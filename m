Return-Path: <linux-pm+bounces-36882-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [IPv6:2a01:60a::1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id A7C5CC0CEB9
	for <lists+linux-pm@lfdr.de>; Mon, 27 Oct 2025 11:18:21 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id D14E13412DB
	for <lists+linux-pm@lfdr.de>; Mon, 27 Oct 2025 10:18:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DF433283FD8;
	Mon, 27 Oct 2025 10:18:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="C7Dyf8BI"
X-Original-To: linux-pm@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B77EE134BD;
	Mon, 27 Oct 2025 10:18:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761560296; cv=none; b=p0WxGhP96ti3gm9J5GXhdTTFcgjykCVVM5p78EvUWLo08bT2/AL/2QBVXke2iW0Hhu2QhenczuuT+YuBGgaQ5qHIBho5naL/kmR2FfIXM5vVsS7bSI+fyNpqcvtWOWyiM6xJx0s0zP2QH9N2BSuTdPcghpEZogAkOGug+uMI8M0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761560296; c=relaxed/simple;
	bh=pWgT/qvNWTcElQLadJvVexppRIu51+UzMQ25dmS673Y=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=lMeUDGyJGuNWiXS7ms7yQ7T+817O8TIxHDG+sPz49AGTLeinjrBJCq6lfjWVcQ/w7IvUs6YXL8jX+r27QXmowpRrSmBPr8tYILIz639r8oLvYsfRZvyyXVvPduMp6HHFdur2nQmrYu7yAU0az2bm2X0XdMlJ6hPR7cwjbiPnd+c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=C7Dyf8BI; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 84455C4CEF1;
	Mon, 27 Oct 2025 10:18:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1761560296;
	bh=pWgT/qvNWTcElQLadJvVexppRIu51+UzMQ25dmS673Y=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=C7Dyf8BIFxlEavwP5Ho5Qk4TDQ6Qa6qrDHYNE+n6k4FQMmDSIWh23WR2gSsimhW3c
	 DNBZvV5BnRNPKWg9nk4HezV/+zXWsRk5qXDz4uFE3KdRFpOvdGLhyxKFm///ru/41D
	 SKam0hBzpswF+eUGN5S3nWg2ZzkxsfpEbZsCehFz2PH4qQHeGnWi74Sf420Q3bBRg0
	 gqyvoWXn/492/h6U6gW6m9uqh2yV2no6r0XA4ffPhkIlisR8cNUtknfzcBWbX6kINe
	 /ZBh+La/Ocnk6UjvoDkdbAqCeTXVEXcK5IoA5HNaHhM07BaBmvLT1jc0puJNwB0uKW
	 nuKv7UXJWCyEA==
Message-ID: <8efa8233-6f55-4df7-9625-a7addc101ea3@kernel.org>
Date: Mon, 27 Oct 2025 11:18:12 +0100
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] pmdomain: samsung: Rework legacy splash-screen handover
 workaround
To: Marek Szyprowski <m.szyprowski@samsung.com>, linux-pm@vger.kernel.org,
 linux-samsung-soc@vger.kernel.org
Cc: Ulf Hansson <ulf.hansson@linaro.org>,
 Alim Akhtar <alim.akhtar@samsung.com>,
 =?UTF-8?Q?Andr=C3=A9_Draszik?= <andre.draszik@linaro.org>,
 Peter Griffin <peter.griffin@linaro.org>
References: <CGME20251024093617eucas1p2a84deaa88e39692fd4933d14684aaeb9@eucas1p2.samsung.com>
 <20251024093603.3484783-1-m.szyprowski@samsung.com>
 <cf9bc771-78a0-4439-a913-dfb8bd62c46c@kernel.org>
 <deeeba6b-af85-44ad-ad78-efa7e923621a@samsung.com>
From: Krzysztof Kozlowski <krzk@kernel.org>
Content-Language: en-US
Autocrypt: addr=krzk@kernel.org; keydata=
 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 a/A=
In-Reply-To: <deeeba6b-af85-44ad-ad78-efa7e923621a@samsung.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

On 27/10/2025 11:10, Marek Szyprowski wrote:
> On 24.10.2025 13:21, Krzysztof Kozlowski wrote:
>> On 24/10/2025 11:36, Marek Szyprowski wrote:
>>> Limit the workaround for splash-screen handover handling to the affected
>>> power domains in legacy ARM 32bit systems and replace forcing a
>>> sync_state by explicite power domain shutdown. This approach lets
>>> compiler to optimize it out on newer ARM 64bit systems.
>>>
>>> Suggested-by: Ulf Hansson <ulf.hansson@linaro.org>
>>> Fixes: 0745658aebbe ("pmdomain: samsung: Fix splash-screen handover by enforcing a sync_state")
>>> Signed-off-by: Marek Szyprowski <m.szyprowski@samsung.com>
>>> ---
>>>   drivers/pmdomain/samsung/exynos-pm-domains.c | 19 ++++++++++---------
>>>   1 file changed, 10 insertions(+), 9 deletions(-)
>>>
>>> diff --git a/drivers/pmdomain/samsung/exynos-pm-domains.c b/drivers/pmdomain/samsung/exynos-pm-domains.c
>>> index f53e1bd24798..8e7ac1ab0780 100644
>>> --- a/drivers/pmdomain/samsung/exynos-pm-domains.c
>>> +++ b/drivers/pmdomain/samsung/exynos-pm-domains.c
>>> @@ -128,6 +128,16 @@ static int exynos_pd_probe(struct platform_device *pdev)
>>>   	pd->pd.power_on = exynos_pd_power_on;
>>>   	pd->local_pwr_cfg = pm_domain_cfg->local_pwr_cfg;
>>>   
>>> +	/*
>>> +	 * Some Samsung platforms with bootloaders turning on the splash-screen
>>> +	 * and handing it over to the kernel, requires the power-domains to be
>>> +	 * reset during boot.
>>> +	 */
>>> +	if (IS_ENABLED(CONFIG_ARM) &&
>>> +	    of_device_is_compatible(np, "samsung,exynos4210-pd") &&
>>> +	    (strstr(pd->pd.name, "LCD") || strstr(pd->pd.name, "DISP")))
>>
>> I thought you folks speak theoretically to point which power domains are
>> relevant here, not for real relying on labels. Labels are not an ABI,
>> these are user informative strings. If you wanted them to be ABI, then
>> the values would have to be documented.... and then they wouldn't be
>> user informative strings :/
> 
> Frankly speaking... we can drop label checks and simply always turn off 
> all the 'exynos4210-pd'-style domains and it will just work. I've just 
> tested that to be sure.

That's fine for me.

> 
> If this sounds like a bit rude hack, then we can use 
> GENPD_FLAG_NO_STAY_ON workaround (like Rockchip and Renesas).
> 
>> If these were different devices, we would need front compatibles, but
>> since this is purely a bootloader stage, then we need a property for
>> that. Something like regulator-boot-on.
> 
> Just to clarify - this splash screen issue has not much with power 
> domain driver itself, but a side-effect of old genpd behavior has hidden 
> this issue deep enough that it was ignored for years.
> 

Issue is still in the bootloader and how the handover should work, so
for me, since we do not have dedicated front compatible, property sounds
reasonable.

Best regards,
Krzysztof

