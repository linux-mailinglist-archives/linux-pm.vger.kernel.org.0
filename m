Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 51BD573DD77
	for <lists+linux-pm@lfdr.de>; Mon, 26 Jun 2023 13:28:56 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229487AbjFZL2y (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Mon, 26 Jun 2023 07:28:54 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33470 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229629AbjFZL2x (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Mon, 26 Jun 2023 07:28:53 -0400
Received: from mail-lf1-x12f.google.com (mail-lf1-x12f.google.com [IPv6:2a00:1450:4864:20::12f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A955910F
        for <linux-pm@vger.kernel.org>; Mon, 26 Jun 2023 04:28:50 -0700 (PDT)
Received: by mail-lf1-x12f.google.com with SMTP id 2adb3069b0e04-4fb7373dd35so1387716e87.1
        for <linux-pm@vger.kernel.org>; Mon, 26 Jun 2023 04:28:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1687778929; x=1690370929;
        h=content-transfer-encoding:in-reply-to:subject:from:references:cc:to
         :content-language:user-agent:mime-version:date:message-id:from:to:cc
         :subject:date:message-id:reply-to;
        bh=6+m+HWADuI8txJr+WXtBskYCNdGlGOVr46UsKfQM6Lo=;
        b=JHsOfKu/1tn3pBMyBbDbZtg93k81jEr6Xb707421GZsbsNEZVsNQLaKSxlLW13k+PM
         Q0Klfy5TpI6yL2yUhMyvhUfWf21muYHIYR6sya6ICj+usZHoBzdsU0PP6oNVRjQCAzZn
         rdbfB52aWb88aU/fJzYtt52Dea2+t1LB8bsgVYkjXvOaz6suXQlYWXUn34IjjzmGKN4L
         NHD+y6c53hwOKRemPQUM4aG+fu1hcSavMoOGCrj6iYy2e5w8UctwjPXLIHe8glhkuJoI
         GJGHFEAqsupiNzpC7Stp8ntASaifC7H7fCzBRBxRAjodUZrFArJnLzNo7xcb9nmX6beA
         AjaA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1687778929; x=1690370929;
        h=content-transfer-encoding:in-reply-to:subject:from:references:cc:to
         :content-language:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=6+m+HWADuI8txJr+WXtBskYCNdGlGOVr46UsKfQM6Lo=;
        b=lfzWZRqGdmu/AAl0H9irCzR4Y+zp73xFmXmW3juVWmzSN2gWpUFUKr4HWe28Z5R9qC
         sxHDRrQaJo78bDyVwd/yjB1f3/ljcBbuw3i6MyHEs9N/TwHpWVA8RFpTSco5ExqHWEKA
         G8ZpnzwSyqRo+sHpiFv/6IjstRCsuZjw7lH26oGbb3gzhvNmf/rnc/gNvqoqD2Ig3KLY
         m0+7u/mb02Dt18CqHfChs/XHppGhge0T1ZfRrxhaDGiVHbxUXDbgWr1lPgKvoqGgICTA
         UE3IHaGpvYoEjBZB8gCuEO9xGnNPnMia2lpQFOvf3sII+1Cq4c6GqlhJ3IjpxbkpuVZv
         iETg==
X-Gm-Message-State: AC+VfDygmFYoGrOkzxb6ecQJOyL9lnIhOAVvsmnJotbIur4PQel9my96
        qHBhO16JFqFDpS5RiBZ3ye2PgQ==
X-Google-Smtp-Source: ACHHUZ7438MroKqR9FP0KLt4s2rTxYZzkx4y2B8xUzluztptmO3AtSJv6bRClIvFv6wjvfWD57lxWQ==
X-Received: by 2002:a19:2d4e:0:b0:4f8:453f:732f with SMTP id t14-20020a192d4e000000b004f8453f732fmr9481734lft.2.1687778928872;
        Mon, 26 Jun 2023 04:28:48 -0700 (PDT)
Received: from [192.168.1.101] (abyk179.neoplus.adsl.tpnet.pl. [83.9.30.179])
        by smtp.gmail.com with ESMTPSA id a22-20020a19f816000000b004fb77d6cab3sm235002lff.261.2023.06.26.04.28.47
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 26 Jun 2023 04:28:48 -0700 (PDT)
Message-ID: <b5ff346b-cbde-68fe-a08a-3b3331439309@linaro.org>
Date:   Mon, 26 Jun 2023 13:28:46 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.12.0
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
References: <20230625202547.174647-1-dmitry.baryshkov@linaro.org>
 <20230625202547.174647-7-dmitry.baryshkov@linaro.org>
From:   Konrad Dybcio <konrad.dybcio@linaro.org>
Subject: Re: [PATCH v2 06/26] interconnect: icc-clk: add support for scaling
 using OPP
In-Reply-To: <20230625202547.174647-7-dmitry.baryshkov@linaro.org>
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

On 25.06.2023 22:25, Dmitry Baryshkov wrote:
> Sometimes it might be required to scale the clock using the OPP
> framework (e.g. to scale regulators following the required clock rate).
> Extend the interconnec
't'

>-clk framework to handle OPP case in addition to
> scaling the clock.
> 
> Signed-off-by: Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
> ---
I think we should check for OPP at the icc-clk registration time,
instead of passing it as a parameter, e.g.:

qn.opp = IS_ERR(dev_pm_opp_get_opp_count)

Not sure if there's a more idiomatic way.

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
