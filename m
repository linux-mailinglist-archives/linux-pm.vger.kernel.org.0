Return-Path: <linux-pm+bounces-24544-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 29335A71E65
	for <lists+linux-pm@lfdr.de>; Wed, 26 Mar 2025 19:29:48 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id B3FCD3B978F
	for <lists+linux-pm@lfdr.de>; Wed, 26 Mar 2025 18:28:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E266925BACF;
	Wed, 26 Mar 2025 18:26:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b="MIwa1tjw"
X-Original-To: linux-pm@vger.kernel.org
Received: from relay8-d.mail.gandi.net (relay8-d.mail.gandi.net [217.70.183.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CD08F258CFA;
	Wed, 26 Mar 2025 18:26:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.70.183.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1743013599; cv=none; b=hrn5Kbf31Z0NKfnqIht6Ny5oaTfRZvjn1w0JDr+OAMaP5iID9BLiVnffXd+VpQFVE2aUPhZC+MGB1c6CMd6oq+2gaPzNqEb6cPxRGM56dkBCIJwHv8Rg5wgSVOzGHA7i0qBGis4QWffnKAPsfMzjH0Y/DecqyFGF2sM8SK9hRA0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1743013599; c=relaxed/simple;
	bh=gJfK6+B5JQj/94XazxErSDyeIkb7T600MeCpaeGZceg=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=tvkxpQKbCWB102oMsAt1LmcU23rcy43mZpdZgkePhvKHvIeS80Gyk130cK0rHEjdnX6yuM8GFpBd4a6ZFhQA6rO8VOvb/Gv1dNysLxqgctMDwvooGKU4yMd8ySqlqXlE6u8ZQb7MDdq6fNEK+s21jFhQ3Z25o15be/O12D2R304=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com; spf=pass smtp.mailfrom=bootlin.com; dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b=MIwa1tjw; arc=none smtp.client-ip=217.70.183.201
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bootlin.com
Received: by mail.gandi.net (Postfix) with ESMTPSA id 30DCD44440;
	Wed, 26 Mar 2025 18:26:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=gm1;
	t=1743013596;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=YQwpVU/XbRJq6paA0C/EVBzKGAJNY3Fgxupz9l/uNkA=;
	b=MIwa1tjwQLR5HbQmg2fPVW7fJahFLAqOE8nuTFOWA7gEfxYtBRIT03BoKDRgOUeVnfUbyC
	PKepVBMVy0mJzsfzGg8TtiI/9MG3ksPO8skQd5ArSsucxQ2D/QA1Qxm5hMqem3332l0dfF
	BYLhZj9Qz5C2upuN1nHxqeFXWZ4eH246Ph8bH4ifj932eLz3HNhmTommXMCSglfP4zPb4N
	tuvDkgimwP4Nskio+9s2VSb03zXE/M1gxiQqdni2fRSCLKsJkvRqwkyGiyTvFiSO7CGXMQ
	oR5UKi1NxSBzvhmDMHDDFLQYa5ARrTDc5+OhN7BrCKu5QiB7+TkgWFrjoJiBjA==
From: Miquel Raynal <miquel.raynal@bootlin.com>
Date: Wed, 26 Mar 2025 19:26:23 +0100
Subject: [PATCH RFC 08/10] clk: Move runtime PM calls out of the
 prepare_lock in clk_unregister()
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250326-cross-lock-dep-v1-8-3199e49e8652@bootlin.com>
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

The clk_unregister() routine calls clk_core_set_parent_nolock() which
can runtime resume basically any clock randomly in the system after
having acquired the main clk lock. In this case the easier approach to
avoid failures is to make sure we wake up all runtime PM enabled clocks
in the system before acquiring the lock. We are not in a hot path
anyway.

Signed-off-by: Miquel Raynal <miquel.raynal@bootlin.com>
---
 drivers/clk/clk.c | 5 +++++
 1 file changed, 5 insertions(+)

diff --git a/drivers/clk/clk.c b/drivers/clk/clk.c
index 4c2f2d2b7735dfbe323fec4e0d331302534bc849..339ebfa8cca729ffb84127e01a21f741bc270cb3 100644
--- a/drivers/clk/clk.c
+++ b/drivers/clk/clk.c
@@ -4574,6 +4574,9 @@ void clk_unregister(struct clk *clk)
 
 	clk_debug_unregister(clk->core);
 
+	if (clk_pm_runtime_get_all())
+		return;
+
 	clk_prepare_lock();
 
 	ops = clk->core->ops;
@@ -4617,6 +4620,8 @@ void clk_unregister(struct clk *clk)
 					__func__, clk->core->name);
 	clk_prepare_unlock();
 
+	clk_pm_runtime_put_all();
+
 	kref_put(&clk->core->ref, __clk_release);
 	free_clk(clk);
 }

-- 
2.48.1


