Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A013A28C473
	for <lists+linux-pm@lfdr.de>; Tue, 13 Oct 2020 00:01:51 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732211AbgJLWBg (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Mon, 12 Oct 2020 18:01:36 -0400
Received: from foss.arm.com ([217.140.110.172]:46380 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727778AbgJLWBf (ORCPT <rfc822;linux-pm@vger.kernel.org>);
        Mon, 12 Oct 2020 18:01:35 -0400
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id C7FCA31B;
        Mon, 12 Oct 2020 15:01:34 -0700 (PDT)
Received: from localhost (unknown [10.1.199.49])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 6999E3F719;
        Mon, 12 Oct 2020 15:01:34 -0700 (PDT)
Date:   Mon, 12 Oct 2020 23:01:33 +0100
From:   Ionela Voinescu <ionela.voinescu@arm.com>
To:     Lukasz Luba <lukasz.luba@arm.com>
Cc:     Rob Herring <robh@kernel.org>,
        Nicola Mazzucato <nicola.mazzucato@arm.com>,
        Viresh Kumar <viresh.kumar@linaro.org>,
        devicetree@vger.kernel.org, linux-pm@vger.kernel.org,
        vireshk@kernel.org, daniel.lezcano@linaro.org, rjw@rjwysocki.net,
        linux-kernel@vger.kernel.org, sudeep.holla@arm.com,
        chris.redpath@arm.com, morten.rasmussen@arm.com,
        linux-arm-kernel@lists.infradead.org
Subject: Re: [PATCH v2 2/2] [RFC] CPUFreq: Add support for
 cpu-perf-dependencies
Message-ID: <20201012220132.GA1715@arm.com>
References: <20201008150317.GB20268@arm.com>
 <56846759-e3a6-9471-827d-27af0c3d410d@arm.com>
 <20201009053921.pkq4pcyrv4r7ylzu@vireshk-i7>
 <42e3c8e9-cadc-d013-1e1f-fa06af4a45ff@arm.com>
 <20201009140141.GA4048593@bogus>
 <2b7b6486-2898-1279-ce9f-9e7bd3512152@arm.com>
 <20201012105945.GA9219@arm.com>
 <500510b9-58f3-90b3-8c95-0ac481d468b5@arm.com>
 <20201012163032.GA30838@arm.com>
 <9fe56600-ba7d-d3b6-eea3-885475d94d7a@arm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <9fe56600-ba7d-d3b6-eea3-885475d94d7a@arm.com>
User-Agent: Mutt/1.9.4 (2018-02-28)
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

Hey Lukasz,

I think after all this discussion (in our own way of describing things)
we agree on how the current cpufreq based FIE implementation is affected
in systems that use hardware coordination.

What we don't agree on is the location where that implementation (that
uses the new mask and aggregation) should be.

On Monday 12 Oct 2020 at 19:19:29 (+0100), Lukasz Luba wrote:
[..]
> The previous FIE implementation where arch_set_freq_scale()
> was called from the drivers, was better suited for this issue.
> Driver could just use internal dependency cpumask or even
> do the aggregation to figure out the max freq for cluster
> if there is a need, before calling arch_set_freq_scale().
> 
> It is not perfect solution for software FIE, but one of possible
> when there is no hw counters.
> 
[..]

> Difference between new FIE and old FIE (from v5.8) is that the new one
> purely relies on schedutil max freq value (which will now be missing),
> while the old FIE was called by the driver and thus it was an option to
> fix only the affected cpufreq driver [1][2].
> 

My final argument is that now you have 2 drivers that would need this
support, next you'll have 3 (the new mediatek driver), and in the future
there will be more. So why limit and duplicate this functionality in the
drivers? Why not make it generic for all drivers to use if the system
is using hardware coordination?

Additionally, I don't think drivers should not even need to know about
these dependency/clock domains. They should act at the level of the
policy, which in this case will be at the level of each CPU.

Thanks,
Ionela.

> IMO we can avoid this new cpumask in policy.
> 
> Regards,
> Lukasz
> 
> [1] https://elixir.bootlin.com/linux/v5.8/source/drivers/cpufreq/scmi-cpufreq.c#L58
> [2] https://elixir.bootlin.com/linux/v5.8/source/drivers/cpufreq/qcom-cpufreq-hw.c#L79
> 
