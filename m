Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3076D3BB7F8
	for <lists+linux-pm@lfdr.de>; Mon,  5 Jul 2021 09:37:28 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229993AbhGEHkD (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Mon, 5 Jul 2021 03:40:03 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44400 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229953AbhGEHkC (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Mon, 5 Jul 2021 03:40:02 -0400
Received: from mail-wr1-x42e.google.com (mail-wr1-x42e.google.com [IPv6:2a00:1450:4864:20::42e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F3168C061574
        for <linux-pm@vger.kernel.org>; Mon,  5 Jul 2021 00:37:25 -0700 (PDT)
Received: by mail-wr1-x42e.google.com with SMTP id t15so17470080wry.11
        for <linux-pm@vger.kernel.org>; Mon, 05 Jul 2021 00:37:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:content-transfer-encoding:in-reply-to;
        bh=3gcOyn0drqMN2jcigqPYxvdzNQqta5uQwhQq9F4TJg0=;
        b=drOt69ort5zAXQmwvPrRSoM71unOxTnmcRTsox0FSHWyaXJVAJqs0QaqeQtZjTUEnB
         Yy+6nwAQoP1MZwjlWZFtVjElWhze7SZQDnBFYs0utlQrX6AKAyvWdUZSeHwXDzaLKLxg
         ZF4IlcMl9QtLVg44dtinwFgTWYg09GTJVYYNs5rB2gOvmTis5fUnvISa6yX9uGVliJWC
         QNGd+TR/+0W7jXNXhJHNAZU4e8WTL93s1rRP61vbhgTNPeEHDnbmZgqNjFqw3qoZUHPk
         YFVEmwnlZRYld4Zhw6uJ6lFLqe6RT3lWsQMGewIvyKgOFiEbPxaa5R+fupdWtQ1QG9RJ
         lt8A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:content-transfer-encoding
         :in-reply-to;
        bh=3gcOyn0drqMN2jcigqPYxvdzNQqta5uQwhQq9F4TJg0=;
        b=NMDvhENTxkR+Dhqe78Vo44aL9Mekw/c0PqysYVCAd1fouxDuyRGZ6EYUSsVvbwTGxn
         hqjPOtrDwC0VRWRy0xdS0SyCAMcrsn/AM6t1o93pRTSYONWt+BhqY/fl5OzMN149bLJd
         2UkkCJcDk9+hTFXDW8HFUWv9xnQuyayyLDfDTgBAuPRZXDaXtclumjFlZ8mv+g9mFxZy
         2N1ktqzY3PUwK/k3ibtekGeyyYGnpoH1g8RmXLHMraP/fobCujxXJ4elMVtP4xYYuBk4
         b4k6zdo5VxAGpBOGJconfCZyN//p/z2U48B95Eiqd1SUfejtzSoS4gCpLLqKbeKk1OJ5
         VkMQ==
X-Gm-Message-State: AOAM531ImXutTxJvh1bzvSAKYcaLDy+ZVmQ6SmSZtVgWa63Ja9OEcYqj
        BXu+QjNYODCw3VOrU6hRNtxB0g==
X-Google-Smtp-Source: ABdhPJw/f1Dw6+hRm2MwOKeQIdSMIlyxE8FHR1I8ojqGa9Mkrc42ZHpnzUDmUOeIHT2+1tzq1v7eAA==
X-Received: by 2002:a5d:6e81:: with SMTP id k1mr14096502wrz.144.1625470644642;
        Mon, 05 Jul 2021 00:37:24 -0700 (PDT)
Received: from dell ([109.180.115.218])
        by smtp.gmail.com with ESMTPSA id l16sm21893173wmj.47.2021.07.05.00.37.23
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 05 Jul 2021 00:37:24 -0700 (PDT)
Date:   Mon, 5 Jul 2021 08:37:25 +0100
From:   Lee Jones <lee.jones@linaro.org>
To:     Andreas Kemnade <andreas@kemnade.info>
Cc:     robh+dt@kernel.org, jic23@kernel.org, lars@metafoo.de,
        sre@kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-iio@vger.kernel.org,
        linux-pm@vger.kernel.org, leonard.crestez@nxp.com,
        letux-kernel@openphoenux.org
Subject: Re: [PATCH 2/4] mfd: rn5t618: Add of compatibles for ADC and power
Message-ID: <YOK2tdaqGcHfz6Uw@dell>
References: <20210703084224.31623-1-andreas@kemnade.info>
 <20210703084224.31623-3-andreas@kemnade.info>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20210703084224.31623-3-andreas@kemnade.info>
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

On Sat, 03 Jul 2021, Andreas Kemnade wrote:

> This allows having devicetree nodes for the subdevices.
> 
> Signed-off-by: Andreas Kemnade <andreas@kemnade.info>
> ---
>  drivers/mfd/rn5t618.c | 6 ++++--
>  1 file changed, 4 insertions(+), 2 deletions(-)
> 
> diff --git a/drivers/mfd/rn5t618.c b/drivers/mfd/rn5t618.c
> index 384acb459427..b916c7471ca3 100644
> --- a/drivers/mfd/rn5t618.c
> +++ b/drivers/mfd/rn5t618.c
> @@ -24,8 +24,10 @@ static const struct mfd_cell rn5t618_cells[] = {
>  };
>  
>  static const struct mfd_cell rc5t619_cells[] = {
> -	{ .name = "rn5t618-adc" },
> -	{ .name = "rn5t618-power" },
> +	{ .name = "rn5t618-adc",
> +	  .of_compatible = "ricoh,rc5t619-adc" },
> +	{ .name = "rn5t618-power",
> +	  .of_compatible = "ricoh,rc5t619-power" },

If you're converting entries from single to multi-line, you should
place the coding lines one different ones to the brackets.

Also, if ordering is unimportant, could you move the multi-line
entries to the bottom please?

>  	{ .name = "rn5t618-regulator" },
>  	{ .name = "rc5t619-rtc" },
>  	{ .name = "rn5t618-wdt" },

-- 
Lee Jones [李琼斯]
Senior Technical Lead - Developer Services
Linaro.org │ Open source software for Arm SoCs
Follow Linaro: Facebook | Twitter | Blog
