Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6C28721099A
	for <lists+linux-pm@lfdr.de>; Wed,  1 Jul 2020 12:46:23 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729926AbgGAKqW (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Wed, 1 Jul 2020 06:46:22 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44150 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729849AbgGAKqV (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Wed, 1 Jul 2020 06:46:21 -0400
Received: from mail-pl1-x643.google.com (mail-pl1-x643.google.com [IPv6:2607:f8b0:4864:20::643])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 940F4C061755
        for <linux-pm@vger.kernel.org>; Wed,  1 Jul 2020 03:46:21 -0700 (PDT)
Received: by mail-pl1-x643.google.com with SMTP id bf7so438364plb.2
        for <linux-pm@vger.kernel.org>; Wed, 01 Jul 2020 03:46:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=ZAwIqiRySDiFfmgD/1oQKpgA8/Glycu71hEVY2X/5aI=;
        b=Y2MZvUMxug59kJ6DDiLOpxa9zz6EJSdJWxnPjurraa6ShY+zwguiLuVARBo2GsYARE
         sCBkYAjnk8pxDw6oB8oYB32xL2alGAVqRPY9f4ka1qooiZvIZ1rQFc2RCSl9hXErdZ8O
         l2R+I1SFM5l9TUuGSKCN/nXFxiXTCkqe7NcMZ8WZ18FSTMVVQiDxRLRWt3TjHIRIHxZa
         lw3/CrMZTs/Xla60Ez35dHPn+j7pFdAAX9vfqeviEf+R2//EnfHkS/+0uek5aH0NP7M0
         /GZvpAXruFM3RGb9Gw2a9FvZjV35rJRNtOSbVmVTrP5TuYIhV201UAKxQOKMieYx4mlB
         1+ZQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=ZAwIqiRySDiFfmgD/1oQKpgA8/Glycu71hEVY2X/5aI=;
        b=FyUtKNc+kp6UA0mAcGzSB+c8YUcawD0ri0/eY/AWvb3dx0rNdF6e+sr0IrsXrwoE8g
         yzY/eZBxTfd/0RMG4cjm3lN1vV3L3khcvZ9I+fmwQ1o4JyZfuKCvDt9bpINbYfgdw0rI
         uI5kdvbRkZvrBip60FtBzXsscsRXbfNHTWaAgHo1Gzt7VLTCVoFt7Y69n47KzCuN54ni
         INZ60cm00jHIUqRjJGOmMuLYpSPiLiy1R3l+aeibRzzdB4Ys6TS0qLAbcA2zNOtIkyOl
         rJyteSQUfpngG5GBexXVnoa/NG8/Slrk0RXH5YLH9NHi2ovfOcJVib3a8IVQravXmQCr
         GgBw==
X-Gm-Message-State: AOAM5337e3yPZvO7USWtNEBUoQMRrwrMipZN71EmpgQdW1dtpv5FhB2T
        z2DdXfinJdBXmzvfOg/psrhqZyJhY7o=
X-Google-Smtp-Source: ABdhPJxPFfNLz+aE4EPYb5tQdrUGE5weML5br9ZUPuFYPAJytDY8xi4+x275Aqh4ljhNNfYUKKeflg==
X-Received: by 2002:a17:902:8d89:: with SMTP id v9mr21290407plo.191.1593600381045;
        Wed, 01 Jul 2020 03:46:21 -0700 (PDT)
Received: from localhost ([122.172.81.75])
        by smtp.gmail.com with ESMTPSA id d16sm5413722pfo.156.2020.07.01.03.46.19
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 01 Jul 2020 03:46:19 -0700 (PDT)
Date:   Wed, 1 Jul 2020 16:16:17 +0530
From:   Viresh Kumar <viresh.kumar@linaro.org>
To:     Ionela Voinescu <ionela.voinescu@arm.com>
Cc:     rjw@rjwysocki.net, catalin.marinas@arm.com, sudeep.holla@arm.com,
        will@kernel.org, linux@armlinux.org.uk, valentin.schneider@arm.com,
        mingo@redhat.com, peterz@infradead.org, dietmar.eggemann@arm.com,
        linux-pm@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH 1/8] cpufreq: allow drivers to flag custom support for
 freq invariance
Message-ID: <20200701094417.ffuvduz6pqknjcks@vireshk-i7>
References: <20200701090751.7543-1-ionela.voinescu@arm.com>
 <20200701090751.7543-2-ionela.voinescu@arm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200701090751.7543-2-ionela.voinescu@arm.com>
User-Agent: NeoMutt/20180716-391-311a52
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

On 01-07-20, 10:07, Ionela Voinescu wrote:
> diff --git a/include/linux/cpufreq.h b/include/linux/cpufreq.h
> index 3494f6763597..42668588f9f8 100644
> --- a/include/linux/cpufreq.h
> +++ b/include/linux/cpufreq.h
> @@ -293,7 +293,7 @@ __ATTR(_name, 0644, show_##_name, store_##_name)
>  
>  struct cpufreq_driver {
>  	char		name[CPUFREQ_NAME_LEN];
> -	u8		flags;
> +	u16		flags;

Lets make it u32.

>  	void		*driver_data;
>  
>  	/* needed by all drivers */
> @@ -417,6 +417,14 @@ struct cpufreq_driver {
>   */
>  #define CPUFREQ_IS_COOLING_DEV			BIT(7)
>  
> +/*
> + * Set by drivers which implement the necessary calls to the scheduler's
> + * frequency invariance engine. The use of this flag will result in the
> + * default arch_set_freq_scale calls being skipped in favour of custom
> + * driver calls.
> + */
> +#define CPUFREQ_CUSTOM_SET_FREQ_SCALE		BIT(8)

I will rather suggest CPUFREQ_SKIP_SET_FREQ_SCALE as the name and
functionality. We need to give drivers a choice if they do not want
the core to do it on their behalf, because they are doing it on their
own or they don't want to do it.

-- 
viresh
