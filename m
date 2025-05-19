Return-Path: <linux-pm+bounces-27367-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id A40FFABC540
	for <lists+linux-pm@lfdr.de>; Mon, 19 May 2025 19:11:16 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id D0B54189F015
	for <lists+linux-pm@lfdr.de>; Mon, 19 May 2025 17:11:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 44329288537;
	Mon, 19 May 2025 17:11:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kwiboo.se header.i=@kwiboo.se header.b="CRHCQhBK"
X-Original-To: linux-pm@vger.kernel.org
Received: from smtp.forwardemail.net (smtp.forwardemail.net [121.127.44.73])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7CB5B28852A
	for <linux-pm@vger.kernel.org>; Mon, 19 May 2025 17:11:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=121.127.44.73
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747674673; cv=none; b=oDEoYYvaYm7u/FlZGhjzaIxS8AB5eb/P1cQkrJP1r8ex4TwivaqGFB8jOmykZAtAIMasE+9f53CU0faWnh7PA0diGEvyHR+WTFcYt6PpUpu8kJMQ+W4BwpGK5oTIRVVADFi0ioqQAjfT/Vv7yID74ue+WO7ce93c09Oo1C7355U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747674673; c=relaxed/simple;
	bh=IpZeW6XYHk5thIjqfNtBzC9Zdqq3wSYcPtCOxPBdJrU=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=UngKCWZf9FDkVCZPz3vyqnH3mc3j0PRje9sOvP3QNSOlP1kyQMftoe3aJpUZ7zVe8L1r3gpx6j8nrMqO6wmm02wC3T0IScViDFqHb/pf5jgtlp9FahkrxRtY5+mLtOmlJC/GtGScLGesntUIyhEg0n1yo8aLAQBV47rzD/aoiWg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=kwiboo.se; spf=pass smtp.mailfrom=fe-bounces.kwiboo.se; dkim=pass (2048-bit key) header.d=kwiboo.se header.i=@kwiboo.se header.b=CRHCQhBK; arc=none smtp.client-ip=121.127.44.73
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=kwiboo.se
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=fe-bounces.kwiboo.se
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kwiboo.se;
 h=Content-Transfer-Encoding: Content-Type: In-Reply-To: From: References:
 Cc: To: Subject: MIME-Version: Date: Message-ID; q=dns/txt;
 s=fe-e1b5cab7be; t=1747674670;
 bh=TUyCcOfCIf+2WqUBH26X/vT2c127e3sqHK+WEBFTQMk=;
 b=CRHCQhBKB3ZMYAIqvfykSQZBGaP2urEE6DPARoaaEzqSTKfQyNQ/LgMTkZY69//REF6Bqgyy9
 z+YDZAAcyOeLhATW5lN+jl1Lg1qLxQ1Pjy1AAp26vjcTKKDqLULBVQsdaLacD7lsM8fMl9gjsBn
 z8eXyvr0Kq9DUX/eDRslNC7B1kgNgCyuDAMNVD02gSXZGzuiadz4W81nVSc23HYIKe6V3zdLc8Z
 V3tA0T0FHAaP0mz/FNl0f4WHSbEdugKvy6MBYr/UFziou8BRIWY7aLj9NChE7NK6E9QmGYC2a9Y
 wLVqUx9ntbs2zWH2+brYQJeZidCOiqWrtGG4qodCVUZA==
X-Forward-Email-ID: 682b662cf094abf9f55ccb7b
X-Forward-Email-Sender: rfc822; jonas@kwiboo.se, smtp.forwardemail.net,
 121.127.44.73
X-Forward-Email-Version: 1.0.3
X-Forward-Email-Website: https://forwardemail.net
X-Complaints-To: abuse@forwardemail.net
X-Report-Abuse: abuse@forwardemail.net
X-Report-Abuse-To: abuse@forwardemail.net
Message-ID: <e2220468-29b4-4c92-a153-c65db19fd270@kwiboo.se>
Date: Mon, 19 May 2025 19:11:04 +0200
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 2/9] pmdomain: rockchip: Add support for RK3528
To: Yao Zi <ziyao@disroot.org>
Cc: Heiko Stuebner <heiko@sntech.de>, Ulf Hansson <ulf.hansson@linaro.org>,
 Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>,
 Conor Dooley <conor+dt@kernel.org>, Chukun Pan <amadeus@jmu.edu.cn>,
 linux-rockchip@lists.infradead.org, linux-pm@vger.kernel.org,
 devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
 linux-kernel@vger.kernel.org
References: <20250518220707.669515-1-jonas@kwiboo.se>
 <20250518220707.669515-3-jonas@kwiboo.se> <aCthtDxm25RU_fd3@pie.lan>
Content-Language: en-US
From: Jonas Karlman <jonas@kwiboo.se>
In-Reply-To: <aCthtDxm25RU_fd3@pie.lan>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 2025-05-19 18:52, Yao Zi wrote:
> On Sun, May 18, 2025 at 10:06:49PM +0000, Jonas Karlman wrote:
>> Add configuration and power domains for RK3528 SoC.
>>
>> Only PD_GPU can fully be powered down. PD_RKVDEC, PD_RKVENC, PD_VO and
>> PD_VPU are used by miscellaneous devices in RK3528.
> 
> Thanks for your work!
> 
>> Signed-off-by: Jonas Karlman <jonas@kwiboo.se>
>> ---
>>  drivers/pmdomain/rockchip/pm-domains.c | 27 ++++++++++++++++++++++++++
>>  1 file changed, 27 insertions(+)
>>
>> diff --git a/drivers/pmdomain/rockchip/pm-domains.c b/drivers/pmdomain/rockchip/pm-domains.c
>> index 4cce407bb1eb..242570c505fb 100644
>> --- a/drivers/pmdomain/rockchip/pm-domains.c
>> +++ b/drivers/pmdomain/rockchip/pm-domains.c
>> @@ -35,6 +35,7 @@
>>  #include <dt-bindings/power/rk3366-power.h>
>>  #include <dt-bindings/power/rk3368-power.h>
>>  #include <dt-bindings/power/rk3399-power.h>
>> +#include <dt-bindings/power/rockchip,rk3528-power.h>
>>  #include <dt-bindings/power/rockchip,rk3562-power.h>
> 
> But I had some trouble applying this patch on either Rockchip SoC tree
> or linux-pm. Looking through the context, seems the patch depends on
> some RK3562 PMU driver changes, which I couldn't find with some brief
> searching among the list.

Strange.

> 
> Which branch is the series based on?

My local branch was based on top of next-20250509 + latest
mmind/for-next (a95d16b0324b) merged.

Regards,
Jonas

> 
>>  #include <dt-bindings/power/rk3568-power.h>
>>  #include <dt-bindings/power/rockchip,rk3576-power.h>
>> @@ -216,6 +217,9 @@ struct rockchip_pmu {
>>  #define DOMAIN_RK3399(name, pwr, status, req, wakeup)		\
>>  	DOMAIN(name, pwr, status, req, req, req, wakeup)
>>  
>> +#define DOMAIN_RK3528(name, pwr, req)		\
>> +	DOMAIN_M(name, pwr, pwr, req, req, req, false)
>> +
>>  #define DOMAIN_RK3562(name, pwr, req, g_mask, mem, wakeup)		\
>>  	DOMAIN_M_G_SD(name, pwr, pwr, req, req, req, g_mask, mem, wakeup, false)
>>  
>> @@ -1215,6 +1219,14 @@ static const struct rockchip_domain_info rk3399_pm_domains[] = {
>>  	[RK3399_PD_SDIOAUDIO]	= DOMAIN_RK3399("sdioaudio", BIT(31), BIT(31), BIT(29), true),
>>  };
>>  
>> +static const struct rockchip_domain_info rk3528_pm_domains[] = {
>> +	[RK3528_PD_GPU]		= DOMAIN_RK3528("gpu",  BIT(0), BIT(4)),
>> +	[RK3528_PD_RKVDEC]	= DOMAIN_RK3528("vdec",      0, BIT(5)),
>> +	[RK3528_PD_RKVENC]	= DOMAIN_RK3528("venc",      0, BIT(6)),
>> +	[RK3528_PD_VO]		= DOMAIN_RK3528("vo",        0, BIT(7)),
>> +	[RK3528_PD_VPU]		= DOMAIN_RK3528("vpu",       0, BIT(8)),
>> +};
>> +
>>  static const struct rockchip_domain_info rk3562_pm_domains[] = {
>>  					     /* name           pwr     req     g_mask  mem wakeup */
>>  	[RK3562_PD_GPU]		= DOMAIN_RK3562("gpu",         BIT(0), BIT(1), BIT(1), 0, false),
>> @@ -1428,6 +1440,17 @@ static const struct rockchip_pmu_info rk3399_pmu = {
>>  	.domain_info = rk3399_pm_domains,
>>  };
>>  
>> +static const struct rockchip_pmu_info rk3528_pmu = {
>> +	.pwr_offset = 0x1210,
>> +	.status_offset = 0x1230,
>> +	.req_offset = 0x1110,
>> +	.idle_offset = 0x1128,
>> +	.ack_offset = 0x1120,
>> +
>> +	.num_domains = ARRAY_SIZE(rk3528_pm_domains),
>> +	.domain_info = rk3528_pm_domains,
>> +};
>> +
>>  static const struct rockchip_pmu_info rk3562_pmu = {
>>  	.pwr_offset = 0x210,
>>  	.status_offset = 0x230,
>> @@ -1538,6 +1561,10 @@ static const struct of_device_id rockchip_pm_domain_dt_match[] = {
>>  		.compatible = "rockchip,rk3399-power-controller",
>>  		.data = (void *)&rk3399_pmu,
>>  	},
>> +	{
>> +		.compatible = "rockchip,rk3528-power-controller",
>> +		.data = (void *)&rk3528_pmu,
>> +	},
>>  	{
>>  		.compatible = "rockchip,rk3562-power-controller",
>>  		.data = (void *)&rk3562_pmu,
>> -- 
>> 2.49.0
>>
> 
> Thanks for your effort,
> Yao Zi


