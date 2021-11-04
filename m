Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 35CFA445448
	for <lists+linux-pm@lfdr.de>; Thu,  4 Nov 2021 14:53:40 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231215AbhKDN4P (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Thu, 4 Nov 2021 09:56:15 -0400
Received: from mx0a-001ae601.pphosted.com ([67.231.149.25]:35644 "EHLO
        mx0b-001ae601.pphosted.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S230401AbhKDN4O (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Thu, 4 Nov 2021 09:56:14 -0400
Received: from pps.filterd (m0077473.ppops.net [127.0.0.1])
        by mx0a-001ae601.pphosted.com (8.16.1.2/8.16.1.2) with ESMTP id 1A46fQYI015730;
        Thu, 4 Nov 2021 08:53:33 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cirrus.com; h=from : to : cc :
 subject : date : message-id : in-reply-to : references : mime-version :
 content-transfer-encoding : content-type; s=PODMain02222019;
 bh=1Pv77IRgt/Ji1nC8p5CSpvCGKBLNjyJ+wDCSD75Dx1I=;
 b=CRxt13aM+FO8mBhGgojz7Y/Dy6VNL3rEixZrx4EN7Gk5hPl+o+7IBamb8Yuz2SHMvH/q
 f3lm5ld+haTKozcUikjDn3wlqZbhopvky+upUI2btDUVFWR+f3ga5ba79IFEztAqRGmb
 tjy/xGSm1ai6cpuE8vEyKI22qEDiVB1DDiYdm2dh0i4qann8uk2gM/rE+c0S9b7DHwBk
 dIMEezy6e+tzoOBX7HRfBaL5XCN0az/Mo8IPQxbwhKckrKjwWgibJAsYpeg5YdP2wBmq
 0o9oAKn6MWe2q0uQPTNr3hSwNOVrbsxwbCdtBsmLycSMj/lpQTVvrmcu/2f6nEJPk87A Lg== 
Received: from ediex01.ad.cirrus.com ([87.246.76.36])
        by mx0a-001ae601.pphosted.com (PPS) with ESMTPS id 3c3e1432nk-2
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT);
        Thu, 04 Nov 2021 08:53:33 -0500
Received: from EDIEX01.ad.cirrus.com (198.61.84.80) by EDIEX01.ad.cirrus.com
 (198.61.84.80) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.12; Thu, 4 Nov
 2021 13:53:31 +0000
Received: from ediswmail.ad.cirrus.com (198.61.86.93) by EDIEX01.ad.cirrus.com
 (198.61.84.80) with Microsoft SMTP Server id 15.1.2375.12 via Frontend
 Transport; Thu, 4 Nov 2021 13:53:31 +0000
Received: from ricardo-lws.crystal.cirrus.com (ricardo-lws.ad.cirrus.com [141.131.206.19])
        by ediswmail.ad.cirrus.com (Postfix) with ESMTP id D63BAB16;
        Thu,  4 Nov 2021 13:53:30 +0000 (UTC)
From:   Ricardo Rivera-Matos <rriveram@opensource.cirrus.com>
To:     <patches@opensource.cirrus.com>, <sre@kernel.org>,
        <linux-pm@vger.kernel.org>, <linux-kernel@vger.kernel.org>
CC:     Ricardo Rivera-Matos <rriveram@opensource.cirrus.com>
Subject: [PATCH 1/1] power: supply: Introduces bypass charging property
Date:   Thu, 4 Nov 2021 08:50:27 -0500
Message-ID: <20211104135027.2352874-2-rriveram@opensource.cirrus.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20211104135027.2352874-1-rriveram@opensource.cirrus.com>
References: <20211104135027.2352874-1-rriveram@opensource.cirrus.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Proofpoint-ORIG-GUID: T9gXKuatNBMzi9LgkXlFylFhMdglzSSD
X-Proofpoint-GUID: T9gXKuatNBMzi9LgkXlFylFhMdglzSSD
X-Proofpoint-Spam-Reason: safe
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

Adds a POWER_SUPPLY_CHARGE_TYPE_BYPASS option to the POWER_SUPPLY_PROP_CHARGE_TYPE
property to facilitate bypass charging operation.

In bypass charging operation, the charger bypasses the charging path around the
integrated converter allowing for a "smart" wall adaptor to perform the power
conversion externally.

This operational mode is critical for the USB PPS standard of power adaptors and is
becoming a common feature in modern charging ICs such as:

- BQ25980
- BQ25975
- BQ25960
- LN8000
- LN8410

Signed-off-by: Ricardo Rivera-Matos <rriveram@opensource.cirrus.com>
---
 drivers/power/supply/power_supply_sysfs.c | 1 +
 include/linux/power_supply.h              | 1 +
 2 files changed, 2 insertions(+)

diff --git a/drivers/power/supply/power_supply_sysfs.c b/drivers/power/supply/power_supply_sysfs.c
index c3d7cbcd4fad..1368e13dc94b 100644
--- a/drivers/power/supply/power_supply_sysfs.c
+++ b/drivers/power/supply/power_supply_sysfs.c
@@ -89,6 +89,7 @@ static const char * const POWER_SUPPLY_CHARGE_TYPE_TEXT[] = {
 	[POWER_SUPPLY_CHARGE_TYPE_ADAPTIVE]	= "Adaptive",
 	[POWER_SUPPLY_CHARGE_TYPE_CUSTOM]	= "Custom",
 	[POWER_SUPPLY_CHARGE_TYPE_LONGLIFE]	= "Long Life",
+	[POWER_SUPPLY_CHARGE_TYPE_BYPASS]	= "Bypass",
 };
 
 static const char * const POWER_SUPPLY_HEALTH_TEXT[] = {
diff --git a/include/linux/power_supply.h b/include/linux/power_supply.h
index 9ca1f120a211..9432234d7900 100644
--- a/include/linux/power_supply.h
+++ b/include/linux/power_supply.h
@@ -49,6 +49,7 @@ enum {
 	POWER_SUPPLY_CHARGE_TYPE_ADAPTIVE,	/* dynamically adjusted speed */
 	POWER_SUPPLY_CHARGE_TYPE_CUSTOM,	/* use CHARGE_CONTROL_* props */
 	POWER_SUPPLY_CHARGE_TYPE_LONGLIFE,	/* slow speed, longer life */
+	POWER_SUPPLY_CHARGE_TYPE_BYPASS,	/* bypassing the charger */
 };
 
 enum {
-- 
2.25.1

