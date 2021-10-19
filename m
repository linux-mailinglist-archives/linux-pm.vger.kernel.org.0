Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E95EE4334E8
	for <lists+linux-pm@lfdr.de>; Tue, 19 Oct 2021 13:41:00 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235447AbhJSLnJ (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Tue, 19 Oct 2021 07:43:09 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53980 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235353AbhJSLnH (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Tue, 19 Oct 2021 07:43:07 -0400
Received: from mail-lf1-x12e.google.com (mail-lf1-x12e.google.com [IPv6:2a00:1450:4864:20::12e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F04E3C06161C
        for <linux-pm@vger.kernel.org>; Tue, 19 Oct 2021 04:40:54 -0700 (PDT)
Received: by mail-lf1-x12e.google.com with SMTP id j21so6936011lfe.0
        for <linux-pm@vger.kernel.org>; Tue, 19 Oct 2021 04:40:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=p/y6DgAZycykowwrleZpy70Yak++qIhNqJ9ImugcYMs=;
        b=gbZb/rIEkq16uEpMdDfbn531uPXxDE2vXRTZ1At7zc8FyijjHf+TaWP9WSCNsx9CRl
         Ax+uAwkmd3zCdbRdDaM3dpQ6QH2wtz6LdoMLA6+gjkzDI8FsGa3Gg4WLu7V9K5SrUrby
         y6A+UktAxyprVLbdSpurxxaZ8mnWtv03QgVC25vrqwdz6F5CjpkyH0G67ZL5o2xSalbx
         z2YLwvEkGXJDZVRENSUyiANgZXnd7Hl65An187cV1TSi/tcYxCoWRVEqIP0BwzqCyQr0
         hoZBxk1g0lrSFu4sw+cYxe+pvM8G9j1I2iiX+c9B9ryltLhmQtiX2zDR77yR1QolGdKK
         MOng==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=p/y6DgAZycykowwrleZpy70Yak++qIhNqJ9ImugcYMs=;
        b=mr7rBWNCfv405ZaGj4MbjdkhbJ0akCwTyPZOO/zTbbTikKlPL6al7ueakqAjyC6FxH
         LxkGKgQ6JxUbgigndZSG1ZohelpWyqIcuJdA5aj0vxa4Ppc73GvzkkkBpW8daoESr51C
         ifqFbj5My+ZSOIHYNwQJH66FFwCxc1965V1YEuJPC9wBI+Hp2y/nxYYHQd5b2w1kpS2H
         QUnqwpF7M04PkYShVO1EAQjDmxBWnka7EelZQkm4ZoM9NZw3hjCPtBoYvPGun4NoyJ7o
         g/P8gDm1gN7lQSfC1bLahz9R6sdOcfdPskLoHneG9yMYubAgDruxHM4EIAzpQgky1sGV
         EezA==
X-Gm-Message-State: AOAM532pGakLowQIctah+pZl07wIMXqzydX8Kbuzji2b7FQ+xf3c0siS
        lY6DDkP91Vvr+KUkeWetOAj+5aJWePHfVmD7M3TuaQ==
X-Google-Smtp-Source: ABdhPJyiZ8hxPaWs5ZGwktR/58DXEHsnrg2iCZG7+dtLEFQZezq+DvEjCTIwbhL0fm341kLJAfk/05h60QX3kuXQ9G4=
X-Received: by 2002:a05:6512:3084:: with SMTP id z4mr5314051lfd.167.1634643653278;
 Tue, 19 Oct 2021 04:40:53 -0700 (PDT)
MIME-Version: 1.0
References: <20210926224058.1252-1-digetx@gmail.com> <20210926224058.1252-21-digetx@gmail.com>
 <CAPDyKFoF2QxZss_h9B1NFqOqgeF=TQ6LajCedGiJ9_P8X5M0NA@mail.gmail.com>
 <0bcbcd3d-2154-03d2-f572-dc9032125c26@gmail.com> <CAPDyKFohA9iu2UQfwoc0pCrCGupdwnUTWjKOtP09_C2KaFSo8w@mail.gmail.com>
 <073114ea-490b-89a9-e82d-852b34cb11df@gmail.com>
In-Reply-To: <073114ea-490b-89a9-e82d-852b34cb11df@gmail.com>
From:   Ulf Hansson <ulf.hansson@linaro.org>
Date:   Tue, 19 Oct 2021 13:40:16 +0200
Message-ID: <CAPDyKFoOMvEW0o6=-_bYKhwUcbfeTD4qu-K2tfkdXiR0bErHsw@mail.gmail.com>
Subject: Re: [PATCH v13 20/35] mtd: rawnand: tegra: Add runtime PM and OPP support
To:     Dmitry Osipenko <digetx@gmail.com>
Cc:     Thierry Reding <thierry.reding@gmail.com>,
        Jonathan Hunter <jonathanh@nvidia.com>,
        Viresh Kumar <vireshk@kernel.org>,
        Stephen Boyd <sboyd@kernel.org>,
        Peter De Schrijver <pdeschrijver@nvidia.com>,
        Mikko Perttunen <mperttunen@nvidia.com>,
        Peter Chen <peter.chen@kernel.org>,
        Lee Jones <lee.jones@linaro.org>,
        =?UTF-8?Q?Uwe_Kleine=2DK=C3=B6nig?= 
        <u.kleine-koenig@pengutronix.de>, Nishanth Menon <nm@ti.com>,
        Adrian Hunter <adrian.hunter@intel.com>,
        Michael Turquette <mturquette@baylibre.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        linux-tegra <linux-tegra@vger.kernel.org>,
        Linux PM <linux-pm@vger.kernel.org>,
        Linux USB List <linux-usb@vger.kernel.org>,
        linux-staging@lists.linux.dev, linux-pwm@vger.kernel.org,
        linux-mmc <linux-mmc@vger.kernel.org>,
        dri-devel <dri-devel@lists.freedesktop.org>,
        DTML <devicetree@vger.kernel.org>,
        linux-clk <linux-clk@vger.kernel.org>,
        Mark Brown <broonie@kernel.org>,
        Vignesh Raghavendra <vigneshr@ti.com>,
        Richard Weinberger <richard@nod.at>,
        Miquel Raynal <miquel.raynal@bootlin.com>,
        Lucas Stach <dev@lynxeye.de>, Stefan Agner <stefan@agner.ch>,
        Mauro Carvalho Chehab <mchehab@kernel.org>,
        David Heidelberg <david@ixit.cz>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

On Sun, 17 Oct 2021 at 10:38, Dmitry Osipenko <digetx@gmail.com> wrote:
>
> 01.10.2021 18:01, Ulf Hansson =D0=BF=D0=B8=D1=88=D0=B5=D1=82:
> > On Fri, 1 Oct 2021 at 16:35, Dmitry Osipenko <digetx@gmail.com> wrote:
> >>
> >> 01.10.2021 17:24, Ulf Hansson =D0=BF=D0=B8=D1=88=D0=B5=D1=82:
> >>> On Mon, 27 Sept 2021 at 00:42, Dmitry Osipenko <digetx@gmail.com> wro=
te:
> >>>>
> >>>> The NAND on Tegra belongs to the core power domain and we're going t=
o
> >>>> enable GENPD support for the core domain. Now NAND must be resumed u=
sing
> >>>> runtime PM API in order to initialize the NAND power state. Add runt=
ime PM
> >>>> and OPP support to the NAND driver.
> >>>>
> >>>> Acked-by: Miquel Raynal <miquel.raynal@bootlin.com>
> >>>> Signed-off-by: Dmitry Osipenko <digetx@gmail.com>
> >>>> ---
> >>>>  drivers/mtd/nand/raw/tegra_nand.c | 55 ++++++++++++++++++++++++++--=
---
> >>>>  1 file changed, 47 insertions(+), 8 deletions(-)
> >>>>
> >>>> diff --git a/drivers/mtd/nand/raw/tegra_nand.c b/drivers/mtd/nand/ra=
w/tegra_nand.c
> >>>> index 32431bbe69b8..098fcc9cb9df 100644
> >>>> --- a/drivers/mtd/nand/raw/tegra_nand.c
> >>>> +++ b/drivers/mtd/nand/raw/tegra_nand.c
> >>>> @@ -17,8 +17,11 @@
> >>>>  #include <linux/mtd/rawnand.h>
> >>>>  #include <linux/of.h>
> >>>>  #include <linux/platform_device.h>
> >>>> +#include <linux/pm_runtime.h>
> >>>>  #include <linux/reset.h>
> >>>>
> >>>> +#include <soc/tegra/common.h>
> >>>> +
> >>>>  #define COMMAND                                        0x00
> >>>>  #define   COMMAND_GO                           BIT(31)
> >>>>  #define   COMMAND_CLE                          BIT(30)
> >>>> @@ -1151,6 +1154,7 @@ static int tegra_nand_probe(struct platform_de=
vice *pdev)
> >>>>                 return -ENOMEM;
> >>>>
> >>>>         ctrl->dev =3D &pdev->dev;
> >>>> +       platform_set_drvdata(pdev, ctrl);
> >>>>         nand_controller_init(&ctrl->controller);
> >>>>         ctrl->controller.ops =3D &tegra_nand_controller_ops;
> >>>>
> >>>> @@ -1166,14 +1170,22 @@ static int tegra_nand_probe(struct platform_=
device *pdev)
> >>>>         if (IS_ERR(ctrl->clk))
> >>>>                 return PTR_ERR(ctrl->clk);
> >>>>
> >>>> -       err =3D clk_prepare_enable(ctrl->clk);
> >>>> +       err =3D devm_pm_runtime_enable(&pdev->dev);
> >>>> +       if (err)
> >>>> +               return err;
> >>>> +
> >>>> +       err =3D devm_tegra_core_dev_init_opp_table_common(&pdev->dev=
);
> >>>> +       if (err)
> >>>> +               return err;
> >>>> +
> >>>> +       err =3D pm_runtime_resume_and_get(&pdev->dev);
> >>>>         if (err)
> >>>>                 return err;
> >>>>
> >>>>         err =3D reset_control_reset(rst);
> >>>>         if (err) {
> >>>>                 dev_err(ctrl->dev, "Failed to reset HW: %d\n", err);
> >>>> -               goto err_disable_clk;
> >>>> +               goto err_put_pm;
> >>>>         }
> >>>>
> >>>>         writel_relaxed(HWSTATUS_CMD_DEFAULT, ctrl->regs + HWSTATUS_C=
MD);
> >>>> @@ -1188,21 +1200,19 @@ static int tegra_nand_probe(struct platform_=
device *pdev)
> >>>>                                dev_name(&pdev->dev), ctrl);
> >>>>         if (err) {
> >>>>                 dev_err(ctrl->dev, "Failed to get IRQ: %d\n", err);
> >>>> -               goto err_disable_clk;
> >>>> +               goto err_put_pm;
> >>>>         }
> >>>>
> >>>>         writel_relaxed(DMA_MST_CTRL_IS_DONE, ctrl->regs + DMA_MST_CT=
RL);
> >>>>
> >>>>         err =3D tegra_nand_chips_init(ctrl->dev, ctrl);
> >>>>         if (err)
> >>>> -               goto err_disable_clk;
> >>>> -
> >>>> -       platform_set_drvdata(pdev, ctrl);
> >>>> +               goto err_put_pm;
> >>>>
> >>>
> >>> There is no corresponding call pm_runtime_put() here. Is it
> >>> intentional to always leave the device runtime resumed after ->probe(=
)
> >>> has succeeded?
> >>>
> >>> I noticed you included some comments about this for some other
> >>> drivers, as those needed more tweaks. Is that also the case for this
> >>> driver?
> >>
> >> Could you please clarify? There is pm_runtime_put() in both probe-erro=
r
> >> and remove() code paths here.
> >
> > I was not considering the error path of ->probe() (or ->remove()), but
> > was rather thinking about when ->probe() completes successfully. Then
> > you keep the device runtime resumed, because you have called
> > pm_runtime_resume_and_get() for it.
> >
> > Shouldn't you have a corresponding pm_runtime_put() in ->probe(),
> > allowing it to be runtime suspended, until the device is really needed
> > later on. No?
>
> This driver doesn't support active power management. I don't have Tegra
> hardware that uses NAND storage for testing, so it's up to somebody else
> to implement dynamic power management. NAND doesn't require high
> voltages, so it's fine to keep the old driver behaviour by keeping
> hardware resumed since the probe time.

Alright, fair enough and thanks for clarifying!

Kind regards
Uffe
