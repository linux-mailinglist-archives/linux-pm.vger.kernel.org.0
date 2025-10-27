Return-Path: <linux-pm+bounces-36885-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [213.196.21.55])
	by mail.lfdr.de (Postfix) with ESMTPS id 8161AC0CF89
	for <lists+linux-pm@lfdr.de>; Mon, 27 Oct 2025 11:34:07 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id 253AF34C7AF
	for <lists+linux-pm@lfdr.de>; Mon, 27 Oct 2025 10:34:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 54F7228A1E6;
	Mon, 27 Oct 2025 10:34:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=samsung.com header.i=@samsung.com header.b="WJXoovPh"
X-Original-To: linux-pm@vger.kernel.org
Received: from mailout1.w1.samsung.com (mailout1.w1.samsung.com [210.118.77.11])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E4D492D5C68
	for <linux-pm@vger.kernel.org>; Mon, 27 Oct 2025 10:33:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=210.118.77.11
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761561240; cv=none; b=q8QVqTFV0EpAbjnIAhWRRnW1RCxOewugyJa6rlD0KHPwaybC5A7miGEm7pHbKJM2M6WgbCDdiA4lhanRcLLUHyL+wbpM05KJB3R8RjDfMDvg+GOBvpwrgoFx0ajRk2Bb5TH2Nww6nYOafKK69pqFyQESsSBgHWmlHDWPo/AI9xY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761561240; c=relaxed/simple;
	bh=8i9amKKc8QHzbE9dglsyxsvtMheD/Rp+45SnV8NFkM4=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:From:In-Reply-To:
	 Content-Type:References; b=V624jBtMwRSp9bhIm6EUkKewgx1CDW5W2icUJwZhY8gSnRgA3B8KsutYPY9AMh8icDfC5vzAQuDjcbmXp0i3JSmdPJPtfO8HjztZxlndg47Jaku8uceIRJ18xwlOfyGymdHtpeGFphcbepXMWvsBZ+jQ7tweaQxE4kcn8m/pmc8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=samsung.com; spf=pass smtp.mailfrom=samsung.com; dkim=pass (1024-bit key) header.d=samsung.com header.i=@samsung.com header.b=WJXoovPh; arc=none smtp.client-ip=210.118.77.11
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=samsung.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=samsung.com
Received: from eucas1p2.samsung.com (unknown [182.198.249.207])
	by mailout1.w1.samsung.com (KnoxPortal) with ESMTP id 20251027103354euoutp01241f68ab10dd4de2904381969d0eefbc~yUpwOga-x1207012070euoutp01P
	for <linux-pm@vger.kernel.org>; Mon, 27 Oct 2025 10:33:54 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout1.w1.samsung.com 20251027103354euoutp01241f68ab10dd4de2904381969d0eefbc~yUpwOga-x1207012070euoutp01P
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
	s=mail20170921; t=1761561234;
	bh=lIYRknRaBsjdmwNLzFfSe6ehdfxBFbkEVntFJSe+mkU=;
	h=Date:Subject:To:Cc:From:In-Reply-To:References:From;
	b=WJXoovPh4R19GTi/htGmGmRXQrW/qOKsCaxUWzP9Dufk+DyZCj+VyfqfcutZipN8C
	 4utEdxqf0wFo5SGHN7tj+O8yW4bwTl6wV8F1Tf78PBpkVDr+7JWt1I2ScKEbUKTFFN
	 MrrbHp0JLVNenX+/9txfmYyCooapHBj2JBKPp8Uc=
Received: from eusmtip1.samsung.com (unknown [203.254.199.221]) by
	eucas1p1.samsung.com (KnoxPortal) with ESMTPA id
	20251027103354eucas1p1214d212f6879efb1d184645476f44cf2~yUpv6yblq2550625506eucas1p1Y;
	Mon, 27 Oct 2025 10:33:54 +0000 (GMT)
Received: from [106.210.134.192] (unknown [106.210.134.192]) by
	eusmtip1.samsung.com (KnoxPortal) with ESMTPA id
	20251027103353eusmtip1290ad2e53b97db4d11729781581d54ba~yUpvSB9Ii1788617886eusmtip1t;
	Mon, 27 Oct 2025 10:33:53 +0000 (GMT)
Message-ID: <e8362b57-ffc8-4f2b-af03-ed37882844ef@samsung.com>
Date: Mon, 27 Oct 2025 11:33:52 +0100
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Betterbird (Windows)
Subject: Re: [PATCH] pmdomain: samsung: Rework legacy splash-screen handover
 workaround
To: Krzysztof Kozlowski <krzk@kernel.org>, linux-pm@vger.kernel.org,
	linux-samsung-soc@vger.kernel.org
Cc: Ulf Hansson <ulf.hansson@linaro.org>, Alim Akhtar
	<alim.akhtar@samsung.com>, =?UTF-8?Q?Andr=C3=A9_Draszik?=
	<andre.draszik@linaro.org>, Peter Griffin <peter.griffin@linaro.org>
Content-Language: en-US
From: Marek Szyprowski <m.szyprowski@samsung.com>
In-Reply-To: <8efa8233-6f55-4df7-9625-a7addc101ea3@kernel.org>
Content-Transfer-Encoding: 8bit
X-CMS-MailID: 20251027103354eucas1p1214d212f6879efb1d184645476f44cf2
X-Msg-Generator: CA
Content-Type: text/plain; charset="utf-8"
X-RootMTR: 20251024093617eucas1p2a84deaa88e39692fd4933d14684aaeb9
X-EPHeader: CA
X-CMS-RootMailID: 20251024093617eucas1p2a84deaa88e39692fd4933d14684aaeb9
References: <CGME20251024093617eucas1p2a84deaa88e39692fd4933d14684aaeb9@eucas1p2.samsung.com>
	<20251024093603.3484783-1-m.szyprowski@samsung.com>
	<cf9bc771-78a0-4439-a913-dfb8bd62c46c@kernel.org>
	<deeeba6b-af85-44ad-ad78-efa7e923621a@samsung.com>
	<8efa8233-6f55-4df7-9625-a7addc101ea3@kernel.org>

On 27.10.2025 11:18, Krzysztof Kozlowski wrote:
> On 27/10/2025 11:10, Marek Szyprowski wrote:
>> On 24.10.2025 13:21, Krzysztof Kozlowski wrote:
>>> On 24/10/2025 11:36, Marek Szyprowski wrote:
>>>> Limit the workaround for splash-screen handover handling to the affected
>>>> power domains in legacy ARM 32bit systems and replace forcing a
>>>> sync_state by explicite power domain shutdown. This approach lets
>>>> compiler to optimize it out on newer ARM 64bit systems.
>>>>
>>>> Suggested-by: Ulf Hansson <ulf.hansson@linaro.org>
>>>> Fixes: 0745658aebbe ("pmdomain: samsung: Fix splash-screen handover by enforcing a sync_state")
>>>> Signed-off-by: Marek Szyprowski <m.szyprowski@samsung.com>
>>>> ---
>>>>    drivers/pmdomain/samsung/exynos-pm-domains.c | 19 ++++++++++---------
>>>>    1 file changed, 10 insertions(+), 9 deletions(-)
>>>>
>>>> diff --git a/drivers/pmdomain/samsung/exynos-pm-domains.c b/drivers/pmdomain/samsung/exynos-pm-domains.c
>>>> index f53e1bd24798..8e7ac1ab0780 100644
>>>> --- a/drivers/pmdomain/samsung/exynos-pm-domains.c
>>>> +++ b/drivers/pmdomain/samsung/exynos-pm-domains.c
>>>> @@ -128,6 +128,16 @@ static int exynos_pd_probe(struct platform_device *pdev)
>>>>    	pd->pd.power_on = exynos_pd_power_on;
>>>>    	pd->local_pwr_cfg = pm_domain_cfg->local_pwr_cfg;
>>>>    
>>>> +	/*
>>>> +	 * Some Samsung platforms with bootloaders turning on the splash-screen
>>>> +	 * and handing it over to the kernel, requires the power-domains to be
>>>> +	 * reset during boot.
>>>> +	 */
>>>> +	if (IS_ENABLED(CONFIG_ARM) &&
>>>> +	    of_device_is_compatible(np, "samsung,exynos4210-pd") &&
>>>> +	    (strstr(pd->pd.name, "LCD") || strstr(pd->pd.name, "DISP")))
>>> I thought you folks speak theoretically to point which power domains are
>>> relevant here, not for real relying on labels. Labels are not an ABI,
>>> these are user informative strings. If you wanted them to be ABI, then
>>> the values would have to be documented.... and then they wouldn't be
>>> user informative strings :/
>> Frankly speaking... we can drop label checks and simply always turn off
>> all the 'exynos4210-pd'-style domains and it will just work. I've just
>> tested that to be sure.
> That's fine for me.
>
>> If this sounds like a bit rude hack, then we can use
>> GENPD_FLAG_NO_STAY_ON workaround (like Rockchip and Renesas).
>>
>>> If these were different devices, we would need front compatibles, but
>>> since this is purely a bootloader stage, then we need a property for
>>> that. Something like regulator-boot-on.
>> Just to clarify - this splash screen issue has not much with power
>> domain driver itself, but a side-effect of old genpd behavior has hidden
>> this issue deep enough that it was ignored for years.
>>
> Issue is still in the bootloader and how the handover should work, so
> for me, since we do not have dedicated front compatible, property sounds
> reasonable.

The problem is that such hypothetical property would be rather a 
properly of display controller, so it would be really hard to find it by 
the power domain driver.

Best regards
-- 
Marek Szyprowski, PhD
Samsung R&D Institute Poland


