Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9D01F436B09
	for <lists+linux-pm@lfdr.de>; Thu, 21 Oct 2021 21:02:38 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230020AbhJUTEx (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Thu, 21 Oct 2021 15:04:53 -0400
Received: from mail-oi1-f182.google.com ([209.85.167.182]:35509 "EHLO
        mail-oi1-f182.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231336AbhJUTEw (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Thu, 21 Oct 2021 15:04:52 -0400
Received: by mail-oi1-f182.google.com with SMTP id r6so2108084oiw.2;
        Thu, 21 Oct 2021 12:02:36 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=W7TkRZBg0XypFSbXfRFIpqf6ScvCTqPGc+rgARxQ4LA=;
        b=7shygzSLatyQFc44/gtRSOGVC8NPc412I8P4OTBPmXvMiAzwgH9N7jPHqfl5cEOJRf
         zm/A8cUqFpOkrvc2tqoQO38F8Lpwe/B7UMt4V7x1P3oFpC5Lzth3p9zSuHKEQBmOcivP
         74c4ZkZnP9NjWPf7gMOh/gPSNA8b+wIdXLHerpN74PeQ+ocdbTHKVuaMtL+ylWUHZMQc
         WPkn1UcJionNMX/WBXcBvXN/olcvOI47PjPTCfIUIPD5bIVNIwdfr134JrLFkiULE3/j
         Cf/bpTHWVTo3CPMsT9EYi3RMKEXql48VsFBsUpJ3BD+ay1mB7xo0HhhSGv6cxwZYGYGR
         +ciw==
X-Gm-Message-State: AOAM530Emf5rLwe7fNO9E2KQuXCaXZlhfVqdvOh1JMeYsx5jSucdZHs6
        YJQq0IJVaWSeR7pg8qJvLaNCXQgih98zHd5AkSE=
X-Google-Smtp-Source: ABdhPJzf2WcHwGOnLbgy1YaTHUIzSnbvS5pD5Zraj6p32xvOZ2slzltcvMkcEUasinTitUk1PoMt+RZrjw3bUKsPfow=
X-Received: by 2002:a05:6808:e87:: with SMTP id k7mr2165504oil.166.1634842956087;
 Thu, 21 Oct 2021 12:02:36 -0700 (PDT)
MIME-Version: 1.0
References: <20210929144451.113334-1-ulf.hansson@linaro.org>
 <20210929144451.113334-3-ulf.hansson@linaro.org> <CAJZ5v0hgdQeJ+6mLMLQcvnM_+EiyDBERj54aT2cL=HiTO9nMNQ@mail.gmail.com>
 <CAPDyKFpep3aPmGGo=aA5dHZZjb-O51et47C9_hgVbZbXMJZX_g@mail.gmail.com>
 <CAJZ5v0j=Fi5vOh45de-u7FwsCm4zsAsHepp16xQ3U5_WjrtWJw@mail.gmail.com>
 <CAPDyKFqeAFhgCFSaFAWnp5xorxSVwAL=z2g6vHJ0PWjtt9GDNg@mail.gmail.com>
 <CAJZ5v0iA4O=tx7qiLKCOze87dcUtwtDJqi2B+2O=oOyCSzgmtQ@mail.gmail.com>
 <CAPDyKFr_-ON1JWXe3W7DAXUzKdrceqXPwLAdHnKeXajy=pFnug@mail.gmail.com>
 <CAJZ5v0itweerfbq8NE9rEonZ2Nfu_nfKgERv2tweeLO4fgAgLg@mail.gmail.com> <CAPDyKFrOSd2xEXuvDki9Em+xFLHfeTfZz3NtnWwNmWB1H6i=Kg@mail.gmail.com>
In-Reply-To: <CAPDyKFrOSd2xEXuvDki9Em+xFLHfeTfZz3NtnWwNmWB1H6i=Kg@mail.gmail.com>
From:   "Rafael J. Wysocki" <rafael@kernel.org>
Date:   Thu, 21 Oct 2021 21:02:24 +0200
Message-ID: <CAJZ5v0j3a_m5T9nbxk4VSuABOq12JEC0fi=0SQ8+=Vwv-qDeOA@mail.gmail.com>
Subject: Re: [PATCH 2/2] PM: sleep: Fix runtime PM based cpuidle support
To:     Ulf Hansson <ulf.hansson@linaro.org>
Cc:     "Rafael J. Wysocki" <rafael@kernel.org>,
        Daniel Lezcano <daniel.lezcano@linaro.org>,
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

On Thu, Oct 21, 2021 at 8:12 PM Ulf Hansson <ulf.hansson@linaro.org> wrote:
>
> On Thu, 21 Oct 2021 at 18:33, Rafael J. Wysocki <rafael@kernel.org> wrote:
> >
> > On Thu, Oct 21, 2021 at 6:17 PM Ulf Hansson <ulf.hansson@linaro.org> wrote:

[cut]

> > So in theory you could check the pm_runtime_put_sync_suspend() return
> > value and fall back to something like WFI if that's an error code.
>
> I have already tried that, but it simply got too complicated. The main
> issue was that runtime PM could become disabled for the device in the
> middle of executing the ->enter() callback.

So IIUC the problem is that you cannot resume after suspending in that case.

IOW, you need to guarantee that if the suspend is successful, the
resume also will take place, but if the suspend fails, you basically
don't care.

> For example, if pm_runtime_get_sync() fails, I still need to make sure
> the reference counting in genpd becomes correct - and I can't do that
> using dev_pm_genpd_resume(). That's because it's not designed to be
> called in this "unknown" suspend phase, but should be called after the
> noirq phase and be properly balanced with dev_pm_genpd_suspend().
>
> In other words, the error path didn't work out for me.

It should be sufficient to call wake_up_all_idle_cpus() in the suspend
path before dpm_suspend_late(), because system suspend acquires a
PM-runtime reference on every device.  IOW, it won't let any devices
runtime-suspend, so if your power domain devices are resumed in that
path, they will never suspend again in it and the
pm_runtime_put_sync_suspend() in __psci_enter_domain_idle_state()
becomes a reference counter management call which works regardless of
whether or not PM runtime is disabled.
