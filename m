Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id BCDDB61A9A
	for <lists+linux-pm@lfdr.de>; Mon,  8 Jul 2019 08:27:12 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728629AbfGHG1L (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Mon, 8 Jul 2019 02:27:11 -0400
Received: from mail-pl1-f193.google.com ([209.85.214.193]:33402 "EHLO
        mail-pl1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727452AbfGHG1L (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Mon, 8 Jul 2019 02:27:11 -0400
Received: by mail-pl1-f193.google.com with SMTP id c14so7694808plo.0
        for <linux-pm@vger.kernel.org>; Sun, 07 Jul 2019 23:27:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=PvaTWFd0jIyj/jWh/gLuDIg+Wz9VdaFcROd1jUU6H5M=;
        b=wHrS2MKgp/qpIFuWhyshvwk7x2tGKyT32qYGZauN0EYywHuPJyrg5ulDYUNFbZ4QNO
         58Ztvc5wOabwQGRa4Lv6Rk28SjdXgvagQt6yX931q03CfOsah3bf/t5myrB0Vs1+YgHF
         LY6zSMxF3ql+oh9z3joSHf/Twfb/WwJX+iZrHMK2G+yWniFiHStbYMpn0jI+qzUXlS0T
         9JoAFd849ZRHJeTmodQFaDLNDP3/J46tcyp4vzEXo6BRtWbP5Fu6mwdWymT/DrOSdmUJ
         ZImcGLQkaDli0BPtB5r0kbTt7aoUXMpGefJy2w7ISitK0rrwfC75uthm9iXe6nYU5duR
         9Tlg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=PvaTWFd0jIyj/jWh/gLuDIg+Wz9VdaFcROd1jUU6H5M=;
        b=Ak9AcqNdiiB/1seih+rvVYcTyVwXMZoD2UCn7WxhuggUHmiXtdO7P5FrNePqNMp9Ct
         b4M7pWvWDMg/zIibK6tXMkypcGluyKmOUNvH6xy26utLGA/2QjL9KnIxTtWfNX1v2VXU
         /GgsnizOA+ZEXC8u2LrUYyC5YEpyS1BnoHpk59k9HbEsSvQNVyn//Gw70LgDt1mC/yXm
         MplHPDkcobhUNLRcZiAGZIaMfSd2jhqtm8h7sjhYJ71Irdgz5RFwc0D04kcXolNphEEn
         +1lLvF7imzOJjO2awbz7HVDYGJ/lM9FqoOXj8wnNey5KPcQ8jMVwVcM89AnZTvAtVXSF
         MASw==
X-Gm-Message-State: APjAAAXganX+yLgGfUMI0xSHEFv05wL/D3y8BPoiHqNJ75CZnmSl0cBr
        JDAaWq5ACdzJg4mumdi4a/7xjA==
X-Google-Smtp-Source: APXvYqwRjKnkWqnGnTkhQ05etsgpHpjlfberNuCPbKjt7IDKyX3jURUFRxp7JkDCe8+PHZdI8BnNTg==
X-Received: by 2002:a17:902:f301:: with SMTP id gb1mr21987709plb.292.1562567230900;
        Sun, 07 Jul 2019 23:27:10 -0700 (PDT)
Received: from localhost ([122.172.28.117])
        by smtp.gmail.com with ESMTPSA id v10sm17791814pfe.163.2019.07.07.23.27.10
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Sun, 07 Jul 2019 23:27:10 -0700 (PDT)
Date:   Mon, 8 Jul 2019 11:57:08 +0530
From:   Viresh Kumar <viresh.kumar@linaro.org>
To:     Wen Yang <wen.yang99@zte.com.cn>
Cc:     linux-kernel@vger.kernel.org, xue.zhihong@zte.com.cn,
        wang.yi59@zte.com.cn, cheng.shengyu@zte.com.cn,
        "Rafael J. Wysocki" <rjw@rjwysocki.net>,
        linuxppc-dev@lists.ozlabs.org, linux-pm@vger.kernel.org
Subject: Re: [PATCH] cpufreq/pasemi: fix an use-after-free in
 pas_cpufreq_cpu_init()
Message-ID: <20190708062708.5zufqsmgso436idn@vireshk-i7>
References: <1562566745-7447-1-git-send-email-wen.yang99@zte.com.cn>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1562566745-7447-1-git-send-email-wen.yang99@zte.com.cn>
User-Agent: NeoMutt/20180716-391-311a52
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

On 08-07-19, 14:19, Wen Yang wrote:
> The cpu variable is still being used in the of_get_property() call
> after the of_node_put() call, which may result in use-after-free.
> 
> Fixes: a9acc26b75f ("cpufreq/pasemi: fix possible object reference leak")
> Signed-off-by: Wen Yang <wen.yang99@zte.com.cn>
> Cc: "Rafael J. Wysocki" <rjw@rjwysocki.net>
> Cc: Viresh Kumar <viresh.kumar@linaro.org>
> Cc: linuxppc-dev@lists.ozlabs.org
> Cc: linux-pm@vger.kernel.org
> Cc: linux-kernel@vger.kernel.org
> ---
>  drivers/cpufreq/pasemi-cpufreq.c | 10 ++++++----
>  1 file changed, 6 insertions(+), 4 deletions(-)

I will suggest some changes here.

> diff --git a/drivers/cpufreq/pasemi-cpufreq.c b/drivers/cpufreq/pasemi-cpufreq.c
> index 6b1e4ab..d2dd47b 100644
> --- a/drivers/cpufreq/pasemi-cpufreq.c
> +++ b/drivers/cpufreq/pasemi-cpufreq.c
> @@ -132,7 +132,6 @@ static int pas_cpufreq_cpu_init(struct cpufreq_policy *policy)

Don't initialize "err" anymore.

>  	cpu = of_get_cpu_node(policy->cpu, NULL);
>  
> -	of_node_put(cpu);
>  	if (!cpu)
>  		goto out;

Do return -ENODEV; here.

>  
> @@ -141,15 +140,15 @@ static int pas_cpufreq_cpu_init(struct cpufreq_policy *policy)
>  		dn = of_find_compatible_node(NULL, NULL,
>  					     "pasemi,pwrficient-sdc");
>  	if (!dn)
> -		goto out;
> +		goto out_put_cpu_node;
>  	err = of_address_to_resource(dn, 0, &res);
>  	of_node_put(dn);
>  	if (err)
> -		goto out;
> +		goto out_put_cpu_node;
>  	sdcasr_mapbase = ioremap(res.start + SDCASR_OFFSET, 0x2000);
>  	if (!sdcasr_mapbase) {
>  		err = -EINVAL;
> -		goto out;
> +		goto out_put_cpu_node;
>  	}

Don't do above changes.

>  
>  	dn = of_find_compatible_node(NULL, NULL, "1682m-gizmo");
> @@ -177,6 +176,7 @@ static int pas_cpufreq_cpu_init(struct cpufreq_policy *policy)
>  		err = -EINVAL;
>  		goto out_unmap_sdcpwr;
>  	}
> +	of_node_put(cpu);
>  
>  	/* we need the freq in kHz */
>  	max_freq = *max_freqp / 1000;
> @@ -203,6 +203,8 @@ static int pas_cpufreq_cpu_init(struct cpufreq_policy *policy)
>  
>  out_unmap_sdcasr:
>  	iounmap(sdcasr_mapbase);
> +out_put_cpu_node:

Don't add this label, instead use "out" for also having the below
code.

> +	of_node_put(cpu);
>  out:
>  	return err;
>  }
> -- 
> 2.9.5

-- 
viresh
