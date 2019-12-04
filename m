Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id F1C0D1127CF
	for <lists+linux-pm@lfdr.de>; Wed,  4 Dec 2019 10:38:24 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727429AbfLDJiV (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Wed, 4 Dec 2019 04:38:21 -0500
Received: from mail-vs1-f68.google.com ([209.85.217.68]:39901 "EHLO
        mail-vs1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727295AbfLDJiV (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Wed, 4 Dec 2019 04:38:21 -0500
Received: by mail-vs1-f68.google.com with SMTP id p21so4412687vsq.6
        for <linux-pm@vger.kernel.org>; Wed, 04 Dec 2019 01:38:20 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=verdurent-com.20150623.gappssmtp.com; s=20150623;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=WKSRUXAknnFGuVSfHxGReWQUvxVO29cQQA2zNwSpULM=;
        b=CDaJqeQsxOZakv4IT6D02OCbik+0JlBE+4lW70GNPFrDEFKnnoc3a8bqcNSiwepcwC
         cbJnJpVsMMkkV7fnsnKqSi6b2MIMjGBTbQJw9WC/Sf+OKijQ7fegzoqei60yfDYakOCD
         QHYwwu9vOBc510u62DIDNsNyh68brak/HneiZJLEhbTx3JBFur6r9Zqr0gY+gq7a9Cfn
         ZbZHvB1xp5BrhFFyEoGJAwDj06xILJWc9gqVAk7NROWUX4cZoUix68cPuk9SNW1m45QQ
         756cGhUjUX4q6Fgm5/5AZXXZvhghT6WshaTKrVS6kYt7GIyAcuYQsp1PtTACJAE4NqsX
         RdEw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=WKSRUXAknnFGuVSfHxGReWQUvxVO29cQQA2zNwSpULM=;
        b=tYyRtxE288OY6l2nG2bbYMbeKUrsPSNNmBCiwJM5J6cPpt2T3x6zHx7782gHWTJdmg
         Q9X+mYl59YX/rV1SuezGXn7g4KcREcc5Nu6E1oWgfUA1wHmcUMt5P5zp9mPmVxmA/8L1
         VjtHdaxtvT9dREUIhhTXP8G5oi1XyKkYuZ+GQUOY8Tfgc1iIR8wiC4rqEWPQUHio/IeQ
         uOvFITonLA6HgsZ/JncoxvtBmZKfXQ5cab4TmszwRBGMh+FK+BpmeG5SMwukCsMiXxp/
         WVk76haHwkA1G92g7UBt8kVxMJXj7nXaeUQ1S3FGjukNoklPH9gDD0ABmNE9lx7iS7ie
         qwRQ==
X-Gm-Message-State: APjAAAUTa5lkd5cM/NyJJcPMQEbfA/vJBmaQ4PQMEyeGi62qlIrPCFvy
        FT9mqgomrvCCOuLsvjcGz8Eoyv0Kx31t/V63FmV+Jw==
X-Google-Smtp-Source: APXvYqxrL3FunHxe+ypKQfT/9GTtMwGi/xMYe45gMeFuXII2RAGl5/rsBU+x3Cj/hRM/BBU+FzxbdlSSvE4RNraI958=
X-Received: by 2002:a67:f8cf:: with SMTP id c15mr1068522vsp.27.1575452299891;
 Wed, 04 Dec 2019 01:38:19 -0800 (PST)
MIME-Version: 1.0
References: <20191030182132.25763-1-f.fainelli@gmail.com> <20191030182132.25763-6-f.fainelli@gmail.com>
In-Reply-To: <20191030182132.25763-6-f.fainelli@gmail.com>
From:   Amit Kucheria <amit.kucheria@verdurent.com>
Date:   Wed, 4 Dec 2019 15:08:08 +0530
Message-ID: <CAHLCerP=3uFsj_fxGcWiKppWfOoYQRmLq1PhEZvC8ZURr=sh5A@mail.gmail.com>
Subject: Re: [PATCH 5/6] thermal: brcmstb_thermal: Restructure interrupt registration
To:     Florian Fainelli <f.fainelli@gmail.com>
Cc:     LKML <linux-kernel@vger.kernel.org>,
        Markus Mayer <mmayer@broadcom.com>,
        "maintainer:BROADCOM STB AVS TMON DRIVER" 
        <bcm-kernel-feedback-list@broadcom.com>,
        Zhang Rui <rui.zhang@intel.com>,
        Eduardo Valentin <edubezval@gmail.com>,
        Daniel Lezcano <daniel.lezcano@linaro.org>,
        Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        "open list:BROADCOM STB AVS TMON DRIVER" <linux-pm@vger.kernel.org>,
        "open list:OPEN FIRMWARE AND FLATTENED DEVICE TREE BINDINGS" 
        <devicetree@vger.kernel.org>,
        "moderated list:BROADCOM BCM7XXX ARM ARCHITECTURE" 
        <linux-arm-kernel@lists.infradead.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

On Wed, Oct 30, 2019 at 11:52 PM Florian Fainelli <f.fainelli@gmail.com> wrote:
>
> If we are successful grabbing the interrupt resource, then register an
> interrupt handler, this makes it easier to support the interrupt as
> being optional, which is it for 7216.
>
> Signed-off-by: Florian Fainelli <f.fainelli@gmail.com>

Reviewed-by: Amit Kucheria <amit.kucheria@linaro.org>

> ---
>  drivers/thermal/broadcom/brcmstb_thermal.c | 19 +++++++++----------
>  1 file changed, 9 insertions(+), 10 deletions(-)
>
> diff --git a/drivers/thermal/broadcom/brcmstb_thermal.c b/drivers/thermal/broadcom/brcmstb_thermal.c
> index 41d4a142707c..64f715053ce9 100644
> --- a/drivers/thermal/broadcom/brcmstb_thermal.c
> +++ b/drivers/thermal/broadcom/brcmstb_thermal.c
> @@ -339,16 +339,15 @@ static int brcmstb_thermal_probe(struct platform_device *pdev)
>         priv->thermal = thermal;
>
>         irq = platform_get_irq(pdev, 0);
> -       if (irq < 0) {
> -               dev_err(&pdev->dev, "could not get IRQ\n");
> -               return irq;
> -       }
> -       ret = devm_request_threaded_irq(&pdev->dev, irq, NULL,
> -                                       brcmstb_tmon_irq_thread, IRQF_ONESHOT,
> -                                       DRV_NAME, priv);
> -       if (ret < 0) {
> -               dev_err(&pdev->dev, "could not request IRQ: %d\n", ret);
> -               return ret;
> +       if (irq >= 0) {
> +               ret = devm_request_threaded_irq(&pdev->dev, irq, NULL,
> +                                               brcmstb_tmon_irq_thread,
> +                                               IRQF_ONESHOT,
> +                                               DRV_NAME, priv);
> +               if (ret < 0) {
> +                       dev_err(&pdev->dev, "could not request IRQ: %d\n", ret);
> +                       return ret;
> +               }
>         }
>
>         dev_info(&pdev->dev, "registered AVS TMON of-sensor driver\n");
> --
> 2.17.1
>
