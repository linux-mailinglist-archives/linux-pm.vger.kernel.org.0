Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 0BE19FC1B5
	for <lists+linux-pm@lfdr.de>; Thu, 14 Nov 2019 09:40:44 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725976AbfKNIkn (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Thu, 14 Nov 2019 03:40:43 -0500
Received: from mail-ot1-f68.google.com ([209.85.210.68]:35848 "EHLO
        mail-ot1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725920AbfKNIkm (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Thu, 14 Nov 2019 03:40:42 -0500
Received: by mail-ot1-f68.google.com with SMTP id f10so4189810oto.3;
        Thu, 14 Nov 2019 00:40:42 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=iPJY8eMCm08nB+zy7CztAq4dqq7+2vUSvcWj8TIB9d0=;
        b=g/BwmTLPlTBSY3vl8srpUxhptcc1dDNv/1P2jZYzUTlh74PeDfNVjMxjcjgnMHp6G8
         TxyBEah0OdBBkpi4IFmPaD3+4jr4Mpn6gtE2XR4StbwZrxDp2wXZCD0qMnQIyrhAIu5I
         A3jzBhhohqvBXLmY+hRbYF0aYbgNjaF7gTxPcug5x7HKRKkr6B8FZL3GPNi3IrJRO5TL
         Aan9+cDHDmlk8GiyPCcN3e2sPVR3U5yQWY1aN7TI1Ugfj5lAIe22Fh0cZY/JKlT/R0IW
         J+hC0FJlrBv2FDglGvTxmDk1KOuYgx90wAsfX2mwcD/KfWNtf4oSzWe1WZ6H9u2sw/Xc
         B7Qw==
X-Gm-Message-State: APjAAAXHDtG+gAwbY3A0XkQqU26/FL8U9Ym8jqwXE/ok98qd3DWe1Rfu
        OUi+GUYR7R7pEBb3X6/2obI6kItcsqkbIHo4ohg=
X-Google-Smtp-Source: APXvYqza2UyhU3w9e++KUj30qC2saYqQyMz58jKySC4hKd+7+kJrbIlDt6mIOTXZPt0EW5IsMevKkkOAX90ny+QG/3g=
X-Received: by 2002:a9d:7d01:: with SMTP id v1mr5967204otn.167.1573720841882;
 Thu, 14 Nov 2019 00:40:41 -0800 (PST)
MIME-Version: 1.0
References: <c60806d5480b7311ced8db07ff239aa5af7a050d.1573702497.git.viresh.kumar@linaro.org>
In-Reply-To: <c60806d5480b7311ced8db07ff239aa5af7a050d.1573702497.git.viresh.kumar@linaro.org>
From:   "Rafael J. Wysocki" <rafael@kernel.org>
Date:   Thu, 14 Nov 2019 09:40:30 +0100
Message-ID: <CAJZ5v0jPkP4Nu2zbWuCGCtiBMQcnfaAOdm-GW1KX81GsyV_Cdg@mail.gmail.com>
Subject: Re: [PATCH] cpufreq: Register cpufreq drivers only after CPU devices
 are registered
To:     Viresh Kumar <viresh.kumar@linaro.org>
Cc:     Rafael Wysocki <rjw@rjwysocki.net>,
        Linux PM <linux-pm@vger.kernel.org>,
        Vincent Guittot <vincent.guittot@linaro.org>,
        Bjorn Andersson <bjorn.andersson@linaro.org>,
        Amit Kucheria <amit.kucheria@linaro.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

On Thu, Nov 14, 2019 at 4:36 AM Viresh Kumar <viresh.kumar@linaro.org> wrote:
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
> ---
> @Amit: I have added your sob without asking as you were involved in
> getting us to this patch, you did a lot of testing yesterday to find the
> root cause.

Co-developed-by is for that, so I used it in the commit.

> @Rafael: This fixes the issues reported by Bjorn on Amit's series and so
> should land before Amit's series, if at all this is acceptable to you.

Well, yes it is.

Applied for 5.5 with a reworded subject, thanks!
