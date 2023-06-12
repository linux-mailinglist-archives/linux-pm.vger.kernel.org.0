Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 90D9E72C6C7
	for <lists+linux-pm@lfdr.de>; Mon, 12 Jun 2023 16:00:52 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235495AbjFLOAu (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Mon, 12 Jun 2023 10:00:50 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46374 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237076AbjFLOAB (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Mon, 12 Jun 2023 10:00:01 -0400
Received: from mo4-p01-ob.smtp.rzone.de (mo4-p01-ob.smtp.rzone.de [81.169.146.165])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5683A10F6;
        Mon, 12 Jun 2023 06:59:54 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1686578391; cv=none;
    d=strato.com; s=strato-dkim-0002;
    b=Mlfzmd2FMLldsvA1EwRP6cESOsJLcBT7JxRj91giCTat9/Vb43akk9GlFEykjuA2CU
    KlmP/neVv0tjBfxMlJh/JuMAJXipVsftO3BMtI8ruxW6AcxPRz6dQBJUpaAY4o+0pbP8
    rztgN4Eh5AymKBZtn50slxFN7A02veOmJ1QKFd+FANMz9hcVGYiEb8T0N2EqKguLLLbr
    PXeTLUHEaXZEOIduGEco5ikpmjmluul1bAq1Q75LzoZRnYisAJxXdWBMj0dX6WgkuckX
    VB6GAsnlE1CcR0rSzmMtjcfxbkFR82Lr3kVqmecm3jMwDG98+AcgESpUWjWN5UhCG3B4
    TgnA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; t=1686578391;
    s=strato-dkim-0002; d=strato.com;
    h=In-Reply-To:References:Message-ID:Subject:Cc:To:From:Date:Cc:Date:
    From:Subject:Sender;
    bh=ma+8RmGyl039YHh+kLX83fD91U9pajDEzK6ztviFVqA=;
    b=XrKhYnirYxLcu1uH6OINJiu+2pV4+Zz/q5RnjBSamlZs8GpNCCoCPwjhARxf1M4CPi
    4K3yZycNpeaRdDfjzEu47dl4kFG2CR1HsDt0Rnf0iD2FkgyhH+5qYr/nTxHiEs2qE2V0
    +kjmyNpkyo8cPO+17cnE3G45xs3dpFKA4LeCp6WYt6AIQlihlN30cS44AvBtIoHmM78r
    pAK88KmPrqAAy9uEGjC4yFLHslDHnosOphD48G5rrF06d+cAkyt3wtLTN156gz0HK99S
    gI2OVbMcuu6YdEqzkwH8t47wQPEVm69DP2ysluWcb/pC/GhJsnSXBZunv2/Km0zK9P9h
    FHBg==
ARC-Authentication-Results: i=1; strato.com;
    arc=none;
    dkim=none
X-RZG-CLASS-ID: mo01
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; t=1686578391;
    s=strato-dkim-0002; d=gerhold.net;
    h=In-Reply-To:References:Message-ID:Subject:Cc:To:From:Date:Cc:Date:
    From:Subject:Sender;
    bh=ma+8RmGyl039YHh+kLX83fD91U9pajDEzK6ztviFVqA=;
    b=VYsNbyCiSkqAqPmA85Fm96V9cCVASIjkXVqjK+NyvZjZ5ZTBRC0VSQZycIsIVAnVZC
    mEdaWATOHiDC9AGzcP71c5yXQ6IPZw98BN3aS1WSo0UmIYtkyfLCTOFRwYiH8ZJJnuyb
    2yJzqYJ7WFQzxPJd4asD0LAQ+0w3Gvs4tk3qyOvgI7A3Jv40LbA9hOFXIE6r0oJQ2ZNL
    4OEHHO7rSYOsxWPtQjzQJC6QbN6ucDIAYfyua5+LEqFfUy7uRdFx1+dnJuWP3iRPdFzp
    QmBlR28kdRw0HCABP7ph3bpnoI+ziFkWthRRzixgNDWFvek6RcHoKWfI8ailjrlzrUZU
    D+Wg==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; t=1686578391;
    s=strato-dkim-0003; d=gerhold.net;
    h=In-Reply-To:References:Message-ID:Subject:Cc:To:From:Date:Cc:Date:
    From:Subject:Sender;
    bh=ma+8RmGyl039YHh+kLX83fD91U9pajDEzK6ztviFVqA=;
    b=d1voIuA7EbU2Zp1su+LmU7Ch2DgDkclFE+V43X4r+hlppKhrl1xg/8nMmWr9kNx7pp
    xDOW+NXE79VXg7wTO0AQ==
X-RZG-AUTH: ":P3gBZUipdd93FF5ZZvYFPugejmSTVR2nRPhVOQ/OcYgojyw4j34+u261EJF5OxJD4peA8peN1A=="
Received: from gerhold.net
    by smtp.strato.de (RZmta 49.5.3 DYNA|AUTH)
    with ESMTPSA id Z82ec2z5CDxpV99
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256 bits))
        (Client did not present a certificate);
    Mon, 12 Jun 2023 15:59:51 +0200 (CEST)
Date:   Mon, 12 Jun 2023 15:59:44 +0200
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
Message-ID: <ZIck0L-gK_a_jCtc@gerhold.net>
References: <20230612053922.3284394-1-dmitry.baryshkov@linaro.org>
 <20230612053922.3284394-16-dmitry.baryshkov@linaro.org>
 <ZIbez4RA0OoVfHzt@gerhold.net>
 <8c1085fd-8a73-d192-6624-d4f35728e68a@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <8c1085fd-8a73-d192-6624-d4f35728e68a@linaro.org>
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_PASS,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

On Mon, Jun 12, 2023 at 04:33:09PM +0300, Dmitry Baryshkov wrote:
> On 12/06/2023 12:01, Stephan Gerhold wrote:
> > On Mon, Jun 12, 2023 at 08:39:19AM +0300, Dmitry Baryshkov wrote:
> > > APQ8064 has 4 speed bins, each of them having from 4 to 6 categorization
> > > kinds. Provide tables necessary to handle voltage scaling on this SoC.
> > > 
> > > Signed-off-by: Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
> > > ---
> > >   arch/arm/boot/dts/qcom-apq8064.dtsi | 1017 +++++++++++++++++++++++++++
> > >   1 file changed, 1017 insertions(+)
> > > 
> > > diff --git a/arch/arm/boot/dts/qcom-apq8064.dtsi b/arch/arm/boot/dts/qcom-apq8064.dtsi
> > > index 4ef13f3d702b..f35853b59544 100644
> > > --- a/arch/arm/boot/dts/qcom-apq8064.dtsi
> > > +++ b/arch/arm/boot/dts/qcom-apq8064.dtsi
> > > @@ -49,6 +49,9 @@ CPU0: cpu@0 {
> > >   			clocks = <&kraitcc KRAIT_CPU_0>;
> > >   			clock-names = "cpu";
> > >   			clock-latency = <100000>;
> > > +			vdd-mem-supply = <&pm8921_l24>;
> > > +			vdd-dig-supply = <&pm8921_s3>;
> > > +			vdd-core-supply = <&saw0_vreg>;
> > >   			interconnects = <&kraitcc MASTER_KRAIT_L2 &kraitcc SLAVE_KRAIT_L2>;
> > >   			operating-points-v2 = <&cpu_opp_table>;
> > >   			#cooling-cells = <2>;
> > > @@ -66,6 +69,9 @@ CPU1: cpu@1 {
> > >   			clocks = <&kraitcc KRAIT_CPU_1>;
> > >   			clock-names = "cpu";
> > >   			clock-latency = <100000>;
> > > +			vdd-mem-supply = <&pm8921_l24>;
> > > +			vdd-dig-supply = <&pm8921_s3>;
> > > +			vdd-core-supply = <&saw1_vreg>;
> > >   			interconnects = <&kraitcc MASTER_KRAIT_L2 &kraitcc SLAVE_KRAIT_L2>;
> > >   			operating-points-v2 = <&cpu_opp_table>;
> > >   			#cooling-cells = <2>;
> > > @@ -83,6 +89,9 @@ CPU2: cpu@2 {
> > >   			clocks = <&kraitcc KRAIT_CPU_2>;
> > >   			clock-names = "cpu";
> > >   			clock-latency = <100000>;
> > > +			vdd-mem-supply = <&pm8921_l24>;
> > > +			vdd-dig-supply = <&pm8921_s3>;
> > > +			vdd-core-supply = <&saw2_vreg>;
> > >   			interconnects = <&kraitcc MASTER_KRAIT_L2 &kraitcc SLAVE_KRAIT_L2>;
> > >   			operating-points-v2 = <&cpu_opp_table>;
> > >   			#cooling-cells = <2>;
> > > @@ -100,6 +109,9 @@ CPU3: cpu@3 {
> > >   			clocks = <&kraitcc KRAIT_CPU_3>;
> > >   			clock-names = "cpu";
> > >   			clock-latency = <100000>;
> > > +			vdd-mem-supply = <&pm8921_l24>;
> > > +			vdd-dig-supply = <&pm8921_s3>;
> > > +			vdd-core-supply = <&saw3_vreg>;
> > >   			interconnects = <&kraitcc MASTER_KRAIT_L2 &kraitcc SLAVE_KRAIT_L2>;
> > >   			operating-points-v2 = <&cpu_opp_table>;
> > >   			#cooling-cells = <2>;
> > > @@ -132,6 +144,81 @@ cpu_opp_table: opp-table-cpu {
> > >   		opp-384000000 {
> > >   			opp-hz = /bits/ 64 <384000000>;
> > >   			opp-peak-kBps = <384000>;
> > > +			opp-microvolt-speed0-pvs0 = <1050000 1050000 1150000>,
> > > +						    <950000 950000 1150000>,
> > > +						    <950000 950000 975000>;
> > 
> > I think this won't result in the correct switch order without making
> > some changes to the OPP core. In _set_opp() the OPP core does
> > 
> > 	/* Scaling up? Configure required OPPs before frequency */
> > 	if (!scaling_down) {
> > 		_set_required_opps();
> > 		_set_opp_bw();
> > 		opp_table->config_regulators();
> > 	}
> > 
> > 	opp_table->config_clks();
> > 
> > 	/* Scaling down? Configure required OPPs after frequency */
> > 	if (scaling_down) {
> > 		opp_table->config_regulators();
> > 		_set_opp_bw();
> > 		_set_required_opps();
> > 	}
> > 
> > Since the "bandwidth" for the L2 cache is set before the regulators
> > there is a short window where the L2 clock is running at a high
> > frequency with too low voltage, which could potentially cause
> > instability. On downstream this seems to be done in the proper order [1].
> > 
> > I'm not sure if the order in the OPP core is on purpose. If not, you
> > could propose moving the config_regulators() first (for scaling up)
> > and last (for scaling down). This would resolve the problem.
> 
> Nice catch, I missed this ordering point.
> 
> > 
> > The alternative that I've already argued for on IRC in #linux-msm a
> > couple of days ago would be to give the L2 cache (here: "interconnect")
> > an own OPP table where it can describe its voltage requirements,
> > independent from the CPU. That way the icc_set_bw() would be guaranteed
> > to apply the correct voltage before adjusting the L2 cache clock. It
> > looks like the "l2_level" voltages for vdd_dig and vdd_mem are not
> > speedbin/PVS-specific [2] so this would also significantly reduce the DT
> > size, since you wouldn't need to repeat the same vdd_dig/vdd_mem
> > voltages for all of them.
> 
> Yes. I fact our discussion triggered me to do this patchset.
> 
> So, another option would be to have something like the following snippet. Do
> you know if we are allowed to squish additional data into the L2 cache DT
> node?
> 

I suspect no one has tried this before, so only the DT maintainers could
answer this. I would say that it just follows the existing design of
clocks/-supply/OPPs on the CPU nodes. vdd-mem-supply isn't a property of
the CPU, it's a property of the L2 cache so it actually fits better there.

I think the more controversial questions might be:

  - Is a L2 cache really an "interconnect"? I suppose one could argue it
    connects multiple CPU cores to a cluster (similar how a CCI connects
    multiple clusters to a system).

  - What would bind to the l2-cache node? A separate driver? Does that
    work if it sits below the /cpus node?

Thanks,
Stephan
