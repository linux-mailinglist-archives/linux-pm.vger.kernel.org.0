Return-Path: <linux-pm+bounces-376-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 6C5BA7FBCCB
	for <lists+linux-pm@lfdr.de>; Tue, 28 Nov 2023 15:33:21 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 27D10282D01
	for <lists+linux-pm@lfdr.de>; Tue, 28 Nov 2023 14:33:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A19FC4F608;
	Tue, 28 Nov 2023 14:33:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dkim=none
X-Original-To: linux-pm@vger.kernel.org
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by lindbergh.monkeyblade.net (Postfix) with ESMTP id 6B9E818D;
	Tue, 28 Nov 2023 06:33:16 -0800 (PST)
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 91544C15;
	Tue, 28 Nov 2023 06:34:03 -0800 (PST)
Received: from donnerap.manchester.arm.com (usa-sjc-imap-foss1.foss.arm.com [10.121.207.14])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 6D2373F6C4;
	Tue, 28 Nov 2023 06:33:13 -0800 (PST)
Date: Tue, 28 Nov 2023 14:33:09 +0000
From: Andre Przywara <andre.przywara@arm.com>
To: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Cc: Vasily Khoruzhick <anarsoul@gmail.com>, Yangtao Li
 <tiny.windzz@gmail.com>, Chen-Yu Tsai <wens@csie.org>, Jernej Skrabec
 <jernej.skrabec@gmail.com>, Samuel Holland <samuel@sholland.org>, "Rafael J
 . Wysocki" <rafael@kernel.org>, Daniel Lezcano <daniel.lezcano@linaro.org>,
 Zhang Rui <rui.zhang@intel.com>, Lukasz Luba <lukasz.luba@arm.com>, Rob
 Herring <robh+dt@kernel.org>, Krzysztof Kozlowski
 <krzysztof.kozlowski+dt@linaro.org>, Conor Dooley <conor+dt@kernel.org>,
 Martin Botka <martin.botka@somainline.org>, Bob McChesney
 <bob@electricworry.net>, linux-pm@vger.kernel.org,
 devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
 linux-sunxi@lists.linux.dev, Icenowy Zheng <icenowy@aosc.io>
Subject: Re: [PATCH v3 4/6] thermal: sun8i: add syscon register access code
Message-ID: <20231128143309.38a4ce61@donnerap.manchester.arm.com>
In-Reply-To: <ddceb30f-1778-4312-af91-97813fe3c6fb@linaro.org>
References: <20231128005849.19044-1-andre.przywara@arm.com>
	<20231128005849.19044-5-andre.przywara@arm.com>
	<ddceb30f-1778-4312-af91-97813fe3c6fb@linaro.org>
Organization: ARM
X-Mailer: Claws Mail 3.18.0 (GTK+ 2.24.32; aarch64-unknown-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Tue, 28 Nov 2023 08:43:32 +0100
Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org> wrote:

Hi,

> On 28/11/2023 01:58, Andre Przywara wrote:
> >  
> > +static struct regmap *sun8i_ths_get_syscon_regmap(struct device_node *node)
> > +{
> > +	struct device_node *syscon_node;
> > +	struct platform_device *syscon_pdev;
> > +	struct regmap *regmap = NULL;
> > +
> > +	syscon_node = of_parse_phandle(node, "syscon", 0);  
> 
> Nope. For the 100th time, this cannot be generic.

OK. Shall this name refer to the required functionality (temperature
offset fix) or to the target syscon node (like allwinner,misc-syscon).
The problem is that this is really a syscon, as in: "random collection of
bits that we didn't know where else to put in", so "syscon" alone actually
says it all.


And btw: it would have been about the same effort (and more helpful!) to
type:

"This cannot be generic, please check writing-bindings.rst."    ;-)

> 
> > +	if (!syscon_node)
> > +		return ERR_PTR(-ENODEV);
> > +
> > +	syscon_pdev = of_find_device_by_node(syscon_node);
> > +	if (!syscon_pdev) {
> > +		/* platform device might not be probed yet */
> > +		regmap = ERR_PTR(-EPROBE_DEFER);
> > +		goto out_put_node;
> > +	}
> > +
> > +	/* If no regmap is found then the other device driver is at fault */
> > +	regmap = dev_get_regmap(&syscon_pdev->dev, NULL);
> > +	if (!regmap)
> > +		regmap = ERR_PTR(-EINVAL);  
> 
> Aren't you open-coding existing API to get regmap from syscon?

That's a good point, I lifted that code from sun8i-emac.c, where we have
the exact same problem. 
Unfortunately syscon_regmap_lookup_by_phandle() requires the syscon DT
node to have "syscon" in its compatible string list, which we
don't have. We actually explicitly dropped this for the A64 (with
1f1f5183981d70bf0950), and never added this for later SoCs in the first place.
I guess we could add it back, and it would work for this case here (tested
that), but then cannot replace the sun8i-emac.c code, because that would
break older DTs.
So is there any chance we can drop the requirement for "syscon" in the
compatible string list, in the implementation of
syscon_regmap_lookup_by_phandle()? Maybe optionally, using a different
prototype? Or is there another existing API that does this already?

Cheers,
Andre

