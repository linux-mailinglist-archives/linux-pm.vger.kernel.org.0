Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 55BF21DB30A
	for <lists+linux-pm@lfdr.de>; Wed, 20 May 2020 14:20:36 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726439AbgETMUf (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Wed, 20 May 2020 08:20:35 -0400
Received: from lelv0142.ext.ti.com ([198.47.23.249]:44090 "EHLO
        lelv0142.ext.ti.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726224AbgETMUf (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Wed, 20 May 2020 08:20:35 -0400
Received: from fllv0034.itg.ti.com ([10.64.40.246])
        by lelv0142.ext.ti.com (8.15.2/8.15.2) with ESMTP id 04KCKXtV061137;
        Wed, 20 May 2020 07:20:33 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
        s=ti-com-17Q1; t=1589977233;
        bh=/vs8Gq9YQ5Dc/ZEYvAlM2ob1iJ0palS32T3aRszrMWU=;
        h=From:To:CC:Subject:Date;
        b=Wn27GW7iT2gSXI+t7YUwim8oXLJqxvJZ3MzZbHLclpvyCnE+CbwnvavZLdEZ4TS4l
         JKCQSSN3GQwepPWPcpYV/wLfezkoaCuAahm8xWUhri8nk0SdbdPkEIOpFD1W1u3dt9
         sNJAlKHlTPQvnd438qpgyPoClzEMlBSx8MCgUZco=
Received: from DLEE115.ent.ti.com (dlee115.ent.ti.com [157.170.170.26])
        by fllv0034.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 04KCKXgU069601
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
        Wed, 20 May 2020 07:20:33 -0500
Received: from DLEE109.ent.ti.com (157.170.170.41) by DLEE115.ent.ti.com
 (157.170.170.26) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.1979.3; Wed, 20
 May 2020 07:20:32 -0500
Received: from fllv0039.itg.ti.com (10.64.41.19) by DLEE109.ent.ti.com
 (157.170.170.41) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.1979.3 via
 Frontend Transport; Wed, 20 May 2020 07:20:32 -0500
Received: from localhost (ileax41-snat.itg.ti.com [10.172.224.153])
        by fllv0039.itg.ti.com (8.15.2/8.15.2) with ESMTP id 04KCKWtd112464;
        Wed, 20 May 2020 07:20:32 -0500
From:   Dan Murphy <dmurphy@ti.com>
To:     <sre@kernel.org>
CC:     <sspatil@android.com>, <dmurphy@ti.com>,
        <linux-pm@vger.kernel.org>, <robh@kernel.org>,
        <linux-kernel@vger.kernel.org>, <devicetree@vger.kernel.org>
Subject: [PATCH v8 0/3] Add JEITA properties and introduce the bq2515x charger
Date:   Wed, 20 May 2020 07:20:24 -0500
Message-ID: <20200520122027.31320-1-dmurphy@ti.com>
X-Mailer: git-send-email 2.26.2
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

Dan Murphy (1):
  power_supply: Add additional health properties to the header

Ricardo Rivera-Matos (2):
  Add the bindings for the bq25150 and bq25155 500mA charging ICs from
    Texas Instruments.
  power: supply: bq25150 introduce the bq25150

 Documentation/ABI/testing/sysfs-class-power   |    2 +-
 .../bindings/power/supply/bq2515x.yaml        |  106 ++
 drivers/power/supply/Kconfig                  |   13 +
 drivers/power/supply/Makefile                 |    1 +
 drivers/power/supply/bq2515x_charger.c        | 1159 +++++++++++++++++
 drivers/power/supply/power_supply_sysfs.c     |    2 +-
 include/linux/power_supply.h                  |    3 +
 7 files changed, 1284 insertions(+), 2 deletions(-)
 create mode 100644 Documentation/devicetree/bindings/power/supply/bq2515x.yaml
 create mode 100644 drivers/power/supply/bq2515x_charger.c

-- 
2.26.2

