Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7E294290B33
	for <lists+linux-pm@lfdr.de>; Fri, 16 Oct 2020 20:16:48 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2391494AbgJPSQr (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Fri, 16 Oct 2020 14:16:47 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33154 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2391390AbgJPSQr (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Fri, 16 Oct 2020 14:16:47 -0400
Received: from mail-ot1-x341.google.com (mail-ot1-x341.google.com [IPv6:2607:f8b0:4864:20::341])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 38878C061755
        for <linux-pm@vger.kernel.org>; Fri, 16 Oct 2020 11:16:47 -0700 (PDT)
Received: by mail-ot1-x341.google.com with SMTP id f10so3255366otb.6
        for <linux-pm@vger.kernel.org>; Fri, 16 Oct 2020 11:16:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=lXUFwXy4CvWitPRBtcqz4P6w54dAmXcel3/G3PMWxJk=;
        b=W5g+DZ0Y+oLih8JHD8yavPz/uC0IhD0zJoUh59V8GVOd6SaaZhHBMLTt5ePflQ91pd
         /1kUpypg2gwGTndoH0SOMQ4qGBOfD1mSG1DMPuGMWpbezFoZsdHnDTHT/Upbey6/L7Kz
         3GbgLp8aWQrW9HWuXCtjyFqQLxE89a5b7wnqwGUQYZLS+4Jh5eLuKFL8LKEBgTyCo33S
         U3YHhKl8uN7kEOqUvYujVmRpHlbqNeh6F5yC2ElknhcZQYLtsmAaIwLgKodysE0Y41X3
         0qolVLm8P4JKYAIGBsu92Ii6hNPuaG9/tQM1oo7Wn8aGOXh9DQEX2sR00NElZLhkt2Nv
         BY7w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=lXUFwXy4CvWitPRBtcqz4P6w54dAmXcel3/G3PMWxJk=;
        b=TtIRXrSsLtM2n+qZNgSDci1fnORIv9k1856pARr1YhRArLhPbUNV722r6cZ4nEYbqA
         kboQsiYWKsl2F5JEwqx6R3pTIjpQgnJglIWf/YGf1pGAQpUtrOJWeEI3hIlhNGlz+MqL
         2jAryurwLMHTXCEXoh4rkS3xRaebNIu0wLHVCHN47JMrWa3ZTzWuglpCfDOYxYUQ5Zw+
         y+6Ne6osn58BR5pGKt0m8hOgRVpwaqY73v0s6KqI/SAr8hg4YFZWVVHlQFjz2t9pP9Dg
         wI+0OIdW8ZPJRR2YI3f8KB2EiclwV7LXkxPHVZCvnOI3ljvWLwdCCbvJz3JO7upBv2gH
         DllQ==
X-Gm-Message-State: AOAM531VBNWa+M/EdTxrKgjsnYX+NLL+aILJKGK+XxWeGCY/xAtqJSNp
        Yq1QGctPQ7n3Cqu0JaVmFspGLA==
X-Google-Smtp-Source: ABdhPJxMlYFEmvPd/oJ+AQMXJK2Q7X41clGIcOfyf7fGkqn3XjCTTzI8bIyIQwbfPa70i7PTr009ZA==
X-Received: by 2002:a9d:7315:: with SMTP id e21mr3387087otk.372.1602872206412;
        Fri, 16 Oct 2020 11:16:46 -0700 (PDT)
Received: from builder.lan (104-57-184-186.lightspeed.austtx.sbcglobal.net. [104.57.184.186])
        by smtp.gmail.com with ESMTPSA id e30sm1173034otf.49.2020.10.16.11.16.45
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 16 Oct 2020 11:16:45 -0700 (PDT)
Date:   Fri, 16 Oct 2020 13:11:35 -0500
From:   Bjorn Andersson <bjorn.andersson@linaro.org>
To:     Ulf Hansson <ulf.hansson@linaro.org>
Cc:     "Rafael J . Wysocki" <rjw@rjwysocki.net>,
        Nishanth Menon <nm@ti.com>, linux-pm@vger.kernel.org,
        Aaro Koskinen <aaro.koskinen@iki.fi>,
        Tony Lindgren <tony@atomide.com>,
        Andy Gross <agross@kernel.org>,
        Niklas Cassel <nks@flawful.org>,
        Heiko Stuebner <heiko@sntech.de>,
        Kevin Hilman <khilman@kernel.org>,
        linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-arm-msm@vger.kernel.org
Subject: Re: [PATCH 1/4] power: avs: qcom-cpr: Move the driver to the qcom
 specific drivers
Message-ID: <20201016181135.GB6705@builder.lan>
References: <20201006160516.319830-1-ulf.hansson@linaro.org>
 <20201006160516.319830-2-ulf.hansson@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20201006160516.319830-2-ulf.hansson@linaro.org>
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

On Tue 06 Oct 11:05 CDT 2020, Ulf Hansson wrote:

> The avs drivers are all SoC specific drivers that doesn't share any code.
> Instead they are located in a directory, mostly to keep similar
> functionality together. From a maintenance point of view, it makes better
> sense to collect SoC specific drivers like these, into the SoC specific
> directories.
> 
> Therefore, let's move the qcom-cpr driver to the qcom directory.
> 
> Cc: Niklas Cassel <nks@flawful.org>
> Cc: Bjorn Andersson <bjorn.andersson@linaro.org>
> Cc: Andy Gross <agross@kernel.org>
> Cc: linux-arm-msm@vger.kernel.org
> Signed-off-by: Ulf Hansson <ulf.hansson@linaro.org>

Acked-by: Bjorn Andersson <bjorn.andersson@linaro.org>

Regards,
Bjorn

> ---
>  MAINTAINERS                                      |  2 +-
>  drivers/power/avs/Kconfig                        | 16 ----------------
>  drivers/power/avs/Makefile                       |  1 -
>  drivers/soc/qcom/Kconfig                         | 16 ++++++++++++++++
>  drivers/soc/qcom/Makefile                        |  1 +
>  drivers/{power/avs/qcom-cpr.c => soc/qcom/cpr.c} |  0
>  6 files changed, 18 insertions(+), 18 deletions(-)
>  rename drivers/{power/avs/qcom-cpr.c => soc/qcom/cpr.c} (100%)
> 
> diff --git a/MAINTAINERS b/MAINTAINERS
> index 4f1a56f6efaa..f51dd1944fe6 100644
> --- a/MAINTAINERS
> +++ b/MAINTAINERS
> @@ -14337,7 +14337,7 @@ L:	linux-pm@vger.kernel.org
>  L:	linux-arm-msm@vger.kernel.org
>  S:	Maintained
>  F:	Documentation/devicetree/bindings/power/avs/qcom,cpr.txt
> -F:	drivers/power/avs/qcom-cpr.c
> +F:	drivers/soc/qcom/cpr.c
>  
>  QUALCOMM CPUFREQ DRIVER MSM8996/APQ8096
>  M:	Ilia Lin <ilia.lin@kernel.org>
> diff --git a/drivers/power/avs/Kconfig b/drivers/power/avs/Kconfig
> index cdb4237bfd02..089b6244b716 100644
> --- a/drivers/power/avs/Kconfig
> +++ b/drivers/power/avs/Kconfig
> @@ -12,22 +12,6 @@ menuconfig POWER_AVS
>  
>  	  Say Y here to enable Adaptive Voltage Scaling class support.
>  
> -config QCOM_CPR
> -	tristate "QCOM Core Power Reduction (CPR) support"
> -	depends on POWER_AVS && HAS_IOMEM
> -	select PM_OPP
> -	select REGMAP
> -	help
> -	  Say Y here to enable support for the CPR hardware found on Qualcomm
> -	  SoCs like QCS404.
> -
> -	  This driver populates CPU OPPs tables and makes adjustments to the
> -	  tables based on feedback from the CPR hardware. If you want to do
> -	  CPUfrequency scaling say Y here.
> -
> -	  To compile this driver as a module, choose M here: the module will
> -	  be called qcom-cpr
> -
>  config ROCKCHIP_IODOMAIN
>  	tristate "Rockchip IO domain support"
>  	depends on POWER_AVS && ARCH_ROCKCHIP && OF
> diff --git a/drivers/power/avs/Makefile b/drivers/power/avs/Makefile
> index 9007d05853e2..a1b8cd453f19 100644
> --- a/drivers/power/avs/Makefile
> +++ b/drivers/power/avs/Makefile
> @@ -1,4 +1,3 @@
>  # SPDX-License-Identifier: GPL-2.0-only
>  obj-$(CONFIG_POWER_AVS_OMAP)		+= smartreflex.o
> -obj-$(CONFIG_QCOM_CPR)			+= qcom-cpr.o
>  obj-$(CONFIG_ROCKCHIP_IODOMAIN)		+= rockchip-io-domain.o
> diff --git a/drivers/soc/qcom/Kconfig b/drivers/soc/qcom/Kconfig
> index 3dc3e3d61ea3..6a3b69b43ad5 100644
> --- a/drivers/soc/qcom/Kconfig
> +++ b/drivers/soc/qcom/Kconfig
> @@ -26,6 +26,22 @@ config QCOM_COMMAND_DB
>  	  resource on a RPM-hardened platform must use this database to get
>  	  SoC specific identifier and information for the shared resources.
>  
> +config QCOM_CPR
> +	tristate "QCOM Core Power Reduction (CPR) support"
> +	depends on ARCH_QCOM && HAS_IOMEM
> +	select PM_OPP
> +	select REGMAP
> +	help
> +	  Say Y here to enable support for the CPR hardware found on Qualcomm
> +	  SoCs like QCS404.
> +
> +	  This driver populates CPU OPPs tables and makes adjustments to the
> +	  tables based on feedback from the CPR hardware. If you want to do
> +	  CPUfrequency scaling say Y here.
> +
> +	  To compile this driver as a module, choose M here: the module will
> +	  be called qcom-cpr
> +
>  config QCOM_GENI_SE
>  	tristate "QCOM GENI Serial Engine Driver"
>  	depends on ARCH_QCOM || COMPILE_TEST
> diff --git a/drivers/soc/qcom/Makefile b/drivers/soc/qcom/Makefile
> index 93392d9dc7f7..ad675a6593d0 100644
> --- a/drivers/soc/qcom/Makefile
> +++ b/drivers/soc/qcom/Makefile
> @@ -3,6 +3,7 @@ CFLAGS_rpmh-rsc.o := -I$(src)
>  obj-$(CONFIG_QCOM_AOSS_QMP) +=	qcom_aoss.o
>  obj-$(CONFIG_QCOM_GENI_SE) +=	qcom-geni-se.o
>  obj-$(CONFIG_QCOM_COMMAND_DB) += cmd-db.o
> +obj-$(CONFIG_QCOM_CPR)		+= cpr.o
>  obj-$(CONFIG_QCOM_GSBI)	+=	qcom_gsbi.o
>  obj-$(CONFIG_QCOM_MDT_LOADER)	+= mdt_loader.o
>  obj-$(CONFIG_QCOM_OCMEM)	+= ocmem.o
> diff --git a/drivers/power/avs/qcom-cpr.c b/drivers/soc/qcom/cpr.c
> similarity index 100%
> rename from drivers/power/avs/qcom-cpr.c
> rename to drivers/soc/qcom/cpr.c
> -- 
> 2.25.1
> 
