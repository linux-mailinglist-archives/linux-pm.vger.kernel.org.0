Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B653F26AFDF
	for <lists+linux-pm@lfdr.de>; Tue, 15 Sep 2020 23:47:31 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727785AbgIOVrN (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Tue, 15 Sep 2020 17:47:13 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46396 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728108AbgIOVqg (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Tue, 15 Sep 2020 17:46:36 -0400
Received: from mail-vk1-xa31.google.com (mail-vk1-xa31.google.com [IPv6:2607:f8b0:4864:20::a31])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B32D0C061788
        for <linux-pm@vger.kernel.org>; Tue, 15 Sep 2020 14:46:33 -0700 (PDT)
Received: by mail-vk1-xa31.google.com with SMTP id q13so1226962vkd.0
        for <linux-pm@vger.kernel.org>; Tue, 15 Sep 2020 14:46:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=5lQx6ouYx3ZQgTAYfn9mY0tepBCsettlTPRkpFc3p7E=;
        b=TfKGQEsNNXmRziL734xfQ2bxGV9BmIMhM6XTbr50j2/KdyK/QrCeRvCRkN3Tx0lfUQ
         J0SXFFY3AIUNxGeHMtDqTbc/VuhyhEDavVTT5XjF/ClsgLOEtGOtgq0iosHZ4EzFdTrw
         JahnUKZxAsq1kBVbY5lZ1JHgim5+EUHvkjFxo=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=5lQx6ouYx3ZQgTAYfn9mY0tepBCsettlTPRkpFc3p7E=;
        b=Xh0A94YJhGIJsLcZG9NCEFTT85dQXJlIju/UmS4sXTdySGtLeCM+iTP9uGiSu1H9tv
         LpZN7bTiXFZ1ydvIj/r/1k5hKr/x/1VDht9PAyJ0JVAZqA77cCd8RczPc7O+rmr6h2Fv
         bcsWJuGpbVy3QR0ygpOGQ7N41UWhVP1HQ2qnIaMU473XwuV9vdUv6W7V71/I7I3L+SF7
         xaBG3hpQNGcwe0gClhu+PiAkkf7T2i1OZU2+UAbQyS2FqxCfSpvN02WmRIK9l8ffdQAY
         kUXRaBZXbr30wu8yX9VCS00vik8DADYemlh9mI9m1sRYhaNQCuqnb/SU39NEMkEkTSpK
         QdgA==
X-Gm-Message-State: AOAM532UKWkU+hhDuRNqhDdv9B/fNzBvvs/35ovRf3F+33JyydOvP5aH
        CTSxSoCkuiZSdZ549qA2pdcyvDONrp3Eug==
X-Google-Smtp-Source: ABdhPJzwm/GHyj4wA0pto02veGyg2XaennGeg0RtPmwa8yU9rsc26EOyWFxYH2yXISOv2ZzADDK4DQ==
X-Received: by 2002:a1f:958f:: with SMTP id x137mr11742600vkd.7.1600206390081;
        Tue, 15 Sep 2020 14:46:30 -0700 (PDT)
Received: from mail-vk1-f169.google.com (mail-vk1-f169.google.com. [209.85.221.169])
        by smtp.gmail.com with ESMTPSA id a73sm2138023vsd.6.2020.09.15.14.46.29
        for <linux-pm@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 15 Sep 2020 14:46:29 -0700 (PDT)
Received: by mail-vk1-f169.google.com with SMTP id e5so1224208vkm.2
        for <linux-pm@vger.kernel.org>; Tue, 15 Sep 2020 14:46:29 -0700 (PDT)
X-Received: by 2002:a1f:d986:: with SMTP id q128mr6249379vkg.7.1600206388505;
 Tue, 15 Sep 2020 14:46:28 -0700 (PDT)
MIME-Version: 1.0
References: <248bb01e-1746-c84c-78c4-3cf7d2541a70@codeaurora.org>
 <20200915172444.GA2771744@google.com> <406d5d4e-d7d7-8a37-5501-119b734facb3@linaro.org>
 <20200915175808.GB2771744@google.com> <27785351-ba14-dc92-6761-d64962c29596@linaro.org>
In-Reply-To: <27785351-ba14-dc92-6761-d64962c29596@linaro.org>
From:   Doug Anderson <dianders@chromium.org>
Date:   Tue, 15 Sep 2020 14:46:16 -0700
X-Gmail-Original-Message-ID: <CAD=FV=XPTrA0S5OukQT4=R7HCOd8DuJCdXCDKW+xCO6YNe7xNA@mail.gmail.com>
Message-ID: <CAD=FV=XPTrA0S5OukQT4=R7HCOd8DuJCdXCDKW+xCO6YNe7xNA@mail.gmail.com>
Subject: Re: is 'dynamic-power-coefficient' expected to be based on 'real'
 power measurements?
To:     Daniel Lezcano <daniel.lezcano@linaro.org>
Cc:     Matthias Kaehlcke <mka@chromium.org>,
        Rajendra Nayak <rnayak@codeaurora.org>,
        Lukasz Luba <lukasz.luba@arm.com>,
        Rob Herring <robh+dt@kernel.org>,
        DTML <devicetree@vger.kernel.org>,
        Linux PM <linux-pm@vger.kernel.org>,
        Amit Daniel Kachhap <amit.kachhap@gmail.com>,
        Viresh Kumar <viresh.kumar@linaro.org>,
        Javi Merino <javi.merino@kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

Hi,

On Tue, Sep 15, 2020 at 1:55 PM Daniel Lezcano
<daniel.lezcano@linaro.org> wrote:
>
> On 15/09/2020 19:58, Matthias Kaehlcke wrote:
> > On Tue, Sep 15, 2020 at 07:50:10PM +0200, Daniel Lezcano wrote:
> >> On 15/09/2020 19:24, Matthias Kaehlcke wrote:
> >>> +Thermal folks
> >>>
> >>> Hi Rajendra,
> >>>
> >>> On Tue, Sep 15, 2020 at 11:14:00AM +0530, Rajendra Nayak wrote:
> >>>> Hi Rob,
> >>>>
> >>>> There has been some discussions on another thread [1] around the DPC (dynamic-power-coefficient) values
> >>>> for CPU's being relative vs absolute (based on real power) and should they be used to derive 'real' power
> >>>> at various OPPs in order to calculate things like 'sustainable-power' for thermal zones.
> >>>> I believe relative values work perfectly fine for scheduling decisions, but with others using this for
> >>>> calculating power values in mW, is there a need to document the property as something that *has* to be
> >>>> based on real power measurements?
> >>>
> >>> Relative values may work for scheduling decisions, but not for thermal
> >>> management with the power allocator, at least not when CPU cooling devices
> >>> are combined with others that specify their power consumption in absolute
> >>> values. Such a configuration should be supported IMO.
> >>
> >> The energy model is used in the cpufreq cooling device and if the
> >> sustainable power is consistent with the relative values then there is
> >> no reason it shouldn't work.
> >
> > Agreed on thermal zones that exclusively use CPUs as cooling devices, but
> > what when you have mixed zones, with CPUs with their pseudo-unit and e.g. a
> > GPU that specifies its power in mW?
>
> Well, if a SoC vendor decides to mix the units, then there is nothing we
> can do.

I mean, there is something someone could do.  They could buy one of
these devices, measure the power (which wouldn't actually be that hard
to do), then submit a patch to adjust all the numbers.  ;-)

-Doug
