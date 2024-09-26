Return-Path: <linux-pm+bounces-14796-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id DE292986F42
	for <lists+linux-pm@lfdr.de>; Thu, 26 Sep 2024 10:49:21 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id A0DFC2867A2
	for <lists+linux-pm@lfdr.de>; Thu, 26 Sep 2024 08:49:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C75EC1A4E9A;
	Thu, 26 Sep 2024 08:49:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=collabora.com header.i=@collabora.com header.b="IGGNyu2G"
X-Original-To: linux-pm@vger.kernel.org
Received: from bali.collaboradmins.com (bali.collaboradmins.com [148.251.105.195])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D83E014AD17;
	Thu, 26 Sep 2024 08:48:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.251.105.195
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727340540; cv=none; b=jIe5uTVd2dHPzHjF7vbMKcImbxNB4Jwsh9IPrCz17Ze2AyPD8gmd8MbtUm+TtMcxA5x9CpJhZshi3Kx0TvSw2stfMjAljFJ0RVMG47RQhmv8jmPlvbwaccvDde4+1EdNWOyJNe+I5DLx6y8KOYmA6eXw1qdSVJYcYeFEcHfHebc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727340540; c=relaxed/simple;
	bh=0H4dM9NzilQ5XHmjN1qEbEUXxix/9JrmttrPTQq+uvI=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=ZbegXg8JJ0wb2QkEBE0Nvt8PsI9DuQY3c6TKrk8Xu3XaldFkFLL1Ywji5Id7VJqeDgPKBqLYG9HBOf4KtAiOmnwtg2dPC4qd+U1+GOYqRllaO3qKes5Q7oudNbQT8qIIYLOFV7n2szvmTYHhHDzFP6QSL67uMEliTfICpZFCidU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=collabora.com; spf=pass smtp.mailfrom=collabora.com; dkim=pass (2048-bit key) header.d=collabora.com header.i=@collabora.com header.b=IGGNyu2G; arc=none smtp.client-ip=148.251.105.195
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=collabora.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=collabora.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
	s=mail; t=1727340537;
	bh=0H4dM9NzilQ5XHmjN1qEbEUXxix/9JrmttrPTQq+uvI=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=IGGNyu2GGhL861wp8iuj8doPxLtpFHdGi+14N43mzCZfjm5A5rwcPIYKHY1VMQXhr
	 aggqvQMkA7uulzyzM1aBKZZ2yRP2uF3rjA8qHkaRJxSRzjrkFsWai5YAkG5Cqqeg45
	 3Ycgkq5ttycO9PjosJ+zp6gIxNP3cNYhNEAFHKNTfZ/xGP+6AFnBbn6jq5rHF/Tl4p
	 6E1XqaooOWMIA3YoFskEJkzmczduIivnTIqspTnh1tuRShqiTcFmrqlYGWCyb4X5HS
	 IN75tPtPoNPClqOcM7CNdas3CVEC+40k9KEK4+3vVMTzeMBQ4x/sdlWJMD/yEvPAP9
	 aZceBE4nfxWag==
Received: from [192.168.1.100] (2-237-20-237.ip236.fastwebnet.it [2.237.20.237])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits))
	(No client certificate requested)
	(Authenticated sender: kholk11)
	by bali.collaboradmins.com (Postfix) with ESMTPSA id A9D5717E107A;
	Thu, 26 Sep 2024 10:48:56 +0200 (CEST)
Message-ID: <e3eabcc4-1174-4a58-a084-d37467f63ced@collabora.com>
Date: Thu, 26 Sep 2024 10:48:56 +0200
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v8 3/3] pmdomain: mediatek: Use OF-specific regulator API
 to get power domain supply
To: Chen-Yu Tsai <wenst@chromium.org>, Ulf Hansson <ulf.hansson@linaro.org>,
 Matthias Brugger <matthias.bgg@gmail.com>, Mark Brown <broonie@kernel.org>
Cc: devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
 linux-mediatek@lists.infradead.org, linux-kernel@vger.kernel.org,
 linux-pm@vger.kernel.org, Douglas Anderson <dianders@chromium.org>,
 Johan Hovold <johan@kernel.org>,
 Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
 Pablo Sun <pablo.sun@mediatek.com>, Macpaul Lin <macpaul.lin@mediatek.com>,
 Sebastian Reichel <sebastian.reichel@collabora.com>
References: <20240925093807.1026949-1-wenst@chromium.org>
 <20240925093807.1026949-4-wenst@chromium.org>
From: AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>
Content-Language: en-US
In-Reply-To: <20240925093807.1026949-4-wenst@chromium.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

Il 25/09/24 11:38, Chen-Yu Tsai ha scritto:
> The MediaTek power domain driver contains a hack that assigns the device
> node of the power domain to the struct device of the power domain
> controller in order to use the devres regulator API.
> 
> Now that there is a proper OF-specific regulator API, and even a devres
> version, replace the hack with proper code.
> 
> This change is incompatible with incomplete device trees. Instead of
> assigning the dummy regulator in cases where the power domain requires
> a supply but the device tree does not provide one, the driver will just
> error out. This will be seen on the MT8390 EVK, which is missing
> supplies for the IMG_VCORE and CAM_VCORE domains. And likely all the
> MediaTek EVBs, which have no power domain supplies specified. This is
> however the correct behavior. If the power domain's supply is missing,
> then it should not work. Relying on other parts of the system to keep
> the unattached regulator enabled is likely to break in ways less easier
> to understand.
> 

Breaking something that was "working" (not really working though) before is a
hard thing to justify, but I feel like this is one of the cases in which we
have to swallow the pill.

This is a hack that I've always been angry about, and causing all sorts of
random issues on MediaTek SoCs from time to time... that was fixed multiple
times by hacking the previous hack which was needed for this hack to still
work in a way or another.

I am tempted to give you a R-b right now, but let me carefully test this on
multiple devices before that.

Meanwhile, I just wanted to say that I agree with you about this commit and
wanted to give a bit more context to people reading "this breaks things" so
that they can understand what's going on (and that we're not crazy! ..or at
least, not *that* much :-P).

Cheers,
Angelo

> Signed-off-by: Chen-Yu Tsai <wenst@chromium.org>
> ---
> Changes since v7:
> - New patch
> 
> The other option is to follow what Rockchip will be doing: getting the
> regulator supply upon first use / enable [1]. This will result in less
> breakage: only the power domain that is missing its supplies will fail
> to be attached.
> 
> [1] https://lore.kernel.org/all/20240919091834.83572-6-sebastian.reichel@collabora.com/
> ---
>   drivers/pmdomain/mediatek/mtk-pm-domains.c | 12 +-----------
>   1 file changed, 1 insertion(+), 11 deletions(-)
> 
> diff --git a/drivers/pmdomain/mediatek/mtk-pm-domains.c b/drivers/pmdomain/mediatek/mtk-pm-domains.c
> index 88406e9ac63c..3580913f25d3 100644
> --- a/drivers/pmdomain/mediatek/mtk-pm-domains.c
> +++ b/drivers/pmdomain/mediatek/mtk-pm-domains.c
> @@ -353,7 +353,6 @@ generic_pm_domain *scpsys_add_one_domain(struct scpsys *scpsys, struct device_no
>   {
>   	const struct scpsys_domain_data *domain_data;
>   	struct scpsys_domain *pd;
> -	struct device_node *root_node = scpsys->dev->of_node;
>   	struct device_node *smi_node;
>   	struct property *prop;
>   	const char *clk_name;
> @@ -388,16 +387,7 @@ generic_pm_domain *scpsys_add_one_domain(struct scpsys *scpsys, struct device_no
>   	pd->scpsys = scpsys;
>   
>   	if (MTK_SCPD_CAPS(pd, MTK_SCPD_DOMAIN_SUPPLY)) {
> -		/*
> -		 * Find regulator in current power domain node.
> -		 * devm_regulator_get() finds regulator in a node and its child
> -		 * node, so set of_node to current power domain node then change
> -		 * back to original node after regulator is found for current
> -		 * power domain node.
> -		 */
> -		scpsys->dev->of_node = node;
> -		pd->supply = devm_regulator_get(scpsys->dev, "domain");
> -		scpsys->dev->of_node = root_node;
> +		pd->supply = devm_of_regulator_get_optional(scpsys->dev, node, "domain");
>   		if (IS_ERR(pd->supply))
>   			return dev_err_cast_probe(scpsys->dev, pd->supply,
>   				      "%pOF: failed to get power supply.\n",




