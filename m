Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id CF8BA2905C2
	for <lists+linux-pm@lfdr.de>; Fri, 16 Oct 2020 15:08:13 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2395532AbgJPNIH (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Fri, 16 Oct 2020 09:08:07 -0400
Received: from mail-oi1-f194.google.com ([209.85.167.194]:43384 "EHLO
        mail-oi1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2408072AbgJPNIA (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Fri, 16 Oct 2020 09:08:00 -0400
Received: by mail-oi1-f194.google.com with SMTP id l85so2326142oih.10;
        Fri, 16 Oct 2020 06:07:59 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=IbRMxMnlad8N4Ot6wHIOw4psjKXxcLeHwhJrn4sz8qw=;
        b=JuQABzkgyqWUeqdVqXFKGISeI0nNiQYMirThiVhBaP/64ZeBPOwZsiaJQ5RRRTdJxz
         K5fcd01bNVJ3hzpBHiN9bcnBtqXpPux/kSGfZrlaGajj2ImcgmQIgLWqKsjoVPKzeIlO
         V2SiziDptT5qBHNzKPa7GZyj2gh4s2zQNMaPXWl0xsrDyieWXHHrLCBScgkCQP3ZCb3/
         9RmKtii9hsRT07K0dD5zUKJCEX//DghlIIhPF8xVwKwh8qZ1/0Lmo/edD7wYaodtp2ie
         4Eks00FLzD9/n6kaaiX0TGa7ACQYtspnPiPOM5qyG8SMB5C+BcDTbL5kYAMGODXrDqfy
         SRwA==
X-Gm-Message-State: AOAM530bNwH+s1ZXD5TU11Wb2TCMJO0fwBMOvSDtuT7iv1Y+4l8WGiQ0
        m7r5A/rRvnr6CCoc8r/hTLEatA61krEKdX85jGE=
X-Google-Smtp-Source: ABdhPJwHQ7yqxKtETTJBFDfqe87gZ4HOGXfUuww5dW/cJgSP0CjVCNy9WPyynMfH88yxjry1Td3NgMFXlqb+CsPqDeQ=
X-Received: by 2002:aca:724a:: with SMTP id p71mr2394429oic.157.1602853679380;
 Fri, 16 Oct 2020 06:07:59 -0700 (PDT)
MIME-Version: 1.0
References: <20201016035109.3952356-1-josephjang@google.com>
In-Reply-To: <20201016035109.3952356-1-josephjang@google.com>
From:   "Rafael J. Wysocki" <rafael@kernel.org>
Date:   Fri, 16 Oct 2020 15:07:48 +0200
Message-ID: <CAJZ5v0hDfZ2wQ60JsmZJv4B0h2DLqwfJBsKw4KQrXh5COBus0Q@mail.gmail.com>
Subject: Re: [PATCH] power: suspend: Add suspend timeout handler
To:     Joseph Jang <josephjang@google.com>
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        "Rafael J . Wysocki" <rjw@rjwysocki.net>,
        Pavel Machek <pavel@ucw.cz>, Len Brown <len.brown@intel.com>,
        Petr Mladek <pmladek@suse.com>,
        Sergey Senozhatsky <sergey.senozhatsky@gmail.com>,
        Steven Rostedt <rostedt@goodmis.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Linux PM <linux-pm@vger.kernel.org>, jonglin@google.com,
        woodylin@google.com, markcheng@google.com
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

On Fri, Oct 16, 2020 at 5:51 AM Joseph Jang <josephjang@google.com> wrote:
>
> From: josephjang <josephjang@google.com>
>
> Add suspend timeout handler to prevent device stuck during suspend/
> resume process. Suspend timeout handler will dump disk sleep task
> at first round timeout and trigger kernel panic at second round timeout.
> The default timer for each round is 30 seconds.
>
> Note: Can use following command to simulate suspend hang for testing.
>     adb shell echo 1 > /sys/power/pm_hang
>     adb shell echo mem > /sys/power/state
> Signed-off-by: josephjang <josephjang@google.com>
> ---
>  include/linux/console.h |   1 +
>  kernel/power/Kconfig    |   9 +++
>  kernel/power/main.c     |  66 ++++++++++++++++
>  kernel/power/suspend.c  | 162 ++++++++++++++++++++++++++++++++++++++++
>  kernel/printk/printk.c  |   5 ++
>  5 files changed, 243 insertions(+)
>
> diff --git a/include/linux/console.h b/include/linux/console.h
> index 0670d3491e0e..ac468c602c0b 100644
> --- a/include/linux/console.h
> +++ b/include/linux/console.h
> @@ -192,6 +192,7 @@ static inline void console_sysfs_notify(void)
>  { }
>  #endif
>  extern bool console_suspend_enabled;
> +extern int is_console_suspended(void);
>
>  /* Suspend and resume console messages over PM events */
>  extern void suspend_console(void);
> diff --git a/kernel/power/Kconfig b/kernel/power/Kconfig
> index a7320f07689d..52b7a181b6d8 100644
> --- a/kernel/power/Kconfig
> +++ b/kernel/power/Kconfig
> @@ -207,6 +207,15 @@ config PM_SLEEP_DEBUG
>         def_bool y
>         depends on PM_DEBUG && PM_SLEEP
>
> +config PM_SLEEP_MONITOR
> +       bool "Linux kernel suspend/resume process monitor"
> +       depends on PM_SLEEP
> +       help
> +       This option will enable suspend/resume monitor to prevent device
> +       stuck during suspend/resume process. Suspend timeout handler will
> +       dump disk sleep task at first round timeout and trigger kernel panic
> +       at second round timeout. The default timer for each round is 30 seconds.
> +

The facility associated with the Kconfig entry right below is supposed
to do exactly the same thing.

What's the reason to add another one?  What is missing?

>  config DPM_WATCHDOG
>         bool "Device suspend/resume watchdog"
>         depends on PM_DEBUG && PSTORE && EXPERT
