Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 76E8FED8F6
	for <lists+linux-pm@lfdr.de>; Mon,  4 Nov 2019 07:27:09 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727904AbfKDG1I (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Mon, 4 Nov 2019 01:27:08 -0500
Received: from mail-vs1-f67.google.com ([209.85.217.67]:46492 "EHLO
        mail-vs1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727877AbfKDG1H (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Mon, 4 Nov 2019 01:27:07 -0500
Received: by mail-vs1-f67.google.com with SMTP id m6so3745434vsn.13
        for <linux-pm@vger.kernel.org>; Sun, 03 Nov 2019 22:27:07 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=wqmK0R/0iLhz2cS78wooYNkQbrX2EenO+h2mxgeYTQw=;
        b=TbpmXP1qjXkjZaAV0UBIMkZZtNEYOnWQNio6/Ktez0ZA2Q26UxZCz30s1kcAOTJbEp
         +R07AyvDuFEPqPlrKD/llfcLdjvIaCu9Wim4Xk94c2LhvmScn6aNUX7cjK/0U3ulbf39
         8DPBIr6StT/Mb4Lwlege9TnktUdDRFPmOhHQZGWfoCc0WpIumylEqZh6E/iTmrAWrTc5
         9aijbfTYKUsyWqJmFt1gqTdxrgL+S3PfjXiCfxGk/6/tQtFxC8vvU4/KXR5M6UXlH/5K
         E2CeCO4dMVz063/A6VFr0uP+FI/xU3r5KYZpHRP86MolUAgdjo/9/5t2WiLh8wlEFq/K
         pQew==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=wqmK0R/0iLhz2cS78wooYNkQbrX2EenO+h2mxgeYTQw=;
        b=AeTt11PXRrnxf7+Gqgr0SlYaNr31Snm1emEyaZus3SanRDdZpHsyaA/DPW7PTkhFIk
         jnLOla4koTGithohs6Qofyto2uqz9cqECNj9dmORmCatRn04gJoGfnTDzFCVqsFCU6ol
         aun+YS3tHnwsK1CnVEvOpa+lprvTfDBfHTNbqU6vryM/gTx/jgtcXD+xvQznmbKv+VDO
         4AaOgkBzn4w/4pLEuh+AS/s+6uCZHiWS9TR6i4lCazo+dQbxREGG7x+kpvWAXGtH2+zb
         KoTzGMdClIVsKAI+FjhjWKzXMa7JJ3IL0CGzfXwrtWMnevci5IWo+pfaMWqCMR66N75L
         mVzw==
X-Gm-Message-State: APjAAAVH32pwzbXb5nbGJ6yekUcLswhGif73OMFIGuRs7Z3xh/c0GMqV
        6i/kmzCaMbLnkPnYeyr8jJq57badwLHi9ml5FWdiok4Z1OA=
X-Google-Smtp-Source: APXvYqxm9P3/wRVKysMgfsfmktDKRSe2qMyyOukFvOrEe5wCvLbSQ48XlGOq6djDHAbrCrxZc/nNP4KSzRwv7oNDLhs=
X-Received: by 2002:a67:edce:: with SMTP id e14mr11995221vsp.182.1572848826271;
 Sun, 03 Nov 2019 22:27:06 -0800 (PST)
MIME-Version: 1.0
References: <cover.1571181041.git.amit.kucheria@linaro.org>
 <1b53ef537203e629328285b4597a09e4a586d688.1571181041.git.amit.kucheria@linaro.org>
 <ed9ef9e3-a8c3-90bf-4e71-8959b2ff94d2@linaro.org>
In-Reply-To: <ed9ef9e3-a8c3-90bf-4e71-8959b2ff94d2@linaro.org>
From:   Amit Kucheria <amit.kucheria@linaro.org>
Date:   Mon, 4 Nov 2019 11:56:55 +0530
Message-ID: <CAHLCerO49=iensdHC=dP-y0Pk_24AYEO53Zw=K5OjtNhmOyUpA@mail.gmail.com>
Subject: Re: [PATCH] of-thermal: Disable polling when interrupt property is
 found in DT
To:     Daniel Lezcano <daniel.lezcano@linaro.org>
Cc:     LKML <linux-kernel@vger.kernel.org>,
        linux-arm-msm <linux-arm-msm@vger.kernel.org>,
        Stephen Boyd <swboyd@chromium.org>,
        Zhang Rui <rui.zhang@intel.com>,
        Eduardo Valentin <edubezval@gmail.com>,
        Linux PM list <linux-pm@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

On Wed, Oct 30, 2019 at 12:21 PM Daniel Lezcano
<daniel.lezcano@linaro.org> wrote:
>
> On 16/10/2019 01:13, Amit Kucheria wrote:
> > Currently, in order to enable interrupt-only mode, one must set
> > polling-delay-passive and polling-delay properties in the DT to 0,
> > otherwise the thermal framework will continue to setup a periodic timers
> > to monitor the thermal zones.
> >
> > Change the behaviour, so that on DT-based systems, we no longer have to
> > set the properties to zero if we find an 'interrupt' property in the
> > sensor.
> >
> > Following data shows the number of times
> > thermal_zone_device_set_polling() is invoked with and without this
> > patch. So the patch achieves the same behaviour as setting the delay
> > properties to 0.
> >
> > Current behaviour (without setting delay properties to 0):
> >   FUNC                              COUNT
> >   thermal_zone_device_update          302
> >   thermal_zone_device_set_pollin     7911
> >
> > Current behaviour (with delay properties set to 0):
> >   FUNC                              COUNT
> >   thermal_zone_device_update            3
> >   thermal_zone_device_set_pollin        6
> >
> > With this patch (without setting delay properties to 0):
> >   FUNC                              COUNT
> >   thermal_zone_device_update            3
> >   thermal_zone_device_set_pollin        6
> >
> > Suggested-by: Stephen Boyd <swboyd@chromium.org>
> > Signed-off-by: Amit Kucheria <amit.kucheria@linaro.org>
> > ---
> >  drivers/thermal/of-thermal.c | 15 +++++++++++++--
> >  1 file changed, 13 insertions(+), 2 deletions(-)
> >
> > diff --git a/drivers/thermal/of-thermal.c b/drivers/thermal/of-thermal.c
> > index dc5093be553e..79ad587462b1 100644
> > --- a/drivers/thermal/of-thermal.c
> > +++ b/drivers/thermal/of-thermal.c
> > @@ -412,7 +412,8 @@ static struct thermal_zone_device_ops of_thermal_ops = {
> >  static struct thermal_zone_device *
> >  thermal_zone_of_add_sensor(struct device_node *zone,
> >                          struct device_node *sensor, void *data,
> > -                        const struct thermal_zone_of_device_ops *ops)
> > +                        const struct thermal_zone_of_device_ops *ops,
> > +                        bool force_interrupts)
> >  {
> >       struct thermal_zone_device *tzd;
> >       struct __thermal_zone *tz;
> > @@ -433,6 +434,11 @@ thermal_zone_of_add_sensor(struct device_node *zone,
> >       tzd->ops->get_temp = of_thermal_get_temp;
> >       tzd->ops->get_trend = of_thermal_get_trend;
> >
> > +     if (force_interrupts) {
> > +             tz->passive_delay = 0;
> > +             tz->polling_delay = 0;
> > +     }
> > +
> >       /*
> >        * The thermal zone core will calculate the window if they have set the
> >        * optional set_trips pointer.
> > @@ -486,6 +492,7 @@ thermal_zone_of_sensor_register(struct device *dev, int sensor_id, void *data,
> >  {
> >       struct device_node *np, *child, *sensor_np;
> >       struct thermal_zone_device *tzd = ERR_PTR(-ENODEV);
> > +     bool force_interrupts = false;
> >
> >       np = of_find_node_by_name(NULL, "thermal-zones");
> >       if (!np)
> > @@ -498,6 +505,9 @@ thermal_zone_of_sensor_register(struct device *dev, int sensor_id, void *data,
> >
> >       sensor_np = of_node_get(dev->of_node);
> >
> > +     if (of_find_property(sensor_np, "interrupts", NULL))
> > +             force_interrupts = true;
> > +
>
> This is hackish. It does cover only DT drivers.

OK.

> It would be cleaner to add a specific flag describing the thermal sensor
> driver mode and then in the core code do not start the timers if the
> associated works in interrupt.
>
> Moreover the interrupt mode can be used to activate faster the passive
> delay monitoring after reaching a threshold like the hikey and hikey960.
> So this patch will disable the mitigation on those boards. This is
> another argument to add flags for the thermal sensor mode.
>

So each driver then needs to set this flag at interrupt registration
time. Or do you want to set that automatically in core code with some
wrapper function?

Regards,
Amit
