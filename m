Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id C1DD92E32F
	for <lists+linux-pm@lfdr.de>; Wed, 29 May 2019 19:25:48 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726102AbfE2RZr (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Wed, 29 May 2019 13:25:47 -0400
Received: from usa-sjc-mx-foss1.foss.arm.com ([217.140.101.70]:49932 "EHLO
        foss.arm.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725990AbfE2RZr (ORCPT <rfc822;linux-pm@vger.kernel.org>);
        Wed, 29 May 2019 13:25:47 -0400
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.72.51.249])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 74818341;
        Wed, 29 May 2019 10:25:46 -0700 (PDT)
Received: from redmoon (e121166-lin.cambridge.arm.com [10.1.196.255])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 3D1533F5AF;
        Wed, 29 May 2019 10:25:44 -0700 (PDT)
Date:   Wed, 29 May 2019 18:25:41 +0100
From:   Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>
To:     Marc Gonzalez <marc.w.gonzalez@free.fr>
Cc:     Niklas Cassel <niklas.cassel@linaro.org>,
        Bjorn Andersson <bjorn.andersson@linaro.org>,
        Amit Kucheria <amit.kucheria@linaro.org>,
        Rafael Wysocki <rjw@rjwysocki.net>,
        Daniel Lezcano <daniel.lezcano@linaro.org>,
        MSM <linux-arm-msm@vger.kernel.org>,
        Linux ARM <linux-arm-kernel@lists.infradead.org>,
        PM <linux-pm@vger.kernel.org>,
        Sibi Sankar <sibis@codeaurora.org>,
        Jeffrey Hugo <jhugo@codeaurora.org>,
        Andy Gross <agross@kernel.org>,
        Sudeep Holla <sudeep.holla@arm.com>
Subject: Re: [PATCH v4] arm64: dts: qcom: msm8998: Add PSCI cpuidle low power
 states
Message-ID: <20190529172541.GB25642@redmoon>
References: <346cd9f0-583d-f467-83d0-e73768bf5aac@free.fr>
 <20190523214619.GB25133@centauri>
 <f9aa108f-cb0a-2cee-7fce-e2803dcadb24@free.fr>
 <c41508c7-35b2-aa40-c468-384e51d3d7b6@free.fr>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <c41508c7-35b2-aa40-c468-384e51d3d7b6@free.fr>
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

On Wed, May 29, 2019 at 01:08:44PM +0200, Marc Gonzalez wrote:
> + linux-pm
> 
> On 24/05/2019 14:32, Marc Gonzalez wrote:
> 
> > From: Amit Kucheria <amit.kucheria@linaro.org>
> > 
> > Add device bindings for cpuidle states for cpu devices.
> > 
> > [marc: rebase, fix arm,psci-suspend-param, fix entry-latency-us]
> > Acked-by: Daniel Lezcano <daniel.lezcano@linaro.org>
> > Signed-off-by: Amit Kucheria <amit.kucheria@linaro.org>
> > Signed-off-by: Marc Gonzalez <marc.w.gonzalez@free.fr>
> > ---
> > Changes from v3:
> > - Fixup all 4 entry-latency-us (Niklas)
> > Changes from v2:
> > - Rebase
> > - Fixup arm,psci-suspend-param for power-collapse states (otherwise: reboot)
> > ---
> >  arch/arm64/boot/dts/qcom/msm8998.dtsi | 50 +++++++++++++++++++++++++++
> >  1 file changed, 50 insertions(+)
> > 
> > diff --git a/arch/arm64/boot/dts/qcom/msm8998.dtsi b/arch/arm64/boot/dts/qcom/msm8998.dtsi
> > index 412195b9794c..ac6bd32c0e7d 100644
> > --- a/arch/arm64/boot/dts/qcom/msm8998.dtsi
> > +++ b/arch/arm64/boot/dts/qcom/msm8998.dtsi
> > @@ -78,6 +78,7 @@
> >  			compatible = "arm,armv8";
> >  			reg = <0x0 0x0>;
> >  			enable-method = "psci";
> > +			cpu-idle-states = <&LITTLE_CPU_SLEEP_0 &LITTLE_CPU_SLEEP_1>;
> >  			next-level-cache = <&L2_0>;
> >  			L2_0: l2-cache {
> >  				compatible = "arm,arch-cache";
> > @@ -96,6 +97,7 @@
> >  			compatible = "arm,armv8";
> >  			reg = <0x0 0x1>;
> >  			enable-method = "psci";
> > +			cpu-idle-states = <&LITTLE_CPU_SLEEP_0 &LITTLE_CPU_SLEEP_1>;
> >  			next-level-cache = <&L2_0>;
> >  			L1_I_1: l1-icache {
> >  				compatible = "arm,arch-cache";
> > @@ -110,6 +112,7 @@
> >  			compatible = "arm,armv8";
> >  			reg = <0x0 0x2>;
> >  			enable-method = "psci";
> > +			cpu-idle-states = <&LITTLE_CPU_SLEEP_0 &LITTLE_CPU_SLEEP_1>;
> >  			next-level-cache = <&L2_0>;
> >  			L1_I_2: l1-icache {
> >  				compatible = "arm,arch-cache";
> > @@ -124,6 +127,7 @@
> >  			compatible = "arm,armv8";
> >  			reg = <0x0 0x3>;
> >  			enable-method = "psci";
> > +			cpu-idle-states = <&LITTLE_CPU_SLEEP_0 &LITTLE_CPU_SLEEP_1>;
> >  			next-level-cache = <&L2_0>;
> >  			L1_I_3: l1-icache {
> >  				compatible = "arm,arch-cache";
> > @@ -138,6 +142,7 @@
> >  			compatible = "arm,armv8";
> >  			reg = <0x0 0x100>;
> >  			enable-method = "psci";
> > +			cpu-idle-states = <&BIG_CPU_SLEEP_0 &BIG_CPU_SLEEP_1>;
> >  			next-level-cache = <&L2_1>;
> >  			L2_1: l2-cache {
> >  				compatible = "arm,arch-cache";
> > @@ -156,6 +161,7 @@
> >  			compatible = "arm,armv8";
> >  			reg = <0x0 0x101>;
> >  			enable-method = "psci";
> > +			cpu-idle-states = <&BIG_CPU_SLEEP_0 &BIG_CPU_SLEEP_1>;
> >  			next-level-cache = <&L2_1>;
> >  			L1_I_101: l1-icache {
> >  				compatible = "arm,arch-cache";
> > @@ -170,6 +176,7 @@
> >  			compatible = "arm,armv8";
> >  			reg = <0x0 0x102>;
> >  			enable-method = "psci";
> > +			cpu-idle-states = <&BIG_CPU_SLEEP_0 &BIG_CPU_SLEEP_1>;
> >  			next-level-cache = <&L2_1>;
> >  			L1_I_102: l1-icache {
> >  				compatible = "arm,arch-cache";
> > @@ -184,6 +191,7 @@
> >  			compatible = "arm,armv8";
> >  			reg = <0x0 0x103>;
> >  			enable-method = "psci";
> > +			cpu-idle-states = <&BIG_CPU_SLEEP_0 &BIG_CPU_SLEEP_1>;
> >  			next-level-cache = <&L2_1>;
> >  			L1_I_103: l1-icache {
> >  				compatible = "arm,arch-cache";
> > @@ -230,6 +238,48 @@
> >  				};
> >  			};
> >  		};
> > +
> > +		idle-states {
> > +			entry-method = "psci";
> > +
> > +			LITTLE_CPU_SLEEP_0: cpu-sleep-0-0 {
> > +				compatible = "arm,idle-state";
> > +				idle-state-name = "little-retention";
> > +				arm,psci-suspend-param = <0x00000002>;
> > +				entry-latency-us = <81>;
> > +				exit-latency-us = <86>;
> > +				min-residency-us = <200>;
> > +			};
> > +
> > +			LITTLE_CPU_SLEEP_1: cpu-sleep-0-1 {
> > +				compatible = "arm,idle-state";
> > +				idle-state-name = "little-power-collapse";
> > +				arm,psci-suspend-param = <0x40000003>;
> > +				entry-latency-us = <273>;
> > +				exit-latency-us = <612>;
> > +				min-residency-us = <1000>;
> > +				local-timer-stop;
> > +			};
> > +
> > +			BIG_CPU_SLEEP_0: cpu-sleep-1-0 {
> > +				compatible = "arm,idle-state";
> > +				idle-state-name = "big-retention";
> > +				arm,psci-suspend-param = <0x00000002>;
> > +				entry-latency-us = <79>;
> > +				exit-latency-us = <82>;
> > +				min-residency-us = <200>;
> > +			};
> > +
> > +			BIG_CPU_SLEEP_1: cpu-sleep-1-1 {
> > +				compatible = "arm,idle-state";
> > +				idle-state-name = "big-power-collapse";
> > +				arm,psci-suspend-param = <0x40000003>;
> > +				entry-latency-us = <336>;
> > +				exit-latency-us = <525>;
> > +				min-residency-us = <1000>;
> > +				local-timer-stop;
> > +			};
> > +		};
> 
> Niklas and I have been discussing the min-residency-us prop.
> 
> https://elixir.bootlin.com/linux/latest/source/Documentation/devicetree/bindings/arm/idle-states.txt
> 
> I thought a requirement would be
> 
> 	min-residency > entry-latency + exit-latency
> 
> but it doesn't seem to be the case.
> 
> Do the values proposed here look kosher?

As the document describes the right values should be computed by
plotting energy consumption.

min-residency is a worst case scenario because the energy consumed to
enter an idle state depends on the system state (eg cache state), so the
worst case value should be added there.

Lorenzo
