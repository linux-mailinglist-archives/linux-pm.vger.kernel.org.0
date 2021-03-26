Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2BB2D34ACC9
	for <lists+linux-pm@lfdr.de>; Fri, 26 Mar 2021 17:46:20 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230229AbhCZQpr (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Fri, 26 Mar 2021 12:45:47 -0400
Received: from mail-ot1-f41.google.com ([209.85.210.41]:44567 "EHLO
        mail-ot1-f41.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230202AbhCZQpc (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Fri, 26 Mar 2021 12:45:32 -0400
Received: by mail-ot1-f41.google.com with SMTP id y19-20020a0568301d93b02901b9f88a238eso5762950oti.11
        for <linux-pm@vger.kernel.org>; Fri, 26 Mar 2021 09:45:31 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=vYaAi8VUcn+kUizM9rf54wEMjzaeJgloZLMKJxfbbLQ=;
        b=QAuq3UUv3Xvc3ukcGcdCbCFtPUbfFVRp9Hy61DgySlqPuQSwcpxDSuL/d7TdHRpPPj
         JtkBtUAMg6ZQSe4qCMZ7GQGh79Z5Fi8zcQOjcQT1taee5ARy4FfmRHC1A+OaJDeop8+K
         1fDiLxqkDg5NhllFYOeyGGmUFcK4XH22pDGhTX3m29frpANmg1ynoGShv5oYuEQT2xVN
         0lu2jc5Aa6Dy3nPYoQR3LwSMECdMXRmduhhA729ON/d8Iwd1ewSySEvQyl8mkd7CRKWP
         Ja9wpqBDgoaGjFn/4d5oaS9DPNpjgyKkzbp3+sQ9s84oWUaDLAWQBhsIMfbNgnnAhF8J
         MJdA==
X-Gm-Message-State: AOAM532zEP49Rz6YLFOQsg+VNxb+D+HpaxOS86RqJ1zH29KBUYtsxivc
        6XmIj12SZwSPOS1sZFPr6Lh0jqUIjcYIS2qpaA8=
X-Google-Smtp-Source: ABdhPJyhpHPy9AoR3eBgP5UYFfw/6do0UgLnQp+89YtsiqvrFK8XHExEYJwosPqfoxsomFpkxpTQma6aZRUdyyxE8CU=
X-Received: by 2002:a9d:4811:: with SMTP id c17mr12926162otf.206.1616777131376;
 Fri, 26 Mar 2021 09:45:31 -0700 (PDT)
MIME-Version: 1.0
References: <20210326120721.1577965-1-geert+renesas@glider.be>
In-Reply-To: <20210326120721.1577965-1-geert+renesas@glider.be>
From:   "Rafael J. Wysocki" <rafael@kernel.org>
Date:   Fri, 26 Mar 2021 17:45:20 +0100
Message-ID: <CAJZ5v0gnX8FN5hLKk-dw3wiyva3+bHxooSn5W5fW48J7fBE__Q@mail.gmail.com>
Subject: Re: [PATCH trivial] cpufreq: Fix scaling_{available,boost}_frequencies_show()
 comments
To:     Geert Uytterhoeven <geert+renesas@glider.be>
Cc:     "Rafael J . Wysocki" <rjw@rjwysocki.net>,
        Viresh Kumar <viresh.kumar@linaro.org>,
        Jiri Kosina <trivial@kernel.org>,
        Myungjoo Ham <myungjoo.ham@samsung.com>,
        Lukasz Majewski <l.majewski@samsung.com>,
        Linux PM <linux-pm@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

On Fri, Mar 26, 2021 at 1:08 PM Geert Uytterhoeven
<geert+renesas@glider.be> wrote:
>
> The function names in the comment blocks for the functions
> scaling_available_frequencies_show() and
> scaling_boost_frequencies_show() do not match the actual names.
>
> Fixes: 6f19efc0a1ca08bc ("cpufreq: Add boost frequency support in core")
> Signed-off-by: Geert Uytterhoeven <geert+renesas@glider.be>
> ---
>  drivers/cpufreq/freq_table.c | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)
>
> diff --git a/drivers/cpufreq/freq_table.c b/drivers/cpufreq/freq_table.c
> index d3f756f7b5a0594c..67e56cf638efb86a 100644
> --- a/drivers/cpufreq/freq_table.c
> +++ b/drivers/cpufreq/freq_table.c
> @@ -267,7 +267,7 @@ struct freq_attr cpufreq_freq_attr_##_name##_freqs =     \
>  __ATTR_RO(_name##_frequencies)
>
>  /*
> - * show_scaling_available_frequencies - show available normal frequencies for
> + * scaling_available_frequencies_show - show available normal frequencies for
>   * the specified CPU
>   */
>  static ssize_t scaling_available_frequencies_show(struct cpufreq_policy *policy,
> @@ -279,7 +279,7 @@ cpufreq_attr_available_freq(scaling_available);
>  EXPORT_SYMBOL_GPL(cpufreq_freq_attr_scaling_available_freqs);
>
>  /*
> - * show_available_boost_freqs - show available boost frequencies for
> + * scaling_boost_frequencies_show - show available boost frequencies for
>   * the specified CPU
>   */
>  static ssize_t scaling_boost_frequencies_show(struct cpufreq_policy *policy,
> --

Applied as 5.12-rc material, thanks!
