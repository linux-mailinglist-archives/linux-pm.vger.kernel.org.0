Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E51E17548A9
	for <lists+linux-pm@lfdr.de>; Sat, 15 Jul 2023 15:14:07 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229556AbjGONOF (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Sat, 15 Jul 2023 09:14:05 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58170 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229502AbjGONOE (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Sat, 15 Jul 2023 09:14:04 -0400
Received: from mail-lf1-x136.google.com (mail-lf1-x136.google.com [IPv6:2a00:1450:4864:20::136])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5AF883A82
        for <linux-pm@vger.kernel.org>; Sat, 15 Jul 2023 06:14:03 -0700 (PDT)
Received: by mail-lf1-x136.google.com with SMTP id 2adb3069b0e04-4fb7373dd35so5065589e87.1
        for <linux-pm@vger.kernel.org>; Sat, 15 Jul 2023 06:14:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1689426841; x=1692018841;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=c8Lfn6m1P3lcdVv785E45YjZVMLrVtniMJnb2v/0JSQ=;
        b=THxg3f00Hk67RaJOUC3EHWR3IN8pfaLrdkSM85hpLyjqMpr8ppYXGW2srpwiVPr2Tz
         ptObyKSn4OkkLq2Q546+gk5T/d7efo7NHF23xF3a4O+Jq2pplGok1APpKZRd+ukORwXD
         rEuC9hljMFFF0r+cg/zFACViR83JVvENC2gf/9PII8a8EcdiqP4Ot18qgrxucTRA+xDG
         sizi68cJAgYRBsIQrAONg7jUX/MCULCmVDFhZ3rDpsG/GopW3tiiM6RF+IK1TVGuoXzN
         0/Bj9mIIHJ3TmlBftZSCxmXl9bs/h/50fJWgsTc+q7OIYrZzcZ0e2rH9yhYcCxHC/rCw
         WcMg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1689426841; x=1692018841;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=c8Lfn6m1P3lcdVv785E45YjZVMLrVtniMJnb2v/0JSQ=;
        b=bWTmVAy3MNlrTbF8T1yJXepG/8PYYLa30vwmGBNHHf0Zk43Pznn09KEGRu7ipw/dem
         R6OwguyA4Avm3+WpPJmVRE0NSMKPRTVMcRjOTS1Iq2GyZ8Y+m51K2+YRZ3TVSnxCbFk+
         IEgaJQyybGPkgnogrGTHclnesQCsw69xhjdoak1X0G2yxPmuEZV7zc/LfQxAfiYJ/w7U
         VGTdw06PSUsRoMgEcWQjEB7Ystrr0+3WG2+InAMevN2cY5WlB65We8t2wSreFl87GSwL
         YuCstQvLZ/axXN2UkLQi1g8oLnoeH/SjOG36mmLrrVDD8HCCr9Tos+cU90rF6ILhmJ4e
         VBeQ==
X-Gm-Message-State: ABy/qLaJ+2nUAZ3H+r+jREQBbA+OEx8t/CXfQJC7aB8mJNvIXQVL98It
        KTTnHWoxOLkUiMHeSlImuVfBHcoE0yTyiq1Tyg8fMw==
X-Google-Smtp-Source: APBJJlHDfniIN/y9SnGR1OrsBIsEH/CEfwKgZDRIMNiDPOE52AKJNPK3YW6hvUQKzPLfxx5O8TJXbg==
X-Received: by 2002:a05:6512:118d:b0:4fb:8aca:6bb4 with SMTP id g13-20020a056512118d00b004fb8aca6bb4mr1871266lfr.20.1689426841580;
        Sat, 15 Jul 2023 06:14:01 -0700 (PDT)
Received: from [192.168.1.101] (abxi167.neoplus.adsl.tpnet.pl. [83.9.2.167])
        by smtp.gmail.com with ESMTPSA id f22-20020ac251b6000000b004fad16596fasm1896997lfk.21.2023.07.15.06.13.59
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sat, 15 Jul 2023 06:14:00 -0700 (PDT)
Message-ID: <3941aa86-3cd2-09a4-67fd-d95a78f8b8e8@linaro.org>
Date:   Sat, 15 Jul 2023 15:13:58 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.13.0
Subject: Re: [PATCH 12/13] arm64: dts: qcom: sm8250: Add interconnect paths to
 UFSHC
Content-Language: en-US
To:     Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>,
        vireshk@kernel.org, nm@ti.com, sboyd@kernel.org,
        myungjoo.ham@samsung.com, kyungmin.park@samsung.com,
        cw00.choi@samsung.com, andersson@kernel.org, robh+dt@kernel.org,
        krzysztof.kozlowski+dt@linaro.org, conor+dt@kernel.org
Cc:     linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-arm-msm@vger.kernel.org, devicetree@vger.kernel.org,
        quic_asutoshd@quicinc.com, quic_cang@quicinc.com,
        quic_nitirawa@quicinc.com, quic_narepall@quicinc.com,
        quic_bhaskarv@quicinc.com, quic_richardp@quicinc.com,
        quic_nguyenb@quicinc.com, quic_ziqichen@quicinc.com,
        bmasney@redhat.com, krzysztof.kozlowski@linaro.org
References: <20230712103213.101770-1-manivannan.sadhasivam@linaro.org>
 <20230712103213.101770-16-manivannan.sadhasivam@linaro.org>
From:   Konrad Dybcio <konrad.dybcio@linaro.org>
In-Reply-To: <20230712103213.101770-16-manivannan.sadhasivam@linaro.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.2 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,
        URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

On 12.07.2023 12:32, Manivannan Sadhasivam wrote:
> UFS host controller requires interconnect path configuration for proper
> working. So let's specify them for SM8250 SoC.
> 
> Signed-off-by: Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
> ---
Reviewed-by: Konrad Dybcio <konrad.dybcio@linaro.org>

Konrad
>  arch/arm64/boot/dts/qcom/sm8250.dtsi | 4 ++++
>  1 file changed, 4 insertions(+)
> 
> diff --git a/arch/arm64/boot/dts/qcom/sm8250.dtsi b/arch/arm64/boot/dts/qcom/sm8250.dtsi
> index 72fd66db9c51..7a495ff7512f 100644
> --- a/arch/arm64/boot/dts/qcom/sm8250.dtsi
> +++ b/arch/arm64/boot/dts/qcom/sm8250.dtsi
> @@ -2197,6 +2197,10 @@ ufs_mem_hc: ufshc@1d84000 {
>  
>  			operating-points-v2 = <&ufs_opp_table>;
>  
> +			interconnects = <&aggre1_noc MASTER_UFS_MEM 0 &mc_virt SLAVE_EBI_CH0 0>,
> +					<&gem_noc MASTER_AMPSS_M0 0 &config_noc SLAVE_UFS_MEM_CFG 0>;
> +			interconnect-names = "ufs-ddr", "cpu-ufs";
> +
>  			status = "disabled";
>  
>  			ufs_opp_table: opp-table {
