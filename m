Return-Path: <linux-pm+bounces-24069-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 207B1A61682
	for <lists+linux-pm@lfdr.de>; Fri, 14 Mar 2025 17:42:07 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 224913BE3C6
	for <lists+linux-pm@lfdr.de>; Fri, 14 Mar 2025 16:41:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8D361203718;
	Fri, 14 Mar 2025 16:41:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=samsung.com header.i=@samsung.com header.b="gllG0Kdb"
X-Original-To: linux-pm@vger.kernel.org
Received: from mailout1.w1.samsung.com (mailout1.w1.samsung.com [210.118.77.11])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7B262202F9E
	for <linux-pm@vger.kernel.org>; Fri, 14 Mar 2025 16:41:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=210.118.77.11
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741970511; cv=none; b=JHozIAybpJGTS/2GQEaYQoG0UMyLwC59xokDbTihi+bTKvs+ENtLWejfxFnpWnKGu0dTahAMA+1Ef8TuEhOAhEcXrR8f0oDJAbRJin9ObiMw7Zfw4mezlBrdYwILXSOf1+Oz2gKZnndbE6x3LgpCPBnJV8l+VvlKd5nyncgQmoI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741970511; c=relaxed/simple;
	bh=iScy1MCNzTIFtmxXYQTG2qk5hdNDHYXbrDbETGvOHo0=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:From:In-Reply-To:
	 Content-Type:References; b=Umrak84X4krOH4dFVLSSDLUv4g2yTAacXDkXU6ssR25nBLPku8OWwesrzARMwRMoe2dVN7DxD6OubvJ0+UIz+IboSQ7hykpPgSp5ckla8/3NdTIHuEPsvJcOE+xDbCcw5f8g6ObzGQuaa1VSa9aV8KSY4iCBny2zna0Q3lGOLCg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=samsung.com; spf=pass smtp.mailfrom=samsung.com; dkim=pass (1024-bit key) header.d=samsung.com header.i=@samsung.com header.b=gllG0Kdb; arc=none smtp.client-ip=210.118.77.11
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=samsung.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=samsung.com
Received: from eucas1p2.samsung.com (unknown [182.198.249.207])
	by mailout1.w1.samsung.com (KnoxPortal) with ESMTP id 20250314164146euoutp016d27a909a2fed834772fc4035daf2707~suPI5Asn71017810178euoutp01-
	for <linux-pm@vger.kernel.org>; Fri, 14 Mar 2025 16:41:46 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout1.w1.samsung.com 20250314164146euoutp016d27a909a2fed834772fc4035daf2707~suPI5Asn71017810178euoutp01-
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
	s=mail20170921; t=1741970506;
	bh=lqm59DIlU8Uravjb1r9ttfGo+LbA8OSm6CzNRKe5hJc=;
	h=Date:Subject:To:Cc:From:In-Reply-To:References:From;
	b=gllG0Kdb9Y8NTlPmK93k2GJgd8T7nJiytIUo1OMQgDQOJKbtV9sWqbrFxJPzaqq34
	 npcK/O5ENdTRo5bbldMIsoAm9NeRj8j56IlseFYJJU+iyiGCI3QtqdseJUxeWK9r4j
	 wO+ZCAHrhsjIqZCbJwXiy8mlX0DtCcxaFPdXmEt8=
Received: from eusmges3new.samsung.com (unknown [203.254.199.245]) by
	eucas1p1.samsung.com (KnoxPortal) with ESMTP id
	20250314164146eucas1p13f14cfd3854a8bbf5bc969a85a48dc75~suPIqwzVb0132101321eucas1p1M;
	Fri, 14 Mar 2025 16:41:46 +0000 (GMT)
Received: from eucas1p1.samsung.com ( [182.198.249.206]) by
	eusmges3new.samsung.com (EUCPMTA) with SMTP id 9B.1F.20397.94C54D76; Fri, 14
	Mar 2025 16:41:46 +0000 (GMT)
Received: from eusmtrp2.samsung.com (unknown [182.198.249.139]) by
	eucas1p2.samsung.com (KnoxPortal) with ESMTPA id
	20250314164145eucas1p25e7a2cc4fab4cc15471b5c1b42cd16bc~suPIEhrzU2579325793eucas1p2N;
	Fri, 14 Mar 2025 16:41:45 +0000 (GMT)
Received: from eusmgms1.samsung.com (unknown [182.198.249.179]) by
	eusmtrp2.samsung.com (KnoxPortal) with ESMTP id
	20250314164145eusmtrp2f2f24762421d6b18bccfe4837e014844~suPID5b_J1293912939eusmtrp2c;
	Fri, 14 Mar 2025 16:41:45 +0000 (GMT)
X-AuditID: cbfec7f5-e59c770000004fad-c7-67d45c49a3c7
Received: from eusmtip2.samsung.com ( [203.254.199.222]) by
	eusmgms1.samsung.com (EUCPMTA) with SMTP id 48.92.19920.94C54D76; Fri, 14
	Mar 2025 16:41:45 +0000 (GMT)
Received: from [192.168.1.44] (unknown [106.210.136.40]) by
	eusmtip2.samsung.com (KnoxPortal) with ESMTPA id
	20250314164144eusmtip2dce068d92b28a397692e243b7a37dbfe~suPHeu5jY0477404774eusmtip2f;
	Fri, 14 Mar 2025 16:41:44 +0000 (GMT)
Message-ID: <d4afcf0e-3b6b-4b2a-af51-7756e57136b0@samsung.com>
Date: Fri, 14 Mar 2025 17:41:44 +0100
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] pmdomain: thead: fix TH1520_AON_PROTOCOL dependency
To: Arnd Bergmann <arnd@kernel.org>, Drew Fustini <drew@pdp7.com>, Guo Ren
	<guoren@kernel.org>, Fu Wei <wefu@redhat.com>, Ulf Hansson
	<ulf.hansson@linaro.org>
Cc: Arnd Bergmann <arnd@arndb.de>, linux-riscv@lists.infradead.org,
	linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org
Content-Language: en-US
From: Michal Wilczynski <m.wilczynski@samsung.com>
In-Reply-To: <20250314154834.4053416-1-arnd@kernel.org>
Content-Transfer-Encoding: 7bit
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFlrPKsWRmVeSWpSXmKPExsWy7djPc7peMVfSDVatZ7L4O+kYu8W2LZtY
	Le5d2sJk8WJvI4vF5V1z2Cw+9x5htNj2uYXN4vjacIuW/VNYHDg9fv+axOixaVUnm8eda3vY
	PDYvqfdoWXuMyeP9vqtsHp83yQWwR3HZpKTmZJalFunbJXBlnLx3mangOV/F7K9NTA2Ml3i6
	GDk5JARMJJquvWXvYuTiEBJYwSjxbc03NgjnC6NE+6pOJpAqIYHPjBLbdtbBdHxa9QKqYzmj
	xPdtH5ghnLeMEqsuLAfr4BWwkzi++yYriM0ioCox9RvIDpC4oMTJmU9YQGxRAXmJ+7dmgMWF
	BTwkrrybCjZIRGARo0TP+wlgRcwCNRK3179mgrDFJW49mQ9mswkYSTxYPh9sAaeAucSZ2dMZ
	IWrkJba/nQM2SELgP4fEgh897BB3u0icaG9nhrCFJV4d3wIVl5H4vxNiqIRAvsSDrZ+gamok
	dvYch7KtJe6c+wUMGA6gBZoS63fpQ4QdJdb8X8cCEpYQ4JO48VYQ4gQ+iUnbpjNDhHklOtqE
	IKrVJKb29MItPbdiG9MERqVZSKEyC8mTs5A8Mwth7wJGllWM4qmlxbnpqcXGeanlesWJucWl
	eel6yfm5mxiBaer0v+NfdzCuePVR7xAjEwfjIUYJDmYlEd49KlfShXhTEiurUovy44tKc1KL
	DzFKc7AoifMu2t+aLiSQnliSmp2aWpBaBJNl4uCUamASlgzuDtgst319WJGIxluXsNUfFm7t
	k7maMfXAP7dZchY787pjPuZE6id/6gg9K6Hjt40lWdNx/93q+bq3pJVu2em+1f0cF+NQpMQY
	01e9lWN34NkQ1n8VtSLGOelvtgStvJN/0jY+5UBMyh2f2pY4Drv66+4bd73/W+ZSEtIt//fp
	tyXvfzitj3SfmunZvm3Jmrq70+pFsrdsefrllpkDb9KhJw2L1e6rpObcudnm5yLUE/pBxd6v
	/661VKT8i7NaRTuOrHKIYbOMO/hbsv6x32bV19zTuw4Lyf1QUOH2f+pceH7H5e7zjRtaT/s4
	FLPdNVgXrC6pouN26/k/32nVqbr8vdcSbtS9bEmoVWIpzkg01GIuKk4EADdCufvCAwAA
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFjrEIsWRmVeSWpSXmKPExsVy+t/xe7qeMVfSDab0ilr8nXSM3WLblk2s
	FvcubWGyeLG3kcXi8q45bBafe48wWmz73MJmcXxtuEXL/iksDpwev39NYvTYtKqTzePOtT1s
	HpuX1Hu0rD3G5PF+31U2j8+b5ALYo/RsivJLS1IVMvKLS2yVog0tjPQMLS30jEws9QyNzWOt
	jEyV9O1sUlJzMstSi/TtEvQyTt67zFTwnK9i9tcmpgbGSzxdjJwcEgImEp9WvWDvYuTiEBJY
	yigx/8lHZoiEjMS17pcsELawxJ9rXWwQRa8ZJSbP+MYGkuAVsJM4vvsmK4jNIqAqMfXbW3aI
	uKDEyZlPwJpFBeQl7t+aARYXFvCQuPJuKjPIIBGBRYwSJw7PZAJJMAvUSEzb3swKsaGLUWLr
	h0WsEAlxiVtP5oMVsQkYSTxYPh8szilgLnFm9nTGLkYOoBp1ifXzhCDK5SW2v53DPIFRaBaS
	O2YhmTQLoWMWko4FjCyrGEVSS4tz03OLDfWKE3OLS/PS9ZLzczcxAiNz27Gfm3cwznv1Ue8Q
	IxMH4yFGCQ5mJRHePSpX0oV4UxIrq1KL8uOLSnNSiw8xmgLDYiKzlGhyPjA15JXEG5oZmBqa
	mFkamFqaGSuJ87pdPp8mJJCeWJKanZpakFoE08fEwSnVwLRMNSDJWHlqZ7zzVPE3MlriQoYH
	FnMtj9xw3TAnoGb+1mpTdQnWJZr30v/efBadpDb/okvb7+v2mi5b+c5/mm2aMXdtVbyx1cmJ
	DVs3rGvKLvzfe3GObWJt+MSmj6uPvG3QOXLu5ISjXxZcmCgz52+y/DRX+cR7GcViv/5kOAkn
	hVxacXlWstIbMc+6UzWXDhmxGl+6ceZaa4KvgoKSsroD+4X0rsOfDxgJpuaXL3J21E6ZxC0t
	2LSdtXwSa4f8NN8yoSsLVq/ZcmDr8y1ayhFnXz5Z9OfEfh22cyfEDs+ye6M+dVJYX2XHxpf2
	i1+tq74ft2NpcmGeaOKsrqTPKZ+uBhVPnfJZj+1U6Yz/ts5KLMUZiYZazEXFiQAZ0dUDVQMA
	AA==
X-CMS-MailID: 20250314164145eucas1p25e7a2cc4fab4cc15471b5c1b42cd16bc
X-Msg-Generator: CA
Content-Type: text/plain; charset="utf-8"
X-RootMTR: 20250314154843eucas1p19fcaec24b94ca2479511cc8ea616bec2
X-EPHeader: CA
CMS-TYPE: 201P
X-CMS-RootMailID: 20250314154843eucas1p19fcaec24b94ca2479511cc8ea616bec2
References: <CGME20250314154843eucas1p19fcaec24b94ca2479511cc8ea616bec2@eucas1p1.samsung.com>
	<20250314154834.4053416-1-arnd@kernel.org>



On 3/14/25 16:48, Arnd Bergmann wrote:
> From: Arnd Bergmann <arnd@arndb.de>
> 
> Kconfig treats the dependency as optional, but the header file only provides
> normal declarations and no empty API stubs:
> 
> ld: fs/btrfs/extent_io.o: in function `writepage_delalloc':
> extent_io.c:(.text+0x2b42): undefined reference to `__udivdi3'
> ld: drivers/pmdomain/thead/th1520-pm-domains.o: in function `th1520_pd_power_off':
> th1520-pm-domains.c:(.text+0x57): undefined reference to `th1520_aon_power_update'
> ld: drivers/pmdomain/thead/th1520-pm-domains.o: in function `th1520_pd_power_on':
> th1520-pm-domains.c:(.text+0x8a): undefined reference to `th1520_aon_power_update'
> ld: drivers/pmdomain/thead/th1520-pm-domains.o: in function `th1520_pd_probe':
> th1520-pm-domains.c:(.text+0xb8): undefined reference to `th1520_aon_init'
> ld: th1520-pm-domains.c:(.text+0x1c6): undefined reference to `th1520_aon_power_update'
> 
> Since the firmware code can easily be enabled for compile testing, there
> is no need to add stubs either, so just make it a hard dependency.
> 
> Fixes: dc9a897dbb03 ("pmdomain: thead: Add power-domain driver for TH1520")
> Signed-off-by: Arnd Bergmann <arnd@arndb.de>
> ---
>  drivers/pmdomain/thead/Kconfig | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/drivers/pmdomain/thead/Kconfig b/drivers/pmdomain/thead/Kconfig
> index c7a1ac0c61dc..7d52f8374b07 100644
> --- a/drivers/pmdomain/thead/Kconfig
> +++ b/drivers/pmdomain/thead/Kconfig
> @@ -2,7 +2,7 @@
>  
>  config TH1520_PM_DOMAINS
>  	tristate "Support TH1520 Power Domains"
> -	depends on TH1520_AON_PROTOCOL || !TH1520_AON_PROTOCOL
> +	depends on TH1520_AON_PROTOCOL
>  	select REGMAP_MMIO
>  	help
>  	  This driver enables power domain management for the T-HEAD

Thanks a lot !
Reviewed-by: Michal Wilczynski <m.wilczynski@samsung.com>

