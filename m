Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 74F8E2903F7
	for <lists+linux-pm@lfdr.de>; Fri, 16 Oct 2020 13:26:17 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2405578AbgJPL0Q (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Fri, 16 Oct 2020 07:26:16 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54028 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2406030AbgJPL0N (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Fri, 16 Oct 2020 07:26:13 -0400
Received: from mail-yb1-xb4a.google.com (mail-yb1-xb4a.google.com [IPv6:2607:f8b0:4864:20::b4a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 773B8C0613D3
        for <linux-pm@vger.kernel.org>; Fri, 16 Oct 2020 04:26:11 -0700 (PDT)
Received: by mail-yb1-xb4a.google.com with SMTP id e9so2155795ybj.11
        for <linux-pm@vger.kernel.org>; Fri, 16 Oct 2020 04:26:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=sender:mime-version:message-id:date:subject:from:to:cc;
        bh=3ebDBpjfYB18MuoFXn3zyWkL13VkNV9A5TzUsx3Jwns=;
        b=TyCPqnNlQ2tcgOI9HZRRvbcDUw1pNMZrSfzIxK5M9PKlD78GCSdhSu6X9TCI/RpJsj
         oOAK5YQ6mcJmeEcljL/CtUx0PNhbdF+Z2OEwZU9X7sO3dPo7LgOJklrtAU9Mjrz3DxKS
         MLvYrkb88kID2iKty7cfxG9LCi4ARCPAE8/JiftnwlqR2ggPM4O1LZCstgKHs0T3GIfC
         WqGwo5rDpFDzg+z3Eg8jr7tS7xe8gs0NWZXbLwXIFXE2YnUpQEgABEHV8f0OFXxMJRaD
         Gmlg2NiRSEktPhMo0Xc7okfc544MdNyS5nFEILM+MzygLv+dKUhfcPF/2EF8+v3l2/XY
         47tw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:mime-version:message-id:date:subject:from
         :to:cc;
        bh=3ebDBpjfYB18MuoFXn3zyWkL13VkNV9A5TzUsx3Jwns=;
        b=sBQSsb2gSvSQ8+jKgLlGqX5RJB20H3v3KWEyYowYMDAJjQqBTGVoTIWHh2HRskLPSB
         PYZnBeg/x68T0O+N73CkEURtKtnbThwJWEWVrOiEGuCqX9+nWneTe4oYKd4ic6SRdCds
         HgPbzEZuLcN1nHNsgcxfWqxE8ptwYHd3sHvdevYoOUth5494k5lDjVTmauPC1DbpCfUV
         IFdz4Fq9MXE+PsVhUxlDKH0WM2FKuiWK+eLLRp6XRGOIWa8GfjKZSzmcxCL9AS5cTI6W
         EBY1lSDQZ6tZisu7Ij5HMIy/gZARCysq/bjDX8e3pY/H4y4WbU7teYvTKiAte44k61RY
         GnNw==
X-Gm-Message-State: AOAM530RmTHUYV95XJSl1V1TSpIz1f2kDJuCcT7yxaGXiECKAeyC5xpc
        2lodhjLS6xl6WKa0JIMuCxE8N9mWyd6jxo2a
X-Google-Smtp-Source: ABdhPJybTUwPfKQYF1YsUkaWjuIOOnZy4F3lP/IWLqxa37JyufLE2W+lbH1WIDnfweIefkboX933fGFaCJAzEwl3
Sender: "josephjang via sendgmr" 
        <josephjang@josephjang-p920.ntc.corp.google.com>
MIME-Version: 1.0
X-Received: from josephjang-p920.ntc.corp.google.com ([2401:fa00:fc:1:7220:84ff:fe09:41e0])
 (user=josephjang job=sendgmr) by 2002:a25:ea02:: with SMTP id
 p2mr4338796ybd.95.1602847570438; Fri, 16 Oct 2020 04:26:10 -0700 (PDT)
Message-ID: <00000000000011154c05b1c8083a@google.com>
Date:   Fri, 16 Oct 2020 11:26:10 +0000
Subject: [PATCH] power: suspend: Add suspend timeout handler
From:   <josephjang@google.com>
To:     gregkh@linuxfoundation.org, rjw@rjwysocki.net, pavel@ucw.cz,
        len.brown@intel.com, pmladek@suse.com,
        sergey.senozhatsky@gmail.com, rostedt@goodmis.org
Cc:     linux-kernel@vger.kernel.org, linux-pm@vger.kernel.org,
        jonglin@google.com, woodylin@google.com, markcheng@google.com,
        josephjang@google.com
Content-Type: text/plain; charset="UTF-8"; format=flowed; delsp=yes
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

Thank you Petr for promptly reply.

> On Fri 2020-10-16 11:51:09, Joseph Jang wrote:
> > From: josephjang <josephjang@google.com>
> >
> > Add suspend timeout handler to prevent device stuck during suspend/
> > resume process. Suspend timeout handler will dump disk sleep task
> > at first round timeout and trigger kernel panic at second round timeout.
> > The default timer for each round is 30 seconds.

> A better solution would be to resume instead of panic().


[Joseph] suspend_timeout() will trigger kernel panic() only when
suspend thread stuck (deadlock/hang) for 2*30 seconds.
At that moment, I don't know how to resume the suspend thread. So I
just could trigger panic to reboot system.
If you have better suggestions, I am willing to study it.

> > Note: Can use following command to simulate suspend hang for testing.
> >     adb shell echo 1 > /sys/power/pm_hang

> This looks dangerous. It adds a simple way to panic() the system.

> First, it should get enabled separately. e.g.
> CONFIG_TEST_PM_SLEEP_MONITOR.

> Second, I would add it as a module that might get loaded
> and unloaded.


[Joseph] Agree to enable new compile flag for test module.
I think it is better to create separate patch for the new test module right?

> > diff --git a/kernel/power/suspend.c b/kernel/power/suspend.c
> > index 8b1bb5ee7e5d..6f2679cfd9d1 100644
> > --- a/kernel/power/suspend.c
> > +++ b/kernel/power/suspend.c
> Using kthread looks like an overkill to me. I wonder how this actually
> works when the kthreads get freezed. It might be enough to implement
> just a timer callback. Start the timer in start_suspend_mon() and
> delete it in stop_suspend_mon(). Or do I miss anything?

> Anyway, the kthread implementation looks a but hairy. If you really
> need to use kthread, I suggest to use kthread_worker API. You would
> need to run an init work to setup the RT scheduling. Then you
> could just call kthread_queue_delayed_work(()
> and kthread_cancel_delayed_work_sync() to start and stop
> the monitor.



[Joseph]
Actually, I had ever think we just need to use
add_timer()/del_timer_sync() for start_suspend_mon()/stop_suspend_mon()  
before.

But I am not sure if add_timer() may cause any performance impact in
suspend thread or not.
So I try to create a suspend monitor kthread and just flip the flag in
suspend thread.


> > @@ -114,6 +251,10 @@ static void s2idle_enter(void)
> >       s2idle_state = S2IDLE_STATE_NONE;
> >       raw_spin_unlock_irq(&s2idle_lock);
> >
> > +#ifdef CONFIG_PM_SLEEP_MONITOR
> > +     start_suspend_mon();
> > +#endif

> It is better to solve this by defining start_suspend_mon() as empty
> function when the config option is disabled. For example, see
> how  vgacon_text_force() is defined in console.h.


[Joseph] Thank you for good suggestions.
May I know if I could use IS_ENABLED() ?
if (IS_ENABLED(CONFIG_PM_SLEEP_MONITOR))
     start_suspend_mon();

> Best Regards,
> Petr

