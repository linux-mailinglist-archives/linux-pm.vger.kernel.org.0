Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id EBE90173358
	for <lists+linux-pm@lfdr.de>; Fri, 28 Feb 2020 09:53:45 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726207AbgB1Ixo (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Fri, 28 Feb 2020 03:53:44 -0500
Received: from mail-wm1-f68.google.com ([209.85.128.68]:53402 "EHLO
        mail-wm1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726400AbgB1Ixn (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Fri, 28 Feb 2020 03:53:43 -0500
Received: by mail-wm1-f68.google.com with SMTP id f15so2314250wml.3
        for <linux-pm@vger.kernel.org>; Fri, 28 Feb 2020 00:53:40 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=subject:to:cc:references:from:openpgp:autocrypt:message-id:date
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=oPmfbH/VN//hr6zphyggj3FNTyzdqrj0mhzn9wcbAF4=;
        b=djvlR8dT39wIMOJ6JqJ5f/7x+HI3BSgTr5GIREnT4ZAsceT0FpRA7a0ywZ0dSzmPxF
         AS0ffDvPoCWPaCdNG8sFMjD4hfkiCw2Fl8ocyCL4va85dM/Ce0h9AdgEmxs5AiwYKEoq
         M0Ll/WLHfic5L/g50RLD7+7VIRDVG13oa5Fhr7485svPmMNFc+w5Qh732Vl47ti4rLfH
         canbtaCOcw5YNJV98nKqXRcCFZYHAGcs5PE/5zhWxV/r8+ng0Nh5L7quKEexDmN5sklH
         FJaWsNz18H7n0XNklrrbzvHs6efNr0yBejGF9aPx2zKTMvkleaS6rC1oPLY37Uy/Lg3Y
         yHDw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:openpgp:autocrypt
         :message-id:date:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=oPmfbH/VN//hr6zphyggj3FNTyzdqrj0mhzn9wcbAF4=;
        b=m7GGozziK7gnPAKlQIMI9PF6MMgbYo2qGovLEjPo798kSS2y3MdtU8zeczqzmRiQ+w
         RT3FIzKlJYmN3EA795ESIRpYT9xdRl3QVu3GOCVUkdQSFUtuQQQI10rqXyFeydcSiPKh
         CTN6gE6zwfbhVmigj1q29h7FcX+zh2ZOM3Wv8b+b4UvP+0OdF9RGz3leib1KRYAmLxml
         nR4x9bnPWmAGAJxLBIeIS09uFWUFauqdfIVvyra7TSUfT2LOc94ndWej6NMOfQGhUChD
         acoBrREneTRQy6F2vGQlU+pLc78YIK2M81GNgWKaJ60mmxOhNDzq00TnvwFl8Seoq2dC
         2aUw==
X-Gm-Message-State: APjAAAVTvKVdzfXumRvjkWqjT3HsNkRul15/kSlCS1BlJFKeycUmKINg
        OWFdYvK8K9ltwH6kdOiZ6Uh8og==
X-Google-Smtp-Source: APXvYqwqw0w8kj5U00AbZ2wrM0nyvr1emJKZpByzmypAeakrNOtZosPACGcBI/KOs6ypyFS1kIuv3Q==
X-Received: by 2002:a7b:c4cc:: with SMTP id g12mr4068558wmk.68.1582880019426;
        Fri, 28 Feb 2020 00:53:39 -0800 (PST)
Received: from [10.44.66.8] ([212.45.67.2])
        by smtp.googlemail.com with ESMTPSA id z8sm11050459wrv.74.2020.02.28.00.53.37
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 28 Feb 2020 00:53:38 -0800 (PST)
Subject: Re: [V4, 2/3] interconnect: qcom: Add SC7180 interconnect provider
 driver
To:     Odelu Kukatla <okukatla@codeaurora.org>, linux-pm@vger.kernel.org
Cc:     daidavid1@codeaurora.org, bjorn.andersson@linaro.org,
        evgreen@google.com, Andy Gross <agross@kernel.org>,
        linux-kernel@vger.kernel.org, linux-arm-msm@vger.kernel.org,
        sboyd@kernel.org, ilina@codeaurora.org, seansw@qti.qualcomm.com,
        elder@linaro.org, linux-arm-msm-owner@vger.kernel.org
References: <1582646384-1458-1-git-send-email-okukatla@codeaurora.org>
 <1582646384-1458-3-git-send-email-okukatla@codeaurora.org>
From:   Georgi Djakov <georgi.djakov@linaro.org>
Openpgp: preference=signencrypt
Autocrypt: addr=georgi.djakov@linaro.org; prefer-encrypt=mutual; keydata=
 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
 KEmKjLDvB0pePJkdTw==
Message-ID: <568574bd-c036-988e-bf95-9c06704d143a@linaro.org>
Date:   Fri, 28 Feb 2020 10:53:37 +0200
MIME-Version: 1.0
In-Reply-To: <1582646384-1458-3-git-send-email-okukatla@codeaurora.org>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

Hi Odelu,

Thank you for this patchset!

On 2/25/20 17:59, Odelu Kukatla wrote:
> Add driver for the Qualcomm interconnect buses found in SC7180 based
> platforms. The topology consists of several NoCs that are controlled by
> a remote processor that collects the aggregated bandwidth for each
> master-slave pairs.
> 
> Signed-off-by: Odelu Kukatla <okukatla@codeaurora.org>
> ---
>  drivers/interconnect/qcom/Kconfig  |   9 +
>  drivers/interconnect/qcom/Makefile |   2 +
>  drivers/interconnect/qcom/sc7180.c | 641 +++++++++++++++++++++++++++++++++++++
>  drivers/interconnect/qcom/sc7180.h | 149 +++++++++
>  4 files changed, 801 insertions(+)
>  create mode 100644 drivers/interconnect/qcom/sc7180.c
>  create mode 100644 drivers/interconnect/qcom/sc7180.h
> 
> diff --git a/drivers/interconnect/qcom/Kconfig b/drivers/interconnect/qcom/Kconfig
> index 08cfd67..c8e74b0 100644
> --- a/drivers/interconnect/qcom/Kconfig
> +++ b/drivers/interconnect/qcom/Kconfig
> @@ -42,6 +42,15 @@ config INTERCONNECT_QCOM_RPMH
>  	depends on INTERCONNECT_QCOM || COMPILE_TEST
>  	depends on QCOM_COMMAND_DB
>  
> +config INTERCONNECT_QCOM_SC7180
> +	tristate "Qualcomm SC7180 interconnect driver"
> +	depends on INTERCONNECT_QCOM
> +	select INTERCONNECT_QCOM_RPMH
> +	select INTERCONNECT_QCOM_BCM_VOTER

IMHO, we should still list here the dependencies here, or for some randconfig
builds we may get warnings for unmet direct dependencies. So i think you got
it right in your v3.

btw. It is also a good practice to list the changes in your cover letter, so
people who have looked at previous versions of that patches would know what
changed.

> +	help
> +	  This is a driver for the Qualcomm Network-on-Chip on sc7180-based
> +	  platforms.
> +
>  config INTERCONNECT_QCOM_SDM845
>  	tristate "Qualcomm SDM845 interconnect driver"
>  	depends on INTERCONNECT_QCOM
> diff --git a/drivers/interconnect/qcom/Makefile b/drivers/interconnect/qcom/Makefile
> index d591bb5..5325558 100644
> --- a/drivers/interconnect/qcom/Makefile
> +++ b/drivers/interconnect/qcom/Makefile
> @@ -5,6 +5,7 @@ qnoc-msm8916-objs			:= msm8916.o
>  qnoc-msm8974-objs			:= msm8974.o
>  qnoc-qcs404-objs			:= qcs404.o
>  icc-rpmh-obj				:= icc-rpmh.o
> +qnoc-sc7180-objs			:= sc7180.o
>  qnoc-sdm845-objs			:= sdm845.o
>  icc-smd-rpm-objs			:= smd-rpm.o
>  
> @@ -13,5 +14,6 @@ obj-$(CONFIG_INTERCONNECT_QCOM_MSM8916) += qnoc-msm8916.o
>  obj-$(CONFIG_INTERCONNECT_QCOM_MSM8974) += qnoc-msm8974.o
>  obj-$(CONFIG_INTERCONNECT_QCOM_QCS404) += qnoc-qcs404.o
>  obj-$(CONFIG_INTERCONNECT_QCOM_RPMH) += icc-rpmh.o
> +obj-$(CONFIG_INTERCONNECT_QCOM_SC7180) += qnoc-sc7180.o
>  obj-$(CONFIG_INTERCONNECT_QCOM_SDM845) += qnoc-sdm845.o
>  obj-$(CONFIG_INTERCONNECT_QCOM_SMD_RPM) += icc-smd-rpm.o
> diff --git a/drivers/interconnect/qcom/sc7180.c b/drivers/interconnect/qcom/sc7180.c
> new file mode 100644
> index 0000000..dcf493d
> --- /dev/null
> +++ b/drivers/interconnect/qcom/sc7180.c
> @@ -0,0 +1,641 @@
> +// SPDX-License-Identifier: GPL-2.0
> +/*
> + * Copyright (c) 2020, The Linux Foundation. All rights reserved.
> + *
> + */
> +
> +#include <linux/device.h>
> +#include <linux/interconnect.h>
> +#include <linux/interconnect-provider.h>
> +#include <linux/module.h>
> +#include <linux/of_platform.h>

I thought you will remove this? Maybe you missed some of the comments on v2.
Please check.

Thanks,
Georgi
