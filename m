Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5BAA8203FFA
	for <lists+linux-pm@lfdr.de>; Mon, 22 Jun 2020 21:19:08 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728318AbgFVTTG (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Mon, 22 Jun 2020 15:19:06 -0400
Received: from fllv0015.ext.ti.com ([198.47.19.141]:44794 "EHLO
        fllv0015.ext.ti.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728068AbgFVTTF (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Mon, 22 Jun 2020 15:19:05 -0400
Received: from lelv0266.itg.ti.com ([10.180.67.225])
        by fllv0015.ext.ti.com (8.15.2/8.15.2) with ESMTP id 05MJJ3q7030177;
        Mon, 22 Jun 2020 14:19:04 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
        s=ti-com-17Q1; t=1592853544;
        bh=4Uc57vnU9L76B5vi4WPRq81bboaPP34jgfbbQ+MxC3w=;
        h=From:To:CC:Subject:Date;
        b=jEazJJydbIUPSsGXDFDfIJRK3UoMRkk35oUQzNujT5acEcNsX6TNMArSA2lwMiTTO
         zpoVhDSlBLq86GI7EcCT1izoFhaCfHGB5E66dO+gj7xbGZA0vVrRWQmszrz2I2I3bR
         xSrLxuL1OpCLcmN6ellUgr2D/FLFyE74+E+uyaDo=
Received: from DFLE115.ent.ti.com (dfle115.ent.ti.com [10.64.6.36])
        by lelv0266.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 05MJJ3kN042288
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
        Mon, 22 Jun 2020 14:19:03 -0500
Received: from DFLE101.ent.ti.com (10.64.6.22) by DFLE115.ent.ti.com
 (10.64.6.36) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.1979.3; Mon, 22
 Jun 2020 14:19:03 -0500
Received: from lelv0326.itg.ti.com (10.180.67.84) by DFLE101.ent.ti.com
 (10.64.6.22) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.1979.3 via
 Frontend Transport; Mon, 22 Jun 2020 14:19:03 -0500
Received: from localhost (ileax41-snat.itg.ti.com [10.172.224.153])
        by lelv0326.itg.ti.com (8.15.2/8.15.2) with ESMTP id 05MJJ3xi125356;
        Mon, 22 Jun 2020 14:19:03 -0500
From:   Ricardo Rivera-Matos <r-rivera-matos@ti.com>
To:     <sre@kernel.org>, <pali@kernel.org>, <robh@kernel.org>
CC:     <afd@ti.com>, <r-rivera-matos@ti.com>, <dmurphy@ti.com>,
        <linux-pm@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <devicetree@vger.kernel.org>, <sspatil@android.com>
Subject: [PATCH v13 0/4] Add JEITA properties and introduce the bq2515x charger
Date:   Mon, 22 Jun 2020 14:18:33 -0500
Message-ID: <20200622191837.9326-1-r-rivera-matos@ti.com>
X-Mailer: git-send-email 2.27.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-EXCLAIMER-MD-CONFIG: e1e8a2fd-e40a-4ac6-ac9b-f7e9cc9ee180
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

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
 .../bindings/power/supply/battery.txt         |   83 +-
 .../bindings/power/supply/battery.yaml        |  139 ++
 .../bindings/power/supply/bq2515x.yaml        |   93 ++
 drivers/power/supply/Kconfig                  |   13 +
 drivers/power/supply/Makefile                 |    1 +
 drivers/power/supply/bq2515x_charger.c        | 1158 +++++++++++++++++
 drivers/power/supply/power_supply_sysfs.c     |    3 +
 include/linux/power_supply.h                  |    3 +
 9 files changed, 1414 insertions(+), 82 deletions(-)
 create mode 100644 Documentation/devicetree/bindings/power/supply/battery.yaml
 create mode 100644 Documentation/devicetree/bindings/power/supply/bq2515x.yaml
 create mode 100644 drivers/power/supply/bq2515x_charger.c

-- 
2.27.0

