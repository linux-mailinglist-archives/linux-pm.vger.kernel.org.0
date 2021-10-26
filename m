Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 321C643B38D
	for <lists+linux-pm@lfdr.de>; Tue, 26 Oct 2021 16:03:36 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235206AbhJZOF5 (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Tue, 26 Oct 2021 10:05:57 -0400
Received: from mail-oi1-f169.google.com ([209.85.167.169]:36717 "EHLO
        mail-oi1-f169.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230119AbhJZOFz (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Tue, 26 Oct 2021 10:05:55 -0400
Received: by mail-oi1-f169.google.com with SMTP id q124so2023044oig.3
        for <linux-pm@vger.kernel.org>; Tue, 26 Oct 2021 07:03:31 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=OzpwedzMOKOOs2Lj84TYRb3SlBKhFSU3i1WuT4zBS2o=;
        b=EVCbqV2mII/FAO3clLkSx1GzDMm1N3ShEYGhsGV8zPnlEvsTkJnMhE/ilPNJNwk9DG
         KI+cOf8+Yg3TCp3iL8JcR4zUxMzjfUXpCr7vvvpFHSBOPJObNSHBgO+/RSCnKwlIEiVZ
         CgEZkOVO5tEFBYja41chIxFhfToTHDd7guz/2Pm1/XQSW/A7M1U+OQJiGbffQGVQzs/F
         jKk7CqPuWqPa/myjls66XUpZKmnBkH7OfVMr0qGGuoV1lg9lzuH0XxzPy0JZjqSqAkHh
         HuCXPB7kUrZpKSMqNpIP7iM6Y6iUr1My90Rz8dkvqOO5mcxdh5KVLh8a7Yypsjzq9NFw
         Ivbg==
X-Gm-Message-State: AOAM533RDeRat5bljHx/1ji3my4gM6Y9NwyIIMsu5RQqjzGrhsKIgqAh
        QXm3Bc5mm2ByvquIfkwGHyXyeCUphUZRHno51+qW3ui5
X-Google-Smtp-Source: ABdhPJx5gQSfMqPqucm/IYgoeoTXx62UCZGjOPcTNCqwbeh/QdJHN3JT2daTgokwvGSqQc7pw0hztz6uXF6x8K13oGo=
X-Received: by 2002:a05:6808:e90:: with SMTP id k16mr5868719oil.166.1635257011357;
 Tue, 26 Oct 2021 07:03:31 -0700 (PDT)
MIME-Version: 1.0
References: <20211026083242.27472-1-rui.zhang@intel.com>
In-Reply-To: <20211026083242.27472-1-rui.zhang@intel.com>
From:   "Rafael J. Wysocki" <rafael@kernel.org>
Date:   Tue, 26 Oct 2021 16:03:20 +0200
Message-ID: <CAJZ5v0gujt5g9D+L+zxB0XbnvtoyhkDy8MytHAc-Jcqy+3Oq9g@mail.gmail.com>
Subject: Re: [PATCH] cpufreq: intel_pstate: Fix cpu->pstate.turbo_freq initialization
To:     Zhang Rui <rui.zhang@intel.com>
Cc:     Linux PM <linux-pm@vger.kernel.org>,
        "Rafael J. Wysocki" <rjw@rjwysocki.net>,
        Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

On Tue, Oct 26, 2021 at 10:17 AM Zhang Rui <rui.zhang@intel.com> wrote:
>
> Fix a problem in active mode that cpu->pstate.turbo_freq is initialized
> only if HWP-to-frequency scaling factor is refined.
>
> In passive mode, this problem is not exposed, because
> cpu->pstate.turbo_freq is set again, later in
> intel_cpufreq_cpu_init()->intel_pstate_get_hwp_cap().
>
> Fixes: eb3693f0521e ("cpufreq: intel_pstate: hybrid: CPU-specific scaling factor")
> Signed-off-by: Zhang Rui <rui.zhang@intel.com>
> ---
>  drivers/cpufreq/intel_pstate.c | 3 ++-
>  1 file changed, 2 insertions(+), 1 deletion(-)
>
> diff --git a/drivers/cpufreq/intel_pstate.c b/drivers/cpufreq/intel_pstate.c
> index 8c176b7dae41..fc7a429f22d3 100644
> --- a/drivers/cpufreq/intel_pstate.c
> +++ b/drivers/cpufreq/intel_pstate.c
> @@ -537,7 +537,8 @@ static void intel_pstate_hybrid_hwp_adjust(struct cpudata *cpu)
>          * scaling factor is too high, so recompute it to make the HWP_CAP
>          * highest performance correspond to the maximum turbo frequency.
>          */
> -       if (turbo_freq < cpu->pstate.turbo_pstate * scaling) {
> +       cpu->pstate.turbo_freq = cpu->pstate.turbo_pstate * scaling;
> +       if (turbo_freq < cpu->pstate.turbo_freq) {
>                 cpu->pstate.turbo_freq = turbo_freq;
>                 scaling = DIV_ROUND_UP(turbo_freq, cpu->pstate.turbo_pstate);
>                 cpu->pstate.scaling = scaling;
> --

Applied as 5.16 material, thanks!
