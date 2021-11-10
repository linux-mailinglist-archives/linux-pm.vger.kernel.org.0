Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id F346A44CDBF
	for <lists+linux-pm@lfdr.de>; Thu, 11 Nov 2021 00:22:02 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234029AbhKJXYt (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Wed, 10 Nov 2021 18:24:49 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51240 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229470AbhKJXYt (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Wed, 10 Nov 2021 18:24:49 -0500
Received: from mail-ed1-x529.google.com (mail-ed1-x529.google.com [IPv6:2a00:1450:4864:20::529])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B4DF4C061766;
        Wed, 10 Nov 2021 15:22:00 -0800 (PST)
Received: by mail-ed1-x529.google.com with SMTP id b15so16674003edd.7;
        Wed, 10 Nov 2021 15:22:00 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=UCVbuQh/C+Zs0YhtwLY4cQLxaGejdrEU0tkrFEKa7e8=;
        b=DEY3ujDvK28qjXRnSiCb6mXVIPgqRqa5u/CAnRcozpU25AJPeIv65vNp838X/ntEIm
         hD6NEC/v8QkINbfKUnL0DrnRoSSrrhvoEw9lcl4qCPsxFfEfmUGJ1y0VsKg5XaqDAvDK
         3Wz8ubzPj0YwbKHyXt02TM0aGoXsu2DWbhlT6W8h9kndSjpbpx0bDjpP660ufurSIWrB
         dZ4tpvriUv5nYF0f3GK4mKMjc4Pq/LqfbaS82wePVKOGS2S7I4Xog+ATf+fmHbTUClRu
         M3ocgPkAtjVchvb3cIMQ4AKWa06xkEjg1IVTSMQXyxd+m2YzNjPmuvkGh13ybMt/aslr
         le6w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=UCVbuQh/C+Zs0YhtwLY4cQLxaGejdrEU0tkrFEKa7e8=;
        b=Pm+kr2/20d+B86Q1mTpocGckTzMua6aDdAMX2toe2IkeLnM1nbDbw/aCiPn+nE7bCD
         Ocu2ntLD84Wk0SLxWQlRKgvTLzz3ql8m8a4jUDo4dmKaFk4ZOAIpFxaUs8lMjA+c45Qu
         joSD17NLtuOQb5ScejqX/2ISnioMn7mIbeU0qsKiCG47/LlJ2kGAVp9Ko2ZP5vcJQVs/
         BbiDxx7WuELat/9y3+ze+eOPXbOaFBChTpB6f8Ar5awonIfaH3fATio6G6+Gem9V4Tnl
         zYwTFVgNitg7VUFk5Vv0bLxz9VNegyWIddAZml6x9paajetFaj4hLblmlZhrsqLr0XCB
         uVEw==
X-Gm-Message-State: AOAM530oHEJq8AmWONz6pKDy5sqcIyXCIJiwI0Wf6syGY06OxBAY7pVX
        +TsG32ZpzONqlke05xgrZ0s=
X-Google-Smtp-Source: ABdhPJzecy4JBFxmwsmPA720C6s5UBrV9tT1wYYnl6LaVwshtMX3+qInFBbhcD49eVYAmTn3fQuthA==
X-Received: by 2002:a17:907:77c8:: with SMTP id kz8mr3693700ejc.188.1636586519314;
        Wed, 10 Nov 2021 15:21:59 -0800 (PST)
Received: from lahvuun (93-76-191-141.kha.volia.net. [93.76.191.141])
        by smtp.gmail.com with ESMTPSA id x22sm609396edd.61.2021.11.10.15.21.57
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 10 Nov 2021 15:21:58 -0800 (PST)
Date:   Thu, 11 Nov 2021 01:21:57 +0200
From:   Ilya Trukhanov <lahvuun@gmail.com>
To:     Ard Biesheuvel <ardb@kernel.org>
Cc:     "# 3.4.x" <stable@vger.kernel.org>, regressions@lists.linux.dev,
        linux-efi <linux-efi@vger.kernel.org>,
        Linux PM <linux-pm@vger.kernel.org>,
        Javier Martinez Canillas <javierm@redhat.com>,
        Thomas Zimmermann <tzimmermann@suse.de>,
        "Rafael J. Wysocki" <rafael@kernel.org>,
        Len Brown <len.brown@intel.com>, pavel@ucw.cz
Subject: Re: [REGRESSION]: drivers/firmware: move x86 Generic System
 Framebuffers support
Message-ID: <20211110232157.xfeue3sbquyhtqmf@lahvuun>
References: <20211110200253.rfudkt3edbd3nsyj@lahvuun>
 <CAMj1kXHuU8dFBUeM41bHu13nd2qQVPJizt8Epw596K89_samiQ@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAMj1kXHuU8dFBUeM41bHu13nd2qQVPJizt8Epw596K89_samiQ@mail.gmail.com>
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

On Wed, Nov 10, 2021 at 11:24:03PM +0100, Ard Biesheuvel wrote:
> Hi Ilya,
> 
> On Wed, 10 Nov 2021 at 21:02, Ilya Trukhanov <lahvuun@gmail.com> wrote:
> >
> > Suspend-to-RAM with elogind under Wayland stopped working in 5.15.
> >
> > This occurs with 5.15, 5.15.1 and latest master at
> > 89d714ab6043bca7356b5c823f5335f5dce1f930. 5.14 and earlier releases work
> > fine.
> >
> > git bisect gives d391c58271072d0b0fad93c82018d495b2633448.
> >
> > To reproduce:
> > - Use elogind and Linux 5.15.1 with CONFIG_SYSFB_SIMPLEFB=n.
> > - Start a Wayland session. I tested sway and weston, neither worked.
> > - In a terminal emulator (I used alacritty) execute `loginctl suspend`.
> >
> > Normally after the last step the system would suspend, but it no longer
> > does so after I upgraded to Linux 5.15. After running `loginctl suspend`
> > in dmesg I get the following:
> > [  103.098782] elogind-daemon[2357]: Suspending system...
> > [  103.098794] PM: suspend entry (deep)
> > [  103.124621] Filesystems sync: 0.025 seconds
> >
> > But nothing happens afterwards.
> >
> > Suspend works as expected if I do any of the following:
> > - Revert d391c58271072d0b0fad93c82018d495b2633448.
> > - Build with CONFIG_SYSFB_SIMPLEFB=y.
> 
> If this solves the issue, what else is there to discuss?
Sorry, I'm not a kernel developer, but I was under the impression
that this is a regression and should at least be brought to attention.

I also think I'm probably not the last person to encounter this. I'm
fortunate because I had the time to bisect and get the idea to try
enabling that option, but others may not know how to fix it.

The suspend not working is also not the only effect. After you execute
`loginctl suspend`, for example, the compositor just hangs if you try to
exit. Should you kill it with SysRq+I, the system suspends but after
resume doesn't respond to anything and has to be hard reset. I think
this is a pretty serious issue, even if it won't affect most users.

Sorry if I wasn't meant to CC you. The issue reporting guide says that
you should CC maintainers of affected subsystems.
> 
> 
> 
> > - Suspend from tty, even if a Wayland session is running in parallel.
> > - Suspend from under an X11 session.
> > - Suspend with `echo mem > /sys/power/state`.
> >
> > If I attach strace to the elogind-daemon process after running
> > `loginctl suspend` then the system immediately suspends. However, if
> > I attach strace *prior* to running `loginctl suspend` then no suspend,
> > and the process gets stuck on a write syscall to `/sys/power/state`.
> >
> > I "traced" a little bit with printk (sorry, I don't know of a better
> > way) and the call chain is as follows:
> > state_store -> pm_suspend -> enter_state -> suspend_prepare
> > -> pm_prepare_console -> vt_move_to_console -> vt_waitactive
> > -> __vt_event_wait
> >
> > __vt_event_wait just waits until wait_event_interruptible completes, but
> > it never does (not until I attach to elogind-daemon with strace, at
> > least). I did not follow the chain further.
> >
> > - Linux version 5.15.1 (lahvuun@lahvuun) (gcc (Gentoo 11.2.0 p1) 11.2.0,
> >   GNU ld (Gentoo 2.37_p1 p0) 2.37) #51 SMP PREEMPT Tue Nov 9 23:39:25
> >   EET 2021
> > - Gentoo Linux 2.8
> > - x86_64 AuthenticAMD
> > - dmesg: https://pastebin.com/duj33bY8
> > - .config: https://pastebin.com/7Hew1g0T
