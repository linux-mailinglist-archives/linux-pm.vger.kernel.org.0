Return-Path: <linux-pm+bounces-36607-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 01044BF8BB4
	for <lists+linux-pm@lfdr.de>; Tue, 21 Oct 2025 22:38:14 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 2DCF04E4242
	for <lists+linux-pm@lfdr.de>; Tue, 21 Oct 2025 20:38:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 89D5026738B;
	Tue, 21 Oct 2025 20:38:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=samsung.com header.i=@samsung.com header.b="rSyoE7eE"
X-Original-To: linux-pm@vger.kernel.org
Received: from mailout2.w1.samsung.com (mailout2.w1.samsung.com [210.118.77.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5EED18528E
	for <linux-pm@vger.kernel.org>; Tue, 21 Oct 2025 20:38:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=210.118.77.12
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761079089; cv=none; b=ZfgF0bdNhjzfkbGsupTuXqeRS3nG7lSdQWLGCzhYDSoynEQYmy17ZTYM0Z77qU5D/e4dkw6d1FFxzC6POGgGKRroejaDqjbjGv2WRMsVCOBpMebrN8a0lXgU+nwCQR/yVZ/5rOaCCavTcsbbOPlXivdNvxYXYGIQwhuqxAc317s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761079089; c=relaxed/simple;
	bh=2UzUPa0O7wVHv85721B5teO1x+rf4QPSmTIVyKZAjHQ=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:From:In-Reply-To:
	 Content-Type:References; b=gYDHgvt0nn26FudGH1ltHrK/glcxZK834oILYgpgMMrqrMHrZFE+2gvvFOWRTSMm7kyDXDYlJku4lrNg5nlqTdFZspjA/QjmXWzzv6STJqPHBxT/FH8DcrMOed++Zlk8PevOaW5ASuAW89eChsVTGLLguvMftRQ9kmdcr9UZIaM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=samsung.com; spf=pass smtp.mailfrom=samsung.com; dkim=pass (1024-bit key) header.d=samsung.com header.i=@samsung.com header.b=rSyoE7eE; arc=none smtp.client-ip=210.118.77.12
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=samsung.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=samsung.com
Received: from eucas1p2.samsung.com (unknown [182.198.249.207])
	by mailout2.w1.samsung.com (KnoxPortal) with ESMTP id 20251021203805euoutp02f3927bfa8bc40308fa60dd1a0fc613f1~wnBkEZHnc0098700987euoutp02B
	for <linux-pm@vger.kernel.org>; Tue, 21 Oct 2025 20:38:05 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout2.w1.samsung.com 20251021203805euoutp02f3927bfa8bc40308fa60dd1a0fc613f1~wnBkEZHnc0098700987euoutp02B
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
	s=mail20170921; t=1761079085;
	bh=WkfTpNuqej1UoTarvASJEkiFQ49zLY0qzCQi5FcT4uM=;
	h=Date:Subject:To:Cc:From:In-Reply-To:References:From;
	b=rSyoE7eEsLXh9M8Vms1QePG23J8dvTd+XqkgCf2aNnIF06Guc00f+AK4hNUbm+XLw
	 pJfmkcyYy9OpTo5HtJVNtSFgUe7ZKlhsHWf2/tt/kDnr4zYtaVbCXvNif9xY70br9D
	 /h2cMy3Hj9X/n0N535wxwcgZt96u+dAS1Heq4SpQ=
Received: from eusmtip2.samsung.com (unknown [203.254.199.222]) by
	eucas1p2.samsung.com (KnoxPortal) with ESMTPA id
	20251021203804eucas1p2c091f1cce52c4d08eeacf8c36604f1fb~wnBisd64H0197501975eucas1p21;
	Tue, 21 Oct 2025 20:38:04 +0000 (GMT)
Received: from [106.210.134.192] (unknown [106.210.134.192]) by
	eusmtip2.samsung.com (KnoxPortal) with ESMTPA id
	20251021203802eusmtip23e28f0f310780cc696c497752fb587eb~wnBhWTpKN1353213532eusmtip2A;
	Tue, 21 Oct 2025 20:38:02 +0000 (GMT)
Message-ID: <2e38e6c2-0548-432f-ae34-daf3972877ac@samsung.com>
Date: Tue, 21 Oct 2025 22:38:01 +0200
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Betterbird (Windows)
Subject: Re: [PATCH v3 06/10] pmdomain: samsung: convert to
 regmap_read_poll_timeout()
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
From: Marek Szyprowski <m.szyprowski@samsung.com>
In-Reply-To: <20251016-gs101-pd-v3-6-7b30797396e7@linaro.org>
Content-Transfer-Encoding: 8bit
X-CMS-MailID: 20251021203804eucas1p2c091f1cce52c4d08eeacf8c36604f1fb
X-Msg-Generator: CA
Content-Type: text/plain; charset="utf-8"
X-RootMTR: 20251016155855eucas1p2ccc516861548e963761133fc52fc560e
X-EPHeader: CA
X-CMS-RootMailID: 20251016155855eucas1p2ccc516861548e963761133fc52fc560e
References: <20251016-gs101-pd-v3-0-7b30797396e7@linaro.org>
	<CGME20251016155855eucas1p2ccc516861548e963761133fc52fc560e@eucas1p2.samsung.com>
	<20251016-gs101-pd-v3-6-7b30797396e7@linaro.org>

On 16.10.2025 17:58, André Draszik wrote:
> Replace the open-coded PD status polling with
> regmap_read_poll_timeout(). This change simplifies the code without
> altering functionality.
>
> Signed-off-by: André Draszik <andre.draszik@linaro.org>
> ---
>   drivers/pmdomain/samsung/exynos-pm-domains.c | 29 ++++++++--------------------
>   1 file changed, 8 insertions(+), 21 deletions(-)
>
> diff --git a/drivers/pmdomain/samsung/exynos-pm-domains.c b/drivers/pmdomain/samsung/exynos-pm-domains.c
> index 383126245811cb8e4dbae3b99ced3f06d3093f35..431548ad9a7e40c0a77ac6672081b600c90ddd4e 100644
> --- a/drivers/pmdomain/samsung/exynos-pm-domains.c
> +++ b/drivers/pmdomain/samsung/exynos-pm-domains.c
> @@ -13,7 +13,6 @@
>   #include <linux/platform_device.h>
>   #include <linux/slab.h>
>   #include <linux/pm_domain.h>
> -#include <linux/delay.h>
>   #include <linux/of.h>
>   #include <linux/pm_runtime.h>
>   #include <linux/regmap.h>
> @@ -35,7 +34,8 @@ struct exynos_pm_domain {
>   static int exynos_pd_power(struct generic_pm_domain *domain, bool power_on)
>   {
>   	struct exynos_pm_domain *pd;
> -	u32 timeout, pwr;
> +	unsigned int val;
> +	u32 pwr;
>   	int err;
>   
>   	pd = container_of(domain, struct exynos_pm_domain, pd);
> @@ -45,25 +45,12 @@ static int exynos_pd_power(struct generic_pm_domain *domain, bool power_on)
>   	if (err)
>   		return err;
>   
> -	/* Wait max 1ms */
> -	timeout = 10;
> -	while (timeout-- > 0) {
> -		unsigned int val;
> -
> -		err = regmap_read(pd->regmap, 0x4, &val);
> -		if (err || ((val & pd->local_pwr_cfg) != pwr)) {
> -			cpu_relax();
> -			usleep_range(80, 100);
> -			continue;
> -		}
> -
> -		return 0;
> -	}
> -
> -	if (!err)
> -		err = -ETIMEDOUT;
> -	pr_err("Power domain %s %sable failed: %d\n", domain->name,
> -	       power_on ? "en" : "dis", err);
> +	err = regmap_read_poll_timeout(pd->regmap, 0x4, val,
> +				       (val & pd->local_pwr_cfg) == pwr,
> +				       100, 1 * USEC_PER_MSEC);
> +	if (err)
> +		pr_err("Power domain %s %sable failed: %d (%#.2x)\n",
> +		       domain->name, power_on ? "en" : "dis", err, val);

I've posted my 'tested-by' tag for this patchset, but in meantime I 
found that this patch causes regression from time to time on old Exynos 
SoCs (especially when all debugs are disabled). It looks that there are 
some subtle differences between reading the status register up to 10 
times with cpu_relax()+usleep_range() and the 
regmap_read_poll_timeout(). I will try to analyze this a bit more and 
provide details, but I suspect that the old loop might take a bit longer 
than the 1ms from the comment above this code.


>   	return err;
>   }
>
Best regards
-- 
Marek Szyprowski, PhD
Samsung R&D Institute Poland


