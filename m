Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 160A431FBB9
	for <lists+linux-pm@lfdr.de>; Fri, 19 Feb 2021 16:13:07 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229571AbhBSPMv (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Fri, 19 Feb 2021 10:12:51 -0500
Received: from mail-ot1-f42.google.com ([209.85.210.42]:39041 "EHLO
        mail-ot1-f42.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229498AbhBSPMu (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Fri, 19 Feb 2021 10:12:50 -0500
Received: by mail-ot1-f42.google.com with SMTP id d7so5345041otq.6
        for <linux-pm@vger.kernel.org>; Fri, 19 Feb 2021 07:12:35 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=g9HQMxLvqX9mv3FzMFZoZFYYKJbLRvBBAfhN+2IXXWE=;
        b=fhZUzCBk9ES7bFZ4h1JkJYtuOmlayR+8EPJ2LHfn3RgYr10BQG6ZjhILUKMVR4cJjv
         tKftQ/EzSfXdpv1r3bkwLh+sCj7f7KOEcapc1hwMkF0GFIW5JkTxWzuXhl8ZqtSQkk4l
         agYGQa3quMezPrrGnlIuNiBfPb9Os3e4UxlJFvYrmgVPHGEhjBv/MRZAUJwvWA0prwO+
         /mvrQhse4pgwOIBIA3oTq3LEp1jQoVFkGWmgIVsvenXYC1OF8flUtS72xTUSZw3dMXBB
         2ZsFVMUR7WJG+CWpD9uSEhYrzORHFbw8LpetPNTqvJAzaP48soEhGpadSgDqlK9nHcjx
         rOyQ==
X-Gm-Message-State: AOAM531TL/E3FsW3ZZopO2MsVnowJEnpA4IZS8zwKtNFuhAOmQBiuO/u
        Tz4Bmd3qsxicUQYhHOvxkioFlzxjvE2Y2l9qZME=
X-Google-Smtp-Source: ABdhPJyuyAzbZ1QsUBYK2XLFfqvln4kIlA35RGg3MBCrhzRZzFaM1up5I78nghPnu45DhVNt6/x7CBrQBmOOGcYDr5c=
X-Received: by 2002:a05:6830:2466:: with SMTP id x38mr6559876otr.206.1613747529822;
 Fri, 19 Feb 2021 07:12:09 -0800 (PST)
MIME-Version: 1.0
References: <20210218090132.1556-1-zbestahu@gmail.com> <20210218090802.x2znazuw7fxnvhtn@vireshk-i7>
In-Reply-To: <20210218090802.x2znazuw7fxnvhtn@vireshk-i7>
From:   "Rafael J. Wysocki" <rafael@kernel.org>
Date:   Fri, 19 Feb 2021 16:11:58 +0100
Message-ID: <CAJZ5v0i7gNCqX-6UmE_+gBb2OkTqierd3=Q3f_+fVjew2fWi1g@mail.gmail.com>
Subject: Re: [PATCH] cpufreq: schedutil: Remove the needless sg_policy
 parameter to ignore_dl_rate_limit()
To:     Viresh Kumar <viresh.kumar@linaro.org>, Yue Hu <zbestahu@gmail.com>
Cc:     "Rafael J. Wysocki" <rjw@rjwysocki.net>,
        Ingo Molnar <mingo@redhat.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Juri Lelli <juri.lelli@redhat.com>,
        Vincent Guittot <vincent.guittot@linaro.org>,
        Dietmar Eggemann <dietmar.eggemann@arm.com>,
        Steven Rostedt <rostedt@goodmis.org>,
        Benjamin Segall <bsegall@google.com>,
        Mel Gorman <mgorman@suse.de>,
        Daniel Bristot de Oliveira <bristot@redhat.com>,
        Linux PM <linux-pm@vger.kernel.org>,
        Yue Hu <huyue2@yulong.com>, zbestahu@163.com
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

On Thu, Feb 18, 2021 at 10:24 AM Viresh Kumar <viresh.kumar@linaro.org> wrote:
>
> On 18-02-21, 17:01, Yue Hu wrote:
> > From: Yue Hu <huyue2@yulong.com>
> >
> > Since sg_policy is a member of struct sugov_cpu. Also remove the local
> > variable in sugov_update_single_common() to make the code more clean.
> >
> > Signed-off-by: Yue Hu <huyue2@yulong.com>
> > ---
> >  kernel/sched/cpufreq_schedutil.c | 12 +++++-------
> >  1 file changed, 5 insertions(+), 7 deletions(-)
>
> Acked-by: Viresh Kumar <viresh.kumar@linaro.org>

Applied as 5.12-rc material, thanks!
