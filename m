Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 22B5765D0F2
	for <lists+linux-pm@lfdr.de>; Wed,  4 Jan 2023 11:51:02 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239069AbjADKu7 (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Wed, 4 Jan 2023 05:50:59 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57972 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234915AbjADKuQ (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Wed, 4 Jan 2023 05:50:16 -0500
Received: from mail-pl1-x62d.google.com (mail-pl1-x62d.google.com [IPv6:2607:f8b0:4864:20::62d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 801691EED9
        for <linux-pm@vger.kernel.org>; Wed,  4 Jan 2023 02:47:38 -0800 (PST)
Received: by mail-pl1-x62d.google.com with SMTP id c2so7952712plc.5
        for <linux-pm@vger.kernel.org>; Wed, 04 Jan 2023 02:47:38 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=lo4CbDWH5rQIwpDKpsT7Ko0Jf4o5yka9XgE6kGYtScY=;
        b=QiaBnuPeKkJBwYIjMzCNBowVDp8QgcjrjJ0KT+pW6LV5/CS8tCnNRqgnlLp+gXFdR/
         M8oXnauTZunIjGN2ptjb6ww/O/ydLR91IXactsTfOPuoAqNPJmw2B3ZiC93kVJPPithR
         S8VGSnw663Qv2wL/4rDPAgPYU2nLc7CJVhbMnZXDZ9uyjORCNQhDRhSarCjFoKkStLhV
         SKxvUmz9mAd5PSvo8OHqIlQDq6IbFAQZ+lbauxnXf3XpF7rFznrmqqz838W7Amcznpj8
         ZnebbemQwRBp3WJbZ0DIrrOxpPcukbcd+DYjzssy2yAXyPsw2HlXnH+CxOd+naQdTxC+
         lzRQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=lo4CbDWH5rQIwpDKpsT7Ko0Jf4o5yka9XgE6kGYtScY=;
        b=R76BO6owA5GlA6K9qBC5W7xnl0EQwwrEPn3yo9c7GLenhQokvC0UvabfIGQbnSFpxH
         5d5aq90XdADlnaOPPmNl3AssiOOQVXfYmxnRcRsgMJb5Tj1wVmVy5oumRgQuo+vEk/Q5
         CzhVmvZzP7we634UXc7mzdKQ2+I4ggS/J8i0K7B2lftaSD2FeEmnRcc/+j13eNsRO0Ox
         0sAEoQwmofysswSk9jmdoO9lInu1ovpusnS1yszlWEVCtiQiSlI5sW+APBG2ZyI5cjzN
         l+8MBr4bcg+UBsNGJkqL6ktBP5I4O0EDi7nOyo3XLYIcrdBN3iXRJ14D98qMhqVl4rDK
         csaA==
X-Gm-Message-State: AFqh2kpp+DPFOeYQfEbKoQKxPLdPNOWpiY2Megea69NZWDaqPSnEWdwp
        M7zSZlTTj/98EY5GM0kiz1AH70KWlvSZEQa3
X-Google-Smtp-Source: AMrXdXs014YVXe/+fLfw+3f/kxOmWHIqGfpYnT+l5UhGAonPccuJD2WCMQ2+m+0wITEw4Q4lq+N1gQ==
X-Received: by 2002:a17:90a:cc0b:b0:219:5955:7570 with SMTP id b11-20020a17090acc0b00b0021959557570mr21849868pju.46.1672829241744;
        Wed, 04 Jan 2023 02:47:21 -0800 (PST)
Received: from localhost ([122.172.82.107])
        by smtp.gmail.com with ESMTPSA id z3-20020a17090a6d0300b00225daca646csm17289384pjj.34.2023.01.04.02.47.20
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 04 Jan 2023 02:47:21 -0800 (PST)
Date:   Wed, 4 Jan 2023 16:17:18 +0530
From:   Viresh Kumar <viresh.kumar@linaro.org>
To:     Hector Martin <marcan@marcan.st>
Cc:     "Rafael J. Wysocki" <rafael@kernel.org>,
        Sven Peter <sven@svenpeter.dev>,
        Alyssa Rosenzweig <alyssa@rosenzweig.io>,
        Marc Zyngier <maz@kernel.org>, asahi@lists.linux.dev,
        linux-arm-kernel@lists.infradead.org, linux-pm@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] cpufreq: apple-soc: Switch to the lowest frequency on
 suspend
Message-ID: <20230104104718.ppvvly4jpuufmknf@vireshk-i7>
References: <20230104102149.16263-1-marcan@marcan.st>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230104102149.16263-1-marcan@marcan.st>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

On 04-01-23, 19:21, Hector Martin wrote:
> Without this, the CPUs are left in a random pstate. Since we don't
> support deep idle yet (which powers down the CPUs), this results in
> significantly increased idle power consumption in suspend.
> 
> Fixes: 6286bbb40576 ("cpufreq: apple-soc: Add new driver to control Apple SoC CPU P-states")
> Signed-off-by: Hector Martin <marcan@marcan.st>
> ---
>  drivers/cpufreq/apple-soc-cpufreq.c | 2 ++
>  1 file changed, 2 insertions(+)
> 
> diff --git a/drivers/cpufreq/apple-soc-cpufreq.c b/drivers/cpufreq/apple-soc-cpufreq.c
> index d1801281cdd9..1b4e6c701860 100644
> --- a/drivers/cpufreq/apple-soc-cpufreq.c
> +++ b/drivers/cpufreq/apple-soc-cpufreq.c
> @@ -280,6 +280,7 @@ static int apple_soc_cpufreq_init(struct cpufreq_policy *policy)
>  	policy->cpuinfo.transition_latency = transition_latency;
>  	policy->dvfs_possible_from_any_cpu = true;
>  	policy->fast_switch_possible = true;
> +	policy->suspend_freq = freq_table[0].frequency;
>  
>  	if (policy_has_boost_freq(policy)) {
>  		ret = cpufreq_enable_boost_support();
> @@ -329,6 +330,7 @@ static struct cpufreq_driver apple_soc_cpufreq_driver = {
>  	.fast_switch	= apple_soc_cpufreq_fast_switch,
>  	.register_em	= cpufreq_register_em_with_opp,
>  	.attr		= apple_soc_cpufreq_hw_attr,
> +	.suspend	= cpufreq_generic_suspend,
>  };
>  
>  static int __init apple_soc_cpufreq_module_init(void)

Applied. Thanks.

-- 
viresh
