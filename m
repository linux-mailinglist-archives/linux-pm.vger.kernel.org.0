Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 22EF328F579
	for <lists+linux-pm@lfdr.de>; Thu, 15 Oct 2020 17:04:25 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2389236AbgJOPES (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Thu, 15 Oct 2020 11:04:18 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34458 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2388892AbgJOPES (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Thu, 15 Oct 2020 11:04:18 -0400
Received: from mail-wr1-x444.google.com (mail-wr1-x444.google.com [IPv6:2a00:1450:4864:20::444])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 89211C0613D3
        for <linux-pm@vger.kernel.org>; Thu, 15 Oct 2020 08:04:17 -0700 (PDT)
Received: by mail-wr1-x444.google.com with SMTP id y12so3904876wrp.6
        for <linux-pm@vger.kernel.org>; Thu, 15 Oct 2020 08:04:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=aM2rdd0kq3Z2pAcYt+iHv5sB+JPN3rjkl3TpYzl6xyc=;
        b=UKAndxXHYto5P21FGeL51//alyDJpo5kZPud/VLYgQq0N3AMkjZx8Lk2sctmT6dujy
         /DDzUg4xNokRkcYSOd8r8Ee3li5lhs1pZ35KRRkW2GSVSxLbf9PhvDGkMNoEnxDpk1pS
         ZouASX6HTudRFi7bf7AIaEeIumeQzIkdRy1tK40IGjIw+H2s2t5aQu7x4vrGhJDASE9r
         LYOzTGJWt6uH6EPhzDgWKDHHBzAQNnAP/SJQB661E2Umc1emtvMLwDs4BQq/sGSf27M0
         lSkPoyj9JDnHWxgP5YNEr9V2NXKGYbCxUrsIUqcZYDqArO7afYzxk79A3I1tjVzOAgc5
         zNRw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=aM2rdd0kq3Z2pAcYt+iHv5sB+JPN3rjkl3TpYzl6xyc=;
        b=meIkquNzpEYWrNl1JTkc/X/3oQHiW4LUtsIWwvLPJAyklJlwis82zVf8WldynD5IiY
         BpDo9V1Sg52EI3sEsSIZesM1hkmBaefD4XswXPJb86Lg4pBxmd/iyg5p7eujsKlg2QUs
         ogIknPLLFDXPU14oldVr54c7oDRXHNs9l7oYF9v1/Etr7QFJt2BL7bT11EAF+ZgKW/cW
         8SRZM1iUnkJd//jYkfvA02fmz/M6KBqx+Ho2qYCTTF7juUNypi77w+lTcyC+2Ov+x6p9
         r06QPM+998qbdrqW9h9EjdE6b09L5jsriXIwqNq5XjkRAf0fCXG6bifuCSRv6CHFo+jb
         uWkQ==
X-Gm-Message-State: AOAM5307JxWwS2KVAiWMPvaaBJRmXiK1mj6suG7QFUxAev+Rd1SZyKvM
        RWStVHdxtO1Gc6zUzzBGosDctQ==
X-Google-Smtp-Source: ABdhPJxJMiuBO2wfbeo+8BN1kdMoWtXi/rlDqTUmwuk2W5nU946ZQ42veLZHYl+13YOi4BDx41lOig==
X-Received: by 2002:adf:ce0b:: with SMTP id p11mr4801689wrn.318.1602774255908;
        Thu, 15 Oct 2020 08:04:15 -0700 (PDT)
Received: from google.com ([2a00:79e0:d:110:f693:9fff:fef4:a7ef])
        by smtp.gmail.com with ESMTPSA id w4sm4612378wmi.10.2020.10.15.08.04.15
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 15 Oct 2020 08:04:15 -0700 (PDT)
Date:   Thu, 15 Oct 2020 16:04:11 +0100
From:   Quentin Perret <qperret@google.com>
To:     "Rafael J. Wysocki" <rafael@kernel.org>
Cc:     Daniel Lezcano <daniel.lezcano@linaro.org>,
        Lukasz Luba <lukasz.luba@arm.com>,
        "Rafael J. Wysocki" <rjw@rjwysocki.net>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Linux PM <linux-pm@vger.kernel.org>,
        "open list:DOCUMENTATION" <linux-doc@vger.kernel.org>,
        "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Amit Kucheria <amitk@kernel.org>,
        Jonathan Corbet <corbet@lwn.net>,
        Dietmar Eggemann <Dietmar.Eggemann@arm.com>,
        Doug Anderson <dianders@chromium.org>,
        Matthias Kaehlcke <mka@chromium.org>,
        "Nayak, Rajendra" <rnayak@codeaurora.org>
Subject: Re: [PATCH v2 0/3] Clarify abstract scale usage for power values in
 Energy Model, EAS and IPA
Message-ID: <20201015150411.GA1859176@google.com>
References: <20201002114426.31277-1-lukasz.luba@arm.com>
 <d2960f6a-1805-1fb4-98ae-4a756d20370b@arm.com>
 <765e6603-b614-fb72-64ff-248b42474803@linaro.org>
 <b19c1f12-b7cf-fcae-4ebb-617019effe2e@arm.com>
 <55d3fb0f-f7d8-63c5-2bdb-53eaa62380e0@linaro.org>
 <f660731e-132b-2514-f526-d7123ed3522c@arm.com>
 <d04019bd-9e85-5f3e-2a1b-66780b8df3dc@linaro.org>
 <3e3dd42c-48ac-7267-45c5-ca88205611bd@arm.com>
 <00ceec64-3273-bb4a-6f38-22de8d877ab5@linaro.org>
 <CAJZ5v0hV8fwRnADdjiiF=zapO3AE6=_W_PeOQ_WhUirCcFkgdA@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAJZ5v0hV8fwRnADdjiiF=zapO3AE6=_W_PeOQ_WhUirCcFkgdA@mail.gmail.com>
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

On Thursday 15 Oct 2020 at 15:40:16 (+0200), Rafael J. Wysocki wrote:
> On Thu, Oct 15, 2020 at 12:22 PM Daniel Lezcano
> <daniel.lezcano@linaro.org> wrote:
> >
> > On 15/10/2020 11:00, Lukasz Luba wrote:
> >
> > [ ... ]
> >
> > >> There is the SCMI and the DT. Because there are two sources where it is
> > >> impossible to know if they are using the same units, we are stuck to
> > >> ensure a consistency for the kernel.
> > >>
> > >> The platform should use:
> > >>   - the SCMI only (scaled or real)
> > >>   - the DT only (real)
> > >>   [ - the firmware file only (scaled or real) ]
> > >>
> > >
> > > Do you mean by SCMI - registration using em_dev_register_perf_domain() ?
> >
> > It was high level description, but yes, I guess it is the case.
> >
> > >> As it is not possible to know if they are scaled or real, there is no
> > >> choice except making them mutually exclusive.
> > >
> > > So you propose a bit more restriction in registration EM, to not get
> > > lost in the future. I also have these doubts. Let's consider it and
> > > maybe agree.
> > >
> > > I've recommended Qcom to use em_dev_register_perf_domain() when they
> > > have this obfuscated power values. Then any developer in the future
> > > who wants to add EM for a new device on that platform, should use the
> > > em_dev_register_perf_domain().
> > >
> > > In this case the flag in EM that you have proposed makes sense.
> > > We probably need an argument 'bool abstract_scale' in the
> > > em_dev_register_perf_domain(..., bool abstract_scale)
> > > as a source of information.
> >
> > I was suggesting to add a flag to the em_perf_domain structure giving
> > the source of the power numbers.
> >
> > So if the IPA is having the 'sustainable-power' set in DT but the
> > em_perf_domain is flagged with power number coming from SCMI, then they
> > will be incompatible, the thermal zone will fail to register.
> >
> >
> > > We would allow to co-exist em_dev_register_perf_domain(..., false)
> > > with dev_pm_opp_of_register_em() EM devices.
> > >
> > > Is it make sense?
> >
> > Well, it does not change my opinion. We should assume the energy model
> > is always milliwatts. If the SoC vendors find a way to get around with
> > bogoWatts, then good to them and up to them to deal with in the future.
> 
> That sounds fair enough, but it also means that any kernel patches
> using power units different from milliwatts for the EM should be
> rejected in the future, doesn't it?
> 
> And the existing code using different power units for the EM (if any)
> should be updated/fixed accordingly, shouldn't it?
> 
> Otherwise I don't see now this can be regarded as a hard rule.

Sorry, jumping late in the discussion :)

To add a bit of background to this, it's been the plan from the very
beginning to make PM_EM use an abstract scale. The only reason it was
not merged like that is because the first version only worked for CPUs,
and IPA was using a totally different source for other devices. So we
had no choice but to specify PM_EM in mW to keep things compatible and
allow to transition IPA. But that is no longer true, so I'm in favor of
evolving PM_EM where it was supposed to be to begin with.

IMO, the only thing the kernel cares about is consistency across power
numbers, but not about the exact unit. And I agree with Rafael, we have
code paths in the kernel that feed data in PM_EM but _cannot_ guarantee
mW, SCMI being a prime example, so I don't think it is reasonable to
mandate that.

Having that properly documented + an 'abstract_scale' parameter in
dev_pm_opp_of_register_em() (or even a unit, which could be bogo-watts)
should work IMO. What is the concern with this approach?

Thanks,
Quentin
