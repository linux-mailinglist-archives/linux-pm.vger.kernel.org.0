Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id ACBAF3AD1F2
	for <lists+linux-pm@lfdr.de>; Fri, 18 Jun 2021 20:16:44 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235140AbhFRSSv (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Fri, 18 Jun 2021 14:18:51 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40456 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235005AbhFRSSv (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Fri, 18 Jun 2021 14:18:51 -0400
Received: from mail-oi1-x232.google.com (mail-oi1-x232.google.com [IPv6:2607:f8b0:4864:20::232])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B63EFC06175F
        for <linux-pm@vger.kernel.org>; Fri, 18 Jun 2021 11:16:41 -0700 (PDT)
Received: by mail-oi1-x232.google.com with SMTP id s17so2709910oij.11
        for <linux-pm@vger.kernel.org>; Fri, 18 Jun 2021 11:16:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=7nPUjc8QA8UoxeQQWsD1UQARcs1YVj1sKwBdqRAk8Q8=;
        b=PHiVcGzVJuHJlg20MflDvGrcV6QmQqNDQPo1eXlcu0MkkFtxNyjn/o4p5oCK6CQ98y
         qvsuDygUlGKFnIHlmDQ7SmgVxktLOCFAeqtlGXmiWlJia9u5L8pzgrv6ZNT40hGdlGjU
         Jhk9eMCcOeNK0Sn86SmZgLAJDo3gtoQCDSxtnvePgM6VNT7R+4xZW/zvTTGbv3XQKySp
         gbJ6CguaXCVTsvr/xNFhoCFq7ZqIAkAH7zZ+A+M259FRh1hOxtnmt0ioYcFSHXCuruZS
         FikDCXnejHBAVd+SUz4O1uh1QDDAXv5z2lUNxBnNi38OfWZ+TeOIftu3gwv+9NCOyYEY
         87MA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=7nPUjc8QA8UoxeQQWsD1UQARcs1YVj1sKwBdqRAk8Q8=;
        b=sT1ZP6D3dz20vyjuPy4JMpAX3UKGYHZdOB5m/nF8QpUV3NFnjskssm9nkTrmOTt0QY
         KbaLRr9/g/vtujcyWC20tg7g2Re2pFZ3T7YJ2srFz1W0kT8M5Y1ZsBRLQI8jvQ+1QBKV
         ccNKBvxkKrVpkZy/1a3TjRxNYpb6xy5slopI5oUps/d6NRzS2iZUbbQmDitDFZkRUZFO
         Nx+zryop73VHUJpytGoAxIg+F6rddy3oTp1z2uA6IABrnTa7iTiwe5ITVI/s++7pTbbp
         vwZOLArYbY/+yQyV+wiX6gszsqrtEUTwyYRuNp/6E8SF4xc//oCfHLr9JFfx42MWB3HC
         LdLg==
X-Gm-Message-State: AOAM533GGlB3gUBDsgdfhpDwVbeGj/WNpFtIqZZqIqwi9w2S7JDFVt1V
        hUnbxIkws4lBiLs4Z9Ypj04STQ==
X-Google-Smtp-Source: ABdhPJyJXeeqVdpN6DYy0aD5HSeiFIYVMzlBgxfttmArEwuGWH+9xVpFuzfw2Fm0sJnXavoJbWdrFA==
X-Received: by 2002:a05:6808:1148:: with SMTP id u8mr8092340oiu.125.1624040201036;
        Fri, 18 Jun 2021 11:16:41 -0700 (PDT)
Received: from builder.lan (104-57-184-186.lightspeed.austtx.sbcglobal.net. [104.57.184.186])
        by smtp.gmail.com with ESMTPSA id c12sm1949076oov.11.2021.06.18.11.16.40
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 18 Jun 2021 11:16:40 -0700 (PDT)
Date:   Fri, 18 Jun 2021 13:16:38 -0500
From:   Bjorn Andersson <bjorn.andersson@linaro.org>
To:     Thara Gopinath <thara.gopinath@linaro.org>
Cc:     agross@kernel.org, rui.zhang@intel.com, daniel.lezcano@linaro.org,
        viresh.kumar@linaro.org, rjw@rjwysocki.net, robh+dt@kernel.org,
        linux-arm-msm@vger.kernel.org, linux-pm@vger.kernel.org,
        linux-kernel@vger.kernel.org, devicetree@vger.kernel.org
Subject: Re: [PATCH 3/5] cpufreq: qcom-cpufreq-hw: Add dcvs interrupt support
Message-ID: <YMzjBvkbITbSIzwf@builder.lan>
References: <20210608222926.2707768-1-thara.gopinath@linaro.org>
 <20210608222926.2707768-4-thara.gopinath@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210608222926.2707768-4-thara.gopinath@linaro.org>
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

On Tue 08 Jun 17:29 CDT 2021, Thara Gopinath wrote:
> diff --git a/drivers/cpufreq/qcom-cpufreq-hw.c b/drivers/cpufreq/qcom-cpufreq-hw.c
[..]
> @@ -305,6 +383,8 @@ static int qcom_cpufreq_hw_cpu_init(struct cpufreq_policy *policy)
>  
>  	index = args.args[0];
>  
> +	lmh_mitigation_enabled = of_property_read_bool(pdev->dev.of_node, "qcom,support-lmh");

Rather than adding a new interrupt _and_ a flag to tell the driver that
this new interrupt should be used, wouldn't it be sufficient to just see
if the interrupt is specified?

> +
>  	res = platform_get_resource(pdev, IORESOURCE_MEM, index);
>  	if (!res) {
>  		dev_err(dev, "failed to get mem resource %d\n", index);
> @@ -329,6 +409,11 @@ static int qcom_cpufreq_hw_cpu_init(struct cpufreq_policy *policy)
>  		goto unmap_base;
>  	}
>  
> +	if (!alloc_cpumask_var(&data->cpus, GFP_KERNEL)) {
> +		ret = -ENOMEM;
> +		goto unmap_base;
> +	}
> +
>  	data->soc_data = of_device_get_match_data(&pdev->dev);
>  	data->base = base;
>  	data->res = res;
> @@ -347,6 +432,7 @@ static int qcom_cpufreq_hw_cpu_init(struct cpufreq_policy *policy)
>  		goto error;
>  	}
>  
> +	cpumask_copy(data->cpus, policy->cpus);
>  	policy->driver_data = data;
>  
>  	ret = qcom_cpufreq_hw_read_lut(cpu_dev, policy);
> @@ -370,6 +456,20 @@ static int qcom_cpufreq_hw_cpu_init(struct cpufreq_policy *policy)
>  			dev_warn(cpu_dev, "failed to enable boost: %d\n", ret);
>  	}
>  
> +	if (lmh_mitigation_enabled) {
> +		data->lmh_dcvs_irq = platform_get_irq(pdev, index);
> +		if (data->lmh_dcvs_irq < 0) {

This will be -ENXIO if the interrupt isn't specified and <0 for other
errors, so you should be able to distinguish the two failure cases.

Regards,
Bjorn

> +			ret = data->lmh_dcvs_irq;
> +			goto error;
> +		}
> +		ret = devm_request_irq(dev, data->lmh_dcvs_irq, qcom_lmh_dcvs_handle_irq,
> +				       0, "dcvsh-irq", data);
> +		if (ret) {
> +			dev_err(dev, "Error %d registering irq %x\n", ret, data->lmh_dcvs_irq);
> +			goto error;
> +		}
> +		INIT_DEFERRABLE_WORK(&data->lmh_dcvs_poll_work, qcom_lmh_dcvs_poll);
> +	}
>  	return 0;
>  error:
>  	kfree(data);
> -- 
> 2.25.1
> 
