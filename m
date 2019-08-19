Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id E0F8694D8C
	for <lists+linux-pm@lfdr.de>; Mon, 19 Aug 2019 21:08:28 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728424AbfHSTHx (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Mon, 19 Aug 2019 15:07:53 -0400
Received: from hqemgate15.nvidia.com ([216.228.121.64]:9385 "EHLO
        hqemgate15.nvidia.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728185AbfHSTHx (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Mon, 19 Aug 2019 15:07:53 -0400
Received: from hqpgpgate101.nvidia.com (Not Verified[216.228.121.13]) by hqemgate15.nvidia.com (using TLS: TLSv1.2, DES-CBC3-SHA)
        id <B5d5af3880001>; Mon, 19 Aug 2019 12:07:52 -0700
Received: from hqmail.nvidia.com ([172.20.161.6])
  by hqpgpgate101.nvidia.com (PGP Universal service);
  Mon, 19 Aug 2019 12:07:51 -0700
X-PGP-Universal: processed;
        by hqpgpgate101.nvidia.com on Mon, 19 Aug 2019 12:07:51 -0700
Received: from DRHQMAIL107.nvidia.com (10.27.9.16) by HQMAIL107.nvidia.com
 (172.20.187.13) with Microsoft SMTP Server (TLS) id 15.0.1473.3; Mon, 19 Aug
 2019 19:07:51 +0000
Received: from [10.110.103.66] (10.124.1.5) by DRHQMAIL107.nvidia.com
 (10.27.9.16) with Microsoft SMTP Server (TLS) id 15.0.1473.3; Mon, 19 Aug
 2019 19:07:50 +0000
Subject: Re: [PATCH v9 20/22] soc/tegra: pmc: Configure deep sleep control
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
References: <1565984527-5272-1-git-send-email-skomatineni@nvidia.com>
 <1565984527-5272-21-git-send-email-skomatineni@nvidia.com>
 <bf5541d2-1bad-8a8c-fd9d-821b55861136@gmail.com>
 <2092e557-06cb-4a74-fe40-1d83bf67ccca@nvidia.com>
Message-ID: <a8d65dbc-6924-c972-06e9-5bc47d66e94f@nvidia.com>
Date:   Mon, 19 Aug 2019 12:07:50 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.7.2
MIME-Version: 1.0
In-Reply-To: <2092e557-06cb-4a74-fe40-1d83bf67ccca@nvidia.com>
X-Originating-IP: [10.124.1.5]
X-ClientProxiedBy: HQMAIL101.nvidia.com (172.20.187.10) To
 DRHQMAIL107.nvidia.com (10.27.9.16)
Content-Type: text/plain; charset="utf-8"; format=flowed
Content-Transfer-Encoding: quoted-printable
Content-Language: en-US
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nvidia.com; s=n1;
        t=1566241672; bh=lDgc6QK33DRljdsnrvFj9EKf+a9SbqWwFOOiG9EuoAk=;
        h=X-PGP-Universal:Subject:From:To:CC:References:Message-ID:Date:
         User-Agent:MIME-Version:In-Reply-To:X-Originating-IP:
         X-ClientProxiedBy:Content-Type:Content-Transfer-Encoding:
         Content-Language;
        b=k3PNkY/zqJCaYV+SmTHtuqLnfIrIUjJap4KJsrwrW+761Wh6674laB+NR6y6whumN
         IvinVjqCeLAR+wbFOdUKjsYgARJy1eRRpS31N+657GvaYq/UgVtJWfJE6jYC/LEdc9
         exWUV/5obw5zb8Mb2pE5JHmA2D+sdX7MPNfPOyIFC1hr+9Q1qF3d9d3NXh7OuB9HAS
         wNegGp+ishXCr+H6dkQivS9IFywlvqvHrc1CDbXVZBxnJ7jV6sJYW5PKkF/c0kzCoO
         a8XWx4WNFb1ksAaoXq2G0cs59s76KMZdUFx2LA8hRf4ZBtaMaZrnGZWQhnYEHcPoi5
         SjmXNk3kQ9eqg==
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org


On 8/19/19 11:20 AM, Sowjanya Komatineni wrote:
>
> On 8/19/19 9:48 AM, Dmitry Osipenko wrote:
>> 16.08.2019 22:42, Sowjanya Komatineni =D0=BF=D0=B8=D1=88=D0=B5=D1=82:
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
>>> =C2=A0 drivers/soc/tegra/pmc.c | 14 +++++++++++++-
>>> =C2=A0 1 file changed, 13 insertions(+), 1 deletion(-)
>>>
>>> diff --git a/drivers/soc/tegra/pmc.c b/drivers/soc/tegra/pmc.c
>>> index 53ed70773872..710969043668 100644
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
>>> @@ -2303,6 +2305,16 @@ static void tegra20_pmc_init(struct tegra_pmc=20
>>> *pmc)
>>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 value =3D tegra_pmc_readl(pmc, PMC_CNTRL=
);
>>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 value |=3D PMC_CNTRL_SYSCLK_OE;
>>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 tegra_pmc_writel(pmc, value, PMC_CNTRL);
>>> +
>>> +=C2=A0=C2=A0=C2=A0 /* program core timings which are applicable only f=
or suspend=20
>>> state */
>>> +=C2=A0=C2=A0=C2=A0 if (pmc->suspend_mode !=3D TEGRA_SUSPEND_NONE) {
>>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 osc =3D DIV_ROUND_UP(pmc->c=
ore_osc_time * 8192, 1000000);
>>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 pmu =3D DIV_ROUND_UP(pmc->c=
ore_pmu_time * 32768, 1000000);
>>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 off =3D DIV_ROUND_UP(pmc->c=
ore_off_time * 32768, 1000000);
>>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 tegra_pmc_writel(pmc, ((osc=
 << 8) & 0xff00) | (pmu & 0xff),
>>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0 PMC_COREPWRGOOD_TIMER);
>>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 tegra_pmc_writel(pmc, off, =
PMC_COREPWROFF_TIMER);
>>> +=C2=A0=C2=A0=C2=A0 }
>>> =C2=A0 }
>>> =C2=A0 =C2=A0 static void tegra20_pmc_setup_irq_polarity(struct tegra_p=
mc *pmc,
>>>
>> In the previous version of this patch there were checks for zero values
>> of the timers with intention to skip programming of the timers if value
>> is zero. I'm a bit puzzled by the new version, given that SUSPEND_NONE
>> means that suspending isn't available at all and thus PMC timers won't
>> be utilized, hence it shouldn't matter what values are programmed for
>> the counters, isn't it?
>
> Yes, as I see in documentation we already specify all these timings=20
> are required properties when suspend mode is used, I updated in this=20
> version to program core timings only when suspend mode is enabled.
>
In other words, core timings are for SC7 entry only. So when SC7/suspend=20
mode is not used, these timings doesn't matter.
