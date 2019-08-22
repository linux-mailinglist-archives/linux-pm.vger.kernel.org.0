Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 10AF59898F
	for <lists+linux-pm@lfdr.de>; Thu, 22 Aug 2019 04:43:19 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727493AbfHVCm2 (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Wed, 21 Aug 2019 22:42:28 -0400
Received: from mail-pf1-f195.google.com ([209.85.210.195]:46579 "EHLO
        mail-pf1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726894AbfHVCm1 (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Wed, 21 Aug 2019 22:42:27 -0400
Received: by mail-pf1-f195.google.com with SMTP id q139so2801103pfc.13
        for <linux-pm@vger.kernel.org>; Wed, 21 Aug 2019 19:42:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=NgNbAg8LMhyX90LlgIEI3ox3xP9DSn9WzzFTkSBbr1g=;
        b=nSstffzoNuXC8At32BW8GVT+2kLpVRBo1TbHwgWRM48q3jY1MRhiw5h7peR/OWeLXW
         eUVQ2VyG98El7mw1A2n+pBPOwC/MUH8mgKfijCCj0/HMe0u3sxP7Qv+y9SRCMZYB+FkR
         2bi5hPGHRZHCyhMaUuQVecxaFFDIPxAyZ2rLpN+Ew4Oy7FqOLNUIHztSdVR6v+rm17R7
         KMSthUsQKaXTmh6witGeDW2u4YElAwlNvZsizh1gtAxGvSIcglM3DL2e4HbjIEx3tx7Q
         wQyEtr8ZSKSbF3p4WeMoSSSyZPe8qihdP9TNTfRwIUu1N6Vqoza3pQjuq5OpNz1PSnqh
         LkQQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=NgNbAg8LMhyX90LlgIEI3ox3xP9DSn9WzzFTkSBbr1g=;
        b=C0PbxAayQWTE9FslX25vm5kMErsIBMN4+ksOqpLLjOmoda8DG4cV6Ps10Bk6mP18Jf
         0qjH77+LUxx98sOQ+ao8Xixjm65Jgch8STxYCSvZJgmEhsypymjtjnj/26oGaGRcQ9kb
         WnwkszVby5mC1MA7VqS7xU2PTTtV3H9KYWoZ3v1BkvkmXXgslWfkCaC0ExGd9pSdfhIj
         /LvzqGpjaBRFYXHmnHZAHfa0STQ27zqwUWHGKLdgkyXpILi1or9OJqT51U7x/DK1h4PT
         V0oRBsRyb27tK59NMJDgngEjcg+cn4p1I5FAoxjkFrNkYosmIP3AyNDQP5hvAAL9YbHL
         b85g==
X-Gm-Message-State: APjAAAW0e16yy4+OUPQWRe+5ZIXXHEG4lGWPvGrRaZE2MSqif90ZCKbZ
        96LKkMrKjsHrnF9KsUnxbgGzSQiJLv4=
X-Google-Smtp-Source: APXvYqwlT9owBX9i8KeoniR31rqUbD2ekZHttd7fvbTto1FEW78Fcq7E+nLkn2nOL4T0dvqDef9yOQ==
X-Received: by 2002:a62:2c93:: with SMTP id s141mr39038219pfs.114.1566441747058;
        Wed, 21 Aug 2019 19:42:27 -0700 (PDT)
Received: from localhost ([122.172.76.219])
        by smtp.gmail.com with ESMTPSA id d12sm24803245pfn.11.2019.08.21.19.42.26
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 21 Aug 2019 19:42:26 -0700 (PDT)
Date:   Thu, 22 Aug 2019 08:12:22 +0530
From:   Viresh Kumar <viresh.kumar@linaro.org>
To:     Florian Fainelli <f.fainelli@gmail.com>
Cc:     linux-kernel@vger.kernel.org,
        "Rafael J. Wysocki" <rjw@rjwysocki.net>,
        "open list:CPU FREQUENCY SCALING FRAMEWORK" 
        <linux-pm@vger.kernel.org>
Subject: Re: [PATCH] cpufreq: Print driver name if cpufreq_suspend() fails
Message-ID: <20190822024221.wt7mx2zrm3fetnjp@vireshk-i7>
References: <20190821231632.29133-1-f.fainelli@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190821231632.29133-1-f.fainelli@gmail.com>
User-Agent: NeoMutt/20180716-391-311a52
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

On 21-08-19, 16:16, Florian Fainelli wrote:
> Instead of printing the policy, which is incidentally a kernel pointer,
> so with limited interest, print the cpufreq driver name that failed to
> be suspend, which is more useful for debugging.
> 
> Fixes: 2f0aea936360 ("cpufreq: suspend governors on system suspend/hibernate")

I will drop this tag as this isn't a bug really.

> Signed-off-by: Florian Fainelli <f.fainelli@gmail.com>
> ---
>  drivers/cpufreq/cpufreq.c | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)
> 
> diff --git a/drivers/cpufreq/cpufreq.c b/drivers/cpufreq/cpufreq.c
> index c28ebf2810f1..330d789f81fc 100644
> --- a/drivers/cpufreq/cpufreq.c
> +++ b/drivers/cpufreq/cpufreq.c
> @@ -1807,8 +1807,8 @@ void cpufreq_suspend(void)
>  		}
>  
>  		if (cpufreq_driver->suspend && cpufreq_driver->suspend(policy))
> -			pr_err("%s: Failed to suspend driver: %p\n", __func__,
> -				policy);
> +			pr_err("%s: Failed to suspend driver: %s\n", __func__,
> +				cpufreq_driver->name);
>  	}
>  
>  suspend:

Acked-by: Viresh Kumar <viresh.kumar@linaro.org>

-- 
viresh
