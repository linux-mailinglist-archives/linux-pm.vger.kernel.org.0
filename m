Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8BCA71CD21F
	for <lists+linux-pm@lfdr.de>; Mon, 11 May 2020 08:55:18 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728466AbgEKGzO (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Mon, 11 May 2020 02:55:14 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53388 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-FAIL-OK-FAIL)
        by vger.kernel.org with ESMTP id S1728353AbgEKGzM (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Mon, 11 May 2020 02:55:12 -0400
Received: from mail-ot1-x341.google.com (mail-ot1-x341.google.com [IPv6:2607:f8b0:4864:20::341])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4DD45C061A0E
        for <linux-pm@vger.kernel.org>; Sun, 10 May 2020 23:55:11 -0700 (PDT)
Received: by mail-ot1-x341.google.com with SMTP id m18so6676559otq.9
        for <linux-pm@vger.kernel.org>; Sun, 10 May 2020 23:55:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=endlessm-com.20150623.gappssmtp.com; s=20150623;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=NqE5Hd6mfokSG+/fYRFQAPgofHTiWpj3lFcNor9u7kc=;
        b=Zg11uLNU9ywU36wb9YDC/vWtcGTb03E8YdiJ0DCgs4CFFAhhLJ1RIkzQzTryf4jaxq
         YBJ3t796heGmNrxmFjgB0VQTo7gXh7lKcxbrgk7foaMVMJXw+Q85cSbM5phLukcsZFCs
         JpbjAyYV1ScyY/FKb29xvy2GrG2b+MgCM+lL69Gad/0filOPGUKUtPBP/8oVwJzjYyIF
         WnJCLUCIJaRirrMuvApKGEUYBFVgcqxhvopk0NZjyh4bcJHCwHAhKMB6wVz5p77Hbo9k
         UOUF+8QD3dj1w8UciJreTMX2LRuu1u6lG/TBpwlZ133chk1H3o1BD2irZMo33jbUFdr+
         LqBQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=NqE5Hd6mfokSG+/fYRFQAPgofHTiWpj3lFcNor9u7kc=;
        b=m8fSkT7KLceYqmM1dJOL9xBBBzp4S5UqcDyXMi5lRvAIFInPHkkM62g9OJ320ugHxZ
         GC2dxftQrNn0rNWdPSvW2fqZl2fn7kqyx0Olyw9hSDXTl1yMuq0+JPJN1ARwhZFY9GlQ
         Fo42ZzUSByqhK9uP4oDHNBk6A58d+4TidYjvq8WVsR5MW2oQhsg3S5rMe8eC2sD103NH
         HvN/rBUNz9RNfQWLyghOCEchDXH88uc2t4RMRJlZXlXIbCzd8g+lwZcuLPWRIaPbqv/7
         7szRaqiV3lErOhcmAu5Yr4wo/i6Tb1QQIhBj3la/G78kKQgDaKV/0kclO0FYtly9DTNv
         QLOw==
X-Gm-Message-State: AGi0PuZp7bW3fjHuMallTK2N8EQoAZXZ8quddz9rau28XM6sw4+2TeBt
        b9adUrPkMAIgPXQTjW4pGTrNEpCWmeNq1aXWqXivvg==
X-Google-Smtp-Source: APiQypJx8MZQXkFp5WsraQLtG72h4Sny3Lasm6pZs7q/K/VxbPocZXTT3hNxCb9DL3z70CaYxjtiG9/cPAgn1SDWbQY=
X-Received: by 2002:a05:6830:1212:: with SMTP id r18mr12002639otp.144.1589180110526;
 Sun, 10 May 2020 23:55:10 -0700 (PDT)
MIME-Version: 1.0
References: <13031978.1nyG40egBz@kreacher>
In-Reply-To: <13031978.1nyG40egBz@kreacher>
From:   Chris Chiu <chiu@endlessm.com>
Date:   Mon, 11 May 2020 14:54:59 +0800
Message-ID: <CAB4CAwfpO6=24tdVBtZ258hAE=sMyww-P9t1PC=BALhy3rHxSQ@mail.gmail.com>
Subject: Re: [PATCH v2] ACPI: EC: s2idle: Avoid premature returns from acpi_s2idle_wake()
To:     "Rafael J. Wysocki" <rjw@rjwysocki.net>
Cc:     Linux ACPI <linux-acpi@vger.kernel.org>,
        Linux PM <linux-pm@vger.kernel.org>,
        Zhang Rui <rui.zhang@intel.com>,
        LKML <linux-kernel@vger.kernel.org>,
        Todd Brandt <todd.e.brandt@linux.intel.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

On Sat, May 9, 2020 at 4:44 PM Rafael J. Wysocki <rjw@rjwysocki.net> wrote:
>
> From: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
>
> If the EC GPE status is not set after checking all of the other GPEs,
> acpi_s2idle_wake() returns 'false', to indicate that the SCI event
> that has just triggered is not a system wakeup one, but it does that
> without canceling the pending wakeup and re-arming the SCI for system
> wakeup which is a mistake, because it may cause s2idle_loop() to busy
> spin until the next valid wakeup event.  [If that happens, the first
> spurious wakeup is still pending after acpi_s2idle_wake() has
> returned, so s2idle_enter() does nothing, acpi_s2idle_wake()
> is called again and it sees that the SCI has triggered, but no GPEs
> are active, so 'false' is returned again, and so on.]
>
> Fix that by moving all of the GPE checking logic from
> acpi_s2idle_wake() to acpi_ec_dispatch_gpe() and making the
> latter return 'true' only if a non-EC GPE has triggered and
> 'false' otherwise, which will cause acpi_s2idle_wake() to
> cancel the pending SCI wakeup and re-arm the SCI for system
> wakeup regardless of the EC GPE status.
>
> This also addresses a lockup observed on an Elitegroup EF20EA laptop
> after attempting to wake it up from suspend-to-idle by a key press.
>
> Fixes: d5406284ff80 ("ACPI: PM: s2idle: Refine active GPEs check")
> Link: https://bugzilla.kernel.org/show_bug.cgi?id=207603
> Reported-by: Todd Brandt <todd.e.brandt@linux.intel.com>
> Fixes: fdde0ff8590b ("ACPI: PM: s2idle: Prevent spurious SCIs from waking up the system")
> Link: https://lore.kernel.org/linux-acpi/CAB4CAwdqo7=MvyG_PE+PGVfeA17AHF5i5JucgaKqqMX6mjArbQ@mail.gmail.com/
> Reported-by: Chris Chiu <chiu@endlessm.com>
> Cc: 5.4+ <stable@vger.kernel.org> # 5.4+
> Signed-off-by: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
> ---
Tested-by: Chris Chiu <chiu@endlessm.com>
>
> -> v2:
>    * Improve the changelog and add more tags.
>
> ---
>  drivers/acpi/ec.c       |   24 ++++++++++++++++--------
>  drivers/acpi/internal.h |    1 -
>  drivers/acpi/sleep.c    |   14 ++------------
>  3 files changed, 18 insertions(+), 21 deletions(-)
>
> Index: linux-pm/drivers/acpi/sleep.c
> ===================================================================
> --- linux-pm.orig/drivers/acpi/sleep.c
> +++ linux-pm/drivers/acpi/sleep.c
> @@ -1013,21 +1013,11 @@ static bool acpi_s2idle_wake(void)
>                 if (acpi_check_wakeup_handlers())
>                         return true;
>
> -               /*
> -                * If the status bit is set for any enabled GPE other than the
> -                * EC one, the wakeup is regarded as a genuine one.
> -                */
> -               if (acpi_ec_other_gpes_active())
> +               /* Check non-EC GPE wakeups and dispatch the EC GPE. */
> +               if (acpi_ec_dispatch_gpe())
>                         return true;
>
>                 /*
> -                * If the EC GPE status bit has not been set, the wakeup is
> -                * regarded as a spurious one.
> -                */
> -               if (!acpi_ec_dispatch_gpe())
> -                       return false;
> -
> -               /*
>                  * Cancel the wakeup and process all pending events in case
>                  * there are any wakeup ones in there.
>                  *
> Index: linux-pm/drivers/acpi/ec.c
> ===================================================================
> --- linux-pm.orig/drivers/acpi/ec.c
> +++ linux-pm/drivers/acpi/ec.c
> @@ -1994,23 +1994,31 @@ void acpi_ec_set_gpe_wake_mask(u8 action
>                 acpi_set_gpe_wake_mask(NULL, first_ec->gpe, action);
>  }
>
> -bool acpi_ec_other_gpes_active(void)
> -{
> -       return acpi_any_gpe_status_set(first_ec ? first_ec->gpe : U32_MAX);
> -}
> -
>  bool acpi_ec_dispatch_gpe(void)
>  {
>         u32 ret;
>
>         if (!first_ec)
> +               return acpi_any_gpe_status_set(U32_MAX);
> +
> +       /*
> +        * Report wakeup if the status bit is set for any enabled GPE other
> +        * than the EC one.
> +        */
> +       if (acpi_any_gpe_status_set(first_ec->gpe))
> +               return true;
> +
> +       if (ec_no_wakeup)
>                 return false;
>
> +       /*
> +        * Dispatch the EC GPE in-band, but do not report wakeup in any case
> +        * to allow the caller to process events properly after that.
> +        */
>         ret = acpi_dispatch_gpe(NULL, first_ec->gpe);
> -       if (ret == ACPI_INTERRUPT_HANDLED) {
> +       if (ret == ACPI_INTERRUPT_HANDLED)
>                 pm_pr_dbg("EC GPE dispatched\n");
> -               return true;
> -       }
> +
>         return false;
>  }
>  #endif /* CONFIG_PM_SLEEP */
> Index: linux-pm/drivers/acpi/internal.h
> ===================================================================
> --- linux-pm.orig/drivers/acpi/internal.h
> +++ linux-pm/drivers/acpi/internal.h
> @@ -202,7 +202,6 @@ void acpi_ec_remove_query_handler(struct
>
>  #ifdef CONFIG_PM_SLEEP
>  void acpi_ec_flush_work(void);
> -bool acpi_ec_other_gpes_active(void);
>  bool acpi_ec_dispatch_gpe(void);
>  #endif
>
>
>
>
