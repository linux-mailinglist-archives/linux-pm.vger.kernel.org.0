Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B9C32651F5B
	for <lists+linux-pm@lfdr.de>; Tue, 20 Dec 2022 11:58:00 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233590AbiLTK56 (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Tue, 20 Dec 2022 05:57:58 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33828 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233587AbiLTK55 (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Tue, 20 Dec 2022 05:57:57 -0500
Received: from mail-lf1-x136.google.com (mail-lf1-x136.google.com [IPv6:2a00:1450:4864:20::136])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CE3EFBC3D
        for <linux-pm@vger.kernel.org>; Tue, 20 Dec 2022 02:57:55 -0800 (PST)
Received: by mail-lf1-x136.google.com with SMTP id f34so2807722lfv.10
        for <linux-pm@vger.kernel.org>; Tue, 20 Dec 2022 02:57:55 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=aDnb9BEb78Sw9ueFN+k+iEYK3Ju9Xb5eo9NuWoultAU=;
        b=xbU91zwKo+VD7aaL/6EB9HslZ70gQoqX9CCAy2CtkJxcwIptobDbFgqbfbEcy0DdLH
         WErCp+YMa8XbSget8F9JsxZ0O98vfQiRh3vtnLsSV4wa1Kt39WmhfDDVlD6glDG9kkmL
         e5DvqwdtNx/R/V+BKJN1OxkRKR02EEpk5f0YVDTfypDQVi8KEcY9wpKdmFXixcsVCFyg
         WTAn9f7mMaRc5xclMnCZkkVkoCrZGDcqOHe7lSCeXXCWFc57LZfWBukAflv4yf261HAN
         h4psbmz5LGoqTlkaC73XPZWj0VXj5pGFqo6ivavJWbCOMzvVXlU2gQOfjIHMW4FpYxO8
         CN4w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=aDnb9BEb78Sw9ueFN+k+iEYK3Ju9Xb5eo9NuWoultAU=;
        b=Qrf99fQ4ZYuvKYhAItV8887AX2lIfGswyZ8+jf/RK4hEUkgvt8aIB1XN/awT3MFYh1
         aYkFDVItgXFtQsOWayWWW/PtDKbBJJcd2Q5nRj1+zf8+9E5C+1XxoWp8xAkV0/xZo9pi
         n7Nl6t64FEyG9nqOj8YkD3hAkynfLp8t99RdZGHbqZb5k6ogxy/A3xQzhnOtsJn4RpST
         +ZMHIsjDv0KhYKJ74xpVY4m868qC++tz5dEJCRrdM4+fzH4oZb8zkF0iFWyCFfih+TmP
         rg7SfuK5U2B5XuoE6B5Sri5xcyDhBfHqku5xIVwEfiiataphe3p5U37wHJnw5UVQWbOo
         t2Fw==
X-Gm-Message-State: ANoB5pkl0JCDK8keug/AcNSW6sekFpUip5nqS7S9EL8UuUmkl7FHJzYY
        esXVBYWGJ8lhPdeQKGwECZjEkw==
X-Google-Smtp-Source: AA0mqf7gv6QofA9h2Lp7gBTUPYcabAUKpteb6Il/1mbVPtD3k/b3GjKlI2oWVASXtWLjlsaoyBdcGA==
X-Received: by 2002:ac2:5f6a:0:b0:4b5:61e8:8934 with SMTP id c10-20020ac25f6a000000b004b561e88934mr11009274lfc.64.1671533874218;
        Tue, 20 Dec 2022 02:57:54 -0800 (PST)
Received: from [192.168.1.101] (abxh212.neoplus.adsl.tpnet.pl. [83.9.1.212])
        by smtp.gmail.com with ESMTPSA id p2-20020ac24ec2000000b00499b27a329esm1416602lfr.300.2022.12.20.02.57.52
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 20 Dec 2022 02:57:53 -0800 (PST)
Message-ID: <9e2e936e-3da2-4d04-f21e-335830c11dfb@linaro.org>
Date:   Tue, 20 Dec 2022 11:57:52 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.6.0
Subject: Re: [PATCH v3 13/15] arm64: dts: qcom: qcs404: specify per-sensor
 calibration cells
Content-Language: en-US
To:     Dmitry Baryshkov <dmitry.baryshkov@linaro.org>,
        Andy Gross <agross@kernel.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Amit Kucheria <amitk@kernel.org>,
        Thara Gopinath <thara.gopinath@gmail.com>,
        "Rafael J. Wysocki" <rafael@kernel.org>,
        Daniel Lezcano <daniel.lezcano@linaro.org>,
        Zhang Rui <rui.zhang@intel.com>
Cc:     linux-arm-msm@vger.kernel.org, linux-pm@vger.kernel.org,
        devicetree@vger.kernel.org
References: <20221220024721.947147-1-dmitry.baryshkov@linaro.org>
 <20221220024721.947147-14-dmitry.baryshkov@linaro.org>
From:   Konrad Dybcio <konrad.dybcio@linaro.org>
In-Reply-To: <20221220024721.947147-14-dmitry.baryshkov@linaro.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-3.3 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org



On 20.12.2022 03:47, Dmitry Baryshkov wrote:
> Specify pre-parsed per-sensor calibration nvmem cells in the tsens
> device node rather than parsing the whole data blob in the driver.
> 
> Signed-off-by: Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
> ---
>  arch/arm64/boot/dts/qcom/qcs404.dtsi | 121 +++++++++++++++++++++++++--
>  1 file changed, 116 insertions(+), 5 deletions(-)
> 
> diff --git a/arch/arm64/boot/dts/qcom/qcs404.dtsi b/arch/arm64/boot/dts/qcom/qcs404.dtsi
> index a5324eecb50a..362764347006 100644
> --- a/arch/arm64/boot/dts/qcom/qcs404.dtsi
> +++ b/arch/arm64/boot/dts/qcom/qcs404.dtsi
> @@ -366,13 +366,102 @@ qfprom: qfprom@a4000 {
>  			reg = <0x000a4000 0x1000>;
>  			#address-cells = <1>;
>  			#size-cells = <1>;
> -			tsens_caldata: caldata@d0 {
> -				reg = <0x1f8 0x14>;
> -			};
>  			cpr_efuse_speedbin: speedbin@13c {
>  				reg = <0x13c 0x4>;
>  				bits = <2 3>;
>  			};
Oh wow, this list is even longer.. can you pinky-promise it's
correct? :P In any case, please add newlines between each
subnode and rename the nodes so that there aren't underscores
in the node names.

Konrad
> +			tsens_s0_p1: s0_p1@1f8 {
> +				reg = <0x1f8 0x1>;
> +				bits = <0 6>;
> +			};
> +			tsens_s0_p2: s0_p2@1f8 {
> +				reg = <0x1f8 0x2>;
> +				bits = <6 6>;
> +			};
> +			tsens_s1_p1: s1_p1@1f9 {
> +				reg = <0x1f9 0x2>;
> +				bits = <4 6>;
> +			};
> +			tsens_s1_p2: s1_p2@1fa {
> +				reg = <0x1fa 0x1>;
> +				bits = <2 6>;
> +			};
> +			tsens_s2_p1: s2_p1@1fb {
> +				reg = <0x1fb 0x1>;
> +				bits = <0 6>;
> +			};
> +			tsens_s2_p2: s2_p2@1fb {
> +				reg = <0x1fb 0x2>;
> +				bits = <6 6>;
> +			};
> +			tsens_s3_p1: s3_p1@1fc {
> +				reg = <0x1fc 0x2>;
> +				bits = <4 6>;
> +			};
> +			tsens_s3_p2: s3_p2@1fd {
> +				reg = <0x1fd 0x1>;
> +				bits = <2 6>;
> +			};
> +			tsens_s4_p1: s4_p1@1fe {
> +				reg = <0x1fe 0x1>;
> +				bits = <0 6>;
> +			};
> +			tsens_s4_p2: s4_p2@1fe {
> +				reg = <0x1fe 0x2>;
> +				bits = <6 6>;
> +			};
> +			tsens_s5_p1: s5_p1@200 {
> +				reg = <0x200 0x1>;
> +				bits = <0 6>;
> +			};
> +			tsens_s5_p2: s5_p2@200 {
> +				reg = <0x200 0x2>;
> +				bits = <6 6>;
> +			};
> +			tsens_s6_p1: s6_p1@201 {
> +				reg = <0x201 0x2>;
> +				bits = <4 6>;
> +			};
> +			tsens_s6_p2: s6_p2@202 {
> +				reg = <0x202 0x1>;
> +				bits = <2 6>;
> +			};
> +			tsens_s7_p1: s7_p1@203 {
> +				reg = <0x203 0x1>;
> +				bits = <0 6>;
> +			};
> +			tsens_s7_p2: s7_p2@203 {
> +				reg = <0x203 0x2>;
> +				bits = <6 6>;
> +			};
> +			tsens_s8_p1: s8_p1@204 {
> +				reg = <0x204 0x2>;
> +				bits = <4 6>;
> +			};
> +			tsens_s8_p2: s8_p2@205 {
> +				reg = <0x205 0x1>;
> +				bits = <2 6>;
> +			};
> +			tsens_s9_p1: s9_p1@206 {
> +				reg = <0x206 0x1>;
> +				bits = <0 6>;
> +			};
> +			tsens_s9_p2: s9_p2@206 {
> +				reg = <0x206 0x2>;
> +				bits = <6 6>;
> +			};
> +			tsens_mode: mode@208 {
> +				reg = <0x208 1>;
> +				bits = <0 3>;
> +			};
> +			tsens_base1: base1@208 {
> +				reg = <0x208 2>;
> +				bits = <3 8>;
> +			};
> +			tsens_base2: base2@208 {
> +				reg = <0x209 2>;
> +				bits = <3 8>;
> +			};
>  			cpr_efuse_quot_offset1: qoffset1@231 {
>  				reg = <0x231 0x4>;
>  				bits = <4 7>;
> @@ -447,8 +536,30 @@ tsens: thermal-sensor@4a9000 {
>  			compatible = "qcom,qcs404-tsens", "qcom,tsens-v1";
>  			reg = <0x004a9000 0x1000>, /* TM */
>  			      <0x004a8000 0x1000>; /* SROT */
> -			nvmem-cells = <&tsens_caldata>;
> -			nvmem-cell-names = "calib";
> +			nvmem-cells = <&tsens_mode>,
> +				      <&tsens_base1>, <&tsens_base2>,
> +				      <&tsens_s0_p1>, <&tsens_s0_p2>,
> +				      <&tsens_s1_p1>, <&tsens_s1_p2>,
> +				      <&tsens_s2_p1>, <&tsens_s2_p2>,
> +				      <&tsens_s3_p1>, <&tsens_s3_p2>,
> +				      <&tsens_s4_p1>, <&tsens_s4_p2>,
> +				      <&tsens_s5_p1>, <&tsens_s5_p2>,
> +				      <&tsens_s6_p1>, <&tsens_s6_p2>,
> +				      <&tsens_s7_p1>, <&tsens_s7_p2>,
> +				      <&tsens_s8_p1>, <&tsens_s8_p2>,
> +				      <&tsens_s9_p1>, <&tsens_s9_p2>;
> +			nvmem-cell-names = "mode",
> +					   "base1", "base2",
> +					   "s0_p1", "s0_p2",
> +					   "s1_p1", "s1_p2",
> +					   "s2_p1", "s2_p2",
> +					   "s3_p1", "s3_p2",
> +					   "s4_p1", "s4_p2",
> +					   "s5_p1", "s5_p2",
> +					   "s6_p1", "s6_p2",
> +					   "s7_p1", "s7_p2",
> +					   "s8_p1", "s8_p2",
> +					   "s9_p1", "s9_p2";
>  			#qcom,sensors = <10>;
>  			interrupts = <GIC_SPI 184 IRQ_TYPE_LEVEL_HIGH>;
>  			interrupt-names = "uplow";
