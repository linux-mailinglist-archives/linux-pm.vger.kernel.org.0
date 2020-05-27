Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D18111E51A9
	for <lists+linux-pm@lfdr.de>; Thu, 28 May 2020 01:18:54 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725850AbgE0XSx (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Wed, 27 May 2020 19:18:53 -0400
Received: from fllv0016.ext.ti.com ([198.47.19.142]:41104 "EHLO
        fllv0016.ext.ti.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725267AbgE0XSw (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Wed, 27 May 2020 19:18:52 -0400
Received: from lelv0266.itg.ti.com ([10.180.67.225])
        by fllv0016.ext.ti.com (8.15.2/8.15.2) with ESMTP id 04RNIoeK082840;
        Wed, 27 May 2020 18:18:50 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
        s=ti-com-17Q1; t=1590621530;
        bh=lNhA+E2fd/RxBR6mEdxlKPJRrv3x5UmqnhFIGQavOu4=;
        h=From:To:CC:Subject:Date;
        b=Y0NJAacYGFh9kJP8IThabkaeO+jmIxx5m3ZUhjip4Mc40H8duj0XeZlzrekx62o00
         8r9b5MYE4V+estYS4vtvpEoFoaqPGAd/jzErddPdWWnsS2deIj8pqrdkjEtiH1xlAH
         Hf9giWwP6+Nm9EoRWd5aXGdrviMq/Uf9K8CifXyo=
Received: from DLEE113.ent.ti.com (dlee113.ent.ti.com [157.170.170.24])
        by lelv0266.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 04RNIok3088667
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
        Wed, 27 May 2020 18:18:50 -0500
Received: from DLEE108.ent.ti.com (157.170.170.38) by DLEE113.ent.ti.com
 (157.170.170.24) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.1979.3; Wed, 27
 May 2020 18:18:50 -0500
Received: from fllv0039.itg.ti.com (10.64.41.19) by DLEE108.ent.ti.com
 (157.170.170.38) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.1979.3 via
 Frontend Transport; Wed, 27 May 2020 18:18:50 -0500
Received: from localhost (ileax41-snat.itg.ti.com [10.172.224.153])
        by fllv0039.itg.ti.com (8.15.2/8.15.2) with ESMTP id 04RNIoxW052642;
        Wed, 27 May 2020 18:18:50 -0500
From:   Ricardo Rivera-Matos <r-rivera-matos@ti.com>
To:     <sre@kernel.org>, <pali@kernel.org>, <robh@kernel.org>
CC:     <afd@ti.com>, <r-rivera-matos@ti.com>, <dmurphy@ti.com>,
        <linux-pm@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <devicetree@vger.kernel.org>, <sspatil@android.com>
Subject: [PATCH v10 0/4] Add JEITA properties and introduce the bq2515x charger
Date:   Wed, 27 May 2020 18:17:39 -0500
Message-ID: <20200527231743.18066-1-r-rivera-matos@ti.com>
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

Dan Murphy (2):
  power_supply: Add additional health properties to the header
  dt-bindings: power: Convert battery.txt to battery.yaml

Ricardo Rivera-Matos (2):
  dt-bindings: power: Add the bindings for the bq2515x family of
    chargers.
  power: supply: bq25150 introduce the bq25150

 Documentation/ABI/testing/sysfs-class-power   |    2 +-
 .../bindings/power/supply/battery.txt         |   82 +-
 .../bindings/power/supply/battery.yaml        |  143 ++
 .../bindings/power/supply/bq2515x.yaml        |   91 ++
 drivers/power/supply/Kconfig                  |   13 +
 drivers/power/supply/Makefile                 |    1 +
 drivers/power/supply/bq2515x_charger.c        | 1159 +++++++++++++++++
 drivers/power/supply/power_supply_sysfs.c     |    2 +-
 include/linux/power_supply.h                  |    3 +
 9 files changed, 1413 insertions(+), 83 deletions(-)
 create mode 100644 Documentation/devicetree/bindings/power/supply/battery.yaml
 create mode 100644 Documentation/devicetree/bindings/power/supply/bq2515x.yaml
 create mode 100644 drivers/power/supply/bq2515x_charger.c

-- 
2.26.2

