Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 83E382B03BE
	for <lists+linux-pm@lfdr.de>; Thu, 12 Nov 2020 12:22:29 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727789AbgKLLW1 (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Thu, 12 Nov 2020 06:22:27 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58284 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727035AbgKLLWZ (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Thu, 12 Nov 2020 06:22:25 -0500
Received: from mail-wm1-x342.google.com (mail-wm1-x342.google.com [IPv6:2a00:1450:4864:20::342])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A67CFC0613D1
        for <linux-pm@vger.kernel.org>; Thu, 12 Nov 2020 03:22:25 -0800 (PST)
Received: by mail-wm1-x342.google.com with SMTP id p22so4934222wmg.3
        for <linux-pm@vger.kernel.org>; Thu, 12 Nov 2020 03:22:25 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=TBhNsZQdgwb8L9O2fB8roWDMxhxwp24jJn01jx9v16I=;
        b=fLq5eB6xzW9c5XCZ9Dg4JnnRSMdtdI+CZBnL2CzEAEuKEuS39D6ZFcEek4RjXyOFit
         FDsjiHViAwjEIIO8c+1TwFxg0hlixayoQxpJbx43404PHsw+cZhwl2+JrkuDpeyZ/q6L
         RuVwDShqzMYZh7BcQFtFj4U/kcqZQPp1ICr/OYZ08q8eF5JJeMecAn72mD6sPifocbmH
         12yTSJQ22RPaY6ToOa4u+rIMJHLU8q/+wl0DVsc8wVpZO9YOviis1H9apNn8c5nV1WqM
         DiRwbxDT39NY06+BSaKjC+L5g56SmFVxOKJKH/yAs43bDCztvdoEdJjUdR2PCQeJWwoS
         1S9g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=TBhNsZQdgwb8L9O2fB8roWDMxhxwp24jJn01jx9v16I=;
        b=MmVe/MMITwKdYcg7ltwuhZYXlUCzsLrfJcobOVeVQOGubhw1DXMm1GrRCQcsIkaDKQ
         IvwJzYGs8LrePhEws7Ye0TL593PqGg++Ut/PXIGEOGChPEWapwlV7UzRr0iM5GVYO4Rl
         KB+7XLNR9O5ThVmesTLpMaMy493ucREh2vF25DbLB5CuAUEJxmNT6f7ks79f+0w9JAn/
         sWvdfGGYE7fwz95foMHFIW1oVnpxvTHXtA1sq9ops9yFlgJ3cHjb55+lTUeUcRXYl6aj
         VU8LLwWgtTJfKXxICK+K0QJ0lKsDJGBClOaHuWpNWGKg7ujSZqho3GVHHIE/TGorzKI+
         Eg/g==
X-Gm-Message-State: AOAM533/BS9DI7PZwDG04KeDcN6WekpL7slSz/hv+kthGliW6CvMQaOO
        V+V6IgaFzymBgUe/Eq3HoG9VMw==
X-Google-Smtp-Source: ABdhPJwTMc42ZSo5QtIlCWsJfNkBbfVitTMYGPJhgclF1n2ZOjp9XjJdfrQd7R638dyC6QUROHA+pA==
X-Received: by 2002:a1c:b70b:: with SMTP id h11mr9650589wmf.185.1605180144219;
        Thu, 12 Nov 2020 03:22:24 -0800 (PST)
Received: from ?IPv6:2a01:e34:ed2f:f020:6971:b700:3764:fa96? ([2a01:e34:ed2f:f020:6971:b700:3764:fa96])
        by smtp.googlemail.com with ESMTPSA id m22sm6500180wrb.97.2020.11.12.03.22.23
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 12 Nov 2020 03:22:23 -0800 (PST)
Subject: Re: [Resend][PATCH] drivers/thermal: fix potential memleak in error
 branch
To:     Bernard <bernard@vivo.com>, Zhang Rui <rui.zhang@intel.com>,
        Amit Kucheria <amitk@kernel.org>, linux-pm@vger.kernel.org,
        linux-kernel@vger.kernel.org
Cc:     opensource.kernel@vivo.com
References: <AOUAJQBgDcHjy8iGeDq3e4rT.1.1604995817639.Hmail.bernard@vivo.com>
From:   Daniel Lezcano <daniel.lezcano@linaro.org>
Message-ID: <b40dc34b-85b2-4d7a-e28e-7beea4bb29f6@linaro.org>
Date:   Thu, 12 Nov 2020 12:22:22 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
MIME-Version: 1.0
In-Reply-To: <AOUAJQBgDcHjy8iGeDq3e4rT.1.1604995817639.Hmail.bernard@vivo.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

On 10/11/2020 09:10, Bernard wrote:
> Function __thermal_cooling_device_register, when device_register
> failed, cdev is not free after error value return, this may
> bring in potential memleak.
> 
> Signed-off-by: Bernard Zhao <bernard@vivo.com>
> ---
>  drivers/thermal/thermal_core.c | 1 +
>  1 file changed, 1 insertion(+)
> 
> diff --git a/drivers/thermal/thermal_core.c b/drivers/thermal/thermal_core.c
> index 3d1e0033bf3e..e4bee15dfa1f 100644
> --- a/drivers/thermal/thermal_core.c
> +++ b/drivers/thermal/thermal_core.c
> @@ -1125,6 +1125,7 @@ __thermal_cooling_device_register(struct device_node *np,
>  	if (result) {
>  		ida_simple_remove(&thermal_cdev_ida, cdev->id);
>  		put_device(&cdev->device);
> +		kfree(cdev);
>  		return ERR_PTR(result);
>  	}

Please fix the function with the proper error path and the labels.

Thanks

  -- Daniel


-- 
<http://www.linaro.org/> Linaro.org │ Open source software for ARM SoCs

Follow Linaro:  <http://www.facebook.com/pages/Linaro> Facebook |
<http://twitter.com/#!/linaroorg> Twitter |
<http://www.linaro.org/linaro-blog/> Blog
