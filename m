Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id CEFCC127826
	for <lists+linux-pm@lfdr.de>; Fri, 20 Dec 2019 10:31:57 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727291AbfLTJb4 (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Fri, 20 Dec 2019 04:31:56 -0500
Received: from cloudserver094114.home.pl ([79.96.170.134]:44708 "EHLO
        cloudserver094114.home.pl" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727167AbfLTJb4 (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Fri, 20 Dec 2019 04:31:56 -0500
Received: from 79.184.253.1.ipv4.supernova.orange.pl (79.184.253.1) (HELO kreacher.localnet)
 by serwer1319399.home.pl (79.96.170.134) with SMTP (IdeaSmtpServer 0.83.320)
 id fe89d39e7f44edc6; Fri, 20 Dec 2019 10:31:54 +0100
From:   "Rafael J. Wysocki" <rjw@rjwysocki.net>
To:     Niklas Cassel <niklas.cassel@linaro.org>
Cc:     Niklas Cassel <nks@flawful.org>, linux-arm-msm@vger.kernel.org,
        amit.kucheria@linaro.org, sboyd@kernel.org, vireshk@kernel.org,
        bjorn.andersson@linaro.org, ulf.hansson@linaro.org,
        Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>, linux-pm@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v7 1/5] dt-bindings: power: avs: Add support for CPR (Core Power Reduction)
Date:   Fri, 20 Dec 2019 10:31:53 +0100
Message-ID: <121319954.uyNvbQYpoT@kreacher>
In-Reply-To: <20191129213917.1301110-2-niklas.cassel@linaro.org>
References: <20191129213917.1301110-1-niklas.cassel@linaro.org> <20191129213917.1301110-2-niklas.cassel@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 7Bit
Content-Type: text/plain; charset="us-ascii"
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

On Friday, November 29, 2019 10:39:11 PM CET Niklas Cassel wrote:
> Add DT bindings to describe the CPR HW found on certain Qualcomm SoCs.
> 
> Co-developed-by: Jorge Ramirez-Ortiz <jorge.ramirez-ortiz@linaro.org>
> Signed-off-by: Jorge Ramirez-Ortiz <jorge.ramirez-ortiz@linaro.org>
> Signed-off-by: Niklas Cassel <niklas.cassel@linaro.org>
> Reviewed-by: Rob Herring <robh@kernel.org>
> Reviewed-by: Bjorn Andersson <bjorn.andersson@linaro.org>
> Reviewed-by: Ulf Hansson <ulf.hansson@linaro.org>
> ---
> Changes since v6:
> -Picked up Bjorn's and Ulf's Reviewed-by.
> 
>  .../bindings/power/avs/qcom,cpr.txt           | 130 ++++++++++++++++++
>  1 file changed, 130 insertions(+)
>  create mode 100644 Documentation/devicetree/bindings/power/avs/qcom,cpr.txt
> 
> diff --git a/Documentation/devicetree/bindings/power/avs/qcom,cpr.txt b/Documentation/devicetree/bindings/power/avs/qcom,cpr.txt
> new file mode 100644
> index 000000000000..ab0d5ebbad4e
> --- /dev/null
> +++ b/Documentation/devicetree/bindings/power/avs/qcom,cpr.txt
> @@ -0,0 +1,130 @@
> +QCOM CPR (Core Power Reduction)
> +
> +CPR (Core Power Reduction) is a technology to reduce core power on a CPU
> +or other device. Each OPP of a device corresponds to a "corner" that has
> +a range of valid voltages for a particular frequency. While the device is
> +running at a particular frequency, CPR monitors dynamic factors such as
> +temperature, etc. and suggests adjustments to the voltage to save power
> +and meet silicon characteristic requirements.
> +
> +- compatible:
> +	Usage: required
> +	Value type: <string>
> +	Definition: should be "qcom,qcs404-cpr", "qcom,cpr" for qcs404
> +
> +- reg:
> +	Usage: required
> +	Value type: <prop-encoded-array>
> +	Definition: base address and size of the rbcpr register region
> +
> +- interrupts:
> +	Usage: required
> +	Value type: <prop-encoded-array>
> +	Definition: should specify the CPR interrupt
> +
> +- clocks:
> +	Usage: required
> +	Value type: <prop-encoded-array>
> +	Definition: phandle to the reference clock
> +
> +- clock-names:
> +	Usage: required
> +	Value type: <stringlist>
> +	Definition: must be "ref"
> +
> +- vdd-apc-supply:
> +	Usage: required
> +	Value type: <phandle>
> +	Definition: phandle to the vdd-apc-supply regulator
> +
> +- #power-domain-cells:
> +	Usage: required
> +	Value type: <u32>
> +	Definition: should be 0
> +
> +- operating-points-v2:
> +	Usage: required
> +	Value type: <phandle>
> +	Definition: A phandle to the OPP table containing the
> +		    performance states supported by the CPR
> +		    power domain
> +
> +- acc-syscon:
> +	Usage: optional
> +	Value type: <phandle>
> +	Definition: phandle to syscon for writing ACC settings
> +
> +- nvmem-cells:
> +	Usage: required
> +	Value type: <phandle>
> +	Definition: phandle to nvmem cells containing the data
> +		    that makes up a fuse corner, for each fuse corner.
> +		    As well as the CPR fuse revision.
> +
> +- nvmem-cell-names:
> +	Usage: required
> +	Value type: <stringlist>
> +	Definition: should be "cpr_quotient_offset1", "cpr_quotient_offset2",
> +		    "cpr_quotient_offset3", "cpr_init_voltage1",
> +		    "cpr_init_voltage2", "cpr_init_voltage3", "cpr_quotient1",
> +		    "cpr_quotient2", "cpr_quotient3", "cpr_ring_osc1",
> +		    "cpr_ring_osc2", "cpr_ring_osc3", "cpr_fuse_revision"
> +		    for qcs404.
> +
> +Example:
> +
> +	cpr_opp_table: cpr-opp-table {
> +		compatible = "operating-points-v2-qcom-level";
> +
> +		cpr_opp1: opp1 {
> +			opp-level = <1>;
> +			qcom,opp-fuse-level = <1>;
> +		};
> +		cpr_opp2: opp2 {
> +			opp-level = <2>;
> +			qcom,opp-fuse-level = <2>;
> +		};
> +		cpr_opp3: opp3 {
> +			opp-level = <3>;
> +			qcom,opp-fuse-level = <3>;
> +		};
> +	};
> +
> +	power-controller@b018000 {
> +		compatible = "qcom,qcs404-cpr", "qcom,cpr";
> +		reg = <0x0b018000 0x1000>;
> +		interrupts = <0 15 IRQ_TYPE_EDGE_RISING>;
> +		clocks = <&xo_board>;
> +		clock-names = "ref";
> +		vdd-apc-supply = <&pms405_s3>;
> +		#power-domain-cells = <0>;
> +		operating-points-v2 = <&cpr_opp_table>;
> +		acc-syscon = <&tcsr>;
> +
> +		nvmem-cells = <&cpr_efuse_quot_offset1>,
> +			<&cpr_efuse_quot_offset2>,
> +			<&cpr_efuse_quot_offset3>,
> +			<&cpr_efuse_init_voltage1>,
> +			<&cpr_efuse_init_voltage2>,
> +			<&cpr_efuse_init_voltage3>,
> +			<&cpr_efuse_quot1>,
> +			<&cpr_efuse_quot2>,
> +			<&cpr_efuse_quot3>,
> +			<&cpr_efuse_ring1>,
> +			<&cpr_efuse_ring2>,
> +			<&cpr_efuse_ring3>,
> +			<&cpr_efuse_revision>;
> +		nvmem-cell-names = "cpr_quotient_offset1",
> +			"cpr_quotient_offset2",
> +			"cpr_quotient_offset3",
> +			"cpr_init_voltage1",
> +			"cpr_init_voltage2",
> +			"cpr_init_voltage3",
> +			"cpr_quotient1",
> +			"cpr_quotient2",
> +			"cpr_quotient3",
> +			"cpr_ring_osc1",
> +			"cpr_ring_osc2",
> +			"cpr_ring_osc3",
> +			"cpr_fuse_revision";
> +	};
> 

I have queued up this one and the [2/5] for 5.6, but if you'd rather want them
to go in via a different patch, please let me know and I'll drop them.

Thanks!



