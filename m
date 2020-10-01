Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 782A3280982
	for <lists+linux-pm@lfdr.de>; Thu,  1 Oct 2020 23:40:42 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1733002AbgJAVkk (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Thu, 1 Oct 2020 17:40:40 -0400
Received: from fllv0015.ext.ti.com ([198.47.19.141]:38062 "EHLO
        fllv0015.ext.ti.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726980AbgJAVkk (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Thu, 1 Oct 2020 17:40:40 -0400
Received: from fllv0034.itg.ti.com ([10.64.40.246])
        by fllv0015.ext.ti.com (8.15.2/8.15.2) with ESMTP id 091LecJN059473;
        Thu, 1 Oct 2020 16:40:38 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
        s=ti-com-17Q1; t=1601588438;
        bh=rLsZsAxIMKVUoTl8IEKHo5ZsJfzyYt4AyGolsKO93dk=;
        h=From:To:CC:Subject:Date;
        b=wPUdbqNBHds1lnai5Ofr7t/XQDsM2FSRLNRL+lw9CO+fatwOBqb/ysK20Rxot/Ss0
         eLWPk4FuaoYggKwzFYXqlOdyXB1z0/oFDD3TxH52hpy0zRK3zKnwmoF2NHt5sGQ/PQ
         GDud+lyzbee2y3ugFFsznjyiJEmU59mcS23NyEB0=
Received: from DFLE108.ent.ti.com (dfle108.ent.ti.com [10.64.6.29])
        by fllv0034.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 091LecL5118287
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
        Thu, 1 Oct 2020 16:40:38 -0500
Received: from DFLE109.ent.ti.com (10.64.6.30) by DFLE108.ent.ti.com
 (10.64.6.29) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.1979.3; Thu, 1 Oct
 2020 16:40:38 -0500
Received: from lelv0326.itg.ti.com (10.180.67.84) by DFLE109.ent.ti.com
 (10.64.6.30) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.1979.3 via
 Frontend Transport; Thu, 1 Oct 2020 16:40:38 -0500
Received: from localhost (ileax41-snat.itg.ti.com [10.172.224.153])
        by lelv0326.itg.ti.com (8.15.2/8.15.2) with ESMTP id 091LectT005858;
        Thu, 1 Oct 2020 16:40:38 -0500
From:   Ricardo Rivera-Matos <r-rivera-matos@ti.com>
To:     <sre@kernel.org>, <robh+dt@kernel.org>, <linux-pm@vger.kernel.org>,
        <devicetree@vger.kernel.org>, <linux-kernel@vger.kernel.org>
CC:     <dmurphy@ti.com>, Ricardo Rivera-Matos <r-rivera-matos@ti.com>
Subject: [PATCH v5 0/2] Introduce the BQ256XX family of chargers
Date:   Thu, 1 Oct 2020 16:40:32 -0500
Message-ID: <20201001214034.5925-1-r-rivera-matos@ti.com>
X-Mailer: git-send-email 2.28.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-EXCLAIMER-MD-CONFIG: e1e8a2fd-e40a-4ac6-ac9b-f7e9cc9ee180
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

Hello,

This patchset introduces the bq256xx family of charging ICs. The bq256xx
ICs are highly integrated, buck, switching chargers intended for use in 
smartphones, tablets, and portable electronics.

Ricardo Rivera-Matos (2):
  dt-bindings: power: Add the bq256xx dt bindings
  power: supply: bq256xx: Introduce the BQ256XX charger driver

 .../bindings/power/supply/bq256xx.yaml        |  110 +
 drivers/power/supply/Kconfig                  |   11 +
 drivers/power/supply/Makefile                 |    1 +
 drivers/power/supply/bq256xx_charger.c        | 1785 +++++++++++++++++
 4 files changed, 1907 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/power/supply/bq256xx.yaml
 create mode 100644 drivers/power/supply/bq256xx_charger.c

-- 
2.28.0

