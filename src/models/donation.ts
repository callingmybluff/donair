import {
  Model,
  Optional,
  Association,
  DataTypes,
} from 'sequelize'

import Bill from './bill'
import DB from './db'

interface DonationAtt {
  id: number
  amount: number
}

interface DonationCreationAtt extends Optional<DonationAtt, 'id'> {}

class Donation extends Model<DonationAtt, DonationCreationAtt> implements DonationAtt {
  public id!: number
  public amount!: number

  public readonly createdAt!: Date
  public readonly updatedAt!: Date

  public readonly bills?: Bill[]

  public static associations: {
    bills: Association<Donation, Bill>,
  }
}

Donation.hasMany(Bill, {
  sourceKey: 'id',
  foreignKey: 'donationID',
  as: 'bills',
})

Donation.init(
  {
    id: {
      type: DataTypes.INTEGER.UNSIGNED,
      autoIncrement: true,
      primaryKey: true,
      allowNull: false,
    },
    amount: {
      type: DataTypes.INTEGER.UNSIGNED,
      allowNull: false,
    }
  },
  {
    sequelize: DB.getConnection(),
    tableName: 'donation',
  }
)

export default Donation