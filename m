Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 622075F9862
	for <lists+linux-pm@lfdr.de>; Mon, 10 Oct 2022 08:32:41 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231327AbiJJGck (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Mon, 10 Oct 2022 02:32:40 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44894 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230500AbiJJGcj (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Mon, 10 Oct 2022 02:32:39 -0400
Received: from mail-pf1-x435.google.com (mail-pf1-x435.google.com [IPv6:2607:f8b0:4864:20::435])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6D85956034
        for <linux-pm@vger.kernel.org>; Sun,  9 Oct 2022 23:32:38 -0700 (PDT)
Received: by mail-pf1-x435.google.com with SMTP id i3so9951290pfk.9
        for <linux-pm@vger.kernel.org>; Sun, 09 Oct 2022 23:32:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=NgaF+gMva8dckm9CLf90aqiI0duPSDPY/OWDay53LhA=;
        b=h/ozjNeq00sDI5b17bBXSXNxfX5R410nyrQDJEDyTd+STmDSkJ7zWtqBrIzfyq5eYA
         WrsyDylLFbELG0PecO+UZOkJhTFF5qDv/AXs4Cgkz9jfHIQZCm/8B+RLVM3w7wffHsEh
         gptVbcCRalaYxof0u5ln9E3Qh8ssaZjGpOd9ADyxJPa08Q2jHIA4N1UKswI1NlVP12+5
         iaL9sD4cEeitHFXquQ3fdsLTM93J8G6rteEv8nef7AXdX8aqk0ct5WcqXeef5MjsmF6N
         zyPZFtVqbAVFG+Nl6sw09i7G8tautiVvJ3s9aYgJSegorGlRKrpdaNG2TM+2pBCHTy/v
         cyiQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=NgaF+gMva8dckm9CLf90aqiI0duPSDPY/OWDay53LhA=;
        b=4WnXAmSYM/QrQQjJuEyMRyZj5lkMIkrbHq+sRociCIpOUpCiTqEHm6ciUp0+G9wJUe
         4lnNxLfD3tZq1J4aNIVApgknspyUIx9nm+qFSUBqZVs5aU0tpI0liKdT59TOx/1Hcdvd
         u2+xD6iMxjpg+bsPdbLWbzXfENFaQmq6rfdChyXwU4j8PZmhDXBqQpE5qOkcD2Ouc6MR
         mcSpIixZinqPlVMb7vm5H4qQLLTk1oNGNZfqVtoN1OR/3qnLZoG28tQ0haFbFvIp+sCy
         JbuoNzdUPQkCMIyPD1mQr/E/8U8ctnHn3EtXY2uHT/N+e2IIk4uehzoHuJiBADcSxSz6
         6bqQ==
X-Gm-Message-State: ACrzQf01woVSC8/RTt7GIvLkvQHUREfbRpk0oVwsaDERXoi+j3cyeM70
        h8QNOnTPB9NcQyqAPEGlF+pxXQ==
X-Google-Smtp-Source: AMsMyM7J/bEwOj7yGx70aukfr/e/FzNuGCgyz+iPALe/bAxPUxcbk1gnFh0dngeWQ47/5vEiL4VedA==
X-Received: by 2002:aa7:9218:0:b0:560:f3f1:d2d4 with SMTP id 24-20020aa79218000000b00560f3f1d2d4mr18225900pfo.14.1665383557970;
        Sun, 09 Oct 2022 23:32:37 -0700 (PDT)
Received: from localhost ([122.172.86.128])
        by smtp.gmail.com with ESMTPSA id j6-20020a170903024600b00178a9b193cfsm5774220plh.140.2022.10.09.23.32.36
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 09 Oct 2022 23:32:37 -0700 (PDT)
Date:   Mon, 10 Oct 2022 12:02:35 +0530
From:   Viresh Kumar <viresh.kumar@linaro.org>
To:     hongchengwen <hongchengwen@oppo.com>
Cc:     rafael@kernel.org, linux-pm@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        zhengding chen <chenzhengding@oppo.com>
Subject: Re: [PATCH] ANDROID: cpufreq: times: record fast switch frequency
 transitions
Message-ID: <20221010063235.3zb6bgtxwpmltlrk@vireshk-i7>
References: <1665231397-115755-1-git-send-email-hongchengwen@oppo.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1665231397-115755-1-git-send-email-hongchengwen@oppo.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

On 08-10-22, 20:16, hongchengwen wrote:
> From: zhengding chen <chenzhengding@oppo.com>
> 
> cpufreq_times_record_transition() is not called when fast switch is
> enabled, leading /proc/[pid]/time_in_state to attribute all time on a
> cluster to a single frequency. To fix this, add a call to
> cpufreq_times_record_transition() in the fast switch path.
> 
> Test: /proc/[pid]/time_in_state shows times for more than one freq per
> cluster
> 
> Bug: 204726690
> Signed-off-by: zhengding chen <chenzhengding@oppo.com>
> ---
>  drivers/cpufreq/cpufreq.c | 1 +
>  1 file changed, 1 insertion(+)
> 
> diff --git a/drivers/cpufreq/cpufreq.c b/drivers/cpufreq/cpufreq.c
> index 69b3d61..1caaf63 100644
> --- a/drivers/cpufreq/cpufreq.c
> +++ b/drivers/cpufreq/cpufreq.c
> @@ -2128,6 +2128,7 @@ unsigned int cpufreq_driver_fast_switch(struct cpufreq_policy *policy,
>         arch_set_freq_scale(policy->related_cpus, freq,
>                             policy->cpuinfo.max_freq);
>         cpufreq_stats_record_transition(policy, freq);
> +       cpufreq_times_record_transition(policy, freq);
> 
>         if (trace_cpu_frequency_enabled()) {
>                 for_each_cpu(cpu, policy->cpus)

zhengding chen,

You have sent your email to linux kernel lists, which don't have the
same code base as Android. Please send your patch to the relevant
lists/gerrit for Android.

Thanks.

-- 
viresh
