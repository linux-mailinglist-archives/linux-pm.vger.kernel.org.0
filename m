Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1CED036617F
	for <lists+linux-pm@lfdr.de>; Tue, 20 Apr 2021 23:23:05 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234116AbhDTVXS (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Tue, 20 Apr 2021 17:23:18 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58624 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234113AbhDTVXR (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Tue, 20 Apr 2021 17:23:17 -0400
Received: from mail-wm1-x32c.google.com (mail-wm1-x32c.google.com [IPv6:2a00:1450:4864:20::32c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 717ACC06174A
        for <linux-pm@vger.kernel.org>; Tue, 20 Apr 2021 14:22:44 -0700 (PDT)
Received: by mail-wm1-x32c.google.com with SMTP id o9-20020a1c41090000b029012c8dac9d47so90864wma.1
        for <linux-pm@vger.kernel.org>; Tue, 20 Apr 2021 14:22:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=kQP1W0MBWimzZ3NHtFo9wJkMkPBAuGsB/TCIhzxFq2s=;
        b=rzuVUTTZ+oUsaLSGlch2El9svn+1gJeN2CTAM2dlFJalEknnqY8jieUoKJMandXYw5
         QZfWrO/fCtAS4Xwwq2TXM9Iy3uRy8QH+nuli3JqOjJc7EuPcVvIffhlAvN97Fz34l8ia
         WH3lI4+K1dKIYEAqzYnvbfvtHE9IR4bgWqp6+CPXN5V37w7Huz1aHSniLIckyAujhYA1
         Z+1oizpgsPEIJqHLH4PvviEpK8DXrZj0iSCkGaMlUu6Nf1knvPWqKBMcnPfoq10ElgCI
         cmqTrIXD4kaQxJBtEfEFBAW+/ocrCUe+xYqD1l7Zw86HEs4V28M5Ahw7GfD+74LC9gXa
         o11A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=kQP1W0MBWimzZ3NHtFo9wJkMkPBAuGsB/TCIhzxFq2s=;
        b=pqGLOJXbEeSs4BUDYqlp/PcB8foeBraByrOKGSsQDz51p/RkfKZFyZTh/rs7O7RwRg
         ll5H8gttQ6PKAy/orkcAmtf8/JgJTKYeZkWatbFxqfZGObCC/uslfpRmK1h7HrvpWmKA
         yFQ53biSOCXNk8ioIXl6jgI/X5AEYP+PY4CVh1iILXjYze5oa/JdMCdtXA2lNRVVjRHx
         rbxSkwtxbl7F5telcr6SmBNX+WMVgdTe/Y1+eIX+X0NgD/5Ejty8exvXalD70vCJWOlE
         mZ6F5F13rnfKiJ1T4b0xIZV+qnvKYXo6jQDMDp7XUbIpXL6Fbfg7KNL6vEVki79EWFxG
         nVFw==
X-Gm-Message-State: AOAM530vKERhIkCV9aDjfDyKXZlI0YgaYwa+TKR/Rsn1YYOGQ1TLB0bu
        T/IT8JQ4ZhBNVgKzDkervasm/A==
X-Google-Smtp-Source: ABdhPJy16FwFXiDGc9r0CAAjvwJ8hNKS+OrtXiZvmcPPiEFLV6whPzFusug3HluJUQV47Qg5SULmPg==
X-Received: by 2002:a1c:4089:: with SMTP id n131mr6389622wma.77.1618953763027;
        Tue, 20 Apr 2021 14:22:43 -0700 (PDT)
Received: from ?IPv6:2a01:e34:ed2f:f020:d985:3a3b:ec32:bdfe? ([2a01:e34:ed2f:f020:d985:3a3b:ec32:bdfe])
        by smtp.googlemail.com with ESMTPSA id z15sm267741wrv.39.2021.04.20.14.22.41
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 20 Apr 2021 14:22:42 -0700 (PDT)
Subject: Re: [v3,1/3] thermal: mediatek: Relocate driver to mediatek folder
To:     Michael Kao <michael.kao@mediatek.com>,
        Zhang Rui <rui.zhang@intel.com>, linux-pm@vger.kernel.org,
        srv_heupstream@mediatek.com
Cc:     Eduardo Valentin <edubezval@gmail.com>,
        Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Matthias Brugger <matthias.bgg@gmail.com>, hsinyi@chromium.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org,
        linux-mediatek@lists.infradead.org
References: <20210312034018.17437-1-michael.kao@mediatek.com>
 <20210312034018.17437-2-michael.kao@mediatek.com>
From:   Daniel Lezcano <daniel.lezcano@linaro.org>
Message-ID: <836581c1-0738-8e42-b168-b54d0bd078a5@linaro.org>
Date:   Tue, 20 Apr 2021 23:22:40 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
MIME-Version: 1.0
In-Reply-To: <20210312034018.17437-2-michael.kao@mediatek.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

On 12/03/2021 04:40, Michael Kao wrote:
> Add Mediatek proprietary folder to upstream more thermal zone and cooler
> drivers. Relocate the original thermal controller driver to it and rename
> as soc_temp.c to show its purpose more clearly.

We already know the purpose :)

soc_temp gives no additional information.

Either keep the name or give the hardware sensor name. It is a driver
directory.

> Signed-off-by: Michael Kao <michael.kao@mediatek.com>
> ---
>  drivers/thermal/Kconfig                       | 14 ++++-------
>  drivers/thermal/Makefile                      |  2 +-
>  drivers/thermal/mediatek/Kconfig              | 23 +++++++++++++++++++
>  drivers/thermal/mediatek/Makefile             |  1 +
>  .../{mtk_thermal.c => mediatek/soc_temp.c}    |  0

[ ... ]

vvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvv


> +config MTK_THERMAL
> +	tristate "Mediatek thermal drivers"
> +	depends on THERMAL_OF
> +	help
> +	  This is the option for Mediatek thermal software
> +	  solutions. Please enable corresponding options to
> +	  get temperature information from thermal sensors or
> +	  turn on throttle mechaisms for thermal mitigation.
> +
> +if MTK_THERMAL


^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^

All the above not needed.

> +config MTK_SOC_THERMAL
> +	tristate "Temperature sensor driver for mediatek SoCs"
> +	depends on HAS_IOMEM
> +	depends on NVMEM
> +	depends on RESET_CONTROLLER
> +	help
> +	  Enable this option if you want to get SoC temperature
> +	  information for Mediatek platforms. This driver
> +	  configures thermal controllers to collect temperature
> +	  via AUXADC interface.
> +
> +endif
> diff --git a/drivers/thermal/mediatek/Makefile b/drivers/thermal/mediatek/Makefile
> new file mode 100644
> index 000000000000..f75313ddce5e
> --- /dev/null
> +++ b/drivers/thermal/mediatek/Makefile
> @@ -0,0 +1 @@
> +obj-$(CONFIG_MTK_SOC_THERMAL)	+= soc_temp.o
> diff --git a/drivers/thermal/mtk_thermal.c b/drivers/thermal/mediatek/soc_temp.c
> similarity index 100%
> rename from drivers/thermal/mtk_thermal.c
> rename to drivers/thermal/mediatek/soc_temp.c



-- 
<http://www.linaro.org/> Linaro.org │ Open source software for ARM SoCs

Follow Linaro:  <http://www.facebook.com/pages/Linaro> Facebook |
<http://twitter.com/#!/linaroorg> Twitter |
<http://www.linaro.org/linaro-blog/> Blog
