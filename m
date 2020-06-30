Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6F80F20FF8D
	for <lists+linux-pm@lfdr.de>; Tue, 30 Jun 2020 23:55:01 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726417AbgF3Vy7 (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Tue, 30 Jun 2020 17:54:59 -0400
Received: from lelv0142.ext.ti.com ([198.47.23.249]:49430 "EHLO
        lelv0142.ext.ti.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726363AbgF3Vy6 (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Tue, 30 Jun 2020 17:54:58 -0400
Received: from fllv0035.itg.ti.com ([10.64.41.0])
        by lelv0142.ext.ti.com (8.15.2/8.15.2) with ESMTP id 05ULstDJ045398;
        Tue, 30 Jun 2020 16:54:55 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
        s=ti-com-17Q1; t=1593554095;
        bh=uEJgcb4tcrP5fgkrX6EiOUahHBi41yHxOfg797i9G7Y=;
        h=From:To:CC:Subject:Date;
        b=luJLCjuo3qyLzaTYTDGeMj8qnvTA/p8dChi5GC/qx6xjHk793ZR6fw1aq8vl/LbtH
         6/53pvEVo5jHDk/gxP44InzITsFkaeuQDMNhxPZf3frWqrsh5JNwzAjY8EBbJyDVvO
         mea5vS7KyGYvkJPGp/uMFM67s7x/iGWYZkK2+Lm4=
Received: from DLEE115.ent.ti.com (dlee115.ent.ti.com [157.170.170.26])
        by fllv0035.itg.ti.com (8.15.2/8.15.2) with ESMTP id 05ULstac018843;
        Tue, 30 Jun 2020 16:54:55 -0500
Received: from DLEE102.ent.ti.com (157.170.170.32) by DLEE115.ent.ti.com
 (157.170.170.26) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.1979.3; Tue, 30
 Jun 2020 16:54:55 -0500
Received: from lelv0326.itg.ti.com (10.180.67.84) by DLEE102.ent.ti.com
 (157.170.170.32) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.1979.3 via
 Frontend Transport; Tue, 30 Jun 2020 16:54:55 -0500
Received: from localhost (ileax41-snat.itg.ti.com [10.172.224.153])
        by lelv0326.itg.ti.com (8.15.2/8.15.2) with ESMTP id 05ULstKj046698;
        Tue, 30 Jun 2020 16:54:55 -0500
From:   Ricardo Rivera-Matos <r-rivera-matos@ti.com>
To:     <sre@kernel.org>, <pali@kernel.org>, <robh@kernel.org>
CC:     <afd@ti.com>, <r-rivera-matos@ti.com>, <dmurphy@ti.com>,
        <linux-pm@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <devicetree@vger.kernel.org>, <sspatil@android.com>
Subject: [PATCH v14 0/4] Add JEITA properties and introduce the bq2515x charger
Date:   Tue, 30 Jun 2020 16:54:22 -0500
Message-ID: <20200630215426.26450-1-r-rivera-matos@ti.com>
X-Mailer: git-send-email 2.27.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-EXCLAIMER-MD-CONFIG: e1e8a2fd-e40a-4ac6-ac9b-f7e9cc9ee180
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

Hello,

This patchset adds additional health properties to the power_supply header.
These additional properties are taken from the JEITA specification. This
patchset also introduces the bq2515x family of charging ICs.

Dan Murphy (2):
  power_supply: Add additional health properties to the header
  dt-bindings: power: Convert battery.txt to battery.yaml

Ricardo Rivera-Matos (2):
  dt-bindings: power: Add the bindings for the bq2515x family of
    chargers.
  power: supply: bq25150 introduce the bq25150

 Documentation/ABI/testing/sysfs-class-power   |    3 +-
 .../bindings/power/supply/battery.txt         |   86 +-
 .../bindings/power/supply/battery.yaml        |  157 +++
 .../bindings/power/supply/bq2515x.yaml        |   93 ++
 drivers/power/supply/Kconfig                  |   13 +
 drivers/power/supply/Makefile                 |    1 +
 drivers/power/supply/bq2515x_charger.c        | 1158 +++++++++++++++++
 drivers/power/supply/power_supply_sysfs.c     |    3 +
 include/linux/power_supply.h                  |    3 +
 9 files changed, 1431 insertions(+), 86 deletions(-)
 create mode 100644 Documentation/devicetree/bindings/power/supply/battery.yaml
 create mode 100644 Documentation/devicetree/bindings/power/supply/bq2515x.yaml
 create mode 100644 drivers/power/supply/bq2515x_charger.c

-- 
2.27.0

