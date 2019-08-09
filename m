Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 9F7798811C
	for <lists+linux-pm@lfdr.de>; Fri,  9 Aug 2019 19:24:36 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2406518AbfHIRYc (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Fri, 9 Aug 2019 13:24:32 -0400
Received: from hqemgate15.nvidia.com ([216.228.121.64]:17187 "EHLO
        hqemgate15.nvidia.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726358AbfHIRYb (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Fri, 9 Aug 2019 13:24:31 -0400
Received: from hqpgpgate101.nvidia.com (Not Verified[216.228.121.13]) by hqemgate15.nvidia.com (using TLS: TLSv1.2, DES-CBC3-SHA)
        id <B5d4dac580001>; Fri, 09 Aug 2019 10:24:40 -0700
Received: from hqmail.nvidia.com ([172.20.161.6])
  by hqpgpgate101.nvidia.com (PGP Universal service);
  Fri, 09 Aug 2019 10:24:29 -0700
X-PGP-Universal: processed;
        by hqpgpgate101.nvidia.com on Fri, 09 Aug 2019 10:24:29 -0700
Received: from [10.2.167.88] (10.124.1.5) by HQMAIL107.nvidia.com
 (172.20.187.13) with Microsoft SMTP Server (TLS) id 15.0.1473.3; Fri, 9 Aug
 2019 17:24:28 +0000
Subject: Re: [PATCH v8 19/21] soc/tegra: pmc: Configure deep sleep control
 settings
From:   Sowjanya Komatineni <skomatineni@nvidia.com>
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
 <275f3685-bc53-38ff-c778-cf2ea588e5a5@nvidia.com>
Message-ID: <60ea494a-9960-b7fc-3afb-8c17feec9fda@nvidia.com>
Date:   Fri, 9 Aug 2019 10:24:27 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.7.2
MIME-Version: 1.0
In-Reply-To: <275f3685-bc53-38ff-c778-cf2ea588e5a5@nvidia.com>
X-Originating-IP: [10.124.1.5]
X-ClientProxiedBy: HQMAIL105.nvidia.com (172.20.187.12) To
 HQMAIL107.nvidia.com (172.20.187.13)
Content-Type: text/plain; charset="utf-8"; format=flowed
Content-Transfer-Encoding: quoted-printable
Content-Language: en-US
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nvidia.com; s=n1;
        t=1565371480; bh=/f4jYEKxyB1FoXf4uT1AIcB499hX8TTQBWVXvydoY5E=;
        h=X-PGP-Universal:Subject:From:To:CC:References:Message-ID:Date:
         User-Agent:MIME-Version:In-Reply-To:X-Originating-IP:
         X-ClientProxiedBy:Content-Type:Content-Transfer-Encoding:
         Content-Language;
        b=HbwgriNPRkPifALJsYkdC+2geRtWm0TwB7+YC6TfNVc2n9prugwG4Ctob75lGK2lN
         /86Dxt5I3E7/gubJWUsZqSpXqAc89LeuMGcRfWZS4d88yKVWYNGjGxk8X/7bL/BFOh
         MbxkL5a15+qg40o9QYBKk9vfvYPc6PHm3OTVUyRtWDavtEqSYGTor7xk6uPo6Hx+2Y
         URarbXG5kS1EBjsCLeCBXnoDtpIoEGQsOBpmJz2cRPsPnYGrW66h3DxT127AsKlca5
         Lk7jxoP30zcGKOIqSzk+XZVr6FjvSBrUJlXY3r56wqFJDPV4N6PtNQzN9oX52qvWbK
         Bf2HAXaJLsz+A==
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org


On 8/9/19 9:23 AM, Sowjanya Komatineni wrote:
>
> On 8/9/19 6:23 AM, Dmitry Osipenko wrote:
>> 09.08.2019 2:46, Sowjanya Komatineni =D0=BF=D0=B8=D1=88=D0=B5=D1=82:
>>> Tegra210 and prior Tegra chips have deep sleep entry and wakeup related
>>> timings which are platform specific that should be configured before
>>> entering into deep sleep.
>>>
>>> Below are the timing specific configurations for deep sleep entry and
>>> wakeup.
>>> - Core rail power-on stabilization timer
>>> - OSC clock stabilization timer after SOC rail power is stabilized.
>>> - Core power off time is the minimum wake delay to keep the system
>>> =C2=A0=C2=A0 in deep sleep state irrespective of any quick wake event.
>>>
>>> These values depends on the discharge time of regulators and turn OFF
>>> time of the PMIC to allow the complete system to finish entering into
>>> deep sleep state.
>>>
>>> These values vary based on the platform design and are specified
>>> through the device tree.
>>>
>>> This patch has implementation to configure these timings which are must
>>> to have for proper deep sleep and wakeup operations.
>>>
>>> Signed-off-by: Sowjanya Komatineni <skomatineni@nvidia.com>
>>> ---
>>> =C2=A0 drivers/soc/tegra/pmc.c | 13 ++++++++++++-
>>> =C2=A0 1 file changed, 12 insertions(+), 1 deletion(-)
>>>
>>> diff --git a/drivers/soc/tegra/pmc.c b/drivers/soc/tegra/pmc.c
>>> index e013ada7e4e9..9a78d8417367 100644
>>> --- a/drivers/soc/tegra/pmc.c
>>> +++ b/drivers/soc/tegra/pmc.c
>>> @@ -88,6 +88,8 @@
>>> =C2=A0 =C2=A0 #define PMC_CPUPWRGOOD_TIMER=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0 0xc8
>>> =C2=A0 #define PMC_CPUPWROFF_TIMER=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0 0xcc
>>> +#define PMC_COREPWRGOOD_TIMER=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0 0x3c
>>> +#define PMC_COREPWROFF_TIMER=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
 0xe0
>>> =C2=A0 =C2=A0 #define PMC_PWR_DET_VALUE=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0 0xe4
>>> =C2=A0 @@ -2277,7 +2279,7 @@ static const struct tegra_pmc_regs=20
>>> tegra20_pmc_regs =3D {
>>> =C2=A0 =C2=A0 static void tegra20_pmc_init(struct tegra_pmc *pmc)
>>> =C2=A0 {
>>> -=C2=A0=C2=A0=C2=A0 u32 value;
>>> +=C2=A0=C2=A0=C2=A0 u32 value, osc, pmu, off;
>>> =C2=A0 =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 /* Always enable CPU power reques=
t */
>>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 value =3D tegra_pmc_readl(pmc, PMC_CNTRL=
);
>>> @@ -2303,6 +2305,15 @@ static void tegra20_pmc_init(struct tegra_pmc=20
>>> *pmc)
>>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 value =3D tegra_pmc_readl(pmc, PMC_CNTRL=
);
>>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 value |=3D PMC_CNTRL_SYSCLK_OE;
>>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 tegra_pmc_writel(pmc, value, PMC_CNTRL);
>>> +
>>> +=C2=A0=C2=A0=C2=A0 osc =3D DIV_ROUND_UP(pmc->core_osc_time * 8192, 100=
0000);
>>> +=C2=A0=C2=A0=C2=A0 pmu =3D DIV_ROUND_UP(pmc->core_pmu_time * 32768, 10=
00000);
>>> +=C2=A0=C2=A0=C2=A0 off =3D DIV_ROUND_UP(pmc->core_off_time * 32768, 10=
00000);
>>> +=C2=A0=C2=A0=C2=A0 if (osc && pmu)
>>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 tegra_pmc_writel(pmc, ((osc=
 << 8) & 0xff00) | (pmu & 0xff),
>>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0 PMC_COREPWRGOOD_TIMER);
>>> +=C2=A0=C2=A0=C2=A0 if (off)
>>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 tegra_pmc_writel(pmc, off, =
PMC_COREPWROFF_TIMER);
>> The osc/pmu/off values are undefined if they are not defined in=20
>> device-tree. I suppose this
>> need to be corrected in tegra_pmc_parse_dt() if the values really=20
>> matter even if LP0 suspend
>> isn't supported in device-tree.
>>
>> And I'm also not sure what's wrong with setting 0 for the timers.
>>
> These settings are for SC7 only and will not have any impact in normal=20
> state.
POR value for these timing registers is not 0 and has default timings=20
based on chip design and on top of that based on platform HW components=20
charge/discharge timings there's a need to increase these timings so=20
support for programming these thru DT is needed and these values have=20
effect only in LP0.
>>> =C2=A0 }
>>> =C2=A0 =C2=A0 static void tegra20_pmc_setup_irq_polarity(struct tegra_p=
mc *pmc,
>>>
