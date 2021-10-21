Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1A72C436AE3
	for <lists+linux-pm@lfdr.de>; Thu, 21 Oct 2021 20:49:50 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230441AbhJUSwF (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Thu, 21 Oct 2021 14:52:05 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44264 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230103AbhJUSwE (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Thu, 21 Oct 2021 14:52:04 -0400
Received: from mail-lj1-x230.google.com (mail-lj1-x230.google.com [IPv6:2a00:1450:4864:20::230])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C95A0C061764
        for <linux-pm@vger.kernel.org>; Thu, 21 Oct 2021 11:49:47 -0700 (PDT)
Received: by mail-lj1-x230.google.com with SMTP id q16so1009813ljg.3
        for <linux-pm@vger.kernel.org>; Thu, 21 Oct 2021 11:49:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=/TtfFv+YJK+r0KiR4Q7jDkvUjTqglRl+YDTfrv8xxts=;
        b=vZCfEv+leEgiq2uSITsk1Q+02XwaBs9iqHHpdbXsWgEA2/a6EX2zDGgIrQmVOOS8m1
         811Em6eRDdc8/knnqhcu1muPymVjGWzY4HkHuAocuvV5G7EJnMevzYWYxOt2P21S1EEg
         SvUpsYcF1kyoGnEjYVkUTqPHFo9lF4wCHBDTncb/y+AD8H5/c20NeH/0XggR+7WmVt+Q
         09hmN32jSv02U6zbV0FKGHtsfMX1DpsoX+44fKlzdzWH4WDPECNcax1iMCNcC/3X5AiU
         tC3/zVwmvkpl/iQk1I1HDeaD8KarQNg+ekYppqJFi61tmyI9hpyYWxVs+6MsaUf+PMWL
         6Nxg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=/TtfFv+YJK+r0KiR4Q7jDkvUjTqglRl+YDTfrv8xxts=;
        b=2Vgg1DB5D6yv0AxAS/VGDAYl/GCAbz/KYCV61a9Nb4VLGoyta2GbBnDxrM3jKHd309
         cpbUqiOkziZy69JMFDZGKPeZKZLMCd+FNatNcYJ1JEkZJhHWmksIbtJ8xWckPywXKDYT
         G3Iv58ecLIeb3QV4djt+1/HXTr2vN4zHVGU1Tb+bKTEchHFmvfA6MVfuTnnbAzyyj0S5
         +v4P+7GPoloh3AG4HUFfLUIA5vsd9+r0heVkUyWoKRwIubXco77W71ACrx2/MwFgwaef
         YjDWgi39VzUQEj6kPlzhfqmOdzu469OVa6kPw+iMZY3msMmQ7xXv12H7iPNTGqOwMF4H
         eB5w==
X-Gm-Message-State: AOAM531pw7IEi3T+ooDxUuPWI3ReXma4JzSdXmIDdTHxbDa5liR7y5Zh
        bbEjeoEDiEWfr8AdaCxqbCxdNWaphDLHXPqXzH7n9A==
X-Google-Smtp-Source: ABdhPJwaN/7Wj+W48MDMN3pQ75XqWwMeL+aCCHzrNt4lw0cYdyMmzGTZVQDEtFEa9DXYRyhULOCZpXiL4NtOVgt/mxI=
X-Received: by 2002:a2e:a5c8:: with SMTP id n8mr7994342ljp.367.1634842186126;
 Thu, 21 Oct 2021 11:49:46 -0700 (PDT)
MIME-Version: 1.0
References: <20210929144451.113334-1-ulf.hansson@linaro.org>
 <20210929144451.113334-3-ulf.hansson@linaro.org> <CAJZ5v0hgdQeJ+6mLMLQcvnM_+EiyDBERj54aT2cL=HiTO9nMNQ@mail.gmail.com>
 <CAPDyKFpep3aPmGGo=aA5dHZZjb-O51et47C9_hgVbZbXMJZX_g@mail.gmail.com>
 <CAJZ5v0j=Fi5vOh45de-u7FwsCm4zsAsHepp16xQ3U5_WjrtWJw@mail.gmail.com>
 <CAPDyKFqeAFhgCFSaFAWnp5xorxSVwAL=z2g6vHJ0PWjtt9GDNg@mail.gmail.com>
 <CAJZ5v0iA4O=tx7qiLKCOze87dcUtwtDJqi2B+2O=oOyCSzgmtQ@mail.gmail.com>
 <CAJZ5v0jQM3VDy_U8TiC3601ivSYVXyT5jJVjLt8qyMWE49zOeg@mail.gmail.com>
 <CAPDyKFouHn95Lwgx+PbK9itQP13U70ZiZbDr3jQd41KsvXMtqQ@mail.gmail.com>
 <CAJZ5v0hjdpyFGF5zPUX8RUaVW7Tk+qr9RwbGt-7C0Wxyx03TLg@mail.gmail.com> <CAJZ5v0iWxiH686bkZ3-mhKK0+F7f+wMWp8Adnjuk7BvdMywTww@mail.gmail.com>
In-Reply-To: <CAJZ5v0iWxiH686bkZ3-mhKK0+F7f+wMWp8Adnjuk7BvdMywTww@mail.gmail.com>
From:   Ulf Hansson <ulf.hansson@linaro.org>
Date:   Thu, 21 Oct 2021 20:49:09 +0200
Message-ID: <CAPDyKFqdF0DptpLvp21yzDOOAbFiiDwSmWZCWa1Vt9KO3fz44A@mail.gmail.com>
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

[...]

> > The PM-runtime case should be addressed directly IMO, we only need to
> > figure out how to do that.
> >
> > I'm wondering how you are dealing with the case when user space
> > prevents pd_dev from suspending via sysfs, for that matter.
>
> Or what happens if rpm_suspend() returns -EAGAIN, because someone has
> started to resume the device right after its reference counter went
> down to 0.

That would mean that the pm_runtime_put_sync() call fails to runtime
suspend the device. In other words, the corresponding genpd stays
powered on, which prevents idle states from being selected by the
genpd governor.

So, yes, this should work fine.

>
> It looks to me like the problem is there regardless of the whole
> interference with system suspend.

I don't think so, but I may be overlooking some points.

Kind regards
Uffe
