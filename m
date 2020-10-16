Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 885EF290633
	for <lists+linux-pm@lfdr.de>; Fri, 16 Oct 2020 15:22:28 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2394761AbgJPNW1 (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Fri, 16 Oct 2020 09:22:27 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43906 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2394611AbgJPNW1 (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Fri, 16 Oct 2020 09:22:27 -0400
Received: from mail-pl1-x64a.google.com (mail-pl1-x64a.google.com [IPv6:2607:f8b0:4864:20::64a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C6432C061755
        for <linux-pm@vger.kernel.org>; Fri, 16 Oct 2020 06:22:25 -0700 (PDT)
Received: by mail-pl1-x64a.google.com with SMTP id v7so1327084plp.23
        for <linux-pm@vger.kernel.org>; Fri, 16 Oct 2020 06:22:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=sender:mime-version:message-id:date:subject:from:to:cc;
        bh=YEanuN8sObryFQCW5AeGRJqhNtr6AqJyoyNt3MXkCtQ=;
        b=Lb0gXw0QDfcZawEb9d4CS03gSg5l+NVqm/offdQFobtd/XQmc8GeOX/5aRCnTa0V7m
         nOUJeNhMC5nf7hIhwkDn8whq1zLzvnGaT63dVGk0lLZhHB4xtyk22Hdqx8oxzHFMZpPm
         AeQvDTMeIARJXCXYqvm0JcdlwR2z0vYpYnMTVplE43i2b2WVZLgDr3suIlTFtzGvKOaN
         V12vVzsCFWZfgWsiXOkPGnxdoRRAaTc3Nd2D83WyBOfRGuEmbvngr7gO42sLzcD3980i
         bnueUr5UJRm6kT9vNxv85UTSHBLPUYW3RSsaQpYJcH05KAvi+jo7n2vjJVrXi4MQStEk
         vflw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:mime-version:message-id:date:subject:from
         :to:cc;
        bh=YEanuN8sObryFQCW5AeGRJqhNtr6AqJyoyNt3MXkCtQ=;
        b=j3o9qiUWljerWmfC7QNcob4XGlNOVQfS5MipkaQy8wi4fVOz0FpeIlxVaasee04hEt
         6bXh1MstEd7UEe/idQdIQIMsdadVP+3DWcesOa4PHNk2GFl6uby63e5vf+L31SFBjYFq
         OqWCezNp5+9N7EnxUuR3AHtZbQ4KUJawTunTd6PT64A7YNYZ0nGpSD9Tag3Jwhr0xh3O
         M36exLuEHPvKN3dgJRFigMbv4ShW9hahgFvyc6Z5+8UVb4SgVCDxRWHvQ8GdVqucxsir
         UPWtD0WtvMYXBI87aiPXfwPCQUzlIBaSSPbxWviJ1F+LutBqaQBOGs8ZdIbS0NnRkP1j
         ArGg==
X-Gm-Message-State: AOAM533MaiD2WYcUca1OiZsObQZQ+q0i8gikD366LZQH7a9TdLmThoRY
        C0LQw/zSY99nbsvLYHtQmu9u3sb1gwP4aY1B
X-Google-Smtp-Source: ABdhPJxMAFpmDwvWzRB8k+Eouj+/UWaZkKvju8/sAQz6PIiX/QjQMHqg62BhG+UIye5lHBAbjB7ZR/CqP13OW1hZ
Sender: "josephjang via sendgmr" 
        <josephjang@josephjang-p920.ntc.corp.google.com>
MIME-Version: 1.0
X-Received: from josephjang-p920.ntc.corp.google.com ([2401:fa00:fc:1:7220:84ff:fe09:41e0])
 (user=josephjang job=sendgmr) by 2002:a62:4e05:0:b029:156:6a80:2686 with SMTP
 id c5-20020a624e050000b02901566a802686mr3525957pfb.61.1602854545149; Fri, 16
 Oct 2020 06:22:25 -0700 (PDT)
Message-ID: <000000000000cafee605b1c9a745@google.com>
Date:   Fri, 16 Oct 2020 13:22:25 +0000
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

Thank you Rafael's promptly response.

> On Fri, Oct 16, 2020 at 5:51 AM Joseph Jang <josephjang@google.com> wrote:
> >
> > From: josephjang <josephjang@google.com>
> >
> > Add suspend timeout handler to prevent device stuck during suspend/
> > resume process. Suspend timeout handler will dump disk sleep task
> > at first round timeout and trigger kernel panic at second round timeout.
> > The default timer for each round is 30 seconds.
> >
> > Note: Can use following command to simulate suspend hang for testing.
> >     adb shell echo 1 > /sys/power/pm_hang
> >     adb shell echo mem > /sys/power/state
> > Signed-off-by: josephjang <josephjang@google.com>
> > ---
> >  include/linux/console.h |   1 +
> >  kernel/power/Kconfig    |   9 +++
> >  kernel/power/main.c     |  66 ++++++++++++++++
> >  kernel/power/suspend.c  | 162 ++++++++++++++++++++++++++++++++++++++++
> >  kernel/printk/printk.c  |   5 ++
> >  5 files changed, 243 insertions(+)
> >
> > diff --git a/include/linux/console.h b/include/linux/console.h
> > index 0670d3491e0e..ac468c602c0b 100644
> > --- a/include/linux/console.h
> > +++ b/include/linux/console.h
> > @@ -192,6 +192,7 @@ static inline void console_sysfs_notify(void)
> >  { }
> >  #endif
> >  extern bool console_suspend_enabled;
> > +extern int is_console_suspended(void);
> >
> >  /* Suspend and resume console messages over PM events */
> >  extern void suspend_console(void);
> > diff --git a/kernel/power/Kconfig b/kernel/power/Kconfig
> > index a7320f07689d..52b7a181b6d8 100644
> > --- a/kernel/power/Kconfig
> > +++ b/kernel/power/Kconfig
> > @@ -207,6 +207,15 @@ config PM_SLEEP_DEBUG
> >         def_bool y
> >         depends on PM_DEBUG && PM_SLEEP
> >
> > +config PM_SLEEP_MONITOR
> > +       bool "Linux kernel suspend/resume process monitor"
> > +       depends on PM_SLEEP
> > +       help
> > +       This option will enable suspend/resume monitor to prevent device
> > +       stuck during suspend/resume process. Suspend timeout handler  
> will
> > +       dump disk sleep task at first round timeout and trigger kernel  
> panic
> > +       at second round timeout. The default timer for each round is 30  
> seconds.
> > +

> The facility associated with the Kconfig entry right below is supposed
> to do exactly the same thing.

> What's the reason to add another one?  What is missing?



> >  config DPM_WATCHDOG
> >         bool "Device suspend/resume watchdog"
> >         depends on PM_DEBUG && PSTORE && EXPERT

Because we found some suspend hand issue that cannot be detected by
"CONFIG_DPM_WATCHDOG" (which is focus on device PM).
Our suspend timeout monitor can cover PM core and Device PM hang issues.

Thank you,
Joseph.
