Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 369517F851
	for <lists+linux-pm@lfdr.de>; Fri,  2 Aug 2019 15:19:17 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2393175AbfHBNTP (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Fri, 2 Aug 2019 09:19:15 -0400
Received: from mail-lf1-f68.google.com ([209.85.167.68]:44938 "EHLO
        mail-lf1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2390134AbfHBNTO (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Fri, 2 Aug 2019 09:19:14 -0400
Received: by mail-lf1-f68.google.com with SMTP id r15so35930576lfm.11
        for <linux-pm@vger.kernel.org>; Fri, 02 Aug 2019 06:19:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=BYlIJPvFssOK64x+am/xS2wZWcj/FM4eymxQYdJNO0E=;
        b=l1ySagA5Vavb8EysRzrgjml8hUDMlz1+OS0qxIY9MuS/t4+ISzmv+SatgRNkZes9N4
         NxBnY3tJ4i4w6lZXvX/wi3/LKGu49oc9XLvkdBGMC5vn4ZS0qjvfmYZiRqeGd8sOsnNq
         mzChlxS6LnKnDA804KT9bA2jzbFjy64GLuZ6qhFT32Yor75167thxtgFkXzHU2g6dN8m
         VhsG+JKQ8tDYXVTWdC+k4Jpdq3+3sPRfEC4a72mi0rku3noody1gCMEbSif5LhOTXOUJ
         fD0tVWHzbs/PmTwRUALLRcWk5EVEdFTwixoUDVkEWxPKGH/IZmqHrMmlYXFFvL/omZC9
         PdAg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=BYlIJPvFssOK64x+am/xS2wZWcj/FM4eymxQYdJNO0E=;
        b=d6de4qy5JB+doZsMCQX0aecnYuDsmqqOBKzhXFshuOQ1ojsy9Izy/d3ZuVAmLSwiZF
         a+e1wwzeOeCltYuTUfM99x7zGGinmbRqvKWk2bFbtuDTXDJg4YjI+iHfvqJECbflH0Zp
         6Ulk01D/slur/aF5/NlwpRyQw9OzScUfzH0jrr1RIipQpcpIp8TXpFBExlJSdcCFU8+g
         amMF/SlhA6Ie4clJSWzUxT+PQrfcL2c/q1E9C3/SWL9PiY77h+lBUAEGaOMyrWJKMcUw
         p87O8R4sVHaMg7fGrlntco2QGIGrRm3u3WlE8gEswuJyCko2KQafl+2th8hdammxcHai
         5XYQ==
X-Gm-Message-State: APjAAAXyEMYKddqGvOoKKXiIVNv4d/zSHgymTYSlY2rsXoB4RuDPiBS6
        7/szU2fhguIPzhnQlb9SzzQwIfXwu/UFIZaLNymTIA==
X-Google-Smtp-Source: APXvYqz47bQkJowsL0czNkaKYpSnYdc6hiS5O1FqH5ObL6RyI/23H5A2jSTq1qZmoQtSLLA93qeYpvHJnfmT/d6Rg94=
X-Received: by 2002:a19:ec15:: with SMTP id b21mr10642487lfa.32.1564751952808;
 Fri, 02 Aug 2019 06:19:12 -0700 (PDT)
MIME-Version: 1.0
References: <20190802104628.8410-1-qais.yousef@arm.com>
In-Reply-To: <20190802104628.8410-1-qais.yousef@arm.com>
From:   Vincent Guittot <vincent.guittot@linaro.org>
Date:   Fri, 2 Aug 2019 15:19:02 +0200
Message-ID: <CAKfTPtDxuwhnSrHDK4hq86wEu2JP8OwXVb_TQbo5UL9D+fkoJQ@mail.gmail.com>
Subject: Re: [PATCH] cpufreq: schedutil: fix equation in comment
To:     Qais Yousef <qais.yousef@arm.com>
Cc:     Peter Zijlstra <peterz@infradead.org>,
        "Rafael J . Wysocki" <rjw@rjwysocki.net>,
        Viresh Kumar <viresh.kumar@linaro.org>,
        Ingo Molnar <mingo@redhat.com>,
        "open list:THERMAL" <linux-pm@vger.kernel.org>,
        linux-kernel <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

On Fri, 2 Aug 2019 at 12:46, Qais Yousef <qais.yousef@arm.com> wrote:
>
> scale_irq_capacity() call in schedutil_cpu_util() does
>
>         util *= (max - irq)
>         util /= max
>
> But the comment says
>
>         util *= (1 - irq)
>         util /= max
>
> Fix the comment to match what the scaling function does.
>
> Signed-off-by: Qais Yousef <qais.yousef@arm.com>

FWIW
Acked-by:  Vincent Guittot <vincent.guittot@linaro.org>
> ---
>  kernel/sched/cpufreq_schedutil.c | 6 +++---
>  1 file changed, 3 insertions(+), 3 deletions(-)
>
> diff --git a/kernel/sched/cpufreq_schedutil.c b/kernel/sched/cpufreq_schedutil.c
> index 636ca6f88c8e..e127d89d5974 100644
> --- a/kernel/sched/cpufreq_schedutil.c
> +++ b/kernel/sched/cpufreq_schedutil.c
> @@ -259,9 +259,9 @@ unsigned long schedutil_cpu_util(int cpu, unsigned long util_cfs,
>          * irq metric. Because IRQ/steal time is hidden from the task clock we
>          * need to scale the task numbers:
>          *
> -        *              1 - irq
> -        *   U' = irq + ------- * U
> -        *                max
> +        *              max - irq
> +        *   U' = irq + --------- * U
> +        *                 max
>          */
>         util = scale_irq_capacity(util, irq, max);
>         util += irq;
> --
> 2.17.1
>
