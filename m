Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id A385A5D309
	for <lists+linux-pm@lfdr.de>; Tue,  2 Jul 2019 17:38:33 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725972AbfGBPi2 (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Tue, 2 Jul 2019 11:38:28 -0400
Received: from mail-ed1-f67.google.com ([209.85.208.67]:43017 "EHLO
        mail-ed1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725868AbfGBPi2 (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Tue, 2 Jul 2019 11:38:28 -0400
Received: by mail-ed1-f67.google.com with SMTP id e3so27692404edr.10;
        Tue, 02 Jul 2019 08:38:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=TWubX7gb8wzCXB97yIF4ujxmq9TcuIBsDJIQkj+roIY=;
        b=kqNBi4Jlai04eQccmfQxO0jgv5VB9kGsaFnDKoxx9oi1eKXC6Zr3LQWADziFmQezHN
         6hnfWNHwwTRcL92TBaWkty/nH86vvjO0vPf1sJp+arA12LbiCRS8CnETEuf7NcTRoxET
         Hw40+qTzurD/DADJElv2sCRGLaLc3xfO1mAsuHz5CCNcvbd5e30TA7Y+zx2Dm8z0T3rN
         o6g72cP4URW9R7KXQDMBj+DTdB9kVTh6NnkxoDaNZX4yXIDG6uUmv4Q9LdJYKqyf+P8g
         Y+VgjMMyLmYhhxL2CzD6Epnh6/IYaPLIuDbOaU+gsJN6Fh2CcYcxtjV7X4NHhpCjcm1j
         I9sg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=TWubX7gb8wzCXB97yIF4ujxmq9TcuIBsDJIQkj+roIY=;
        b=EpVq1boUMUNk2FJZcPeo/IURjSc3KVLenSFihP9/JHpnxSHAPgbWpCH8TbC07b35Vj
         nc6Kwo1+TSD+Y7m2CEif5MT6DN0XW/wJ8mtNh/Edz9JQVRAZ8uZmUSAtCDJdBJhXVdpC
         vN+nc4ChylEEzJ+9AEXudabEeOFWmFYasF4vUIpR1QGFdBsJmuEqFh3P2ckK8atluDEQ
         sItGNymUgrNjJHli0bDlcTqY7vTAZy7CWuUECDzP5k6IDmsDl9RYcEwur3kxbH3QZKmT
         804oABGNO0f97Y0GDWeDcZxChgiEDKHrSZvrp8KbpBw1Qzy8WTHTeP+xokO6g7jVi2gl
         ZaAw==
X-Gm-Message-State: APjAAAUH3Wh6Ip2b7+s1GXkluw8T8/F2cZRHRfixu698SDT2SHw+a1sx
        zROb+5thkfzYHwBpsCOPkHb9U/Ol6edWnIZAu+Y=
X-Google-Smtp-Source: APXvYqyktHKWgvN0S6LNY7pdMrXxHx5O9m+Yl5fFofqt5yp4IGh6UcYOfgL9RRiuXiNgRlMvI0lYG9OboxCExD3ySLw=
X-Received: by 2002:aa7:d888:: with SMTP id u8mr36260345edq.264.1562081905533;
 Tue, 02 Jul 2019 08:38:25 -0700 (PDT)
MIME-Version: 1.0
References: <20190630150230.7878-1-robdclark@gmail.com> <20190630150230.7878-6-robdclark@gmail.com>
 <20190702152011.GE5033@pendragon.ideasonboard.com>
In-Reply-To: <20190702152011.GE5033@pendragon.ideasonboard.com>
From:   Rob Clark <robdclark@gmail.com>
Date:   Tue, 2 Jul 2019 08:38:09 -0700
Message-ID: <CAF6AEGtBk_6kcKyw9HMVGnXm-vvAeR0LXVQXN7FFOACoS158Zg@mail.gmail.com>
Subject: Re: [PATCH 5/5] drm/bridge: ti-sn65dsi86: support booloader enabled display
To:     Laurent Pinchart <laurent.pinchart@ideasonboard.com>
Cc:     dri-devel <dri-devel@lists.freedesktop.org>,
        linux-arm-msm <linux-arm-msm@vger.kernel.org>,
        freedreno <freedreno@lists.freedesktop.org>,
        aarch64-laptops@lists.linaro.org,
        linux-clk <linux-clk@vger.kernel.org>,
        Linux PM <linux-pm@vger.kernel.org>,
        Rob Clark <robdclark@chromium.org>,
        Andrzej Hajda <a.hajda@samsung.com>,
        David Airlie <airlied@linux.ie>,
        Daniel Vetter <daniel@ffwll.ch>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

On Tue, Jul 2, 2019 at 8:20 AM Laurent Pinchart
<laurent.pinchart@ideasonboard.com> wrote:
>
> Hi Rob,
>
> Thank you for the patch.
>
> On Sun, Jun 30, 2019 at 08:01:43AM -0700, Rob Clark wrote:
> > From: Rob Clark <robdclark@chromium.org>
> >
> > Request the enable gpio ASIS to avoid disabling bridge during probe, if
> > already enabled.  And if already enabled, defer enabling runpm until
> > attach to avoid cutting off the power to the bridge.
> >
> > Once we get to attach, we know panel and drm driver are probed
> > successfully, so at this point it i s safe to enable runpm and reset the
> > bridge.  If we do it earlier, we kill efifb (in the case that panel or
> > drm driver do not probe successfully, giving the user no way to see what
> > is going on.
> >
> > Signed-off-by: Rob Clark <robdclark@chromium.org>
> > ---
> >  drivers/gpu/drm/bridge/ti-sn65dsi86.c | 12 ++++++++++--
> >  1 file changed, 10 insertions(+), 2 deletions(-)
> >
> > diff --git a/drivers/gpu/drm/bridge/ti-sn65dsi86.c b/drivers/gpu/drm/bridge/ti-sn65dsi86.c
> > index 7a046bcdd81b..8bdc33576992 100644
> > --- a/drivers/gpu/drm/bridge/ti-sn65dsi86.c
> > +++ b/drivers/gpu/drm/bridge/ti-sn65dsi86.c
> > @@ -257,6 +257,12 @@ static int ti_sn_bridge_attach(struct drm_bridge *bridge)
> >                                                  .node = NULL,
> >                                                };
> >
> > +     if (gpiod_get_value(pdata->enable_gpio)) {
> > +             pm_runtime_enable(pdata->dev);
>
> Does this need to be balanced with a pm_runtime_disable() call ? Bridges
> can be attached and detached at runtime when reloading the display
> controller drivers, so you need to ensure that detach/re-attach cycles
> work.

It should only be a problem if things don't get shut down properly in
the detach/unload path.

> > +             ti_sn_bridge_resume(pdata->dev);
> > +             ti_sn_bridge_suspend(pdata->dev);
> > +     }
> > +
> >       ret = drm_connector_init(bridge->dev, &pdata->connector,
> >                                &ti_sn_bridge_connector_funcs,
> >                                DRM_MODE_CONNECTOR_eDP);
> > @@ -813,7 +819,7 @@ static int ti_sn_bridge_probe(struct i2c_client *client,
> >       dev_set_drvdata(&client->dev, pdata);
> >
> >       pdata->enable_gpio = devm_gpiod_get(pdata->dev, "enable",
> > -                                         GPIOD_OUT_LOW);
> > +                                         GPIOD_ASIS);
> >       if (IS_ERR(pdata->enable_gpio)) {
> >               DRM_ERROR("failed to get enable gpio from DT\n");
> >               ret = PTR_ERR(pdata->enable_gpio);
> > @@ -843,7 +849,9 @@ static int ti_sn_bridge_probe(struct i2c_client *client,
> >       if (ret)
> >               return ret;
> >
> > -     pm_runtime_enable(pdata->dev);
> > +     if (!gpiod_get_value(pdata->enable_gpio)) {
> > +             pm_runtime_enable(pdata->dev);
> > +     }
>
> If I understand the issue correctly, this is part of an effort to avoid
> disabling a potentially display output until we get as close as possible
> to display handover, right ? Is there a drawback in always enabling
> runtime PM when the bridge is attached instead of at probe time ? I
> think we need to come up with a set of rules for bridge driver authors,
> otherwise we'll end up with incompatible expectations of bridge drivers
> and display controller drivers.

That would simplify things slightly.. but perhaps w/ the slight
downside, if things booted with clk running or regulator enabled, but
the panel not actually enabled, then you wouldn't shut things down
until attach.

I'm also about to send a patch that adds debugfs to dump status
registers (and a related fix that I found from that).. which will need
to do a runpm get/put, and could potentially happen before attach (ie.
if bridge driver is probed but drm driver is not).

Maybe those are edge cases not worth worrying about.

I suppose also it is possible that some bridge driver would want to
read out a hw revision register in probe to see if it is a version of
hw that it supports.  But fortunately that is not a problem with this
particular bridge.

In the end, I suspect the first time you bring up some platform with
display running, you are going to have some patches spanning clk /
bridge / display / etc, no matter what we do ;-)

BR,
-R

> >
> >       i2c_set_clientdata(client, pdata);
> >
>
> --
> Regards,
>
> Laurent Pinchart
