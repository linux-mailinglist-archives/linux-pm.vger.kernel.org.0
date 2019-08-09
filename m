Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 1C05087FC3
	for <lists+linux-pm@lfdr.de>; Fri,  9 Aug 2019 18:23:31 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2407414AbfHIQXZ (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Fri, 9 Aug 2019 12:23:25 -0400
Received: from hqemgate14.nvidia.com ([216.228.121.143]:3035 "EHLO
        hqemgate14.nvidia.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2407405AbfHIQXY (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Fri, 9 Aug 2019 12:23:24 -0400
Received: from hqpgpgate101.nvidia.com (Not Verified[216.228.121.13]) by hqemgate14.nvidia.com (using TLS: TLSv1.2, DES-CBC3-SHA)
        id <B5d4d9dfc0001>; Fri, 09 Aug 2019 09:23:24 -0700
Received: from hqmail.nvidia.com ([172.20.161.6])
  by hqpgpgate101.nvidia.com (PGP Universal service);
  Fri, 09 Aug 2019 09:23:22 -0700
X-PGP-Universal: processed;
        by hqpgpgate101.nvidia.com on Fri, 09 Aug 2019 09:23:22 -0700
Received: from [10.2.167.88] (10.124.1.5) by HQMAIL107.nvidia.com
 (172.20.187.13) with Microsoft SMTP Server (TLS) id 15.0.1473.3; Fri, 9 Aug
 2019 16:23:21 +0000
Subject: Re: [PATCH v8 19/21] soc/tegra: pmc: Configure deep sleep control
 settings
To:     Dmitry Osipenko <digetx@gmail.com>, <thierry.reding@gmail.com>,
        <jonathanh@nvidia.com>, <tglx@linutronix.de>,
        <jason@lakedaemon.net>, <marc.zyngier@arm.com>,
        <linus.walleij@linaro.org>, <stefan@agner.ch>,
        <mark.rutland@arm.com>
CC:     <pdeschrijver@nvidia.com>, <pgaikwad@nvidia.com>,
        <sboyd@kernel.org>, <linux-clk@vger.kernel.org>,
        <linux-gpio@vger.kernel.org>, <jckuo@nvidia.com>,
        <josephl@nvidia.com>, <talho@nvidia.com>,
        <linux-tegra@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <mperttunen@nvidia.com>, <spatra@nvidia.com>, <robh+dt@kernel.org>,
        <devicetree@vger.kernel.org>, <rjw@rjwysocki.net>,
        <viresh.kumar@linaro.org>, <linux-pm@vger.kernel.org>
References: <1565308020-31952-1-git-send-email-skomatineni@nvidia.com>
 <1565308020-31952-20-git-send-email-skomatineni@nvidia.com>
 <57ed54cd-bf57-cab1-eb63-8548761640de@gmail.com>
From:   Sowjanya Komatineni <skomatineni@nvidia.com>
Message-ID: <275f3685-bc53-38ff-c778-cf2ea588e5a5@nvidia.com>
Date:   Fri, 9 Aug 2019 09:23:20 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.7.2
MIME-Version: 1.0
In-Reply-To: <57ed54cd-bf57-cab1-eb63-8548761640de@gmail.com>
X-Originating-IP: [10.124.1.5]
X-ClientProxiedBy: HQMAIL101.nvidia.com (172.20.187.10) To
 HQMAIL107.nvidia.com (172.20.187.13)
Content-Type: text/plain; charset="utf-8"; format=flowed
Content-Transfer-Encoding: quoted-printable
Content-Language: en-US
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nvidia.com; s=n1;
        t=1565367804; bh=hZlKkX1rFr4vL+pJND2gxRlDf4kcTv5t7znratg6u9E=;
        h=X-PGP-Universal:Subject:To:CC:References:From:Message-ID:Date:
         User-Agent:MIME-Version:In-Reply-To:X-Originating-IP:
         X-ClientProxiedBy:Content-Type:Content-Transfer-Encoding:
         Content-Language;
        b=SJkVka8g7pDkab2VphrL2rmAmK5iXvcQ05yk3qkKTv3xk4y3vUoBg/pRkL3nWidRN
         5oiE+oirqHYJS+K+KJFSToQ7i7sCrAbjVP6LflqEOf7/PFpjEuCR/CS120Tlm4UKWF
         admBMJgXBi4e0v/n+PqESkWFCAGHv5ndT77VICIqXja+08Cg+hAiq9WgpEUDN6MIuB
         f4XvEanilPyGjZp81Au9pHkxlKQO/WFLl2dftnl38Me4HaR/WB4prpS25quawOpctt
         yszooDw8n76ZdYfVywL8u3Vciydmc3ezjp+2wBcs4tbMS8Xejdw3WWIzKGrwkmJIcE
         pbyST3xXUvLcw==
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org


On 8/9/19 6:23 AM, Dmitry Osipenko wrote:
> 09.08.2019 2:46, Sowjanya Komatineni =D0=BF=D0=B8=D1=88=D0=B5=D1=82:
>> Tegra210 and prior Tegra chips have deep sleep entry and wakeup related
>> timings which are platform specific that should be configured before
>> entering into deep sleep.
>>
>> Below are the timing specific configurations for deep sleep entry and
>> wakeup.
>> - Core rail power-on stabilization timer
>> - OSC clock stabilization timer after SOC rail power is stabilized.
>> - Core power off time is the minimum wake delay to keep the system
>>    in deep sleep state irrespective of any quick wake event.
>>
>> These values depends on the discharge time of regulators and turn OFF
>> time of the PMIC to allow the complete system to finish entering into
>> deep sleep state.
>>
>> These values vary based on the platform design and are specified
>> through the device tree.
>>
>> This patch has implementation to configure these timings which are must
>> to have for proper deep sleep and wakeup operations.
>>
>> Signed-off-by: Sowjanya Komatineni <skomatineni@nvidia.com>
>> ---
>>   drivers/soc/tegra/pmc.c | 13 ++++++++++++-
>>   1 file changed, 12 insertions(+), 1 deletion(-)
>>
>> diff --git a/drivers/soc/tegra/pmc.c b/drivers/soc/tegra/pmc.c
>> index e013ada7e4e9..9a78d8417367 100644
>> --- a/drivers/soc/tegra/pmc.c
>> +++ b/drivers/soc/tegra/pmc.c
>> @@ -88,6 +88,8 @@
>>  =20
>>   #define PMC_CPUPWRGOOD_TIMER		0xc8
>>   #define PMC_CPUPWROFF_TIMER		0xcc
>> +#define PMC_COREPWRGOOD_TIMER		0x3c
>> +#define PMC_COREPWROFF_TIMER		0xe0
>>  =20
>>   #define PMC_PWR_DET_VALUE		0xe4
>>  =20
>> @@ -2277,7 +2279,7 @@ static const struct tegra_pmc_regs tegra20_pmc_reg=
s =3D {
>>  =20
>>   static void tegra20_pmc_init(struct tegra_pmc *pmc)
>>   {
>> -	u32 value;
>> +	u32 value, osc, pmu, off;
>>  =20
>>   	/* Always enable CPU power request */
>>   	value =3D tegra_pmc_readl(pmc, PMC_CNTRL);
>> @@ -2303,6 +2305,15 @@ static void tegra20_pmc_init(struct tegra_pmc *pm=
c)
>>   	value =3D tegra_pmc_readl(pmc, PMC_CNTRL);
>>   	value |=3D PMC_CNTRL_SYSCLK_OE;
>>   	tegra_pmc_writel(pmc, value, PMC_CNTRL);
>> +
>> +	osc =3D DIV_ROUND_UP(pmc->core_osc_time * 8192, 1000000);
>> +	pmu =3D DIV_ROUND_UP(pmc->core_pmu_time * 32768, 1000000);
>> +	off =3D DIV_ROUND_UP(pmc->core_off_time * 32768, 1000000);
>> +	if (osc && pmu)
>> +		tegra_pmc_writel(pmc, ((osc << 8) & 0xff00) | (pmu & 0xff),
>> +				 PMC_COREPWRGOOD_TIMER);
>> +	if (off)
>> +		tegra_pmc_writel(pmc, off, PMC_COREPWROFF_TIMER);
> The osc/pmu/off values are undefined if they are not defined in device-tr=
ee. I suppose this
> need to be corrected in tegra_pmc_parse_dt() if the values really matter =
even if LP0 suspend
> isn't supported in device-tree.
>
> And I'm also not sure what's wrong with setting 0 for the timers.
>
These settings are for SC7 only and will not have any impact in normal=20
state.
>>   }
>>  =20
>>   static void tegra20_pmc_setup_irq_polarity(struct tegra_pmc *pmc,
>>
