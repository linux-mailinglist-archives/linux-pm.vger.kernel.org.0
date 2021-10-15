Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2D25442EDED
	for <lists+linux-pm@lfdr.de>; Fri, 15 Oct 2021 11:44:39 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237621AbhJOJqm (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Fri, 15 Oct 2021 05:46:42 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45870 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237656AbhJOJqi (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Fri, 15 Oct 2021 05:46:38 -0400
Received: from mail-io1-xd2d.google.com (mail-io1-xd2d.google.com [IPv6:2607:f8b0:4864:20::d2d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id ABD19C0617B1;
        Fri, 15 Oct 2021 02:44:18 -0700 (PDT)
Received: by mail-io1-xd2d.google.com with SMTP id m20so6985478iol.4;
        Fri, 15 Oct 2021 02:44:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=9NXi+dJimxQdgEFQS5128X7IR1wpG54I2lntzTVysHg=;
        b=XOU78TQ4+Dq1jYhGaUo17LPV9+id1mBjGTAFHnpkW7G8ivA0zmAwctLEhBZsWiyv1y
         gFba9Xj3V9oguFFp/2fprxXx86pYb8q++GyDHADK1o3igKaBBQ/S1Akhxpm7Tk17RdEO
         WaJKviSWgBnoh+KhmgkEz+rx2pB6hT41L/ajzavZx274UgSYmaPN08c+egCeC6WDgyZ/
         4RsnR5vgkA6lIg4EUhuhm6JxvIDhaS8cAIIdyDS+/auUcvyaKE9hMszVJFqrsdVbi+b3
         9kC2Kz7VzULxHSzmlT30SAaZAlQ1lBrx327AUVixaFfdw1xj6BJ9m4yhd8fke+laPaUw
         grDQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=9NXi+dJimxQdgEFQS5128X7IR1wpG54I2lntzTVysHg=;
        b=H7jUyjpxmMrUea977aFy3EzkU5D6Qhsas6JyoB8wPGTy/3HT7scpg/ipTZIeIMo6NZ
         1KsnPsfGaZ8bKP8Rq4++CEezhCMkSTYjHTHySa+aiOHZVtlhdKnMusW2+LXRVcOlnnf+
         e4W/awFrd2DR8nzQS77kKrIDMB1OsfdI4KOU/J2OYRwK705unUNA/Wd+cWZTMLhJZHGP
         WQVZCx65fEx6t39l+5jwqn6xP70u25Smy33moixCy1opw+rnPC/GFDdfCpBCwn0K6Abu
         N73vV/XD/Wmx7vb+5TiovPYWRvYMuNTyEmhGlFx2ihGd7zcSr3CIAhap6D4/YKebJk5o
         gPOA==
X-Gm-Message-State: AOAM530jx2U97o3PhmJVlQxqvY92zTFozbyXISIRVR2ylfc8Vb5V2VXh
        Io3VLzvhfd7AjX+/t7tk03qclSqZBYZd4Jl61mQ=
X-Google-Smtp-Source: ABdhPJzToyLsRp585Vw5bHBRFxQRavTC63/y0ndrD1zpvgnLBZyiU7PVPzBIK7eFo9EbjMpYJ7xD6FI5uGXlwhsP5m0=
X-Received: by 2002:a5e:9612:: with SMTP id a18mr2929547ioq.57.1634291058137;
 Fri, 15 Oct 2021 02:44:18 -0700 (PDT)
MIME-Version: 1.0
References: <20211009115732.19102-1-alistair@alistair23.me> <20211015025923.GA22881@dragon>
In-Reply-To: <20211015025923.GA22881@dragon>
From:   Alistair Francis <alistair23@gmail.com>
Date:   Fri, 15 Oct 2021 19:43:00 +1000
Message-ID: <CAKmqyKOjSCGNfyQj+eegixURM+NqTYWsa0QGLN+sV7he-RVCHg@mail.gmail.com>
Subject: Re: [PATCH v12 10/10] ARM: dts: imx7d: remarkable2: Enable lcdif
To:     Shawn Guo <shawnguo@kernel.org>
Cc:     Alistair Francis <alistair@alistair23.me>,
        Lee Jones <lee.jones@linaro.org>,
        Rob Herring <robh+dt@kernel.org>, lgirdwood@gmail.com,
        Mark Brown <broonie@kernel.org>,
        Sascha Hauer <kernel@pengutronix.de>,
        Sascha Hauer <s.hauer@pengutronix.de>,
        dl-linux-imx <linux-imx@nxp.com>, amitk@kernel.org,
        rui.zhang@intel.com, devicetree <devicetree@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        linux-hwmon@vger.kernel.org,
        linux-arm-kernel <linux-arm-kernel@lists.infradead.org>,
        linux-pm@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

On Fri, Oct 15, 2021 at 12:59 PM Shawn Guo <shawnguo@kernel.org> wrote:
>
> On Sat, Oct 09, 2021 at 09:57:32PM +1000, Alistair Francis wrote:
> > Connect the dispaly on the reMarkable2.
> >
> > Signed-off-by: Alistair Francis <alistair@alistair23.me>
>
> Maybe there are some patches missing.  It doesn't apply to my branch.

Sorry about that. This series applies on top of the "ARM: dts: imx7d:
remarkable2: add wacom digitizer device" patch. The patch is on the
list but not yet applied.

I'll send a rebased version.

Alistair

>
> Shawn
>
> > ---
> >  arch/arm/boot/dts/imx7d-remarkable2.dts | 74 +++++++++++++++++++++++++
> >  1 file changed, 74 insertions(+)
> >
> > diff --git a/arch/arm/boot/dts/imx7d-remarkable2.dts b/arch/arm/boot/dts/imx7d-remarkable2.dts
> > index 1b49c26816cd..5f32c216c3fd 100644
> > --- a/arch/arm/boot/dts/imx7d-remarkable2.dts
> > +++ b/arch/arm/boot/dts/imx7d-remarkable2.dts
> > @@ -47,6 +47,16 @@ reg_digitizer: regulator-digitizer {
> >               startup-delay-us = <100000>; /* 100 ms */
> >       };
> >
> > +     reg_sdoe: regulator-sdoe {
> > +             compatible = "regulator-fixed";
> > +             regulator-name = "SDOE";
> > +             pinctrl-names = "default", "sleep";
> > +             pinctrl-0 = <&pinctrl_sdoe_reg>;
> > +             pinctrl-1 = <&pinctrl_sdoe_reg>;
> > +             gpio = <&gpio3 27 GPIO_ACTIVE_HIGH>;
> > +             enable-active-high;
> > +     };
> > +
> >       wifi_pwrseq: wifi_pwrseq {
> >               compatible = "mmc-pwrseq-simple";
> >               pinctrl-names = "default";
> > @@ -55,6 +65,16 @@ wifi_pwrseq: wifi_pwrseq {
> >               clocks = <&clks IMX7D_CLKO2_ROOT_DIV>;
> >               clock-names = "ext_clock";
> >       };
> > +
> > +     panel {
> > +             compatible = "eink,vb3300-kca";
> > +
> > +             port {
> > +                     panel_in: endpoint {
> > +                             remote-endpoint = <&display_out>;
> > +                     };
> > +             };
> > +     };
> >  };
> >
> >  &clks {
> > @@ -114,6 +134,20 @@ reg_epdpmic: vcom {
> >       };
> >  };
> >
> > +&lcdif {
> > +     pinctrl-names = "default";
> > +     pinctrl-0 = <&pinctrl_lcdif>;
> > +     lcd-supply = <&reg_epdpmic>;
> > +     lcd2-supply = <&reg_sdoe>;
> > +     status = "okay";
> > +
> > +     port {
> > +             display_out: endpoint {
> > +                     remote-endpoint = <&panel_in>;
> > +             };
> > +     };
> > +};
> > +
> >  &snvs_pwrkey {
> >       status = "okay";
> >  };
> > @@ -228,6 +262,46 @@ MX7D_PAD_I2C4_SCL__I2C4_SCL              0x4000007f
> >               >;
> >       };
> >
> > +     pinctrl_lcdif: lcdifgrp {
> > +             fsl,pins = <
> > +                     MX7D_PAD_LCD_DATA00__LCD_DATA0          0x79
> > +                     MX7D_PAD_LCD_DATA01__LCD_DATA1          0x79
> > +                     MX7D_PAD_LCD_DATA02__LCD_DATA2          0x79
> > +                     MX7D_PAD_LCD_DATA03__LCD_DATA3          0x79
> > +                     MX7D_PAD_LCD_DATA04__LCD_DATA4          0x79
> > +                     MX7D_PAD_LCD_DATA05__LCD_DATA5          0x79
> > +                     MX7D_PAD_LCD_DATA06__LCD_DATA6          0x79
> > +                     MX7D_PAD_LCD_DATA07__LCD_DATA7          0x79
> > +                     MX7D_PAD_LCD_DATA08__LCD_DATA8          0x79
> > +                     MX7D_PAD_LCD_DATA09__LCD_DATA9          0x79
> > +                     MX7D_PAD_LCD_DATA10__LCD_DATA10         0x79
> > +                     MX7D_PAD_LCD_DATA11__LCD_DATA11         0x79
> > +                     MX7D_PAD_LCD_DATA12__LCD_DATA12         0x79
> > +                     MX7D_PAD_LCD_DATA13__LCD_DATA13         0x79
> > +                     MX7D_PAD_LCD_DATA14__LCD_DATA14         0x79
> > +                     MX7D_PAD_LCD_DATA15__LCD_DATA15         0x79
> > +
> > +                     MX7D_PAD_LCD_DATA17__LCD_DATA17         0x79
> > +                     MX7D_PAD_LCD_DATA18__LCD_DATA18         0x79
> > +                     MX7D_PAD_LCD_DATA19__LCD_DATA19         0x79
> > +                     MX7D_PAD_LCD_DATA20__LCD_DATA20         0x79
> > +                     MX7D_PAD_LCD_DATA21__LCD_DATA21         0x79
> > +
> > +                     MX7D_PAD_LCD_DATA23__LCD_DATA23         0x79
> > +                     MX7D_PAD_LCD_CLK__LCD_CLK               0x79
> > +                     MX7D_PAD_LCD_ENABLE__LCD_ENABLE         0x79
> > +                     MX7D_PAD_LCD_VSYNC__LCD_VSYNC           0x79
> > +                     MX7D_PAD_LCD_HSYNC__LCD_HSYNC           0x79
> > +                     MX7D_PAD_LCD_RESET__LCD_RESET           0x79
> > +             >;
> > +     };
> > +
> > +     pinctrl_sdoe_reg: sdoereggrp {
> > +             fsl,pins = <
> > +                     MX7D_PAD_LCD_DATA22__GPIO3_IO27         0x74
> > +             >;
> > +     };
> > +
> >       pinctrl_uart1: uart1grp {
> >               fsl,pins = <
> >                       MX7D_PAD_UART1_TX_DATA__UART1_DCE_TX    0x79
> > --
> > 2.31.1
> >
