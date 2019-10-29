Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 013B5E9086
	for <lists+linux-pm@lfdr.de>; Tue, 29 Oct 2019 21:03:02 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726594AbfJ2UDB (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Tue, 29 Oct 2019 16:03:01 -0400
Received: from lelv0143.ext.ti.com ([198.47.23.248]:41256 "EHLO
        lelv0143.ext.ti.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725879AbfJ2UDA (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Tue, 29 Oct 2019 16:03:00 -0400
Received: from fllv0034.itg.ti.com ([10.64.40.246])
        by lelv0143.ext.ti.com (8.15.2/8.15.2) with ESMTP id x9TK2w4E111113;
        Tue, 29 Oct 2019 15:02:58 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
        s=ti-com-17Q1; t=1572379378;
        bh=ka5ha/Tzt+vFQfCRNPrMeCS7n3mWeBklbHZMPqoPqP0=;
        h=From:To:CC:Subject:Date;
        b=y/w8ui+0jTGaRe5VY5J0+15q/yTkW0pETDpYv51cW3auUUEajIpokgBqRNfnrgjbq
         7wQhAEKQn7VjWSoIp6BYXKuJJz+4VAQeej6wIm6CnLXhJjKPuFON3Is6CPG/oqKX5Z
         H1WkTRAM+S2/lPQRvyBDAcn8xPR2pf1YHZ8I2tOo=
Received: from DFLE113.ent.ti.com (dfle113.ent.ti.com [10.64.6.34])
        by fllv0034.itg.ti.com (8.15.2/8.15.2) with ESMTPS id x9TK2wm6021244
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
        Tue, 29 Oct 2019 15:02:58 -0500
Received: from DFLE115.ent.ti.com (10.64.6.36) by DFLE113.ent.ti.com
 (10.64.6.34) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.1713.5; Tue, 29
 Oct 2019 15:02:45 -0500
Received: from fllv0039.itg.ti.com (10.64.41.19) by DFLE115.ent.ti.com
 (10.64.6.36) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.1713.5 via
 Frontend Transport; Tue, 29 Oct 2019 15:02:45 -0500
Received: from localhost (ileax41-snat.itg.ti.com [10.172.224.153])
        by fllv0039.itg.ti.com (8.15.2/8.15.2) with ESMTP id x9TK2vVt124135;
        Tue, 29 Oct 2019 15:02:57 -0500
From:   Dan Murphy <dmurphy@ti.com>
To:     <sre@kernel.org>, <linux-pm@vger.kernel.org>
CC:     <linux-kernel@vger.kernel.org>, Dan Murphy <dmurphy@ti.com>
Subject: [PATCH v2 1/3] power_supply: Add additional health properties to the header
Date:   Tue, 29 Oct 2019 15:01:59 -0500
Message-ID: <20191029200201.24483-1-dmurphy@ti.com>
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

v2 - No changes

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

