Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 9ACD115A678
	for <lists+linux-pm@lfdr.de>; Wed, 12 Feb 2020 11:34:46 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727779AbgBLKej (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Wed, 12 Feb 2020 05:34:39 -0500
Received: from mail-oi1-f196.google.com ([209.85.167.196]:35604 "EHLO
        mail-oi1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727558AbgBLKei (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Wed, 12 Feb 2020 05:34:38 -0500
Received: by mail-oi1-f196.google.com with SMTP id b18so1564861oie.2;
        Wed, 12 Feb 2020 02:34:37 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=annKQUxliL7g9llg5hUdfeFX3nCzS9hBSmQMK3dnva4=;
        b=oIXMovIVoli/wN93QBIBqvscaVXfvW8yGYrkMUwHQatDQhPyfHfYOxGdSgvT4QLDiu
         xEQj8Ig9WnRgokgnpaBcM236er2EaDwJyOzVRga0nmejZ1bnTB9qyEkilYHEQKnDZcWs
         l3QGYdqQ494kAJC1LIyzkal2a/BLSeEbdoJlZFtFLrmhOe/kie5vnWgrvG0xIzKE335Z
         gl38W77H5EsSkEO2JHWUj4LW32LKx7f2gizogXWFf6LK8glgZBwDup8KhIz+5pX3swZe
         9hmAibn+IXx9WeqVwAiHOU5jZH0vYgDj1lAj9WdylJ8DToU8CjCgjbc4QtkWesQYaBVt
         5TnQ==
X-Gm-Message-State: APjAAAUtPvBRh8KFV0vacKVYPJuCTnoTBwjsIHp8WWC/+AL/pmjWC4HI
        2c/5oQl6w7YhQnnCL6QpPTYQPbC8N+lkEN/UpggzIg==
X-Google-Smtp-Source: APXvYqwFCghaCvnTXfbxqiNJsmUbujLORuF4vWYMSQRfnVcXxG+OJC60iPiS/78by2mRAbllksCWs72VKlDc/7CHhu0=
X-Received: by 2002:a54:488d:: with SMTP id r13mr5546067oic.115.1581503677172;
 Wed, 12 Feb 2020 02:34:37 -0800 (PST)
MIME-Version: 1.0
References: <1654227.8mz0SueHsU@kreacher> <3305010.P0mNzRSuHC@kreacher>
In-Reply-To: <3305010.P0mNzRSuHC@kreacher>
From:   "Rafael J. Wysocki" <rafael@kernel.org>
Date:   Wed, 12 Feb 2020 11:34:26 +0100
Message-ID: <CAJZ5v0hV6iEJ=dmNMYL7RU2sQZy5rXffMbVEJ3d4Qa=r9No2OQ@mail.gmail.com>
Subject: Re: [PATCH 10/28] PM: QoS: Rename things related to the CPU latency QoS
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

On Wed, Feb 12, 2020 at 12:39 AM Rafael J. Wysocki <rjw@rjwysocki.net> wrote:
>
> From: "Rafael J. Wysocki" <rafael.j.wysocki@intel.com>
>
> First, rename PM_QOS_CPU_DMA_LAT_DEFAULT_VALUE to
> PM_QOS_CPU_LATENCY_DEFAULT_VALUE and update all of the code
> referring to it accordingly.
>
> Next, rename cpu_dma_constraints to cpu_latency_constraints, move
> the definition of it closer to the functions referring to it and
> update all of them accordingly.  [While at it, add a comment to mark
> the start of the code related to the CPU latency QoS.]
>
> Finally, rename the pm_qos_power_*() family of functions and
> pm_qos_power_fops to cpu_latency_qos_*() and cpu_latency_qos_fops,
> respectively, and update the definition of cpu_latency_qos_miscdev.
> [While at it, update the miscdev interface code start comment.]
>
> No intentional functional impact.
>
> Signed-off-by: Rafael J. Wysocki <rafael.j.wysocki@intel.com>


Please note that the whole series is available here:

https://lore.kernel.org/linux-pm/1654227.8mz0SueHsU@kreacher/


> ---
>  drivers/tty/serial/8250/8250_omap.c |  6 ++--
>  drivers/tty/serial/omap-serial.c    |  6 ++--
>  include/linux/pm_qos.h              |  2 +-
>  kernel/power/qos.c                  | 56 +++++++++++++++++++------------------
>  4 files changed, 36 insertions(+), 34 deletions(-)
>
> diff --git a/drivers/tty/serial/8250/8250_omap.c b/drivers/tty/serial/8250/8250_omap.c
> index 6f343ca08440..19f8d2f9e7ba 100644
> --- a/drivers/tty/serial/8250/8250_omap.c
> +++ b/drivers/tty/serial/8250/8250_omap.c
> @@ -1222,8 +1222,8 @@ static int omap8250_probe(struct platform_device *pdev)
>                          DEFAULT_CLK_SPEED);
>         }
>
> -       priv->latency = PM_QOS_CPU_DMA_LAT_DEFAULT_VALUE;
> -       priv->calc_latency = PM_QOS_CPU_DMA_LAT_DEFAULT_VALUE;
> +       priv->latency = PM_QOS_CPU_LATENCY_DEFAULT_VALUE;
> +       priv->calc_latency = PM_QOS_CPU_LATENCY_DEFAULT_VALUE;
>         pm_qos_add_request(&priv->pm_qos_request, PM_QOS_CPU_DMA_LATENCY,
>                            priv->latency);
>         INIT_WORK(&priv->qos_work, omap8250_uart_qos_work);
> @@ -1445,7 +1445,7 @@ static int omap8250_runtime_suspend(struct device *dev)
>         if (up->dma && up->dma->rxchan)
>                 omap_8250_rx_dma_flush(up);
>
> -       priv->latency = PM_QOS_CPU_DMA_LAT_DEFAULT_VALUE;
> +       priv->latency = PM_QOS_CPU_LATENCY_DEFAULT_VALUE;
>         schedule_work(&priv->qos_work);
>
>         return 0;
> diff --git a/drivers/tty/serial/omap-serial.c b/drivers/tty/serial/omap-serial.c
> index 48017cec7f2f..ce2558767eee 100644
> --- a/drivers/tty/serial/omap-serial.c
> +++ b/drivers/tty/serial/omap-serial.c
> @@ -1722,8 +1722,8 @@ static int serial_omap_probe(struct platform_device *pdev)
>                          DEFAULT_CLK_SPEED);
>         }
>
> -       up->latency = PM_QOS_CPU_DMA_LAT_DEFAULT_VALUE;
> -       up->calc_latency = PM_QOS_CPU_DMA_LAT_DEFAULT_VALUE;
> +       up->latency = PM_QOS_CPU_LATENCY_DEFAULT_VALUE;
> +       up->calc_latency = PM_QOS_CPU_LATENCY_DEFAULT_VALUE;
>         pm_qos_add_request(&up->pm_qos_request,
>                 PM_QOS_CPU_DMA_LATENCY, up->latency);
>         INIT_WORK(&up->qos_work, serial_omap_uart_qos_work);
> @@ -1869,7 +1869,7 @@ static int serial_omap_runtime_suspend(struct device *dev)
>
>         serial_omap_enable_wakeup(up, true);
>
> -       up->latency = PM_QOS_CPU_DMA_LAT_DEFAULT_VALUE;
> +       up->latency = PM_QOS_CPU_LATENCY_DEFAULT_VALUE;
>         schedule_work(&up->qos_work);
>
>         return 0;
> diff --git a/include/linux/pm_qos.h b/include/linux/pm_qos.h
> index cb57e5918a25..a3e0bfc6c470 100644
> --- a/include/linux/pm_qos.h
> +++ b/include/linux/pm_qos.h
> @@ -28,7 +28,7 @@ enum pm_qos_flags_status {
>  #define PM_QOS_LATENCY_ANY     S32_MAX
>  #define PM_QOS_LATENCY_ANY_NS  ((s64)PM_QOS_LATENCY_ANY * NSEC_PER_USEC)
>
> -#define PM_QOS_CPU_DMA_LAT_DEFAULT_VALUE       (2000 * USEC_PER_SEC)
> +#define PM_QOS_CPU_LATENCY_DEFAULT_VALUE       (2000 * USEC_PER_SEC)
>  #define PM_QOS_RESUME_LATENCY_DEFAULT_VALUE    PM_QOS_LATENCY_ANY
>  #define PM_QOS_RESUME_LATENCY_NO_CONSTRAINT    PM_QOS_LATENCY_ANY
>  #define PM_QOS_RESUME_LATENCY_NO_CONSTRAINT_NS PM_QOS_LATENCY_ANY_NS
> diff --git a/kernel/power/qos.c b/kernel/power/qos.c
> index 201b43bc6457..a6bf53e9db17 100644
> --- a/kernel/power/qos.c
> +++ b/kernel/power/qos.c
> @@ -56,14 +56,6 @@
>   */
>  static DEFINE_SPINLOCK(pm_qos_lock);
>
> -static struct pm_qos_constraints cpu_dma_constraints = {
> -       .list = PLIST_HEAD_INIT(cpu_dma_constraints.list),
> -       .target_value = PM_QOS_CPU_DMA_LAT_DEFAULT_VALUE,
> -       .default_value = PM_QOS_CPU_DMA_LAT_DEFAULT_VALUE,
> -       .no_constraint_value = PM_QOS_CPU_DMA_LAT_DEFAULT_VALUE,
> -       .type = PM_QOS_MIN,
> -};
> -
>  /**
>   * pm_qos_read_value - Return the current effective constraint value.
>   * @c: List of PM QoS constraint requests.
> @@ -227,6 +219,16 @@ bool pm_qos_update_flags(struct pm_qos_flags *pqf,
>         return prev_value != curr_value;
>  }
>
> +/* Definitions related to the CPU latency QoS. */
> +
> +static struct pm_qos_constraints cpu_latency_constraints = {
> +       .list = PLIST_HEAD_INIT(cpu_latency_constraints.list),
> +       .target_value = PM_QOS_CPU_LATENCY_DEFAULT_VALUE,
> +       .default_value = PM_QOS_CPU_LATENCY_DEFAULT_VALUE,
> +       .no_constraint_value = PM_QOS_CPU_LATENCY_DEFAULT_VALUE,
> +       .type = PM_QOS_MIN,
> +};
> +
>  /**
>   * pm_qos_request - returns current system wide qos expectation
>   * @pm_qos_class: Ignored.
> @@ -235,13 +237,13 @@ bool pm_qos_update_flags(struct pm_qos_flags *pqf,
>   */
>  int pm_qos_request(int pm_qos_class)
>  {
> -       return pm_qos_read_value(&cpu_dma_constraints);
> +       return pm_qos_read_value(&cpu_latency_constraints);
>  }
>  EXPORT_SYMBOL_GPL(pm_qos_request);
>
>  int pm_qos_request_active(struct pm_qos_request *req)
>  {
> -       return req->qos == &cpu_dma_constraints;
> +       return req->qos == &cpu_latency_constraints;
>  }
>  EXPORT_SYMBOL_GPL(pm_qos_request_active);
>
> @@ -278,7 +280,7 @@ void pm_qos_add_request(struct pm_qos_request *req,
>
>         trace_pm_qos_add_request(PM_QOS_CPU_DMA_LATENCY, value);
>
> -       req->qos = &cpu_dma_constraints;
> +       req->qos = &cpu_latency_constraints;
>         cpu_latency_qos_update(req, PM_QOS_ADD_REQ, value);
>  }
>  EXPORT_SYMBOL_GPL(pm_qos_add_request);
> @@ -338,9 +340,9 @@ void pm_qos_remove_request(struct pm_qos_request *req)
>  }
>  EXPORT_SYMBOL_GPL(pm_qos_remove_request);
>
> -/* User space interface to global PM QoS via misc device. */
> +/* User space interface to the CPU latency QoS via misc device. */
>
> -static int pm_qos_power_open(struct inode *inode, struct file *filp)
> +static int cpu_latency_qos_open(struct inode *inode, struct file *filp)
>  {
>         struct pm_qos_request *req;
>
> @@ -354,7 +356,7 @@ static int pm_qos_power_open(struct inode *inode, struct file *filp)
>         return 0;
>  }
>
> -static int pm_qos_power_release(struct inode *inode, struct file *filp)
> +static int cpu_latency_qos_release(struct inode *inode, struct file *filp)
>  {
>         struct pm_qos_request *req = filp->private_data;
>
> @@ -366,8 +368,8 @@ static int pm_qos_power_release(struct inode *inode, struct file *filp)
>         return 0;
>  }
>
> -static ssize_t pm_qos_power_read(struct file *filp, char __user *buf,
> -                                size_t count, loff_t *f_pos)
> +static ssize_t cpu_latency_qos_read(struct file *filp, char __user *buf,
> +                                   size_t count, loff_t *f_pos)
>  {
>         struct pm_qos_request *req = filp->private_data;
>         unsigned long flags;
> @@ -377,14 +379,14 @@ static ssize_t pm_qos_power_read(struct file *filp, char __user *buf,
>                 return -EINVAL;
>
>         spin_lock_irqsave(&pm_qos_lock, flags);
> -       value = pm_qos_get_value(&cpu_dma_constraints);
> +       value = pm_qos_get_value(&cpu_latency_constraints);
>         spin_unlock_irqrestore(&pm_qos_lock, flags);
>
>         return simple_read_from_buffer(buf, count, f_pos, &value, sizeof(s32));
>  }
>
> -static ssize_t pm_qos_power_write(struct file *filp, const char __user *buf,
> -                                 size_t count, loff_t *f_pos)
> +static ssize_t cpu_latency_qos_write(struct file *filp, const char __user *buf,
> +                                    size_t count, loff_t *f_pos)
>  {
>         s32 value;
>
> @@ -404,21 +406,21 @@ static ssize_t pm_qos_power_write(struct file *filp, const char __user *buf,
>         return count;
>  }
>
> -static const struct file_operations pm_qos_power_fops = {
> -       .write = pm_qos_power_write,
> -       .read = pm_qos_power_read,
> -       .open = pm_qos_power_open,
> -       .release = pm_qos_power_release,
> +static const struct file_operations cpu_latency_qos_fops = {
> +       .write = cpu_latency_qos_write,
> +       .read = cpu_latency_qos_read,
> +       .open = cpu_latency_qos_open,
> +       .release = cpu_latency_qos_release,
>         .llseek = noop_llseek,
>  };
>
>  static struct miscdevice cpu_latency_qos_miscdev = {
>         .minor = MISC_DYNAMIC_MINOR,
>         .name = "cpu_dma_latency",
> -       .fops = &pm_qos_power_fops,
> +       .fops = &cpu_latency_qos_fops,
>  };
>
> -static int __init pm_qos_power_init(void)
> +static int __init cpu_latency_qos_init(void)
>  {
>         int ret;
>
> @@ -429,7 +431,7 @@ static int __init pm_qos_power_init(void)
>
>         return ret;
>  }
> -late_initcall(pm_qos_power_init);
> +late_initcall(cpu_latency_qos_init);
>
>  /* Definitions related to the frequency QoS below. */
>
> --
> 2.16.4
>
>
>
>
>
