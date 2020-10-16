Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9B4A7290660
	for <lists+linux-pm@lfdr.de>; Fri, 16 Oct 2020 15:33:41 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2408138AbgJPNdk (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Fri, 16 Oct 2020 09:33:40 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45674 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2408036AbgJPNdi (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Fri, 16 Oct 2020 09:33:38 -0400
Received: from mail-pf1-x449.google.com (mail-pf1-x449.google.com [IPv6:2607:f8b0:4864:20::449])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2818AC0613D3
        for <linux-pm@vger.kernel.org>; Fri, 16 Oct 2020 06:33:37 -0700 (PDT)
Received: by mail-pf1-x449.google.com with SMTP id q16so1457332pfj.7
        for <linux-pm@vger.kernel.org>; Fri, 16 Oct 2020 06:33:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=sender:mime-version:message-id:date:subject:from:to:cc;
        bh=KcIutrRAI690Kuxs6Ggg953kyLX5Sg3gj/e4pIHhVgA=;
        b=Me+/3P5ngmHekvdLvG/5LNWF9JOFgy0gp1tj8Qzwpw/LCk9rEUIDm6FeFA/KulV1uK
         hehBlKdcquNszWV2o1IvuuzYXjoCGuyPH2S9omIAaImZeFCtufZg4u7bWVamKHnTnLgO
         T7CIpFgFIBhnyR1XPQ5jJBxz2GnBcWKr6ygAlemMfednCbBzwBhpDQInJyZsANzS7GEg
         s0l3obUarohtvhThj7wOmTc8nk6gpKnQ8MfIlMOa8P8ni8Yk81QHtYmSZQfhkZyYu3LO
         p9eaqzb6GSYlT4C0q5LyHZ2iXuTUM8s6zAOwVeSawIZdmThX9wrhpds7UlBvXb4Efe9Q
         6sKw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:mime-version:message-id:date:subject:from
         :to:cc;
        bh=KcIutrRAI690Kuxs6Ggg953kyLX5Sg3gj/e4pIHhVgA=;
        b=EtD25lRGEWW8Rq52MBUDJeXczgMygLmjvTbmTsq8mq6FfbMd+e5rpeO6J3bHqefNCF
         niEngq6MAgXKW/0BsFlwPvzmXqOSqeM012I+YGic+3jy8sa+r4ADgQraeiur6qNqJXcp
         qT/cAIUPnoFBUS9TQy7IsiNKiVjqLSMLXYh3NPZ/NMc7K9AYl/pf9f4p268bdac5sGe4
         rHMu7ffcUbanWr1mWh64iUxonub18EpknqiVqKeYpYxMrFY52ifb95b9LHcY/E6BvKPU
         dYsS92hBBruMnCjh5JyEEFkPYfae+81kG40PAh+hhUMIxPJ7dGJ0MYuxWue6dGkRSES0
         nwIw==
X-Gm-Message-State: AOAM533GB8yUF4HLAakwhjDDh4I/c6WYBuXRLAd5zOItHRiTrHhK0yRL
        4onpV/lKTKdQSLdWaLUgU08lk8JBIJ+eg/f2
X-Google-Smtp-Source: ABdhPJyDqt0Arf5tyMl1YZBfCGnMk0e7itWn7hCVqqkMfa88u0f/qFiKDj57Rz8Lbh9cZSoo+BJ2RJ8y1JC1eMj8
Sender: "josephjang via sendgmr" 
        <josephjang@josephjang-p920.ntc.corp.google.com>
MIME-Version: 1.0
X-Received: from josephjang-p920.ntc.corp.google.com ([2401:fa00:fc:1:7220:84ff:fe09:41e0])
 (user=josephjang job=sendgmr) by 2002:a17:902:aa8b:b029:d3:b362:7936 with
 SMTP id d11-20020a170902aa8bb02900d3b3627936mr3905140plr.11.1602855216579;
 Fri, 16 Oct 2020 06:33:36 -0700 (PDT)
Message-ID: <000000000000cfe69e05b1c9cf0e@google.com>
Date:   Fri, 16 Oct 2020 13:33:36 +0000
Subject: [PATCH] power: suspend: Add suspend timeout handler
From:   <josephjang@google.com>
To:     rafael@kernel.org, gregkh@linuxfoundation.org, rjw@rjwysocki.net,
        pavel@ucw.cz, len.brown@intel.com, pmladek@suse.com,
        sergey.senozhatsky@gmail.com, rostedt@goodmis.org
Cc:     linux-kernel@vger.kernel.org, linux-pm@vger.kernel.org,
        jonglin@google.com, woodylin@google.com, markcheng@google.com,
        josephjang@google.com
Content-Type: text/plain; charset="UTF-8"; format=flowed; delsp=yes
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

> >
> > On Fri, Oct 16, 2020 at 3:22 PM <josephjang@google.com> wrote:
> > >
> > > Thank you Rafael's promptly response.
> > >
> > > > On Fri, Oct 16, 2020 at 5:51 AM Joseph Jang <josephjang@google.com>  
> wrote:
> > > > >
> > > > > From: josephjang <josephjang@google.com>
> > > > >
> > > > > Add suspend timeout handler to prevent device stuck during  
> suspend/
> > > > > resume process. Suspend timeout handler will dump disk sleep task
> > > > > at first round timeout and trigger kernel panic at second round  
> timeout.
> > > > > The default timer for each round is 30 seconds.
> > > > >
> > > > > Note: Can use following command to simulate suspend hang for  
> testing.
> > > > >     adb shell echo 1 > /sys/power/pm_hang
> > > > >     adb shell echo mem > /sys/power/state
> > > > > Signed-off-by: josephjang <josephjang@google.com>
> > > > > ---
> > > > >  include/linux/console.h |   1 +
> > > > >  kernel/power/Kconfig    |   9 +++
> > > > >  kernel/power/main.c     |  66 ++++++++++++++++
> > > > >  kernel/power/suspend.c  | 162  
> ++++++++++++++++++++++++++++++++++++++++
> > > > >  kernel/printk/printk.c  |   5 ++
> > > > >  5 files changed, 243 insertions(+)
> > > > >
> > > > > diff --git a/include/linux/console.h b/include/linux/console.h
> > > > > index 0670d3491e0e..ac468c602c0b 100644
> > > > > --- a/include/linux/console.h
> > > > > +++ b/include/linux/console.h
> > > > > @@ -192,6 +192,7 @@ static inline void console_sysfs_notify(void)
> > > > >  { }
> > > > >  #endif
> > > > >  extern bool console_suspend_enabled;
> > > > > +extern int is_console_suspended(void);
> > > > >
> > > > >  /* Suspend and resume console messages over PM events */
> > > > >  extern void suspend_console(void);
> > > > > diff --git a/kernel/power/Kconfig b/kernel/power/Kconfig
> > > > > index a7320f07689d..52b7a181b6d8 100644
> > > > > --- a/kernel/power/Kconfig
> > > > > +++ b/kernel/power/Kconfig
> > > > > @@ -207,6 +207,15 @@ config PM_SLEEP_DEBUG
> > > > >         def_bool y
> > > > >         depends on PM_DEBUG && PM_SLEEP
> > > > >
> > > > > +config PM_SLEEP_MONITOR
> > > > > +       bool "Linux kernel suspend/resume process monitor"
> > > > > +       depends on PM_SLEEP
> > > > > +       help
> > > > > +       This option will enable suspend/resume monitor to prevent  
> device
> > > > > +       stuck during suspend/resume process. Suspend timeout  
> handler
> > > > will
> > > > > +       dump disk sleep task at first round timeout and trigger  
> kernel
> > > > panic
> > > > > +       at second round timeout. The default timer for each round  
> is 30
> > > > seconds.
> > > > > +
> > >
> > > > The facility associated with the Kconfig entry right below is  
> supposed
> > > > to do exactly the same thing.
> > >
> > > > What's the reason to add another one?  What is missing?
> > >
> > >
> > >
> > > > >  config DPM_WATCHDOG
> > > > >         bool "Device suspend/resume watchdog"
> > > > >         depends on PM_DEBUG && PSTORE && EXPERT
> > >
> > > Because we found some suspend hand issue that cannot be detected by
> > > "CONFIG_DPM_WATCHDOG" (which is focus on device PM).
> >
> > What's that issue?
> >
> > > Our suspend timeout monitor can cover PM core and Device PM hang  
> issues.
> >
> > Then I'd suggest to extend the existing watchdog instead of adding a
> > whole new implementation.


Since kernel/power/suspend.c doesn't need "struct device *dev" like  
following.
Can we create a new suspend_timer to cover PM core and Device PM hang  
issues?

/**
  * dpm_watchdog_set - Enable pm watchdog for given device.
  * @wd: Watchdog. Must be allocated on the stack.
  * @dev: Device to handle.
  */
static void dpm_watchdog_set(struct dpm_watchdog *wd, struct device *dev)
{
	struct timer_list *timer = &wd->timer;

	wd->dev = dev;
	wd->tsk = current;
...



Thank you,
Joseph.
