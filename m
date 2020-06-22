Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A2F5B203312
	for <lists+linux-pm@lfdr.de>; Mon, 22 Jun 2020 11:16:10 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726426AbgFVJQJ (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Mon, 22 Jun 2020 05:16:09 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36766 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726047AbgFVJQJ (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Mon, 22 Jun 2020 05:16:09 -0400
Received: from mail-vk1-xa42.google.com (mail-vk1-xa42.google.com [IPv6:2607:f8b0:4864:20::a42])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 20E74C061794
        for <linux-pm@vger.kernel.org>; Mon, 22 Jun 2020 02:16:09 -0700 (PDT)
Received: by mail-vk1-xa42.google.com with SMTP id s6so3777317vkb.9
        for <linux-pm@vger.kernel.org>; Mon, 22 Jun 2020 02:16:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=NDecMwAQTCegGOg+vSBrgZxDNrHozXoTSFs1bBiYrhQ=;
        b=lN91PIUmbPojW0Q6OFXuhuvKqEvyu68NX4Wp7iVVvAnK7IbEXq2624awvXoLWjd7kj
         bwnimKaV65S3YO9zHn/ClNN30JziW9PbfGIUxVAj/cGZNsR2wTOyelWrH5stOq1SUATh
         8jCvXERB8Jqm+yjZqEbt5+YF78f9oJjY9GlnkfmxCc8rqzwQ8if69gcl8qPvOFccL+hR
         GL4Y1+iIPnEJ50yIxmUASnFzSe7Fyk5ciAMNEX5YpsdgdALTiKvyDsUQfCPv832nrnHW
         HhkITyW0ZfbohqF9Fpvf+rpYuHULlPCidRtuXWF5rkNQMXLdMjvhhC6Bw44vnbUggJPo
         aS9A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=NDecMwAQTCegGOg+vSBrgZxDNrHozXoTSFs1bBiYrhQ=;
        b=ouK8RNPyBG+ZnhBcsFDJJ+avFZhUkW1wOe3uPtZXfNTVJ4NkjWDLNf4+AfOxIsn+5u
         DmMVmBjvmntf6kHnBp5gImL3km8P4/812XTYzFWgP7mn+S0/F3OP+VIpj6wD5GOJeeKT
         cSBCwxl4lMdRsYoeU4a2cmAR97Itv0vSNR4c5vBtORlW2HHHOFZvga7/pbyAjbG0qeZc
         2+bNXonIK1DWg7dOLxB7HKKmZRKR/da+RR8FxvN8o2w2eGSgh+Nc8qrMVmFOR7nM1V1a
         c6/saxBaXia5GFoc9nvMQvXKuDfmIrferVzQK++XbHvCAbilfdGXZ2dN/DQ5G4aQp6rf
         R1dg==
X-Gm-Message-State: AOAM530GMrSvHih211kLlsW2UNmKygRlmWk+hmVW1PMpDl3ZNmhmkTXP
        Sx3wVVM+lMUEOW3YQc5Ix/ohbyYgNGliHs/WoZHq1g==
X-Google-Smtp-Source: ABdhPJwAs3/P/4JqM3ZPC29AuUFUKFR3bS8J9Tr5EK/NjZ5gOqokqkyZfw2MTSUxBfm8xO+0EXisHhK9HU0yshQkctY=
X-Received: by 2002:ac5:c189:: with SMTP id z9mr5248794vkb.79.1592817368315;
 Mon, 22 Jun 2020 02:16:08 -0700 (PDT)
MIME-Version: 1.0
References: <20200619015126.15002-1-finley.xiao@rock-chips.com>
In-Reply-To: <20200619015126.15002-1-finley.xiao@rock-chips.com>
From:   Amit Kucheria <amit.kucheria@linaro.org>
Date:   Mon, 22 Jun 2020 14:45:57 +0530
Message-ID: <CAHLCerNnJELC=ZhiG7XFbRLk8GgkSSLEPncGt-Yf9yAeDe=9NA@mail.gmail.com>
Subject: Re: [PATCH] thermal/drivers/cpufreq_cooling: Fix wrong frequency
 converted from power
To:     Finley Xiao <finley.xiao@rock-chips.com>
Cc:     xf@rock-chips.com, Heiko Stuebner <heiko@sntech.de>,
        Amit Daniel Kachhap <amit.kachhap@gmail.com>,
        Daniel Lezcano <daniel.lezcano@linaro.org>,
        Viresh Kumar <viresh.kumar@linaro.org>,
        Javi Merino <javi.merino@kernel.org>,
        Zhang Rui <rui.zhang@intel.com>,
        linux-rockchip@lists.infradead.org,
        LKML <linux-kernel@vger.kernel.org>,
        Linux PM list <linux-pm@vger.kernel.org>,
        huangtao@rock-chips.com, tony.xie@rock-chips.com, cl@rock-chips.com
Content-Type: text/plain; charset="UTF-8"
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

On Fri, Jun 19, 2020 at 7:21 AM Finley Xiao <finley.xiao@rock-chips.com> wrote:
>
> The function cpu_power_to_freq is used to find a frequency and set the
> cooling device to consume at most the power to be converted. For example,
> if the power to be converted is 80mW, and the em table is as follow.
> struct em_cap_state table[] = {
>         /* KHz     mW */
>         { 1008000, 36, 0 },
>         { 1200000, 49, 0 },
>         { 1296000, 59, 0 },
>         { 1416000, 72, 0 },
>         { 1512000, 86, 0 },
> };
> The target frequency should be 1416000KHz, not 1512000KHz.
>
> Fixes: 349d39dc5739 ("thermal: cpu_cooling: merge frequency and power tables")
> Signed-off-by: Finley Xiao <finley.xiao@rock-chips.com>

Reviewed-by: Amit Kucheria <amit.kucheria@linaro.org>

> ---
>  drivers/thermal/cpufreq_cooling.c | 6 +++---
>  1 file changed, 3 insertions(+), 3 deletions(-)
>
> diff --git a/drivers/thermal/cpufreq_cooling.c b/drivers/thermal/cpufreq_cooling.c
> index 9e124020519f..6c0e1b053126 100644
> --- a/drivers/thermal/cpufreq_cooling.c
> +++ b/drivers/thermal/cpufreq_cooling.c
> @@ -123,12 +123,12 @@ static u32 cpu_power_to_freq(struct cpufreq_cooling_device *cpufreq_cdev,
>  {
>         int i;
>
> -       for (i = cpufreq_cdev->max_level - 1; i >= 0; i--) {
> -               if (power > cpufreq_cdev->em->table[i].power)
> +       for (i = cpufreq_cdev->max_level; i >= 0; i--) {
> +               if (power >= cpufreq_cdev->em->table[i].power)
>                         break;
>         }
>
> -       return cpufreq_cdev->em->table[i + 1].frequency;
> +       return cpufreq_cdev->em->table[i].frequency;
>  }
>
>  /**
> --
> 2.11.0
>
>
>
