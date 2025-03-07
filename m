Return-Path: <linux-pm+bounces-23622-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 0A90EA56673
	for <lists+linux-pm@lfdr.de>; Fri,  7 Mar 2025 12:19:35 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 737E7189670F
	for <lists+linux-pm@lfdr.de>; Fri,  7 Mar 2025 11:19:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 17B6A217671;
	Fri,  7 Mar 2025 11:19:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b="eCFsKVKA"
X-Original-To: linux-pm@vger.kernel.org
Received: from relay4-d.mail.gandi.net (relay4-d.mail.gandi.net [217.70.183.196])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 427D014293;
	Fri,  7 Mar 2025 11:19:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.70.183.196
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741346369; cv=none; b=js0DHxCH57HOyc9+DiqFh4+CD6WDlIaKBL4WrJ4fYb+FgmrqpGnCeHIFRLEaADIBXRgjWpzIsDaS0Y0J8taL6EBTXiuqipcSENV7k1PcMvVRZ0WfL2WB6LPmGN3nRNTWqWHgAw1Y5DNu3QhlsG+CA8LP7p/IgT5RtfBCwC34MCs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741346369; c=relaxed/simple;
	bh=LTgzbJRao0kxWFSBOmMo40nrp0G+Nn8FLwMclm5nFiQ=;
	h=From:Subject:Date:Message-Id:MIME-Version:Content-Type:To:Cc; b=iS4K9EWEZLBVEq1KGeR4yxUb8t2bhJYgiRh8V69c55rHrc8SuwgdNzH4kDb1WKP94mLHErflCmUf+eR7jiJydUQJyC7opBv1d2u9KhrAZoO59i96VKkw6O/ET7Bg6g5+A3UyKqMqLg8WKmuXBrg1z2xd6Lg+stjiZxb7TCyd1Fw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com; spf=pass smtp.mailfrom=bootlin.com; dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b=eCFsKVKA; arc=none smtp.client-ip=217.70.183.196
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bootlin.com
Received: by mail.gandi.net (Postfix) with ESMTPSA id 98BBF443A6;
	Fri,  7 Mar 2025 11:19:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=gm1;
	t=1741346364;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding;
	bh=Yl6f/SodGGeAxz+5H/l72NErMjz9ym9/w2AhCrQGKKY=;
	b=eCFsKVKARYrnL/zAS2YX34+Rl56pcOrOvoAXI9lYg7dMcmLKh4yqOq133wU9e1qMoZO8Tu
	WhTKuiggcabdIRA7tJU77YD6PPNL0f6iqSce2nCSe0NYWV4DkGxhHnua9W/bzAqkcQYZom
	RrGbfY4wA/kiAIRJMQQZF1qjWT0ufhnkTL3t0iKlOiMQ0m8/d7G73M9Pn5QcvCtB5eG7ei
	pEpMIC26i7VQAGN4CLowA+VmaYwPuwX1VUFLpVa3HeU3Qj0aju9JXzEXWFiL49DzD9SkS2
	D9VV0ryc4l9vK69HvKhvA1XcX/OI5ynMNgFQHeRnTMA0egR3Ylufwa5E17eBXQ==
From: Luca Ceresoli <luca.ceresoli@bootlin.com>
Subject: [PATCH 0/2] vsprintf: remove redundant %pCn format specifier
Date: Fri, 07 Mar 2025 12:19:06 +0100
Message-Id: <20250307-vsprintf-pcn-v1-0-df0b2ccf610f@bootlin.com>
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIACrWymcC/x2MQQqAIBAAvyJ7TjAtir4SHUzX2ovJGhJIf086D
 XOYqZCRCTMsogJjoUxXbNJ3Atxp44GSfHPQSo/KqEmWnJjiHWRyUc52MGh25RugJYkx0PPv1u1
 9P0rCgtteAAAA
X-Change-ID: 20250307-vsprintf-pcn-8a43e3b0d43e
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
X-GND-Cause: gggruggvucftvghtrhhoucdtuddrgeefvddrtddtgdduuddthedvucetufdoteggodetrfdotffvucfrrhhofhhilhgvmecuifetpfffkfdpucggtfgfnhhsuhgsshgtrhhisggvnecuuegrihhlohhuthemuceftddunecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenucfjughrpefhufffkfggtgfgvfevofesthejredtredtjeenucfhrhhomhepnfhutggrucevvghrvghsohhlihcuoehluhgtrgdrtggvrhgvshholhhisegsohhothhlihhnrdgtohhmqeenucggtffrrghtthgvrhhnpefgieetkeekgfdtudevueffueffveekheeiudfhfedvhfeukeeuhffhtddtvdekfeenucffohhmrghinhepkhgvrhhnvghlrdhorhhgnecukfhppedvrgdtvdemieejtdemvddtvddtmegvrgdtudemsggvgedumeelhegvjeemfeegfeemledufegvnecuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehinhgvthepvdgrtddvmeeijedtmedvtddvtdemvggrtddumegsvgegudemleehvgejmeefgeefmeeludefvgdphhgvlhhopegludelvddrudeikedrudejkedruddukegnpdhmrghilhhfrhhomheplhhutggrrdgtvghrvghsohhlihessghoohhtlhhinhdrtghomhdpnhgspghrtghpthhtohepvdejpdhrtghpthhtoheprghnughrihihrdhshhgvvhgthhgvnhhkoheslhhinhhugidrihhnthgvlhdrtghomhdprhgtphhtthhopehssghrrghnuggvnhessghrohgruggtohhmrdgtohhmpdhrtghpthhto
 heplhhinhhugidqtghlkhesvhhgvghrrdhkvghrnhgvlhdrohhrghdprhgtphhtthhopegtohhrsggvtheslhifnhdrnhgvthdprhgtphhtthhopehlihhnuhigqdgrrhhmqdhkvghrnhgvlheslhhishhtshdrihhnfhhrrgguvggrugdrohhrghdprhgtphhtthhopehflhhorhhirghnrdhfrghinhgvlhhlihessghrohgruggtohhmrdgtohhmpdhrtghpthhtohepshgvnhhoiihhrghtshhkhiestghhrhhomhhiuhhmrdhorhhgpdhrtghpthhtohepphhmlhgruggvkhesshhushgvrdgtohhm
X-GND-Sasl: luca.ceresoli@bootlin.com

There are two printk format specifiers for clocks: %pC and %pCn, and they
print exactly the same string. The reason for having two is not totally
clear (see discussion in patch 2), but there seem to be no advantage in
having two instead of one.

Definitely having two without properly documenting they do the same creates
misunderstandings [0].

Since %pCn is used in a single place, replace it with %pC and remove %pCn
to simplify such format specifiers implementation and avoid
misunderstandings.

[0] https://lore.kernel.org/dri-devel/71c44221-b18b-4928-8faf-00893ec4a109@nxp.com/

Signed-off-by: Luca Ceresoli <luca.ceresoli@bootlin.com>
---
Luca Ceresoli (2):
      thermal: bcm2835: use %pC instead of %pCn
      vsprintf: remove redundant and unused %pCn format specifier

 Documentation/core-api/printk-formats.rst  |  3 +--
 drivers/thermal/broadcom/bcm2835_thermal.c |  2 +-
 lib/vsprintf.c                             | 10 ++--------
 3 files changed, 4 insertions(+), 11 deletions(-)
---
base-commit: 7eb172143d5508b4da468ed59ee857c6e5e01da6
change-id: 20250307-vsprintf-pcn-8a43e3b0d43e

Best regards,
-- 
Luca Ceresoli <luca.ceresoli@bootlin.com>


