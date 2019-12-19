Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id A367A125D31
	for <lists+linux-pm@lfdr.de>; Thu, 19 Dec 2019 10:04:18 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726609AbfLSJES (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Thu, 19 Dec 2019 04:04:18 -0500
Received: from mail-ot1-f68.google.com ([209.85.210.68]:36985 "EHLO
        mail-ot1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726599AbfLSJER (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Thu, 19 Dec 2019 04:04:17 -0500
Received: by mail-ot1-f68.google.com with SMTP id k14so6357845otn.4;
        Thu, 19 Dec 2019 01:04:17 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=D6QwxL5ClmQL4963/vA00A1Z54S2MxdwBMrb2WwDQJM=;
        b=lUGzeUYMhQYRQ1hwnz1wkac/WdshW3PxupG3ojWF8FTpofqW50HGoBg66jUhYwL7Av
         kYWAfsO/tGMqu9pvTx8DWaQ30dFNQ960qrkOBYslWqo5gK8mJf2RONfPFS/i7z8iixAY
         4e349JkE1rpdrObKEs14n6vTP3tnJ+1h5Ijzyx8DQoHysGsqdpSJrrAHxlRcK9EIPKMt
         CR/BLGfsgDXI5SNl18mdzvm6bfzTCHeI/mbDtEkMr38e5om+2X2anZ3c+8iT4Wqq/Y5t
         Zkoe21EItNY5cmD+VZ2C+IYxdVgp59Q4IsgHnShn0BZ9A9fy3OiyA0MDJdCSpY9DF3JQ
         v6sg==
X-Gm-Message-State: APjAAAXn8DkhekqLs2GSdEL6gSKlVlaPQ8ybMrnGOlZQSkPF1i5LgiJZ
        H3VHWovUi3+l7tVW6A1lKG45BgrP5KN0aHPQEGk=
X-Google-Smtp-Source: APXvYqxvtmzZrthi55RZESVFF79UCbetBABF1q44daYEavcKPrTABMYDhSDR84TWl4LOGpRuihuWcoxcT7mLKXxlFqU=
X-Received: by 2002:a05:6830:4b9:: with SMTP id l25mr7909990otd.266.1576746256795;
 Thu, 19 Dec 2019 01:04:16 -0800 (PST)
MIME-Version: 1.0
References: <20191217143834.19797-1-huntbag@linux.vnet.ibm.com>
 <CAJZ5v0jmMwRGDY70EV3sqpw7uJ4R+VomoWtJ9rWzNTVuV3AUxQ@mail.gmail.com> <CAOSf1CF9F1iViKCCoJXOPmkbj+kLXnJJz5b5B7xLgrLpCZoB3w@mail.gmail.com>
In-Reply-To: <CAOSf1CF9F1iViKCCoJXOPmkbj+kLXnJJz5b5B7xLgrLpCZoB3w@mail.gmail.com>
From:   "Rafael J. Wysocki" <rafael@kernel.org>
Date:   Thu, 19 Dec 2019 10:04:05 +0100
Message-ID: <CAJZ5v0iMutsf1UK+01dsZa1WDZAVK_fvOZJ-2FgiYXwWDqdnig@mail.gmail.com>
Subject: Re: [RFC] cpuidle : Add debugfs support for cpuidle core
To:     "Oliver O'Halloran" <oohall@gmail.com>
Cc:     "Rafael J. Wysocki" <rafael@kernel.org>,
        Abhishek Goel <huntbag@linux.vnet.ibm.com>,
        Linux PM <linux-pm@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        "Rafael J. Wysocki" <rjw@rjwysocki.net>,
        Daniel Lezcano <daniel.lezcano@linaro.org>,
        "Gautham R. Shenoy" <ego@linux.vnet.ibm.com>,
        Michael Ellerman <mpe@ellerman.id.au>,
        Vaidyanathan Srinivasan <svaidy@linux.ibm.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

On Wed, Dec 18, 2019 at 3:26 PM Oliver O'Halloran <oohall@gmail.com> wrote:
>
> On Wed, Dec 18, 2019 at 3:51 AM Rafael J. Wysocki <rafael@kernel.org> wrote:
> >
> > On Tue, Dec 17, 2019 at 3:42 PM Abhishek Goel
> > <huntbag@linux.vnet.ibm.com> wrote:
> > >
> > > Up until now, we did not have a way to tune cpuidle attribute like
> > > residency in kernel. This patch adds support for debugfs in cpuidle core.
> > > Thereby providing support for tuning cpuidle attributes like residency in
> > > kernel at runtime.
> >
> > This is not a good idea in my view, for a couple of reasons.
> >
> > First off, if the target residency of an idle state is changed, it
> > effectively becomes a different one and all of the statistics
> > regarding it become outdated at that point.  Synchronizing that would
> > be a pain.
> >
> > Next, governors may get confused if idle state parameters are changed
> > on the fly.  In particular, the statistics collected by the teo
> > governor depend on the target residencies of idle states, so if one of
> > them changes, the governor needs to be reloaded.
> >
> > Next, idle states are expected to be ordered by the target residency
> > (and by the exit latency), so their parameters cannot be allowed to
> > change freely anyway.
> >
> > Finally, the idle state parameters are expected to reflect the
> > properties of the hardware, which wouldn't hold any more if they were
> > allowed to change at any time.
>
> Certainly does sound like a headache.
>
> > > For example: Tuning residency at runtime can be used to quantify governors
> > > decision making as governor uses residency as one of the parameter to
> > > take decision about the state that needs to be entered while idling.
> >
> > IMO it would be better to introduce a testing cpuidle driver with an
> > artificial set of idle states (or even such that the set of idle
> > states to be used by it can be defined by the user e.g. via module
> > parameters) for this purpose.
>
> The motivation for this patch isn't really a desire to test / tune the
> governor. It's intended to allow working around a performance problem
> caused by using high-latency idle states on some interrupt heavy GPU
> workload. The interrupts occur around ~30ms apart which is long enough
> for the governor to put the CPU into the deeper states and over the
> course of long job the additional wakeup latency adds up. The initial
> fix someone came up with was cooking the residency values so the
> high-latency states had a residency of +50ms to prevent the govenor
> from using them. However, that fix is supposed to go into a bit of
> firmware I maintain and I'm not terribly happy with the idea. I'm
> fairly sure that ~30ms value is workload dependent and personally I
> don't think firmware should be making up numbers to trick specific
> kernel versions into doing specific things.
>
> My impression is the right solution is to have the GPU driver set a PM
> QoS constraint on the CPUs receiving interrupts while a job is
> on-going.

Yes, that would address the GPU problem.

> However, interrupt latency sensitivity isn't something
> that's unique to GPUs so I'm wondering it it makes sense to have the
> governor factor in interrupt traffic when deciding what state to use.
> Is that something that's been tried before?

Yes, that is in the works.

The existing governors should take interrupts into account too in the
form of the expected idle duration corrections, but that may not be
particularly precise.  If the governor currently in use (I guess menu)
doesn't to that, you may try an alternative one (e.g. teo).

That said, work is in progress on taking the actual interrupt
frequency into account in idle duration prediction.

Thanks!
