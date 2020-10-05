Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 998FA28367B
	for <lists+linux-pm@lfdr.de>; Mon,  5 Oct 2020 15:25:46 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725931AbgJENZm (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Mon, 5 Oct 2020 09:25:42 -0400
Received: from mail-ot1-f68.google.com ([209.85.210.68]:36225 "EHLO
        mail-ot1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725914AbgJENZm (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Mon, 5 Oct 2020 09:25:42 -0400
Received: by mail-ot1-f68.google.com with SMTP id 60so8564019otw.3;
        Mon, 05 Oct 2020 06:25:40 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=VSm7gLjvoXVPW4MRbVep3VxyatFylcoxKzzruY+rFmA=;
        b=InZFc1lYgCZygfhHYk2b4a3MLtsjfM/Kj6YzSOPfbBArMSXZ3yAV/CZ3yH87Amlj29
         9frevE4Yn+Qmx5ldJq1EXqajAaHGNioDWg23yirns3JRk7jCse+ix9S//CwAj8kEFN+Q
         /5nZfSaD8nkQrf+CuY9TabrfbOGHCYVpWBrU2PUYc4ewODK1Mk/lu9C5OzuTWJ0fww2r
         8BR7fMBjWeoz11Z+cfB/SruBkKF+bS+ji+szgp9BFvrNMEDvVnAO90+xYle8Bqkbe8Bi
         JBeJeKnCncCQExaR441NUNrQ/WrrKuF92R8EDnIyuqQ48sjzLtdX9LESwBb4Ifqlsip5
         oYqA==
X-Gm-Message-State: AOAM5329Fia7b/0RdgHWfoKbh+Me13zr47U03PnuHxHPq4VhGJAXCiku
        Kb/pfhP1SbLgzNk4mvM2I6PyGuaobxnfXITkyj0=
X-Google-Smtp-Source: ABdhPJzAhOvM/7gBRkLIamiQt5pp03piG1poAEdBabDBErML+QILbGXZKNRPjGnxftmzHcZgGjAR9Ak294uciO60TmU=
X-Received: by 2002:a9d:734f:: with SMTP id l15mr5055320otk.260.1601904339903;
 Mon, 05 Oct 2020 06:25:39 -0700 (PDT)
MIME-Version: 1.0
References: <cover.1601884370.git.viresh.kumar@linaro.org>
In-Reply-To: <cover.1601884370.git.viresh.kumar@linaro.org>
From:   "Rafael J. Wysocki" <rafael@kernel.org>
Date:   Mon, 5 Oct 2020 15:25:28 +0200
Message-ID: <CAJZ5v0hLyF5G4QR=qQnmsnnjobmV0w62L2ZPLxjKA0dOtdcqkw@mail.gmail.com>
Subject: Re: [PATCH V3 0/5] cpufreq: Record stats with fast-switching
To:     Viresh Kumar <viresh.kumar@linaro.org>
Cc:     Rafael Wysocki <rjw@rjwysocki.net>,
        Ben Segall <bsegall@google.com>,
        Dietmar Eggemann <dietmar.eggemann@arm.com>,
        Ingo Molnar <mingo@redhat.com>,
        Juri Lelli <juri.lelli@redhat.com>,
        Mel Gorman <mgorman@suse.de>,
        Peter Zijlstra <peterz@infradead.org>,
        Steven Rostedt <rostedt@goodmis.org>,
        Vincent Guittot <vincent.guittot@linaro.org>,
        Linux PM <linux-pm@vger.kernel.org>,
        Lukasz Luba <lukasz.luba@arm.com>, cristian.marussi@arm.com,
        Sudeep Holla <sudeep.holla@arm.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

On Mon, Oct 5, 2020 at 9:56 AM Viresh Kumar <viresh.kumar@linaro.org> wrote:
>
> Hi,
>
> We disabled recording cpufreq stats when fast switching was introduced
> to the cpufreq core as the cpufreq stats required to take a spinlock and
> that can't be allowed (for performance reasons) on scheduler's hot path.
>
> Here is an attempt to get rid of the lock and bring back the support.
>
> V2->V3:
> - Use READ/WRITE_ONCE() for reset-time as well.
> - Use unlikely for few conditionals in the hot path.
> - Better changelogs.
> - Rebase changes.
>
> V1-V2:
> - Use READ_ONCE/WRITE_ONCE instead of atomic in the first patch.
>
> --
> Viresh
>
> Viresh Kumar (5):
>   cpufreq: stats: Defer stats update to
>     cpufreq_stats_record_transition()
>   cpufreq: stats: Remove locking
>   cpufreq: stats: Mark few conditionals with unlikely()
>   cpufreq: stats: Enable stats for fast-switch as well
>   cpufreq: Move traces and update to policy->cur to cpufreq core
>
>  drivers/cpufreq/cpufreq.c        | 11 ++++
>  drivers/cpufreq/cpufreq_stats.c  | 89 ++++++++++++++++++++------------
>  kernel/sched/cpufreq_schedutil.c | 12 +----
>  3 files changed, 69 insertions(+), 43 deletions(-)
>
> --

The entire series applied as 5.10 material with some minor changelog
edits in patch [1/5], thanks!
