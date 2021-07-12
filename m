Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1220A3C61A9
	for <lists+linux-pm@lfdr.de>; Mon, 12 Jul 2021 19:12:38 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235321AbhGLRPT (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Mon, 12 Jul 2021 13:15:19 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38016 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230142AbhGLRPS (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Mon, 12 Jul 2021 13:15:18 -0400
Received: from mail-oi1-x22f.google.com (mail-oi1-x22f.google.com [IPv6:2607:f8b0:4864:20::22f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E30A8C061786
        for <linux-pm@vger.kernel.org>; Mon, 12 Jul 2021 10:12:29 -0700 (PDT)
Received: by mail-oi1-x22f.google.com with SMTP id l26so25289592oic.7
        for <linux-pm@vger.kernel.org>; Mon, 12 Jul 2021 10:12:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=hhYJAhkDrtzD1TZ603Y285exmmtUvo2J1DNQvlpOcc4=;
        b=iSdM+gXa0EpZbAN3Rcdr/ucRq4XtUaafuQg2PbaF/3hUxE9nLSSrhte/oVc/Jgaamt
         fJwmmcCbCn6gU3rE3UnGpCLDyCa5YKVTi/U1GerYkpk7LIg+4WuOk/0tF39ywnkT9xJX
         TGE64ilHlaV3aVy7CQ/Xk89puC3XcVhmjZjb83V/v3gwPghYMzDaipQNuHG2/e4vD0ju
         WyqlL6TJWT+qbACuMjmKP6+M5h0i8AY/hCgNWhXm6iJMfBKY9u2/tt7St2CyjLGh8U8D
         XaFE2M4ts2Z73BhA3GeqagIBN6svOgZWRpcGhdcl+Mqn+UhnqBR+mtyD68ZuO4yDdwdv
         k35w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=hhYJAhkDrtzD1TZ603Y285exmmtUvo2J1DNQvlpOcc4=;
        b=NZi9/pl4ImPcDKtmABzDLTe6tvfr7F7DURhT2sCCL/QKAfubR+W05QhpqydrDhbydJ
         TuIYxpErd8nCh4t1lw2IPjlTJ9BiL0obMJ/osxB7/W0fLANBMg9ugMr2IAry4aXVHSU1
         kpgleDJcqr1K0AYuFS4yIL4lQR8d3UFw/viivZUZEsbBUvMNbYVtggVf5s5sjTaXfPSz
         28KcFJrN7C82hu7Zg1IOQfPJtrAxFEhf3IXWvjfSpecW8lJK0E8Lqz2q5IU493hWga5Q
         2lB7CjwFWsBRReCpjdzWgb6XngqXKbmSyxjW69R2db4iGsUtRFsN1PHIh3nVNxfHkA9e
         WaeQ==
X-Gm-Message-State: AOAM533Y201x54dKO0nAcgOaTGL/EAmBu+Vn3Sp+TT1vVncE0sDPnzSB
        r8sbODrcskqACb3ySvWVlCHSyQ==
X-Google-Smtp-Source: ABdhPJwGv2i/4fNcLoL/Oj1RiFgJsvY/v54G/YzCwIQEseT14L/UZEscy4PJvTlnsQvCIrJyx7BwtA==
X-Received: by 2002:aca:5714:: with SMTP id l20mr11515246oib.74.1626109949263;
        Mon, 12 Jul 2021 10:12:29 -0700 (PDT)
Received: from yoga (104-57-184-186.lightspeed.austtx.sbcglobal.net. [104.57.184.186])
        by smtp.gmail.com with ESMTPSA id g1sm3257182otq.22.2021.07.12.10.12.28
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 12 Jul 2021 10:12:28 -0700 (PDT)
Date:   Mon, 12 Jul 2021 12:12:26 -0500
From:   Bjorn Andersson <bjorn.andersson@linaro.org>
To:     Shawn Guo <shawn.guo@linaro.org>
Cc:     Sebastian Reichel <sre@kernel.org>,
        Stephan Gerhold <stephan@gerhold.net>,
        Rob Herring <robh+dt@kernel.org>,
        Vinod Koul <vkoul@kernel.org>, devicetree@vger.kernel.org,
        linux-arm-msm@vger.kernel.org, linux-pm@vger.kernel.org
Subject: Re: [PATCH 3/3] power: reset: qcom-pon: Add support for
 'qcom,pon-reboot-not-used'
Message-ID: <YOx3+qy2JhmLP87r@yoga>
References: <20210705025032.12804-1-shawn.guo@linaro.org>
 <20210705025032.12804-4-shawn.guo@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210705025032.12804-4-shawn.guo@linaro.org>
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

On Sun 04 Jul 21:50 CDT 2021, Shawn Guo wrote:

> Check property 'qcom,pon-reboot-not-used' and skip reboot-mode setup
> if the property is present.  This is useful for devices that use IMEM
> instead of PON register to pass reboot mode, but still want to populate
> pwrkey and resin devices.
> 

If IMEM is used instead, I think it should be sufficient for the DT
author to omit mode-* properties to achieve this. If the PON hardware
doesn't support mode-*, then that should be reflected in the DT binding
and compatible.

Regards,
Bjorn

> Signed-off-by: Shawn Guo <shawn.guo@linaro.org>
> ---
>  drivers/power/reset/qcom-pon.c | 9 +++++++++
>  1 file changed, 9 insertions(+)
> 
> diff --git a/drivers/power/reset/qcom-pon.c b/drivers/power/reset/qcom-pon.c
> index 4a688741a88a..85fae9e85878 100644
> --- a/drivers/power/reset/qcom-pon.c
> +++ b/drivers/power/reset/qcom-pon.c
> @@ -47,6 +47,14 @@ static int pm8916_pon_probe(struct platform_device *pdev)
>  	struct pm8916_pon *pon;
>  	int error;
>  
> +	if (device_property_present(&pdev->dev, "qcom,pon-reboot-not-used")) {
> +		/*
> +		 * Skip reboot-mode setup and registration if PON is not used
> +		 * for passing reboot mode at all.
> +		 */
> +		goto done;
> +	}
> +
>  	pon = devm_kzalloc(&pdev->dev, sizeof(*pon), GFP_KERNEL);
>  	if (!pon)
>  		return -ENOMEM;
> @@ -75,6 +83,7 @@ static int pm8916_pon_probe(struct platform_device *pdev)
>  
>  	platform_set_drvdata(pdev, pon);
>  
> +done:
>  	return devm_of_platform_populate(&pdev->dev);
>  }
>  
> -- 
> 2.17.1
> 
