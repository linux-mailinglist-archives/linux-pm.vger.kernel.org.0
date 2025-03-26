Return-Path: <linux-pm+bounces-24545-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 9BCBCA71E61
	for <lists+linux-pm@lfdr.de>; Wed, 26 Mar 2025 19:28:41 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 99E4E7A1AF9
	for <lists+linux-pm@lfdr.de>; Wed, 26 Mar 2025 18:27:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D582425DD12;
	Wed, 26 Mar 2025 18:26:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b="DHocBZj4"
X-Original-To: linux-pm@vger.kernel.org
Received: from relay8-d.mail.gandi.net (relay8-d.mail.gandi.net [217.70.183.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9510425A647;
	Wed, 26 Mar 2025 18:26:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.70.183.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1743013601; cv=none; b=B4HldJYJTKc2zqR6o0lUn4W6OqVB/spXdo+b1oMNf3HIKW2B8Mba61h2UsZMd/Z5IVf3mnPP019LIEw/V5CL5txUZmNNXxXq9a/lrORpMe+r7uFfmFcUrgtyre6UfKKnedopfQj0vopoLGL9GyPVEsUowY30frPmhE2hZBzh3kw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1743013601; c=relaxed/simple;
	bh=p/SQu/txIkaclb7CmktdQaCDuOWlbdrrhqQjCNeoSGg=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=RRvejFURQdc9IQ23xgn4sLLPTm5tshymyxWpVr/uSmWs5q7ZTVUfq9gPGf+jMSN9t4OOsfahPfHGZBgeje9z3AzPsO+BNyybnYd2BIz8Uv/ARXfC0x0pLk0XNgT3GGQiKkOT07aWZt7yGR2I7H2FZAdDz8/aRkLToX66nffRtXo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com; spf=pass smtp.mailfrom=bootlin.com; dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b=DHocBZj4; arc=none smtp.client-ip=217.70.183.201
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bootlin.com
Received: by mail.gandi.net (Postfix) with ESMTPSA id 7093944446;
	Wed, 26 Mar 2025 18:26:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=gm1;
	t=1743013597;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=R3+Mu9M77+PpoOK75hoSqIuv6VHqsXdDyRQbbbzxiv0=;
	b=DHocBZj4pX8S9PdrRo5/CUny+pFhQH9TSirK/9Hz8o5d4FsIwaZS2PrrSFMObOwFxtSWTP
	NemWy6D+8pBsIyLoqXW06FOvNoyLdgrSwYYXT4EZ+CrnlixAd2L1rUtrGvuMHa7aKIuIpE
	ArH1PPcdG7TPbWgE/syqXZM9vE1A0uBgT7R9kfZqPBSxNN2t33IspnrE6k8bdXCysh3F4I
	4Pz2b57XjaaatcKIjtRccjom0k6DkN2zr6hjYJuBFC0iH2UWiWrbtiNEzjHaNI2MNY/Wl7
	xbv22sE35t/xAoMXfAkKGCF8uf42Sxcor9XA+Owt3WGOoQKttzWLJ6KynCYbLA==
From: Miquel Raynal <miquel.raynal@bootlin.com>
Date: Wed, 26 Mar 2025 19:26:24 +0100
Subject: [PATCH RFC 09/10] clk: Make sure clock parents and children are
 resumed when necessary
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250326-cross-lock-dep-v1-9-3199e49e8652@bootlin.com>
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

Any pm_runtime_get() call will both wake up the core clock as well as
its parents. But there are some cases which also require resuming the
children clocks. One way to do that is to use the new
pm_runtime_get_consumers() helper.

It's been identified that the following situation may require resuming
the children:
- getting the rate
- setting the rate
- changing the parent (especially since it may produce rate changes)
- putting the clock, which may involve reparenting as well

In order to fix the ABBA locking situation between clock and power
domains, let's disimburse these two locks by resuming the children
outside of the prepare_lock in one function call by using this new
helper.

Signed-off-by: Miquel Raynal <miquel.raynal@bootlin.com>
---
 drivers/clk/clk.c | 77 +++++++++++++++++++++++++++++++++++++++++++++++++++++++
 1 file changed, 77 insertions(+)

diff --git a/drivers/clk/clk.c b/drivers/clk/clk.c
index 339ebfa8cca729ffb84127e01a21f741bc270cb3..26af3a134fa7b9d7f4a77ff473df7e79fd465789 100644
--- a/drivers/clk/clk.c
+++ b/drivers/clk/clk.c
@@ -119,6 +119,20 @@ static int clk_pm_runtime_get(struct clk_core *core)
 	return pm_runtime_resume_and_get(core->dev);
 }
 
+static int clk_pm_runtime_get_and_consumers(struct clk_core *core)
+{
+	int ret;
+
+	if (!core || !core->rpm_enabled)
+		return 0;
+
+	ret = pm_runtime_resume_and_get(core->dev);
+	if (!ret)
+		pm_runtime_get_consumers(core->dev);
+
+	return ret;
+}
+
 static int clk_pm_runtime_get_if_active(struct clk_core *core)
 {
 	int ret;
@@ -141,6 +155,16 @@ static void clk_pm_runtime_put(struct clk_core *core)
 	pm_runtime_put_sync(core->dev);
 }
 
+static void clk_pm_runtime_put_and_consumers(struct clk_core *core)
+{
+	if (!core || !core->rpm_enabled)
+		return;
+
+	pm_runtime_put_consumers(core->dev);
+
+	pm_runtime_put_sync(core->dev);
+}
+
 /**
  * clk_pm_runtime_get_all() - Runtime "get" all clk provider devices
  *
@@ -2010,10 +2034,15 @@ unsigned long clk_get_rate(struct clk *clk)
 	if (!clk)
 		return 0;
 
+	if (clk_pm_runtime_get_and_consumers(clk->core))
+		return 0;
+
 	clk_prepare_lock();
 	rate = clk_core_get_rate_recalc(clk->core);
 	clk_prepare_unlock();
 
+	clk_pm_runtime_put_and_consumers(clk->core);
+
 	return rate;
 }
 EXPORT_SYMBOL_GPL(clk_get_rate);
@@ -2605,6 +2634,10 @@ int clk_set_rate(struct clk *clk, unsigned long rate)
 	if (!clk)
 		return 0;
 
+	ret = clk_pm_runtime_get_and_consumers(clk->core);
+	if (ret)
+		return ret;
+
 	/* prevent racing with updates to the clock topology */
 	clk_prepare_lock();
 
@@ -2618,6 +2651,8 @@ int clk_set_rate(struct clk *clk, unsigned long rate)
 
 	clk_prepare_unlock();
 
+	clk_pm_runtime_put_and_consumers(clk->core);
+
 	return ret;
 }
 EXPORT_SYMBOL_GPL(clk_set_rate);
@@ -2648,6 +2683,10 @@ int clk_set_rate_exclusive(struct clk *clk, unsigned long rate)
 	if (!clk)
 		return 0;
 
+	ret = clk_pm_runtime_get_and_consumers(clk->core);
+	if (ret)
+		return ret;
+
 	/* prevent racing with updates to the clock topology */
 	clk_prepare_lock();
 
@@ -2665,6 +2704,8 @@ int clk_set_rate_exclusive(struct clk *clk, unsigned long rate)
 
 	clk_prepare_unlock();
 
+	clk_pm_runtime_put_and_consumers(clk->core);
+
 	return ret;
 }
 EXPORT_SYMBOL_GPL(clk_set_rate_exclusive);
@@ -2755,12 +2796,18 @@ int clk_set_rate_range(struct clk *clk, unsigned long min, unsigned long max)
 	if (!clk)
 		return 0;
 
+	ret = clk_pm_runtime_get_and_consumers(clk->core);
+	if (ret)
+		return ret;
+
 	clk_prepare_lock();
 
 	ret = clk_set_rate_range_nolock(clk, min, max);
 
 	clk_prepare_unlock();
 
+	clk_pm_runtime_put_and_consumers(clk->core);
+
 	return ret;
 }
 EXPORT_SYMBOL_GPL(clk_set_rate_range);
@@ -2964,6 +3011,10 @@ int clk_set_parent(struct clk *clk, struct clk *parent)
 	if (!clk)
 		return 0;
 
+	ret = clk_pm_runtime_get_and_consumers(clk->core);
+	if (ret)
+		return ret;
+
 	clk_prepare_lock();
 
 	if (clk->exclusive_count)
@@ -2977,6 +3028,8 @@ int clk_set_parent(struct clk *clk, struct clk *parent)
 
 	clk_prepare_unlock();
 
+	clk_pm_runtime_put_and_consumers(clk->core);
+
 	return ret;
 }
 EXPORT_SYMBOL_GPL(clk_set_parent);
@@ -3459,10 +3512,16 @@ static int clk_rate_set(void *data, u64 val)
 	struct clk_core *core = data;
 	int ret;
 
+	ret = clk_pm_runtime_get_and_consumers(core);
+	if (ret)
+		return ret;
+
 	clk_prepare_lock();
 	ret = clk_core_set_rate_nolock(core, val);
 	clk_prepare_unlock();
 
+	clk_pm_runtime_put_and_consumers(core);
+
 	return ret;
 }
 
@@ -3518,11 +3577,18 @@ DEFINE_DEBUGFS_ATTRIBUTE(clk_prepare_enable_fops, clk_prepare_enable_get,
 static int clk_rate_get(void *data, u64 *val)
 {
 	struct clk_core *core = data;
+	int ret;
+
+	ret = clk_pm_runtime_get_and_consumers(core);
+	if (ret)
+		return ret;
 
 	clk_prepare_lock();
 	*val = clk_core_get_rate_recalc(core);
 	clk_prepare_unlock();
 
+	clk_pm_runtime_put_and_consumers(core);
+
 	return 0;
 }
 
@@ -3659,12 +3725,18 @@ static ssize_t current_parent_write(struct file *file, const char __user *ubuf,
 	if (!parent)
 		return -ENOENT;
 
+	err = clk_pm_runtime_get_and_consumers(parent);
+	if (err)
+		return err;
+
 	clk_prepare_lock();
 	err = clk_core_set_parent_nolock(core, parent);
 	clk_prepare_unlock();
 	if (err)
 		return err;
 
+	clk_pm_runtime_put_and_consumers(parent);
+
 	return count;
 }
 
@@ -4762,6 +4834,9 @@ void __clk_put(struct clk *clk)
 	if (!clk || WARN_ON_ONCE(IS_ERR(clk)))
 		return;
 
+	if (clk_pm_runtime_get_and_consumers(clk->core))
+		return;
+
 	clk_prepare_lock();
 
 	/*
@@ -4784,6 +4859,8 @@ void __clk_put(struct clk *clk)
 
 	clk_prepare_unlock();
 
+	clk_pm_runtime_put_and_consumers(clk->core);
+
 	owner = clk->core->owner;
 	kref_put(&clk->core->ref, __clk_release);
 	module_put(owner);

-- 
2.48.1


