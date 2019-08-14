Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id A46B48CFBB
	for <lists+linux-pm@lfdr.de>; Wed, 14 Aug 2019 11:35:08 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726496AbfHNJfH (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Wed, 14 Aug 2019 05:35:07 -0400
Received: from mail-oi1-f196.google.com ([209.85.167.196]:40350 "EHLO
        mail-oi1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726230AbfHNJfH (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Wed, 14 Aug 2019 05:35:07 -0400
Received: by mail-oi1-f196.google.com with SMTP id h21so2807876oie.7;
        Wed, 14 Aug 2019 02:35:06 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=Bw5KhbpmibFWhChU8YoAfUG7HzRzPn3xcgdayXlgbWA=;
        b=I0/3itXLi7byMjI4r4146+nK2sgSrVZGr0v9LjTC2gHfIj6VNo13WdVpzwzpgycqjV
         Z5lSN2oscM0MN6wjZJzlpTv2OHM9pZw23z6jYd5NVpWpokz8uDfS+pGlr2wuBtt6VTYg
         hxbaWXpMPX/UJB7gBOVCUF0DxWeLJk713i1MXWdog/BdR7E871giVV9qQnpWgz+2Xn8Q
         O9oZvhaX7uCmKUU2qOWC0kH/7zEXJ1AEVBrXwFIiwYBrcPWm3RJINCfrd9uCDuGalq3y
         dHXYIUqt1Fs7WywzXcFu3ElQDjpgbBxHOHXFZnox7Q1ULt/4v6GMngA8t1gXcgAgToPX
         CILw==
X-Gm-Message-State: APjAAAUKCOE85kseGXrvvrWrUw+jA03oUVykWtaTq1eD/iLlJBJdkKMb
        FNyCd/66uYkRLVHX/qKsKqoEhcrKv89acJgHoGM=
X-Google-Smtp-Source: APXvYqxT08JTHoU9IIFLNv0rxGzFt+rmcw413cBIvAnyG34f7vnC9YGHZUNQ2XqUeo1/iaAXT6LbLCv/piqoWcvq0gE=
X-Received: by 2002:aca:ab56:: with SMTP id u83mr4787577oie.57.1565775305817;
 Wed, 14 Aug 2019 02:35:05 -0700 (PDT)
MIME-Version: 1.0
References: <20190814004053.23775-1-swboyd@chromium.org>
In-Reply-To: <20190814004053.23775-1-swboyd@chromium.org>
From:   "Rafael J. Wysocki" <rafael@kernel.org>
Date:   Wed, 14 Aug 2019 11:34:54 +0200
Message-ID: <CAJZ5v0gaC0AzJak8qmGf-qH8bbMiRDXB6r-PuHzPO4rU7eeAFw@mail.gmail.com>
Subject: Re: [PATCH] PM / wakeup: Fix sysfs registration error path
To:     Stephen Boyd <swboyd@chromium.org>
Cc:     "Rafael J. Wysocki" <rjw@rjwysocki.net>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Linux PM <linux-pm@vger.kernel.org>, Qian Cai <cai@lca.pw>,
        Tri Vo <trong@android.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

On Wed, Aug 14, 2019 at 2:40 AM Stephen Boyd <swboyd@chromium.org> wrote:
>
> We shouldn't call wakeup_source_destroy() from the error path in
> wakeup_source_register() because that calls __pm_relax() which takes a
> lock that isn't initialized until wakeup_source_add() is called. Add a
> new function, wakeup_source_free(), that just does the bare minimum to
> free a wakeup source that was created but hasn't been added yet and use
> it from the two places it's needed. This fixes the following problem
> seen on various x86 server boxes:
>
>  INFO: trying to register non-static key.
>  the code is fine but needs lockdep annotation.
>  turning off the locking correctness validator.
>  CPU: 12 PID: 1 Comm: swapper/0 Not tainted 5.3.0-rc4-
>  Hardware name: HP ProLiant XL420 Gen9/ProLiant XL420 Gen9, BIOS U19 12/27/2015
>  Call Trace:
>   dump_stack+0x62/0x9a
>   register_lock_class+0x95a/0x960
>   ? __platform_driver_probe+0xcd/0x230
>   ? __platform_create_bundle+0xc0/0xe0
>   ? i8042_init+0x4ec/0x578
>   ? do_one_initcall+0xfe/0x45a
>   ? kernel_init_freeable+0x614/0x6a7
>   ? kernel_init+0x11/0x138
>   ? ret_from_fork+0x35/0x40
>   ? is_dynamic_key+0xf0/0xf0
>   ? rwlock_bug.part.0+0x60/0x60
>   ? __debug_check_no_obj_freed+0x8e/0x250
>   __lock_acquire.isra.13+0x5f/0x830
>   ? __debug_check_no_obj_freed+0x152/0x250
>   lock_acquire+0x107/0x220
>   ? __pm_relax.part.2+0x21/0xa0
>   _raw_spin_lock_irqsave+0x35/0x50
>   ? __pm_relax.part.2+0x21/0xa0
>   __pm_relax.part.2+0x21/0xa0
>   wakeup_source_destroy.part.3+0x18/0x190
>   wakeup_source_register+0x43/0x50
>
> Fixes: 986845e747af ("PM / wakeup: Show wakeup sources stats in sysfs")
> Reported-by: Qian Cai <cai@lca.pw>
> Cc: Qian Cai <cai@lca.pw>
> Cc: Tri Vo <trong@android.com>
> Cc: Peter Zijlstra <peterz@infradead.org>
> Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
> Signed-off-by: Stephen Boyd <swboyd@chromium.org>
> ---
>  drivers/base/power/wakeup.c | 13 +++++++++----
>  1 file changed, 9 insertions(+), 4 deletions(-)
>
> diff --git a/drivers/base/power/wakeup.c b/drivers/base/power/wakeup.c
> index 3a7f5803aa81..f7925820b5ca 100644
> --- a/drivers/base/power/wakeup.c
> +++ b/drivers/base/power/wakeup.c
> @@ -137,6 +137,13 @@ static void wakeup_source_record(struct wakeup_source *ws)
>         spin_unlock_irqrestore(&deleted_ws.lock, flags);
>  }
>
> +static void wakeup_source_free(struct wakeup_source *ws)
> +{
> +       ida_free(&wakeup_ida, ws->id);
> +       kfree_const(ws->name);
> +       kfree(ws);
> +}
> +
>  /**
>   * wakeup_source_destroy - Destroy a struct wakeup_source object.
>   * @ws: Wakeup source to destroy.
> @@ -150,9 +157,7 @@ void wakeup_source_destroy(struct wakeup_source *ws)
>
>         __pm_relax(ws);
>         wakeup_source_record(ws);
> -       ida_free(&wakeup_ida, ws->id);
> -       kfree_const(ws->name);
> -       kfree(ws);
> +       wakeup_source_free(ws);
>  }
>  EXPORT_SYMBOL_GPL(wakeup_source_destroy);
>
> @@ -217,7 +222,7 @@ struct wakeup_source *wakeup_source_register(struct device *dev,
>         if (ws) {
>                 ret = wakeup_source_sysfs_add(dev, ws);
>                 if (ret) {
> -                       wakeup_source_destroy(ws);
> +                       wakeup_source_free(ws);
>                         return NULL;
>                 }
>                 wakeup_source_add(ws);
> --

Applied, thanks!
