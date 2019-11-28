Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 717BA10CB88
	for <lists+linux-pm@lfdr.de>; Thu, 28 Nov 2019 16:16:26 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726510AbfK1PQZ (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Thu, 28 Nov 2019 10:16:25 -0500
Received: from mail-io1-f67.google.com ([209.85.166.67]:40985 "EHLO
        mail-io1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726436AbfK1PQZ (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Thu, 28 Nov 2019 10:16:25 -0500
Received: by mail-io1-f67.google.com with SMTP id z26so25792708iot.8;
        Thu, 28 Nov 2019 07:16:24 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :content-transfer-encoding;
        bh=H82IbOS8sPZjWpvcnPcR/AqjGK/fOT5IpCUad40HLpM=;
        b=jFkLPx4spUlCQAlkElZdAN/usQOw62IzHHY17uPCjEjiRvR3Ew45iJgdOCGgFJuwmy
         tc12rUtvLAumuNtQfgak+gNrU305RyPV5nNUoT7QrbOIGfyQxxTAzCOygwOCq+tAh+ut
         gDYAhBoodWSub2YT9kgAcE2MXrqf3mafeVeP7law170kSB+R2bPCvMPy/KdmD7H4py9Y
         58eIDioECiAEQhzC6sz6ulocyOC0AemYsJeEW2gHOb1tyJeW8BEgoats+Zow/OmWwL3Y
         nmjee7/mEWcF4WVsGKv5WhR3/6hhUMbmwgH9E4SxczUzaZ2T77SCid6X3ymEkwvqzy9M
         elhg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:content-transfer-encoding;
        bh=H82IbOS8sPZjWpvcnPcR/AqjGK/fOT5IpCUad40HLpM=;
        b=K3c9GUrxd4BwJPm5uY7GCjTH+dEFA1XskObUrqalN3d30uPsC9C9EFc1eQGnZUNdt4
         m/LpOMeeuSGYUY0h4r6QJaOjA8dy+hT6ndZX3Gn+BF7/9sAWXDUkXKdGbMCBOOw+1pwL
         lwdArvc3YqXiWI8yaw02OyzvluUm43/2S/eIMpPmjkOo/AX8W0g85wQgO6qPlDu7wGO2
         F37Fdm5wG8FhRMsDEJK0JqhV6Xy0ho26Ufw//Vx1LUdpGa+v9EydN9px7/b8XdQK8Y4P
         +nBWLOPllESKzkg7f9t9H41DVyJ0HVTFpGRfMseWTAWsMtpre77su/fYGDkAFaX5m374
         Ygcw==
X-Gm-Message-State: APjAAAX2nRopO+Glk57paAMB+pv0plZkJaE+Uw3mXrC/vr2kU5t49XJ4
        gX2E3487B9TSIta57YWqavHFqVmoFALPNI+S24E=
X-Google-Smtp-Source: APXvYqz8GjuY8urNYBmxma4DGx0mSieCqXdt1pzHdh1zCUnKUm27LXPBe0Rh4lFT2Z8hUrQH687ozEQJIC7EOhS+L8c=
X-Received: by 2002:a5d:9f05:: with SMTP id q5mr40915527iot.295.1574954183712;
 Thu, 28 Nov 2019 07:16:23 -0800 (PST)
MIME-Version: 1.0
References: <20191127052935.1719897-1-anarsoul@gmail.com> <20191127052935.1719897-2-anarsoul@gmail.com>
 <20191127111419.z5hfu5soxceiivg6@core.my.home> <20191127173547.ch3pcv3lxgdcrfnu@gilmour.lan>
 <CAEExFWvG-Af4qtUrxQV4ssNQCVQAmpXfxB+92wX+6ZxUNfX-Jw@mail.gmail.com>
 <CA+E=qVcdwQO3Y8ismmBN-gRVNMs1Thx+TPLqstKM9fYf2_0qFQ@mail.gmail.com> <20191127222427.coyeggbxs5miioxn@core.my.home>
In-Reply-To: <20191127222427.coyeggbxs5miioxn@core.my.home>
From:   Frank Lee <tiny.windzz@gmail.com>
Date:   Thu, 28 Nov 2019 23:16:05 +0800
Message-ID: <CAEExFWtBifY-1O0wBzk7ft8C9fxSUUx_cCJAribdP8dE9cteUg@mail.gmail.com>
Subject: Re: [PATCH v6 1/7] thermal: sun8i: add thermal driver for H6/H5/H3/A64/A83T/R40
To:     Vasily Khoruzhick <anarsoul@gmail.com>,
        Frank Lee <tiny.windzz@gmail.com>,
        Mark Rutland <mark.rutland@arm.com>,
        devicetree <devicetree@vger.kernel.org>,
        Amit Kucheria <amit.kucheria@verdurent.com>,
        Linux PM <linux-pm@vger.kernel.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Daniel Lezcano <daniel.lezcano@linaro.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Maxime Ripard <mripard@kernel.org>,
        Eduardo Valentin <edubezval@gmail.com>,
        Chen-Yu Tsai <wens@csie.org>, Rob Herring <robh+dt@kernel.org>,
        Mauro Carvalho Chehab <mchehab+samsung@kernel.org>,
        Zhang Rui <rui.zhang@intel.com>,
        "David S. Miller" <davem@davemloft.net>,
        Linux ARM <linux-arm-kernel@lists.infradead.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

On Thu, Nov 28, 2019 at 6:24 AM Ond=C5=99ej Jirman <megous@megous.com> wrot=
e:
>
> On Wed, Nov 27, 2019 at 11:48:32AM -0800, Vasily Khoruzhick wrote:
> > On Wed, Nov 27, 2019 at 11:44 AM Frank Lee <tiny.windzz@gmail.com> wrot=
e:
> > >
> > > Hello Vasily,
> > >
> > > Thank you very much for your work on this.
> > > This looks good to me.
> >
> > Thanks!
> >
> > > By the way, I would like to ask comments about adding the following c=
ode.
> >
> > Can we add it as follow up patch? I don't think that I have a device
> > with working suspend to test it and I'm hesitant to add any code that
> > I can't test.
>
> I have, but it doesn't use any of the clocks and resets, so it wouldn't
> test this fully, and basicaly doesn't need re-calibration at all, probabl=
y.
>
> So that may be one feedback. On a83t, I'd made these callbacks a no-op.

This is just that the mainline code does not yet have the S2RAM code
implementation of these SOCs.
Each module has its own suspend function and resume function as part
of the system suspend function.
When the system is in S2RAM, the entire SOC will be completely powered
off, and each module
needs to save and restore its own state.

Yangtao

>
> regards,
>         o.
>
> > >
> > > diff --git a/drivers/thermal/sun8i_thermal.c b/drivers/thermal/sun8i_=
thermal.c
> > > index c0ed60782b11..579dde5e0701 100644
> > > --- a/drivers/thermal/sun8i_thermal.c
> > > +++ b/drivers/thermal/sun8i_thermal.c
> > > @@ -629,11 +629,63 @@ static const struct of_device_id of_ths_match[]=
 =3D {
> > >  };
> > >  MODULE_DEVICE_TABLE(of, of_ths_match);
> > >
> > > +static int __maybe_unused sun8i_thermal_suspend(struct device *dev)
> > > +{
> > > + struct ths_device *tmdev; =3D dev_get_drvdata(dev);
> > > +
> > > + clk_disable(tmdev->mod_clk);
> > > + clk_disable(tmdev->bus_clk);
> > > +
> > > + reset_control_assert(tmdev->reset);
> > > +
> > > + return 0;
> > > +}
> > > +
> > > +static int __maybe_unused sun8i_thermal_resume(struct device *dev)
> > > +{
> > > + struct ths_device *tmdev; =3D dev_get_drvdata(dev);
> > > + int error;
> > > +
> > > + error =3D reset_control_deassert(tmdev->reset);
> > > + if (error)
> > > + return error;
> > > +
> > > + error =3D clk_enable(tmdev->bus_clk);
> > > + if (error)
> > > + goto assert_reset;
> > > +
> > > + clk_set_rate(tmdev->mod_clk, 24000000);
> > > + error =3D clk_enable(tmdev->mod_clk);
> > > + if (error)
> > > + goto bus_disable;
> > > +
> > > + sun8i_ths_calibrate(tmdev);
> > > +
> > > + ret =3D tmdev->chip->init(tmdev);
> > > + if (ret)
> > > + goto mod_disable;
> > > +
> > > + return 0;
> > > +
> > > +mod_disable:
> > > + clk_disable(tmdev->mod_clk);
> > > +bus_disable:
> > > + clk_disable(tmdev->bus_clk);
> > > +assert_reset:
> > > + reset_control_assert(tmdev->reset);
> > > +
> > > + return 0;
> > > +}
> > > +
> > > +static SIMPLE_DEV_PM_OPS(sun8i_thermal_pm_ops,
> > > + sun8i_thermal_suspend, sun8i_thermal_resume);
> > > +
> > >  static struct platform_driver ths_driver =3D {
> > >   .probe =3D sun8i_ths_probe,
> > >   .remove =3D sun8i_ths_remove,
> > >   .driver =3D {
> > >   .name =3D "sun8i-thermal",
> > > + .pm =3D &sun8i_thermal_pm_ops,
> > >   .of_match_table =3D of_ths_match,
> > >   },
> > >  };
> > >
> > > Yangtao
> >
> > _______________________________________________
> > linux-arm-kernel mailing list
> > linux-arm-kernel@lists.infradead.org
> > http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
