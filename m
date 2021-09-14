Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 86BC140B59D
	for <lists+linux-pm@lfdr.de>; Tue, 14 Sep 2021 19:08:46 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229993AbhINRKC (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Tue, 14 Sep 2021 13:10:02 -0400
Received: from mail-ot1-f51.google.com ([209.85.210.51]:41609 "EHLO
        mail-ot1-f51.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229517AbhINRKC (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Tue, 14 Sep 2021 13:10:02 -0400
Received: by mail-ot1-f51.google.com with SMTP id o16-20020a9d2210000000b0051b1e56c98fso19522034ota.8;
        Tue, 14 Sep 2021 10:08:44 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=FhUnbg+uhSt5ysUwKSnG6H0zuUdL3FIHTzTgcFPDfCs=;
        b=diSXijtsednguG4SS/DfwdvJH/tnjOVu8IrhKjy3jqitKhcIclTO9+8G5L/VoCDGc2
         KkQ0glxlS8ZmXLj/iwK29363FnXq9PfhVZ2z/NkwCRrzvOzZ5GSH9IuPQeL3cda8UxpJ
         dggb59C3nxK9/OvJxlLcacWO20JmVbcuBSaD5c9QKwliLzAsYC0A+LPwcw7PajCAeW5V
         y+jqQBrhSkCEqA6fY9YeJqOxfajQuDVeMCxw0lMBRAzbI0o7av0cE3+ZIKFGpOqTtoYp
         jdPFcVt+0ufTZyiR4V+E3XgyL6pDUISfKzS12lE1sKwaQ0/fT7IPzxdypAy1NhfnlJV5
         wy5Q==
X-Gm-Message-State: AOAM533oE6Yih0duGuXtfTMpybbzFhi6hcjZ29uqtl8LK/5feRfqJt7I
        GW+91stI0KimLDo77RU2g2LF2uMe/ai5iUIKiWY=
X-Google-Smtp-Source: ABdhPJwwNvkCwgKHIXpSxGbqsgqWZFPM80nulHEd5WVGCXkN6rwUTA0/uY5HQm5l3gbFey6QGta7bdShVzTGDm5kdfo=
X-Received: by 2002:a05:6830:34b:: with SMTP id h11mr15965174ote.319.1631639324158;
 Tue, 14 Sep 2021 10:08:44 -0700 (PDT)
MIME-Version: 1.0
References: <20210914165623.18972-1-james.morse@arm.com>
In-Reply-To: <20210914165623.18972-1-james.morse@arm.com>
From:   "Rafael J. Wysocki" <rafael@kernel.org>
Date:   Tue, 14 Sep 2021 19:08:33 +0200
Message-ID: <CAJZ5v0juNZA8waQGyxTRQR05gQZa+qi0WksHUcfJSrzyFuMO7Q@mail.gmail.com>
Subject: Re: [PATCH] cpufreq: schedutil: Destroy mutex before kobject_put()
 frees the memory
To:     James Morse <james.morse@arm.com>
Cc:     Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Linux PM <linux-pm@vger.kernel.org>,
        "Rafael J. Wysocki" <rafael@kernel.org>,
        Kevin Hao <haokexin@gmail.com>,
        Juri Lelli <juri.lelli@redhat.com>,
        Ingo Molnar <mingo@redhat.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Vincent Guittot <vincent.guittot@linaro.org>,
        Viresh Kumar <viresh.kumar@linaro.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

On Tue, Sep 14, 2021 at 6:56 PM James Morse <james.morse@arm.com> wrote:
>
> Since commit e5c6b312ce3c ("cpufreq: schedutil: Use kobject release()
> method to free sugov_tunables") kobject_put() has kfree()d the
> attr_set before gov_attr_set_put() returns.
>
> kobject_put() isn't the last user of attr_set in gov_attr_set_put(),
> the subsequent mutex_destroy() triggers a use-after-free:
> | BUG: KASAN: use-after-free in mutex_is_locked+0x20/0x60
> | Read of size 8 at addr ffff000800ca4250 by task cpuhp/2/20
> |
> | CPU: 2 PID: 20 Comm: cpuhp/2 Not tainted 5.15.0-rc1 #12369
> | Hardware name: ARM LTD ARM Juno Development Platform/ARM Juno Development
> | Platform, BIOS EDK II Jul 30 2018
> | Call trace:
> |  dump_backtrace+0x0/0x380
> |  show_stack+0x1c/0x30
> |  dump_stack_lvl+0x8c/0xb8
> |  print_address_description.constprop.0+0x74/0x2b8
> |  kasan_report+0x1f4/0x210
> |  kasan_check_range+0xfc/0x1a4
> |  __kasan_check_read+0x38/0x60
> |  mutex_is_locked+0x20/0x60
> |  mutex_destroy+0x80/0x100
> |  gov_attr_set_put+0xfc/0x150
> |  sugov_exit+0x78/0x190
> |  cpufreq_offline.isra.0+0x2c0/0x660
> |  cpuhp_cpufreq_offline+0x14/0x24
> |  cpuhp_invoke_callback+0x430/0x6d0
> |  cpuhp_thread_fun+0x1b0/0x624
> |  smpboot_thread_fn+0x5e0/0xa6c
> |  kthread+0x3a0/0x450
> |  ret_from_fork+0x10/0x20
>
> Swap the order of the calls.
>
> Fixes: e5c6b312ce3c ("cpufreq: schedutil: Use kobject release() method to free sugov_tunables")
> Cc: 4.7+ <stable@vger.kernel.org> # 4.7+
> CC: Kevin Hao <haokexin@gmail.com>
> CC: Viresh Kumar <viresh.kumar@linaro.org>
> CC: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
> Signed-off-by: James Morse <james.morse@arm.com>
> ---
>  drivers/cpufreq/cpufreq_governor_attr_set.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/drivers/cpufreq/cpufreq_governor_attr_set.c b/drivers/cpufreq/cpufreq_governor_attr_set.c
> index 66b05a326910..a6f365b9cc1a 100644
> --- a/drivers/cpufreq/cpufreq_governor_attr_set.c
> +++ b/drivers/cpufreq/cpufreq_governor_attr_set.c
> @@ -74,8 +74,8 @@ unsigned int gov_attr_set_put(struct gov_attr_set *attr_set, struct list_head *l
>         if (count)
>                 return count;
>
> -       kobject_put(&attr_set->kobj);
>         mutex_destroy(&attr_set->update_lock);
> +       kobject_put(&attr_set->kobj);

Doh

I should have caught this one, thanks!

>         return 0;
>  }
>  EXPORT_SYMBOL_GPL(gov_attr_set_put);
> --

Applied as 5.15-rc material, thanks!
