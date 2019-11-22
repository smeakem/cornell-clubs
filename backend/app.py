import json
from db import db, Club, Category, Member
from flask import Flask, request

db_filename = "todo.db"
app = Flask(__name__)

app.config['SQLALCHEMY_DATABASE_URI'] = 'sqlite:///%s' % db_filename
app.config['SQLALCHEMY_TRACK_MODIFICATIONS'] = False
app.config['SQLALCHEMY_ECHO'] = True

db.init_app(app)
with app.app_context():
    db.create_all()


@app.route('/')
@app.route('/api/clubs/')
def get_clubs():
    clubs = Club.query.all()
    res = {'success': True, 'data': [cl.serialize() for cl in clubs]}
    return json.dumps(res), 200


@app.route('/api/clubs/', methods = ['POST'])
def create_club():
    post_body = json.loads(request.data)
    name = post_body.get('name', '')
    description = post_body.get('description', '')
    favorite = post_body.get('favorite', False)
    club = Club(
        name = name,
        description = description,
        favorite = favorite
    )
    db.session.add(club)
    db.session.commit()
    return json.dumps({'success': True, 'data': club.serialize()}), 200

@app.route('/api/club/<int:club_id>/')
def get_club(club_id):
    club = Club.query.filter_by(id=club_id).first()
    if not club:
        return json.dumps({'success': False, 'error': 'Club not found'}), 404
    return json.dumps({'success': True, 'data': club.serialize()}), 200

@app.route('/api/club/<int:club_id>/', methods=['DELETE'])
def delete_club(club_id):
    club = Club.query.filter_by(id=club_id).first()
    if not club:
        return json.dumps({'success': False, 'error': 'Club not found'}), 404
    db.session.delete(club)
    db.session.commit()
    return json.dumps({'success': True, 'data': club.serialize()}), 200

@app.route('/api/club/<int:club_id>/category/', methods = ['POST'])
def assign_category(club_id):
    club = Club.query.filter_by(id=club_id).first()
    if not club:
        return json.dumps({'success': False, 'error': 'Club not found'}), 404
    post_body= json.loads(request.data)
    category = Category.query.filter_by(name=post_body.get('name')).first()
    if not category:
        category = Category(
            name=post_body.get('name', '')
        )
    club.categories.append(category)
    db.session.add(category)
    db.session.commit()
    return json.dumps({'success': True, 'data': category.serialize()}), 200





if __name__ == '__main__':
    app.run(host='0.0.0.0', port=5000, debug=True)
