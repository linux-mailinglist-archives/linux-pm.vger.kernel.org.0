Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 182E119C528
	for <lists+linux-pm@lfdr.de>; Thu,  2 Apr 2020 16:59:01 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2389072AbgDBO6j (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Thu, 2 Apr 2020 10:58:39 -0400
Received: from rere.qmqm.pl ([91.227.64.183]:45187 "EHLO rere.qmqm.pl"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2389060AbgDBO6j (ORCPT <rfc822;linux-pm@vger.kernel.org>);
        Thu, 2 Apr 2020 10:58:39 -0400
Received: from remote.user (localhost [127.0.0.1])
        by rere.qmqm.pl (Postfix) with ESMTPSA id 48tR5n2L4szpX;
        Thu,  2 Apr 2020 16:58:37 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=rere.qmqm.pl; s=1;
        t=1585839517; bh=K0kGzxg39yXWXSUEEmrAX5O79dFH60rAvb0VYzqfkq4=;
        h=Date:In-Reply-To:References:From:Subject:To:Cc:From;
        b=BUQAgeEbaQo7vEZ70u/oDSCKsw+v5485zBKPRB2tuYWUIbvv1Nvsl+ZqdN4Ck2Nq7
         i3zV0w7F6xlJZFctGDMlcngHZyIn11F4ozCHVgGejY6d7rfhoPzekUUd1LfoLFE49Q
         8AVlsuiLwucyjJ6Ckx3gztCPFvP7lL2nLwV3QHoLoPzhDR6vy37x0LNMPUC7SDslA5
         LcHIzSkbN9MoXbRjO39CjOd+P7B4D93oyjktH0Nn+IYGLL9uMH6h10BgnOVigKYHRC
         +O7QqDxkKPbGHMjgNimDz0rNNlifzr8CxpWTSeIkcTCx41ksflgnqjNBxULaP/qoO6
         75wEgBU6UYIgg==
X-Virus-Status: Clean
X-Virus-Scanned: clamav-milter 0.102.2 at mail
Date:   Thu, 02 Apr 2020 16:58:36 +0200
Message-Id: <f70ea4f644d5751e8e254d4c718e964c63cac201.1585838679.git.mirq-linux@rere.qmqm.pl>
In-Reply-To: <cover.1585838678.git.mirq-linux@rere.qmqm.pl>
References: <cover.1585838678.git.mirq-linux@rere.qmqm.pl>
From:   =?UTF-8?q?Micha=C5=82=20Miros=C5=82aw?= <mirq-linux@rere.qmqm.pl>
Subject: [PATCH 14/14] power: supply: bq25890: support IBAT compensation
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
To:     Sebastian Reichel <sre@kernel.org>
Cc:     linux-kernel@vger.kernel.org, linux-pm@vger.kernel.org
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

Add configuration for compensation of IBAT measuring resistor in series
with the battery.

Signed-off-by: Michał Mirosław <mirq-linux@rere.qmqm.pl>
---
 drivers/power/supply/bq25890_charger.c | 15 +++++++++++++--
 1 file changed, 13 insertions(+), 2 deletions(-)

diff --git a/drivers/power/supply/bq25890_charger.c b/drivers/power/supply/bq25890_charger.c
index a61eab6a4552..ba1562968bec 100644
--- a/drivers/power/supply/bq25890_charger.c
+++ b/drivers/power/supply/bq25890_charger.c
@@ -83,6 +83,8 @@ struct bq25890_init_data {
 	u8 boostf;	/* boost frequency		*/
 	u8 ilim_en;	/* enable ILIM pin		*/
 	u8 treg;	/* thermal regulation threshold */
+	u8 rbatcomp;	/* IBAT sense resistor value    */
+	u8 vclamp;	/* IBAT compensation voltage limit */
 };
 
 struct bq25890_state {
@@ -258,6 +260,8 @@ enum bq25890_table_ids {
 	TBL_VREG,
 	TBL_BOOSTV,
 	TBL_SYSVMIN,
+	TBL_VBATCOMP,
+	TBL_RBATCOMP,
 
 	/* lookup tables */
 	TBL_TREG,
@@ -299,6 +303,8 @@ static const union {
 	[TBL_VREG] =	{ .rt = {3840000, 4608000, 16000} },	 /* uV */
 	[TBL_BOOSTV] =	{ .rt = {4550000, 5510000, 64000} },	 /* uV */
 	[TBL_SYSVMIN] = { .rt = {3000000, 3700000, 100000} },	 /* uV */
+	[TBL_VBATCOMP] ={ .rt = {0,        224000, 32000} },	 /* uV */
+	[TBL_RBATCOMP] ={ .rt = {0,        140000, 20000} },	 /* uOhm */
 
 	/* lookup tables */
 	[TBL_TREG] =	{ .lt = {bq25890_treg_tbl, BQ25890_TREG_TBL_SIZE} },
@@ -667,7 +673,9 @@ static int bq25890_hw_init(struct bq25890_device *bq)
 		{F_BOOSTI,	 bq->init_data.boosti},
 		{F_BOOSTF,	 bq->init_data.boostf},
 		{F_EN_ILIM,	 bq->init_data.ilim_en},
-		{F_TREG,	 bq->init_data.treg}
+		{F_TREG,	 bq->init_data.treg},
+		{F_BATCMP,	 bq->init_data.rbatcomp},
+		{F_VCLAMP,	 bq->init_data.vclamp},
 	};
 
 	ret = bq25890_chip_reset(bq);
@@ -880,11 +888,14 @@ static int bq25890_fw_read_u32_props(struct bq25890_device *bq)
 		{"ti,boost-max-current", false, TBL_BOOSTI, &init->boosti},
 
 		/* optional properties */
-		{"ti,thermal-regulation-threshold", true, TBL_TREG, &init->treg}
+		{"ti,thermal-regulation-threshold", true, TBL_TREG, &init->treg},
+		{"ti,ibatcomp-resistance", true, TBL_RBATCOMP, &init->rbatcomp},
+		{"ti,ibatcomp-clamp-voltage", true, TBL_VBATCOMP, &init->vclamp},
 	};
 
 	/* initialize data for optional properties */
 	init->treg = 3; /* 120 degrees Celsius */
+	init->rbatcomp = init->vclamp = 0; /* IBAT compensation disabled */
 
 	for (i = 0; i < ARRAY_SIZE(props); i++) {
 		ret = device_property_read_u32(bq->dev, props[i].name,
-- 
2.20.1

