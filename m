Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 038EA30B52A
	for <lists+linux-pm@lfdr.de>; Tue,  2 Feb 2021 03:20:27 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229543AbhBBCT2 (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Mon, 1 Feb 2021 21:19:28 -0500
Received: from fllv0015.ext.ti.com ([198.47.19.141]:43078 "EHLO
        fllv0015.ext.ti.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229527AbhBBCTZ (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Mon, 1 Feb 2021 21:19:25 -0500
Received: from lelv0266.itg.ti.com ([10.180.67.225])
        by fllv0015.ext.ti.com (8.15.2/8.15.2) with ESMTP id 1122Hm5M048967;
        Mon, 1 Feb 2021 20:17:48 -0600
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
        s=ti-com-17Q1; t=1612232268;
        bh=HpAcjjyMX+aBZiXEvhn3ye8U6EEBAbEnKPxzDdE0GFc=;
        h=From:To:CC:Subject:Date;
        b=PZYHjC/q0U/MGjL9e1iv+ZbnEKqBbcieTghMvAWupLufuO5oLzwmEkFNLBZKgBNE6
         apjc7cskdP6ActFqZesODrYKJbvfyU7yzh7Xjfua6pTCmLjbHrda0NWtAnZ/zs5QIk
         hBruaoOFxTZGgyJEySz8lriqg6MFeFYRPN+XqsOc=
Received: from DFLE114.ent.ti.com (dfle114.ent.ti.com [10.64.6.35])
        by lelv0266.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 1122HmAU086782
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
        Mon, 1 Feb 2021 20:17:48 -0600
Received: from DFLE105.ent.ti.com (10.64.6.26) by DFLE114.ent.ti.com
 (10.64.6.35) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.1979.3; Mon, 1 Feb
 2021 20:17:48 -0600
Received: from lelv0327.itg.ti.com (10.180.67.183) by DFLE105.ent.ti.com
 (10.64.6.26) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.1979.3 via
 Frontend Transport; Mon, 1 Feb 2021 20:17:48 -0600
Received: from localhost (ileax41-snat.itg.ti.com [10.172.224.153])
        by lelv0327.itg.ti.com (8.15.2/8.15.2) with ESMTP id 1122HlgW043895;
        Mon, 1 Feb 2021 20:17:48 -0600
From:   Ricardo Rivera-Matos <r-rivera-matos@ti.com>
To:     <sre@kernel.org>, <linux-pm@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>
CC:     <dmurphy@ti.com>, Ricardo Rivera-Matos <r-rivera-matos@ti.com>
Subject: [PATCH v5 0/2] Introduce the BQ25790 charger driver
Date:   Mon, 1 Feb 2021 20:17:45 -0600
Message-ID: <20210202021747.717-1-r-rivera-matos@ti.com>
X-Mailer: git-send-email 2.30.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-EXCLAIMER-MD-CONFIG: e1e8a2fd-e40a-4ac6-ac9b-f7e9cc9ee180
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

Hello,

This patchset introduces the BQ25790 integrated buck-boost charging IC.

Dan Murphy (2):
  dt-bindings: power: Add the bq25790 dt bindings
  power: supply: bq25790: Introduce the BQ25790 charger driver

 .../bindings/power/supply/bq25790.yaml        |   95 ++
 drivers/power/supply/Kconfig                  |    8 +
 drivers/power/supply/Makefile                 |    1 +
 drivers/power/supply/bq25790_charger.c        | 1100 +++++++++++++++++
 drivers/power/supply/bq25790_charger.h        |  148 +++
 5 files changed, 1352 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/power/supply/bq25790.yaml
 create mode 100644 drivers/power/supply/bq25790_charger.c
 create mode 100644 drivers/power/supply/bq25790_charger.h

-- 
2.30.0

