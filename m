Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1CC8478C0EE
	for <lists+linux-pm@lfdr.de>; Tue, 29 Aug 2023 11:04:45 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230122AbjH2JEO (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Tue, 29 Aug 2023 05:04:14 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47960 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234401AbjH2JDt (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Tue, 29 Aug 2023 05:03:49 -0400
Received: from mail-pf1-x42e.google.com (mail-pf1-x42e.google.com [IPv6:2607:f8b0:4864:20::42e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 812751AA
        for <linux-pm@vger.kernel.org>; Tue, 29 Aug 2023 02:03:46 -0700 (PDT)
Received: by mail-pf1-x42e.google.com with SMTP id d2e1a72fcca58-68c0d886ea0so2828064b3a.2
        for <linux-pm@vger.kernel.org>; Tue, 29 Aug 2023 02:03:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1693299826; x=1693904626;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=ORZiB94/bjq/zwPr1B87oo/KGJsoCMW7VqIJI5SB3aI=;
        b=uFfiEzXN0A0a2rGrhDxfqXkk8Xtd96BTxJxumJSKxcYnL2WuJkpp5xKIrByXK0nLQ7
         /kJBnmekbrxYuJ4kBakDaTcM5VBuhcnp1qNqjflhUudi3FlHetF+ed2ZatOuvJbjzjJM
         K5LrH251uaGUa7N6mYzYZKnvkOFOBX3TKmdG8TJF27oz1GDTMuehJeCzDHYQHtdpXRlM
         Dj5RHD5tMUaAVyXX7cKdtBdPEzitDJPl2Q1n+GBtvBhnDZd+OolcsfYQdFvt5VhiOUPp
         wsniCq7Tgk2+8vbre7gVz0Yc4DARe384FymQP+IgJU2Ib0aYFJNeL8zuhBTI9PxlIybh
         G1lg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1693299826; x=1693904626;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ORZiB94/bjq/zwPr1B87oo/KGJsoCMW7VqIJI5SB3aI=;
        b=hXMwjd/7qvQT5PyMi8liyPpbaLpBf2/ZqtSJvOxHfmht5RPpO4W7azUulBr0bTBYNj
         5jZIbslLsTERjefLT0edfVgyUZZ+qG12EiVlvGu7HtML35Ri8BU7SjMEstoOPfz3iJLH
         CsxqJCMyk38uVM1YtWKh0609anCygPa3CWKcJVbUmc20G1F1hti3lRgKcl2APtGSGz/p
         AXLsWr7iBhMkQVJQTHiujRaeGZqG46/jmvG70HIO1tEkXVS/PyV5BZFjeUCPaGf7r6u0
         Ld5Jxhp497teUjSziFXynp9OU8zOXTIdc0rju+yn7I/JzcWtH60Wnh6cL/tAKzFRWmiJ
         uEcw==
X-Gm-Message-State: AOJu0YxCJjAZMgref6wzjEikL+x+o/bIEtFWzCf0Aaf901u7gTt2qS/O
        xy9gkWDOXNg6BSBNUK0i97IyJA==
X-Google-Smtp-Source: AGHT+IGxIYjt92oKdEgN1Tkfh7Y6aYrB5m136ynE5+UkbRi5VNPnmqvDRiUhxAz6JBCEoOZgUqOUGw==
X-Received: by 2002:a05:6a00:cc1:b0:68a:570f:e36a with SMTP id b1-20020a056a000cc100b0068a570fe36amr29336238pfv.4.1693299826001;
        Tue, 29 Aug 2023 02:03:46 -0700 (PDT)
Received: from localhost ([122.172.87.195])
        by smtp.gmail.com with ESMTPSA id t25-20020aa79399000000b0068be4ce33easm8199639pfe.96.2023.08.29.02.03.44
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 29 Aug 2023 02:03:45 -0700 (PDT)
Date:   Tue, 29 Aug 2023 14:33:43 +0530
From:   Viresh Kumar <viresh.kumar@linaro.org>
To:     Sumit Gupta <sumitg@nvidia.com>
Cc:     rafael@kernel.org, linux-pm@vger.kernel.org,
        linux-tegra@vger.kernel.org, linux-kernel@vger.kernel.org,
        treding@nvidia.com, jonathanh@nvidia.com, bbasu@nvidia.com
Subject: Re: [Patch v2] cpufreq: tegra194: fix warning due to missing opp_put
Message-ID: <20230829090343.kyyfsienwo4aiu2p@vireshk-i7>
References: <20230829084322.30558-1-sumitg@nvidia.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230829084322.30558-1-sumitg@nvidia.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

On 29-08-23, 14:13, Sumit Gupta wrote:
> Fix the warning due to missing dev_pm_opp_put() call and hence
> wrong refcount value. This causes below warning message when
> trying to remove the module.
> 
>  Call trace:
>   dev_pm_opp_put_opp_table+0x154/0x15c
>   dev_pm_opp_remove_table+0x34/0xa0
>   _dev_pm_opp_cpumask_remove_table+0x7c/0xbc
>   dev_pm_opp_of_cpumask_remove_table+0x10/0x18
>   tegra194_cpufreq_exit+0x24/0x34 [tegra194_cpufreq]
>   cpufreq_remove_dev+0xa8/0xf8
>   subsys_interface_unregister+0x90/0xe8
>   cpufreq_unregister_driver+0x54/0x9c
>   tegra194_cpufreq_remove+0x18/0x2c [tegra194_cpufreq]
>   platform_remove+0x24/0x74
>   device_remove+0x48/0x78
>   device_release_driver_internal+0xc8/0x160
>   driver_detach+0x4c/0x90
>   bus_remove_driver+0x68/0xb8
>   driver_unregister+0x2c/0x58
>   platform_driver_unregister+0x10/0x18
>   tegra194_ccplex_driver_exit+0x14/0x1e0 [tegra194_cpufreq]
>   __arm64_sys_delete_module+0x184/0x270
> 
> Fixes: f41e1442ac5b ("cpufreq: tegra194: add OPP support and set bandwidth")
> Signed-off-by: Sumit Gupta <sumitg@nvidia.com>
> ---
>  drivers/cpufreq/tegra194-cpufreq.c | 1 +
>  1 file changed, 1 insertion(+)
> 
> diff --git a/drivers/cpufreq/tegra194-cpufreq.c b/drivers/cpufreq/tegra194-cpufreq.c
> index 88ef5e57ccd0..9d7e1d58f6e5 100644
> --- a/drivers/cpufreq/tegra194-cpufreq.c
> +++ b/drivers/cpufreq/tegra194-cpufreq.c
> @@ -450,6 +450,7 @@ static int tegra_cpufreq_init_cpufreq_table(struct cpufreq_policy *policy,
>  		if (IS_ERR(opp))
>  			continue;
>  
> +		dev_pm_opp_put(opp);
>  		ret = dev_pm_opp_enable(cpu_dev, pos->frequency * KHZ);
>  		if (ret < 0)
>  			return ret;

Applied. Thanks.

-- 
viresh
