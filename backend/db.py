from flask_sqlalchemy import SQLAlchemy

db = SQLAlchemy()

association_table = db.Table('association', db.Model.metadata,
    db.Column('club_id', db.Integer, db.ForeignKey('club.id')),
    db.Column('category_id', db.Integer, db.ForeignKey('category.id'))
)

class Club(db.Model):
    __tablename__ = 'club'
    id = db.Column(db.Integer, primary_key=True)
    name = db.Column(db.String, nullable=False)
    description = db.Column(db.String, nullable=False)
    categories = db.relationship('Category', secondary=association_table, back_populates='clubs')

    def __init__(self, **kwargs):
        self.name = kwargs.get('name', '')
        self.description = kwargs.get('description', '')

    def serialize(self):
        return {
            'id': self.id,
            'name': self.name,
            'description': self.description,
            'categories': [c.serialize() for c in self.categories]
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
            'clubs': [cl.serialize() for cl in self.categories]
        }
