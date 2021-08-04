Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 48BBD3E0776
	for <lists+linux-pm@lfdr.de>; Wed,  4 Aug 2021 20:21:05 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238755AbhHDSVQ (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Wed, 4 Aug 2021 14:21:16 -0400
Received: from mail-ot1-f42.google.com ([209.85.210.42]:37431 "EHLO
        mail-ot1-f42.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238225AbhHDSVQ (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Wed, 4 Aug 2021 14:21:16 -0400
Received: by mail-ot1-f42.google.com with SMTP id v9-20020a9d60490000b02904f06fc590dbso2477898otj.4;
        Wed, 04 Aug 2021 11:21:03 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=b/edGkLQWDl6XXKiceNO7zU+IerFTZr101Z1aDcI/HQ=;
        b=HuUMM+IBNj1i+1sLxu1LRQ86uwlggdb6IOpkgF4T9gXAXE3mb4IGjiUaam/Gl+HIdx
         kU4+443Y1/597/FsR1hBPLche9VMC8HHcrf9/0/9Um/iwQMcdtDi/o1JmDbZWXpstsJm
         r59YhQA6Dl8L2xrYk4CYbiHGJ0+OR7DJ0cwi8R3GwharwyvmUVQIq6Nk3kCBtwILYsxD
         MdXjpntTQT9GeEr2Uc3Ci8YckrC+mAmiOFr7wo94TSehJgbzpR3ixQ0bmT+VTvQ6hW/a
         gRyOyWGb4jOu8D5Pn7kFOWDSFZTi4M7fCMv0HiKU8nM2DleXDlZUOW0NTiZLheTNdErN
         8XFg==
X-Gm-Message-State: AOAM533lNQWyeyFkVIJZ+hMJ5ee2NLT2F0zcLOU/KuZB6GqRk6xdqCRq
        Mg5v+qZAnk2B/2tEnNntL/1Ae4T6qN3DYNLSNUE=
X-Google-Smtp-Source: ABdhPJzOvoh//4ac5PXGMQO3ShQmfU9ENFPVXhq1vWarKEfI80ZvHddgY/BfNQHvOt1bG4EDHj5szOJcT2qhpfhumt0=
X-Received: by 2002:a9d:5c8b:: with SMTP id a11mr800745oti.206.1628101262968;
 Wed, 04 Aug 2021 11:21:02 -0700 (PDT)
MIME-Version: 1.0
References: <20210803141621.780504-1-bigeasy@linutronix.de> <20210803141621.780504-31-bigeasy@linutronix.de>
In-Reply-To: <20210803141621.780504-31-bigeasy@linutronix.de>
From:   "Rafael J. Wysocki" <rafael@kernel.org>
Date:   Wed, 4 Aug 2021 20:20:52 +0200
Message-ID: <CAJZ5v0goSZywTVDFqE-hXocARyhKDy0AhXSJ_W9pBzU5yg6JZw@mail.gmail.com>
Subject: Re: [PATCH 30/38] ACPI: PM: s2idle: Replace deprecated CPU-hotplug functions.
To:     Sebastian Andrzej Siewior <bigeasy@linutronix.de>
Cc:     Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Peter Zijlstra <peterz@infradead.org>,
        "Rafael J. Wysocki" <rjw@rjwysocki.net>,
        Pavel Machek <pavel@ucw.cz>, Len Brown <len.brown@intel.com>,
        Linux PM <linux-pm@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

On Tue, Aug 3, 2021 at 4:17 PM Sebastian Andrzej Siewior
<bigeasy@linutronix.de> wrote:
>
> The functions get_online_cpus() and put_online_cpus() have been
> deprecated during the CPU hotplug rework. They map directly to
> cpus_read_lock() and cpus_read_unlock().
>
> Replace deprecated CPU-hotplug functions with the official version.
> The behavior remains unchanged.
>
> Cc: "Rafael J. Wysocki" <rjw@rjwysocki.net>
> Cc: Pavel Machek <pavel@ucw.cz>
> Cc: Len Brown <len.brown@intel.com>
> Cc: linux-pm@vger.kernel.org
> Signed-off-by: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
> ---
>  kernel/power/suspend.c | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)
>
> diff --git a/kernel/power/suspend.c b/kernel/power/suspend.c
> index d8cae434f9eb5..eb75f394a0590 100644
> --- a/kernel/power/suspend.c
> +++ b/kernel/power/suspend.c
> @@ -96,7 +96,7 @@ static void s2idle_enter(void)
>         s2idle_state = S2IDLE_STATE_ENTER;
>         raw_spin_unlock_irq(&s2idle_lock);
>
> -       get_online_cpus();
> +       cpus_read_lock();
>         cpuidle_resume();
>
>         /* Push all the CPUs into the idle loop. */
> @@ -106,7 +106,7 @@ static void s2idle_enter(void)
>                     s2idle_state == S2IDLE_STATE_WAKE);
>
>         cpuidle_pause();
> -       put_online_cpus();
> +       cpus_read_unlock();
>
>         raw_spin_lock_irq(&s2idle_lock);
>
> --

Applied as 5.15 material, but the subject changed to "PM: sleep:
s2idle: Replace deprecated CPU-hotplug functions".

Thanks!
