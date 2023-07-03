Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 891CF745ADE
	for <lists+linux-pm@lfdr.de>; Mon,  3 Jul 2023 13:18:00 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229614AbjGCLR6 (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Mon, 3 Jul 2023 07:17:58 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42960 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230144AbjGCLR5 (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Mon, 3 Jul 2023 07:17:57 -0400
Received: from mail-lf1-x12e.google.com (mail-lf1-x12e.google.com [IPv6:2a00:1450:4864:20::12e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 655C2F3
        for <linux-pm@vger.kernel.org>; Mon,  3 Jul 2023 04:17:54 -0700 (PDT)
Received: by mail-lf1-x12e.google.com with SMTP id 2adb3069b0e04-4f9fdb0ef35so6812189e87.0
        for <linux-pm@vger.kernel.org>; Mon, 03 Jul 2023 04:17:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1688383072; x=1690975072;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=AiG2E9lyX7R6JeCw0Hq9bLTBu3xdtmAiHdXrjzQB/Go=;
        b=ftU7FTMwBj4VMEGow7wF9oaZUig6nbUCWaqi2MmOP1RFY6wePfmeFm+k3/HvFham5J
         dUQyOMnevCAwwZ1SgqqXTOafa5G373uxwEqxjwgyq3JkBYrifprqWkX8rn+wbpxVAjAI
         Hx04aLNBu+b4wSgaHdHHmgzakMLv60KoG3rOq68NxWmQ/9FAwfbxP2G8Bveoq4tjNNhK
         rJsNuDmMNS1RwbQSjyvDJEiR0HCVeeH1+Tb+071ILZXVQWHaDzw57fr6mSB7lxfdPpll
         Npc7FJImUGZLYlIWNjc5zoR4ICy12+zIVpzud4ub10TXFl92FzKcXZyJtO1HHIy8KQiP
         UBaw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1688383072; x=1690975072;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=AiG2E9lyX7R6JeCw0Hq9bLTBu3xdtmAiHdXrjzQB/Go=;
        b=TSzsZ/GO8CpFoBljGR+oWrcioeWf6HXReiOCq8uMtKxN2YXwDEUT4mZXvweN3EJI8x
         zj+YhE02xr2Wn3LCtT0uW2YLsQYjASPWdzi5Gd7EVK0+rwLu2ctM+6Mfb2S/vhqpKu1h
         8VmFH8bA7u3RfDjXyDr3s95h3HfRWHXNBlrBrF3DVlv7jGUDnVyWrkS88TjuuyA0fdbA
         JbExmj7E0z07eDcj1DCkC+jAuelgm6WQH09Z3ho4zi3JECq2zZFaUpvLkjMVzwxk+KGo
         bWXSrkU7FoUDLvJn7VgkTX1HykODEMJl2oGMtvTB7X9giG+7dkC4/T1XZ+CbrpU568eI
         naTw==
X-Gm-Message-State: ABy/qLZ3MJkCfgLrqLX2F+fAt+uTY2pH2U/7tCq1g7Om3WLK1N4P1b2l
        10wiKg9x3fdUfqpLAcUwKnlOpCA8R5bii36HSnUF5A==
X-Google-Smtp-Source: APBJJlF+ROws4cooNvbfGzB14o/lSdC80W+tRssizG9GZwZtIZG3LnIlnNPhCazurc5TA2oDfmdZKQ==
X-Received: by 2002:a05:6512:3a8e:b0:4f5:a181:97b8 with SMTP id q14-20020a0565123a8e00b004f5a18197b8mr7390760lfu.25.1688383072379;
        Mon, 03 Jul 2023 04:17:52 -0700 (PDT)
Received: from [192.168.1.101] (abyj26.neoplus.adsl.tpnet.pl. [83.9.29.26])
        by smtp.gmail.com with ESMTPSA id d1-20020ac24c81000000b004fb759964a9sm3758528lfl.168.2023.07.03.04.17.50
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 03 Jul 2023 04:17:52 -0700 (PDT)
Message-ID: <915fa7cd-5d5d-94dd-621c-654938cb07b3@linaro.org>
Date:   Mon, 3 Jul 2023 13:17:50 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.12.0
Subject: Re: [PATCH v3 06/28] interconnect: icc-clk: add support for scaling
 using OPP
Content-Language: en-US
To:     Dmitry Baryshkov <dmitry.baryshkov@linaro.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley <conor+dt@kernel.org>,
        Andy Gross <agross@kernel.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Ilia Lin <ilia.lin@kernel.org>,
        Viresh Kumar <vireshk@kernel.org>, Nishanth Menon <nm@ti.com>,
        Stephen Boyd <sboyd@kernel.org>,
        Michael Turquette <mturquette@baylibre.com>,
        "Rafael J. Wysocki" <rafael@kernel.org>,
        Georgi Djakov <djakov@kernel.org>
Cc:     linux-arm-msm@vger.kernel.org, devicetree@vger.kernel.org,
        linux-pm@vger.kernel.org, linux-clk@vger.kernel.org,
        Christian Marangi <ansuelsmth@gmail.com>,
        Stephan Gerhold <stephan@gerhold.net>
References: <20230702174246.121656-1-dmitry.baryshkov@linaro.org>
 <20230702174246.121656-7-dmitry.baryshkov@linaro.org>
From:   Konrad Dybcio <konrad.dybcio@linaro.org>
In-Reply-To: <20230702174246.121656-7-dmitry.baryshkov@linaro.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.2 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

On 2.07.2023 19:42, Dmitry Baryshkov wrote:
> Sometimes it might be required to scale the clock using the OPP
> framework (e.g. to scale regulators following the required clock rate).
> Extend the interconnec-clk framework to handle OPP case in addition to
> scaling the clock.
> 
> Signed-off-by: Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
> ---
Reviewed-by: Konrad Dybcio <konrad.dybcio@linaro.org>

Konrad
>  drivers/interconnect/icc-clk.c   | 13 +++++++++++--
>  include/linux/interconnect-clk.h |  1 +
>  2 files changed, 12 insertions(+), 2 deletions(-)
> 
> diff --git a/drivers/interconnect/icc-clk.c b/drivers/interconnect/icc-clk.c
> index 4d43ebff4257..c7962acdcee7 100644
> --- a/drivers/interconnect/icc-clk.c
> +++ b/drivers/interconnect/icc-clk.c
> @@ -7,10 +7,13 @@
>  #include <linux/device.h>
>  #include <linux/interconnect-clk.h>
>  #include <linux/interconnect-provider.h>
> +#include <linux/pm_opp.h>
>  
>  struct icc_clk_node {
> +	struct device *dev;
>  	struct clk *clk;
>  	bool enabled;
> +	bool opp;
>  };
>  
>  struct icc_clk_provider {
> @@ -25,12 +28,16 @@ struct icc_clk_provider {
>  static int icc_clk_set(struct icc_node *src, struct icc_node *dst)
>  {
>  	struct icc_clk_node *qn = src->data;
> +	unsigned long rate = icc_units_to_bps(src->peak_bw);
>  	int ret;
>  
>  	if (!qn || !qn->clk)
>  		return 0;
>  
> -	if (!src->peak_bw) {
> +	if (qn->opp)
> +		return dev_pm_opp_set_rate(qn->dev, rate);
> +
> +	if (!rate) {
>  		if (qn->enabled)
>  			clk_disable_unprepare(qn->clk);
>  		qn->enabled = false;
> @@ -45,7 +52,7 @@ static int icc_clk_set(struct icc_node *src, struct icc_node *dst)
>  		qn->enabled = true;
>  	}
>  
> -	return clk_set_rate(qn->clk, icc_units_to_bps(src->peak_bw));
> +	return clk_set_rate(qn->clk, rate);
>  }
>  
>  static int icc_clk_get_bw(struct icc_node *node, u32 *avg, u32 *peak)
> @@ -106,7 +113,9 @@ struct icc_provider *icc_clk_register(struct device *dev,
>  	icc_provider_init(provider);
>  
>  	for (i = 0, j = 0; i < num_clocks; i++) {
> +		qp->clocks[i].dev = dev;
>  		qp->clocks[i].clk = data[i].clk;
> +		qp->clocks[i].opp = data[i].opp;
>  
>  		node = icc_node_create(first_id + j);
>  		if (IS_ERR(node)) {
> diff --git a/include/linux/interconnect-clk.h b/include/linux/interconnect-clk.h
> index 0cd80112bea5..c695e5099901 100644
> --- a/include/linux/interconnect-clk.h
> +++ b/include/linux/interconnect-clk.h
> @@ -11,6 +11,7 @@ struct device;
>  struct icc_clk_data {
>  	struct clk *clk;
>  	const char *name;
> +	bool opp;
>  };
>  
>  struct icc_provider *icc_clk_register(struct device *dev,
