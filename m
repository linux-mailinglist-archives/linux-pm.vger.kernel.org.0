Return-Path: <linux-pm+bounces-23828-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 0CBD1A5BBEF
	for <lists+linux-pm@lfdr.de>; Tue, 11 Mar 2025 10:21:47 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id A99203A712F
	for <lists+linux-pm@lfdr.de>; Tue, 11 Mar 2025 09:21:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DDBD222D7A0;
	Tue, 11 Mar 2025 09:21:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b="o9p83flX"
X-Original-To: linux-pm@vger.kernel.org
Received: from relay5-d.mail.gandi.net (relay5-d.mail.gandi.net [217.70.183.197])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2038422CBD5;
	Tue, 11 Mar 2025 09:21:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.70.183.197
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741684896; cv=none; b=LAkgTU93YsubOAygzJuK9ACfvsalUbZWSmimHrqGcUtv01Zc2RV1VA0CCIdSSDpoZF7PNEpKeAo9AEWW1SLv4TWkn9RMWZ8gX6rErNoB0A+E5cZZ2dvByL2dqzDRokKC8lX9XBWVDYGRvUHlAEkjsMTEG/xkU+7kpwfhNKhhzKQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741684896; c=relaxed/simple;
	bh=D3oDrA/DYZsV2ZD9WpsoFM6T5ClnWVYJe1My0WXo2Xs=;
	h=From:Subject:Date:Message-Id:MIME-Version:Content-Type:To:Cc; b=CZ9GIE104jKsHTS6Qd+9E/5JbPE+MGbZLuY19cQR2CyZgVE5SfeTIT2kxdSihHOgU8KzhYQSeensQD788RUFue7Kv4kmUpjC5wAvJtMBDtemsnrukU2CO8Rd8mZWGXY47x+AVW0Tk9B/dWsBCJ3wTtVY3AHar+KF5m3/MyfEjLE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com; spf=pass smtp.mailfrom=bootlin.com; dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b=o9p83flX; arc=none smtp.client-ip=217.70.183.197
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bootlin.com
Received: by mail.gandi.net (Postfix) with ESMTPSA id 9D8E3432FA;
	Tue, 11 Mar 2025 09:21:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=gm1;
	t=1741684892;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding;
	bh=6VTqHFVqHMv5npZuUyKgDinGie6VAE2hr7CtUFwYLSY=;
	b=o9p83flXRMrRQuTLg6n/HGont2VUgB6/lw/4w2fAvirJUilLCqThl8RIPLmtWw9vEW95eX
	envhk4s2MbLlzGsQ27DidxfRYMN44+3RIPG6IjBlPdfTXNQOOivGfzTqKEm6d9e+tL6QUp
	dtDRYnr3/mG9lUC2rJD/UMAfkIh6l/+H9vQhU3fyvb4zD2QkhuytKMs3Nq2/wnfcbWBuZJ
	SsRtZocmVaX+Juk8O43qF2q6E+QMN3fbet6gpazai6Dc4JcUXZ90pZioTpeucWr/sYw9MJ
	LBNJAENxwSNN4bTC7qANAYjPilyUpYrUUyAvCtwKLM5hvCJ6vxwl5hU2Hh1Zfg==
From: Luca Ceresoli <luca.ceresoli@bootlin.com>
Subject: [PATCH v2 0/2] vsprintf: remove redundant %pCn format specifier
Date: Tue, 11 Mar 2025 10:21:21 +0100
Message-Id: <20250311-vsprintf-pcn-v2-0-0af40fc7dee4@bootlin.com>
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIAJEA0GcC/3WMywrCMBBFf6XM2pFJ4gtX/od00bzsgCYlCUEp+
 Xdj964u58I5K2SX2GW4DiskVzlzDB3kbgAzT+HhkG1nkCSPpOiMNS+JQ/G4mICX6aCc0mT7QFe
 W5Dy/t9x97DxzLjF9tnoVv/dPqAoktJ60NMafBPmbjrE8OexNfMHYWvsC41q6JaoAAAA=
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
X-GND-Cause: gggruggvucftvghtrhhoucdtuddrgeefvddrtddtgdduvddukeeiucetufdoteggodetrfdotffvucfrrhhofhhilhgvmecuifetpfffkfdpucggtfgfnhhsuhgsshgtrhhisggvnecuuegrihhlohhuthemuceftddunecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenucfjughrpefhufffkfggtgfgvfevofesthejredtredtjeenucfhrhhomhepnfhutggrucevvghrvghsohhlihcuoehluhgtrgdrtggvrhgvshholhhisegsohhothhlihhnrdgtohhmqeenucggtffrrghtthgvrhhnpefgieetkeekgfdtudevueffueffveekheeiudfhfedvhfeukeeuhffhtddtvdekfeenucffohhmrghinhepkhgvrhhnvghlrdhorhhgnecukfhppedvrgdtvdemieejtdemvddtvddtmegvrgdtudemsggvgedumeelhegvjeemfeegfeemledufegvnecuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehinhgvthepvdgrtddvmeeijedtmedvtddvtdemvggrtddumegsvgegudemleehvgejmeefgeefmeeludefvgdphhgvlhhopegludelvddrudeikedrudejkedrjeehngdpmhgrihhlfhhrohhmpehluhgtrgdrtggvrhgvshholhhisegsohhothhlihhnrdgtohhmpdhnsggprhgtphhtthhopeeftddprhgtphhtthhopehflhhorhhirghnrdhfrghinhgvlhhlihessghrohgruggtohhmrdgtohhmpdhrtghpthhtoheplhhinhhugidqrhhpihdqkhgvrhhnvghlsehlihhsthhsrdhinhhfrhgruggvrggur
 dhorhhgpdhrtghpthhtohepiihhohhusghinhgsihhnsehlohhonhhgshhonhdrtghnpdhrtghpthhtoheprhgrfhgrvghlsehkvghrnhgvlhdrohhrghdprhgtphhtthhopehluhgtrgdrtggvrhgvshholhhisegsohhothhlihhnrdgtohhmpdhrtghpthhtohepphhmlhgruggvkhesshhushgvrdgtohhmpdhrtghpthhtoheprghnughrihihrdhshhgvvhgthhgvnhhkoheslhhinhhugidrihhnthgvlhdrtghomhdprhgtphhtthhopehlihhnuhigqdguohgtsehvghgvrhdrkhgvrhhnvghlrdhorhhg
X-GND-Sasl: luca.ceresoli@bootlin.com

There are two printk format specifiers for clocks: %pC and %pCn, and they
print exactly the same string. Geert confirmed the intended reason for
having two was that %pC would act as a default, like some (but not all)
formats do. However there seem to be no advantage in having two instead of
one, especially now that there is no other %pC specifier since commit
666902e42fd8 ("lib/vsprintf: Remove atomic-unsafe support for %pCr").

Definitely having two without properly documenting they do the same creates
misunderstandings [0].

Since %pCn is used in a single place, replace it with %pC and remove %pCn
to simplify such format specifiers implementation and avoid
misunderstandings.

[0] https://lore.kernel.org/dri-devel/f8df2b5e-b005-4ada-8108-159b2b94a72e@nxp.com/

Signed-off-by: Luca Ceresoli <luca.ceresoli@bootlin.com>
---
Changes in v2:
- Add Chinese translation
- Link to v1: https://lore.kernel.org/r/20250307-vsprintf-pcn-v1-0-df0b2ccf610f@bootlin.com

---
Luca Ceresoli (2):
      thermal: bcm2835: use %pC instead of %pCn
      vsprintf: remove redundant and unused %pCn format specifier

 Documentation/core-api/printk-formats.rst                    |  3 +--
 Documentation/translations/zh_CN/core-api/printk-formats.rst |  3 +--
 drivers/thermal/broadcom/bcm2835_thermal.c                   |  2 +-
 lib/vsprintf.c                                               | 10 ++--------
 4 files changed, 5 insertions(+), 13 deletions(-)
---
base-commit: 4d872d51bc9d7b899c1f61534e3dbde72613f627
change-id: 20250307-vsprintf-pcn-8a43e3b0d43e

Best regards,
-- 
Luca Ceresoli <luca.ceresoli@bootlin.com>


