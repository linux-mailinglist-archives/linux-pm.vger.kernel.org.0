Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9AD5D295F46
	for <lists+linux-pm@lfdr.de>; Thu, 22 Oct 2020 15:04:17 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2506913AbgJVNEQ (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Thu, 22 Oct 2020 09:04:16 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48326 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2505589AbgJVNEP (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Thu, 22 Oct 2020 09:04:15 -0400
Received: from mail-wm1-x343.google.com (mail-wm1-x343.google.com [IPv6:2a00:1450:4864:20::343])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8506DC0613D4
        for <linux-pm@vger.kernel.org>; Thu, 22 Oct 2020 06:04:15 -0700 (PDT)
Received: by mail-wm1-x343.google.com with SMTP id c77so1985194wmd.4
        for <linux-pm@vger.kernel.org>; Thu, 22 Oct 2020 06:04:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=subject:to:cc:references:from:autocrypt:message-id:date
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=WNzAQXz3amhO6wa3kYX2lVV5iioJ9/t/YoS1l34UuYM=;
        b=E5LppAZuapWnhx+KMQ3Q7N1KBxUdGcLdDkSDoW1gdkQ0Zit6yfggBP8eBJz/kAL19J
         eC1W0lqhBzhkLachecwM5yoEfDrs9cTuKWkMedaCE5YmJTyuAEen9P80HVa8egfU0WxE
         ebcozzTUCxr3LzIm7ZJx7c+I7oZGuqviSyKgwMd5Q0bIU4xriY0tLhZVymXvwpKy44zU
         PHk0/o6HSETktDeC5aOG96k7gHivBWtf9aC8XqaPZlkt5rsEc/2eilADNGCKKv5l0Yx1
         25/Yj7zPEkzLE6k9Hd9YhfmbSg+8cgEzsZh+pColedvceqPQMjntvkiiRptb69QhXl+D
         pc6w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:autocrypt
         :message-id:date:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=WNzAQXz3amhO6wa3kYX2lVV5iioJ9/t/YoS1l34UuYM=;
        b=JOuvjZbXnFDV1OR5eU4gAmZdr2VrB6LSdHxEkiFy/XOpjQfSWC6wIvXuZDlsG658Ba
         46czvE5StIB/hgkqYszDgbwhlmyQMYpIDolpGERKAYGCd1rG1kQsFXTpA2HNn46kmsow
         cREVxv+8FR9LIwbag5sglX/DMFnXP0WTFyrnJ5K278ievkgv++KJF32aJHbN9BYAW9jw
         YWvJnJXJN/I4QwOxXxXkMhUlFP3htghpTBz1uCI3vC+rC1USCO/mC0OeHQR2D55K/9zx
         HZc2LenTgA/bipcn8egIKG1DgUsQgRWi8p9W7GA8s15FPpFQBVamtYbsz69z1KmRxANo
         BoiQ==
X-Gm-Message-State: AOAM5318ewcXNJSkAJysc2IIajHcpVMoGJe5D4fxExDvDfGIQo6hcSGW
        RAaAsflr8vfy1S9tk2rv9MBj/w==
X-Google-Smtp-Source: ABdhPJxmtsbaY0Tp76qOfehkHi7IkVA7DgRzfPcU2R413JLWNJnUUqVb73cG2m5ZdFnHDQahgZTbuQ==
X-Received: by 2002:a1c:5545:: with SMTP id j66mr2560129wmb.31.1603371852368;
        Thu, 22 Oct 2020 06:04:12 -0700 (PDT)
Received: from [10.44.66.8] ([212.45.67.2])
        by smtp.googlemail.com with ESMTPSA id l1sm4033136wrb.1.2020.10.22.06.04.11
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 22 Oct 2020 06:04:11 -0700 (PDT)
Subject: Re: [PATCH 1/5] interconnect: qcom: Consolidate interconnect RPM
 support
To:     Jun Nie <jun.nie@linaro.org>
Cc:     devicetree@vger.kernel.org, bjorn.andersson@linaro.org,
        agross@kernel.org, linux-pm@vger.kernel.org,
        linux-arm-msm@vger.kernel.org, linux-kernel@vger.kernel.org,
        robh@kernel.org, shawn.guo@linaro.org
References: <20200930081645.3434-1-jun.nie@linaro.org>
 <20200930081645.3434-2-jun.nie@linaro.org>
From:   Georgi Djakov <georgi.djakov@linaro.org>
Autocrypt: addr=georgi.djakov@linaro.org; prefer-encrypt=mutual; keydata=
 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
 KEmKjLDvB0pePJkdTw==
Message-ID: <8b9f06ae-f711-2e71-1e36-1f8519b52e8d@linaro.org>
Date:   Thu, 22 Oct 2020 16:04:09 +0300
MIME-Version: 1.0
In-Reply-To: <20200930081645.3434-2-jun.nie@linaro.org>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

Hi Jun,

Thanks for working on this.

On 9/30/20 11:16, Jun Nie wrote:
> Add RPM based interconnect driver implements the set and aggregate
> functionalities that translates bandwidth requests into RPM messages.
> These modules provide a common set of functionalities for all
> Qualcomm RPM based interconnect providers and should help reduce code
> duplication when adding new providers.
> 
> Signed-off-by: Jun Nie <jun.nie@linaro.org>
> ---
>  drivers/interconnect/qcom/Makefile  |   3 +-
>  drivers/interconnect/qcom/icc-rpm.c | 194 ++++++++++++++++++++++
>  drivers/interconnect/qcom/icc-rpm.h |  73 +++++++++
>  drivers/interconnect/qcom/msm8916.c | 241 ++--------------------------
>  4 files changed, 279 insertions(+), 232 deletions(-)
>  create mode 100644 drivers/interconnect/qcom/icc-rpm.c
>  create mode 100644 drivers/interconnect/qcom/icc-rpm.h
> 
> diff --git a/drivers/interconnect/qcom/Makefile b/drivers/interconnect/qcom/Makefile
> index 1702ece67dc5..f5e803489de0 100644
> --- a/drivers/interconnect/qcom/Makefile
> +++ b/drivers/interconnect/qcom/Makefile
> @@ -9,7 +9,7 @@ icc-rpmh-obj				:= icc-rpmh.o
>  qnoc-sc7180-objs			:= sc7180.o
>  qnoc-sdm845-objs			:= sdm845.o
>  qnoc-sm8150-objs			:= sm8150.o
> -icc-smd-rpm-objs			:= smd-rpm.o
> +icc-smd-rpm-objs			:= smd-rpm.o icc-rpm.o
>  
>  obj-$(CONFIG_INTERCONNECT_QCOM_BCM_VOTER) += icc-bcm-voter.o
>  obj-$(CONFIG_INTERCONNECT_QCOM_MSM8916) += qnoc-msm8916.o
> @@ -21,3 +21,4 @@ obj-$(CONFIG_INTERCONNECT_QCOM_SC7180) += qnoc-sc7180.o
>  obj-$(CONFIG_INTERCONNECT_QCOM_SDM845) += qnoc-sdm845.o
>  obj-$(CONFIG_INTERCONNECT_QCOM_SM8150) += qnoc-sm8150.o
>  obj-$(CONFIG_INTERCONNECT_QCOM_SMD_RPM) += icc-smd-rpm.o
> +obj-$(CONFIG_INTERCONNECT_QCOM_SMD_RPM) += icc-smd-rpm.o

Duplicate line.

> diff --git a/drivers/interconnect/qcom/icc-rpm.c b/drivers/interconnect/qcom/icc-rpm.c
> new file mode 100644
> index 000000000000..4ddcb6cd4b84
> --- /dev/null
> +++ b/drivers/interconnect/qcom/icc-rpm.c
[..]
> +int qnoc_probe(struct platform_device *pdev, size_t cd_size, int cd_num,
> +	       const struct clk_bulk_data *cd)
> +{
> +	struct device *dev = &pdev->dev;
> +	const struct qcom_icc_desc *desc;
> +	struct icc_onecell_data *data;
> +	struct icc_provider *provider;
> +	struct qcom_icc_node **qnodes;
> +	struct qcom_icc_provider *qp;
> +	struct icc_node *node;
> +	size_t num_nodes, i;
> +	int ret;
> +
> +	/* wait for the RPM proxy */
> +	if (!qcom_icc_rpm_smd_available())
> +		return -EPROBE_DEFER;
> +
> +	desc = of_device_get_match_data(dev);
> +	if (!desc)
> +		return -EINVAL;
> +
> +	qnodes = desc->nodes;
> +	num_nodes = desc->num_nodes;
> +
> +	qp = devm_kzalloc(dev, sizeof(*qp), GFP_KERNEL);
> +	if (!qp)
> +		return -ENOMEM;
> +
> +	data = devm_kzalloc(dev, struct_size(data, nodes, num_nodes),
> +			    GFP_KERNEL);
> +	if (!data)
> +		return -ENOMEM;
> +
> +	qp->bus_clks = devm_kmemdup(dev, cd, cd_size,
> +				    GFP_KERNEL);
> +	if (!qp->bus_clks)
> +		return -ENOMEM;
> +
> +	qp->num_clks = cd_num;
> +	ret = devm_clk_bulk_get(dev, qp->num_clks, qp->bus_clks);
> +	if (ret)
> +		return ret;
> +
> +	ret = clk_bulk_prepare_enable(qp->num_clks, qp->bus_clks);
> +	if (ret)
> +		return ret;
> +
> +	provider = &qp->provider;
> +	INIT_LIST_HEAD(&provider->nodes);
> +	provider->dev = dev;
> +	provider->set = qcom_icc_set;
> +	provider->aggregate = icc_std_aggregate;
> +	provider->xlate = of_icc_xlate_onecell;
> +	provider->data = data;
> +
> +	ret = icc_provider_add(provider);
> +	if (ret) {
> +		dev_err(dev, "error adding interconnect provider: %d\n", ret);
> +		clk_bulk_disable_unprepare(qp->num_clks, qp->bus_clks);
> +		return ret;
> +	}
> +
> +	for (i = 0; i < num_nodes; i++) {
> +		size_t j;
> +
> +		node = icc_node_create(qnodes[i]->id);
> +		if (IS_ERR(node)) {
> +			ret = PTR_ERR(node);
> +			goto err;
> +		}
> +
> +		node->name = qnodes[i]->name;
> +		node->data = qnodes[i];
> +		icc_node_add(node, provider);
> +
> +		dev_dbg(dev, "registered node %s\n", node->name);

Please drop this line.

> +
> +		/* populate links */

Please drop this comment.

> +		for (j = 0; j < qnodes[i]->num_links; j++)
> +			icc_link_create(node, qnodes[i]->links[j]);
> +
> +		data->nodes[i] = node;
> +	}
> +	data->num_nodes = num_nodes;
> +
> +	platform_set_drvdata(pdev, qp);
> +
> +	return 0;
> +err:
> +	icc_nodes_remove(provider);
> +	clk_bulk_disable_unprepare(qp->num_clks, qp->bus_clks);
> +	icc_provider_del(provider);
> +
> +	return ret;
> +}
> +EXPORT_SYMBOL(qnoc_probe);
> +
> +int qnoc_remove(struct platform_device *pdev)
> +{
> +	struct qcom_icc_provider *qp = platform_get_drvdata(pdev);
> +
> +	icc_nodes_remove(&qp->provider);
> +	clk_bulk_disable_unprepare(qp->num_clks, qp->bus_clks);
> +	return icc_provider_del(&qp->provider);
> +}
> +EXPORT_SYMBOL(qnoc_remove);
> diff --git a/drivers/interconnect/qcom/icc-rpm.h b/drivers/interconnect/qcom/icc-rpm.h
> new file mode 100644
> index 000000000000..b75bb59d79b7
> --- /dev/null
> +++ b/drivers/interconnect/qcom/icc-rpm.h
> @@ -0,0 +1,73 @@
> +/* SPDX-License-Identifier: GPL-2.0 */
> +/*
> + * Copyright (C) 2020 Linaro Ltd
> + */
> +
> +#ifndef __DRIVERS_INTERCONNECT_QCOM_SMD_RPM_COMMON_H
> +#define __DRIVERS_INTERCONNECT_QCOM_SMD_RPM_COMMON_H

Would be nice if this matches with path and filename:
__DRIVERS_INTERCONNECT_QCOM_ICC_RPM_H


All the rest looks good.

Thanks,
Georgi
