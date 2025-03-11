Return-Path: <linux-pm+bounces-23829-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 5097AA5BBF3
	for <lists+linux-pm@lfdr.de>; Tue, 11 Mar 2025 10:21:56 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 07BE9188B1E0
	for <lists+linux-pm@lfdr.de>; Tue, 11 Mar 2025 09:22:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3608F22E41D;
	Tue, 11 Mar 2025 09:21:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b="cQx/H3xU"
X-Original-To: linux-pm@vger.kernel.org
Received: from relay5-d.mail.gandi.net (relay5-d.mail.gandi.net [217.70.183.197])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9CB771E32D6;
	Tue, 11 Mar 2025 09:21:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.70.183.197
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741684899; cv=none; b=cYfSr1zE39wW5AVVDX3Ho/kodMGEZ3iSe1dsWDuVKPsaBWoX3kdXTTiixmwlVuINx6LczPFmK10mRDC0jPQghy4NKc8M/zthOWfpZOReWQwLSXJ0ep/S0lc99TgW1qzkZeQDA+D0TVJNAxVAAzvecr8rVyu/P8afiTRF+tqUgfw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741684899; c=relaxed/simple;
	bh=T+TmIRpYbZ8cX2F/ixslx/wKWFdNw3rZ71ReDMpgEPM=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=exVsmKS8Fmd9ul54zDQ0OGy82qRqqFFlLM5JlSkzY3k4Yhr0Fnsyi4FH0D2yuhvYk2lZcI+9AaftNQW9gpjGnOCfZ8oLBasSAq868dF/oFmr2G3S/yNIJgCnls0tcUPSkpgL2O9DTE+XnkW4IVJJ3MiT6Mu0fYUcBaQ/3mK4e8Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com; spf=pass smtp.mailfrom=bootlin.com; dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b=cQx/H3xU; arc=none smtp.client-ip=217.70.183.197
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bootlin.com
Received: by mail.gandi.net (Postfix) with ESMTPSA id 2A5C143304;
	Tue, 11 Mar 2025 09:21:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=gm1;
	t=1741684894;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=U0aeEmyOhZpYdPG0oJnbE0E6tWQjFtoJd00ZFzjUFic=;
	b=cQx/H3xUA/Qs34i12BWbKhsxshB7OpwcT1lgzga31QcvTGJ6TzW/p4z2BFKQ6uRJ/dcs05
	/vekjtV4X+lAMpNzZf6t2ZiLSP11KPgyt0b6OfNKKu82LP8Ub8J39y9GgQ3/YxHhLQ4LfO
	+D81dDCK/3vVc0TGJ1p4fp8LKN3ElENFDPyR7Omqq2BKKOwJwMPVLyLg6PpEenPcyOnlOS
	jDOji+41zBkcljiGcL7TSplXJjxBPB79kLvcWlB/t74v8062cOCL/UwYsIF2Nv1d4nmXmz
	293Kz7oYZzkfERLmUs2d/deLafuQVPdUZ+8JvjsYSo99iK5z/6k43UedHQu7Iw==
From: Luca Ceresoli <luca.ceresoli@bootlin.com>
Date: Tue, 11 Mar 2025 10:21:22 +0100
Subject: [PATCH v2 1/2] thermal: bcm2835: use %pC instead of %pCn
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250311-vsprintf-pcn-v2-1-0af40fc7dee4@bootlin.com>
References: <20250311-vsprintf-pcn-v2-0-0af40fc7dee4@bootlin.com>
In-Reply-To: <20250311-vsprintf-pcn-v2-0-0af40fc7dee4@bootlin.com>
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
 Jonathan Corbet <corbet@lwn.net>, Andrew Morton <akpm@linux-foundation.org>, 
 Alex Shi <alexs@kernel.org>, Yanteng Si <si.yanteng@linux.dev>
Cc: Binbin Zhou <zhoubinbin@loongson.cn>, 
 Thomas Petazzoni <thomas.petazzoni@bootlin.com>, 
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
X-GND-Cause: gggruggvucftvghtrhhoucdtuddrgeefvddrtddtgdduvddukeeiucetufdoteggodetrfdotffvucfrrhhofhhilhgvmecuifetpfffkfdpucggtfgfnhhsuhgsshgtrhhisggvnecuuegrihhlohhuthemuceftddunecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenucfjughrpefhfffugggtgffkfhgjvfevofesthejredtredtjeenucfhrhhomhepnfhutggrucevvghrvghsohhlihcuoehluhgtrgdrtggvrhgvshholhhisegsohhothhlihhnrdgtohhmqeenucggtffrrghtthgvrhhnpeeiieeuvdfftefgueduleehueetgffgjeeitedtteetkeeuueeuueekveevvdeuveenucfkphepvdgrtddvmeeijedtmedvtddvtdemvggrtddumegsvgegudemleehvgejmeefgeefmeeludefvgenucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepihhnvghtpedvrgdtvdemieejtdemvddtvddtmegvrgdtudemsggvgedumeelhegvjeemfeegfeemledufegvpdhhvghloheplgduledvrdduieekrddujeekrdejhegnpdhmrghilhhfrhhomheplhhutggrrdgtvghrvghsohhlihessghoohhtlhhinhdrtghomhdpnhgspghrtghpthhtohepfedtpdhrtghpthhtohepfhhlohhrihgrnhdrfhgrihhnvghllhhisegsrhhorggutghomhdrtghomhdprhgtphhtthhopehlihhnuhigqdhrphhiqdhkvghrnhgvlheslhhishhtshdrihhnfhhrrgguvggrugdrohhrghdprhgtphhtthhopeiihhhouhgsi
 hhnsghinheslhhoohhnghhsohhnrdgtnhdprhgtphhtthhopehrrghfrggvlheskhgvrhhnvghlrdhorhhgpdhrtghpthhtoheplhhutggrrdgtvghrvghsohhlihessghoohhtlhhinhdrtghomhdprhgtphhtthhopehpmhhlrgguvghksehsuhhsvgdrtghomhdprhgtphhtthhopegrnhgurhhihidrshhhvghvtghhvghnkhhosehlihhnuhigrdhinhhtvghlrdgtohhmpdhrtghpthhtoheplhhinhhugidqughotgesvhhgvghrrdhkvghrnhgvlhdrohhrgh
X-GND-Sasl: luca.ceresoli@bootlin.com

The %pC and %pCn printk format specifiers produce the exact same string. In
preparation for removing %pCn, use %pC.

Reviewed-by: Geert Uytterhoeven <geert+renesas@glider.be>
Signed-off-by: Luca Ceresoli <luca.ceresoli@bootlin.com>

---

Changes in v2: none.
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


