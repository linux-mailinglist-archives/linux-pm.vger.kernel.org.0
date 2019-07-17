Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 2D73A6C042
	for <lists+linux-pm@lfdr.de>; Wed, 17 Jul 2019 19:19:04 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726063AbfGQRTC (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Wed, 17 Jul 2019 13:19:02 -0400
Received: from foss.arm.com ([217.140.110.172]:49330 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725873AbfGQRTC (ORCPT <rfc822;linux-pm@vger.kernel.org>);
        Wed, 17 Jul 2019 13:19:02 -0400
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id ACFB728;
        Wed, 17 Jul 2019 10:19:01 -0700 (PDT)
Received: from e107155-lin (e107155-lin.cambridge.arm.com [10.1.196.42])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id C30D73F71F;
        Wed, 17 Jul 2019 10:18:58 -0700 (PDT)
Date:   Wed, 17 Jul 2019 18:18:56 +0100
From:   Sudeep Holla <sudeep.holla@arm.com>
To:     Lina Iyer <ilina@codeaurora.org>
Cc:     Ulf Hansson <ulf.hansson@linaro.org>,
        Lorenzo Pieralisi <Lorenzo.Pieralisi@arm.com>,
        Mark Rutland <mark.rutland@arm.com>,
        linux-arm-kernel@lists.infradead.org,
        "Rafael J . Wysocki" <rjw@rjwysocki.net>,
        Daniel Lezcano <daniel.lezcano@linaro.org>,
        "Raju P . L . S . S . S . N" <rplsssn@codeaurora.org>,
        Amit Kucheria <amit.kucheria@linaro.org>,
        Bjorn Andersson <bjorn.andersson@linaro.org>,
        Stephen Boyd <sboyd@kernel.org>,
        Niklas Cassel <niklas.cassel@linaro.org>,
        Tony Lindgren <tony@atomide.com>,
        Kevin Hilman <khilman@kernel.org>,
        Viresh Kumar <viresh.kumar@linaro.org>,
        Vincent Guittot <vincent.guittot@linaro.org>,
        Geert Uytterhoeven <geert+renesas@glider.be>,
        Souvik Chakravarty <souvik.chakravarty@arm.com>,
        linux-pm@vger.kernel.org, linux-arm-msm@vger.kernel.org,
        linux-kernel@vger.kernel.org, Lina Iyer <lina.iyer@linaro.org>,
        Andy Gross <andy.gross@linaro.org>,
        David Brown <david.brown@linaro.org>
Subject: Re: [PATCH 17/18] arm64: dts: Convert to the hierarchical CPU
 topology layout for MSM8916
Message-ID: <20190717171856.GF18370@e107155-lin>
References: <20190513192300.653-1-ulf.hansson@linaro.org>
 <20190513192300.653-18-ulf.hansson@linaro.org>
 <20190716144730.GA7250@e107155-lin>
 <20190716203631.GC25567@codeaurora.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190716203631.GC25567@codeaurora.org>
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

On Tue, Jul 16, 2019 at 02:36:31PM -0600, Lina Iyer wrote:
> On Tue, Jul 16 2019 at 08:47 -0600, Sudeep Holla wrote:
> > On Mon, May 13, 2019 at 09:22:59PM +0200, Ulf Hansson wrote:
> > > From: Lina Iyer <lina.iyer@linaro.org>
> > >
> > > In the hierarchical layout, we are creating power domains around each CPU
> > > and describes the idle states for them inside the power domain provider
> > > node. Note that, the CPU's idle states still needs to be compatible with
> > > "arm,idle-state".
> > >
> > > Furthermore, represent the CPU cluster as a separate master power domain,
> > > powering the CPU's power domains. The cluster node, contains the idle
> > > states for the cluster and each idle state needs to be compatible with the
> > > "domain-idle-state".
> > >
> > > If the running platform is using a PSCI FW that supports the OS initiated
> > > CPU suspend mode, which likely should be the case unless the PSCI FW is
> > > very old, this change triggers the PSCI driver to enable it.
> > >
> > > Cc: Andy Gross <andy.gross@linaro.org>
> > > Cc: David Brown <david.brown@linaro.org>
> > > Signed-off-by: Lina Iyer <lina.iyer@linaro.org>
> > > Co-developed-by: Ulf Hansson <ulf.hansson@linaro.org>
> > > Signed-off-by: Ulf Hansson <ulf.hansson@linaro.org>
> > > ---
> >
> > [...]
> >
> > > @@ -166,12 +170,57 @@
> > >  				min-residency-us = <2000>;
> > >  				local-timer-stop;
> > >  			};
> > > +
> > > +			CLUSTER_RET: cluster-retention {
> > > +				compatible = "domain-idle-state";
> > > +				arm,psci-suspend-param = <0x1000010>;
> > > +				entry-latency-us = <500>;
> > > +				exit-latency-us = <500>;
> > > +				min-residency-us = <2000>;
> > > +			};
> > > +
> > > +			CLUSTER_PWRDN: cluster-gdhs {
> > > +				compatible = "domain-idle-state";
> > > +				arm,psci-suspend-param = <0x1000030>;
> > > +				entry-latency-us = <2000>;
> > > +				exit-latency-us = <2000>;
> > > +				min-residency-us = <6000>;
> > > +			};
> > >  		};
> > >  	};
> >
> > I was trying to understand the composition of composite state parameters
> > in this series and that made me look at these DT examples.
> >
> This was meant to depict a hierarchical state format for OSI.
>

Hmm, I am more confused. We have 2 formats: original and extended.

1. Original:
	31:26 Reserved. Must be zero.
	25:24 PowerLevel
	23:17 Reserved. Must be zero.
	16 StateType
	15:0 StateID
2. Extended
	31 Reserved. Must be zero.
	30 StateType
	29:28 Reserved. Must be zero.
	27:0 StateID

I was trying to match them to that. I think I commented on other patches.
I think simple OR logic breaks with extended format easily if StateIDs
are not carefully crafted which is not mandated and hence the trouble.
The same holds to original format but with PowerLevel, it slightly
relaxing things a bit but still it needs to be crafted when firmware
decides these parameters. E.g.: what is done with HiKey platform is
completely wrong.

It's helpful if we want to avoid save/restore for retention states.
CPU_PM_CPU_IDLE_ENTER_RETENTION vs CPU_PM_CPU_IDLE_ENTER

> > What format does the above platform use ? I tried matching them to
> > both original as well as extended format and I fail to understand.
> > Assuming original format:
> > 	State         power_state PowerLevel  StateType     StateID
> > 	SPC           0x40000002   0(core)    0(Retention)  0x2 (Res0 b[29]=1?)
> > 	CLUSTER_RET   0x1000010   1(clusters) 0(Retention)  0x10
> > 	CLUSTER_PWRDN 0x1000030   1(clusters) 0(Retention?) 0x30
> > Now extended format:
> > 	State         power_state StateType     StateID
> > 	SPC           0x40000002  0(Retention)  0x40000002 (Res0 b[29]=1?)
> > 	CLUSTER_RET   0x1000010   0(Retention)  0x1000010
> The composite state would comprise of CPU state and  Cluster state.
> So for the last CPU entering idle -
> (CLUSTER_RET | SPC)
> 0x41000012
> > 	CLUSTER_PWRDN 0x1000030   0(Retention?) 0x1000030
> >
> (CLUSTER_PWRDN | SPC)
> 0x41000032
>
> Hope this helps.
>

I just follow OR logic. I have made wrong reference to bit 29 above(I
can't read simple 32 bit number anymore :(), it should bit 30 and if
this platform follow extended state, then it makes some sense. But
I expect CLUSTER_PWRDN also to have bit 30 set. I tried to match to both
formats and failed to understand which it follows, so thought of asking.

--
Regards,
Sudeep
