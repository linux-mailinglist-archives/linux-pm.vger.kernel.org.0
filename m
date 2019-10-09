Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 2019ED1A7F
	for <lists+linux-pm@lfdr.de>; Wed,  9 Oct 2019 23:06:32 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731072AbfJIVGb (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Wed, 9 Oct 2019 17:06:31 -0400
Received: from muru.com ([72.249.23.125]:36488 "EHLO muru.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729908AbfJIVGa (ORCPT <rfc822;linux-pm@vger.kernel.org>);
        Wed, 9 Oct 2019 17:06:30 -0400
Received: from hillo.muru.com (localhost [127.0.0.1])
        by muru.com (Postfix) with ESMTP id A35638162;
        Wed,  9 Oct 2019 21:07:03 +0000 (UTC)
From:   Tony Lindgren <tony@atomide.com>
To:     Sebastian Reichel <sre@kernel.org>
Cc:     linux-pm@vger.kernel.org, linux-omap@vger.kernel.org,
        Merlijn Wajer <merlijn@wizzup.org>, Pavel Machek <pavel@ucw.cz>
Subject: [PATCH 1/5] power: supply: cpcap-battery: Move coulomb counter units per lsb to ddata
Date:   Wed,  9 Oct 2019 14:06:17 -0700
Message-Id: <20191009210621.10522-2-tony@atomide.com>
X-Mailer: git-send-email 2.23.0
In-Reply-To: <20191009210621.10522-1-tony@atomide.com>
References: <20191009210621.10522-1-tony@atomide.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

We can simplify cpcap_battery_cc_raw_div() a bit by moving the units per
lsb to ddata.

Cc: Merlijn Wajer <merlijn@wizzup.org>
Cc: Pavel Machek <pavel@ucw.cz>
Signed-off-by: Tony Lindgren <tony@atomide.com>
---
 drivers/power/supply/cpcap-battery.c | 28 ++++++++++++++--------------
 1 file changed, 14 insertions(+), 14 deletions(-)

diff --git a/drivers/power/supply/cpcap-battery.c b/drivers/power/supply/cpcap-battery.c
--- a/drivers/power/supply/cpcap-battery.c
+++ b/drivers/power/supply/cpcap-battery.c
@@ -111,6 +111,7 @@ struct cpcap_battery_ddata {
 	struct power_supply *psy;
 	struct cpcap_battery_config config;
 	struct cpcap_battery_state_data state[CPCAP_BATTERY_STATE_NR];
+	u32 cc_lsb;		/* μAms per LSB */
 	atomic_t active;
 	int status;
 	u16 vendor;
@@ -220,32 +221,19 @@ static int cpcap_battery_cc_raw_div(struct cpcap_battery_ddata *ddata,
 	s64 acc;
 	u64 tmp;
 	int avg_current;
-	u32 cc_lsb;
 
 	if (!divider)
 		return 0;
 
-	switch (ddata->vendor) {
-	case CPCAP_VENDOR_ST:
-		cc_lsb = 95374;		/* μAms per LSB */
-		break;
-	case CPCAP_VENDOR_TI:
-		cc_lsb = 91501;		/* μAms per LSB */
-		break;
-	default:
-		return -EINVAL;
-	}
-
 	acc = accumulator;
 	acc = acc - ((s64)sample * offset);
-	cc_lsb = (cc_lsb * ddata->config.cd_factor) / 1000;
 
 	if (acc >=  0)
 		tmp = acc;
 	else
 		tmp = acc * -1;
 
-	tmp = tmp * cc_lsb;
+	tmp = tmp * ddata->cc_lsb;
 	do_div(tmp, divider);
 	avg_current = tmp;
 
@@ -814,6 +802,18 @@ static int cpcap_battery_probe(struct platform_device *pdev)
 	if (error)
 		return error;
 
+	switch (ddata->vendor) {
+	case CPCAP_VENDOR_ST:
+		ddata->cc_lsb = 95374;	/* μAms per LSB */
+		break;
+	case CPCAP_VENDOR_TI:
+		ddata->cc_lsb = 91501;	/* μAms per LSB */
+		break;
+	default:
+		return -EINVAL;
+	}
+	ddata->cc_lsb = (ddata->cc_lsb * ddata->config.cd_factor) / 1000;
+
 	platform_set_drvdata(pdev, ddata);
 
 	error = regmap_update_bits(ddata->reg, CPCAP_REG_CCM,
-- 
2.23.0
