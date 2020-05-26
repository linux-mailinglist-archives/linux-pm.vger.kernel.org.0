Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 019801E2940
	for <lists+linux-pm@lfdr.de>; Tue, 26 May 2020 19:42:26 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388654AbgEZRmZ (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Tue, 26 May 2020 13:42:25 -0400
Received: from mail-ot1-f67.google.com ([209.85.210.67]:41844 "EHLO
        mail-ot1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2388499AbgEZRmZ (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Tue, 26 May 2020 13:42:25 -0400
Received: by mail-ot1-f67.google.com with SMTP id 63so17016717oto.8;
        Tue, 26 May 2020 10:42:24 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=SmxTWFXXM8Y+h9jTDITVUIXUE4Zfd86HNcIQXeGrsvg=;
        b=lZCtJr2r84UqdgbPW+lqqg9NsydVGA70wLSWXVu3D70BjVEedy9OfaIxwH4qKgaRzd
         eNZ4aeZaoVxdk4yBgK9U8qZHshJ9jIwHYAU/mmG9iavJF/Ug1IIsPpCJeKJTAZprXRQx
         GytE4bEri7yRY617WiFoMA+Y90Adtd0vSSiI413qdfgHno6Orez+gpnoq8vu1LyS0qhD
         mZy0VLzLYZxxeBN4sE23QrWzajBfIRcZzxH/4KhIt/GbJH+IOAQ9RJ5Fh+eX8fzLnc2f
         Y3unTa4xI35mIgmnX2a5JZWEmvL/vAEQqJbtRleY62Ha1S8j+Uq6mRbUUHTWvBc/nymE
         Uvgg==
X-Gm-Message-State: AOAM531uyGjw3UUo95m1BI752ooP/UQtVMLc24thDGhZDlAnzTRByXuS
        1FxzZD+gP6Svj7vFTRyuctnT1bLnUV/ytIoULP4=
X-Google-Smtp-Source: ABdhPJwFFP4P8gdh3vXJm5dZIVmlwwrvCbfa1hsaT/wQPQI9ONnf3VgoTYFCJk9CkNQheEUgN7QsNloQASq382OXMHQ=
X-Received: by 2002:a9d:3d05:: with SMTP id a5mr1722231otc.262.1590514943990;
 Tue, 26 May 2020 10:42:23 -0700 (PDT)
MIME-Version: 1.0
References: <3169564.ZRsPWhXyMD@kreacher> <87mu5wre1v.fsf@intel.com>
 <CAJZ5v0hBiKdDQJjdcuV72+3jCOZPNekmGxdtod-f9Sgwc_7D+g@mail.gmail.com>
 <87a71vraus.fsf@intel.com> <CAJZ5v0j4EYLej+Xb=huAGTDEH_0mgRShBkjBeib38exmss60Sg@mail.gmail.com>
 <000801d63375$927946a0$b76bd3e0$@net>
In-Reply-To: <000801d63375$927946a0$b76bd3e0$@net>
From:   "Rafael J. Wysocki" <rafael@kernel.org>
Date:   Tue, 26 May 2020 19:42:12 +0200
Message-ID: <CAJZ5v0jSZVGYxQY5pJ89U-XGTwTFciQRuz87a8ekGBDx55WTvw@mail.gmail.com>
Subject: Re: [RFC/RFT][PATCH] cpufreq: intel_pstate: Work in passive mode with
 HWP enabled
To:     Doug Smythies <dsmythies@telus.net>
Cc:     "Rafael J. Wysocki" <rafael@kernel.org>,
        Francisco Jerez <francisco.jerez.plata@intel.com>,
        "Rafael J. Wysocki" <rjw@rjwysocki.net>,
        Linux PM <linux-pm@vger.kernel.org>,
        LKML <linux-kernel@vger.kernel.org>,
        Len Brown <len.brown@intel.com>,
        Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Giovanni Gherdovich <ggherdovich@suse.cz>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

On Tue, May 26, 2020 at 5:51 PM Doug Smythies <dsmythies@telus.net> wrote:
>
> On 2020.05.26 01:19 Rafael J. Wysocki wrote:
> >  to On Mon, May 25, 2020 at 10:57 PM Francisco Jerez
> > > "Rafael J. Wysocki" <rafael@kernel.org> writes:
> > > > On Mon, May 25, 2020 at 3:39 AM Francisco Jerez
> > >
> > > Why not HWP_MIN_PERF?  That would leave the HWP quite some room for
> > > maneuvering (the whole HWP_MIN_PERF-HWP_MAX_PERF P-state range, it's not
> > > like P-state selection would be entirely driven by the kernel), while
> > > avoiding every failure scenario I was describing in my previous reply.
>
> I have re-done my tests.
> The problem that I observe seems specific to hwp itself
> and not this patch and it's use in passive mode.
> I see the exact same thing with intel_pstate/powersave.
> [1] detail A.
>
>
> Test: still simple single threaded load sweep,
> at 347 hertz work/sleep frequency.
> What do I see?
>
> Unexpected frequency drops at around 70% load.
> Example, from trace:
>
> First, the thing has been going for awhile at 4.8 GHz.
>
> Old epp ; new epp ; freq GHz; load % ; duration mS
> 80        ; 82      ; 4.57    ; 61.94  ; 20.001
> 82      ; 80    ; 4.57    ; 62.47  ; 40.003
> 80      ; 44      ; 3.73    ;   68.63  ; 62.009  <<<< What? Why freq down? Why long duration?
> 44      ;  0      ; 1.96    ; 100.23 ; 19.995  <<<< Even lower freq. load overruns.
>  0      ; 73      ; 4.56    ; 82.93  ; 40.07   <<<< O.K. recovered, but damage done.
> 73      ; 46      ; 2.36    ;   79.19  ; 20.94   <<< now things oscillate a little.
> 46      ; 0       ; 1.9884  ;   100.24 ; 20.99
>  0      ; 75      ; 4.5624  ;   82.1   ; 41.002  <<< Event ends. Next event in 487 milliseconds.
>
> Observation: Events are often, but not always, preceded by a longer than normal duration.
> However, long durations are also not out of the ordinary in passive mode.
>
> And yes, the above trace was with DELAY_HWP 20,000, but I do have trace examples
> with it at 5,000. This was just a particularly good example.
>
> Observation (from looking at a lot of trace data): There are phase delays
> between the two systems, intel_cpufreq and hwp, and sometimes they seem to
> oscillate a little and fight each other. There maybe some problematic
> work/sleep frequencies where the oscillation builds into a full blown
> resonance.
>
> Why does hwp drop the frequency?
>
> This system is otherwise fairly idle,
> so maybe because the pll drops down during the non work periods.
>
> Maybe HWP thinks the system is idle and drops the frequency.
> I can eliminate the overruns by disabling deep idle states such
> that the PLL vote is never relinquished, but it's not a fair test.
>
> Note that the above response can be "tuned".
> If we take the conversation algorithm from target frequency to EPP
> and introduce and offset, the above can be improved.
>
> At what cost? More sluggishness, for a large positive offset.
> So, the overruns just move from the steady state side of the task to
> when the task starts. I did not find if there is a "sweet spot"
> between offset and system response, and I do not think there is value
> added in trying.
>
> Note: With original settings, I rarely observe a problem with the step
> function response to a new task.
>
> >
> > Actually, I have been thinking about the HWP min as an alternative
> > that may be worth evaluating.
> >
> > However, I would rather set the HWP min to something like 80% if the
> > cpufreq request.
>
> Yes, this is a good idea and should not suffer from the two servo systems
> fighting each other.

OK, thanks for the feedback!

I am about to post this patch.

> I got 0 overruns, verses 2240 overruns with no min limitation (100 second test).
>
> As for INTEL_CPUFREQ_TRANSITION_DELAY_HWP, I'll probably use
> 10 milliseconds moving forward, because that is what I am most
> familiar with from years ago work on the this driver. But, I did
> not observe any issue with 5 milliseconds.

I'm going to use INTEL_CPUFREQ_TRANSITION_DELAY_HWP in the new patch
for now then.

> [1] http://www.smythies.com/~doug/linux/intel_pstate/passive-hwp/passive-hwp-but-active-powersave.png

Thanks!
