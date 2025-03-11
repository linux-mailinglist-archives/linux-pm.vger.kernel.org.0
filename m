Return-Path: <linux-pm+bounces-23830-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 99165A5BBF9
	for <lists+linux-pm@lfdr.de>; Tue, 11 Mar 2025 10:22:06 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 0B5B71725F5
	for <lists+linux-pm@lfdr.de>; Tue, 11 Mar 2025 09:22:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EF1CC22FE15;
	Tue, 11 Mar 2025 09:21:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b="U63TcZzx"
X-Original-To: linux-pm@vger.kernel.org
Received: from relay5-d.mail.gandi.net (relay5-d.mail.gandi.net [217.70.183.197])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8FA8622DFB4;
	Tue, 11 Mar 2025 09:21:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.70.183.197
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741684900; cv=none; b=HnNxEALwP5lF3L4aWVw+vu9z8uJwyz4LGRsuqLTAVyHFfeD5qMrpiImpMGvO0LWxZRgOZon01KINm7BP6c7n80dAwvDpwngxiVnK40y8nONUFChpk5M99fLm1/i4b/j4xYlZFT/4Q9txFRi/KWHMSrKQ98sQ67w4A2+W950wo1Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741684900; c=relaxed/simple;
	bh=NNCDmWvEeAkd8FhlZDmXtAIfDrkUFxd8oqdzc1UrrVk=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=s/6J5kBMQyaec5QOKPPgIihrZAZaVwJ5wbgRdnrfKBe/US/Ml13tzUE026s4qfa/D+IkPP9YvHU4/BK6OKvXBGU9t9QA3mum3OuI1QAasLlB78d2/+Lg9XQwAIppsuYNwojK7tCuwPVktelfg8w6462yuFi13O3ygNr0WvpJpc8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com; spf=pass smtp.mailfrom=bootlin.com; dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b=U63TcZzx; arc=none smtp.client-ip=217.70.183.197
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bootlin.com
Received: by mail.gandi.net (Postfix) with ESMTPSA id 855B6432FD;
	Tue, 11 Mar 2025 09:21:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=gm1;
	t=1741684896;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=z7UQpUk6EmrJuJuxGvA3LtueMy3iwHvPLNk89wKvghY=;
	b=U63TcZzx714/xsSVzQjZUkomYVJaYT/FhlISzbZfEwUvBH5pyaAqnCln+q/Mr+oBVO3SJO
	08Vyv2LPU9TinK47r1ncKAtQ96tXWmX+Js7Zw6cz/UhwbKvRJl+UoA9gCQzUB2uQJ2Gi4i
	xkfKR0Rp5o3bKLcLMl6YMiX+HgUtp7iKwZIvzNsPIxnfDDzOk4wrUGQdkF2CFVswY2a2lz
	+HLCoW9CB34ajgOH2EQnt3esL9I2GzhDaSKAysRjpshjUIR9agjRBOzsbQtqgqgKQzECWi
	2T1fUAbPw0BXejic0Um3l0XlHHUNDJ9edrWoYKLSeNDeuND9GSILiajG3Xge8g==
From: Luca Ceresoli <luca.ceresoli@bootlin.com>
Date: Tue, 11 Mar 2025 10:21:23 +0100
Subject: [PATCH v2 2/2] vsprintf: remove redundant and unused %pCn format
 specifier
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Message-Id: <20250311-vsprintf-pcn-v2-2-0af40fc7dee4@bootlin.com>
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
X-GND-Cause: gggruggvucftvghtrhhoucdtuddrgeefvddrtddtgdduvddukeeiucetufdoteggodetrfdotffvucfrrhhofhhilhgvmecuifetpfffkfdpucggtfgfnhhsuhgsshgtrhhisggvnecuuegrihhlohhuthemuceftddunecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenucfjughrpefhfffugggtgffkfhgjvfevofesthekredtredtjeenucfhrhhomhepnfhutggrucevvghrvghsohhlihcuoehluhgtrgdrtggvrhgvshholhhisegsohhothhlihhnrdgtohhmqeenucggtffrrghtthgvrhhnpefffffgfefghfettedtfeehgfdtveekhfekudeiueetkeehleetveetjeffhedugeenucfkphepvdgrtddvmeeijedtmedvtddvtdemvggrtddumegsvgegudemleehvgejmeefgeefmeeludefvgenucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepihhnvghtpedvrgdtvdemieejtdemvddtvddtmegvrgdtudemsggvgedumeelhegvjeemfeegfeemledufegvpdhhvghloheplgduledvrdduieekrddujeekrdejhegnpdhmrghilhhfrhhomheplhhutggrrdgtvghrvghsohhlihessghoohhtlhhinhdrtghomhdpnhgspghrtghpthhtohepfedtpdhrtghpthhtohepfhhlohhrihgrnhdrfhgrihhnvghllhhisegsrhhorggutghomhdrtghomhdprhgtphhtthhopehlihhnuhigqdhrphhiqdhkvghrnhgvlheslhhishhtshdrihhnfhhrrgguvggrugdrohhrghdprhgtphhtthhopeiihhhouhgsi
 hhnsghinheslhhoohhnghhsohhnrdgtnhdprhgtphhtthhopehrrghfrggvlheskhgvrhhnvghlrdhorhhgpdhrtghpthhtoheplhhutggrrdgtvghrvghsohhlihessghoohhtlhhinhdrtghomhdprhgtphhtthhopehpmhhlrgguvghksehsuhhsvgdrtghomhdprhgtphhtthhopegrnhgurhhihidrshhhvghvtghhvghnkhhosehlihhnuhigrdhinhhtvghlrdgtohhmpdhrtghpthhtoheplhhinhhugidqughotgesvhhgvghrrdhkvghrnhgvlhdrohhrgh
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

Acked-by: Stephen Boyd <sboyd@kernel.org>
Reviewed-by: Geert Uytterhoeven <geert+renesas@glider.be>
Signed-off-by: Luca Ceresoli <luca.ceresoli@bootlin.com>

---

Changes in v2:
- update Chinese documentation (change acked by Yanteng Si <si.yanteng@linux.dev>)
---
 Documentation/core-api/printk-formats.rst                    |  3 +--
 Documentation/translations/zh_CN/core-api/printk-formats.rst |  3 +--
 lib/vsprintf.c                                               | 10 ++--------
 3 files changed, 4 insertions(+), 12 deletions(-)

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
diff --git a/Documentation/translations/zh_CN/core-api/printk-formats.rst b/Documentation/translations/zh_CN/core-api/printk-formats.rst
index bd36d35eba4eb124be43a66227059a30429e4135..96a917ecc93f2a4872784b6d8e3f98bcb9f5f737 100644
--- a/Documentation/translations/zh_CN/core-api/printk-formats.rst
+++ b/Documentation/translations/zh_CN/core-api/printk-formats.rst
@@ -523,9 +523,8 @@ clk结构体
 ::
 
 	%pC	pll1
-	%pCn	pll1
 
-用于打印clk结构。%pC 和 %pCn 打印时钟的名称（通用时钟框架）或唯一的32位
+用于打印clk结构。%pC 打印时钟的名称（通用时钟框架）或唯一的32位
 ID（传统时钟框架）。
 
 通过引用传递。
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


