Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 1386E15A686
	for <lists+linux-pm@lfdr.de>; Wed, 12 Feb 2020 11:35:40 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727347AbgBLKfj (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Wed, 12 Feb 2020 05:35:39 -0500
Received: from mail-oi1-f196.google.com ([209.85.167.196]:35740 "EHLO
        mail-oi1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727361AbgBLKfi (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Wed, 12 Feb 2020 05:35:38 -0500
Received: by mail-oi1-f196.google.com with SMTP id b18so1567037oie.2;
        Wed, 12 Feb 2020 02:35:36 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=NnnbDSzoop0s0gj0miT73Peda0TDZhvlDkQKNkLxkbs=;
        b=LOyIbD3I3b5JwiL+mGbgzmuh3mR/H8dkgkps/koXX6WCvPSSHPdeGxhFcPIXh6PnG3
         SPfhexHgQaAB1m029SjjqGXPRh1FP89Ml6a5c6CUuxJjXmUlEtqsBliZHsUjv8k47CN+
         bgwc/kddOwkRb9Q6EnQuIGnoEbUEOFpoITuuG27D9qg5mUk7xes+liNC+QuMDln+QcCW
         SdaJPo2C88L72iBTClz755t3MZM49u8HBXGI35InZW5wfdtqLpWDtZSCVTHDN9vTY70M
         SqXmsd3V/J2rdAXJbta+/d9g9rcMkMvjaot9/pLhGRErTGNQjTPDZPco1gJmUrDP6JfR
         /EKA==
X-Gm-Message-State: APjAAAVnTC/d362cp49tGDSvfQmJOJKO1rp1T+5rp8ByqCKF6MDvB5/U
        VSmizxSLNaPBS1Fi+Al9Rgf3DYsv4OQg7bJgkWimchiR
X-Google-Smtp-Source: APXvYqx/wHUIDKIKoZeysuin0Zjc/oUAVs+aOzddBBu1ZdL8iabUtwLtopMZOgBPOMdlL9Sajxk811bKA7gbDfAMaTc=
X-Received: by 2002:a54:4e96:: with SMTP id c22mr5929326oiy.110.1581503736425;
 Wed, 12 Feb 2020 02:35:36 -0800 (PST)
MIME-Version: 1.0
References: <1654227.8mz0SueHsU@kreacher> <2339403.frKpfgBVMR@kreacher>
In-Reply-To: <2339403.frKpfgBVMR@kreacher>
From:   "Rafael J. Wysocki" <rafael@kernel.org>
Date:   Wed, 12 Feb 2020 11:35:25 +0100
Message-ID: <CAJZ5v0itHeg2nb40ZFRxzoZG-33UqypE1F-wGucHdyAD8BSH9A@mail.gmail.com>
Subject: Re: [PATCH 22/28] drivers: tty: Call cpu_latency_qos_*() instead of pm_qos_*()
To:     linux-serial@vger.kernel.org
Cc:     Linux PM <linux-pm@vger.kernel.org>,
        LKML <linux-kernel@vger.kernel.org>,
        Amit Kucheria <amit.kucheria@linaro.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        "Rafael J. Wysocki" <rjw@rjwysocki.net>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

On Wed, Feb 12, 2020 at 12:40 AM Rafael J. Wysocki <rjw@rjwysocki.net> wrote:
>
> From: "Rafael J. Wysocki" <rafael.j.wysocki@intel.com>
>
> Call cpu_latency_qos_add/update/remove_request() instead of
> pm_qos_add/update/remove_request(), respectively, because the
> latter are going to be dropped.
>
> No intentional functional impact.
>
> Signed-off-by: Rafael J. Wysocki <rafael.j.wysocki@intel.com>

Please note that the whole series is available here:

https://lore.kernel.org/linux-pm/1654227.8mz0SueHsU@kreacher/

> ---
>  drivers/tty/serial/8250/8250_omap.c | 7 +++----
>  drivers/tty/serial/omap-serial.c    | 9 ++++-----
>  2 files changed, 7 insertions(+), 9 deletions(-)
>
> diff --git a/drivers/tty/serial/8250/8250_omap.c b/drivers/tty/serial/8250/8250_omap.c
> index 19f8d2f9e7ba..76fe72bfb8bb 100644
> --- a/drivers/tty/serial/8250/8250_omap.c
> +++ b/drivers/tty/serial/8250/8250_omap.c
> @@ -569,7 +569,7 @@ static void omap8250_uart_qos_work(struct work_struct *work)
>         struct omap8250_priv *priv;
>
>         priv = container_of(work, struct omap8250_priv, qos_work);
> -       pm_qos_update_request(&priv->pm_qos_request, priv->latency);
> +       cpu_latency_qos_update_request(&priv->pm_qos_request, priv->latency);
>  }
>
>  #ifdef CONFIG_SERIAL_8250_DMA
> @@ -1224,8 +1224,7 @@ static int omap8250_probe(struct platform_device *pdev)
>
>         priv->latency = PM_QOS_CPU_LATENCY_DEFAULT_VALUE;
>         priv->calc_latency = PM_QOS_CPU_LATENCY_DEFAULT_VALUE;
> -       pm_qos_add_request(&priv->pm_qos_request, PM_QOS_CPU_DMA_LATENCY,
> -                          priv->latency);
> +       cpu_latency_qos_add_request(&priv->pm_qos_request, priv->latency);
>         INIT_WORK(&priv->qos_work, omap8250_uart_qos_work);
>
>         spin_lock_init(&priv->rx_dma_lock);
> @@ -1295,7 +1294,7 @@ static int omap8250_remove(struct platform_device *pdev)
>         pm_runtime_put_sync(&pdev->dev);
>         pm_runtime_disable(&pdev->dev);
>         serial8250_unregister_port(priv->line);
> -       pm_qos_remove_request(&priv->pm_qos_request);
> +       cpu_latency_qos_remove_request(&priv->pm_qos_request);
>         device_init_wakeup(&pdev->dev, false);
>         return 0;
>  }
> diff --git a/drivers/tty/serial/omap-serial.c b/drivers/tty/serial/omap-serial.c
> index ce2558767eee..e0b720ac754b 100644
> --- a/drivers/tty/serial/omap-serial.c
> +++ b/drivers/tty/serial/omap-serial.c
> @@ -831,7 +831,7 @@ static void serial_omap_uart_qos_work(struct work_struct *work)
>         struct uart_omap_port *up = container_of(work, struct uart_omap_port,
>                                                 qos_work);
>
> -       pm_qos_update_request(&up->pm_qos_request, up->latency);
> +       cpu_latency_qos_update_request(&up->pm_qos_request, up->latency);
>  }
>
>  static void
> @@ -1724,8 +1724,7 @@ static int serial_omap_probe(struct platform_device *pdev)
>
>         up->latency = PM_QOS_CPU_LATENCY_DEFAULT_VALUE;
>         up->calc_latency = PM_QOS_CPU_LATENCY_DEFAULT_VALUE;
> -       pm_qos_add_request(&up->pm_qos_request,
> -               PM_QOS_CPU_DMA_LATENCY, up->latency);
> +       cpu_latency_qos_add_request(&up->pm_qos_request, up->latency);
>         INIT_WORK(&up->qos_work, serial_omap_uart_qos_work);
>
>         platform_set_drvdata(pdev, up);
> @@ -1759,7 +1758,7 @@ static int serial_omap_probe(struct platform_device *pdev)
>         pm_runtime_dont_use_autosuspend(&pdev->dev);
>         pm_runtime_put_sync(&pdev->dev);
>         pm_runtime_disable(&pdev->dev);
> -       pm_qos_remove_request(&up->pm_qos_request);
> +       cpu_latency_qos_remove_request(&up->pm_qos_request);
>         device_init_wakeup(up->dev, false);
>  err_rs485:
>  err_port_line:
> @@ -1777,7 +1776,7 @@ static int serial_omap_remove(struct platform_device *dev)
>         pm_runtime_dont_use_autosuspend(up->dev);
>         pm_runtime_put_sync(up->dev);
>         pm_runtime_disable(up->dev);
> -       pm_qos_remove_request(&up->pm_qos_request);
> +       cpu_latency_qos_remove_request(&up->pm_qos_request);
>         device_init_wakeup(&dev->dev, false);
>
>         return 0;
> --
> 2.16.4
>
>
>
>
>
