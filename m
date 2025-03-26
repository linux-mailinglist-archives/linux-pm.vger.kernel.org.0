Return-Path: <linux-pm+bounces-24546-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 7E1A4A71E6C
	for <lists+linux-pm@lfdr.de>; Wed, 26 Mar 2025 19:30:36 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id A5A053B3B16
	for <lists+linux-pm@lfdr.de>; Wed, 26 Mar 2025 18:28:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 955C125EF9B;
	Wed, 26 Mar 2025 18:26:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b="WQBePKR6"
X-Original-To: linux-pm@vger.kernel.org
Received: from relay8-d.mail.gandi.net (relay8-d.mail.gandi.net [217.70.183.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 73EB825D524;
	Wed, 26 Mar 2025 18:26:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.70.183.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1743013602; cv=none; b=B+lfBENgT2i0m0j9XCMJUrrFx3sp1z9up6o6nPZjRToas81YhbKhR9n3ObH5vWgPEuMHL0QkeEWwHz2vq89ZEccT6+FhFI7JgpD6gcrpeXnc9xYN9cGcX+ENg47XjF5z6JSnh0/d8BU59P+o6BzG9rcCOdBo9sIb/TzQsqLbeco=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1743013602; c=relaxed/simple;
	bh=2hOOkKfJ2O24FeBerSRc7TzBcA7RAdNIvqDCbUOqPBs=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=bIMeYPny+SRWPFKI0XKfB8Q9o3AFAU43srAyHanFMTgfVnNj4Fg+2paIFXEhfZ3GS59BC9pZtNpidXgfGteCTJPMSuPLvemvG7il5/3zQ0feBXLBGbpW8p5FG5AAwaXLpXq53cEtgGoa1NvxkMqp/jJ+4BBIt2xDiIxEZxHsRWg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com; spf=pass smtp.mailfrom=bootlin.com; dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b=WQBePKR6; arc=none smtp.client-ip=217.70.183.201
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bootlin.com
Received: by mail.gandi.net (Postfix) with ESMTPSA id BD6F844447;
	Wed, 26 Mar 2025 18:26:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=gm1;
	t=1743013598;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=G6fDJAgeivWwEjOlUOt+sxMAv2+TjUSgdeW6xREfgQ4=;
	b=WQBePKR6H4Qi0pPpju+j0GA4z4uw2abs39R6ZvrmXUT7QQXG06s56xvKtQtO4KjWqdF7Df
	dpT/YQ+1W6kwCwSyqW5+tjpfVHHzIO7tqSJA6+/0WUtzbpDlMCnHdEw8jMrzTPnlmIObSK
	8vUfxrXsB+MtbES6OucJb75vs1SRo8cWbcHk/7m5OzXaD2pqSNWeIsg6oDca6m9kLRw2CD
	PQZUTQsucwmimu2Yl3CYP0VIZrfNDvNJr398UMc4+x4Iu5MIlwJD2F6CQW3d2ZYKzF2Tv6
	0mbek6lj9SZIX133MF4YJtQ33N8t8yElehLWVozJtTLRsqIvOfycZjMwUxP2Vw==
From: Miquel Raynal <miquel.raynal@bootlin.com>
Date: Wed, 26 Mar 2025 19:26:25 +0100
Subject: [PATCH RFC 10/10] clk: Fix the ABBA locking issue with runtime PM
 subcalls
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250326-cross-lock-dep-v1-10-3199e49e8652@bootlin.com>
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
X-GND-Cause: gggruggvucftvghtrhhoucdtuddrgeefvddrtddtgdduieeivdehucetufdoteggodetrfdotffvucfrrhhofhhilhgvmecuifetpfffkfdpucggtfgfnhhsuhgsshgtrhhisggvnecuuegrihhlohhuthemuceftddunecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenucfjughrpefhfffugggtgffkfhgjvfevofesthejredtredtjeenucfhrhhomhepofhiqhhuvghlucftrgihnhgrlhcuoehmihhquhgvlhdrrhgrhihnrghlsegsohhothhlihhnrdgtohhmqeenucggtffrrghtthgvrhhnpeelgfehvdduieefieeikeffgffggfdttdeugeffieetheeuleelfeehffdtffetveenucfkphepledtrdekledrudeifedruddvjeenucevlhhushhtvghrufhiiigvpeeknecurfgrrhgrmhepihhnvghtpeeltddrkeelrdduieefrdduvdejpdhhvghloheplgduledvrdduieekrdegvddrgeeingdpmhgrihhlfhhrohhmpehmihhquhgvlhdrrhgrhihnrghlsegsohhothhlihhnrdgtohhmpdhnsggprhgtphhtthhopedvkedprhgtphhtthhopehmrghrvgigseguvghngidruggvpdhrtghpthhtoheplhhinhhugidqihhmgiesnhigphdrtghomhdprhgtphhtthhopehlihhnuhigqdgtlhhksehvghgvrhdrkhgvrhhnvghlrdhorhhgpdhrtghpthhtohepihgrnhdrrhgrhiesghgvhhgvrghlthhhtggrrhgvrdgtohhmpdhrtghpthhtohepmhhtuhhrqhhuvghtthgvsegsrgihlhhisghrvgdrtghomhdpr
 hgtphhtthhopehssghohigusehkvghrnhgvlhdrohhrghdprhgtphhtthhopehkhhhilhhmrghnsehkvghrnhgvlhdrohhrghdprhgtphhtthhopehthhhomhgrshdrphgvthgriiiiohhnihessghoohhtlhhinhdrtghomh
X-GND-Sasl: miquel.raynal@bootlin.com

The clock subsystem is calling runtime PM callbacks after having
acquired its own lock, which is in general problematic, especially
because when PM callbacks enter the power domain subsystem, we have the
following scenario:
mutex_lock(prepare_lock)
mutex_lock(genpd_lock)
But on the other side, devices may enable power domains, which
themselves might require clocks, forcing the following path:
mutex_lock(genpd_lock)
mutex_lock(prepare_lock)

The clk core has been modified in order to avoid the need for "late"
runtime PM calls (ie. inside the clk prepare_lock), so what remains to
be done is to simply remove these inner runtime calls.

Signed-off-by: Miquel Raynal <miquel.raynal@bootlin.com>
---
 drivers/clk/clk.c | 31 +++++--------------------------
 1 file changed, 5 insertions(+), 26 deletions(-)

diff --git a/drivers/clk/clk.c b/drivers/clk/clk.c
index 26af3a134fa7b9d7f4a77ff473df7e79fd465789..652551860201f2d4ed606c55079dc4fb655d9fa0 100644
--- a/drivers/clk/clk.c
+++ b/drivers/clk/clk.c
@@ -1961,10 +1961,9 @@ static unsigned long clk_recalc(struct clk_core *core,
 {
 	unsigned long rate = parent_rate;
 
-	if (core->ops->recalc_rate && !clk_pm_runtime_get(core)) {
+	if (core->ops->recalc_rate)
 		rate = core->ops->recalc_rate(core->hw, parent_rate);
-		clk_pm_runtime_put(core);
-	}
+
 	return rate;
 }
 
@@ -2458,9 +2457,6 @@ static void clk_change_rate(struct clk_core *core)
 		best_parent_rate = core->parent->rate;
 	}
 
-	if (clk_pm_runtime_get(core))
-		return;
-
 	if (core->flags & CLK_SET_RATE_UNGATE) {
 		clk_core_prepare(core);
 		clk_core_enable_lock(core);
@@ -2523,8 +2519,6 @@ static void clk_change_rate(struct clk_core *core)
 	/* handle the new child who might not be in core->children yet */
 	if (core->new_child)
 		clk_change_rate(core->new_child);
-
-	clk_pm_runtime_put(core);
 }
 
 static unsigned long clk_core_req_round_rate_nolock(struct clk_core *core,
@@ -2562,7 +2556,6 @@ static int clk_core_set_rate_nolock(struct clk_core *core,
 {
 	struct clk_core *top, *fail_clk;
 	unsigned long rate;
-	int ret;
 
 	if (!core)
 		return 0;
@@ -2582,28 +2575,21 @@ static int clk_core_set_rate_nolock(struct clk_core *core,
 	if (!top)
 		return -EINVAL;
 
-	ret = clk_pm_runtime_get(core);
-	if (ret)
-		return ret;
-
 	/* notify that we are about to change rates */
 	fail_clk = clk_propagate_rate_change(top, PRE_RATE_CHANGE);
 	if (fail_clk) {
 		pr_debug("%s: failed to set %s rate\n", __func__,
 				fail_clk->name);
 		clk_propagate_rate_change(top, ABORT_RATE_CHANGE);
-		ret = -EBUSY;
-		goto err;
+		return -EBUSY;
 	}
 
 	/* change the rates */
 	clk_change_rate(top);
 
 	core->req_rate = req_rate;
-err:
-	clk_pm_runtime_put(core);
 
-	return ret;
+	return 0;
 }
 
 /**
@@ -2953,16 +2939,12 @@ static int clk_core_set_parent_nolock(struct clk_core *core,
 		p_rate = parent->rate;
 	}
 
-	ret = clk_pm_runtime_get(core);
-	if (ret)
-		return ret;
-
 	/* propagate PRE_RATE_CHANGE notifications */
 	ret = __clk_speculate_rates(core, p_rate);
 
 	/* abort if a driver objects */
 	if (ret & NOTIFY_STOP_MASK)
-		goto runtime_put;
+		return ret;
 
 	/* do the re-parent */
 	ret = __clk_set_parent(core, parent, p_index);
@@ -2975,9 +2957,6 @@ static int clk_core_set_parent_nolock(struct clk_core *core,
 		__clk_recalc_accuracies(core);
 	}
 
-runtime_put:
-	clk_pm_runtime_put(core);
-
 	return ret;
 }
 

-- 
2.48.1


