Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 0310A164343
	for <lists+linux-pm@lfdr.de>; Wed, 19 Feb 2020 12:23:22 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726856AbgBSLXK (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Wed, 19 Feb 2020 06:23:10 -0500
Received: from foss.arm.com ([217.140.110.172]:46812 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726484AbgBSLXJ (ORCPT <rfc822;linux-pm@vger.kernel.org>);
        Wed, 19 Feb 2020 06:23:09 -0500
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 12F8231B;
        Wed, 19 Feb 2020 03:23:09 -0800 (PST)
Received: from [10.37.12.28] (unknown [10.37.12.28])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 13CF43F6CF;
        Wed, 19 Feb 2020 03:23:05 -0800 (PST)
Subject: Re: [PATCH 1/2] ARM: dts: exynos: Add dynamic-power-coefficient to
 Exynos5422 CPUs
To:     kgene@kernel.org, krzk@kernel.org,
        linux-arm-kernel@lists.infradead.org,
        linux-samsung-soc@vger.kernel.org, linux-kernel@vger.kernel.org,
        devicetree@vger.kernel.org, linux-pm@vger.kernel.org
Cc:     myungjoo.ham@samsung.com, kyungmin.park@samsung.com,
        cw00.choi@samsung.com, robh+dt@kernel.org, mark.rutland@arm.com,
        b.zolnierkie@samsung.com, dietmar.eggemann@arm.com
References: <20200219095828.8063-1-lukasz.luba@arm.com>
 <20200219095828.8063-2-lukasz.luba@arm.com>
From:   Lukasz Luba <lukasz.luba@arm.com>
Message-ID: <d545fe0f-3af2-4d37-ab44-c78fba350029@arm.com>
Date:   Wed, 19 Feb 2020 11:23:04 +0000
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.9.0
MIME-Version: 1.0
In-Reply-To: <20200219095828.8063-2-lukasz.luba@arm.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

My apologizes for the mistake in the subject. It should be
"PATCH v2 1/2" (mistake in script arguments while sending).
The same applies to the second patch, should be  "PATCH v2 2/2".

Regards,
Lukasz

On 2/19/20 9:58 AM, lukasz.luba@arm.com wrote:
> From: Lukasz Luba <lukasz.luba@arm.com>
> 
> To use Energy Aware Scheduler (EAS) the Energy Model (EM) should be
> registered for CPUs. Add dynamic-power-coefficient into CPU nodes which
> let CPUFreq subsystem register the EM structures. This will increase
> energy efficiency of big.LITTLE platforms.
> 
> The 'dynamic-power-coefficient' values have been obtained experimenting
> with different workloads. The power measurements taken from big CPU
> Cluster and LITTLE CPU Cluster has been compared with official documents
> and synthetic workloads estimations. The effective power ratio between
> Cortex-A7 and Cortex-A15 CPUs (~3x) is also aligned with documentation.
> 
> Signed-off-by: Lukasz Luba <lukasz.luba@arm.com>
> ---
>   arch/arm/boot/dts/exynos5422-cpus.dtsi | 8 ++++++++
>   1 file changed, 8 insertions(+)
> 
> diff --git a/arch/arm/boot/dts/exynos5422-cpus.dtsi b/arch/arm/boot/dts/exynos5422-cpus.dtsi
> index 1b8605cf2407..4b641b9b8179 100644
> --- a/arch/arm/boot/dts/exynos5422-cpus.dtsi
> +++ b/arch/arm/boot/dts/exynos5422-cpus.dtsi
> @@ -31,6 +31,7 @@
>   			operating-points-v2 = <&cluster_a7_opp_table>;
>   			#cooling-cells = <2>; /* min followed by max */
>   			capacity-dmips-mhz = <539>;
> +			dynamic-power-coefficient = <90>;
>   		};
>   
>   		cpu1: cpu@101 {
> @@ -43,6 +44,7 @@
>   			operating-points-v2 = <&cluster_a7_opp_table>;
>   			#cooling-cells = <2>; /* min followed by max */
>   			capacity-dmips-mhz = <539>;
> +			dynamic-power-coefficient = <90>;
>   		};
>   
>   		cpu2: cpu@102 {
> @@ -55,6 +57,7 @@
>   			operating-points-v2 = <&cluster_a7_opp_table>;
>   			#cooling-cells = <2>; /* min followed by max */
>   			capacity-dmips-mhz = <539>;
> +			dynamic-power-coefficient = <90>;
>   		};
>   
>   		cpu3: cpu@103 {
> @@ -67,6 +70,7 @@
>   			operating-points-v2 = <&cluster_a7_opp_table>;
>   			#cooling-cells = <2>; /* min followed by max */
>   			capacity-dmips-mhz = <539>;
> +			dynamic-power-coefficient = <90>;
>   		};
>   
>   		cpu4: cpu@0 {
> @@ -79,6 +83,7 @@
>   			operating-points-v2 = <&cluster_a15_opp_table>;
>   			#cooling-cells = <2>; /* min followed by max */
>   			capacity-dmips-mhz = <1024>;
> +			dynamic-power-coefficient = <310>;
>   		};
>   
>   		cpu5: cpu@1 {
> @@ -91,6 +96,7 @@
>   			operating-points-v2 = <&cluster_a15_opp_table>;
>   			#cooling-cells = <2>; /* min followed by max */
>   			capacity-dmips-mhz = <1024>;
> +			dynamic-power-coefficient = <310>;
>   		};
>   
>   		cpu6: cpu@2 {
> @@ -103,6 +109,7 @@
>   			operating-points-v2 = <&cluster_a15_opp_table>;
>   			#cooling-cells = <2>; /* min followed by max */
>   			capacity-dmips-mhz = <1024>;
> +			dynamic-power-coefficient = <310>;
>   		};
>   
>   		cpu7: cpu@3 {
> @@ -115,6 +122,7 @@
>   			operating-points-v2 = <&cluster_a15_opp_table>;
>   			#cooling-cells = <2>; /* min followed by max */
>   			capacity-dmips-mhz = <1024>;
> +			dynamic-power-coefficient = <310>;
>   		};
>   	};
>   };
> 
