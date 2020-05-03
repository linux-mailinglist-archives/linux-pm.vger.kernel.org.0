Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1D6D21C2D51
	for <lists+linux-pm@lfdr.de>; Sun,  3 May 2020 17:21:36 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728782AbgECPVS (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Sun, 3 May 2020 11:21:18 -0400
Received: from rere.qmqm.pl ([91.227.64.183]:3830 "EHLO rere.qmqm.pl"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728743AbgECPVR (ORCPT <rfc822;linux-pm@vger.kernel.org>);
        Sun, 3 May 2020 11:21:17 -0400
Received: from remote.user (localhost [127.0.0.1])
        by rere.qmqm.pl (Postfix) with ESMTPSA id 49FV7Z24nPzyJ;
        Sun,  3 May 2020 17:21:14 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=rere.qmqm.pl; s=1;
        t=1588519274; bh=D5lHcvsWUfCazaZCIpXQUO49elvu1ZjF+jgG6AivSgU=;
        h=Date:In-Reply-To:References:From:Subject:To:Cc:From;
        b=JjeuhiGZ7NFgr9As58a6U4F4hzSsBzWRrMaF9Vu61kXE2h0olxRKmekFeSoAgbnSz
         0kcFOR4dFjy2TNs0shK9HoNrtDgb9prjPNncw0Yh1CaWC1R/n0y9hYweJkcl1z/oUr
         hnOHVyczSA8R9kivedUeqgX9uVMw0QjxZVi1rjiqPS6PwZMSS68k3mC0p+Ya6Wy1uK
         Y8A2R0lBcSTVM/XvOXY7gGp7GkW68XHMGAdX9sZSSGZz/O00GK8Y97V5G8PLWp3ndJ
         EboElt6gsQqeu+kPIByKDHjP0wmiAf7NlCwYsGPz7YSjAulv4+zMOlpt4UtNpAwEtJ
         4zvskGCUeeQ9Q==
X-Virus-Status: Clean
X-Virus-Scanned: clamav-milter 0.102.2 at mail
Date:   Sun, 03 May 2020 17:21:14 +0200
Message-Id: <75c3b4fe55ba0059c7f7ed6f224c116ee98623ff.1588517058.git.mirq-linux@rere.qmqm.pl>
In-Reply-To: <cover.1588517058.git.mirq-linux@rere.qmqm.pl>
References: <cover.1588517058.git.mirq-linux@rere.qmqm.pl>
From:   =?UTF-8?q?Micha=C5=82=20Miros=C5=82aw?= <mirq-linux@rere.qmqm.pl>
Subject: [PATCH v2 10/11] power: bq25890: support IBAT compensation
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
To:     Rob Herring <robh+dt@kernel.org>,
        Sebastian Reichel <sre@kernel.org>
Cc:     devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-pm@vger.kernel.org
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
index 87c5832e23d3..9d1ba3bd0bea 100644
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
@@ -650,7 +656,9 @@ static int bq25890_hw_init(struct bq25890_device *bq)
 		{F_BOOSTI,	 bq->init_data.boosti},
 		{F_BOOSTF,	 bq->init_data.boostf},
 		{F_EN_ILIM,	 bq->init_data.ilim_en},
-		{F_TREG,	 bq->init_data.treg}
+		{F_TREG,	 bq->init_data.treg},
+		{F_BATCMP,	 bq->init_data.rbatcomp},
+		{F_VCLAMP,	 bq->init_data.vclamp},
 	};
 
 	ret = bq25890_chip_reset(bq);
@@ -861,11 +869,14 @@ static int bq25890_fw_read_u32_props(struct bq25890_device *bq)
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

