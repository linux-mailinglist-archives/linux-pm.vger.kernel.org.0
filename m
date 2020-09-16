Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5519826C89F
	for <lists+linux-pm@lfdr.de>; Wed, 16 Sep 2020 20:55:08 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728237AbgIPSyh (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Wed, 16 Sep 2020 14:54:37 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37312 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727690AbgIPR6I (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Wed, 16 Sep 2020 13:58:08 -0400
Received: from mail-pg1-x52e.google.com (mail-pg1-x52e.google.com [IPv6:2607:f8b0:4864:20::52e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3A549C02C2BE
        for <linux-pm@vger.kernel.org>; Wed, 16 Sep 2020 09:40:58 -0700 (PDT)
Received: by mail-pg1-x52e.google.com with SMTP id j34so4214716pgi.7
        for <linux-pm@vger.kernel.org>; Wed, 16 Sep 2020 09:40:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=WhlGWVI3LaTH1p8+ldz6Qi6juBzyGEgCmFwW9Q3lN6w=;
        b=duLh2jWD5Dgb7ko3teI+il54V3ud9S5mViXog9DWH845vNxR6yLnMgzngf/1tU1cpQ
         u4rpIF1qiQji7whRdll2vGn+nmP/IQL7plBW3mcwU51tjdElN3oPVxJwaPvYM1ocONic
         EFYaUtuJNTHvmwrpuDMWUh46BudzieMMzHfuE=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=WhlGWVI3LaTH1p8+ldz6Qi6juBzyGEgCmFwW9Q3lN6w=;
        b=HkZCh+mhSTpsqe9JlCH1CBWTzF7eeVwerYlN40rPaambgM7atpDoU/mE0SdwlCj6GV
         nAd4HDb4oD65ZiW6DruPm3aHPuMprRYbvHShDUOwujMUIwN4jV+So7Ili1wVEx6Wk8yh
         cul6JYowjaswzNZLo8JNJYbFhmFknpFyc9DhwvJvgwlTpFbhEy8Ey66tiND3rxXX70En
         Gu1kVnfxg9CrGX4pLom3wUWB6HkWWV59dd0v6aEzomut8Vn19Zapj2lh31gbbo05l1/3
         FOW79vx57XGio7dmuarkgCQ18EmgZl1K0XftuSbJ0XCTwiT83jIb0QrPawdMhXpawy5w
         rsNQ==
X-Gm-Message-State: AOAM533x3OE6PDWhjQOS6xNvlqrS6xiiDEBth8ge2W6Ci4fLz9Nt189K
        KQBU4gR98N7ddcg+B8obs4RO6A==
X-Google-Smtp-Source: ABdhPJznGYU6LeZ9pKpPyRSNH2dEyT60pWBW0HCpYhZxfcK3eIVGa5mgxE9gqJq+UvYYbS0477ghFg==
X-Received: by 2002:a62:ac18:0:b029:142:2501:34ef with SMTP id v24-20020a62ac180000b0290142250134efmr6829574pfe.72.1600274457743;
        Wed, 16 Sep 2020 09:40:57 -0700 (PDT)
Received: from localhost ([2620:15c:202:1:f693:9fff:fef4:e70a])
        by smtp.gmail.com with ESMTPSA id g24sm3282695pfk.65.2020.09.16.09.40.56
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 16 Sep 2020 09:40:56 -0700 (PDT)
Date:   Wed, 16 Sep 2020 09:40:55 -0700
From:   Matthias Kaehlcke <mka@chromium.org>
To:     Rajendra Nayak <rnayak@codeaurora.org>
Cc:     Daniel Lezcano <daniel.lezcano@linaro.org>,
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
Message-ID: <20200916164055.GH2771744@google.com>
References: <248bb01e-1746-c84c-78c4-3cf7d2541a70@codeaurora.org>
 <20200915172444.GA2771744@google.com>
 <406d5d4e-d7d7-8a37-5501-119b734facb3@linaro.org>
 <20200915175808.GB2771744@google.com>
 <27785351-ba14-dc92-6761-d64962c29596@linaro.org>
 <20200915211309.GC2771744@google.com>
 <808029c4-3a05-1926-934d-10739190ab9e@linaro.org>
 <20200915213626.GD2771744@google.com>
 <5553e9c4-9681-e223-8a31-ea0b0582668f@codeaurora.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <5553e9c4-9681-e223-8a31-ea0b0582668f@codeaurora.org>
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

On Wed, Sep 16, 2020 at 09:45:04AM +0530, Rajendra Nayak wrote:
> 
> On 9/16/2020 3:06 AM, Matthias Kaehlcke wrote:
> > On Tue, Sep 15, 2020 at 11:23:49PM +0200, Daniel Lezcano wrote:
> > > On 15/09/2020 23:13, Matthias Kaehlcke wrote:
> > > > On Tue, Sep 15, 2020 at 10:55:52PM +0200, Daniel Lezcano wrote:
> > > > > On 15/09/2020 19:58, Matthias Kaehlcke wrote:
> > > > > > On Tue, Sep 15, 2020 at 07:50:10PM +0200, Daniel Lezcano wrote:
> > > > > > > On 15/09/2020 19:24, Matthias Kaehlcke wrote:
> > > > > > > > +Thermal folks
> > > > > > > > 
> > > > > > > > Hi Rajendra,
> > > > > > > > 
> > > > > > > > On Tue, Sep 15, 2020 at 11:14:00AM +0530, Rajendra Nayak wrote:
> > > > > > > > > Hi Rob,
> > > > > > > > > 
> > > > > > > > > There has been some discussions on another thread [1] around the DPC (dynamic-power-coefficient) values
> > > > > > > > > for CPU's being relative vs absolute (based on real power) and should they be used to derive 'real' power
> > > > > > > > > at various OPPs in order to calculate things like 'sustainable-power' for thermal zones.
> > > > > > > > > I believe relative values work perfectly fine for scheduling decisions, but with others using this for
> > > > > > > > > calculating power values in mW, is there a need to document the property as something that *has* to be
> > > > > > > > > based on real power measurements?
> > > > > > > > 
> > > > > > > > Relative values may work for scheduling decisions, but not for thermal
> > > > > > > > management with the power allocator, at least not when CPU cooling devices
> > > > > > > > are combined with others that specify their power consumption in absolute
> > > > > > > > values. Such a configuration should be supported IMO.
> > > > > > > 
> > > > > > > The energy model is used in the cpufreq cooling device and if the
> > > > > > > sustainable power is consistent with the relative values then there is
> > > > > > > no reason it shouldn't work.
> > > > > > 
> > > > > > Agreed on thermal zones that exclusively use CPUs as cooling devices, but
> > > > > > what when you have mixed zones, with CPUs with their pseudo-unit and e.g. a
> > > > > > GPU that specifies its power in mW?
> > > > > 
> > > > > Well, if a SoC vendor decides to mix the units, then there is nothing we
> > > > > can do.
> > > > > 
> > > > > When specifying the power numbers available for the SoC, they could be
> > > > > all scaled against the highest power number.
> > > > 
> > > > The GPU was just one example, a device could have heat dissipating components
> > > > that are not from the SoC vendor (e.g. WiFi, modem, backlight), and depending
> > > > on the design it might not make sense to have separate thermal zones.
> > > 
> > > Is it possible to elaborate, I'm not sure to get the point ?
> > 
> > A device could have a thermal zone with the following cooling
> > devices:
> > 
> > - CPUs with power consumption specified as pmW (pseudo mW
> > - A modem from a third party vendor. The modem can dissipate
> >    significant heat and allows to throttle the bandwidth for
> >    cooling. The power consumption of the modem is given in
> >    mW.
> > 
> > These could be crammed together in a small form factor
> > (e.g. ChromeCast or Chromebit) which makes it difficult to
> > discern with a sensor what exactly is generating the heat,
> > which is why you have a single thermal zone.
> > 
> > IPA is used as governor for this zone, it can't make accurate
> > decisions because one cooling device specifies it's power
> > consumption in pmW and the other in mW.
> 
> Is there a real example upstream for this, or is it a theoretical
> problem (which can exist in the future) we are trying to solve?

Sort of, there is the rk3288-based veyron-mickey, which uses CPUs,
the GPU and ddrfreq as cooling devices in the same zone:

https://chromium.googlesource.com/chromiumos/third_party/kernel/+/refs/heads/chromeos-4.19/arch/arm/boot/dts/rk3288-veyron-mickey.dts#42

The device doesn't use IPA though, so mixed up units wouldn't matter in this
case.

From a quick grep in arch/arm(64)/boot/dts/ at least it seems that mixing
cooling devices of different types is not a common case, though it doesn't
necessarily reflect what is done in custom DTs.
