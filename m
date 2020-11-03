Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E34A42A4BD5
	for <lists+linux-pm@lfdr.de>; Tue,  3 Nov 2020 17:45:13 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728524AbgKCQpM (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Tue, 3 Nov 2020 11:45:12 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40374 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728522AbgKCQpL (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Tue, 3 Nov 2020 11:45:11 -0500
Received: from mail-wm1-x342.google.com (mail-wm1-x342.google.com [IPv6:2a00:1450:4864:20::342])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A0567C061A47
        for <linux-pm@vger.kernel.org>; Tue,  3 Nov 2020 08:45:11 -0800 (PST)
Received: by mail-wm1-x342.google.com with SMTP id c18so13401298wme.2
        for <linux-pm@vger.kernel.org>; Tue, 03 Nov 2020 08:45:11 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=subject:to:cc:references:from:autocrypt:message-id:date
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=QVYSL7Z7XSgVb+kN/ChQfOvuxiKpkqlxd/bMhr/vzd0=;
        b=eR2eh/ew+5BKh8a8YAYPPrPz99u4o8NTTZPjaHpYEpPSkNh8KQm90kx2omCbKCLedO
         SqztYlervHqm0+Hht0b9EOr8U4Y97NyEEHjfv67mW8qeUCEQTzP8F+j8BY8Gxi4bsRQO
         C4PAObCYns+hKSe4u7X/USssgryGxFxwVjX/4A2tydK/5PX8E6+8OIBEy3nWQ7ufMj7y
         4dUvpd7ZiBdgus7Bib44KWrgvAx8IagpfJukBvdwG5VU9YGF7n+bnhmpwcpx5ubraL3a
         D+7KBSTA4P3kqX6vtb2cd3ocRQDJTJBPfJiBm1Y/3KiTgQ77piHoSPaM7EZyKU4mh0no
         EZRw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:autocrypt
         :message-id:date:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=QVYSL7Z7XSgVb+kN/ChQfOvuxiKpkqlxd/bMhr/vzd0=;
        b=pLRoZV9zshkpTBkPjqDHgeioEJEBSfNFol8LNrmXLqu8TjE4d3pvq3PeNArK5VGfqt
         /U9ei1YOHA3vnWvOgXmg6c6GbYegYf5cpeouMoqqBOIabI1G7z7GwEmAlza6a+gHLIhv
         lXW52GYu3FuVAQ/8UfCRmF5bexfOZxqivqxzQaMDBI88fXnhQeFBLxRRpNz0bZ91y2Sp
         +afbRkKFfhMd77etPovPdAVYq/ekzJhEDBOgwMJXWZ8C4SjABJjgRaLvL1+QjBP7/cfM
         poJv75zMMHwwbO0XmG1x9kA3h6jhheP8wf6y6C2riBadCmi3k4R67AOoiRClqHL51SpP
         LsCQ==
X-Gm-Message-State: AOAM532ubpyOUHYGAyPHBxiRjF8sIgl1mi2Z9MAuarcSyeBi+e1P5VdY
        m9xobKkskatcJp4x+RrCrFcYyg==
X-Google-Smtp-Source: ABdhPJwF8gbDb8L3Tz1UdLuY3+8DQb937KN1OTBNJ7x2becQ9TqjfefvGY69ex8uGSenwM77E59owQ==
X-Received: by 2002:a05:600c:210:: with SMTP id 16mr21621wmi.122.1604421910339;
        Tue, 03 Nov 2020 08:45:10 -0800 (PST)
Received: from [10.44.66.8] ([212.45.67.2])
        by smtp.googlemail.com with ESMTPSA id v6sm3430544wmj.6.2020.11.03.08.45.09
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 03 Nov 2020 08:45:09 -0800 (PST)
Subject: Re: [PATCH 5/5] interconnect: qcom: Add MSM8939 interconnect provider
 driver
To:     Jun Nie <jun.nie@linaro.org>
Cc:     devicetree@vger.kernel.org, bjorn.andersson@linaro.org,
        agross@kernel.org, linux-pm@vger.kernel.org,
        linux-arm-msm@vger.kernel.org, linux-kernel@vger.kernel.org,
        robh@kernel.org, shawn.guo@linaro.org
References: <20200930081645.3434-1-jun.nie@linaro.org>
 <20200930081645.3434-6-jun.nie@linaro.org>
From:   Georgi Djakov <georgi.djakov@linaro.org>
Autocrypt: addr=georgi.djakov@linaro.org; prefer-encrypt=mutual; keydata=
 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
 KEmKjLDvB0pePJkdTw==
Message-ID: <39ad2fc8-8604-5529-c2d5-d5b434f19859@linaro.org>
Date:   Tue, 3 Nov 2020 18:45:12 +0200
MIME-Version: 1.0
In-Reply-To: <20200930081645.3434-6-jun.nie@linaro.org>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

On 9/30/20 11:16, Jun Nie wrote:
> Add driver for the Qualcomm interconnect buses found in MSM8939 based
> platforms. The topology consists of four NoCs that are controlled by
> a remote processor that collects the aggregated bandwidth for each
> master-slave pairs.
> 
> Signed-off-by: Jun Nie <jun.nie@linaro.org>
> ---
>  drivers/interconnect/qcom/Kconfig   |   9 +
>  drivers/interconnect/qcom/Makefile  |   2 +
>  drivers/interconnect/qcom/msm8939.c | 355 ++++++++++++++++++++++++++++
>  3 files changed, 366 insertions(+)
>  create mode 100644 drivers/interconnect/qcom/msm8939.c
> 
> diff --git a/drivers/interconnect/qcom/Kconfig b/drivers/interconnect/qcom/Kconfig
> index 25486de5a38d..6395404bfe3f 100644
> --- a/drivers/interconnect/qcom/Kconfig
> +++ b/drivers/interconnect/qcom/Kconfig
> @@ -17,6 +17,15 @@ config INTERCONNECT_QCOM_MSM8916
>  	  This is a driver for the Qualcomm Network-on-Chip on msm8916-based
>  	  platforms.
>  
> +config INTERCONNECT_QCOM_MSM8939
> +	tristate "Qualcomm MSM8939 interconnect driver"
> +	depends on INTERCONNECT_QCOM
> +	depends on QCOM_SMD_RPM
> +	select INTERCONNECT_QCOM_SMD_RPM
> +	help
> +	  This is a driver for the Qualcomm Network-on-Chip on msm8939-based
> +	  platforms.
> +
>  config INTERCONNECT_QCOM_MSM8974
>  	tristate "Qualcomm MSM8974 interconnect driver"
>  	depends on INTERCONNECT_QCOM
> diff --git a/drivers/interconnect/qcom/Makefile b/drivers/interconnect/qcom/Makefile
> index f5e803489de0..84b75022f0d8 100644
> --- a/drivers/interconnect/qcom/Makefile
> +++ b/drivers/interconnect/qcom/Makefile
> @@ -2,6 +2,7 @@
>  
>  icc-bcm-voter-objs			:= bcm-voter.o
>  qnoc-msm8916-objs			:= msm8916.o
> +qnoc-msm8939-objs			:= msm8939.o
>  qnoc-msm8974-objs			:= msm8974.o
>  icc-osm-l3-objs				:= osm-l3.o
>  qnoc-qcs404-objs			:= qcs404.o
> @@ -13,6 +14,7 @@ icc-smd-rpm-objs			:= smd-rpm.o icc-rpm.o
>  
>  obj-$(CONFIG_INTERCONNECT_QCOM_BCM_VOTER) += icc-bcm-voter.o
>  obj-$(CONFIG_INTERCONNECT_QCOM_MSM8916) += qnoc-msm8916.o
> +obj-$(CONFIG_INTERCONNECT_QCOM_MSM8939) += qnoc-msm8939.o
>  obj-$(CONFIG_INTERCONNECT_QCOM_MSM8974) += qnoc-msm8974.o
>  obj-$(CONFIG_INTERCONNECT_QCOM_OSM_L3) += icc-osm-l3.o
>  obj-$(CONFIG_INTERCONNECT_QCOM_QCS404) += qnoc-qcs404.o
> diff --git a/drivers/interconnect/qcom/msm8939.c b/drivers/interconnect/qcom/msm8939.c
> new file mode 100644
> index 000000000000..dfbec30ed149
> --- /dev/null
> +++ b/drivers/interconnect/qcom/msm8939.c
> @@ -0,0 +1,355 @@
> +// SPDX-License-Identifier: GPL-2.0
> +/*
> + * Copyright (C) 2020 Linaro Ltd
> + * Author: Jun Nie <jun.nie@linaro.org>
> + * With reference of msm8916 interconnect driver of Georgi Djakov.
> + */
> +
> +#include <linux/clk.h>
> +#include <linux/device.h>
> +#include <linux/interconnect-provider.h>
> +#include <linux/io.h>
> +#include <linux/module.h>
> +#include <linux/platform_device.h>
> +#include <linux/of_device.h>

Nit: Move this above platform_device.h to make it sorted.

> +
> +#include <dt-bindings/interconnect/qcom,msm8939.h>
> +
> +#include "smd-rpm.h"
> +#include "icc-rpm.h"
> +
[..]
> +static const struct of_device_id msm8939_noc_of_match[] = {
> +	{ .compatible = "qcom,msm8939-bimc", .data = &msm8939_bimc },
> +	{ .compatible = "qcom,msm8939-pcnoc", .data = &msm8939_pcnoc },
> +	{ .compatible = "qcom,msm8939-snoc", .data = &msm8939_snoc },
> +	{ .compatible = "qcom,msm8939-snoc-mm", .data = &msm8939_snoc_mm },
> +	{ }
> +};
> +MODULE_DEVICE_TABLE(of, msm8939_noc_of_match);
> +
> +static struct platform_driver msm8939_noc_driver = {
> +	.probe = msm8939_qnoc_probe,
> +	.remove = qnoc_remove,
> +	.driver = {
> +		.name = "qnoc-msm8939",
> +		.of_match_table = msm8939_noc_of_match,

The sync_state patches got merged, so please add this:
		.sync_state = icc_sync_state,

Thanks,
Georgi

> +	},
> +};
> +module_platform_driver(msm8939_noc_driver);
> +MODULE_AUTHOR("Jun Nie <jun.nie@linaro.org>");
> +MODULE_DESCRIPTION("Qualcomm MSM8939 NoC driver");
> +MODULE_LICENSE("GPL v2");
> 
