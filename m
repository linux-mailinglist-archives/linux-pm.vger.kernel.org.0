Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7851566277E
	for <lists+linux-pm@lfdr.de>; Mon,  9 Jan 2023 14:44:50 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237206AbjAINor (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Mon, 9 Jan 2023 08:44:47 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56294 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237439AbjAINoB (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Mon, 9 Jan 2023 08:44:01 -0500
Received: from mail-lf1-x132.google.com (mail-lf1-x132.google.com [IPv6:2a00:1450:4864:20::132])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 50D671EC7B
        for <linux-pm@vger.kernel.org>; Mon,  9 Jan 2023 05:43:55 -0800 (PST)
Received: by mail-lf1-x132.google.com with SMTP id g13so13015177lfv.7
        for <linux-pm@vger.kernel.org>; Mon, 09 Jan 2023 05:43:55 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=rWl8UCfCUg60fJjNfhX7+lZo9Tp69LmtvnhMusTDvNs=;
        b=e2uVmD2gTVdDiQ/o8CVBjNj0ZqdlkQ5V8xjQF3phVP/ZKAWEMs0yue/Vpj+yBm/tri
         bRokMDB+cTmP4GLtI/B36CnUst2OIT9eLqpPqN86WT0eJEAxkrL69/QSlvd8aFXScgg2
         1r+FVd/0GelAkea7rSaKWxaQ52Cmzxh+6y+WspRZvJAE0gNFTleEUWIwg/SyasXbrLRM
         NFXi5bO19gBu6D6UnrCxSCsSrxhCF8wR7+DsFmClCeDIshG2Sexbn0mtYTdvTCW23DPE
         WxIKrpBA4qaUf0E30Yo1UTU2zUycI3ZZr0aqrvVTcROrJv2qYfM5a/XRVBIfHppGV/DS
         laLA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=rWl8UCfCUg60fJjNfhX7+lZo9Tp69LmtvnhMusTDvNs=;
        b=MYshy6KLSD0Pb8sJqv1dLOunkQyDdKLIZzu46lp8yBoq4cPzRycd/jelY5i+lAR1gF
         94bTA0Gwwxi3LfNkk7FxWhqNo5DfkVEgFWuD5nDqBTIbPdV7Mqzz6InKI1vemN1xCzvg
         qiIv3Bs9sVxHBZZixmXZbYGsntwAuabb8yxfyXvQgTnQtNiUayS3GOh+8AWcAgWT2kfR
         iqc+OUuWLofH9+CdjaTc/CYEOKWAl1YzVm3Bhonq9uxwHYRHbSvYsWyPDnwIZdPulaJN
         6gwbJ3STE5QmDPD1I/EfQH0XnoEh2/sMBwVgDLtDx1L28QCEurSyhNPgFtBFqxaJ0vzS
         1ACg==
X-Gm-Message-State: AFqh2krdGNPkgMc23fpylBWGQqxH6cOluBmyI/oTKByCeQ9DkJWNa70K
        y4AGj9nm+UoVr2sArUbpVXYQVsolfOPXNRxq
X-Google-Smtp-Source: AMrXdXuuwmZXRfVrYIvR4aFB8quO5/AwWXVjENPMlBK/Ld7vEdp8oFvN1cTzz/Bn9YABrA4d6vb5AQ==
X-Received: by 2002:a05:6512:1111:b0:4b5:43ef:a552 with SMTP id l17-20020a056512111100b004b543efa552mr19663828lfg.16.1673271833659;
        Mon, 09 Jan 2023 05:43:53 -0800 (PST)
Received: from [192.168.1.101] (abxi45.neoplus.adsl.tpnet.pl. [83.9.2.45])
        by smtp.gmail.com with ESMTPSA id f7-20020ac25327000000b004b4ea0f4e25sm1628259lfh.301.2023.01.09.05.43.52
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 09 Jan 2023 05:43:53 -0800 (PST)
Message-ID: <e9b0f691-82f6-d0a8-653e-a78470607588@linaro.org>
Date:   Mon, 9 Jan 2023 14:43:51 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.6.1
Subject: Re: [PATCH v3 02/12] interconnect: qcom: sc7180: drop IP0 remnants
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
 <20230109002935.244320-3-dmitry.baryshkov@linaro.org>
From:   Konrad Dybcio <konrad.dybcio@linaro.org>
In-Reply-To: <20230109002935.244320-3-dmitry.baryshkov@linaro.org>
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
> Drop two defines leftover from the commit 2f3724930eb4 ("interconnect:
> qcom: sc7180: Drop IP0 interconnects"), which dropped handling of the
> IP0 resource in favour of handling it in the clk-rpmh driver.
> 
> Fixes: 2f3724930eb4 ("interconnect: qcom: sc7180: Drop IP0 interconnects")
> Signed-off-by: Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
> ---
Reviewed-by: Konrad Dybcio <konrad.dybcio@linaro.org>

Konrad
>  drivers/interconnect/qcom/sc7180.h | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)
> 
> diff --git a/drivers/interconnect/qcom/sc7180.h b/drivers/interconnect/qcom/sc7180.h
> index c6212a10c2f6..7a2b3eb00923 100644
> --- a/drivers/interconnect/qcom/sc7180.h
> +++ b/drivers/interconnect/qcom/sc7180.h
> @@ -11,7 +11,7 @@
>  #define SC7180_MASTER_APPSS_PROC			0
>  #define SC7180_MASTER_SYS_TCU				1
>  #define SC7180_MASTER_NPU_SYS				2
> -#define SC7180_MASTER_IPA_CORE				3
> +/* 3 was used by MASTER_IPA_CORE, now represented as RPMh clock */
>  #define SC7180_MASTER_LLCC				4
>  #define SC7180_MASTER_A1NOC_CFG				5
>  #define SC7180_MASTER_A2NOC_CFG				6
> @@ -58,7 +58,7 @@
>  #define SC7180_MASTER_USB3				47
>  #define SC7180_MASTER_EMMC				48
>  #define SC7180_SLAVE_EBI1				49
> -#define SC7180_SLAVE_IPA_CORE				50
> +/* 50 was used by SLAVE_IPA_CORE, now represented as RPMh clock */
>  #define SC7180_SLAVE_A1NOC_CFG				51
>  #define SC7180_SLAVE_A2NOC_CFG				52
>  #define SC7180_SLAVE_AHB2PHY_SOUTH			53
