Return-Path: <linux-pm+bounces-24893-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 12768A7E741
	for <lists+linux-pm@lfdr.de>; Mon,  7 Apr 2025 18:52:47 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 9E540175D10
	for <lists+linux-pm@lfdr.de>; Mon,  7 Apr 2025 16:47:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AEF292116E4;
	Mon,  7 Apr 2025 16:46:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b="Nuh6OFc3"
X-Original-To: linux-pm@vger.kernel.org
Received: from relay2-d.mail.gandi.net (relay2-d.mail.gandi.net [217.70.183.194])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4474221149C;
	Mon,  7 Apr 2025 16:46:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.70.183.194
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744044416; cv=none; b=ExFq455bAEWr3ZiExy6B8C3QkGaIK+iAhN4O9DnvwTjnb5huGKOnIh8V5/3lhegtlfG9km+J6+2t0SjyM3oDxI3e2IoS9K3J1R6gZg9twUCcCK1V7uUQAH7r0CASFlp16m9pG0TionFfadEsVrhPHGZXzvrVZKYSJHxxDpNKEj4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744044416; c=relaxed/simple;
	bh=c4KBYqPr3jTX/BN6Q4aT5hyNkfv7vvC3t8calp633Ug=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=JkroASAhsAByIznWNK5M0UWXm88/kupCKukHAwmm3DwABqPYWwOuBUSRyGesAKjJF8lqxn+TJHnMalCpIskprFcIGGoaoSJCAJR2egz1EaGcUMaHLh2q4ww0sSDXgvfz9w5xpsGn7ro2E9eGO1znV55tQd+LIAh9iuqO2Ts6dxQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com; spf=pass smtp.mailfrom=bootlin.com; dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b=Nuh6OFc3; arc=none smtp.client-ip=217.70.183.194
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bootlin.com
Received: by mail.gandi.net (Postfix) with ESMTPSA id 910F543137;
	Mon,  7 Apr 2025 16:46:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=gm1;
	t=1744044412;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=RXJpfmhZ+8yM3mjrwdmbYrVV3J33ZSlFaLXrj0slIbA=;
	b=Nuh6OFc3/kXzo6DFhHDNjBix1k6eSZDM8GdsMsXmsU0V3T4vccLEgUCC4EgQeWaqxdDd+m
	6iDycLP0ZRwOMlRdIP55ClDsYY3RRZggJjGc57Tbk0t12a7NIkAiyOyEKWjVYYGcYtB8cY
	LSF3wv/M4lhju7DTiyJXQ8Vfvi1s2OBuTch5r0lwm/s2X3bqq+j8hq+NI1nantxL2od+tP
	b5oVECDGuEQqoTNn/1N8Bm58s4JuR7NFVdrwxCIpRF2xGRCvUw2WN9uKmJ98U/NeGEgPJo
	E8lKL1tTsWOpYcW6n8W0UST7oX+rytoqLVzC9dA4uDFH/LG6/2QHCJ7BxnoDoA==
Date: Mon, 7 Apr 2025 18:46:47 +0200
From: Luca Ceresoli <luca.ceresoli@bootlin.com>
To: Petr Mladek <pmladek@suse.com>, Daniel Lezcano
 <daniel.lezcano@linaro.org>
Cc: "Rafael J. Wysocki" <rafael@kernel.org>, Zhang Rui
 <rui.zhang@intel.com>, Lukasz Luba <lukasz.luba@arm.com>, Florian Fainelli
 <florian.fainelli@broadcom.com>, Ray Jui <rjui@broadcom.com>, Scott Branden
 <sbranden@broadcom.com>, Broadcom internal kernel review list
 <bcm-kernel-feedback-list@broadcom.com>, Steven Rostedt
 <rostedt@goodmis.org>, Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
 Rasmus Villemoes <linux@rasmusvillemoes.dk>, Sergey Senozhatsky
 <senozhatsky@chromium.org>, Jonathan Corbet <corbet@lwn.net>, Andrew Morton
 <akpm@linux-foundation.org>, Alex Shi <alexs@kernel.org>, Yanteng Si
 <si.yanteng@linux.dev>, Binbin Zhou <zhoubinbin@loongson.cn>, Thomas
 Petazzoni <thomas.petazzoni@bootlin.com>, Michael Turquette
 <mturquette@baylibre.com>, Stephen Boyd <sboyd@kernel.org>, Geert
 Uytterhoeven <geert+renesas@glider.be>, Liu Ying <victor.liu@nxp.com>,
 linux-clk@vger.kernel.org, linux-pm@vger.kernel.org,
 linux-rpi-kernel@lists.infradead.org, linux-arm-kernel@lists.infradead.org,
 linux-kernel@vger.kernel.org, linux-doc@vger.kernel.org
Subject: Re: [PATCH v2 2/2] vsprintf: remove redundant and unused %pCn
 format specifier
Message-ID: <20250407184647.3b72de47@booty>
In-Reply-To: <Z9BKW_06nLAOzYfY@pathway.suse.cz>
References: <20250311-vsprintf-pcn-v2-0-0af40fc7dee4@bootlin.com>
	<20250311-vsprintf-pcn-v2-2-0af40fc7dee4@bootlin.com>
	<Z9BKW_06nLAOzYfY@pathway.suse.cz>
Organization: Bootlin
X-Mailer: Claws Mail 4.3.1 (GTK 3.24.43; x86_64-redhat-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-GND-State: clean
X-GND-Score: -100
X-GND-Cause: gggruggvucftvghtrhhoucdtuddrgeefvddrtddtgddvtddtjeduucetufdoteggodetrfdotffvucfrrhhofhhilhgvmecuifetpfffkfdpucggtfgfnhhsuhgsshgtrhhisggvnecuuegrihhlohhuthemuceftddunecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenucfjughrpeffhffvvefukfgjfhhoofggtgfgsehtjeertdertddvnecuhfhrohhmpefnuhgtrgcuvegvrhgvshholhhiuceolhhutggrrdgtvghrvghsohhlihessghoohhtlhhinhdrtghomheqnecuggftrfgrthhtvghrnhepgeelffefgfehhfdtvdefueefieevkefggfelkeeiudetkeektedvhedukefgvddvnecuffhomhgrihhnpegsohhothhlihhnrdgtohhmnecukfhppedvrgdtvdemieejtdemvddtvddtmegvrgdtudemsggvgedumeelhegvjeemfeegfeemledufegvnecuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehinhgvthepvdgrtddvmeeijedtmedvtddvtdemvggrtddumegsvgegudemleehvgejmeefgeefmeeludefvgdphhgvlhhopegsohhothihpdhmrghilhhfrhhomheplhhutggrrdgtvghrvghsohhlihessghoohhtlhhinhdrtghomhdpnhgspghrtghpthhtohepvdelpdhrtghpthhtohepphhmlhgruggvkhesshhushgvrdgtohhmpdhrtghpthhtohepuggrnhhivghlrdhlvgiitggrnhhosehlihhnrghrohdrohhrghdprhgtphhtthhopehrrghfrggvlheskhgvrhhnvghlrdhorhhgpdhrt
 ghpthhtoheprhhuihdriihhrghnghesihhnthgvlhdrtghomhdprhgtphhtthhopehluhhkrghsiidrlhhusggrsegrrhhmrdgtohhmpdhrtghpthhtohepfhhlohhrihgrnhdrfhgrihhnvghllhhisegsrhhorggutghomhdrtghomhdprhgtphhtthhopehrjhhuihessghrohgruggtohhmrdgtohhmpdhrtghpthhtohepshgsrhgrnhguvghnsegsrhhorggutghomhdrtghomh
X-GND-Sasl: luca.ceresoli@bootlin.com

Hello Petr, Daniel,

On Tue, 11 Mar 2025 15:36:11 +0100
Petr Mladek <pmladek@suse.com> wrote:

> On Tue 2025-03-11 10:21:23, Luca Ceresoli wrote:
> > %pC and %pCn print the same string, and commit 900cca294425 ("lib/vsprintf:
> > add %pC{,n,r} format specifiers for clocks") introducing them does not
> > clarify any intended difference. It can be assumed %pC is a default for
> > %pCn as some other specifiers do, but not all are consistent with this
> > policy. Moreover there is now no other suffix other than 'n', which makes a
> > default not really useful.
> > 
> > All users in the kernel were using %pC except for one which has been
> > converted. So now remove %pCn and all the unnecessary extra code and
> > documentation.
> > 
> > Acked-by: Stephen Boyd <sboyd@kernel.org>
> > Reviewed-by: Geert Uytterhoeven <geert+renesas@glider.be>
> > Signed-off-by: Luca Ceresoli <luca.ceresoli@bootlin.com>  
> 
> Makes sense. Looks and works well, so:
> 
> Reviewed-by: Petr Mladek <pmladek@suse.com>
> Tested-by: Petr Mladek <pmladek@suse.com>
> 
> Daniel, if I get it correctly, you have already taken the 1st patch.
> Would you mind to take also this patch using the same tree, please?
> Otherwise, we would need to coordinate pull requests in the upcoming
> merge window ;-)

I see none of these two patches in linux-next.

Anything I should do? Resend? Or just wait a bit more?

Best regards,
Luca

-- 
Luca Ceresoli, Bootlin
Embedded Linux and Kernel engineering
https://bootlin.com

