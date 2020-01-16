Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 43BC013EBF5
	for <lists+linux-pm@lfdr.de>; Thu, 16 Jan 2020 18:54:30 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2394454AbgAPRxo (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Thu, 16 Jan 2020 12:53:44 -0500
Received: from lelv0143.ext.ti.com ([198.47.23.248]:42730 "EHLO
        lelv0143.ext.ti.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2394443AbgAPRxo (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Thu, 16 Jan 2020 12:53:44 -0500
Received: from lelv0265.itg.ti.com ([10.180.67.224])
        by lelv0143.ext.ti.com (8.15.2/8.15.2) with ESMTP id 00GHrebX029057;
        Thu, 16 Jan 2020 11:53:40 -0600
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
        s=ti-com-17Q1; t=1579197220;
        bh=t8orkGLdN+VEXtw9A9i1nVzcxXSIJKWT0HvQf4WRsYY=;
        h=From:To:CC:Subject:Date;
        b=N1igzSg8HbQMxuU4mta1clFA76Qk1XUzdinIySGWB+yb/Zux0quMvg80JWiaE9ayb
         /5shhxzvWfPk4XkO+83lET+byiR7cu3XFaNKVueVt4+ay3muvxw+3LaYSUyAYXYKon
         nKdeT6DSnxLA2o8qMd1Nv2e2aL9Se7Dmy4VX2oN8=
Received: from DLEE109.ent.ti.com (dlee109.ent.ti.com [157.170.170.41])
        by lelv0265.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 00GHreNl075932
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
        Thu, 16 Jan 2020 11:53:40 -0600
Received: from DLEE107.ent.ti.com (157.170.170.37) by DLEE109.ent.ti.com
 (157.170.170.41) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.1847.3; Thu, 16
 Jan 2020 11:53:40 -0600
Received: from fllv0039.itg.ti.com (10.64.41.19) by DLEE107.ent.ti.com
 (157.170.170.37) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.1847.3 via
 Frontend Transport; Thu, 16 Jan 2020 11:53:40 -0600
Received: from localhost (ileax41-snat.itg.ti.com [10.172.224.153])
        by fllv0039.itg.ti.com (8.15.2/8.15.2) with ESMTP id 00GHresi040565;
        Thu, 16 Jan 2020 11:53:40 -0600
From:   Dan Murphy <dmurphy@ti.com>
To:     <sebastian.reichel@collabora.com>
CC:     <linux-pm@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        Dan Murphy <dmurphy@ti.com>
Subject: [PATCH v4 0/4] BQ25150/155 Driver introduction
Date:   Thu, 16 Jan 2020 11:50:35 -0600
Message-ID: <20200116175039.1317-1-dmurphy@ti.com>
X-Mailer: git-send-email 2.25.0
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

Dan

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
2.25.0

