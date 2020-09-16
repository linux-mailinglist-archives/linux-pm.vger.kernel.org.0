Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5BEF426CC93
	for <lists+linux-pm@lfdr.de>; Wed, 16 Sep 2020 22:46:24 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726810AbgIPUqV (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Wed, 16 Sep 2020 16:46:21 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56286 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726715AbgIPRB5 (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Wed, 16 Sep 2020 13:01:57 -0400
Received: from mail-pg1-x529.google.com (mail-pg1-x529.google.com [IPv6:2607:f8b0:4864:20::529])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1603BC00217D
        for <linux-pm@vger.kernel.org>; Wed, 16 Sep 2020 09:48:44 -0700 (PDT)
Received: by mail-pg1-x529.google.com with SMTP id u13so4262177pgh.1
        for <linux-pm@vger.kernel.org>; Wed, 16 Sep 2020 09:48:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=P8PPXyb+uFO9XkdIEQXnPdIy8/a63GyCLZBdgHTWNo8=;
        b=lTDGuCkV4IpGXWAcjxk5BI+Lv7DinZHeRstTh98asodjwaKRYM6TBI3SJKbdw1HcIn
         fqSJbx6cDg+fyoEw64N8t2MEV1jOOPH2Lrbh1EaKTop2krATgdmP0Aq14j8fEiIbL7Pd
         /nvqgKZZWwpsjhblH7u1GDOQJMqqWNqfiLQ2A=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=P8PPXyb+uFO9XkdIEQXnPdIy8/a63GyCLZBdgHTWNo8=;
        b=PecyjxpM4S493ADDhTNGMFYMV32RIpQNMxgvWDbbOt/srkQYCjamEhG75hBBVQBj38
         2F3XN3HRi8P4u6S2+URRCFebskeqvmp+D0VNCE9/MwiQ/MDaYEVkC/42Hm/SsGGVv/Su
         qFwQnRO+aq4F2PCkew69szmXMaA4KTCbjFG/EZVKQtJ9dS/nUSfsgBFCdyJTfT79pKxF
         LfjArxHfL0ECcZMuLmxm7zhNf3HffaAcjPhl45tB4gJx7DCHKfTMJUef1okUqKO1auJf
         usOPVCkqIdGBUZdWN4mh6Q5yxXJDSsgEAfJDl+FQxCN7JOlG/uGZyBL/Qr09mma/Q8d6
         Crlw==
X-Gm-Message-State: AOAM530DuZobwSJYxCIlCLUG7L63Lz9zrqmyGd6DQAiIZyySZ6L/En81
        6rIslOl29TA4ddX+D+FpKWMx0Q==
X-Google-Smtp-Source: ABdhPJx8tcqUHrkBE71+UqAnT8KwW1vKZLiih2uNUfDW7wnlCFQ6vPb7NtG00XO3kjlvM3ePTTZyKg==
X-Received: by 2002:a63:cd47:: with SMTP id a7mr3384877pgj.394.1600274922218;
        Wed, 16 Sep 2020 09:48:42 -0700 (PDT)
Received: from localhost ([2620:15c:202:1:f693:9fff:fef4:e70a])
        by smtp.gmail.com with ESMTPSA id p11sm17317866pfq.130.2020.09.16.09.48.41
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 16 Sep 2020 09:48:41 -0700 (PDT)
Date:   Wed, 16 Sep 2020 09:48:40 -0700
From:   Matthias Kaehlcke <mka@chromium.org>
To:     Lukasz Luba <lukasz.luba@arm.com>
Cc:     Daniel Lezcano <daniel.lezcano@linaro.org>,
        Rajendra Nayak <rnayak@codeaurora.org>,
        Rob Herring <robh+dt@kernel.org>,
        DTML <devicetree@vger.kernel.org>,
        Doug Anderson <dianders@chromium.org>,
        linux-pm@vger.kernel.org,
        Amit Daniel Kachhap <amit.kachhap@gmail.com>,
        Viresh Kumar <viresh.kumar@linaro.org>,
        Javi Merino <javi.merino@kernel.org>
Subject: Re: is 'dynamic-power-coefficient' expected to be based on 'real'
 power measurements?
Message-ID: <20200916164840.GI2771744@google.com>
References: <248bb01e-1746-c84c-78c4-3cf7d2541a70@codeaurora.org>
 <20200915172444.GA2771744@google.com>
 <406d5d4e-d7d7-8a37-5501-119b734facb3@linaro.org>
 <20200915175808.GB2771744@google.com>
 <27785351-ba14-dc92-6761-d64962c29596@linaro.org>
 <b0d32e2b-1e21-b921-2d5f-335abafd0a37@arm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <b0d32e2b-1e21-b921-2d5f-335abafd0a37@arm.com>
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

On Wed, Sep 16, 2020 at 10:53:48AM +0100, Lukasz Luba wrote:
> 
> 
> On 9/15/20 9:55 PM, Daniel Lezcano wrote:
> > On 15/09/2020 19:58, Matthias Kaehlcke wrote:
> > > On Tue, Sep 15, 2020 at 07:50:10PM +0200, Daniel Lezcano wrote:
> > > > On 15/09/2020 19:24, Matthias Kaehlcke wrote:
> > > > > +Thermal folks
> > > > > 
> > > > > Hi Rajendra,
> > > > > 
> > > > > On Tue, Sep 15, 2020 at 11:14:00AM +0530, Rajendra Nayak wrote:
> > > > > > Hi Rob,
> > > > > > 
> > > > > > There has been some discussions on another thread [1] around the DPC (dynamic-power-coefficient) values
> > > > > > for CPU's being relative vs absolute (based on real power) and should they be used to derive 'real' power
> > > > > > at various OPPs in order to calculate things like 'sustainable-power' for thermal zones.
> > > > > > I believe relative values work perfectly fine for scheduling decisions, but with others using this for
> > > > > > calculating power values in mW, is there a need to document the property as something that *has* to be
> > > > > > based on real power measurements?
> > > > > 
> > > > > Relative values may work for scheduling decisions, but not for thermal
> > > > > management with the power allocator, at least not when CPU cooling devices
> > > > > are combined with others that specify their power consumption in absolute
> > > > > values. Such a configuration should be supported IMO.
> > > > 
> > > > The energy model is used in the cpufreq cooling device and if the
> > > > sustainable power is consistent with the relative values then there is
> > > > no reason it shouldn't work.
> > > 
> > > Agreed on thermal zones that exclusively use CPUs as cooling devices, but
> > > what when you have mixed zones, with CPUs with their pseudo-unit and e.g. a
> > > GPU that specifies its power in mW?
> > 
> > Well, if a SoC vendor decides to mix the units, then there is nothing we
> > can do.
> > 
> > When specifying the power numbers available for the SoC, they could be
> > all scaled against the highest power number.
> > 
> > There are so many factors on the hardware, the firmware, the kernel and
> > the userspace sides having an impact on the energy efficiency, I don't
> > understand why SoC vendors are so shy to share the power numbers...
> > 
> 
> Unfortunately (because it might confuse engineers in some cases like
> this one), even in the SCMI spec DEN0056B [1] we have this statement
> which allows to expose an 'abstract scale' values from firmware:
> '4.5.1 Performance domain management protocol background
> ...The power can be expressed in mW or in an abstract scale. Vendors
> are not obliged to reveal power costs if it is undesirable, but a linear
> scale is required.'
> 
> This is the source of our Energy Model values when we use SCMI cpufreq
> driver [2].
> 
> So this might be an issue in the future, when some SoC vendor decides to
> not expose the real mW, but the phone OEM would then take the SoC and
> try to add some other cooling device into the thermal zone. That new
> device is not part of the SCMI perf but some custom and has the real mW.
> 
> Do you think Daniel it should be somewhere documented in the kernel
> thermal that the firmware might silently populate EM with 'abstract
> scale'? Then special care should be taken when combining new
> cooling devices.
> 
> Regards,
> Lukasz
> 
> [1] https://developer.arm.com/documentation/den0056/b/?lang=en
> [2] https://elixir.bootlin.com/linux/latest/source/drivers/cpufreq/scmi-cpufreq.c#L121

If an 'abstract scale' is explicitly allowed I think it should be documented
to avoid confusion and make engineers aware of the peril of combining cooling
devices of different types in the same thermal zone.
