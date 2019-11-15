Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id C1298FDBF3
	for <lists+linux-pm@lfdr.de>; Fri, 15 Nov 2019 12:06:10 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727274AbfKOLGJ (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Fri, 15 Nov 2019 06:06:09 -0500
Received: from mail-lj1-f194.google.com ([209.85.208.194]:46980 "EHLO
        mail-lj1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726983AbfKOLGJ (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Fri, 15 Nov 2019 06:06:09 -0500
Received: by mail-lj1-f194.google.com with SMTP id e9so10218369ljp.13
        for <linux-pm@vger.kernel.org>; Fri, 15 Nov 2019 03:06:06 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=shq3V/ue0af5VG0Uxhe+EhaqYoTx4YdTo+9ySK44k0o=;
        b=Nt1cvHlNqQgeHmvi9R72Of3lIXCieP0osFMIeTaE/doM7/x3/kEP0XJPKtQ29bvRmF
         79k/Yyu+Okilh9P44v0tvQ0dzqRyBN9BpR0kKgWFOiL6a/VqS1uXSiUNSH9uPILvgOrT
         YapkLcQWFUBRNmuXweWg//5qSltKeulsANa9LMM+2cWrYrtcyrM9/7Jm5UU/a1qF/Qto
         QKIsxLAoBnU5M77FaH9uO0bD3c8Yv/gEOhCrtitC0oc2KvU8DNvLdz8k+eBy0SSD8UGO
         uM8/z5Yil8RSNCvVMZTlB9WKcja2Bf6ijGCjuHRpBSiBlGTJBmEjITBx91FOCeKwxcgZ
         Whsw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=shq3V/ue0af5VG0Uxhe+EhaqYoTx4YdTo+9ySK44k0o=;
        b=OG56PRn8auImVGb0CVnPBNqenz7qRsQFSxTBGMq0FGkaMRLscwfZ4gqhc7UO3r5eIo
         9QVgUC6gRlzGgSaOJ/aml+bVIV12DvaDlLxWP16RtJAivZ5KOG8/RmK/Dz7MCeld7cpk
         wNMBVbeZW5gLJ80fO6GpgT0G4uBxF9LFtKvJSH5eVqz2kH1V3Ke6TxhWZGijEsWQBPuq
         aJ+wBeysMnHu/Yb15K4WvGkOB4YnCzLejP9s4K/FN5a1AKlccibZXwvouhDrsz41l6Q1
         UKRMFmU6wOEhJmeQ1EmOqmeIL/UmR9Clckkmz7oxA6s2e0yHBDC2QuveCk0YwkC6JdnP
         6wiA==
X-Gm-Message-State: APjAAAViJTicrAhL53kcOw9gM1l9QUiXuhcn9w/YZVcXPa1XjXwIn0xU
        KxLD/G7bUgNf1LVKrdWkSLIZrGdBXcq2VcAupr57hw==
X-Google-Smtp-Source: APXvYqzS1EIkNYVvmw564gwWMYzpaZj7xXThYxA72Qt1a8gJgwDQEbyZRfy73qyedSN3eTDxq9/BRrbFbF6ApF6ydh8=
X-Received: by 2002:a2e:982:: with SMTP id 124mr11018244ljj.48.1573815965102;
 Fri, 15 Nov 2019 03:06:05 -0800 (PST)
MIME-Version: 1.0
References: <1573751251-3505-1-git-send-email-vincent.guittot@linaro.org>
 <20191115095447.GU4114@hirez.programming.kicks-ass.net> <CAJZ5v0hjsWM=bRg4k2qNCfcqjQ08N+6kG=1vCXpjbi5qEx7utw@mail.gmail.com>
 <20191115104052.GF4131@hirez.programming.kicks-ass.net>
In-Reply-To: <20191115104052.GF4131@hirez.programming.kicks-ass.net>
From:   Vincent Guittot <vincent.guittot@linaro.org>
Date:   Fri, 15 Nov 2019 12:05:52 +0100
Message-ID: <CAKfTPtBWrpT+jEFo0Jy+WhX+CSQ4rOL_Hbkzhy4nwcEARh9CFw@mail.gmail.com>
Subject: Re: [PATCH v4] sched/freq: move call to cpufreq_update_util
To:     Peter Zijlstra <peterz@infradead.org>
Cc:     "Rafael J. Wysocki" <rafael@kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Ingo Molnar <mingo@redhat.com>,
        Dietmar Eggemann <dietmar.eggemann@arm.com>,
        Juri Lelli <juri.lelli@redhat.com>,
        Steven Rostedt <rostedt@goodmis.org>,
        Mel Gorman <mgorman@suse.de>,
        Doug Smythies <dsmythies@telus.net>,
        Linux PM <linux-pm@vger.kernel.org>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Sargun Dhillon <sargun@sargun.me>, Tejun Heo <tj@kernel.org>,
        Xie XiuQi <xiexiuqi@huawei.com>, xiezhipeng1@huawei.com,
        Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

On Fri, 15 Nov 2019 at 11:41, Peter Zijlstra <peterz@infradead.org> wrote:
>
> On Fri, Nov 15, 2019 at 11:03:20AM +0100, Rafael J. Wysocki wrote:
> > On Fri, Nov 15, 2019 at 10:55 AM Peter Zijlstra <peterz@infradead.org> wrote:
>
> > > So why are we making the scheduler code more ugly instead of fixing that
> > > driver?
> >
> > I guess we could "fix" the driver by making it rate limit MSR writes
> > only, but I'm not sure if that would help.
>
> So it is not clear to me what exactly intel_pstate needs and why. Like I
> wrote in my reply to Vincent just now, it can still store the last
> value, even if it doesn't act on it right away.
>
> And it can then act on that stored value at a later event, whatever is
> appropriate.
>
> I'm just saying that generating superfluous events is silly. But
> possibly I read the patch wrong.

This is not the intent of the patch.

Before 039ae8bcf7a5 ("sched/fair: Fix O(nr_cgroups) in the load
balancing path"), the call to cpufreq was done thanks to
update_cfs_rq_load_avg() even if cfs was already null but not irq/rt
or dl
After the patch, cpufreq was not called anymore

This patch fix this to make sure that cpufreq is called while  irq/rt
or dl is not null

Then, it also remove a spurious call to cpufreq just before attaching the task
