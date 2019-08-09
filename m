Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 9591587F88
	for <lists+linux-pm@lfdr.de>; Fri,  9 Aug 2019 18:19:30 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2437048AbfHIQTZ (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Fri, 9 Aug 2019 12:19:25 -0400
Received: from hqemgate16.nvidia.com ([216.228.121.65]:7489 "EHLO
        hqemgate16.nvidia.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2436953AbfHIQTZ (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Fri, 9 Aug 2019 12:19:25 -0400
Received: from hqpgpgate102.nvidia.com (Not Verified[216.228.121.13]) by hqemgate16.nvidia.com (using TLS: TLSv1.2, DES-CBC3-SHA)
        id <B5d4d9d0c0001>; Fri, 09 Aug 2019 09:19:24 -0700
Received: from hqmail.nvidia.com ([172.20.161.6])
  by hqpgpgate102.nvidia.com (PGP Universal service);
  Fri, 09 Aug 2019 09:19:22 -0700
X-PGP-Universal: processed;
        by hqpgpgate102.nvidia.com on Fri, 09 Aug 2019 09:19:22 -0700
Received: from [10.2.167.88] (10.124.1.5) by HQMAIL107.nvidia.com
 (172.20.187.13) with Microsoft SMTP Server (TLS) id 15.0.1473.3; Fri, 9 Aug
 2019 16:19:21 +0000
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
From:   Sowjanya Komatineni <skomatineni@nvidia.com>
Message-ID: <7d101ec9-c559-8b40-1764-6bf67a9c7a7a@nvidia.com>
Date:   Fri, 9 Aug 2019 09:19:19 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.7.2
MIME-Version: 1.0
In-Reply-To: <a21b7464-62c3-8461-04c2-a0e863bdde85@gmail.com>
X-Originating-IP: [10.124.1.5]
X-ClientProxiedBy: HQMAIL101.nvidia.com (172.20.187.10) To
 HQMAIL107.nvidia.com (172.20.187.13)
Content-Type: text/plain; charset="utf-8"; format=flowed
Content-Transfer-Encoding: quoted-printable
Content-Language: en-US
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nvidia.com; s=n1;
        t=1565367564; bh=FOPVqa4Dn+ceVBVS8Ls4J5NnDlg7bwVxzOmYPZsKN0c=;
        h=X-PGP-Universal:Subject:To:CC:References:From:Message-ID:Date:
         User-Agent:MIME-Version:In-Reply-To:X-Originating-IP:
         X-ClientProxiedBy:Content-Type:Content-Transfer-Encoding:
         Content-Language;
        b=nXKYHsZ27J0weor9ST3WSDlD/BZyovGgOds58z+pam0bhjbg2BV6e7DO1i7az6W+6
         MtzdKUEzX4RI2pGPpv061Y9akKVKHA4X6hL6pmWZfaPhyFhk8bzpV1KTHfZZwcLsiR
         gPNgcLvEcMgZtVuna4Z2+lx88nqqdUIXGkrUlswpaY1muTuIUDOw9jR5tymDYU0ayX
         9bLxpuzZN7kD1UOxZOhuG1U3zHWeAEynQzh9oTxWnUZuk3JfR+mmw1Rx6b3FsUH4xb
         k4AYGS3x7UpHPewNqNZ0ftXGtvGCutPkbxOvu201ZxXSPF+wPxr0u1chrqvVNnSRQI
         dYnPrU7Q12afA==
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org


On 8/9/19 6:56 AM, Dmitry Osipenko wrote:
> 09.08.2019 2:46, Sowjanya Komatineni =D0=BF=D0=B8=D1=88=D0=B5=D1=82:
>> This patch adds support for clk: tegra210: suspend-resume.
>>
>> All the CAR controller settings are lost on suspend when core
>> power goes off.
>>
>> This patch has implementation for saving and restoring all PLLs
>> and clocks context during system suspend and resume to have the
>> clocks back to same state for normal operation.
>>
>> Clock driver suspend and resume are registered as syscore_ops as clocks
>> restore need to happen before the other drivers resume to have all their
>> clocks back to the same state as before suspend.
>>
>> Signed-off-by: Sowjanya Komatineni <skomatineni@nvidia.com>
>> ---
>>   drivers/clk/tegra/clk-tegra210.c | 103 +++++++++++++++++++++++++++++++=
++++++--
>>   drivers/clk/tegra/clk.c          |  64 ++++++++++++++++++++++++
>>   drivers/clk/tegra/clk.h          |   3 ++
>>   3 files changed, 166 insertions(+), 4 deletions(-)
>>
>> diff --git a/drivers/clk/tegra/clk-tegra210.c b/drivers/clk/tegra/clk-te=
gra210.c
>> index 998bf60b219a..8dd6f4f4debb 100644
>> --- a/drivers/clk/tegra/clk-tegra210.c
>> +++ b/drivers/clk/tegra/clk-tegra210.c
>> @@ -9,13 +9,13 @@
>>   #include <linux/clkdev.h>
>>   #include <linux/of.h>
>>   #include <linux/of_address.h>
>> +#include <linux/syscore_ops.h>
>>   #include <linux/delay.h>
>>   #include <linux/export.h>
>>   #include <linux/mutex.h>
>>   #include <linux/clk/tegra.h>
>>   #include <dt-bindings/clock/tegra210-car.h>
>>   #include <dt-bindings/reset/tegra210-car.h>
>> -#include <linux/iopoll.h>
>>   #include <linux/sizes.h>
>>   #include <soc/tegra/pmc.h>
>>  =20
>> @@ -220,11 +220,15 @@
>>   #define CLK_M_DIVISOR_SHIFT 2
>>   #define CLK_M_DIVISOR_MASK 0x3
>>  =20
>> +#define CLK_MASK_ARM	0x44
>> +#define MISC_CLK_ENB	0x48
>> +
>>   #define RST_DFLL_DVCO 0x2f4
>>   #define DVFS_DFLL_RESET_SHIFT 0
>>  =20
>>   #define CLK_RST_CONTROLLER_RST_DEV_Y_SET 0x2a8
>>   #define CLK_RST_CONTROLLER_RST_DEV_Y_CLR 0x2ac
>> +#define CPU_SOFTRST_CTRL 0x380
>>  =20
>>   #define LVL2_CLK_GATE_OVRA 0xf8
>>   #define LVL2_CLK_GATE_OVRC 0x3a0
>> @@ -2825,6 +2829,7 @@ static int tegra210_enable_pllu(void)
>>   	struct tegra_clk_pll_freq_table *fentry;
>>   	struct tegra_clk_pll pllu;
>>   	u32 reg;
>> +	int ret;
>>  =20
>>   	for (fentry =3D pll_u_freq_table; fentry->input_rate; fentry++) {
>>   		if (fentry->input_rate =3D=3D pll_ref_freq)
>> @@ -2853,9 +2858,14 @@ static int tegra210_enable_pllu(void)
>>   	reg |=3D PLL_ENABLE;
>>   	writel(reg, clk_base + PLLU_BASE);
>>  =20
>> -	readl_relaxed_poll_timeout_atomic(clk_base + PLLU_BASE, reg,
>> -					  reg & PLL_BASE_LOCK, 2, 1000);
>> -	if (!(reg & PLL_BASE_LOCK)) {
>> +	/*
>> +	 * During clocks resume, same PLLU init and enable sequence get
>> +	 * executed. So, readx_poll_timeout_atomic can't be used here as it
>> +	 * uses ktime_get() and timekeeping resume doesn't happen by that
>> +	 * time. So, using tegra210_wait_for_mask for PLL LOCK.
>> +	 */
>> +	ret =3D tegra210_wait_for_mask(&pllu, PLLU_BASE, PLL_BASE_LOCK);
>> +	if (ret) {
>>   		pr_err("Timed out waiting for PLL_U to lock\n");
>>   		return -ETIMEDOUT;
>>   	}
>> @@ -3288,6 +3298,84 @@ static void tegra210_disable_cpu_clock(u32 cpu)
>>   }
>>  =20
>>   #ifdef CONFIG_PM_SLEEP
>> +/*
>> + * This array lists mask values for each peripheral clk bank
>> + * to mask out reserved bits during the clocks state restore
>> + * on SC7 resume to prevent accidental writes to these reserved
>> + * bits.
>> + */
>> +static u32 periph_clk_rsvd_mask[TEGRA210_CAR_BANK_COUNT] =3D {
> Should be more natural to have a "valid_mask" instead of "rsvd_mask".
>
> What's actually wrong with touching of the reserved bits? They must be NO=
-OP.. or the
> reserved bits are actually some kind of "secret" bits? If those bits have=
 some use-case
> outside of Silicon HW (like FPGA simulation), then this doesn't matter fo=
r upstream and you
> have to keep the workaround locally in the downstream kernel or whatever.

Will rename as valid_mask.

some bits in these registers are undefined and is not good to write to=20
these bits as they can cause pslverr.

>
>> +	0x23282006,
>> +	0x782e0c18,
>> +	0x0c012c05,
>> +	0x003e7304,
>> +	0x86c04800,
>> +	0xc0199000,
>> +	0x03e03800,
>> +};
>> +
>> +#define car_readl(_base, _off) readl_relaxed(clk_base + (_base) + ((_of=
f) * 4))
>> +#define car_writel(_val, _base, _off) \
>> +		writel_relaxed(_val, clk_base + (_base) + ((_off) * 4))
>> +
>> +static u32 spare_reg_ctx, misc_clk_enb_ctx, clk_msk_arm_ctx;
>> +static u32 cpu_softrst_ctx[3];
>> +
>> +static int tegra210_clk_suspend(void)
>> +{
>> +	unsigned int i;
>> +
>> +	clk_save_context();
>> +
>> +	/*
>> +	 * Save the bootloader configured clock registers SPARE_REG0,
>> +	 * MISC_CLK_ENB, CLK_MASK_ARM, CPU_SOFTRST_CTRL.
>> +	 */
>> +	spare_reg_ctx =3D readl_relaxed(clk_base + SPARE_REG0);
>> +	misc_clk_enb_ctx =3D readl_relaxed(clk_base + MISC_CLK_ENB);
>> +	clk_msk_arm_ctx =3D readl_relaxed(clk_base + CLK_MASK_ARM);
>> +
>> +	for (i =3D 0; i < ARRAY_SIZE(cpu_softrst_ctx); i++)
>> +		cpu_softrst_ctx[i] =3D car_readl(CPU_SOFTRST_CTRL, i);
>> +
>> +	tegra_clk_periph_suspend();
>> +	return 0;
>> +}
>> +
>> +static void tegra210_clk_resume(void)
>> +{
>> +	unsigned int i;
>> +
>> +	tegra_clk_osc_resume(clk_base);
>> +
>> +	/*
>> +	 * Restore the bootloader configured clock registers SPARE_REG0,
>> +	 * MISC_CLK_ENB, CLK_MASK_ARM, CPU_SOFTRST_CTRL from saved context.
>> +	 */
>> +	writel_relaxed(spare_reg_ctx, clk_base + SPARE_REG0);
>> +	writel_relaxed(misc_clk_enb_ctx, clk_base + MISC_CLK_ENB);
>> +	writel_relaxed(clk_msk_arm_ctx, clk_base + CLK_MASK_ARM);
>> +
>> +	for (i =3D 0; i < ARRAY_SIZE(cpu_softrst_ctx); i++)
>> +		car_writel(cpu_softrst_ctx[i], CPU_SOFTRST_CTRL, i);
>> +
>> +	fence_udelay(5, clk_base);
>> +
>> +	/* enable all the clocks before changing the clock sources */
>> +	tegra_clk_periph_force_on(periph_clk_rsvd_mask);
> Why clocks need to be enabled before changing the sources?

To prevent glitchless frequency switch, Tegra clock programming=20
recommended sequence is to change MUX control or divisor or both with=20
the clocks running.

Actual state of clocks before suspend are restored later after all PLL's=20
and peripheral clocks are restored.

>
>> +	/* wait for all writes to happen to have all the clocks enabled */
>> +	wmb();
> fence_udelay() has exactly the same barrier at the very beginning of read=
l(), no need to
> duplicate it here.
>
>> +	fence_udelay(2, clk_base);
>> +
>> +	/* restore PLLs and all peripheral clock rates */
>> +	tegra210_init_pllu();
> Why USB PLL need to be restored at first?
USB PLL restore is independent to all other clocks restore. So this can=20
be done either before clk_restore_context or even after.
>
>> +	clk_restore_context();
>> +
>> +	/* restore all peripheral clocks enable and reset state */
>> +	tegra_clk_periph_resume();
>> +}
> [snip]
