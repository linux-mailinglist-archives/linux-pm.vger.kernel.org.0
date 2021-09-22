Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 217E84142E2
	for <lists+linux-pm@lfdr.de>; Wed, 22 Sep 2021 09:50:05 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233303AbhIVHvd (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Wed, 22 Sep 2021 03:51:33 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47564 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233283AbhIVHvc (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Wed, 22 Sep 2021 03:51:32 -0400
Received: from mail-pg1-x531.google.com (mail-pg1-x531.google.com [IPv6:2607:f8b0:4864:20::531])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 06CFAC061574;
        Wed, 22 Sep 2021 00:50:03 -0700 (PDT)
Received: by mail-pg1-x531.google.com with SMTP id r2so1784265pgl.10;
        Wed, 22 Sep 2021 00:50:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=TuwMBP3lxjZDIIIkKMBUehWeZnhQg+0jQoxtba7Hh9I=;
        b=hXvMvZ6eOBZgNmCdzYTcl+fJpAXjGcrpcqPyIpdNC4uEmypCDQLvizzSoJZi9hCCbp
         PRW5QSi3xfeqR27vOD8R6M2uaD3gmmXA5LzvgJFa0qCdJKbosCxZSKk62Q1u2H9VMkd3
         +XmrZ7YO7V26K/V45nvINrCp606jItpb6SbEDGt2fj5i5HeFOQRGp8dwKzAe2T+OH7k4
         6+wtTwy/7o1ebrYGmFnTPc9vst6Asxlw+iRan5z761Y9yUe5es40AbGMCKJebGR2hPMc
         eK3lJmhF0rnqkL/Q3yonydEjxnTcY1N05xt5DPLg26CA/YYExkkETH7Zv/ku1X5Xrt9S
         iPig==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=TuwMBP3lxjZDIIIkKMBUehWeZnhQg+0jQoxtba7Hh9I=;
        b=j+IBKcEwPe0uh4Nnks+tppJ+6C34I3SEsB7Yh7fkjVwN/9r3BS/JzrsPejdWpLBsKe
         1hlLf3HRjKaGAd5eKY0hE9UlZBbcGMO41j/w3yIt6oUk7ZpvP1OZvEvT3+I8hviEIgy+
         2HMhChqfMIuWW2muwc8SvgFpzygo8Qwi9qcXK6VypudCDUEIsxiISyVEtnj3T7vTFrYy
         ropL+6n+oBbRU6qiwnCG8tVVZPUGx+ELdyzT/+22E8I+7flupO8Nu1BHkHyXFpswLx6t
         f2+lgO2Jc/yBq1wxI1UQY+q4nbsCJkCp6D9UcRa2IyiSqE58Hr7ifvcRuGGxGRaJsgZM
         E2sA==
X-Gm-Message-State: AOAM530CQjYZnunYzsZJ53WfKj4r+h2NZq8vieqhBRIJwaaXor+up3JW
        3xJo53m00Oigrkxl/ox2FYTulmkIc8Q=
X-Google-Smtp-Source: ABdhPJzpBPdqWkBZslTDJ4YwznbRa3wkyEY3vk9O0PqfEos3Nwntzh+fraHr3XZl3fmaUznxxKludw==
X-Received: by 2002:a62:1a09:0:b0:435:61bd:2d09 with SMTP id a9-20020a621a09000000b0043561bd2d09mr34578837pfa.71.1632297001840;
        Wed, 22 Sep 2021 00:50:01 -0700 (PDT)
Received: from [172.30.1.2] ([14.32.163.5])
        by smtp.gmail.com with ESMTPSA id f127sm1387197pfa.25.2021.09.22.00.49.58
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 22 Sep 2021 00:50:01 -0700 (PDT)
Subject: Re: [PATCH v2 2/4] PM / devfreq: Add devm_devfreq_add_governor()
To:     Dmitry Osipenko <digetx@gmail.com>,
        Thierry Reding <thierry.reding@gmail.com>,
        Jonathan Hunter <jonathanh@nvidia.com>,
        Viresh Kumar <vireshk@kernel.org>, Nishanth Menon <nm@ti.com>,
        MyungJoo Ham <myungjoo.ham@samsung.com>,
        Stephen Boyd <sboyd@kernel.org>,
        Kyungmin Park <kyungmin.park@samsung.com>,
        Chanwoo Choi <cw00.choi@samsung.com>
Cc:     linux-tegra@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-pm@vger.kernel.org
References: <20210920172249.28206-1-digetx@gmail.com>
 <20210920172249.28206-3-digetx@gmail.com>
From:   Chanwoo Choi <cwchoi00@gmail.com>
Message-ID: <780208e2-911c-87a0-f97c-0147c6f11c5d@gmail.com>
Date:   Wed, 22 Sep 2021 16:49:58 +0900
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.13.0
MIME-Version: 1.0
In-Reply-To: <20210920172249.28206-3-digetx@gmail.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

On 21. 9. 21. 오전 2:22, Dmitry Osipenko wrote:
> Add resource-managed variant of devfreq_add_governor().
> 
> Signed-off-by: Dmitry Osipenko <digetx@gmail.com>
> ---
>   drivers/devfreq/devfreq.c  | 26 ++++++++++++++++++++++++++
>   drivers/devfreq/governor.h |  3 +++
>   2 files changed, 29 insertions(+)
> 
> diff --git a/drivers/devfreq/devfreq.c b/drivers/devfreq/devfreq.c
> index 85faa7a5c7d1..4579eefb8fe7 100644
> --- a/drivers/devfreq/devfreq.c
> +++ b/drivers/devfreq/devfreq.c
> @@ -1301,6 +1301,32 @@ int devfreq_add_governor(struct devfreq_governor *governor)
>   }
>   EXPORT_SYMBOL(devfreq_add_governor);
>   
> +static void devm_devfreq_remove_governor(void *governor)
> +{
> +	WARN_ON(devfreq_remove_governor(governor));
> +}
> +
> +/**
> + * devm_devfreq_add_governor() - Add devfreq governor
> + * @dev:	device which adds devfreq governor
> + * @governor:	the devfreq governor to be added
> + *
> + * This is a resource-managed variant of devfreq_add_governor().
> + */
> +int devm_devfreq_add_governor(struct device *dev,
> +			      struct devfreq_governor *governor)
> +{
> +	int err;
> +
> +	err = devfreq_add_governor(governor);
> +	if (err)
> +		return err;
> +
> +	return devm_add_action_or_reset(dev, devm_devfreq_remove_governor,
> +					governor);
> +}
> +EXPORT_SYMBOL(devm_devfreq_add_governor);
> +
>   /**
>    * devfreq_remove_governor() - Remove devfreq feature from a device.
>    * @governor:	the devfreq governor to be removed
> diff --git a/drivers/devfreq/governor.h b/drivers/devfreq/governor.h
> index 2d69a0ce6291..002a7d67e39d 100644
> --- a/drivers/devfreq/governor.h
> +++ b/drivers/devfreq/governor.h
> @@ -84,6 +84,9 @@ void devfreq_update_interval(struct devfreq *devfreq, unsigned int *delay);
>   int devfreq_add_governor(struct devfreq_governor *governor);
>   int devfreq_remove_governor(struct devfreq_governor *governor);
>   
> +int devm_devfreq_add_governor(struct device *dev,
> +			      struct devfreq_governor *governor);
> +
>   int devfreq_update_status(struct devfreq *devfreq, unsigned long freq);
>   int devfreq_update_target(struct devfreq *devfreq, unsigned long freq);
>   
> 

Acked-by: Chanwoo Choi <cw00.choi@samsung.com>

-- 
Best Regards,
Samsung Electronics
Chanwoo Choi
