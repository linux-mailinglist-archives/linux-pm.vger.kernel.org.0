Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C77822ED4E7
	for <lists+linux-pm@lfdr.de>; Thu,  7 Jan 2021 18:01:11 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728158AbhAGRAV (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Thu, 7 Jan 2021 12:00:21 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51596 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726165AbhAGRAV (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Thu, 7 Jan 2021 12:00:21 -0500
Received: from mail-wm1-x335.google.com (mail-wm1-x335.google.com [IPv6:2a00:1450:4864:20::335])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9794EC0612F4
        for <linux-pm@vger.kernel.org>; Thu,  7 Jan 2021 08:59:40 -0800 (PST)
Received: by mail-wm1-x335.google.com with SMTP id v14so5772404wml.1
        for <linux-pm@vger.kernel.org>; Thu, 07 Jan 2021 08:59:40 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=mmzskSdQrTev/cCFm1H+i5iNhgQlXZbBR6M55+jIUbg=;
        b=p0FZbIHjagfRb2V9idGaKfOd3zkdv/4eXS3DJ41meEK8jk6I8AOTSYS1MsFFraN3di
         ux8SL6ohkQ4AIRrf7bzHsvHmarTw1r9rIQvGk3kql5bAIfqjUNH374oLhmueD91N+YvA
         iKutl8gulJLC/9H87XLTMdh7P6JpXc+0TnW0LMU471FUkhA7Se7gto7hmfUB+RzoMKt4
         v87iGORighicC5EJo7iqmDhzxPQTO6E9MY+YHDE6HhyiVZ+YQ7UN2Wctpz1+c8Nnjnm2
         ys2kqaWo76215ah0PEX34FZ5xAx7Ds3O1geNmeByFAXvAyREn0T+Ea0H4rNVa0pgxuwb
         K5Iw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=mmzskSdQrTev/cCFm1H+i5iNhgQlXZbBR6M55+jIUbg=;
        b=lYVKg0eY060Dn7eIEaoeNsGPMDSOLUHKLoo2TmDG3XMaFQG+W3E8xs4wVwUAZW06fk
         R/Zqf+XDyZvNOU7ARom+COu/jWDTQMztkKxIsIq6oZtSUSjNbK+62sp7i08IZVbcGXAh
         7HOhEoQjruEYe3MBZyFinpz1Cp64/18q+PjUwvXR0ReQNDE/uTTBqgfvFPVzd0Gx0HsE
         IPrPFS9VARcM0PU9rXpttORrB+vDrir1GqJ9KKAlPaeNsgS/jeKFrXS6Q7IepqMY7KZK
         Gms2/6WI6Bsgl7GsesrjnDMauCZko3xfuDENp0vxV+SelMo8/6h3GOIC+FFPiFbQZHR3
         yifQ==
X-Gm-Message-State: AOAM531Jy5EVcsVpU34kFOGTdpVBmc6YbivX1zCLQAHoQqAq7ltZhv1N
        xSYwYdikp8NAVsNjKAqAX/7yYQ==
X-Google-Smtp-Source: ABdhPJyOSGSpxEaUNicgKfPZbyMLJiHppv8e9n4occqn8Gv5bbSauWDqngbimbkh3mvgSdL8MjuQww==
X-Received: by 2002:a7b:c35a:: with SMTP id l26mr8537212wmj.182.1610038779235;
        Thu, 07 Jan 2021 08:59:39 -0800 (PST)
Received: from [192.168.0.41] (lns-bzn-59-82-252-152-224.adsl.proxad.net. [82.252.152.224])
        by smtp.googlemail.com with ESMTPSA id g5sm9205632wro.60.2021.01.07.08.59.37
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 07 Jan 2021 08:59:38 -0800 (PST)
Subject: Re: [PATCH 1/3] powercap/drivers/dtpm: Fix a double shift bug
To:     Dan Carpenter <dan.carpenter@oracle.com>,
        "Rafael J. Wysocki" <rjw@rjwysocki.net>
Cc:     Lukasz Luba <lukasz.luba@arm.com>, linux-pm@vger.kernel.org,
        kernel-janitors@vger.kernel.org
References: <X/V2k8dwaXJH6VFh@mwanda>
From:   Daniel Lezcano <daniel.lezcano@linaro.org>
Message-ID: <3723a63e-5c3f-9c15-2e2c-788e7e6ec0bf@linaro.org>
Date:   Thu, 7 Jan 2021 17:59:37 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
MIME-Version: 1.0
In-Reply-To: <X/V2k8dwaXJH6VFh@mwanda>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

On 06/01/2021 09:36, Dan Carpenter wrote:
> The DTPM_POWER_LIMIT_FLAG is used for test_bit() etc which take a bit
> number so it should be bit 0.  But currently it's set to BIT(0) then
> that is double shifted equivalent to BIT(BIT(0)).  This doesn't cause a
> run time problem because it's done consistently.
> 
> Fixes: a20d0ef97abf ("powercap/drivers/dtpm: Add API for dynamic thermal power management")
> Signed-off-by: Dan Carpenter <dan.carpenter@oracle.com>

Acked-by: Daniel Lezcano <daniel.lezcano@linaro.org>

> ---
>  drivers/powercap/dtpm.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/drivers/powercap/dtpm.c b/drivers/powercap/dtpm.c
> index 0abcc439d728..d49df0569cd4 100644
> --- a/drivers/powercap/dtpm.c
> +++ b/drivers/powercap/dtpm.c
> @@ -24,7 +24,7 @@
>  #include <linux/slab.h>
>  #include <linux/mutex.h>
>  
> -#define DTPM_POWER_LIMIT_FLAG BIT(0)
> +#define DTPM_POWER_LIMIT_FLAG 0
>  
>  static const char *constraint_name[] = {
>  	"Instantaneous",
> 


-- 
<http://www.linaro.org/> Linaro.org │ Open source software for ARM SoCs

Follow Linaro:  <http://www.facebook.com/pages/Linaro> Facebook |
<http://twitter.com/#!/linaroorg> Twitter |
<http://www.linaro.org/linaro-blog/> Blog
