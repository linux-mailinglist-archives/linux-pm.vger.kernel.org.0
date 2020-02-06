Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id C3AD1154C3C
	for <lists+linux-pm@lfdr.de>; Thu,  6 Feb 2020 20:27:07 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727957AbgBFT0z (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Thu, 6 Feb 2020 14:26:55 -0500
Received: from mail-vs1-f66.google.com ([209.85.217.66]:39577 "EHLO
        mail-vs1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727836AbgBFT0z (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Thu, 6 Feb 2020 14:26:55 -0500
Received: by mail-vs1-f66.google.com with SMTP id p14so4547729vsq.6
        for <linux-pm@vger.kernel.org>; Thu, 06 Feb 2020 11:26:53 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=verdurent-com.20150623.gappssmtp.com; s=20150623;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :content-transfer-encoding;
        bh=S7KpLMUY7LiWZq/Kj/eAi+yNVL0NiKccJvwviJrN6LU=;
        b=Tv8MZfQyvsljJl/L3IaZhjvF0zhvW7SGNWz006rU+AEOnWunbxolvEn+ld89B6WyJW
         yn7gHQ2DktgOFMcX/tw2hqsr4MwhiimED2xSWJRNi0Apz814aNulaQTHc9vuGeK9IDNT
         It5U1ReUUYb4xFG50FuVrDTevCZD9OT1L6gMNuK6aOR8E6g97ydSvQuyTUAWyDPrMdh6
         vnjEkFc16T2U61hgk19+NgLZQA6IzseSsUaAl2CKt1oSsru/HYy478Lyv/RNrNgsMfJg
         E34mx0+Ekt0XJqgazqxe82zwubl03+fz1uevMPW37HhjqMn6CPFGAdE0XsKrux2KOFyn
         AYyw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:content-transfer-encoding;
        bh=S7KpLMUY7LiWZq/Kj/eAi+yNVL0NiKccJvwviJrN6LU=;
        b=S6cvpbr/BL+fNEU7YQ7AgKSnP3ik+zPP5Imvr/aMvev5fxDdvkmScd8FeJPqaFLl3D
         11oB9BJWq1Asu3U0IH8o9NV/O1UFlAwfrgLZ0txUVGr1OFiMsVfmY95iqLZM67po8YA4
         NobHXvxvxfJFZDdGppRmxeiPerWlREGCloce8jaOxzOycnuVyvt3wFAIy+19sGrmaDMF
         O/RStnPgNM6E5ozJCOjjuY8mEOBB7Nt4wVMphOMDdaQNG7Lm7TA8G4Dem2jwyekVnWYd
         NrNv/cRqx6NWTG1GqizPizHlQfl6t1rmR5xgxuoV4vQJ6hzFkDlYdm03cBbEDAbT2yE2
         TFGw==
X-Gm-Message-State: APjAAAVBIV/3A+vtgoDCNC7FYJkNQ2rJpRIJ7RRBWf4ckb1TkZHDi0bm
        1a1A35O5a2muHz6VPqWV0GtHDeyGboe31n+RaC4f1g==
X-Google-Smtp-Source: APXvYqwoojhOiE1bY8Keza3r5GUPbzrgIujBGiCbM5sfzEmHarjYTwY433tNBdAO58ymcgqBI0TN5G4Kv1fiGkD0b+o=
X-Received: by 2002:a67:d011:: with SMTP id r17mr2575599vsi.159.1581017212681;
 Thu, 06 Feb 2020 11:26:52 -0800 (PST)
MIME-Version: 1.0
References: <20191219172823.1652600-1-anarsoul@gmail.com> <CAHLCerPWEDqEE8LRUiO5GpeP+BfnestocndBQq6oXAxVN=+3ow@mail.gmail.com>
 <20200206155703.fyry7nh473mc7pqy@core.my.home>
In-Reply-To: <20200206155703.fyry7nh473mc7pqy@core.my.home>
From:   Amit Kucheria <amit.kucheria@verdurent.com>
Date:   Fri, 7 Feb 2020 00:56:41 +0530
Message-ID: <CAHLCerMLFYRNUfPAzbUTZkn33P7LG5PtHMNiSJ2GMCoJ=0k74w@mail.gmail.com>
Subject: Re: [PATCH v8 0/7] add thermal sensor driver for A64, A83T, H3, H5,
 H6, R40
To:     Amit Kucheria <amit.kucheria@verdurent.com>,
        Vasily Khoruzhick <anarsoul@gmail.com>,
        Yangtao Li <tiny.windzz@gmail.com>,
        Zhang Rui <rui.zhang@intel.com>,
        Daniel Lezcano <daniel.lezcano@linaro.org>,
        Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Maxime Ripard <mripard@kernel.org>,
        Chen-Yu Tsai <wens@csie.org>,
        Mauro Carvalho Chehab <mchehab+samsung@kernel.org>,
        "David S. Miller" <davem@davemloft.net>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Linux PM list <linux-pm@vger.kernel.org>,
        "open list:OPEN FIRMWARE AND FLATTENED DEVICE TREE BINDINGS" 
        <devicetree@vger.kernel.org>,
        lakml <linux-arm-kernel@lists.infradead.org>,
        LKML <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

On Thu, Feb 6, 2020 at 9:27 PM Ond=C5=99ej Jirman <megous@megous.com> wrote=
:
>
> Hi Amit,
>
> On Thu, Feb 06, 2020 at 07:43:59PM +0530, Amit Kucheria wrote:
> > Hi Vasily,
> >
> > For this entire series, the DTS files don't contain any trip points.
> > Did I miss some other series?
> >
> > At a minimum, you should add some "hot" or "critical" trip points
> > since then don't require a cooling-map with throttling actions. If you
> > have "passive" trip points, then you need to provide cooling-maps.
> >
> > Since this series has been merged, could you please follow up with a
> > fixup series to add the trip points?
>
> I don't think lack of trip points causes runtime issues. Or does it? I pl=
anned
> to send update with some trip points and cooling maps for 5.7 merge windo=
w.
> Is this acceptable?

Yes, I think that would be fine.

> If not, I can send a patch that adds:
>
> + trips {
> +         cpu-very-hot {
> +                 temperature =3D <100000>;
> +                 hysteresis =3D <0>;
> +                 type =3D "critical";
> +         };
> + };
>
> and
>
> + trips {
> +         gpu-very-hot {
> +                 temperature =3D <100000>;
> +                 hysteresis =3D <0>;
> +                 type =3D "critical";
> +         };
> + };
>
> everywhere where appropriate. Though that will make rebase of out of
> tree patches that already have a more complicated setup to be sent for th=
e next
> merge window a bit tedious.

Right, don't do that.

> thank you,
>         Ondrej
>
> > Regards,
> > Amit
> > p.s. We should catch all this automatically, I'll send out yaml
> > bindings for the thermal framework soon that should catch this stuff.
