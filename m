Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 93791D1A84
	for <lists+linux-pm@lfdr.de>; Wed,  9 Oct 2019 23:06:33 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731145AbfJIVGd (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Wed, 9 Oct 2019 17:06:33 -0400
Received: from muru.com ([72.249.23.125]:36506 "EHLO muru.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729908AbfJIVGc (ORCPT <rfc822;linux-pm@vger.kernel.org>);
        Wed, 9 Oct 2019 17:06:32 -0400
Received: from hillo.muru.com (localhost [127.0.0.1])
        by muru.com (Postfix) with ESMTP id 4645D8162;
        Wed,  9 Oct 2019 21:07:06 +0000 (UTC)
From:   Tony Lindgren <tony@atomide.com>
To:     Sebastian Reichel <sre@kernel.org>
Cc:     linux-pm@vger.kernel.org, linux-omap@vger.kernel.org,
        Merlijn Wajer <merlijn@wizzup.org>, Pavel Machek <pavel@ucw.cz>
Subject: [PATCH 3/5] power: supply: cpcap-battery: Simplify short term power average calculation
Date:   Wed,  9 Oct 2019 14:06:19 -0700
Message-Id: <20191009210621.10522-4-tony@atomide.com>
X-Mailer: git-send-email 2.23.0
In-Reply-To: <20191009210621.10522-1-tony@atomide.com>
References: <20191009210621.10522-1-tony@atomide.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

We can use sign_extend32() here to simplify things. And let's fix the
comment for CCM register, that contains the calibration offset.

Cc: Merlijn Wajer <merlijn@wizzup.org>
Cc: Pavel Machek <pavel@ucw.cz>
Signed-off-by: Tony Lindgren <tony@atomide.com>
---
 drivers/power/supply/cpcap-battery.c | 23 ++++++++++-------------
 1 file changed, 10 insertions(+), 13 deletions(-)

diff --git a/drivers/power/supply/cpcap-battery.c b/drivers/power/supply/cpcap-battery.c
--- a/drivers/power/supply/cpcap-battery.c
+++ b/drivers/power/supply/cpcap-battery.c
@@ -312,31 +312,28 @@ cpcap_battery_read_accumulated(struct cpcap_battery_ddata *ddata,
 static int cpcap_battery_cc_get_avg_current(struct cpcap_battery_ddata *ddata)
 {
 	int value, acc, error;
-	s32 sample = 1;
+	s32 sample;
 	s16 offset;
 
-	if (ddata->vendor == CPCAP_VENDOR_ST)
-		sample = 4;
-
 	/* Coulomb counter integrator */
 	error = regmap_read(ddata->reg, CPCAP_REG_CCI, &value);
 	if (error)
 		return error;
 
-	if ((ddata->vendor == CPCAP_VENDOR_TI) && (value > 0x2000))
-		value = value | 0xc000;
-
-	acc = (s16)value;
+	if (ddata->vendor == CPCAP_VENDOR_TI) {
+		acc = sign_extend32(value, 13);
+		sample = 1;
+	} else {
+		acc = (s16)value;
+		sample = 4;
+	}
 
-	/* Coulomb counter sample time */
+	/* Coulomb counter calibration offset  */
 	error = regmap_read(ddata->reg, CPCAP_REG_CCM, &value);
 	if (error)
 		return error;
 
-	if (value < 0x200)
-		offset = value;
-	else
-		offset = value | 0xfc00;
+	offset = sign_extend32(value, 9);
 
 	return cpcap_battery_cc_to_ua(ddata, sample, acc, offset);
 }
-- 
2.23.0
