Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2294D31E8D6
	for <lists+linux-pm@lfdr.de>; Thu, 18 Feb 2021 12:00:24 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230458AbhBRKsO (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Thu, 18 Feb 2021 05:48:14 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52688 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230282AbhBRKhh (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Thu, 18 Feb 2021 05:37:37 -0500
Received: from mail-pj1-x102c.google.com (mail-pj1-x102c.google.com [IPv6:2607:f8b0:4864:20::102c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4284EC06178C
        for <linux-pm@vger.kernel.org>; Thu, 18 Feb 2021 02:35:43 -0800 (PST)
Received: by mail-pj1-x102c.google.com with SMTP id c19so1097152pjq.3
        for <linux-pm@vger.kernel.org>; Thu, 18 Feb 2021 02:35:43 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=tHsrb0DYK4lku3a8AnYlDdd6INw/DQti6oTvXdTAcko=;
        b=LdDO9eJw/qbgP0/LCpOnbkjSGBMMN2AU6sn65utGj7Jbua7u3RHte1Ox/HaIXhwAa1
         8WZs8xvJP5LX0JCKAIv0wcvEMVuGI4MBYfuBEEqnBHsMwui4ItoSi7MOzdrCyYXCZMih
         jmv9VGZOheR15KF2A6NvprAkZD/QpuZXEvvqyvk7bKpmpogMJxwticcQJu1V+D7TE/3c
         ezkwqo8856MsFmFSJx0NkN0oKzNAEeyiqNjGOOg/ptNajf7WWTog46DrEXXbC5mvNtjv
         xfhJ5NZ+iDUWHrfYEGRleXN8ft4+SZVzUOB8O0RllCZYf8eaVGm6dbBJoOPG5Enq1Zwk
         nLYQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=tHsrb0DYK4lku3a8AnYlDdd6INw/DQti6oTvXdTAcko=;
        b=IXhC1FydF0XQQsh5ILO4UILKAGXFTuE/ikysroSk7kGMZfd4EV1NyR3vjz/pDODJvV
         do1SreDpaC34Twg3HxiZQXVIWBKAetJLUwCiTcg8SXwGSigLTc4J4B3upvF7VONRaSMa
         3J+mU0WuZgDBYUQbsYOAuAGwaQji/RlYHjZPMz4E1Iter5gSljUMI9YtBdE5V6Y0gLJE
         8vMgD3qgOLo/il85jrSnGZUFBbrIeHgLj8Mxi1W0SIJkIKsw/oA2liU3jTHjouAEMxTj
         n4XdhJX5ojqTq8haAw+5KdUv8hthNiA5w6PQYsuMXzBToALOkcoflj2sR6oPaBHScEh4
         uvRw==
X-Gm-Message-State: AOAM532PEHTQhaZTzpDMnCCWULlWea3X17phIudMhrvwiJHcGT6O3/x9
        d7TOhqhYIckRS0V/Po4gaBUWOg==
X-Google-Smtp-Source: ABdhPJxQm2bKWc2RQXMTCauGvO51yB4Estxp63HbHEwUBI1tly6FVkm3dSOXS/hj6Pnmun84byamxA==
X-Received: by 2002:a17:903:2285:b029:e1:58a2:b937 with SMTP id b5-20020a1709032285b02900e158a2b937mr3536248plh.68.1613644542659;
        Thu, 18 Feb 2021 02:35:42 -0800 (PST)
Received: from localhost ([122.172.59.240])
        by smtp.gmail.com with ESMTPSA id z2sm5627390pfa.121.2021.02.18.02.35.41
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 18 Feb 2021 02:35:42 -0800 (PST)
Date:   Thu, 18 Feb 2021 16:05:39 +0530
From:   Viresh Kumar <viresh.kumar@linaro.org>
To:     Nicola Mazzucato <nicola.mazzucato@arm.com>
Cc:     linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-pm@vger.kernel.org, sudeep.holla@arm.com, rjw@rjwysocki.net,
        vireshk@kernel.org, cristian.marussi@arm.com,
        morten.rasmussen@arm.com, chris.redpath@arm.com,
        ionela.voinescu@arm.com
Subject: Re: [PATCH v7 1/3] scmi-cpufreq: Remove deferred probe
Message-ID: <20210218103539.zkxhqxaivhifmjwj@vireshk-i7>
References: <20210215075139.30772-1-nicola.mazzucato@arm.com>
 <20210215075139.30772-2-nicola.mazzucato@arm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210215075139.30772-2-nicola.mazzucato@arm.com>
User-Agent: NeoMutt/20180716-391-311a52
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

On 15-02-21, 07:51, Nicola Mazzucato wrote:
> The current implementation of the scmi_cpufreq_init() function returns
> -EPROBE_DEFER when the OPP table is not populated. In practice the
> cpufreq core cannot handle this error code.
> Therefore, fix the return value and clarify the error message.
> 
> Reviewed-by: Ionela Voinescu <ionela.voinescu@arm.com>
> Signed-off-by: Nicola Mazzucato <nicola.mazzucato@arm.com>
> ---
>  drivers/cpufreq/scmi-cpufreq.c | 8 +++++---
>  1 file changed, 5 insertions(+), 3 deletions(-)
> 
> diff --git a/drivers/cpufreq/scmi-cpufreq.c b/drivers/cpufreq/scmi-cpufreq.c
> index 491a0a24fb1e..34bf2eb8d465 100644
> --- a/drivers/cpufreq/scmi-cpufreq.c
> +++ b/drivers/cpufreq/scmi-cpufreq.c
> @@ -155,9 +155,11 @@ static int scmi_cpufreq_init(struct cpufreq_policy *policy)
>  
>  	nr_opp = dev_pm_opp_get_opp_count(cpu_dev);
>  	if (nr_opp <= 0) {
> -		dev_dbg(cpu_dev, "OPP table is not ready, deferring probe\n");
> -		ret = -EPROBE_DEFER;
> -		goto out_free_opp;

Why change goto label as well ?

> +		dev_err(cpu_dev, "%s: No OPPs for this device: %d\n",
> +			__func__, ret);
> +
> +		ret = -ENODEV;
> +		goto out_free_priv;
>  	}
>  
>  	priv = kzalloc(sizeof(*priv), GFP_KERNEL);
> -- 
> 2.27.0

-- 
viresh
