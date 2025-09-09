Return-Path: <linux-pm+bounces-34278-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 44054B4FFE4
	for <lists+linux-pm@lfdr.de>; Tue,  9 Sep 2025 16:46:56 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 965E73B5030
	for <lists+linux-pm@lfdr.de>; Tue,  9 Sep 2025 14:46:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0053F338F23;
	Tue,  9 Sep 2025 14:46:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ragnatech.se header.i=@ragnatech.se header.b="D3BeZ5d+";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="YtxD6xFJ"
X-Original-To: linux-pm@vger.kernel.org
Received: from fout-b7-smtp.messagingengine.com (fout-b7-smtp.messagingengine.com [202.12.124.150])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 913462BB1D;
	Tue,  9 Sep 2025 14:46:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.150
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757429197; cv=none; b=LoV5oEXop+NpY/mQ3EQabVG2v7e7ulwGq6joe4bvqxCvV15ZzXigidgvxitQB2/A85AdbVEm5mahBGRfP7x5nyKR21edlA4lZzK1jnNivzWMRj9piqnm1XzGispZtsDJPqDZqHv4WAGjIjUpsu4DBMFbfcDBumhMrQltLBalUso=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757429197; c=relaxed/simple;
	bh=0FwGvXrE9mDL/Ts/ITnh/0I1/PCaLAXKwi5AbezrR3Q=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=qrl6zJAjArIfcZ2YT7qwx1AziPl/lQRKUg14mmDmLV2eX29sQsLpkX1lCbult0kNo9JaLjE4jmsZKoDqm9k508G5TGeia+Ty6YZwI9MxbgjdADriYkOYRzFNC6rHBkMHTSHwm+1X2HVnq4Ggbgry2121XfVcUVyLNSV9HrUSHDI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=ragnatech.se; spf=pass smtp.mailfrom=ragnatech.se; dkim=pass (2048-bit key) header.d=ragnatech.se header.i=@ragnatech.se header.b=D3BeZ5d+; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=YtxD6xFJ; arc=none smtp.client-ip=202.12.124.150
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=ragnatech.se
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ragnatech.se
Received: from phl-compute-04.internal (phl-compute-04.internal [10.202.2.44])
	by mailfout.stl.internal (Postfix) with ESMTP id 649481D000C5;
	Tue,  9 Sep 2025 10:46:34 -0400 (EDT)
Received: from phl-mailfrontend-01 ([10.202.2.162])
  by phl-compute-04.internal (MEProxy); Tue, 09 Sep 2025 10:46:34 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ragnatech.se; h=
	cc:cc:content-transfer-encoding:content-type:content-type:date
	:date:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm3; t=1757429194;
	 x=1757515594; bh=3xq7RsZJqSaXf06obnl0el2O1fY/VZN9hjuq599veYg=; b=
	D3BeZ5d+j4hvhpM9RsZwtYzyXLO9SWXHU2wvVuc1LeMmDfTwHci7S2zrVzRYMmKF
	SJdaZ/aru0EHj/JhLslBhxAhJBAO2xnMlk9faevwpVbHxpurys9gL3CDVgfTvYK0
	eewBnxduKtt2X3gOtJpDY2fAY9J3pYhuP6GnzJXcI5TqA1E4oxOVhpQRkFX4ib8w
	LwCDF4eog55CL5mN4f2aVhIVLEHgL7wqEHuY4Sp1oaUsoO4c5tGl7rbweo9Ixjwl
	jMmU4js8wIXeEkjcHEnkp4vUvRA9I7cBgb4ygHh28QG8tTMu5ESRdJ9szmelOCF/
	x0gXqM2+1sauTBKorQx1xA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm1; t=1757429194; x=
	1757515594; bh=3xq7RsZJqSaXf06obnl0el2O1fY/VZN9hjuq599veYg=; b=Y
	txD6xFJrPbdut6X0H77VYiPdYz9+I79YMInTUC3eMi3fluB8yO8+8/4L+aAocfCg
	WwLQqWmJo7xb5Jr9Q1SYvYTuB650cxZVjNsHssRFGpqU6mL/aFi+8KDvZVlBBRha
	uef1WHPe7ocBCmBBYm2D4jqNm+Uj0gjlM5o7Rgpcoo8+OznQXc+X/GNBvi2g0lsC
	DK8ahrl3EG2uOGbP2fVS/qHXM340Y72oR8/yFv+yj3NzTw66dBsDp5LqrEKaM7LH
	eGLKmcD6bS9SXmQgzEX7S/PSmoxKS4n1BLq1/cDYkbs8xWqzt/PMkSL7OB/2zhCD
	sFLPygZk6fTkR1/go7DEg==
X-ME-Sender: <xms:yT3AaPezpobd7j-fcx-5ks1Wq24L0SEJ7NmeW2MwhVdxWf9BKcIQgQ>
    <xme:yT3AaClifJCxiEPZjMmMNXjho1sUbcyn_fr39sm-PQIm-NXFMM5r05Ox7dW_9pVEg
    BVLce8aV-Qu8NOj5yY>
X-ME-Received: <xmr:yT3AaP0Y9Snr7bcf6KzJs1Yv6KK3I8hfkY1lozE5uXS2SWylr-VgKkO3GwI2Le83E_4Vph88HbQYvug-_6FJoChw_2ob4GQEXw>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeffedrtdeggddvtdeikecutefuodetggdotefrod
    ftvfcurfhrohhfihhlvgemucfhrghsthforghilhdpuffrtefokffrpgfnqfghnecuuegr
    ihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenucfjug
    hrpeffhffvvefukfhfgggtugfgjgesthekredttddtjeenucfhrhhomheppfhikhhlrghs
    ucfunpguvghrlhhunhguuceonhhikhhlrghsrdhsohguvghrlhhunhgusehrrghgnhgrth
    gvtghhrdhsvgeqnecuggftrfgrthhtvghrnhepveetgedtvddvhfdtkeeghfeffeehteeh
    keekgeefjeduieduueelgedtheekkeetnecuvehluhhsthgvrhfuihiivgeptdenucfrrg
    hrrghmpehmrghilhhfrhhomhepnhhikhhlrghsrdhsohguvghrlhhunhgusehrrghgnhgr
    thgvtghhrdhsvgdpnhgspghrtghpthhtohepuddtpdhmohguvgepshhmthhpohhuthdprh
    gtphhtthhopeifshgrodhrvghnvghsrghssehsrghnghdqvghnghhinhgvvghrihhnghdr
    tghomhdprhgtphhtthhopehlihhnuhigqdhrvghnvghsrghsqdhsohgtsehvghgvrhdrkh
    gvrhhnvghlrdhorhhgpdhrtghpthhtohepmhgrrhgvkhdrvhgrshhuthesghhmrghilhdr
    tghomhdprhgtphhtthhopehrrghfrggvlheskhgvrhhnvghlrdhorhhgpdhrtghpthhtoh
    epuggrnhhivghlrdhlvgiitggrnhhosehlihhnrghrohdrohhrghdprhgtphhtthhopehr
    uhhirdiihhgrnhhgsehinhhtvghlrdgtohhmpdhrtghpthhtoheplhhukhgrshiirdhluh
    gsrgesrghrmhdrtghomhdprhgtphhtthhopehgvggvrhhtodhrvghnvghsrghssehglhhi
    uggvrhdrsggvpdhrtghpthhtohepmhgrghhnuhhsrdgurghmmhesghhmrghilhdrtghomh
X-ME-Proxy: <xmx:yT3AaLdayxTaoxugJ1Gidzu6ZszzsXgDmFywOC_TWaGRmTEBVNUyGQ>
    <xmx:yT3AaJYaPKM7QAXm3q_cX0TYR6vQxfrhGdh-hgYl6V6wgLen_-G6zg>
    <xmx:yT3AaAHYPKDEaOY4xT_NEmbVUkQgjeH8qJcCxYnLgwMF-Npp2hA-5g>
    <xmx:yT3AaHlkXUXmFCkH8SeGWPYReFz5PVxoFv8yohzyowFSP68Z8Y1o7w>
    <xmx:yj3AaLjLUwOq7ki_1YkCJKungG5VRsqabSuS4qlUfdlhH0X3O2cb5JkQ>
Feedback-ID: i80c9496c:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Tue,
 9 Sep 2025 10:46:33 -0400 (EDT)
Date: Tue, 9 Sep 2025 16:46:31 +0200
From: Niklas =?utf-8?Q?S=C3=B6derlund?= <niklas.soderlund@ragnatech.se>
To: Wolfram Sang <wsa+renesas@sang-engineering.com>
Cc: linux-renesas-soc@vger.kernel.org, Marek Vasut <marek.vasut@gmail.com>,
	"Rafael J. Wysocki" <rafael@kernel.org>,
	Daniel Lezcano <daniel.lezcano@linaro.org>,
	Zhang Rui <rui.zhang@intel.com>, Lukasz Luba <lukasz.luba@arm.com>,
	Geert Uytterhoeven <geert+renesas@glider.be>,
	Magnus Damm <magnus.damm@gmail.com>, linux-pm@vger.kernel.org
Subject: Re: [RFC PATCH 1/2] thermal/drivers/rcar_gen3: fix mapping SoCs to
 generic Gen4 entry
Message-ID: <20250909144631.GA3476608@ragnatech.se>
References: <20250909084618.23082-4-wsa+renesas@sang-engineering.com>
 <20250909084618.23082-5-wsa+renesas@sang-engineering.com>
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20250909084618.23082-5-wsa+renesas@sang-engineering.com>

Hi Wolfram,

Thanks for your work.

On 2025-09-09 10:46:19 +0200, Wolfram Sang wrote:
> S4 was added first so it was assumed to be the blueprint for R-Car Gen4.
> It turned out now, that S4 is a special mix between Gen3 and Gen4. V4H
> and V4M are the similar ones as confirmed by HW engineers.
> 
> So, rename the S4 entry to be specific instead of generic. Rename the
> V4H entry to be the new generic one, so V4M will use it as well now.
> 
> Signed-off-by: Wolfram Sang <wsa+renesas@sang-engineering.com>

Good catch,

Reviewed-by: Niklas Söderlund <niklas.soderlund+renesas@ragnatech.se>

> ---
>  drivers/thermal/renesas/rcar_gen3_thermal.c | 12 ++++++------
>  1 file changed, 6 insertions(+), 6 deletions(-)
> 
> diff --git a/drivers/thermal/renesas/rcar_gen3_thermal.c b/drivers/thermal/renesas/rcar_gen3_thermal.c
> index 01858e72f4e0..07b53d4f2683 100644
> --- a/drivers/thermal/renesas/rcar_gen3_thermal.c
> +++ b/drivers/thermal/renesas/rcar_gen3_thermal.c
> @@ -371,7 +371,7 @@ static const struct rcar_gen3_thermal_fuse_default rcar_gen3_thermal_fuse_defaul
>  	},
>  };
>  
> -static const struct rcar_gen3_thermal_fuse_default rcar_gen3_thermal_fuse_default_info_v4h = {
> +static const struct rcar_gen3_thermal_fuse_default rcar_gen3_thermal_fuse_default_info_gen4 = {
>  	.ptat = { 3274, 2164, 985 },
>  	.thcodes = { /* All four THS units share the same trimming */
>  		{ 3218, 2617, 1980 },
> @@ -397,7 +397,7 @@ static const struct rcar_thermal_info rcar_gen3_thermal_info = {
>  	.fuse_defaults = &rcar_gen3_thermal_fuse_default_info_gen3,
>  };
>  
> -static const struct rcar_thermal_info rcar_gen4_thermal_info = {
> +static const struct rcar_thermal_info rcar_s4_thermal_info = {
>  	.scale = 167,
>  	.adj_below = -41,
>  	.adj_above = 126,
> @@ -405,12 +405,12 @@ static const struct rcar_thermal_info rcar_gen4_thermal_info = {
>  	.fuse_defaults = &rcar_gen3_thermal_fuse_default_info_gen3,
>  };
>  
> -static const struct rcar_thermal_info rcar_v4h_thermal_info = {
> +static const struct rcar_thermal_info rcar_gen4_thermal_info = {
>  	.scale = 167,
>  	.adj_below = -41,
>  	.adj_above = 126,
>  	.fuses = &rcar_gen3_thermal_fuse_info_gen4,
> -	.fuse_defaults = &rcar_gen3_thermal_fuse_default_info_v4h,
> +	.fuse_defaults = &rcar_gen3_thermal_fuse_default_info_gen4,
>  };
>  
>  static const struct of_device_id rcar_gen3_thermal_dt_ids[] = {
> @@ -452,11 +452,11 @@ static const struct of_device_id rcar_gen3_thermal_dt_ids[] = {
>  	},
>  	{
>  		.compatible = "renesas,r8a779f0-thermal",
> -		.data = &rcar_gen4_thermal_info,
> +		.data = &rcar_s4_thermal_info,
>  	},
>  	{
>  		.compatible = "renesas,r8a779g0-thermal",
> -		.data = &rcar_v4h_thermal_info,
> +		.data = &rcar_gen4_thermal_info,
>  	},
>  	{
>  		.compatible = "renesas,r8a779h0-thermal",
> -- 
> 2.47.2
> 

-- 
Kind Regards,
Niklas Söderlund

