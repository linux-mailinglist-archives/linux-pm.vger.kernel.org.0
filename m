Return-Path: <linux-pm+bounces-36655-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 2639FBFC5EF
	for <lists+linux-pm@lfdr.de>; Wed, 22 Oct 2025 16:05:25 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id D27446276A3
	for <lists+linux-pm@lfdr.de>; Wed, 22 Oct 2025 13:47:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id ECD4434B19A;
	Wed, 22 Oct 2025 13:45:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=samsung.com header.i=@samsung.com header.b="CZryngLg"
X-Original-To: linux-pm@vger.kernel.org
Received: from mailout2.w1.samsung.com (mailout2.w1.samsung.com [210.118.77.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0A954347BBD
	for <linux-pm@vger.kernel.org>; Wed, 22 Oct 2025 13:45:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=210.118.77.12
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761140714; cv=none; b=cqLkL0Faef5wdkI47LzIplYOA1eb8zZkGPzZSPrX+x+79AVZZV19/u9ZUqmD/YW0pe+Os8xOPjUwppnZcozWWq2Z9aqxXUnPOWPrxmAxc/k0nnyVQeVVGOilsJBSaNnl3mmRQmtQb+GGa1Dzq/LGZqRXoLW4zd/eYBFGlPDtbDU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761140714; c=relaxed/simple;
	bh=/m4NmFCniT6JSPGXkBNpQ06V7pNeEBakNlH8t8yHOEM=;
	h=Message-ID:Date:MIME-Version:Subject:From:To:Cc:In-Reply-To:
	 Content-Type:References; b=EAXN1b/DVqD9/Urd+u1At8XIbEIOoRqC3XPUcdy1opQptUNo/tbgbTb8ph/EmvlfvuIF3Gf2GckfdheT3YUHkNKqOL8Ug+1+ws6jJM1X86IH1PQ2V44YEpDvrH6ZTuVunUxWSiEM3C+7w/jLRM36fwYu0+d1ByL+e786zTuJA0Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=samsung.com; spf=pass smtp.mailfrom=samsung.com; dkim=pass (1024-bit key) header.d=samsung.com header.i=@samsung.com header.b=CZryngLg; arc=none smtp.client-ip=210.118.77.12
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=samsung.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=samsung.com
Received: from eucas1p1.samsung.com (unknown [182.198.249.206])
	by mailout2.w1.samsung.com (KnoxPortal) with ESMTP id 20251022134510euoutp02e57b871b4bb9b748569ffee2e0a3f1dc~w1CUd_MBr1131811318euoutp02M
	for <linux-pm@vger.kernel.org>; Wed, 22 Oct 2025 13:45:10 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout2.w1.samsung.com 20251022134510euoutp02e57b871b4bb9b748569ffee2e0a3f1dc~w1CUd_MBr1131811318euoutp02M
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
	s=mail20170921; t=1761140710;
	bh=uVOoyF07iVYQ24dFE2kJcX0p9ox+bw4w5ywwtjuXGNM=;
	h=Date:Subject:From:To:Cc:In-Reply-To:References:From;
	b=CZryngLgbYRbGFm/ihPNVB9ukl/429AnUUsVxxCUcbjSI/Lu1diT/A7KiU7IzeeG6
	 coz4p5Uhslnv5JVHPlOadDhREbFd5sVox2JbdDYoJu+XDDJr8pNc9UWrpteHVZRPAo
	 bYBObZC5/v+zcbjyxqZ0qdHqps6WOfHuAXkKc8Ns=
Received: from eusmtip2.samsung.com (unknown [203.254.199.222]) by
	eucas1p1.samsung.com (KnoxPortal) with ESMTPA id
	20251022134509eucas1p1789fd89e07d10b550b7f21decd862d52~w1CT44nK50583205832eucas1p1W;
	Wed, 22 Oct 2025 13:45:09 +0000 (GMT)
Received: from [106.210.134.192] (unknown [106.210.134.192]) by
	eusmtip2.samsung.com (KnoxPortal) with ESMTPA id
	20251022134508eusmtip2d638eeea6ab8ba407c25e72a5591ac57~w1CS6lJHO0945309453eusmtip2K;
	Wed, 22 Oct 2025 13:45:08 +0000 (GMT)
Message-ID: <5c19e4ef-c4fd-4bf5-88b3-46c86751b14e@samsung.com>
Date: Wed, 22 Oct 2025 15:45:07 +0200
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Betterbird (Windows)
Subject: Re: [PATCH v3 06/10] pmdomain: samsung: convert to
 regmap_read_poll_timeout()
From: Marek Szyprowski <m.szyprowski@samsung.com>
To: =?UTF-8?Q?Andr=C3=A9_Draszik?= <andre.draszik@linaro.org>, Krzysztof
	Kozlowski <krzk@kernel.org>, Alim Akhtar <alim.akhtar@samsung.com>, Rob
	Herring <robh@kernel.org>, Conor Dooley <conor+dt@kernel.org>, Krzysztof
	Kozlowski <krzk+dt@kernel.org>, Ulf Hansson <ulf.hansson@linaro.org>
Cc: Peter Griffin <peter.griffin@linaro.org>, Tudor Ambarus
	<tudor.ambarus@linaro.org>, Will McVicker <willmcvicker@google.com>,
	kernel-team@android.com, linux-arm-kernel@lists.infradead.org,
	linux-samsung-soc@vger.kernel.org, devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org, linux-pm@vger.kernel.org
Content-Language: en-US
In-Reply-To: <2e38e6c2-0548-432f-ae34-daf3972877ac@samsung.com>
Content-Transfer-Encoding: 8bit
X-CMS-MailID: 20251022134509eucas1p1789fd89e07d10b550b7f21decd862d52
X-Msg-Generator: CA
Content-Type: text/plain; charset="utf-8"
X-RootMTR: 20251016155855eucas1p2ccc516861548e963761133fc52fc560e
X-EPHeader: CA
X-CMS-RootMailID: 20251016155855eucas1p2ccc516861548e963761133fc52fc560e
References: <20251016-gs101-pd-v3-0-7b30797396e7@linaro.org>
	<CGME20251016155855eucas1p2ccc516861548e963761133fc52fc560e@eucas1p2.samsung.com>
	<20251016-gs101-pd-v3-6-7b30797396e7@linaro.org>
	<2e38e6c2-0548-432f-ae34-daf3972877ac@samsung.com>

On 21.10.2025 22:38, Marek Szyprowski wrote:
> On 16.10.2025 17:58, André Draszik wrote:
>> Replace the open-coded PD status polling with
>> regmap_read_poll_timeout(). This change simplifies the code without
>> altering functionality.
>>
>> Signed-off-by: André Draszik <andre.draszik@linaro.org>
>> ---
>>   drivers/pmdomain/samsung/exynos-pm-domains.c | 29 
>> ++++++++--------------------
>>   1 file changed, 8 insertions(+), 21 deletions(-)
>>
>> diff --git a/drivers/pmdomain/samsung/exynos-pm-domains.c 
>> b/drivers/pmdomain/samsung/exynos-pm-domains.c
>> index 
>> 383126245811cb8e4dbae3b99ced3f06d3093f35..431548ad9a7e40c0a77ac6672081b600c90ddd4e 
>> 100644
>> --- a/drivers/pmdomain/samsung/exynos-pm-domains.c
>> +++ b/drivers/pmdomain/samsung/exynos-pm-domains.c
>> @@ -13,7 +13,6 @@
>>   #include <linux/platform_device.h>
>>   #include <linux/slab.h>
>>   #include <linux/pm_domain.h>
>> -#include <linux/delay.h>
>>   #include <linux/of.h>
>>   #include <linux/pm_runtime.h>
>>   #include <linux/regmap.h>
>> @@ -35,7 +34,8 @@ struct exynos_pm_domain {
>>   static int exynos_pd_power(struct generic_pm_domain *domain, bool 
>> power_on)
>>   {
>>       struct exynos_pm_domain *pd;
>> -    u32 timeout, pwr;
>> +    unsigned int val;
>> +    u32 pwr;
>>       int err;
>>         pd = container_of(domain, struct exynos_pm_domain, pd);
>> @@ -45,25 +45,12 @@ static int exynos_pd_power(struct 
>> generic_pm_domain *domain, bool power_on)
>>       if (err)
>>           return err;
>>   -    /* Wait max 1ms */
>> -    timeout = 10;
>> -    while (timeout-- > 0) {
>> -        unsigned int val;
>> -
>> -        err = regmap_read(pd->regmap, 0x4, &val);
>> -        if (err || ((val & pd->local_pwr_cfg) != pwr)) {
>> -            cpu_relax();
>> -            usleep_range(80, 100);
>> -            continue;
>> -        }
>> -
>> -        return 0;
>> -    }
>> -
>> -    if (!err)
>> -        err = -ETIMEDOUT;
>> -    pr_err("Power domain %s %sable failed: %d\n", domain->name,
>> -           power_on ? "en" : "dis", err);
>> +    err = regmap_read_poll_timeout(pd->regmap, 0x4, val,
>> +                       (val & pd->local_pwr_cfg) == pwr,
>> +                       100, 1 * USEC_PER_MSEC);
>> +    if (err)
>> +        pr_err("Power domain %s %sable failed: %d (%#.2x)\n",
>> +               domain->name, power_on ? "en" : "dis", err, val);
>
> I've posted my 'tested-by' tag for this patchset, but in meantime I 
> found that this patch causes regression from time to time on old 
> Exynos SoCs (especially when all debugs are disabled). It looks that 
> there are some subtle differences between reading the status register 
> up to 10 times with cpu_relax()+usleep_range() and the 
> regmap_read_poll_timeout(). I will try to analyze this a bit more and 
> provide details, but I suspect that the old loop might take a bit 
> longer than the 1ms from the comment above this code.

It looks that during the early boot all calls to 
regmap_read_poll_timeout() lasts exactly 10ms (measured with ktime_get() 
and ktime_to_ms()), what means that timekeeping source doesn't provide 
resolution high enough for the 1ms timeout. This in turn results in 
premature end of regmap_read_poll_timeout() loop after only one cycle of 
read+wait+read, what is not always enough for power domain to turn on/off.

According to the commit 7349a69cf312 ("iopoll: Do not use timekeeping in 
read_poll_timeout_atomic()"), ktime_get(), which is used also by 
regmap_read_poll_timeout(), is not reliable in all contexts, so I think 
that this patch should be dropped as there is no easy way to fix this.

The alternative would be to use regmap_read_poll_timeout_atomic(), which 
need to be fixed the same way as regmap_read_poll_timeout_atomic() by 
the mentioned commit, but in such case we would effectively switch from 
usleep to udelay.

Best regards
-- 
Marek Szyprowski, PhD
Samsung R&D Institute Poland


