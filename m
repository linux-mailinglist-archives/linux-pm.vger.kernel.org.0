Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 701176AAD1
	for <lists+linux-pm@lfdr.de>; Tue, 16 Jul 2019 16:47:45 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728137AbfGPOrk (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Tue, 16 Jul 2019 10:47:40 -0400
Received: from foss.arm.com ([217.140.110.172]:35908 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726997AbfGPOrk (ORCPT <rfc822;linux-pm@vger.kernel.org>);
        Tue, 16 Jul 2019 10:47:40 -0400
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 2B8F0337;
        Tue, 16 Jul 2019 07:47:39 -0700 (PDT)
Received: from e107155-lin (e107155-lin.cambridge.arm.com [10.1.196.42])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 281E63F59C;
        Tue, 16 Jul 2019 07:47:36 -0700 (PDT)
Date:   Tue, 16 Jul 2019 15:47:30 +0100
From:   Sudeep Holla <sudeep.holla@arm.com>
To:     Ulf Hansson <ulf.hansson@linaro.org>
Cc:     Lorenzo Pieralisi <Lorenzo.Pieralisi@arm.com>,
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
        Lina Iyer <ilina@codeaurora.org>,
        Viresh Kumar <viresh.kumar@linaro.org>,
        Vincent Guittot <vincent.guittot@linaro.org>,
        Geert Uytterhoeven <geert+renesas@glider.be>,
        Souvik Chakravarty <souvik.chakravarty@arm.com>,
        linux-pm@vger.kernel.org, linux-arm-msm@vger.kernel.org,
        linux-kernel@vger.kernel.org, Lina Iyer <lina.iyer@linaro.org>,
        Andy Gross <andy.gross@linaro.org>,
        Sudeep Holla <sudeep.holla@arm.com>,
        David Brown <david.brown@linaro.org>
Subject: Re: [PATCH 17/18] arm64: dts: Convert to the hierarchical CPU
 topology layout for MSM8916
Message-ID: <20190716144730.GA7250@e107155-lin>
References: <20190513192300.653-1-ulf.hansson@linaro.org>
 <20190513192300.653-18-ulf.hansson@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190513192300.653-18-ulf.hansson@linaro.org>
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

On Mon, May 13, 2019 at 09:22:59PM +0200, Ulf Hansson wrote:
> From: Lina Iyer <lina.iyer@linaro.org>
>
> In the hierarchical layout, we are creating power domains around each CPU
> and describes the idle states for them inside the power domain provider
> node. Note that, the CPU's idle states still needs to be compatible with
> "arm,idle-state".
>
> Furthermore, represent the CPU cluster as a separate master power domain,
> powering the CPU's power domains. The cluster node, contains the idle
> states for the cluster and each idle state needs to be compatible with the
> "domain-idle-state".
>
> If the running platform is using a PSCI FW that supports the OS initiated
> CPU suspend mode, which likely should be the case unless the PSCI FW is
> very old, this change triggers the PSCI driver to enable it.
>
> Cc: Andy Gross <andy.gross@linaro.org>
> Cc: David Brown <david.brown@linaro.org>
> Signed-off-by: Lina Iyer <lina.iyer@linaro.org>
> Co-developed-by: Ulf Hansson <ulf.hansson@linaro.org>
> Signed-off-by: Ulf Hansson <ulf.hansson@linaro.org>
> ---

[...]

> @@ -166,12 +170,57 @@
>  				min-residency-us = <2000>;
>  				local-timer-stop;
>  			};
> +
> +			CLUSTER_RET: cluster-retention {
> +				compatible = "domain-idle-state";
> +				arm,psci-suspend-param = <0x1000010>;
> +				entry-latency-us = <500>;
> +				exit-latency-us = <500>;
> +				min-residency-us = <2000>;
> +			};
> +
> +			CLUSTER_PWRDN: cluster-gdhs {
> +				compatible = "domain-idle-state";
> +				arm,psci-suspend-param = <0x1000030>;
> +				entry-latency-us = <2000>;
> +				exit-latency-us = <2000>;
> +				min-residency-us = <6000>;
> +			};
>  		};
>  	};

I was trying to understand the composition of composite state parameters
in this series and that made me look at these DT examples.

What format does the above platform use ? I tried matching them to
both original as well as extended format and I fail to understand.
Assuming original format:
	State         power_state PowerLevel  StateType     StateID
	SPC           0x40000002   0(core)    0(Retention)  0x2 (Res0 b[29]=1?)
	CLUSTER_RET   0x1000010   1(clusters) 0(Retention)  0x10
	CLUSTER_PWRDN 0x1000030   1(clusters) 0(Retention?) 0x30
Now extended format:
	State         power_state StateType     StateID
	SPC           0x40000002  0(Retention)  0x40000002 (Res0 b[29]=1?)
	CLUSTER_RET   0x1000010   0(Retention)  0x1000010
	CLUSTER_PWRDN 0x1000030   0(Retention?) 0x1000030

What am I missing ?

--
Regards,
Sudeep
