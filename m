Return-Path: <linux-pm+bounces-29498-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id E54FCAE81BA
	for <lists+linux-pm@lfdr.de>; Wed, 25 Jun 2025 13:42:54 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 8B92D1648A2
	for <lists+linux-pm@lfdr.de>; Wed, 25 Jun 2025 11:42:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C9F9A25E46A;
	Wed, 25 Jun 2025 11:40:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ragnatech.se header.i=@ragnatech.se header.b="dHYN2eaq";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="lLUqKskn"
X-Original-To: linux-pm@vger.kernel.org
Received: from fout-a6-smtp.messagingengine.com (fout-a6-smtp.messagingengine.com [103.168.172.149])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5195925C82F;
	Wed, 25 Jun 2025 11:40:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.149
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750851658; cv=none; b=WQRfvCFdHnoHR0SENGFSNRNi8E+UZAcj/r3Sd6GcqaCNBVBKgjc89gEDsNkhtptvPmrzNxPvOBqpAmUvOHgOWVpxuQ29+Ry8EptgBfeN1lqiGUlQaYxfeTn8I/niD38MF6ft57L/gE4iJF88uYMCOqnh2jnsQRtGr8rzNaQj9uU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750851658; c=relaxed/simple;
	bh=fCe8dAEl1qm2WUnVfXy0vMiDTlxn0gSlX41YLsl98Ew=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=WdOvccaTli/aGUa/HFoEYRuzvu4ph+4+ck14x+meZQAsizDsZIbCQtoJyMUUMBTx4TkGkRyPgSkCoy5xRiI/yu3qD+5+aWuHeGteV6Lrx9m+ZeIv4eI66mmPRC4fY0hsPBvlVrviOJvZnD1e8vENcn9o6Xu9v+ScbciPSYOmZy8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=ragnatech.se; spf=pass smtp.mailfrom=ragnatech.se; dkim=pass (2048-bit key) header.d=ragnatech.se header.i=@ragnatech.se header.b=dHYN2eaq; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=lLUqKskn; arc=none smtp.client-ip=103.168.172.149
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=ragnatech.se
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ragnatech.se
Received: from phl-compute-11.internal (phl-compute-11.phl.internal [10.202.2.51])
	by mailfout.phl.internal (Postfix) with ESMTP id 6EE64EC02AE;
	Wed, 25 Jun 2025 07:40:55 -0400 (EDT)
Received: from phl-mailfrontend-02 ([10.202.2.163])
  by phl-compute-11.internal (MEProxy); Wed, 25 Jun 2025 07:40:55 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ragnatech.se; h=
	cc:cc:content-transfer-encoding:content-type:content-type:date
	:date:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm1; t=1750851655;
	 x=1750938055; bh=hkEEicwpbjhtLOtMYFCG+ZO9bls8DtRS6RWHYNVwAao=; b=
	dHYN2eaqpUbCsQBvdskvlBzPyzOGMQrmj4qalof8N2ltIX8LroO2NIulms5KHy1p
	42x09yz7BVk4JaeKmzGW8KJRz2gFhR94cbAXoX58c9/+gyxlPYG4aaG+zbxghESk
	Y4MbIZBLLdQ/2C3BalDReUdbjdBV0pTw8wU8tu6B8SJhFoVwN446mhSA43ajT5nL
	p8qut/xIztc6FDSj6Xp4QcjmrCrG6TFcs8WaeZuo6JpA18Y+GpuHqQayTzRbXeGg
	d9Yhkrtsz+xaNE6c/JAyUOmkxY1YRdySBHxezVE+llPFjINVLTOYie4f6CNzL4Kn
	bW/M1YMsIe/dXhx8UdxaZQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm2; t=1750851655; x=
	1750938055; bh=hkEEicwpbjhtLOtMYFCG+ZO9bls8DtRS6RWHYNVwAao=; b=l
	LUqKskn/T8AqN74zd7wugTCUlD2Jf0VbtSkEzC+uGMoJLcP2pn9CZSonC+Kxw5Oi
	CoNit2iwVxSin/icpdoR0AsDQqyhynD482OmwJ0vNZ1CCiu4ikf05b4xmXwwz/LR
	5B/eit4FQxvR/i+Ayk9ndec3jUpThRSUEzfB4LiIw+vKwLCq24X+3ozwZOhJ1pL0
	QUrGqxXZ9n3+5M/RyyKBhrcD4t0dQVpEu7F2kcXACHUzA1ODgSWhFtAvziTUh+U+
	P9wrWPnvPmZWAHb4ypqhKwxp0r1EwNu15Yk9ezUSP2fKZakEtUKJWTKz8NR9Gkpm
	I7xmRsJvNNYzgcna24Lew==
X-ME-Sender: <xms:RuBbaFwDqsgtIgn5b8l-qITtIITnrIuQwI1Y0kutVpXaPdbJ4sossg>
    <xme:RuBbaFQyLljwWrfyYLuN4R79OdGlWFwSUdwVZdE4uEpH2wk546Lv1SQpAQUzaeOL7
    rmr5nhw6ncJz5WVrBQ>
X-ME-Received: <xmr:RuBbaPU9s0F1fiGtvrjNEbOffARih_t7NVqPEN4RlGRaIqU04mgdlX88ybBa63HCsWfYiHCpCBLWMmCaq-jeaos5c4cIjc8b9Q>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeffedrtddvgddvvdeijecutefuodetggdotefrod
    ftvfcurfhrohhfihhlvgemucfhrghsthforghilhdpuffrtefokffrpgfnqfghnecuuegr
    ihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenucfjug
    hrpeffhffvvefukfhfgggtugfgjgesthekredttddtjeenucfhrhhomheppfhikhhlrghs
    ucfunpguvghrlhhunhguuceonhhikhhlrghsrdhsohguvghrlhhunhgusehrrghgnhgrth
    gvtghhrdhsvgeqnecuggftrfgrthhtvghrnhepveetgedtvddvhfdtkeeghfeffeehteeh
    keekgeefjeduieduueelgedtheekkeetnecuvehluhhsthgvrhfuihiivgeptdenucfrrg
    hrrghmpehmrghilhhfrhhomhepnhhikhhlrghsrdhsohguvghrlhhunhgusehrrghgnhgr
    thgvtghhrdhsvgdpnhgspghrtghpthhtohepledpmhhouggvpehsmhhtphhouhhtpdhrtg
    hpthhtohepmhgrrhgvkhdrvhgrshhuthdorhgvnhgvshgrshesmhgrihhlsghogidrohhr
    ghdprhgtphhtthhopehlihhnuhigqdhpmhesvhhgvghrrdhkvghrnhgvlhdrohhrghdprh
    gtphhtthhopehrrghfrggvlheskhgvrhhnvghlrdhorhhgpdhrtghpthhtohepuggrnhhi
    vghlrdhlvgiitggrnhhosehlihhnrghrohdrohhrghdprhgtphhtthhopehgvggvrhhtod
    hrvghnvghsrghssehglhhiuggvrhdrsggvpdhrtghpthhtoheplhhukhgrshiirdhluhgs
    rgesrghrmhdrtghomhdprhgtphhtthhopehmrghgnhhushdruggrmhhmsehgmhgrihhlrd
    gtohhmpdhrtghpthhtoheprhhuihdriihhrghnghesihhnthgvlhdrtghomhdprhgtphht
    thhopehlihhnuhigqdhrvghnvghsrghsqdhsohgtsehvghgvrhdrkhgvrhhnvghlrdhorh
    hg
X-ME-Proxy: <xmx:RuBbaHjrutuNxDznWmawTOtOBL1o11Tk0e4mXdl3Gp3iuhbdEPX1QQ>
    <xmx:RuBbaHDWB90u6h9JvECeAgaqVe21D8QwxsYd9X9Ud_MHCyojNCFapg>
    <xmx:RuBbaAKKJXfyVlpAP6xXUNCSzR_hjqusMlyTSOU3D8yPxBxpivS5WA>
    <xmx:RuBbaGAgb91dEZRUARRj46Qd4K5PgAROxS_qiAI1XPVo_AD1ZYYHsw>
    <xmx:R-BbaGjnhMfd2ypEJoXVEj9wyJwuP_R93VIhaVzPF5BM32mfSHgSY4Gn>
Feedback-ID: i80c9496c:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Wed,
 25 Jun 2025 07:40:54 -0400 (EDT)
Date: Wed, 25 Jun 2025 13:40:53 +0200
From: Niklas =?utf-8?Q?S=C3=B6derlund?= <niklas.soderlund@ragnatech.se>
To: Marek Vasut <marek.vasut+renesas@mailbox.org>
Cc: linux-pm@vger.kernel.org, "Rafael J. Wysocki" <rafael@kernel.org>,
	Daniel Lezcano <daniel.lezcano@linaro.org>,
	Geert Uytterhoeven <geert+renesas@glider.be>,
	Lukasz Luba <lukasz.luba@arm.com>,
	Magnus Damm <magnus.damm@gmail.com>,
	Zhang Rui <rui.zhang@intel.com>, linux-renesas-soc@vger.kernel.org
Subject: Re: [PATCH 2/2] thermal: rcar_gen3: Add support for R-Car V4H
 default trim values
Message-ID: <20250625114053.GB854038@ragnatech.se>
References: <20250625100116.7538-1-marek.vasut+renesas@mailbox.org>
 <20250625100116.7538-2-marek.vasut+renesas@mailbox.org>
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20250625100116.7538-2-marek.vasut+renesas@mailbox.org>

Hi Marek,

Thanks for your patch.

On 2025-06-25 11:59:59 +0200, Marek Vasut wrote:
> Add default trimming values for the four temperature sensors located
> in Renesas R-Car V4H Working Sample SoC. The trimming values are
> identical for all four THS temperature sensors.
> 
> Signed-off-by: Marek Vasut <marek.vasut+renesas@mailbox.org>
> ---
> Cc: "Niklas Söderlund" <niklas.soderlund@ragnatech.se>
> Cc: "Rafael J. Wysocki" <rafael@kernel.org>
> Cc: Daniel Lezcano <daniel.lezcano@linaro.org>
> Cc: Geert Uytterhoeven <geert+renesas@glider.be>
> Cc: Lukasz Luba <lukasz.luba@arm.com>
> Cc: Magnus Damm <magnus.damm@gmail.com>
> Cc: Zhang Rui <rui.zhang@intel.com>
> Cc: linux-pm@vger.kernel.org
> Cc: linux-renesas-soc@vger.kernel.org
> ---
>  drivers/thermal/renesas/rcar_gen3_thermal.c | 21 ++++++++++++++++++++-
>  1 file changed, 20 insertions(+), 1 deletion(-)
> 
> diff --git a/drivers/thermal/renesas/rcar_gen3_thermal.c b/drivers/thermal/renesas/rcar_gen3_thermal.c
> index a388bd3135e4..f361991e9651 100644
> --- a/drivers/thermal/renesas/rcar_gen3_thermal.c
> +++ b/drivers/thermal/renesas/rcar_gen3_thermal.c
> @@ -372,6 +372,17 @@ static const struct rcar_gen3_thermal_fuse_default_info
>  	},
>  };
>  
> +static const struct rcar_gen3_thermal_fuse_default_info
> +	rcar_gen3_thermal_fuse_default_info_v4h = {

This could fit on one line (even without the symbol rename suggested in 
1/2).

> +	.ptat = { 3274, 2164, 985 },
> +	.thcodes = { /* All four THS units share the same trimming */
> +		{ 3218, 2617, 1980 },
> +		{ 3218, 2617, 1980 },
> +		{ 3218, 2617, 1980 },
> +		{ 3218, 2617, 1980 },
> +	}
> +};
> +

I can't review the values themself, but testing on V4H the readout looks 
good! With the line length nit-pick comment above fixed,

Reviewed-by: Niklas Söderlund <niklas.soderlund+renesas@ragnatech.se>

>  static const struct rcar_thermal_info rcar_m3w_thermal_info = {
>  	.scale = 157,
>  	.adj_below = -41,
> @@ -396,6 +407,14 @@ static const struct rcar_thermal_info rcar_gen4_thermal_info = {
>  	.fuse_defaults = &rcar_gen3_thermal_fuse_default_info_gen3,
>  };
>  
> +static const struct rcar_thermal_info rcar_v4h_thermal_info = {
> +	.scale = 167,
> +	.adj_below = -41,
> +	.adj_above = 126,
> +	.fuses = &rcar_gen3_thermal_fuse_info_gen4,
> +	.fuse_defaults = &rcar_gen3_thermal_fuse_default_info_v4h,
> +};
> +
>  static const struct of_device_id rcar_gen3_thermal_dt_ids[] = {
>  	{
>  		.compatible = "renesas,r8a774a1-thermal",
> @@ -439,7 +458,7 @@ static const struct of_device_id rcar_gen3_thermal_dt_ids[] = {
>  	},
>  	{
>  		.compatible = "renesas,r8a779g0-thermal",
> -		.data = &rcar_gen4_thermal_info,
> +		.data = &rcar_v4h_thermal_info,
>  	},
>  	{
>  		.compatible = "renesas,r8a779h0-thermal",
> -- 
> 2.47.2
> 

-- 
Kind Regards,
Niklas Söderlund

