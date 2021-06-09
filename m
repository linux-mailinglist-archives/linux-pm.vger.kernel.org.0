Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 78B773A0E87
	for <lists+linux-pm@lfdr.de>; Wed,  9 Jun 2021 10:09:52 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237086AbhFIILk (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Wed, 9 Jun 2021 04:11:40 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38680 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236372AbhFIILk (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Wed, 9 Jun 2021 04:11:40 -0400
Received: from mail-wm1-x330.google.com (mail-wm1-x330.google.com [IPv6:2a00:1450:4864:20::330])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B979AC061574;
        Wed,  9 Jun 2021 01:09:30 -0700 (PDT)
Received: by mail-wm1-x330.google.com with SMTP id k5-20020a05600c1c85b02901affeec3ef8so3683309wms.0;
        Wed, 09 Jun 2021 01:09:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=ZWS3MwmOtTgK8KzMw9axjq4+2CXYo4dUJ6kQFDobHa4=;
        b=RP9SBzME6Yp5GvJvuPzsa8sUoTFFIj9qPw33zzygi8NFBPwNH1Raxtlk5O7KBPxD1S
         b0ZpQEmFcCiAnywdlfGmTF3mSfJpsj2sJVbB7c00YPIDPqyFdNMmM/gwQdzlF10fOqWr
         O6rxzH2fUpkOfkSglik3kbs2aenbxAfAcfHr5Ydcbt3neH16dciL4w3FPj2ZIzD4z7Ji
         ZGG//irhoOjWPkLE95q4ZF3/kth7zhU+szCdFCT9E/br3rD4yrlj1XhYJgWTjYVlq+Bl
         zAiRHXPrTgOQeMBaMA15DfMPRDwKR3jOhvTzOuSq/gPCc+4FawwxcWbUc9+Q84EngWnt
         vv1Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=ZWS3MwmOtTgK8KzMw9axjq4+2CXYo4dUJ6kQFDobHa4=;
        b=gCZ3c4/TfIZobiqmEwjcvHxe4W3SlXVyHhE4lN8YBrjKsFm4hW8a+o0Bzhntegu3H2
         N9Lhwal7bZN/bk+FcM5JELR7Oy0m75Hd9CeFsCHEVBPytXZwn/jmGUVv+82q+/ad1Mh8
         Rysy55yEG7nZQ4x0XurMInXYLdshVeLVrWCNhWwQg/KdfAvlLQD8IMvJIauWFO7sjGJJ
         Yg6YnpqTT/8j4rk5BLKx0IPdGMgPiKegqD7AHozRXjmpTdPwpvIrQeBrqkAY1qKW3TWj
         GRERfkxtk9Kwj9x/evCwwIZOecnPDfGpnraYS1jXR8LumsHyhE8Ivf5L/j7nvnoB0BYk
         ChAw==
X-Gm-Message-State: AOAM530/CV4a2qAdFLCYW1sWCw+P00NLMkcUmjm6EhNzZrG6oE403f2+
        iN89GfaCP8plK4YAk5LQ8HiQr1rnFd0=
X-Google-Smtp-Source: ABdhPJxF19Evm7s4ElEWSnMEPIT+yKJD5u0Z2LH2a7HoLDsA4tr5Oe1LO+xtXd43URi0nrJ5s8BxWg==
X-Received: by 2002:a05:600c:4a09:: with SMTP id c9mr8315517wmp.162.1623226169391;
        Wed, 09 Jun 2021 01:09:29 -0700 (PDT)
Received: from ziggy.stardust (81.172.61.185.dyn.user.ono.com. [81.172.61.185])
        by smtp.gmail.com with ESMTPSA id v18sm24943781wrb.10.2021.06.09.01.09.28
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 09 Jun 2021 01:09:29 -0700 (PDT)
Subject: Re: [PATCH v4] thermal: mediatek: add sensors-support
To:     Frank Wunderlich <linux@fw-web.de>,
        linux-mediatek@lists.infradead.org
Cc:     Frank Wunderlich <frank-w@public-files.de>,
        Daniel Lezcano <daniel.lezcano@linaro.org>,
        Amit Kucheria <amitk@kernel.org>, linux-pm@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
References: <20210608154530.70074-1-linux@fw-web.de>
From:   Matthias Brugger <matthias.bgg@gmail.com>
Message-ID: <9eb45f06-1303-1438-7ba0-b9ccaa898b34@gmail.com>
Date:   Wed, 9 Jun 2021 10:09:28 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.10.2
MIME-Version: 1.0
In-Reply-To: <20210608154530.70074-1-linux@fw-web.de>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org



On 08/06/2021 17:45, Frank Wunderlich wrote:
> From: Frank Wunderlich <frank-w@public-files.de>
> 
> add HWMON-support to mediateks thermal driver to allow lm-sensors
> userspace tools read soc temperature
> 
> Signed-off-by: Frank Wunderlich <frank-w@public-files.de>

Reviewed-by: Matthias Brugger <matthias.bgg@gmail.com>

> ---
> v4: change message to dev_warn as suggested by matthias
> v3: drop no_hwmon
> v2: drop ifdef and used devm_thermal_add_hwmon_sysfs
> ---
>  drivers/thermal/mtk_thermal.c | 6 ++++++
>  1 file changed, 6 insertions(+)
> 
> diff --git a/drivers/thermal/mtk_thermal.c b/drivers/thermal/mtk_thermal.c
> index 97e8678ccf0e..ede94eadddda 100644
> --- a/drivers/thermal/mtk_thermal.c
> +++ b/drivers/thermal/mtk_thermal.c
> @@ -23,6 +23,8 @@
>  #include <linux/reset.h>
>  #include <linux/types.h>
>  
> +#include "thermal_hwmon.h"
> +
>  /* AUXADC Registers */
>  #define AUXADC_CON1_SET_V	0x008
>  #define AUXADC_CON1_CLR_V	0x00c
> @@ -1087,6 +1089,10 @@ static int mtk_thermal_probe(struct platform_device *pdev)
>  		goto err_disable_clk_peri_therm;
>  	}
>  
> +	ret = devm_thermal_add_hwmon_sysfs(tzdev);
> +	if (ret)
> +		dev_warn(&pdev->dev, "error in thermal_add_hwmon_sysfs");
> +
>  	return 0;
>  
>  err_disable_clk_peri_therm:
> 
