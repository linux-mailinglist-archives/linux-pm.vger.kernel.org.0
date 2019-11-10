Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 17548F698B
	for <lists+linux-pm@lfdr.de>; Sun, 10 Nov 2019 16:13:29 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726800AbfKJPN2 (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Sun, 10 Nov 2019 10:13:28 -0500
Received: from mail-lj1-f193.google.com ([209.85.208.193]:41699 "EHLO
        mail-lj1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726617AbfKJPN1 (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Sun, 10 Nov 2019 10:13:27 -0500
Received: by mail-lj1-f193.google.com with SMTP id m9so11057765ljh.8
        for <linux-pm@vger.kernel.org>; Sun, 10 Nov 2019 07:13:26 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=lcuaDzTn5xcx3GvRhEsUKRkdeQxQHVuFzpLwf2zUomU=;
        b=ZBl2Q626uvo+qPgSkpC2cJabVplXCzF78qFmX7LeouV/27Y6uldo66xhfgL/qXiOhk
         17GqrrfVdKaUU1PoYyKk4nMu2eq6FFgl+yLOvHDNmV5GLe4sVR4aPLHfyFzlGGN3ZrrM
         bGXRBuUCBQvqjEkF+rNkbjPgNxxrSgamRzUbgmmuv9CtRvJ16YmjQyxzmgLKJu0Y0md7
         k7hahzuHJzZwjt5U0/+qSjoqJ6GYNjTLUwKNEMfspSvEcSqvns/YMBelHzfKpKaoJxaf
         30YfYrheitZ/0MXy1KapL+0m2lBWQVURjwT9VWd7aDHupaJTytnxu+OcMPLP9IXfAhm3
         pN6A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=lcuaDzTn5xcx3GvRhEsUKRkdeQxQHVuFzpLwf2zUomU=;
        b=XdBjmefrYymiLXIvrhlZAshzeM5sYjAoV9HofM1Hqw/eZyZB2WtSbSETuGf6cTjAXK
         FmG0++qmLVBtm9K+anJEkxJ+EqjIvGVpkTVzoXcpxee8bRQpHjrcx00owzK4jF6B/loy
         JCj71eZYtvrt4yn5QxMfBZp6jgOBg2Chxo8pqvX+0bK2tYFjdf/IqTmQECWBexKK3DwV
         oB7fVa42x56fbaUZNy+38z0XOpdJ3fCp/EfYTeIbOBaizo/d5UVL7du8aFvyZ/PNOFj1
         0O8s0pbHClQxMQfpu0wHXRiAuY6smyeEIg1/ooaF/kcj2K8IuIxKOKSdMyQ6NFwdUskq
         7WbQ==
X-Gm-Message-State: APjAAAVXPibQPVDJtiSlnfvL8dS3uJWmb3AHHMtBJXNpLts5DxwIk4ti
        /YzBn2PixD75iN2akovNC/NXPLHitxT0vGLGzAf/9w==
X-Google-Smtp-Source: APXvYqz4nQCQX2bf/HJVWQsssPaerxtaX085BJbf2h0MeAOyO8y6e4BeuELkHjJPLJ9vPB+D8crG16Tsaxzu6xA3ARE=
X-Received: by 2002:a05:651c:28a:: with SMTP id b10mr12768619ljo.193.1573398805894;
 Sun, 10 Nov 2019 07:13:25 -0800 (PST)
MIME-Version: 1.0
References: <1572018904-5234-1-git-send-email-dsmythies@telus.net>
 <CAKfTPtDFAS3TiNaaPoEXFZbqdMt_-tfGm9ffVcQAN=Mu_KbRdQ@mail.gmail.com>
 <000c01d58bca$f5709b30$e051d190$@net> <CAKfTPtDx6nu7YtYN=JLRAseZS3Q6Nt-QdMQuG_XoUtmtR_101A@mail.gmail.com>
 <001201d58e68$eaa39630$bfeac290$@net> <20191029160210.GA8343@linaro.org>
 <000001d58f2a$fc593200$f50b9600$@net> <CAKfTPtCjhYKttEuWs9cqicUdJMiJVy5he+=xWofof_4xAWgKAw@mail.gmail.com>
 <20191108091834.GA24402@linaro.org> <000001d5971d$57a90c80$06fb2580$@net>
In-Reply-To: <000001d5971d$57a90c80$06fb2580$@net>
From:   Vincent Guittot <vincent.guittot@linaro.org>
Date:   Sun, 10 Nov 2019 16:13:14 +0100
Message-ID: <CAKfTPtA6+stq0heDa6r29Tyi2D9qEX9KZRcR8J0qw3vp6mdcMg@mail.gmail.com>
Subject: Re: [PATCH] Revert "sched/fair: Fix O(nr_cgroups) in the load
 balancing path"
To:     Doug Smythies <dsmythies@telus.net>
Cc:     linux-kernel <linux-kernel@vger.kernel.org>,
        "open list:THERMAL" <linux-pm@vger.kernel.org>,
        Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@kernel.org>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Sargun Dhillon <sargun@sargun.me>, Tejun Heo <tj@kernel.org>,
        Xie XiuQi <xiexiuqi@huawei.com>, xiezhipeng1@huawei.com,
        Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>,
        Rik van Riel <riel@surriel.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

Hi Doug,

On Sat, 9 Nov 2019 at 17:47, Doug Smythies <dsmythies@telus.net> wrote:
>
> Hi Vincent,
>
> Thank you for your item 2 patch.
>
> On 2019.11.08 01:19 Vincent Guittot wrote:
> ...
> >> I have to prepare a patch for this part which is item 2
> >
> > I have finally been able to prepared the patch for item 2. Could you check
> > that it also fixes your problem ?
> ...
> > We can still have some spurious call to cpufreq_util_change in
> > update_blocked_average() with this patch but at least the value will be
> > up to date in both calls, which was not the case before. If this fix
> > Doug's problem, I can prepare an additional one to fix the spurious call
> > but I wanted to make sure that this fix the problem first.
>
> Yes, the issue is solved with this patch.

Thanks for your tests

> I do wonder if I am seeing the effect of the spurious calls.

I don't think so because the spurious calls are in fact a 2nd call
during the same update_blocked_average and from what i have seen ,
intel pstate driver filter call when there is less than 3 or 10ms
between the 2 calls

>
> Details:
>
> Test 1: an 8000 second trace during system idle:
> Maximum duration: 4.00015 seconds. Good.
> Typically, there would have been about 300 durations
> of over 10 seconds in 8000 seconds.
> Number of calls to driver: 103168, which is about 8% more than
> the previous experimental solution.
> (Should be repeated a few times to verify repeatability, but
> not going to.)
>
> Test 2: one 8000 second energy sample, for high accuracy idle power:
> 3.703 watts which is about +0.7% idle power increase.
>
> Test 3: The load-no-load test with only idle state 1 enabled:
> There was never an excessive energy sample for the no load samples.
> The test ran for about 8 hours.
> Maximum: 9.49 watts
> Minimum: 9.13 watts
> Recall that with the issue, the max would have been about 14 watts
>
> Kernel: 5.4-rc6 + your items 1 and item 2 patches.
> Idle governor = menu, because teo fixes are still pending.
> Note: some reference data is from kernel 5.4-rc2, and really
> should have been re-done with 5.4-rc6 as the baseline.
>
> ... Doug
>
>
