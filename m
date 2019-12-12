Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 5EF3511D2C1
	for <lists+linux-pm@lfdr.de>; Thu, 12 Dec 2019 17:51:38 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729894AbfLLQvh (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Thu, 12 Dec 2019 11:51:37 -0500
Received: from mail-ot1-f66.google.com ([209.85.210.66]:35977 "EHLO
        mail-ot1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729804AbfLLQvh (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Thu, 12 Dec 2019 11:51:37 -0500
Received: by mail-ot1-f66.google.com with SMTP id i4so2664973otr.3;
        Thu, 12 Dec 2019 08:51:36 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=XsNHcoXojvn1TcE1nuLVaSYl2O55IiSy7eZOYf0Q2mU=;
        b=Ds8tcD/+8UTS2Exjg55SdWLE7JLnsXy1P/UhYBqeupvZm8P1Xy2TWOUN1dKYX9lr3b
         xHIsBrck2o98fB4G/dgrdiSiVQLNtzfRVPDdpBD1hZtaR9pnuocg2AO3IVyFUDM2nmoK
         1rYKhT8Jn0hMFfOdBY+QFHe9uy7Pqa63TGXD+/9zW/lYKfu0royzLWCtQPDfZnpuHsBR
         9KlkUtppp026NWi9INKbCX0bq3Gy4BQcI3bWyBBQWhFQ/rj0o/I6yiQl1/pOTgZ6gPqc
         TMD7IxPa1r561L9IJpAUeFeXEQeM5VC8mwRQqsMAXAXYiyZa7pJdUQA89lnufOryztq2
         qSZQ==
X-Gm-Message-State: APjAAAXazOKePaWNZGyv4CiZ97K3ZwZHDF+3MvUYkIyfNyYVCIukOm07
        0ryQBh8aYHSd6IS0asoM6uUfXl7PVtuGr5HZOdvpdA==
X-Google-Smtp-Source: APXvYqxE+Jl9B/h8Hy01Gvlb4q+48YkA/CIUasZspMNTMfDGUXyoTeLzs+Hy/f0FzbkiwnpuyYygly7gpJmsAesQuDE=
X-Received: by 2002:a05:6830:95:: with SMTP id a21mr8624849oto.167.1576169496091;
 Thu, 12 Dec 2019 08:51:36 -0800 (PST)
MIME-Version: 1.0
References: <2691942.bH9KnLg61H@kreacher>
In-Reply-To: <2691942.bH9KnLg61H@kreacher>
From:   "Rafael J. Wysocki" <rafael@kernel.org>
Date:   Thu, 12 Dec 2019 17:51:25 +0100
Message-ID: <CAJZ5v0hy1ERxCjVsYN0wtxbWxJOXhCg_MeTEPONqRs_YE53Bgg@mail.gmail.com>
Subject: Re: [PATCH] cpufreq: Avoid leaving stale IRQ work items during CPU offline
To:     Linux PM <linux-pm@vger.kernel.org>,
        Peter Zijlstra <peterz@infradead.org>
Cc:     LKML <linux-kernel@vger.kernel.org>,
        Viresh Kumar <viresh.kumar@linaro.org>,
        Anson Huang <anson.huang@nxp.com>, Peng Fan <peng.fan@nxp.com>,
        "Rafael J. Wysocki" <rjw@rjwysocki.net>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

On Wed, Dec 11, 2019 at 11:28 AM Rafael J. Wysocki <rjw@rjwysocki.net> wrote:
>
> From: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
>
> The scheduler code calling cpufreq_update_util() may run during CPU
> offline on the target CPU after the IRQ work lists have been flushed
> for it, so the target CPU should be prevented from running code that
> may queue up an IRQ work item on it at that point.
>
> Unfortunately, that may not be the case if dvfs_possible_from_any_cpu
> is set for at least one cpufreq policy in the system, because that
> allows the CPU going offline to run the utilization update callback
> of the cpufreq governor on behalf of another (online) CPU in some
> cases.
>
> If that happens, the cpufreq governor callback may queue up an IRQ
> work on the CPU running it, which is going offline, and the IRQ work
> will not be flushed after that point.  Moreover, that IRQ work cannot
> be flushed until the "offlining" CPU goes back online, so if any
> other CPU calls irq_work_sync() to wait for the completion of that
> IRQ work, it will have to wait until the "offlining" CPU is back
> online and that may not happen forever.  In particular, a system-wide
> deadlock may occur during CPU online as a result of that.
>
> The failing scenario is as follows.  CPU0 is the boot CPU, so it
> creates a cpufreq policy and becomes the "leader" of it
> (policy->cpu).  It cannot go offline, because it is the boot CPU.
> Next, other CPUs join the cpufreq policy as they go online and they
> leave it when they go offline.  The last CPU to go offline, say CPU3,
> may queue up an IRQ work while running the governor callback on
> behalf of CPU0 after leaving the cpufreq policy because of the
> dvfs_possible_from_any_cpu effect described above.  Then, CPU0 is
> the only online CPU in the system and the stale IRQ work is still
> queued on CPU3.  When, say, CPU1 goes back online, it will run
> irq_work_sync() to wait for that IRQ work to complete and so it
> will wait for CPU3 to go back online (which may never happen even
> in principle), but (worse yet) CPU0 is waiting for CPU1 at that
> point too and a system-wide deadlock occurs.
>
> To address this problem notice that CPUs which cannot run cpufreq
> utilization update code for themselves (for example, because they
> have left the cpufreq policies that they belonged to), should also
> be prevented from running that code on behalf of the other CPUs that
> belong to a cpufreq policy with dvfs_possible_from_any_cpu set and so
> in that case the cpufreq_update_util_data pointer of the CPU running
> the code must not be NULL as well as for the CPU which is the target
> of the cpufreq utilization update in progress.
>
> Accordingly, change cpufreq_this_cpu_can_update() into a regular
> function in kernel/sched/cpufreq.c (instead of a static inline in a
> header file) and make it check the cpufreq_update_util_data pointer
> of the local CPU if dvfs_possible_from_any_cpu is set for the target
> cpufreq policy.
>
> Also update the schedutil governor to do the
> cpufreq_this_cpu_can_update() check in the non-fast-switch
> case too to avoid the stale IRQ work issues.
>
> Fixes: 99d14d0e16fa ("cpufreq: Process remote callbacks from any CPU if the platform permits")
> Link: https://lore.kernel.org/linux-pm/20191121093557.bycvdo4xyinbc5cb@vireshk-i7/
> Reported-by: Anson Huang <anson.huang@nxp.com>
> Cc: 4.14+ <stable@vger.kernel.org> # 4.14+
> Signed-off-by: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
> ---
>
> Peter,
>
> The reason why I want to address the issue this way is because IMO
> the right place to do the check is the cpufreq governor.  Governors
> that don't use cpufreq_this_cpu_can_update() at all don't need to
> worry as well as governors that don't use IRQ works.
>
> The cpufreq governor is given an opportunity to update the frequency
> of the CPU and it needs to decide whether or not to really do that.
>
> Please let me know if you have any concerns.

Given the response so far this doesn't seem to be controversial, so
I'm going to queue it up for 5.5.
