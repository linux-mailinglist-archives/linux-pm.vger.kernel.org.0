Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A05F2709E2A
	for <lists+linux-pm@lfdr.de>; Fri, 19 May 2023 19:31:58 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232118AbjESRb4 (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Fri, 19 May 2023 13:31:56 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40346 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232117AbjESRbl (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Fri, 19 May 2023 13:31:41 -0400
Received: from mail-pf1-x433.google.com (mail-pf1-x433.google.com [IPv6:2607:f8b0:4864:20::433])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DC2461BEA
        for <linux-pm@vger.kernel.org>; Fri, 19 May 2023 10:30:48 -0700 (PDT)
Received: by mail-pf1-x433.google.com with SMTP id d2e1a72fcca58-64d2c865e4eso1114664b3a.0
        for <linux-pm@vger.kernel.org>; Fri, 19 May 2023 10:30:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20221208; t=1684517442; x=1687109442;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=UC+jI3/CK9+amjGlwgD2fjJeUO4RPUZ3xbU2aD/Wzuc=;
        b=Btgcj/NqXDvRLxYdXKsksJ7KfJOVcTo2lby1gP+oiz1Ucfv0zDDAvdIKKg37PSwlDo
         OSoGBPBdwZVwYzptVaE48/LZYEEGl1ox15uuzGDq0IX0TwnyzdmQQcNeFue7F03IVYl1
         Yh77OG7Z42cRSrcFBVR8tn5GQEefyaHysNz3FQGtqjme7AweLw4CsTYvsvpeh3P6HP/i
         wQMywIHdhDAI28aVHUOSAJJN09yhTSYULS74SVSEP2YYGLFyjD1FQLHT175Tz9Rz3Jha
         JBZm+n5guQr4gwil+za9lyOumYOOW9HtzKQREKASdRLfHrFaXFQUm6iiVMIy/Ju14wp/
         m96g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1684517442; x=1687109442;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=UC+jI3/CK9+amjGlwgD2fjJeUO4RPUZ3xbU2aD/Wzuc=;
        b=V2JKuYnnN6J5AURsOpHmZthewM7ZaTQO8biz50EJ4y3AdWV4dYft8mJqy0W+NRdW+J
         3FEwXyLBE+7FeoNWgfqnt0sI/JHRWIpvO3ALfnnKHJUtxZJxxsNZl9sEV0mO1c2TR8JI
         Expi+PzZhtEfZeK6CzwaR7xC+6sRbZWvGkoDAO9UYamQldk0s3tX9B35lC8lK28yftSh
         vXvt6gAVdYoSumwmPvRxEgMEZJPz+5CcrxhF8DcE+qa3JveQZU5ao6COMrnGZ0XVCCfM
         81HTTugUQrazkY/IgbWooTF4FlBByq1lBg0wkHBLj52QOABReHd1vWsmTeFOgmypd4AY
         5/+A==
X-Gm-Message-State: AC+VfDyEMpe3NwNKUDYWfg+c7QdzACAEMfohEItBHCKffJXigG7j8ddQ
        7VT0P8DMUJnZwuEs9Y7cKk8doA==
X-Google-Smtp-Source: ACHHUZ7F2QVS8EAefbNQl9H9vP8gSthVYMLuaEyNi4/cSt5b9RpnlAOTm1x8bx6UlG3DIwW/u1+rLw==
X-Received: by 2002:a05:6a20:4285:b0:109:bd4c:3865 with SMTP id o5-20020a056a20428500b00109bd4c3865mr3169537pzj.24.1684517442075;
        Fri, 19 May 2023 10:30:42 -0700 (PDT)
Received: from google.com ([2620:15c:2d1:203:a93f:b5b1:61c5:a52a])
        by smtp.gmail.com with ESMTPSA id v7-20020aa78087000000b0063d3fbf4783sm3263959pff.80.2023.05.19.10.30.40
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 19 May 2023 10:30:41 -0700 (PDT)
Date:   Fri, 19 May 2023 10:30:35 -0700
From:   Nick Desaulniers <ndesaulniers@google.com>
To:     Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
Cc:     Andy Gross <agross@kernel.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Konrad Dybcio <konrad.dybcio@linaro.org>,
        Stephen Boyd <sboyd@kernel.org>,
        Michael Turquette <mturquette@baylibre.com>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Taniya Das <quic_tdas@quicinc.com>,
        Georgi Djakov <djakov@kernel.org>,
        linux-arm-msm@vger.kernel.org, linux-clk@vger.kernel.org,
        devicetree@vger.kernel.org,
        Yassine Oudjana <y.oudjana@protonmail.com>,
        linux-pm@vger.kernel.org, llvm@lists.linux.dev
Subject: Re: [PATCH v6 2/4] interconnect: add clk-based icc provider support
Message-ID: <ZGeyO6MRBSPf7b1y@google.com>
References: <20230512001334.2983048-1-dmitry.baryshkov@linaro.org>
 <20230512001334.2983048-3-dmitry.baryshkov@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230512001334.2983048-3-dmitry.baryshkov@linaro.org>
X-Spam-Status: No, score=-17.6 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        ENV_AND_HDR_SPF_MATCH,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE,USER_IN_DEF_DKIM_WL,USER_IN_DEF_SPF_WL
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

On Fri, May 12, 2023 at 03:13:32AM +0300, Dmitry Baryshkov wrote:
> For some devices it is useful to export clocks as interconnect providers,
> if the clock corresponds to bus bandwidth.
> 
> For example, on MSM8996 the cluster interconnect clock should be scaled
> according to the cluster frequencies. Exporting it as an interconnect
> allows one to properly describe this as the cluster bandwidth
> requirements.
> 
> Tested-by: Yassine Oudjana <y.oudjana@protonmail.com>
> Signed-off-by: Dmitry Baryshkov <dmitry.baryshkov@linaro.org>

Hi Dmitry,
Apologies if this has already been reported elsewhere, but our CI is red
for linux-next today for allmodconfig builds:

>> ERROR: modpost: missing MODULE_LICENSE() in drivers/interconnect/icc-clk.o

https://github.com/ClangBuiltLinux/continuous-integration2/actions/runs/5024096989/jobs/9011763868

Can you PTAL?

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
> +	int ret;
> +
> +	if (!qn || !qn->clk)
> +		return 0;
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
> +{
> +	struct icc_clk_provider *qp;
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
> +	onecell->num_nodes = j;
> +
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
> +void icc_clk_unregister(struct icc_provider *provider);
> +
> +#endif
> -- 
> 2.39.2
> 
