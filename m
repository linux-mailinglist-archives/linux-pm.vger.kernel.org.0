Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C3A3A31B607
	for <lists+linux-pm@lfdr.de>; Mon, 15 Feb 2021 09:53:34 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229597AbhBOIxb (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Mon, 15 Feb 2021 03:53:31 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38190 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229919AbhBOIxZ (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Mon, 15 Feb 2021 03:53:25 -0500
Received: from mail-wm1-x32e.google.com (mail-wm1-x32e.google.com [IPv6:2a00:1450:4864:20::32e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C9B2BC0613D6
        for <linux-pm@vger.kernel.org>; Mon, 15 Feb 2021 00:52:44 -0800 (PST)
Received: by mail-wm1-x32e.google.com with SMTP id r5so2255472wmp.1
        for <linux-pm@vger.kernel.org>; Mon, 15 Feb 2021 00:52:44 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:content-transfer-encoding:in-reply-to;
        bh=uKS+Djquue+LfyedBxvXt9cVVOP7cKVsEq1hWOM8/vw=;
        b=jYg060gKSWt358ST2fmYuHV8DpNAJXRWYerutXv0eEjyiL0Ka3jDeQN/sNUhvqs48Q
         SQEoWnwFYESI3wDaZz0v6kdy0uPVCiVl82s3GL9DzLanLKcsVP73Wh/8F2ElY3WoViot
         4aeCUbwU0W+2oVJvubEalXgmO/cHQClK1LMvwWj3no/Qi3NsH7bpbENxklgVWyURjdP+
         Ro2Ev5GbeRvvTi6B1Hadu80eZtbsfJROWzReZCUPa+Qd84TzKgbdK1n5DqxWC2/TUMYt
         2SHUgMcJKUSSq941TgCzCLepCZ7eP9UGBKuW8rJrYDh0c1kbNyPn/CYmofg6R70jAPEY
         BKpw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:content-transfer-encoding
         :in-reply-to;
        bh=uKS+Djquue+LfyedBxvXt9cVVOP7cKVsEq1hWOM8/vw=;
        b=NDkQ56+isFmgVWWlHD9O/zQ3xoXSBUBH8vr8M+R1IbPkx5ngGlzj0FWxixVkq9ioqp
         gCGSmpvHMmS7grxH0hwjO1qk7Hb39/Ka19YKwYEH0LUMoVA+Ac2q8phHllzyUb0iy99E
         NSkL7cizEgqPI4YJ6d8Hodgo9eoMQeA0uxvUG19YfpYc4rn34p5imXDfZQ7quV4BHZKS
         ZllhXcnL8vLYUUUpWGqZda81CmtHkGAygpkZCkJTUWyBjf3a0jONvFfp84BJZC9QLXR8
         9RLo1209n8N/IFNO3tRVAT6xiMaZ1QDtfiHHWNTB9AkdmjpcQ/S5jOqfNFsECcG8msRO
         Czog==
X-Gm-Message-State: AOAM531D8yAS4+E+Y4JefY9c6qWBnufOukBYXJSszQiKxML3Z5ReBshG
        qm7Cg022Yq4KVjFrFlIfXoaLBg==
X-Google-Smtp-Source: ABdhPJyBhnjYaHKKbEfnlUU0rpoWpGgWVScJOAenfp2X7EhRm7SH+e1L0eehd3cBdyFbEZGBA2K05w==
X-Received: by 2002:a05:600c:1991:: with SMTP id t17mr8399158wmq.118.1613379163409;
        Mon, 15 Feb 2021 00:52:43 -0800 (PST)
Received: from dell ([91.110.221.146])
        by smtp.gmail.com with ESMTPSA id a84sm24586107wme.12.2021.02.15.00.52.42
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 15 Feb 2021 00:52:43 -0800 (PST)
Date:   Mon, 15 Feb 2021 08:52:41 +0000
From:   Lee Jones <lee.jones@linaro.org>
To:     Krzysztof Kozlowski <krzk@kernel.org>
Cc:     linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-leds@vger.kernel.org, linux-iio@vger.kernel.org,
        dri-devel@lists.freedesktop.org, linux-fbdev@vger.kernel.org,
        linux-pwm@vger.kernel.org, Sebastian Reichel <sre@kernel.org>,
        Liam Girdwood <lgirdwood@gmail.com>,
        Mark Brown <broonie@kernel.org>, Pavel Machek <pavel@ucw.cz>,
        Dan Murphy <dmurphy@ti.com>,
        Jonathan Cameron <jic23@kernel.org>,
        Lars-Peter Clausen <lars@metafoo.de>,
        Peter Meerwald-Stadler <pmeerw@pmeerw.net>,
        Daniel Thompson <daniel.thompson@linaro.org>,
        Jingoo Han <jingoohan1@gmail.com>,
        Thierry Reding <thierry.reding@gmail.com>,
        Uwe =?iso-8859-1?Q?Kleine-K=F6nig?= 
        <u.kleine-koenig@pengutronix.de>,
        Jonathan Cameron <Jonathan.Cameron@huawei.com>
Subject: Re: [PATCH v4] MAINTAINERS: move Milo Kim to credits
Message-ID: <20210215085241.GG179940@dell>
References: <20210212163229.68270-1-krzk@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20210212163229.68270-1-krzk@kernel.org>
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

On Fri, 12 Feb 2021, Krzysztof Kozlowski wrote:

> Milo Kim's email in TI bounces with permanent error (550: Invalid
> recipient).  Last email from him on LKML was in 2017.  Move Milo Kim to
> credits and remove the separate driver entries for:
>  - TI LP855x backlight driver,
>  - TI LP8727 charger driver,
>  - TI LP8788 MFD (ADC, LEDs, charger and regulator) drivers.
> 
> Signed-off-by: Krzysztof Kozlowski <krzk@kernel.org>
> Cc: Mark Brown <broonie@kernel.org>
> Cc: Jonathan Cameron <Jonathan.Cameron@huawei.com>
> Cc: Jingoo Han <jingoohan1@gmail.com>
> Cc: Lee Jones <lee.jones@linaro.org>
> Cc: Pavel Machek <pavel@ucw.cz>
> Cc: Thierry Reding <thierry.reding@gmail.com>
> Cc: Sebastian Reichel <sre@kernel.org>
> Cc: Daniel Thompson <daniel.thompson@linaro.org>
> 
> ---
> 
> Dear Lee,
> 
> Could you take care about this patch?

Yes, but I'll be sending out my pull-request for v5.12 in the next
couple of days (maybe even today if I can find some time), so this
will have to wait until v5.13.

-- 
Lee Jones [李琼斯]
Senior Technical Lead - Developer Services
Linaro.org │ Open source software for Arm SoCs
Follow Linaro: Facebook | Twitter | Blog
