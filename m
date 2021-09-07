Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id CB0BC402EC9
	for <lists+linux-pm@lfdr.de>; Tue,  7 Sep 2021 21:11:44 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243501AbhIGTMu (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Tue, 7 Sep 2021 15:12:50 -0400
Received: from mail-ot1-f47.google.com ([209.85.210.47]:37602 "EHLO
        mail-ot1-f47.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230203AbhIGTMt (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Tue, 7 Sep 2021 15:12:49 -0400
Received: by mail-ot1-f47.google.com with SMTP id i3-20020a056830210300b0051af5666070so409567otc.4
        for <linux-pm@vger.kernel.org>; Tue, 07 Sep 2021 12:11:43 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=UwSYMYOOg2GixNbx/21ilsYrRNPWnL4RxTTYxADcoBg=;
        b=AXSqJpS2ALmh142r9Xjl2Occ/irTlTTTgIzXvE0EdT3HkSY25Se+9QW4foGf5cyYDC
         ZMa1A00v1fPasdteF6bxq5CTqYf2CNUJM2Yjvx6unga2Vi4GpRPpz5z2TtBf65zn9Pg1
         3doywqiKDVAs0IW8qCUbVcB8e5D2S2rBktHzDorJAndyqAfNffRBjZUIpNEWaKe1W82Y
         8ev+20PFhyiOkRkXx5kXP6VzEhHcSETHbJZMZz4iT0usrWbEapKF8JJPs7AlfVYrkOWx
         ID3QKH4p6kX3YU/XVXcoOWNQRgXhFY65dDT3zKE0QrxN30l99Nyzbbd/mB0FEIppeWD8
         gZCQ==
X-Gm-Message-State: AOAM531EbO/UaeKruRZUsLObZaKiDrn3xsJIPG/FvMQ1DaMSp1d51EBe
        M9MT8773qbj96d5ISg+qMZPMBOJKvxG59kmq19Y=
X-Google-Smtp-Source: ABdhPJxx/E4tLHmhLT8Fq7hCKfNNiLXWBNDSQjmKvS0VW3C+Asi2NcylMUkbSR7FfbbYRPXubf5koaExEKs1FAuy60k=
X-Received: by 2002:a9d:6945:: with SMTP id p5mr16777002oto.301.1631041902803;
 Tue, 07 Sep 2021 12:11:42 -0700 (PDT)
MIME-Version: 1.0
References: <c670e963-0059-0da8-0273-ef0170fb769d@omp.ru>
In-Reply-To: <c670e963-0059-0da8-0273-ef0170fb769d@omp.ru>
From:   "Rafael J. Wysocki" <rafael@kernel.org>
Date:   Tue, 7 Sep 2021 21:11:31 +0200
Message-ID: <CAJZ5v0ih5n4FveJz9d8AOM2F41LkFDPLq+NFb8o86yoqVact-g@mail.gmail.com>
Subject: Re: [PATCH power core: wakeirq: kill useless parameter in dev_pm_attach_wake_irq()
To:     Sergey Shtylyov <s.shtylyov@omp.ru>
Cc:     "Rafael J. Wysocki" <rjw@rjwysocki.net>,
        Len Brown <len.brown@intel.com>, Pavel Machek <pavel@ucw.cz>,
        Linux PM <linux-pm@vger.kernel.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

On Thu, Sep 2, 2021 at 11:06 PM Sergey Shtylyov <s.shtylyov@omp.ru> wrote:
>
> This function has the 'irq' parameter which isn't ever used, so let's kill it.
>
> Signed-off-by: Sergey Shtylyov <s.shtylyov@omp.ru>
>
> ---
> The patch is against the 'linux-next' branch of the Rafael J. Wysocki's
> 'linux-=pm.git' repo.
>
>  drivers/base/power/wakeirq.c |   11 ++++-------
>  1 file changed, 4 insertions(+), 7 deletions(-)
>
> Index: linux-pm/drivers/base/power/wakeirq.c
> ===================================================================
> --- linux-pm.orig/drivers/base/power/wakeirq.c
> +++ linux-pm/drivers/base/power/wakeirq.c
> @@ -12,14 +12,11 @@
>  /**
>   * dev_pm_attach_wake_irq - Attach device interrupt as a wake IRQ
>   * @dev: Device entry
> - * @irq: Device wake-up capable interrupt
>   * @wirq: Wake irq specific data
>   *
> - * Internal function to attach either a device IO interrupt or a
> - * dedicated wake-up interrupt as a wake IRQ.
> + * Internal function to attach a dedicated wake-up interrupt as a wake IRQ.
>   */
> -static int dev_pm_attach_wake_irq(struct device *dev, int irq,
> -                                 struct wake_irq *wirq)
> +static int dev_pm_attach_wake_irq(struct device *dev, struct wake_irq *wirq)
>  {
>         unsigned long flags;
>
> @@ -65,7 +62,7 @@ int dev_pm_set_wake_irq(struct device *d
>         wirq->dev = dev;
>         wirq->irq = irq;
>
> -       err = dev_pm_attach_wake_irq(dev, irq, wirq);
> +       err = dev_pm_attach_wake_irq(dev, wirq);
>         if (err)
>                 kfree(wirq);
>
> @@ -196,7 +193,7 @@ int dev_pm_set_dedicated_wake_irq(struct
>         if (err)
>                 goto err_free_name;
>
> -       err = dev_pm_attach_wake_irq(dev, irq, wirq);
> +       err = dev_pm_attach_wake_irq(dev, wirq);
>         if (err)
>                 goto err_free_irq;

Applied as 5.15-rc material, but killing sounds brutal to me, so I've
changed it to dropping in the subject and changelog.

Thanks!
