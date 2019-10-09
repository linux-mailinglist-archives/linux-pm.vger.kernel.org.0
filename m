Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id E7542D1A88
	for <lists+linux-pm@lfdr.de>; Wed,  9 Oct 2019 23:06:34 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731589AbfJIVGe (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Wed, 9 Oct 2019 17:06:34 -0400
Received: from muru.com ([72.249.23.125]:36514 "EHLO muru.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729908AbfJIVGe (ORCPT <rfc822;linux-pm@vger.kernel.org>);
        Wed, 9 Oct 2019 17:06:34 -0400
Received: from hillo.muru.com (localhost [127.0.0.1])
        by muru.com (Postfix) with ESMTP id 88E7D8140;
        Wed,  9 Oct 2019 21:07:07 +0000 (UTC)
From:   Tony Lindgren <tony@atomide.com>
To:     Sebastian Reichel <sre@kernel.org>
Cc:     linux-pm@vger.kernel.org, linux-omap@vger.kernel.org,
        Merlijn Wajer <merlijn@wizzup.org>, Pavel Machek <pavel@ucw.cz>
Subject: [PATCH 4/5] power: supply: cpcap-battery: Read and save integrator register CCI
Date:   Wed,  9 Oct 2019 14:06:20 -0700
Message-Id: <20191009210621.10522-5-tony@atomide.com>
X-Mailer: git-send-email 2.23.0
In-Reply-To: <20191009210621.10522-1-tony@atomide.com>
References: <20191009210621.10522-1-tony@atomide.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

We can simplify code in the later patches by reading and saving the
integrator register CCI. Let's also fix a comment typo for register range
naming while at it.

Cc: Merlijn Wajer <merlijn@wizzup.org>
Cc: Pavel Machek <pavel@ucw.cz>
Signed-off-by: Tony Lindgren <tony@atomide.com>
---
 drivers/power/supply/cpcap-battery.c | 10 +++++++++-
 1 file changed, 9 insertions(+), 1 deletion(-)

diff --git a/drivers/power/supply/cpcap-battery.c b/drivers/power/supply/cpcap-battery.c
--- a/drivers/power/supply/cpcap-battery.c
+++ b/drivers/power/supply/cpcap-battery.c
@@ -84,6 +84,7 @@ struct cpcap_coulomb_counter_data {
 	s32 sample;		/* 24 or 32 bits */
 	s32 accumulator;
 	s16 offset;		/* 9 bits */
+	s16 integrator;		/* 13 or 16 bits */
 };
 
 enum cpcap_battery_state {
@@ -269,12 +270,13 @@ static int
 cpcap_battery_read_accumulated(struct cpcap_battery_ddata *ddata,
 			       struct cpcap_coulomb_counter_data *ccd)
 {
-	u16 buf[7];	/* CPCAP_REG_CC1 to CCI */
+	u16 buf[7];	/* CPCAP_REG_CCS1 to CCI */
 	int error;
 
 	ccd->sample = 0;
 	ccd->accumulator = 0;
 	ccd->offset = 0;
+	ccd->integrator = 0;
 
 	/* Read coulomb counter register range */
 	error = regmap_bulk_read(ddata->reg, CPCAP_REG_CCS1,
@@ -299,6 +301,12 @@ cpcap_battery_read_accumulated(struct cpcap_battery_ddata *ddata,
 	ccd->offset = buf[4];
 	ccd->offset = sign_extend32(ccd->offset, 9);
 
+	/* Integrator register CPCAP_REG_CCI */
+	if (ddata->vendor == CPCAP_VENDOR_TI)
+		ccd->integrator = sign_extend32(buf[6], 13);
+	else
+		ccd->integrator = (s16)buf[6];
+
 	return cpcap_battery_cc_to_uah(ddata,
 				       ccd->sample,
 				       ccd->accumulator,
-- 
2.23.0
