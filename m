Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id AD69D34000B
	for <lists+linux-pm@lfdr.de>; Thu, 18 Mar 2021 08:09:51 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229698AbhCRHJM (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Thu, 18 Mar 2021 03:09:12 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44350 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229600AbhCRHIl (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Thu, 18 Mar 2021 03:08:41 -0400
Received: from mail-wm1-x329.google.com (mail-wm1-x329.google.com [IPv6:2a00:1450:4864:20::329])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 74CEDC06174A
        for <linux-pm@vger.kernel.org>; Thu, 18 Mar 2021 00:08:41 -0700 (PDT)
Received: by mail-wm1-x329.google.com with SMTP id r10-20020a05600c35cab029010c946c95easo2665476wmq.4
        for <linux-pm@vger.kernel.org>; Thu, 18 Mar 2021 00:08:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=to:cc:references:from:subject:message-id:date:mime-version
         :in-reply-to:content-language:content-transfer-encoding;
        bh=tYyCLy2hNOWzr8X9wkzDu/aLJvecRkc3MlIGDL43D84=;
        b=zd8JS1IsADKWR0H+haadl3kwgDVTY80wS5vVfwcKWHtA+Pc8uUUADplsCdwc58x9Ay
         cz+eMWMeqWXNfmTvVzFmEKGfUJZzljEEV21WDaqoflGHGbdiXNbQWEka+8SL4jmRgmRt
         AP0u2/ipb/3a33yPjSuMSY9nzLnGzl3H6ULxMawzzELwBc5T9pTpDm+m2XFZkKrJ1zj5
         iSQE/TSbkZ26RG0MMa4FOGDu7nhbBxfqeAi4Ylccp1HXSbMLmRqshH97R3BpAV9cMP0+
         v3GKw8vYSFoxz/K4WdTtA4/WjHwkLcGYhK/5THvaZYzseLzZUh5UWMlfwHWSZWSY6VIF
         Jtbg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:to:cc:references:from:subject:message-id:date
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=tYyCLy2hNOWzr8X9wkzDu/aLJvecRkc3MlIGDL43D84=;
        b=N1GYwORJR5k0oMLaps5PckvujmIT25SpCkfTrfh43yMZFKcsuIzfTfeoJQwo97c3t/
         v/GjpxrqvcGhZk94RmGUTCUKqBc96lX4yq40V3FZEFp3dSA5YP6fZZPMdK3aHONAthpl
         8SuMTxb3hXIHMW1Y/0oxARpJnJRtu42eHmXtABJyfk7/ESu0gmxgevgQnayPYvZ3ot0v
         NFN+rJ47kO8eKLrP+FC/hYT72w7ZiPSkdQNOoIyLN6imfFQ/KIUjF/kNIMgjY1r1RKxu
         NP7WsZAu3SaIqGYUAHrSKMRQUmaMBUK874tRX/XIhmS/fhVXsrmRfcTpoIOcpj7JS5zy
         xIHQ==
X-Gm-Message-State: AOAM531cEyKsAv1UScexUPqMipYD2uvnI1F3+Ax6miMeGsDo03Rqk9T6
        4BAgeT/QyU2aAkwhO57AsiCqH0oyUSdzbw==
X-Google-Smtp-Source: ABdhPJx2mwu56ekL6RAkkwFD/e0wUpre3b1LhPriPxcJtF90oIkr/C7m31U9JM3IOE2Alq7gYWwTOA==
X-Received: by 2002:a05:600c:290a:: with SMTP id i10mr2143686wmd.91.1616051320240;
        Thu, 18 Mar 2021 00:08:40 -0700 (PDT)
Received: from [10.44.66.8] ([212.45.67.2])
        by smtp.googlemail.com with ESMTPSA id e18sm1696061wru.73.2021.03.18.00.08.39
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 18 Mar 2021 00:08:39 -0700 (PDT)
To:     Vinod Koul <vkoul@kernel.org>
Cc:     linux-arm-msm@vger.kernel.org,
        Bjorn Andersson <bjorn.andersson@linaro.org>,
        Andy Gross <agross@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Odelu Kukatla <okukatla@codeaurora.org>,
        linux-pm@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
References: <20210302134323.2822076-1-vkoul@kernel.org>
 <20210302134323.2822076-3-vkoul@kernel.org>
From:   Georgi Djakov <georgi.djakov@linaro.org>
Subject: Re: [PATCH v2 2/2] interconnect: qcom: Add SM8350 interconnect
 provider driver
Message-ID: <0c405a3c-1759-34f3-08c6-116444479b09@linaro.org>
Date:   Thu, 18 Mar 2021 09:08:39 +0200
MIME-Version: 1.0
In-Reply-To: <20210302134323.2822076-3-vkoul@kernel.org>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

Hi Vinod,

On 3/2/21 15:43, Vinod Koul wrote:
> Add driver for the Qualcomm interconnect buses found in SM8i350 based

Still SM8i350? Have you checked my comments on v1?

> platforms. The topology consists of several NoCs that are controlled by
> a remote processor that collects the aggregated bandwidth for each
> master-slave pairs.
> 
> Generated from downstream interconnect driver written by David Dai
> 
> Signed-off-by: Vinod Koul <vkoul@kernel.org>
> ---
>  drivers/interconnect/qcom/Kconfig  |  10 +
>  drivers/interconnect/qcom/Makefile |   2 +
>  drivers/interconnect/qcom/sm8350.c | 636 +++++++++++++++++++++++++++++
>  drivers/interconnect/qcom/sm8350.h | 168 ++++++++
>  4 files changed, 816 insertions(+)
>  create mode 100644 drivers/interconnect/qcom/sm8350.c
>  create mode 100644 drivers/interconnect/qcom/sm8350.h
> 
> diff --git a/drivers/interconnect/qcom/Kconfig b/drivers/interconnect/qcom/Kconfig
> index ca52647f8955..836157d97cae 100644
> --- a/drivers/interconnect/qcom/Kconfig
> +++ b/drivers/interconnect/qcom/Kconfig
> @@ -110,5 +110,15 @@ config INTERCONNECT_QCOM_SM8250
>  	  This is a driver for the Qualcomm Network-on-Chip on sm8250-based
>  	  platforms.
>  
> +config INTERCONNECT_QCOM_SM8350
> +	tristate "Qualcomm SM8350 interconnect driver"
> +	depends on INTERCONNECT_QCOM
> +	depends on (QCOM_RPMH && QCOM_COMMAND_DB && OF) || COMPILE_TEST

Again: depends on INTERCONNECT_QCOM_RPMH_POSSIBLE

> +	select INTERCONNECT_QCOM_RPMH
> +	select INTERCONNECT_QCOM_BCM_VOTER
> +	help
> +	  This is a driver for the Qualcomm Network-on-Chip on SM8350-based
> +	  platforms.
> +
>  config INTERCONNECT_QCOM_SMD_RPM
>  	tristate
> diff --git a/drivers/interconnect/qcom/Makefile b/drivers/interconnect/qcom/Makefile
> index c6a735df067e..93d97e590836 100644
> --- a/drivers/interconnect/qcom/Makefile
> +++ b/drivers/interconnect/qcom/Makefile
> @@ -12,6 +12,7 @@ qnoc-sdm845-objs			:= sdm845.o
>  qnoc-sdx55-objs				:= sdx55.o
>  qnoc-sm8150-objs			:= sm8150.o
>  qnoc-sm8250-objs			:= sm8250.o
> +qnoc-sm8350-objs			:= sm8350.o
>  icc-smd-rpm-objs			:= smd-rpm.o icc-rpm.o
>  
>  obj-$(CONFIG_INTERCONNECT_QCOM_BCM_VOTER) += icc-bcm-voter.o
> @@ -26,4 +27,5 @@ obj-$(CONFIG_INTERCONNECT_QCOM_SDM845) += qnoc-sdm845.o
>  obj-$(CONFIG_INTERCONNECT_QCOM_SDX55) += qnoc-sdx55.o
>  obj-$(CONFIG_INTERCONNECT_QCOM_SM8150) += qnoc-sm8150.o
>  obj-$(CONFIG_INTERCONNECT_QCOM_SM8250) += qnoc-sm8250.o
> +obj-$(CONFIG_INTERCONNECT_QCOM_SM8350) += qnoc-sm8350.o
>  obj-$(CONFIG_INTERCONNECT_QCOM_SMD_RPM) += icc-smd-rpm.o
> diff --git a/drivers/interconnect/qcom/sm8350.c b/drivers/interconnect/qcom/sm8350.c
> new file mode 100644
> index 000000000000..55c76542aeff
> --- /dev/null
> +++ b/drivers/interconnect/qcom/sm8350.c
> @@ -0,0 +1,636 @@
> +// SPDX-License-Identifier: GPL-2.0-only
> +/*
> + * Copyright (c) 2019-2020, The Linux Foundation. All rights reserved.
> + * Copyright (c) 2021, Linaro Limited
> + *
> + */
> +
> +#include <linux/device.h>
> +#include <linux/interconnect.h>
> +#include <linux/interconnect-provider.h>
> +#include <linux/module.h>
> +#include <linux/of_device.h>
> +#include <linux/of_platform.h>

Is this used?

Thanks,
Georgi
