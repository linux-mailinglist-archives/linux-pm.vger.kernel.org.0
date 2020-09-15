Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id DB7F726AFF3
	for <lists+linux-pm@lfdr.de>; Tue, 15 Sep 2020 23:52:16 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728108AbgIOVwA (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Tue, 15 Sep 2020 17:52:00 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47202 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728085AbgIOVvr (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Tue, 15 Sep 2020 17:51:47 -0400
Received: from mail-pg1-x52f.google.com (mail-pg1-x52f.google.com [IPv6:2607:f8b0:4864:20::52f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9F7F1C06178A
        for <linux-pm@vger.kernel.org>; Tue, 15 Sep 2020 14:51:46 -0700 (PDT)
Received: by mail-pg1-x52f.google.com with SMTP id s65so2736918pgb.0
        for <linux-pm@vger.kernel.org>; Tue, 15 Sep 2020 14:51:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:content-transfer-encoding:in-reply-to;
        bh=mH9lo1yIL7XtqfMGHP4oTXsGu+z1FdnjyArN1xA9P/M=;
        b=KILcvAfoLaqMhcAZ8ys43ZMZLKPji8+6RcJNl/HeJbxBJs4Cbrz0EMe0CY7TNqoqOD
         VxBdq0j5mRt/np0t8JXeZOPJlEcDRHFHiTHuhmU08lugLpVDejZJy+hM6DrZoFcXaGea
         F64nvTzEq8chOxIE31izCedyb+gkvR9W1HgSU=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:content-transfer-encoding
         :in-reply-to;
        bh=mH9lo1yIL7XtqfMGHP4oTXsGu+z1FdnjyArN1xA9P/M=;
        b=MeB72H3XpUppY0S/tDfZtcdLsFXNPH9Uu+JncHRgZwirKF1BKqwnak1/YoFfkKXy/3
         0SyzMBhvAQwrnbF4JBHdpo/sPW/TSKGJLdmAggZo+V8l+FSHIlcUHwIl4N33Yuos/knV
         h4zfJWtiGD2g96CWFlnO1pmZ87BgUPWq2CRSPUXYoq5pa2dFNN4mhYnV3kCH0Kx0+p3L
         qXb+hTgH70w9J2tat/sqO7qMwITyEP98tvxJIcbtr0jo/TpxcY6WxEzwDsfdscP0UeJR
         8gd167wziw60t90E+O+D3i3U0pQfkKlT9HyVwA8UhV5f7Ak4Shf1AnQRBtIUYSSqAhXb
         oF6w==
X-Gm-Message-State: AOAM531PGk/OTLDfvYM2iVdPjBHMK1SGJf8sYwWVoi+c9hqhEmUzlp/f
        MFgV9sUheoc714ZHaJnqudOYdQ==
X-Google-Smtp-Source: ABdhPJw7qB1eFbNMikCO4TGf4y13sWV7W+6ly29WgwiBnYXdRdaoQAV2Yv/vUKZcPpTtOYJ5ErmA5g==
X-Received: by 2002:a65:685a:: with SMTP id q26mr6863702pgt.28.1600206705123;
        Tue, 15 Sep 2020 14:51:45 -0700 (PDT)
Received: from localhost ([2620:15c:202:1:f693:9fff:fef4:e70a])
        by smtp.gmail.com with ESMTPSA id v205sm14551750pfc.110.2020.09.15.14.51.44
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 15 Sep 2020 14:51:44 -0700 (PDT)
Date:   Tue, 15 Sep 2020 14:51:43 -0700
From:   Matthias Kaehlcke <mka@chromium.org>
To:     Doug Anderson <dianders@chromium.org>
Cc:     Daniel Lezcano <daniel.lezcano@linaro.org>,
        Rajendra Nayak <rnayak@codeaurora.org>,
        Lukasz Luba <lukasz.luba@arm.com>,
        Rob Herring <robh+dt@kernel.org>,
        DTML <devicetree@vger.kernel.org>,
        Linux PM <linux-pm@vger.kernel.org>,
        Amit Daniel Kachhap <amit.kachhap@gmail.com>,
        Viresh Kumar <viresh.kumar@linaro.org>,
        Javi Merino <javi.merino@kernel.org>
Subject: Re: is 'dynamic-power-coefficient' expected to be based on 'real'
 power measurements?
Message-ID: <20200915215143.GE2771744@google.com>
References: <248bb01e-1746-c84c-78c4-3cf7d2541a70@codeaurora.org>
 <20200915172444.GA2771744@google.com>
 <406d5d4e-d7d7-8a37-5501-119b734facb3@linaro.org>
 <20200915175808.GB2771744@google.com>
 <27785351-ba14-dc92-6761-d64962c29596@linaro.org>
 <CAD=FV=XPTrA0S5OukQT4=R7HCOd8DuJCdXCDKW+xCO6YNe7xNA@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAD=FV=XPTrA0S5OukQT4=R7HCOd8DuJCdXCDKW+xCO6YNe7xNA@mail.gmail.com>
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

On Tue, Sep 15, 2020 at 02:46:16PM -0700, Doug Anderson wrote:
> Hi,
> 
> On Tue, Sep 15, 2020 at 1:55 PM Daniel Lezcano
> <daniel.lezcano@linaro.org> wrote:
> >
> > On 15/09/2020 19:58, Matthias Kaehlcke wrote:
> > > On Tue, Sep 15, 2020 at 07:50:10PM +0200, Daniel Lezcano wrote:
> > >> On 15/09/2020 19:24, Matthias Kaehlcke wrote:
> > >>> +Thermal folks
> > >>>
> > >>> Hi Rajendra,
> > >>>
> > >>> On Tue, Sep 15, 2020 at 11:14:00AM +0530, Rajendra Nayak wrote:
> > >>>> Hi Rob,
> > >>>>
> > >>>> There has been some discussions on another thread [1] around the DPC (dynamic-power-coefficient) values
> > >>>> for CPU's being relative vs absolute (based on real power) and should they be used to derive 'real' power
> > >>>> at various OPPs in order to calculate things like 'sustainable-power' for thermal zones.
> > >>>> I believe relative values work perfectly fine for scheduling decisions, but with others using this for
> > >>>> calculating power values in mW, is there a need to document the property as something that *has* to be
> > >>>> based on real power measurements?
> > >>>
> > >>> Relative values may work for scheduling decisions, but not for thermal
> > >>> management with the power allocator, at least not when CPU cooling devices
> > >>> are combined with others that specify their power consumption in absolute
> > >>> values. Such a configuration should be supported IMO.
> > >>
> > >> The energy model is used in the cpufreq cooling device and if the
> > >> sustainable power is consistent with the relative values then there is
> > >> no reason it shouldn't work.
> > >
> > > Agreed on thermal zones that exclusively use CPUs as cooling devices, but
> > > what when you have mixed zones, with CPUs with their pseudo-unit and e.g. a
> > > GPU that specifies its power in mW?
> >
> > Well, if a SoC vendor decides to mix the units, then there is nothing we
> > can do.
> 
> I mean, there is something someone could do.  They could buy one of
> these devices, measure the power (which wouldn't actually be that hard
> to do), then submit a patch to adjust all the numbers.  ;-)

In case they look for a recipe:

commit ac60c5e33df4ec2b69c7e3ebbc0ccf1557e7bd5e
Author: Matthias Kaehlcke <mka@chromium.org>
Date:   Thu Apr 11 17:01:58 2019 -0700

    ARM: dts: rockchip: Add dynamic-power-coefficient for rk3288

    The value was determined with the following method:

    - take CPUs 1-3 offline
    - for each OPP
      - set cpufreq min and max freq to OPP freq
      - start dhrystone benchmark
      - measure CPU power consumption during 10s
      - calculate Cx for OPPx
      - Cx = (Px - P1) / (Vx²fx - V1²f1)          [1]
        using the following units: mW / Ghz / V   [2]
    - C = avg(C2, ..., Cn)

   [1] see commit 4daa001a1773 ("arm64: dts: juno: Add cpu
       dynamic-power-coefficient information")
   [2] https://patchwork.kernel.org/patch/10493615/#22158551
