Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 9E74B7376C
	for <lists+linux-pm@lfdr.de>; Wed, 24 Jul 2019 21:08:58 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726942AbfGXTI5 convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-pm@lfdr.de>); Wed, 24 Jul 2019 15:08:57 -0400
Received: from mail-wm1-f65.google.com ([209.85.128.65]:40763 "EHLO
        mail-wm1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725955AbfGXTI5 (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Wed, 24 Jul 2019 15:08:57 -0400
Received: by mail-wm1-f65.google.com with SMTP id v19so42601867wmj.5;
        Wed, 24 Jul 2019 12:08:55 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:content-transfer-encoding
         :in-reply-to:user-agent;
        bh=mYrGkDQOnSU5Lp9avRqB0jc65jAYh0UF93+Huamd7FY=;
        b=t1/CRLaELIeSbRmDX8VpiAdEV65VK6mSpA+IBurx+XlWBcgGHVP0KPpKP2o2FTwhtt
         Fmm0tZPvfo5Zua/+uYA7Wx1CFReJXRaAGGnbe80kCbFT5oC2iDgO2X/o8d9Mq0fFncCx
         t5/KKXT8yEkx0P9tow0XQ+NUHm/uF6itrjZa4vkMx98hPCABnHyk7ey+qHRPWFnld5L4
         rXbIuvfOzS3y2X4QpBayLk4EGQ+HY6OSpt5khjNAGcQvFg12q0gsqrSZ3EZUfHFMFuCR
         S2M8t0L/4J89TGB+oRoX/ZA/6Lzh9W2YAJZvXFNHGVWbOEvGUZWOJvc1SiUGWeZW+xiL
         +XxQ==
X-Gm-Message-State: APjAAAWcNvR2IMz9y1xVFDxWQLb7G0UcPhg3rwn0yMpiPDj4ui65Od2Z
        WlauCdHlfDpwHiR+/0FKTZM=
X-Google-Smtp-Source: APXvYqzdk6u7Pk10r48MB52INPrCA0J17QNFIsWrGOO+ZuC0i9JWvgiRp9UAxl5CifpHBiYGbc8sOw==
X-Received: by 2002:a7b:c4d2:: with SMTP id g18mr76037481wmk.79.1563995334246;
        Wed, 24 Jul 2019 12:08:54 -0700 (PDT)
Received: from kozik-lap ([194.230.155.239])
        by smtp.googlemail.com with ESMTPSA id y1sm35475550wma.32.2019.07.24.12.08.53
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Wed, 24 Jul 2019 12:08:53 -0700 (PDT)
Date:   Wed, 24 Jul 2019 21:08:51 +0200
From:   Krzysztof Kozlowski <krzk@kernel.org>
To:     Artur =?utf-8?B?xZp3aWdvxYQ=?= <a.swigon@partner.samsung.com>
Cc:     devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-samsung-soc@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-pm@vger.kernel.org, dri-devel@lists.freedesktop.org,
        cw00.choi@samsung.com, myungjoo.ham@samsung.com,
        inki.dae@samsung.com, sw0312.kim@samsung.com,
        georgi.djakov@linaro.org, m.szyprowski@samsung.com
Subject: Re: [RFC PATCH 02/11] devfreq: exynos-bus: Extract
 exynos_bus_profile_init_passive()
Message-ID: <20190724190851.GE14346@kozik-lap>
References: <20190723122016.30279-1-a.swigon@partner.samsung.com>
 <CGME20190723122023eucas1p2ff56c00b60a676ed85d9fe159a1839f2@eucas1p2.samsung.com>
 <20190723122016.30279-3-a.swigon@partner.samsung.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8BIT
In-Reply-To: <20190723122016.30279-3-a.swigon@partner.samsung.com>
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

On Tue, Jul 23, 2019 at 02:20:07PM +0200, Artur Świgoń wrote:
> This patch adds a new static function, exynos_bus_profile_init_passive(),
> extracted from exynos_bus_probe().
> 
> Signed-off-by: Artur Świgoń <a.swigon@partner.samsung.com>
> ---
>  drivers/devfreq/exynos-bus.c | 70 +++++++++++++++++++++---------------
>  1 file changed, 42 insertions(+), 28 deletions(-)
> 
> diff --git a/drivers/devfreq/exynos-bus.c b/drivers/devfreq/exynos-bus.c
> index d8f1efaf2d49..cf6f6cbd0f55 100644
> --- a/drivers/devfreq/exynos-bus.c
> +++ b/drivers/devfreq/exynos-bus.c
> @@ -430,13 +430,51 @@ static int exynos_bus_profile_init(struct exynos_bus *bus,
>  	return ret;
>  }
>  
> +static int exynos_bus_profile_init_passive(struct exynos_bus *bus,
> +					   struct devfreq_dev_profile *profile)
> +{
> +	struct device *dev = bus->dev;
> +	struct devfreq *parent_devfreq;
> +	struct devfreq_passive_data *passive_data;
> +	int ret = 0;
> +
> +	/* Initialize the struct profile and governor data for passive device */
> +	profile->target = exynos_bus_passive_target;
> +	profile->exit = exynos_bus_passive_exit;
> +
> +	/* Get the instance of parent devfreq device */
> +	parent_devfreq = devfreq_get_devfreq_by_phandle(dev, 0);
> +	if (IS_ERR(parent_devfreq)) {
> +		ret = -EPROBE_DEFER;
> +		goto err;

Same as in previous patch - no need for error goto.

Best regards,
Krzysztof

