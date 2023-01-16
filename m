Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9B85C66B687
	for <lists+linux-pm@lfdr.de>; Mon, 16 Jan 2023 05:08:39 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231745AbjAPEIg (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Sun, 15 Jan 2023 23:08:36 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51108 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231972AbjAPEIB (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Sun, 15 Jan 2023 23:08:01 -0500
Received: from mail-pg1-x52f.google.com (mail-pg1-x52f.google.com [IPv6:2607:f8b0:4864:20::52f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2873086A7
        for <linux-pm@vger.kernel.org>; Sun, 15 Jan 2023 20:07:24 -0800 (PST)
Received: by mail-pg1-x52f.google.com with SMTP id r18so18794751pgr.12
        for <linux-pm@vger.kernel.org>; Sun, 15 Jan 2023 20:07:24 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=pnwKltfGqDd9PkML2qq9NUgrfPdCan+QgzEP+byBi28=;
        b=w/SLyX8z4faQdeQoH2TqyZXlU7xZXNtXNUQZc/x8rtE6ZxOYlfgtsP8JiRjW2XZG4b
         3kzy45s+gtuLfdSgdsRzNpCiC35dt7UC5xHGFIzlbVWGr9r1b2HmQgFvvBiPc4e5kqVp
         XU187f4aU/DvKzefc+16y8H7yVL9xTq1jwzr7ADDZqzpCTFgWFvczC9swzL8mlcr4RUX
         BM7ao/bx5H6iYk7myd6ugWzIFlmWcdXH5b061zTm+3FDZmIqWOLs/HRbPLL98vhWGU9p
         aHxC0UFJdNqwZQzXw/3Fzotm8xzHp2Iz8mPO5vc7sSYq84YgMx/zEgNa0Ge/H7zeqGG7
         0DqQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=pnwKltfGqDd9PkML2qq9NUgrfPdCan+QgzEP+byBi28=;
        b=4N2e0gdkuBCnSAgy4MfT8D6iJBunxOe6kYjmyrbJHE0b8cpzMHYYbl2cqLc9EEYqVb
         DKq4EuKaRFlNEAzxCGHUmkUWftzI74DPI6Ds3ODkO+UXmwpgfa1XDVz3OX6Y8vhAgRKO
         SuaNxxa2o+hXMev85ok5YRG3hCJHs221FdC2wW9vb+6S8IVqd6Lge22IOfPRazVkyLjs
         3vX1EvTzoTH3LTwOhSgR2/ieLBL+sS9QsvAUGxKanx2fmrhR3liL1KCR441o/PwKKTZ8
         ToRJnnCLQXtM9iPqCWQ9oQqCEatxOESSJnHbjfJ3D11489tCIyfwcVVvvLZixdc0918H
         lu/Q==
X-Gm-Message-State: AFqh2koMzNtQqEOiBEIuUp6/BSJmkYA1SY9idGzb0qw6l8P68dLtYw7Y
        NIpCwUZapMjwMSyUQbjfwD/m9g==
X-Google-Smtp-Source: AMrXdXtn/D4zwVfbHMkHQ/PqVI6H9OrfxJYC31Cb4NaSmAsL3c6dP2AZun2ZdjGOef0iz/uj0FA0zg==
X-Received: by 2002:a62:61c3:0:b0:581:2a6:f04c with SMTP id v186-20020a6261c3000000b0058102a6f04cmr18620962pfb.30.1673842043609;
        Sun, 15 Jan 2023 20:07:23 -0800 (PST)
Received: from localhost ([122.172.81.45])
        by smtp.gmail.com with ESMTPSA id b131-20020a621b89000000b005815217e665sm17146234pfb.65.2023.01.15.20.07.22
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 15 Jan 2023 20:07:22 -0800 (PST)
Date:   Mon, 16 Jan 2023 09:37:20 +0530
From:   Viresh Kumar <viresh.kumar@linaro.org>
To:     Lukasz Luba <lukasz.luba@arm.com>, Vincent Wang <bhuwz@163.com>
Cc:     rafael@kernel.org, linux-pm@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        Vincent Wang <vincentwang3@lenovo.com>
Subject: Re: [PATCH] cpufreq: Send CPUFREQ_CREATE_POLICY notification after
 the perf domain creation.
Message-ID: <20230116040720.zjsyp6bolcbnxyqf@vireshk-i7>
References: <20230115235202.24695-1-bhuwz@163.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230115235202.24695-1-bhuwz@163.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

+Lukasz,

Any inputs ?

On 16-01-23, 07:52, Vincent Wang wrote:
> From: Vincent Wang <vincentwang3@lenovo.com>
> 
> We found the following issue during kernel boot on android phone:
> 
> [    1.325272][    T1] cpu cpu0: EM: created perf domain
> [    1.329317][    T1] cpu cpu4: EM: created perf domain
> [    1.337597][   T76] pd_init: no EM found for CPU7
> [    1.350849][    T1] cpu cpu7: EM: created perf domain
> 
> pd init for cluster2 is executed in a kworker thread and
> is earlier than the perf domain creation for cluster2.
> 
> pd_init() is called from the cpufreq notification of
> CPUFREQ_CREATE_POLICY in cpufreq_online(), which is earlier
> than that cpufreq_driver->register_em() is called.
> 
> To avoid this issue, cpufreq notification should be sent after
> the perf domain creation.
> 
> Signed-off-by: Vincent Wang <vincentwang3@lenovo.com>
> ---
>  drivers/cpufreq/cpufreq.c | 6 +++---
>  1 file changed, 3 insertions(+), 3 deletions(-)
> 
> diff --git a/drivers/cpufreq/cpufreq.c b/drivers/cpufreq/cpufreq.c
> index 7e56a42750ea..af8836069398 100644
> --- a/drivers/cpufreq/cpufreq.c
> +++ b/drivers/cpufreq/cpufreq.c
> @@ -1430,9 +1430,6 @@ static int cpufreq_online(unsigned int cpu)
>  			policy->max_freq_req = NULL;
>  			goto out_destroy_policy;
>  		}
> -
> -		blocking_notifier_call_chain(&cpufreq_policy_notifier_list,
> -				CPUFREQ_CREATE_POLICY, policy);
>  	}
>  
>  	if (cpufreq_driver->get && has_target()) {
> @@ -1506,6 +1503,9 @@ static int cpufreq_online(unsigned int cpu)
>  		 */
>  		if (cpufreq_driver->register_em)
>  			cpufreq_driver->register_em(policy);
> +
> +		blocking_notifier_call_chain(&cpufreq_policy_notifier_list,
> +				CPUFREQ_CREATE_POLICY, policy);
>  	}
>  
>  	ret = cpufreq_init_policy(policy);
> -- 
> 2.25.1

-- 
viresh
