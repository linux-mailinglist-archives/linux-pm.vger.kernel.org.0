Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A57241ECAD0
	for <lists+linux-pm@lfdr.de>; Wed,  3 Jun 2020 09:52:05 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725888AbgFCHwE (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Wed, 3 Jun 2020 03:52:04 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50934 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725275AbgFCHwE (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Wed, 3 Jun 2020 03:52:04 -0400
Received: from mail-pf1-x436.google.com (mail-pf1-x436.google.com [IPv6:2607:f8b0:4864:20::436])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 12599C05BD43
        for <linux-pm@vger.kernel.org>; Wed,  3 Jun 2020 00:52:04 -0700 (PDT)
Received: by mail-pf1-x436.google.com with SMTP id j1so913002pfe.4
        for <linux-pm@vger.kernel.org>; Wed, 03 Jun 2020 00:52:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=r/WSOOgzKah1n7hh2oJZG/JFgX3kZ1eyc3n37SqQbvQ=;
        b=FnKoWR7RT8zK6PByUgH0+LGhcQmKt1grg2AvPgaaga/WlmpLgGnhAUb2SiK8pAq34n
         fVUqKqAXp2fimwkYQ4Bz9FN4F0MPN8jqiwJiim4n+PAfy/qX+SCeAvcGk0vHvdoeqtMp
         TgyP45XWLuCiDOigaq+k80TeuklEgj5PEb8f1ChyNTB7sMY6UI+Kj3nHUcW0P77mDum2
         bWoDmtW8iQhFgCOgRdXJoixndB2OaRjsuLl9TThhsUuXmHQr9VTEcsjatQPxV91bOw8i
         Rk5DFYMufWU2v8h0M+JUdDHbPIUwU+htVbEVgl8k8l7iq57Bqzl2Jrjx5Fxd/Il6nH9+
         tKzg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=r/WSOOgzKah1n7hh2oJZG/JFgX3kZ1eyc3n37SqQbvQ=;
        b=k3SStRunJyk0bmVCMSQjZ/wbRUomGTypEKJA6ownnaqSzT3uixurhpqBye5wvSeNlF
         V66QzkuVZqRx0cDy3jptUMzL3SHKuaDAYoodT/Qy6VelfUyhZqqIwEAqeGNLK+fiPZJG
         8hWKRpKQoPavEgRpVQSn4iAOUGvs7si0yOSZN0aurHjleE9st7ylcCFqHoxW4ZerEmWE
         ysv6CRY77pWCI9SWFqZ+eUPSKZj0zXH3P/1mmrtR9k+Dyg+jlrU6df2HV/wHPf+uMKyp
         5NBF+cKiNXIWiFAM0jZX/5RtvK2sIZLwPf5AkoaieENrV/iI43BKTEX7t5V9UXOKJTrK
         ylxw==
X-Gm-Message-State: AOAM5314FGMnetxsq56d9lkZrk72dSJ6dRzGKmuwDGjx6dgO8A/L3zUh
        O0FUFjzxbQgYIDoE9iGNQrhtrg==
X-Google-Smtp-Source: ABdhPJx9FLnXp46sE75jcDP06AhA8yH9xya7bs8ESIwmSWrpAkgdgtdF7M45DKCBnszLb5rTxGVwvg==
X-Received: by 2002:a17:90b:78b:: with SMTP id l11mr3995244pjz.97.1591170723258;
        Wed, 03 Jun 2020 00:52:03 -0700 (PDT)
Received: from localhost ([122.172.62.209])
        by smtp.gmail.com with ESMTPSA id j26sm1159884pfr.215.2020.06.03.00.52.01
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 03 Jun 2020 00:52:02 -0700 (PDT)
Date:   Wed, 3 Jun 2020 13:22:00 +0530
From:   Viresh Kumar <viresh.kumar@linaro.org>
To:     Xiongfeng Wang <wangxiongfeng2@huawei.com>
Cc:     rjw@rjwysocki.net, guohanjun@huawei.com, Sudeep.Holla@arm.com,
        ionela.voinescu@arm.com, linux-pm@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [Question]: about 'cpuinfo_cur_freq' shown in sysfs when the CPU
 is in idle state
Message-ID: <20200603075200.hbyofgcyiwocl565@vireshk-i7>
References: <f1773fdc-f6ef-ec28-0c0a-4a09e66ab63b@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <f1773fdc-f6ef-ec28-0c0a-4a09e66ab63b@huawei.com>
User-Agent: NeoMutt/20180716-391-311a52
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

On 02-06-20, 11:34, Xiongfeng Wang wrote:
> Hi Viresh,
> 
> Sorry to disturb you about another problem as follows.
> 
> CPPC use the increment of Desired Performance counter and Reference Performance
> counter to get the CPU frequency and show it in sysfs through
> 'cpuinfo_cur_freq'. But ACPI CPPC doesn't specifically define the behavior of
> these two counters when the CPU is in idle state, such as stop incrementing when
> the CPU is in idle state.
> 
> ARMv8.4 Extension inctroduced support for the Activity Monitors Unit (AMU). The
> processor frequency cycles and constant frequency cycles in AMU can be used as
> Delivered Performance counter and Reference Performance counter. These two
> counter in AMU does not increase when the PE is in WFI or WFE. So the increment
> is zero when the PE is in WFI/WFE. This cause no issue because
> 'cppc_get_rate_from_fbctrs()' in cppc_cpufreq driver will check the increment
> and return the desired performance if the increment is zero.
> 
> But when the CPU goes into power down idle state, accessing these two counters
> in AMU by memory-mapped address will return zero. Such as CPU1 went into power
> down idle state and CPU0 try to get the frequency of CPU1. In this situation,
> will display a very big value for 'cpuinfo_cur_freq' in sysfs. Do you have some
> advice about this problem ?
> 
> I was thinking about an idea as follows. We can run 'cppc_cpufreq_get_rate()' on
> the CPU to be measured, so that we can make sure the CPU is in C0 state when we
> access the two counters. Also we can return the actual frequency rather than
> desired performance when the CPU is in WFI/WFE. But this modification will
> change the existing logical and I am not sure if this will cause some bad effect.
> 
> 
> diff --git a/drivers/cpufreq/cppc_cpufreq.c b/drivers/cpufreq/cppc_cpufreq.c
> index 257d726..ded3bcc 100644
> --- a/drivers/cpufreq/cppc_cpufreq.c
> +++ b/drivers/cpufreq/cppc_cpufreq.c
> @@ -396,9 +396,10 @@ static int cppc_get_rate_from_fbctrs(struct cppc_cpudata *cpu,
>         return cppc_cpufreq_perf_to_khz(cpu, delivered_perf);
>  }
> 
> -static unsigned int cppc_cpufreq_get_rate(unsigned int cpunum)
> +static int cppc_cpufreq_get_rate_cpu(void *info)
>  {
>         struct cppc_perf_fb_ctrs fb_ctrs_t0 = {0}, fb_ctrs_t1 = {0};
> + unsigned int cpunum = *(unsigned int *)info;
>         struct cppc_cpudata *cpu = all_cpu_data[cpunum];
>         int ret;
> 
> @@ -418,6 +419,22 @@ static unsigned int cppc_cpufreq_get_rate(unsigned int cpunum)
>         return cppc_get_rate_from_fbctrs(cpu, fb_ctrs_t0, fb_ctrs_t1);
>  }
> 
> +static unsigned int cppc_cpufreq_get_rate(unsigned int cpunum)
> +{
> + unsigned int ret;
> +
> + ret = smp_call_on_cpu(cpunum, cppc_cpufreq_get_rate_cpu, &cpunum, true);
> +
> + /*
> +  * convert negative error code to zero, otherwise we will display
> +  * an odd value for 'cpuinfo_cur_freq' in sysfs
> +  */
> + if (ret < 0)
> +         ret = 0;
> +
> + return ret;
> +}
> +
>  static int cppc_cpufreq_set_boost(struct cpufreq_policy *policy, int state)
>  {
>         struct cppc_cpudata *cpudata;

I don't see any other sane solution, even if this brings the CPU back
to normal state and waste power. We should be able to reliably provide
value to userspace.

Rafael / Sudeep: What you do say ?

-- 
viresh
