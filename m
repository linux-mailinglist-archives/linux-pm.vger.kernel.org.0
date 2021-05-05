Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E00E1373998
	for <lists+linux-pm@lfdr.de>; Wed,  5 May 2021 13:41:24 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232805AbhEELmT (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Wed, 5 May 2021 07:42:19 -0400
Received: from foss.arm.com ([217.140.110.172]:42998 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S232658AbhEELmT (ORCPT <rfc822;linux-pm@vger.kernel.org>);
        Wed, 5 May 2021 07:42:19 -0400
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 9C91631B;
        Wed,  5 May 2021 04:41:22 -0700 (PDT)
Received: from bogus (unknown [10.57.61.118])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id BAB233F70D;
        Wed,  5 May 2021 04:41:20 -0700 (PDT)
Date:   Wed, 5 May 2021 12:41:18 +0100
From:   Sudeep Holla <sudeep.holla@arm.com>
To:     Sibi Sankar <sibis@codeaurora.org>
Cc:     bjorn.andersson@linaro.org, viresh.kumar@linaro.org,
        Sudeep Holla <sudeep.holla@arm.com>, swboyd@chromium.org,
        agross@kernel.org, robh+dt@kernel.org, rjw@rjwysocki.net,
        linux-arm-msm@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-pm@vger.kernel.org,
        dianders@chromium.org, mka@chromium.org
Subject: Re: [PATCH 2/2] arm64: dts: qcom: sc7280: Add cpu OPP tables
Message-ID: <20210505114118.idblntcldomzgmab@bogus>
References: <1619792901-32701-1-git-send-email-sibis@codeaurora.org>
 <1619792901-32701-3-git-send-email-sibis@codeaurora.org>
 <20210504144215.svmrmmsy4jtoixzv@bogus>
 <1fc9fb8d9a94909ff9b7b76d598bd266@codeaurora.org>
 <20210505084908.3lynedmblmqagr72@bogus>
 <5cc53032c1f9f4e0170559c006133f47@codeaurora.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <5cc53032c1f9f4e0170559c006133f47@codeaurora.org>
User-Agent: NeoMutt/20171215
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

On Wed, May 05, 2021 at 03:39:17PM +0530, Sibi Sankar wrote:
> On 2021-05-05 14:19, Sudeep Holla wrote:

[...]

> > But I am not sure how this is related to the above commit anyways.
> >
> > >
> > > I guess your main concern for breakage is ^^ commit? The original
> > > design is
> > > to list a super set of frequencies supported by all variants of the
> > > SoC
> > > along with the required DDR/L3 bandwidth values. When we run into
> > > non-documented frequency we just wouldn't put in bw votes for it which
> > > should be fine since the entire opp_table is optional. If this is
> > > the reason
> > > for the NACK I can try get it reverted with Matthias's ack.
> >
> > No my main concern is this platform uses "qcom-cpufreq-hw" driver and
> > the
> > fact that the OPPs are retrieved from the hardware lookup table
> > invalidates
> > whatever we have in DT. In short it will be junk and becomes obsolete.
>
> The table provides mapping to bandwidths which aren't available in the
> firmware though. In short we do have to store the mapping somewhere i.e. a
> mapping that lists all possible frequencies to its bandwidth requirements
> needs to be present and using a opp table with the interconnect bw bindings
> was the consensus reached.

I understand and that's exactly what I had pointed out earlier when I
mentioned that I had raised this concern previously.

> Given that a duplicate mapping that lists all possible frequencies to bw is
> inevitable

I disagree, it was made inevitable by not listening to all feedback, sorry.

> and Qualcomm has a way of listing all the supported frequencies for the SoC,
> I feel that dt breakage in the future should be a non-concern.

I don't completely understand this TBH. Also my main worry is as we move more
towards abstract scale and/or index based, any addition or deletion of OPPs
results in change in the index or scale. It may be dealt on absolute scale
today everywhere and not a problem *today*, but it will break IMO.

> Not sure why you call it junk since it solves the perf/power requirements on
> SDM845/SC7180 SoCs. When it becomes obsolete it would mean that they are
> better devfreq governors available upstream and that's a good reason for the
> opp tables to go away.
>

Nope, I meant the firmware updates the OPP table underneath for whatever
valid reasons it may have.

> > So what I suggested before is still valid. You simply can't have static
> > OPP tables in the DT for this platform. Do get some boot code to fetch
> > the same from the h/w LUT and patch to the DT or figure out any other way
> > to manage dynamically.
>
> moving the logic to boot loader doesn't magically fix your concerns though
> (since it would also need a superset of available frequencies).


OK that's interesting. I wanted to fetch the exact list from the hardware
every time.

> It will suffer from the same problems with an additional dependency on
> firmware propagation in case of breakages which is something you can avoid
> for the simple cpu based scaling solution.

IMO the cross dependency is one part of problem and fetching the exact list
of OPPs available for the CPU is another. I meant to fix the latter in boot
code. The former is something I assume DT bindings deals with.

> >
> > So NACK still stands for static addition of OPPs to the DT as in this
> > patch.
>
> I'll let Viresh take the call since this solution is already used on older SoCs.

Sure, definitely I am just expressing my concern with NACK and I don't have
the final say 😁.

--
Regards,
Sudeep
