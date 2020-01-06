Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id C54EA1316FE
	for <lists+linux-pm@lfdr.de>; Mon,  6 Jan 2020 18:45:26 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726569AbgAFRpW (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Mon, 6 Jan 2020 12:45:22 -0500
Received: from mail-io1-f66.google.com ([209.85.166.66]:39588 "EHLO
        mail-io1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726496AbgAFRpV (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Mon, 6 Jan 2020 12:45:21 -0500
Received: by mail-io1-f66.google.com with SMTP id c16so19623915ioh.6;
        Mon, 06 Jan 2020 09:45:21 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=iXctLlmYdrdKmfjjRbd044M1gc5IPMj+HwF01t2aLxE=;
        b=lKMWg3HLOmvwWxJ0QtPLD+d5uVW21/HD+VV4LSzKxccmAVHU752JGwACLfCOx4foBp
         GFOqdq9A+iruNNxsN2JqU2Eb1oTMSzmj0WFCtWM+lEOnByEwBEKHUK9UuzeYh8ppDgB1
         2Eqw9dntUU+zlnSMUDRGFDFrc044zk4qIXmoPVQpgfWUs82Ebmrzslu7vl10SIte5Hq0
         UrDk+034ryO0R86w1j1MoG33EKI7rsNLmJepg+tmeb2EVey2rUkNYU2bnEFtILqAoKmI
         mN31+OxzTYyvUzE4Y9ZgmRC8dY03A9szlx8By3srCtGGNwXRyGLcYl15FUWZ2RSDd9n9
         VhCg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=iXctLlmYdrdKmfjjRbd044M1gc5IPMj+HwF01t2aLxE=;
        b=TKkiR8OlSm1XF6EtG7Q6Lt8RFHJodT+0V75xe+hW/CaC3AgFlaUQSsN5R6rpK8bULT
         SoR51nFSC+FnFkiG7KBtCdmWdGyheDZrepud94od3/B4hNOouGnaXYVCAV4Xs8pcBI4E
         TlRHruSHhDhsmYVIwoyGWCpjCInoCGA5u/1BMezX5F8o06Tfb1YZsdsBsrjpzF8FfZTw
         RpEzpeu/RFdjQ7HvP4gztVMFHIGUFSpq1yw/eTgwH0hxMyM8p3LmmGbdb7RtJirIMFP9
         lczMOZE1tTVItSXcUOGGKeS1nnxmz0rBOnTKY4K9wBHJvcKu/hnF8Wnzwz8HLf5R3v9C
         Zk1g==
X-Gm-Message-State: APjAAAVBOBTS4jmS0H0WahhNJn9KPTMNoH2GDC92pB0Xv6Ed2tmszjxk
        akRduvvGbaRfRU+XVVODx2XkkBZGEVAFiscteJ8=
X-Google-Smtp-Source: APXvYqxBbtoShLII8AtDZh3j+6a1iS1Iq+kxojCr5tNwKmFK+J2CfVlfliqXAlghSpaB31l+fm+LyLpoIZV/nJ2y0l8=
X-Received: by 2002:a6b:b941:: with SMTP id j62mr72571643iof.168.1578332721008;
 Mon, 06 Jan 2020 09:45:21 -0800 (PST)
MIME-Version: 1.0
References: <20200106172254.20271-1-tiny.windzz@gmail.com> <CA+E=qVciDPXrHCGsHR7mjFuaGrv_K21ZAdWW28_fnSV3CvEDCg@mail.gmail.com>
In-Reply-To: <CA+E=qVciDPXrHCGsHR7mjFuaGrv_K21ZAdWW28_fnSV3CvEDCg@mail.gmail.com>
From:   Frank Lee <tiny.windzz@gmail.com>
Date:   Tue, 7 Jan 2020 01:45:09 +0800
Message-ID: <CAEExFWtD_wOJ9sSvXd3uGD5ZXAOPX3kenoRdv-fKpqjZXp22Dw@mail.gmail.com>
Subject: Re: [PATCH 1/2] thermal: sun8i: fix r40 ths number
To:     Vasily Khoruzhick <anarsoul@gmail.com>
Cc:     Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Maxime Ripard <mripard@kernel.org>,
        Chen-Yu Tsai <wens@csie.org>, Zhang Rui <rui.zhang@intel.com>,
        Daniel Lezcano <daniel.lezcano@linaro.org>,
        Amit Kucheria <amit.kucheria@verdurent.com>,
        devicetree <devicetree@vger.kernel.org>,
        arm-linux <linux-arm-kernel@lists.infradead.org>,
        linux-kernel <linux-kernel@vger.kernel.org>,
        Linux PM <linux-pm@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

On Tue, Jan 7, 2020 at 1:29 AM Vasily Khoruzhick <anarsoul@gmail.com> wrote=
:
>
> On Mon, Jan 6, 2020 at 9:23 AM Yangtao Li <tiny.windzz@gmail.com> wrote:
> >
> > According to the spec, r40 has 2 thermal sensors.
> > Sensor0 located in the CPU, another in the GPU.
> >
> > Signed-off-by: Yangtao Li <tiny.windzz@gmail.com>
>
> You should also add "Fixes" tag here.

Since the driver has not yet entered the merge window......
Thanks for reminding=EF=BC=8C =EF=BC=9AD

Yangtao

>
> > Tested-by: Corentin Labbe <clabbe.montjoie@gmail.com>
> > Tested-on: sun8i-r40-bananapi-m2-ultra
> > ---
> >  drivers/thermal/sun8i_thermal.c | 2 +-
> >  1 file changed, 1 insertion(+), 1 deletion(-)
> >
> > diff --git a/drivers/thermal/sun8i_thermal.c b/drivers/thermal/sun8i_th=
ermal.c
> > index 23a5f4aa4be4..c5661d7c3e20 100644
> > --- a/drivers/thermal/sun8i_thermal.c
> > +++ b/drivers/thermal/sun8i_thermal.c
> > @@ -565,7 +565,7 @@ static const struct ths_thermal_chip sun8i_h3_ths =
=3D {
> >  };
> >
> >  static const struct ths_thermal_chip sun8i_r40_ths =3D {
> > -       .sensor_num =3D 3,
> > +       .sensor_num =3D 2,
> >         .offset =3D 251086,
> >         .scale =3D 1130,
> >         .has_mod_clk =3D true,
> > --
> > 2.17.1
> >
