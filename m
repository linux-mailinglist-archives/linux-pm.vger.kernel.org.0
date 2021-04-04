Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A3A4B35387B
	for <lists+linux-pm@lfdr.de>; Sun,  4 Apr 2021 16:46:11 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229633AbhDDOqN (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Sun, 4 Apr 2021 10:46:13 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45214 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230210AbhDDOqL (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Sun, 4 Apr 2021 10:46:11 -0400
Received: from mail-ot1-x335.google.com (mail-ot1-x335.google.com [IPv6:2607:f8b0:4864:20::335])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A45D5C061788
        for <linux-pm@vger.kernel.org>; Sun,  4 Apr 2021 07:46:05 -0700 (PDT)
Received: by mail-ot1-x335.google.com with SMTP id h6-20020a0568300346b02901b71a850ab4so9243293ote.6
        for <linux-pm@vger.kernel.org>; Sun, 04 Apr 2021 07:46:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=/LaNflTLlNyLNnfybNeALEmO1QkTG5j1xdulmReRjoc=;
        b=CZM2rMQSwB2owpt42AvT2FwrK2kKavTNZW2qXqPm40A9XNcHC0qd3HPkMx8GmkhDg0
         I2HWKqyPeMPUr528I9raDod/WGbwejghrYK7Pxr1dc95XxjEy2uOFKB/WtqoOWrKotQW
         LnEgRS7NBlf+QZOz6cj/ImQzlXWTyjOHzVpEdk8T+2laECuM0dKXDvjREmNt1q+Nb7La
         KgTAxtDCCCelkVqOC9oag1gQWPuJ0SYnUy9fjIsyggISYFESRLeH8+NH+F0l/FzOdpEg
         aAHEU2J823upnfeAmfOfinMWhedQR8q3oAwKbJ3c4H3VSFUjM5h4JXaG32sLI+3a+zEO
         y8yg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=/LaNflTLlNyLNnfybNeALEmO1QkTG5j1xdulmReRjoc=;
        b=cUptW+V2pN0iMfXICUXnDAXOK5+cLhKO5B9k24KBmt2ggtKJwQsKGqtPcNOlSZ1Px8
         WzOShCx/pw+hMa65w2jA70CH1iYCykVB8ncFWJTRYIwnQ/bi/1ZUSBitWfcwpKwkjRGx
         jhWO/D0OcO7d3K3IV8TgX7qeqlLuGMYUbd630QqsGoHMDeczZuf3+GpDFqnHXw/JyabP
         CXfFJh98Dkf3Sk8NG2RB1OuieF6FJtYB6aJr2KpjpN368Yy1ALbxIpNqJGuGdFXxU4/u
         AcMwboMGC3kjxaBcHn5SGlg4jAMAoq37OBT7RzV/6/gZ8gqNSzELDK76lK5UeOyAOC6Z
         X7/Q==
X-Gm-Message-State: AOAM531fOgwziGmx7vAzatoktmEmGv8Wo/DBXKi1rTKkqM78EteMjFuZ
        DKmThwXOd3ntpoy0kkDiD8C7bw==
X-Google-Smtp-Source: ABdhPJyp7sIs73IWuqvjliAsiqBoC6b7KWxE8kmcQ6qGxXGJJkEpwC7cBxVPha62YNwSjCkVGUFyMw==
X-Received: by 2002:a9d:39ca:: with SMTP id y68mr19355517otb.84.1617547564520;
        Sun, 04 Apr 2021 07:46:04 -0700 (PDT)
Received: from yoga (104-57-184-186.lightspeed.austtx.sbcglobal.net. [104.57.184.186])
        by smtp.gmail.com with ESMTPSA id w2sm2963328oov.23.2021.04.04.07.46.03
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 04 Apr 2021 07:46:04 -0700 (PDT)
Date:   Sun, 4 Apr 2021 09:46:02 -0500
From:   Bjorn Andersson <bjorn.andersson@linaro.org>
To:     zhuguangqing83@gmail.com
Cc:     Amit Kucheria <amitk@kernel.org>, Andy Gross <agross@kernel.org>,
        Zhang Rui <rui.zhang@intel.com>,
        Daniel Lezcano <daniel.lezcano@linaro.org>,
        linux-pm@vger.kernel.org, linux-arm-msm@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2] thermal/drivers/tsens: fix missing put_device error
Message-ID: <20210404144602.GV904837@yoga>
References: <20210404125431.12208-1-zhuguangqing83@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210404125431.12208-1-zhuguangqing83@gmail.com>
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

On Sun 04 Apr 07:54 CDT 2021, zhuguangqing83@gmail.com wrote:

> From: Guangqing Zhu <zhuguangqing83@gmail.com>
> 
> Fixes coccicheck error:
> 
> drivers/thermal/qcom/tsens.c:759:4-10: ERROR: missing put_device; call
> of_find_device_by_node on line 715, but without a corresponding object
> release within this function.
> 
> Fixes: a7ff82976122 ("drivers: thermal: tsens: Merge tsens-common.c into
> tsens.c")
> 
> Signed-off-by: Guangqing Zhu <zhuguangqing83@gmail.com>

Reviewed-by: Bjorn Andersson <bjorn.andersson@linaro.org>

Regards,
Bjorn

> ---
> v2:
>   - Fix a error(missing a bracket) in v1.
> 
> ---
>  drivers/thermal/qcom/tsens.c | 6 ++++--
>  1 file changed, 4 insertions(+), 2 deletions(-)
> 
> diff --git a/drivers/thermal/qcom/tsens.c b/drivers/thermal/qcom/tsens.c
> index d8ce3a687b80..3c4c0516e58a 100644
> --- a/drivers/thermal/qcom/tsens.c
> +++ b/drivers/thermal/qcom/tsens.c
> @@ -755,8 +755,10 @@ int __init init_common(struct tsens_priv *priv)
>  		for (i = VER_MAJOR; i <= VER_STEP; i++) {
>  			priv->rf[i] = devm_regmap_field_alloc(dev, priv->srot_map,
>  							      priv->fields[i]);
> -			if (IS_ERR(priv->rf[i]))
> -				return PTR_ERR(priv->rf[i]);
> +			if (IS_ERR(priv->rf[i])) {
> +				ret = PTR_ERR(priv->rf[i]);
> +				goto err_put_device;
> +			}
>  		}
>  		ret = regmap_field_read(priv->rf[VER_MINOR], &ver_minor);
>  		if (ret)
> -- 
> 2.17.1
> 
