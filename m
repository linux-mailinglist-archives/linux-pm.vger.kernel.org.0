Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E2C041B42DA
	for <lists+linux-pm@lfdr.de>; Wed, 22 Apr 2020 13:11:06 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726328AbgDVLLF (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Wed, 22 Apr 2020 07:11:05 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42918 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-FAIL-OK-FAIL)
        by vger.kernel.org with ESMTP id S1726208AbgDVLLD (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Wed, 22 Apr 2020 07:11:03 -0400
Received: from mail-pf1-x443.google.com (mail-pf1-x443.google.com [IPv6:2607:f8b0:4864:20::443])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6A4A7C03C1A8
        for <linux-pm@vger.kernel.org>; Wed, 22 Apr 2020 04:11:03 -0700 (PDT)
Received: by mail-pf1-x443.google.com with SMTP id x15so906613pfa.1
        for <linux-pm@vger.kernel.org>; Wed, 22 Apr 2020 04:11:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc;
        bh=ZRUvq1lpAB/ul32d5fdGyDclWnO9sfK04iOHOtl+foE=;
        b=NaUqel5GHk4qiBnc4LG2+ZA69rvdL+DQ0rSn/BrUat3jaiydxGwK0Qr4D3mQEM98Ez
         /ylDunIOOrRwccsE6IU0uq33EElo5eeYGl7cy3NUexeHTK9NQ9wGT1PE2hvjhVbPSsuT
         GEWMTp7xnY9g4+cifktpG9SqLLT57xp1uL48XQT2AZGC7G/YTi0pwzz36aSQAIKWuele
         tyY8SCMOKOvVrtQBlpfzPbw7MT/HV0C47D7Kibz8beCGUL6lauU4JtGei/YWItEFYQfX
         FM7vpQXb1oE64Q+UpITxybZWMcmfF1WR8URvNujchDYdx8RTiJbLTpNpNLARcPLcJjQs
         r6Vw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc;
        bh=ZRUvq1lpAB/ul32d5fdGyDclWnO9sfK04iOHOtl+foE=;
        b=DvDFP+pLwntsH1LPJKNSuBltZ9QYLkujqP4z/MYjjxAvxmtH/DqHCKUNMx5Kjf8ruA
         D/wKoBa51ld7nLOOOst9mrBaCLTRymBUY9wF0tc6Rs+cFFCQ+qngxohaSFkSotoUgVzH
         /hD+jUwPDbvR5Ntd6nDgZwI/QbUr9Fe/nOlpW9aVVN64ypvjVmTcVPmyEHUbLF0UZGMp
         QlE2ShpBxnTDwmLkev7aRWw13Kj2R/sWPPIQQwCNKrC2Wonc5NHII3jENYcckqlWofxu
         MfQQyFEBtN1H/Dj9J846a1BVVMkca9a0QrwYE21Hm1UqFO8JjHtDdZTq1DLhjZlk/Qc/
         btTQ==
X-Gm-Message-State: AGi0PuaWJ7ByXztCVu3njaUmsxzPq7oPJx8ecXgB3j0uJZaBnUHfQ6q4
        AVBsDfeiQCYgdXno5HIIT7u62uMAYOniaaVOvzc=
X-Google-Smtp-Source: APiQypJ0fs4MAcocoZkUcI49V3guHSr9arkKcGnRek0duwAfXsCICstatMc81yK24TOlITClYRUMJqTr38h8xydq6SI=
X-Received: by 2002:a63:5125:: with SMTP id f37mr25831887pgb.327.1587553862991;
 Wed, 22 Apr 2020 04:11:02 -0700 (PDT)
MIME-Version: 1.0
Received: by 2002:a17:90a:2129:0:0:0:0 with HTTP; Wed, 22 Apr 2020 04:11:02
 -0700 (PDT)
In-Reply-To: <CANO_MSJdi_12=OV4mOju9M0dDc1Sd4daZJ1WBXM1A++XKqBLgQ@mail.gmail.com>
References: <1587365320-25222-1-git-send-email-gao.yunxiao6@gmail.com>
 <20200422080439.kkpl7xmaawkxu5re@vireshk-i7> <CANO_MSLwA6PWEqGEbj50y98TR=trqddENQ6Qcne5edvf1oi9jg@mail.gmail.com>
 <20200422095433.br2zgpzm7f66ydhi@vireshk-i7> <CANO_MSJdi_12=OV4mOju9M0dDc1Sd4daZJ1WBXM1A++XKqBLgQ@mail.gmail.com>
From:   gao yunxiao <gao.yunxiao6@gmail.com>
Date:   Wed, 22 Apr 2020 19:11:02 +0800
Message-ID: <CANO_MSK28MgNM8ohXaoONQa69bM2Nz1N8Rh8t53peQ9kboT6Xg@mail.gmail.com>
Subject: Re: [PATCH 1/2] thermal/drivers/cpufreq_cooling: Add platform
 callback functions
To:     Viresh Kumar <viresh.kumar@linaro.org>
Cc:     daniel.lezcano@linaro.org, amit.kachhap@gmail.com,
        javi.merino@kernel.org, linux-pm@vger.kernel.org,
        kernel-team@android.com, orsonzhai@gmail.com, zhang.lyra@gmail.com,
        Jeson Gao <jeson.gao@unisoc.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

On 22/04/2020, gao yunxiao <gao.yunxiao6@gmail.com> wrote:
> viresh
>
> On UNISOC platform, CPU's temperature can not be controlled when
> cpufreq has been limited to the lowest frequency, we have to hotplug
> out CPUS to mitigate temperature rising.
>
> adding platform callback to have a chance to check whether the
> normalised power at power2state() is lower than the power
> corresponding to the lowest frequency. provide an example in another
> patch
> +static int sprd_cpufreq_cpu_ctrl(struct cpufreq_policy *policy,
> +                                u32 load, u32 normalised_power,
> +                                u32 freq_power)
> +{
> +       unsigned int ncpus, online_cpus;
> +
> +       ncpus = cpumask_weight(policy->related_cpus);
> +       online_cpus = cpumask_weight(policy->cpus);
> +
> +       if (normalised_power <  freq_power)
> +               sprd_estimate_down_cpus(policy, load,
> +                                       normalised_power, freq_power);
> +       else if (online_cpus < ncpus)
> +               sprd_estimate_up_cpus(policy, load,
> +                                     normalised_power, freq_power);
> +       else
> +               sprd_keep_cpus(policy);
> +
> +       return 0;
> +}
>
> On 22/04/2020, Viresh Kumar <viresh.kumar@linaro.org> wrote:
>> On 22-04-20, 17:53, gao yunxiao wrote:
>>> viresh
>>>
>>> Thank you very much for your advice.
>>>
>>> In here, only check whether the frequency point given by cpu_cooling
>>> module is the minimum frequency point.
>>
>> I am not sure I understood what you are doing here. Please elaborate a
>> bit.
>>
>> --
>> viresh
>>
>
