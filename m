Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id DBE19C231B
	for <lists+linux-pm@lfdr.de>; Mon, 30 Sep 2019 16:24:44 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731276AbfI3OYo (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Mon, 30 Sep 2019 10:24:44 -0400
Received: from lelv0142.ext.ti.com ([198.47.23.249]:45330 "EHLO
        lelv0142.ext.ti.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730378AbfI3OYn (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Mon, 30 Sep 2019 10:24:43 -0400
Received: from fllv0034.itg.ti.com ([10.64.40.246])
        by lelv0142.ext.ti.com (8.15.2/8.15.2) with ESMTP id x8UEOgPs064508;
        Mon, 30 Sep 2019 09:24:42 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
        s=ti-com-17Q1; t=1569853482;
        bh=Q++4+W+xo4Pr6ly1SOnOWLFFQ+MsIQZKvmW9IrDJ/9g=;
        h=From:To:CC:Subject:Date;
        b=kMWr25EA0mJP761xMSptJuMIBZFJNXq32J+QSNRtVrlwn3QtOJKXhtFCsndUN0G1x
         hs3XEaetjTYgEZEij7C8DjhM5VmsAELJfhMZ+L+L34wRb9NbbP0LYP2qYvLhy0Cunz
         6Rh5dbf2C5Zg9vgblGRAMIp+pqH9GttIXpUglmYE=
Received: from DLEE108.ent.ti.com (dlee108.ent.ti.com [157.170.170.38])
        by fllv0034.itg.ti.com (8.15.2/8.15.2) with ESMTPS id x8UEOgY2068175
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
        Mon, 30 Sep 2019 09:24:42 -0500
Received: from DLEE109.ent.ti.com (157.170.170.41) by DLEE108.ent.ti.com
 (157.170.170.38) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.1713.5; Mon, 30
 Sep 2019 09:24:32 -0500
Received: from fllv0040.itg.ti.com (10.64.41.20) by DLEE109.ent.ti.com
 (157.170.170.41) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.1713.5 via
 Frontend Transport; Mon, 30 Sep 2019 09:24:32 -0500
Received: from localhost (ileax41-snat.itg.ti.com [10.172.224.153])
        by fllv0040.itg.ti.com (8.15.2/8.15.2) with ESMTP id x8UEOfP8100297;
        Mon, 30 Sep 2019 09:24:41 -0500
From:   Dan Murphy <dmurphy@ti.com>
To:     <sre@kernel.org>, <linux-pm@vger.kernel.org>
CC:     <linux-kernel@vger.kernel.org>, Dan Murphy <dmurphy@ti.com>
Subject: [PATCH 1/3] power_supply: Add additional health properties to the header
Date:   Mon, 30 Sep 2019 09:31:35 -0500
Message-ID: <20190930143137.21624-1-dmurphy@ti.com>
X-Mailer: git-send-email 2.22.0.214.g8dca754b1e
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-EXCLAIMER-MD-CONFIG: e1e8a2fd-e40a-4ac6-ac9b-f7e9cc9ee180
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

Add HEALTH_WARM, HEALTH_COOL and HEALTH_HOT to the health enum.

Signed-off-by: Dan Murphy <dmurphy@ti.com>
---
 include/linux/power_supply.h | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/include/linux/power_supply.h b/include/linux/power_supply.h
index 28413f737e7d..bd0d3225f245 100644
--- a/include/linux/power_supply.h
+++ b/include/linux/power_supply.h
@@ -61,6 +61,9 @@ enum {
 	POWER_SUPPLY_HEALTH_WATCHDOG_TIMER_EXPIRE,
 	POWER_SUPPLY_HEALTH_SAFETY_TIMER_EXPIRE,
 	POWER_SUPPLY_HEALTH_OVERCURRENT,
+	POWER_SUPPLY_HEALTH_WARM,
+	POWER_SUPPLY_HEALTH_COOL,
+	POWER_SUPPLY_HEALTH_HOT,
 };
 
 enum {
-- 
2.22.0.214.g8dca754b1e

