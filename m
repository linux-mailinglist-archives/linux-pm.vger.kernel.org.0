Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A399B3D965E
	for <lists+linux-pm@lfdr.de>; Wed, 28 Jul 2021 22:06:19 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231398AbhG1UGU (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Wed, 28 Jul 2021 16:06:20 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60634 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229762AbhG1UGT (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Wed, 28 Jul 2021 16:06:19 -0400
Received: from mail-ot1-x32e.google.com (mail-ot1-x32e.google.com [IPv6:2607:f8b0:4864:20::32e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DC578C061757
        for <linux-pm@vger.kernel.org>; Wed, 28 Jul 2021 13:06:16 -0700 (PDT)
Received: by mail-ot1-x32e.google.com with SMTP id i39-20020a9d17270000b02904cf73f54f4bso3379175ota.2
        for <linux-pm@vger.kernel.org>; Wed, 28 Jul 2021 13:06:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=RgQV2POnTNhownKZPlBpXU10D8P77Sy5Oy1xD8WPPn0=;
        b=FrrKJ3i9URl+r8rqdK4/pScXSbV1pGBeQ8X/yVyMtpzQL0IH9u2yLQz0LcljmC4zfk
         nUsdiUtfPuoc/EVFZvUmVPinS7Zq09Y53PsMa6reMrjsSLxu9PRSvvVmaZj6PR/UQ2Xm
         uNZoa2ol0vwgDymYyGv6Pt6E8VCyEHp5IzUaX0+r0NqPb8vUPmRIYOE9+F109f2Mo/+6
         JPayvBjfHPPPJxMf5ij43EfzAjPnahmg/pwlKJ6j2fzO6P5XpydNC+2kwU6LwxpWbS4J
         A92hqvW+Dr3AHch23CLzyF1aJFPoFezn0tiFrIAKnw9H/BZ6VKZUvcQQTQnn1MdszEt0
         YQew==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=RgQV2POnTNhownKZPlBpXU10D8P77Sy5Oy1xD8WPPn0=;
        b=C+st93xlfJsJBdpNy18Qs+eC8n5f5iVhHejJs6q7GxjIrb8Xb102CKUaol9hE6k8TO
         qaGneCq5ygANwhkghyVAE0hbAzYJqFj21gck8komVeWWpzJEMjtry7MpKe0D0Al66iJ7
         P33/mgyFogHP6i4IhvUcFdCn5cL2tDmPtT/xd/ChOjxRHSkHgj64ZJ+xPdcMUmzF1xI/
         483CqxpAk7PNz13k1IY1dd4EOBuh3NPecUjfjqeLbPXkPKbuOsD7N99bsRrwrTXurQpf
         Z4Y20/Q61BUzGBMeqN7aQf0pNyt+l4HYqfoyWF73+5Kb0PX0YxoHPlrag55Keo/SSxOa
         GbUg==
X-Gm-Message-State: AOAM531DuUuoOJDskfLhbo9JkFfSlUpI7QRWAyfldrxwKGxvHRKnBJ9T
        XdDcigTFhu+c+0jpmuzGtH2E8w==
X-Google-Smtp-Source: ABdhPJzQXfs+1VxjlRn+p1VmmVBgmBHUbC1ZA3IFjmSDDXTdl7sQL291fsv4jcT5kBuGPKI+wpkAoA==
X-Received: by 2002:a9d:64d9:: with SMTP id n25mr1167735otl.174.1627502776188;
        Wed, 28 Jul 2021 13:06:16 -0700 (PDT)
Received: from ripper (104-57-184-186.lightspeed.austtx.sbcglobal.net. [104.57.184.186])
        by smtp.gmail.com with ESMTPSA id n202sm203165oig.10.2021.07.28.13.06.15
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 28 Jul 2021 13:06:15 -0700 (PDT)
Date:   Wed, 28 Jul 2021 13:04:25 -0700
From:   Bjorn Andersson <bjorn.andersson@linaro.org>
To:     Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
Cc:     "Rafael J. Wysocki" <rjw@rjwysocki.net>,
        Pavel Machek <pavel@ucw.cz>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Stephen Boyd <sboyd@kernel.org>,
        Taniya Das <tdas@codeaurora.org>,
        Michael Turquette <mturquette@baylibre.com>,
        Andy Gross <agross@kernel.org>, linux-pm@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-clk@vger.kernel.org,
        linux-arm-msm@vger.kernel.org
Subject: Re: [PATCH v2 1/5] PM: runtime: add devm_pm_runtime_enable helper
Message-ID: <YQG4SVwUI21HugbG@ripper>
References: <20210728142445.774158-1-dmitry.baryshkov@linaro.org>
 <20210728142445.774158-2-dmitry.baryshkov@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210728142445.774158-2-dmitry.baryshkov@linaro.org>
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

On Wed 28 Jul 07:24 PDT 2021, Dmitry Baryshkov wrote:

> Add helper function handling typical driver action: call
> pm_runtime_enable at the probe() time and disable it during remove().
> 

This says what the patch does, but it doesn't say why we would like
these helpers - i.e. the fact that it's quite common across the kernel
to have error handlers and remove functions that simply has to do
pm_runtime_disable().

> Signed-off-by: Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
> ---
>  drivers/base/power/runtime.c | 17 +++++++++++++++++
>  include/linux/pm_runtime.h   |  4 ++++
>  2 files changed, 21 insertions(+)
> 
> diff --git a/drivers/base/power/runtime.c b/drivers/base/power/runtime.c
> index 8a66eaf731e4..ec94049442b9 100644
> --- a/drivers/base/power/runtime.c
> +++ b/drivers/base/power/runtime.c
> @@ -1447,6 +1447,23 @@ void pm_runtime_enable(struct device *dev)
>  }
>  EXPORT_SYMBOL_GPL(pm_runtime_enable);
>  
> +static void pm_runtime_disable_action(void *data)
> +{
> +	pm_runtime_disable(data);
> +}
> +
> +/**
> + * devm_pm_runtime_enable - devres-enabled version of pm_runtime_enable.

() on the function name.

> + * @dev: Device to handle.

Returns: 0 on success, negative errno on failure

Regards,
Bjorn

> + */
> +int devm_pm_runtime_enable(struct device *dev)
> +{
> +	pm_runtime_enable(dev);
> +
> +	return devm_add_action_or_reset(dev, pm_runtime_disable_action, dev);
> +}
> +EXPORT_SYMBOL_GPL(devm_pm_runtime_enable);
> +
>  /**
>   * pm_runtime_forbid - Block runtime PM of a device.
>   * @dev: Device to handle.
> diff --git a/include/linux/pm_runtime.h b/include/linux/pm_runtime.h
> index aab8b35e9f8a..222da43b7096 100644
> --- a/include/linux/pm_runtime.h
> +++ b/include/linux/pm_runtime.h
> @@ -59,6 +59,8 @@ extern void pm_runtime_put_suppliers(struct device *dev);
>  extern void pm_runtime_new_link(struct device *dev);
>  extern void pm_runtime_drop_link(struct device_link *link);
>  
> +extern int devm_pm_runtime_enable(struct device *dev);
> +
>  /**
>   * pm_runtime_get_if_in_use - Conditionally bump up runtime PM usage counter.
>   * @dev: Target device.
> @@ -253,6 +255,8 @@ static inline void __pm_runtime_disable(struct device *dev, bool c) {}
>  static inline void pm_runtime_allow(struct device *dev) {}
>  static inline void pm_runtime_forbid(struct device *dev) {}
>  
> +static inline int devm_pm_runtime_enable(struct device *dev) { return 0; }
> +
>  static inline void pm_suspend_ignore_children(struct device *dev, bool enable) {}
>  static inline void pm_runtime_get_noresume(struct device *dev) {}
>  static inline void pm_runtime_put_noidle(struct device *dev) {}
> -- 
> 2.30.2
> 
