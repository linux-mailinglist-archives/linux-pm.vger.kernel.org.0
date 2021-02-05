Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8706D311648
	for <lists+linux-pm@lfdr.de>; Sat,  6 Feb 2021 00:01:48 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231273AbhBEXAM (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Fri, 5 Feb 2021 18:00:12 -0500
Received: from mail-ot1-f43.google.com ([209.85.210.43]:35871 "EHLO
        mail-ot1-f43.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231822AbhBEMoY (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Fri, 5 Feb 2021 07:44:24 -0500
Received: by mail-ot1-f43.google.com with SMTP id 100so47649otg.3;
        Fri, 05 Feb 2021 04:44:07 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=kuINixcG/J94gESP0yyjqiYb/s22t0ZfSXhCYWQroxI=;
        b=obWk6BQ5ZMOBvTVEwhhw2CV0CXPgp9UMDgh0DfNmhgjDix25Xr8d3Q0pas1o4AHB8o
         WeSBMAom7Ycn4cu0bD85Y1zds+su3CFFnmyBEQYrMuuM8gBcf+JY43T88MY9nHUJoS/R
         YKnAwMq4sspwJhgen28J/G6etP81X0ZjKat3Ou4Z1eUpZSEi/AI+pWtGrVD2AX9jrAPL
         VwS0NwYQtXu4BuA2BVfP3RkC2TGIH0eqdEn6/RvaBxmDzb5cfk4kYuOkUgFm1CtwX9K/
         TIXLanEK4hIhbA5yoDPhSFJTaRZyALznXAjRuT1RKG6IkP+rzDoYWfWxECGdxtJqpjV9
         /7CA==
X-Gm-Message-State: AOAM531d/KnSre7SqwXX2t9+aQcdpMb89KQt+P8ih0ZZaWwy+0XZ23Qa
        NyqyFXYszsKns4yD8Yl2eGXqn024rzyD3kwfHjW1mvt5
X-Google-Smtp-Source: ABdhPJxio/AsWQ4f32FDc+YpO+ird+n+TGH9eAOM0SWxPJMdUTuxRHQMc6kyV2+EPXg80cUrK697FvJtbMZ4n+v1EFY=
X-Received: by 2002:a9d:7a4a:: with SMTP id z10mr3350757otm.206.1612529022635;
 Fri, 05 Feb 2021 04:43:42 -0800 (PST)
MIME-Version: 1.0
References: <20210125143039.1051912-1-geert+renesas@glider.be>
In-Reply-To: <20210125143039.1051912-1-geert+renesas@glider.be>
From:   "Rafael J. Wysocki" <rafael@kernel.org>
Date:   Fri, 5 Feb 2021 13:43:28 +0100
Message-ID: <CAJZ5v0geLBviVW_6LNe0BNymX=PSDfqoukkdz92RNZN5=h3BJg@mail.gmail.com>
Subject: Re: [PATCH] ntp: Use freezable workqueue for RTC synchronization
To:     Geert Uytterhoeven <geert+renesas@glider.be>
Cc:     John Stultz <john.stultz@linaro.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Stephen Boyd <sboyd@kernel.org>,
        Alexandre Belloni <alexandre.belloni@bootlin.com>,
        "Rafael J . Wysocki" <rjw@rjwysocki.net>,
        Len Brown <len.brown@intel.com>, Pavel Machek <pavel@ucw.cz>,
        Wolfram Sang <wsa+renesas@sang-engineering.com>,
        Viresh Kumar <vireshk@kernel.org>, Tejun Heo <tj@kernel.org>,
        Lai Jiangshan <jiangshanlai@gmail.com>,
        Alessandro Zummo <a.zummo@towertech.it>,
        linux-rtc@vger.kernel.org, Linux PM <linux-pm@vger.kernel.org>,
        Linux-Renesas <linux-renesas-soc@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

On Tue, Jan 26, 2021 at 6:48 AM Geert Uytterhoeven
<geert+renesas@glider.be> wrote:
>
> The bug fixed by commit e3fab2f3de081e98 ("ntp: Fix RTC synchronization
> on 32-bit platforms") revealed an underlying issue: RTC synchronization
> may happen anytime, even while the system is partially suspended.
>
> On systems where the RTC is connected to an I2C bus, the I2C bus
> controller may already or still be suspended, triggering a WARNING
> during suspend or resume from s2ram:
>
>     WARNING: CPU: 0 PID: 124 at drivers/i2c/i2c-core.h:54 __i2c_transfer+0x634/0x680
>     i2c i2c-6: Transfer while suspended
>     [...]
>     Workqueue: events_power_efficient sync_hw_clock
>     [...]
>     [<c0738e08>] (__i2c_transfer) from [<c0738eac>] (i2c_transfer+0x58/0xf8)
>     [<c0738eac>] (i2c_transfer) from [<c065202c>] (regmap_i2c_read+0x58/0x94)
>     [<c065202c>] (regmap_i2c_read) from [<c064de40>] (_regmap_raw_read+0x19c/0x2f4)
>     [<c064de40>] (_regmap_raw_read) from [<c064dfdc>] (_regmap_bus_read+0x44/0x68)
>     [<c064dfdc>] (_regmap_bus_read) from [<c064ccb4>] (_regmap_read+0x84/0x1a4)
>     [<c064ccb4>] (_regmap_read) from [<c064d334>] (_regmap_update_bits+0xa8/0xf4)
>     [<c064d334>] (_regmap_update_bits) from [<c064d464>] (_regmap_select_page+0xe4/0x100)
>     [<c064d464>] (_regmap_select_page) from [<c064d554>] (_regmap_raw_write_impl+0xd4/0x6c4)
>     [<c064d554>] (_regmap_raw_write_impl) from [<c064ec10>] (_regmap_raw_write+0xd8/0x114)
>     [<c064ec10>] (_regmap_raw_write) from [<c064eca4>] (regmap_raw_write+0x58/0x7c)
>     [<c064eca4>] (regmap_raw_write) from [<c064ede0>] (regmap_bulk_write+0x118/0x13c)
>     [<c064ede0>] (regmap_bulk_write) from [<c073660c>] (da9063_rtc_set_time+0x44/0x8c)
>     [<c073660c>] (da9063_rtc_set_time) from [<c0734164>] (rtc_set_time+0xc8/0x228)
>     [<c0734164>] (rtc_set_time) from [<c02abe78>] (sync_hw_clock+0x128/0x1fc)
>     [<c02abe78>] (sync_hw_clock) from [<c023e6a0>] (process_one_work+0x330/0x550)
>     [<c023e6a0>] (process_one_work) from [<c023f0a8>] (worker_thread+0x22c/0x2ec)
>
> Fix this race condition by using the freezable instead of the normal
> power-efficient workqueue.
>
> Signed-off-by: Geert Uytterhoeven <geert+renesas@glider.be>

LGTM

Acked-by: Rafael J. Wysocki <rafael@kernel.org>

> ---
>  kernel/time/ntp.c | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)
>
> diff --git a/kernel/time/ntp.c b/kernel/time/ntp.c
> index 54d52fab201d283e..6310328fe398406a 100644
> --- a/kernel/time/ntp.c
> +++ b/kernel/time/ntp.c
> @@ -502,7 +502,7 @@ static struct hrtimer sync_hrtimer;
>
>  static enum hrtimer_restart sync_timer_callback(struct hrtimer *timer)
>  {
> -       queue_work(system_power_efficient_wq, &sync_work);
> +       queue_work(system_freezable_power_efficient_wq, &sync_work);
>
>         return HRTIMER_NORESTART;
>  }
> @@ -668,7 +668,7 @@ void ntp_notify_cmos_timer(void)
>          * just a pointless work scheduled.
>          */
>         if (ntp_synced() && !hrtimer_is_queued(&sync_hrtimer))
> -               queue_work(system_power_efficient_wq, &sync_work);
> +               queue_work(system_freezable_power_efficient_wq, &sync_work);
>  }
>
>  static void __init ntp_init_cmos_sync(void)
> --
> 2.25.1
>
