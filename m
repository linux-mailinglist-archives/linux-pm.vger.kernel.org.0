Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id ADD0D1C1C73
	for <lists+linux-pm@lfdr.de>; Fri,  1 May 2020 20:00:17 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730055AbgEASAA (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Fri, 1 May 2020 14:00:00 -0400
Received: from fllv0015.ext.ti.com ([198.47.19.141]:33342 "EHLO
        fllv0015.ext.ti.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729410AbgEASAA (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Fri, 1 May 2020 14:00:00 -0400
Received: from fllv0034.itg.ti.com ([10.64.40.246])
        by fllv0015.ext.ti.com (8.15.2/8.15.2) with ESMTP id 041Hxwhe042549;
        Fri, 1 May 2020 12:59:59 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
        s=ti-com-17Q1; t=1588355999;
        bh=qJjDwd6CKyDhY83FeTF+lldULXjVHA5iOtjwclkfDmo=;
        h=From:To:CC:Subject:Date;
        b=OHM2J3ifevHs+kTtOePXdkyHa2AqPith3lo9k3s6xfThhgzSgsPmXFG2mJI37mO4D
         GPxVw/YA8q8iHAqgemBe4abExtFoas6tltsiyJFhsCKc298aPUZJlYG7++Fi/pTB0e
         UVx9JP0zbP/uVbQdUfKZoJMxgri206ab90ZFX2LE=
Received: from DFLE115.ent.ti.com (dfle115.ent.ti.com [10.64.6.36])
        by fllv0034.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 041HxwFv077992
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
        Fri, 1 May 2020 12:59:58 -0500
Received: from DFLE109.ent.ti.com (10.64.6.30) by DFLE115.ent.ti.com
 (10.64.6.36) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.1979.3; Fri, 1 May
 2020 12:59:58 -0500
Received: from fllv0039.itg.ti.com (10.64.41.19) by DFLE109.ent.ti.com
 (10.64.6.30) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.1979.3 via
 Frontend Transport; Fri, 1 May 2020 12:59:58 -0500
Received: from localhost (ileax41-snat.itg.ti.com [10.172.224.153])
        by fllv0039.itg.ti.com (8.15.2/8.15.2) with ESMTP id 041Hxw4W044913;
        Fri, 1 May 2020 12:59:58 -0500
From:   Dan Murphy <dmurphy@ti.com>
To:     <sre@kernel.org>
CC:     <linux-pm@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <devicetree@vger.kernel.org>, Dan Murphy <dmurphy@ti.com>
Subject: [PATCH v5 0/3] BQ25150/155 Batter charger
Date:   Fri, 1 May 2020 12:51:15 -0500
Message-ID: <20200501175118.26226-1-dmurphy@ti.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-EXCLAIMER-MD-CONFIG: e1e8a2fd-e40a-4ac6-ac9b-f7e9cc9ee180
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

Hello,

Resending for Ricardo

This v5 series picks up on the development that Dan Murphy <dmurphy@ti.com> 
began with the power_supply framework and bq2515x_charger driver.

This series incorporates the changes suggested by
Sebastien Reichel<sre@kernel.org> in v4.

Datasheets for these devices can be found at:
http://www.ti.com/lit/ds/symlink/bq25150.pdf
http://www.ti.com/lit/ds/symlink/bq25155.pdf 

Thanks, Ricardo

Dan Murphy (1):
  power_supply: Add additional health properties to the header

Ricardo Rivera-Matos (2):
  Add the bindings for the bq25150 and bq25155 500mA charging ICs from
    Texas Instruments.
  power: supply: bq25150 introduce the bq25150

 Documentation/ABI/testing/sysfs-class-power   |    2 +-
 .../bindings/power/supply/bq2515x.yaml        |   99 ++
 drivers/power/supply/Kconfig                  |    8 +
 drivers/power/supply/Makefile                 |    1 +
 drivers/power/supply/bq2515x_charger.c        | 1170 +++++++++++++++++
 drivers/power/supply/power_supply_sysfs.c     |    2 +-
 include/linux/power_supply.h                  |    3 +
 7 files changed, 1283 insertions(+), 2 deletions(-)
 create mode 100644 Documentation/devicetree/bindings/power/supply/bq2515x.yaml
 create mode 100644 drivers/power/supply/bq2515x_charger.c

-- 
2.25.1

