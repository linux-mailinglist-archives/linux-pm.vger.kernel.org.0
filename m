Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 1B9D294C83
	for <lists+linux-pm@lfdr.de>; Mon, 19 Aug 2019 20:20:28 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727995AbfHSSUY (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Mon, 19 Aug 2019 14:20:24 -0400
Received: from hqemgate14.nvidia.com ([216.228.121.143]:16071 "EHLO
        hqemgate14.nvidia.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727769AbfHSSUY (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Mon, 19 Aug 2019 14:20:24 -0400
Received: from hqpgpgate102.nvidia.com (Not Verified[216.228.121.13]) by hqemgate14.nvidia.com (using TLS: TLSv1.2, DES-CBC3-SHA)
        id <B5d5ae8660007>; Mon, 19 Aug 2019 11:20:22 -0700
Received: from hqmail.nvidia.com ([172.20.161.6])
  by hqpgpgate102.nvidia.com (PGP Universal service);
  Mon, 19 Aug 2019 11:20:23 -0700
X-PGP-Universal: processed;
        by hqpgpgate102.nvidia.com on Mon, 19 Aug 2019 11:20:23 -0700
Received: from DRHQMAIL107.nvidia.com (10.27.9.16) by HQMAIL105.nvidia.com
 (172.20.187.12) with Microsoft SMTP Server (TLS) id 15.0.1473.3; Mon, 19 Aug
 2019 18:20:22 +0000
Received: from [10.110.103.66] (10.124.1.5) by DRHQMAIL107.nvidia.com
 (10.27.9.16) with Microsoft SMTP Server (TLS) id 15.0.1473.3; Mon, 19 Aug
 2019 18:20:22 +0000
Subject: Re: [PATCH v9 20/22] soc/tegra: pmc: Configure deep sleep control
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
References: <1565984527-5272-1-git-send-email-skomatineni@nvidia.com>
 <1565984527-5272-21-git-send-email-skomatineni@nvidia.com>
 <bf5541d2-1bad-8a8c-fd9d-821b55861136@gmail.com>
From:   Sowjanya Komatineni <skomatineni@nvidia.com>
Message-ID: <2092e557-06cb-4a74-fe40-1d83bf67ccca@nvidia.com>
Date:   Mon, 19 Aug 2019 11:20:21 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.7.2
MIME-Version: 1.0
In-Reply-To: <bf5541d2-1bad-8a8c-fd9d-821b55861136@gmail.com>
X-Originating-IP: [10.124.1.5]
X-ClientProxiedBy: HQMAIL101.nvidia.com (172.20.187.10) To
 DRHQMAIL107.nvidia.com (10.27.9.16)
Content-Type: text/plain; charset="utf-8"; format=flowed
Content-Transfer-Encoding: quoted-printable
Content-Language: en-US
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nvidia.com; s=n1;
        t=1566238823; bh=DG3Ncvdyhdgnv9HjB4ejbpQrlRq3pOO4ZH69laUIV64=;
        h=X-PGP-Universal:Subject:To:CC:References:From:Message-ID:Date:
         User-Agent:MIME-Version:In-Reply-To:X-Originating-IP:
         X-ClientProxiedBy:Content-Type:Content-Transfer-Encoding:
         Content-Language;
        b=Y8wgVA4pfeRKLIYg2KrGx9URLHJ4egqhwFl+VoI+e5pkLq7Dr+CJjxdfZe/+PIWvm
         tbeGbpDsRjTenb3ybLjI3O5/OgofFuZD6ZlVYAl5GT2VO+wZDeTgehO4Lyx5yWPWA2
         axs+WKmdVfPBZOnS3+Wh4a8OIoAQMN1yUQrnez2AFyXZvSNZlRllMsRFLmb0r9+nTQ
         jr9+jOGlXhUEl7IPnlT+0h8TqaQ9S2ZX1iJqsSqJ5u4iYCwrf2hkz3d5Ft7CMe9JU3
         Qaw9XuAp1G3xi8NZ3PNDumrp83oC++7DbYnRlT3nD0AS6WCUSJhQ3f8gmVZL5z7Qvm
         HDclZS5QY6WTg==
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org


On 8/19/19 9:48 AM, Dmitry Osipenko wrote:
> 16.08.2019 22:42, Sowjanya Komatineni =D0=BF=D0=B8=D1=88=D0=B5=D1=82:
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
>>   drivers/soc/tegra/pmc.c | 14 +++++++++++++-
>>   1 file changed, 13 insertions(+), 1 deletion(-)
>>
>> diff --git a/drivers/soc/tegra/pmc.c b/drivers/soc/tegra/pmc.c
>> index 53ed70773872..710969043668 100644
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
>> @@ -2303,6 +2305,16 @@ static void tegra20_pmc_init(struct tegra_pmc *pm=
c)
>>   	value =3D tegra_pmc_readl(pmc, PMC_CNTRL);
>>   	value |=3D PMC_CNTRL_SYSCLK_OE;
>>   	tegra_pmc_writel(pmc, value, PMC_CNTRL);
>> +
>> +	/* program core timings which are applicable only for suspend state */
>> +	if (pmc->suspend_mode !=3D TEGRA_SUSPEND_NONE) {
>> +		osc =3D DIV_ROUND_UP(pmc->core_osc_time * 8192, 1000000);
>> +		pmu =3D DIV_ROUND_UP(pmc->core_pmu_time * 32768, 1000000);
>> +		off =3D DIV_ROUND_UP(pmc->core_off_time * 32768, 1000000);
>> +		tegra_pmc_writel(pmc, ((osc << 8) & 0xff00) | (pmu & 0xff),
>> +				 PMC_COREPWRGOOD_TIMER);
>> +		tegra_pmc_writel(pmc, off, PMC_COREPWROFF_TIMER);
>> +	}
>>   }
>>  =20
>>   static void tegra20_pmc_setup_irq_polarity(struct tegra_pmc *pmc,
>>
> In the previous version of this patch there were checks for zero values
> of the timers with intention to skip programming of the timers if value
> is zero. I'm a bit puzzled by the new version, given that SUSPEND_NONE
> means that suspending isn't available at all and thus PMC timers won't
> be utilized, hence it shouldn't matter what values are programmed for
> the counters, isn't it?

Yes, as I see in documentation we already specify all these timings are=20
required properties when suspend mode is used, I updated in this version=20
to program core timings only when suspend mode is enabled.


