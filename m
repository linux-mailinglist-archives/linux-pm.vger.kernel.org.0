Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id B1EE28C4A8
	for <lists+linux-pm@lfdr.de>; Wed, 14 Aug 2019 01:10:35 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725923AbfHMXKe (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Tue, 13 Aug 2019 19:10:34 -0400
Received: from mail-ot1-f66.google.com ([209.85.210.66]:39421 "EHLO
        mail-ot1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725903AbfHMXKe (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Tue, 13 Aug 2019 19:10:34 -0400
Received: by mail-ot1-f66.google.com with SMTP id b1so9943258otp.6;
        Tue, 13 Aug 2019 16:10:34 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=Pszrb8barvQGWyNWoJ+Fs3dzWTSZn768LKHzdqrBxsI=;
        b=RdE+eiW75xd6Pz8SZBgjaG6z4a5SLgZbeZcH/9LeOFAASzEVs5x/cbjdYDEQ3Jbk2g
         mqmUQftPt1qyxI5OqfpgiNmEsk+nrdUrPg7Pjd548fjpZLJAoQed7vukhoQrRJdR6ZKA
         /qC0odcOUYbXnwiUp50gCwKnBEhDgiieReOjtWO6JfuwGjErLI+DPlnAykfwILqMAnGX
         9DIy+XLOKI8pbW2fOufmEmiJlkxyviVhkTnEpKedcytOqKsPqrH704CxEe5VUXGkARTy
         R8hAwnE9r3dJn3/9A8+yzmwhflne3zoV8OtIZ7U6lkBy1Y5cKIxkr3GwdjkBQSD6aFtr
         6xgQ==
X-Gm-Message-State: APjAAAVIW19XywA9GG5zCo+eC06IDkDP/naSp+qbB9rcDJXDJq2FJGQC
        vnwsv5rNIpwJk9qrj7sT1sUyUuB6UwH4PIzQxFs=
X-Google-Smtp-Source: APXvYqxSK1J7GeyFaCbHx6IjCdOS/0bPhigFihM/kYU6JSSFXu9VRXgTwpzeTMGmUfuB0Td3+52GkJadzuSdlyrrCj0=
X-Received: by 2002:a9d:65ca:: with SMTP id z10mr5607770oth.167.1565737833554;
 Tue, 13 Aug 2019 16:10:33 -0700 (PDT)
MIME-Version: 1.0
References: <1565731976.8572.16.camel@lca.pw> <5d533b43.1c69fb81.5729.a6bc@mx.google.com>
 <CANA+-vAXzHTSZa4Oq4osOOWJkme43cP8Cv2JySU--QCv-A0U_A@mail.gmail.com>
In-Reply-To: <CANA+-vAXzHTSZa4Oq4osOOWJkme43cP8Cv2JySU--QCv-A0U_A@mail.gmail.com>
From:   "Rafael J. Wysocki" <rafael@kernel.org>
Date:   Wed, 14 Aug 2019 01:10:22 +0200
Message-ID: <CAJZ5v0g0p+P7JF0Q_cmch7PbHXgQG-KQAZHyhfq7sCAkgH1rmg@mail.gmail.com>
Subject: Re: "PM / wakeup: Show wakeup sources stats in sysfs" causes boot warnings
To:     Tri Vo <trong@android.com>
Cc:     Stephen Boyd <swboyd@chromium.org>, Qian Cai <cai@lca.pw>,
        Peter Zijlstra <peterz@infradead.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        "Rafael J. Wysocki" <rafael@kernel.org>,
        Linux PM <linux-pm@vger.kernel.org>,
        LKML <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

On Wed, Aug 14, 2019 at 1:04 AM Tri Vo <trong@android.com> wrote:
>
> On Tue, Aug 13, 2019 at 3:35 PM Stephen Boyd <swboyd@chromium.org> wrote:
> >
> > Quoting Qian Cai (2019-08-13 14:32:56)
> > > The linux-next commit "PM / wakeup: Show wakeup sources stats in sysfs" [1]
> > > introduced some baddies during boot on several x86 servers. Reverted the commit
> > > fixed the issue.
> > >
> > > [1] https://lore.kernel.org/lkml/20190807014846.143949-4-trong@android.com/
> > >
> > > [   39.195053][    T1] serio: i8042 KBD port at 0x60,0x64 irq 1
> > > [   39.197347][    T1] kobject_add_internal failed for wakeup (error: -2 parent:
> > > serio0)
> > > [   39.199845][    T1] INFO: trying to register non-static key.
> > > [   39.201582][    T1] the code is fine but needs lockdep annotation.
> > > [   39.203477][    T1] turning off the locking correctness validator.
> > > [   39.205399][    T1] CPU: 12 PID: 1 Comm: swapper/0 Not tainted 5.3.0-rc4-
> > > next-20190813 #3
> > > [   39.207938][    T1] Hardware name: HP ProLiant XL420 Gen9/ProLiant XL420
> > > Gen9, BIOS U19 12/27/2015
> > > [   39.210606][    T1] Call Trace:
> > > [   39.210606][    T1]  dump_stack+0x62/0x9a
> > > [   39.210606][    T1]  register_lock_class+0x95a/0x960
> > > [   39.210606][    T1]  ? __platform_driver_probe+0xcd/0x230
> > > [   39.210606][    T1]  ? __platform_create_bundle+0xc0/0xe0
> > > [   39.210606][    T1]  ? i8042_init+0x4ec/0x578
> > > [   39.210606][    T1]  ? do_one_initcall+0xfe/0x45a
> > > [   39.219571][    T1]  ? kernel_init_freeable+0x614/0x6a7
> > > [   39.219571][    T1]  ? kernel_init+0x11/0x138
> > > [   39.219571][    T1]  ? ret_from_fork+0x35/0x40
> > > [   39.219571][    T1]  ? is_dynamic_key+0xf0/0xf0
> > > [   39.219571][    T1]  ? rwlock_bug.part.0+0x60/0x60
> > > [   39.219571][    T1]  ? __debug_check_no_obj_freed+0x8e/0x250
> > > [   39.219571][    T1]  __lock_acquire.isra.13+0x5f/0x830
> > > [   39.229491][    T1]  ? __debug_check_no_obj_freed+0x152/0x250
> > > [   39.229491][    T1]  lock_acquire+0x107/0x220
> > > [   39.229491][    T1]  ? __pm_relax.part.2+0x21/0xa0
> > > [   39.229491][    T1]  _raw_spin_lock_irqsave+0x35/0x50
> > > [   39.229491][    T1]  ? __pm_relax.part.2+0x21/0xa0
> > > [   39.229491][    T1]  __pm_relax.part.2+0x21/0xa0
> > > [   39.239588][    T1]  wakeup_source_destroy.part.3+0x18/0x190
> > > [   39.239588][    T1]  wakeup_source_register+0x43/0x50
> >
> > We shouldn't call wakeup_source_destroy() from the error path in
> > wakeup_source_register() because that calls __pm_relax() and that takes
> > a lock that isn't initialized until wakeup_source_add() is called. Can
> > you try this patch?
>
> Right, that makes sense. Thanks for sending a fix, Stephen!
>
> What's the preferred procedure for merging this fix? Should we apply
> this commit on top of pm tree? Or should I resend a new version of the
> offending patch? Sorry, I'm still new to this.

I can apply this patch as a fix if it is resent with a proper changelog.
