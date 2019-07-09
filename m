Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 4F66C632B9
	for <lists+linux-pm@lfdr.de>; Tue,  9 Jul 2019 10:12:10 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726046AbfGIIMJ (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Tue, 9 Jul 2019 04:12:09 -0400
Received: from mail-pl1-f195.google.com ([209.85.214.195]:46573 "EHLO
        mail-pl1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725975AbfGIIMJ (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Tue, 9 Jul 2019 04:12:09 -0400
Received: by mail-pl1-f195.google.com with SMTP id c2so8105034plz.13
        for <linux-pm@vger.kernel.org>; Tue, 09 Jul 2019 01:12:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=eOuvT6Cckl+GniRg64y9AJ/5rozkkhx3polgR2aQ1Gg=;
        b=p0sVP6ulMvod/W51H37xuLg53Fl+A7Bh19Wz2kvDNDJCRba5OeflOxKLz4VCwk3vBH
         OxhobdOmtfIck0hPhXEgusq0pIkl8iHdl3N3nWWSmB40YunTxHNbS4db/5b7aaZ3LxbL
         6JtBhD4FbnUAb89fDssoCeREhxfNP3HWrxsgayq0PHlA29aKvfj+q3TTRAbdc3E937/U
         tsTDMgouPDMrh5g068LzbdDu/x4kmIbgBkwaietOvRfW5FuuLm5214ZWY6nz688PSwMR
         7btjap/Xfck/KXDQiNfrSAT2G6zkJGnWmJJ5QGFcQuCb2AJ3oz5EvM46B1V2V+3mqOf/
         rP8g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=eOuvT6Cckl+GniRg64y9AJ/5rozkkhx3polgR2aQ1Gg=;
        b=otM8xo5a863/zW3z/wVY7fKlJkzBLqeuApUoMI8+D/q5m+33ahiEf0uNu/bjil1szk
         A7I7jbVePezSlJFrYyphTJNmkTS6XCssvEE/JNC7/Mxuvh2Xpbr6iLuMRs1q8h64xkZg
         9ha8j4wb/fsPOf2QeQFqAKxwJOjiafvpknQbqvAykvgiuBP9XkuXBbg2avsI8c6PGmZk
         sbvkXzg9YA4Knt7tYeBLhppSnBtxKIbybuVgstVA9a+EoidY8Juq8BP3KB7bOJaPmMd3
         oDbRCYQDSq/M2CcbS1O4SOvK+mhGvaeuITK/GNIsg3qovHAEXd22HAgp77qtiA3gqHpP
         CcjQ==
X-Gm-Message-State: APjAAAUApZrDw/WRu+ILNnW6yIJSd/vSe2QNoJhvckhJQtA+VHLNWroy
        ihhQQhpVedql+fcZjcK4JWIuCw==
X-Google-Smtp-Source: APXvYqyba7DGNCtta2YQmlEVmhFZ7couczowCm4W1ouKSK5ZaSHTVWK5GxIV6Rk69Zyj4e8ga2Xfsg==
X-Received: by 2002:a17:902:8207:: with SMTP id x7mr30445929pln.63.1562659928360;
        Tue, 09 Jul 2019 01:12:08 -0700 (PDT)
Received: from localhost ([122.172.28.117])
        by smtp.gmail.com with ESMTPSA id l1sm22620240pfl.9.2019.07.09.01.12.07
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 09 Jul 2019 01:12:07 -0700 (PDT)
Date:   Tue, 9 Jul 2019 13:42:05 +0530
From:   Viresh Kumar <viresh.kumar@linaro.org>
To:     Wen Yang <wen.yang99@zte.com.cn>
Cc:     linux-kernel@vger.kernel.org, xue.zhihong@zte.com.cn,
        wang.yi59@zte.com.cn, cheng.shengyu@zte.com.cn,
        "Rafael J. Wysocki" <rjw@rjwysocki.net>,
        Michael Ellerman <mpe@ellerman.id.au>,
        linuxppc-dev@lists.ozlabs.org, linux-pm@vger.kernel.org
Subject: Re: [PATCH v5] cpufreq/pasemi: fix an use-after-free in
 pas_cpufreq_cpu_init()
Message-ID: <20190709081205.a5sjsqo2el6zt24b@vireshk-i7>
References: <1562659447-39989-1-git-send-email-wen.yang99@zte.com.cn>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1562659447-39989-1-git-send-email-wen.yang99@zte.com.cn>
User-Agent: NeoMutt/20180716-391-311a52
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

On 09-07-19, 16:04, Wen Yang wrote:
> The cpu variable is still being used in the of_get_property() call
> after the of_node_put() call, which may result in use-after-free.
> 
> Fixes: a9acc26b75f ("cpufreq/pasemi: fix possible object reference leak")
> Signed-off-by: Wen Yang <wen.yang99@zte.com.cn>
> Cc: "Rafael J. Wysocki" <rjw@rjwysocki.net>
> Cc: Viresh Kumar <viresh.kumar@linaro.org>
> Cc: Michael Ellerman <mpe@ellerman.id.au>
> Cc: linuxppc-dev@lists.ozlabs.org
> Cc: linux-pm@vger.kernel.org
> Cc: linux-kernel@vger.kernel.org
> ---
> v5: put together the code to get, use, and release cpu device_node.
> v4: restore the blank line.
> v3: fix a leaked reference.
> v2: clean up the code according to the advice of viresh.
> 
>  drivers/cpufreq/pasemi-cpufreq.c | 21 +++++++++------------
>  1 file changed, 9 insertions(+), 12 deletions(-)
> 
> diff --git a/drivers/cpufreq/pasemi-cpufreq.c b/drivers/cpufreq/pasemi-cpufreq.c
> index 6b1e4ab..1f0beb7 100644
> --- a/drivers/cpufreq/pasemi-cpufreq.c
> +++ b/drivers/cpufreq/pasemi-cpufreq.c
> @@ -131,10 +131,17 @@ static int pas_cpufreq_cpu_init(struct cpufreq_policy *policy)
>  	int err = -ENODEV;
>  
>  	cpu = of_get_cpu_node(policy->cpu, NULL);
> -
> -	of_node_put(cpu);
>  	if (!cpu)
>  		goto out;

I would have loved a blank line here :)

> +	max_freqp = of_get_property(cpu, "clock-frequency", NULL);
> +	of_node_put(cpu);
> +	if (!max_freqp) {
> +		err = -EINVAL;
> +		goto out;
> +	}
> +
> +	/* we need the freq in kHz */
> +	max_freq = *max_freqp / 1000;
>  
>  	dn = of_find_compatible_node(NULL, NULL, "1682m-sdc");
>  	if (!dn)
> @@ -171,16 +178,6 @@ static int pas_cpufreq_cpu_init(struct cpufreq_policy *policy)
>  	}
>  
>  	pr_debug("init cpufreq on CPU %d\n", policy->cpu);
> -
> -	max_freqp = of_get_property(cpu, "clock-frequency", NULL);
> -	if (!max_freqp) {
> -		err = -EINVAL;
> -		goto out_unmap_sdcpwr;
> -	}
> -
> -	/* we need the freq in kHz */
> -	max_freq = *max_freqp / 1000;
> -
>  	pr_debug("max clock-frequency is at %u kHz\n", max_freq);
>  	pr_debug("initializing frequency table\n");

Though, enough versions have happened now.

Acked-by: Viresh Kumar <viresh.kumar@linaro.org>

-- 
viresh
