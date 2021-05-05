Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2FA71373698
	for <lists+linux-pm@lfdr.de>; Wed,  5 May 2021 10:49:21 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232109AbhEEIuP (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Wed, 5 May 2021 04:50:15 -0400
Received: from foss.arm.com ([217.140.110.172]:40612 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S231430AbhEEIuO (ORCPT <rfc822;linux-pm@vger.kernel.org>);
        Wed, 5 May 2021 04:50:14 -0400
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 6B7F2D6E;
        Wed,  5 May 2021 01:49:18 -0700 (PDT)
Received: from bogus (unknown [10.57.61.118])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 74E243F70D;
        Wed,  5 May 2021 01:49:16 -0700 (PDT)
Date:   Wed, 5 May 2021 09:49:08 +0100
From:   Sudeep Holla <sudeep.holla@arm.com>
To:     Sibi Sankar <sibis@codeaurora.org>
Cc:     bjorn.andersson@linaro.org, viresh.kumar@linaro.org,
        Sudeep Holla <sudeep.holla@arm.com>, swboyd@chromium.org,
        agross@kernel.org, robh+dt@kernel.org, rjw@rjwysocki.net,
        linux-arm-msm@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-pm@vger.kernel.org,
        dianders@chromium.org, mka@chromium.org
Subject: Re: [PATCH 2/2] arm64: dts: qcom: sc7280: Add cpu OPP tables
Message-ID: <20210505084908.3lynedmblmqagr72@bogus>
References: <1619792901-32701-1-git-send-email-sibis@codeaurora.org>
 <1619792901-32701-3-git-send-email-sibis@codeaurora.org>
 <20210504144215.svmrmmsy4jtoixzv@bogus>
 <1fc9fb8d9a94909ff9b7b76d598bd266@codeaurora.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1fc9fb8d9a94909ff9b7b76d598bd266@codeaurora.org>
User-Agent: NeoMutt/20171215
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

Hi Sibi,

On Tue, May 04, 2021 at 11:55:10PM +0530, Sibi Sankar wrote:
> Hey Sudeep,
>
> Thanks for the review!
>
> On 2021-05-04 20:12, Sudeep Holla wrote:

[...]

> >
> > NACK, this breaks if there is a mismatch from what is read from the
> > hardware and what is presented in this table above. Either add it from the
> > some bootloader or other boot code to this table reading from the
> > hardware/firmware or find a way to link them without this.
> >
> > Sorry I had warned long back about this when such links were discussed
> > as part of interconnect binding.
>
> Not sure why this warrants a NACK, as this was consensus for mapping cpu
> freq to DDR/L3 bandwidth votes. (We use the same solution on SDM845 and
> SC7180). The opp tables are optional and when specified puts in votes for
> DDR/L3. In the future the table can be safely dropped when more useful
> devfreq governors are upstreamed.
> cpufreq: qcom: Don't add frequencies without an OPP

(You can always add commit sha to make it easy to search)

But I am not sure how this is related to the above commit anyways.

>
> I guess your main concern for breakage is ^^ commit? The original design is
> to list a super set of frequencies supported by all variants of the SoC
> along with the required DDR/L3 bandwidth values. When we run into
> non-documented frequency we just wouldn't put in bw votes for it which
> should be fine since the entire opp_table is optional. If this is the reason
> for the NACK I can try get it reverted with Matthias's ack.

No my main concern is this platform uses "qcom-cpufreq-hw" driver and the
fact that the OPPs are retrieved from the hardware lookup table invalidates
whatever we have in DT. In short it will be junk and becomes obsolete.
So what I suggested before is still valid. You simply can't have static
OPP tables in the DT for this platform. Do get some boot code to fetch the
same from the h/w LUT and patch to the DT or figure out any other way to
manage dynamically.

So NACK still stands for static addition of OPPs to the DT as in this patch.

--
Regards,
Sudeep
