Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 145487D69DC
	for <lists+linux-pm@lfdr.de>; Wed, 25 Oct 2023 13:18:28 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232272AbjJYLS1 (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Wed, 25 Oct 2023 07:18:27 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33346 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232076AbjJYLS0 (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Wed, 25 Oct 2023 07:18:26 -0400
Received: from mail-oa1-x2b.google.com (mail-oa1-x2b.google.com [IPv6:2001:4860:4864:20::2b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 79DB5BB
        for <linux-pm@vger.kernel.org>; Wed, 25 Oct 2023 04:18:24 -0700 (PDT)
Received: by mail-oa1-x2b.google.com with SMTP id 586e51a60fabf-1ea4a3d0a44so3657328fac.1
        for <linux-pm@vger.kernel.org>; Wed, 25 Oct 2023 04:18:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1698232704; x=1698837504; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=O/w4iA+oDuPu231sTcNOTsdxeUTQplFVmErJTH5H3OY=;
        b=FNhRtMkzNUGu9nr012wAESpAYD14IgE1GJDYNLP2tSxQDxj5xTGVvFnsE/2Yh6odcz
         TJU8tbadSvgxSRJBLHyJDMAnGQXD8gF9djmyolWmJZoZ6HE9jjVXNfE1oruGUCP2sB8u
         EgfH2SYFH1jqBnb9i2DuNdUTSsKdv4peG7U7szgqGg96TDf/Y2z4TdBgoA3zTiPbWloQ
         JlglPjphJ4MMe01t23iZ2DHNLAdU7MboV+lPJu08XOu1XY2oIcKEa7Z7DSIUDLIcciyH
         9CjVAtWIISgrv8k5iWe3zZZWZDKzMi2emZVew5Uv004SEtlUzw5rUtYoOgwCO4NAVBo0
         IYww==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1698232704; x=1698837504;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=O/w4iA+oDuPu231sTcNOTsdxeUTQplFVmErJTH5H3OY=;
        b=jipnsKn940cloanmx0XBm+keVMAEs6+bnp++4SwekJ1PvQWd9lI/ZNavP8AX8UkxSC
         HFSZGAUdul7KLr7NJlyeYrJqlZM4KH74ryeLycxz+WELrzkHAGFbfZ0/bL8JcY2hyObV
         X27whOLfAzhx+qLq37P3i+Uh7Lb8e0+Rdcs3nJhaXKVOFhkyezNhcVkAJelOPr925k/A
         e25Tk6cyb7aCyLIQbMGJK5q21bwcLP6/atNMvX/aTxmk7Hi8Vf/j6f89+f/CiY4xpdJK
         ktHD4FgoNRqUm0W560UtRdD8bwiK5UJB7PoH19AS1z5QQf1vgkFW1qRP017VXn/5T4rL
         NlcQ==
X-Gm-Message-State: AOJu0YyYL4TcYmwi6MViK23n6dnqjbl2oHsMYwoTBHkX/iLkNympJePu
        TDscUPzKxGJCrbm2bRKPtzRgOyaGpFlwon6CBko=
X-Google-Smtp-Source: AGHT+IEtGdAVdFkWJnngM50vrzWN38KyMloiqcaozZu5lVIF2ZqigYk3JwzyX/TjX6djJ/Fg/wCdow==
X-Received: by 2002:a05:6870:9d96:b0:1ea:2c8b:e18e with SMTP id pv22-20020a0568709d9600b001ea2c8be18emr18928096oab.8.1698232703744;
        Wed, 25 Oct 2023 04:18:23 -0700 (PDT)
Received: from localhost ([122.172.80.14])
        by smtp.gmail.com with ESMTPSA id 202-20020a6301d3000000b005b7e3eddb87sm8640826pgb.61.2023.10.25.04.18.22
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 25 Oct 2023 04:18:23 -0700 (PDT)
Date:   Wed, 25 Oct 2023 16:48:21 +0530
From:   Viresh Kumar <viresh.kumar@linaro.org>
To:     Zeng Heng <zengheng4@huawei.com>
Cc:     rafael@kernel.org, liwei391@huawei.com, linux-pm@vger.kernel.org,
        xiexiuqi@huawei.com, wangxiongfeng2@huawei.com,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH -next] cpufreq: userspace: Keep the current frequency
 when set userspace policy
Message-ID: <20231025111821.pp3hdpilddbx4yzr@vireshk-i7>
References: <20231025080910.3245690-1-zengheng4@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20231025080910.3245690-1-zengheng4@huawei.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

On 25-10-23, 16:09, Zeng Heng wrote:
> When switching to the userspace policy, if the current frequency is within
> the range of policy's min and max values, the current frequency value
> should be remained. The .limit() function is called when changing governor
> or updating governor limits, so in both cases, there is no need to update
> frequency if the current frequency does not exceed the threshold.
> 
> Additionally, when changing to userspace governor, the default value of
> set_speed is set by reading the current frequency of the CPU, but there
> is inevitable error between the frequency coming from .get_rate() interface
> and the actual working frequency. Consequently, when switching to userspace
> policy, keeping the current frequency can avoid unexpected changes.
> 
> Signed-off-by: Zeng Heng <zengheng4@huawei.com>
> ---
>  drivers/cpufreq/cpufreq_userspace.c | 4 +---
>  1 file changed, 1 insertion(+), 3 deletions(-)
> 
> diff --git a/drivers/cpufreq/cpufreq_userspace.c b/drivers/cpufreq/cpufreq_userspace.c
> index 2c42fee76daa..fe55a7bb663c 100644
> --- a/drivers/cpufreq/cpufreq_userspace.c
> +++ b/drivers/cpufreq/cpufreq_userspace.c
> @@ -117,9 +117,7 @@ static void cpufreq_userspace_policy_limits(struct cpufreq_policy *policy)
>  	else if (policy->min > userspace->setspeed)
>  		__cpufreq_driver_target(policy, policy->min,
>  					CPUFREQ_RELATION_L);
> -	else
> -		__cpufreq_driver_target(policy, userspace->setspeed,
> -					CPUFREQ_RELATION_L);
> +	/* Otherwise, keep the current frequency. */
> 
>  	mutex_unlock(&userspace->mutex);
>  }

Here is some reasoning why it should be done the way it is:

commit e43e94c1eda7 ("cpufreq: Fix GOV_LIMITS handling for the userspace governor")

-- 
viresh
