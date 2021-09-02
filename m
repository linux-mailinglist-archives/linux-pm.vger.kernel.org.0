Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A90903FF15E
	for <lists+linux-pm@lfdr.de>; Thu,  2 Sep 2021 18:28:34 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234571AbhIBQ3b (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Thu, 2 Sep 2021 12:29:31 -0400
Received: from mail-oi1-f174.google.com ([209.85.167.174]:34537 "EHLO
        mail-oi1-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1346312AbhIBQ3Y (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Thu, 2 Sep 2021 12:29:24 -0400
Received: by mail-oi1-f174.google.com with SMTP id p2so3295690oif.1;
        Thu, 02 Sep 2021 09:28:25 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=yAfF6voZMV5HL2emobgman82UwdzTl9MjI3NYiAvvY8=;
        b=CvSdputKjf5THPrzwpFEzM7yPK+xb2OENDZHJS3JFjnA8OvXjHsAPEp/LmPpUIMdto
         xNGi39vhtMJzsYAe3qMY2YztYw2akklDxJrmHa64yaPegF8+eZu44+HkHcpXrJfnKBw8
         nRkkP+TPD2YBC5NI0rgiJvBM1/QwWajnBvWiCejdrpQNSc7AafLJvurMzs+Urc25R7YX
         thTj8rq4nH8hoAYXX9ZVoGB0w8cp/5mUXFyEmodBjbiMehh/DzK4ZCbag+7NyxJ0vDsO
         +p6zornnbmWc0EFOO91Fx4RuIkbhP26kpH6zygXUzx08+8i9AfwxXb03b2pw7vWIIN6r
         daeg==
X-Gm-Message-State: AOAM533KKwMzhu7yH7mZnMwGGNSySpPFVH7X5WfuscK4ExJYmcrhI/Vy
        KVtOpUKuvU1szL79Xh7v89Hi73aK5hm164Cs0lQ=
X-Google-Smtp-Source: ABdhPJwg0lvNr/QwsNhFe4IobRTfilUwoaE+FI69nZyCe2YopZSoRjuvrS/SxUVf8ud4LCqA44b+ACTfkChQgkY6tt4=
X-Received: by 2002:aca:afcd:: with SMTP id y196mr2831372oie.71.1630600104769;
 Thu, 02 Sep 2021 09:28:24 -0700 (PDT)
MIME-Version: 1.0
References: <20210901083442.210230-1-sean@geanix.com>
In-Reply-To: <20210901083442.210230-1-sean@geanix.com>
From:   "Rafael J. Wysocki" <rafael@kernel.org>
Date:   Thu, 2 Sep 2021 18:28:14 +0200
Message-ID: <CAJZ5v0j5dMDSDjhuXaZd=_J5JOP4Z09WUXfjWX_iCcT4RDisCg@mail.gmail.com>
Subject: Re: [PATCH] PM / suspend: move userspace freeze before disk sync
To:     Sean Nyekjaer <sean@geanix.com>
Cc:     Miquel Raynal <miquel.raynal@bootlin.com>,
        Sascha Hauer <s.hauer@pengutronix.de>,
        Richard Weinberger <richard@nod.at>,
        Linux PM <linux-pm@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Len Brown <len.brown@intel.com>, linux-mtd@lists.infradead.org
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

On Wed, Sep 1, 2021 at 10:35 AM Sean Nyekjaer <sean@geanix.com> wrote:
>
> This fixes an issue where data remains unwritten before suspend.

Well, it doesn't make the issue go away, it just hides it for you and
it may very well expose it for someone else.

In particular, note that you can compile the kernel with
CONFIG_SUSPEND_SKIP_SYNC set which makes it not sync at all during
system-wide suspend and this is a valid case expected to work.  It
looks like this case doesn't work for you.

> UBI tried to write data, before the mtd device had been unsuspended.

Well, that's the real problem and it can happen regardless of whether
or not this patch is there.

> Seen on an iMX6ULL board fitted with rawnand flash.
>
> Before:
> PM: suspend entry (deep)
> Filesystems sync: 0.088 seconds
> Freezing user space processes ... (elapsed 0.000 seconds) done.
> OOM killer disabled.
> Freezing remaining freezable tasks ... (elapsed 0.001 seconds) done.
> printk: Suspending console(s) (use no_console_suspend to debug)
> PM: suspend devices took 0.030 seconds
> Disabling non-boot CPUs ...
> ubi0 error: ubi_io_write: error -16 while writing 4096 bytes to PEB 1762:94208, written 0 bytes
>
> After:
> PM: suspend entry (deep)
> Freezing user space processes ... (elapsed 0.001 seconds) done.
> OOM killer disabled.
> Freezing remaining freezable tasks ... (elapsed 0.001 seconds) done.
> Filesystems sync: 0.060 seconds
> printk: Suspending console(s) (use no_console_suspend to debug)
> PM: suspend devices took 0.040 seconds
> Disabling non-boot CPUs ...
> PM: resume devices took 0.100 seconds
>
> Signed-off-by: Sean Nyekjaer <sean@geanix.com>
> ---
>
> Some explanation/discussion here:
> http://lists.infradead.org/pipermail/linux-mtd/2021-July/087390.html
>
>  kernel/power/suspend.c | 12 ++++++------
>  1 file changed, 6 insertions(+), 6 deletions(-)
>
> diff --git a/kernel/power/suspend.c b/kernel/power/suspend.c
> index 87331565e505..4ee3fcbb0e7a 100644
> --- a/kernel/power/suspend.c
> +++ b/kernel/power/suspend.c
> @@ -562,6 +562,12 @@ static int enter_state(suspend_state_t state)
>         if (state == PM_SUSPEND_TO_IDLE)
>                 s2idle_begin();
>
> +       pm_pr_dbg("Preparing system for sleep (%s)\n", mem_sleep_labels[state]);
> +       pm_suspend_clear_flags();
> +       error = suspend_prepare(state);
> +       if (error)
> +               goto Unlock;
> +
>  #ifndef CONFIG_SUSPEND_SKIP_SYNC
>         trace_suspend_resume(TPS("sync_filesystems"), 0, true);
>         pr_info("Syncing filesystems ... ");
> @@ -570,12 +576,6 @@ static int enter_state(suspend_state_t state)
>         trace_suspend_resume(TPS("sync_filesystems"), 0, false);
>  #endif
>
> -       pm_pr_dbg("Preparing system for sleep (%s)\n", mem_sleep_labels[state]);
> -       pm_suspend_clear_flags();
> -       error = suspend_prepare(state);
> -       if (error)
> -               goto Unlock;
> -
>         if (suspend_test(TEST_FREEZER))
>                 goto Finish;
>
> --
> 2.33.0
>
