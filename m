Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 90E8ADB97
	for <lists+linux-pm@lfdr.de>; Mon, 29 Apr 2019 07:42:08 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726139AbfD2FmH (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Mon, 29 Apr 2019 01:42:07 -0400
Received: from mail-pl1-f193.google.com ([209.85.214.193]:45938 "EHLO
        mail-pl1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725958AbfD2FmH (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Mon, 29 Apr 2019 01:42:07 -0400
Received: by mail-pl1-f193.google.com with SMTP id o5so4518002pls.12
        for <linux-pm@vger.kernel.org>; Sun, 28 Apr 2019 22:42:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=4PjAN5s35KxrA6O3yAA2lOmnSIef/BNqc8isfj39WhE=;
        b=jh5EG8imvPRR5+ZwVzEh0Xx+N7ceW3FeXLCJL4Z6NOXmZRLbmZKKM9dfIKK/8dd+Eb
         KUYBsI8M72yVrlDRZqYC5556mnm6VBAHTf4+OH4HYk1c6iPf1xppSQsxSZzCMM8vvOdF
         rCya+KqtCaCkMC6U1XiAj66rzQol6L1fdJNKnRikjOvfwgg18xzkRfPBbD0zHvN9w0VL
         w/2NMwHBj9QJFS7P4YWmY8BJxkqcz7z1OZzF2WC/ItXMWLt+wTq58bcqj4OOjPinFxa0
         Ru7Edij6GmeG/oseRVbhYox1aCIvX/6LiLdj6PM6KGrdgGvkMZ/OvclTDioNjqrtpyW8
         39Pw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=4PjAN5s35KxrA6O3yAA2lOmnSIef/BNqc8isfj39WhE=;
        b=fGgYMjt40Ta3GXb2CXzTb7v7/uGqlEuOqTXGstoffh4fhpNBbtoWlEdthtd+s9tbkT
         AKNJO6SVxCP1p39ynmPEaubC6wrJdwy+xsPx5Nt0jrY3oU/ma3dCjScuwYcZHM/kvwTV
         bq9wPgGk98aF3PAV0EqvZ8/yikDsnUi9pEM4kGNUCcc4ftOe7k5SS9kL7lZnXp1fWvCW
         z5+phJp93KWwBcQGSaWwUJ89Xy6oFwKrDVwaiKCatP9mVfHLkIFIHaHDQ1qWz7vVW9m+
         JeD5KJCUHcxPfb39fn/vgeZv090T9C1Rnmd7RIgFxka6AZMR5tFEQPlMqhrx9bzRwEUq
         H+uQ==
X-Gm-Message-State: APjAAAUgqPc5Grx/Kertn0SRIyqf6NM9ty8tUyup2pa9Ia83A9UDYiYN
        n9XrF8UPHB0VLWU8pgigGcdeJg==
X-Google-Smtp-Source: APXvYqxgUSrDrujXKTktv58TTpqZ9C0p6n7njOqZ8FEIm+HZ0MutLyLiHvIX7IlgFUWA2at6/UOZIA==
X-Received: by 2002:a17:902:7241:: with SMTP id c1mr8092060pll.326.1556516526669;
        Sun, 28 Apr 2019 22:42:06 -0700 (PDT)
Received: from localhost ([122.166.139.136])
        by smtp.gmail.com with ESMTPSA id r197sm22007561pfc.178.2019.04.28.22.42.04
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Sun, 28 Apr 2019 22:42:05 -0700 (PDT)
Date:   Mon, 29 Apr 2019 11:12:03 +0530
From:   Viresh Kumar <viresh.kumar@linaro.org>
To:     dongjian <dj0227@163.com>
Cc:     rjw@rjwysocki.net, linux-pm@vger.kernel.org, dongjian@yulong.com,
        huyue2@yulong.com
Subject: Re: [PATCH] cpufreq: Fix centrino_setpolicy to centrino_target
Message-ID: <20190429054203.wwjpqkotbmmpcij2@vireshk-i7>
References: <20190428085417.16156-1-dj0227@163.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190428085417.16156-1-dj0227@163.com>
User-Agent: NeoMutt/20180323-120-3dd1ac
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

On 28-04-19, 16:54, dongjian wrote:
> From: dongjian <dongjian@yulong.com>
> 
> The code is using centrino_target rather than centrino_setpolicy.
> 
> Signed-off-by: dongjian <dongjian@yulong.com>
> ---
>  drivers/cpufreq/speedstep-centrino.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/drivers/cpufreq/speedstep-centrino.c b/drivers/cpufreq/speedstep-centrino.c
> index 7d4a315..26fab0c 100644
> --- a/drivers/cpufreq/speedstep-centrino.c
> +++ b/drivers/cpufreq/speedstep-centrino.c
> @@ -412,7 +412,7 @@ static int centrino_cpu_exit(struct cpufreq_policy *policy)
>  }
>  
>  /**
> - * centrino_setpolicy - set a new CPUFreq policy
> + * centrino_target - set a new CPUFreq policy
>   * @policy: new policy
>   * @index: index of target frequency
>   *

Acked-by: Viresh Kumar <viresh.kumar@linaro.org>

-- 
viresh
