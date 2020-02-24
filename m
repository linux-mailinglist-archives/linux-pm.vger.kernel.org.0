Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id C3BC016A3DF
	for <lists+linux-pm@lfdr.de>; Mon, 24 Feb 2020 11:27:29 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727281AbgBXK13 (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Mon, 24 Feb 2020 05:27:29 -0500
Received: from mail-wr1-f67.google.com ([209.85.221.67]:41786 "EHLO
        mail-wr1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726778AbgBXK13 (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Mon, 24 Feb 2020 05:27:29 -0500
Received: by mail-wr1-f67.google.com with SMTP id c9so9720475wrw.8
        for <linux-pm@vger.kernel.org>; Mon, 24 Feb 2020 02:27:27 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:content-transfer-encoding:in-reply-to
         :user-agent;
        bh=/wPxcyrQruYDAUyh+jsOvRDd2ILov7dBYbjfQHdUR9k=;
        b=OM1HSWa05yHXwkkMJacChsT5B/1SWbWNLxCzkWbbOoDmENeKMuT66ieIDskm160KTb
         0sbwd12T2eCBlJlA4lggTfxd1OQ81GmrG6BbeKSBJHvS5vgX7HjTzsflOdqniSLoMJaU
         /k1WGJ2ew/1V7nH6CxDjxb4Q50En04RBWnNBMZJLRe1dKdOctHgl49WA/xeXUHE9eJmF
         tc+a96pghF5lTrYgXKzyWjtq25uFpjadgURs27R/4CTUnOBJsrRrc8oQstDpVJMYNBY4
         RF7AUNQGUS4O7xIQLzeDwb6ZsqWHa5hLvKiCjr4+h+oXcfMY95FXUvUMPuCQ32exkDx5
         XnBg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:content-transfer-encoding
         :in-reply-to:user-agent;
        bh=/wPxcyrQruYDAUyh+jsOvRDd2ILov7dBYbjfQHdUR9k=;
        b=iKsUXXXACZTw+LENCfTFWt3F/njsX4xKAdIiS/KWN9zI9Vyi1StNRC5gA1zDbty8vz
         yHd2vlnwzkRstfr5Mkpm15e+Y3nVgU67tTDGsiovlbU5X1/zYtUDZad69Mk6A6S0HKgn
         bgtiRWrQpXxuYcPCj0SLFpA0sQFJ8+CGCsKMQV2kO/CrkMKipqlE+4EaNUH5oDqOo+PX
         GiM8mYgLqSTeuhae4xQ2qDxGti1OUumPL7JY78TsrZjTlcbz/wDiVF6yONX6mGLxkYqH
         cdyDVzLpvqrPQjDq+5sjZOMiVbNFpZMTcRnQUHrQKAWBlXcQJccFJFbp79quhTfUd0zb
         DAtA==
X-Gm-Message-State: APjAAAXvNNZfORFvhIwIZrS2yGH1dg9GNmuJVkCMCRQBN8+yvs4YwonJ
        debxAmwFisogUeLlHOhI5SyCDA==
X-Google-Smtp-Source: APXvYqzt5+G2FRAHu4Ld1WC5LSxw0Vs4RC2Rs28c7+oDkTb503qdeuPcpgIfu31rO5pd3EWywZu3KQ==
X-Received: by 2002:a5d:4c41:: with SMTP id n1mr2207962wrt.183.1582540047270;
        Mon, 24 Feb 2020 02:27:27 -0800 (PST)
Received: from dell ([2.31.163.122])
        by smtp.gmail.com with ESMTPSA id d3sm6569072wrr.56.2020.02.24.02.27.26
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 24 Feb 2020 02:27:26 -0800 (PST)
Date:   Mon, 24 Feb 2020 10:27:58 +0000
From:   Lee Jones <lee.jones@linaro.org>
To:     Prashant Malani <pmalani@chromium.org>
Cc:     enric.balletbo@collabora.com, groeck@chromium.org,
        bleung@chromium.org, sre@kernel.org, linux-kernel@vger.kernel.org,
        linux-pm@vger.kernel.org
Subject: Re: [PATCH v8 3/4] mfd: cros_ec: Check DT node for usbpd-notify add
Message-ID: <20200224102758.GN3494@dell>
References: <20200124231834.63628-1-pmalani@chromium.org>
 <20200124231834.63628-3-pmalani@chromium.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20200124231834.63628-3-pmalani@chromium.org>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

On Fri, 24 Jan 2020, Prashant Malani wrote:

> Add a check to ensure there is indeed an EC device tree entry before
> adding the cros-usbpd-notify device. This covers configs where both
> CONFIG_ACPI and CONFIG_OF are defined, but the EC device is defined
> using device tree and not in ACPI.

Don't this 'fix' a patch in *this* set?

If so, please squash and resend.

> Signed-off-by: Prashant Malani <pmalani@chromium.org>
> ---
> 
> Changes in v8:
> - Patch first introduced in v8 of the series.
> 
>  drivers/mfd/cros_ec_dev.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/drivers/mfd/cros_ec_dev.c b/drivers/mfd/cros_ec_dev.c
> index d0c28a4c10ad0..411e80fc9a066 100644
> --- a/drivers/mfd/cros_ec_dev.c
> +++ b/drivers/mfd/cros_ec_dev.c
> @@ -212,7 +212,7 @@ static int ec_device_probe(struct platform_device *pdev)
>  	 * explicitly added on platforms that don't have the PD notifier ACPI
>  	 * device entry defined.
>  	 */
> -	if (IS_ENABLED(CONFIG_OF)) {
> +	if (IS_ENABLED(CONFIG_OF) && ec->ec_dev->dev->of_node) {
>  		if (cros_ec_check_features(ec, EC_FEATURE_USB_PD)) {
>  			retval = mfd_add_hotplug_devices(ec->dev,
>  					cros_usbpd_notify_cells,

-- 
Lee Jones [李琼斯]
Linaro Services Technical Lead
Linaro.org │ Open source software for ARM SoCs
Follow Linaro: Facebook | Twitter | Blog
