Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 92DB743755C
	for <lists+linux-pm@lfdr.de>; Fri, 22 Oct 2021 12:19:05 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232527AbhJVKVR (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Fri, 22 Oct 2021 06:21:17 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54468 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232518AbhJVKVI (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Fri, 22 Oct 2021 06:21:08 -0400
Received: from mail-lf1-x12c.google.com (mail-lf1-x12c.google.com [IPv6:2a00:1450:4864:20::12c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CAB5DC061766
        for <linux-pm@vger.kernel.org>; Fri, 22 Oct 2021 03:18:50 -0700 (PDT)
Received: by mail-lf1-x12c.google.com with SMTP id bp15so1315992lfb.4
        for <linux-pm@vger.kernel.org>; Fri, 22 Oct 2021 03:18:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=9PwSiIQWLcfaolIdxvWwpR3c2+g9ZZvb4TeLeXAtp7I=;
        b=XlAoxvOju3kRrEbWVVrkeWXOZBnhXXzBoeAbtV9Om0vy1TUNyfyA3PzQ6slrVOLyTe
         vclPvp+LJLC4I7H7Cncz0mk63K0J8vLZV7r65bJHi36LPpBxazNGDINrWJLNGoHDNuKV
         aUC8TSui1v2agtVCH9opYzHAHdM2SeZ+CsFkyWYBL/MOnnf3pVqCx/ITnMyg7j6yDdzV
         hzcZMDdCIdct4sHD0tv2outF319Ecf7KN/4eDEN5f4wbxPzoQ+3pQ8yc+7nADySxfB+h
         97dwhOIhc1DVcK4IeZtIMnB/HDF+dyU9S1HrBTnnMrwGbFaLbRJwj670scjckB5TtRRm
         Rj5A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=9PwSiIQWLcfaolIdxvWwpR3c2+g9ZZvb4TeLeXAtp7I=;
        b=puM2+HQm/Q+PqWObE/9BmYQh7Kb/XdYmLsDiS+ICDAQfhoeMqT10Hdt9TqYaLD/jFp
         44a27YClFWuc4RDU10tGVzPGJJjVGytekAuOawS56K/koKDNBIrSouYKiEBNKrml1U3U
         eQJM/0CMmVRgXZUurvSqbP3BbETwjvpPbK6ihNpEEwWGdFvFLuDNZToFFmfK2IHDMgPz
         Z0csTGRAIU6dOQtyNWAq1BY+6znogMuWZhTyZxGLeqfC8bBc64siufqT4xD7oXXvQGqa
         JNOB0ywhfdm9B/K+kPo/F31/gX3gjYW04pp+NJPBBYPKs119QPi+olNqsQolV8Uc8wbE
         PCaw==
X-Gm-Message-State: AOAM530swpCPv9ZBwM/ANsolZ/j6WaPBUZNYYkGdA1dNdOCeFRz+F+wr
        BjUj7zCPi+eHPgxhtliuyRtl5+EorMtZMMdyERsX6Q==
X-Google-Smtp-Source: ABdhPJysn3JD674/zWO/LNI2vU1vTlPQmuFiPMqcYqWDwA8hH7SNawpJxyWdEdC5ydnl3NtqN7LuCIMoOEpN4F+3q/M=
X-Received: by 2002:a05:6512:4029:: with SMTP id br41mr11088973lfb.233.1634897929048;
 Fri, 22 Oct 2021 03:18:49 -0700 (PDT)
MIME-Version: 1.0
References: <20210929144451.113334-1-ulf.hansson@linaro.org>
 <20210929144451.113334-3-ulf.hansson@linaro.org> <CAJZ5v0hgdQeJ+6mLMLQcvnM_+EiyDBERj54aT2cL=HiTO9nMNQ@mail.gmail.com>
 <CAPDyKFpep3aPmGGo=aA5dHZZjb-O51et47C9_hgVbZbXMJZX_g@mail.gmail.com>
 <CAJZ5v0j=Fi5vOh45de-u7FwsCm4zsAsHepp16xQ3U5_WjrtWJw@mail.gmail.com>
 <CAPDyKFqeAFhgCFSaFAWnp5xorxSVwAL=z2g6vHJ0PWjtt9GDNg@mail.gmail.com>
 <CAJZ5v0iA4O=tx7qiLKCOze87dcUtwtDJqi2B+2O=oOyCSzgmtQ@mail.gmail.com>
 <CAPDyKFr_-ON1JWXe3W7DAXUzKdrceqXPwLAdHnKeXajy=pFnug@mail.gmail.com>
 <CAJZ5v0itweerfbq8NE9rEonZ2Nfu_nfKgERv2tweeLO4fgAgLg@mail.gmail.com>
 <CAPDyKFrOSd2xEXuvDki9Em+xFLHfeTfZz3NtnWwNmWB1H6i=Kg@mail.gmail.com>
 <CAJZ5v0j3a_m5T9nbxk4VSuABOq12JEC0fi=0SQ8+=Vwv-qDeOA@mail.gmail.com> <CAPDyKFpjy5sZo6ayqPx07Jzs4J2yePy=cZk=k6VjhWB7zGeedg@mail.gmail.com>
In-Reply-To: <CAPDyKFpjy5sZo6ayqPx07Jzs4J2yePy=cZk=k6VjhWB7zGeedg@mail.gmail.com>
From:   Ulf Hansson <ulf.hansson@linaro.org>
Date:   Fri, 22 Oct 2021 12:18:12 +0200
Message-ID: <CAPDyKFooeseEXW-O8DCAd5Jku1n0iNXfHFt_HVjcfMYFvw4a2g@mail.gmail.com>
Subject: Re: [PATCH 2/2] PM: sleep: Fix runtime PM based cpuidle support
To:     "Rafael J. Wysocki" <rafael@kernel.org>
Cc:     Daniel Lezcano <daniel.lezcano@linaro.org>,
        Linux PM <linux-pm@vger.kernel.org>,
        Maulik Shah <mkshah@codeaurora.org>,
        Peter Zijlstra <peterz@infradead.org>,
        Vincent Guittot <vincent.guittot@linaro.org>,
        Len Brown <len.brown@intel.com>,
        Bjorn Andersson <bjorn.andersson@linaro.org>,
        Linux ARM <linux-arm-kernel@lists.infradead.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

On Thu, 21 Oct 2021 at 21:56, Ulf Hansson <ulf.hansson@linaro.org> wrote:
>
> On Thu, 21 Oct 2021 at 21:02, Rafael J. Wysocki <rafael@kernel.org> wrote:
> >
> > On Thu, Oct 21, 2021 at 8:12 PM Ulf Hansson <ulf.hansson@linaro.org> wrote:
> > >
> > > On Thu, 21 Oct 2021 at 18:33, Rafael J. Wysocki <rafael@kernel.org> wrote:
> > > >
> > > > On Thu, Oct 21, 2021 at 6:17 PM Ulf Hansson <ulf.hansson@linaro.org> wrote:
> >
> > [cut]
> >
> > > > So in theory you could check the pm_runtime_put_sync_suspend() return
> > > > value and fall back to something like WFI if that's an error code.
> > >
> > > I have already tried that, but it simply got too complicated. The main
> > > issue was that runtime PM could become disabled for the device in the
> > > middle of executing the ->enter() callback.
> >
> > So IIUC the problem is that you cannot resume after suspending in that case.
> >
> > IOW, you need to guarantee that if the suspend is successful, the
> > resume also will take place, but if the suspend fails, you basically
> > don't care.
>
> Exactly.
>
> >
> > > For example, if pm_runtime_get_sync() fails, I still need to make sure
> > > the reference counting in genpd becomes correct - and I can't do that
> > > using dev_pm_genpd_resume(). That's because it's not designed to be
> > > called in this "unknown" suspend phase, but should be called after the
> > > noirq phase and be properly balanced with dev_pm_genpd_suspend().
> > >
> > > In other words, the error path didn't work out for me.
> >
> > It should be sufficient to call wake_up_all_idle_cpus() in the suspend
> > path before dpm_suspend_late(), because system suspend acquires a
> > PM-runtime reference on every device.  IOW, it won't let any devices
> > runtime-suspend, so if your power domain devices are resumed in that
> > path, they will never suspend again in it and the
> > pm_runtime_put_sync_suspend() in __psci_enter_domain_idle_state()
> > becomes a reference counter management call which works regardless of
> > whether or not PM runtime is disabled.
>
> That sounds like a great idea, this should work too! Then the question
> is, how to make that call to wake_up_all_idle_cpus() to become
> optional - or only invoked for the cpuidle drivers that need it.
>
> In any case, I will try this out, thanks for the suggestion!

I now recall that I have already tried this, but unfortunately it doesn't work.

The problem is that the dev->power.syscore flag is set for the device,
which makes device_prepare() to bail out early and skip calling
pm_runtime_get_noresume().

Kind regards
Uffe
