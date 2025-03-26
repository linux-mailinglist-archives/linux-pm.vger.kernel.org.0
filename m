Return-Path: <linux-pm+bounces-24541-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 024ECA71E60
	for <lists+linux-pm@lfdr.de>; Wed, 26 Mar 2025 19:28:32 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 6ACE83B4B58
	for <lists+linux-pm@lfdr.de>; Wed, 26 Mar 2025 18:27:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8E8C2257AF3;
	Wed, 26 Mar 2025 18:26:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b="L0uNkCSl"
X-Original-To: linux-pm@vger.kernel.org
Received: from relay8-d.mail.gandi.net (relay8-d.mail.gandi.net [217.70.183.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 41475255252;
	Wed, 26 Mar 2025 18:26:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.70.183.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1743013596; cv=none; b=nVFsgCMg4C8aTZ+UV7timIQy4U9idnoeiBZj67gcoZEVXfwWAhzo+f69/oFRO2VFLSWBcnSm3chG9s5MBwJ7R/cEg0KCRJ/Tj52kaOErXLw6BuKF+JflMJIuMqsQJ755vQVlvGLvLoatKrh0oJI8EfEs0w6M2mcACdCQWBO6Lcs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1743013596; c=relaxed/simple;
	bh=TXM7sLhzHfOEVWJ/LZpNHizW5tziUNT8UE+3ZJDD6sE=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=mlvFD5Gwe1TARNw7O/DShBzQxAzG4ATzFkCEw74pdAsQV3APH1u3XK/DI/WzBmCGGA6DLoZcQ1N4TKLGi8Y17QFKBzLIyY5fr4yxvSfVyHz+IKk9GMjEBwe9a/Q101Y+r2TIVYuNUjLbvz7PC86Uv1y8eREgHht6qkoq+PWaMT8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com; spf=pass smtp.mailfrom=bootlin.com; dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b=L0uNkCSl; arc=none smtp.client-ip=217.70.183.201
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bootlin.com
Received: by mail.gandi.net (Postfix) with ESMTPSA id 52DE14443C;
	Wed, 26 Mar 2025 18:26:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=gm1;
	t=1743013592;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=DKTpwOtwUs6kWNFE1zxeuftYDJFPwkNiJxs3ZZp0nXc=;
	b=L0uNkCSlYuuQHMPfS8p0uKgfqzAyfEz5yEv4jcYZc75cfdXbWTL+6CudMjYBoPz3FsFF7r
	ClVtozGq7/VitKafCS0HZEPZ8eFGBc4cNzmTw0IKK+GenHPNgMWj2LEcZcF5PjpwzipVQX
	Fw5JZtxtsjuy/CUR7UVKskDWxJqLaAvxVGWKgw2Z9ZgNYkPlSG4A5H9C8OYSnpl/+fhRAP
	qTsM1+Qlr08hQjIRXmQNwrb9DJyqVS0Kra1i0ofEkfqPjW3iayRBHw+sAfwMQUrFgu5qkI
	G35jfjrfp7SkTKOahbMA6eMv/+i4AooVCN/0tcypRbzSn3FC8u/6w4GI0p8H/A==
From: Miquel Raynal <miquel.raynal@bootlin.com>
Date: Wed, 26 Mar 2025 19:26:20 +0100
Subject: [PATCH RFC 05/10] clk: Move runtime PM calls out of the
 prepare_lock in clk_init()
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250326-cross-lock-dep-v1-5-3199e49e8652@bootlin.com>
References: <20250326-cross-lock-dep-v1-0-3199e49e8652@bootlin.com>
In-Reply-To: <20250326-cross-lock-dep-v1-0-3199e49e8652@bootlin.com>
To: "Rafael J. Wysocki" <rafael@kernel.org>, Pavel Machek <pavel@ucw.cz>, 
 Len Brown <len.brown@intel.com>, 
 Greg Kroah-Hartman <gregkh@linuxfoundation.org>, 
 Danilo Krummrich <dakr@kernel.org>, 
 Michael Turquette <mturquette@baylibre.com>, 
 Stephen Boyd <sboyd@kernel.org>
Cc: Thomas Petazzoni <thomas.petazzoni@bootlin.com>, 
 linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org, 
 linux-clk@vger.kernel.org, Chen-Yu Tsai <wenst@chromium.org>, 
 Lucas Stach <l.stach@pengutronix.de>, 
 Laurent Pinchart <laurent.pinchart@ideasonboard.com>, 
 Marek Vasut <marex@denx.de>, Ulf Hansson <ulf.hansson@linaro.org>, 
 Kevin Hilman <khilman@kernel.org>, Fabio Estevam <festevam@denx.de>, 
 Jacky Bai <ping.bai@nxp.com>, Peng Fan <peng.fan@nxp.com>, 
 Shawn Guo <shawnguo@kernel.org>, Shengjiu Wang <shengjiu.wang@nxp.com>, 
 linux-imx@nxp.com, Ian Ray <ian.ray@gehealthcare.com>, 
 =?utf-8?q?Herv=C3=A9_Codina?= <herve.codina@bootlin.com>, 
 Luca Ceresoli <luca.ceresoli@bootlin.com>, 
 Saravana Kannan <saravanak@google.com>, 
 Miquel Raynal <miquel.raynal@bootlin.com>
X-Mailer: b4 0.15-dev
X-GND-State: clean
X-GND-Score: -100
X-GND-Cause: gggruggvucftvghtrhhoucdtuddrgeefvddrtddtgdduieeivdehucetufdoteggodetrfdotffvucfrrhhofhhilhgvmecuifetpfffkfdpucggtfgfnhhsuhgsshgtrhhisggvnecuuegrihhlohhuthemuceftddunecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenucfjughrpefhfffugggtgffkfhgjvfevofesthejredtredtjeenucfhrhhomhepofhiqhhuvghlucftrgihnhgrlhcuoehmihhquhgvlhdrrhgrhihnrghlsegsohhothhlihhnrdgtohhmqeenucggtffrrghtthgvrhhnpeelgfehvdduieefieeikeffgffggfdttdeugeffieetheeuleelfeehffdtffetveenucfkphepledtrdekledrudeifedruddvjeenucevlhhushhtvghrufhiiigvpeefnecurfgrrhgrmhepihhnvghtpeeltddrkeelrdduieefrdduvdejpdhhvghloheplgduledvrdduieekrdegvddrgeeingdpmhgrihhlfhhrohhmpehmihhquhgvlhdrrhgrhihnrghlsegsohhothhlihhnrdgtohhmpdhnsggprhgtphhtthhopedvkedprhgtphhtthhopehmrghrvgigseguvghngidruggvpdhrtghpthhtoheplhhinhhugidqihhmgiesnhigphdrtghomhdprhgtphhtthhopehlihhnuhigqdgtlhhksehvghgvrhdrkhgvrhhnvghlrdhorhhgpdhrtghpthhtohepihgrnhdrrhgrhiesghgvhhgvrghlthhhtggrrhgvrdgtohhmpdhrtghpthhtohepmhhtuhhrqhhuvghtthgvsegsrgihlhhisghrvgdrtghomhdpr
 hgtphhtthhopehssghohigusehkvghrnhgvlhdrohhrghdprhgtphhtthhopehkhhhilhhmrghnsehkvghrnhgvlhdrohhrghdprhgtphhtthhopehthhhomhgrshdrphgvthgriiiiohhnihessghoohhtlhhinhdrtghomh
X-GND-Sasl: miquel.raynal@bootlin.com

In order to fix the ABBA locking situation between clock and power
domains, let's disimburse these two locks by preventing any runtime PM
call to happen with the clk prepare_lock mutex acquired.

The __clock_core_init() routine shall preferably call the runtime PM
functions before acquiring the prepare lock, which can be achieved by
the existing clk_pm_runtime_get_all() call. We have no other choice than
waking up all clocks at this stage because we are going the possibly
reparent any random orphan clock in the system at this stage, and thus
will require all its parents and children to be enabled.

Signed-off-by: Miquel Raynal <miquel.raynal@bootlin.com>
---
 drivers/clk/clk.c | 16 ++++++++++------
 1 file changed, 10 insertions(+), 6 deletions(-)

diff --git a/drivers/clk/clk.c b/drivers/clk/clk.c
index a6148eae7b6615d23d6ac665e8f94e2ae69f93b6..b6decfaf8aa6bd50c2173d19f1ece8f08a95afd8 100644
--- a/drivers/clk/clk.c
+++ b/drivers/clk/clk.c
@@ -3906,6 +3906,14 @@ static int __clk_core_init(struct clk_core *core)
 	unsigned long rate;
 	int phase;
 
+	/*
+	 * While reparenting the orphans, it is too late to resume the children
+	 * that will get their rates recalculated.
+	 */
+	ret = clk_pm_runtime_get_all();
+	if (ret)
+		return ret;
+
 	clk_prepare_lock();
 
 	/*
@@ -3916,10 +3924,6 @@ static int __clk_core_init(struct clk_core *core)
 	 */
 	core->hw->core = core;
 
-	ret = clk_pm_runtime_get(core);
-	if (ret)
-		goto unlock;
-
 	/* check to see if a clock with this name is already registered */
 	if (clk_core_lookup(core->name)) {
 		pr_debug("%s: clk %s already initialized\n",
@@ -4082,8 +4086,6 @@ static int __clk_core_init(struct clk_core *core)
 
 	clk_core_reparent_orphans_nolock();
 out:
-	clk_pm_runtime_put(core);
-unlock:
 	if (ret) {
 		hlist_del_init(&core->child_node);
 		core->hw->core = NULL;
@@ -4091,6 +4093,8 @@ static int __clk_core_init(struct clk_core *core)
 
 	clk_prepare_unlock();
 
+	clk_pm_runtime_put_all();
+
 	if (!ret)
 		clk_debug_register(core);
 

-- 
2.48.1


