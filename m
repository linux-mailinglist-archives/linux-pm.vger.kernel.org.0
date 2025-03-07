Return-Path: <linux-pm+bounces-23623-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 17DA5A56678
	for <lists+linux-pm@lfdr.de>; Fri,  7 Mar 2025 12:19:44 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 0662C3A7A90
	for <lists+linux-pm@lfdr.de>; Fri,  7 Mar 2025 11:19:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id ADE3F217723;
	Fri,  7 Mar 2025 11:19:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b="b0lbPgPy"
X-Original-To: linux-pm@vger.kernel.org
Received: from relay4-d.mail.gandi.net (relay4-d.mail.gandi.net [217.70.183.196])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 38731216E30;
	Fri,  7 Mar 2025 11:19:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.70.183.196
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741346370; cv=none; b=qDEoUPUDOB8RWbWLMLfpjSTelDaixIgAI2WZkWsCTd2wk2Ti88YDzjRjkGS3ZcsUh7yrJQqZc9fmSM0JPQPGVzq09zZUGEldVolSyIUQzkhh88jBg5zgI2TAiNLso+KLc4z/Zn3kV7scJfKNUcqTp4UxK/MSx3hMlfB4ogyNcpM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741346370; c=relaxed/simple;
	bh=DAZPx/13hLlq8oALEQbVKG0NIYN0xuUdaa9yQ31ilDo=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=kUVE7NY8dZ/FUjNi4QFjFXfzJQLlTWLfeWEvJM2NdfIgQPnDaAvQYlZDHHJWX/tD535Xr+pI/aV0L7/y0Xq1hQEpLNPQXgMAp6prgwDo/G5E9TeG7c0cvQ76gAEe44dlwKpvzK4EoXyd90NwkaI3eNIZFcn/1I2pt0yhkfAIQ/8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com; spf=pass smtp.mailfrom=bootlin.com; dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b=b0lbPgPy; arc=none smtp.client-ip=217.70.183.196
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bootlin.com
Received: by mail.gandi.net (Postfix) with ESMTPSA id 8E02043349;
	Fri,  7 Mar 2025 11:19:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=gm1;
	t=1741346366;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=8x3lei9vrmlsjP6V208iSvZSdEC6uVaHCGxHyg5du2E=;
	b=b0lbPgPyRiJ+EvgogRoHF1Q5o5I5WC7K+u5fRx8RJ8uwY3NhIuz14L4MdGQ73lrWY6gTAY
	wZUscZsBJqqiahtbYbFQoZXQyP45VZBQUN9WXdlYp8U0kFqMCYg8tWTln/Pv0YTV9nTolF
	AjGrB4KHqa6ncbZ5xpJcO4pnGYK+pXIAAy+lsM3nUSuz6YWqVHdXrBJfq5qaXGCVEtiJgc
	zsywzJYNFYF3ERtxRYLIdVevEMiajHkGUaXPoUP65nY+wuQWim5SEjAZZZl/E8XjGOf7Eh
	4lOK5CuEmfEY+LDGJcGaUqdrK6v/+hVcadHBg93lYRH4R3wyh3Oky1v1cs29sw==
From: Luca Ceresoli <luca.ceresoli@bootlin.com>
Date: Fri, 07 Mar 2025 12:19:07 +0100
Subject: [PATCH 1/2] thermal: bcm2835: use %pC instead of %pCn
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250307-vsprintf-pcn-v1-1-df0b2ccf610f@bootlin.com>
References: <20250307-vsprintf-pcn-v1-0-df0b2ccf610f@bootlin.com>
In-Reply-To: <20250307-vsprintf-pcn-v1-0-df0b2ccf610f@bootlin.com>
To: "Rafael J. Wysocki" <rafael@kernel.org>, 
 Daniel Lezcano <daniel.lezcano@linaro.org>, Zhang Rui <rui.zhang@intel.com>, 
 Lukasz Luba <lukasz.luba@arm.com>, 
 Florian Fainelli <florian.fainelli@broadcom.com>, 
 Ray Jui <rjui@broadcom.com>, Scott Branden <sbranden@broadcom.com>, 
 Broadcom internal kernel review list <bcm-kernel-feedback-list@broadcom.com>, 
 Petr Mladek <pmladek@suse.com>, Steven Rostedt <rostedt@goodmis.org>, 
 Andy Shevchenko <andriy.shevchenko@linux.intel.com>, 
 Rasmus Villemoes <linux@rasmusvillemoes.dk>, 
 Sergey Senozhatsky <senozhatsky@chromium.org>, 
 Jonathan Corbet <corbet@lwn.net>, Andrew Morton <akpm@linux-foundation.org>
Cc: Thomas Petazzoni <thomas.petazzoni@bootlin.com>, 
 Michael Turquette <mturquette@baylibre.com>, 
 Stephen Boyd <sboyd@kernel.org>, 
 Geert Uytterhoeven <geert+renesas@glider.be>, Liu Ying <victor.liu@nxp.com>, 
 linux-clk@vger.kernel.org, linux-pm@vger.kernel.org, 
 linux-rpi-kernel@lists.infradead.org, linux-arm-kernel@lists.infradead.org, 
 linux-kernel@vger.kernel.org, linux-doc@vger.kernel.org, 
 Luca Ceresoli <luca.ceresoli@bootlin.com>
X-Mailer: b4 0.14.2
X-GND-State: clean
X-GND-Score: -100
X-GND-Cause: gggruggvucftvghtrhhoucdtuddrgeefvddrtddtgdduuddthedvucetufdoteggodetrfdotffvucfrrhhofhhilhgvmecuifetpfffkfdpucggtfgfnhhsuhgsshgtrhhisggvnecuuegrihhlohhuthemuceftddunecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenucfjughrpefhfffugggtgffkfhgjvfevofesthejredtredtjeenucfhrhhomhepnfhutggrucevvghrvghsohhlihcuoehluhgtrgdrtggvrhgvshholhhisegsohhothhlihhnrdgtohhmqeenucggtffrrghtthgvrhhnpeeiieeuvdfftefgueduleehueetgffgjeeitedtteetkeeuueeuueekveevvdeuveenucfkphepvdgrtddvmeeijedtmedvtddvtdemvggrtddumegsvgegudemleehvgejmeefgeefmeeludefvgenucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepihhnvghtpedvrgdtvdemieejtdemvddtvddtmegvrgdtudemsggvgedumeelhegvjeemfeegfeemledufegvpdhhvghloheplgduledvrdduieekrddujeekrdduudekngdpmhgrihhlfhhrohhmpehluhgtrgdrtggvrhgvshholhhisegsohhothhlihhnrdgtohhmpdhnsggprhgtphhtthhopedvjedprhgtphhtthhopegrnhgurhhihidrshhhvghvtghhvghnkhhosehlihhnuhigrdhinhhtvghlrdgtohhmpdhrtghpthhtohepshgsrhgrnhguvghnsegsrhhorggutghomhdrtghomhdprhgtphhtthhopehlihhnuhigqdgtlhhksehvghgvrhdrk
 hgvrhhnvghlrdhorhhgpdhrtghpthhtoheptghorhgsvghtsehlfihnrdhnvghtpdhrtghpthhtoheplhhinhhugidqrghrmhdqkhgvrhhnvghlsehlihhsthhsrdhinhhfrhgruggvrggurdhorhhgpdhrtghpthhtohepfhhlohhrihgrnhdrfhgrihhnvghllhhisegsrhhorggutghomhdrtghomhdprhgtphhtthhopehsvghnohiihhgrthhskhihsegthhhrohhmihhumhdrohhrghdprhgtphhtthhopehpmhhlrgguvghksehsuhhsvgdrtghomh
X-GND-Sasl: luca.ceresoli@bootlin.com

The %pC and %pCn printk format specifiers produce the exact same string. In
preparation for removing %pCn, use %pC.

Signed-off-by: Luca Ceresoli <luca.ceresoli@bootlin.com>
---
 drivers/thermal/broadcom/bcm2835_thermal.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/thermal/broadcom/bcm2835_thermal.c b/drivers/thermal/broadcom/bcm2835_thermal.c
index 7fbba2233c4c12e14090832a62784e1500c0ab79..685a5aee5e0dfb113638313a9086721beae09db3 100644
--- a/drivers/thermal/broadcom/bcm2835_thermal.c
+++ b/drivers/thermal/broadcom/bcm2835_thermal.c
@@ -192,7 +192,7 @@ static int bcm2835_thermal_probe(struct platform_device *pdev)
 	rate = clk_get_rate(data->clk);
 	if ((rate < 1920000) || (rate > 5000000))
 		dev_warn(dev,
-			 "Clock %pCn running at %lu Hz is outside of the recommended range: 1.92 to 5MHz\n",
+			 "Clock %pC running at %lu Hz is outside of the recommended range: 1.92 to 5MHz\n",
 			 data->clk, rate);
 
 	/* register of thermal sensor and get info from DT */

-- 
2.48.1


