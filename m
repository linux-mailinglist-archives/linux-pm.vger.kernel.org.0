Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A3D9824750C
	for <lists+linux-pm@lfdr.de>; Mon, 17 Aug 2020 21:18:55 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2392156AbgHQTS1 (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Mon, 17 Aug 2020 15:18:27 -0400
Received: from lelv0143.ext.ti.com ([198.47.23.248]:52256 "EHLO
        lelv0143.ext.ti.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2392131AbgHQTS0 (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Mon, 17 Aug 2020 15:18:26 -0400
Received: from lelv0266.itg.ti.com ([10.180.67.225])
        by lelv0143.ext.ti.com (8.15.2/8.15.2) with ESMTP id 07HJIEDF041828;
        Mon, 17 Aug 2020 14:18:14 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
        s=ti-com-17Q1; t=1597691894;
        bh=80uJ5kKs7K6ojF+rJ/lSvYTiOi3jFw4mNWv2W/UGfYA=;
        h=From:To:CC:Subject:Date;
        b=CXQWgNkTw+S21ozwtWoHygnVTOEVH1sVSDh3VZ+pUp+ftF1BeIUiBIvfJTcNGm1L+
         K0N98YWUbw+7guB7liQbPtpa0ZATzm3ue2otVTjdHarb62aeSYMX6FFMYwrKBfMxJT
         9FPT0BoWeuB/pak1zL0kTx5jnxKPfHsACTcMgvaA=
Received: from DLEE113.ent.ti.com (dlee113.ent.ti.com [157.170.170.24])
        by lelv0266.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 07HJIEM0102013
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
        Mon, 17 Aug 2020 14:18:14 -0500
Received: from DLEE113.ent.ti.com (157.170.170.24) by DLEE113.ent.ti.com
 (157.170.170.24) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.1979.3; Mon, 17
 Aug 2020 14:18:13 -0500
Received: from lelv0326.itg.ti.com (10.180.67.84) by DLEE113.ent.ti.com
 (157.170.170.24) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.1979.3 via
 Frontend Transport; Mon, 17 Aug 2020 14:18:13 -0500
Received: from localhost (ileax41-snat.itg.ti.com [10.172.224.153])
        by lelv0326.itg.ti.com (8.15.2/8.15.2) with ESMTP id 07HJIDeW094892;
        Mon, 17 Aug 2020 14:18:13 -0500
From:   Ricardo Rivera-Matos <r-rivera-matos@ti.com>
To:     <sre@kernel.org>, <robh+dt@kernel.org>, <linux-pm@vger.kernel.org>,
        <devicetree@vger.kernel.org>, <linux-kernel@vger.kernel.org>
CC:     <dmurphy@ti.com>, Ricardo Rivera-Matos <r-rivera-matos@ti.com>
Subject: [PATCH v1 0/2] Introduce the BQ256XX family of chargers
Date:   Mon, 17 Aug 2020 14:17:21 -0500
Message-ID: <20200817191723.22416-1-r-rivera-matos@ti.com>
X-Mailer: git-send-email 2.28.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-EXCLAIMER-MD-CONFIG: e1e8a2fd-e40a-4ac6-ac9b-f7e9cc9ee180
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

Hello,

This patchset introduces the bq256xx family of charging ICs. The bq256xx ICs
are highly integrated, buck, switching chargers intended for use in 
smartphones, tablets, and portable electronics.

Ricardo Rivera-Matos (2):
  dt-bindings: power: Add the bq256xx dt bindings
  power: supply: bq256xx: Introduce the BQ256XX charger driver

 .../bindings/power/supply/bq256xx.yaml        |   99 +
 drivers/power/supply/Kconfig                  |   11 +
 drivers/power/supply/Makefile                 |    1 +
 drivers/power/supply/bq256xx_charger.c        | 1769 +++++++++++++++++
 4 files changed, 1880 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/power/supply/bq256xx.yaml
 create mode 100644 drivers/power/supply/bq256xx_charger.c

-- 
2.28.0

