Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id BE8AB37FC32
	for <lists+linux-pm@lfdr.de>; Thu, 13 May 2021 19:14:21 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230196AbhEMRPa (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Thu, 13 May 2021 13:15:30 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52030 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229877AbhEMRPa (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Thu, 13 May 2021 13:15:30 -0400
Received: from mail-pg1-x52d.google.com (mail-pg1-x52d.google.com [IPv6:2607:f8b0:4864:20::52d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1D306C06174A
        for <linux-pm@vger.kernel.org>; Thu, 13 May 2021 10:14:19 -0700 (PDT)
Received: by mail-pg1-x52d.google.com with SMTP id t30so729752pgl.8
        for <linux-pm@vger.kernel.org>; Thu, 13 May 2021 10:14:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=kSs+1tBj3VUYIMuFlEEx58LmywfW1aed7E8E2k9YJrU=;
        b=Qb4KCDH67UjllIopYlb1nqkuOcpV8gfLoK/X/8+ToEConK64B5kY9kueyUreIOSwn8
         TZqzo+n/lUBLNtRO/LsEjSPUhLS9YVa+eZqf0EdSv4nhHBWsysq5QR+C4c+Eh0Fy5Ywi
         QgD92NU5Rzg7PabDrwSovVVYENDtF3/w2zmj8=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=kSs+1tBj3VUYIMuFlEEx58LmywfW1aed7E8E2k9YJrU=;
        b=qYQ3VDaD1SMSX3sg/mBfKe7morS4OBKrN6/1n+WqqVKtucu2Jpt/Yzaz8nbSyu2Uqc
         MWPIpJkArBjS2S5UBMqO3/KXDngxnbXVm7yBivICSYxIJFoXgyQp9HYwjcEzo9q4KT2q
         tRqcN+9ZPKle2PcmjtDpUa4SkkL8oPL/uyEMRUvsgMOHbJvmDH/IMPbw6A+kaHbAliDf
         t6L3j/YWwOpwlZSIHK2HsWav7VrKoRmloVasAXcYMXJtwRXFd6asLtSZ4fcIzmgYykZm
         XCWWBktx0SQuki5yGc/y/ZHrHFr507jCxMmTHI9pNPQQycqhiyuXwzwlFM7MdkVh4qqi
         iZMg==
X-Gm-Message-State: AOAM532NxK1PUF6/hc1ZnKQ9UNi8GKDCIShk+RVd8cfPwa9XAe89wAnv
        rjjgjYEJV+DAMTqp36B8g+0ajw==
X-Google-Smtp-Source: ABdhPJxlZ9XLksNeF3rW1kBEnzOLBwWdzU5gFedyz4E7+6DbgjIgL+4tmb8BSdVm/frRfGe97vMuKQ==
X-Received: by 2002:a63:fb05:: with SMTP id o5mr41545190pgh.316.1620926058610;
        Thu, 13 May 2021 10:14:18 -0700 (PDT)
Received: from localhost ([2620:15c:202:201:4c2:8d34:961f:de80])
        by smtp.gmail.com with UTF8SMTPSA id t192sm2355328pfc.56.2021.05.13.10.14.17
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 13 May 2021 10:14:17 -0700 (PDT)
Date:   Thu, 13 May 2021 10:14:16 -0700
From:   Matthias Kaehlcke <mka@chromium.org>
To:     Sibi Sankar <sibis@codeaurora.org>
Cc:     bjorn.andersson@linaro.org, dianders@chromium.org,
        viresh.kumar@linaro.org, sboyd@kernel.org, agross@kernel.org,
        robh+dt@kernel.org, rjw@rjwysocki.net,
        linux-arm-msm@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-pm@vger.kernel.org
Subject: Re: [PATCH v3 2/2] arm64: dts: qcom: sc7280: Add cpu OPP tables
Message-ID: <YJ1eaECY6VDN94dr@google.com>
References: <1620807083-5451-1-git-send-email-sibis@codeaurora.org>
 <1620807083-5451-3-git-send-email-sibis@codeaurora.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <1620807083-5451-3-git-send-email-sibis@codeaurora.org>
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

On Wed, May 12, 2021 at 01:41:23PM +0530, Sibi Sankar wrote:
> Add OPP tables required to scale DDR/L3 per freq-domain on SC7280 SoCs.
> 
> Reviewed-by: Douglas Anderson <dianders@chromium.org>
> Signed-off-by: Sibi Sankar <sibis@codeaurora.org>
> ---
> 
> V3:
>  * Rename cpu opp table nodes [Matthias]
>  * Rename opp phandles [Doug]
> 
> Depends on the following patch series:
> L3 Provider Support: https://lore.kernel.org/lkml/1618556290-28303-1-git-send-email-okukatla@codeaurora.org/
> CPUfreq Support: https://lore.kernel.org/lkml/1618020280-5470-2-git-send-email-tdas@codeaurora.org/
> RPMH Provider Support: https://lore.kernel.org/lkml/1619517059-12109-1-git-send-email-okukatla@codeaurora.org/
> 
> It also depends on L3 and cpufreq dt nodes from the ^^ series to not have
> overlapping memory regions.
> 
>  arch/arm64/boot/dts/qcom/sc7280.dtsi | 215 +++++++++++++++++++++++++++++++++++
>  1 file changed, 215 insertions(+)
> 
> diff --git a/arch/arm64/boot/dts/qcom/sc7280.dtsi b/arch/arm64/boot/dts/qcom/sc7280.dtsi
> index 0bb835aeae33..89ec11eb7fc0 100644
> --- a/arch/arm64/boot/dts/qcom/sc7280.dtsi
> +++ b/arch/arm64/boot/dts/qcom/sc7280.dtsi
> @@ -7,6 +7,7 @@
>  
>  #include <dt-bindings/clock/qcom,gcc-sc7280.h>
>  #include <dt-bindings/clock/qcom,rpmh.h>
> +#include <dt-bindings/interconnect/qcom,osm-l3.h>
>  #include <dt-bindings/interconnect/qcom,sc7280.h>
>  #include <dt-bindings/interrupt-controller/arm-gic.h>
>  #include <dt-bindings/mailbox/qcom-ipcc.h>
> @@ -71,6 +72,9 @@
>  					   &LITTLE_CPU_SLEEP_1
>  					   &CLUSTER_SLEEP_0>;
>  			next-level-cache = <&L2_0>;
> +			operating-points-v2 = <&cpu0_opp_table>;
> +			interconnects = <&gem_noc MASTER_APPSS_PROC 3 &mc_virt SLAVE_EBI1 3>,
> +					<&epss_l3 MASTER_EPSS_L3_APPS &epss_l3 SLAVE_EPSS_L3_SHARED>;
>  			qcom,freq-domain = <&cpufreq_hw 0>;
>  			L2_0: l2-cache {
>  				compatible = "cache";
> @@ -90,6 +94,9 @@
>  					   &LITTLE_CPU_SLEEP_1
>  					   &CLUSTER_SLEEP_0>;
>  			next-level-cache = <&L2_100>;
> +			operating-points-v2 = <&cpu0_opp_table>;
> +			interconnects = <&gem_noc MASTER_APPSS_PROC 3 &mc_virt SLAVE_EBI1 3>,
> +					<&epss_l3 MASTER_EPSS_L3_APPS &epss_l3 SLAVE_EPSS_L3_SHARED>;
>  			qcom,freq-domain = <&cpufreq_hw 0>;
>  			L2_100: l2-cache {
>  				compatible = "cache";
> @@ -106,6 +113,9 @@
>  					   &LITTLE_CPU_SLEEP_1
>  					   &CLUSTER_SLEEP_0>;
>  			next-level-cache = <&L2_200>;
> +			operating-points-v2 = <&cpu0_opp_table>;
> +			interconnects = <&gem_noc MASTER_APPSS_PROC 3 &mc_virt SLAVE_EBI1 3>,
> +					<&epss_l3 MASTER_EPSS_L3_APPS &epss_l3 SLAVE_EPSS_L3_SHARED>;
>  			qcom,freq-domain = <&cpufreq_hw 0>;
>  			L2_200: l2-cache {
>  				compatible = "cache";
> @@ -122,6 +132,9 @@
>  					   &LITTLE_CPU_SLEEP_1
>  					   &CLUSTER_SLEEP_0>;
>  			next-level-cache = <&L2_300>;
> +			operating-points-v2 = <&cpu0_opp_table>;
> +			interconnects = <&gem_noc MASTER_APPSS_PROC 3 &mc_virt SLAVE_EBI1 3>,
> +					<&epss_l3 MASTER_EPSS_L3_APPS &epss_l3 SLAVE_EPSS_L3_SHARED>;
>  			qcom,freq-domain = <&cpufreq_hw 0>;
>  			L2_300: l2-cache {
>  				compatible = "cache";
> @@ -138,6 +151,9 @@
>  					   &BIG_CPU_SLEEP_1
>  					   &CLUSTER_SLEEP_0>;
>  			next-level-cache = <&L2_400>;
> +			operating-points-v2 = <&cpu4_opp_table>;
> +			interconnects = <&gem_noc MASTER_APPSS_PROC 3 &mc_virt SLAVE_EBI1 3>,
> +					<&epss_l3 MASTER_EPSS_L3_APPS &epss_l3 SLAVE_EPSS_L3_SHARED>;
>  			qcom,freq-domain = <&cpufreq_hw 1>;
>  			L2_400: l2-cache {
>  				compatible = "cache";
> @@ -154,6 +170,9 @@
>  					   &BIG_CPU_SLEEP_1
>  					   &CLUSTER_SLEEP_0>;
>  			next-level-cache = <&L2_500>;
> +			operating-points-v2 = <&cpu4_opp_table>;
> +			interconnects = <&gem_noc MASTER_APPSS_PROC 3 &mc_virt SLAVE_EBI1 3>,
> +					<&epss_l3 MASTER_EPSS_L3_APPS &epss_l3 SLAVE_EPSS_L3_SHARED>;
>  			qcom,freq-domain = <&cpufreq_hw 1>;
>  			L2_500: l2-cache {
>  				compatible = "cache";
> @@ -170,6 +189,9 @@
>  					   &BIG_CPU_SLEEP_1
>  					   &CLUSTER_SLEEP_0>;
>  			next-level-cache = <&L2_600>;
> +			operating-points-v2 = <&cpu4_opp_table>;
> +			interconnects = <&gem_noc MASTER_APPSS_PROC 3 &mc_virt SLAVE_EBI1 3>,
> +					<&epss_l3 MASTER_EPSS_L3_APPS &epss_l3 SLAVE_EPSS_L3_SHARED>;
>  			qcom,freq-domain = <&cpufreq_hw 1>;
>  			L2_600: l2-cache {
>  				compatible = "cache";
> @@ -186,6 +208,9 @@
>  					   &BIG_CPU_SLEEP_1
>  					   &CLUSTER_SLEEP_0>;
>  			next-level-cache = <&L2_700>;
> +			operating-points-v2 = <&cpu7_opp_table>;
> +			interconnects = <&gem_noc MASTER_APPSS_PROC 3 &mc_virt SLAVE_EBI1 3>,
> +					<&epss_l3 MASTER_EPSS_L3_APPS &epss_l3 SLAVE_EPSS_L3_SHARED>;
>  			qcom,freq-domain = <&cpufreq_hw 2>;
>  			L2_700: l2-cache {
>  				compatible = "cache";
> @@ -248,6 +273,196 @@
>  		};
>  	};
>  
> +	cpu0_opp_table: cpu0-opp-table {
> +		compatible = "operating-points-v2";
> +		opp-shared;
> +
> +		cpu0_opp_300mhz: opp-300000000 {
> +			opp-hz = /bits/ 64 <300000000>;
> +			opp-peak-kBps = <800000 9600000>;
> +		};
> +
> +		cpu0_opp_691mhz: opp-691200000 {
> +			opp-hz = /bits/ 64 <691200000>;
> +			opp-peak-kBps = <800000 17817600>;
> +		};
> +
> +		cpu0_opp_806mhz: opp-806400000 {
> +			opp-hz = /bits/ 64 <806400000>;
> +			opp-peak-kBps = <800000 20889600>;
> +		};
> +
> +		cpu0_opp_940mhz: opp-940800000 {

nit: one could argue that rounded it's 941 MHz. Same for some other OPPs.

Not super-important though, so:

Reviewed-by: Matthias Kaehlcke <mka@chromium.org>
