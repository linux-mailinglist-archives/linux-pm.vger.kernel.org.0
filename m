Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DD5246BC4C6
	for <lists+linux-pm@lfdr.de>; Thu, 16 Mar 2023 04:36:23 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229494AbjCPDgV (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Wed, 15 Mar 2023 23:36:21 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55732 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229482AbjCPDgU (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Wed, 15 Mar 2023 23:36:20 -0400
Received: from mail-pl1-x629.google.com (mail-pl1-x629.google.com [IPv6:2607:f8b0:4864:20::629])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1E47A5A19F
        for <linux-pm@vger.kernel.org>; Wed, 15 Mar 2023 20:36:19 -0700 (PDT)
Received: by mail-pl1-x629.google.com with SMTP id u5so373071plq.7
        for <linux-pm@vger.kernel.org>; Wed, 15 Mar 2023 20:36:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1678937778;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=eySsXUVBPeuknu9XKJH8XQTsPXuxbdjPQ8orqH0Ixns=;
        b=buO+slWOmBBVA3sNSFiaelurFehv7wkmkhUx+qrNXFKfJ9wNazGQWkqHXFqW0lp5Fb
         lJctDtyMHRQMqIP/MMxx5vFnODA8415xONeWPVtWfdbCdJEJ/fa0eEg2W6IJ6Y+AbS6x
         bwvZwdVrpW5RbO1WLtf/3Mf+z54zWryD0IYH43fq2xdLmUNkWLgV+RJ9V2zxsua956wi
         FjgAj+F/Bt0fXQqMe3CnidqJUXcZi2/wIgHaRHJ1eCXixJtLpNhHREBDcGS2eLpQ7aYb
         mxzPTC2eGc14m3NTmFEAYt+oyrAjC6CW9x5tdrPLcjAwuJyxiG/GbZ9Jdj8AskbdG1Dn
         fJgw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1678937778;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=eySsXUVBPeuknu9XKJH8XQTsPXuxbdjPQ8orqH0Ixns=;
        b=nv4zC0gWeRR2W2J4D7bFeRxtCmcP6c4UaHIaWPSVSp0erkN0f255AoHszcqpiBWN0O
         zacGM7etmIp9ewztSwXDDanDkQupJoQ7cCaQccbN+cMkudamKGNmRfw5ES8ovWT6+K5a
         4xf3AyFtXQEbggVZvliIpppU6cIDu5X6qF59Bmq/Z+CwgkrtrLpP3/NbhQfwpAZFQsjY
         1mTFC37HZHaRcSCogeIx6MjeisLViQKOaaQy7YR+Fdrx8FVCLrRabr1dvRBAst+ZhBf+
         w8DajNzmxVsgTZ6nyCov+2ZQPisO0ldaNzdBG06UXBa9+4m9X1lYZdah1+lOtx5tddeR
         MV4Q==
X-Gm-Message-State: AO0yUKU58FQtXBfM8vY+w526blpcHRZEndvNgzySmvTb68spm0bWtJN/
        t60qpPdv0Z/cZNs4Xqj1zi5Clu7ZkZ4Mwgh0WaU=
X-Google-Smtp-Source: AK7set8mJmBVOhPfD72poyQh3qd7KOIde46Idd4gZO5eZddmWS7kuK31wCfwTNj2KU3rIjqGkGoRZA==
X-Received: by 2002:a05:6a20:244d:b0:cb:c276:5898 with SMTP id t13-20020a056a20244d00b000cbc2765898mr2494675pzc.0.1678937778535;
        Wed, 15 Mar 2023 20:36:18 -0700 (PDT)
Received: from localhost ([122.172.83.155])
        by smtp.gmail.com with ESMTPSA id g24-20020aa78198000000b00592417157f2sm4384771pfi.148.2023.03.15.20.36.17
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 15 Mar 2023 20:36:17 -0700 (PDT)
Date:   Thu, 16 Mar 2023 09:06:14 +0530
From:   Viresh Kumar <viresh.kumar@linaro.org>
To:     qinyu <qinyu32@huawei.com>
Cc:     rafael@kernel.org, linux-pm@vger.kernel.org,
        zhangxiaofeng46@huawei.com, hewenliang4@huawei.com,
        linfeilong@huawei.com
Subject: Re: [PATCH] cpufreq: warn about invalid vals to scaling_max/min_freq
 interfaces
Message-ID: <20230316033614.d4yqquhacmzqvmyj@vireshk-i7>
References: <20230316031549.1343340-1-qinyu32@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230316031549.1343340-1-qinyu32@huawei.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

On 16-03-23, 11:15, qinyu wrote:
> When echo an invalid val to scaling_min_freq:
> > echo 123abc123 > scaling_min_freq
> It looks weird to have a return val of 0:
> > echo $?
> > 0
> 
> Sane people won't echo strings like that into these interfaces but fuzz
> tests may do. Also, maybe it's better to inform people if input is invalid
> or out of range.
> 
> After this:
> > echo 123abc123 > scaling_min_freq
> > -bash: echo: write error: Invalid argument
> 
> Signed-off-by: qinyu <qinyu32@huawei.com>
> Tested-by: zhangxiaofeng <zhangxiaofeng46@huawei.com>
> ---
>  drivers/cpufreq/cpufreq.c | 6 +++---
>  1 file changed, 3 insertions(+), 3 deletions(-)
> 
> diff --git a/drivers/cpufreq/cpufreq.c b/drivers/cpufreq/cpufreq.c
> index 6d8fd3b8d..d61f7308f 100644
> --- a/drivers/cpufreq/cpufreq.c
> +++ b/drivers/cpufreq/cpufreq.c
> @@ -725,9 +725,9 @@ static ssize_t store_##file_name					\
>  	unsigned long val;						\
>  	int ret;							\
>  									\
> -	ret = sscanf(buf, "%lu", &val);					\
> -	if (ret != 1)							\
> -		return -EINVAL;						\
> +	ret = kstrtoul(buf, 0, &val);					\
> +	if (ret)							\
> +		return ret;						\
>  									\
>  	ret = freq_qos_update_request(policy->object##_freq_req, val);\
>  	return ret >= 0 ? count : ret;					\

Acked-by: Viresh Kumar <viresh.kumar@linaro.org>

-- 
viresh
