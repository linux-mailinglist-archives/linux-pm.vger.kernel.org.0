Return-Path: <linux-pm+bounces-12064-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 06EAB94E477
	for <lists+linux-pm@lfdr.de>; Mon, 12 Aug 2024 03:22:16 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 30ADB1C20BEC
	for <lists+linux-pm@lfdr.de>; Mon, 12 Aug 2024 01:22:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 699BC49659;
	Mon, 12 Aug 2024 01:22:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=manjaro.org header.i=@manjaro.org header.b="UvNEosSz"
X-Original-To: linux-pm@vger.kernel.org
Received: from mail.manjaro.org (mail.manjaro.org [116.203.91.91])
	(using TLSv1.2 with cipher DHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0C9501EA8D;
	Mon, 12 Aug 2024 01:22:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=116.203.91.91
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723425732; cv=none; b=RG+R1Qgdyds7+gFZAeM06lq8RXgX3zF212bA6Iq3nhCkCFFRqAGIXvsBIijnIZXeypKuAWt6umHbz1HJ6d5rBzlfl2K027liLmfjHT6+QhWJTl16MAfVC9efB9sUohH7LxzTo0kdADC/MrxnrqDkgX9UQM4+uSgqSGDH+2HBS0A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723425732; c=relaxed/simple;
	bh=qzYqKKwqyk5y44/gCG1R9OePQRAqQfShNPTLuQoA4kU=;
	h=MIME-Version:Date:From:To:Cc:Subject:In-Reply-To:References:
	 Message-ID:Content-Type; b=U6S2DGcZklio5+e2m+BwRcuWcK9b1Tg6bZuepRThqrysrD/urv+cqlgoTWx563TQm7CC5Y6nCr2VC99FvM2fJihO/fCcw5rAspJW+Fy7M4tr30nu2APzm1tebbcMYf1fFaDwgjPRrfPPL4Di0xOnGhjETb3tU/syNky+GaL+42I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=manjaro.org; spf=pass smtp.mailfrom=manjaro.org; dkim=pass (2048-bit key) header.d=manjaro.org header.i=@manjaro.org header.b=UvNEosSz; arc=none smtp.client-ip=116.203.91.91
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=manjaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=manjaro.org
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=manjaro.org; s=2021;
	t=1723425725;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=A5fSNqHi9NEqILrnhCWCR3tGDVIu+LDzvUUnKDBNWDM=;
	b=UvNEosSziXo3OIwb8LAWlDOA7gMZRS0gU8LGeBcoAttZl8r13bUVa0J0DAz810IsP4hqEK
	ihDRwja9yYXx4BqV2Ol0YvRngaUi+hKQB4bEbHrDCxi3c+mBPStcfxHSTYB658B1OJIKEb
	tqYlNfa0ZrU7b+g97LC1AXT8UjobuoFh1K/wb4OmZ/hhcfCBZGWF6eX9rSpe6H7D0qOCDy
	YiMlyOGClyet/g00T4Gv/eUub8YLeYVuo3KicN+GEKgux7eYUTjwPO7eD6STdcLnpODw8C
	v+o1nX5JGpcGzfQrvnBSTyXWB9mQP5uVRCPZcBlU4AacFq9k8m+cJtnHwIBr2A==
Date: Mon, 12 Aug 2024 03:22:05 +0200
From: Dragan Simic <dsimic@manjaro.org>
To: Chen-Yu Tsai <wenst@chromium.org>
Cc: Daniel Lezcano <daniel.lezcano@linaro.org>, Amit Kucheria
 <amitk@kernel.org>, Zhang Rui <rui.zhang@intel.com>, Icenowy Zheng
 <uwu@icenowy.me>, Mark Brown <broonie@kernel.org>, linux-pm@vger.kernel.org,
 linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
 linux-sunxi@lists.linux.dev, =?UTF-8?Q?N=C3=ADcolas_F=2E_R=2E_A=2E_Pra?=
 =?UTF-8?Q?do?= <nfraprado@collabora.com>, AngeloGioacchino Del Regno
 <angelogioacchino.delregno@collabora.com>, Matthias Brugger
 <matthias.bgg@gmail.com>, linux-mediatek@lists.infradead.org, Hsin-Te Yuan
 <yuanhsinte@chromium.org>
Subject: Re: [PATCH v2] thermal/of: support thermal zones w/o trips subnode
In-Reply-To: <20240809070822.2835371-1-wenst@chromium.org>
References: <20240809070822.2835371-1-wenst@chromium.org>
Message-ID: <b00273d65dfc4b48cca474784184c62b@manjaro.org>
X-Sender: dsimic@manjaro.org
Content-Type: text/plain; charset=US-ASCII;
 format=flowed
Content-Transfer-Encoding: 7bit
Authentication-Results: ORIGINATING;
	auth=pass smtp.auth=dsimic@manjaro.org smtp.mailfrom=dsimic@manjaro.org

Hello Chen-Yu,

Thanks for the patch.  Please see one comment below.

On 2024-08-09 09:08, Chen-Yu Tsai wrote:
> From: Icenowy Zheng <uwu@icenowy.me>
> 
> Although the current device tree binding of thermal zones require the
> trips subnode, the binding in kernel v5.15 does not require it, and 
> many
> device trees shipped with the kernel, for example,
> allwinner/sun50i-a64.dtsi and mediatek/mt8183-kukui.dtsi in ARM64, 
> still
> comply to the old binding and contain no trips subnode.
> 
> Allow the code to successfully register thermal zones w/o trips subnode
> for DT binding compatibility now.
> 
> Furtherly, the inconsistency between DTs and bindings should be 
> resolved
> by either adding empty trips subnode or dropping the trips subnode
> requirement.
> 
> Fixes: d0c75fa2c17f ("thermal/of: Initialize trip points separately")
> Signed-off-by: Icenowy Zheng <uwu@icenowy.me>
> Reviewed-by: Mark Brown <broonie@kernel.org>
> Signed-off-by: Chen-Yu Tsai <wenst@chromium.org>
> ---
> Resurrecting this patch specifically for MediaTek MT8183 Kukui devices.
> 
> Changes since v1:
> - set *ntrips at beginning of thermal_of_trips_init()
> - Keep goto out_of_node_put in of_get_child_count(trips) == 0 branch
> - Check return value of thermal_of_trips_init(), if it is -ENXIO, print
>   warning and clear |trips| pointer
> - Drop |mask| change, as the variable was removed
> 
> I kept Mark's reviewed-by since the changes are more stylish than
> functional.
> ---
>  drivers/thermal/thermal_of.c | 19 ++++++++++++-------
>  1 file changed, 12 insertions(+), 7 deletions(-)
> 
> diff --git a/drivers/thermal/thermal_of.c 
> b/drivers/thermal/thermal_of.c
> index aa34b6e82e26..f237e74c92fc 100644
> --- a/drivers/thermal/thermal_of.c
> +++ b/drivers/thermal/thermal_of.c
> @@ -128,16 +128,17 @@ static struct thermal_trip
> *thermal_of_trips_init(struct device_node *np, int *n
>  	struct device_node *trips, *trip;
>  	int ret, count;
> 
> +	*ntrips = 0;
>  	trips = of_get_child_by_name(np, "trips");
>  	if (!trips) {
> -		pr_err("Failed to find 'trips' node\n");
> -		return ERR_PTR(-EINVAL);
> +		pr_debug("Failed to find 'trips' node\n");
> +		return ERR_PTR(-ENXIO);
>  	}
> 
>  	count = of_get_child_count(trips);
>  	if (!count) {
> -		pr_err("No trip point defined\n");
> -		ret = -EINVAL;
> +		pr_debug("No trip point defined\n");
> +		ret = -ENXIO;
>  		goto out_of_node_put;
>  	}
> 
> @@ -162,7 +163,6 @@ static struct thermal_trip
> *thermal_of_trips_init(struct device_node *np, int *n
> 
>  out_kfree:
>  	kfree(tt);
> -	*ntrips = 0;
>  out_of_node_put:
>  	of_node_put(trips);

It might be a bit cleaner to keep the "*ntrips = 0" assignment
in the error handling path(s) only, with the positions of the goto
labels adjusted a bit, and then assign -ENXIO to "ret" and jump
to the right label when of_get_child_by_name(np, "trips") fails,
instead of returning from there.

If it's unclear what I'm talking about, please let me know and
I'll send back the proposed hunk.

> @@ -490,8 +490,13 @@ static struct thermal_zone_device
> *thermal_of_zone_register(struct device_node *
> 
>  	trips = thermal_of_trips_init(np, &ntrips);
>  	if (IS_ERR(trips)) {
> -		pr_err("Failed to find trip points for %pOFn id=%d\n", sensor, id);
> -		return ERR_CAST(trips);
> +		if (PTR_ERR(trips) != -ENXIO) {
> +			pr_err("Failed to find trip points for %pOFn id=%d\n", sensor, id);
> +			return ERR_CAST(trips);
> +		}
> +
> +		pr_warn("Failed to find trip points for %pOFn id=%d\n", sensor, id);
> +		trips = NULL;
>  	}
> 
>  	ret = thermal_of_monitor_init(np, &delay, &pdelay);

