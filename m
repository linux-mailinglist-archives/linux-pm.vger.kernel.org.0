Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3C3094FB9D3
	for <lists+linux-pm@lfdr.de>; Mon, 11 Apr 2022 12:36:56 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1345642AbiDKKid (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Mon, 11 Apr 2022 06:38:33 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40446 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1345629AbiDKKi3 (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Mon, 11 Apr 2022 06:38:29 -0400
Received: from mail-lj1-x236.google.com (mail-lj1-x236.google.com [IPv6:2a00:1450:4864:20::236])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0C43343AFC
        for <linux-pm@vger.kernel.org>; Mon, 11 Apr 2022 03:36:14 -0700 (PDT)
Received: by mail-lj1-x236.google.com with SMTP id b21so31053ljf.4
        for <linux-pm@vger.kernel.org>; Mon, 11 Apr 2022 03:36:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=lWbA8BxSlOYVP3LVwiIDtHxC35MchtX1bQhiwUUgIBM=;
        b=wQZ5G4wbP6asggk3xfZw8FnN5ffLC093ppWdL3I2U0Ii5eh+cP2bkUc5jPU/z/n8VP
         6fTLvwZu/vYB7UOXSZJipSL1SLu/3fP5wrA5YJQLwpIRaCL0ritC/xdeoKq6Jt8F1dix
         6t/H2rlxbAH0hAj+8GioML/2lI/jlw94KbL4csTtPG59Whl4ZFO0GnGjWDGBxtiMv2/N
         vpWW4Qy01T02tBh4jWiNanQKhMgnZ+IPhEKXUfwOvXQxF4m/I6yr0/rnV/w7n8szSz4u
         2PJnK185zzerZKxrK6on34Ww6HIEwIIMrdL9e2sMg10IbXiJlhLWVVM1qwtSH1HX5D2K
         q8jQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=lWbA8BxSlOYVP3LVwiIDtHxC35MchtX1bQhiwUUgIBM=;
        b=Ok6KX8MqncsG8thABVBxwvuqaUFBJoiQ6aur40f6bhTN/eT+7FpbviSNIfp+t+QPzY
         rAkfE1UVZS3+Hj3+SUzJERNb9eKvNL0aUxqW9eQ6DyqvAKsPUKUcZPH7sVd7TSGFR/uE
         6yluXNEWksJoceTvP2Wlh9NPva8EMdtpTAi2EI2XneI2qWF6AW1Fg/VEbp8Zyhz8E1B6
         9bRAPO6z7nq0hiGAUWfb2jn8OgH1bryg4qOFgMw+2pn3+QkN2UwyQEAYDSpWM9UUKht8
         mN2SvIaygoLXe8iYOstz4Hw6lZwcIvyq3cZAN8NAZoI7zB1Jlhj0aXByd/R2H1kIPIBV
         FMMQ==
X-Gm-Message-State: AOAM530LmV3bznnxp+CUivNSkGBV8jddwNN7itjp8B21yzQfz/JB63M/
        XyUF7RuEi9q1WyAkyx0sH9XebWoaZbQujCkEGpo6BQ==
X-Google-Smtp-Source: ABdhPJzMSB6szqj7+JrFClK5+oBXYA0BTO3VojX36KJWRQfEbbmK9WnDf60M+AqYlDUEuv1kX2aRaWUgyewAkiIWS94=
X-Received: by 2002:a2e:9048:0:b0:249:78bb:375e with SMTP id
 n8-20020a2e9048000000b0024978bb375emr20336046ljg.229.1649673372244; Mon, 11
 Apr 2022 03:36:12 -0700 (PDT)
MIME-Version: 1.0
References: <1836398.tdWV9SEqCh@kreacher> <CAPDyKFoop_mtWV0i+fH8GSmaxbPCyCPmOeNi6GuK5Qrj7ZVo1g@mail.gmail.com>
 <CAJZ5v0geG77Npdy_Ae7XnpWukPPSJ1nE0DFF-vbJViKj6GtCWA@mail.gmail.com>
In-Reply-To: <CAJZ5v0geG77Npdy_Ae7XnpWukPPSJ1nE0DFF-vbJViKj6GtCWA@mail.gmail.com>
From:   Ulf Hansson <ulf.hansson@linaro.org>
Date:   Mon, 11 Apr 2022 12:35:35 +0200
Message-ID: <CAPDyKFo9t__WV00yp5gt+M0BhYtgJU2HmKXF2fXEDtjvSEUhhw@mail.gmail.com>
Subject: Re: [PATCH v1] PM: runtime: Avoid device usage count underflows
To:     "Rafael J. Wysocki" <rafael@kernel.org>
Cc:     "Rafael J. Wysocki" <rjw@rjwysocki.net>,
        Linux PM <linux-pm@vger.kernel.org>,
        LKML <linux-kernel@vger.kernel.org>,
        Alan Stern <stern@rowland.harvard.edu>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

On Fri, 8 Apr 2022 at 19:05, Rafael J. Wysocki <rafael@kernel.org> wrote:
>
> On Fri, Apr 8, 2022 at 4:05 PM Ulf Hansson <ulf.hansson@linaro.org> wrote:
> >
> > On Wed, 6 Apr 2022 at 21:03, Rafael J. Wysocki <rjw@rjwysocki.net> wrote:
> > >
> > > From: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
> > >
> > > A PM-runtime device usage count underflow is potentially critical,
> > > because it may cause a device to be suspended when it is expected to
> > > be operational.
> >
> > I get the point. Although, perhaps we should also state that it's a
> > programming problem that we would like to catch and warn about?
>
> OK, I can add that to the changelog.
>
> > >
> > > For this reason, (1) make rpm_check_suspend_allowed() return an error
> > > when the device usage count is negative to prevent devices from being
> > > suspended in that case, (2) introduce rpm_drop_usage_count() that will
> > > detect device usage count underflows, warn about them and fix them up,
> > > and (3) use it to drop the usage count in a few places instead of
> > > atomic_dec_and_test().
> > >
> > > Signed-off-by: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
> > > ---
> > >  drivers/base/power/runtime.c |   44 ++++++++++++++++++++++++++++++++++++-------
> > >  1 file changed, 37 insertions(+), 7 deletions(-)
> > >
> > > Index: linux-pm/drivers/base/power/runtime.c
> > > ===================================================================
> > > --- linux-pm.orig/drivers/base/power/runtime.c
> > > +++ linux-pm/drivers/base/power/runtime.c
> > > @@ -263,7 +263,7 @@ static int rpm_check_suspend_allowed(str
> > >                 retval = -EINVAL;
> > >         else if (dev->power.disable_depth > 0)
> > >                 retval = -EACCES;
> > > -       else if (atomic_read(&dev->power.usage_count) > 0)
> > > +       else if (atomic_read(&dev->power.usage_count))
> > >                 retval = -EAGAIN;
> > >         else if (!dev->power.ignore_children &&
> > >                         atomic_read(&dev->power.child_count))
> > > @@ -1039,13 +1039,33 @@ int pm_schedule_suspend(struct device *d
> > >  }
> > >  EXPORT_SYMBOL_GPL(pm_schedule_suspend);
> > >
> > > +static int rpm_drop_usage_count(struct device *dev)
> > > +{
> > > +       int ret;
> > > +
> > > +       ret = atomic_sub_return(1, &dev->power.usage_count);
> > > +       if (ret >= 0)
> > > +               return ret;
> > > +
> > > +       /*
> > > +        * Because rpm_resume() does not check the usage counter, it will resume
> > > +        * the device even if the usage counter is 0 or negative, so it is
> > > +        * sufficient to increment the usage counter here to reverse the change
> > > +        * made above.
> > > +        */
> > > +       atomic_inc(&dev->power.usage_count);
> >
> > Rather than this two-step process, couldn't we just do an
> > "atomic_add_unless(&dev->power.usage_count, -1, 0)" - and check the
> > return value?
>
> No, we couldn't, because atomic_add_unless() returns a bool and we
> need to know the new counter value (and in particular whether or not
> it is 0).

atomic_add_unless(&dev->power.usage_count, -1, 0) would return true as
long as the counter value is greater than 0.

If the counter has become 0, atomic_add_unless() would return false
and not continue to decrease the value below zero. Isn't this exactly
what we want?

>
> I thought that it would be better to do the extra access in the
> failing case only.
>
> > > +       dev_warn(dev, "Runtime PM usage count underflow!\n");
> > > +       return -EINVAL;
> > > +}
> > > +
> >
> > [...]

Kind regards
Uffe
