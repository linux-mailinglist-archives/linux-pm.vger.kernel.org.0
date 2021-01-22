Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D5A2F300839
	for <lists+linux-pm@lfdr.de>; Fri, 22 Jan 2021 17:09:11 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729461AbhAVQH1 (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Fri, 22 Jan 2021 11:07:27 -0500
Received: from mail-ot1-f53.google.com ([209.85.210.53]:45644 "EHLO
        mail-ot1-f53.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729408AbhAVQHU (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Fri, 22 Jan 2021 11:07:20 -0500
Received: by mail-ot1-f53.google.com with SMTP id n42so5505335ota.12;
        Fri, 22 Jan 2021 08:07:05 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=QYkRYnREnsaoy26u+xFFqCYy/dFfndRZVMIwAMnpr9s=;
        b=I9GerIBaiL+7qVpAW+TyGY7mF2+jHFbix8C4QGUFZLB6UfrrSRPeoTBMrZy+kzaNMD
         LCtFiFOlq8upkXBGqf+8Q1x+X51FGSGkUB4c5KtnbfoQdoDkzEuG9TLsF5DWtlVBQyTD
         mYQtfAf56EGaVFMK+yG7/qgGAjn2c7F8GOjn458xkJKPdp+UFkc7XPT0hujC6GgNnIFO
         Z5aSVpTPyO2kUQPehPl99YEMpi8jGh+0of0JCarwLu//MKau5qR5of82CR8IF+F6wewu
         rpbi2p3FapzxOgZ0qBm/ohSKYkJNw8KJbKYqbVHpzTLd0mPtPBcRuLFT8dsqq+Stkwyu
         hp6g==
X-Gm-Message-State: AOAM533qAZ7y4ZR5NrKnAVl02ChwkWJOhz+skSjRUXIuPpY0WJAeeIwa
        FZx7MvbjNjjcAqrIci4txb9M5Chrr52eySsmVkHMyHZQ
X-Google-Smtp-Source: ABdhPJyMcjSUb80rzcyu7DxoBvjsmx1VIY7g/MTuzzLrCzFhHfvDRm60ldDzmDaxZVKzAzduIMKMXob3h1IISRMJ0ew=
X-Received: by 2002:a05:6830:2313:: with SMTP id u19mr642634ote.321.1611331599132;
 Fri, 22 Jan 2021 08:06:39 -0800 (PST)
MIME-Version: 1.0
References: <20210117004705.GA10789@fedora>
In-Reply-To: <20210117004705.GA10789@fedora>
From:   "Rafael J. Wysocki" <rafael@kernel.org>
Date:   Fri, 22 Jan 2021 17:06:28 +0100
Message-ID: <CAJZ5v0h7VN9-uKZPPBJ3wuRRLJpCN5EjLKFM++DcCi3fU2zwzw@mail.gmail.com>
Subject: Re: [PATCH] cpufreq: intel_pstate: Remove repeated word
To:     Nigel Christian <nigel.l.christian@gmail.com>
Cc:     Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>,
        Len Brown <lenb@kernel.org>,
        "Rafael J. Wysocki" <rjw@rjwysocki.net>,
        Viresh Kumar <viresh.kumar@linaro.org>,
        Linux PM <linux-pm@vger.kernel.org>,
        kernel-janitors@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

On Sun, Jan 17, 2021 at 1:48 AM Nigel Christian
<nigel.l.christian@gmail.com> wrote:
>
> In the comment for trace in passive mode there is an
> unnecessary "the". Eradicate it.
>
> Signed-off-by: Nigel Christian <nigel.l.christian@gmail.com>
> ---
>  drivers/cpufreq/intel_pstate.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/drivers/cpufreq/intel_pstate.c b/drivers/cpufreq/intel_pstate.c
> index 6f2ff2775664..5175ae3cac44 100644
> --- a/drivers/cpufreq/intel_pstate.c
> +++ b/drivers/cpufreq/intel_pstate.c
> @@ -2498,7 +2498,7 @@ static int intel_cpufreq_verify_policy(struct cpufreq_policy_data *policy)
>   * driver call was via the normal or fast switch path. Various graphs
>   * output from the intel_pstate_tracer.py utility that include core_busy
>   * (or performance or core_avg_perf) have a fixed y-axis from 0 to 100%,
> - * so we use 10 to indicate the the normal path through the driver, and
> + * so we use 10 to indicate the normal path through the driver, and
>   * 90 to indicate the fast switch path through the driver.
>   * The scaled_busy field is not used, and is set to 0.
>   */
> --

Applied as 5.12 material, thanks!
