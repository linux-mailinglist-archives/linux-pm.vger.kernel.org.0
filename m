Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 66E172DF27F
	for <lists+linux-pm@lfdr.de>; Sun, 20 Dec 2020 01:17:44 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726621AbgLTAR1 (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Sat, 19 Dec 2020 19:17:27 -0500
Received: from mail.kernel.org ([198.145.29.99]:38884 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726501AbgLTAR1 (ORCPT <rfc822;linux-pm@vger.kernel.org>);
        Sat, 19 Dec 2020 19:17:27 -0500
Content-Type: text/plain; charset="utf-8"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1608423406;
        bh=lReEG8HagIWISKDfoCXDU33zCgfMnXmryW7+NLo+eEo=;
        h=In-Reply-To:References:Subject:From:Cc:To:Date:From;
        b=isPvGxtWBaFu6bIKGg7JfzszxV1+pP0cpFbFWGTEN/9mFCxXr7xAp5bsCcRST97CM
         YdA9zL4rPHTo9Th0qCVd2gh7R0h8lXXaDGs3QKRrMioovKJtr+1qJnDWoaeL0nipPV
         ApftFmggFGekyeluZltxEEblugl97HTCGK6YxHWVpe+buIV/pe+3e1A/GT0sze8xoU
         cnysDMEH3rrB5d+5mTdAfUPOFJNhY0mi/kglf8+2RDHuJ1FYi/H6RgLN0GAjH0G9/Y
         p1ojC/sFAgZzkxuyngGbOk2g0YJhLY9Idp837x6Zc3AUqLmv/Kc766qowI8MWTvo/X
         7fg/J5w8bbcsw==
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
In-Reply-To: <20201217174602.22212-3-kostap@marvell.com>
References: <20201217174602.22212-1-kostap@marvell.com> <20201217174602.22212-3-kostap@marvell.com>
Subject: Re: [PATCH 2/2] clk: mvebu: use firmware SiP service for accessing dfx register set
From:   Stephen Boyd <sboyd@kernel.org>
Cc:     mturquette@baylibre.com, miquel.raynal@bootlin.com,
        rui.zhang@intel.com, daniel.lezcano@linaro.org, amitk@kernel.org,
        mw@semihalf.com, jaz@semihalf.com, nadavh@marvell.com,
        bpeled@marvell.com, stefanc@marvell.com,
        Konstantin Porotchkin <kostap@marvell.com>
To:     kostap@marvell.com, linux-clk@vger.kernel.org,
        linux-pm@vger.kernel.org
Date:   Sat, 19 Dec 2020 16:16:44 -0800
Message-ID: <160842340492.1580929.1761349313009973921@swboyd.mtv.corp.google.com>
User-Agent: alot/0.9.1
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

Quoting kostap@marvell.com (2020-12-17 09:46:02)
> diff --git a/drivers/clk/mvebu/ap-cpu-clk.c b/drivers/clk/mvebu/ap-cpu-cl=
k.c
> index b4259b60dcfd..52721ef2d7d9 100644
> --- a/drivers/clk/mvebu/ap-cpu-clk.c
> +++ b/drivers/clk/mvebu/ap-cpu-clk.c
> @@ -139,8 +141,107 @@ struct ap_cpu_clk {
>         struct clk_hw hw;
>         struct regmap *pll_cr_base;
>         const struct cpu_dfs_regs *pll_regs;
> +       phys_addr_t phys;
>  };
> =20
> +static int dfx_sread_smc(unsigned long addr, unsigned int *reg)
> +{
> +       struct arm_smccc_res res;
> +
> +       arm_smccc_smc(MV_SIP_DFX, MV_SIP_DFX_SREAD, addr, 0, 0, 0, 0, 0, =
&res);
> +
> +       if (res.a0 =3D=3D 0 && reg !=3D NULL)
> +               *reg =3D res.a1;
> +
> +       return res.a0;
> +}
> +
> +static int dfx_swrite_smc(unsigned long addr, unsigned long val)
> +{
> +       struct arm_smccc_res res;
> +
> +       arm_smccc_smc(MV_SIP_DFX, MV_SIP_DFX_SWRITE, addr, val,
> +                     0, 0, 0, 0, &res);
> +
> +       return res.a0;
> +}

Can this be implemented as a regmap, similar to the regmap-mmio? And
then the cpu clks use this instead of mmio regmap?

> +
> +static int ap_clk_regmap_read(struct ap_cpu_clk *clk, unsigned int reg,
> +                             unsigned int *val)
> +{
> +       int ret;
> +
> +       ret =3D dfx_sread_smc(clk->phys + reg, val);
> +       if (ret !=3D SMCCC_RET_SUCCESS)
> +               ret =3D regmap_read(clk->pll_cr_base, reg, val);
> +
> +       return ret;
> +}
> +
> +static int ap_clk_regmap_write(struct ap_cpu_clk *clk, unsigned int reg,
> +                         unsigned int val)
> +{
> +       int ret;
> +
> +       ret =3D dfx_swrite_smc(clk->phys + reg, val);
> +       if (ret !=3D SMCCC_RET_SUCCESS)
> +               ret =3D regmap_write(clk->pll_cr_base, reg, val);
> +
> +       return ret;
> +}
> +
> +static int ap_clk_regmap_update_bits(struct ap_cpu_clk *clk, unsigned in=
t reg,
> +                                    unsigned int mask, unsigned int val)
> +{
> +       int ret;
> +       unsigned int tmp;
> +
> +       ret =3D dfx_sread_smc(clk->phys + reg, &tmp);
> +       if (ret !=3D SMCCC_RET_SUCCESS)
> +               goto try_legacy;

Can we try the legacy path at boot to read something and then if it
fails plug in the old regmap? If it works then use the new regmap. Let's
not keep both paths all the time if we can runtime detect it at boot.

> +
> +       tmp &=3D ~mask;
> +       tmp |=3D val & mask;
> +
> +       ret =3D dfx_swrite_smc(clk->phys + reg, tmp);
> +       if (ret =3D=3D SMCCC_RET_SUCCESS)
> +               return ret;
> +
> +try_legacy:
> +       return regmap_update_bits(clk->pll_cr_base, reg, mask, val);
> +}
> +
> +static int ap_clk_regmap_read_poll_timeout(struct ap_cpu_clk *clk,
> +                                           unsigned int reg,
> +                                           unsigned int stable_bit)
> +{
> +       int ret;
> +       u32 val;
> +       ktime_t timeout;
> +
> +       timeout =3D ktime_add_us(ktime_get(), STATUS_POLL_TIMEOUT_US);
> +       do {
> +               ret =3D dfx_sread_smc(clk->phys + reg, &val);
> +               if (ret || (val & stable_bit))
> +                       break;
> +
> +               usleep_range((STATUS_POLL_PERIOD_US >> 2) + 1,
> +                            STATUS_POLL_PERIOD_US);
> +
> +       } while (ktime_before(ktime_get(), timeout));
> +
> +       if (ret =3D=3D SMCCC_RET_SUCCESS)
> +               return (val & stable_bit) ? 0 : -ETIMEDOUT;
> +
> +       /* If above fail, try legacy */
> +       ret =3D regmap_read_poll_timeout(clk->pll_cr_base,
> +                                      reg, val,
> +                                      val & stable_bit, STATUS_POLL_PERI=
OD_US,
> +                                      STATUS_POLL_TIMEOUT_US);
> +
> +       return ret;
> +}
> +
>  static unsigned long ap_cpu_clk_recalc_rate(struct clk_hw *hw,
>                                             unsigned long parent_rate)
>  {
> @@ -150,7 +251,7 @@ static unsigned long ap_cpu_clk_recalc_rate(struct cl=
k_hw *hw,
> =20
>         cpu_clkdiv_reg =3D clk->pll_regs->divider_reg +
>                 (clk->cluster * clk->pll_regs->cluster_offset);
> -       regmap_read(clk->pll_cr_base, cpu_clkdiv_reg, &cpu_clkdiv_ratio);
> +       ap_clk_regmap_read(clk, cpu_clkdiv_reg, &cpu_clkdiv_ratio);
>         cpu_clkdiv_ratio &=3D clk->pll_regs->divider_mask;
>         cpu_clkdiv_ratio >>=3D clk->pll_regs->divider_offset;
> =20
> @@ -171,7 +272,7 @@ static int ap_cpu_clk_set_rate(struct clk_hw *hw, uns=
igned long rate,
>         cpu_ratio_reg =3D clk->pll_regs->ratio_reg +
>                 (clk->cluster * clk->pll_regs->cluster_offset);
> =20
> -       regmap_read(clk->pll_cr_base, cpu_clkdiv_reg, &reg);
> +       ap_clk_regmap_read(clk, cpu_clkdiv_reg, &reg);
>         reg &=3D ~(clk->pll_regs->divider_mask);
>         reg |=3D (divider << clk->pll_regs->divider_offset);
> =20
> @@ -184,29 +285,26 @@ static int ap_cpu_clk_set_rate(struct clk_hw *hw, u=
nsigned long rate,
>                 reg |=3D ((divider * clk->pll_regs->divider_ratio) <<
>                                 AP807_PLL_CR_1_CPU_CLK_DIV_RATIO_OFFSET);
>         }
> -       regmap_write(clk->pll_cr_base, cpu_clkdiv_reg, reg);
> -
> +       ap_clk_regmap_write(clk, cpu_clkdiv_reg, reg);
> =20
> -       regmap_update_bits(clk->pll_cr_base, cpu_force_reg,
> -                          clk->pll_regs->force_mask,
> -                          clk->pll_regs->force_mask);
> +       ap_clk_regmap_update_bits(clk, cpu_force_reg, clk->pll_regs->forc=
e_mask,
> +                                 clk->pll_regs->force_mask);
> =20
> -       regmap_update_bits(clk->pll_cr_base, cpu_ratio_reg,
> -                          BIT(clk->pll_regs->ratio_offset),
> -                          BIT(clk->pll_regs->ratio_offset));
> +       ap_clk_regmap_update_bits(clk, cpu_ratio_reg,
> +                                 BIT(clk->pll_regs->ratio_offset),
> +                                 BIT(clk->pll_regs->ratio_offset));
> =20
>         stable_bit =3D BIT(clk->pll_regs->ratio_state_offset +
>                          clk->cluster *
>                          clk->pll_regs->ratio_state_cluster_offset);
> -       ret =3D regmap_read_poll_timeout(clk->pll_cr_base,
> -                                      clk->pll_regs->ratio_state_reg, re=
g,
> -                                      reg & stable_bit, STATUS_POLL_PERI=
OD_US,
> -                                      STATUS_POLL_TIMEOUT_US);
> +       ret =3D ap_clk_regmap_read_poll_timeout(clk,
> +                                             clk->pll_regs->ratio_state_=
reg,
> +                                             stable_bit);
>         if (ret)
>                 return ret;
> =20
> -       regmap_update_bits(clk->pll_cr_base, cpu_ratio_reg,
> -                          BIT(clk->pll_regs->ratio_offset), 0);
> +       ap_clk_regmap_update_bits(clk, cpu_ratio_reg,
> +                                 BIT(clk->pll_regs->ratio_offset), 0);
> =20
>         return 0;
>  }
> @@ -235,6 +333,11 @@ static int ap_cpu_clock_probe(struct platform_device=
 *pdev)
>         struct clk_hw_onecell_data *ap_cpu_data;
>         struct ap_cpu_clk *ap_cpu_clk;
>         struct regmap *regmap;
> +       struct resource res;
> +
> +       ret =3D of_address_to_resource(np->parent, 0, &res);
> +       if (ret)
> +               return ret;
> =20
>         regmap =3D syscon_node_to_regmap(np->parent);
>         if (IS_ERR(regmap)) {
> @@ -313,6 +416,12 @@ static int ap_cpu_clock_probe(struct platform_device=
 *pdev)
>                 ap_cpu_clk[cluster_index].dev =3D dev;
>                 ap_cpu_clk[cluster_index].pll_regs =3D of_device_get_matc=
h_data(&pdev->dev);
> =20
> +               /*
> +                * Hack to retrieve a physical addr that will be given to=
 the

I'd rather not enshrine "hack" in the code. "Get a physicall address to
hand to the firmware"? Presumably this address will work and isn't some
intermediate PA (IPA)?

> +                * firmware.
> +                */
> +               ap_cpu_clk[cluster_index].phys =3D res.start;
> +
>                 init.name =3D ap_cpu_clk[cluster_index].clk_name;
>                 init.ops =3D &ap_cpu_clk_ops;
>                 init.num_parents =3D 1;
