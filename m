Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D2D34279C0F
	for <lists+linux-pm@lfdr.de>; Sat, 26 Sep 2020 21:15:22 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729443AbgIZTPU (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Sat, 26 Sep 2020 15:15:20 -0400
Received: from rere.qmqm.pl ([91.227.64.183]:55371 "EHLO rere.qmqm.pl"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726183AbgIZTPT (ORCPT <rfc822;linux-pm@vger.kernel.org>);
        Sat, 26 Sep 2020 15:15:19 -0400
X-Greylist: delayed 584 seconds by postgrey-1.27 at vger.kernel.org; Sat, 26 Sep 2020 15:15:19 EDT
Received: from remote.user (localhost [127.0.0.1])
        by rere.qmqm.pl (Postfix) with ESMTPSA id 4BzJC30yhjz2KM;
        Sat, 26 Sep 2020 21:05:35 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=rere.qmqm.pl; s=1;
        t=1601147135; bh=A6FEbk0jOsce4uOG4hqYgXIH+C1qRtC4NLa/GQ9EAY0=;
        h=Date:In-Reply-To:References:From:Subject:To:Cc:From;
        b=hNGAkvK0zBV+8SNw0ZZPspmlwKmbKpnJ6JINGqy23i8riZDaSFAlqXbR7kAyARuEc
         0Y5+UF6EPKqvchuFYmGoB9b1fMX0JvYHkwNJ/KulTqFHw3n+7n0s5FLyEkdsibII1H
         hmjB84wiuXGP6DZ6NAz4lqgaebMB4yNjCJZ8vGwyVu596cc8RiZ4Ew2p2xC59iWRqI
         oy0hZxAc18GiOURhWa0DrjKCeoGkLpFWbz7QJkIdRwmGQuaKv2B15TfUUfwwkPmbBR
         f4xykrzI8acqpaHzzZj3nAYL1hqlfxiGkwaFL6tULMdtiFhbq32/9Bt9OwlJCJZTCU
         nX2cmxAz1DnTw==
X-Virus-Status: Clean
X-Virus-Scanned: clamav-milter 0.102.4 at mail
Date:   Sat, 26 Sep 2020 21:05:34 +0200
Message-Id: <73bd1e2f62912bc97152078540f15fcf6438e6c1.1601146802.git.mirq-linux@rere.qmqm.pl>
In-Reply-To: <cover.1601146802.git.mirq-linux@rere.qmqm.pl>
References: <cover.1601146802.git.mirq-linux@rere.qmqm.pl>
From:   =?UTF-8?q?Micha=C5=82=20Miros=C5=82aw?= <mirq-linux@rere.qmqm.pl>
Subject: [PATCH v4 2/2] power: bq25890: support IBAT compensation
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
To:     Angus Ainslie <angus@akkea.ca>, Rob Herring <robh+dt@kernel.org>,
        Sebastian Reichel <sre@kernel.org>,
        Yauhen Kharuzhy <jekhor@gmail.com>
Cc:     devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-pm@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

Add configuration for compensation of IBAT measuring resistor in series
with the battery.

Signed-off-by: Michał Mirosław <mirq-linux@rere.qmqm.pl>
---
v4: renamed properties applying property-suffix
---
 drivers/power/supply/bq25890_charger.c | 15 +++++++++++++--
 1 file changed, 13 insertions(+), 2 deletions(-)

diff --git a/drivers/power/supply/bq25890_charger.c b/drivers/power/supply/bq25890_charger.c
index 77150667e36b..ab8398f935c5 100644
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
@@ -648,7 +654,9 @@ static int bq25890_hw_init(struct bq25890_device *bq)
 		{F_BOOSTI,	 bq->init_data.boosti},
 		{F_BOOSTF,	 bq->init_data.boostf},
 		{F_EN_ILIM,	 bq->init_data.ilim_en},
-		{F_TREG,	 bq->init_data.treg}
+		{F_TREG,	 bq->init_data.treg},
+		{F_BATCMP,	 bq->init_data.rbatcomp},
+		{F_VCLAMP,	 bq->init_data.vclamp},
 	};
 
 	ret = bq25890_chip_reset(bq);
@@ -859,11 +867,14 @@ static int bq25890_fw_read_u32_props(struct bq25890_device *bq)
 		{"ti,boost-max-current", false, TBL_BOOSTI, &init->boosti},
 
 		/* optional properties */
-		{"ti,thermal-regulation-threshold", true, TBL_TREG, &init->treg}
+		{"ti,thermal-regulation-threshold", true, TBL_TREG, &init->treg},
+		{"ti,ibatcomp-micro-ohms", true, TBL_RBATCOMP, &init->rbatcomp},
+		{"ti,ibatcomp-clamp-microvolt", true, TBL_VBATCOMP, &init->vclamp},
 	};
 
 	/* initialize data for optional properties */
 	init->treg = 3; /* 120 degrees Celsius */
+	init->rbatcomp = init->vclamp = 0; /* IBAT compensation disabled */
 
 	for (i = 0; i < ARRAY_SIZE(props); i++) {
 		ret = device_property_read_u32(bq->dev, props[i].name,
-- 
2.20.1

