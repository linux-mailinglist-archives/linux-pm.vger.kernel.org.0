Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6BB087548AE
	for <lists+linux-pm@lfdr.de>; Sat, 15 Jul 2023 15:14:19 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230111AbjGONOR (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Sat, 15 Jul 2023 09:14:17 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58342 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230087AbjGONOQ (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Sat, 15 Jul 2023 09:14:16 -0400
Received: from mail-lj1-x22a.google.com (mail-lj1-x22a.google.com [IPv6:2a00:1450:4864:20::22a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 04BC73A95
        for <linux-pm@vger.kernel.org>; Sat, 15 Jul 2023 06:14:13 -0700 (PDT)
Received: by mail-lj1-x22a.google.com with SMTP id 38308e7fff4ca-2b701e1c80fso42326601fa.2
        for <linux-pm@vger.kernel.org>; Sat, 15 Jul 2023 06:14:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1689426852; x=1692018852;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=Tg/kxjtEKsklndIMTQKwhL8po68Qbh2CBR2ANbISunw=;
        b=Xtw9eOk/a2D2AZe+3PCnyqyoy01a4749K8Es+HM2Al9kZ8I47Nt3f1Oq25QxVWPzLm
         1/dXpe3WlUGeG7PxwvPY0JdW2FrHSD0jpzInko9N2TYYhsyOTeCTJysnflRqLSlln2YU
         NSYfjSJ09lHQu3PAmpO6zm/KABGECpUwaTC8v2zwCnewWdjozvvwEK0pgeEwBovJ3SnR
         6CdtX6uXSYuHdO5mrd5kv+FyI3qYL+wuhYi/7QpDXrr/bXnpqByPTMZwUZglEAXz+orD
         8aCavdByOhrdCAIl2lUb/bt0kBh6pFoJ2afUYuvUI9eXN48+xIT6x1lLC6jbesKbdrWv
         ySTQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1689426852; x=1692018852;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=Tg/kxjtEKsklndIMTQKwhL8po68Qbh2CBR2ANbISunw=;
        b=LIJHxAG80vJ020at6x5klZdYPb0SOpF/Z4+qynIN/zZOIbVOdOAVNSMJybeeikHDSI
         Fwhlp4LlZK4iendHrdUOZz5O0iZtSRcldxuP3+HAlAq7zUAI2H9ypIFsLX6wBpH8NioA
         aGxdPKTraH1XpoTqwfCLUhy7Y+YyJ7uZhY9w/xTQCEjjlbmSjMUqjFDriTP+BNBlNPsq
         ewJlCH5KDq2QxG9ArckeoKu6frEGWvtnVsNPmY8Sj4n9+fMILO++vsN2VAd+qYFzuSFi
         DFA8xr9iuy3hMZ9P8z1xc5rg479Pz/s70K2bBQa32gbcDP64wce666mVmk2Vx6kZt4Gl
         Mx7A==
X-Gm-Message-State: ABy/qLbvNbI6BEM+Yp2s56lMsFBBxRcWTYNIZGA2teB1iXLrbeWrGgX+
        sNsRkwWPEiBeOznNmPUNjN9SIw==
X-Google-Smtp-Source: APBJJlE13xkTQ0+Q17FSGo9vnxlbQn1ZypNTFPDTBzLNw6jrAUV9TgHkHfiO/IDq+yB78alBoFlaHA==
X-Received: by 2002:a2e:b056:0:b0:2b6:e623:7b57 with SMTP id d22-20020a2eb056000000b002b6e6237b57mr5553594ljl.25.1689426852258;
        Sat, 15 Jul 2023 06:14:12 -0700 (PDT)
Received: from [192.168.1.101] (abxi167.neoplus.adsl.tpnet.pl. [83.9.2.167])
        by smtp.gmail.com with ESMTPSA id k10-20020a2e888a000000b002b839578e56sm923203lji.11.2023.07.15.06.14.10
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sat, 15 Jul 2023 06:14:11 -0700 (PDT)
Message-ID: <1d45d292-a645-7f63-32f6-a397567ea997@linaro.org>
Date:   Sat, 15 Jul 2023 15:14:09 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.13.0
Subject: Re: [PATCH 13/14] arm64: dts: qcom: sm8250: Add interconnect paths to
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
 <20230712103213.101770-17-manivannan.sadhasivam@linaro.org>
From:   Konrad Dybcio <konrad.dybcio@linaro.org>
In-Reply-To: <20230712103213.101770-17-manivannan.sadhasivam@linaro.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.2 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,
        URIBL_BLOCKED autolearn=unavailable autolearn_force=no version=3.4.6
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
Duplicate

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
