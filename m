Return-Path: <linux-pm+bounces-29495-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 322C1AE80A0
	for <lists+linux-pm@lfdr.de>; Wed, 25 Jun 2025 13:10:36 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id C599A3A9D08
	for <lists+linux-pm@lfdr.de>; Wed, 25 Jun 2025 11:10:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 877B22BD58A;
	Wed, 25 Jun 2025 11:10:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ragnatech.se header.i=@ragnatech.se header.b="dQmPgMH3";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="VLtwbBhy"
X-Original-To: linux-pm@vger.kernel.org
Received: from fout-a6-smtp.messagingengine.com (fout-a6-smtp.messagingengine.com [103.168.172.149])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 68E571E1C3F;
	Wed, 25 Jun 2025 11:10:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.149
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750849831; cv=none; b=hICqJ1scXYJChvNRhFvnpw9vCp/DrMdOv6bfC2rlIcKWs+6Q+C8VtffxrlJIaIGROuzQJQ6Ol59+Hm7C7oN48Zq3nAKNNf11sZmCSFTs3QYJBp+FfaUITJcjcsvYZLoKJb3qAg4ciFTvGyL70wINdfVOe3qFVg32yPiB3DOjKeQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750849831; c=relaxed/simple;
	bh=XT+EwPD4OgKIgCidfsqog4gzyYrb031nl7652LHFA+I=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=FbAarGURno4Ubr07DCjm91M+gmxQrhzA1qVgYQEYd+yWqBxIC5oq9UkFRbGiGtEXEO/HL96DvbCOZzENLVPOhS7mMqR+TT2dKhHNm/z/7zMt3EhZh45C2eynpzIAjea2+1gEaprrq+zUXFIwSrEohmbywH+29lDGd2Wtqse8EcY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=ragnatech.se; spf=pass smtp.mailfrom=ragnatech.se; dkim=pass (2048-bit key) header.d=ragnatech.se header.i=@ragnatech.se header.b=dQmPgMH3; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=VLtwbBhy; arc=none smtp.client-ip=103.168.172.149
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=ragnatech.se
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ragnatech.se
Received: from phl-compute-12.internal (phl-compute-12.phl.internal [10.202.2.52])
	by mailfout.phl.internal (Postfix) with ESMTP id 45B4BEC0292;
	Wed, 25 Jun 2025 07:10:27 -0400 (EDT)
Received: from phl-mailfrontend-02 ([10.202.2.163])
  by phl-compute-12.internal (MEProxy); Wed, 25 Jun 2025 07:10:27 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ragnatech.se; h=
	cc:cc:content-transfer-encoding:content-type:content-type:date
	:date:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm1; t=1750849827;
	 x=1750936227; bh=pfz7ME3gmVUD4gHhu/odMLYpeYC9QIWk3tsj5/f8bRE=; b=
	dQmPgMH3SQYrbOnd4o9OEI2mbO0FBWMlwDmH4pearvPMsLxrXNP0fIlHZl03Qdlh
	v20nmE61iXP+9ZV2E2LrYcAnUHCwZArQSlKVoFb1wCSlmf7TtFIQ2cyrfFWZBh0L
	MRY5SHykz1tp/jCVgQm50Mn8yvv69gCS6xqUw1+LupWedZVJYr7PyGeRB2yanQpc
	KnPygzNNLX8wSZuwkyvNWeWva05t5IObOMU9MOkGg1Ybm2c+5zZl8o1GNExI62bA
	RG0ybaqo3SktS1kb2gGA42OoW/Xxzo0/RZT6GeQvVeaCzMiUKQbw9a3op8bjEEH3
	6z/oe88sL4mxNIE+bmK1QQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm2; t=1750849827; x=
	1750936227; bh=pfz7ME3gmVUD4gHhu/odMLYpeYC9QIWk3tsj5/f8bRE=; b=V
	LtwbBhyFep8zGcZ/H3hDNt7qhtSwvR1rOW7Tbzh+m9gV7wfFb6R0D6G1oXkpJ87A
	LPX7LWfqYisSdkwxzZ8NklT6ybgwR2sEmiNJIre6fGt4xi7ZSVQedAkfeT1rAERZ
	ZQ/54cyMwW1bPW8xa0FD/ps84N8QekbN5xSKzA+RoH3QtY0yG2IfXMoZylRkIwKZ
	uOkDrxDdFbhrZqo6UsvtYKgRPntEVHH2iNhL9Lesnrxu+vslGRCEvaPNi5aoYEYJ
	FyojSBQ/cqzYnrNsESWTYcdFiOk/F6NZ46tVgVm+NI8fZ0IgJ8ifB9X4CvDmCUE5
	wYImr62d+kRFjl2w0nHjg==
X-ME-Sender: <xms:ItlbaG8K6_ljU3apPcYci3q-kwXdVQEhO0G8PREQsoK3Jy4aSuIoLA>
    <xme:ItlbaGtHvbwxXnA94rvzxe7D0UGxCI1nzBoQ0u55scxchX1LuvuxO7TkkQuYHzOO9
    CmBLx_d1QjCisMiiUY>
X-ME-Received: <xmr:ItlbaMDixQKsceSZPuutL6PpVsPvL9S3YVnkwxt34mkht4rGcwiZyvkijIZtRgBLW-b49evRDtoCR94A1-BrWzriIMo9EVcVng>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeffedrtddvgddvvdeiudcutefuodetggdotefrod
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
X-ME-Proxy: <xmx:ItlbaOd33cVm7FM2GAEKt1LxbzFKmRNcK-aU4zgQGYoewesAFTHMFA>
    <xmx:ItlbaLNbPVAVzcVy74QajidDLQq9QAXvi4Of7WvIdUucOWpnvnObLg>
    <xmx:ItlbaIl5bY4-8WIw9UMsf22uXx3z9xW-T6zvfT-7DnaQJftSEpOCKw>
    <xmx:ItlbaNtmt0oBFIWosiJ38HEo0XSt4WjTJTTQ-8LWs9SvW9gWmQptBw>
    <xmx:I9lbaLcnin9YYA1hOIo0B0PF7MH8bcsg1MtjwKUg5pIVTUV3W3yXcKpu>
Feedback-ID: i80c9496c:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Wed,
 25 Jun 2025 07:10:26 -0400 (EDT)
Date: Wed, 25 Jun 2025 13:10:24 +0200
From: Niklas =?utf-8?Q?S=C3=B6derlund?= <niklas.soderlund@ragnatech.se>
To: Marek Vasut <marek.vasut+renesas@mailbox.org>
Cc: linux-pm@vger.kernel.org, "Rafael J. Wysocki" <rafael@kernel.org>,
	Daniel Lezcano <daniel.lezcano@linaro.org>,
	Geert Uytterhoeven <geert+renesas@glider.be>,
	Lukasz Luba <lukasz.luba@arm.com>,
	Magnus Damm <magnus.damm@gmail.com>,
	Zhang Rui <rui.zhang@intel.com>, linux-renesas-soc@vger.kernel.org
Subject: Re: [PATCH 1/2] thermal: rcar_gen3: Add support for per-SoC default
 trim values
Message-ID: <20250625111024.GA854038@ragnatech.se>
References: <20250625100116.7538-1-marek.vasut+renesas@mailbox.org>
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20250625100116.7538-1-marek.vasut+renesas@mailbox.org>

Hi Marek,

Thanks for your work!

On 2025-06-25 11:59:58 +0200, Marek Vasut wrote:
> The Working Sample R-Car SoCs may not yet have thermal sensor trimming
> values programmed into fuses, those fuses are blank instead. For such
> SoCs, the driver includes fallback trimming values. Those values are
> currently applied to all SoCs which use this driver.
> 
> Introduce support for per-SoC fallback trimming values in preparation
> for SoCs which do not use these current trimming values. No functional
> change is intended here.

I like the change, only have one bikeshedding comment about naming.

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
>  drivers/thermal/renesas/rcar_gen3_thermal.c | 42 ++++++++++++++-------
>  1 file changed, 28 insertions(+), 14 deletions(-)
> 
> diff --git a/drivers/thermal/renesas/rcar_gen3_thermal.c b/drivers/thermal/renesas/rcar_gen3_thermal.c
> index 24a702ee4c1f..a388bd3135e4 100644
> --- a/drivers/thermal/renesas/rcar_gen3_thermal.c
> +++ b/drivers/thermal/renesas/rcar_gen3_thermal.c
> @@ -73,11 +73,17 @@ struct rcar_gen3_thermal_fuse_info {
>  	u32 mask;
>  };
>  
> +struct rcar_gen3_thermal_fuse_default_info {

Maybe call this 'rcar_gen3_thermal_fuse_default' to reduce the symbol 
length. In retrospect picking the preifx 'rcar_gen3_thermal_' was a 
really bad idea on my part...

> +	u32 ptat[3];
> +	u32 thcodes[TSC_MAX_NUM][3];
> +};
> +
>  struct rcar_thermal_info {
>  	int scale;
>  	int adj_below;
>  	int adj_above;
>  	const struct rcar_gen3_thermal_fuse_info *fuses;
> +	const struct rcar_gen3_thermal_fuse_default_info *fuse_defaults;
>  };
>  
>  struct equation_set_coef {
> @@ -289,6 +295,7 @@ static void rcar_gen3_thermal_fetch_fuses(struct rcar_gen3_thermal_priv *priv)
>  
>  static bool rcar_gen3_thermal_read_fuses(struct rcar_gen3_thermal_priv *priv)
>  {
> +	const struct rcar_gen3_thermal_fuse_default_info *fuse_defaults = priv->info->fuse_defaults;
>  	unsigned int i;
>  	u32 thscp;
>  
> @@ -297,24 +304,16 @@ static bool rcar_gen3_thermal_read_fuses(struct rcar_gen3_thermal_priv *priv)
>  	if (!priv->info->fuses ||
>  	    (thscp & THSCP_COR_PARA_VLD) != THSCP_COR_PARA_VLD) {
>  		/* Default THCODE values in case FUSEs are not set. */
> -		static const int thcodes[TSC_MAX_NUM][3] = {
> -			{ 3397, 2800, 2221 },
> -			{ 3393, 2795, 2216 },
> -			{ 3389, 2805, 2237 },
> -			{ 3415, 2694, 2195 },
> -			{ 3356, 2724, 2244 },
> -		};
> -
> -		priv->ptat[0] = 2631;
> -		priv->ptat[1] = 1509;
> -		priv->ptat[2] = 435;
> +		priv->ptat[0] = fuse_defaults->ptat[0];
> +		priv->ptat[1] = fuse_defaults->ptat[1];
> +		priv->ptat[2] = fuse_defaults->ptat[2];
>  
>  		for (i = 0; i < priv->num_tscs; i++) {
>  			struct rcar_gen3_thermal_tsc *tsc = priv->tscs[i];
>  
> -			tsc->thcode[0] = thcodes[i][0];
> -			tsc->thcode[1] = thcodes[i][1];
> -			tsc->thcode[2] = thcodes[i][2];
> +			tsc->thcode[0] = fuse_defaults->thcodes[i][0];
> +			tsc->thcode[1] = fuse_defaults->thcodes[i][1];
> +			tsc->thcode[2] = fuse_defaults->thcodes[i][2];
>  		}
>  
>  		return false;
> @@ -361,11 +360,24 @@ static const struct rcar_gen3_thermal_fuse_info rcar_gen3_thermal_fuse_info_gen4
>  	.mask = GEN4_FUSE_MASK,
>  };
>  
> +static const struct rcar_gen3_thermal_fuse_default_info
> +	rcar_gen3_thermal_fuse_default_info_gen3 = {

With the names adjusted above this could be

static const struct rcar_gen3_thermal_fuse_default rcar_gen3_thermal_fuses_default_gen3 = {

And that would fit the 100 char limit. We have lines that are 100 chars 
long already in the file, so this is fine IMHO. Again having such a long 
prefix string was a bad idea, sorry about that.

With this addressed,

Reviewed-by: Niklas Söderlund <niklas.soderlund+renesas@ragnatech.se>

> +	.ptat = { 2631, 1509, 435 },
> +	.thcodes = {
> +		{ 3397, 2800, 2221 },
> +		{ 3393, 2795, 2216 },
> +		{ 3389, 2805, 2237 },
> +		{ 3415, 2694, 2195 },
> +		{ 3356, 2724, 2244 },
> +	},
> +};
> +
>  static const struct rcar_thermal_info rcar_m3w_thermal_info = {
>  	.scale = 157,
>  	.adj_below = -41,
>  	.adj_above = 116,
>  	.fuses = &rcar_gen3_thermal_fuse_info_gen3,
> +	.fuse_defaults = &rcar_gen3_thermal_fuse_default_info_gen3,
>  };
>  
>  static const struct rcar_thermal_info rcar_gen3_thermal_info = {
> @@ -373,6 +385,7 @@ static const struct rcar_thermal_info rcar_gen3_thermal_info = {
>  	.adj_below = -41,
>  	.adj_above = 126,
>  	.fuses = &rcar_gen3_thermal_fuse_info_gen3,
> +	.fuse_defaults = &rcar_gen3_thermal_fuse_default_info_gen3,
>  };
>  
>  static const struct rcar_thermal_info rcar_gen4_thermal_info = {
> @@ -380,6 +393,7 @@ static const struct rcar_thermal_info rcar_gen4_thermal_info = {
>  	.adj_below = -41,
>  	.adj_above = 126,
>  	.fuses = &rcar_gen3_thermal_fuse_info_gen4,
> +	.fuse_defaults = &rcar_gen3_thermal_fuse_default_info_gen3,
>  };
>  
>  static const struct of_device_id rcar_gen3_thermal_dt_ids[] = {
> -- 
> 2.47.2
> 

-- 
Kind Regards,
Niklas Söderlund

