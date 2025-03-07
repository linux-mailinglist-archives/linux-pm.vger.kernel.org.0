Return-Path: <linux-pm+bounces-23624-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 373C5A5667C
	for <lists+linux-pm@lfdr.de>; Fri,  7 Mar 2025 12:20:04 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 6FAB218969FE
	for <lists+linux-pm@lfdr.de>; Fri,  7 Mar 2025 11:20:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AECC021883C;
	Fri,  7 Mar 2025 11:19:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b="jU5ct4R9"
X-Original-To: linux-pm@vger.kernel.org
Received: from relay4-d.mail.gandi.net (relay4-d.mail.gandi.net [217.70.183.196])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 085DD218592;
	Fri,  7 Mar 2025 11:19:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.70.183.196
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741346374; cv=none; b=p5mLG1NpwYK+1rDXPtr/Dzcm314JrXppQcXepAqr0THpgZeutlUYs5JNAK6RfvzUcNZWrFBVDXwTd/NjxJwgL2rqCE63Z0+Of4MNvQbMORUO+Lnw6i+A92pbX8vVEzxtzYXx/7pc9XFBTnaC2br/wUBlnPjxQX97Nt1XVrET4xI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741346374; c=relaxed/simple;
	bh=0m6O98RpJX9PsqeHuauUrajQB/b6Sh9ottkc8OpeKhA=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=q1ddd2/PPQb2H7AhGvqsAhvk68aw6xxxtP8KMuZtBy0oY6XxgbvP3/i8bS+Kgy5wxduUIQ2z063smupwXKliWLQLZBwxOiZT4rr9ZBqCPOel4pgXuaEXNGbsFGnvCObt03hLx0DXKKHw1uzkyDlVvFuiawRH6xr2HlDc9uJaXbc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com; spf=pass smtp.mailfrom=bootlin.com; dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b=jU5ct4R9; arc=none smtp.client-ip=217.70.183.196
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bootlin.com
Received: by mail.gandi.net (Postfix) with ESMTPSA id 9CB7C443B1;
	Fri,  7 Mar 2025 11:19:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=gm1;
	t=1741346369;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=LfB8K2ObZyFaf2KJ7GrPMaTmLZopPbcPorZdKiZQLQk=;
	b=jU5ct4R900zDqjytQyRj5JegUO57qtA31qoVKn4YXpHNl+N2nOViXGl6cP2zOHl8mqYrOt
	rkzZ7YDS3Z/nUYdhHv2AfwMg2YMSQFe+g0h72eTHv9/cAMFO20amakYGmZQi8DWE11UsVX
	UR/ICIQinVYrFNxfDPlNqpbo9aWhWJ+Phe2rcMDSNHa5Ji6gDPTxSjfXh709bICeh+2/rm
	qxuypskAO39Tq0zjsFkO1mZ7mvDHdAKvGPn26r/Xca9IK4Lgmp18ER8LQb/TLUxMmHu6f2
	BD2EcngPJh1SxSJz0r1Qu1aS3HPW88On1itr4FEYdfoq9BSsy6OOFW5WlFQicA==
From: Luca Ceresoli <luca.ceresoli@bootlin.com>
Date: Fri, 07 Mar 2025 12:19:08 +0100
Subject: [PATCH 2/2] vsprintf: remove redundant and unused %pCn format
 specifier
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250307-vsprintf-pcn-v1-2-df0b2ccf610f@bootlin.com>
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
X-GND-Cause: gggruggvucftvghtrhhoucdtuddrgeefvddrtddtgdduuddthedvucetufdoteggodetrfdotffvucfrrhhofhhilhgvmecuifetpfffkfdpucggtfgfnhhsuhgsshgtrhhisggvnecuuegrihhlohhuthemuceftddunecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenucfjughrpefhfffugggtgffkfhgjvfevofesthejredtredtjeenucfhrhhomhepnfhutggrucevvghrvghsohhlihcuoehluhgtrgdrtggvrhgvshholhhisegsohhothhlihhnrdgtohhmqeenucggtffrrghtthgvrhhnpeeiieeuvdfftefgueduleehueetgffgjeeitedtteetkeeuueeuueekveevvdeuveenucfkphepvdgrtddvmeeijedtmedvtddvtdemvggrtddumegsvgegudemleehvgejmeefgeefmeeludefvgenucevlhhushhtvghrufhiiigvpedunecurfgrrhgrmhepihhnvghtpedvrgdtvdemieejtdemvddtvddtmegvrgdtudemsggvgedumeelhegvjeemfeegfeemledufegvpdhhvghloheplgduledvrdduieekrddujeekrdduudekngdpmhgrihhlfhhrohhmpehluhgtrgdrtggvrhgvshholhhisegsohhothhlihhnrdgtohhmpdhnsggprhgtphhtthhopedvjedprhgtphhtthhopegrnhgurhhihidrshhhvghvtghhvghnkhhosehlihhnuhigrdhinhhtvghlrdgtohhmpdhrtghpthhtohepshgsrhgrnhguvghnsegsrhhorggutghomhdrtghomhdprhgtphhtthhopehlihhnuhigqdgtlhhksehvghgvrhdrk
 hgvrhhnvghlrdhorhhgpdhrtghpthhtoheptghorhgsvghtsehlfihnrdhnvghtpdhrtghpthhtoheplhhinhhugidqrghrmhdqkhgvrhhnvghlsehlihhsthhsrdhinhhfrhgruggvrggurdhorhhgpdhrtghpthhtohepfhhlohhrihgrnhdrfhgrihhnvghllhhisegsrhhorggutghomhdrtghomhdprhgtphhtthhopehsvghnohiihhgrthhskhihsegthhhrohhmihhumhdrohhrghdprhgtphhtthhopehpmhhlrgguvghksehsuhhsvgdrtghomh
X-GND-Sasl: luca.ceresoli@bootlin.com

%pC and %pCn print the same string, and commit 900cca294425 ("lib/vsprintf:
add %pC{,n,r} format specifiers for clocks") introducing them does not
clarify any intended difference. It can be assumed %pC is a default for
%pCn as some other specifiers do, but not all are consistent with this
policy. Moreover there is now no other suffix other than 'n', which makes a
default not really useful.

All users in the kernel were using %pC except for one which has been
converted. So now remove %pCn and all the unnecessary extra code and
documentation.

Signed-off-by: Luca Ceresoli <luca.ceresoli@bootlin.com>
---
 Documentation/core-api/printk-formats.rst |  3 +--
 lib/vsprintf.c                            | 10 ++--------
 2 files changed, 3 insertions(+), 10 deletions(-)

diff --git a/Documentation/core-api/printk-formats.rst b/Documentation/core-api/printk-formats.rst
index ecccc0473da9c10f45f2464566f690472c61401e..f3009e6ec80a864c330c8812efcd82c12f4066b3 100644
--- a/Documentation/core-api/printk-formats.rst
+++ b/Documentation/core-api/printk-formats.rst
@@ -571,9 +571,8 @@ struct clk
 ::
 
 	%pC	pll1
-	%pCn	pll1
 
-For printing struct clk structures. %pC and %pCn print the name of the clock
+For printing struct clk structures. %pC prints the name of the clock
 (Common Clock Framework) or a unique 32-bit ID (legacy clock framework).
 
 Passed by reference.
diff --git a/lib/vsprintf.c b/lib/vsprintf.c
index 56fe96319292674c9f79559cf78dd0d99d1a1f06..143d55cb1c12acac21a6c6bafd255437e878f280 100644
--- a/lib/vsprintf.c
+++ b/lib/vsprintf.c
@@ -1969,15 +1969,11 @@ char *clock(char *buf, char *end, struct clk *clk, struct printf_spec spec,
 	if (check_pointer(&buf, end, clk, spec))
 		return buf;
 
-	switch (fmt[1]) {
-	case 'n':
-	default:
 #ifdef CONFIG_COMMON_CLK
-		return string(buf, end, __clk_get_name(clk), spec);
+	return string(buf, end, __clk_get_name(clk), spec);
 #else
-		return ptr_to_id(buf, end, clk, spec);
+	return ptr_to_id(buf, end, clk, spec);
 #endif
-	}
 }
 
 static
@@ -2382,8 +2378,6 @@ char *rust_fmt_argument(char *buf, char *end, void *ptr);
  *      T    time64_t
  * - 'C' For a clock, it prints the name (Common Clock Framework) or address
  *       (legacy clock framework) of the clock
- * - 'Cn' For a clock, it prints the name (Common Clock Framework) or address
- *        (legacy clock framework) of the clock
  * - 'G' For flags to be printed as a collection of symbolic strings that would
  *       construct the specific value. Supported flags given by option:
  *       p page flags (see struct page) given as pointer to unsigned long

-- 
2.48.1


