Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B10DF4B0EF3
	for <lists+linux-pm@lfdr.de>; Thu, 10 Feb 2022 14:40:28 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242282AbiBJNiZ (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Thu, 10 Feb 2022 08:38:25 -0500
Received: from mxb-00190b01.gslb.pphosted.com ([23.128.96.19]:38388 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S242291AbiBJNiY (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Thu, 10 Feb 2022 08:38:24 -0500
Received: from mail-ej1-x634.google.com (mail-ej1-x634.google.com [IPv6:2a00:1450:4864:20::634])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 77B6EDDB
        for <linux-pm@vger.kernel.org>; Thu, 10 Feb 2022 05:38:24 -0800 (PST)
Received: by mail-ej1-x634.google.com with SMTP id fy20so15370952ejc.0
        for <linux-pm@vger.kernel.org>; Thu, 10 Feb 2022 05:38:24 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=qo+3lof+9ZgEdoYqg9n+9HUoegVVcIVctooUaTdAV8c=;
        b=NVoPBNyQ6KWqxaKVjXM4b3D5PmjRZ2EKtBhBE/1xuEN8THnLzCXtajgR1jRuUXBoax
         R8jfdygcv2BcnomYL4eM/iJWuwCqybbcKXag1uglhn7an34HnZPUmEg0dibLMlYMWn26
         C2jvsgoKeiNYXzdcX4VOvEjx4k6txPycV3kCk5JJH371STEljsaC1BJNdzvM9zTYLhRa
         MwEpHpr+BZDAdYgo7HtLPFPV9xM85zitBJ4HAFhboMsEcXrfQn6doAoVUaW0ofoC4x+7
         V8or2FLj3O25VnqImito3570G4GHNDwWsegZrP6sUkwIDCSHAe6+4u1A8lv45I2vO09h
         YDrA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=qo+3lof+9ZgEdoYqg9n+9HUoegVVcIVctooUaTdAV8c=;
        b=Sw3T1AHmmUSRjKs5OBl3FJ3ZhZQcQwCWmeNYhZB7QL2XVCXpN96SnWy1645UR0BTdA
         BV/UeOM4bqIy8MQ0c3qivrPmDn1jNyF7QNyjWmWIPDCrx+Lti3pd6OZ8ai9fQDqqQZYL
         kUtKU+ScPLRY+lBXrpFPjW3amacmcP/sl3H/lN4C76+QGsodguh3Wjqge2/RXw/qhu06
         zIrz2ZPDzeFsgRd6yAv4qf1hoe70dO5W7pzMw0A2leShMcM3tmxjiS810hKDSI8HdhsD
         qv7aui7q+gYV49vnk6mVITqSxTqR9SiFEdiITFPXjktxhKGmeRUaHqH/7aU61FnOz1jJ
         FQIg==
X-Gm-Message-State: AOAM530l/Ky7HWfmIWafOt9vKipVnjit2dqvQ/ME2TszBB5JFfk/OAdk
        lYqMqFfQg2mHtozAUJSeu+GNKw==
X-Google-Smtp-Source: ABdhPJwnxobrtjifEn1vNy1Nqb7eb4CtUkKNzY6ebDF6I3LTQB8ZCEmx6clKWAMMQxDY+jJ6D0O4Yg==
X-Received: by 2002:a17:907:3e90:: with SMTP id hs16mr6579246ejc.731.1644500300437;
        Thu, 10 Feb 2022 05:38:20 -0800 (PST)
Received: from leoy-ThinkPad-X240s ([104.245.96.223])
        by smtp.gmail.com with ESMTPSA id v26sm2493418ejk.125.2022.02.10.05.38.17
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 10 Feb 2022 05:38:19 -0800 (PST)
Date:   Thu, 10 Feb 2022 21:38:14 +0800
From:   Leo Yan <leo.yan@linaro.org>
To:     Viresh Kumar <viresh.kumar@linaro.org>
Cc:     Rafael Wysocki <rjw@rjwysocki.net>,
        Viresh Kumar <vireshk@kernel.org>, Nishanth Menon <nm@ti.com>,
        Stephen Boyd <sboyd@kernel.org>, linux-pm@vger.kernel.org,
        Vincent Guittot <vincent.guittot@linaro.org>,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] opp: Expose of-node's name in debugfs
Message-ID: <20220210133814.GB334894@leoy-ThinkPad-X240s>
References: <6d4ebbbe09f97c9f97834c293a70f6a8a4d36709.1644487134.git.viresh.kumar@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <6d4ebbbe09f97c9f97834c293a70f6a8a4d36709.1644487134.git.viresh.kumar@linaro.org>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

Hi Viresh,

On Thu, Feb 10, 2022 at 03:29:26PM +0530, Viresh Kumar wrote:
> It is difficult to find which OPPs are active at the moment, specially
> if there are multiple OPPs with same frequency available in the device
> tree (controlled by supported hardware feature).
> 
> Expose name of the DT node to find out the exact OPP.
> 
> While at it, also expose level field.
> 
> Reported-by: Leo Yan <leo.yan@linaro.org>
> Signed-off-by: Viresh Kumar <viresh.kumar@linaro.org>

Thanks a lot for patch.  I verified it:

Tested-by: Leo Yan <leo.yan@linaro.org>

> ---
>  drivers/opp/debugfs.c | 5 +++++
>  drivers/opp/opp.h     | 1 +
>  2 files changed, 6 insertions(+)
> 
> diff --git a/drivers/opp/debugfs.c b/drivers/opp/debugfs.c
> index 596c185b5dda..b5f2f9f39392 100644
> --- a/drivers/opp/debugfs.c
> +++ b/drivers/opp/debugfs.c
> @@ -10,6 +10,7 @@
>  #include <linux/debugfs.h>
>  #include <linux/device.h>
>  #include <linux/err.h>
> +#include <linux/of.h>
>  #include <linux/init.h>
>  #include <linux/limits.h>
>  #include <linux/slab.h>
> @@ -131,9 +132,13 @@ void opp_debug_create_one(struct dev_pm_opp *opp, struct opp_table *opp_table)
>  	debugfs_create_bool("suspend", S_IRUGO, d, &opp->suspend);
>  	debugfs_create_u32("performance_state", S_IRUGO, d, &opp->pstate);
>  	debugfs_create_ulong("rate_hz", S_IRUGO, d, &opp->rate);
> +	debugfs_create_u32("level", S_IRUGO, d, &opp->level);
>  	debugfs_create_ulong("clock_latency_ns", S_IRUGO, d,
>  			     &opp->clock_latency_ns);
>  
> +	opp->of_name = of_node_full_name(opp->np);
> +	debugfs_create_str("of_name", S_IRUGO, d, (char **)&opp->of_name);
> +
>  	opp_debug_create_supplies(opp, opp_table, d);
>  	opp_debug_create_bw(opp, opp_table, d);
>  
> diff --git a/drivers/opp/opp.h b/drivers/opp/opp.h
> index 407c3bfe51d9..45e3a55239a1 100644
> --- a/drivers/opp/opp.h
> +++ b/drivers/opp/opp.h
> @@ -96,6 +96,7 @@ struct dev_pm_opp {
>  
>  #ifdef CONFIG_DEBUG_FS
>  	struct dentry *dentry;
> +	const char *of_name;
>  #endif
>  };
>  
> -- 
> 2.31.1.272.g89b43f80a514
> 
