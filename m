Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9A5E72E7508
	for <lists+linux-pm@lfdr.de>; Tue, 29 Dec 2020 23:52:24 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726156AbgL2WwI (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Tue, 29 Dec 2020 17:52:08 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50722 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726138AbgL2WwH (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Tue, 29 Dec 2020 17:52:07 -0500
Received: from mail-il1-x12a.google.com (mail-il1-x12a.google.com [IPv6:2607:f8b0:4864:20::12a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 82E67C061574
        for <linux-pm@vger.kernel.org>; Tue, 29 Dec 2020 14:51:27 -0800 (PST)
Received: by mail-il1-x12a.google.com with SMTP id 75so13356554ilv.13
        for <linux-pm@vger.kernel.org>; Tue, 29 Dec 2020 14:51:27 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=semihalf-com.20150623.gappssmtp.com; s=20150623;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=uR9xtt/OA3KwdmU344WBeToDK8NSL24Jp73H9MLvJx8=;
        b=vZiluhzq2DA6hTrdTq38Lh0/3u7DhL55gdXlyWi52ikHOI/mH2pLv5ILg0h3LU5HQy
         NVER0FIDcPYdk+za9CICRwjoeIjKjPT5pYI1iJRSg3sXkQXBY/cg+bIsP9L5Vp5bji8e
         NywZI6j0PqITI3JUDzQgJn4tL/vfx2HmDhbm9ttf0nTBkx+qIIJcLGPlO+po0+qDxjEK
         kLGEaDHYZaQFWIVvSs/lcvYWNaaEt/eqvOsg3trqOmSc98S1BtgQ/wLrQETlqBnd9c3k
         L3e7QZbFl3wHAbSdcOvZ2l6vCWKphy7bqFDHQCvGoZ7+LzdX6yKOcrGJSITMyQGmJ/lJ
         8e3g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=uR9xtt/OA3KwdmU344WBeToDK8NSL24Jp73H9MLvJx8=;
        b=cktY+9W8Wu9uChg8N4lu0KopkBhPnkWcRNfaPxz500C+zdix8dyatjlhYkzGGplU1n
         TrKVy8/Tpc/sJ8XaoewS4EYchZ6r882H3PEFDVJcql/zJd3Kh9R52C10ta7URyZamTQn
         M/+EqeFKamjiw71QEXF+wLdrFbC5DZdg+C5RD9P+91GUTO5LbJPgu0ANVd/GirFmOJLj
         2tioYXshk5IJL38cIzYtG16n/hQB5n3hVq1SdWPHq4rwHAGqDahMh7pb2Dln+3MgFhFB
         s6CjnPfAQrZy1dpr3+vQdoH4m5cx+KCYs8qZu3pUih3D04nNh6CyQuv4Dkytv+ClKLoa
         K6Gg==
X-Gm-Message-State: AOAM530jcLxY8P9jCvgAxdUTUjKVk7wd1NOLGBwAvoytEIC7Ln23mpxe
        m9zUHe1lrIHNlPMmtIknAeyrZvvvBL5pDDHoP7iGAA==
X-Google-Smtp-Source: ABdhPJxg/dRD7gAKseIrbXj0QZ+yipjD4LXauwOYK/dT5EfO1Tx+irxvhLt0S/K6DiONQ5itrxYY+Lyxs8/i7oZjGyc=
X-Received: by 2002:a92:cd8c:: with SMTP id r12mr48777108ilb.221.1609282286909;
 Tue, 29 Dec 2020 14:51:26 -0800 (PST)
MIME-Version: 1.0
References: <20201217174602.22212-1-kostap@marvell.com> <20201217174602.22212-3-kostap@marvell.com>
 <160842340492.1580929.1761349313009973921@swboyd.mtv.corp.google.com>
In-Reply-To: <160842340492.1580929.1761349313009973921@swboyd.mtv.corp.google.com>
From:   Grzegorz Jaszczyk <jaz@semihalf.com>
Date:   Tue, 29 Dec 2020 23:51:16 +0100
Message-ID: <CAH76GKOQoroW4p3qTffXtFJLbhvSRfOWOnm0JPysqiy8K2wT_g@mail.gmail.com>
Subject: Re: [PATCH 2/2] clk: mvebu: use firmware SiP service for accessing
 dfx register set
To:     Stephen Boyd <sboyd@kernel.org>
Cc:     linux-clk@vger.kernel.org, linux-pm@vger.kernel.org,
        Michael Turquette <mturquette@baylibre.com>,
        Miquel Raynal <miquel.raynal@bootlin.com>, rui.zhang@intel.com,
        daniel.lezcano@linaro.org, amitk@kernel.org,
        Marcin Wojtas <mw@semihalf.com>,
        Nadav Haklai <nadavh@marvell.com>,
        Ben Peled <bpeled@marvell.com>,
        Stefan Chulski <stefanc@marvell.com>,
        Konstantin Porotchkin <kostap@marvell.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

niedz., 20 gru 2020 o 01:16 Stephen Boyd <sboyd@kernel.org> napisa=C5=82(a)=
:
>
> Quoting kostap@marvell.com (2020-12-17 09:46:02)
> > diff --git a/drivers/clk/mvebu/ap-cpu-clk.c b/drivers/clk/mvebu/ap-cpu-=
clk.c
> > index b4259b60dcfd..52721ef2d7d9 100644
> > --- a/drivers/clk/mvebu/ap-cpu-clk.c
> > +++ b/drivers/clk/mvebu/ap-cpu-clk.c
> > @@ -139,8 +141,107 @@ struct ap_cpu_clk {
> >         struct clk_hw hw;
> >         struct regmap *pll_cr_base;
> >         const struct cpu_dfs_regs *pll_regs;
> > +       phys_addr_t phys;
> >  };
> >
> > +static int dfx_sread_smc(unsigned long addr, unsigned int *reg)
> > +{
> > +       struct arm_smccc_res res;
> > +
> > +       arm_smccc_smc(MV_SIP_DFX, MV_SIP_DFX_SREAD, addr, 0, 0, 0, 0, 0=
, &res);
> > +
> > +       if (res.a0 =3D=3D 0 && reg !=3D NULL)
> > +               *reg =3D res.a1;
> > +
> > +       return res.a0;
> > +}
> > +
> > +static int dfx_swrite_smc(unsigned long addr, unsigned long val)
> > +{
> > +       struct arm_smccc_res res;
> > +
> > +       arm_smccc_smc(MV_SIP_DFX, MV_SIP_DFX_SWRITE, addr, val,
> > +                     0, 0, 0, 0, &res);
> > +
> > +       return res.a0;
> > +}
>
> Can this be implemented as a regmap, similar to the regmap-mmio? And
> then the cpu clks use this instead of mmio regmap?

Yes, I think it is possible. Just to be sure: you suggest to provide a
custom regmap reg_read/reg_write, based on current
dfx_sread_smc/dfx_swrite_smc, only if it is needed (after some check
in probe - please see also my answer below)?

>
> > +
> > +static int ap_clk_regmap_read(struct ap_cpu_clk *clk, unsigned int reg=
,
> > +                             unsigned int *val)
> > +{
> > +       int ret;
> > +
> > +       ret =3D dfx_sread_smc(clk->phys + reg, val);
> > +       if (ret !=3D SMCCC_RET_SUCCESS)
> > +               ret =3D regmap_read(clk->pll_cr_base, reg, val);
> > +
> > +       return ret;
> > +}
> > +
> > +static int ap_clk_regmap_write(struct ap_cpu_clk *clk, unsigned int re=
g,
> > +                         unsigned int val)
> > +{
> > +       int ret;
> > +
> > +       ret =3D dfx_swrite_smc(clk->phys + reg, val);
> > +       if (ret !=3D SMCCC_RET_SUCCESS)
> > +               ret =3D regmap_write(clk->pll_cr_base, reg, val);
> > +
> > +       return ret;
> > +}
> > +
> > +static int ap_clk_regmap_update_bits(struct ap_cpu_clk *clk, unsigned =
int reg,
> > +                                    unsigned int mask, unsigned int va=
l)
> > +{
> > +       int ret;
> > +       unsigned int tmp;
> > +
> > +       ret =3D dfx_sread_smc(clk->phys + reg, &tmp);
> > +       if (ret !=3D SMCCC_RET_SUCCESS)
> > +               goto try_legacy;
>
> Can we try the legacy path at boot to read something and then if it
> fails plug in the old regmap? If it works then use the new regmap. Let's
> not keep both paths all the time if we can runtime detect it at boot.

Trying legacy in case of a secured dfx region will result with an
exception. Actually doing the opposite will do the job: during driver
probe read something with the use of smc, in case of success we will
know that we deal with updated fw and we can switch to custom, based
on smc, regmap reg_read/reg_write (as described above). In case of
failure we continue with "legacy" default regmap reg_read/reg_write.

>
> > +
> > +       tmp &=3D ~mask;
> > +       tmp |=3D val & mask;
> > +
> > +       ret =3D dfx_swrite_smc(clk->phys + reg, tmp);
> > +       if (ret =3D=3D SMCCC_RET_SUCCESS)
> > +               return ret;
> > +
> > +try_legacy:
> > +       return regmap_update_bits(clk->pll_cr_base, reg, mask, val);
> > +}
> > +
> > +static int ap_clk_regmap_read_poll_timeout(struct ap_cpu_clk *clk,
> > +                                           unsigned int reg,
> > +                                           unsigned int stable_bit)
> > +{
> > +       int ret;
> > +       u32 val;
> > +       ktime_t timeout;
> > +
> > +       timeout =3D ktime_add_us(ktime_get(), STATUS_POLL_TIMEOUT_US);
> > +       do {
> > +               ret =3D dfx_sread_smc(clk->phys + reg, &val);
> > +               if (ret || (val & stable_bit))
> > +                       break;
> > +
> > +               usleep_range((STATUS_POLL_PERIOD_US >> 2) + 1,
> > +                            STATUS_POLL_PERIOD_US);
> > +
> > +       } while (ktime_before(ktime_get(), timeout));
> > +
> > +       if (ret =3D=3D SMCCC_RET_SUCCESS)
> > +               return (val & stable_bit) ? 0 : -ETIMEDOUT;
> > +
> > +       /* If above fail, try legacy */
> > +       ret =3D regmap_read_poll_timeout(clk->pll_cr_base,
> > +                                      reg, val,
> > +                                      val & stable_bit, STATUS_POLL_PE=
RIOD_US,
> > +                                      STATUS_POLL_TIMEOUT_US);
> > +
> > +       return ret;
> > +}
> > +
> >  static unsigned long ap_cpu_clk_recalc_rate(struct clk_hw *hw,
> >                                             unsigned long parent_rate)
> >  {
> > @@ -150,7 +251,7 @@ static unsigned long ap_cpu_clk_recalc_rate(struct =
clk_hw *hw,
> >
> >         cpu_clkdiv_reg =3D clk->pll_regs->divider_reg +
> >                 (clk->cluster * clk->pll_regs->cluster_offset);
> > -       regmap_read(clk->pll_cr_base, cpu_clkdiv_reg, &cpu_clkdiv_ratio=
);
> > +       ap_clk_regmap_read(clk, cpu_clkdiv_reg, &cpu_clkdiv_ratio);
> >         cpu_clkdiv_ratio &=3D clk->pll_regs->divider_mask;
> >         cpu_clkdiv_ratio >>=3D clk->pll_regs->divider_offset;
> >
> > @@ -171,7 +272,7 @@ static int ap_cpu_clk_set_rate(struct clk_hw *hw, u=
nsigned long rate,
> >         cpu_ratio_reg =3D clk->pll_regs->ratio_reg +
> >                 (clk->cluster * clk->pll_regs->cluster_offset);
> >
> > -       regmap_read(clk->pll_cr_base, cpu_clkdiv_reg, &reg);
> > +       ap_clk_regmap_read(clk, cpu_clkdiv_reg, &reg);
> >         reg &=3D ~(clk->pll_regs->divider_mask);
> >         reg |=3D (divider << clk->pll_regs->divider_offset);
> >
> > @@ -184,29 +285,26 @@ static int ap_cpu_clk_set_rate(struct clk_hw *hw,=
 unsigned long rate,
> >                 reg |=3D ((divider * clk->pll_regs->divider_ratio) <<
> >                                 AP807_PLL_CR_1_CPU_CLK_DIV_RATIO_OFFSET=
);
> >         }
> > -       regmap_write(clk->pll_cr_base, cpu_clkdiv_reg, reg);
> > -
> > +       ap_clk_regmap_write(clk, cpu_clkdiv_reg, reg);
> >
> > -       regmap_update_bits(clk->pll_cr_base, cpu_force_reg,
> > -                          clk->pll_regs->force_mask,
> > -                          clk->pll_regs->force_mask);
> > +       ap_clk_regmap_update_bits(clk, cpu_force_reg, clk->pll_regs->fo=
rce_mask,
> > +                                 clk->pll_regs->force_mask);
> >
> > -       regmap_update_bits(clk->pll_cr_base, cpu_ratio_reg,
> > -                          BIT(clk->pll_regs->ratio_offset),
> > -                          BIT(clk->pll_regs->ratio_offset));
> > +       ap_clk_regmap_update_bits(clk, cpu_ratio_reg,
> > +                                 BIT(clk->pll_regs->ratio_offset),
> > +                                 BIT(clk->pll_regs->ratio_offset));
> >
> >         stable_bit =3D BIT(clk->pll_regs->ratio_state_offset +
> >                          clk->cluster *
> >                          clk->pll_regs->ratio_state_cluster_offset);
> > -       ret =3D regmap_read_poll_timeout(clk->pll_cr_base,
> > -                                      clk->pll_regs->ratio_state_reg, =
reg,
> > -                                      reg & stable_bit, STATUS_POLL_PE=
RIOD_US,
> > -                                      STATUS_POLL_TIMEOUT_US);
> > +       ret =3D ap_clk_regmap_read_poll_timeout(clk,
> > +                                             clk->pll_regs->ratio_stat=
e_reg,
> > +                                             stable_bit);
> >         if (ret)
> >                 return ret;
> >
> > -       regmap_update_bits(clk->pll_cr_base, cpu_ratio_reg,
> > -                          BIT(clk->pll_regs->ratio_offset), 0);
> > +       ap_clk_regmap_update_bits(clk, cpu_ratio_reg,
> > +                                 BIT(clk->pll_regs->ratio_offset), 0);
> >
> >         return 0;
> >  }
> > @@ -235,6 +333,11 @@ static int ap_cpu_clock_probe(struct platform_devi=
ce *pdev)
> >         struct clk_hw_onecell_data *ap_cpu_data;
> >         struct ap_cpu_clk *ap_cpu_clk;
> >         struct regmap *regmap;
> > +       struct resource res;
> > +
> > +       ret =3D of_address_to_resource(np->parent, 0, &res);
> > +       if (ret)
> > +               return ret;
> >
> >         regmap =3D syscon_node_to_regmap(np->parent);
> >         if (IS_ERR(regmap)) {
> > @@ -313,6 +416,12 @@ static int ap_cpu_clock_probe(struct platform_devi=
ce *pdev)
> >                 ap_cpu_clk[cluster_index].dev =3D dev;
> >                 ap_cpu_clk[cluster_index].pll_regs =3D of_device_get_ma=
tch_data(&pdev->dev);
> >
> > +               /*
> > +                * Hack to retrieve a physical addr that will be given =
to the
>
> I'd rather not enshrine "hack" in the code. "Get a physicall address to
> hand to the firmware"? Presumably this address will work and isn't some
> intermediate PA (IPA)?

You are correct, let's update the comment as you suggested.

Thank you for all your comments and suggestions,
Grzegorz

>
> > +                * firmware.
> > +                */
> > +               ap_cpu_clk[cluster_index].phys =3D res.start;
> > +
> >                 init.name =3D ap_cpu_clk[cluster_index].clk_name;
> >                 init.ops =3D &ap_cpu_clk_ops;
> >                 init.num_parents =3D 1;
