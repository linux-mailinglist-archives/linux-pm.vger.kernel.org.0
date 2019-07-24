Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 97EA27375D
	for <lists+linux-pm@lfdr.de>; Wed, 24 Jul 2019 21:07:51 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727550AbfGXTHr convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-pm@lfdr.de>); Wed, 24 Jul 2019 15:07:47 -0400
Received: from mail-wm1-f66.google.com ([209.85.128.66]:34958 "EHLO
        mail-wm1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726622AbfGXTHq (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Wed, 24 Jul 2019 15:07:46 -0400
Received: by mail-wm1-f66.google.com with SMTP id l2so42561120wmg.0;
        Wed, 24 Jul 2019 12:07:44 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:content-transfer-encoding
         :in-reply-to:user-agent;
        bh=jtQSPuZ1QzMs99js7V9Wo2RTLphiNzuGhsELT//GEEg=;
        b=q7WyBGiVaCx5zfiZXWWNePnxq2V8kdF+At38cApdo9WIgMtWVzeorGDfmE2mSdqKUS
         8slYk5rh5ZcIPEmOSPzdDq/3WjYYoM9cFC1s1ZDZYagfVGQ6Iq7Bdqea5N39Zx/FAsa5
         szF0mpUcDM3SWpJEWynYqY1oD1eIHl1BV+wDd063l3gEzuKxTqGUfwILWkSn1iCooBde
         UqFNTNcXspiAK38An6RJIFkj+1lokybzjm8873pVBsUOKcsVu9mv+5sPChUfsDNnq/i0
         cXJdvMEKpmIWz0a9nsPJlAVyOYD9lau589X+Y11kULsSmD5wNWJyEKjF3DKRGRplLCyZ
         0Q+Q==
X-Gm-Message-State: APjAAAWmzndQIqbCCVKBwMKE0YLxwaYFjj5/EbN28/NNl8Tpek2Z1l1+
        I5AeB4Gr5DeLWzuzzrvzG70=
X-Google-Smtp-Source: APXvYqzW5J/UxiwCLKihWU+W6v0QY2SUnZdcHCLGNhpwuL3J4T0/WFqdxk7zt2m7BHrB78puwFES8w==
X-Received: by 2002:a05:600c:212:: with SMTP id 18mr25939276wmi.88.1563995264126;
        Wed, 24 Jul 2019 12:07:44 -0700 (PDT)
Received: from kozik-lap ([194.230.155.239])
        by smtp.googlemail.com with ESMTPSA id w23sm48058527wmi.45.2019.07.24.12.07.42
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Wed, 24 Jul 2019 12:07:43 -0700 (PDT)
Date:   Wed, 24 Jul 2019 21:07:41 +0200
From:   Krzysztof Kozlowski <krzk@kernel.org>
To:     Artur =?utf-8?B?xZp3aWdvxYQ=?= <a.swigon@partner.samsung.com>
Cc:     devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-samsung-soc@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-pm@vger.kernel.org, dri-devel@lists.freedesktop.org,
        cw00.choi@samsung.com, myungjoo.ham@samsung.com,
        inki.dae@samsung.com, sw0312.kim@samsung.com,
        georgi.djakov@linaro.org, m.szyprowski@samsung.com
Subject: Re: [RFC PATCH 01/11] devfreq: exynos-bus: Extract
 exynos_bus_profile_init()
Message-ID: <20190724190741.GD14346@kozik-lap>
References: <20190723122016.30279-1-a.swigon@partner.samsung.com>
 <CGME20190723122022eucas1p1266d90873d564894bd852c20140f8474@eucas1p1.samsung.com>
 <20190723122016.30279-2-a.swigon@partner.samsung.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8BIT
In-Reply-To: <20190723122016.30279-2-a.swigon@partner.samsung.com>
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

On Tue, Jul 23, 2019 at 02:20:06PM +0200, Artur Świgoń wrote:
> This patch adds a new static function, exynos_bus_profile_init(), extracted
> from exynos_bus_probe().
> 
> Signed-off-by: Artur Świgoń <a.swigon@partner.samsung.com>
> ---
>  drivers/devfreq/exynos-bus.c | 106 ++++++++++++++++++++---------------
>  1 file changed, 60 insertions(+), 46 deletions(-)
> 
> diff --git a/drivers/devfreq/exynos-bus.c b/drivers/devfreq/exynos-bus.c
> index d9f377912c10..d8f1efaf2d49 100644
> --- a/drivers/devfreq/exynos-bus.c
> +++ b/drivers/devfreq/exynos-bus.c
> @@ -372,12 +372,69 @@ static int exynos_bus_parse_of(struct device_node *np,
>  	return ret;
>  }
>  
> +static int exynos_bus_profile_init(struct exynos_bus *bus,
> +				   struct devfreq_dev_profile *profile)
> +{
> +	struct device *dev = bus->dev;
> +	struct devfreq_simple_ondemand_data *ondemand_data;
> +	int ret;
> +
> +	/* Initialize the struct profile and governor data for parent device */
> +	profile->polling_ms = 50;
> +	profile->target = exynos_bus_target;
> +	profile->get_dev_status = exynos_bus_get_dev_status;
> +	profile->exit = exynos_bus_exit;
> +
> +	ondemand_data = devm_kzalloc(dev, sizeof(*ondemand_data), GFP_KERNEL);
> +	if (!ondemand_data) {
> +		ret = -ENOMEM;
> +		goto err;

Just return proper error code. Less lines, obvious code since you do not
have any cleanup in error path.

> +	}
> +	ondemand_data->upthreshold = 40;
> +	ondemand_data->downdifferential = 5;
> +
> +	/* Add devfreq device to monitor and handle the exynos bus */
> +	bus->devfreq = devm_devfreq_add_device(dev, profile,
> +						DEVFREQ_GOV_SIMPLE_ONDEMAND,
> +						ondemand_data);
> +	if (IS_ERR(bus->devfreq)) {
> +		dev_err(dev, "failed to add devfreq device\n");
> +		ret = PTR_ERR(bus->devfreq);
> +		goto err;
> +	}
> +
> +	/* Register opp_notifier to catch the change of OPP  */
> +	ret = devm_devfreq_register_opp_notifier(dev, bus->devfreq);
> +	if (ret < 0) {
> +		dev_err(dev, "failed to register opp notifier\n");
> +		goto err;

The same - return err.

Best regards,
Krzysztof

