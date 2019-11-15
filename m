Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id D88F8FDC7F
	for <lists+linux-pm@lfdr.de>; Fri, 15 Nov 2019 12:46:20 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727122AbfKOLqT (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Fri, 15 Nov 2019 06:46:19 -0500
Received: from mail-oi1-f196.google.com ([209.85.167.196]:36074 "EHLO
        mail-oi1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727254AbfKOLqT (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Fri, 15 Nov 2019 06:46:19 -0500
Received: by mail-oi1-f196.google.com with SMTP id j7so8374726oib.3;
        Fri, 15 Nov 2019 03:46:19 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=xFqS/qZz0IFP6XdyI3eRL4Ng99szmuHxo7BYforgxcw=;
        b=jh5jbtMb0NXm9Vvrwf9neWAM3gCpT51X7iGRukk+0/+6NbdOqW4CtSHykinvWzUx6r
         hjpA/+WJ2yTq6HU28P2Bo36hNMLB8uoNxsFOrUu6TvW5GOLS1aqVklUpEzFGDNOwCnfr
         5GNGnFCv+gn3BCdRohkLXHQxak0RkOvRItYa6MAFStViGg0b+w81FZ64bduWHXRWLqDT
         7vAQg3Ev/YoGmDGfEfBWyiC33JtIeftt4ikf7xNCNstKnMFJiWM7Xik7I3KCX5XQtTn+
         F4VBmO547gY29TpZpYLrrlNKvPpGacrSynbSPseKxhBZENs7PwXMP9M0N3VTwjfHDkJj
         fh+Q==
X-Gm-Message-State: APjAAAVh0ehWU7P13HRv68Ii26VFr7WjkF3BlW5y10rPNTd+kKS8GiSc
        /9HUQzddBafYSjnaYdv0NZXZJKchmCwdeUgf6bM=
X-Google-Smtp-Source: APXvYqx73oJAcN5YwdEQcOHXx+83dFzsmmK0zqs/TLO/k3CdjLE3Sho8BRt5Zbj2Du8Xu/eW9AftkdzYHUoWsG6RTJU=
X-Received: by 2002:a05:6808:901:: with SMTP id w1mr7725371oih.57.1573818378589;
 Fri, 15 Nov 2019 03:46:18 -0800 (PST)
MIME-Version: 1.0
References: <1573751251-3505-1-git-send-email-vincent.guittot@linaro.org>
In-Reply-To: <1573751251-3505-1-git-send-email-vincent.guittot@linaro.org>
From:   "Rafael J. Wysocki" <rafael@kernel.org>
Date:   Fri, 15 Nov 2019 12:46:07 +0100
Message-ID: <CAJZ5v0gCffTP-GsmbmjoJ5K7QMk7egYipMiKu+89Q1PAhRyrQA@mail.gmail.com>
Subject: Re: [PATCH v4] sched/freq: move call to cpufreq_update_util
To:     Vincent Guittot <vincent.guittot@linaro.org>
Cc:     Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Ingo Molnar <mingo@redhat.com>,
        Peter Zijlstra <peterz@infradead.org>,
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

On Thu, Nov 14, 2019 at 6:07 PM Vincent Guittot
<vincent.guittot@linaro.org> wrote:
>
> update_cfs_rq_load_avg() calls cfs_rq_util_change() everytime pelt decays,
> which might be inefficient when cpufreq driver has rate limitation.
>
> When a task is attached on a CPU, we have call path:
>
> update_load_avg()
>   update_cfs_rq_load_avg()
>     cfs_rq_util_change -- > trig frequency update
>   attach_entity_load_avg()
>     cfs_rq_util_change -- > trig frequency update
>
> The 1st frequency update will not take into account the utilization of the
> newly attached task and the 2nd one might be discard because of rate
> limitation of the cpufreq driver.

Kind of on a second thought, it shouldn't matter for governors other
than schedutil that the new task's utilization is not taken into
account by the first update, because they measure utilization by
themselves.

> update_cfs_rq_load_avg() is only called by update_blocked_averages()
> and update_load_avg() so we can move the call to
> cfs_rq_util_change/cpufreq_update_util() into these 2 functions. It's also
> interesting to notice that update_load_avg() already calls directly
> cfs_rq_util_change() for !SMP case.
>
> This changes will also ensure that cpufreq_update_util() is called even
> when there is no more CFS rq in the leaf_cfs_rq_list to update but only
> irq, rt or dl pelt signals.

So this change appears to be the relevant one for non-schedutil governors.

Now, there is a rate limit in schedutil too, see
sugov_should_update_freq(), but I'm not sure if that matters in the
context of this patch.
