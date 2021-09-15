Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id CF3D840CC81
	for <lists+linux-pm@lfdr.de>; Wed, 15 Sep 2021 20:23:42 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229623AbhIOSZA (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Wed, 15 Sep 2021 14:25:00 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58110 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229479AbhIOSY7 (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Wed, 15 Sep 2021 14:24:59 -0400
Received: from mail-pf1-x42b.google.com (mail-pf1-x42b.google.com [IPv6:2607:f8b0:4864:20::42b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5CA2EC061574;
        Wed, 15 Sep 2021 11:23:40 -0700 (PDT)
Received: by mail-pf1-x42b.google.com with SMTP id y4so1938614pfe.5;
        Wed, 15 Sep 2021 11:23:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=crqcUOKW4ICiyDqv+FQ3+9UvZjcNBFY2WdOBjUG5rOs=;
        b=KAwl0YJ7funyESGOGR3ZOtr93nJB8k+o8x9+Mqd2G7ZW6nrXn4ReyFw2L2eIiS+zsZ
         qUYUYiPTNao/RQ1j/nYsrlyVJ71WJdYWCeuuH5xnghw9ESu28x7gUEIEhVhnr2WLD+55
         mwHkuXI1T9VhT8UPkT8q3RVgXDYo4Y5GixX9gX7vSIixifwhMUuZ/G7OPCSKqOWQcVUW
         Uf9j1G6xxx4l3Is1OLiJKYB0FUJ/9BiL5+jIIhXuAXAFulEp4saARUZttinMgRBL+5DC
         6yuVLLnxf/hq41JH7hqfZASwjUZF5DjchiZa7lfEWluNPBjQpUtwkSscxj08YtjY2HEb
         XK/w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=crqcUOKW4ICiyDqv+FQ3+9UvZjcNBFY2WdOBjUG5rOs=;
        b=YeDuYi8zNCdNuJUmUehoBCYZ5zYxuSjnpHh0dN0d7vDpiI075wKPQyOYwRfuDDFZN0
         ScnEJ6rxmgE2SKFh1shDqt1ZHcW6OSr7WwXbMJlWapOCF4Qjm+eu+k0Q3ERdbXUr6sAs
         xH5TENTPBNIxqVS7uIM4GtRr9QVAIVimxP9UGcLiHwXXWNbXi9twvPrsizf+CBxtlz/6
         3404A5PrwegQG1UpaPpVAR+qepmV4X+qVYRktEDOg8ErSsIo1rY5jzX9AXutB8URGgFs
         gLtL16WiWOvHVDjoGGwHyd6ks4luGYWB8I++GG5CB2ZNAUhGgs6EzXStLKY3/MD+VIJ8
         bUVg==
X-Gm-Message-State: AOAM530CMNjIs8NzWbhA13pj/uBodVEfIJaLlh8jHO/8mMqJHgPza3/t
        /KdCnz9KRtGZvPDgxAH26wUlXI1RDkwcRg==
X-Google-Smtp-Source: ABdhPJyBSksG+UA+g7JDGCXXN+jxkrh/nPAiIN6AkdkBXvVqFL/5LaHPP81ftnf3ClQ38kqXFz1tnw==
X-Received: by 2002:a62:14cb:0:b0:43e:ba00:c35e with SMTP id 194-20020a6214cb000000b0043eba00c35emr877869pfu.9.1631730219210;
        Wed, 15 Sep 2021 11:23:39 -0700 (PDT)
Received: from [172.30.1.2] ([14.32.163.5])
        by smtp.gmail.com with ESMTPSA id u8sm526368pfk.212.2021.09.15.11.23.35
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 15 Sep 2021 11:23:38 -0700 (PDT)
Subject: Re: [PATCH v1 2/4] PM / devfreq: Add devm_devfreq_add_governor()
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
References: <20210912184458.17995-1-digetx@gmail.com>
 <20210912184458.17995-3-digetx@gmail.com>
From:   Chanwoo Choi <cwchoi00@gmail.com>
Message-ID: <504a75a9-3f39-3aed-2df5-4ca1e7f99afc@gmail.com>
Date:   Thu, 16 Sep 2021 03:23:34 +0900
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.13.0
MIME-Version: 1.0
In-Reply-To: <20210912184458.17995-3-digetx@gmail.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

On 21. 9. 13. 오전 3:44, Dmitry Osipenko wrote:
> Add resource-managed variant of devfreq_add_governor().
> 
> Signed-off-by: Dmitry Osipenko <digetx@gmail.com>
> ---
>   drivers/devfreq/devfreq.c  | 26 ++++++++++++++++++++++++++
>   drivers/devfreq/governor.h |  3 +++
>   2 files changed, 29 insertions(+)
> 
> diff --git a/drivers/devfreq/devfreq.c b/drivers/devfreq/devfreq.c
> index 85faa7a5c7d1..d3af000ec290 100644
> --- a/drivers/devfreq/devfreq.c
> +++ b/drivers/devfreq/devfreq.c
> @@ -1301,6 +1301,32 @@ int devfreq_add_governor(struct devfreq_governor *governor)
>   }
>   EXPORT_SYMBOL(devfreq_add_governor);
>   
> +static void devm_devfreq_remove_governor(void *governor)
> +{
> +	devfreq_remove_governor(governor);

Because devfreq_remove_governor has the return value,
you need to check the return value and then print error at least.

	WARN_ON(devfreq_remove_governor(governor));

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
> index 2d69a0ce6291..0d70a9ad951e 100644
> --- a/drivers/devfreq/governor.h
> +++ b/drivers/devfreq/governor.h
> @@ -94,4 +94,7 @@ static inline int devfreq_update_stats(struct devfreq *df)
>   
>   	return df->profile->get_dev_status(df->dev.parent, &df->last_status);
>   }
> +
> +int devm_devfreq_add_governor(struct device *dev,
> +			      struct devfreq_governor *governor);

Better to add under devfreq_remove_governor definition in order to 
gather the similar functions.

>   #endif /* _GOVERNOR_H */
> 


-- 
Best Regards,
Samsung Electronics
Chanwoo Choi
