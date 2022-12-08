Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 90F43647A33
	for <lists+linux-pm@lfdr.de>; Fri,  9 Dec 2022 00:41:24 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230288AbiLHXlW (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Thu, 8 Dec 2022 18:41:22 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49294 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230300AbiLHXlF (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Thu, 8 Dec 2022 18:41:05 -0500
Received: from mail-pj1-x1031.google.com (mail-pj1-x1031.google.com [IPv6:2607:f8b0:4864:20::1031])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BF05FA19A3
        for <linux-pm@vger.kernel.org>; Thu,  8 Dec 2022 15:38:51 -0800 (PST)
Received: by mail-pj1-x1031.google.com with SMTP id q17-20020a17090aa01100b002194cba32e9so6291415pjp.1
        for <linux-pm@vger.kernel.org>; Thu, 08 Dec 2022 15:38:51 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=MQRFUCugIpCc3nJPPZoXBXwJxeGE8cAxgdJDMoSfyBM=;
        b=SmaZOE+oKoKxAup/qiJcDl+2tiXztqeWmNcoMWgHHRrxzFBaIT6LnxnVQpWlC/TV25
         l+Y296UUy4vDPcxSYFJZiLyBvL2MukA5opDNQH19OyzWVJsKDdiFyUCSLSEisS9V4ZIe
         dYH6nFbfaS1hTb8cBOiY9nd5sClx3uy/cU3CRD3cm1M666yarHVn1GPxpk8Wd4Z6VMjf
         6NViqUKNQrb9EClwxghHOfX5RWo6hWmwWKEY9Q1AY7lqL6BFwT8UEAr7DI0VjjSBK373
         Yl3VImAWKHH3YFpxdwaIFcC/mb3d9AR9zIB+628FIV0ihjnFLpt9bLQRwy/NqWAsxFP+
         0fkg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=MQRFUCugIpCc3nJPPZoXBXwJxeGE8cAxgdJDMoSfyBM=;
        b=QFGc8UeSiHUBH9ZlMFhbz8FKl+pjER2Lhdn+eTvK2vvpzorHw1bb+oxRFp9KYtJtMu
         rjUs4aygDnQt2EYZiR1i2c+Mtamm8+HdE0EGkZVSPP0l78NhxBNV1gGeU834+f+8HYsa
         w+jZRdwNJq705WIiYb36E0k6chzvSGvxkgUvgDo55OjndfpQSj0DJpp1H/bQJO2IH7t7
         yZemvw1St7H3xYWej/ypcuA5WzNLkL27fy0O25gsMtB71KqcoxIV9lcT8z5FTVoKuXbY
         1ApfKVSSJv6jwl7SlU1fXi1SNBCxbYN0EMwI2hZ7/nrNYcakzUSxiOfSjKTQrZaoA/K3
         wcqw==
X-Gm-Message-State: ANoB5pn6NNDV85jeaVFIcOoFdxwLEk5qiqZpPhu94hzkY6tHr44LyhLY
        3AUr0BEsYEU2ziPpXfn3WWlv/A==
X-Google-Smtp-Source: AA0mqf7HW4zKs56oKSXQVoUeqFxPq25BynTHdtfUP2fJ+FsAqafx6IWob28wyAnjCsU+y4rZH0uOlA==
X-Received: by 2002:a17:90a:8c82:b0:213:1e29:c8dd with SMTP id b2-20020a17090a8c8200b002131e29c8ddmr3647540pjo.7.1670542684756;
        Thu, 08 Dec 2022 15:38:04 -0800 (PST)
Received: from localhost ([122.172.87.149])
        by smtp.gmail.com with ESMTPSA id q8-20020a17090a1b0800b0021937b2118bsm52777pjq.54.2022.12.08.15.38.03
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 08 Dec 2022 15:38:03 -0800 (PST)
Date:   Fri, 9 Dec 2022 05:08:01 +0530
From:   Viresh Kumar <viresh.kumar@linaro.org>
To:     Lukasz Luba <lukasz.luba@arm.com>
Cc:     linux-kernel@vger.kernel.org, linux-pm@vger.kernel.org,
        rafael@kernel.org, dietmar.eggemann@arm.com,
        vincent.guittot@linaro.org, saravanak@google.com,
        wusamuel@google.com, isaacmanjarres@google.com,
        kernel-team@android.com, juri.lelli@redhat.com,
        peterz@infradead.org, mingo@redhat.com, rostedt@goodmis.org,
        bsegall@google.com, mgorman@suse.de
Subject: Re: [PATCH v3 1/1] cpufreq: schedutil: Optimize operations with
 single CPU capacity lookup
Message-ID: <20221208233801.s26awslkx6aloxyd@vireshk-i7>
References: <20221208160256.859-1-lukasz.luba@arm.com>
 <20221208160256.859-2-lukasz.luba@arm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20221208160256.859-2-lukasz.luba@arm.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

On 08-12-22, 16:02, Lukasz Luba wrote:
> @@ -332,12 +333,15 @@ static void sugov_update_single_freq(struct update_util_data *hook, u64 time,
>  	struct sugov_cpu *sg_cpu = container_of(hook, struct sugov_cpu, update_util);
>  	struct sugov_policy *sg_policy = sg_cpu->sg_policy;
>  	unsigned int cached_freq = sg_policy->cached_raw_freq;
> +	unsigned long max_cap;
>  	unsigned int next_f;
>  
> -	if (!sugov_update_single_common(sg_cpu, time, flags))
> +	max_cap = arch_scale_cpu_capacity(sg_cpu->cpu);

I will rather do this at all three locations:

	unsigned long max_cap = arch_scale_cpu_capacity(sg_cpu->cpu);

-- 
viresh
