Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id BFD4591D6D
	for <lists+linux-pm@lfdr.de>; Mon, 19 Aug 2019 08:58:35 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726742AbfHSG6R (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Mon, 19 Aug 2019 02:58:17 -0400
Received: from mail-pf1-f195.google.com ([209.85.210.195]:36075 "EHLO
        mail-pf1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726261AbfHSG6R (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Mon, 19 Aug 2019 02:58:17 -0400
Received: by mail-pf1-f195.google.com with SMTP id w2so613776pfi.3
        for <linux-pm@vger.kernel.org>; Sun, 18 Aug 2019 23:58:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=HvtA+GBfwHC8fvnaQIIJLLxWYh1rn1153XxRWvxFdUs=;
        b=P3rK6cja54D8TRyXeXPYfTuuwH5EeJR6miORU5/Kef4uXdnOfRpQE6kC2Vx8+smA4u
         zhar+VQMpglRiotAhkMB5M6KLLM+0mIcJIGWxk+xdbnP8w8kZmTVVYAAEVJpYsFH4jtD
         GcIzCPRcMWH3f5JHBPgNaFkRg0DUXIIuLamFhbKMg2HiPLPUN2rb9+rFSzJXp75fbLHx
         Gv5bk4ZdFoEHuwr7EyUSc1p5UoLLng6CzOQUp179nmdihHBt/hSIhTsB20Rr9tr8LbQ7
         ENeyGHfHo79eaE6efoimOa+FG1sYtV34yLMiZfJuhpSvgmufUDZJYCoVey+cMjxlmOCU
         w4jw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=HvtA+GBfwHC8fvnaQIIJLLxWYh1rn1153XxRWvxFdUs=;
        b=T8a51aBWXeu9mv8/nCA2ryEmkMqPjNJy6heP2ZmQUPq0qSAXVkIAX59y5gv43kEoJ+
         bL+8UqOuXJSbYN/v2KbMeOh/A4nT6XmIguo+HnUWp27/IAFu3DispUnVy7hnHvOstiWs
         ZPKyGztkoNxT8uF0MNHlhOa/B5hlcrsRwfk/vwU4wGfJqMd+QKl5Fueaoi7oDygrEjqs
         wpRxKTmcTkULH7C5L0A2micjb1T70WHC47VfNILQNJUyzFSuvgYQuz0/WH5ifwQs+G02
         HM62hD3xt9bPcJeUuIhqk7n9O0rVaFtZM5wSuKXEqEABKG52NCYidO78lU14W4qnEYsx
         A2bA==
X-Gm-Message-State: APjAAAXfgOrEH87Uy2pd4/ks0a8U9iaEPLKWK2XtM0pfKesaLrpMv4mO
        vOskX0wv6cn7tjqF3OtuIl/Tzg==
X-Google-Smtp-Source: APXvYqwmUeKAoNB6rJXK3rhuM5Ub/Wsz5p7XsyHuL0fBQNYaNS4bX0+QSzbe0jQR1GcmLgMOHn1YaA==
X-Received: by 2002:a62:e910:: with SMTP id j16mr23217505pfh.123.1566197896522;
        Sun, 18 Aug 2019 23:58:16 -0700 (PDT)
Received: from localhost ([122.172.76.219])
        by smtp.gmail.com with ESMTPSA id f14sm15662246pfn.53.2019.08.18.23.58.15
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Sun, 18 Aug 2019 23:58:15 -0700 (PDT)
Date:   Mon, 19 Aug 2019 12:28:14 +0530
From:   Viresh Kumar <viresh.kumar@linaro.org>
To:     Colin King <colin.king@canonical.com>
Cc:     "Rafael J . Wysocki" <rjw@rjwysocki.net>, linux-pm@vger.kernel.org,
        kernel-janitors@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] cpufreq: remove redundant assignment to ret
Message-ID: <20190819065814.333kowws4mpw3qfx@vireshk-i7>
References: <20190813122121.28160-1-colin.king@canonical.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190813122121.28160-1-colin.king@canonical.com>
User-Agent: NeoMutt/20180716-391-311a52
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

On 13-08-19, 13:21, Colin King wrote:
> From: Colin Ian King <colin.king@canonical.com>
> 
> Variable ret is initialized to a value that is never read and it is
> re-assigned later. The initialization is redundant and can be removed.
> 
> Addresses-Coverity: ("Unused value")
> Signed-off-by: Colin Ian King <colin.king@canonical.com>
> ---
>  drivers/cpufreq/cpufreq.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/drivers/cpufreq/cpufreq.c b/drivers/cpufreq/cpufreq.c
> index c28ebf2810f1..26d82e0a2de5 100644
> --- a/drivers/cpufreq/cpufreq.c
> +++ b/drivers/cpufreq/cpufreq.c
> @@ -2140,7 +2140,7 @@ int cpufreq_driver_target(struct cpufreq_policy *policy,
>  			  unsigned int target_freq,
>  			  unsigned int relation)
>  {
> -	int ret = -EINVAL;
> +	int ret;
>  
>  	down_write(&policy->rwsem);
>  

Acked-by: Viresh Kumar <viresh.kumar@linaro.org>

-- 
viresh
