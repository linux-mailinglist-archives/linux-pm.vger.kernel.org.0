Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 34A5821099C
	for <lists+linux-pm@lfdr.de>; Wed,  1 Jul 2020 12:46:28 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730088AbgGAKqZ (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Wed, 1 Jul 2020 06:46:25 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44164 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730078AbgGAKqX (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Wed, 1 Jul 2020 06:46:23 -0400
Received: from mail-pl1-x642.google.com (mail-pl1-x642.google.com [IPv6:2607:f8b0:4864:20::642])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BB3A1C03E979
        for <linux-pm@vger.kernel.org>; Wed,  1 Jul 2020 03:46:23 -0700 (PDT)
Received: by mail-pl1-x642.google.com with SMTP id bj10so4532951plb.11
        for <linux-pm@vger.kernel.org>; Wed, 01 Jul 2020 03:46:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=7Oexly+v8/VyUxxogdFbxPaQRY4n7smy/8rwZyOuOiI=;
        b=u3heF6GnAihYtVpndilxFGhT6MfcJXu//ppNokEx3psd/wgpHMwhk+YZHMgJaHp8if
         nDMuNIeWsG2ZboyPHQFyQ/3mV/BwZR3rv8ijiJjHdj4IC08kd2eZASQYrxh43G2vEwUo
         hSmvdu/ehyCNzOXQuQvsG14Nmx6ef86c30g5soeKD1/m9GI7bX43tQTYYr21E0tc66fX
         qBxD2KFRWJb6fRE1etJERxF8/eQKndEn0pM5q51k/zJM1Ix3mO7SW6Y9MJapKbm9esdj
         i7esad0QCGmmkZiCP8MxT3ZRQzX4+/UZMr6FWcJQZ/aDTOtJpY/VxJSukB6uOd5IKmrz
         xi4w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=7Oexly+v8/VyUxxogdFbxPaQRY4n7smy/8rwZyOuOiI=;
        b=YXpLSaxOzs5COSkcHecj7DanmRPukhy9dt209SfQvJXMJfWwmPplchyzlWtqp8gTfY
         XBFOf0/H/NjT8A6HHMlXcJ3VTnNmVpXV+8mtEcHfpXu4JyVGIepmvrubwqC5v6ox6nTE
         /I5/rq6nSXOADXuecUjjLi4pi2XXXWY0d2UbmE0N1BZz8FkksU7laH1jafgsNlowILwJ
         18vnQM8H+JC4dvmoq+NrL9e1KsExiv0jjnsYo5Zy6ZenrcqqbTh5nRv9eqQVQOoyOqW+
         9q09W62vFFVMCjxHPovqdZAP9tzIvv6L8Uy767IZekmsgbrRZHgKx4opCv0sdxtl+nOI
         Ptow==
X-Gm-Message-State: AOAM530TEN2qV8Tw8YB1Xhty7TiKtq1i/RHqqzE/cZZb69p4pr3zrQ1h
        A2bd643bURopz5yjUmwzyIXGtg==
X-Google-Smtp-Source: ABdhPJxv4rvEJmK7v4WKFNzdWQMYkJjXtEZFO3i2cDVfQvJAhWvFR+HWST3bxqUbfPbN35XKrSn3Ww==
X-Received: by 2002:a17:902:8c92:: with SMTP id t18mr21436052plo.196.1593600383271;
        Wed, 01 Jul 2020 03:46:23 -0700 (PDT)
Received: from localhost ([122.172.81.75])
        by smtp.gmail.com with ESMTPSA id n1sm5001453pjn.24.2020.07.01.03.46.21
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 01 Jul 2020 03:46:22 -0700 (PDT)
Date:   Wed, 1 Jul 2020 16:16:19 +0530
From:   Viresh Kumar <viresh.kumar@linaro.org>
To:     Ionela Voinescu <ionela.voinescu@arm.com>
Cc:     rjw@rjwysocki.net, catalin.marinas@arm.com, sudeep.holla@arm.com,
        will@kernel.org, linux@armlinux.org.uk, valentin.schneider@arm.com,
        mingo@redhat.com, peterz@infradead.org, dietmar.eggemann@arm.com,
        linux-pm@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org, Liviu Dudau <liviu.dudau@arm.com>
Subject: Re: [PATCH 4/8] cpufreq,vexpress-spc: fix Frequency Invariance (FI)
 for bL switching
Message-ID: <20200701095414.2wjcnyhndgcedk2q@vireshk-i7>
References: <20200701090751.7543-1-ionela.voinescu@arm.com>
 <20200701090751.7543-5-ionela.voinescu@arm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200701090751.7543-5-ionela.voinescu@arm.com>
User-Agent: NeoMutt/20180716-391-311a52
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

On 01-07-20, 10:07, Ionela Voinescu wrote:
> In the majority of cases, the index argument to cpufreq's target_index()
> is meant to identify the frequency that is requested from the hardware,
> according to the frequency table: policy->freq_table[index].frequency.
> 
> After successfully requesting it from the hardware, this value, together
> with the maximum hardware frequency (policy->cpuinfo.max_freq) are used
> as arguments to arch_set_freq_scale(), in order to set the task scheduler
> frequency scale factor. This is a normalized indication of a CPU's
> current performance.
> 
> But for the vexpress-spc-cpufreq driver, when big.LITTLE switching [1]
> is enabled, there are three issues with using the above information for
> setting the FI scale factor:
> 
>  - cur_freq: policy->freq_table[index].frequency is not the frequency
>    requested from the hardware. ve_spc_cpufreq_set_rate() will convert
>    from this virtual frequency to an actual frequency, which is then
>    requested from the hardware. For the A7 cluster, the virtual frequency
>    is half the actual frequency. The use of the virtual policy->freq_table
>    frequency results in an incorrect FI scale factor.
> 
>  - max_freq: policy->cpuinfo.max_freq does not correctly identify the
>    maximum frequency of the physical cluster. This value identifies the
>    maximum frequency achievable by the big-LITTLE pair, that is the
>    maximum frequency of the big CPU. But when the LITTLE CPU in the group
>    is used, the hardware maximum frquency passed to arch_set_freq_scale()
>    is incorrect.
> 
>  - missing a scale factor update: when switching clusters, the driver
>    recalculates the frequency of the old clock domain based on the
>    requests of the remaining CPUs in the domain and asks for a clock
>    change. But this does not result in an update in the scale factor.
> 
> Therefore, introduce a local function bLs_set_sched_freq_scale() that
> helps call arch_set_freq_scale() with correct information for the
> is_bL_switching_enabled() case, while maintaining the old, more
> efficient, call site of arch_set_freq_scale() for when cluster
> switching is disabled.
> 
> Also, because of these requirements in computing the scale factor, this
> driver is the only one that maintains custom support for FI, which is
> marked by the presence of the CPUFREQ_CUSTOM_SET_FREQ_SCALE flag.
> 
> [1] https://lwn.net/Articles/481055/
> 
> Signed-off-by: Ionela Voinescu <ionela.voinescu@arm.com>
> Cc: Viresh Kumar <viresh.kumar@linaro.org>
> Cc: Sudeep Holla <sudeep.holla@arm.com>
> Cc: Rafael J. Wysocki <rjw@rjwysocki.net>
> Cc: Liviu Dudau <liviu.dudau@arm.com>
> ---
>  drivers/cpufreq/vexpress-spc-cpufreq.c | 23 ++++++++++++++++++++++-
>  1 file changed, 22 insertions(+), 1 deletion(-)

Is there anyone who cares for this driver and EAS ? I will just skip doing the
FIE thing here and mark it skipped.

-- 
viresh
