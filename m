Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 1B75660F6E
	for <lists+linux-pm@lfdr.de>; Sat,  6 Jul 2019 10:17:28 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725934AbfGFIR1 convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-pm@lfdr.de>); Sat, 6 Jul 2019 04:17:27 -0400
Received: from mail-ot1-f65.google.com ([209.85.210.65]:40286 "EHLO
        mail-ot1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725900AbfGFIR1 (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Sat, 6 Jul 2019 04:17:27 -0400
Received: by mail-ot1-f65.google.com with SMTP id e8so11214106otl.7;
        Sat, 06 Jul 2019 01:17:26 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=BmjS73XlAr/xExYyGQ/UHQ+KTYtukJa8bAxRUnVmDcg=;
        b=hr4kZONchUsldLXs4gsKEpLO43E+E2ZQ5ZWfVEKAhnA00j8JjAANZ3Lmhqp3Pbv3ZO
         6MP/XY91biXb+/DIAgXGKNRNI7vrOj+R7LbcvSakusBroLzoPGGpxWW6cG/e+Ey24PH9
         yQk2o+MMy2JVS64jDAerbmjYs9xYJjMTDk8j7N/Ak5aDHNmEQ7iOV+uRUui8fLNKuOd1
         c6npUbiDurafKwM6bmE7HwX9Xa56ZNVfgkY/bZsR4JHmSWSr4WGFkrOW7EC01gOoheIY
         VH/6i/sHIQYTVTgUnrB46WxgB3pJKqqVBoaKw3j/y6TUDZcnng5Ubl3ZGshFz46owNqs
         geeQ==
X-Gm-Message-State: APjAAAUH0M+pq1IF15jFbTqXH5lSYlPX7ISR8TyL2PScTXZlsxLwNRpg
        PvVcZlplZBzEB+4meTaZ0JUsQ6E2NlVhJatAwg0=
X-Google-Smtp-Source: APXvYqwpaq0rDzPcnpj3pFXRl4h+ABXahe/kTwqQ4V/E9YVuoErUBySOPi3W44AsrLPO0L5ONQSP22LLfEke6J2swjs=
X-Received: by 2002:a9d:6a4b:: with SMTP id h11mr4036175otn.266.1562401046081;
 Sat, 06 Jul 2019 01:17:26 -0700 (PDT)
MIME-Version: 1.0
References: <79b247b3-e056-610e-9a07-e685dfdaa6c9@gmail.com>
In-Reply-To: <79b247b3-e056-610e-9a07-e685dfdaa6c9@gmail.com>
From:   "Rafael J. Wysocki" <rafael@kernel.org>
Date:   Sat, 6 Jul 2019 10:17:15 +0200
Message-ID: <CAJZ5v0grOas+Wh0h09fKZmUnOJ3PRX2Fc=2fv7=zCFJiZ09-Bg@mail.gmail.com>
Subject: Re: The tick is active on idle adaptive-tick CPUs when
 /dev/cpu_dma_latency is used
To:     Thomas Lindroth <thomas.lindroth@gmail.com>
Cc:     Linux PM <linux-pm@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Peter Zijlstra <peterz@infradead.org>,
        Frederic Weisbecker <frederic@kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8BIT
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

On Fri, Jul 5, 2019 at 7:22 PM Thomas Lindroth
<thomas.lindroth@gmail.com> wrote:
>
> On recent kernels the tick remains active on idle adaptive-tick CPUs when a small value is written to /dev/cpu_dma_latency to restrict the highest C-state. Before the idle loop redesign in 4.17 idle CPUs had the tick disabled even when C-state were restricted. Is this change intentional or a regression?

It was intentional, but this kind of is a gray area.

At least for the menu governor you may argue that the decision on
whether or not to stop the tick should be based on the predicted idle
duration.

> I use an x86_64 system built with CONFIG_NO_HZ_FULL that I recently upgraded to the 4.19 series from the 4.14 series. I noticed that adaptive-tick CPUs (nohz_full=1-7) still fire timer interrupts about 1000 times/s (CONFIG_HZ_1000=y) even when they are mostly idle. Some debugging showed that this only happens when a program is writing to /dev/cpu_dma_latency to restrict C-states. The old 4.14 kernel only have around 10 timer interrupts per second on idle adaptive-tick CPU even when C-states are restricted that way.
>
> I would expect an adaptive-tick CPU to turn off the tick when it has 0 or 1 processes to run and enable the tick for >2 processes. Kernels after 4.17 instead have the tick on when 0 or >2 processes are running and the tick off in the 1 process case. Since the tick is off when a single process is running that workload isn't directly harmed by the change but if the CPU use hyperthreading the constant wakeups on an idle HT sibling will reduce performance on the other sibling.
>
> They way I look for timer interrupts is by comparing the LOC line in /proc/interrupts or using the hrtimer_expire_entry tracepoint when function=tick_sched_timer. Both methods seem to give the same results.
>
> I can reproduce the problem using an i7-4790K CPU with /sys/devices/system/cpu/cpuidle/current_driver:intel_idle. I can also reproduce the problem on an old core2duo laptop with current_driver:acpi_idle but I can't reproduce the problem in a virtual machine where current_driver:none. I also can't reproduce the problem if C-states are restricted using the intel_idle.max_cstate=1 kernel argument instead of /dev/cpu_dma_latency.
>
> The commit that introduced the change is 554c8aa8ec "sched: idle: Select idle state before stopping the tick" in v4.17 and the problem exists at least up to kernel 5.1 using the menu cpuidle governor.

Restoring the previous behavior in this case should be relatively
straightforward.  I'll send you a patch to do that later.
