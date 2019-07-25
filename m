Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 6DCC3751DD
	for <lists+linux-pm@lfdr.de>; Thu, 25 Jul 2019 16:53:59 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388166AbfGYOxx (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Thu, 25 Jul 2019 10:53:53 -0400
Received: from mail-lj1-f194.google.com ([209.85.208.194]:41222 "EHLO
        mail-lj1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2388154AbfGYOxx (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Thu, 25 Jul 2019 10:53:53 -0400
Received: by mail-lj1-f194.google.com with SMTP id d24so48286212ljg.8;
        Thu, 25 Jul 2019 07:53:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:reply-to:from:date:message-id
         :subject:to:cc:content-transfer-encoding;
        bh=Ves/f9tu6TtsBtCLUNP0b3bzM2Uf2Nm5yMFDA1GMfbc=;
        b=HG2pDyTRovEm831xHNuDvkOmfNDjfVyGi7YHw8mNl2rJFTexXNySjqL3AQU7gG++nA
         YumFFeHF+YJb1HdS24FkHcsFf4eBVJCWuFDEozd3CogY5M+yTH9pe7VVp4qRiOjXcoIN
         ox1LooMmzJInds5EPvwIAlk6waCNsXQEiJexOMi8vwxmOR4TPQKm0OgUInSejtmUgfDX
         iLLZrw/vrgXWa6pIIRZ8BGmtudCYUEpD8cspX7XSrfId29ivDbtE97Dn1/vZ5LjobIg3
         kKnz/SxlfDjbqsy/2AdyPS3HauLvRRZQclGhoKvg5gRbSDwvg2JE2l1PqwYFHR2rXEva
         WOnQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:reply-to
         :from:date:message-id:subject:to:cc:content-transfer-encoding;
        bh=Ves/f9tu6TtsBtCLUNP0b3bzM2Uf2Nm5yMFDA1GMfbc=;
        b=C5XBAvwuULBI48m6kNhvFIcmz/bkIoXb073LymS4odhLiXTbPwx/mEMj9ne/epRUbZ
         i71HCmf2gLS/4U843KKp4GBCqns86jZdAITjX8ZITOyHVyF9Lieebq38+icLAxn56kHY
         KxPrs6ALlp7JVX65BWyzI+dfdWOqUnBLYAU/UC/1lGEq78eAzgVxMTmWj8+WmcZ/PbeS
         YFFkPvNyIflF0wG8I46FUNtyXEFO1uX5msyhiDK1GQK2+q6MstfS5sG4Wl7c+k5DleuP
         OFwHeVbXNfRl4g6BxPR5Ol/B0fh+qnQrTh0R0zyvQVkJ5dwz/lPSAz8yPh8Wh6ehhQBx
         9TUA==
X-Gm-Message-State: APjAAAXFuCVXvfJhJRzFkkaf5CehNhIrGOsByjo0uHlvFvgWM2XKB9sO
        jNOnxIg91ZYQlPjcPqFBoPNh9E8aIEUUTEepVv5McciArS18jg==
X-Google-Smtp-Source: APXvYqzVmr7UP05OBJQtGyEZORBSpchwZjW+8PdCNUf63yxd2z8ra0kx21UJnTKmsVClJloNyb8Wp6Nr4X+DpxTxpzc=
X-Received: by 2002:a2e:85d4:: with SMTP id h20mr46715537ljj.142.1564066429035;
 Thu, 25 Jul 2019 07:53:49 -0700 (PDT)
MIME-Version: 1.0
References: <20190719150535.15501-1-k.konieczny@partner.samsung.com>
 <CGME20190719150555eucas1p197adc3c58e45c53137fd70cadbfae60e@eucas1p1.samsung.com>
 <20190719150535.15501-4-k.konieczny@partner.samsung.com> <beb2455b-7f9e-35df-d524-01f4f51a1c62@samsung.com>
 <ed80b6e3-5b40-18ce-ca1e-65520edf516e@partner.samsung.com>
In-Reply-To: <ed80b6e3-5b40-18ce-ca1e-65520edf516e@partner.samsung.com>
Reply-To: cwchoi00@gmail.com
From:   Chanwoo Choi <cwchoi00@gmail.com>
Date:   Thu, 25 Jul 2019 23:53:12 +0900
Message-ID: <CAGTfZH1OaYpTheQxWQs7Fs4qcJEGtXQHESLg0CJSsL=dmROpQw@mail.gmail.com>
Subject: Re: [PATCH v3 3/5] devfreq: exynos-bus: convert to use dev_pm_opp_set_rate()
To:     Kamil Konieczny <k.konieczny@partner.samsung.com>
Cc:     Chanwoo Choi <cw00.choi@samsung.com>,
        Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>,
        Marek Szyprowski <m.szyprowski@samsung.com>,
        Krzysztof Kozlowski <krzk@kernel.org>,
        Kukjin Kim <kgene@kernel.org>,
        Kyungmin Park <kyungmin.park@samsung.com>,
        Mark Rutland <mark.rutland@arm.com>,
        MyungJoo Ham <myungjoo.ham@samsung.com>,
        Nishanth Menon <nm@ti.com>, Rob Herring <robh+dt@kernel.org>,
        Stephen Boyd <sboyd@kernel.org>,
        Viresh Kumar <vireshk@kernel.org>,
        devicetree <devicetree@vger.kernel.org>,
        linux-arm-kernel <linux-arm-kernel@lists.infradead.org>,
        linux-kernel <linux-kernel@vger.kernel.org>,
        Linux PM list <linux-pm@vger.kernel.org>,
        linux-samsung-soc <linux-samsung-soc@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

2019=EB=85=84 7=EC=9B=94 25=EC=9D=BC (=EB=AA=A9) =EC=98=A4=ED=9B=84 11:19, =
Kamil Konieczny
<k.konieczny@partner.samsung.com>=EB=8B=98=EC=9D=B4 =EC=9E=91=EC=84=B1:
>
> Hi Chanwoo,
>
> On 25.07.2019 12:17, Chanwoo Choi wrote:
> > Hi Kamil,
> >
> > Looks good to me. But, I have some comment. Please check them.
>
> Thank you for review, please see answers below.
>
> > After this patch, exynos_bus_target is perfectly same with
> > exynos_bus_passive_target. The exynos_bus_passive_target() could be rem=
oved.
>
> Ok, I will make it in separate patch to simplify review process.

I think you can just modify this patch without any separate patch.

> > On 19. 7. 20. =EC=98=A4=EC=A0=84 12:05, k.konieczny@partner.samsung.com=
 wrote:
> >> Reuse opp core code for setting bus clock and voltage. As a side
> >> effect this allow useage of coupled regulators feature (required
> >
> > s/useage/usage ?
>
> Good catch, I will change it.
>
> >> for boards using Exynos5422/5800 SoCs) because dev_pm_opp_set_rate()
> >> uses regulator_set_voltage_triplet() for setting regulator voltage
> >> while the old code used regulator_set_voltage_tol() with fixed
> >> tolerance. This patch also removes no longer needed parsing of DT
> >> property "exynos,voltage-tolerance" (no Exynos devfreq DT node uses
> >> it).
> >>
> >> Signed-off-by: Kamil Konieczny <k.konieczny@partner.samsung.com>
> >> ---
> >>  drivers/devfreq/exynos-bus.c | 143 +++++++++-------------------------=
-
> >>  1 file changed, 37 insertions(+), 106 deletions(-)
> >>
> >> diff --git a/drivers/devfreq/exynos-bus.c b/drivers/devfreq/exynos-bus=
.c
> >> index f391044aa39d..c2147b0912a0 100644
> >> --- a/drivers/devfreq/exynos-bus.c
> >> +++ b/drivers/devfreq/exynos-bus.c
> >> @@ -25,7 +25,6 @@
> >>  #include <linux/slab.h>
> >>
> >>  #define DEFAULT_SATURATION_RATIO    40
> >> -#define DEFAULT_VOLTAGE_TOLERANCE   2
> >>
> >>  struct exynos_bus {
> >>      struct device *dev;
> >> @@ -37,9 +36,9 @@ struct exynos_bus {
> >>
> >>      unsigned long curr_freq;
> >>
> >> -    struct regulator *regulator;
> >> +    struct opp_table *opp_table;
> >> +
> >>      struct clk *clk;
> >> -    unsigned int voltage_tolerance;
> >>      unsigned int ratio;
> >>  };
> >>
> >> @@ -99,56 +98,23 @@ static int exynos_bus_target(struct device *dev, u=
nsigned long *freq, u32 flags)
> >>  {
> >>      struct exynos_bus *bus =3D dev_get_drvdata(dev);
> >>      struct dev_pm_opp *new_opp;
> >> -    unsigned long old_freq, new_freq, new_volt, tol;
> >>      int ret =3D 0;
> >>
> >> -    /* Get new opp-bus instance according to new bus clock */
> >> +    /* Get correct frequency for bus. */
> >>      new_opp =3D devfreq_recommended_opp(dev, freq, flags);
> >>      if (IS_ERR(new_opp)) {
> >>              dev_err(dev, "failed to get recommended opp instance\n");
> >>              return PTR_ERR(new_opp);
> >>      }
> >>
> >> -    new_freq =3D dev_pm_opp_get_freq(new_opp);
> >> -    new_volt =3D dev_pm_opp_get_voltage(new_opp);
> >>      dev_pm_opp_put(new_opp);
> >>
> >> -    old_freq =3D bus->curr_freq;
> >> -
> >> -    if (old_freq =3D=3D new_freq)
> >> -            return 0;
> >> -    tol =3D new_volt * bus->voltage_tolerance / 100;
> >> -
> >>      /* Change voltage and frequency according to new OPP level */
> >>      mutex_lock(&bus->lock);
> >> +    ret =3D dev_pm_opp_set_rate(dev, *freq);
> >> +    if (!ret)
> >> +            bus->curr_freq =3D *freq;
> >>
> >> -    if (old_freq < new_freq) {
> >> -            ret =3D regulator_set_voltage_tol(bus->regulator, new_vol=
t, tol);
> >> -            if (ret < 0) {
> >> -                    dev_err(bus->dev, "failed to set voltage\n");
> >> -                    goto out;
> >> -            }
> >> -    }
> >> -
> >> -    ret =3D clk_set_rate(bus->clk, new_freq);
> >> -    if (ret < 0) {
> >> -            dev_err(dev, "failed to change clock of bus\n");
> >> -            clk_set_rate(bus->clk, old_freq);
> >> -            goto out;
> >> -    }
> >> -
> >> -    if (old_freq > new_freq) {
> >> -            ret =3D regulator_set_voltage_tol(bus->regulator, new_vol=
t, tol);
> >> -            if (ret < 0) {
> >> -                    dev_err(bus->dev, "failed to set voltage\n");
> >> -                    goto out;
> >> -            }
> >> -    }
> >> -    bus->curr_freq =3D new_freq;
> >> -
> >> -    dev_dbg(dev, "Set the frequency of bus (%luHz -> %luHz, %luHz)\n"=
,
> >> -                    old_freq, new_freq, clk_get_rate(bus->clk));
> >> -out:
> >>      mutex_unlock(&bus->lock);
> >>
> >>      return ret;
> >> @@ -195,8 +161,8 @@ static void exynos_bus_exit(struct device *dev)
> >>              dev_warn(dev, "failed to disable the devfreq-event device=
s\n");
> >>
> >>      clk_disable_unprepare(bus->clk);
> >> -    if (bus->regulator)
> >> -            regulator_disable(bus->regulator);
> >> +    if (bus->opp_table)
> >> +            dev_pm_opp_put_regulators(bus->opp_table);
> >>
> >>      dev_pm_opp_of_remove_table(dev);
> >>  }
> >> @@ -209,39 +175,23 @@ static int exynos_bus_passive_target(struct devi=
ce *dev, unsigned long *freq,
> >>  {
> >>      struct exynos_bus *bus =3D dev_get_drvdata(dev);
> >>      struct dev_pm_opp *new_opp;
> >> -    unsigned long old_freq, new_freq;
> >> -    int ret =3D 0;
> >> +    int ret;
> >>
> >> -    /* Get new opp-bus instance according to new bus clock */
> >> +    /* Get correct frequency for bus. */
> >>      new_opp =3D devfreq_recommended_opp(dev, freq, flags);
> >>      if (IS_ERR(new_opp)) {
> >>              dev_err(dev, "failed to get recommended opp instance\n");
> >>              return PTR_ERR(new_opp);
> >>      }
> >>
> >> -    new_freq =3D dev_pm_opp_get_freq(new_opp);
> >>      dev_pm_opp_put(new_opp);
> >>
> >> -    old_freq =3D bus->curr_freq;
> >> -
> >> -    if (old_freq =3D=3D new_freq)
> >> -            return 0;
> >> -
> >>      /* Change the frequency according to new OPP level */
> >>      mutex_lock(&bus->lock);
> >> +    ret =3D dev_pm_opp_set_rate(dev, *freq);
> >> +    if (!ret)
> >> +            bus->curr_freq =3D *freq;
> >>
> >> -    ret =3D clk_set_rate(bus->clk, new_freq);
> >> -    if (ret < 0) {
> >> -            dev_err(dev, "failed to set the clock of bus\n");
> >> -            goto out;
> >> -    }
> >> -
> >> -    *freq =3D new_freq;
> >> -    bus->curr_freq =3D new_freq;
> >> -
> >> -    dev_dbg(dev, "Set the frequency of bus (%luHz -> %luHz, %luHz)\n"=
,
> >> -                    old_freq, new_freq, clk_get_rate(bus->clk));
> >> -out:
> >>      mutex_unlock(&bus->lock);
> >>
> >>      return ret;
> >> @@ -259,20 +209,9 @@ static int exynos_bus_parent_parse_of(struct devi=
ce_node *np,
> >>                                      struct exynos_bus *bus)
> >>  {
> >>      struct device *dev =3D bus->dev;
> >> -    int i, ret, count, size;
> >> -
> >> -    /* Get the regulator to provide each bus with the power */
> >> -    bus->regulator =3D devm_regulator_get(dev, "vdd");
> >> -    if (IS_ERR(bus->regulator)) {
> >> -            dev_err(dev, "failed to get VDD regulator\n");
> >> -            return PTR_ERR(bus->regulator);
> >> -    }
> >> -
> >> -    ret =3D regulator_enable(bus->regulator);
> >> -    if (ret < 0) {
> >> -            dev_err(dev, "failed to enable VDD regulator\n");
> >> -            return ret;
> >> -    }
> >> +    struct opp_table *opp_table;
> >> +    const char *vdd =3D "vdd";
> >> +    int i, count, size;
> >>
> >>      /*
> >>       * Get the devfreq-event devices to get the current utilization o=
f
> >> @@ -281,26 +220,29 @@ static int exynos_bus_parent_parse_of(struct dev=
ice_node *np,
> >>      count =3D devfreq_event_get_edev_count(dev);
> >>      if (count < 0) {
> >>              dev_err(dev, "failed to get the count of devfreq-event de=
v\n");
> >> -            ret =3D count;
> >> -            goto err_regulator;
> >> +            return count;
> >>      }
> >> -    bus->edev_count =3D count;
> >>
> >> +    bus->edev_count =3D count;
> >>      size =3D sizeof(*bus->edev) * count;
> >>      bus->edev =3D devm_kzalloc(dev, size, GFP_KERNEL);
> >> -    if (!bus->edev) {
> >> -            ret =3D -ENOMEM;
> >> -            goto err_regulator;
> >> -    }
> >> +    if (!bus->edev)
> >> +            return -ENOMEM;
> >>
> >>      for (i =3D 0; i < count; i++) {
> >>              bus->edev[i] =3D devfreq_event_get_edev_by_phandle(dev, i=
);
> >> -            if (IS_ERR(bus->edev[i])) {
> >> -                    ret =3D -EPROBE_DEFER;
> >> -                    goto err_regulator;
> >> -            }
> >> +            if (IS_ERR(bus->edev[i]))
> >> +                    return -EPROBE_DEFER;
> >> +    }
> >> +
> >> +    opp_table =3D dev_pm_opp_set_regulators(dev, &vdd, 1);
> >> +    if (IS_ERR(opp_table)) {
> >> +            i =3D PTR_ERR(opp_table);
> >> +            dev_err(dev, "failed to set regulators %d\n", i);
> >> +            return i;
> >
> > Maybe, you just used the 'i' defined variable instead of adding
> > new variable. But, I think that you better to add new variable
> > like 'err' for the readability. Or, jut use the 'PTR_ERR(opp_table)'
> > directly without any additional variable.
>
> I will remove not related changes, so here I will reuse 'ret' variable.
>
> >>      }
> >>
> >> +    bus->opp_table =3D opp_table;
> >
> > Add blank line.
>
> OK
>
> >>      /*
> >>       * Optionally, Get the saturation ratio according to Exynos SoC
> >>       * When measuring the utilization of each AXI bus with devfreq-ev=
ent
> >> @@ -314,16 +256,7 @@ static int exynos_bus_parent_parse_of(struct devi=
ce_node *np,
> >>      if (of_property_read_u32(np, "exynos,saturation-ratio", &bus->rat=
io))
> >>              bus->ratio =3D DEFAULT_SATURATION_RATIO;
> >>
> >> -    if (of_property_read_u32(np, "exynos,voltage-tolerance",
> >> -                                    &bus->voltage_tolerance))
> >> -            bus->voltage_tolerance =3D DEFAULT_VOLTAGE_TOLERANCE;
> >> -
> >>      return 0;
> >> -
> >> -err_regulator:
> >> -    regulator_disable(bus->regulator);
> >> -
> >> -    return ret;
> >>  }
> >>
> >>  static int exynos_bus_parse_of(struct exynos_bus *bus)
> >> @@ -414,12 +347,8 @@ static int exynos_bus_probe(struct platform_devic=
e *pdev)
> >>
> >>      /* Parse the device-tree to get the resource information */
> >>      ret =3D exynos_bus_parse_of(bus);
> >> -    if (ret < 0) {
> >> -            if (!passive)
> >> -                    regulator_disable(bus->regulator);
> >> -
> >> -            return ret;
> >> -    }
> >> +    if (ret < 0)
> >> +            goto err_reg;
> >>
> >>      if (passive)
> >>              goto passive;
> >> @@ -512,10 +441,12 @@ static int exynos_bus_probe(struct platform_devi=
ce *pdev)
> >>
> >>  err:
> >>      clk_disable_unprepare(bus->clk);
> >> -    if (!passive)
> >> -            regulator_disable(bus->regulator);
> >> -
> >>      dev_pm_opp_of_remove_table(dev);
> >
> > This function removes the 'opp_table'. But, the below code
> > uses the 'opp_table' variable by dev_pm_opp_put_regulators().
> >
> > To disable the regulator, you have to call dev_pm_opp_of_remove_table(d=
ev)
> > after dev_pm_opp_put_regulators(bus->opp_table).
>
> Regulators should be set before dev_pm_opp_add_table(), so exit sequence
> should be in reverse order,
>
> init order:
>
> exynos_bus_parent_parse_of()
>         dev_pm_opp_set_regulators()
> exynos_bus_parse_of()
>         clk_prepare_enable()
>         dev_pm_opp_of_add_table()
>
> exit or error order:
>
> dev_pm_opp_of_remove_table()
> clk_disable_unprepare()
> if (bus->opp_table)
>         dev_pm_opp_put_regulators(bus->opp_table);

dev_pm_opp_of_remove_table() have to be called at the end of exit sequence
after disabling clock and put regulators. Because dev_pm_opp_of_remove_tabl=
e()
frees the 'opp_table' pointer of device.

clk_disable_unprepare()
if (bus->opp_table)
          dev_pm_opp_put_regulators(bus->opp_table);
dev_pm_opp_of_remove_table()

>
> I will send v4 soon.
>
> >> +err_reg:
> >> +    if (bus->opp_table) {
> >> +            dev_pm_opp_put_regulators(bus->opp_table);
> >> +            bus->opp_table =3D NULL;
> >> +    }
> >>
> >>      return ret;
> >>  }
>
> --
> Best regards,
> Kamil Konieczny
> Samsung R&D Institute Poland
>


--=20
Best Regards,
Chanwoo Choi
