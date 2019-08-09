Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 35383882EE
	for <lists+linux-pm@lfdr.de>; Fri,  9 Aug 2019 20:50:45 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2405999AbfHISui (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Fri, 9 Aug 2019 14:50:38 -0400
Received: from hqemgate16.nvidia.com ([216.228.121.65]:15880 "EHLO
        hqemgate16.nvidia.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726168AbfHISuh (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Fri, 9 Aug 2019 14:50:37 -0400
Received: from hqpgpgate101.nvidia.com (Not Verified[216.228.121.13]) by hqemgate16.nvidia.com (using TLS: TLSv1.2, DES-CBC3-SHA)
        id <B5d4dc07d0002>; Fri, 09 Aug 2019 11:50:37 -0700
Received: from hqmail.nvidia.com ([172.20.161.6])
  by hqpgpgate101.nvidia.com (PGP Universal service);
  Fri, 09 Aug 2019 11:50:35 -0700
X-PGP-Universal: processed;
        by hqpgpgate101.nvidia.com on Fri, 09 Aug 2019 11:50:35 -0700
Received: from [10.2.167.88] (10.124.1.5) by HQMAIL107.nvidia.com
 (172.20.187.13) with Microsoft SMTP Server (TLS) id 15.0.1473.3; Fri, 9 Aug
 2019 18:50:34 +0000
Subject: Re: [PATCH v8 05/21] clk: tegra: pll: Save and restore pll context
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
 <1565308020-31952-6-git-send-email-skomatineni@nvidia.com>
 <68f65db6-44b7-1c75-2633-4a2fffd62a92@gmail.com>
 <dd20aa34-d838-40c4-9edd-bbe5973053f3@nvidia.com>
 <2eecf4ff-802d-7e0e-d971-0257fae4e3a2@gmail.com>
From:   Sowjanya Komatineni <skomatineni@nvidia.com>
Message-ID: <9096cbca-f647-b0af-2ab8-d48769555c3e@nvidia.com>
Date:   Fri, 9 Aug 2019 11:50:33 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.7.2
MIME-Version: 1.0
In-Reply-To: <2eecf4ff-802d-7e0e-d971-0257fae4e3a2@gmail.com>
X-Originating-IP: [10.124.1.5]
X-ClientProxiedBy: HQMAIL101.nvidia.com (172.20.187.10) To
 HQMAIL107.nvidia.com (172.20.187.13)
Content-Type: text/plain; charset="utf-8"; format=flowed
Content-Transfer-Encoding: quoted-printable
Content-Language: en-US
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nvidia.com; s=n1;
        t=1565376637; bh=SfvdUFKLkyQbfTKMP8GT8fp4INVlwrptcyWMvdGjvqQ=;
        h=X-PGP-Universal:Subject:To:CC:References:From:Message-ID:Date:
         User-Agent:MIME-Version:In-Reply-To:X-Originating-IP:
         X-ClientProxiedBy:Content-Type:Content-Transfer-Encoding:
         Content-Language;
        b=OTaGAijbYuLx6OHVL6rG0f89MiUPGg3h+uo8DRPKwUCDZ3zOylkdezrznU7bqqddA
         9i03jhAOpggS3ss1lNCOU217+PvSMFUZSn3SY6nbE0ab4QtmOHyVtU08+sflAmZdBO
         ZpiW13GEpoMT9uTSZylJsdPJLW6pjs16X7jtX7cBtuUskdx3yhf+BuCfvNJPK7cGOw
         nTzSx/4GNgIlqHzlXUDf9+vvWg1q/UFpy1c1ncSxdEj5VjXDBkrwOlNSfkrvepd7Um
         ma245jVkhZHDU81cdhwWaHH76UGumTiQk9nR7zAvP1PXuqM4m0sPcYRm20mhulmuXq
         It3Xqa/7azCPw==
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org


On 8/9/19 10:50 AM, Dmitry Osipenko wrote:
> 09.08.2019 20:39, Sowjanya Komatineni =D0=BF=D0=B8=D1=88=D0=B5=D1=82:
>> On 8/9/19 4:33 AM, Dmitry Osipenko wrote:
>>> 09.08.2019 2:46, Sowjanya Komatineni =D0=BF=D0=B8=D1=88=D0=B5=D1=82:
>>>> This patch implements save and restore of PLL context.
>>>>
>>>> During system suspend, core power goes off and looses the settings
>>>> of the Tegra CAR controller registers.
>>>>
>>>> So during suspend entry pll context is stored and on resume it is
>>>> restored back along with its state.
>>>>
>>>> Acked-by: Thierry Reding <treding@nvidia.com>
>>>> Signed-off-by: Sowjanya Komatineni <skomatineni@nvidia.com>
>>>> ---
>>>>  =C2=A0 drivers/clk/tegra/clk-pll.c | 88 ++++++++++++++++++++++++++++-=
----------------
>>>>  =C2=A0 drivers/clk/tegra/clk.h=C2=A0=C2=A0=C2=A0=C2=A0 |=C2=A0 2 ++
>>>>  =C2=A0 2 files changed, 58 insertions(+), 32 deletions(-)
>>>>
>>>> diff --git a/drivers/clk/tegra/clk-pll.c b/drivers/clk/tegra/clk-pll.c
>>>> index 1583f5fc992f..e52add2bbdbb 100644
>>>> --- a/drivers/clk/tegra/clk-pll.c
>>>> +++ b/drivers/clk/tegra/clk-pll.c
>>>> @@ -1008,6 +1008,28 @@ static unsigned long clk_plle_recalc_rate(struc=
t clk_hw *hw,
>>>>  =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 return rate;
>>>>  =C2=A0 }
>>>>  =C2=A0 +static void tegra_clk_pll_restore_context(struct clk_hw *hw)
>>>> +{
>>>> +=C2=A0=C2=A0=C2=A0 struct tegra_clk_pll *pll =3D to_clk_pll(hw);
>>>> +=C2=A0=C2=A0=C2=A0 struct clk_hw *parent =3D clk_hw_get_parent(hw);
>>>> +=C2=A0=C2=A0=C2=A0 unsigned long parent_rate =3D clk_hw_get_rate(pare=
nt);
>>>> +=C2=A0=C2=A0=C2=A0 unsigned long rate =3D clk_hw_get_rate(hw);
>>>> +=C2=A0=C2=A0=C2=A0 u32 val;
>>>> +
>>>> +=C2=A0=C2=A0=C2=A0 if (clk_pll_is_enabled(hw))
>>>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 return;
>>>> +
>>>> +=C2=A0=C2=A0=C2=A0 if (pll->params->set_defaults)
>>>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 pll->params->set_defaults(=
pll);
>>>> +
>>>> +=C2=A0=C2=A0=C2=A0 clk_pll_set_rate(hw, rate, parent_rate);
>>>> +
>>>> +=C2=A0=C2=A0=C2=A0 if (!__clk_get_enable_count(hw->clk))
>>> What about orphaned clocks? Is enable_count > 0 for them?
>> There are no orphaned pll clocks.
> Sorry, I meant the "clk_ignore_unused".

clocks with CLK_IGNORE_UNUSED are taken care by clk driver.

clk_disable_unused checks for clocks with this flag and if they are not=20
enabled it will enable them.

So by the time suspend happens enable_count is > 0


