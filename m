Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 676232757BD
	for <lists+linux-pm@lfdr.de>; Wed, 23 Sep 2020 14:12:27 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726513AbgIWMMZ (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Wed, 23 Sep 2020 08:12:25 -0400
Received: from mail-oi1-f196.google.com ([209.85.167.196]:45931 "EHLO
        mail-oi1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726498AbgIWMMZ (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Wed, 23 Sep 2020 08:12:25 -0400
Received: by mail-oi1-f196.google.com with SMTP id z26so24724138oih.12;
        Wed, 23 Sep 2020 05:12:24 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=eveZIbMy5IaynFxma8rYgZSMFND5801oVWlwra+0n8I=;
        b=bOZnX94N16otpsU1LPVWYvCSMbFL+SOA3z5aaeuRoCHjOGWRI7Eh+w1RyeaQPZ7UWu
         nCEwbqhcZ6D9u0j0UFGVNL3xFtmFDJdI4LgV8u84/pxuxuaxAznJhc9DZfVycfMtmDIz
         Ah1z6B5tmg+tyytM7XyQSAJ8K86NKQz6krbWO4YFtxAl4XFCu9l4rszHbk7zkleP1oN8
         4WaZ9O9Cpxfyy+a/dDa3JdiSXIm/dcHl0H2wthrt8yEKrcMLhe1wjkwU5Bbk092Xk+Fb
         T58S5HB+VQ6lJEevGYDGtunbMHfWBXR0zgZcbco91Cn242Rz/m5HmeiaKMP/PsXRlvYH
         6gYw==
X-Gm-Message-State: AOAM532me7d4Gi7j0L/8bL+rUjUg3otut1DDTKn9+jXYYuK3QXKhrgk8
        jXPeWUcC3i/Mhy0Ty9onxY/d2PyhZk04Ix/9vtzy1DY4
X-Google-Smtp-Source: ABdhPJzzJuupuF64EpLqYlHLZHIz3hvhsnMUcZcqxdYlUfrZGOIRy88bH3VwTICVcry00uYzCyQWzAIc7VxUC0xZMbQ=
X-Received: by 2002:aca:5b09:: with SMTP id p9mr5330041oib.68.1600863144301;
 Wed, 23 Sep 2020 05:12:24 -0700 (PDT)
MIME-Version: 1.0
References: <20200922183416.14442-1-ilina@codeaurora.org>
In-Reply-To: <20200922183416.14442-1-ilina@codeaurora.org>
From:   "Rafael J. Wysocki" <rafael@kernel.org>
Date:   Wed, 23 Sep 2020 14:12:10 +0200
Message-ID: <CAJZ5v0gooHij1AAjXXm+R-SHYUscuvANYv25pG2_iWqe_DBcpw@mail.gmail.com>
Subject: Re: [PATCH v2] cpuidle: record state entry rejection statistics
To:     Lina Iyer <ilina@codeaurora.org>
Cc:     "Rafael J. Wysocki" <rjw@rjwysocki.net>,
        Daniel Lezcano <daniel.lezcano@linaro.org>,
        Linux PM <linux-pm@vger.kernel.org>,
        linux-arm-msm <linux-arm-msm@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

On Tue, Sep 22, 2020 at 8:34 PM Lina Iyer <ilina@codeaurora.org> wrote:
>
> CPUs may fail to enter the chosen idle state if there was a pending
> interrupt. The cpuidle driver would return an error value in that case.
> Let's record that and show along with other statistics for the idle
> state. This could prove useful in understanding behavior of the governor
> and the system during usecases that involve multiple CPUs.
>
> Signed-off-by: Lina Iyer <ilina@codeaurora.org>

Applied as 5.10 material with some changelog and documentation edits, thanks!

>
> ---
> Changes in v2:
> - Rename 'failed' to 'rejected'
> - Update documentation
> ---
>  Documentation/admin-guide/pm/cpuidle.rst | 8 ++++++++
>  drivers/cpuidle/cpuidle.c                | 1 +
>  drivers/cpuidle/sysfs.c                  | 3 +++
>  include/linux/cpuidle.h                  | 1 +
>  4 files changed, 13 insertions(+)
>
> diff --git a/Documentation/admin-guide/pm/cpuidle.rst b/Documentation/admin-guide/pm/cpuidle.rst
> index a96a423e3779..1e7fd7a64c65 100644
> --- a/Documentation/admin-guide/pm/cpuidle.rst
> +++ b/Documentation/admin-guide/pm/cpuidle.rst
> @@ -528,6 +528,9 @@ object corresponding to it, as follows:
>         Total number of times the hardware has been asked by the given CPU to
>         enter this idle state.
>
> +``rejected``
> +        Total number of times the idle state requested to the CPU was rejected.
> +
>  The :file:`desc` and :file:`name` files both contain strings.  The difference
>  between them is that the name is expected to be more concise, while the
>  description may be longer and it may contain white space or special characters.
> @@ -572,6 +575,11 @@ particular case.  For these reasons, the only reliable way to find out how
>  much time has been spent by the hardware in different idle states supported by
>  it is to use idle state residency counters in the hardware, if available.
>
> +Generally, an  interrupt received when entering idle state would cause the idle
> +state entry request to be rejected. The return value from the cpuidle driver
> +indicates whether the idle state was entered or rejected. The files
> +:file:`usage` and :file:`rejected` report the number of times the idle states
> +were successfully entered and rejected, respectively.
>
>  .. _cpu-pm-qos:
>
> diff --git a/drivers/cpuidle/cpuidle.c b/drivers/cpuidle/cpuidle.c
> index 6c7e5621cf9a..0ed5030b89d6 100644
> --- a/drivers/cpuidle/cpuidle.c
> +++ b/drivers/cpuidle/cpuidle.c
> @@ -307,6 +307,7 @@ int cpuidle_enter_state(struct cpuidle_device *dev, struct cpuidle_driver *drv,
>                 }
>         } else {
>                 dev->last_residency_ns = 0;
> +               dev->states_usage[index].rejected++;
>         }
>
>         return entered_state;
> diff --git a/drivers/cpuidle/sysfs.c b/drivers/cpuidle/sysfs.c
> index 091d1caceb41..53ec9585ccd4 100644
> --- a/drivers/cpuidle/sysfs.c
> +++ b/drivers/cpuidle/sysfs.c
> @@ -256,6 +256,7 @@ define_show_state_time_function(exit_latency)
>  define_show_state_time_function(target_residency)
>  define_show_state_function(power_usage)
>  define_show_state_ull_function(usage)
> +define_show_state_ull_function(rejected)
>  define_show_state_str_function(name)
>  define_show_state_str_function(desc)
>  define_show_state_ull_function(above)
> @@ -312,6 +313,7 @@ define_one_state_ro(latency, show_state_exit_latency);
>  define_one_state_ro(residency, show_state_target_residency);
>  define_one_state_ro(power, show_state_power_usage);
>  define_one_state_ro(usage, show_state_usage);
> +define_one_state_ro(rejected, show_state_rejected);
>  define_one_state_ro(time, show_state_time);
>  define_one_state_rw(disable, show_state_disable, store_state_disable);
>  define_one_state_ro(above, show_state_above);
> @@ -325,6 +327,7 @@ static struct attribute *cpuidle_state_default_attrs[] = {
>         &attr_residency.attr,
>         &attr_power.attr,
>         &attr_usage.attr,
> +       &attr_rejected.attr,
>         &attr_time.attr,
>         &attr_disable.attr,
>         &attr_above.attr,
> diff --git a/include/linux/cpuidle.h b/include/linux/cpuidle.h
> index 6175c77bf25e..ed0da0e58e8b 100644
> --- a/include/linux/cpuidle.h
> +++ b/include/linux/cpuidle.h
> @@ -38,6 +38,7 @@ struct cpuidle_state_usage {
>         u64                     time_ns;
>         unsigned long long      above; /* Number of times it's been too deep */
>         unsigned long long      below; /* Number of times it's been too shallow */
> +       unsigned long long      rejected; /* Number of times idle entry was rejected */
>  #ifdef CONFIG_SUSPEND
>         unsigned long long      s2idle_usage;
>         unsigned long long      s2idle_time; /* in US */
> --
> The Qualcomm Innovation Center, Inc. is a member of the Code Aurora Forum,
> a Linux Foundation Collaborative Project
>
