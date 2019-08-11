Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 66DD889348
	for <lists+linux-pm@lfdr.de>; Sun, 11 Aug 2019 21:16:23 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726469AbfHKTQT (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Sun, 11 Aug 2019 15:16:19 -0400
Received: from hqemgate14.nvidia.com ([216.228.121.143]:12661 "EHLO
        hqemgate14.nvidia.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726014AbfHKTQS (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Sun, 11 Aug 2019 15:16:18 -0400
Received: from hqpgpgate102.nvidia.com (Not Verified[216.228.121.13]) by hqemgate14.nvidia.com (using TLS: TLSv1.2, DES-CBC3-SHA)
        id <B5d50695b0000>; Sun, 11 Aug 2019 12:15:39 -0700
Received: from hqmail.nvidia.com ([172.20.161.6])
  by hqpgpgate102.nvidia.com (PGP Universal service);
  Sun, 11 Aug 2019 12:15:37 -0700
X-PGP-Universal: processed;
        by hqpgpgate102.nvidia.com on Sun, 11 Aug 2019 12:15:37 -0700
Received: from [10.2.167.88] (10.124.1.5) by HQMAIL107.nvidia.com
 (172.20.187.13) with Microsoft SMTP Server (TLS) id 15.0.1473.3; Sun, 11 Aug
 2019 19:15:35 +0000
Subject: Re: [PATCH v8 14/21] clk: tegra210: Add suspend and resume support
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
 <1565308020-31952-15-git-send-email-skomatineni@nvidia.com>
 <a21b7464-62c3-8461-04c2-a0e863bdde85@gmail.com>
 <7d101ec9-c559-8b40-1764-6bf67a9c7a7a@nvidia.com>
 <aa823801-00c7-df88-0f63-45338bffa854@gmail.com>
 <cbe94f84-a17b-7e1a-811d-89db571784e1@nvidia.com>
 <4397de5d-772d-2b04-5f87-b2988f6c96c8@gmail.com>
From:   Sowjanya Komatineni <skomatineni@nvidia.com>
Message-ID: <805a825e-f19d-d056-83eb-8ed1cb1c089c@nvidia.com>
Date:   Sun, 11 Aug 2019 12:15:34 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.7.2
MIME-Version: 1.0
In-Reply-To: <4397de5d-772d-2b04-5f87-b2988f6c96c8@gmail.com>
X-Originating-IP: [10.124.1.5]
X-ClientProxiedBy: HQMAIL101.nvidia.com (172.20.187.10) To
 HQMAIL107.nvidia.com (172.20.187.13)
Content-Type: text/plain; charset="utf-8"; format=flowed
Content-Transfer-Encoding: quoted-printable
Content-Language: en-US
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nvidia.com; s=n1;
        t=1565550939; bh=N8c2FWu26nfTsIdttcw9WFv0expJxHBD/dEzp9/+g7A=;
        h=X-PGP-Universal:Subject:To:CC:References:From:Message-ID:Date:
         User-Agent:MIME-Version:In-Reply-To:X-Originating-IP:
         X-ClientProxiedBy:Content-Type:Content-Transfer-Encoding:
         Content-Language;
        b=cu26SHazNM1/FKhF+tv777uAetvdlWMznh/dxSLeNqu5gt82VPilm+2ZuNS3rcG5x
         7uwnI8iDc4Tv7TwNF7YnmvODIzCk7AkPHMVQAwSoXZVsWOHG5owxfaxkFXdGialIe9
         y2VBAFmQZh8/ASf4gFyqCK8Psj9dA1f/AmxCq3JwPHUUmRFc0z73jEhYx4o4jTqZQe
         lknuL9l34lpmqGhgHtwuSEPmKzJY36HfI621t4PxqlIRZhtkisO8Im8ptS+VUSGatv
         pO7+u8yOqG0CpCWotORTHbLZoi209dczMiTmlu5UTsVrAlyafjCZrzEFnuOOKJZBPg
         nwzA8nVxGAsFA==
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org


On 8/11/19 10:39 AM, Dmitry Osipenko wrote:
> 09.08.2019 21:40, Sowjanya Komatineni =D0=BF=D0=B8=D1=88=D0=B5=D1=82:
>> On 8/9/19 11:18 AM, Dmitry Osipenko wrote:
>>> 09.08.2019 19:19, Sowjanya Komatineni =D0=BF=D0=B8=D1=88=D0=B5=D1=82:
>>>> On 8/9/19 6:56 AM, Dmitry Osipenko wrote:
>>>>> 09.08.2019 2:46, Sowjanya Komatineni =D0=BF=D0=B8=D1=88=D0=B5=D1=82:
>>>>>> This patch adds support for clk: tegra210: suspend-resume.
>>>>>>
>>>>>> All the CAR controller settings are lost on suspend when core
>>>>>> power goes off.
>>>>>>
>>>>>> This patch has implementation for saving and restoring all PLLs
>>>>>> and clocks context during system suspend and resume to have the
>>>>>> clocks back to same state for normal operation.
>>>>>>
>>>>>> Clock driver suspend and resume are registered as syscore_ops as clo=
cks
>>>>>> restore need to happen before the other drivers resume to have all t=
heir
>>>>>> clocks back to the same state as before suspend.
>>>>>>
>>>>>> Signed-off-by: Sowjanya Komatineni <skomatineni@nvidia.com>
>>>>>> ---
>>>>>>  =C2=A0 drivers/clk/tegra/clk-tegra210.c | 103 +++++++++++++++++++++=
++++++++++++++++--
>>>>>>  =C2=A0 drivers/clk/tegra/clk.c=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0 |=C2=A0 64 ++++++++++++++++++++++++
>>>>>>  =C2=A0 drivers/clk/tegra/clk.h=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0 |=C2=A0=C2=A0 3 ++
>>>>>>  =C2=A0 3 files changed, 166 insertions(+), 4 deletions(-)
>>>>>>
>>>>>> diff --git a/drivers/clk/tegra/clk-tegra210.c b/drivers/clk/tegra/cl=
k-tegra210.c
>>>>>> index 998bf60b219a..8dd6f4f4debb 100644
>>>>>> --- a/drivers/clk/tegra/clk-tegra210.c
>>>>>> +++ b/drivers/clk/tegra/clk-tegra210.c
>>>>>> @@ -9,13 +9,13 @@
>>>>>>  =C2=A0 #include <linux/clkdev.h>
>>>>>>  =C2=A0 #include <linux/of.h>
>>>>>>  =C2=A0 #include <linux/of_address.h>
>>>>>> +#include <linux/syscore_ops.h>
>>>>>>  =C2=A0 #include <linux/delay.h>
>>>>>>  =C2=A0 #include <linux/export.h>
>>>>>>  =C2=A0 #include <linux/mutex.h>
>>>>>>  =C2=A0 #include <linux/clk/tegra.h>
>>>>>>  =C2=A0 #include <dt-bindings/clock/tegra210-car.h>
>>>>>>  =C2=A0 #include <dt-bindings/reset/tegra210-car.h>
>>>>>> -#include <linux/iopoll.h>
>>>>>>  =C2=A0 #include <linux/sizes.h>
>>>>>>  =C2=A0 #include <soc/tegra/pmc.h>
>>>>>>  =C2=A0 @@ -220,11 +220,15 @@
>>>>>>  =C2=A0 #define CLK_M_DIVISOR_SHIFT 2
>>>>>>  =C2=A0 #define CLK_M_DIVISOR_MASK 0x3
>>>>>>  =C2=A0 +#define CLK_MASK_ARM=C2=A0=C2=A0=C2=A0 0x44
>>>>>> +#define MISC_CLK_ENB=C2=A0=C2=A0=C2=A0 0x48
>>>>>> +
>>>>>>  =C2=A0 #define RST_DFLL_DVCO 0x2f4
>>>>>>  =C2=A0 #define DVFS_DFLL_RESET_SHIFT 0
>>>>>>  =C2=A0 =C2=A0 #define CLK_RST_CONTROLLER_RST_DEV_Y_SET 0x2a8
>>>>>>  =C2=A0 #define CLK_RST_CONTROLLER_RST_DEV_Y_CLR 0x2ac
>>>>>> +#define CPU_SOFTRST_CTRL 0x380
>>>>>>  =C2=A0 =C2=A0 #define LVL2_CLK_GATE_OVRA 0xf8
>>>>>>  =C2=A0 #define LVL2_CLK_GATE_OVRC 0x3a0
>>>>>> @@ -2825,6 +2829,7 @@ static int tegra210_enable_pllu(void)
>>>>>>  =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 struct tegra_clk_pll_freq_table *fen=
try;
>>>>>>  =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 struct tegra_clk_pll pllu;
>>>>>>  =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 u32 reg;
>>>>>> +=C2=A0=C2=A0=C2=A0 int ret;
>>>>>>  =C2=A0 =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 for (fentry =3D pll_u_freq_ta=
ble; fentry->input_rate; fentry++) {
>>>>>>  =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 if (fentry->=
input_rate =3D=3D pll_ref_freq)
>>>>>> @@ -2853,9 +2858,14 @@ static int tegra210_enable_pllu(void)
>>>>>>  =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 reg |=3D PLL_ENABLE;
>>>>>>  =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 writel(reg, clk_base + PLLU_BASE);
>>>>>>  =C2=A0 -=C2=A0=C2=A0=C2=A0 readl_relaxed_poll_timeout_atomic(clk_ba=
se + PLLU_BASE, reg,
>>>>>> -=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 reg & PLL_BASE=
_LOCK, 2, 1000);
>>>>>> -=C2=A0=C2=A0=C2=A0 if (!(reg & PLL_BASE_LOCK)) {
>>>>>> +=C2=A0=C2=A0=C2=A0 /*
>>>>>> +=C2=A0=C2=A0=C2=A0=C2=A0 * During clocks resume, same PLLU init and=
 enable sequence get
>>>>>> +=C2=A0=C2=A0=C2=A0=C2=A0 * executed. So, readx_poll_timeout_atomic =
can't be used here as it
>>>>>> +=C2=A0=C2=A0=C2=A0=C2=A0 * uses ktime_get() and timekeeping resume =
doesn't happen by that
>>>>>> +=C2=A0=C2=A0=C2=A0=C2=A0 * time. So, using tegra210_wait_for_mask f=
or PLL LOCK.
>>>>>> +=C2=A0=C2=A0=C2=A0=C2=A0 */
>>>>>> +=C2=A0=C2=A0=C2=A0 ret =3D tegra210_wait_for_mask(&pllu, PLLU_BASE,=
 PLL_BASE_LOCK);
>>>>>> +=C2=A0=C2=A0=C2=A0 if (ret) {
>>>>>>  =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 pr_err("Time=
d out waiting for PLL_U to lock\n");
>>>>>>  =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 return -ETIM=
EDOUT;
>>>>>>  =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 }
>>>>>> @@ -3288,6 +3298,84 @@ static void tegra210_disable_cpu_clock(u32 cp=
u)
>>>>>>  =C2=A0 }
>>>>>>  =C2=A0 =C2=A0 #ifdef CONFIG_PM_SLEEP
>>>>>> +/*
>>>>>> + * This array lists mask values for each peripheral clk bank
>>>>>> + * to mask out reserved bits during the clocks state restore
>>>>>> + * on SC7 resume to prevent accidental writes to these reserved
>>>>>> + * bits.
>>>>>> + */
>>>>>> +static u32 periph_clk_rsvd_mask[TEGRA210_CAR_BANK_COUNT] =3D {
>>>>> Should be more natural to have a "valid_mask" instead of "rsvd_mask".
>>>>>
>>>>> What's actually wrong with touching of the reserved bits? They must b=
e NO-OP.. or the
>>>>> reserved bits are actually some kind of "secret" bits? If those bits =
have some use-case
>>>>> outside of Silicon HW (like FPGA simulation), then this doesn't matte=
r for upstream and you
>>>>> have to keep the workaround locally in the downstream kernel or whate=
ver.
>>>> Will rename as valid_mask.
>>>>
>>>> some bits in these registers are undefined and is not good to write to=
 these bits as they
>>>> can cause pslverr.
>>> Okay, it should be explained in the comment.
>>>
>>> Is it possible to disable trapping of changing the undefined bits?
>> No its internal to design
> Okay.
>
> Also, what about to move the valid_mask into struct tegra_clk_periph_regs=
?

No, we cannot move to tegra_clk_periph_regs as its in tegra/clk.c and is=20
common for all tegra.

Reserved bits are different on tegra chips so should come from Tegra=20
chip specific clock driver like

clk-tegra210 for Tegra210.

>>>>>> +=C2=A0=C2=A0=C2=A0 0x23282006,
>>>>>> +=C2=A0=C2=A0=C2=A0 0x782e0c18,
>>>>>> +=C2=A0=C2=A0=C2=A0 0x0c012c05,
>>>>>> +=C2=A0=C2=A0=C2=A0 0x003e7304,
>>>>>> +=C2=A0=C2=A0=C2=A0 0x86c04800,
>>>>>> +=C2=A0=C2=A0=C2=A0 0xc0199000,
>>>>>> +=C2=A0=C2=A0=C2=A0 0x03e03800,
>>>>>> +};
>>>>>> +
>>>>>> +#define car_readl(_base, _off) readl_relaxed(clk_base + (_base) + (=
(_off) * 4))
>>>>>> +#define car_writel(_val, _base, _off) \
>>>>>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 writel_relaxed(_val, clk=
_base + (_base) + ((_off) * 4))
>>>>>> +
>>>>>> +static u32 spare_reg_ctx, misc_clk_enb_ctx, clk_msk_arm_ctx;
>>>>>> +static u32 cpu_softrst_ctx[3];
>>>>>> +
>>>>>> +static int tegra210_clk_suspend(void)
>>>>>> +{
>>>>>> +=C2=A0=C2=A0=C2=A0 unsigned int i;
>>>>>> +
>>>>>> +=C2=A0=C2=A0=C2=A0 clk_save_context();
>>>>>> +
>>>>>> +=C2=A0=C2=A0=C2=A0 /*
>>>>>> +=C2=A0=C2=A0=C2=A0=C2=A0 * Save the bootloader configured clock reg=
isters SPARE_REG0,
>>>>>> +=C2=A0=C2=A0=C2=A0=C2=A0 * MISC_CLK_ENB, CLK_MASK_ARM, CPU_SOFTRST_=
CTRL.
>>>>>> +=C2=A0=C2=A0=C2=A0=C2=A0 */
>>>>>> +=C2=A0=C2=A0=C2=A0 spare_reg_ctx =3D readl_relaxed(clk_base + SPARE=
_REG0);
>>>>>> +=C2=A0=C2=A0=C2=A0 misc_clk_enb_ctx =3D readl_relaxed(clk_base + MI=
SC_CLK_ENB);
>>>>>> +=C2=A0=C2=A0=C2=A0 clk_msk_arm_ctx =3D readl_relaxed(clk_base + CLK=
_MASK_ARM);
>>>>>> +
>>>>>> +=C2=A0=C2=A0=C2=A0 for (i =3D 0; i < ARRAY_SIZE(cpu_softrst_ctx); i=
++)
>>>>>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 cpu_softrst_ctx[i] =3D c=
ar_readl(CPU_SOFTRST_CTRL, i);
>>>>>> +
>>>>>> +=C2=A0=C2=A0=C2=A0 tegra_clk_periph_suspend();
>>>>>> +=C2=A0=C2=A0=C2=A0 return 0;
>>>>>> +}
>>>>>> +
>>>>>> +static void tegra210_clk_resume(void)
>>>>>> +{
>>>>>> +=C2=A0=C2=A0=C2=A0 unsigned int i;
>>>>>> +
>>>>>> +=C2=A0=C2=A0=C2=A0 tegra_clk_osc_resume(clk_base);
>>>>>> +
>>>>>> +=C2=A0=C2=A0=C2=A0 /*
>>>>>> +=C2=A0=C2=A0=C2=A0=C2=A0 * Restore the bootloader configured clock =
registers SPARE_REG0,
>>>>>> +=C2=A0=C2=A0=C2=A0=C2=A0 * MISC_CLK_ENB, CLK_MASK_ARM, CPU_SOFTRST_=
CTRL from saved context.
>>>>>> +=C2=A0=C2=A0=C2=A0=C2=A0 */
>>>>>> +=C2=A0=C2=A0=C2=A0 writel_relaxed(spare_reg_ctx, clk_base + SPARE_R=
EG0);
>>>>>> +=C2=A0=C2=A0=C2=A0 writel_relaxed(misc_clk_enb_ctx, clk_base + MISC=
_CLK_ENB);
>>>>>> +=C2=A0=C2=A0=C2=A0 writel_relaxed(clk_msk_arm_ctx, clk_base + CLK_M=
ASK_ARM);
>>>>>> +
>>>>>> +=C2=A0=C2=A0=C2=A0 for (i =3D 0; i < ARRAY_SIZE(cpu_softrst_ctx); i=
++)
>>>>>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 car_writel(cpu_softrst_c=
tx[i], CPU_SOFTRST_CTRL, i);
>>>>>> +
>>>>>> +=C2=A0=C2=A0=C2=A0 fence_udelay(5, clk_base);
>>>>>> +
>>>>>> +=C2=A0=C2=A0=C2=A0 /* enable all the clocks before changing the clo=
ck sources */
>>>>>> +=C2=A0=C2=A0=C2=A0 tegra_clk_periph_force_on(periph_clk_rsvd_mask);
>>>>> Why clocks need to be enabled before changing the sources?
>>>> To prevent glitchless frequency switch, Tegra clock programming recomm=
ended sequence is to
>>>> change MUX control or divisor or both with the clocks running.
>>> This should be explained in the comment.
>>>
>>>> Actual state of clocks before suspend are restored later after all PLL=
's and peripheral
>>>> clocks are restored.
>>>>
>>>>>> +=C2=A0=C2=A0=C2=A0 /* wait for all writes to happen to have all the=
 clocks enabled */
>>>>>> +=C2=A0=C2=A0=C2=A0 wmb();
>>>>> fence_udelay() has exactly the same barrier at the very beginning of =
readl(), no need to
>>>>> duplicate it here.
>>> Actually, readl does the rmb() and it should be a more correct variant =
of fencing because it
>>> actually ensures that the write reached hardware. I suppose that someth=
ing like fence_udelay
>>> should be used for the pinctrl as well.
>>>
>>>>>> +=C2=A0=C2=A0=C2=A0 fence_udelay(2, clk_base);
>>>>>> +
>>>>>> +=C2=A0=C2=A0=C2=A0 /* restore PLLs and all peripheral clock rates *=
/
>>>>>> +=C2=A0=C2=A0=C2=A0 tegra210_init_pllu();
>>>>> Why USB PLL need to be restored at first?
>>>> USB PLL restore is independent to all other clocks restore. So this ca=
n be done either
>>>> before clk_restore_context or even after.
>>> Then why not to implement restore_context for PLLU?
>> pllu is registered as fixed_rate clock and we using clk core clk_registe=
r_fixed_rate which
>> uses clk_fixed_rate_ops from the same generic clk-fixed-rate driver.
>>
>> Also pllu init happens in the same clk-tegra210, so invoking it during r=
esume which is the
>> same sequence needed during resume as well.
> Okay.
>
