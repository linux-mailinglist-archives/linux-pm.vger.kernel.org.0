Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id BBC033ACCE1
	for <lists+linux-pm@lfdr.de>; Fri, 18 Jun 2021 15:56:50 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234094AbhFRN65 (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Fri, 18 Jun 2021 09:58:57 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38054 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233754AbhFRN65 (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Fri, 18 Jun 2021 09:58:57 -0400
Received: from mail-wr1-x42c.google.com (mail-wr1-x42c.google.com [IPv6:2a00:1450:4864:20::42c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2174CC061574;
        Fri, 18 Jun 2021 06:56:48 -0700 (PDT)
Received: by mail-wr1-x42c.google.com with SMTP id m18so10891322wrv.2;
        Fri, 18 Jun 2021 06:56:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=Xizm99JD150ezeQOoH2mePCgmp/xdHQI0Sa2KlLfCYE=;
        b=kKFnimk0jGW0TVeqyZvO9ZxJpyRHln7vCrqNXdpfwxdm8HeoiDdp/JWycfazuaTE1U
         x5lpZep/wsAds82Qeb4HKQaRLfhJffWrBjo8emSMoJzVcwNRDusWywVVQY/j+0AYEpKu
         9086iEZngkzZucesNWjpGG0b1PMX3y4Mty6oLJoD1OhD6LHowCJgg078feaYjxe4n93o
         UahRsBdHGDkfKL43kzVygIvtwyoi/j1PEp9lIvWiDgTjUeJfYme4VRO0EY+4/mmU4R5+
         Tjy4WQLsKY2TaL17SaH7xLLjwVX4iQuW8IlhgtOHKkXdBAI/HR9WIERg36qaCPtrHIRz
         YUPA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=Xizm99JD150ezeQOoH2mePCgmp/xdHQI0Sa2KlLfCYE=;
        b=riorZsz8eQlOI3Oc7hL90tJVGItfm5s5MLQ8OyaT7/0rV7IOXV4hcWEUbghkdxJx74
         q68ETkJQ4tgScUKEQHG5MMVfNrJ7Xt+bdSnlAMhof3qeNnaYe5fejPmDKJJyP5CFmYPu
         HyBUAqakUr+kT1T8ez0rp18rtriCLXtMINetJFneqEZ+N6hwXB8qotwX4RHYAVwdTCdR
         tlXStV/IZimK9HcDg+xXoDuZ6XEZLZiRePDGzMOWNfcbTfcx3/j13CH0NJz4brRxc9s+
         ksld4gqyCHRDImrTnhKpKqCyPJJrqGAX6sS/rfrURE1BrsHWZUA9jwlMXl9VXGiadZB9
         54AA==
X-Gm-Message-State: AOAM533rkaSS0EV8YFk3pbeXDnvfkNTNqmZf69D4mh3e3uFA0via6/0l
        2hPV2hkj2henW159I/O1jEQ=
X-Google-Smtp-Source: ABdhPJxtJtd1fV658X/G1BMWPx4eA+Rrv6VLMcP9tTD5u5EkkXdWvbtyc3bnVU4B3m2vKa2M3xBHyQ==
X-Received: by 2002:a05:6000:1091:: with SMTP id y17mr4741964wrw.100.1624024606740;
        Fri, 18 Jun 2021 06:56:46 -0700 (PDT)
Received: from ziggy.stardust ([213.195.126.134])
        by smtp.gmail.com with ESMTPSA id 61sm9202800wrp.4.2021.06.18.06.56.45
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 18 Jun 2021 06:56:46 -0700 (PDT)
Subject: Re: [PATCH v5 1/3] thermal: mediatek: Relocate driver to mediatek
 folder
To:     Ben Tseng <ben.tseng@mediatek.com>,
        Fan Chen <fan.chen@mediatek.com>,
        Zhang Rui <rui.zhang@intel.com>,
        Daniel Lezcano <daniel.lezcano@linaro.org>,
        linux-pm@vger.kernel.org, srv_heupstream@mediatek.com
Cc:     Eduardo Valentin <edubezval@gmail.com>,
        Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>, hsinyi@chromium.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org,
        linux-mediatek@lists.infradead.org,
        Project_Global_Chrome_Upstream_Group@mediatek.com,
        Michael Kao <michael.kao@mediatek.com>,
        Michael Kao <michael.kao@mediatek.comi>
References: <20210617114707.10618-1-ben.tseng@mediatek.com>
 <20210617114707.10618-2-ben.tseng@mediatek.com>
From:   Matthias Brugger <matthias.bgg@gmail.com>
Message-ID: <372c579c-5cdc-e66a-af99-ea8ee8533ded@gmail.com>
Date:   Fri, 18 Jun 2021 15:56:45 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.10.2
MIME-Version: 1.0
In-Reply-To: <20210617114707.10618-2-ben.tseng@mediatek.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org



On 17/06/2021 13:47, Ben Tseng wrote:
> From: Michael Kao <michael.kao@mediatek.com>
> 
> Add Mediatek proprietary folder to upstream more thermal zone and cooler
> drivers. Relocate the original thermal controller driver to it and rename
> as soc_temp.c to show its purpose more clearly.
> 
> Signed-off-by: Michael Kao <michael.kao@mediatek.comi>
> Signed-off-by: Ben Tseng <ben.tseng@mediatek.com>

Reviewed-by: Matthias Brugger <matthias.bgg@gmail.com>

> ---
>  drivers/thermal/Kconfig                       | 14 ++++-------
>  drivers/thermal/Makefile                      |  2 +-
>  drivers/thermal/mediatek/Kconfig              | 23 +++++++++++++++++++
>  drivers/thermal/mediatek/Makefile             |  1 +
>  .../{mtk_thermal.c => mediatek/soc_temp.c}    |  0
>  5 files changed, 29 insertions(+), 11 deletions(-)
>  create mode 100644 drivers/thermal/mediatek/Kconfig
>  create mode 100644 drivers/thermal/mediatek/Makefile
>  rename drivers/thermal/{mtk_thermal.c => mediatek/soc_temp.c} (100%)
> 
> diff --git a/drivers/thermal/Kconfig b/drivers/thermal/Kconfig
> index d7f44deab5b1..7a4ba50ba97d 100644
> --- a/drivers/thermal/Kconfig
> +++ b/drivers/thermal/Kconfig
> @@ -401,16 +401,10 @@ config DA9062_THERMAL
>  	  zone.
>  	  Compatible with the DA9062 and DA9061 PMICs.
>  
> -config MTK_THERMAL
> -	tristate "Temperature sensor driver for mediatek SoCs"
> -	depends on ARCH_MEDIATEK || COMPILE_TEST
> -	depends on HAS_IOMEM
> -	depends on NVMEM || NVMEM=n
> -	depends on RESET_CONTROLLER
> -	default y
> -	help
> -	  Enable this option if you want to have support for thermal management
> -	  controller present in Mediatek SoCs
> +menu "Mediatek thermal drivers"
> +depends on ARCH_MEDIATEK || COMPILE_TEST
> +source "drivers/thermal/mediatek/Kconfig"
> +endmenu
>  
>  config AMLOGIC_THERMAL
>  	tristate "Amlogic Thermal Support"
> diff --git a/drivers/thermal/Makefile b/drivers/thermal/Makefile
> index 82fc3e616e54..9729a2b08991 100644
> --- a/drivers/thermal/Makefile
> +++ b/drivers/thermal/Makefile
> @@ -54,7 +54,7 @@ obj-y				+= st/
>  obj-$(CONFIG_QCOM_TSENS)	+= qcom/
>  obj-y				+= tegra/
>  obj-$(CONFIG_HISI_THERMAL)     += hisi_thermal.o
> -obj-$(CONFIG_MTK_THERMAL)	+= mtk_thermal.o
> +obj-$(CONFIG_MTK_THERMAL)	+= mediatek/
>  obj-$(CONFIG_GENERIC_ADC_THERMAL)	+= thermal-generic-adc.o
>  obj-$(CONFIG_UNIPHIER_THERMAL)	+= uniphier_thermal.o
>  obj-$(CONFIG_AMLOGIC_THERMAL)     += amlogic_thermal.o
> diff --git a/drivers/thermal/mediatek/Kconfig b/drivers/thermal/mediatek/Kconfig
> new file mode 100644
> index 000000000000..0351e73170b7
> --- /dev/null
> +++ b/drivers/thermal/mediatek/Kconfig
> @@ -0,0 +1,23 @@
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
> +
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
> 
