Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 63F526627B3
	for <lists+linux-pm@lfdr.de>; Mon,  9 Jan 2023 14:50:33 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234302AbjAINuB (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Mon, 9 Jan 2023 08:50:01 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60612 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237018AbjAINtf (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Mon, 9 Jan 2023 08:49:35 -0500
Received: from mail-lf1-x134.google.com (mail-lf1-x134.google.com [IPv6:2a00:1450:4864:20::134])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2C0C132E99
        for <linux-pm@vger.kernel.org>; Mon,  9 Jan 2023 05:49:31 -0800 (PST)
Received: by mail-lf1-x134.google.com with SMTP id b3so13061716lfv.2
        for <linux-pm@vger.kernel.org>; Mon, 09 Jan 2023 05:49:31 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=XQ++tXnAAnj4m7JM+pf48esO3W6svpjP4CzYNi5gjuA=;
        b=P1t1ZIq0yzDJEN8nuVNvuK3RJDYGdKS/K3WMkwHh4S1IfW4KbYkMt4yN4l3ar99T6u
         DSRsCRw/D++IMBvAjPc+cN+PoONcOYHHTCIi5Ea19LfRhdV5yn47vkkXF4gnVFOWY0pP
         NI+K6aBCU+UTwT6JWgUAW+6d+ZKoEzNuC+fM/QfHmpqB3PcecNkeLkwWzw/sv2H9fsTW
         5N5Ff44rdvrDIBE5VaEb281wKDTtCy8ujwyFAhYctDYbA8SpcyQQhM2+FcOZDOXL2uF2
         LAzw1q50rXJhhA+3uhQdCfNrFkIP0pYzMSkDe0lDU90MTHjQjRyUS+VnP4nu7hrIImns
         NNTg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=XQ++tXnAAnj4m7JM+pf48esO3W6svpjP4CzYNi5gjuA=;
        b=io+5RpZpAFxgLzfonbw7R6DhVUthb/iGaSOrhMhuJ1aHSgwgVyO0xx8lq6Qu2pAUpU
         gmW9/OO/I4Db7sa1np7SCON0PCag6MRXzcCI6X1zsp9kcnJFZ9+3e0cHc81z0m/TUldR
         eMKskodT8FzAF53fkP3UMADRQ+IhewPo1QOV86FwOvlZo2J0MCjlcatPIvqHQaYedfbx
         OYWfyGBYaKLFPFq1T9SyXcnDeMybpFeAg6DdFCOi0QoD0xIY3oPiPJwSEk5jjogaRKos
         ZIOczk+k+q+7/EOmAb4mh756exJ8rIFYqwXF9DSRKCAQXISAoNuPd3TN+O/+YoDyL9Xv
         qnUw==
X-Gm-Message-State: AFqh2kpzYQEOk58dN9wcyw8SPGD4vFTiWWxhIWdARp4VGEd0OPUN28hr
        v8rBIo6uwCe53hLzhlebt3xAXQ==
X-Google-Smtp-Source: AMrXdXu9C4VmnuquuZKtg4t9IstWGTTnPCNJc8c7t5T828Id9ByIz0TNJd0x2bN5rJxUsfiy3bpouw==
X-Received: by 2002:a05:6512:2601:b0:4ca:f9e4:5cac with SMTP id bt1-20020a056512260100b004caf9e45cacmr17837865lfb.14.1673272169387;
        Mon, 09 Jan 2023 05:49:29 -0800 (PST)
Received: from [192.168.1.101] (abxi45.neoplus.adsl.tpnet.pl. [83.9.2.45])
        by smtp.gmail.com with ESMTPSA id c7-20020a056512324700b004b55da14ba8sm1615421lfr.291.2023.01.09.05.49.27
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 09 Jan 2023 05:49:28 -0800 (PST)
Message-ID: <d3c473e3-3553-0aa9-cbca-f65a11604fff@linaro.org>
Date:   Mon, 9 Jan 2023 14:49:27 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.6.1
Subject: Re: [PATCH v3 12/12] arm64: dts: qcom: sm8250: drop the virtual
 ipa-virt device
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
 <20230109002935.244320-13-dmitry.baryshkov@linaro.org>
From:   Konrad Dybcio <konrad.dybcio@linaro.org>
In-Reply-To: <20230109002935.244320-13-dmitry.baryshkov@linaro.org>
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
> Drop the virtual ipa-virt device. The interconnects it provided are
> going to be represented as <&rpmhcc RPMH_IPA_CLK> clock.
> 
> Signed-off-by: Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
> ---
Reviewed-by: Konrad Dybcio <konrad.dybcio@linaro.org>

Konrad
>  arch/arm64/boot/dts/qcom/sm8250.dtsi | 7 -------
>  1 file changed, 7 deletions(-)
> 
> diff --git a/arch/arm64/boot/dts/qcom/sm8250.dtsi b/arch/arm64/boot/dts/qcom/sm8250.dtsi
> index b3ab2896a6cc..af298dec0568 100644
> --- a/arch/arm64/boot/dts/qcom/sm8250.dtsi
> +++ b/arch/arm64/boot/dts/qcom/sm8250.dtsi
> @@ -2215,13 +2215,6 @@ ufs_mem_phy_lanes: phy@1d87400 {
>  			};
>  		};
>  
> -		ipa_virt: interconnect@1e00000 {
> -			compatible = "qcom,sm8250-ipa-virt";
> -			reg = <0 0x01e00000 0 0x1000>;
> -			#interconnect-cells = <1>;
> -			qcom,bcm-voters = <&apps_bcm_voter>;
> -		};
> -
>  		tcsr_mutex: hwlock@1f40000 {
>  			compatible = "qcom,tcsr-mutex";
>  			reg = <0x0 0x01f40000 0x0 0x40000>;
