Return-Path: <linux-pm+bounces-29422-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id D497CAE62B0
	for <lists+linux-pm@lfdr.de>; Tue, 24 Jun 2025 12:40:19 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id D9E663A8ACD
	for <lists+linux-pm@lfdr.de>; Tue, 24 Jun 2025 10:39:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 03FDF2874EA;
	Tue, 24 Jun 2025 10:40:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="v1IFWcFr";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="3q5D0uT4"
X-Original-To: linux-pm@vger.kernel.org
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 24A19279DC8;
	Tue, 24 Jun 2025 10:40:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750761607; cv=none; b=jBdUwDUNri/EOqrm5kjsjiAoJcepYN1RPBHtUPlcI+utZrX4vHGKC8JrfQu7eLk2nZeBez4VVwFHyE1Nb0oKhCptOrJFV/PR/KC60JE9i6+vB0CalgZaD4of8bzBqCRDb8zBo00+kmDjhzkKw8OBYqaEg5PQL6t1y7DxZOHmoug=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750761607; c=relaxed/simple;
	bh=f8XsI5O1CkfkYFDeROjVLKjcyy9Tl6y4vwZNlHiFsyg=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=RASDgoa9P94TdrpI1W91tg257cW/56rp4OpUy1zGOud0g3K4yQHxX0S4NnDqFOXPTzt99DWWTo4mV97PZ3foJ8ibEnxBZ//EsgrT5YL4ywINwv7OWiwl33cu2UxteQ3f9FGjaOS1iko2dDIx3jJQEq8DLUa4qCf2dMEoKJLqbXg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=v1IFWcFr; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=3q5D0uT4; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
From: Thomas Gleixner <tglx@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1750761604;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=PmKtYLO9DDYaj9Me5RnB2od40m2nfSC9/3iVyLRTgPc=;
	b=v1IFWcFrbObYtAZ/RT0Kppv2+R1ysQJUiAOhyBDBdBD7GRafKVhWIJlEp4M1/MAbW7r3Ca
	o8ExT+FJNwE1MLi5ZHj7mixRk7DPF7y0JESsK+b/BXPx0H36L3GknAlPGKQ80sDZSd8kX8
	c7tk3xzYOhkh9+PB8l0sOAqBJbObspXXOYombtNTWorYQc/dnlFuIdXCWjoZNydWHsEEfw
	BxAB1cxurgSdDrVSKVwi91WSkw72/7/zhYIxKx2zfbMR8WyyBWVel7X/khQj5qlBzANr+W
	waHxljQ3WDmwbOBvDQ6fj/PD/LbBRXtKBrQTzgU9iEnxcn0NlO2wYO/ak4OZtw==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1750761604;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=PmKtYLO9DDYaj9Me5RnB2od40m2nfSC9/3iVyLRTgPc=;
	b=3q5D0uT4oSfP2VhfCp/l4dQktoBuSpc64H38sBuCNB8bE8D63GfRugryCyLDa3R+2guT87
	o5CUyJOaQUdlplCw==
To: Pan Chuang <panchuang@vivo.com>, "Rafael J. Wysocki"
 <rafael@kernel.org>, Daniel Lezcano <daniel.lezcano@linaro.org>, Zhang Rui
 <rui.zhang@intel.com>, Lukasz Luba <lukasz.luba@arm.com>, Miquel Raynal
 <miquel.raynal@bootlin.com>, Markus Mayer <mmayer@broadcom.com>, Broadcom
 internal kernel review list <bcm-kernel-feedback-list@broadcom.com>,
 Florian Fainelli <florian.fainelli@broadcom.com>, Shawn Guo
 <shawnguo@kernel.org>, Sascha Hauer <s.hauer@pengutronix.de>, Pengutronix
 Kernel Team <kernel@pengutronix.de>, Fabio Estevam <festevam@gmail.com>,
 zhanghongchen <zhanghongchen@loongson.cn>, Yinbo Zhu
 <zhuyinbo@loongson.cn>, Amit Kucheria <amitk@kernel.org>, Thara Gopinath
 <thara.gopinath@gmail.com>, Niklas =?utf-8?Q?S=C3=B6derlund?=
 <niklas.soderlund@ragnatech.se>, Geert Uytterhoeven
 <geert+renesas@glider.be>, Magnus Damm <magnus.damm@gmail.com>, Heiko
 Stuebner <heiko@sntech.de>, Bartlomiej Zolnierkiewicz
 <bzolnier@gmail.com>, Krzysztof Kozlowski <krzk@kernel.org>, Alim Akhtar
 <alim.akhtar@samsung.com>, Maxime Coquelin <mcoquelin.stm32@gmail.com>,
 Alexandre Torgue <alexandre.torgue@foss.st.com>, Vasily Khoruzhick
 <anarsoul@gmail.com>, Yangtao Li <tiny.windzz@gmail.com>, Chen-Yu Tsai
 <wens@csie.org>, Jernej Skrabec <jernej.skrabec@gmail.com>, Samuel Holland
 <samuel@sholland.org>, Thierry Reding <thierry.reding@gmail.com>, Jonathan
 Hunter <jonathanh@nvidia.com>, Kunihiko Hayashi
 <hayashi.kunihiko@socionext.com>, Masami Hiramatsu <mhiramat@kernel.org>,
 Matthias Brugger <matthias.bgg@gmail.com>, AngeloGioacchino Del Regno
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
 Jonathan Cameron <Jonathan.Cameron@huawei.com>, "Jiri Slaby (SUSE)"
 <jirislaby@kernel.org>, Sebastian Andrzej Siewior <bigeasy@linutronix.de>,
 Andrew Morton <akpm@linux-foundation.org>, Costa Shulyupin
 <costa.shul@redhat.com>, Yury Norov <yury.norov@gmail.com>, Cheng-Yang
 Chou <yphbchou0911@gmail.com>, Caleb Sander Mateos
 <csander@purestorage.com>, linux-pm@vger.kernel.org,
 linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
 imx@lists.linux.dev, linux-arm-msm@vger.kernel.org,
 linux-renesas-soc@vger.kernel.org, linux-rockchip@lists.infradead.org,
 linux-samsung-soc@vger.kernel.org,
 linux-stm32@st-md-mailman.stormreply.com, linux-sunxi@lists.linux.dev,
 linux-tegra@vger.kernel.org, linux-mediatek@lists.infradead.org
Cc: Yangtao Li <frank.li@vivo.com>, Uwe =?utf-8?Q?Kleine-K=C3=B6nig?=
 <u.kleine-koenig@pengutronix.de>, Jonathan Cameron
 <Jonathan.Cameron@Huawei.com>, Pan Chuang <panchuang@vivo.com>
Subject: Re: [PATCH v6 01/24] genirq/devres: Add
 devm_request_threaded_irq_probe() and devm_request_irq_probe()
In-Reply-To: <20250623123054.472216-2-panchuang@vivo.com>
References: <20250623123054.472216-1-panchuang@vivo.com>
 <20250623123054.472216-2-panchuang@vivo.com>
Date: Tue, 24 Jun 2025 10:13:10 +0200
Message-ID: <87h605o8vd.ffs@tglx>
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

On Mon, Jun 23 2025 at 20:30, Pan Chuang wrote:
> +/**
> + * devm_request_threaded_irq_probe - request irq for a managed device with error msg (recommended in probe)
> + * @dev:	Device to request interrupt for
> + * @irq:	Interrupt line to allocate
> + * @handler:	Function to be called when the IRQ occurs
> + * @thread_fn:	Function to be called in a threaded interrupt context. NULL
> + *		for devices which handle everything in @handler
> + * @irqflags:	Interrupt type flags
> + * @devname:	An ascii name for the claiming device, dev_name(dev) if NULL
> + * @dev_id:	A cookie passed back to the handler function
> + * @info:	Optional additional error log
> + *
> + * This is a variant of the devm_request_threaded_irq function.
> + * It will print an error message by default when the request fails,
> + * and the consumer can add a special error msg.
> + *
> + * Except for the extra @info argument, this function takes the
> + * same arguments and performs the same function as
> + * devm_request_threaded_irq(). IRQs requested with this function will be
> + * automatically freed on driver detach.

I really have to ask why you need the extra info argument. It's not
providing any really value.

What's important when the interrupt request fails?

    1) The device, which is identifiable by @devname and/or dev_name(@dev)

    2) The interrupt number

    3) The error code

If you want to be more expressive then you can also print out the
handler function symbols, which makes it even more useful to map back
into the affected driver.

As you cited correctly I said back then:

  "So there is certainly an argument to be made that this particular
   function should print a well formatted and informative error
   message."

This particular function is: devm_request_threaded_irq().

IOW, I did not ask you should go an create a new one, right?

The extra @info argument is just proliferating the nonsensical
information which driver developers put into the output. I just looked
through a couple of your thermal patches (hint, I had to chase them
manually because you failed to thread them properly). While most of them
provide NULL, the two adding 'alarm' are really not providing any useful
information.

The point is, that the information is aimed at developers and not to be
helpful for Joe User to identify/fix a problem. If the driver
developer/maintainer is not able to track back the information (name,
number, error code) to the driver in question, then the added "foo" info
is not going to make him any smarter.

If that happens, then being able to map it back to the driver is only 1%
of the problem analysis, simply because you need to decode the
underlying problem (DT, vector exhaustion, memory exhaustion ....) to be
able to address it.

So just make devm_request.*irq() emit a uniform and informative message
on fail and you can go and remove all the homebrewn useless error prints
from the drivers.

It does not matter at all if there are duplicated error messages for a
release or two until all drivers have been cleaned up. This is not the
common case and only rarely triggered. So what?

> +int devm_request_threaded_irq_probe(struct device *dev, unsigned int irq,
> +				    irq_handler_t handler, irq_handler_t thread_fn,
> +				    unsigned long irqflags, const char *devname,
> +				    void *dev_id, const char *info)
> +{
> +	int rc;
> +
> +	rc = devm_request_threaded_irq(dev, irq, handler, NULL, irqflags, devname, dev_id);

This is just wrong as you fail to hand in thread_fn.

Q: How was this code ever tested?
A: Not at all.

> Could you please consider merging the entire series into your branch? 

You're seriously asking that for something which is so obviously broken?

> +	if (rc) {
> +		return dev_err_probe(dev, rc, "Failed to request %sinterrupt %u %s %s\n",
> +				     thread_fn ? "threaded " : "", irq, devname ? : dev_name(dev),
> +				     info ? : "");

This is wrong too because devm_request_threaded_irq() allows you to hand
in both a hard interrupt and a threaded handler and either one of them
can be NULL.

So what you want to add in devm_request_threaded_irq() is something like
this:

	if (rc < 0) {
		return dev_err_probe(dev, rc, "request_irq(%u) %pS %pS %s\n",
                        	     handler, thread_fn, devname ? : "");
        }

dev_err_probe() already prefixes the caller string with 'error ', so
there is no need for a lenghty 'failed to request ....' novel.

Thanks,

        tglx

