Return-Path: <linux-pm+bounces-24538-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id B6105A71E4D
	for <lists+linux-pm@lfdr.de>; Wed, 26 Mar 2025 19:26:51 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 4E185171920
	for <lists+linux-pm@lfdr.de>; Wed, 26 Mar 2025 18:26:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C5E85253B52;
	Wed, 26 Mar 2025 18:26:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b="QcRFWQ6W"
X-Original-To: linux-pm@vger.kernel.org
Received: from relay8-d.mail.gandi.net (relay8-d.mail.gandi.net [217.70.183.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8E47F2459CB;
	Wed, 26 Mar 2025 18:26:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.70.183.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1743013592; cv=none; b=SqR6oAS/PoyIIeP3MiPhFkXrtGayg5pvv63DSmTHKdEpMW1u5pEKsAfAbiVinPbLGOxVhr3MivJ0IWVjW94eKg8tm7+6zd316RkIzsY2IQci16/Odkm77Z3HbT+KrAmCXbuc2nDfrXQKwAvJmJjU7E8mBqqnwqDu2eau5Rx4C3s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1743013592; c=relaxed/simple;
	bh=pUdbIzTSWu9FizDsOr0A4bulFwTYwtPu12MdLYGg1c0=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=Tp+h98jLuVKdLFgkqOoFumidc5ZQPS1oHgaCJWrg8IMqrb2Sojoytiq6z0f4O5oUc1AfRlkzq1NMH94VqwYGKLFNz6BD7xuBShRmXHb0NjPJOGaiGnbLasoYknly91YmSRbNfBP8ExNsdL+/FzdQlfbzv5fv0eCFZOe/6OU4guU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com; spf=pass smtp.mailfrom=bootlin.com; dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b=QcRFWQ6W; arc=none smtp.client-ip=217.70.183.201
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bootlin.com
Received: by mail.gandi.net (Postfix) with ESMTPSA id A16714441C;
	Wed, 26 Mar 2025 18:26:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=gm1;
	t=1743013588;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=2Cfz0a/5S6u6nHzcv1rW0zQzLUAGoNaXxXWFyhaaNgQ=;
	b=QcRFWQ6WLTgdNy2fray1YCL5Mh7OyoyMSVnWPJZf5cQxDrIdJvzc1f5CHnaHOdjuU9A3If
	ghl6wjWjwdVhm1wJ8nyGsUnDFHBcNgIS0PeZxyDR22sJ/4mxubnVq6I/zZmboXPAiz8Efp
	rRjdK2myTh/SJ9CKwxa6/WoCv35itqwrStihuxn8FfV1mLskPHQtJN1h9UF/RYo1b6dAz2
	nx42HfGGrlCo+h9L2mZLmaF5pbdN4jfT30fnQv9aQI3ymjJzFSotvh/x0VrFbxFeH3i6EN
	vstciFxNHiwjApJDO7Z7lFgU0tP3RX8565Cyzc6qgORcN+JGyiA/jEA8dSrVRQ==
From: Miquel Raynal <miquel.raynal@bootlin.com>
Date: Wed, 26 Mar 2025 19:26:17 +0100
Subject: [PATCH RFC 02/10] clk: Improve comments with usual punctuation
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250326-cross-lock-dep-v1-2-3199e49e8652@bootlin.com>
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
X-GND-Cause: gggruggvucftvghtrhhoucdtuddrgeefvddrtddtgdduieeivdehucetufdoteggodetrfdotffvucfrrhhofhhilhgvmecuifetpfffkfdpucggtfgfnhhsuhgsshgtrhhisggvnecuuegrihhlohhuthemuceftddunecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenucfjughrpefhfffugggtgffkfhgjvfevofesthejredtredtjeenucfhrhhomhepofhiqhhuvghlucftrgihnhgrlhcuoehmihhquhgvlhdrrhgrhihnrghlsegsohhothhlihhnrdgtohhmqeenucggtffrrghtthgvrhhnpeelgfehvdduieefieeikeffgffggfdttdeugeffieetheeuleelfeehffdtffetveenucfkphepledtrdekledrudeifedruddvjeenucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepihhnvghtpeeltddrkeelrdduieefrdduvdejpdhhvghloheplgduledvrdduieekrdegvddrgeeingdpmhgrihhlfhhrohhmpehmihhquhgvlhdrrhgrhihnrghlsegsohhothhlihhnrdgtohhmpdhnsggprhgtphhtthhopedvkedprhgtphhtthhopehmrghrvgigseguvghngidruggvpdhrtghpthhtoheplhhinhhugidqihhmgiesnhigphdrtghomhdprhgtphhtthhopehlihhnuhigqdgtlhhksehvghgvrhdrkhgvrhhnvghlrdhorhhgpdhrtghpthhtohepihgrnhdrrhgrhiesghgvhhgvrghlthhhtggrrhgvrdgtohhmpdhrtghpthhtohepmhhtuhhrqhhuvghtthgvsegsrgihlhhisghrvgdrtghomhdpr
 hgtphhtthhopehssghohigusehkvghrnhgvlhdrohhrghdprhgtphhtthhopehkhhhilhhmrghnsehkvghrnhgvlhdrohhrghdprhgtphhtthhopehthhhomhgrshdrphgvthgriiiiohhnihessghoohhtlhhinhdrtghomh
X-GND-Sasl: miquel.raynal@bootlin.com

These two-line comments did not meant anything to me until I figured out
they were two separated sentences. Clarify these comments.

Signed-off-by: Miquel Raynal <miquel.raynal@bootlin.com>
---
 drivers/clk/clk.c | 8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

diff --git a/drivers/clk/clk.c b/drivers/clk/clk.c
index cf7720b9172ff223d86227aad144e15375ddfd86..7df9965bcbdffd641e6dbf5bff3d3b20079a3af3 100644
--- a/drivers/clk/clk.c
+++ b/drivers/clk/clk.c
@@ -289,8 +289,8 @@ static bool clk_core_is_prepared(struct clk_core *core)
 	bool ret = false;
 
 	/*
-	 * .is_prepared is optional for clocks that can prepare
-	 * fall back to software usage counter if it is missing
+	 * .is_prepared is optional for clocks that can prepare.
+	 * Fall back to software usage counter if it is missing.
 	 */
 	if (!core->ops->is_prepared)
 		return core->prepare_count;
@@ -308,8 +308,8 @@ static bool clk_core_is_enabled(struct clk_core *core)
 	bool ret = false;
 
 	/*
-	 * .is_enabled is only mandatory for clocks that gate
-	 * fall back to software usage counter if .is_enabled is missing
+	 * .is_enabled is only mandatory for clocks that gate.
+	 * Fall back to software usage counter if .is_enabled is missing
 	 */
 	if (!core->ops->is_enabled)
 		return core->enable_count;

-- 
2.48.1


