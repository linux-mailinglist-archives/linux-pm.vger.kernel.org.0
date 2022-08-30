Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D8DA95A5B29
	for <lists+linux-pm@lfdr.de>; Tue, 30 Aug 2022 07:34:24 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229659AbiH3FeW (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Tue, 30 Aug 2022 01:34:22 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51968 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229591AbiH3FeV (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Tue, 30 Aug 2022 01:34:21 -0400
Received: from mail-pl1-x632.google.com (mail-pl1-x632.google.com [IPv6:2607:f8b0:4864:20::632])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7ECC09E6A0
        for <linux-pm@vger.kernel.org>; Mon, 29 Aug 2022 22:34:20 -0700 (PDT)
Received: by mail-pl1-x632.google.com with SMTP id jm11so10039430plb.13
        for <linux-pm@vger.kernel.org>; Mon, 29 Aug 2022 22:34:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc;
        bh=cwSBr2h4OiE+kR2d/zytgkkxH2nVR6e5Ml0P+brWa7w=;
        b=izwFkQCjgHh98pqhta5QMnPqwogQkPuXt4vwuuPnviLbBfeTDPELCS7HBIfwOSdFfZ
         SWxq9/4B9OIQCJX6T6hkrdu8OQrdpmP9vpuWju6X7kncF4rpSAiwpqPNKVpmU6DLgCf4
         aVv8l81q6NkWHuJFtlkjS6TTHqyPfQq43j2FJz8JYMzkpjJ3d/iAsgAXOD5DqIshsxzp
         hKAgLgQMXX/e2ayWDoEsHzicmoCDNG2/fp3MK/VqRTlVKus2YczLd+8Ykenonva6g4jB
         DfKKGHhAKoDYPR3Iu2jRvlwhVmdTYKxGJ+nVuQxGD/R1xdQej7AtFHXwrO8s4h3jLGtC
         U9Nw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc;
        bh=cwSBr2h4OiE+kR2d/zytgkkxH2nVR6e5Ml0P+brWa7w=;
        b=3r9IksHkCOndOoWqdIGbD6MbaeMvUfnO8ZnzGWCHvMZZwrfmSnS4QQy9gjfGLbdJXf
         aYjTUW1j6v0wpemcni1AY7+E1buXMuv0/UXOn3Xz0X+TSg2l1tRupLlW7yvtnuzBH5dy
         nW/lcWW6l+nFO3LlETwd15qau85K/xwkQBJZJehwC1MzhaPwd8mQ+Oh6totsdyQNTaCF
         ePyB7QnCehAyboLrQUOA8lXPSl5kxuRRtuQV8VRQNsR4Qm4act8Dj2rH8q40LYsbDFfi
         AIkcIc+YSdGjS0E3enYKw7+KLufcHDGLD2LGsyGnl3mM5K9OZykwttg6DGhJm9Tq9gV/
         QF1g==
X-Gm-Message-State: ACgBeo023sPjs+406BImjx6mvjRNPDq2VFDeuhq9mpszQp5Dg0KHsyhu
        DfKYeRYBAsSwxoP2PD0prrHKng==
X-Google-Smtp-Source: AA6agR5r9/cuTJggQxaSA6iBk8vx7A4+KxmBY77FiZVjd+KTv4ZIoX2+8GOjyJ9o+7++NfiXrWSgcQ==
X-Received: by 2002:a17:902:9b85:b0:16e:cc02:b9b2 with SMTP id y5-20020a1709029b8500b0016ecc02b9b2mr19813668plp.74.1661837660055;
        Mon, 29 Aug 2022 22:34:20 -0700 (PDT)
Received: from localhost ([122.171.18.80])
        by smtp.gmail.com with ESMTPSA id x10-20020a170902ec8a00b0016c0c82e85csm8664633plg.75.2022.08.29.22.34.18
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 29 Aug 2022 22:34:19 -0700 (PDT)
Date:   Tue, 30 Aug 2022 11:04:17 +0530
From:   Viresh Kumar <viresh.kumar@linaro.org>
To:     Xuewen Yan <xuewen.yan@unisoc.com>
Cc:     lukasz.luba@arm.com, amit.kachhap@gmail.com,
        daniel.lezcano@linaro.org, rafael@kernel.org, amitk@kernel.org,
        rui.zhang@intel.com, linux-pm@vger.kernel.org,
        linux-kernel@vger.kernel.org, xuewen.yan94@gmail.com,
        di.shen@unisoc.com
Subject: Re: [PATCH] thermal: Check the policy first in
 cpufreq_cooling_register
Message-ID: <20220830053417.eebsc6joyvlpti3s@vireshk-i7>
References: <20220825114018.1715-1-xuewen.yan@unisoc.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220825114018.1715-1-xuewen.yan@unisoc.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

On 25-08-22, 19:40, Xuewen Yan wrote:
> Since the policy needs to be accessed first when obtaining cpu devices,
> first check whether the policy is legal before this.
> 
> Signed-off-by: Xuewen Yan <xuewen.yan@unisoc.com>

Fixes: 5130802ddbb1 ("thermal: cpu_cooling: Switch to QoS requests for freq limits")

> ---
>  drivers/thermal/cpufreq_cooling.c | 10 +++++-----
>  1 file changed, 5 insertions(+), 5 deletions(-)
> 
> diff --git a/drivers/thermal/cpufreq_cooling.c b/drivers/thermal/cpufreq_cooling.c
> index b76293cc989c..7838b6e2dba5 100644
> --- a/drivers/thermal/cpufreq_cooling.c
> +++ b/drivers/thermal/cpufreq_cooling.c
> @@ -501,17 +501,17 @@ __cpufreq_cooling_register(struct device_node *np,
>  	struct thermal_cooling_device_ops *cooling_ops;
>  	char *name;
>  
> +	if (IS_ERR_OR_NULL(policy)) {
> +		pr_err("%s: cpufreq policy isn't valid: %p\n", __func__, policy);
> +		return ERR_PTR(-EINVAL);
> +	}
> +
>  	dev = get_cpu_device(policy->cpu);
>  	if (unlikely(!dev)) {
>  		pr_warn("No cpu device for cpu %d\n", policy->cpu);
>  		return ERR_PTR(-ENODEV);
>  	}
>  
> -	if (IS_ERR_OR_NULL(policy)) {
> -		pr_err("%s: cpufreq policy isn't valid: %p\n", __func__, policy);
> -		return ERR_PTR(-EINVAL);
> -	}
> -
>  	i = cpufreq_table_count_valid_entries(policy);
>  	if (!i) {
>  		pr_debug("%s: CPUFreq table not found or has no valid entries\n",

Acked-by: Viresh Kumar <viresh.kumar@linaro.org>

-- 
viresh
