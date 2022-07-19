Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 766C75791B7
	for <lists+linux-pm@lfdr.de>; Tue, 19 Jul 2022 06:14:54 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236811AbiGSEOx (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Tue, 19 Jul 2022 00:14:53 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60436 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236616AbiGSEOw (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Tue, 19 Jul 2022 00:14:52 -0400
Received: from mail-pj1-x1031.google.com (mail-pj1-x1031.google.com [IPv6:2607:f8b0:4864:20::1031])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AF3DE3ED5B
        for <linux-pm@vger.kernel.org>; Mon, 18 Jul 2022 21:14:51 -0700 (PDT)
Received: by mail-pj1-x1031.google.com with SMTP id x18-20020a17090a8a9200b001ef83b332f5so20196709pjn.0
        for <linux-pm@vger.kernel.org>; Mon, 18 Jul 2022 21:14:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=PcoM/2VxSazYw3xrD2Doehr//Sh1eaqhYJJVE4GDy34=;
        b=Opm4hi3omHyUJfxTX7A6AUKYKxH6SF2hvwXsFMaHw5vuVLEi1Nibi2mNaMXkfehTBR
         WVtr/AdJ9d9ciIxMs8K6zTCGUiceENfLjIBKKjJBNhpV9xjHmfP/s5rg3Im4Hnsoax89
         0DjC9YfKQuIUbrKs8sATbBnBaK0I2zihi67vJUSaWj/BtmCF1XuFyqwqOC4sT44FUNtX
         iCYoNaY9rmSjFz/oKpdDoeq3OY6TnwglIlZYosgKCuKpvaUg3igxTi50q2nro5h515Z4
         hL01oin4i/6j3NXa86htkVgHjC8ZcAP/WGYQrP/IRj5pFl62xB4GEmtBo3fTsBJPZth+
         RJFA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=PcoM/2VxSazYw3xrD2Doehr//Sh1eaqhYJJVE4GDy34=;
        b=bIrhaoJuVXXN83TxXBBprVbst4tAOlSsN4euLstQcDdEnsvOXxj3GcF4gzju7azUYx
         aFo9B9JwJO7/xQY2MEPfX9VC9Ll98IXQeZZXObNcVUoRG18hN2BJN8bSlsFPClKRkCLJ
         i0iWrMqJLvA3t//WRHz3eJaCJfr4xOejhj29TTACB+6f+xT5+WHjkk18w+cRbvP/+puF
         VJMqtn3NbCeVZwKa6IZZ8cJ0GrNNX6o0j6JnQLoyGuHfJRSZqr/VRqwiDD2SltO13zuN
         GZzpXErkxMfjVn2lwkwT7cBkwfYzjf4IbpYgPE1V9sujHrhlvuRZiyp3KXS/sjHvxxlY
         CMlw==
X-Gm-Message-State: AJIora/ekFJkRNLPA3rJoRr1VoIIzgFc5a/6gPySxq6+MSsh99IeC2v8
        C5AT6r1Tj2WUoP8a/XCpWen1mg==
X-Google-Smtp-Source: AGRyM1tI6zyRWQfdZYvlnOak1NVPcELyI5ONB78Ywca0UFqiJ9+fItFi1nzNJgxXXUHg2SLi20/X1Q==
X-Received: by 2002:a17:90b:3a88:b0:1f0:56d5:460e with SMTP id om8-20020a17090b3a8800b001f056d5460emr41219754pjb.208.1658204091145;
        Mon, 18 Jul 2022 21:14:51 -0700 (PDT)
Received: from localhost ([122.171.18.80])
        by smtp.gmail.com with ESMTPSA id b32-20020a631b60000000b0040d48cf046csm8935574pgm.55.2022.07.18.21.14.50
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 18 Jul 2022 21:14:50 -0700 (PDT)
Date:   Tue, 19 Jul 2022 09:44:48 +0530
From:   Viresh Kumar <viresh.kumar@linaro.org>
To:     Di Shen <di.shen@unisoc.com>
Cc:     lukasz.luba@arm.com, amitk@kernel.org, rui.zhang@intel.com,
        amit.kachhap@gmail.com, daniel.lezcano@linaro.org,
        rafael@kernel.org, linux-pm@vger.kernel.org,
        linux-kernel@vger.kernel.org, xuewen.yan@unisoc.com,
        xuewen.yan94@gmail.com
Subject: Re: [PATCH] thermal: cpufreq_cooling: Avoid all cluster using global
 cooling_ops
Message-ID: <20220719041448.iyavinsv3jzs3au4@vireshk-i7>
References: <20220718122419.9409-1-di.shen@unisoc.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220718122419.9409-1-di.shen@unisoc.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

On 18-07-22, 20:24, Di Shen wrote:
> Now, all the cooling device use the globle cpufreq_cooling_ops. When the
> CONFIG_THERMAL_GOV_POWER_ALLOCATOR is enabled, once one cluster init the
> cpufreq_cooling_ops, it would make all cooling device use the power allocator's
> ops. If one's em is error because of the "em_is_sane", it would cause the
> em NULL, but the cooling device's ops is exist, as a result, it would cause
> panic because of the em.
> 
> Add cpufreq_power_cooling_ops to avoid this case.
> 
> Signed-off-by: Di Shen <di.shen@unisoc.com>
> Signed-off-by: Xuewen Yan <xuewen.yan@unisoc.com>
> ---
>  drivers/thermal/cpufreq_cooling.c | 15 ++++++++++++---
>  1 file changed, 12 insertions(+), 3 deletions(-)
> 
> diff --git a/drivers/thermal/cpufreq_cooling.c b/drivers/thermal/cpufreq_cooling.c
> index b8151d95a806..af5cfb458370 100644
> --- a/drivers/thermal/cpufreq_cooling.c
> +++ b/drivers/thermal/cpufreq_cooling.c
> @@ -493,6 +493,17 @@ static struct thermal_cooling_device_ops cpufreq_cooling_ops = {
>  	.set_cur_state		= cpufreq_set_cur_state,
>  };
>  
> +#ifdef CONFIG_THERMAL_GOV_POWER_ALLOCATOR
> +static struct thermal_cooling_device_ops cpufreq_power_cooling_ops = {
> +	.get_max_state		= cpufreq_get_max_state,
> +	.get_cur_state		= cpufreq_get_cur_state,
> +	.set_cur_state		= cpufreq_set_cur_state,
> +	.get_requested_power	= cpufreq_get_requested_power,
> +	.state2power		= cpufreq_state2power,
> +	.power2state		= cpufreq_power2state,
> +};
> +#endif
> +
>  /**
>   * __cpufreq_cooling_register - helper function to create cpufreq cooling device
>   * @np: a valid struct device_node to the cooling device device tree node
> @@ -559,9 +570,7 @@ __cpufreq_cooling_register(struct device_node *np,
>  #ifdef CONFIG_THERMAL_GOV_POWER_ALLOCATOR
>  	if (em_is_sane(cpufreq_cdev, em)) {
>  		cpufreq_cdev->em = em;
> -		cooling_ops->get_requested_power = cpufreq_get_requested_power;
> -		cooling_ops->state2power = cpufreq_state2power;
> -		cooling_ops->power2state = cpufreq_power2state;
> +		cooling_ops = &cpufreq_power_cooling_ops;
>  	} else
>  #endif
>  	if (policy->freq_table_sorted == CPUFREQ_TABLE_UNSORTED) {

Please have a look at this patch in linux-next.

commit 6ee324afdf30 ("drivers/thermal/cpufreq_cooling: Use private callback ops for each cooling device")

This already fixes the problem, right ?

-- 
viresh
