Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 90F0F6627AA
	for <lists+linux-pm@lfdr.de>; Mon,  9 Jan 2023 14:50:00 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233782AbjAINt2 (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Mon, 9 Jan 2023 08:49:28 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60462 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232809AbjAINs5 (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Mon, 9 Jan 2023 08:48:57 -0500
Received: from mail-lf1-x12c.google.com (mail-lf1-x12c.google.com [IPv6:2a00:1450:4864:20::12c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A70EB2F787
        for <linux-pm@vger.kernel.org>; Mon,  9 Jan 2023 05:48:54 -0800 (PST)
Received: by mail-lf1-x12c.google.com with SMTP id cf42so13057711lfb.1
        for <linux-pm@vger.kernel.org>; Mon, 09 Jan 2023 05:48:54 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=MbSke/IUyqgXB86/Q/wbUV3YxMuKXP8lQelAYhZP2mE=;
        b=s8gHZwha7IqoZmY7Il1f2rtVuX3I8ElWCde4cPs0ZRVvHMvdeCHvzW+FS6W23d71v4
         Gztt1roE3S2ORToJs863cRSfb4sOpFFd8eNR9/UdPqr4FTQbq8SRgP2Eqqv7L5WHXN4i
         LbQi5wiDDc0pj19G3YIOiFOACYajvqYh+tfKzjciZHAaZqquPCl3mwws/WuAYbp30p1w
         REkZKIJL9BAP7cy0lg4PerMVsmjqBAjxnKxza55Nl3cRZ3sH9u+jNYQd5NMNz5qVezUO
         6wI+VdfObdqcP4RdDMp4aNVmheDjSx/dUjgKBvM01dOsG8Dfb3mrnvJrT5MuCOzT1tSr
         EOsw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=MbSke/IUyqgXB86/Q/wbUV3YxMuKXP8lQelAYhZP2mE=;
        b=g213aKhNlMWCDKijYFPfiLCQTvm5OCIW7U8Ggprw1zD45liv1KRaDcxcOo1uhjvHev
         gzAZmsB7lmBXybXvqR6Je26AZ3VemHd+xpsRBrTsWMfTsIMXLWlBy099cGPYEa9ljsi6
         JfihCe34Xf01x72/VryR8zFSgONnULDVgkIDH3WQyO03ZZHLFacM2BYFj0e0yAClavLn
         SCq2IQLOwP0zhSWXGU+jIoOcG7RzLhSH+FSNqSZQXxVeuG7ig1AUqbS4Iv/37Fjkhv8i
         LdtiqCa529jZHPMIOpNsXhVnUyV/s2vCKLKo32XmLQE4pf3s6ysFlPJ0k/WiLMUfr1ZL
         kvcg==
X-Gm-Message-State: AFqh2kqksUL5iCj62gj9jgF8bgtOJA+CKPIkb3/myTLlXzgLXKaFylOC
        VQUYJ0vTWN9sbsLVjwEtjKyjgGdC1E90bsEW
X-Google-Smtp-Source: AMrXdXuu792JHbk4QZku+zqg839crgNVhT6aZC9/7T8VgQ6KlFCbk/ApuMblRABxt5fa9WHOsIfKvQ==
X-Received: by 2002:a05:6512:150b:b0:4ca:e66e:43c8 with SMTP id bq11-20020a056512150b00b004cae66e43c8mr18540432lfb.14.1673272132963;
        Mon, 09 Jan 2023 05:48:52 -0800 (PST)
Received: from [192.168.1.101] (abxi45.neoplus.adsl.tpnet.pl. [83.9.2.45])
        by smtp.gmail.com with ESMTPSA id x2-20020a056512130200b004a8f824466bsm1624242lfu.188.2023.01.09.05.48.51
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 09 Jan 2023 05:48:52 -0800 (PST)
Message-ID: <a4bb356e-830c-bd70-b1ca-b877664ae362@linaro.org>
Date:   Mon, 9 Jan 2023 14:48:50 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.6.1
Subject: Re: [PATCH v3 10/12] clk: qcom: rpmh: define IPA clocks where
 required
Content-Language: en-US
To:     Dmitry Baryshkov <dmitry.baryshkov@linaro.org>,
        Andy Gross <agross@kernel.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Stephen Boyd <sboyd@kernel.org>,
        Michael Turquette <mturquette@baylibre.com>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Taniya Das <quic_tdas@quicinc.com>
Cc:     Georgi Djakov <djakov@kernel.org>, Alex Elder <elder@linaro.org>,
        Johan Hovold <johan@kernel.org>, linux-arm-msm@vger.kernel.org,
        linux-clk@vger.kernel.org, linux-pm@vger.kernel.org,
        devicetree@vger.kernel.org
References: <20230109002935.244320-1-dmitry.baryshkov@linaro.org>
 <20230109002935.244320-11-dmitry.baryshkov@linaro.org>
From:   Konrad Dybcio <konrad.dybcio@linaro.org>
In-Reply-To: <20230109002935.244320-11-dmitry.baryshkov@linaro.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org



On 9.01.2023 01:29, Dmitry Baryshkov wrote:
> Follow the example of sc7180 and sdx55 and implement IP0 resource as
> clocks rather than interconnects.
> 
> Signed-off-by: Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
> ---
Reviewed-by: Konrad Dybcio <konrad.dybcio@linaro.org>

Konrad
>  drivers/clk/qcom/clk-rpmh.c | 4 ++++
>  1 file changed, 4 insertions(+)
> 
> diff --git a/drivers/clk/qcom/clk-rpmh.c b/drivers/clk/qcom/clk-rpmh.c
> index 7db5a53d73f0..05940e51b261 100644
> --- a/drivers/clk/qcom/clk-rpmh.c
> +++ b/drivers/clk/qcom/clk-rpmh.c
> @@ -455,6 +455,7 @@ static struct clk_hw *sm8150_rpmh_clocks[] = {
>  	[RPMH_RF_CLK2_A]	= &clk_rpmh_rf_clk2_a_ao.hw,
>  	[RPMH_RF_CLK3]		= &clk_rpmh_rf_clk3_a.hw,
>  	[RPMH_RF_CLK3_A]	= &clk_rpmh_rf_clk3_a_ao.hw,
> +	[RPMH_IPA_CLK]		= &clk_rpmh_ipa.hw,
>  };
>  
>  static const struct clk_rpmh_desc clk_rpmh_sm8150 = {
> @@ -494,6 +495,7 @@ static struct clk_hw *sc8180x_rpmh_clocks[] = {
>  	[RPMH_RF_CLK2_A]	= &clk_rpmh_rf_clk2_d_ao.hw,
>  	[RPMH_RF_CLK3]		= &clk_rpmh_rf_clk3_d.hw,
>  	[RPMH_RF_CLK3_A]	= &clk_rpmh_rf_clk3_d_ao.hw,
> +	[RPMH_IPA_CLK]		= &clk_rpmh_ipa.hw,
>  };
>  
>  static const struct clk_rpmh_desc clk_rpmh_sc8180x = {
> @@ -514,6 +516,7 @@ static struct clk_hw *sm8250_rpmh_clocks[] = {
>  	[RPMH_RF_CLK1_A]	= &clk_rpmh_rf_clk1_a_ao.hw,
>  	[RPMH_RF_CLK3]		= &clk_rpmh_rf_clk3_a.hw,
>  	[RPMH_RF_CLK3_A]	= &clk_rpmh_rf_clk3_a_ao.hw,
> +	[RPMH_IPA_CLK]		= &clk_rpmh_ipa.hw,
>  };
>  
>  static const struct clk_rpmh_desc clk_rpmh_sm8250 = {
> @@ -556,6 +559,7 @@ static struct clk_hw *sc8280xp_rpmh_clocks[] = {
>  	[RPMH_IPA_CLK]          = &clk_rpmh_ipa.hw,
>  	[RPMH_PKA_CLK]          = &clk_rpmh_pka.hw,
>  	[RPMH_HWKM_CLK]         = &clk_rpmh_hwkm.hw,
> +	[RPMH_IPA_CLK]		= &clk_rpmh_ipa.hw,
>  };
>  
>  static const struct clk_rpmh_desc clk_rpmh_sc8280xp = {
