Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id BBC3A418EA
	for <lists+linux-pm@lfdr.de>; Wed, 12 Jun 2019 01:32:01 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2408131AbfFKXbr (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Tue, 11 Jun 2019 19:31:47 -0400
Received: from mail-pl1-f195.google.com ([209.85.214.195]:38483 "EHLO
        mail-pl1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2408127AbfFKXbq (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Tue, 11 Jun 2019 19:31:46 -0400
Received: by mail-pl1-f195.google.com with SMTP id f97so5779902plb.5
        for <linux-pm@vger.kernel.org>; Tue, 11 Jun 2019 16:31:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=SUELTqCdgnhfMtEJT+K2hfmIvdShqQEL+xOz99fPPDE=;
        b=INK9zkqh2DwgI4vqxDBJXwMJBWi9O+96pPOBJpoT3L70MTdqRof9e2UMiWE9uCdz/j
         nKnSoEic9XxdOV2nOngg8FNXNkDGrPc2m1MTlHBUQK69n39hML6TlO6SeOYMYGplhY8M
         XphKmU1obW8GQ1iyRCZltA+FYBokybQKEoo2Et0fDBpEIwVx8Jib3BGVTHoKsGFytGRS
         JuZ//MrpGDt+1FKEO+DXwkz4n+woLPCyt/hP+MWUsQ6aAHgD3GdGvujq/E8zov2jQ0Tn
         kcoT5kHnAO94gPJW5k48xDwRHfPZamcssssscQmzU44jQ0Nf+WKZuM2j+j0w139m9M09
         6/Cw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=SUELTqCdgnhfMtEJT+K2hfmIvdShqQEL+xOz99fPPDE=;
        b=kIcIbny6qiYbl61aSfD+P3g5G+u4KF/RvInnBjUQgJE8RFlSWyEG9NbfpLd9odgJf/
         2rPv4Sn3FQsjVlmj7B6fqW8UVUIhXkgz3+dggjBNYoAW6bb74GBezdVwzk7TXl9uavBg
         +sMUI7/aSIHjv9VBHJLEOSKMA1Nny3MGEl06U8osQjkktZaxQFtrxGHLuYMbQcBnCdBz
         PUGoixw0fcdjUfDM8Q/v8M0ndsoW9IP1iu0S5VQ4wMhZ96UfOAX+5kt8wS+KqgIFrQZc
         eAKFdh2FRK7FoavdY000AXAxGj0vz0iU6DBSS1AzedA2QSZXMSOXXNbigtE4xOMfgvF0
         DJTw==
X-Gm-Message-State: APjAAAUns/KjtOCnvaFj6aaPV7j2ns8xznRl5AxNAIcHcSH1eDsnuwoe
        3B1UpFeb+dm1JB2SoEP5D7fBng==
X-Google-Smtp-Source: APXvYqxZgA9JS1Ip7R5t6SWHrg5cFNSwDT2IMkTf4B+g4pxrpj03oMvdWpUBchCvS9aQwOWH5QFJQg==
X-Received: by 2002:a17:902:2006:: with SMTP id n6mr21060815pla.232.1560295906004;
        Tue, 11 Jun 2019 16:31:46 -0700 (PDT)
Received: from minitux (104-188-17-28.lightspeed.sndgca.sbcglobal.net. [104.188.17.28])
        by smtp.gmail.com with ESMTPSA id p7sm14242407pfp.131.2019.06.11.16.31.44
        (version=TLS1_3 cipher=AEAD-AES256-GCM-SHA384 bits=256/256);
        Tue, 11 Jun 2019 16:31:45 -0700 (PDT)
Date:   Tue, 11 Jun 2019 16:31:43 -0700
From:   Bjorn Andersson <bjorn.andersson@linaro.org>
To:     Georgi Djakov <georgi.djakov@linaro.org>
Cc:     robh+dt@kernel.org, agross@kernel.org, vkoul@kernel.org,
        evgreen@chromium.org, daidavid1@codeaurora.org,
        linux-pm@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-arm-msm@vger.kernel.org
Subject: Re: [PATCH v3 4/5] interconnect: qcom: Add interconnect SMD over SMD
 driver
Message-ID: <20190611233143.GV4814@minitux>
References: <20190611164157.24656-1-georgi.djakov@linaro.org>
 <20190611164157.24656-5-georgi.djakov@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190611164157.24656-5-georgi.djakov@linaro.org>
User-Agent: Mutt/1.12.0 (2019-05-25)
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

On Tue 11 Jun 09:41 PDT 2019, Georgi Djakov wrote:

> On some Qualcomm SoCs, there is a remote processor, which controls some of
> the Network-On-Chip interconnect resources. Other CPUs express their needs
> by communicating with this processor. Add a driver to handle communication
> with this remote processor.
> 
> Signed-off-by: Georgi Djakov <georgi.djakov@linaro.org>
> ---
> 
> v3:
> - New patch.
> 
>  drivers/interconnect/qcom/Kconfig   |  9 ++++
>  drivers/interconnect/qcom/Makefile  |  2 +
>  drivers/interconnect/qcom/smd-rpm.c | 72 +++++++++++++++++++++++++++++
>  drivers/interconnect/qcom/smd-rpm.h | 15 ++++++
>  4 files changed, 98 insertions(+)
>  create mode 100644 drivers/interconnect/qcom/smd-rpm.c
>  create mode 100644 drivers/interconnect/qcom/smd-rpm.h
> 
> diff --git a/drivers/interconnect/qcom/Kconfig b/drivers/interconnect/qcom/Kconfig
> index e76e3e248c41..b0eade1da5d5 100644
> --- a/drivers/interconnect/qcom/Kconfig
> +++ b/drivers/interconnect/qcom/Kconfig
> @@ -9,6 +9,7 @@ config INTERCONNECT_QCOM_QCS404
>  	tristate "Qualcomm QCS404 interconnect driver"
>  	depends on INTERCONNECT_QCOM
>  	depends on QCOM_SMD_RPM || COMPILE_TEST
> +	select INTERCONNECT_QCOM_SMD_RPM
>  	help
>  	  This is a driver for the Qualcomm Network-on-Chip on qcs404-based
>  	  platforms.
> @@ -20,3 +21,11 @@ config INTERCONNECT_QCOM_SDM845
>  	help
>  	  This is a driver for the Qualcomm Network-on-Chip on sdm845-based
>  	  platforms.
> +
> +config INTERCONNECT_QCOM_SMD_RPM
> +	tristate "Qualcomm SMD RPM interconnect driver"

I think it's correct to have INTERCONNECT_QCOM_QCS404 select
INTERCONNECT_QCOM_SMD_RPM and then but INTERCONNECT_QCOM_SMD_RPM should
not be user selectable. So leave the tristate but drop the description
and the help text.

> +	depends on INTERCONNECT_QCOM
> +	depends on QCOM_SMD_RPM || COMPILE_TEST
> +	help
> +	  This is a driver for communicating interconnect related configuration
> +	  details with a remote processor (RPM) on Qualcomm platforms.
> diff --git a/drivers/interconnect/qcom/Makefile b/drivers/interconnect/qcom/Makefile
> index 059ff325ee6c..67dafb783dec 100644
> --- a/drivers/interconnect/qcom/Makefile
> +++ b/drivers/interconnect/qcom/Makefile
> @@ -2,6 +2,8 @@
>  
>  qnoc-qcs404-objs			:= qcs404.o
>  qnoc-sdm845-objs			:= sdm845.o
> +icc-smd-rpm-objs			:= smd-rpm.o
>  
>  obj-$(CONFIG_INTERCONNECT_QCOM_QCS404) += qnoc-qcs404.o
>  obj-$(CONFIG_INTERCONNECT_QCOM_SDM845) += qnoc-sdm845.o
> +obj-$(CONFIG_INTERCONNECT_QCOM_SMD_RPM) += icc-smd-rpm.o
> diff --git a/drivers/interconnect/qcom/smd-rpm.c b/drivers/interconnect/qcom/smd-rpm.c
> new file mode 100644
> index 000000000000..af22c0a293e6
> --- /dev/null
> +++ b/drivers/interconnect/qcom/smd-rpm.c
> @@ -0,0 +1,72 @@
> +// SPDX-License-Identifier: GPL-2.0
> +/*
> + * RPM over SMD communication wrapper for interconnects
> + *
> + * Copyright (C) 2019 Linaro Ltd
> + * Author: Georgi Djakov <georgi.djakov@linaro.org>
> + */
> +
> +#include <linux/interconnect-provider.h>
> +#include <linux/module.h>
> +#include <linux/of.h>
> +#include <linux/of_platform.h>
> +#include <linux/platform_device.h>
> +#include <linux/soc/qcom/smd-rpm.h>
> +
> +#include "smd-rpm.h"
> +
> +#define RPM_KEY_BW		0x00007762
> +
> +static struct qcom_smd_rpm *icc_smd_rpm;
> +
> +struct icc_rpm_smd_req {
> +	__le32 key;
> +	__le32 nbytes;
> +	__le32 value;
> +};
> +
> +bool qcom_icc_rpm_smd_available(void)
> +{
> +	if (!icc_smd_rpm)
> +		return false;
> +
> +	return true;
> +}
> +EXPORT_SYMBOL_GPL(qcom_icc_rpm_smd_available);
> +
> +int qcom_icc_rpm_smd_send(int ctx, int rsc_type, int id, u32 val)
> +{
> +	struct icc_rpm_smd_req req = {
> +		.key = cpu_to_le32(RPM_KEY_BW),
> +		.nbytes = cpu_to_le32(sizeof(u32)),
> +		.value = cpu_to_le32(val),
> +	};
> +
> +	return qcom_rpm_smd_write(icc_smd_rpm, ctx, rsc_type, id, &req,
> +				  sizeof(req));
> +}
> +EXPORT_SYMBOL_GPL(qcom_icc_rpm_smd_send);
> +
> +static int qcom_icc_rpm_smd_probe(struct platform_device *pdev)
> +{
> +	icc_smd_rpm = dev_get_drvdata(pdev->dev.parent);
> +
> +	if (!icc_smd_rpm) {
> +		dev_err(&pdev->dev, "unable to retrieve handle to RPM\n");
> +		return -ENODEV;
> +	}
> +
> +	return 0;
> +}

It would probably be nice to have a remove function that zeros out
icc_smd_rpm as well.

Regards,
Bjorn

> +
> +static struct platform_driver qcom_interconnect_rpm_smd_driver = {
> +	.driver = {
> +		.name		= "icc_smd_rpm",
> +	},
> +	.probe = qcom_icc_rpm_smd_probe,
> +};
> +module_platform_driver(qcom_interconnect_rpm_smd_driver);
> +MODULE_AUTHOR("Georgi Djakov <georgi.djakov@linaro.org>");
> +MODULE_DESCRIPTION("Qualcomm SMD RPM interconnect proxy driver");
> +MODULE_LICENSE("GPL v2");
> +MODULE_ALIAS("platform:icc_smd_rpm");
> diff --git a/drivers/interconnect/qcom/smd-rpm.h b/drivers/interconnect/qcom/smd-rpm.h
> new file mode 100644
> index 000000000000..ca9d0327b8ac
> --- /dev/null
> +++ b/drivers/interconnect/qcom/smd-rpm.h
> @@ -0,0 +1,15 @@
> +/* SPDX-License-Identifier: GPL-2.0 */
> +/*
> + * Copyright (c) 2019, Linaro Ltd.
> + * Author: Georgi Djakov <georgi.djakov@linaro.org>
> + */
> +
> +#ifndef __DRIVERS_INTERCONNECT_QCOM_SMD_RPM_H
> +#define __DRIVERS_INTERCONNECT_QCOM_SMD_RPM_H
> +
> +#include <linux/soc/qcom/smd-rpm.h>
> +
> +bool qcom_icc_rpm_smd_available(void);
> +int qcom_icc_rpm_smd_send(int ctx, int rsc_type, int id, u32 val);
> +
> +#endif
