Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 8C1EB83B1F
	for <lists+linux-pm@lfdr.de>; Tue,  6 Aug 2019 23:32:41 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726238AbfHFVcl (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Tue, 6 Aug 2019 17:32:41 -0400
Received: from mail-oi1-f195.google.com ([209.85.167.195]:36349 "EHLO
        mail-oi1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725974AbfHFVck (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Tue, 6 Aug 2019 17:32:40 -0400
Received: by mail-oi1-f195.google.com with SMTP id c15so13424236oic.3;
        Tue, 06 Aug 2019 14:32:40 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=Ef8vY14IPg+ARIOj2VrrOApE5VT46udp6YkWmmIY8Ms=;
        b=C9tpcqn2Gg1FkvdmKFSoHZzZpu7xwyVY7lSOlgHozEIMXdpQGdGjlFZGhNTo//CHGA
         z0f0OyVtxGZwCgGGqEoT18sEkm7LGTENIZT1LAQv4vfJ7JSwSo9E6RQQ1MKfqBs93EMn
         g5a4SyThQ8EI9MEW8/Jt8qlcmlCrqEGnTUtrjCbzBwrN5nbvMh6Lpimd4h/kuGPYn4S8
         MItErD+nfNesXZG+uUt4+82N6BHomyH0SloZH2cXNYZMnbbxKZYqMB8ty8dvakV4WOwm
         4Bu2U/9jZ3mq/uVfhKl/XEsRIlrbVzO667+PiDpVWfxAcckczXaoxo2icywo+divFWLy
         J9sw==
X-Gm-Message-State: APjAAAWOvh9d7SKKkN5v2Np35ZG534woE8xnhYbEDoDa2lqbAAuHy2+5
        dXIV0iJRZn4FaguH5zRAriNSmjUcuXvNf03RuHg=
X-Google-Smtp-Source: APXvYqz5InPmzAE9CcFUiwV8OQSK3Rfqze+93pwnQo2dyWs4n8mTKQoIhMVewx9cL+IVA1slbun5a7mS7PvjzPnLM8g=
X-Received: by 2002:aca:cdd3:: with SMTP id d202mr3451399oig.115.1565127159601;
 Tue, 06 Aug 2019 14:32:39 -0700 (PDT)
MIME-Version: 1.0
References: <20190805175848.163558-1-trong@android.com> <20190805175848.163558-4-trong@android.com>
 <5d48bbc2.1c69fb81.62114.5473@mx.google.com> <CANA+-vBFY_mVfhhK=5BL5m_yyQ5+GTE9bv32fk-qsfnAmfE4nA@mail.gmail.com>
In-Reply-To: <CANA+-vBFY_mVfhhK=5BL5m_yyQ5+GTE9bv32fk-qsfnAmfE4nA@mail.gmail.com>
From:   "Rafael J. Wysocki" <rafael@kernel.org>
Date:   Tue, 6 Aug 2019 23:32:27 +0200
Message-ID: <CAJZ5v0ijZdTPi3dFrqcGwPo-gmCEOmjnShv=fLBW9L_8vDNuZQ@mail.gmail.com>
Subject: Re: [PATCH v7 3/3] PM / wakeup: Show wakeup sources stats in sysfs
To:     Tri Vo <trong@android.com>
Cc:     Stephen Boyd <swboyd@chromium.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        "Rafael J. Wysocki" <rjw@rjwysocki.net>,
        Viresh Kumar <viresh.kumar@linaro.org>,
        "Rafael J. Wysocki" <rafael@kernel.org>,
        Hridya Valsaraju <hridya@google.com>,
        Sandeep Patil <sspatil@google.com>,
        Kalesh Singh <kaleshsingh@google.com>,
        Ravi Chandra Sadineni <ravisadineni@chromium.org>,
        LKML <linux-kernel@vger.kernel.org>,
        Linux PM <linux-pm@vger.kernel.org>,
        "Cc: Android Kernel" <kernel-team@android.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

On Tue, Aug 6, 2019 at 8:51 PM Tri Vo <trong@android.com> wrote:
>
> On Mon, Aug 5, 2019 at 4:29 PM Stephen Boyd <swboyd@chromium.org> wrote:
> >
> > Quoting Tri Vo (2019-08-05 10:58:48)
> > > diff --git a/drivers/base/power/wakeup_stats.c b/drivers/base/power/wakeup_stats.c
> > > new file mode 100644
> > > index 000000000000..3a4f55028e27
> > > --- /dev/null
> > > +++ b/drivers/base/power/wakeup_stats.c
> > > @@ -0,0 +1,161 @@
> > [...]
> > > +/**
> > > + * wakeup_source_sysfs_add - Add wakeup_source attributes to sysfs.
> > > + * @parent: Device given wakeup source is associated with (or NULL if virtual).
> > > + * @ws: Wakeup source to be added in sysfs.
> > > + */
> > > +int wakeup_source_sysfs_add(struct device *parent, struct wakeup_source *ws)
> > > +{
> > > +       struct device *dev;
> > > +
> > > +       dev = device_create_with_groups(wakeup_class, parent, MKDEV(0, 0), ws,
> > > +                                       wakeup_source_groups, "wakeup%d",
> > > +                                       ws->id);
> > > +       if (IS_ERR(dev))
> > > +               return PTR_ERR(dev);
> > > +       ws->dev = dev;
> > > +       pm_runtime_no_callbacks(ws->dev);
> >
> > Does this only avoid adding runtime PM attributes?
> >
> > I thought we would call device_set_pm_not_required() on the device here.
> > Probably requiring a bit of copy/paste from device_create_with_groups()
> > so that it can be set before the device is registered. Or another
> > version of device_create_with_groups() that does everything besides call
> > device_add().
>
> Comments on pm_runtime_no_callbacks() say,
>   "Set the power.no_callbacks flag, which tells the PM core that this
>    device is power-managed through its parent and has no runtime PM
>    callbacks of its own.  The runtime sysfs attributes will be removed."
>
> Sound like it's appropriate to apply this function to the wakeup source.

This is only useful if you ever enable PM-runtime for this device.
Which you won't do.

You could use device_set_pm_not_required(), though.
