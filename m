Return-Path: <linux-pm+bounces-31217-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id CAAB2B0C76A
	for <lists+linux-pm@lfdr.de>; Mon, 21 Jul 2025 17:20:58 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id D4184171B38
	for <lists+linux-pm@lfdr.de>; Mon, 21 Jul 2025 15:20:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DFABA2DF3EC;
	Mon, 21 Jul 2025 15:20:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="dSUpea09";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="Q0GGv108"
X-Original-To: linux-pm@vger.kernel.org
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 48FE52DE213;
	Mon, 21 Jul 2025 15:20:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753111244; cv=none; b=XPp49NC9tCOStJw0B/lcoRxRMEly0k5gbTNoemMsV/P5nwjEJBPojjS1flTBWw4oqAkRLIZgaSp+Y8eKa+zOhFDfgsQXTm8IbZP2Qc8gZ9hRxPws1/+VLxt2PEXkCDd1pz31hWKJriNunBsZFxD8Q1nXuYYjkW2OthssYtliOA8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753111244; c=relaxed/simple;
	bh=EKv/CuvVWTqGB+3lPgiI/Kb5dtzwxeNfNXJbovQpa9I=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=u6ERqfSYS+M2Hr+gosEj3fsCnnnHf6SisTSvhGLuB8eaD+AJPSHeAW6A9CTnz8SzgQMFzxZAfUao/tyb3TR9cX2wdb1Y1vo80JPGw6ilLi7AdJqsi5EozFZKrjFVgVS00awF3tuFW0GN0gVpi10jMtvDm0+qchxye6fJEtUsJI0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=dSUpea09; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=Q0GGv108; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
From: Thomas Gleixner <tglx@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1753111241;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=/9FzCqmcyJh+8Ydz6tHP0relc2+nn3FdzXGKT9u9tC0=;
	b=dSUpea09yTKvaap84BHTchrX/mvRMJUc48+kcHHkQxoYAlMq1o9H91n0rEyouWUQZds+Ls
	rJWeBKpdVh+r6TVg9PcQPcuj0sZz+kTaDMsLK4KCjaOjlWQYgv4f4R/F/uiKtEsxW6IPu8
	BZs7DYrF+ZLrdRacfIavNLPjVeum/qGXpUL0kBgehfj92Ae5GBzPEau0pmYMGKZYiMUTmA
	WBzzEbBwXCWSUfsni3ElVs+D8g26iSUsJ/++lpGRihfVxdZY1aFI35kcEgLVtGeA+2qJTV
	JIM9YCZ9KB6Tup50FIIXZa38Dsi7uKFBiXUKjNhkEMalmJWrVmGFGCj4lmFI7A==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1753111241;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=/9FzCqmcyJh+8Ydz6tHP0relc2+nn3FdzXGKT9u9tC0=;
	b=Q0GGv108K0Wx0ZlG5G8V8V0Na3jr3eUG3hFHWm0zuYoWeHBjtZZPu1Oy3mIu6+M+ntdxcb
	YsPYlYqxSgIstBDQ==
To: panchuang <panchuang@vivo.com>, Miquel Raynal <miquel.raynal@bootlin.com>
Cc: =?utf-8?B?5p2O5oms6Z+s?= <frank.li@vivo.com>, Uwe =?utf-8?Q?Kleine-K?=
 =?utf-8?Q?=C3=B6nig?=
 <u.kleine-koenig@pengutronix.de>, "Rafael J. Wysocki" <rafael@kernel.org>,
 Daniel Lezcano <daniel.lezcano@linaro.org>, Zhang Rui
 <rui.zhang@intel.com>, Lukasz Luba <lukasz.luba@arm.com>, Markus Mayer
 <mmayer@broadcom.com>, Broadcom internal kernel review list
 <bcm-kernel-feedback-list@broadcom.com>, Florian Fainelli
 <florian.fainelli@broadcom.com>, Shawn Guo <shawnguo@kernel.org>, Sascha
 Hauer <s.hauer@pengutronix.de>, Pengutronix Kernel Team
 <kernel@pengutronix.de>, Fabio Estevam <festevam@gmail.com>, zhanghongchen
 <zhanghongchen@loongson.cn>, Yinbo Zhu <zhuyinbo@loongson.cn>, Amit
 Kucheria <amitk@kernel.org>, Thara Gopinath <thara.gopinath@gmail.com>,
 Niklas =?utf-8?Q?S=C3=B6derlund?= <niklas.soderlund@ragnatech.se>, Geert
 Uytterhoeven <geert+renesas@glider.be>, Magnus Damm
 <magnus.damm@gmail.com>, Heiko Stuebner <heiko@sntech.de>, Bartlomiej
 Zolnierkiewicz <bzolnier@gmail.com>, Krzysztof Kozlowski <krzk@kernel.org>,
 Alim Akhtar <alim.akhtar@samsung.com>, Maxime Coquelin
 <mcoquelin.stm32@gmail.com>, Alexandre Torgue
 <alexandre.torgue@foss.st.com>, Vasily Khoruzhick <anarsoul@gmail.com>,
 Yangtao Li <tiny.windzz@gmail.com>, Chen-Yu Tsai <wens@csie.org>, Jernej
 Skrabec <jernej.skrabec@gmail.com>, Samuel Holland <samuel@sholland.org>,
 Thierry Reding <thierry.reding@gmail.com>, Jonathan Hunter
 <jonathanh@nvidia.com>, Kunihiko Hayashi <hayashi.kunihiko@socionext.com>,
 Masami Hiramatsu <mhiramat@kernel.org>, Matthias Brugger
 <matthias.bgg@gmail.com>, AngeloGioacchino Del Regno
 <angelogioacchino.delregno@collabora.com>, Srinivas Pandruvada
 <srinivas.pandruvada@linux.intel.com>, Greg KH
 <gregkh@linuxfoundation.org>, Peter Zijlstra <peterz@infradead.org>,
 =?utf-8?Q?N=C3=ADcolas_F=2E_R=2E_A=2E_Prado?= <nfraprado@collabora.com>,
 Conor Dooley
 <conor.dooley@microchip.com>, Julien Panis <jpanis@baylibre.com>, Arnd
 Bergmann <arnd@arndb.de>, Uwe =?utf-8?Q?Kleine-K=C3=B6nig?=
 <u.kleine-koenig@baylibre.com>,
 Colin Ian King <colin.i.king@gmail.com>, Raphael Gallais-Pou
 <rgallaispou@gmail.com>, Patrice Chotard <patrice.chotard@foss.st.com>,
 Jonathan Cameron <jonathan.cameron@huawei.com>, "Jiri Slaby (SUSE)"
 <jirislaby@kernel.org>, Sebastian Andrzej Siewior <bigeasy@linutronix.de>,
 Andrew Morton <akpm@linux-foundation.org>, Costa Shulyupin
 <costa.shul@redhat.com>, Yury
 Norov <yury.norov@gmail.com>, Cheng-Yang Chou <yphbchou0911@gmail.com>,
 Caleb Sander Mateos <csander@purestorage.com>, "linux-pm@vger.kernel.org"
 <linux-pm@vger.kernel.org>, LKML <linux-kernel@vger.kernel.org>,
 "linux-arm-kernel@lists.infradead.org"
 <linux-arm-kernel@lists.infradead.org>, "imx@lists.linux.dev"
 <imx@lists.linux.dev>, "linux-arm-msm@vger.kernel.org"
 <linux-arm-msm@vger.kernel.org>, "linux-renesas-soc@vger.kernel.org"
 <linux-renesas-soc@vger.kernel.org>, "linux-rockchip@lists.infradead.org"
 <linux-rockchip@lists.infradead.org>, "linux-samsung-soc@vger.kernel.org"
 <linux-samsung-soc@vger.kernel.org>,
 "linux-stm32@st-md-mailman.stormreply.com"
 <linux-stm32@st-md-mailman.stormreply.com>, "linux-sunxi@lists.linux.dev"
 <linux-sunxi@lists.linux.dev>, "linux-tegra@vger.kernel.org"
 <linux-tegra@vger.kernel.org>, "linux-mediatek@lists.infradead.org"
 <linux-mediatek@lists.infradead.org>
Subject: Re: =?utf-8?B?5Zue5aSNOg==?= [PATCH v6 01/24] genirq/devres: Add
 devm_request_threaded_irq_probe() and devm_request_irq_probe()
In-Reply-To: <draft-87ikjnvqfx.ffs@tglx>
References: <draft-87ikjnvqfx.ffs@tglx>
Date: Mon, 21 Jul 2025 17:20:39 +0200
Message-ID: <87qzy9tvso.ffs@tglx>
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

On Sat, Jul 19 2025 at 23:08, Thomas Gleixner wrote:
> On Wed, Jul 09 2025 at 17:13, panchuang@vivo.com wrote:
>> Hi tglx and Miqu=C3=A8l, Just a gentle ping on this patchset. I understa=
nd=20
>> you're likely busy with many other tasks, but any feedback or guidance=20
>> on how to proceed would be greatly appreciated. As discussed in the=20
>> previous thread, there was some uncertainty about whether we should=20
>> directly integrate dev_err_probe() into devm_request_threaded_irq(), or=
=20
>> if it's better to create a wrapper function. Thanks for your time!=20
>> Thanks, Panchuang

For simplicity sake just rename the existing functions
devm_request_threaded_irq() and devm_request_any_context_irq() to
__devm_request_threaded_irq() and __devm_request_any_context_irq().

Then create new functions for the API, which

   - invoke the underscore variants
   - and on error invoke dev_err_probe() similar to what I suggested in
     my reply in this thread.

In the rare case of failure, this will print error messages for the
affected drivers both in the core and at the callsite, but that's not
the end of the world.

Then go and remove the random printks from the drivers, once the core
change has hit upstream.

Thanks,

        tglx




