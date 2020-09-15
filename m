Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3DF6826AFAA
	for <lists+linux-pm@lfdr.de>; Tue, 15 Sep 2020 23:37:54 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728012AbgIOVhu (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Tue, 15 Sep 2020 17:37:50 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44806 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728112AbgIOVgm (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Tue, 15 Sep 2020 17:36:42 -0400
Received: from mail-pl1-x631.google.com (mail-pl1-x631.google.com [IPv6:2607:f8b0:4864:20::631])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CDED1C06174A
        for <linux-pm@vger.kernel.org>; Tue, 15 Sep 2020 14:36:28 -0700 (PDT)
Received: by mail-pl1-x631.google.com with SMTP id c3so2034764plz.5
        for <linux-pm@vger.kernel.org>; Tue, 15 Sep 2020 14:36:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=Q/ONZTq8yzKfu/JZ1zGnvLWpAzIfYzhKA8qIl7mniGY=;
        b=DoIbTW/2CtgRJq92eSPalZa5mfpmnrfT0ofKnk+wQQuLo2PGBqHmm+aHXdoVihU7L5
         JzjBgRroHOgcgX+2B+NngYYJyN052zZ2YT/wCOWSsMVrPcBFpmPLltbSL4WleFYWk4xX
         HmpAXktw8Z7NpIydJI23Qo7yy9zpxzYZZKZBw=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=Q/ONZTq8yzKfu/JZ1zGnvLWpAzIfYzhKA8qIl7mniGY=;
        b=RBSN4SISfvBSGQY3YrpOISXlQwhEfBPiaQaYUSmIVb5wHBW6NdB/yK7H7yjM6D0qze
         GXwf/gYEVIILcsYWE5wPbqxKtBWVn4eZnpW0+N3Jk0LDuCF8JreIrg1tGMoIFcyxACDR
         KiUUf17IzgCUVhlRvZHvLPy7rCiId+fTUhSkSTLarArJDPLdWOOuMmMxr9CHqthjwrSs
         7Es1LdtTVY77cJ2nPSlOzp5BAHnq/qJYRWEAmJEqmiEFEaR6Z+y+TFNtySFHulmsnhiL
         qrZX4lOn8q/5FPcAGi3WrdidlO0Hjw1+UorPttgq/WcW9fh3xdqR31Zgi/np/pIFbXpP
         pPRQ==
X-Gm-Message-State: AOAM533RKCM9PH9jA3HzYs1DMbiaX0Nfi7roNv2VBwXY+NbO6PixVpoX
        2M3pawLVvLU8d/qIb05xt8Ri9w==
X-Google-Smtp-Source: ABdhPJx1PHMy//vOzR66thN4Z4MDTzaarCGbaq0XsSH22Cct3LbDQMW0bs1s+D0QMpWCoi3yZsKFvQ==
X-Received: by 2002:a17:902:b7c7:b029:d1:cc21:9c38 with SMTP id v7-20020a170902b7c7b02900d1cc219c38mr9786815plz.21.1600205788381;
        Tue, 15 Sep 2020 14:36:28 -0700 (PDT)
Received: from localhost ([2620:15c:202:1:f693:9fff:fef4:e70a])
        by smtp.gmail.com with ESMTPSA id a23sm12197586pgv.86.2020.09.15.14.36.27
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 15 Sep 2020 14:36:28 -0700 (PDT)
Date:   Tue, 15 Sep 2020 14:36:26 -0700
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
Message-ID: <20200915213626.GD2771744@google.com>
References: <248bb01e-1746-c84c-78c4-3cf7d2541a70@codeaurora.org>
 <20200915172444.GA2771744@google.com>
 <406d5d4e-d7d7-8a37-5501-119b734facb3@linaro.org>
 <20200915175808.GB2771744@google.com>
 <27785351-ba14-dc92-6761-d64962c29596@linaro.org>
 <20200915211309.GC2771744@google.com>
 <808029c4-3a05-1926-934d-10739190ab9e@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <808029c4-3a05-1926-934d-10739190ab9e@linaro.org>
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

On Tue, Sep 15, 2020 at 11:23:49PM +0200, Daniel Lezcano wrote:
> On 15/09/2020 23:13, Matthias Kaehlcke wrote:
> > On Tue, Sep 15, 2020 at 10:55:52PM +0200, Daniel Lezcano wrote:
> >> On 15/09/2020 19:58, Matthias Kaehlcke wrote:
> >>> On Tue, Sep 15, 2020 at 07:50:10PM +0200, Daniel Lezcano wrote:
> >>>> On 15/09/2020 19:24, Matthias Kaehlcke wrote:
> >>>>> +Thermal folks
> >>>>>
> >>>>> Hi Rajendra,
> >>>>>
> >>>>> On Tue, Sep 15, 2020 at 11:14:00AM +0530, Rajendra Nayak wrote:
> >>>>>> Hi Rob,
> >>>>>>
> >>>>>> There has been some discussions on another thread [1] around the DPC (dynamic-power-coefficient) values
> >>>>>> for CPU's being relative vs absolute (based on real power) and should they be used to derive 'real' power
> >>>>>> at various OPPs in order to calculate things like 'sustainable-power' for thermal zones.
> >>>>>> I believe relative values work perfectly fine for scheduling decisions, but with others using this for
> >>>>>> calculating power values in mW, is there a need to document the property as something that *has* to be
> >>>>>> based on real power measurements?
> >>>>>
> >>>>> Relative values may work for scheduling decisions, but not for thermal
> >>>>> management with the power allocator, at least not when CPU cooling devices
> >>>>> are combined with others that specify their power consumption in absolute
> >>>>> values. Such a configuration should be supported IMO.
> >>>>
> >>>> The energy model is used in the cpufreq cooling device and if the
> >>>> sustainable power is consistent with the relative values then there is
> >>>> no reason it shouldn't work.
> >>>
> >>> Agreed on thermal zones that exclusively use CPUs as cooling devices, but
> >>> what when you have mixed zones, with CPUs with their pseudo-unit and e.g. a
> >>> GPU that specifies its power in mW?
> >>
> >> Well, if a SoC vendor decides to mix the units, then there is nothing we
> >> can do.
> >>
> >> When specifying the power numbers available for the SoC, they could be
> >> all scaled against the highest power number.
> > 
> > The GPU was just one example, a device could have heat dissipating components
> > that are not from the SoC vendor (e.g. WiFi, modem, backlight), and depending
> > on the design it might not make sense to have separate thermal zones.
> 
> Is it possible to elaborate, I'm not sure to get the point ?

A device could have a thermal zone with the following cooling
devices:

- CPUs with power consumption specified as pmW (pseudo mW
- A modem from a third party vendor. The modem can dissipate
  significant heat and allows to throttle the bandwidth for
  cooling. The power consumption of the modem is given in
  mW.

These could be crammed together in a small form factor
(e.g. ChromeCast or Chromebit) which makes it difficult to
discern with a sensor what exactly is generating the heat,
which is why you have a single thermal zone.

IPA is used as governor for this zone, it can't make accurate
decisions because one cooling device specifies it's power
consumption in pmW and the other in mW.
