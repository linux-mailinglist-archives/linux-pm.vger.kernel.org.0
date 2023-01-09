Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0EDE3662793
	for <lists+linux-pm@lfdr.de>; Mon,  9 Jan 2023 14:46:30 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234546AbjAINq2 (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Mon, 9 Jan 2023 08:46:28 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55726 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236975AbjAINoU (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Mon, 9 Jan 2023 08:44:20 -0500
Received: from mail-lj1-x236.google.com (mail-lj1-x236.google.com [IPv6:2a00:1450:4864:20::236])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B1D4F1EC4F
        for <linux-pm@vger.kernel.org>; Mon,  9 Jan 2023 05:44:18 -0800 (PST)
Received: by mail-lj1-x236.google.com with SMTP id s22so8900399ljp.5
        for <linux-pm@vger.kernel.org>; Mon, 09 Jan 2023 05:44:18 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=3v/urk97wKGi10t4zFr7GyX2Qd2Ark2mf3B1dwYMq4c=;
        b=wWXKsZMJgoXaEU7yjmdmqDQv/D+v2BGIs3G1kWYcpuaoMob78JiBovZfqdSzsw3sk8
         s32WRvevUOCb8n86qiblCFdG4SUplVM3HS5oIjNsWjLLKJNhy9dDeWh+TOY1TqO1PRxO
         h5LpJt+qUkuWspSQk3mjF+zrPkzfioZHI38ZqXqguol6/TR7j0yus7m2yN9tnVfsFbs5
         foPbhzqPPOORyQHuOI5dEFFWL2mz7MIjxWO6T5rtxRsjulXborxvRPRlhVwYQOG/Mk5a
         rkTtxzM1bE/YJz4DLQHbZwVO2NrjxxMHYTELTDgcm54BJI2IYzqfMLaJnpeTcMoIBJqY
         GdqQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=3v/urk97wKGi10t4zFr7GyX2Qd2Ark2mf3B1dwYMq4c=;
        b=JKasgu8pZdOBzP9/fY+RUCVbfSWQdFy9WXmkxkz8u++pbSt9foC1BA4nzOOGyX2qSi
         DlXVTdooR4f9dq8oiOYHJOgsRNKh5hOve/GdoRQHIgCljGiwHdp5JWk+dcQlb5oejYHY
         rKGAbaXLeymvVULh/R56QWRj4OmdfaSCt3WbCv53nTFw3r0Nh4NTmOmu0OM6qIM5s8X/
         BdHX/APlMasQogGfWgvvYTCtP6KEwP75G0szx5YJGQQilxIIBlLFsLxK1kAu/UhoTQXm
         I0Ffy6YBIWrXr69c1/dXICRx9ciWWIok89WRyF8+NVz/wK82XLynCztE1BTcgpE6ZSuj
         DoiA==
X-Gm-Message-State: AFqh2kqoDlOJUabcOaYH/m6MLRz47os9iiJudYw/ljrlXWDJhn01lEJt
        j9tgp0g2u2wYCIWZpy/KW/p3xg==
X-Google-Smtp-Source: AMrXdXvlruhAsfHw0sKgwKtCWKYeFjn0JSLjvermqiR4yxusPFxZLM0oK51UExFkctwIFWhJKuS9iw==
X-Received: by 2002:a05:651c:1785:b0:280:9da3:1431 with SMTP id bn5-20020a05651c178500b002809da31431mr5819969ljb.27.1673271857108;
        Mon, 09 Jan 2023 05:44:17 -0800 (PST)
Received: from [192.168.1.101] (abxi45.neoplus.adsl.tpnet.pl. [83.9.2.45])
        by smtp.gmail.com with ESMTPSA id y3-20020a2ebb83000000b002830d074c84sm694983lje.85.2023.01.09.05.44.15
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 09 Jan 2023 05:44:16 -0800 (PST)
Message-ID: <e8c56d1b-74ac-4285-2afa-ff4271766935@linaro.org>
Date:   Mon, 9 Jan 2023 14:44:15 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.6.1
Subject: Re: [PATCH v3 03/12] interconnect: move ignore_list out of
 of_count_icc_providers()
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
        devicetree@vger.kernel.org, kernel test robot <lkp@intel.com>
References: <20230109002935.244320-1-dmitry.baryshkov@linaro.org>
 <20230109002935.244320-4-dmitry.baryshkov@linaro.org>
From:   Konrad Dybcio <konrad.dybcio@linaro.org>
In-Reply-To: <20230109002935.244320-4-dmitry.baryshkov@linaro.org>
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
> Move the const ignore_list definition out of the
> of_count_icc_providers() function. This prevents the following stack
> frame size warnings if the list is expanded:
> 
> drivers/interconnect/core.c:1082:12: warning: stack frame size (1216) exceeds limit (1024) in 'of_count_icc_providers' [-Wframe-larger-than]
> 
> Reported-by: kernel test robot <lkp@intel.com>
> Signed-off-by: Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
> ---
Reviewed-by: Konrad Dybcio <konrad.dybcio@linaro.org>

Konrad
>  drivers/interconnect/core.c | 11 ++++++-----
>  1 file changed, 6 insertions(+), 5 deletions(-)
> 
> diff --git a/drivers/interconnect/core.c b/drivers/interconnect/core.c
> index 25debded65a8..df77d2f6215d 100644
> --- a/drivers/interconnect/core.c
> +++ b/drivers/interconnect/core.c
> @@ -1079,15 +1079,16 @@ void icc_provider_del(struct icc_provider *provider)
>  }
>  EXPORT_SYMBOL_GPL(icc_provider_del);
>  
> +static const struct of_device_id __maybe_unused ignore_list[] = {
> +	{ .compatible = "qcom,sc7180-ipa-virt" },
> +	{ .compatible = "qcom,sdx55-ipa-virt" },
> +	{}
> +};
> +
>  static int of_count_icc_providers(struct device_node *np)
>  {
>  	struct device_node *child;
>  	int count = 0;
> -	const struct of_device_id __maybe_unused ignore_list[] = {
> -		{ .compatible = "qcom,sc7180-ipa-virt" },
> -		{ .compatible = "qcom,sdx55-ipa-virt" },
> -		{}
> -	};
>  
>  	for_each_available_child_of_node(np, child) {
>  		if (of_property_read_bool(child, "#interconnect-cells") &&
