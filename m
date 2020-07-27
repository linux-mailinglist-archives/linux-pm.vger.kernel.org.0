Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 54D1922EA8B
	for <lists+linux-pm@lfdr.de>; Mon, 27 Jul 2020 12:58:39 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728394AbgG0K6i (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Mon, 27 Jul 2020 06:58:38 -0400
Received: from mail29.static.mailgun.info ([104.130.122.29]:27290 "EHLO
        mail29.static.mailgun.info" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1728393AbgG0K6i (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Mon, 27 Jul 2020 06:58:38 -0400
DKIM-Signature: a=rsa-sha256; v=1; c=relaxed/relaxed; d=mg.codeaurora.org; q=dns/txt;
 s=smtp; t=1595847517; h=Message-ID: References: In-Reply-To: Subject:
 Cc: To: From: Date: Content-Transfer-Encoding: Content-Type:
 MIME-Version: Sender; bh=DEfjH/2I4evPsMqfPSbH/iM41ACmWP5x0mOUhdXb52s=;
 b=Yvo33Kmc27/MaiunuWz2t3PGU84cnndOaD3vYQo50uKrIdUZ7XSp1nSPTpSfV23H1K241kGc
 bd14VO27GW/WBfhjL/2t4337kqO3HgsG3VWZyB0MjQiyhg8MFB+vVem1ET8nyLbVmmCSyd3x
 zHzBwSqiElJX6sMVsogQrQHCbVc=
X-Mailgun-Sending-Ip: 104.130.122.29
X-Mailgun-Sid: WyI5ZDFmMiIsICJsaW51eC1wbUB2Z2VyLmtlcm5lbC5vcmciLCAiYmU5ZTRhIl0=
Received: from smtp.codeaurora.org
 (ec2-35-166-182-171.us-west-2.compute.amazonaws.com [35.166.182.171]) by
 smtp-out-n03.prod.us-east-1.postgun.com with SMTP id
 5f1eb35da61bb9e3f58d35e1 (version=TLS1.2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256); Mon, 27 Jul 2020 10:58:37
 GMT
Received: by smtp.codeaurora.org (Postfix, from userid 1001)
        id 861D9C433CB; Mon, 27 Jul 2020 10:58:36 +0000 (UTC)
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
        aws-us-west-2-caf-mail-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=2.0 tests=ALL_TRUSTED
        autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.codeaurora.org (localhost.localdomain [127.0.0.1])
        (using TLSv1 with cipher ECDHE-RSA-AES256-SHA (256/256 bits))
        (No client certificate requested)
        (Authenticated sender: sibis)
        by smtp.codeaurora.org (Postfix) with ESMTPSA id 914D4C433C6;
        Mon, 27 Jul 2020 10:58:35 +0000 (UTC)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII;
 format=flowed
Content-Transfer-Encoding: 7bit
Date:   Mon, 27 Jul 2020 16:28:35 +0530
From:   Sibi Sankar <sibis@codeaurora.org>
To:     Georgi Djakov <georgi.djakov@linaro.org>
Cc:     linux-pm@vger.kernel.org, devicetree@vger.kernel.org,
        bjorn.andersson@linaro.org, robh+dt@kernel.org, mka@chromium.org,
        dianders@chromium.org, linux-kernel@vger.kernel.org,
        linux-kernel-owner@vger.kernel.org
Subject: Re: [PATCH 4/6] arm64: dts: qcom: sdm845: Increase the number of
 interconnect cells
In-Reply-To: <20200723130942.28491-5-georgi.djakov@linaro.org>
References: <20200723130942.28491-1-georgi.djakov@linaro.org>
 <20200723130942.28491-5-georgi.djakov@linaro.org>
Message-ID: <3c8c4aae7697d9d5a052b9dfd1ea0cf4@codeaurora.org>
X-Sender: sibis@codeaurora.org
User-Agent: Roundcube Webmail/1.3.9
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

On 2020-07-23 18:39, Georgi Djakov wrote:
> Increase the number of interconnect-cells, as now we can include
> the tag information. The consumers can specify the path tag as an
> additional argument to the endpoints.

Tested-by: Sibi Sankar <sibis@codeaurora.org>
Reviewed-by: Sibi Sankar <sibis@codeaurora.org>

https://patchwork.kernel.org/patch/11655409/
I'll replace the tag ids with the
macros once ^^ lands.

> 
> Signed-off-by: Georgi Djakov <georgi.djakov@linaro.org>
> ---
>  arch/arm64/boot/dts/qcom/sdm845.dtsi | 44 ++++++++++++++--------------
>  1 file changed, 22 insertions(+), 22 deletions(-)
> 
> diff --git a/arch/arm64/boot/dts/qcom/sdm845.dtsi
> b/arch/arm64/boot/dts/qcom/sdm845.dtsi
> index e506793407d8..94f5d27f2927 100644
> --- a/arch/arm64/boot/dts/qcom/sdm845.dtsi
> +++ b/arch/arm64/boot/dts/qcom/sdm845.dtsi
> @@ -200,7 +200,7 @@ &LITTLE_CPU_SLEEP_1
>  			dynamic-power-coefficient = <100>;
>  			qcom,freq-domain = <&cpufreq_hw 0>;
>  			operating-points-v2 = <&cpu0_opp_table>;
> -			interconnects = <&gladiator_noc MASTER_APPSS_PROC &mem_noc 
> SLAVE_EBI1>,
> +			interconnects = <&gladiator_noc MASTER_APPSS_PROC 3 &mem_noc 
> SLAVE_EBI1 3>,
>  					<&osm_l3 MASTER_OSM_L3_APPS &osm_l3 SLAVE_OSM_L3>;
>  			#cooling-cells = <2>;
>  			next-level-cache = <&L2_0>;
> @@ -225,7 +225,7 @@ &LITTLE_CPU_SLEEP_1
>  			dynamic-power-coefficient = <100>;
>  			qcom,freq-domain = <&cpufreq_hw 0>;
>  			operating-points-v2 = <&cpu0_opp_table>;
> -			interconnects = <&gladiator_noc MASTER_APPSS_PROC &mem_noc 
> SLAVE_EBI1>,
> +			interconnects = <&gladiator_noc MASTER_APPSS_PROC 3 &mem_noc 
> SLAVE_EBI1 3>,
>  					<&osm_l3 MASTER_OSM_L3_APPS &osm_l3 SLAVE_OSM_L3>;
>  			#cooling-cells = <2>;
>  			next-level-cache = <&L2_100>;
> @@ -247,7 +247,7 @@ &LITTLE_CPU_SLEEP_1
>  			dynamic-power-coefficient = <100>;
>  			qcom,freq-domain = <&cpufreq_hw 0>;
>  			operating-points-v2 = <&cpu0_opp_table>;
> -			interconnects = <&gladiator_noc MASTER_APPSS_PROC &mem_noc 
> SLAVE_EBI1>,
> +			interconnects = <&gladiator_noc MASTER_APPSS_PROC 3 &mem_noc 
> SLAVE_EBI1 3>,
>  					<&osm_l3 MASTER_OSM_L3_APPS &osm_l3 SLAVE_OSM_L3>;
>  			#cooling-cells = <2>;
>  			next-level-cache = <&L2_200>;
> @@ -269,7 +269,7 @@ &LITTLE_CPU_SLEEP_1
>  			dynamic-power-coefficient = <100>;
>  			qcom,freq-domain = <&cpufreq_hw 0>;
>  			operating-points-v2 = <&cpu0_opp_table>;
> -			interconnects = <&gladiator_noc MASTER_APPSS_PROC &mem_noc 
> SLAVE_EBI1>,
> +			interconnects = <&gladiator_noc MASTER_APPSS_PROC 3 &mem_noc 
> SLAVE_EBI1 3>,
>  					<&osm_l3 MASTER_OSM_L3_APPS &osm_l3 SLAVE_OSM_L3>;
>  			#cooling-cells = <2>;
>  			next-level-cache = <&L2_300>;
> @@ -291,7 +291,7 @@ &BIG_CPU_SLEEP_1
>  			dynamic-power-coefficient = <396>;
>  			qcom,freq-domain = <&cpufreq_hw 1>;
>  			operating-points-v2 = <&cpu4_opp_table>;
> -			interconnects = <&gladiator_noc MASTER_APPSS_PROC &mem_noc 
> SLAVE_EBI1>,
> +			interconnects = <&gladiator_noc MASTER_APPSS_PROC 3 &mem_noc 
> SLAVE_EBI1 3>,
>  					<&osm_l3 MASTER_OSM_L3_APPS &osm_l3 SLAVE_OSM_L3>;
>  			#cooling-cells = <2>;
>  			next-level-cache = <&L2_400>;
> @@ -313,7 +313,7 @@ &BIG_CPU_SLEEP_1
>  			dynamic-power-coefficient = <396>;
>  			qcom,freq-domain = <&cpufreq_hw 1>;
>  			operating-points-v2 = <&cpu4_opp_table>;
> -			interconnects = <&gladiator_noc MASTER_APPSS_PROC &mem_noc 
> SLAVE_EBI1>,
> +			interconnects = <&gladiator_noc MASTER_APPSS_PROC 3 &mem_noc 
> SLAVE_EBI1 3>,
>  					<&osm_l3 MASTER_OSM_L3_APPS &osm_l3 SLAVE_OSM_L3>;
>  			#cooling-cells = <2>;
>  			next-level-cache = <&L2_500>;
> @@ -335,7 +335,7 @@ &BIG_CPU_SLEEP_1
>  			dynamic-power-coefficient = <396>;
>  			qcom,freq-domain = <&cpufreq_hw 1>;
>  			operating-points-v2 = <&cpu4_opp_table>;
> -			interconnects = <&gladiator_noc MASTER_APPSS_PROC &mem_noc 
> SLAVE_EBI1>,
> +			interconnects = <&gladiator_noc MASTER_APPSS_PROC 3 &mem_noc 
> SLAVE_EBI1 3>,
>  					<&osm_l3 MASTER_OSM_L3_APPS &osm_l3 SLAVE_OSM_L3>;
>  			#cooling-cells = <2>;
>  			next-level-cache = <&L2_600>;
> @@ -357,7 +357,7 @@ &BIG_CPU_SLEEP_1
>  			dynamic-power-coefficient = <396>;
>  			qcom,freq-domain = <&cpufreq_hw 1>;
>  			operating-points-v2 = <&cpu4_opp_table>;
> -			interconnects = <&gladiator_noc MASTER_APPSS_PROC &mem_noc 
> SLAVE_EBI1>,
> +			interconnects = <&gladiator_noc MASTER_APPSS_PROC 3 &mem_noc 
> SLAVE_EBI1 3>,
>  					<&osm_l3 MASTER_OSM_L3_APPS &osm_l3 SLAVE_OSM_L3>;
>  			#cooling-cells = <2>;
>  			next-level-cache = <&L2_700>;
> @@ -2011,49 +2011,49 @@ pcie1_lane: lanes@1c06200 {
>  		mem_noc: interconnect@1380000 {
>  			compatible = "qcom,sdm845-mem-noc";
>  			reg = <0 0x01380000 0 0x27200>;
> -			#interconnect-cells = <1>;
> +			#interconnect-cells = <2>;
>  			qcom,bcm-voters = <&apps_bcm_voter>;
>  		};
> 
>  		dc_noc: interconnect@14e0000 {
>  			compatible = "qcom,sdm845-dc-noc";
>  			reg = <0 0x014e0000 0 0x400>;
> -			#interconnect-cells = <1>;
> +			#interconnect-cells = <2>;
>  			qcom,bcm-voters = <&apps_bcm_voter>;
>  		};
> 
>  		config_noc: interconnect@1500000 {
>  			compatible = "qcom,sdm845-config-noc";
>  			reg = <0 0x01500000 0 0x5080>;
> -			#interconnect-cells = <1>;
> +			#interconnect-cells = <2>;
>  			qcom,bcm-voters = <&apps_bcm_voter>;
>  		};
> 
>  		system_noc: interconnect@1620000 {
>  			compatible = "qcom,sdm845-system-noc";
>  			reg = <0 0x01620000 0 0x18080>;
> -			#interconnect-cells = <1>;
> +			#interconnect-cells = <2>;
>  			qcom,bcm-voters = <&apps_bcm_voter>;
>  		};
> 
>  		aggre1_noc: interconnect@16e0000 {
>  			compatible = "qcom,sdm845-aggre1-noc";
>  			reg = <0 0x016e0000 0 0x15080>;
> -			#interconnect-cells = <1>;
> +			#interconnect-cells = <2>;
>  			qcom,bcm-voters = <&apps_bcm_voter>;
>  		};
> 
>  		aggre2_noc: interconnect@1700000 {
>  			compatible = "qcom,sdm845-aggre2-noc";
>  			reg = <0 0x01700000 0 0x1f300>;
> -			#interconnect-cells = <1>;
> +			#interconnect-cells = <2>;
>  			qcom,bcm-voters = <&apps_bcm_voter>;
>  		};
> 
>  		mmss_noc: interconnect@1740000 {
>  			compatible = "qcom,sdm845-mmss-noc";
>  			reg = <0 0x01740000 0 0x1c100>;
> -			#interconnect-cells = <1>;
> +			#interconnect-cells = <2>;
>  			qcom,bcm-voters = <&apps_bcm_voter>;
>  		};
> 
> @@ -2156,8 +2156,8 @@ ipa: ipa@1e40000 {
>  			clocks = <&rpmhcc RPMH_IPA_CLK>;
>  			clock-names = "core";
> 
> -			interconnects = <&aggre2_noc MASTER_IPA &mem_noc SLAVE_EBI1>,
> -				        <&aggre2_noc MASTER_IPA &system_noc SLAVE_IMEM>,
> +			interconnects = <&aggre2_noc MASTER_IPA 0 &mem_noc SLAVE_EBI1 0>,
> +					<&aggre2_noc MASTER_IPA 0 &system_noc SLAVE_IMEM 0>,
>  					<&gladiator_noc MASTER_APPSS_PROC &config_noc SLAVE_IPA_CFG>;
>  			interconnect-names = "memory",
>  					     "imem",
> @@ -3561,8 +3561,8 @@ usb_1: usb@a6f8800 {
> 
>  			resets = <&gcc GCC_USB30_PRIM_BCR>;
> 
> -			interconnects = <&aggre2_noc MASTER_USB3_0 &mem_noc SLAVE_EBI1>,
> -					<&gladiator_noc MASTER_APPSS_PROC &config_noc SLAVE_USB3_0>;
> +			interconnects = <&aggre2_noc MASTER_USB3_0 0 &mem_noc SLAVE_EBI1 
> 0>,
> +					<&gladiator_noc MASTER_APPSS_PROC 0 &config_noc SLAVE_USB3_0 0>;
>  			interconnect-names = "usb-ddr", "apps-usb";
> 
>  			usb_1_dwc3: dwc3@a600000 {
> @@ -3609,8 +3609,8 @@ usb_2: usb@a8f8800 {
> 
>  			resets = <&gcc GCC_USB30_SEC_BCR>;
> 
> -			interconnects = <&aggre2_noc MASTER_USB3_1 &mem_noc SLAVE_EBI1>,
> -					<&gladiator_noc MASTER_APPSS_PROC &config_noc SLAVE_USB3_1>;
> +			interconnects = <&aggre2_noc MASTER_USB3_1 0 &mem_noc SLAVE_EBI1 
> 0>,
> +					<&gladiator_noc MASTER_APPSS_PROC 0 &config_noc SLAVE_USB3_1 0>;
>  			interconnect-names = "usb-ddr", "apps-usb";
> 
>  			usb_2_dwc3: dwc3@a800000 {
> @@ -4306,7 +4306,7 @@ lpasscc: clock-controller@17014000 {
>  		gladiator_noc: interconnect@17900000 {
>  			compatible = "qcom,sdm845-gladiator-noc";
>  			reg = <0 0x17900000 0 0xd080>;
> -			#interconnect-cells = <1>;
> +			#interconnect-cells = <2>;
>  			qcom,bcm-voters = <&apps_bcm_voter>;
>  		};

-- 
Qualcomm Innovation Center, Inc. is a member of Code Aurora Forum,
a Linux Foundation Collaborative Project.
