Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 3153C752FA
	for <lists+linux-pm@lfdr.de>; Thu, 25 Jul 2019 17:39:58 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727081AbfGYPj4 (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Thu, 25 Jul 2019 11:39:56 -0400
Received: from mail-ua1-f65.google.com ([209.85.222.65]:46743 "EHLO
        mail-ua1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728710AbfGYPjy (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Thu, 25 Jul 2019 11:39:54 -0400
Received: by mail-ua1-f65.google.com with SMTP id o19so20018048uap.13
        for <linux-pm@vger.kernel.org>; Thu, 25 Jul 2019 08:39:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=zUSY0yNX7mjAe5hgCsuzMt6JoI+T3veQET0Qe3Sg7bs=;
        b=nmCIp8hqFv2u364QTeF1hoE1hDHQBhUlMI7TLjTtUqlM+25nPEpVMXgqAJLBrL8W0E
         KIj2AH3i+7XfPuNPCPGSvPkgR0tOh0YPzOZGrx8Hwrh+I0lAOo36NobtMFOnjg6kl3YJ
         Qk+Lxh1O2J1WrPHMivAvH/rBYsTe2Iw+lYFPQ=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=zUSY0yNX7mjAe5hgCsuzMt6JoI+T3veQET0Qe3Sg7bs=;
        b=iNZxegIlkEMh0dRVXSPHe7uzyj3oJ5Oc55taHNVjAnR48GwHd0P66Hn5l3l3rMbPBY
         +2Y/l54bl/2pvipvwf9qX/mKVB0WSzfKIyv/DpSvef1qlHKikJqPRX/cQA84uBDz8FLL
         PmWRO9yTErkjzhGOwIMaSkFq989O+zb+4Mp3K+5KxdLz3gfhXaZdVobvVJS3vFp+F9fT
         TPvNBzKhhtgoL8eBk9d+/cAqlSfrGphB1CzDHKFFQlzosJOJkX5ERWgjpUY2zl/gcv/F
         O1BppXeJCFO47qqR6Py9EeCnsA9go97Ee3c9+u4MhCkw7dX7jLM475hAd/tN2R/MtU2c
         6FZQ==
X-Gm-Message-State: APjAAAUbweU5mKPvn8kgtuFRipRECj8Wr2UpNa1UNygEl93txyRrsxTb
        YdZs7C7tmylfWWlwDPOW/nwejQlzySI=
X-Google-Smtp-Source: APXvYqyHKcK0tzLkvmPVXy6Tyccc2BrWNu3NeIE3vHKqqSWfw4gq/ENdhfDCtyQoiRaXIXxwgG17Pw==
X-Received: by 2002:ab0:6788:: with SMTP id v8mr11566485uar.48.1564069192345;
        Thu, 25 Jul 2019 08:39:52 -0700 (PDT)
Received: from mail-ua1-f48.google.com (mail-ua1-f48.google.com. [209.85.222.48])
        by smtp.gmail.com with ESMTPSA id c123sm12557633vkb.23.2019.07.25.08.39.51
        for <linux-pm@vger.kernel.org>
        (version=TLS1_3 cipher=AEAD-AES128-GCM-SHA256 bits=128/128);
        Thu, 25 Jul 2019 08:39:51 -0700 (PDT)
Received: by mail-ua1-f48.google.com with SMTP id 34so20023607uar.8
        for <linux-pm@vger.kernel.org>; Thu, 25 Jul 2019 08:39:51 -0700 (PDT)
X-Received: by 2002:ab0:1391:: with SMTP id m17mr52819855uae.90.1564069190798;
 Thu, 25 Jul 2019 08:39:50 -0700 (PDT)
MIME-Version: 1.0
References: <20190722215340.3071-1-ilina@codeaurora.org> <20190722215340.3071-2-ilina@codeaurora.org>
 <5d3769df.1c69fb81.55d03.aa33@mx.google.com> <20190724145251.GB18620@codeaurora.org>
 <5d38b38e.1c69fb81.e8e5d.035b@mx.google.com> <20190724203610.GE18620@codeaurora.org>
 <CAD=FV=UYj55m99EcQXmkYhs257A46x8DaarE0DC-GRF_3dY3-Q@mail.gmail.com> <20190725151851.GG18620@codeaurora.org>
In-Reply-To: <20190725151851.GG18620@codeaurora.org>
From:   Doug Anderson <dianders@chromium.org>
Date:   Thu, 25 Jul 2019 08:39:30 -0700
X-Gmail-Original-Message-ID: <CAD=FV=X2ENqt5+vdUoRnLTRbedj_sFdQD3Me-yYEW0fDOdBCvg@mail.gmail.com>
Message-ID: <CAD=FV=X2ENqt5+vdUoRnLTRbedj_sFdQD3Me-yYEW0fDOdBCvg@mail.gmail.com>
Subject: Re: [PATCH V2 2/4] drivers: qcom: rpmh-rsc: avoid locking in the
 interrupt handler
To:     Lina Iyer <ilina@codeaurora.org>
Cc:     Stephen Boyd <swboyd@chromium.org>, Andy Gross <agross@kernel.org>,
        Bjorn Andersson <bjorn.andersson@linaro.org>,
        linux-arm-msm <linux-arm-msm@vger.kernel.org>,
        "open list:ARM/QUALCOMM SUPPORT" <linux-soc@vger.kernel.org>,
        Rajendra Nayak <rnayak@codeaurora.org>,
        LKML <linux-kernel@vger.kernel.org>,
        Linux PM <linux-pm@vger.kernel.org>, mkshah@codeaurora.org
Content-Type: text/plain; charset="UTF-8"
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

Hi,

On Thu, Jul 25, 2019 at 8:18 AM Lina Iyer <ilina@codeaurora.org> wrote:
>
> On Wed, Jul 24 2019 at 17:28 -0600, Doug Anderson wrote:
> >Hi,
> >
> >On Wed, Jul 24, 2019 at 1:36 PM Lina Iyer <ilina@codeaurora.org> wrote:
> >>
> >> On Wed, Jul 24 2019 at 13:38 -0600, Stephen Boyd wrote:
> >> >Quoting Lina Iyer (2019-07-24 07:52:51)
> >> >> On Tue, Jul 23 2019 at 14:11 -0600, Stephen Boyd wrote:
> >> >> >Quoting Lina Iyer (2019-07-22 14:53:38)
> >> >> >> Avoid locking in the interrupt context to improve latency. Since we
> >> >> >> don't lock in the interrupt context, it is possible that we now could
> >> >> >> race with the DRV_CONTROL register that writes the enable register and
> >> >> >> cleared by the interrupt handler. For fire-n-forget requests, the
> >> >> >> interrupt may be raised as soon as the TCS is triggered and the IRQ
> >> >> >> handler may clear the enable bit before the DRV_CONTROL is read back.
> >> >> >>
> >> >> >> Use the non-sync variant when enabling the TCS register to avoid reading
> >> >> >> back a value that may been cleared because the interrupt handler ran
> >> >> >> immediately after triggering the TCS.
> >> >> >>
> >> >> >> Signed-off-by: Lina Iyer <ilina@codeaurora.org>
> >> >> >> ---
> >> >> >
> >> >> >I have to read this patch carefully. The commit text isn't convincing me
> >> >> >that it is actually safe to make this change. It mostly talks about the
> >> >> >performance improvements and how we need to fix __tcs_trigger(), which
> >> >> >is good, but I was hoping to be convinced that not grabbing the lock
> >> >> >here is safe.
> >> >> >
> >> >> >How do we ensure that drv->tcs_in_use is cleared before we call
> >> >> >tcs_write() and try to look for a free bit? Isn't it possible that we'll
> >> >> >get into a situation where the bitmap is all used up but the hardware
> >> >> >has just received an interrupt and is going to clear out a bit and then
> >> >> >an rpmh write fails with -EBUSY?
> >> >> >
> >> >> If we have a situation where there are no available free bits, we retry
> >> >> and that is part of the function. Since we have only 2 TCSes avaialble
> >> >> to write to the hardware and there could be multiple requests coming in,
> >> >> it is a very common situation. We try and acquire the drv->lock and if
> >> >> there are free TCS available and if available mark them busy and send
> >> >> our requests. If there are none available, we keep retrying.
> >> >>
> >> >
> >> >Ok. I wonder if we need some sort of barriers here too, like an
> >> >smp_mb__after_atomic()? That way we can make sure that the write to
> >> >clear the bit is seen by another CPU that could be spinning forever
> >> >waiting for that bit to be cleared? Before this change the spinlock
> >> >would be guaranteed to make these barriers for us, but now that doesn't
> >> >seem to be the case. I really hope that this whole thing can be changed
> >> >to be a mutex though, in which case we can use the bit_wait() API, etc.
> >> >to put tasks to sleep while RPMh is processing things.
> >> >
> >> We have drivers that want to send requests in atomic contexts and
> >> therefore mutex locks would not work.
> >
> >Jumping in without reading all the context, but I saw this fly by and
> >it seemed odd.  If I'm way off base then please ignore...
> >
> >Can you give more details?  Why are these drivers in atomic contexts?
> >If they are in atomic contexts because they are running in the context
> >of an interrupt then your next patch in the series isn't so correct.
> >
> >Also: when people submit requests in atomic context are they always
> >submitting an asynchronous request?  In that case we could
> >(presumably) just use a spinlock to protect the queue of async
> >requests and a mutex for everything else?
> Yes, drivers only make async requests in interrupt contexts.

So correct me if I'm off base, but you're saying that drivers make
requests in interrupt contexts even after your whole series and that's
why you're using spinlocks instead of mutexes.  ...but then in patch
#3 in your series you say:

> Switch over from using _irqsave/_irqrestore variants since we no longer
> race with a lock from the interrupt handler.

Those seem like contradictions.  What happens if someone is holding
the lock, then an interrupt fires, then the interrupt routine wants to
do an async request.  Boom, right?


> They cannot
> use the sync variants. The async and sync variants are streamlined into
> the same code path. Hence the use of spinlocks instead of mutexes
> through the critical path.

I will perhaps defer to Stephen who was the one thinking that a mutex
would be a big win here.  ...but if a mutex truly is a big win then it
doesn't seem like it'd be that hard to have a linked list (protected
by a spinlock) and then some type of async worker that:

1. Grab the spinlock, pops one element off the linked list, release the spinlock
2. Grab the mutex, send the one element, release the mutex
3. Go back to step #1.

This will keep the spinlock held for as little time as possible.


-Doug
