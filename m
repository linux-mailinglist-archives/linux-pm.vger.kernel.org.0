Return-Path: <linux-pm+bounces-30583-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 1FD92B002BE
	for <lists+linux-pm@lfdr.de>; Thu, 10 Jul 2025 15:01:05 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id EC9AA4E6321
	for <lists+linux-pm@lfdr.de>; Thu, 10 Jul 2025 13:00:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C19B5223DF1;
	Thu, 10 Jul 2025 13:01:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ragnatech.se header.i=@ragnatech.se header.b="u53pnXEh";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="ShMwq5Qd"
X-Original-To: linux-pm@vger.kernel.org
Received: from fout-a7-smtp.messagingengine.com (fout-a7-smtp.messagingengine.com [103.168.172.150])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CCDB018B47D;
	Thu, 10 Jul 2025 13:00:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.150
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752152460; cv=none; b=QbrlP7cJAkRzwXgQ5rwmLheUy29EGbiivHPWUgtzG5P+iexgMslbEEDwk0lQ5tjn+0iliOeMuf3lhSXo/2XeyAUmeuhDeXuG9JuPfr1NeDoW/DGCTcCjrkIjvb0pv0OJrlkxr7QM3/OPX2FEDINbO1sNipyg8ANqi+kpljK/WAg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752152460; c=relaxed/simple;
	bh=jzpxRsJ6VW1YxSlJsbTN9FpLUNduUWgpjq0ALHBpxwM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Er/a9wilmIXgZ5/U+BA7BtjOyuKMDumABn296fpJece3gIvfddW12cjwwhv0oQqC75c5R5axXVuTb/PjQdwrRir8iRXYTn6aZB3HAP5aVBK8A1VkamgjJuCKWL9k1FoRIgvnwqHzoRK9mOAZ+fgpG33E2TPrIuULyi1UCUCCWj0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=ragnatech.se; spf=pass smtp.mailfrom=ragnatech.se; dkim=pass (2048-bit key) header.d=ragnatech.se header.i=@ragnatech.se header.b=u53pnXEh; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=ShMwq5Qd; arc=none smtp.client-ip=103.168.172.150
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=ragnatech.se
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ragnatech.se
Received: from phl-compute-01.internal (phl-compute-01.phl.internal [10.202.2.41])
	by mailfout.phl.internal (Postfix) with ESMTP id F04EBEC025F;
	Thu, 10 Jul 2025 09:00:57 -0400 (EDT)
Received: from phl-mailfrontend-02 ([10.202.2.163])
  by phl-compute-01.internal (MEProxy); Thu, 10 Jul 2025 09:00:57 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ragnatech.se; h=
	cc:cc:content-transfer-encoding:content-type:content-type:date
	:date:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm1; t=1752152457;
	 x=1752238857; bh=7HDLZP/6/SAsDo7hZEfPxId47x3a7/9rXug00+vwYvo=; b=
	u53pnXEhNUr5SAaJujCtAuQI0z0AHafwbpVKYYuaeNnMv+kiG+dI2jiZb4gtYlHM
	vvxLS5GmMwNjJfI4MpVFIylp5fU6rNBR5lptr0kB+RcWRhn7jiYWOJcgDpmj/XMZ
	5Qy+nNh1Kx+UMIwgyhYITKkfiXjw09VPPV2tCFV5HtfERqwVfsB0vym2W+FnJ+Kd
	RbbcpFreduGEf9EKFeGRTZCwl6ypsK0SZjTYVIu8iy/4S69wC4RWmUDUKSLaNwM3
	gDXpxSXI/XGGFwTJl1SUP727LUiWrP45e5pwhNid90XKeKUSsdIe+O3ClWkX7dQS
	RTTXxORgHDRh95Djm81tnw==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm2; t=1752152457; x=
	1752238857; bh=7HDLZP/6/SAsDo7hZEfPxId47x3a7/9rXug00+vwYvo=; b=S
	hMwq5Qdsrx3sQ3sDPy+/pUZcl79dFHY/YxSqciYqM5RHUGXYUmqseE9hkZ6nthMY
	7/7372CZp8rBI2wbaysuuF9Dn2A5E5LS5rEfwXbSow+bgBqebJ49GP1V4vzktIzk
	5CdBH+WKSeK+kWnowNC7nn/UF2CDm+QpLNUpBdUCKv/+4ukqOk+/rEF6PFJi7LES
	iZHt77o3g8OyfbU6GLcbyhLkXC5epXssGnsWmODmmLMpxjBiMJejuB1ewJFMdIlp
	rTE4A9iRfEgRxdZ6Oa7WtbcuIj2u103/Y29BT+YvuDdDV9t4ympLpcz/AcZbFSqP
	aoFV2KaZJkfBpsM086suA==
X-ME-Sender: <xms:iblvaMt5BjosKbh9UnbvyoCzAsbjzNZWefh494USW_DJRb9adDvojw>
    <xme:iblvaNQRBx-WBw-w4AoNGaS8BOpT3McftB6Hb901SOqwTQ7G91dE8lXmWKYDY4uy5
    -DB0SUVJdhroBIPjz4>
X-ME-Received: <xmr:iblvaA1vxCkQdESXK4wfdmmJHivuOQqpC-mcW9GUj0oD3BekTu3i8osxSGNmqXvUV-RnzLJgR0BSdkFbIzfQcdc1ykZRdSX5Og>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeffedrtdefgdegtdehudcutefuodetggdotefrod
    ftvfcurfhrohhfihhlvgemucfhrghsthforghilhdpuffrtefokffrpgfnqfghnecuuegr
    ihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenucfjug
    hrpeffhffvvefukfhfgggtugfgjgesthekredttddtjeenucfhrhhomheppfhikhhlrghs
    ucfunpguvghrlhhunhguuceonhhikhhlrghsrdhsohguvghrlhhunhgusehrrghgnhgrth
    gvtghhrdhsvgeqnecuggftrfgrthhtvghrnhepveetgedtvddvhfdtkeeghfeffeehteeh
    keekgeefjeduieduueelgedtheekkeetnecuvehluhhsthgvrhfuihiivgeptdenucfrrg
    hrrghmpehmrghilhhfrhhomhepnhhikhhlrghsrdhsohguvghrlhhunhgusehrrghgnhgr
    thgvtghhrdhsvgdpnhgspghrtghpthhtohepjedpmhhouggvpehsmhhtphhouhhtpdhrtg
    hpthhtohepghgvvghrthdorhgvnhgvshgrshesghhlihguvghrrdgsvgdprhgtphhtthho
    pehrrghfrggvlheskhgvrhhnvghlrdhorhhgpdhrtghpthhtohepuggrnhhivghlrdhlvg
    iitggrnhhosehlihhnrghrohdrohhrghdprhgtphhtthhopehruhhirdiihhgrnhhgsehi
    nhhtvghlrdgtohhmpdhrtghpthhtoheplhhukhgrshiirdhluhgsrgesrghrmhdrtghomh
    dprhgtphhtthhopehlihhnuhigqdhrvghnvghsrghsqdhsohgtsehvghgvrhdrkhgvrhhn
    vghlrdhorhhgpdhrtghpthhtoheplhhinhhugidqphhmsehvghgvrhdrkhgvrhhnvghlrd
    horhhg
X-ME-Proxy: <xmx:iblvaCtSP16XhuEZyNJvl0QeX3yso_53-xGqeZDcMUXoPJlaTkcIpQ>
    <xmx:iblvaGiZ1ZySKnWVeiybmz484Xjq_S6rQJzsNnxrZH00mXb10JzzSw>
    <xmx:iblvaD9_Mt4NHziQjlgm4CiF6a5oR7EfWfCN6iGZFiHfMK4gi8WIsA>
    <xmx:iblvaJvlz15n1fxV0oehSNkbkP-W1OiwqUOeFESedSqEUzVpejmXZQ>
    <xmx:iblvaL-ZLO-Qec_jyWwNsOG6GGd4QzJj0cyInAJEGOVP4TnwPgTdKyPz>
Feedback-ID: i80c9496c:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Thu,
 10 Jul 2025 09:00:56 -0400 (EDT)
Date: Thu, 10 Jul 2025 15:00:55 +0200
From: Niklas =?utf-8?Q?S=C3=B6derlund?= <niklas.soderlund@ragnatech.se>
To: Geert Uytterhoeven <geert+renesas@glider.be>
Cc: "Rafael J . Wysocki" <rafael@kernel.org>,
	Daniel Lezcano <daniel.lezcano@linaro.org>,
	Zhang Rui <rui.zhang@intel.com>, Lukasz Luba <lukasz.luba@arm.com>,
	linux-renesas-soc@vger.kernel.org, linux-pm@vger.kernel.org
Subject: Re: [PATCH] thermal: rcar: Convert to DEFINE_SIMPLE_DEV_PM_OPS()
Message-ID: <20250710130055.GC2234326@ragnatech.se>
References: <4bf4c21a72abeb53649ea545a3db768355b03d50.1752087838.git.geert+renesas@glider.be>
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <4bf4c21a72abeb53649ea545a3db768355b03d50.1752087838.git.geert+renesas@glider.be>

Hi Geert,

Thanks for your work.

On 2025-07-09 21:04:17 +0200, Geert Uytterhoeven wrote:
> Convert the Renesas R-Car thermal driver from SIMPLE_DEV_PM_OPS() to
> DEFINE_SIMPLE_DEV_PM_OPS() and pm_sleep_ptr().  This lets us drop the
> check for CONFIG_PM_SLEEP, and reduces kernel size in case CONFIG_PM or
> CONFIG_PM_SLEEP is disabled, while increasing build coverage.
> 
> Signed-off-by: Geert Uytterhoeven <geert+renesas@glider.be>

Reviewed-by: Niklas Söderlund <niklas.soderlund+renesas@ragnatech.se>

> ---
>  drivers/thermal/renesas/rcar_thermal.c | 8 +++-----
>  1 file changed, 3 insertions(+), 5 deletions(-)
> 
> diff --git a/drivers/thermal/renesas/rcar_thermal.c b/drivers/thermal/renesas/rcar_thermal.c
> index 00a66ee0a5b00c5f..4323b96670e7571f 100644
> --- a/drivers/thermal/renesas/rcar_thermal.c
> +++ b/drivers/thermal/renesas/rcar_thermal.c
> @@ -534,7 +534,6 @@ static int rcar_thermal_probe(struct platform_device *pdev)
>  	return ret;
>  }
>  
> -#ifdef CONFIG_PM_SLEEP
>  static int rcar_thermal_suspend(struct device *dev)
>  {
>  	struct rcar_thermal_common *common = dev_get_drvdata(dev);
> @@ -567,15 +566,14 @@ static int rcar_thermal_resume(struct device *dev)
>  
>  	return 0;
>  }
> -#endif
>  
> -static SIMPLE_DEV_PM_OPS(rcar_thermal_pm_ops, rcar_thermal_suspend,
> -			 rcar_thermal_resume);
> +static DEFINE_SIMPLE_DEV_PM_OPS(rcar_thermal_pm_ops, rcar_thermal_suspend,
> +				rcar_thermal_resume);
>  
>  static struct platform_driver rcar_thermal_driver = {
>  	.driver	= {
>  		.name	= "rcar_thermal",
> -		.pm = &rcar_thermal_pm_ops,
> +		.pm = pm_sleep_ptr(&rcar_thermal_pm_ops),
>  		.of_match_table = rcar_thermal_dt_ids,
>  	},
>  	.probe		= rcar_thermal_probe,
> -- 
> 2.43.0
> 

-- 
Kind Regards,
Niklas Söderlund

