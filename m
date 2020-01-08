Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 789D6134D28
	for <lists+linux-pm@lfdr.de>; Wed,  8 Jan 2020 21:26:10 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726617AbgAHU0J (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Wed, 8 Jan 2020 15:26:09 -0500
Received: from fllv0015.ext.ti.com ([198.47.19.141]:38898 "EHLO
        fllv0015.ext.ti.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726149AbgAHU0J (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Wed, 8 Jan 2020 15:26:09 -0500
Received: from lelv0266.itg.ti.com ([10.180.67.225])
        by fllv0015.ext.ti.com (8.15.2/8.15.2) with ESMTP id 008KQ5UH048585;
        Wed, 8 Jan 2020 14:26:05 -0600
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
        s=ti-com-17Q1; t=1578515165;
        bh=K3zCJq0s1KUf2adHFNH9bIqtZS4ohTJdousXJK/IAkY=;
        h=From:To:CC:Subject:Date;
        b=YdzexfcCSyJXjAuE1TxWzvSVD/IowPIamY/kuAozM+WCuI5G9ttDLwR97RLY9puuc
         jZwAiP7plrpebi/tYdAmhKqut7mZCuDa8XO2A5N8QQ2ZdYM0XoVpP8VeRfOKpe8AbR
         bUbk+sUi0LA6O+kXkFqXmrY4A5YuNaN5ri74RJJQ=
Received: from DFLE114.ent.ti.com (dfle114.ent.ti.com [10.64.6.35])
        by lelv0266.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 008KQ5Vn036025
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
        Wed, 8 Jan 2020 14:26:05 -0600
Received: from DFLE109.ent.ti.com (10.64.6.30) by DFLE114.ent.ti.com
 (10.64.6.35) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.1847.3; Wed, 8 Jan
 2020 14:26:05 -0600
Received: from fllv0039.itg.ti.com (10.64.41.19) by DFLE109.ent.ti.com
 (10.64.6.30) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.1847.3 via
 Frontend Transport; Wed, 8 Jan 2020 14:26:05 -0600
Received: from localhost (ileax41-snat.itg.ti.com [10.172.224.153])
        by fllv0039.itg.ti.com (8.15.2/8.15.2) with ESMTP id 008KQ4rd024896;
        Wed, 8 Jan 2020 14:26:04 -0600
From:   Dan Murphy <dmurphy@ti.com>
To:     <sebastian.reichel@collabora.com>, <linux-pm@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>
CC:     Dan Murphy <dmurphy@ti.com>
Subject: [PATCH v3 0/4] BQ25150/155 Charger
Date:   Wed, 8 Jan 2020 14:23:10 -0600
Message-ID: <20200108202314.11791-1-dmurphy@ti.com>
X-Mailer: git-send-email 2.23.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-EXCLAIMER-MD-CONFIG: e1e8a2fd-e40a-4ac6-ac9b-f7e9cc9ee180
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

Hello

I am introducing the TI BQ25150/155 Charge driver.
The driver also supports the JEITA spec for Thermal battery management. This
support for Hot, Warm and Cool are being added to the power supply class.

Datasheets for these devices can be found at:
http://www.ti.com/lit/ds/symlink/bq25150.pdf
http://www.ti.com/lit/ds/symlink/bq25155.pdf

Dan Murphy (4):
  power: supply: core: Update sysfs-class-power ABI document
  power_supply: Add additional health properties to the header
  dt-bindings: power: Add the bq2515x family dt bindings
  power: supply: bq2515x: Introduce the bq2515x family

 Documentation/ABI/testing/sysfs-class-power   |   3 +-
 .../bindings/power/supply/bq2515x.yaml        |  85 ++
 drivers/power/supply/Kconfig                  |   8 +
 drivers/power/supply/Makefile                 |   1 +
 drivers/power/supply/bq2515x_charger.c        | 739 ++++++++++++++++++
 drivers/power/supply/power_supply_sysfs.c     |   2 +-
 include/linux/power_supply.h                  |   3 +
 7 files changed, 839 insertions(+), 2 deletions(-)
 create mode 100644 Documentation/devicetree/bindings/power/supply/bq2515x.yaml
 create mode 100644 drivers/power/supply/bq2515x_charger.c

-- 
2.23.0

