/*
 * purchaseitemwidget.h
 * Copyright 2017 - ~, Apin <apin.klas@gmail.com>
 *
 * This file is part of Turbin.
 *
 * This program is free software; you can redistribute it and/or modify it
 * under the terms of the GNU General Public License as published by the Free
 * Software Foundation; either version 2 of the License, or (at your option)
 * any later version.
 *
 * This program is distributed in the hope that it will be useful, but WITHOUT
 * ANY WARRANTY; without even the implied warranty of MERCHANTABILITY or
 * FITNESS FOR A PARTICULAR PURPOSE.  See the GNU General Public License for
 * more details.
 *
 * You should have received a copy of the GNU General Public License along with
 * this program. If not, see <http://www.gnu.org/licenses/>.
 */
#ifndef PURCHASEITEMWIDGET_H
#define PURCHASEITEMWIDGET_H

#include "messagehandler.h"
#include <QWidget>

namespace Ui {
class NormalWidget;
}

namespace LibGUI {

class TableWidget;
class PurchaseAddItemDialog;

class PurchaseItemWidget : public QWidget, public LibG::MessageHandler
{
    Q_OBJECT

public:
    PurchaseItemWidget(int id, const QString &number, LibG::MessageBus *bus, QWidget *parent = 0);
    ~PurchaseItemWidget();
    inline int getId() { return mId; }

private:
    Ui::NormalWidget *ui;
    int mId;
    TableWidget *mTableWidget;
    PurchaseAddItemDialog *mAddDialog;

protected:
    void messageReceived(LibG::Message *msg) override;

private slots:
    void addClicked();
    void updateClicked(const QModelIndex &index);
    void delClicked(const QModelIndex &index);
};

}
#endif // PURCHASEITEMWIDGET_H