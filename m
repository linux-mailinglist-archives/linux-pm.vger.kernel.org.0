Return-Path: <linux-pm+bounces-30686-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id D2CFCB01CC7
	for <lists+linux-pm@lfdr.de>; Fri, 11 Jul 2025 15:03:58 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id EB4211CA71B8
	for <lists+linux-pm@lfdr.de>; Fri, 11 Jul 2025 13:04:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AE94F2C327C;
	Fri, 11 Jul 2025 12:59:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=samsung.com header.i=@samsung.com header.b="sJIjFK2h"
X-Original-To: linux-pm@vger.kernel.org
Received: from mailout1.w1.samsung.com (mailout1.w1.samsung.com [210.118.77.11])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 488902D23B8
	for <linux-pm@vger.kernel.org>; Fri, 11 Jul 2025 12:59:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=210.118.77.11
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752238751; cv=none; b=tU+mUImqsVMHEdUgQYwCcrGLVEy21TIhY4cDEuQiaiuduHSM5oOscUI3k3fxzuRZLmifR2wvcFN03/e4nvvmTKOvgOBDd9+4QLHQjxHWLHv0IN0R4Mgmp5MoIMsdgRJfdcN3fb3f4pohYxB0H844v4Un4rR5u0B3+H7PFCVouE0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752238751; c=relaxed/simple;
	bh=4M9ldy+V4oLhPUak4VZMhJhEiovbN8RCnFKfpUi5kl4=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:From:In-Reply-To:
	 Content-Type:References; b=bqju1unJ8lNzrq26JnLqwMunoBosyV9zpp+kpfl7+1ExzRbghE6K6vHrh022jh1b4/2i7xv5bYhvV2vsAju85ShLzO88WWbuYbvWicQ+1ivuqWmsM0CmflufaYaj1TxQvPgJ658Xy/NI4pJkFdMhk7tl3DkQfVCY+9/dUxzuQ7s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=samsung.com; spf=pass smtp.mailfrom=samsung.com; dkim=pass (1024-bit key) header.d=samsung.com header.i=@samsung.com header.b=sJIjFK2h; arc=none smtp.client-ip=210.118.77.11
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=samsung.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=samsung.com
Received: from eucas1p2.samsung.com (unknown [182.198.249.207])
	by mailout1.w1.samsung.com (KnoxPortal) with ESMTP id 20250711125907euoutp019d12aba7aa6b10a860e193aef7ee6a3e~RM9tyw43j3149931499euoutp01g
	for <linux-pm@vger.kernel.org>; Fri, 11 Jul 2025 12:59:07 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout1.w1.samsung.com 20250711125907euoutp019d12aba7aa6b10a860e193aef7ee6a3e~RM9tyw43j3149931499euoutp01g
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
	s=mail20170921; t=1752238747;
	bh=3kDealCV6zffo4RuWYcZVJvSwU3t4q0xUuFSOKLwc8Q=;
	h=Date:Subject:To:Cc:From:In-Reply-To:References:From;
	b=sJIjFK2hjreora6isCVF4sSwqZooR1YZAfTELwJUidrX9mSB+CTKpaGsUaO80uubv
	 L1R7wxFaNIcD/bGKEGPmwl17W6BB26vIBjVCBSJufCtaLiw11GRKlqUzegaaZtpWLk
	 vmvRRgAvTAQIkL7Oet0Qxrt9jxXynaxQKN4XuPsc=
Received: from eusmtip1.samsung.com (unknown [203.254.199.221]) by
	eucas1p1.samsung.com (KnoxPortal) with ESMTPA id
	20250711125906eucas1p1bdd63ed78efdc9e1ed419e3765f939c2~RM9tLOVmS2722427224eucas1p1u;
	Fri, 11 Jul 2025 12:59:06 +0000 (GMT)
Received: from [106.210.134.192] (unknown [106.210.134.192]) by
	eusmtip1.samsung.com (KnoxPortal) with ESMTPA id
	20250711125906eusmtip1d00d7a0a16b6f50ed698eeeab2ff3a30~RM9saRIS00427404274eusmtip1O;
	Fri, 11 Jul 2025 12:59:06 +0000 (GMT)
Message-ID: <751b912d-48a5-416d-aa83-8947b952dd5e@samsung.com>
Date: Fri, 11 Jul 2025 14:59:05 +0200
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] pmdomain: samsung: Fix splash-screen handover by
 enforcing a sync_state
To: Ulf Hansson <ulf.hansson@linaro.org>, linux-pm@vger.kernel.org
Cc: Krzysztof Kozlowski <krzk@kernel.org>, Alim Akhtar
	<alim.akhtar@samsung.com>, linux-arm-kernel@lists.infradead.org,
	linux-samsung-soc@vger.kernel.org, linux-kernel@vger.kernel.org
Content-Language: en-US
From: Marek Szyprowski <m.szyprowski@samsung.com>
In-Reply-To: <20250711114719.189441-1-ulf.hansson@linaro.org>
Content-Transfer-Encoding: 7bit
X-CMS-MailID: 20250711125906eucas1p1bdd63ed78efdc9e1ed419e3765f939c2
X-Msg-Generator: CA
Content-Type: text/plain; charset="utf-8"
X-RootMTR: 20250711114739eucas1p2e3b4b266d24dc239b8ef4f75da06e40b
X-EPHeader: CA
X-CMS-RootMailID: 20250711114739eucas1p2e3b4b266d24dc239b8ef4f75da06e40b
References: <CGME20250711114739eucas1p2e3b4b266d24dc239b8ef4f75da06e40b@eucas1p2.samsung.com>
	<20250711114719.189441-1-ulf.hansson@linaro.org>

On 11.07.2025 13:47, Ulf Hansson wrote:
> It's has been reported that some Samsung platforms fails to boot with
> genpd's new sync_state support.
>
> Typically the problem exists for platforms where bootloaders are turning on
> the splash-screen and handing it over to be managed by the kernel. However,
> at this point, it's not clear how to correctly solve the problem.
>
> Although, to make the platforms boot again, let's add a temporary hack in
> the samsung power-domain provider driver, which enforces a sync_state that
> allows the power-domains to be reset before consumer devices starts to be
> attached.
>
> Reported-by: Marek Szyprowski <m.szyprowski@samsung.com>
> Link: https://lore.kernel.org/all/212a1a56-08a5-48a5-9e98-23de632168d0@samsung.com
> Signed-off-by: Ulf Hansson <ulf.hansson@linaro.org>

This fixes the issue and seems to be a good workaround for now. Thanks!

Tested-by: Marek Szyprowski <m.szyprowski@samsung.com>

I will work on the proper fix in 2 weeks after getting back from holidays.


> ---
>   drivers/pmdomain/samsung/exynos-pm-domains.c | 9 +++++++++
>   1 file changed, 9 insertions(+)
>
> diff --git a/drivers/pmdomain/samsung/exynos-pm-domains.c b/drivers/pmdomain/samsung/exynos-pm-domains.c
> index 9b502e8751d1..5d478bb37ad6 100644
> --- a/drivers/pmdomain/samsung/exynos-pm-domains.c
> +++ b/drivers/pmdomain/samsung/exynos-pm-domains.c
> @@ -147,6 +147,15 @@ static int exynos_pd_probe(struct platform_device *pdev)
>   				parent.np, child.np);
>   	}
>   
> +	/*
> +	 * Some Samsung platforms with bootloaders turning on the splash-screen
> +	 * and handing it over to the kernel, requires the power-domains to be
> +	 * reset during boot. As a temporary hack to manage this, let's enforce
> +	 * a sync_state.
> +	 */
> +	if (!ret)
> +		of_genpd_sync_state(np);
> +
>   	pm_runtime_enable(dev);
>   	return ret;
>   }

Best regards
-- 
Marek Szyprowski, PhD
Samsung R&D Institute Poland


