Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 03A81106968
	for <lists+linux-pm@lfdr.de>; Fri, 22 Nov 2019 10:59:46 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726500AbfKVJ7p (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Fri, 22 Nov 2019 04:59:45 -0500
Received: from mail-ot1-f65.google.com ([209.85.210.65]:46740 "EHLO
        mail-ot1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726100AbfKVJ7p (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Fri, 22 Nov 2019 04:59:45 -0500
Received: by mail-ot1-f65.google.com with SMTP id n23so5629500otr.13
        for <linux-pm@vger.kernel.org>; Fri, 22 Nov 2019 01:59:42 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=I/ZdY3bM8lpQtmraKi1sgvqQFXBo796yS3lFNXe7mJw=;
        b=ALe/6RHEobBH3AqYzQS2SWET2xmemMfKB6Ijm/IZcbwMc5Zci3EC1R1c0x8I+iHuJJ
         G0MvWyjecI/gzNOibDd5oSuqI6fPXbnUM7rZUYbDdv7j/XnLuS0/5Ozb0hIbGVc6UMiB
         FgZfzPTw/pDLYgJUeQXQvc7rlKlDS2tkDxZqO2G48I7V2W99F5/xuKjqe4RILTV2Fnmo
         0hwT1jj/MjYrjC0w1PHb2akDiKz5UntLgFl28YCv/zomFqhSfgom99Qa1N16gMMeqj21
         QkK+rcW7oeyd5ocW0eZ/c7NUvwiRvwrULvCyu8U+VrB2nOfoi2Mk/3KBebvbEM4LJMNt
         c1jA==
X-Gm-Message-State: APjAAAVefDtJ9ZpA8rqJnlVwW5VmpdnMJr2bUOnjx7d4+YU3YHVJKzg7
        jy2YNN44dDMsQ4iAqiOAEmYwTvylzqjO39nEo+4=
X-Google-Smtp-Source: APXvYqyM6QTfDCgfxt3GM73HDDfMyg/8imJDfW9t+ZT8V+pxkictWZK96fzGP0Xrz8kOnzKnxTQ/+gfPZsUpyzsz9Po=
X-Received: by 2002:a9d:4c85:: with SMTP id m5mr9643405otf.118.1574416781916;
 Fri, 22 Nov 2019 01:59:41 -0800 (PST)
MIME-Version: 1.0
References: <DB3PR0402MB391626A8ECFDC182C6EDCF8DF54E0@DB3PR0402MB3916.eurprd04.prod.outlook.com>
 <20191121093557.bycvdo4xyinbc5cb@vireshk-i7> <DB3PR0402MB39165544EDD0317095A1B72DF54E0@DB3PR0402MB3916.eurprd04.prod.outlook.com>
 <CAJZ5v0geykeebX-67+h4twj+t7oTVBf7X7_UsXw0LAc+0Ap75Q@mail.gmail.com>
 <CAJZ5v0j4z9tEDCGKRc7dHqTiJ1Fq3So=ELfvR6H25UkRmKeBvg@mail.gmail.com> <DB3PR0402MB3916BDC24BDA1053B7ADBDCFF5490@DB3PR0402MB3916.eurprd04.prod.outlook.com>
In-Reply-To: <DB3PR0402MB3916BDC24BDA1053B7ADBDCFF5490@DB3PR0402MB3916.eurprd04.prod.outlook.com>
From:   "Rafael J. Wysocki" <rafael@kernel.org>
Date:   Fri, 22 Nov 2019 10:59:30 +0100
Message-ID: <CAJZ5v0g5EGWVAm4A8ynoWAPc1wJRpR6wgZqwhvbmeT4eT49EUA@mail.gmail.com>
Subject: Re: About CPU hot-plug stress test failed in cpufreq driver
To:     Anson Huang <anson.huang@nxp.com>
Cc:     "Rafael J. Wysocki" <rafael@kernel.org>,
        Viresh Kumar <viresh.kumar@linaro.org>,
        Jacky Bai <ping.bai@nxp.com>,
        "linux-pm@vger.kernel.org" <linux-pm@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

On Fri, Nov 22, 2019 at 6:15 AM Anson Huang <anson.huang@nxp.com> wrote:
>
> Hi, Rafael
>         Theoretically, yes, the CPU being offline will run the irq work list to make sure the irq work pending on it will be clear, but the fact is NOT,

So this looks like a problem with irq_work_sync() working not as expected.

>         both ondemand and schedutil governor can reproduce this issue if running stress CPU hotplug test.
>         I tried add a "int cpu" in irq work structure to record CPU number which has irq work pending, when issue happen, I can see the irq work is pending at CPU #3 which is already offline, this is why issue happen, but I don't know how it happens...
>
> diff --git a/include/linux/irq_work.h b/include/linux/irq_work.h
> index b11fcdf..f8da06f9 100644
> --- a/include/linux/irq_work.h
> +++ b/include/linux/irq_work.h
> @@ -25,6 +25,7 @@ struct irq_work {
>         unsigned long flags;
>         struct llist_node llnode;
>         void (*func)(struct irq_work *);
> +       int cpu;
>  };
>
>  static inline
> diff --git a/kernel/irq_work.c b/kernel/irq_work.c
> index d42acaf..2e893d5 100644
> --- a/kernel/irq_work.c
> +++ b/kernel/irq_work.c
> @@ -10,6 +10,7 @@
>  #include <linux/kernel.h>
>  #include <linux/export.h>
>  #include <linux/irq_work.h>
> +#include <linux/jiffies.h>
>  #include <linux/percpu.h>
>  #include <linux/hardirq.h>
>  #include <linux/irqflags.h>
> @@ -78,6 +79,7 @@ bool irq_work_queue(struct irq_work *work)
>         if (!irq_work_claim(work))
>                 return false;
>
> +       work->cpu = smp_processor_id();
>         /* Queue the entry and raise the IPI if needed. */
>         preempt_disable();
>         __irq_work_queue_local(work);
> @@ -105,6 +107,7 @@ bool irq_work_queue_on(struct irq_work *work, int cpu)
>         /* Only queue if not already pending */
>         if (!irq_work_claim(work))
>                 return false;
> +       work->cpu = cpu;
>
>         preempt_disable();
>         if (cpu != smp_processor_id()) {
> @@ -161,6 +164,7 @@ static void irq_work_run_list(struct llist_head *list)
>                  */
>                 flags = work->flags & ~IRQ_WORK_PENDING;
>                 xchg(&work->flags, flags);
> +               work->cpu = -1;
>
>                 work->func(work);
>                 /*
> @@ -197,9 +201,13 @@ void irq_work_tick(void)
>   */
>  void irq_work_sync(struct irq_work *work)
>  {
> +       unsigned long timeout = jiffies + msecs_to_jiffies(500);
>         lockdep_assert_irqs_enabled();

Can you please add something like

pr_info("%s: CPU %d\n", __func__, work->cpu);

here re-run the test and collect a log again?

I need to know if irq_work_sync() runs during CPU offline as expected.

>
> -       while (work->flags & IRQ_WORK_BUSY)
> +       while (work->flags & IRQ_WORK_BUSY) {
> +               if (time_after(jiffies, timeout))
> +                       pr_warn("irq_work_sync 500ms timeout, work cpu %d\n", work->cpu);
>                 cpu_relax();
> +       }
>  }
>  EXPORT_SYMBOL_GPL(irq_work_sync);
