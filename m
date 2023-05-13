Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1C763701574
	for <lists+linux-pm@lfdr.de>; Sat, 13 May 2023 11:00:05 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232564AbjEMJAC (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Sat, 13 May 2023 05:00:02 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49286 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237357AbjEMJAB (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Sat, 13 May 2023 05:00:01 -0400
Received: from mail-lj1-x234.google.com (mail-lj1-x234.google.com [IPv6:2a00:1450:4864:20::234])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 753054C38
        for <linux-pm@vger.kernel.org>; Sat, 13 May 2023 01:59:59 -0700 (PDT)
Received: by mail-lj1-x234.google.com with SMTP id 38308e7fff4ca-2ac89e6a5a1so106413471fa.0
        for <linux-pm@vger.kernel.org>; Sat, 13 May 2023 01:59:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1683968398; x=1686560398;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=YV/mnZ4/4r3AbGxzYpTnL7fXn/4PhGDzkVnVht6PIUY=;
        b=hydG02x8sN3Dc1uuIrMUyEL0Lbr9XO80nlza33L7ih1cLxw/mJf97Bf8dZAljcKrs7
         HZVxeGdtJxKwBoKaSTNTgpl2Abp0QVtYNe3x3AHzqb0yVJKbKpGXea4xsSZWNEuE6O9i
         B6TBd8wKi0FO4ehtxmdFpaC4cyTmMrLd+yWJOK7TEhWLwGiaKuCWlGAUt+78urdCs4+S
         X8vD+wk5DIyELX/JzrJN78k+ekM3nQ0Gp8WHWHCZzWggEMEX1WeN/ibAb/4z9QFWjS4n
         MmgOY0zYcC/GbWBCohV7VoamXoQQyzBCp+rduT/FWHJvFPYFSXY0PUMUOG/+nE1rDW4Q
         Wj2g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1683968398; x=1686560398;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=YV/mnZ4/4r3AbGxzYpTnL7fXn/4PhGDzkVnVht6PIUY=;
        b=FnU4Io0ui48IZNcb8Fc7N8nzulSAc2mzsweZH8ceAC/8V7CrO1YioT+R0LhFFKlMjG
         hh97kniwIEBUPUMfCgLeA1pE0uXCV2/TSFDw7NKLA4XbX9af20sfx0iHjwcwjAlmsBne
         PI/x+jvLLzXFpMCg5D27DDOvaEXvNq1HhVxSPCUOMvOMh/TscadQXjr9x9bgtaKwZEh8
         2wLE1BLP2wmhmy8+AVOAn61iD+sFRmE9I6fWF0MzZ6TB6G30CFnkoq+ZrWMa1bJGFTUm
         9Av1PvNOzwD2Z4k10VdC4bBdxRwCGDTfide4WU/WoWIDGkY5gc9fgnXwF1OU1VXEr8t4
         mokA==
X-Gm-Message-State: AC+VfDzx7GWngRnL1TO1Eu5cVaDikc7cgvqgFhDbCSEqiNgSweLDk5QE
        5LNJyhV1eu33y5DwDQ9UuD5xkg==
X-Google-Smtp-Source: ACHHUZ5/oqXsjheRMdwkquVqrIgZ9TCHtwYEIipwgHc9qOwzW5KHHGhiProtciW738juU+Gtz6MOyw==
X-Received: by 2002:a2e:9bd7:0:b0:2ad:9161:7aca with SMTP id w23-20020a2e9bd7000000b002ad91617acamr5113901ljj.41.1683968397737;
        Sat, 13 May 2023 01:59:57 -0700 (PDT)
Received: from [192.168.1.101] (abxi58.neoplus.adsl.tpnet.pl. [83.9.2.58])
        by smtp.gmail.com with ESMTPSA id y5-20020a2e95c5000000b002addbc16a54sm342220ljh.41.2023.05.13.01.59.56
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sat, 13 May 2023 01:59:57 -0700 (PDT)
Message-ID: <9c07e0a1-d3a6-03df-87a0-f2bdbac7d8f3@linaro.org>
Date:   Sat, 13 May 2023 10:59:55 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.10.1
Subject: Re: [PATCH v6 2/4] interconnect: add clk-based icc provider support
Content-Language: en-US
To:     Dmitry Baryshkov <dmitry.baryshkov@linaro.org>,
        Andy Gross <agross@kernel.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Stephen Boyd <sboyd@kernel.org>,
        Michael Turquette <mturquette@baylibre.com>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Taniya Das <quic_tdas@quicinc.com>,
        Georgi Djakov <djakov@kernel.org>
Cc:     linux-arm-msm@vger.kernel.org, linux-clk@vger.kernel.org,
        devicetree@vger.kernel.org,
        Yassine Oudjana <y.oudjana@protonmail.com>,
        linux-pm@vger.kernel.org
References: <20230512001334.2983048-1-dmitry.baryshkov@linaro.org>
 <20230512001334.2983048-3-dmitry.baryshkov@linaro.org>
From:   Konrad Dybcio <konrad.dybcio@linaro.org>
In-Reply-To: <20230512001334.2983048-3-dmitry.baryshkov@linaro.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-3.0 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org



On 12.05.2023 02:13, Dmitry Baryshkov wrote:
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
> ---
[...]

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
I'm still not very into using 2 iterators and modifying one
on the flight, but I don't think I have any other issues with
this driver..

Some sort of a Mostly-Acked-by tag would be helpful here!

Konrad
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
