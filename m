Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 36B2F18FFFC
	for <lists+linux-pm@lfdr.de>; Mon, 23 Mar 2020 22:05:24 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726179AbgCWVFX (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Mon, 23 Mar 2020 17:05:23 -0400
Received: from mail-vk1-f196.google.com ([209.85.221.196]:44113 "EHLO
        mail-vk1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726177AbgCWVFX (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Mon, 23 Mar 2020 17:05:23 -0400
Received: by mail-vk1-f196.google.com with SMTP id s194so4205649vkb.11
        for <linux-pm@vger.kernel.org>; Mon, 23 Mar 2020 14:05:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=verdurent-com.20150623.gappssmtp.com; s=20150623;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=afgnjkDJ/R+0EdXTGL+409eIfOJr3eWoeZR0O+51R6M=;
        b=w0nVY/jGdqLmt49rqhh/Y6tL2SnwaSNPXgMzQsNqnAtNVahj3eUnRvPrdrsOAUkX/6
         4/FNI/IQfzJr7WhfoOr/oNuKlXVM99+6nV6FU3Hn7CiuDmODZOtdfFSG3VZCtylp4yTu
         /THiOqbqRCbP+MMzNMZu8+GH/n9NX5N8zqweOA8MbT9bomaxtOge0ati1P21G2/dqpJo
         KYzMEbroCTHNHICjNpUjVZrxUOH+BXpsFaF6sN4xH6xGwMxn3b8u4u4309xCWOadrScU
         FI3v1Z7DWk6McdknmRIt/R1AfHFQa3DvhFGg9E8LILW6fxD1ypsBVv5ifbjp2JEH9iin
         yeag==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=afgnjkDJ/R+0EdXTGL+409eIfOJr3eWoeZR0O+51R6M=;
        b=Z61AxbJtrOc50e6891xaw+Di5z6rvgWp2IF56eJB/GfiV7bDWzRqbO+I38nolvdQPD
         FEeh675XSFJmKzpc+RFrAFXa5I1rqWl2cx9Imc5/3vPQ5rHLJ2KKLxPn+Tw/xFUvJqmK
         mVfnu5UCb01rg8kycqa1/FLdKUP3bLf0EYP+0euk6HFg0lNuEPcLUl24ELVBpq0coXnS
         cS699h/pFqkoOoa97U/fgRs2drubbO8McCxrZvgBBoN5vLPzfmmU/Ed1vUF9SGLtL6gh
         8qhUG5FKSOu+XN5Bk+w0WmINursIpcV2XG9YSe941by6E162CZRtd4Z/psG7r5Wlcok4
         dwVg==
X-Gm-Message-State: ANhLgQ0cbLwk4/g8G+6i19sCXKXzr4xKdFHwPe9X6/3VARw7ok1YWNTS
        NaVGN9qwUHp4Agcd6Y/CVLcSfSIfdUcj/GxRJeM5nw==
X-Google-Smtp-Source: ADFU+vvrjH5G4g0feRHSk0fyCI3ZyCF0GzPEmwvvKlkfu1dSa1Gzs9wMxucKb1tWPtNV9pfbDVTM+69gfAiozqy50Sw=
X-Received: by 2002:a1f:2882:: with SMTP id o124mr16886445vko.86.1584997520484;
 Mon, 23 Mar 2020 14:05:20 -0700 (PDT)
MIME-Version: 1.0
References: <20200321092740.7vvwfxsebcrznydh@macmini.local>
In-Reply-To: <20200321092740.7vvwfxsebcrznydh@macmini.local>
From:   Amit Kucheria <amit.kucheria@verdurent.com>
Date:   Tue, 24 Mar 2020 02:35:09 +0530
Message-ID: <CAHLCerOFg30GEaQgV=4ccgA1fG6P3OTgaG33pw-3YCtuD5mSmA@mail.gmail.com>
Subject: Re: [PATCH] thermal/drivers/cpufreq_cooling: Fix return of cpufreq_set_cur_state
To:     Willy Wolff <willy.mh.wolff.ml@gmail.com>
Cc:     Amit Daniel Kachhap <amit.kachhap@gmail.com>,
        Viresh Kumar <viresh.kumar@linaro.org>,
        Javi Merino <javi.merino@kernel.org>,
        Zhang Rui <rui.zhang@intel.com>,
        Daniel Lezcano <daniel.lezcano@linaro.org>,
        Linux PM list <linux-pm@vger.kernel.org>,
        LKML <linux-kernel@vger.kernel.org>,
        "Rafael J.Wysocki" <rjw@rjwysocki.net>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

Hi Willy,

On Sat, Mar 21, 2020 at 2:57 PM Willy Wolff <willy.mh.wolff.ml@gmail.com> wrote:
>
> The function freq_qos_update_request returns 0 or 1 describing update
> effectiveness, and a negative error code on failure. However,
> cpufreq_set_cur_state returns 0 on success or an error code otherwise.
>

Please improve the commit message with context from your earlier bug
report thread and a summary of how the problem shows up.

Thanks,
Amit



> Signed-off-by: Willy Wolff <willy.mh.wolff.ml@gmail.com>
> ---
>  drivers/thermal/cpufreq_cooling.c | 6 ++++--
>  1 file changed, 4 insertions(+), 2 deletions(-)
>
> diff --git a/drivers/thermal/cpufreq_cooling.c b/drivers/thermal/cpufreq_cooling.c
> index fe83d7a210d4..af55ac08e1bd 100644
> --- a/drivers/thermal/cpufreq_cooling.c
> +++ b/drivers/thermal/cpufreq_cooling.c
> @@ -431,6 +431,7 @@ static int cpufreq_set_cur_state(struct thermal_cooling_device *cdev,
>                                  unsigned long state)
>  {
>         struct cpufreq_cooling_device *cpufreq_cdev = cdev->devdata;
> +       int ret;
>
>         /* Request state should be less than max_level */
>         if (WARN_ON(state > cpufreq_cdev->max_level))
> @@ -442,8 +443,9 @@ static int cpufreq_set_cur_state(struct thermal_cooling_device *cdev,
>
>         cpufreq_cdev->cpufreq_state = state;
>
> -       return freq_qos_update_request(&cpufreq_cdev->qos_req,
> -                               get_state_freq(cpufreq_cdev, state));
> +       ret = freq_qos_update_request(&cpufreq_cdev->qos_req,
> +                                     get_state_freq(cpufreq_cdev, state));
> +       return ret < 0 ? ret : 0;
>  }
>
>  /* Bind cpufreq callbacks to thermal cooling device ops */
> --
> 2.20.1
>
