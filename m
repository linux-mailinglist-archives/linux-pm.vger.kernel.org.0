Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A3181372C4C
	for <lists+linux-pm@lfdr.de>; Tue,  4 May 2021 16:42:25 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231411AbhEDOnS (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Tue, 4 May 2021 10:43:18 -0400
Received: from foss.arm.com ([217.140.110.172]:59474 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S230086AbhEDOnS (ORCPT <rfc822;linux-pm@vger.kernel.org>);
        Tue, 4 May 2021 10:43:18 -0400
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 67CFFED1;
        Tue,  4 May 2021 07:42:23 -0700 (PDT)
Received: from bogus (unknown [10.57.61.118])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 839EF3F718;
        Tue,  4 May 2021 07:42:21 -0700 (PDT)
Date:   Tue, 4 May 2021 15:42:15 +0100
From:   Sudeep Holla <sudeep.holla@arm.com>
To:     Sibi Sankar <sibis@codeaurora.org>
Cc:     bjorn.andersson@linaro.org, viresh.kumar@linaro.org,
        Sudeep Holla <sudeep.holla@arm.com>, swboyd@chromium.org,
        agross@kernel.org, robh+dt@kernel.org, rjw@rjwysocki.net,
        linux-arm-msm@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-pm@vger.kernel.org,
        dianders@chromium.org, mka@chromium.org
Subject: Re: [PATCH 2/2] arm64: dts: qcom: sc7280: Add cpu OPP tables
Message-ID: <20210504144215.svmrmmsy4jtoixzv@bogus>
References: <1619792901-32701-1-git-send-email-sibis@codeaurora.org>
 <1619792901-32701-3-git-send-email-sibis@codeaurora.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1619792901-32701-3-git-send-email-sibis@codeaurora.org>
User-Agent: NeoMutt/20171215
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

On Fri, Apr 30, 2021 at 07:58:21PM +0530, Sibi Sankar wrote:
> Add OPP tables required to scale DDR/L3 per freq-domain on SC7280 SoCs.
> 
> Signed-off-by: Sibi Sankar <sibis@codeaurora.org>
> ---
>  arch/arm64/boot/dts/qcom/sc7280.dtsi | 135 +++++++++++++++++++++++++++++++++++
>  1 file changed, 135 insertions(+)
> 
> diff --git a/arch/arm64/boot/dts/qcom/sc7280.dtsi b/arch/arm64/boot/dts/qcom/sc7280.dtsi
> index 0bb835aeae33..90220cecb368 100644
> --- a/arch/arm64/boot/dts/qcom/sc7280.dtsi
> +++ b/arch/arm64/boot/dts/qcom/sc7280.dtsi


[...]

> @@ -248,6 +273,116 @@
>  		};
>  	};
>  
> +	cpu0_opp_table: cpu0_opp_table {
> +		compatible = "operating-points-v2";
> +		opp-shared;
> +
> +		cpu0_opp1: opp-300000000 {
> +			opp-hz = /bits/ 64 <300000000>;
> +			opp-peak-kBps = <800000 9600000>;
> +		};
> +
> +		cpu0_opp2: opp-691200000 {
> +			opp-hz = /bits/ 64 <691200000>;
> +			opp-peak-kBps = <800000 17817600>;
> +		};
> +
> +		cpu0_opp3: opp-806400000 {
> +			opp-hz = /bits/ 64 <806400000>;
> +			opp-peak-kBps = <800000 20889600>;
> +		};
> +
> +		cpu0_opp4: opp-940800000 {
> +			opp-hz = /bits/ 64 <940800000>;
> +			opp-peak-kBps = <1804000 24576000>;
> +		};
> +
> +		cpu0_opp5: opp-1152000000 {
> +			opp-hz = /bits/ 64 <1152000000>;
> +			opp-peak-kBps = <2188000 27033600>;
> +		};
> +
> +		cpu0_opp6: opp-1324800000 {
> +			opp-hz = /bits/ 64 <1324800000>;
> +			opp-peak-kBps = <2188000 33792000>;
> +		};
> +
> +		cpu0_opp7: opp-1516800000 {
> +			opp-hz = /bits/ 64 <1516800000>;
> +			opp-peak-kBps = <3072000 38092800>;
> +		};
> +
> +		cpu0_opp8: opp-1651200000 {
> +			opp-hz = /bits/ 64 <1651200000>;
> +			opp-peak-kBps = <3072000 41779200>;
> +		};
> +
> +		cpu0_opp9: opp-1804800000 {
> +			opp-hz = /bits/ 64 <1804800000>;
> +			opp-peak-kBps = <4068000 48537600>;
> +		};
> +
> +		cpu0_opp10: opp-1958400000 {
> +			opp-hz = /bits/ 64 <1958400000>;
> +			opp-peak-kBps = <4068000 48537600>;
> +		};
> +	};
> +

NACK, this breaks if there is a mismatch from what is read from the hardware
and what is presented in this table above. Either add it from the some
bootloader or other boot code to this table reading from the hardware/firmware
or find a way to link them without this.

Sorry I had warned long back about this when such links were discussed as
part of interconnect binding.

-- 
Regards,
Sudeep
