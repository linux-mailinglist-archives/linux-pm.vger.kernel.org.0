Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 42E0B38CB6A
	for <lists+linux-pm@lfdr.de>; Fri, 21 May 2021 18:57:15 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234189AbhEUQ6h (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Fri, 21 May 2021 12:58:37 -0400
Received: from mail-ot1-f51.google.com ([209.85.210.51]:42801 "EHLO
        mail-ot1-f51.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235253AbhEUQ6h (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Fri, 21 May 2021 12:58:37 -0400
Received: by mail-ot1-f51.google.com with SMTP id g7-20020a9d12870000b0290328b1342b73so10772660otg.9
        for <linux-pm@vger.kernel.org>; Fri, 21 May 2021 09:57:13 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=eoA3Uf/3di6e9LaCixXNqCLwOq94n+Djp8/PVFviqmQ=;
        b=Pm+F/TJE62wBQaVeNePkTCxOlL5iT4BPFPvdwK59T40f/ksy6I8SWYCkDxWEXE2nxG
         CZe18vk687trRlbFdR+sobnWbwfnAyXq/UVY0blRtbZXshglrApYgSQ3UIko4q9e2/Dp
         YBZFb+rsdD1BpzkH65tS/UBD9SEA4vLdq4jcz857dvU+xSKmbNf9SIYlehxSj5KX8ioG
         LyeRBLPTXxrAc1ut+fvPb1hxsQrRmXdgkpG+riBgLnZZcLXyIq7FUfM5Az7WHP4VhiSh
         WQHpZo8/V6I66wauYwenUWCiSE+fQ6ezCqEGzuEWsEon1W3E9BEO1QwEe0AQOTAcD7bg
         gvLQ==
X-Gm-Message-State: AOAM5332TeUf+BxN5jhmHcaMA7cXj7PjjHeL7HYGoLPHEQfTaOltcg9L
        i/dPb0b8RVntNi49n/B02oyln5Goz1xkonDG/dQ=
X-Google-Smtp-Source: ABdhPJxJOQryPtUO7XjO665T/wVwvsxwuLbzMNOcniuq1uBi9jademNSgAss1LbttTtEhmbuv2QsxY0G3DZ98FvBU6E=
X-Received: by 2002:a05:6830:164c:: with SMTP id h12mr1695462otr.321.1621616233616;
 Fri, 21 May 2021 09:57:13 -0700 (PDT)
MIME-Version: 1.0
References: <1621496098-50271-1-git-send-email-tiantao6@hisilicon.com>
In-Reply-To: <1621496098-50271-1-git-send-email-tiantao6@hisilicon.com>
From:   "Rafael J. Wysocki" <rafael@kernel.org>
Date:   Fri, 21 May 2021 18:57:02 +0200
Message-ID: <CAJZ5v0ie_ijC4XVBxnS9tid-q_vbMm6zXwvvOoMMEe20E_mLUQ@mail.gmail.com>
Subject: Re: [PATCH] PM / wakeirq: move to use request_irq by IRQF_NO_AUTOEN flag
To:     Tian Tao <tiantao6@hisilicon.com>, Tony Lindgren <tony@atomide.com>
Cc:     "Rafael J. Wysocki" <rjw@rjwysocki.net>,
        Len Brown <len.brown@intel.com>, Pavel Machek <pavel@ucw.cz>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Linux PM <linux-pm@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

On Thu, May 20, 2021 at 9:35 AM Tian Tao <tiantao6@hisilicon.com> wrote:
>
> request_irq() after setting IRQ_NOAUTOEN as below
> irq_set_status_flags(irq, IRQ_NOAUTOEN);
> request_irq(dev, irq...);
> can be replaced by request_irq() with IRQF_NO_AUTOEN flag.
>
> this change is just to simplify the code, no actual functional changes.
>
> Signed-off-by: Tian Tao <tiantao6@hisilicon.com>

Tony, what do you think?

> ---
>  drivers/base/power/wakeirq.c | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)
>
> diff --git a/drivers/base/power/wakeirq.c b/drivers/base/power/wakeirq.c
> index 8e02108..3bad326 100644
> --- a/drivers/base/power/wakeirq.c
> +++ b/drivers/base/power/wakeirq.c
> @@ -182,7 +182,6 @@ int dev_pm_set_dedicated_wake_irq(struct device *dev, int irq)
>
>         wirq->dev = dev;
>         wirq->irq = irq;
> -       irq_set_status_flags(irq, IRQ_NOAUTOEN);
>
>         /* Prevent deferred spurious wakeirqs with disable_irq_nosync() */
>         irq_set_status_flags(irq, IRQ_DISABLE_UNLAZY);
> @@ -192,7 +191,8 @@ int dev_pm_set_dedicated_wake_irq(struct device *dev, int irq)
>          * so we use a threaded irq.
>          */
>         err = request_threaded_irq(irq, NULL, handle_threaded_wake_irq,
> -                                  IRQF_ONESHOT, wirq->name, wirq);
> +                                  IRQF_ONESHOT | IRQF_NO_AUTOEN,
> +                                  wirq->name, wirq);
>         if (err)
>                 goto err_free_name;
>
> --
> 2.7.4
>
