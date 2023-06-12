Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8B66172BBA0
	for <lists+linux-pm@lfdr.de>; Mon, 12 Jun 2023 11:04:45 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233898AbjFLJEl (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Mon, 12 Jun 2023 05:04:41 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60836 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232246AbjFLJEF (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Mon, 12 Jun 2023 05:04:05 -0400
Received: from mo4-p01-ob.smtp.rzone.de (mo4-p01-ob.smtp.rzone.de [85.215.255.54])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CF27310FA;
        Mon, 12 Jun 2023 02:01:11 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1686560469; cv=none;
    d=strato.com; s=strato-dkim-0002;
    b=Pn7ea8vL52QPjkK99GeononXLUPhTqtzeHIt3eBy7EnijdrirSuiTgcXBdb5ugdAzP
    GUPXUd16CnGXjm9JkPmaiFpjiYSlbVzaWOuNrfVXE4ikhL9Jtc9fRd0ZWf01e6SR6EDb
    wePuzuXkAhlCrxiowZMjpvTxJgOPM1FlHeNiT2fkJ3pAp8qEwU9idE+IkwgDU45JbmID
    OxIYotrpfGSYxjKlQH9nvfO186jHBe/8xLDi7dC/xgsOqTP30IEPOP03CLNpgQhPS+xf
    /NXqnmtH8VcKAb1uzDog5bw2obWrnRIbWiKJFm/NLUrI7MqR89vEADSF8h89YZ8/of5Y
    5fxw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; t=1686560469;
    s=strato-dkim-0002; d=strato.com;
    h=In-Reply-To:References:Message-ID:Subject:Cc:To:From:Date:Cc:Date:
    From:Subject:Sender;
    bh=HsYKHXb5LAN1XiiGZp2HxT12uNIn7GspuR/yuWNQBco=;
    b=KH1cYlA2HFYFNPVeaZqezBNb+b9voOkmjCppBpFZ8TKdNUJ7M2tlv6kU1eieLYIcPV
    tk2meT+M/SUOTGmIt4YkeRAnXnzEWipIV8S4TSRgFpssoPoLMo2ZMaK72eGRR1nqK5dH
    trnjddkoGoJrUNdlH8MOE8Af81EEXbLJChTByCGcICeTnknrmOVL5KDG4js0J5U9qU8M
    +7+SLs/LGRQtsTZwyXTqorxKl7oY5EWWT+iqJvFyvNjqj1FWaeTBFnwAQ2IsEnpsZ5bV
    nTv0nXFc7NA/HM8EmaCX8DScjDJjpcZp1Jbp14MTtPZWPuiBF39yx1pTKCsG0+6smQe7
    ptCA==
ARC-Authentication-Results: i=1; strato.com;
    arc=none;
    dkim=none
X-RZG-CLASS-ID: mo01
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; t=1686560469;
    s=strato-dkim-0002; d=gerhold.net;
    h=In-Reply-To:References:Message-ID:Subject:Cc:To:From:Date:Cc:Date:
    From:Subject:Sender;
    bh=HsYKHXb5LAN1XiiGZp2HxT12uNIn7GspuR/yuWNQBco=;
    b=Orn1/uOG3q0lg6RIzYm0/t187uo3e6yfSkl+9RgRXth1hWTd8njfn1vlsR8wwkFfbb
    ZzVYbs9e2/VNU/cVrua3Tay6MzA0jXQvcRKQleIlBVblEu/1nZGhBaMByOktsTHk9KUM
    xWfsmS/KzcDqEzl7LT4MXZJx3oGZIKqGm2GlPHN8Kv8EwoltK5oBHRw/xBKgJ0+K3sye
    NxrnT9chWNEaJc7d6TAwLEOBI+ZCmHcU+kh2VAMPErxWitbXAIh0jWOiAGxbI9m7pn7e
    ecIhaXeeLQuljth52SRSqbeCBVUU18jFPnlS6agmB2f80DDe4lRIQhjCz7rxensumdvu
    DgdA==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; t=1686560469;
    s=strato-dkim-0003; d=gerhold.net;
    h=In-Reply-To:References:Message-ID:Subject:Cc:To:From:Date:Cc:Date:
    From:Subject:Sender;
    bh=HsYKHXb5LAN1XiiGZp2HxT12uNIn7GspuR/yuWNQBco=;
    b=j2MLThErs3364etj5U8wBH/yatT3+o2s2io6qOq2f/losIFsePrda788DHBhp5tXxy
    4K1j+iyn9TC7viqtJMCg==
X-RZG-AUTH: ":P3gBZUipdd93FF5ZZvYFPugejmSTVR2nRPhVOQ/OcYgojyw4j34+u261EJF5OxJD4peA8peN1A=="
Received: from gerhold.net
    by smtp.strato.de (RZmta 49.5.3 DYNA|AUTH)
    with ESMTPSA id Z82ec2z5C918TbJ
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256 bits))
        (Client did not present a certificate);
    Mon, 12 Jun 2023 11:01:08 +0200 (CEST)
Date:   Mon, 12 Jun 2023 11:01:03 +0200
From:   Stephan Gerhold <stephan@gerhold.net>
To:     Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
Cc:     Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley <conor+dt@kernel.org>,
        Andy Gross <agross@kernel.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Konrad Dybcio <konrad.dybcio@linaro.org>,
        Ilia Lin <ilia.lin@kernel.org>,
        Viresh Kumar <vireshk@kernel.org>, Nishanth Menon <nm@ti.com>,
        Stephen Boyd <sboyd@kernel.org>,
        Michael Turquette <mturquette@baylibre.com>,
        "Rafael J. Wysocki" <rafael@kernel.org>,
        linux-arm-msm@vger.kernel.org, devicetree@vger.kernel.org,
        linux-pm@vger.kernel.org, linux-clk@vger.kernel.org,
        Christian Marangi <ansuelsmth@gmail.com>
Subject: Re: [PATCH 15/18] ARM: dts: qcom: apq8064: provide voltage scaling
 tables
Message-ID: <ZIbez4RA0OoVfHzt@gerhold.net>
References: <20230612053922.3284394-1-dmitry.baryshkov@linaro.org>
 <20230612053922.3284394-16-dmitry.baryshkov@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230612053922.3284394-16-dmitry.baryshkov@linaro.org>
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_PASS,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

On Mon, Jun 12, 2023 at 08:39:19AM +0300, Dmitry Baryshkov wrote:
> APQ8064 has 4 speed bins, each of them having from 4 to 6 categorization
> kinds. Provide tables necessary to handle voltage scaling on this SoC.
> 
> Signed-off-by: Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
> ---
>  arch/arm/boot/dts/qcom-apq8064.dtsi | 1017 +++++++++++++++++++++++++++
>  1 file changed, 1017 insertions(+)
> 
> diff --git a/arch/arm/boot/dts/qcom-apq8064.dtsi b/arch/arm/boot/dts/qcom-apq8064.dtsi
> index 4ef13f3d702b..f35853b59544 100644
> --- a/arch/arm/boot/dts/qcom-apq8064.dtsi
> +++ b/arch/arm/boot/dts/qcom-apq8064.dtsi
> @@ -49,6 +49,9 @@ CPU0: cpu@0 {
>  			clocks = <&kraitcc KRAIT_CPU_0>;
>  			clock-names = "cpu";
>  			clock-latency = <100000>;
> +			vdd-mem-supply = <&pm8921_l24>;
> +			vdd-dig-supply = <&pm8921_s3>;
> +			vdd-core-supply = <&saw0_vreg>;
>  			interconnects = <&kraitcc MASTER_KRAIT_L2 &kraitcc SLAVE_KRAIT_L2>;
>  			operating-points-v2 = <&cpu_opp_table>;
>  			#cooling-cells = <2>;
> @@ -66,6 +69,9 @@ CPU1: cpu@1 {
>  			clocks = <&kraitcc KRAIT_CPU_1>;
>  			clock-names = "cpu";
>  			clock-latency = <100000>;
> +			vdd-mem-supply = <&pm8921_l24>;
> +			vdd-dig-supply = <&pm8921_s3>;
> +			vdd-core-supply = <&saw1_vreg>;
>  			interconnects = <&kraitcc MASTER_KRAIT_L2 &kraitcc SLAVE_KRAIT_L2>;
>  			operating-points-v2 = <&cpu_opp_table>;
>  			#cooling-cells = <2>;
> @@ -83,6 +89,9 @@ CPU2: cpu@2 {
>  			clocks = <&kraitcc KRAIT_CPU_2>;
>  			clock-names = "cpu";
>  			clock-latency = <100000>;
> +			vdd-mem-supply = <&pm8921_l24>;
> +			vdd-dig-supply = <&pm8921_s3>;
> +			vdd-core-supply = <&saw2_vreg>;
>  			interconnects = <&kraitcc MASTER_KRAIT_L2 &kraitcc SLAVE_KRAIT_L2>;
>  			operating-points-v2 = <&cpu_opp_table>;
>  			#cooling-cells = <2>;
> @@ -100,6 +109,9 @@ CPU3: cpu@3 {
>  			clocks = <&kraitcc KRAIT_CPU_3>;
>  			clock-names = "cpu";
>  			clock-latency = <100000>;
> +			vdd-mem-supply = <&pm8921_l24>;
> +			vdd-dig-supply = <&pm8921_s3>;
> +			vdd-core-supply = <&saw3_vreg>;
>  			interconnects = <&kraitcc MASTER_KRAIT_L2 &kraitcc SLAVE_KRAIT_L2>;
>  			operating-points-v2 = <&cpu_opp_table>;
>  			#cooling-cells = <2>;
> @@ -132,6 +144,81 @@ cpu_opp_table: opp-table-cpu {
>  		opp-384000000 {
>  			opp-hz = /bits/ 64 <384000000>;
>  			opp-peak-kBps = <384000>;
> +			opp-microvolt-speed0-pvs0 = <1050000 1050000 1150000>,
> +						    <950000 950000 1150000>,
> +						    <950000 950000 975000>;

I think this won't result in the correct switch order without making
some changes to the OPP core. In _set_opp() the OPP core does

	/* Scaling up? Configure required OPPs before frequency */
	if (!scaling_down) {
		_set_required_opps();
		_set_opp_bw();
		opp_table->config_regulators();
	}

	opp_table->config_clks();

	/* Scaling down? Configure required OPPs after frequency */
	if (scaling_down) {
		opp_table->config_regulators();
		_set_opp_bw();
		_set_required_opps();
	}

Since the "bandwidth" for the L2 cache is set before the regulators
there is a short window where the L2 clock is running at a high
frequency with too low voltage, which could potentially cause
instability. On downstream this seems to be done in the proper order [1].

I'm not sure if the order in the OPP core is on purpose. If not, you
could propose moving the config_regulators() first (for scaling up)
and last (for scaling down). This would resolve the problem.

The alternative that I've already argued for on IRC in #linux-msm a
couple of days ago would be to give the L2 cache (here: "interconnect")
an own OPP table where it can describe its voltage requirements,
independent from the CPU. That way the icc_set_bw() would be guaranteed
to apply the correct voltage before adjusting the L2 cache clock. It
looks like the "l2_level" voltages for vdd_dig and vdd_mem are not
speedbin/PVS-specific [2] so this would also significantly reduce the DT
size, since you wouldn't need to repeat the same vdd_dig/vdd_mem
voltages for all of them.

Thanks,
Stephan

[1]: https://git.codelinaro.org/clo/la/kernel/msm/-/blob/LA.AF.1.2.1-08410-8064.0/arch/arm/mach-msm/acpuclock-krait.c#L529-588
[2]: https://git.codelinaro.org/clo/la/kernel/msm/-/blob/LA.AF.1.2.1-08410-8064.0/arch/arm/mach-msm/acpuclock-8064.c#L118-135
