Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1BE1B510F6D
	for <lists+linux-pm@lfdr.de>; Wed, 27 Apr 2022 05:18:08 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S244309AbiD0DVP (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Tue, 26 Apr 2022 23:21:15 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44828 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239226AbiD0DVO (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Tue, 26 Apr 2022 23:21:14 -0400
Received: from mail-pj1-x102f.google.com (mail-pj1-x102f.google.com [IPv6:2607:f8b0:4864:20::102f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 59D3B13F8C
        for <linux-pm@vger.kernel.org>; Tue, 26 Apr 2022 20:18:04 -0700 (PDT)
Received: by mail-pj1-x102f.google.com with SMTP id gj17-20020a17090b109100b001d8b390f77bso3880474pjb.1
        for <linux-pm@vger.kernel.org>; Tue, 26 Apr 2022 20:18:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=XTLOas78RQ0/UyRSC2YDKTpbOeiAeOZCtumqdgYp4Z4=;
        b=mqSgWBPiZA5AOZKT6FykeD6jPdOPAmSH9NV6sFOFz8a3i0AnRvCiTCjNYuwdZ+tCCv
         gdE8VRhUJ1oNfG49hKS+xFeQCJFqTPR+nGg32RdalHPbCtc04r2U6JmyfhYwR+z8ou5m
         4SnX8J6xEUt2YGkfpLEX0TGC8aaSGfCSFpEE0+KmW8uI4Bb/QPUCzL+gWClk2JGHjQpz
         cVZQCTFmoR3RKcmVKCSvRTV3H8WEBItqH9wYErn1W2xSRGex0COZsSCofAonYxX3KTtI
         U0yxOkGL5qvKzKZ3GoAcCZ8ny3+D0vAJ2+PiStmirta8ou5U2iW+YVvBU17MqF2twsC9
         BBVA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=XTLOas78RQ0/UyRSC2YDKTpbOeiAeOZCtumqdgYp4Z4=;
        b=AwjsujXhlMhHC74Ye16sY4PjK9KcvRTztJKNTl/ZVj99QET5xEG7LAa0aKSgZxlCWU
         wIqqg7XRHgRvEVya4epHlk/B2I5vO/WBC0kVmO+OGk3sfDcMNIQUw9NvVgVFExfVGpwA
         epHp0TS+MhtL9T8Qb5jCpXjkJEeH0i+O1+Sogla5E1Yo5eBjsLF/fHkKEcm4jihbvOMB
         Qd+jnM2kLFm7z04j30ngqJ/nJqn3LELX70CxeTeWZFv5sWAD8HTwdVyhY2T0yZ2yogNA
         RwvHbNdzawIaqCF7Q6NcdDVFCPSZsEH50G6YWeyQIgIKOMVtHqvcmOZLXwPOc01foklk
         z4/w==
X-Gm-Message-State: AOAM531lCo4anwqnpygufbs4A/uARf6nYFP7YdNMhLDGrMAra6qKLMPJ
        s/8iUT4zmdnYG6Ly57zPt1XUS6NJXa2qNg==
X-Google-Smtp-Source: ABdhPJwUEsxKcRCpJmBZnAvMHtBIhDnOJS4DjfdCieo7LC2EPJV6RP0uzxjZi6XmsQoPF1XA84D7ag==
X-Received: by 2002:a17:90b:17c6:b0:1d2:8450:49b3 with SMTP id me6-20020a17090b17c600b001d2845049b3mr41331569pjb.246.1651029483817;
        Tue, 26 Apr 2022 20:18:03 -0700 (PDT)
Received: from localhost ([122.177.141.190])
        by smtp.gmail.com with ESMTPSA id e17-20020a637451000000b003c144b70a7csm609775pgn.77.2022.04.26.20.18.02
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 26 Apr 2022 20:18:03 -0700 (PDT)
Date:   Wed, 27 Apr 2022 08:48:01 +0530
From:   Viresh Kumar <viresh.kumar@linaro.org>
To:     Wan Jiabing <wanjiabing@vivo.com>
Cc:     "Rafael J. Wysocki" <rafael@kernel.org>,
        Matthias Brugger <matthias.bgg@gmail.com>,
        AngeloGioacchino Del Regno 
        <angelogioacchino.delregno@collabora.com>,
        Rex-BC Chen <rex-bc.chen@mediatek.com>,
        linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org,
        linux-mediatek@lists.infradead.org
Subject: Re: [PATCH] cpufreq: mediatek: Fix NULL pointer dereference in
 mediatek-cpufreq
Message-ID: <20220427031801.tlph5uyougr55yri@vireshk-i7>
References: <20220426111715.627609-1-wanjiabing@vivo.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220426111715.627609-1-wanjiabing@vivo.com>
User-Agent: NeoMutt/20180716-391-311a52
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

On 26-04-22, 19:17, Wan Jiabing wrote:
> Fix following coccicheck error:
> drivers/cpufreq/mediatek-cpufreq.c:464:16-23: ERROR: info is NULL but dereferenced.
> 
> Use pr_err instead of dev_err to avoid dereferring a NULL pointer.
> 
> Fixes: f52b16ba9fe4 ("cpufreq: mediatek: Use device print to show logs")
> Signed-off-by: Wan Jiabing <wanjiabing@vivo.com>
> ---
>  drivers/cpufreq/mediatek-cpufreq.c | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)
> 
> diff --git a/drivers/cpufreq/mediatek-cpufreq.c b/drivers/cpufreq/mediatek-cpufreq.c
> index bcabb3726a5b..901042e9a240 100644
> --- a/drivers/cpufreq/mediatek-cpufreq.c
> +++ b/drivers/cpufreq/mediatek-cpufreq.c
> @@ -461,8 +461,8 @@ static int mtk_cpufreq_init(struct cpufreq_policy *policy)
>  
>  	info = mtk_cpu_dvfs_info_lookup(policy->cpu);
>  	if (!info) {
> -		dev_err(info->cpu_dev,
> -			"dvfs info for cpu%d is not initialized.\n", policy->cpu);
> +		pr_err("dvfs info for cpu%d is not initialized.\n",
> +			policy->cpu);
>  		return -EINVAL;
>  	}

Applied. Thanks.

-- 
viresh
