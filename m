Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 64BED688D66
	for <lists+linux-pm@lfdr.de>; Fri,  3 Feb 2023 03:53:30 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232004AbjBCCx2 (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Thu, 2 Feb 2023 21:53:28 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58872 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232002AbjBCCx1 (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Thu, 2 Feb 2023 21:53:27 -0500
Received: from mail-ej1-x62f.google.com (mail-ej1-x62f.google.com [IPv6:2a00:1450:4864:20::62f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id ADEDE3B657
        for <linux-pm@vger.kernel.org>; Thu,  2 Feb 2023 18:53:24 -0800 (PST)
Received: by mail-ej1-x62f.google.com with SMTP id hx15so11653176ejc.11
        for <linux-pm@vger.kernel.org>; Thu, 02 Feb 2023 18:53:24 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=Yo+aFZ5QQ/uWL3CjrlBOZYca0lCKb40QkSx1ezLfSE0=;
        b=wcAcqY5ez42orIdT32m5UGvNP+MeAv1kQxgWXE+7fkka8v/GEf93dc63kHXEwmF1Fn
         7qJhnQICRHjIhb6iiDGBaTCbCSBULc391n8QNo8ftx/gfqUnLNI+kg5sP1w1DZuk9CTQ
         Q75Q0BViDWR9ANc3VKUMViHrW+tj0Ikxoa48/+7vDj3e8Lnd+u6KBri/SvOUN3jzfII5
         znHBzviIiY1iNplQccryYRBf1303YWGjctCzwbxXT0qXHEUTKhR0W1sDXwAAtBuqRs3L
         TNFX16bworCUKOK/lZId3U/3xqs5pW3cZpal8mbciRRVr/AbXxRFuY2JmnjWvSXaMMFa
         dxmA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=Yo+aFZ5QQ/uWL3CjrlBOZYca0lCKb40QkSx1ezLfSE0=;
        b=qBi8odkl2r81cfQ2IQ003w002EN9L5W9MQqgIwsYEFwMX5Mlj+tsfPVYjFVkGPMFVJ
         otvLxSAEM1TLttGvd82LN56s8ATxRf6jQLdc199HU/lbIolE6XdjVjvPn93Pl1y8xowR
         +HxbNvxzt7g3zVMec+klpGHxI3MP8fLCpGtpcgSJ295x2SQNFZGQuJ8hcXuJ2Fjpn/19
         RW4sIHMPEuZhe/+aNfPF6P/8Jz2jdG+pj0Ez2CNxTvgzb0OOTRz3OuKqb/TrJG4iFGp0
         /Fq1war4HLJAZf/psMol4NOqh8dePbVCcjTg83kIjiv9h/Yug9ZUAM9D6kZ2lvi4Lums
         CQOg==
X-Gm-Message-State: AO0yUKV1M6ZF6gLqUilcrAq+c6nMsBv8GirmCMksKLD2/iDNvJmH892S
        Foqy3whXltFDzLxaRfHkgIAVpQ==
X-Google-Smtp-Source: AK7set/sHUB0PJ4zCstfU+8ieheHljg0vLSu0D2o+FGVahwziH+j7dZ//ypkczHXcZbYmyJJEAWyAQ==
X-Received: by 2002:a17:907:3d87:b0:88f:9c29:d232 with SMTP id he7-20020a1709073d8700b0088f9c29d232mr46757ejc.57.1675392803241;
        Thu, 02 Feb 2023 18:53:23 -0800 (PST)
Received: from [192.168.1.101] (abyl20.neoplus.adsl.tpnet.pl. [83.9.31.20])
        by smtp.gmail.com with ESMTPSA id lv3-20020a170906bc8300b00883410a786csm642358ejb.207.2023.02.02.18.53.21
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 02 Feb 2023 18:53:22 -0800 (PST)
Message-ID: <33cff77a-1967-e902-6a49-3ebf6b80f1ec@linaro.org>
Date:   Fri, 3 Feb 2023 03:53:20 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.7.0
Subject: Re: [PATCH 07/23] interconnect: qcom: rpm: fix probe PM domain error
 handling
Content-Language: en-US
To:     Johan Hovold <johan+linaro@kernel.org>,
        Georgi Djakov <djakov@kernel.org>
Cc:     Shawn Guo <shawnguo@kernel.org>,
        Sascha Hauer <s.hauer@pengutronix.de>,
        Pengutronix Kernel Team <kernel@pengutronix.de>,
        Fabio Estevam <festevam@gmail.com>,
        NXP Linux Team <linux-imx@nxp.com>,
        Andy Gross <agross@kernel.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Sylwester Nawrocki <s.nawrocki@samsung.com>,
        =?UTF-8?B?QXJ0dXIgxZp3aWdvxYQ=?= <a.swigon@samsung.com>,
        Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>,
        Alim Akhtar <alim.akhtar@samsung.com>,
        Thierry Reding <thierry.reding@gmail.com>,
        Jonathan Hunter <jonathanh@nvidia.com>,
        linux-pm@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-arm-msm@vger.kernel.org, linux-samsung-soc@vger.kernel.org,
        linux-tegra@vger.kernel.org, linux-kernel@vger.kernel.org,
        stable@vger.kernel.org, Yassine Oudjana <y.oudjana@protonmail.com>
References: <20230201101559.15529-1-johan+linaro@kernel.org>
 <20230201101559.15529-8-johan+linaro@kernel.org>
From:   Konrad Dybcio <konrad.dybcio@linaro.org>
In-Reply-To: <20230201101559.15529-8-johan+linaro@kernel.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.2 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org



On 1.02.2023 11:15, Johan Hovold wrote:
> Make sure to disable clocks also in case attaching the power domain
> fails.
> 
> Fixes: 7de109c0abe9 ("interconnect: icc-rpm: Add support for bus power domain")
> Cc: stable@vger.kernel.org      # 5.17
> Cc: Yassine Oudjana <y.oudjana@protonmail.com>
> Signed-off-by: Johan Hovold <johan+linaro@kernel.org>
> ---
Reviewed-by: Konrad Dybcio <konrad.dybcio@linaro.org>

Konrad
>  drivers/interconnect/qcom/icc-rpm.c | 9 ++++-----
>  1 file changed, 4 insertions(+), 5 deletions(-)
> 
> diff --git a/drivers/interconnect/qcom/icc-rpm.c b/drivers/interconnect/qcom/icc-rpm.c
> index 91778cfcbc65..da595059cafd 100644
> --- a/drivers/interconnect/qcom/icc-rpm.c
> +++ b/drivers/interconnect/qcom/icc-rpm.c
> @@ -498,8 +498,7 @@ int qnoc_probe(struct platform_device *pdev)
>  
>  	if (desc->has_bus_pd) {
>  		ret = dev_pm_domain_attach(dev, true);
> -		if (ret)
> -			return ret;
> +		goto err_disable_clks;
>  	}
>  
>  	provider = &qp->provider;
> @@ -514,8 +513,7 @@ int qnoc_probe(struct platform_device *pdev)
>  	ret = icc_provider_add(provider);
>  	if (ret) {
>  		dev_err(dev, "error adding interconnect provider: %d\n", ret);
> -		clk_bulk_disable_unprepare(qp->num_clks, qp->bus_clks);
> -		return ret;
> +		goto err_disable_clks;
>  	}
>  
>  	for (i = 0; i < num_nodes; i++) {
> @@ -550,8 +548,9 @@ int qnoc_probe(struct platform_device *pdev)
>  	return 0;
>  err:
>  	icc_nodes_remove(provider);
> -	clk_bulk_disable_unprepare(qp->num_clks, qp->bus_clks);
>  	icc_provider_del(provider);
> +err_disable_clks:
> +	clk_bulk_disable_unprepare(qp->num_clks, qp->bus_clks);
>  
>  	return ret;
>  }
