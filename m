Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0BA4825123B
	for <lists+linux-pm@lfdr.de>; Tue, 25 Aug 2020 08:44:23 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729131AbgHYGoV (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Tue, 25 Aug 2020 02:44:21 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44622 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729116AbgHYGoU (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Tue, 25 Aug 2020 02:44:20 -0400
Received: from mail-vk1-xa43.google.com (mail-vk1-xa43.google.com [IPv6:2607:f8b0:4864:20::a43])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2DA41C061755
        for <linux-pm@vger.kernel.org>; Mon, 24 Aug 2020 23:44:20 -0700 (PDT)
Received: by mail-vk1-xa43.google.com with SMTP id s81so2582982vkb.3
        for <linux-pm@vger.kernel.org>; Mon, 24 Aug 2020 23:44:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=XJAMoTU8iPJ2XHvID+aYODKfhNhGKA98hb1eoQOOBaY=;
        b=fWkqe7h2JlXjqCBifsBo1DomqyFcxD+MwZ64RmxkM3ByyKCVfF9elGSBuoMHyCcYS2
         UBFKwj7oQqabnf5QdJMBg0f5GAJ6FwQnfiak89uIJm1t+JNeQblGGufYjQ80PPqMsKEo
         lL1x7n/UwbjttP1Jy8jahAMssBJYJVA+5Qc7RsKvuXbccBeJK0wszJi70P2A5pclYVSR
         PcA3bTxqE9kVnIz8YndYmtQ/PmmNACGwmSBny44NBdm0yMHag/Fr8LCbcPqVqd3RVb3L
         crWd1nkGx9CbX6JZ44OMVT/pKD5PX79JDc+sHU03ACLJPDt7AAeevgp7IyWYcdJ96y0N
         Eslg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=XJAMoTU8iPJ2XHvID+aYODKfhNhGKA98hb1eoQOOBaY=;
        b=Ce/GHIkxTocvG+HyYrPjjSvQFRSOv9n72JqkO9tEpuGjkMbstIl66ZQLkG/5IR2f0j
         rrPuuYGRZmxQASn9WU0n0foyy2+Vl0RTgIuSADte55/ta5WBpOCgeAKx8GssjA1p9Due
         MPcqt6m1/iOqPWSwufkqemBHJHdKD4SEBIQArmLEJSf/ZGkbInGXKyNKSMDvCeuGdd18
         T47u+8dpd/D0w/ASLEigcSjTwvrbHCkcZUWAhxgHeKlTVFjJ+qRGpK3UpoqLl/xVIXu6
         ZeZsiQeeqnDxqG3QXC4WWIuMOw3y41bH1PMy14YH6aCzmZlDMJGubuL86PE5kR2dclBy
         xa0g==
X-Gm-Message-State: AOAM533VOCrg8rxZNcy7pLozZXc6vMFKHyg3Ylvig7XcWxkoxnSOsLbJ
        aIk0G2M+eXrtrrIhFZw6kibiavLeupE+0a0yY3CL1Q==
X-Google-Smtp-Source: ABdhPJzKdRlKnr0X6BmbjTIZvsC9IPRFVtH+69UI+kMPkRKZFeq0AzmE4bQnjN3zfh/5kBle3QGy1jR+/FwARY/V9iQ=
X-Received: by 2002:a1f:2cd0:: with SMTP id s199mr4733615vks.25.1598337859183;
 Mon, 24 Aug 2020 23:44:19 -0700 (PDT)
MIME-Version: 1.0
References: <20200730080146.25185-1-stephan@gerhold.net> <20200730080146.25185-4-stephan@gerhold.net>
 <20200824112744.jsyaxrfbybyjpwex@vireshk-i7> <20200824115549.GB208090@gerhold.net>
 <CAPDyKFojtArMRfO+Z8YaWCWw2fFYcO62x3eL1paNi5pKRg3Jww@mail.gmail.com>
 <20200824150831.GA842@gerhold.net> <20200825044308.4y3w2urcikban7if@vireshk-i7>
In-Reply-To: <20200825044308.4y3w2urcikban7if@vireshk-i7>
From:   Ulf Hansson <ulf.hansson@linaro.org>
Date:   Tue, 25 Aug 2020 08:43:42 +0200
Message-ID: <CAPDyKFp+71_WGwvdZ6DYamsDjgoRk57H5MjDAdQUtCtJpEHp2Q@mail.gmail.com>
Subject: Re: [RFC PATCH 3/3] opp: Power on (virtual) power domains managed by
 the OPP core
To:     Viresh Kumar <viresh.kumar@linaro.org>
Cc:     Stephan Gerhold <stephan@gerhold.net>,
        "Rafael J. Wysocki" <rjw@rjwysocki.net>,
        Kevin Hilman <khilman@kernel.org>, Nishanth Menon <nm@ti.com>,
        Stephen Boyd <sboyd@kernel.org>,
        Linux PM <linux-pm@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Niklas Cassel <nks@flawful.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

On Tue, 25 Aug 2020 at 06:43, Viresh Kumar <viresh.kumar@linaro.org> wrote:
>
> On 24-08-20, 17:08, Stephan Gerhold wrote:
> > On Mon, Aug 24, 2020 at 04:36:57PM +0200, Ulf Hansson wrote:
> > > That said, perhaps should rely on the consumer to deploy runtime PM
> > > support, but let the OPP core to set up the device links for the genpd
> > > virtual devices!?
> > >
> >
> > Yes, that would be the alternative option.
>
> That is the right option IMO.
>
> > I would be fine with it as long as it also works for the CPUfreq case.
> >
> > I don't think anything manages runtime PM for the CPU device, just
> > like no-one calls dev_pm_opp_set_rate(cpu_dev, 0). So with my patch the
> > power domain is essentially kept always-on (except for system suspend).
> > At least in my case this is intended.
> >
> > If device links also keep the power domains on if the consumer device
> > does not make use of runtime PM it should work fine for my case.
>
> With device link, you only need to do rpm enable/disable on the consumer device
> and it will get propagated by itself.

Note that the default state for the genpd virtual device(s) is that
runtime PM has been enabled for them. This means it's left in runtime
suspended state, which allows its PM domain to be powered off (if all
other devices and child domains for it allow that too, of course).

>
> > Personally, I think my original patch (without device links) fits better
> > into the OPP API, for the following two reasons.
> >
> > With device links:
> >
> >   1. Unlike regulators/interconnects, attached power domains would be
> >      controlled by runtime PM instead of dev_pm_opp_set_rate(opp_dev, 0).
> >
> >   2. ... some driver using OPP tables might not make use of runtime PM.
> >      In that case, the power domains would stay on the whole time,
> >      even if dev_pm_opp_set_rate(opp_dev, 0) was called.
> >
> > With my patch, the power domain state is directly related to the
> > dev_pm_opp_set_rate(opp_dev, 0) call, which is more intuitive than
> > relying on the runtime PM state in my opinion.
>
> So opp-set-rate isn't in the best of shape TBH, some things are left for the
> drivers while other are done by it. Regulator-enable/disable was moved to it
> some time back as people needed something like that. While on the other hand,
> clk_enable/disable doesn't happen there, nor does rpm enable/disable.
>
> Maybe one day we may want to do that, but lets make sure someone wants to do
> that first.
>
> Anyway, even in that case both of the changes would be required. We must make
> device links nevertheless first. And later on if required, we may want to do rpm
> enable/disable on the consumer device itself.

This sounds like a reasonable step-by-step approach.

Then, to create the device links, we should use DL_FLAG_PM_RUNTIME,
DL_FLAG_STATELESS.

But whether we should use DL_FLAG_RPM_ACTIVE as well, to initially
runtime resume the supplier (the genpd virtual device), is harder to
know - as that kind of depends on expectations by the consumer device
driver.

Kind regards
Uffe
