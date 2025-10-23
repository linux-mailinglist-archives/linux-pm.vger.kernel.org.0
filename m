Return-Path: <linux-pm+bounces-36720-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 4D2B5C010EF
	for <lists+linux-pm@lfdr.de>; Thu, 23 Oct 2025 14:17:46 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id A6C623A7498
	for <lists+linux-pm@lfdr.de>; Thu, 23 Oct 2025 12:17:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C1F34313549;
	Thu, 23 Oct 2025 12:17:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=samsung.com header.i=@samsung.com header.b="V/n3wje2"
X-Original-To: linux-pm@vger.kernel.org
Received: from mailout2.w1.samsung.com (mailout2.w1.samsung.com [210.118.77.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6340C31352E
	for <linux-pm@vger.kernel.org>; Thu, 23 Oct 2025 12:17:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=210.118.77.12
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761221858; cv=none; b=EBh5E+PpoGOZkp1lGruCziM6jMcSpJJ6d8/yoLLb4NxV2f2c8kPa+0Jn/3hgIwiW4xXPzTKdl/hsmvukBoHZyU3eqlFI7MrOoTet10mKPr7XF8M5AjjBmXtd4svL87NwOlbxElI0tKsvG2cx+xcrZD06yx/ExlBWGheR0dXMyPg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761221858; c=relaxed/simple;
	bh=F+IPlDFq86m88/BQzW1tUzZRcDaGgKPf/SBSPSggqsQ=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:From:In-Reply-To:
	 Content-Type:References; b=fJVxtirz/o2rd9UBDbY1hCqeVhgrBRwOy7lVyjHQxa3/7Y6/FXdXXYmS+Eo+R7QvEPuhpKz5Lb1mOsVQAPx2f1fd4Te7KYxkss5uw94/9tQuBcZBJHiZhwP3PLYV+kV0VzOBiEF0UU76CAsUBf9JYHG4UTegv49zU78D1cPMRAc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=samsung.com; spf=pass smtp.mailfrom=samsung.com; dkim=pass (1024-bit key) header.d=samsung.com header.i=@samsung.com header.b=V/n3wje2; arc=none smtp.client-ip=210.118.77.12
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=samsung.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=samsung.com
Received: from eucas1p2.samsung.com (unknown [182.198.249.207])
	by mailout2.w1.samsung.com (KnoxPortal) with ESMTP id 20251023121731euoutp02a6e3cd5625813bed307ec6184d5b87e4~xHfFejJet3128431284euoutp02y
	for <linux-pm@vger.kernel.org>; Thu, 23 Oct 2025 12:17:31 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout2.w1.samsung.com 20251023121731euoutp02a6e3cd5625813bed307ec6184d5b87e4~xHfFejJet3128431284euoutp02y
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
	s=mail20170921; t=1761221851;
	bh=lDw1nU8NLSxSa1gqia5h1scw7MTd+jhxy/PnLfCJ7Ks=;
	h=Date:Subject:To:Cc:From:In-Reply-To:References:From;
	b=V/n3wje2NJ8BLnwg4s18POq8rtSsar9kusWHxsaqF6P6x7rE7TlW2AXwY0m8nlusL
	 gt9HOPbivaiRXi7/VjOQCzlfIXrNQuh03yLkOxYJdL7QuENCB/JBu0r5qvOiHzvE3k
	 fVRpmi0ayFia6n07qcc/goyMfIszhKGBRvYk/3oM=
Received: from eusmtip2.samsung.com (unknown [203.254.199.222]) by
	eucas1p1.samsung.com (KnoxPortal) with ESMTPA id
	20251023121731eucas1p101ee5675a1effd61f7bbd504b018f529~xHfE-GNtq0073800738eucas1p15;
	Thu, 23 Oct 2025 12:17:31 +0000 (GMT)
Received: from [106.210.134.192] (unknown [106.210.134.192]) by
	eusmtip2.samsung.com (KnoxPortal) with ESMTPA id
	20251023121730eusmtip29e2f973850b2c55d974387409fea4f03~xHfEBdNx52867328673eusmtip2p;
	Thu, 23 Oct 2025 12:17:30 +0000 (GMT)
Message-ID: <cca286f5-bb43-4914-864c-b5e5c73270c8@samsung.com>
Date: Thu, 23 Oct 2025 14:17:29 +0200
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Betterbird (Windows)
Subject: Re: [PATCH v3 08/10] pmdomain: samsung: selectively handle enforced
 sync_state
To: Ulf Hansson <ulf.hansson@linaro.org>, Krzysztof Kozlowski
	<krzk@kernel.org>, Rob Herring <robh@kernel.org>
Cc: =?UTF-8?Q?Andr=C3=A9_Draszik?= <andre.draszik@linaro.org>, Alim Akhtar
	<alim.akhtar@samsung.com>, Conor Dooley <conor+dt@kernel.org>, Krzysztof
	Kozlowski <krzk+dt@kernel.org>, Peter Griffin <peter.griffin@linaro.org>,
	Tudor Ambarus <tudor.ambarus@linaro.org>, Will McVicker
	<willmcvicker@google.com>, kernel-team@android.com,
	linux-arm-kernel@lists.infradead.org, linux-samsung-soc@vger.kernel.org,
	devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
	linux-pm@vger.kernel.org
Content-Language: en-US
From: Marek Szyprowski <m.szyprowski@samsung.com>
In-Reply-To: <CAPDyKFrCS1PGwPeZd2ahZ=wKXCqPj93qAJ7V-ELELLA_OwgdSw@mail.gmail.com>
Content-Transfer-Encoding: 8bit
X-CMS-MailID: 20251023121731eucas1p101ee5675a1effd61f7bbd504b018f529
X-Msg-Generator: CA
Content-Type: text/plain; charset="utf-8"
X-RootMTR: 20251022110738eucas1p2cee28096ca5c9c6a802e2190d88ccf21
X-EPHeader: CA
X-CMS-RootMailID: 20251022110738eucas1p2cee28096ca5c9c6a802e2190d88ccf21
References: <20251016-gs101-pd-v3-0-7b30797396e7@linaro.org>
	<20251016-gs101-pd-v3-8-7b30797396e7@linaro.org>
	<CGME20251022110738eucas1p2cee28096ca5c9c6a802e2190d88ccf21@eucas1p2.samsung.com>
	<CAPDyKFq2esPos=D-eVz6w1VXq=4LYi6fx54K4TvsUi4JqUJOaQ@mail.gmail.com>
	<57bacc06-8a5e-4284-a520-c5d2a56545e9@samsung.com>
	<CAPDyKFrCS1PGwPeZd2ahZ=wKXCqPj93qAJ7V-ELELLA_OwgdSw@mail.gmail.com>

On 23.10.2025 12:02, Ulf Hansson wrote:
> On Wed, 22 Oct 2025 at 20:39, Marek Szyprowski <m.szyprowski@samsung.com> wrote:
>> On 22.10.2025 13:06, Ulf Hansson wrote:
>>> On Thu, 16 Oct 2025 at 17:58, André Draszik <andre.draszik@linaro.org> wrote:
>>>> Unconditionally calling of_genpd_sync_state() causes issues on
>>>> platforms with child domains as the parent domain will be turned off
>>>> before the child domain was even registered during boot.
>>>>
>>>> This in particular is an issue for the upcoming Google gs101 support -
>>>> all operations on child domains registered after the parent domain
>>>> misbehave.
>>>>
>>>> Add a flag to the probe data to be able to sync_state conditionally
>>>> only, and enable that flag on the two platforms currently supported by
>>>> this driver.
>>>>
>>>> Signed-off-by: André Draszik <andre.draszik@linaro.org>
>>>>
>>>> ---
>>>> v2:
>>>> * use bool for need_early_sync_state (Krzysztof)
>>>> ---
>>>>    drivers/pmdomain/samsung/exynos-pm-domains.c | 5 ++++-
>>>>    1 file changed, 4 insertions(+), 1 deletion(-)
>>>>
>>>> diff --git a/drivers/pmdomain/samsung/exynos-pm-domains.c b/drivers/pmdomain/samsung/exynos-pm-domains.c
>>>> index 638d286b57f716140b2401092415644a6805870e..15a1582aa92103a07335eb681600d9415369fefd 100644
>>>> --- a/drivers/pmdomain/samsung/exynos-pm-domains.c
>>>> +++ b/drivers/pmdomain/samsung/exynos-pm-domains.c
>>>> @@ -20,6 +20,7 @@
>>>>    struct exynos_pm_domain_config {
>>>>           /* Value for LOCAL_PWR_CFG and STATUS fields for each domain */
>>>>           u32 local_pwr_cfg;
>>>> +       bool need_early_sync_state;
>>>>    };
>>>>
>>>>    /*
>>>> @@ -69,10 +70,12 @@ static int exynos_pd_power_off(struct generic_pm_domain *domain)
>>>>
>>>>    static const struct exynos_pm_domain_config exynos4210_cfg = {
>>>>           .local_pwr_cfg          = 0x7,
>>>> +       .need_early_sync_state  = true,
>>>>    };
>>>>
>>>>    static const struct exynos_pm_domain_config exynos5433_cfg = {
>>>>           .local_pwr_cfg          = 0xf,
>>>> +       .need_early_sync_state  = true,
>>>>    };
>>>>
>>>>    static const struct of_device_id exynos_pm_domain_of_match[] = {
>>>> @@ -179,7 +182,7 @@ static int exynos_pd_probe(struct platform_device *pdev)
>>>>            * reset during boot. As a temporary hack to manage this, let's enforce
>>>>            * a sync_state.
>>>>            */
>>>> -       if (!ret)
>>>> +       if (pm_domain_cfg->need_early_sync_state && !ret)
>>>>                   of_genpd_sync_state(np);
>>> The call to of_genpd_sync_state() was intended as a temporary solution here.
>>>
>>> Potentially, if we would be able to distinguish what PM domain that is
>>> causing the problem on the Exynos platforms, we could set
>>> GENPD_FLAG_NO_STAY_ON for that genpd instead.
>> Well, this of_genpd_sync_state() "workaround" has to be applied only to
>> the power domain of the display controller device. It can be replaced by
>> the following check on the legacy Exynos systems:
>>
>> if (IS_ENABLED(CONFIG_ARM) &&
>> of_device_is_compatible(np, "samsung,exynos4210-pd") &&
>> (strstr(pd->pd.name, "LCD") || strstr(pd->pd.name, "DISP")))
>> pd->pd.flags = GENPD_FLAG_NO_STAY_ON;
> Oh wait, perhaps better to just power-off these PM domains before
> calling pm_genpd_init(), if that can be done safely?
>
> At least that would guarantee the reset to happen before the display
> driver gets probed. Instead of relying on genpd_power_off_unused()
> (late_initcall_sync) to do it.

Well, yes, this works too:

if ((of_device_is_compatible(np, "samsung,exynos4210-pd") &&
     (strstr(pd->pd.name, "LCD") || strstr(pd->pd.name, "DISP"))))
          exynos_pd_power_off(&pd->pd);

>> I assume that this information cannot be coded in device tree to make it
>> somehow generic...
> Right, in principle we would need a new DT property for a power-domain
> provider, like "broken-hw-reset", because we don't have a reset-line
> to pull.

It is not a matter of broken reset at all. It is a matter of software 
configuration and the lack of 'protocol' to pass the information that 
the display controller is configured to display splash screen from the 
system memory at given address and newly instantiated drivers must to be 
aware of that.

Turning display-related power domain off simply resets all that 
configuration, so drivers can start from good known 'unconfigured' state.

Best regards
-- 
Marek Szyprowski, PhD
Samsung R&D Institute Poland


