Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id E1896FC06F
	for <lists+linux-pm@lfdr.de>; Thu, 14 Nov 2019 08:03:31 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726000AbfKNHDb (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Thu, 14 Nov 2019 02:03:31 -0500
Received: from mail-qk1-f196.google.com ([209.85.222.196]:34463 "EHLO
        mail-qk1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725601AbfKNHDb (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Thu, 14 Nov 2019 02:03:31 -0500
Received: by mail-qk1-f196.google.com with SMTP id 205so4151094qkk.1
        for <linux-pm@vger.kernel.org>; Wed, 13 Nov 2019 23:03:30 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=EDWEwzVGX/Z+LhLTkyUvC+5Du7NTkM6wxTPRe/Giii8=;
        b=UtbncTT5Mcc2iIxq5EcLUpW7wJHJqWv8QO2+J5fJlVFCEKzUMU5n5sb5QktLpIhMz2
         7KOrmoB0hBSJW7Jfarnzt6rl7JNhTDWuQNhRB231fK/g3Oq6ngxWLeoE96tVh5jJvzGm
         zP38uDDRcefnZkkzU3OhCff95r3cUiY+6gFvPKECiCeyS3BBMbqdZK+H6VPpmQzbi4Jx
         INOelEZ0IE4w7v5zmqQ0nQAX5XYXwfhmuC+YJbbcsqy+2dzkcLeSSg8MToX+pqMKeD9/
         EyUGf+wYRR4BEdHvV7l2ZvyjbA0SXCWhSNrCUxjZxm5+WKiGBg/p3lgNs8QOaoQ80w8w
         ytCQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=EDWEwzVGX/Z+LhLTkyUvC+5Du7NTkM6wxTPRe/Giii8=;
        b=T42akQ+BU1Lz4YiH9/CY0eS3G/kGjZG6hKEACQeH6daEJA+l6zrfZfTa4lvb4wXU6q
         Z4OsgkSKCqN7O93HIZz0XdFkeQV5bK9Nv8cM1BXBAAU3Sn8QTBDEJPnnRyfcbSOMRfyC
         SeK6nW0D8Iiq45nPA6SQoRiSoVkO2xQtbyC3JcO9FGdBz7LSuO5kou3fdhjs33XoABLy
         XGH5ZBBnveMVHaCyWpp+twQBSu0KK4qHct4QKqLRxsev9dtD0XYVLxb44VuLR5RcXIs0
         XZSytpVYIp7N14fB9EXDQ2XYZCl3GhOzmfrXW0dUVfYtyTfZ6DomkIt14IstSpnySuh+
         D0hw==
X-Gm-Message-State: APjAAAXmEm2jZ6WT2Kn0JOjIZkpT9yeu0BkCcWt1WwKjtMWSySuTHFyy
        VKjcoxpB2mY0Yv4yI2GPaNkjL9Pt7RRSmgrwUvC6+Uzj5v8=
X-Google-Smtp-Source: APXvYqyClIXRtpHWxVwISkB81In7x8GdFSI2pOnue5OUeAsLIZcRt8sSpsoXpyBIOobz9cg4CLFmsrcvnvm7sIRqkj4=
X-Received: by 2002:a37:5603:: with SMTP id k3mr6327873qkb.346.1573715009867;
 Wed, 13 Nov 2019 23:03:29 -0800 (PST)
MIME-Version: 1.0
References: <c60806d5480b7311ced8db07ff239aa5af7a050d.1573702497.git.viresh.kumar@linaro.org>
In-Reply-To: <c60806d5480b7311ced8db07ff239aa5af7a050d.1573702497.git.viresh.kumar@linaro.org>
From:   Amit Kucheria <amit.kucheria@linaro.org>
Date:   Thu, 14 Nov 2019 12:33:18 +0530
Message-ID: <CAP245DXgrnkVWp2ycObP+b5MV7CT8JzQdgxe8CeWktFT-eE6GQ@mail.gmail.com>
Subject: Re: [PATCH] cpufreq: Register cpufreq drivers only after CPU devices
 are registered
To:     Viresh Kumar <viresh.kumar@linaro.org>,
        Daniel Lezcano <daniel.lezcano@linaro.org>
Cc:     Rafael Wysocki <rjw@rjwysocki.net>,
        Linux PM list <linux-pm@vger.kernel.org>,
        Vincent Guittot <vincent.guittot@linaro.org>,
        Bjorn Andersson <bjorn.andersson@linaro.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

On Thu, Nov 14, 2019 at 9:06 AM Viresh Kumar <viresh.kumar@linaro.org> wrote:
>
> The cpufreq core heavily depends on the availability of the struct
> device for CPUs and if they aren't available at the time cpufreq driver
> is registered, we will never succeed in making cpufreq work.
>
> This happens due to following sequence of events:
>
> - cpufreq_register_driver()
>   - subsys_interface_register()
>   - return 0; //successful registration of driver
>
> ... at a later point of time
>
> - register_cpu();
>   - device_register();
>     - bus_probe_device();
>       - sif->add_dev();
>         - cpufreq_add_dev();
>           - get_cpu_device(); //FAILS
>   - per_cpu(cpu_sys_devices, num) = &cpu->dev; //used by get_cpu_device()
>   - return 0; //CPU registered successfully
>
> Because the per-cpu variable cpu_sys_devices is set only after the CPU
> device is regsitered, cpufreq will never be able to get it when
> cpufreq_add_dev() is called.
>
> This patch avoids this failure by making sure device structure of at
> least CPU0 is available when the cpufreq driver is registered, else
> return -EPROBE_DEFER.
>
> Reported-by: Bjorn Andersson <bjorn.andersson@linaro.org>
> Signed-off-by: Amit Kucheria <amit.kucheria@linaro.org>
> Signed-off-by: Viresh Kumar <viresh.kumar@linaro.org>

Tested-by: Amit Kucheria <amit.kucheria@linaro.org>

> ---
> @Amit: I have added your sob without asking as you were involved in
> getting us to this patch, you did a lot of testing yesterday to find the
> root cause.

SoB for the SoB :-)

> @Rafael: This fixes the issues reported by Bjorn on Amit's series and so
> should land before Amit's series, if at all this is acceptable to you.
> Thanks.

My series was going to get merged through the thermal tree. Currently
it is hosted here[1] for linux-next testing. We could sign-off this
patch to the thermal tree or bring the series into the PM tree. Up to
Rafael and you.

[1] https://git.kernel.org/pub/scm/linux/kernel/git/thermal/linux.git/log/?h=thermal/linux-next

>  drivers/cpufreq/cpufreq.c | 7 +++++++
>  1 file changed, 7 insertions(+)
>
> diff --git a/drivers/cpufreq/cpufreq.c b/drivers/cpufreq/cpufreq.c
> index 681c1b5f0a1a..05293b43e56d 100644
> --- a/drivers/cpufreq/cpufreq.c
> +++ b/drivers/cpufreq/cpufreq.c
> @@ -2641,6 +2641,13 @@ int cpufreq_register_driver(struct cpufreq_driver *driver_data)
>         if (cpufreq_disabled())
>                 return -ENODEV;
>
> +       /*
> +        * The cpufreq core depends heavily on the availability of device
> +        * structure, make sure they are available before proceeding further.
> +        */
> +       if (!get_cpu_device(0))
> +               return -EPROBE_DEFER;
> +
>         if (!driver_data || !driver_data->verify || !driver_data->init ||
>             !(driver_data->setpolicy || driver_data->target_index ||
>                     driver_data->target) ||
> --
> 2.21.0.rc0.269.g1a574e7a288b
>
