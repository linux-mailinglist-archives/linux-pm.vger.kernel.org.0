Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C566633D17C
	for <lists+linux-pm@lfdr.de>; Tue, 16 Mar 2021 11:13:15 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236535AbhCPKMn (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Tue, 16 Mar 2021 06:12:43 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52536 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236529AbhCPKMf (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Tue, 16 Mar 2021 06:12:35 -0400
Received: from mail-pj1-x104a.google.com (mail-pj1-x104a.google.com [IPv6:2607:f8b0:4864:20::104a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 02858C061756
        for <linux-pm@vger.kernel.org>; Tue, 16 Mar 2021 03:12:34 -0700 (PDT)
Received: by mail-pj1-x104a.google.com with SMTP id dw22so7723463pjb.6
        for <linux-pm@vger.kernel.org>; Tue, 16 Mar 2021 03:12:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:message-id:date:subject:from:to:cc;
        bh=sPNBrirzsgarV+3bjwHU9bpa6NDoX062YVrvF8wD1U4=;
        b=DMM4i3J8S3C36P9kFJQwQ7vdwRtEBdC0febk3sxrwnE4AYpokBI7MNKJ9qyJNycz28
         yd1ctej9wK0Jx+oXcK+BrPEmmQ2I+hCXHDqxcpKpXsg6xRTJGjye+HdDPO4vTY6U3v48
         e9tWLRY17XNKMdI/1slxtBYdNfwfo9loBJjvNtW3oHbsGYmXFmooYam+or9bNj/iYrXZ
         gqcmtMdhUdoi6UTUEsF4zET8MLNQ/n60l38vagGAaC9c2/hoFrqwH62siknxYFK3eE4X
         AD/00aaUfsvEPY86op5iba1PpJojUP9MzdVgIPwLbSbXu/paacTAvNvVDz0Yb5x1muRa
         XPDg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:message-id:date:subject:from:to:cc;
        bh=sPNBrirzsgarV+3bjwHU9bpa6NDoX062YVrvF8wD1U4=;
        b=OqjplxC06vflWlc2H1DbvUvN9HgxET/egTCnJ77XXhofqHNFcWCsw6chKAS5R3kGRe
         +pPt8xu7kedZJZoNRb0mELj3C92NnUe/pFx33KPeeZ5BYfTl3UWFi28vS97T5hbWebRO
         tx6WNgfk/ZuyklSHoBheTKUr+hYJbBrfcbdAs21XCE7UGrB/TXGGR6ep5pI49ak5z41t
         luHN49nMbBOkbMg78zNGtLyTHANF6duMe5v7Mg2a81SZZuHJxCldFCHuCfqzA7xEKQxj
         wwLNpDaUJ0zbOidPolWnwxJM3i/t1+eZYJV4fgXAia0aTBzy4X7GnjNyl2JBt7SgboTd
         GXqA==
X-Gm-Message-State: AOAM5308U9wZUGDhUoKBqv2ywUrH84xMmd4iRiwQN5t+gBbfc08JxXXV
        bPnN2Q19cH1n2qZo2O++xpoNF5x4Ve9n2WG3
X-Google-Smtp-Source: ABdhPJztY9SrZJAz+C5uxc+ZJ3iMQYZQ+12zieZ1wkDR3lseCwPGf0fQv2A1FR6AgacrJffp7J7n0iAHegtC8iJP
MIME-Version: 1.0
X-Received: from josephjang-p920.ntc.corp.google.com ([2401:fa00:fc:1:dc9d:82ae:24c8:961b])
 (user=josephjang job=sendgmr) by 2002:a17:902:a412:b029:e5:d7dd:9e41 with
 SMTP id p18-20020a170902a412b02900e5d7dd9e41mr15814329plq.78.1615889554362;
 Tue, 16 Mar 2021 03:12:34 -0700 (PDT)
Message-ID: <000000000000e2a17305bda49a5e@google.com>
Date:   Tue, 16 Mar 2021 10:12:34 +0000
Subject: Re: [PATCH v6] power: suspend: Move dpm_watchdog to suspend.c and
 enhance it
From:   <josephjang@google.com>
To:     gregkh@linuxfoundation.org, rafael@kernel.org, rjw@rjwysocki.net,
        pavel@ucw.cz, len.brown@intel.com, pmladek@suse.com,
        sergey.senozhatsky@gmail.com, rostedt@goodmis.org,
        Kees Cook <keescook@chromium.org>,
        Anton Vorontsov <anton@enomsg.org>,
        Colin Cross <ccross@android.com>,
        Tony Luck <tony.luck@intel.com>,
        "David S . Miller" <davem@davemloft.net>,
        Rob Herring <robh@kernel.org>
Cc:     linux-kernel@vger.kernel.org, linux-pm@vger.kernel.org,
        jonglin@google.com, woodylin@google.com, markcheng@google.com,
        josephjang@google.com
Content-Type: text/plain; charset="UTF-8"; format=flowed; delsp=yes
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

> Since dpm_watchdog just cover two functions __device_suspend() and
> device_resume(), we proposed to move it to core power suspend.c to extend
> its coverage and monitor more devices suspend hand issues.

> We propose to use new name suspend watchdog and new timeout handler to
> cover more sleep hang issues. The new timeout handler will dump disk
> sleep task call trace at first round timeout and trigger kernel panic
> at second round timeout.
> The default timer for each round is defined in
> CONFIG_PM_SUSPEND_WATCHDOG_TIMEOUT.

> Signed-off-by: Joseph Jang <josephjang@google.com>
> ---
> Changes since v5:
>   - Remove MAINTAINERS update since we current MAINTAINERS already cover  
> kernel/power/
>   drivers/base/power/main.c       | 69 ---------------------------
>   kernel/power/Kconfig            | 27 +++++------
>   kernel/power/Makefile           |  1 +
>   kernel/power/suspend.c          | 19 ++++++++
>   kernel/power/suspend_watchdog.c | 84 +++++++++++++++++++++++++++++++++
>   kernel/power/suspend_watchdog.h | 40 ++++++++++++++++
>   kernel/printk/printk.c          |  2 +-
>   7 files changed, 158 insertions(+), 84 deletions(-)
>   create mode 100644 kernel/power/suspend_watchdog.c
>   create mode 100644 kernel/power/suspend_watchdog.h

> @@ -916,7 +852,6 @@ static int device_resume(struct device *dev,  
> pm_message_t state, bool async)
>          if (!dpm_wait_for_superior(dev, async))
>                  goto Complete;

> +
>   /**
>    * pm_suspend_default_s2idle - Check if suspend-to-idle is the default  
> suspend.
>    *
> @@ -89,6 +92,8 @@ static void s2idle_enter(void)
>   {
>          trace_suspend_resume(TPS("machine_suspend"), PM_SUSPEND_TO_IDLE,  
> true);

> +       stop_suspend_watchdog(&suspend_wd);
> +
>          raw_spin_lock_irq(&s2idle_lock);
>          if (pm_wakeup_pending())
>                  goto out;
> @@ -114,6 +119,8 @@ static void s2idle_enter(void)
>          s2idle_state = S2IDLE_STATE_NONE;
>          raw_spin_unlock_irq(&s2idle_lock);

> +       start_suspend_watchdog(&suspend_wd);
> +
>          trace_suspend_resume(TPS("machine_suspend"), PM_SUSPEND_TO_IDLE,  
> false);
>   }

> 2.30.0.365.g02bc693789-goog

Hi Greg and Rafael,

Sorry for the interrupt ~
Since this patch is really help us to narrow down many problems at our  
platform.
May I know if you could help to take a look at PATCH#6 again ?

Thank you,
Joseph.
