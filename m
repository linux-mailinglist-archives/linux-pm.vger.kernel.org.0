Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id D82D38828A
	for <lists+linux-pm@lfdr.de>; Fri,  9 Aug 2019 20:33:31 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2436754AbfHISda (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Fri, 9 Aug 2019 14:33:30 -0400
Received: from hqemgate14.nvidia.com ([216.228.121.143]:10517 "EHLO
        hqemgate14.nvidia.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2405723AbfHISda (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Fri, 9 Aug 2019 14:33:30 -0400
Received: from hqpgpgate101.nvidia.com (Not Verified[216.228.121.13]) by hqemgate14.nvidia.com (using TLS: TLSv1.2, DES-CBC3-SHA)
        id <B5d4dbc7a0002>; Fri, 09 Aug 2019 11:33:30 -0700
Received: from hqmail.nvidia.com ([172.20.161.6])
  by hqpgpgate101.nvidia.com (PGP Universal service);
  Fri, 09 Aug 2019 11:33:28 -0700
X-PGP-Universal: processed;
        by hqpgpgate101.nvidia.com on Fri, 09 Aug 2019 11:33:28 -0700
Received: from [10.2.167.88] (10.124.1.5) by HQMAIL107.nvidia.com
 (172.20.187.13) with Microsoft SMTP Server (TLS) id 15.0.1473.3; Fri, 9 Aug
 2019 18:33:27 +0000
Subject: Re: [PATCH v8 11/21] clk: tegra: clk-dfll: Add suspend and resume
 support
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
 <1565308020-31952-12-git-send-email-skomatineni@nvidia.com>
 <eb4fdab8-aba3-7f0c-a391-d751674fd03e@gmail.com>
 <29a85a35-10ff-2d43-d148-9dba1ee25869@nvidia.com>
 <84a0d46a-bca2-1000-a2a6-8890ee702dd3@gmail.com>
From:   Sowjanya Komatineni <skomatineni@nvidia.com>
Message-ID: <9902aa72-3f18-9840-35ad-137293d2e26c@nvidia.com>
Date:   Fri, 9 Aug 2019 11:33:26 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.7.2
MIME-Version: 1.0
In-Reply-To: <84a0d46a-bca2-1000-a2a6-8890ee702dd3@gmail.com>
X-Originating-IP: [10.124.1.5]
X-ClientProxiedBy: HQMAIL105.nvidia.com (172.20.187.12) To
 HQMAIL107.nvidia.com (172.20.187.13)
Content-Type: text/plain; charset="utf-8"; format=flowed
Content-Transfer-Encoding: quoted-printable
Content-Language: en-US
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nvidia.com; s=n1;
        t=1565375610; bh=RL3xW/QV8ig+4LOtDKUXlwGYg2LoxLMNhawJPeDdkro=;
        h=X-PGP-Universal:Subject:To:CC:References:From:Message-ID:Date:
         User-Agent:MIME-Version:In-Reply-To:X-Originating-IP:
         X-ClientProxiedBy:Content-Type:Content-Transfer-Encoding:
         Content-Language;
        b=PpZY5iBbGEvm7gAPal8Gj+kjDjdYIKM7c5m+y3squ6PxdfK5512ANCp1yXGF7WkGK
         8MkEkIKzaxbXdfOt2lUUbaALPWiLC6HhZbFtcCaRlPHX99vikblmdxalGwDVbqrWPY
         vMdiOYXR5FAtwHBK1UFt3pT6F/M49X0MM5AFCm80KTjs2EY/5n4DYtKz3kAuiPCch8
         UEujoW4PLGOiPOY3Agj/Q24f+7i34V83GgK/b/DmLrxsJgLJbXmdUtUC65GPuXU56m
         FXvfyS94TS6MFriG1tBDlKSloKPwddwBZO2oL++f/jMty0h6HqoqosjFY0YQ0ydsaC
         ZlHwkkyO/A7SA==
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org


On 8/9/19 11:00 AM, Dmitry Osipenko wrote:
> 09.08.2019 19:39, Sowjanya Komatineni =D0=BF=D0=B8=D1=88=D0=B5=D1=82:
>> On 8/9/19 5:23 AM, Dmitry Osipenko wrote:
>>> 09.08.2019 2:46, Sowjanya Komatineni =D0=BF=D0=B8=D1=88=D0=B5=D1=82:
>>>> This patch implements DFLL suspend and resume operation.
>>>>
>>>> During system suspend entry, CPU clock will switch CPU to safe
>>>> clock source of PLLP and disables DFLL clock output.
>>>>
>>>> DFLL driver suspend confirms DFLL disable state and errors out on
>>>> being active.
>>>>
>>>> DFLL is re-initialized during the DFLL driver resume as it goes
>>>> through complete reset during suspend entry.
>>>>
>>>> Signed-off-by: Sowjanya Komatineni <skomatineni@nvidia.com>
>>>> ---
>>>>  =C2=A0 drivers/clk/tegra/clk-dfll.c=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 | 56 ++++++++++++++++++=
++++++++++++
>>>>  =C2=A0 drivers/clk/tegra/clk-dfll.h=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 |=C2=A0 2 ++
>>>>  =C2=A0 drivers/clk/tegra/clk-tegra124-dfll-fcpu.c |=C2=A0 1 +
>>>>  =C2=A0 3 files changed, 59 insertions(+)
>>>>
>>>> diff --git a/drivers/clk/tegra/clk-dfll.c b/drivers/clk/tegra/clk-dfll=
.c
>>>> index f8688c2ddf1a..eb298a5d7be9 100644
>>>> --- a/drivers/clk/tegra/clk-dfll.c
>>>> +++ b/drivers/clk/tegra/clk-dfll.c
>>>> @@ -1487,6 +1487,7 @@ static int dfll_init(struct tegra_dfll *td)
>>>>  =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 td->last_unrounded_rate =3D 0;
>>>>  =C2=A0 =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 pm_runtime_enable(td->dev);
>>>> +=C2=A0=C2=A0=C2=A0 pm_runtime_irq_safe(td->dev);
>>>>  =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 pm_runtime_get_sync(td->dev);
>>>>  =C2=A0 =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 dfll_set_mode(td, DFLL_DISABLED=
);
>>>> @@ -1513,6 +1514,61 @@ static int dfll_init(struct tegra_dfll *td)
>>>>  =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 return ret;
>>>>  =C2=A0 }
>>>>  =C2=A0 +/**
>>>> + * tegra_dfll_suspend - check DFLL is disabled
>>>> + * @dev: DFLL device *
>>>> + *
>>>> + * DFLL clock should be disabled by the CPUFreq driver. So, make
>>>> + * sure it is disabled and disable all clocks needed by the DFLL.
>>>> + */
>>>> +int tegra_dfll_suspend(struct device *dev)
>>>> +{
>>>> +=C2=A0=C2=A0=C2=A0 struct tegra_dfll *td =3D dev_get_drvdata(dev);
>>>> +
>>>> +=C2=A0=C2=A0=C2=A0 if (dfll_is_running(td)) {
>>>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 dev_err(td->dev, "dfll is =
enabled while shouldn't be\n");
>>>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 return -EBUSY;
>>>> +=C2=A0=C2=A0=C2=A0 }
>>>> +
>>>> +=C2=A0=C2=A0=C2=A0 reset_control_assert(td->dvco_rst);
>>>> +
>>>> +=C2=A0=C2=A0=C2=A0 return 0;
>>>> +}
>>>> +EXPORT_SYMBOL(tegra_dfll_suspend);
>>>> +
>>>> +/**
>>>> + * tegra_dfll_resume - reinitialize DFLL on resume
>>>> + * @dev: DFLL instance
>>>> + *
>>>> + * DFLL is disabled and reset during suspend and resume.
>>>> + * So, reinitialize the DFLL IP block back for use.
>>>> + * DFLL clock is enabled later in closed loop mode by CPUFreq
>>>> + * driver before switching its clock source to DFLL output.
>>>> + */
>>>> +int tegra_dfll_resume(struct device *dev)
>>>> +{
>>>> +=C2=A0=C2=A0=C2=A0 struct tegra_dfll *td =3D dev_get_drvdata(dev);
>>>> +
>>>> +=C2=A0=C2=A0=C2=A0 reset_control_deassert(td->dvco_rst);
>>> This doesn't look right because I assume that DFLL resetting is
>>> synchronous and thus clk should be enabled in order for reset to
>>> propagate inside hardware.
>>>
>>>> +=C2=A0=C2=A0=C2=A0 pm_runtime_get_sync(td->dev);
>>> Hence it will be better to remove the above reset_control_deassert() an=
d
>>> add here:
>>>
>>>  =C2=A0=C2=A0=C2=A0=C2=A0reset_control_reset(td->dvco_rst);
>> By the time dfll resume happens, dfll controller clock will already be e=
nabled.
>>
>> so doing reset de-assert before pm_runtime seems ok.
> I don't see what enables the DFLL clock because it should be enabled by t=
he CPUFreq driver
> on resume from suspend and resume happens after resuming of the DFLL driv=
er.

dvco_rst is part of peripheral clocks and all peripheral clocks are=20
restored by clk-tegra210 driver which happens before dfll driver resume.

So dfll rst thru part of peripheral clock enable is set prior to dfll=20
reset deassertion

