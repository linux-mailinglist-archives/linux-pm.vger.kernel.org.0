Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1716926AF40
	for <lists+linux-pm@lfdr.de>; Tue, 15 Sep 2020 23:13:57 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728011AbgIOVNk (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Tue, 15 Sep 2020 17:13:40 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41142 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727861AbgIOVNg (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Tue, 15 Sep 2020 17:13:36 -0400
Received: from mail-pl1-x634.google.com (mail-pl1-x634.google.com [IPv6:2607:f8b0:4864:20::634])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9DCC6C061788
        for <linux-pm@vger.kernel.org>; Tue, 15 Sep 2020 14:13:12 -0700 (PDT)
Received: by mail-pl1-x634.google.com with SMTP id k13so2003882plk.3
        for <linux-pm@vger.kernel.org>; Tue, 15 Sep 2020 14:13:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=abKiPag/1Ozorrxyyt6wGE2JT6gcln8Nw1fbM7q+yr8=;
        b=DDr7b+kwk53W99xWv9BTfuVx1CbeELr5NYyKBTb+Tov7SJ4uB3E2pLqTxyIdkqmdEg
         ko73MyzlNMxCv75sJj1sF0x7vwO7gG+oyUewBCA/WSvAXwL0CgDMTjMOKCJUotpJTBbw
         6nFjWmpaUK4i4OSl59HuZ7MCWIJCoFK5FVcnA=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=abKiPag/1Ozorrxyyt6wGE2JT6gcln8Nw1fbM7q+yr8=;
        b=TArxs6Vfema9KE9djzyNsfXpX2ZoaJ1ljOVkMZ4i8F7Z48lg9jtgbv6aB30UALXm74
         i+xJrTgxE5Dva4vSFuM4NPExi1LI4K8/OKyjq78HUGg6NPtwjHWA1bu5VXnhZn2qnp/Y
         i2Y6A0X6QxRJ9BbXh/jffyfM+HQsIyWhbDODAetpC5Qs0Y+q7i+2MFB9UWeLZcpbxJpx
         LDbo+C2LY5AvtX6qM9c6miT0XBuY6k2LUKpH/v1/UbmGa3HLAFNNXGzUVD6upyOuZSsD
         SrnrFVXFgXiJb9+x5Va0Dx5NusmM4vWhuW2hJ38NirUzHsMMME+sqbzgNvv8cVYVTqPR
         oZdA==
X-Gm-Message-State: AOAM532XzMmLchAZ0sutDbIQXWMZv5qRQA6lh9KXZnLNUrUYw7nM/vQW
        mIvM5afBVVGltkBmU2iTEBFl2Q==
X-Google-Smtp-Source: ABdhPJys3IuhT1Oz35grLyPQiwfcEIAeCrRlZvnjWzwVaB82sYIWoTL1lKenyW5Yt5IgSvLtwOrkLw==
X-Received: by 2002:a17:902:b715:b029:d1:e598:4000 with SMTP id d21-20020a170902b715b02900d1e5984000mr3456768pls.58.1600204392036;
        Tue, 15 Sep 2020 14:13:12 -0700 (PDT)
Received: from localhost ([2620:15c:202:1:f693:9fff:fef4:e70a])
        by smtp.gmail.com with ESMTPSA id x6sm396935pjp.25.2020.09.15.14.13.11
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 15 Sep 2020 14:13:11 -0700 (PDT)
Date:   Tue, 15 Sep 2020 14:13:09 -0700
From:   Matthias Kaehlcke <mka@chromium.org>
To:     Daniel Lezcano <daniel.lezcano@linaro.org>
Cc:     Rajendra Nayak <rnayak@codeaurora.org>,
        Lukasz Luba <lukasz.luba@arm.com>,
        Rob Herring <robh+dt@kernel.org>,
        DTML <devicetree@vger.kernel.org>,
        Doug Anderson <dianders@chromium.org>,
        linux-pm@vger.kernel.org,
        Amit Daniel Kachhap <amit.kachhap@gmail.com>,
        Viresh Kumar <viresh.kumar@linaro.org>,
        Javi Merino <javi.merino@kernel.org>
Subject: Re: is 'dynamic-power-coefficient' expected to be based on 'real'
 power measurements?
Message-ID: <20200915211309.GC2771744@google.com>
References: <248bb01e-1746-c84c-78c4-3cf7d2541a70@codeaurora.org>
 <20200915172444.GA2771744@google.com>
 <406d5d4e-d7d7-8a37-5501-119b734facb3@linaro.org>
 <20200915175808.GB2771744@google.com>
 <27785351-ba14-dc92-6761-d64962c29596@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <27785351-ba14-dc92-6761-d64962c29596@linaro.org>
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

On Tue, Sep 15, 2020 at 10:55:52PM +0200, Daniel Lezcano wrote:
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
> 
> When specifying the power numbers available for the SoC, they could be
> all scaled against the highest power number.

The GPU was just one example, a device could have heat dissipating components
that are not from the SoC vendor (e.g. WiFi, modem, backlight), and depending
on the design it might not make sense to have separate thermal zones.

> There are so many factors on the hardware, the firmware, the kernel and
> the userspace sides having an impact on the energy efficiency, I don't
> understand why SoC vendors are so shy to share the power numbers...

nor do I, someone could just perform measurements to determine DPCs
with the proper scale if Qualcomm refuses to provide them ...
