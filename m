Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AE5FB6274E5
	for <lists+linux-pm@lfdr.de>; Mon, 14 Nov 2022 04:23:08 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235688AbiKNDXG (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Sun, 13 Nov 2022 22:23:06 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53096 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233930AbiKNDXF (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Sun, 13 Nov 2022 22:23:05 -0500
Received: from mail-pj1-x1036.google.com (mail-pj1-x1036.google.com [IPv6:2607:f8b0:4864:20::1036])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B2EA113D0B
        for <linux-pm@vger.kernel.org>; Sun, 13 Nov 2022 19:23:04 -0800 (PST)
Received: by mail-pj1-x1036.google.com with SMTP id l6so9251610pjj.0
        for <linux-pm@vger.kernel.org>; Sun, 13 Nov 2022 19:23:04 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=WqzcORU3j8qDZtC3NsFnSoyEDpr6q/ZSnwSL9bohmmw=;
        b=TLegfkWaaJBJJjAlC99aB4HSDz/LC6A+erI3krS0zu+8eadBsRI83RQYvFB7imBUHb
         862AHBkYJJWkizisJ8ZndxgurpE7Ge6u0LpNryk4kBg0k7oD5Rp2nr9A1BIXgPhpIOzN
         7caTsC2qqt1EvjwSazl3mVmNGYCjNW9m7DtNEQogz/khHqdOm6A4b/7GU5gZfv2P551w
         oDl3vHZ11I5JhGmiIjO3Yl30knKOfhZeAvDaTWDcjcMUMsBJPsYC5dzW4p7N6Kcn7LTR
         RL7C+s/j3W0knunCntydOmy5mopxJpFwiSLz4HJzpZkWIfPGnrld4b4WcM2RWwbfCOYS
         rrKA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=WqzcORU3j8qDZtC3NsFnSoyEDpr6q/ZSnwSL9bohmmw=;
        b=pJ0y8lfR05FrlZZAkVq+W6n4dag+64Q9p9Evpl4avRePGM8pWusxJxNUw7g81+bfGY
         74ihS1uGAtytfBvQwvNYdRTBuVM43ds831NokkxOhs/OlcmDyGrTSiHE0SW+4zXKEj2y
         VV+qrLOr4XR8HTzv6bcTmLq3yNRkVKfOIRmeEDBeJXSihxp0dnVQ3XIpuF2PAxVpn4dz
         4J+Fut4KNbTitvQHDEINnEF2TdwPkZu9seqf+a2VzWWE7xI5NxtkYPRsulpqnu3tYzcQ
         IlQJdBo2Ead78ktBKlUUtwzZRux5AwbKKUEGiBJqSgpN3LbyeiimMYm1qMeYXNlGwIBC
         pOGw==
X-Gm-Message-State: ANoB5plGoL8c1hqGFocd3ycPDVa80dVfhW59ZARX8KbF+nFGXH2iLeTH
        ypeOQDvW9zYpgi9nQ2L/n1M/Fg==
X-Google-Smtp-Source: AA0mqf4u81Tocfgme+KesZOWgHbxi7rntgqUQtsU12Hb9iET1sCjB6PixCY613SzT/9Gtt3uJJySLA==
X-Received: by 2002:a17:90a:2b08:b0:213:30b2:4e4e with SMTP id x8-20020a17090a2b0800b0021330b24e4emr12222330pjc.193.1668396184242;
        Sun, 13 Nov 2022 19:23:04 -0800 (PST)
Received: from localhost ([122.172.85.60])
        by smtp.gmail.com with ESMTPSA id 66-20020a620445000000b0056ee0d0985asm5440472pfe.82.2022.11.13.19.23.03
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 13 Nov 2022 19:23:03 -0800 (PST)
Date:   Mon, 14 Nov 2022 08:53:01 +0530
From:   Viresh Kumar <viresh.kumar@linaro.org>
To:     Yongqiang Liu <liuyongqiang13@huawei.com>
Cc:     rafael@kernel.org, tobin@kernel.org, zhangxiaoxu5@huawei.com,
        linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] cpufreq: Init completion before kobject_init_and_add()
Message-ID: <20221114032301.gipu5l3fcndq7oy3@vireshk-i7>
References: <20221110142307.981883-1-liuyongqiang13@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20221110142307.981883-1-liuyongqiang13@huawei.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

On 10-11-22, 14:23, Yongqiang Liu wrote:
> In cpufreq_policy_alloc(), it will call uninitialed completion in
> cpufreq_sysfs_release() when kobject_init_and_add() fails. And
> that will cause a crash such as the following page fault in complete:
> 
> BUG: unable to handle page fault for address: fffffffffffffff8
> [..]
> RIP: 0010:complete+0x98/0x1f0
> [..]
> Call Trace:
>  kobject_put+0x1be/0x4c0
>  cpufreq_online.cold+0xee/0x1fd
>  cpufreq_add_dev+0x183/0x1e0
>  subsys_interface_register+0x3f5/0x4e0
>  cpufreq_register_driver+0x3b7/0x670
>  acpi_cpufreq_init+0x56c/0x1000 [acpi_cpufreq]
>  do_one_initcall+0x13d/0x780
>  do_init_module+0x1c3/0x630
>  load_module+0x6e67/0x73b0
>  __do_sys_finit_module+0x181/0x240
>  do_syscall_64+0x35/0x80
>  entry_SYSCALL_64_after_hwframe+0x63/0xcd
> 
> Fixes: 4ebe36c94aed ("cpufreq: Fix kobject memleak")
> Signed-off-by: Yongqiang Liu <liuyongqiang13@huawei.com>
> ---
>  drivers/cpufreq/cpufreq.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/drivers/cpufreq/cpufreq.c b/drivers/cpufreq/cpufreq.c
> index 69b3d61852ac..7e56a42750ea 100644
> --- a/drivers/cpufreq/cpufreq.c
> +++ b/drivers/cpufreq/cpufreq.c
> @@ -1207,6 +1207,7 @@ static struct cpufreq_policy *cpufreq_policy_alloc(unsigned int cpu)
>  	if (!zalloc_cpumask_var(&policy->real_cpus, GFP_KERNEL))
>  		goto err_free_rcpumask;
>  
> +	init_completion(&policy->kobj_unregister);
>  	ret = kobject_init_and_add(&policy->kobj, &ktype_cpufreq,
>  				   cpufreq_global_kobject, "policy%u", cpu);
>  	if (ret) {
> @@ -1245,7 +1246,6 @@ static struct cpufreq_policy *cpufreq_policy_alloc(unsigned int cpu)
>  	init_rwsem(&policy->rwsem);
>  	spin_lock_init(&policy->transition_lock);
>  	init_waitqueue_head(&policy->transition_wait);
> -	init_completion(&policy->kobj_unregister);
>  	INIT_WORK(&policy->update, handle_update);
>  
>  	policy->cpu = cpu;

Acked-by: Viresh Kumar <viresh.kumar@linaro.org>

-- 
viresh
