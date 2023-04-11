Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AA31C6DD942
	for <lists+linux-pm@lfdr.de>; Tue, 11 Apr 2023 13:21:38 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229815AbjDKLVg (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Tue, 11 Apr 2023 07:21:36 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60698 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229608AbjDKLVg (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Tue, 11 Apr 2023 07:21:36 -0400
Received: from mail-lf1-x130.google.com (mail-lf1-x130.google.com [IPv6:2a00:1450:4864:20::130])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 393FC1734
        for <linux-pm@vger.kernel.org>; Tue, 11 Apr 2023 04:21:34 -0700 (PDT)
Received: by mail-lf1-x130.google.com with SMTP id g19so52924569lfr.9
        for <linux-pm@vger.kernel.org>; Tue, 11 Apr 2023 04:21:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1681212092;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=58nYaq6wCyUylaMezZxGhLwTHgkD4rn+ZViBcBIc7E4=;
        b=B513c0RKCSYFEDbwBrR1T5EBTgDkmL1IoMt3JJD0qKZ3ZWEIrtcNvsIMzG8Mv4uoNa
         IlEWcv0kkpMjFW9O2GHSuD068HMy+no1VcBjKkLHWzkHJGb3kfASU6qh4n1iAJLFGULl
         vrXMw5PlOqocYcct8cdKrt7T2edwsJH3UC8WGZ9hyjp9Jz+oaSP5HUSiTsd7R/gnQa+I
         Zfjy3+vVy5qRZcqjHXY/Jy1UEiPBH6zWhAtAh542IzBlBMGDrLROmo0krkwxcDvzIrvk
         30wwXdIfZ3wpN72CWDnsb4IHjFr01r9hdUte9INj/s/v14IfCnG6Xopc2RlIN90sdkWT
         jsnA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1681212092;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=58nYaq6wCyUylaMezZxGhLwTHgkD4rn+ZViBcBIc7E4=;
        b=smkGSYKiuvHWqAZJ33JSRCsdzJnCFt+a8Pv3c3hYE2yZfQlaSTfvOKrHxpEU29XCfv
         5FlVfgMobgd91IGyDUv/4CRKvFtEamW9qFyV7j4QUciEa5fndQJBLzKLjbZKZlf+y9L5
         To1XQw9gT3wLwBVd8T+d1R6FmdEpLVXetwVyZhOZaPpihpfEWYqut4SJ9mCRws8fkgbZ
         0dZFCWvZFXYdYYczEHSzf385dzZP9nX6Nko2HalW7Xo3n4oZiIiOpEH+ZZbhT/o4tblS
         B0voKuyFKDrEm46jpeUOfDO77C+6x8j8xpxm54aZqrD1CRCrqThC1KUxvXjXBXIJ35ky
         rGvw==
X-Gm-Message-State: AAQBX9fTTaFY3kDz9ZxxrWUakVidDXxBMQaUt9zrtIZHhDy3UD9mMtHl
        taT19Ee8sCSjNzG2QXNmbQCxVQ==
X-Google-Smtp-Source: AKy350Zf5CdJ/4oO63gE8VJbxJYGpKxwijA6lXPLZRiXuapi5eSwS2dMjiR5GLQz4oOzVqYQmhcQvg==
X-Received: by 2002:a05:6512:39c4:b0:4dc:8049:6f36 with SMTP id k4-20020a05651239c400b004dc80496f36mr3171019lfu.1.1681212092391;
        Tue, 11 Apr 2023 04:21:32 -0700 (PDT)
Received: from [192.168.1.101] (abxj23.neoplus.adsl.tpnet.pl. [83.9.3.23])
        by smtp.gmail.com with ESMTPSA id q15-20020a19a40f000000b004db3e2d3efesm2491411lfc.204.2023.04.11.04.21.31
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 11 Apr 2023 04:21:32 -0700 (PDT)
Message-ID: <d317a2a3-56f6-3c7c-0896-c32476f075b3@linaro.org>
Date:   Tue, 11 Apr 2023 13:21:30 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.9.1
Subject: Re: [PATCH v4 2/4] iterconnect: add clk-based icc provider support
Content-Language: en-US
To:     Dmitry Baryshkov <dmitry.baryshkov@linaro.org>,
        Andy Gross <agross@kernel.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Georgi Djakov <djakov@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>
Cc:     Yassine Oudjana <y.oudjana@protonmail.com>,
        linux-arm-msm@vger.kernel.org, linux-pm@vger.kernel.org,
        devicetree@vger.kernel.org
References: <20230408234932.2363302-1-dmitry.baryshkov@linaro.org>
 <20230408234932.2363302-3-dmitry.baryshkov@linaro.org>
From:   Konrad Dybcio <konrad.dybcio@linaro.org>
In-Reply-To: <20230408234932.2363302-3-dmitry.baryshkov@linaro.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.4 required=5.0 tests=DKIM_SIGNED,DKIM_VALID,
        DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org



On 9.04.2023 01:49, Dmitry Baryshkov wrote:
> For some devices it is useful to export clocks as interconect providers,
> if the clock corresponds to bus bandwidth.
> 
> For example, on MSM8996 the cluster interconnect clock should be scaled
> according to the cluster frequencies. Exporting it as an interconnect
> allows one to properly describe this as the cluster bandwidth
> requirements.
> 
> Signed-off-by: Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
> ---
>  drivers/interconnect/Kconfig     |   6 ++
>  drivers/interconnect/Makefile    |   2 +
>  drivers/interconnect/icc-clk.c   | 168 +++++++++++++++++++++++++++++++
>  include/linux/interconnect-clk.h |  22 ++++
>  4 files changed, 198 insertions(+)
>  create mode 100644 drivers/interconnect/icc-clk.c
>  create mode 100644 include/linux/interconnect-clk.h
> 
> diff --git a/drivers/interconnect/Kconfig b/drivers/interconnect/Kconfig
> index d637a89d4695..5faa8d2aecff 100644
> --- a/drivers/interconnect/Kconfig
> +++ b/drivers/interconnect/Kconfig
> @@ -15,4 +15,10 @@ source "drivers/interconnect/imx/Kconfig"
>  source "drivers/interconnect/qcom/Kconfig"
>  source "drivers/interconnect/samsung/Kconfig"
>  
> +config INTERCONNECT_CLK
> +	tristate
> +	depends on COMMON_CLK
> +	help
> +	  Support for wrapping clocks into the interconnect nodes.
> +
>  endif
> diff --git a/drivers/interconnect/Makefile b/drivers/interconnect/Makefile
> index 97d393fd638d..5604ce351a9f 100644
> --- a/drivers/interconnect/Makefile
> +++ b/drivers/interconnect/Makefile
> @@ -7,3 +7,5 @@ obj-$(CONFIG_INTERCONNECT)		+= icc-core.o
>  obj-$(CONFIG_INTERCONNECT_IMX)		+= imx/
>  obj-$(CONFIG_INTERCONNECT_QCOM)		+= qcom/
>  obj-$(CONFIG_INTERCONNECT_SAMSUNG)	+= samsung/
> +
> +obj-$(CONFIG_INTERCONNECT_CLK)		+= icc-clk.o
> diff --git a/drivers/interconnect/icc-clk.c b/drivers/interconnect/icc-clk.c
> new file mode 100644
> index 000000000000..0db3b654548b
> --- /dev/null
> +++ b/drivers/interconnect/icc-clk.c
> @@ -0,0 +1,168 @@
> +/* SPDX-License-Identifier: GPL-2.0 */
> +/*
> + * Copyright (c) 2023, Linaro Ltd.
> + */
> +
> +#include <linux/clk.h>
> +#include <linux/device.h>
> +#include <linux/interconnect-clk.h>
> +#include <linux/interconnect-provider.h>
> +
> +struct icc_clk_node {
> +	struct clk *clk;
> +	bool enabled;
> +};
> +
> +struct icc_clk_provider {
> +	struct icc_provider provider;
> +	int num_clocks;
> +	struct icc_clk_node clocks[];
> +};
> +
> +#define to_icc_clk_provider(_provider) \
> +	container_of(_provider, struct icc_clk_provider, provider)
> +
> +static int icc_clk_set(struct icc_node *src, struct icc_node *dst)
> +{
> +	struct icc_clk_node *qn = src->data;
"qn" is used in qc drivers for "qcom node", the generic code should
probably use "n" for "node" or "cn" for "clock node".

> +	int ret;
> +
> +	if (!qn || !qn->clk)
> +		return 0;
Shouldn't this be an error?

> +
> +	if (!src->peak_bw) {
> +		if (qn->enabled)
> +			clk_disable_unprepare(qn->clk);
> +		qn->enabled = false;
> +
> +		return 0;
> +	}
> +
> +	if (!qn->enabled) {
> +		ret = clk_prepare_enable(qn->clk);
> +		if (ret)
> +			return ret;
> +		qn->enabled = true;
> +	}
> +
> +	return clk_set_rate(qn->clk, icc_units_to_bps(src->peak_bw));
> +}
> +
> +static int icc_clk_get_bw(struct icc_node *node, u32 *avg, u32 *peak)
> +{
> +	struct icc_clk_node *qn = node->data;
> +
> +	if (!qn || !qn->clk)
> +		*peak = INT_MAX;
> +	else
> +		*peak = Bps_to_icc(clk_get_rate(qn->clk));
clk_get_rate can return 0 if the rate is actually 0 or when
there's some sort of an error. Not sure how/whether we wanna
throw some warning there based on qp->enabled.


> +
> +	return 0;
> +}
> +
> +/**
> + * icc_clk_register() - register a new clk-based interconnect provider
> + * @dev: device supporting this provider
> + * @first_id: an ID of the first provider's node
> + * @num_clocks: number of instances of struct icc_clk_data
> + * @data: data for the provider
> + *
> + * Registers and returns a clk-based interconnect provider. It is a simple
> + * wrapper around COMMON_CLK framework, allowing other devices to vote on the
> + * clock rate.
> + *
> + * Return: 0 on success, or an error code otherwise
> + */
> +struct icc_provider *icc_clk_register(struct device *dev,
> +				      unsigned int first_id,
> +				      unsigned int num_clocks,
> +				      const struct icc_clk_data *data)
Misaligned

> +{
> +	struct icc_clk_provider *qp;
Similarly to before, "qp" was for "qcom provider".

> +	struct icc_provider *provider;
> +	struct icc_onecell_data *onecell;
> +	struct icc_node *node;
> +	int ret, i, j;
> +
> +	onecell = devm_kzalloc(dev, struct_size(onecell, nodes, 2 * num_clocks), GFP_KERNEL);
> +	if (!onecell)
> +		return ERR_PTR(-ENOMEM);
> +
> +	qp = devm_kzalloc(dev, struct_size(qp, clocks, num_clocks), GFP_KERNEL);
> +	if (!qp)
> +		return ERR_PTR(-ENOMEM);
> +
> +	qp->num_clocks = num_clocks;
> +
> +	provider = &qp->provider;
> +	provider->dev = dev;
> +	provider->get_bw = icc_clk_get_bw;
> +	provider->set = icc_clk_set;
> +	provider->aggregate = icc_std_aggregate;
> +	provider->xlate = of_icc_xlate_onecell;
> +	INIT_LIST_HEAD(&provider->nodes);
> +	provider->data = onecell;
> +
> +	icc_provider_init(provider);
> +
> +	for (i = 0, j = 0; i < num_clocks; i++) {
> +		qp->clocks[i].clk = data[i].clk;
> +
> +		node = icc_node_create(first_id + j);
Remove j altogether and use 2*i / 2*i + 1?

> +		if (IS_ERR(node)) {
> +			ret = PTR_ERR(node);
> +			goto err;
> +		}
> +
> +		node->name = devm_kasprintf(dev, GFP_KERNEL, "%s_master", data[i].name);
> +		node->data = &qp->clocks[i];
> +		icc_node_add(node, provider);
> +		/* link to the next node, slave */
> +		icc_link_create(node, first_id + j + 1);
> +		onecell->nodes[j++] = node;
> +
> +		node = icc_node_create(first_id + j);
> +		if (IS_ERR(node)) {
> +			ret = PTR_ERR(node);
> +			goto err;
> +		}
> +
> +		node->name = devm_kasprintf(dev, GFP_KERNEL, "%s_slave", data[i].name);
> +		/* no data for slave node */
> +		icc_node_add(node, provider);
> +		onecell->nodes[j++] = node;
> +	}
> +
> +	onecell->num_nodes = j> +
> +	ret = icc_provider_register(provider);
> +	if (ret)
> +		goto err;
> +
> +	return provider;
> +
> +err:
> +	icc_nodes_remove(provider);
> +
> +	return ERR_PTR(ret);
> +}
> +
> +/**
> + * icc_clk_unregister() - unregister a previously registered clk interconnect provider
> + * @provider: provider returned by icc_clk_register()
> + */
> +void icc_clk_unregister(struct icc_provider *provider)
> +{
> +	struct icc_clk_provider *qp = container_of(provider, struct icc_clk_provider, provider);
to_icc_clk_provider?

> +	int i;
> +
> +	icc_provider_deregister(&qp->provider);
> +	icc_nodes_remove(&qp->provider);
> +
> +	for (i = 0; i < qp->num_clocks; i++) {
> +		struct icc_clk_node *qn = &qp->clocks[i];
> +
> +		if (qn->enabled)
> +			clk_disable_unprepare(qn->clk);
> +	}
> +}
> diff --git a/include/linux/interconnect-clk.h b/include/linux/interconnect-clk.h
> new file mode 100644
> index 000000000000..0cd80112bea5
> --- /dev/null
> +++ b/include/linux/interconnect-clk.h
> @@ -0,0 +1,22 @@
> +/* SPDX-License-Identifier: GPL-2.0 */
> +/*
> + * Copyright (c) 2023, Linaro Ltd.
> + */
> +
> +#ifndef __LINUX_INTERCONNECT_CLK_H
> +#define __LINUX_INTERCONNECT_CLK_H
> +
> +struct device;
> +
> +struct icc_clk_data {
> +	struct clk *clk;
> +	const char *name;
> +};
> +
> +struct icc_provider *icc_clk_register(struct device *dev,
> +				      unsigned int first_id,
> +				      unsigned int num_clocks,
> +				      const struct icc_clk_data *data);
Misaligned

Konrad
> +void icc_clk_unregister(struct icc_provider *provider);
> +
> +#endif
