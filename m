Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 1ECCB190391
	for <lists+linux-pm@lfdr.de>; Tue, 24 Mar 2020 03:30:12 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727213AbgCXCaL (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Mon, 23 Mar 2020 22:30:11 -0400
Received: from mail-vk1-f194.google.com ([209.85.221.194]:40476 "EHLO
        mail-vk1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726824AbgCXCaK (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Mon, 23 Mar 2020 22:30:10 -0400
Received: by mail-vk1-f194.google.com with SMTP id k63so4414905vka.7
        for <linux-pm@vger.kernel.org>; Mon, 23 Mar 2020 19:30:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=verdurent-com.20150623.gappssmtp.com; s=20150623;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=E654FjdUEQHUs8slsoY39LXgqQlQcst7HtR/NPfu2ZU=;
        b=PyFnFDvHAMFtZOHiL4JFSEvTOpBWyVQ8WX+T2B9tTPB+q275MbxkOqKZ1+ISeFb6gm
         jaPo5MDrjePiqUG7HWMGP09fCnGlt0kCqsLJhlkJmER/XMa8VnA0R6gso4cAOjV2jLGz
         VYvcp5LP370pkMyIxuP1Mv0Q+YZEdohyHkUywWz8WjASqHjz0/mJqw/AN3ZwBe7h3/iw
         WFMiQ+fo5taKM6gEd0Wji7LTUqKGVjCMhp2afWe9qHBhtdfipHQ5zzl7+vqh151bIXi3
         ylbM+X9UsC7TJ+3N6DunPFxwvzmUjf21SJPrLEuJZuWoYmMFdWgX8tiwFCVEdZgkAyBu
         RwAg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=E654FjdUEQHUs8slsoY39LXgqQlQcst7HtR/NPfu2ZU=;
        b=BF0utGmx9h8CZpsm2ILdEL7TfHiRkBVxpXyTzEHOj8UrbbLXv/eJW92B8ZvGLl3uLI
         F1r+E6N1PRk2VJjD6vjT3+SqVLDhimCNH7morkZPSdtZJzSG1NfBgtszahx8okTPosm7
         jK3vS3o5lQRSSWLj6BNzXFWJv8ZjCLyovdnF1IAKNqs1xSKgHa+PmjzbDvC8yh4FK7kE
         m4yp8nwImL3Yt/65x5NwA/PE0ZvbrxMIJJmMUE8gbAH4TkCca5BszDdycRRvE8J7YxIz
         vTkKySUzCkrlWYmCdUKkqCLt3+G76nkXo5QZdNgbJJlcJef4lY0dQPhmNMqXvpPP0dJf
         h2nA==
X-Gm-Message-State: ANhLgQ05iR8k4L4cO1zeeuB82nkol0C1SAYwzTrjw+T5lzDg/oJhX4gw
        VfiNStJXbzgcSL8uRkJG+WCXl+jxufxKbN8IM0nPmg==
X-Google-Smtp-Source: ADFU+vsNWDf85t42CDUfiM9Il8e3f8zk6wDs/cv9jsrMiNAdLh8PJOcpCzY0DfTq5I6U3WH+HvpaRN6WK1qTQVgkdRo=
X-Received: by 2002:a1f:ee05:: with SMTP id m5mr17038079vkh.9.1585017006589;
 Mon, 23 Mar 2020 19:30:06 -0700 (PDT)
MIME-Version: 1.0
References: <20200321193107.21590-1-daniel.lezcano@linaro.org>
In-Reply-To: <20200321193107.21590-1-daniel.lezcano@linaro.org>
From:   Amit Kucheria <amit.kucheria@verdurent.com>
Date:   Tue, 24 Mar 2020 08:00:00 +0530
Message-ID: <CAHLCerPheqrD4Qkxsy1LmdLP1OTVb2pZkKMVCA0dK3CL9xfGKA@mail.gmail.com>
Subject: Re: [PATCH] thermal/drivers/cpufreq_cooling: Remove abusing WARN_ON
To:     Daniel Lezcano <daniel.lezcano@linaro.org>
Cc:     Amit Daniel Kachhap <amit.kachhap@gmail.com>,
        Viresh Kumar <viresh.kumar@linaro.org>,
        Javi Merino <javi.merino@kernel.org>,
        Zhang Rui <rui.zhang@intel.com>,
        "open list:THERMAL/CPU_COOLING" <linux-pm@vger.kernel.org>,
        open list <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

On Sun, Mar 22, 2020 at 1:01 AM Daniel Lezcano
<daniel.lezcano@linaro.org> wrote:
>
> The WARN_ON macros are used at the entry functions state2power() and
> set_cur_state().
>
> state2power() is called with the max_state retrieved from
> get_max_state which returns cpufreq_cdev->max_level, then it check if
> max_state is > cpufreq_cdev->max_level. The test does not really makes
> sense but let's assume we want to make sure to catch an error if the
> code evolves. However the WARN_ON is overkill.
>
> set_cur_state() is also called from userspace if we write to the
> sysfs. It is easy to see a stack dumped by just writing to sysfs
> /sys/class/thermal/cooling_device0/cur_state a value greater than
> "max_level". A bit scary. Returing -EINVAL is enough.
>
> Remove these WARN_ON.
>
> Signed-off-by: Daniel Lezcano <daniel.lezcano@linaro.org>

Reviewed-by: Amit Kucheria <amit.kucheria@linaro.org>

> ---
>  drivers/thermal/cpufreq_cooling.c | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)
>
> diff --git a/drivers/thermal/cpufreq_cooling.c b/drivers/thermal/cpufreq_cooling.c
> index af55ac08e1bd..d66791a71320 100644
> --- a/drivers/thermal/cpufreq_cooling.c
> +++ b/drivers/thermal/cpufreq_cooling.c
> @@ -273,7 +273,7 @@ static int cpufreq_state2power(struct thermal_cooling_device *cdev,
>         struct cpufreq_cooling_device *cpufreq_cdev = cdev->devdata;
>
>         /* Request state should be less than max_level */
> -       if (WARN_ON(state > cpufreq_cdev->max_level))
> +       if (state > cpufreq_cdev->max_level)
>                 return -EINVAL;
>
>         num_cpus = cpumask_weight(cpufreq_cdev->policy->cpus);
> @@ -434,7 +434,7 @@ static int cpufreq_set_cur_state(struct thermal_cooling_device *cdev,
>         int ret;
>
>         /* Request state should be less than max_level */
> -       if (WARN_ON(state > cpufreq_cdev->max_level))
> +       if (state > cpufreq_cdev->max_level)
>                 return -EINVAL;
>
>         /* Check if the old cooling action is same as new cooling action */
> --
> 2.17.1
>
