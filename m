Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 294B1ED8F0
	for <lists+linux-pm@lfdr.de>; Mon,  4 Nov 2019 07:21:47 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727877AbfKDGVq (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Mon, 4 Nov 2019 01:21:46 -0500
Received: from mail-vs1-f67.google.com ([209.85.217.67]:46206 "EHLO
        mail-vs1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727444AbfKDGVq (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Mon, 4 Nov 2019 01:21:46 -0500
Received: by mail-vs1-f67.google.com with SMTP id m6so3739046vsn.13
        for <linux-pm@vger.kernel.org>; Sun, 03 Nov 2019 22:21:45 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=verdurent-com.20150623.gappssmtp.com; s=20150623;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=7XR8aB5FAq9qkqAbv6gsdSxRJnXfyOytqENlU/Ne5DU=;
        b=tChmpZXnDE+NZfUpbyo9vgercVEz57+g+KJ6PCCgO4+F9c9kwGAkmddksvV48bLCF9
         p/FUK8tFwUmLyBblcmvupC7rnr4BmNQJUdkyZGCr8gfMZ80Ac3rXLTeUK68zqtgS6drH
         jNuJGYGJ3zQr+A5C4Q/0QiOjNmAcQjr7myleAIRBlYesLUIlQQ7gpLfYLyaZ9ANUI7OF
         ddCeyNTYE5/ciITcrSmpHyuDKyQQR/RQtsCIcPHuwbU9P6A2Hurlc6/1EHfji9GfaaNp
         626+TXtHgKfR47I+1e+nOuRYIPol1W7fNOW0Trgc9eT4QvJt58zkzsV9XaNKhv79evHV
         LUSg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=7XR8aB5FAq9qkqAbv6gsdSxRJnXfyOytqENlU/Ne5DU=;
        b=YO5CsU1QFnZk+SoFYvmo50WQjUc2Fnx3GOs1/XV2LfB0jKVNq8GfJTZZ5zGsvBPsPb
         fWGTMfZzYJwcRniN/oDjGALHzlG4be/ZBNX61y/pIkFCj9enELSr30b6+lH2HR8Pt5CZ
         QX1qTBck9i7NJ0sp8rR1MHGtqq+swyLy0w2pkGHE2cwARBTwm+e5OmZzZBrEqHMXqGpN
         QI0II2V6+ZkHlNDCQ1tO63QPyDdTXbMZR+6HMgEhfG5NQTcIOYJraaVZ0yB9W/XWU/En
         K/2rvdxqjtfE336hpssuikxfPqC1JbgDrVmUBjWno843qdVNAPRU3ou2XiV1I9YSBA3m
         bEuQ==
X-Gm-Message-State: APjAAAULOtb8GUgse/VQP+9cLBX4uJKaEShVBmGGMyBmjZ44mUtBtUko
        foYI9bysMjr1qUauznathvm/gnghoAzUdFQvuWMRnw==
X-Google-Smtp-Source: APXvYqyWHViqGHAgMlTc9BBuG9Nxtj3v53mAItQ8daEFU0o9x+TOGhJ1eiReK7K71hBJG16iXSGIYEcT6HWTxYKKOmA=
X-Received: by 2002:a67:df0d:: with SMTP id s13mr10831700vsk.95.1572848504953;
 Sun, 03 Nov 2019 22:21:44 -0800 (PST)
MIME-Version: 1.0
References: <20191030091038.678-1-daniel.lezcano@linaro.org> <20191030091038.678-2-daniel.lezcano@linaro.org>
In-Reply-To: <20191030091038.678-2-daniel.lezcano@linaro.org>
From:   Amit Kucheria <amit.kucheria@verdurent.com>
Date:   Mon, 4 Nov 2019 11:51:33 +0530
Message-ID: <CAHLCerO6eN6qXRS9Mdz4TwVTH9_dF5eiWqqWkcW+5+PFF_WwzA@mail.gmail.com>
Subject: Re: [PATCH 2/2] thermal: cpu_cooling: Reorder the header file
To:     Daniel Lezcano <daniel.lezcano@linaro.org>
Cc:     Amit Daniel Kachhap <amit.kachhap@gmail.com>,
        Viresh Kumar <viresh.kumar@linaro.org>,
        Javi Merino <javi.merino@kernel.org>,
        Zhang Rui <rui.zhang@intel.com>,
        Eduardo Valentin <edubezval@gmail.com>,
        "open list:THERMAL/CPU_COOLING" <linux-pm@vger.kernel.org>,
        open list <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

On Wed, Oct 30, 2019 at 2:41 PM Daniel Lezcano
<daniel.lezcano@linaro.org> wrote:
>
> As the conditions are simplified and unified, it is useless to have
> different blocks of definitions under the same compiler condition,
> let's merge the blocks.
>
> There is no functional change.
>
> Signed-off-by: Daniel Lezcano <daniel.lezcano@linaro.org>

Reviewed-by: Amit Kucheria <amit.kucheria@linaro.org>

> ---
>  include/linux/cpu_cooling.h | 16 +++++++---------
>  1 file changed, 7 insertions(+), 9 deletions(-)
>
> diff --git a/include/linux/cpu_cooling.h b/include/linux/cpu_cooling.h
> index 72d1c9c5e538..b74732535e4b 100644
> --- a/include/linux/cpu_cooling.h
> +++ b/include/linux/cpu_cooling.h
> @@ -33,6 +33,13 @@ cpufreq_cooling_register(struct cpufreq_policy *policy);
>   */
>  void cpufreq_cooling_unregister(struct thermal_cooling_device *cdev);
>
> +/**
> + * of_cpufreq_cooling_register - create cpufreq cooling device based on DT.
> + * @policy: cpufreq policy.
> + */
> +struct thermal_cooling_device *
> +of_cpufreq_cooling_register(struct cpufreq_policy *policy);
> +
>  #else /* !CONFIG_CPU_THERMAL */
>  static inline struct thermal_cooling_device *
>  cpufreq_cooling_register(struct cpufreq_policy *policy)
> @@ -45,16 +52,7 @@ void cpufreq_cooling_unregister(struct thermal_cooling_device *cdev)
>  {
>         return;
>  }
> -#endif /* CONFIG_CPU_THERMAL */
>
> -#ifdef CONFIG_CPU_THERMAL
> -/**
> - * of_cpufreq_cooling_register - create cpufreq cooling device based on DT.
> - * @policy: cpufreq policy.
> - */
> -struct thermal_cooling_device *
> -of_cpufreq_cooling_register(struct cpufreq_policy *policy);
> -#else
>  static inline struct thermal_cooling_device *
>  of_cpufreq_cooling_register(struct cpufreq_policy *policy)
>  {
> --
> 2.17.1
>
