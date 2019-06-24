Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 9FFED5091E
	for <lists+linux-pm@lfdr.de>; Mon, 24 Jun 2019 12:42:26 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728824AbfFXKmZ (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Mon, 24 Jun 2019 06:42:25 -0400
Received: from mail-lf1-f65.google.com ([209.85.167.65]:44976 "EHLO
        mail-lf1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728676AbfFXKmZ (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Mon, 24 Jun 2019 06:42:25 -0400
Received: by mail-lf1-f65.google.com with SMTP id r15so9624298lfm.11;
        Mon, 24 Jun 2019 03:42:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=ZKQur/4feM7yNS7/yjihV2CmCsKO6qLzrXuCht+A5oM=;
        b=LdYoeXBBpqQ2fwvRbztpeh8hFO3N+98fqdFUyS35G7dvgm+WGNyRVubCCIaJn7OIA0
         GFzYPD5Vi3po9+AHIhddgYC/VtRWJz7Hi1ZNqE33iok9f2XAejNUNPQF4anxX+uoSHeY
         /KZw2U0wefzixeDhKMQUuimTVY8KuyCL6+JCxNuIN0+tSW1PDunvD7KVvXqM/MxiF7wC
         niJovSyHpviJIj4r5XkXsZ8H0BgRYu+DJmzutdNTxB1wNPekKh36l5zbw/yJBWTgQz4l
         loGDD3hoVJsh/5wdD0lvFgUofVOKm55tSpMxq7i0Z05jam3cfKrva/0NDwj4XNPi335k
         GKsQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=ZKQur/4feM7yNS7/yjihV2CmCsKO6qLzrXuCht+A5oM=;
        b=KyKx3qFQzCwLVFSVB8yhfJTuNFgC14f82ckBHGWnNlbVIw+rwtWZt8J5ETai9J+fUo
         JqF/VRJnVN2H7B7HKc2MZI/xjojgXTH/p5cePNILjK5gYOPJqS2LQm6kArE1NtBgc3LB
         yDQ7EUCNOPFhCLvwS9f+WlB89LcFfC/p6H9m6TVBINf4I14KPnP3JCNXxZYwCRJyKUFd
         vVWQG7bUJXOJ83rep005kKUqwf7JBjFVraX0GWPrXrsJAoI6xoLIJNF9oKXOD+s6LRVs
         ENWRaxu0vSFHeHMovlilIeMri4y1W0d4feAlCHYqov8AmxfWdUz3YT2fucfy5zCdar43
         JsLQ==
X-Gm-Message-State: APjAAAX/CNq4Z3/23gFaQnYT+Mp7GKK+BIKSLkvVbeVM0WcnCCI0QuXL
        gHWHogSlZtEPwEDylQ3ph3Y=
X-Google-Smtp-Source: APXvYqwYusjRTqAjFQIBBX2wQHYSRL2eiIcDsSuX5Yg2cauKLG99VWoJGr6qEkokrtmME+zPpnwEfQ==
X-Received: by 2002:ac2:596c:: with SMTP id h12mr13962464lfp.101.1561372942517;
        Mon, 24 Jun 2019 03:42:22 -0700 (PDT)
Received: from [192.168.2.145] (ppp91-79-162-197.pppoe.mtu-net.ru. [91.79.162.197])
        by smtp.googlemail.com with ESMTPSA id w1sm1914739ljm.81.2019.06.24.03.42.21
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 24 Jun 2019 03:42:21 -0700 (PDT)
Subject: Re: [PATCH v4 13/16] PM / devfreq: tegra: Support Tegra30
To:     myungjoo.ham@samsung.com
Cc:     Chanwoo Choi <cw00.choi@samsung.com>,
        "linux-pm@vger.kernel.org" <linux-pm@vger.kernel.org>,
        "linux-tegra@vger.kernel.org" <linux-tegra@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "jonathanh@nvidia.com" <jonathanh@nvidia.com>,
        "thierry.reding@gmail.com" <thierry.reding@gmail.com>
References: <20190624065919epcms1p1a366de5f455f5138c438d1da8151c12f@epcms1p1>
 <CGME20190624065919epcms1p1a366de5f455f5138c438d1da8151c12f@epcms1p8>
 <20190624073414epcms1p87b6dc13758b6bd401d275cfba583314a@epcms1p8>
From:   Dmitry Osipenko <digetx@gmail.com>
Message-ID: <37db00bc-3a22-d1c2-7bdc-e27af42cd5c7@gmail.com>
Date:   Mon, 24 Jun 2019 13:42:20 +0300
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.7.1
MIME-Version: 1.0
In-Reply-To: <20190624073414epcms1p87b6dc13758b6bd401d275cfba583314a@epcms1p8>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

24.06.2019 10:34, MyungJoo Ham пишет:
>>
>> A question:
>>
>> Does this driver support Tegra20 as well?
>> I'm asking this because ARCH_TEGRA includes ARCH_TEGRA_2x_SOC
>> according to /drivers/soc/tegra/Kconfig.
>>
> 
> For this matter, how about updating your 13/16 patch as follows?
> 
> ---
>  drivers/devfreq/Kconfig         | 4 ++--
>  drivers/devfreq/tegra-devfreq.c | 1 +
>  2 files changed, 3 insertions(+), 2 deletions(-)
> 
> diff --git a/drivers/devfreq/Kconfig b/drivers/devfreq/Kconfig
> index 7dd46d44579d..78c4b436aad8 100644
> --- a/drivers/devfreq/Kconfig
> +++ b/drivers/devfreq/Kconfig
> @@ -93,8 +93,8 @@ config ARM_EXYNOS_BUS_DEVFREQ
>  	  This does not yet operate with optimal voltages.
>  
>  config ARM_TEGRA_DEVFREQ
> -	tristate "Tegra DEVFREQ Driver"
> -	depends on ARCH_TEGRA_124_SOC
> +	tristate "NVIDIA Tegra30/114/124/210 DEVFREQ Driver"
> +	depends on ARCH_TEGRA_3x_SOC || ARCH_TEGRA_114_SOC || ARCH_TEGRA_124_SOC || ARCH_TEGRA_210_SOC
>  	select PM_OPP
>  	help
>  	  This adds the DEVFREQ driver for the Tegra family of SoCs.
> diff --git a/drivers/devfreq/tegra-devfreq.c b/drivers/devfreq/tegra-devfreq.c
> index 5cddf2199c4e..a6ba75f4106d 100644
> --- a/drivers/devfreq/tegra-devfreq.c
> +++ b/drivers/devfreq/tegra-devfreq.c
> @@ -726,6 +726,7 @@ static int tegra_devfreq_remove(struct platform_device *pdev)
>  }
>  
>  static const struct of_device_id tegra_devfreq_of_match[] = {
> +	{ .compatible = "nvidia,tegra30-actmon" },
>  	{ .compatible = "nvidia,tegra124-actmon" },
>  	{ },
>  };
> 

Good call! I'll update this patch following yours suggestion, thanks.
