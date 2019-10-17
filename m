Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 0DD09DB799
	for <lists+linux-pm@lfdr.de>; Thu, 17 Oct 2019 21:36:44 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732970AbfJQTgn (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Thu, 17 Oct 2019 15:36:43 -0400
Received: from mail-oi1-f193.google.com ([209.85.167.193]:46914 "EHLO
        mail-oi1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1732550AbfJQTgm (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Thu, 17 Oct 2019 15:36:42 -0400
Received: by mail-oi1-f193.google.com with SMTP id k25so3150616oiw.13;
        Thu, 17 Oct 2019 12:36:42 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=wMBmQgXgQoWb0P4lgM78gRiFJNtt+8vmUMx+YfAsBSQ=;
        b=prmWJ0k7Tv0gBRQpycn1Y/7jY9xXD4P9rlB1yB6dkIYKFfCrLOdXfLYJChkHlovmMM
         Urik0f1L4ybbbK77LFwqArGUVVOgCtWhdOw8x4aiLefyUpIeKxt8CB678HoMC8tZ8m7E
         BVckjZicf40N9D7KG958056gnN5I/9Z+K/ak8HVn0j9LdTb1KWqEQanXynLGXWvzCEOQ
         zAMrRgJIpQTq0AbTSsAt5UvQpyNWOV7YWMgv2OYLFEb3VDxIHMkBIpPJOL6wDKvFC7YT
         0o+ws1WkLa7XkEdBjCRLPSmJ6BvQA+hRl0gY7hhBhLDhhAIPRbn1ydpoWPFfi+n+dAf7
         u9kA==
X-Gm-Message-State: APjAAAV88Q0Mp2UtX3O/89EZxcODVMJ6BudjzK3THwf3ffw3O/2Kw0hb
        OxseOehXe+KwT3HlsYkxZjKivPYs3lkghGzfCfk=
X-Google-Smtp-Source: APXvYqxPA6/JVI+JYwHJZbOxjnhNoLGs95dDEiw9iUvKoJGOEg7tze49M+p8Pq72f5dILLOH/ZveQyzjbBgeRKP0YRY=
X-Received: by 2002:aca:d706:: with SMTP id o6mr4796175oig.57.1571341001884;
 Thu, 17 Oct 2019 12:36:41 -0700 (PDT)
MIME-Version: 1.0
References: <20191017163503.30791-1-sudeep.holla@arm.com>
In-Reply-To: <20191017163503.30791-1-sudeep.holla@arm.com>
From:   "Rafael J. Wysocki" <rafael@kernel.org>
Date:   Thu, 17 Oct 2019 21:36:30 +0200
Message-ID: <CAJZ5v0gTpK0cJhsWGVvs-=Sbgcia0jz2j5QNYRL+1wOz=2xkJQ@mail.gmail.com>
Subject: Re: [PATCH] cpufreq: flush any pending policy update work scheduled
 before freeing
To:     Sudeep Holla <sudeep.holla@arm.com>
Cc:     Viresh Kumar <viresh.kumar@linaro.org>,
        "Rafael J . Wysocki" <rjw@rjwysocki.net>,
        Linux PM <linux-pm@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

On Thu, Oct 17, 2019 at 6:35 PM Sudeep Holla <sudeep.holla@arm.com> wrote:
>
> dev_pm_qos_remove_request ends calling {max,min}_freq_req QoS notifiers
> which schedule policy update work. It may end up racing with the freeing
> the policy and unregistering the driver.
>
> One possible race is as below where the cpufreq_driver is unregistered
> but the scheduled work gets executed at later stage when cpufreq_driver
> is NULL(i.e. after freeing the policy and driver)
>
> Unable to handle kernel NULL pointer dereference at virtual address 0000001c
> pgd = (ptrval)
> [0000001c] *pgd=80000080204003, *pmd=00000000
> Internal error: Oops: 206 [#1] SMP THUMB2
> Modules linked in:
> CPU: 0 PID: 34 Comm: kworker/0:1 Not tainted 5.4.0-rc3-00006-g67f5a8081a4b #86
> Hardware name: ARM-Versatile Express
> Workqueue: events handle_update
> PC is at cpufreq_set_policy+0x58/0x228
> LR is at dev_pm_qos_read_value+0x77/0xac
> Control: 70c5387d  Table: 80203000  DAC: fffffffd
> Process kworker/0:1 (pid: 34, stack limit = 0x(ptrval))
>         (cpufreq_set_policy) from (refresh_frequency_limits.part.24+0x37/0x48)
>         (refresh_frequency_limits.part.24) from (handle_update+0x2f/0x38)
>         (handle_update) from (process_one_work+0x16d/0x3cc)
>         (process_one_work) from (worker_thread+0xff/0x414)
>         (worker_thread) from (kthread+0xff/0x100)
>         (kthread) from (ret_from_fork+0x11/0x28)
>
> Cc: "Rafael J. Wysocki" <rjw@rjwysocki.net>
> Cc: Viresh Kumar <viresh.kumar@linaro.org>
> Signed-off-by: Sudeep Holla <sudeep.holla@arm.com>
> ---
>  drivers/cpufreq/cpufreq.c | 3 +++
>  1 file changed, 3 insertions(+)
>
> Hi Rafael, Viresh,
>
> This fixed the boot issue I reported[1] on TC2 with bL switcher enabled.
> I have based this patch on -rc3 and not on top of your patches. This
> only fixes the boot issue but I hit the other crashes while continuously
> switching on and off the bL switcher that register/unregister the driver
> Your patch series fixes them. I can based this on top of those if you
> prefer.
>
> Regards,
> Sudeep
>
> [1] https://lore.kernel.org/linux-pm/20191015155735.GA29105@bogus/
>
> diff --git a/drivers/cpufreq/cpufreq.c b/drivers/cpufreq/cpufreq.c
> index c52d6fa32aac..b703c29a84be 100644
> --- a/drivers/cpufreq/cpufreq.c
> +++ b/drivers/cpufreq/cpufreq.c
> @@ -1278,6 +1278,9 @@ static void cpufreq_policy_free(struct cpufreq_policy *policy)
>         }
>
>         dev_pm_qos_remove_request(policy->min_freq_req);
> +       /* flush the pending policy->update work before freeing the policy */
> +       if (work_pending(&policy->update))

Isn't this racy?

It still may be running if the pending bit is clear and we still need
to wait for it then, don't we?

Why don't you do an unconditional flush_work() here?

> +               flush_work(&policy->update);
>         kfree(policy->min_freq_req);
>
>         cpufreq_policy_put_kobj(policy);
> --
> 2.17.1
>
