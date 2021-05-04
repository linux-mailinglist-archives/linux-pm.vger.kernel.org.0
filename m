Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4CD08372638
	for <lists+linux-pm@lfdr.de>; Tue,  4 May 2021 09:06:30 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229955AbhEDHHW (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Tue, 4 May 2021 03:07:22 -0400
Received: from so254-9.mailgun.net ([198.61.254.9]:40302 "EHLO
        so254-9.mailgun.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229999AbhEDHHO (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Tue, 4 May 2021 03:07:14 -0400
DKIM-Signature: a=rsa-sha256; v=1; c=relaxed/relaxed; d=mg.codeaurora.org; q=dns/txt;
 s=smtp; t=1620111980; h=Message-ID: References: In-Reply-To: Subject:
 Cc: To: From: Date: Content-Transfer-Encoding: Content-Type:
 MIME-Version: Sender; bh=4rqQzuKlbS7jS2KVzQAJON90zfpeBcgTQ6ug7QuN1oc=;
 b=KVyy1WBYnfWsboxjVmLmua9EGliLDBHFHeqpCoHhYQ0aBqQMkwE4cwx0GDq3JBBpW0YUNG+C
 iXhi5GkFMq/u8ifgB5d6/nt/GCZmIVmZkMGccO36rMvAdKnDR7EH/DSaHXWlJY5QdQ1WqUrk
 DlY/ZDu9XZgmFiwhsewZXWcquDg=
X-Mailgun-Sending-Ip: 198.61.254.9
X-Mailgun-Sid: WyI5ZDFmMiIsICJsaW51eC1wbUB2Z2VyLmtlcm5lbC5vcmciLCAiYmU5ZTRhIl0=
Received: from smtp.codeaurora.org
 (ec2-35-166-182-171.us-west-2.compute.amazonaws.com [35.166.182.171]) by
 smtp-out-n06.prod.us-east-1.postgun.com with SMTP id
 6090f2588166b7eff769371d (version=TLS1.2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256); Tue, 04 May 2021 07:06:00
 GMT
Sender: sibis=codeaurora.org@mg.codeaurora.org
Received: by smtp.codeaurora.org (Postfix, from userid 1001)
        id 11171C43144; Tue,  4 May 2021 07:06:00 +0000 (UTC)
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
        aws-us-west-2-caf-mail-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.9 required=2.0 tests=ALL_TRUSTED,BAYES_00
        autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.codeaurora.org (localhost.localdomain [127.0.0.1])
        (using TLSv1 with cipher ECDHE-RSA-AES256-SHA (256/256 bits))
        (No client certificate requested)
        (Authenticated sender: sibis)
        by smtp.codeaurora.org (Postfix) with ESMTPSA id 7D864C433D3;
        Tue,  4 May 2021 07:05:58 +0000 (UTC)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII;
 format=flowed
Content-Transfer-Encoding: 7bit
Date:   Tue, 04 May 2021 12:35:58 +0530
From:   Sibi Sankar <sibis@codeaurora.org>
To:     Matthias Kaehlcke <mka@chromium.org>
Cc:     bjorn.andersson@linaro.org, viresh.kumar@linaro.org,
        swboyd@chromium.org, agross@kernel.org, robh+dt@kernel.org,
        rjw@rjwysocki.net, linux-arm-msm@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-pm@vger.kernel.org, dianders@chromium.org
Subject: Re: [PATCH 2/2] arm64: dts: qcom: sc7280: Add cpu OPP tables
In-Reply-To: <YJAmdIHYl0DKsKyq@google.com>
References: <1619792901-32701-1-git-send-email-sibis@codeaurora.org>
 <1619792901-32701-3-git-send-email-sibis@codeaurora.org>
 <YJAmdIHYl0DKsKyq@google.com>
Message-ID: <df0e6ff1e7ebba710228cfe568e64bbb@codeaurora.org>
X-Sender: sibis@codeaurora.org
User-Agent: Roundcube Webmail/1.3.9
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

On 2021-05-03 22:06, Matthias Kaehlcke wrote:
> On Fri, Apr 30, 2021 at 07:58:21PM +0530, Sibi Sankar wrote:
>> Add OPP tables required to scale DDR/L3 per freq-domain on SC7280 
>> SoCs.
>> 
>> Signed-off-by: Sibi Sankar <sibis@codeaurora.org>
>> ---
>>  arch/arm64/boot/dts/qcom/sc7280.dtsi | 135 
>> +++++++++++++++++++++++++++++++++++
>>  1 file changed, 135 insertions(+)
>> 
>> diff --git a/arch/arm64/boot/dts/qcom/sc7280.dtsi 
>> b/arch/arm64/boot/dts/qcom/sc7280.dtsi
>> index 0bb835aeae33..90220cecb368 100644
>> --- a/arch/arm64/boot/dts/qcom/sc7280.dtsi
>> +++ b/arch/arm64/boot/dts/qcom/sc7280.dtsi
>> @@ -7,6 +7,7 @@
>> 
>>  #include <dt-bindings/clock/qcom,gcc-sc7280.h>
>>  #include <dt-bindings/clock/qcom,rpmh.h>
>> +#include <dt-bindings/interconnect/qcom,osm-l3.h>
>>  #include <dt-bindings/interconnect/qcom,sc7280.h>
>>  #include <dt-bindings/interrupt-controller/arm-gic.h>
>>  #include <dt-bindings/mailbox/qcom-ipcc.h>
>> @@ -71,6 +72,9 @@
>>  					   &LITTLE_CPU_SLEEP_1
>>  					   &CLUSTER_SLEEP_0>;
>>  			next-level-cache = <&L2_0>;
>> +			operating-points-v2 = <&cpu0_opp_table>;
>> +			interconnects = <&gem_noc MASTER_APPSS_PROC 3 &mc_virt SLAVE_EBI1 
>> 3>,
>> +					<&epss_l3 MASTER_EPSS_L3_APPS &epss_l3 SLAVE_EPSS_L3_SHARED>;
> 
> This patch seems to depend on the 'Add SC7280 interconnect provider
> driver' series
> (https://patchwork.kernel.org/project/linux-arm-msm/list/?series=473747)
> and 'Add L3 provider support for SC7280'
> (https://patchwork.kernel.org/project/linux-arm-msm/list/?series=468285),
> none of them has landed yet. The dependencies should be mentioned in 
> the
> commit notes (under '---').

Had all the dependencies listed in the cover
letter. I'll make sure I put them ^^ as well
in v3.

> 
>>  			qcom,freq-domain = <&cpufreq_hw 0>;
>>  			L2_0: l2-cache {
>>  				compatible = "cache";
>> @@ -90,6 +94,9 @@
>>  					   &LITTLE_CPU_SLEEP_1
>>  					   &CLUSTER_SLEEP_0>;
>>  			next-level-cache = <&L2_100>;
>> +			operating-points-v2 = <&cpu0_opp_table>;
>> +			interconnects = <&gem_noc MASTER_APPSS_PROC 3 &mc_virt SLAVE_EBI1 
>> 3>,
>> +					<&epss_l3 MASTER_EPSS_L3_APPS &epss_l3 SLAVE_EPSS_L3_SHARED>;
>>  			qcom,freq-domain = <&cpufreq_hw 0>;
>>  			L2_100: l2-cache {
>>  				compatible = "cache";
>> @@ -106,6 +113,9 @@
>>  					   &LITTLE_CPU_SLEEP_1
>>  					   &CLUSTER_SLEEP_0>;
>>  			next-level-cache = <&L2_200>;
>> +			operating-points-v2 = <&cpu0_opp_table>;
>> +			interconnects = <&gem_noc MASTER_APPSS_PROC 3 &mc_virt SLAVE_EBI1 
>> 3>,
>> +					<&epss_l3 MASTER_EPSS_L3_APPS &epss_l3 SLAVE_EPSS_L3_SHARED>;
>>  			qcom,freq-domain = <&cpufreq_hw 0>;
>>  			L2_200: l2-cache {
>>  				compatible = "cache";
>> @@ -122,6 +132,9 @@
>>  					   &LITTLE_CPU_SLEEP_1
>>  					   &CLUSTER_SLEEP_0>;
>>  			next-level-cache = <&L2_300>;
>> +			operating-points-v2 = <&cpu0_opp_table>;
>> +			interconnects = <&gem_noc MASTER_APPSS_PROC 3 &mc_virt SLAVE_EBI1 
>> 3>,
>> +					<&epss_l3 MASTER_EPSS_L3_APPS &epss_l3 SLAVE_EPSS_L3_SHARED>;
>>  			qcom,freq-domain = <&cpufreq_hw 0>;
>>  			L2_300: l2-cache {
>>  				compatible = "cache";
>> @@ -138,6 +151,9 @@
>>  					   &BIG_CPU_SLEEP_1
>>  					   &CLUSTER_SLEEP_0>;
>>  			next-level-cache = <&L2_400>;
>> +			operating-points-v2 = <&cpu4_opp_table>;
>> +			interconnects = <&gem_noc MASTER_APPSS_PROC 3 &mc_virt SLAVE_EBI1 
>> 3>,
>> +					<&epss_l3 MASTER_EPSS_L3_APPS &epss_l3 SLAVE_EPSS_L3_SHARED>;
>>  			qcom,freq-domain = <&cpufreq_hw 1>;
>>  			L2_400: l2-cache {
>>  				compatible = "cache";
>> @@ -154,6 +170,9 @@
>>  					   &BIG_CPU_SLEEP_1
>>  					   &CLUSTER_SLEEP_0>;
>>  			next-level-cache = <&L2_500>;
>> +			operating-points-v2 = <&cpu4_opp_table>;
>> +			interconnects = <&gem_noc MASTER_APPSS_PROC 3 &mc_virt SLAVE_EBI1 
>> 3>,
>> +					<&epss_l3 MASTER_EPSS_L3_APPS &epss_l3 SLAVE_EPSS_L3_SHARED>;
>>  			qcom,freq-domain = <&cpufreq_hw 1>;
>>  			L2_500: l2-cache {
>>  				compatible = "cache";
>> @@ -170,6 +189,9 @@
>>  					   &BIG_CPU_SLEEP_1
>>  					   &CLUSTER_SLEEP_0>;
>>  			next-level-cache = <&L2_600>;
>> +			operating-points-v2 = <&cpu4_opp_table>;
>> +			interconnects = <&gem_noc MASTER_APPSS_PROC 3 &mc_virt SLAVE_EBI1 
>> 3>,
>> +					<&epss_l3 MASTER_EPSS_L3_APPS &epss_l3 SLAVE_EPSS_L3_SHARED>;
>>  			qcom,freq-domain = <&cpufreq_hw 1>;
>>  			L2_600: l2-cache {
>>  				compatible = "cache";
>> @@ -186,6 +208,9 @@
>>  					   &BIG_CPU_SLEEP_1
>>  					   &CLUSTER_SLEEP_0>;
>>  			next-level-cache = <&L2_700>;
>> +			operating-points-v2 = <&cpu4_opp_table>;
>> +			interconnects = <&gem_noc MASTER_APPSS_PROC 3 &mc_virt SLAVE_EBI1 
>> 3>,
>> +					<&epss_l3 MASTER_EPSS_L3_APPS &epss_l3 SLAVE_EPSS_L3_SHARED>;
>>  			qcom,freq-domain = <&cpufreq_hw 2>;
>>  			L2_700: l2-cache {
>>  				compatible = "cache";
>> @@ -248,6 +273,116 @@
>>  		};
>>  	};
>> 
>> +	cpu0_opp_table: cpu0_opp_table {
> 
> the node name should use dashes as separators instead of underscores, 
> i.e.
> it should be 'cpu0-opp-table'.

will fix it in v3.

> 
>> +		compatible = "operating-points-v2";
>> +		opp-shared;
>> +
>> +		cpu0_opp1: opp-300000000 {
>> +			opp-hz = /bits/ 64 <300000000>;
>> +			opp-peak-kBps = <800000 9600000>;
>> +		};
>> +
>> +		cpu0_opp2: opp-691200000 {
>> +			opp-hz = /bits/ 64 <691200000>;
>> +			opp-peak-kBps = <800000 17817600>;
>> +		};
>> +
>> +		cpu0_opp3: opp-806400000 {
>> +			opp-hz = /bits/ 64 <806400000>;
>> +			opp-peak-kBps = <800000 20889600>;
>> +		};
>> +
>> +		cpu0_opp4: opp-940800000 {
>> +			opp-hz = /bits/ 64 <940800000>;
>> +			opp-peak-kBps = <1804000 24576000>;
>> +		};
>> +
>> +		cpu0_opp5: opp-1152000000 {
>> +			opp-hz = /bits/ 64 <1152000000>;
>> +			opp-peak-kBps = <2188000 27033600>;
>> +		};
>> +
>> +		cpu0_opp6: opp-1324800000 {
>> +			opp-hz = /bits/ 64 <1324800000>;
>> +			opp-peak-kBps = <2188000 33792000>;
>> +		};
>> +
>> +		cpu0_opp7: opp-1516800000 {
>> +			opp-hz = /bits/ 64 <1516800000>;
>> +			opp-peak-kBps = <3072000 38092800>;
>> +		};
>> +
>> +		cpu0_opp8: opp-1651200000 {
>> +			opp-hz = /bits/ 64 <1651200000>;
>> +			opp-peak-kBps = <3072000 41779200>;
>> +		};
>> +
>> +		cpu0_opp9: opp-1804800000 {
>> +			opp-hz = /bits/ 64 <1804800000>;
>> +			opp-peak-kBps = <4068000 48537600>;
>> +		};
>> +
>> +		cpu0_opp10: opp-1958400000 {
>> +			opp-hz = /bits/ 64 <1958400000>;
>> +			opp-peak-kBps = <4068000 48537600>;
>> +		};
>> +	};
>> +
>> +	cpu4_opp_table: cpu4_opp_table {
> 
> node name should be 'cpu4-opp-table'

will fix it in v3.

> 
>> +		compatible = "operating-points-v2";
>> +		opp-shared;
>> +
>> +		cpu4_opp1: opp-691200000 {
>> +			opp-hz = /bits/ 64 <691200000>;
>> +			opp-peak-kBps = <1804000 9600000>;
>> +		};
>> +
>> +		cpu4_opp2: opp-940800000 {
>> +			opp-hz = /bits/ 64 <940800000>;
>> +			opp-peak-kBps = <2188000 17817600>;
>> +		};
>> +
>> +		cpu4_opp3: opp-1228800000 {
>> +			opp-hz = /bits/ 64 <1228800000>;
>> +			opp-peak-kBps = <4068000 24576000>;
>> +		};
>> +
>> +		cpu4_opp4: opp-1344000000 {
>> +			opp-hz = /bits/ 64 <1344000000>;
>> +			opp-peak-kBps = <4068000 24576000>;
>> +		};
>> +
>> +		cpu4_opp5: opp-1516800000 {
>> +			opp-hz = /bits/ 64 <1516800000>;
>> +			opp-peak-kBps = <4068000 24576000>;
>> +		};
>> +
>> +		cpu4_opp6: opp-1651200000 {
>> +			opp-hz = /bits/ 64 <1651200000>;
>> +			opp-peak-kBps = <6220000 38092800>;
>> +		};
>> +
>> +		cpu4_opp7: opp-1900800000 {
>> +			opp-hz = /bits/ 64 <1900800000>;
>> +			opp-peak-kBps = <6220000 44851200>;
>> +		};
>> +
>> +		cpu4_opp8: opp-2054400000 {
>> +			opp-hz = /bits/ 64 <2054400000>;
>> +			opp-peak-kBps = <6220000 44851200>;
>> +		};
>> +
>> +		cpu4_opp9: opp-2131200000 {
>> +			opp-hz = /bits/ 64 <2131200000>;
>> +			opp-peak-kBps = <6220000 44851200>;
>> +		};
>> +
>> +		cpu4_opp10: opp-2400000000 {
>> +			opp-hz = /bits/ 64 <2400000000>;
>> +			opp-peak-kBps = <6832000 48537600>;
>> +		};
>> +	};
>> +
>>  	memory@80000000 {
>>  		device_type = "memory";
>>  		/* We expect the bootloader to fill in the size */

-- 
Qualcomm Innovation Center, Inc. is a member of Code Aurora Forum,
a Linux Foundation Collaborative Project.
