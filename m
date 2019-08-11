Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id D95318934F
	for <lists+linux-pm@lfdr.de>; Sun, 11 Aug 2019 21:16:57 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726502AbfHKTQx (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Sun, 11 Aug 2019 15:16:53 -0400
Received: from hqemgate16.nvidia.com ([216.228.121.65]:14883 "EHLO
        hqemgate16.nvidia.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726014AbfHKTQx (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Sun, 11 Aug 2019 15:16:53 -0400
Received: from hqpgpgate101.nvidia.com (Not Verified[216.228.121.13]) by hqemgate16.nvidia.com (using TLS: TLSv1.2, DES-CBC3-SHA)
        id <B5d5069a60001>; Sun, 11 Aug 2019 12:16:54 -0700
Received: from hqmail.nvidia.com ([172.20.161.6])
  by hqpgpgate101.nvidia.com (PGP Universal service);
  Sun, 11 Aug 2019 12:16:52 -0700
X-PGP-Universal: processed;
        by hqpgpgate101.nvidia.com on Sun, 11 Aug 2019 12:16:52 -0700
Received: from [10.2.167.88] (10.124.1.5) by HQMAIL107.nvidia.com
 (172.20.187.13) with Microsoft SMTP Server (TLS) id 15.0.1473.3; Sun, 11 Aug
 2019 19:16:50 +0000
Subject: Re: [PATCH v8 13/21] clk: tegra210: Use fence_udelay during PLLU init
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
 <1565308020-31952-14-git-send-email-skomatineni@nvidia.com>
 <1d09a2c5-4973-340f-fdfc-d4e665c8b55d@gmail.com>
From:   Sowjanya Komatineni <skomatineni@nvidia.com>
Message-ID: <af4dce78-5561-7078-1da7-cef01f187cf3@nvidia.com>
Date:   Sun, 11 Aug 2019 12:16:49 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.7.2
MIME-Version: 1.0
In-Reply-To: <1d09a2c5-4973-340f-fdfc-d4e665c8b55d@gmail.com>
X-Originating-IP: [10.124.1.5]
X-ClientProxiedBy: HQMAIL101.nvidia.com (172.20.187.10) To
 HQMAIL107.nvidia.com (172.20.187.13)
Content-Type: text/plain; charset="utf-8"; format=flowed
Content-Transfer-Encoding: quoted-printable
Content-Language: en-US
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nvidia.com; s=n1;
        t=1565551014; bh=B6ddjnEKl0ua+Tada6d8Tb7SUSLehPfPuF8MM3YYMj8=;
        h=X-PGP-Universal:Subject:To:CC:References:From:Message-ID:Date:
         User-Agent:MIME-Version:In-Reply-To:X-Originating-IP:
         X-ClientProxiedBy:Content-Type:Content-Transfer-Encoding:
         Content-Language;
        b=K6ERdW8yThtfsPaINCIqakd5gFwkxjyduawu95MVejzx32Fq0TqO1jaMsLabDvmE5
         /DFiAeD/BMuLmfdN3gkXnnb1GTiQ32zkFxz8IiH3pP6C6ORCCdE4/Bl5BGtZKn07hj
         U4kFIXRuMra4yyN3wXhdMtXeNfFVCBIgcc/YKPqAy3I57uYbrOVBVwDUXNFBfoW1Jv
         jDRLNih5SeR2PIhu0BznbHvZRZcF69Cm0yhf0za2gRcFZJKgOBz6JxJGgC9MqWqUum
         Bd63yHkGj5tyui/8MEMsf79d8GtFQCboBZQCglK65t40mmcM++wpwhVvbDfOmT69j5
         xtlCDuflo1isA==
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org


On 8/11/19 11:02 AM, Dmitry Osipenko wrote:
> 09.08.2019 2:46, Sowjanya Komatineni =D0=BF=D0=B8=D1=88=D0=B5=D1=82:
>> This patch uses fence_udelay rather than udelay during PLLU
>> initialization to ensure writes to clock registers happens before
>> waiting for specified delay.
>>
>> Acked-by: Thierry Reding <treding@nvidia.com>
>> Signed-off-by: Sowjanya Komatineni <skomatineni@nvidia.com>
>> ---
>>   drivers/clk/tegra/clk-tegra210.c | 8 ++++----
>>   1 file changed, 4 insertions(+), 4 deletions(-)
>>
>> diff --git a/drivers/clk/tegra/clk-tegra210.c b/drivers/clk/tegra/clk-te=
gra210.c
>> index 4721ee030d1c..998bf60b219a 100644
>> --- a/drivers/clk/tegra/clk-tegra210.c
>> +++ b/drivers/clk/tegra/clk-tegra210.c
>> @@ -2841,7 +2841,7 @@ static int tegra210_enable_pllu(void)
>>   	reg =3D readl_relaxed(clk_base + pllu.params->ext_misc_reg[0]);
>>   	reg &=3D ~BIT(pllu.params->iddq_bit_idx);
>>   	writel_relaxed(reg, clk_base + pllu.params->ext_misc_reg[0]);
>> -	udelay(5);
>> +	fence_udelay(5, clk_base);
>>  =20
>>   	reg =3D readl_relaxed(clk_base + PLLU_BASE);
>>   	reg &=3D ~GENMASK(20, 0);
>> @@ -2849,7 +2849,7 @@ static int tegra210_enable_pllu(void)
>>   	reg |=3D fentry->n << 8;
>>   	reg |=3D fentry->p << 16;
>>   	writel(reg, clk_base + PLLU_BASE);
>> -	udelay(1);
>> +	fence_udelay(1, clk_base);
>>   	reg |=3D PLL_ENABLE;
>>   	writel(reg, clk_base + PLLU_BASE);
>>  =20
>> @@ -2895,12 +2895,12 @@ static int tegra210_init_pllu(void)
>>   		reg =3D readl_relaxed(clk_base + XUSB_PLL_CFG0);
>>   		reg &=3D ~XUSB_PLL_CFG0_PLLU_LOCK_DLY_MASK;
>>   		writel_relaxed(reg, clk_base + XUSB_PLL_CFG0);
>> -		udelay(1);
>> +		fence_udelay(1, clk_base);
>>  =20
>>   		reg =3D readl_relaxed(clk_base + PLLU_HW_PWRDN_CFG0);
>>   		reg |=3D PLLU_HW_PWRDN_CFG0_SEQ_ENABLE;
>>   		writel_relaxed(reg, clk_base + PLLU_HW_PWRDN_CFG0);
>> -		udelay(1);
>> +		fence_udelay(1, clk_base);
>>  =20
>>   		reg =3D readl_relaxed(clk_base + PLLU_BASE);
>>   		reg &=3D ~PLLU_BASE_CLKENABLE_USB;
>>
> The clk_base corresponds to the RESET controller's part of Clock-and-Rese=
t hardware, is it
> okay to read-back the RST register and not the clock for the fencing?
Yes as both reset and clocks are all in same CAR
