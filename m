Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CBB6772C872
	for <lists+linux-pm@lfdr.de>; Mon, 12 Jun 2023 16:28:15 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238895AbjFLO2N (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Mon, 12 Jun 2023 10:28:13 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37704 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238886AbjFLO1t (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Mon, 12 Jun 2023 10:27:49 -0400
Received: from mail-wm1-x32d.google.com (mail-wm1-x32d.google.com [IPv6:2a00:1450:4864:20::32d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7B0111FD9;
        Mon, 12 Jun 2023 07:26:01 -0700 (PDT)
Received: by mail-wm1-x32d.google.com with SMTP id 5b1f17b1804b1-3f730c1253fso32875905e9.1;
        Mon, 12 Jun 2023 07:26:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1686579959; x=1689171959;
        h=in-reply-to:content-disposition:mime-version:references:subject:cc
         :to:from:date:message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=RjtSEA7DuOPBkcYthmOn7vURof3lAlYXKY7QmKw3HkY=;
        b=Cwt8/EH1kDYTNz09VG4PrLvKE4Vjat0/KE85BrlKV5AzkkxI2MrMsU6Ee4FXxw6pkI
         QehfdZgVRW8OUYq6ch0FzmGsloii12FBSnhvyFUZRZZZOUlZ799TeQPPshjIZgXSgjwb
         OjMG07aw22Llo//b9xxnFVqiAaLA9acC/obL/Zcay9vJqmM1KqxMRJroFiS5+i+lFHy6
         2xo+YbRUi8yjOGJAV7BFsFsEj7S7o41FrovPWQlp/8RL7SADp9MHfFzPxSrw5jIVVkbS
         pw+YorK9pv6oHkr3k3W0SCipwnDrJLyHSz6KjefW/hMgvVSaZgbbGPtcT6E6LYmwriW2
         0BGQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1686579959; x=1689171959;
        h=in-reply-to:content-disposition:mime-version:references:subject:cc
         :to:from:date:message-id:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=RjtSEA7DuOPBkcYthmOn7vURof3lAlYXKY7QmKw3HkY=;
        b=Y/70NrmSd9Jwi/ETn4fRIr/3JcV3OIoYylH8lgl8oLNBwqQ6sSTG9dRgWF4vUSFSMW
         m8dR9QXbQgGoXc3ZwcfnsEC6TJD9zXPApah12lobq7JfILZGC58tSX4sF6GL58U4PPVD
         Hka8fg7/GaZ1PDTrBQDAGtYwsjiTxABC1ygdM6odCOR0Cg3wLKISCOuH2WavS9sszu3M
         zWGEMo3A2hbT+Ex2yGGcmfSCMKWO0kMYtj4oHFa2eTVuhtQxcrFitJbPvKp6gsW2006w
         uw7SXxl2g5bYRpznYbjCquYwk5Az/Dq5Wxh9MKfjt2OAtf8pyS2U26x9KKJJKa6DrSGF
         CU+A==
X-Gm-Message-State: AC+VfDyp2TzBIPr7ptCAvFipxkUsGwG166Xdg4wik/n/GkR9CFNaqP7/
        TQFJrfiPmA5U+DcIUQdl6JU=
X-Google-Smtp-Source: ACHHUZ7Omyn97pOg8e3cGLPeeyE8qSbQSLg1G/lz5tM5DYso6n8pXS79Aq6p5zBQ9so0adBrOJ4W8Q==
X-Received: by 2002:adf:e310:0:b0:306:3912:a7f0 with SMTP id b16-20020adfe310000000b003063912a7f0mr4144949wrj.50.1686579958579;
        Mon, 12 Jun 2023 07:25:58 -0700 (PDT)
Received: from Ansuel-xps. (93-34-93-173.ip49.fastwebnet.it. [93.34.93.173])
        by smtp.gmail.com with ESMTPSA id q7-20020adff947000000b0030af72bca98sm12584038wrr.103.2023.06.12.07.25.57
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 12 Jun 2023 07:25:58 -0700 (PDT)
Message-ID: <64872af6.df0a0220.53d8a.9284@mx.google.com>
X-Google-Original-Message-ID: <ZIZHoO0e6gZtRP2B@Ansuel-xps.>
Date:   Mon, 12 Jun 2023 00:16:00 +0200
From:   Christian Marangi <ansuelsmth@gmail.com>
To:     Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
Cc:     Stephan Gerhold <stephan@gerhold.net>,
        Rob Herring <robh+dt@kernel.org>,
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
        linux-pm@vger.kernel.org, linux-clk@vger.kernel.org
Subject: Re: [PATCH 15/18] ARM: dts: qcom: apq8064: provide voltage scaling
 tables
References: <20230612053922.3284394-1-dmitry.baryshkov@linaro.org>
 <20230612053922.3284394-16-dmitry.baryshkov@linaro.org>
 <ZIbez4RA0OoVfHzt@gerhold.net>
 <8c1085fd-8a73-d192-6624-d4f35728e68a@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <8c1085fd-8a73-d192-6624-d4f35728e68a@linaro.org>
X-Spam-Status: No, score=-1.1 required=5.0 tests=BAYES_00,DATE_IN_PAST_12_24,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=no autolearn_force=no version=3.4.6
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

I have a similar implementation with the l2 devfreq driver where I need
to put a compatible in the l2-cache node. From what I observed, keeping
the l2-cache node in the cpus node makes the extra compile not work
(nothing is probed) but moving the l2-cache node in the soc node and
referencing the phandle makes the compatible correctly works and that
doesn't seems to cause any problem. IMHO it would be better to have a
separate opp table for l2, should keep things more organized.

> CPU0: cpu@0 {
>     vdd-core-supply = <&saw0_vreg>;
>     interconnects = <&L2 MASTER_KRAIT_L2 &L2 SLAVE_KRAIT_L2>;
>     operating-points-v2 = <&cpu_opp_table>;
> };
> 
> L2: l2-cache {
>     compatible = "qcom,apq8064-l2-cache", "cache";
> 
>     clocks = <&kraitcc KRAIT_L2>;
>     vdd-mem-supply = <&pm8921_l24>;
>     vdd-dig-supply = <&pm8921_s3>;
>     operating-points-v2 = <&l2_opp_table>;
> 
>     l2_opp_table {
>         compatible = "operating-points-v2";
>         opp-384000000 {
>             opp-hz = /bits/ 64 <384000000>;
>             opp-microvolt = <1050000 1050000 1150000>,
>                             <950000 950000 1150000>;
>         };
> 
>         opp-648000000 {
>             opp-hz = /bits/ 64 <648000000>;
>             opp-microvolt = <1050000 1050000 1150000>,
>                             <1050000 1050000 1150000>;
>         };
> 
>         opp-1134000000 {
>             opp-hz = /bits/ 64 <1134000000>;
>             opp-microvolt = <1150000 1150000 1150000>,
>                             <1150000 1150000 1150000>;
>         };
>     };
> };
> 
> > 
> > Thanks,
> > Stephan
> > 
> > [1]: https://git.codelinaro.org/clo/la/kernel/msm/-/blob/LA.AF.1.2.1-08410-8064.0/arch/arm/mach-msm/acpuclock-krait.c#L529-588
> > [2]: https://git.codelinaro.org/clo/la/kernel/msm/-/blob/LA.AF.1.2.1-08410-8064.0/arch/arm/mach-msm/acpuclock-8064.c#L118-135
> 
> -- 
> With best wishes
> Dmitry
> 

-- 
	Ansuel
