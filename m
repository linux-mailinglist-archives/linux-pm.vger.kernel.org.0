Return-Path: <linux-pm+bounces-24542-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 29629A71E57
	for <lists+linux-pm@lfdr.de>; Wed, 26 Mar 2025 19:27:54 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 4D0191897573
	for <lists+linux-pm@lfdr.de>; Wed, 26 Mar 2025 18:27:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C06C7258CF3;
	Wed, 26 Mar 2025 18:26:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b="H6VnLgNQ"
X-Original-To: linux-pm@vger.kernel.org
Received: from relay8-d.mail.gandi.net (relay8-d.mail.gandi.net [217.70.183.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8BA6324A077;
	Wed, 26 Mar 2025 18:26:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.70.183.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1743013597; cv=none; b=DHt6COH8YGjsTri8CBiuW08D5svb0jQKOcvlBf9V5Q0DN5WNrHqlbly6F9zBmYpM5OW7OQKqo9v1xeRJMRZTDQas91xupcuVNA9MtWrDqj+J+UKKtJ4nJo/e7zg9xgICee5T6fkrOWy8wQAlTYKjKruaq1vE246Sn/D+S6zD8ik=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1743013597; c=relaxed/simple;
	bh=fQRi4Amjuf0y/liuUYDVS5GF+DVY1+r5MM+krVbpn0I=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=EEU/3voNozlEchBsgKwGxnFiKEi+0hS4+GDUtl0GxXCxB5Tbrx/uJquqfiWlvLyl44NGCQo92GHXnczY7p/CGelWU3nrR+VmZbsCPf7PPk4V1aAJQe2Xwag1eSPtPp/y4G9QjYpw22fTTE/IKM5LRXWRanYSV/2SGetxCSUD8jU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com; spf=pass smtp.mailfrom=bootlin.com; dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b=H6VnLgNQ; arc=none smtp.client-ip=217.70.183.201
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bootlin.com
Received: by mail.gandi.net (Postfix) with ESMTPSA id 9BB2044443;
	Wed, 26 Mar 2025 18:26:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=gm1;
	t=1743013593;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=OcGvc6n0vOnsaoJ5OZPe24saE0nLgPTFQXzjqD1fHgc=;
	b=H6VnLgNQqzGqJEWF3O579ImX06LL+m/5N6zm4+WilCp6/geOFS71VNrmP4lbZWqEwy23Af
	reX53yM5P82UMuSWiUmgGBMbF6bGo/FXYtx3VwzJ8MMFuGoC/7xwz9fdK7aeASosz7yD+b
	dQesEqyIqV3bb0ThryfRcnROgcQDZNLbNJiNVgPyycZjiY1yI/D1e6RqP4SNQtW5WounyG
	VBJbcMxA6OyM6lyseEYEEIBpvUYYj39koVo3nBT3bkUzZ+TjnCueDBROIkSQJDPVwe4Sdh
	v2/SN1SqjZgT9kxUv7eHbUKsY2/cu+BUpqGxNKofO5E1AVDXcw7pcG71wJ/Lsw==
From: Miquel Raynal <miquel.raynal@bootlin.com>
Date: Wed, 26 Mar 2025 19:26:21 +0100
Subject: [PATCH RFC 06/10] clk: Move runtime PM calls out of the
 prepare_lock in clk_prepare()
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250326-cross-lock-dep-v1-6-3199e49e8652@bootlin.com>
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

The prepare routine shall preferably call the runtime PM functions
before acquiring the prepare lock. In practice the prepare helper
requires the current clock and all its parents to be runtime
resumed.

There is no need to perform individual calls as we get inner and inner
in recursive calls (ie. following the "clock parents") because, as of
today, runtime PM works by already resuming automatically all the
suppliers which in this case already include the clock parents.

Hence, doing a single runtime PM call at the beginning of the function
is enough. One side effect though is that we now need to check for the
validity of core clk pointers in the runtime PM clk helpers.

Signed-off-by: Miquel Raynal <miquel.raynal@bootlin.com>
---
 drivers/clk/clk.c | 23 +++++++++++++----------
 1 file changed, 13 insertions(+), 10 deletions(-)

diff --git a/drivers/clk/clk.c b/drivers/clk/clk.c
index b6decfaf8aa6bd50c2173d19f1ece8f08a95afd8..95f53bc427d8980287bfe668d1c993023e0e078b 100644
--- a/drivers/clk/clk.c
+++ b/drivers/clk/clk.c
@@ -113,7 +113,7 @@ struct clk {
 /***           runtime pm          ***/
 static int clk_pm_runtime_get(struct clk_core *core)
 {
-	if (!core->rpm_enabled)
+	if (!core || !core->rpm_enabled)
 		return 0;
 
 	return pm_runtime_resume_and_get(core->dev);
@@ -135,7 +135,7 @@ static int clk_pm_runtime_get_if_active(struct clk_core *core)
 
 static void clk_pm_runtime_put(struct clk_core *core)
 {
-	if (!core->rpm_enabled)
+	if (!core || !core->rpm_enabled)
 		return;
 
 	pm_runtime_put_sync(core->dev);
@@ -1081,7 +1081,6 @@ static void clk_core_unprepare(struct clk_core *core)
 
 	trace_clk_unprepare_complete(core);
 	clk_core_unprepare(core->parent);
-	clk_pm_runtime_put(core);
 }
 
 static void clk_core_unprepare_lock(struct clk_core *core)
@@ -1089,6 +1088,8 @@ static void clk_core_unprepare_lock(struct clk_core *core)
 	clk_prepare_lock();
 	clk_core_unprepare(core);
 	clk_prepare_unlock();
+
+	clk_pm_runtime_put(core);
 }
 
 /**
@@ -1121,13 +1122,9 @@ static int clk_core_prepare(struct clk_core *core)
 		return 0;
 
 	if (core->prepare_count == 0) {
-		ret = clk_pm_runtime_get(core);
-		if (ret)
-			return ret;
-
 		ret = clk_core_prepare(core->parent);
 		if (ret)
-			goto runtime_put;
+			return ret;
 
 		trace_clk_prepare(core);
 
@@ -1155,8 +1152,7 @@ static int clk_core_prepare(struct clk_core *core)
 	return 0;
 unprepare:
 	clk_core_unprepare(core->parent);
-runtime_put:
-	clk_pm_runtime_put(core);
+
 	return ret;
 }
 
@@ -1164,10 +1160,17 @@ static int clk_core_prepare_lock(struct clk_core *core)
 {
 	int ret;
 
+	ret = clk_pm_runtime_get(core);
+	if (ret)
+		return ret;
+
 	clk_prepare_lock();
 	ret = clk_core_prepare(core);
 	clk_prepare_unlock();
 
+	if (ret)
+		clk_pm_runtime_put(core);
+
 	return ret;
 }
 

-- 
2.48.1


