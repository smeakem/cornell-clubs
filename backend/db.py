from flask_sqlalchemy import SQLAlchemy

db = SQLAlchemy()

association_table = db.Table('association', db.Model.metadata,
    db.Column('club_id', db.Integer, db.ForeignKey('club.id')),
    db.Column('category_id', db.Integer, db.ForeignKey('category.id'))
)

association_table_m = db.Table('association_m', db.Model.metadata,
    db.Column('club_id', db.Integer, db.ForeignKey('club.id')),
    db.Column('member_id', db.Integer, db.ForeignKey('member.id'))
)


class Club(db.Model):
    __tablename__ = 'club'
    id = db.Column(db.Integer, primary_key=True)
    name = db.Column(db.String, nullable=False)
    description = db.Column(db.String, nullable=False)
    favorite = db.Column(db.Boolean, nullable = False)
    categories = db.relationship('Category', secondary=association_table, back_populates='clubs')
    members = db.relationship('Member', secondary=association_table_m, back_populates='clubs')


    def __init__(self, **kwargs):
        self.name = kwargs.get('name', '')
        self.description = kwargs.get('description', '')
        self.favorite = kwargs.get('favorite', False)


    def serialize(self):
        return {
            'id': self.id,
            'name': self.name,
            'description': self.description,
            'favorite': self.favorite,
            'categories': [c.serialize() for c in self.categories],
            'members': [m.serialize() for m in self.members]

        }


class Category(db.Model):
    __tablename__ = 'category'
    id = db.Column(db.Integer, primary_key=True)
    name = db.Column(db.String, nullable=False)
    clubs = db.relationship('Club', secondary=association_table, back_populates='categories')

    def __init__(self, **kwargs):
        self.name = kwargs.get('name', '')

    def serialize(self):
        return {
            'id': self.id,
            'name': self.name,
            #'clubs': [cl.serialize() for cl in self.clubs]
        }

class Member(db.Model):
    __tablename__ = 'member'
    id = db.Column(db.Integer, primary_key=True)
    name = db.Column(db.String, nullable=False)
    clubs = db.relationship('Club', secondary=association_table_m, back_populates='members')

    def __init__(self):
        return {
            'id': self.id,
            'name': self.name
        }
