Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 8AE3D127E47
	for <lists+linux-pm@lfdr.de>; Fri, 20 Dec 2019 15:42:32 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727513AbfLTOkX (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Fri, 20 Dec 2019 09:40:23 -0500
Received: from pio-pvt-msa3.bahnhof.se ([79.136.2.42]:34868 "EHLO
        pio-pvt-msa3.bahnhof.se" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727407AbfLTOkX (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Fri, 20 Dec 2019 09:40:23 -0500
X-Greylist: delayed 379 seconds by postgrey-1.27 at vger.kernel.org; Fri, 20 Dec 2019 09:40:21 EST
Received: from localhost (localhost [127.0.0.1])
        by pio-pvt-msa3.bahnhof.se (Postfix) with ESMTP id 84F9D3F36C;
        Fri, 20 Dec 2019 15:33:59 +0100 (CET)
Authentication-Results: pio-pvt-msa3.bahnhof.se;
        dkim=pass (1024-bit key; unprotected) header.d=flawful.org header.i=@flawful.org header.b=u5oB4Mzu;
        dkim-atps=neutral
X-Virus-Scanned: Debian amavisd-new at bahnhof.se
X-Spam-Flag: NO
X-Spam-Score: -2.099
X-Spam-Level: 
X-Spam-Status: No, score=-2.099 tagged_above=-999 required=6.31
        tests=[BAYES_00=-1.9, DKIM_SIGNED=0.1, DKIM_VALID=-0.1,
        DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, URIBL_BLOCKED=0.001]
        autolearn=ham autolearn_force=no
Received: from pio-pvt-msa3.bahnhof.se ([127.0.0.1])
        by localhost (pio-pvt-msa3.bahnhof.se [127.0.0.1]) (amavisd-new, port 10024)
        with ESMTP id 4iaXAKwHxOaC; Fri, 20 Dec 2019 15:33:58 +0100 (CET)
Received: from flawful.org (ua-84-217-220-205.bbcust.telenor.se [84.217.220.205])
        (Authenticated sender: mb274189)
        by pio-pvt-msa3.bahnhof.se (Postfix) with ESMTPA id F07543F363;
        Fri, 20 Dec 2019 15:33:57 +0100 (CET)
Received: by flawful.org (Postfix, from userid 1001)
        id 7C724778; Fri, 20 Dec 2019 15:33:56 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=flawful.org; s=mail;
        t=1576852436; bh=uIwpsC9CqzY2wzmFL/L7G29tuR1CW3dSiiv7KHs724c=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=u5oB4Mzu1xVtBR0eepkJZ8Ots2kLODostidNmYqaMn/1ESctkrTfsnWtfqMMC/xDv
         oFORI+O8DkK+muqQmsN6M4VPflFYMJpviD8fcowOM8Fm0rjNqtCfgAnGB6g6Ww0goA
         at7lAqcKUFmsqUxKlg7lGVthKl5LRxWhC4CSJl34=
Date:   Fri, 20 Dec 2019 15:33:56 +0100
From:   Niklas Cassel <nks@flawful.org>
To:     "Rafael J. Wysocki" <rjw@rjwysocki.net>
Cc:     Niklas Cassel <niklas.cassel@linaro.org>,
        linux-arm-msm@vger.kernel.org, amit.kucheria@linaro.org,
        sboyd@kernel.org, vireshk@kernel.org, bjorn.andersson@linaro.org,
        ulf.hansson@linaro.org, Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>, linux-pm@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v7 1/5] dt-bindings: power: avs: Add support for CPR
 (Core Power Reduction)
Message-ID: <20191220143356.cprp55jmuhtcx7wr@flawful.org>
References: <20191129213917.1301110-1-niklas.cassel@linaro.org>
 <20191129213917.1301110-2-niklas.cassel@linaro.org>
 <121319954.uyNvbQYpoT@kreacher>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <121319954.uyNvbQYpoT@kreacher>
User-Agent: NeoMutt/20170113 (1.7.2)
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

On Fri, Dec 20, 2019 at 10:31:53AM +0100, Rafael J. Wysocki wrote:
> On Friday, November 29, 2019 10:39:11 PM CET Niklas Cassel wrote:
> > Add DT bindings to describe the CPR HW found on certain Qualcomm SoCs.
> > 
> > Co-developed-by: Jorge Ramirez-Ortiz <jorge.ramirez-ortiz@linaro.org>
> > Signed-off-by: Jorge Ramirez-Ortiz <jorge.ramirez-ortiz@linaro.org>
> > Signed-off-by: Niklas Cassel <niklas.cassel@linaro.org>
> > Reviewed-by: Rob Herring <robh@kernel.org>
> > Reviewed-by: Bjorn Andersson <bjorn.andersson@linaro.org>
> > Reviewed-by: Ulf Hansson <ulf.hansson@linaro.org>
> > ---
> > Changes since v6:
> > -Picked up Bjorn's and Ulf's Reviewed-by.
> > 
> >  .../bindings/power/avs/qcom,cpr.txt           | 130 ++++++++++++++++++
> >  1 file changed, 130 insertions(+)
> >  create mode 100644 Documentation/devicetree/bindings/power/avs/qcom,cpr.txt
> > 
> > diff --git a/Documentation/devicetree/bindings/power/avs/qcom,cpr.txt b/Documentation/devicetree/bindings/power/avs/qcom,cpr.txt
> > new file mode 100644
> > index 000000000000..ab0d5ebbad4e
> > --- /dev/null
> > +++ b/Documentation/devicetree/bindings/power/avs/qcom,cpr.txt
> > @@ -0,0 +1,130 @@
> > +QCOM CPR (Core Power Reduction)
> > +
> > +CPR (Core Power Reduction) is a technology to reduce core power on a CPU
> > +or other device. Each OPP of a device corresponds to a "corner" that has
> > +a range of valid voltages for a particular frequency. While the device is
> > +running at a particular frequency, CPR monitors dynamic factors such as
> > +temperature, etc. and suggests adjustments to the voltage to save power
> > +and meet silicon characteristic requirements.
> > +
> > +- compatible:
> > +	Usage: required
> > +	Value type: <string>
> > +	Definition: should be "qcom,qcs404-cpr", "qcom,cpr" for qcs404
> > +
> > +- reg:
> > +	Usage: required
> > +	Value type: <prop-encoded-array>
> > +	Definition: base address and size of the rbcpr register region
> > +
> > +- interrupts:
> > +	Usage: required
> > +	Value type: <prop-encoded-array>
> > +	Definition: should specify the CPR interrupt
> > +
> > +- clocks:
> > +	Usage: required
> > +	Value type: <prop-encoded-array>
> > +	Definition: phandle to the reference clock
> > +
> > +- clock-names:
> > +	Usage: required
> > +	Value type: <stringlist>
> > +	Definition: must be "ref"
> > +
> > +- vdd-apc-supply:
> > +	Usage: required
> > +	Value type: <phandle>
> > +	Definition: phandle to the vdd-apc-supply regulator
> > +
> > +- #power-domain-cells:
> > +	Usage: required
> > +	Value type: <u32>
> > +	Definition: should be 0
> > +
> > +- operating-points-v2:
> > +	Usage: required
> > +	Value type: <phandle>
> > +	Definition: A phandle to the OPP table containing the
> > +		    performance states supported by the CPR
> > +		    power domain
> > +
> > +- acc-syscon:
> > +	Usage: optional
> > +	Value type: <phandle>
> > +	Definition: phandle to syscon for writing ACC settings
> > +
> > +- nvmem-cells:
> > +	Usage: required
> > +	Value type: <phandle>
> > +	Definition: phandle to nvmem cells containing the data
> > +		    that makes up a fuse corner, for each fuse corner.
> > +		    As well as the CPR fuse revision.
> > +
> > +- nvmem-cell-names:
> > +	Usage: required
> > +	Value type: <stringlist>
> > +	Definition: should be "cpr_quotient_offset1", "cpr_quotient_offset2",
> > +		    "cpr_quotient_offset3", "cpr_init_voltage1",
> > +		    "cpr_init_voltage2", "cpr_init_voltage3", "cpr_quotient1",
> > +		    "cpr_quotient2", "cpr_quotient3", "cpr_ring_osc1",
> > +		    "cpr_ring_osc2", "cpr_ring_osc3", "cpr_fuse_revision"
> > +		    for qcs404.
> > +
> > +Example:
> > +
> > +	cpr_opp_table: cpr-opp-table {
> > +		compatible = "operating-points-v2-qcom-level";
> > +
> > +		cpr_opp1: opp1 {
> > +			opp-level = <1>;
> > +			qcom,opp-fuse-level = <1>;
> > +		};
> > +		cpr_opp2: opp2 {
> > +			opp-level = <2>;
> > +			qcom,opp-fuse-level = <2>;
> > +		};
> > +		cpr_opp3: opp3 {
> > +			opp-level = <3>;
> > +			qcom,opp-fuse-level = <3>;
> > +		};
> > +	};
> > +
> > +	power-controller@b018000 {
> > +		compatible = "qcom,qcs404-cpr", "qcom,cpr";
> > +		reg = <0x0b018000 0x1000>;
> > +		interrupts = <0 15 IRQ_TYPE_EDGE_RISING>;
> > +		clocks = <&xo_board>;
> > +		clock-names = "ref";
> > +		vdd-apc-supply = <&pms405_s3>;
> > +		#power-domain-cells = <0>;
> > +		operating-points-v2 = <&cpr_opp_table>;
> > +		acc-syscon = <&tcsr>;
> > +
> > +		nvmem-cells = <&cpr_efuse_quot_offset1>,
> > +			<&cpr_efuse_quot_offset2>,
> > +			<&cpr_efuse_quot_offset3>,
> > +			<&cpr_efuse_init_voltage1>,
> > +			<&cpr_efuse_init_voltage2>,
> > +			<&cpr_efuse_init_voltage3>,
> > +			<&cpr_efuse_quot1>,
> > +			<&cpr_efuse_quot2>,
> > +			<&cpr_efuse_quot3>,
> > +			<&cpr_efuse_ring1>,
> > +			<&cpr_efuse_ring2>,
> > +			<&cpr_efuse_ring3>,
> > +			<&cpr_efuse_revision>;
> > +		nvmem-cell-names = "cpr_quotient_offset1",
> > +			"cpr_quotient_offset2",
> > +			"cpr_quotient_offset3",
> > +			"cpr_init_voltage1",
> > +			"cpr_init_voltage2",
> > +			"cpr_init_voltage3",
> > +			"cpr_quotient1",
> > +			"cpr_quotient2",
> > +			"cpr_quotient3",
> > +			"cpr_ring_osc1",
> > +			"cpr_ring_osc2",
> > +			"cpr_ring_osc3",
> > +			"cpr_fuse_revision";
> > +	};
> > 
> 
> I have queued up this one and the [2/5] for 5.6, but if you'd rather want them
> to go in via a different patch, please let me know and I'll drop them.
> 

Thanks a lot Rafael!

I would very much prefer them to go via your tree.

Unfortunately it seems like kbuild test robot
found an incorrect printk format specifier in
one of the debug prints.

Line 838
dev_dbg(dev, "efuse read(%s) = %x, bytes %ld\n", cname, *data, len);

should be
dev_dbg(dev, "efuse read(%s) = %x, bytes %zd\n", cname, *data, len);

So %zd rather than %ld.

This was obviously an error, but didn't show when
compiling on arm64 or x86_64.

Sorry for this inconvenience.

Could you fix up the commit or do I need to do a respin?


Kind regards,
Niklas
