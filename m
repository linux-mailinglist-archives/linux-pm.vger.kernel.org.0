Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 106AA172117
	for <lists+linux-pm@lfdr.de>; Thu, 27 Feb 2020 15:47:29 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730586AbgB0OrA (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Thu, 27 Feb 2020 09:47:00 -0500
Received: from mail-wr1-f68.google.com ([209.85.221.68]:43517 "EHLO
        mail-wr1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730279AbgB0Noy (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Thu, 27 Feb 2020 08:44:54 -0500
Received: by mail-wr1-f68.google.com with SMTP id c13so3376327wrq.10
        for <linux-pm@vger.kernel.org>; Thu, 27 Feb 2020 05:44:52 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=subject:to:cc:references:from:openpgp:autocrypt:message-id:date
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=bRBVzm7LmsESKTnCqWwBanH8FICpCOc4WhuYig3TGrY=;
        b=oxD1yVksx5FhGgGokg268at9nOg2OPkGr/R7GsuVaEgPOdQOBg5Etzvs9PSLYtqM2l
         CZGF67SEWhZEDL7J8ahBDe6xf0Zz0fToAxU3DijpB69N6Io50emD9vKcB+fCigK8okDs
         5qskwoAVQc+fiFX2LjtN7K71G4d/XoMCgviAF0NPTP5xZHlQVgmtuoacXZaMNkfWEXru
         P3UOaMNT16J1yp6A3qPMXK5a3oWuRxLqSOsROTD62C3YKhQXHcUOv8BHZ2mDpWfrtFVX
         HOzA3R7dcvNaaj+30Odd5gc4Xm+lPqMDwh9TXMJADs76USaKS5N8gcDh/KySSwfsynVU
         EeYQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:openpgp:autocrypt
         :message-id:date:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=bRBVzm7LmsESKTnCqWwBanH8FICpCOc4WhuYig3TGrY=;
        b=Jf8+oa4CRFazWulhPeDc/pO5R3cB+q774BqypjAwapbgUwJo3HV3u22VuL7+pRic2y
         CE3Njm52ENNvmJce8Gi/pX2ofGLlktoCTm3R6hVIDW77NJLHM+K7ewhdEcMzaw5wajEY
         3sE49mripqi/8Yxb2J+SkJrrqg5cL7aG2Vt1IFYbDHcd3GigHokc3lfKRA8oOz9IfZf5
         wEcU/PXwiOUhZdqwqPZ0pTmy63q/8yMUxb/VhiatkrwXcq8KybfrCNoUV2osFK37dp7k
         C4rO91fQBvcnwTrEXzMLO2QhryD6P+9JVmaZJ2x6oGzEOPGx0yaMf9PkSi++mrrcMgCD
         0AUQ==
X-Gm-Message-State: APjAAAU6Z2mQ1tIlnwm4wqDybyJGxgxaxK6Wc6r4OhBzWCUVv7vxLuAz
        uOggy2A5b9spYFnjiIqYdu3+4w==
X-Google-Smtp-Source: APXvYqxr0HRJGL3LzxWA8tAPZNioP7XMTNL6XoAFSAUC/2LCPDBe4z5XcS2wQOU0GLia2herDKWI8w==
X-Received: by 2002:adf:e38d:: with SMTP id e13mr4787598wrm.133.1582811091737;
        Thu, 27 Feb 2020 05:44:51 -0800 (PST)
Received: from [10.44.66.8] ([212.45.67.2])
        by smtp.googlemail.com with ESMTPSA id c74sm8187080wmd.26.2020.02.27.05.44.50
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 27 Feb 2020 05:44:50 -0800 (PST)
Subject: Re: [PATCH v3 4/6] interconnect: qcom: Consolidate interconnect RPMh
 support
To:     Sibi Sankar <sibis@codeaurora.org>, robh+dt@kernel.org,
        evgreen@chromium.org
Cc:     bjorn.andersson@linaro.org, agross@kernel.org,
        linux-kernel@vger.kernel.org, devicetree@vger.kernel.org,
        linux-arm-msm@vger.kernel.org, mark.rutland@arm.com,
        daidavid1@codeaurora.org, saravanak@google.com, mka@chromium.org,
        linux-pm@vger.kernel.org, Odelu Kukatla <okukatla@codeaurora.org>
References: <20200209183411.17195-1-sibis@codeaurora.org>
 <20200209183411.17195-5-sibis@codeaurora.org>
From:   Georgi Djakov <georgi.djakov@linaro.org>
Openpgp: preference=signencrypt
Autocrypt: addr=georgi.djakov@linaro.org; prefer-encrypt=mutual; keydata=
 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
 KEmKjLDvB0pePJkdTw==
Message-ID: <921917e6-45d3-f9c5-6519-5f3b8116d9ec@linaro.org>
Date:   Thu, 27 Feb 2020 15:44:48 +0200
MIME-Version: 1.0
In-Reply-To: <20200209183411.17195-5-sibis@codeaurora.org>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

Hi Sibi,

Thank you for refreshing this patchset!

On 2/9/20 20:34, Sibi Sankar wrote:
> From: David Dai <daidavid1@codeaurora.org>
> 
> Add bcm voter driver and add support for RPMh specific interconnect
> providers which implements the set and aggregate functionalities that
> translates bandwidth requests into RPMh messages. These modules provide
> a common set of functionalities for all Qualcomm RPMh based interconnect
> providers and should help reduce code duplication when adding new
> providers.
> 
> Signed-off-by: David Dai <daidavid1@codeaurora.org>
> Signed-off-by: Odelu Kukatla <okukatla@codeaurora.org>
> Signed-off-by: Sibi Sankar <sibis@codeaurora.org>
> ---
>  drivers/interconnect/qcom/Kconfig     |  13 +-
>  drivers/interconnect/qcom/Makefile    |   4 +
>  drivers/interconnect/qcom/bcm-voter.c | 366 ++++++++++++++++++++++++++
>  drivers/interconnect/qcom/bcm-voter.h |  27 ++
>  drivers/interconnect/qcom/icc-rpmh.c  | 147 +++++++++++
>  drivers/interconnect/qcom/icc-rpmh.h  | 149 +++++++++++
>  6 files changed, 705 insertions(+), 1 deletion(-)
>  create mode 100644 drivers/interconnect/qcom/bcm-voter.c
>  create mode 100644 drivers/interconnect/qcom/bcm-voter.h
>  create mode 100644 drivers/interconnect/qcom/icc-rpmh.c
>  create mode 100644 drivers/interconnect/qcom/icc-rpmh.h
> 
> diff --git a/drivers/interconnect/qcom/Kconfig b/drivers/interconnect/qcom/Kconfig
> index 76938ece1658e..08cfd676b4299 100644
> --- a/drivers/interconnect/qcom/Kconfig
> +++ b/drivers/interconnect/qcom/Kconfig
> @@ -5,6 +5,11 @@ config INTERCONNECT_QCOM
>  	help
>  	  Support for Qualcomm's Network-on-Chip interconnect hardware.
>  
> +config INTERCONNECT_QCOM_BCM_VOTER
> +	tristate
> +	depends on INTERCONNECT_QCOM || COMPILE_TEST
> +	depends on QCOM_RPMH && OF

This is not user-selectable, but has a "depends on" lines...

> +
>  config INTERCONNECT_QCOM_MSM8916
>  	tristate "Qualcomm MSM8916 interconnect driver"
>  	depends on INTERCONNECT_QCOM
> @@ -32,10 +37,16 @@ config INTERCONNECT_QCOM_QCS404
>  	  This is a driver for the Qualcomm Network-on-Chip on qcs404-based
>  	  platforms.
>  
> +config INTERCONNECT_QCOM_RPMH
> +	tristate
> +	depends on INTERCONNECT_QCOM || COMPILE_TEST
> +	depends on QCOM_COMMAND_DB
> +
>  config INTERCONNECT_QCOM_SDM845
>  	tristate "Qualcomm SDM845 interconnect driver"
>  	depends on INTERCONNECT_QCOM
> -	depends on (QCOM_RPMH && QCOM_COMMAND_DB && OF) || COMPILE_TEST
> +	select INTERCONNECT_QCOM_RPMH
> +	select INTERCONNECT_QCOM_BCM_VOTER

...and these selects will force a symbol to a value without checking its
dependencies. So i was wondering whether this will cause any problems.

>  	help
>  	  This is a driver for the Qualcomm Network-on-Chip on sdm845-based
>  	  platforms.
> diff --git a/drivers/interconnect/qcom/Makefile b/drivers/interconnect/qcom/Makefile
> index e8271575e3d8a..d591bb56273b1 100644
[..]
> +static const struct of_device_id bcm_voter_of_match[] = {
> +	{ .compatible = "qcom,bcm-voter" },
> +	{ }
> +};
> +
> +static struct platform_driver qcom_icc_bcm_voter_driver = {
> +	.probe = qcom_icc_bcm_voter_probe,
> +	.driver = {
> +		.name		= "sdm845_bcm_voter",

Nit: This is not just about sdm845 anymore, so maybe qcom_bcm_voter.

> +		.of_match_table = bcm_voter_of_match,
> +	},
> +};
> +module_platform_driver(qcom_icc_bcm_voter_driver);
> +
> +MODULE_AUTHOR("David Dai <daidavid1@codeaurora.org>");
> +MODULE_DESCRIPTION("Qualcomm BCM Voter interconnect driver");
> +MODULE_LICENSE("GPL v2");
> diff --git a/drivers/interconnect/qcom/bcm-voter.h b/drivers/interconnect/qcom/bcm-voter.h
> new file mode 100644
> index 0000000000000..3436673e9f104
> --- /dev/null
[.]
> diff --git a/drivers/interconnect/qcom/icc-rpmh.c b/drivers/interconnect/qcom/icc-rpmh.c
> new file mode 100644
> index 0000000000000..e9443b50e0b48
> --- /dev/null
> +++ b/drivers/interconnect/qcom/icc-rpmh.c
> @@ -0,0 +1,147 @@
> +// SPDX-License-Identifier: GPL-2.0
> +/*
> + * Copyright (c) 2020, The Linux Foundation. All rights reserved.
> + */
> +
> +#include <linux/interconnect.h>
> +#include <linux/interconnect-provider.h>
> +
> +#include "bcm-voter.h"
> +#include "icc-rpmh.h"
> +
> +/**
> + * qcom_icc_pre_aggregate - cleans up stale values from prior icc_set
> + * @node: icc node to operate on
> + */
> +void qcom_icc_pre_aggregate(struct icc_node *node)
> +{
> +	size_t i;
> +	struct qcom_icc_node *qn;
> +
> +	qn = node->data;
> +
> +	for (i = 0; i < QCOM_ICC_NUM_BUCKETS; i++) {
> +		qn->sum_avg[i] = 0;
> +		qn->max_peak[i] = 0;
> +	}
> +}
> +EXPORT_SYMBOL_GPL(qcom_icc_pre_aggregate);
> +
> +/**
> + * qcom_icc_aggregate - aggregate bw for buckets indicated by tag
> + * @node: node to aggregate
> + * @tag: tag to indicate which buckets to aggregate
> + * @avg_bw: new bw to sum aggregate
> + * @peak_bw: new bw to max aggregate
> + * @agg_avg: existing aggregate avg bw val
> + * @agg_peak: existing aggregate peak bw val
> + */
> +int qcom_icc_aggregate(struct icc_node *node, u32 tag, u32 avg_bw,
> +		       u32 peak_bw, u32 *agg_avg, u32 *agg_peak)
> +{
> +	size_t i;
> +	struct qcom_icc_node *qn;
> +	struct qcom_icc_provider *qp;
> +
> +	qn = node->data;
> +	qp = to_qcom_provider(node->provider);
> +
> +	if (!tag)
> +		tag = QCOM_ICC_TAG_ALWAYS;
> +
> +	for (i = 0; i < QCOM_ICC_NUM_BUCKETS; i++) {
> +		if (tag & BIT(i)) {
> +			qn->sum_avg[i] += avg_bw;
> +			qn->max_peak[i] = max_t(u32, qn->max_peak[i], peak_bw);
> +		}
> +	}
> +
> +	*agg_avg += avg_bw;
> +	*agg_peak = max_t(u32, *agg_peak, peak_bw);
> +
> +	for (i = 0; i < qn->num_bcms; i++)
> +		qcom_icc_bcm_voter_add(qp->voter, qn->bcms[i]);
> +
> +	return 0;
> +}
> +EXPORT_SYMBOL_GPL(qcom_icc_aggregate);
> +
> +/**
> + * qcom_icc_set - set the constraints based on path
> + * @src: source node for the path to set constraints on
> + * @dst: destination node for the path to set constraints on
> + *
> + * Return: 0 on success, or an error code otherwise
> + */
> +int qcom_icc_set(struct icc_node *src, struct icc_node *dst)
> +{
> +	struct qcom_icc_provider *qp;
> +	struct icc_node *node;
> +
> +	if (!src)
> +		node = dst;
> +	else
> +		node = src;
> +
> +	qp = to_qcom_provider(node->provider);
> +
> +	qcom_icc_bcm_voter_commit(qp->voter);
> +
> +	return 0;
> +}
> +EXPORT_SYMBOL_GPL(qcom_icc_set);
> +
> +/**
> + * qcom_icc_bcm_init - populates bcm aux data and connect qnodes
> + * @bcm: bcm to be initialized
> + * @dev: associated provider device
> + *
> + * Return: 0 on success, or an error code otherwise
> + */
> +int qcom_icc_bcm_init(struct qcom_icc_bcm *bcm, struct device *dev)
> +{
> +	struct qcom_icc_node *qn;
> +	const struct bcm_db *data;
> +	size_t data_count;
> +	int i;
> +
> +	/* BCM is already initialised*/
> +	if (bcm->addr)
> +		return 0;
> +
> +	bcm->addr = cmd_db_read_addr(bcm->name);
> +	if (!bcm->addr) {
> +		dev_err(dev, "%s could not find RPMh address\n",
> +			bcm->name);
> +		return -EINVAL;
> +	}
> +
> +	data = cmd_db_read_aux_data(bcm->name, &data_count);
> +	if (IS_ERR(data)) {
> +		dev_err(dev, "%s command db read error (%ld)\n",
> +			bcm->name, PTR_ERR(data));
> +		return PTR_ERR(data);
> +	}
> +	if (!data_count) {
> +		dev_err(dev, "%s command db missing or partial aux data\n",
> +			bcm->name);
> +		return -EINVAL;
> +	}
> +
> +	bcm->aux_data.unit = le32_to_cpu(data->unit);
> +	bcm->aux_data.width = le16_to_cpu(data->width);
> +	bcm->aux_data.vcd = data->vcd;
> +	bcm->aux_data.reserved = data->reserved;
> +	INIT_LIST_HEAD(&bcm->list);
> +	INIT_LIST_HEAD(&bcm->ws_list);
> +
> +	/* Link Qnodes to their respective BCMs */
> +	for (i = 0; i < bcm->num_nodes; i++) {
> +		qn = bcm->nodes[i];
> +		qn->bcms[qn->num_bcms] = bcm;
> +		qn->num_bcms++;
> +	}
> +
> +	return 0;
> +}
> +EXPORT_SYMBOL_GPL(qcom_icc_bcm_init);

When i tried building this as a module i see the following warning:
WARNING: modpost: missing MODULE_LICENSE() in drivers/interconnect/qcom/icc-rpmh.o

So we may want to include module.h and add MODULE_LICENSE("GPL v2") as specified
in the SPDX tag.

Thanks,
Georgi
