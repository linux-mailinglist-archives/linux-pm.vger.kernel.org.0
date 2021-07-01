Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 226AF3B94D8
	for <lists+linux-pm@lfdr.de>; Thu,  1 Jul 2021 18:45:50 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230006AbhGAQsT (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Thu, 1 Jul 2021 12:48:19 -0400
Received: from mail-ot1-f41.google.com ([209.85.210.41]:41495 "EHLO
        mail-ot1-f41.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229759AbhGAQsS (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Thu, 1 Jul 2021 12:48:18 -0400
Received: by mail-ot1-f41.google.com with SMTP id m6-20020a9d1d060000b029044e2d8e855eso7132199otm.8;
        Thu, 01 Jul 2021 09:45:47 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=tg55kCy9BnkaIPndB0hyuKuJD9G9ni7AlPPZSuQ9v3w=;
        b=uFe1QGQNN+hWCZqMZBI0l9dnXY3+F4ht0UMtQw7UfsTHIXhBhLQQbxcbLIYpegjvD6
         pxNu0hz2UfyOk8hpgnDCm9ZD8PSCk3hro/s5U0+cm0j5iPG1qoXbLguQZo3dQAJiHqny
         4RkuXw3gMOtRYuMJnL1AJbO4CDN0xkCXYI0zoxXTAFrEYTZubv18CXr4ef1WUr1d0ggy
         V/w+kamiLtqbpyL0H9Z8lkP/BLzYMr8czJyV2kbql5+/0wtLwbXgyTD1Is9/X21wu1wQ
         i5GOaeZ7uRgcnCPQYEWPwmsgrnSLw6PTCDtjmcsND0rkVTl+Iqi9ryBpizl2YcnBW4bU
         qq4g==
X-Gm-Message-State: AOAM533vkw0EooG9faXX6pxkwZ31NjT16zi1xni+CrpDOnd7eLYpvQO8
        kAnwHHvZeUhFp79Sgr2MtOPMribOOJvnVGF4KyU=
X-Google-Smtp-Source: ABdhPJzJRnn4f+Vbn+ymJy286bml0QkXr0HrBOpFwNgfZMUVbXSNYFoo4KA1Pu2nyMOx8volQGLdwbVBVNuW2BqDwWI=
X-Received: by 2002:a9d:674b:: with SMTP id w11mr775865otm.260.1625157947244;
 Thu, 01 Jul 2021 09:45:47 -0700 (PDT)
MIME-Version: 1.0
References: <20210701004538.23483-1-mark-pk.tsai@mediatek.com>
In-Reply-To: <20210701004538.23483-1-mark-pk.tsai@mediatek.com>
From:   "Rafael J. Wysocki" <rafael@kernel.org>
Date:   Thu, 1 Jul 2021 18:45:36 +0200
Message-ID: <CAJZ5v0gtWRpbpL82Nh9VpkXQfOqMXAC08nNmEovHq_=xdwN=mA@mail.gmail.com>
Subject: Re: [PATCH] PM: sleep: use ktime_us_delta in initcall_debug_report()
To:     Mark-PK Tsai <mark-pk.tsai@mediatek.com>
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Matthias Brugger <matthias.bgg@gmail.com>,
        "Rafael J. Wysocki" <rjw@rjwysocki.net>,
        Pavel Machek <pavel@ucw.cz>, Len Brown <len.brown@intel.com>,
        Linux PM <linux-pm@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Linux ARM <linux-arm-kernel@lists.infradead.org>,
        "moderated list:ARM/Mediatek SoC..." 
        <linux-mediatek@lists.infradead.org>, yj.chiang@mediatek.com
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

On Thu, Jul 1, 2021 at 2:45 AM Mark-PK Tsai <mark-pk.tsai@mediatek.com> wrote:
>
> usecs is no more used after trace_device_pm_report_time replaced
> by device_pm_callback_start/end in the below change.
>
> commit e8bca479c3f2 ("PM / sleep: trace events for device PM callbacks")
>
> Use ktime_us_delta to make the debug log more precise instead of
> nsecs >> 10.
>
> Signed-off-by: Mark-PK Tsai <mark-pk.tsai@mediatek.com>
> ---
>  drivers/base/power/main.c | 5 +----
>  1 file changed, 1 insertion(+), 4 deletions(-)
>
> diff --git a/drivers/base/power/main.c b/drivers/base/power/main.c
> index f893c3c5af07..d568772152c2 100644
> --- a/drivers/base/power/main.c
> +++ b/drivers/base/power/main.c
> @@ -220,16 +220,13 @@ static void initcall_debug_report(struct device *dev, ktime_t calltime,
>                                   void *cb, int error)
>  {
>         ktime_t rettime;
> -       s64 nsecs;
>
>         if (!pm_print_times_enabled)
>                 return;
>
>         rettime = ktime_get();
> -       nsecs = (s64) ktime_to_ns(ktime_sub(rettime, calltime));
> -
>         dev_info(dev, "%pS returned %d after %Ld usecs\n", cb, error,
> -                (unsigned long long)nsecs >> 10);
> +                (unsigned long long)ktime_us_delta(rettime, calltime));
>  }
>
>  /**
> --

Applied as 5.14-rc1 material with some edits in the subject and
changelog, thanks!
