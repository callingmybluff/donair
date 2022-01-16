import {
  DataTypes,
  Model,
  Optional,
} from 'sequelize'

import DB from './db'

interface BillAtt {
  id: number
  donationID: number
  app: string
  percentage: number
  amount: number
}

interface BillCreationAtt extends Optional<BillAtt, 'id'> {}

class Bill extends Model<BillAtt, BillCreationAtt> implements BillAtt {
  public id!: number
  public donationID!: number
  public app!: string
  public percentage!: number
  public amount!: number
}

Bill.init(
  {
    id: {
      type: DataTypes.INTEGER.UNSIGNED,
      autoIncrement: true,
      primaryKey: true,
      allowNull: false,
    },
    donationID: {
      type: DataTypes.INTEGER.UNSIGNED,
      allowNull: false,
    },
    app: {
      type: DataTypes.STRING,
      allowNull: false,
    },
    percentage: {
      type: DataTypes.DECIMAL(4, 2),
      allowNull: false,
    },
    amount: {
      type: DataTypes.DECIMAL(12, 4),
      allowNull: false,
    },
  },
  {
    sequelize: DB.getConnection(),
    tableName: 'bill',
  },
)

export default Bill