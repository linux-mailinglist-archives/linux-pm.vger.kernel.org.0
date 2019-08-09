Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 48C9B8816E
	for <lists+linux-pm@lfdr.de>; Fri,  9 Aug 2019 19:39:22 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2407558AbfHIRjP (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Fri, 9 Aug 2019 13:39:15 -0400
Received: from hqemgate14.nvidia.com ([216.228.121.143]:7665 "EHLO
        hqemgate14.nvidia.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2406652AbfHIRjO (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Fri, 9 Aug 2019 13:39:14 -0400
Received: from hqpgpgate101.nvidia.com (Not Verified[216.228.121.13]) by hqemgate14.nvidia.com (using TLS: TLSv1.2, DES-CBC3-SHA)
        id <B5d4dafc30001>; Fri, 09 Aug 2019 10:39:15 -0700
Received: from hqmail.nvidia.com ([172.20.161.6])
  by hqpgpgate101.nvidia.com (PGP Universal service);
  Fri, 09 Aug 2019 10:39:13 -0700
X-PGP-Universal: processed;
        by hqpgpgate101.nvidia.com on Fri, 09 Aug 2019 10:39:13 -0700
Received: from [10.2.167.88] (10.124.1.5) by HQMAIL107.nvidia.com
 (172.20.187.13) with Microsoft SMTP Server (TLS) id 15.0.1473.3; Fri, 9 Aug
 2019 17:39:12 +0000
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
From:   Sowjanya Komatineni <skomatineni@nvidia.com>
Message-ID: <dd20aa34-d838-40c4-9edd-bbe5973053f3@nvidia.com>
Date:   Fri, 9 Aug 2019 10:39:11 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.7.2
MIME-Version: 1.0
In-Reply-To: <68f65db6-44b7-1c75-2633-4a2fffd62a92@gmail.com>
X-Originating-IP: [10.124.1.5]
X-ClientProxiedBy: HQMAIL105.nvidia.com (172.20.187.12) To
 HQMAIL107.nvidia.com (172.20.187.13)
Content-Type: text/plain; charset="utf-8"; format=flowed
Content-Transfer-Encoding: quoted-printable
Content-Language: en-US
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nvidia.com; s=n1;
        t=1565372355; bh=CzgvMgHAJL9GjuudcqOPdG9sFZIRj8vjIzWTv9Ucuco=;
        h=X-PGP-Universal:Subject:To:CC:References:From:Message-ID:Date:
         User-Agent:MIME-Version:In-Reply-To:X-Originating-IP:
         X-ClientProxiedBy:Content-Type:Content-Transfer-Encoding:
         Content-Language;
        b=jscOhXagojvphjbgkZOVS9C/YLvz7iscPfSVn1H7CdfLhijm8rQOVx83HAR2zFg/U
         nW3XRGBzGQ5MDyrfceIzfclrlvRjkSKGo0/JI2K3VyCF5d2An6w7zO+R0bNm69Ggj8
         P0V0nwzdVVpGH6Mkq2Dtwm9f/SZFheFMF9ANe9z11J1HX60ogs4KI1P1xbQ9GeMQsR
         Sv436o7ybJQlRcxo77aOtANj86WSAVg+Iy1w31hV0f9/S6Y/uGyXwv0M9Z4UTUJana
         bJtUwY5uXUoX93REFRMSaE8/UM5jPHMwFw48y4fvD8bFlwaShfuw+XsXnFyawS3qPH
         yxbYUCicwQXcA==
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org


On 8/9/19 4:33 AM, Dmitry Osipenko wrote:
> 09.08.2019 2:46, Sowjanya Komatineni =D0=BF=D0=B8=D1=88=D0=B5=D1=82:
>> This patch implements save and restore of PLL context.
>>
>> During system suspend, core power goes off and looses the settings
>> of the Tegra CAR controller registers.
>>
>> So during suspend entry pll context is stored and on resume it is
>> restored back along with its state.
>>
>> Acked-by: Thierry Reding <treding@nvidia.com>
>> Signed-off-by: Sowjanya Komatineni <skomatineni@nvidia.com>
>> ---
>>   drivers/clk/tegra/clk-pll.c | 88 ++++++++++++++++++++++++++++---------=
--------
>>   drivers/clk/tegra/clk.h     |  2 ++
>>   2 files changed, 58 insertions(+), 32 deletions(-)
>>
>> diff --git a/drivers/clk/tegra/clk-pll.c b/drivers/clk/tegra/clk-pll.c
>> index 1583f5fc992f..e52add2bbdbb 100644
>> --- a/drivers/clk/tegra/clk-pll.c
>> +++ b/drivers/clk/tegra/clk-pll.c
>> @@ -1008,6 +1008,28 @@ static unsigned long clk_plle_recalc_rate(struct =
clk_hw *hw,
>>   	return rate;
>>   }
>>  =20
>> +static void tegra_clk_pll_restore_context(struct clk_hw *hw)
>> +{
>> +	struct tegra_clk_pll *pll =3D to_clk_pll(hw);
>> +	struct clk_hw *parent =3D clk_hw_get_parent(hw);
>> +	unsigned long parent_rate =3D clk_hw_get_rate(parent);
>> +	unsigned long rate =3D clk_hw_get_rate(hw);
>> +	u32 val;
>> +
>> +	if (clk_pll_is_enabled(hw))
>> +		return;
>> +
>> +	if (pll->params->set_defaults)
>> +		pll->params->set_defaults(pll);
>> +
>> +	clk_pll_set_rate(hw, rate, parent_rate);
>> +
>> +	if (!__clk_get_enable_count(hw->clk))
> What about orphaned clocks? Is enable_count > 0 for them?
There are no orphaned pll clocks.
>> +		clk_pll_disable(hw);
>> +	else
>> +		clk_pll_enable(hw);
>> +}
> [snip]
