Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1035C373858
	for <lists+linux-pm@lfdr.de>; Wed,  5 May 2021 12:09:20 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231899AbhEEKKP (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Wed, 5 May 2021 06:10:15 -0400
Received: from m43-7.mailgun.net ([69.72.43.7]:13771 "EHLO m43-7.mailgun.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S231750AbhEEKKP (ORCPT <rfc822;linux-pm@vger.kernel.org>);
        Wed, 5 May 2021 06:10:15 -0400
DKIM-Signature: a=rsa-sha256; v=1; c=relaxed/relaxed; d=mg.codeaurora.org; q=dns/txt;
 s=smtp; t=1620209358; h=Message-ID: References: In-Reply-To: Subject:
 Cc: To: From: Date: Content-Transfer-Encoding: Content-Type:
 MIME-Version: Sender; bh=/pFeOOQka32uiKGUO61/tAA85g3Y2JLsNoKpfoqaSaM=;
 b=pUjHkSyAmgWkVKLuSPgR5DWWIKFm5yG/yxmX71ZOmAMJR5r40dJiO/lT5xvkb9D/I/dsY/eE
 vfnggAZD0vq02o1SJKuB5t1kRgC62kaLqt1kdCtBSYm14cOAvQKbeJW0EnyO8w6+bJuE9jvi
 74/AdByylx90zbXoaR9+BSqcorw=
X-Mailgun-Sending-Ip: 69.72.43.7
X-Mailgun-Sid: WyI5ZDFmMiIsICJsaW51eC1wbUB2Z2VyLmtlcm5lbC5vcmciLCAiYmU5ZTRhIl0=
Received: from smtp.codeaurora.org
 (ec2-35-166-182-171.us-west-2.compute.amazonaws.com [35.166.182.171]) by
 smtp-out-n07.prod.us-west-2.postgun.com with SMTP id
 60926ece79b6f9e57b0223d3 (version=TLS1.2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256); Wed, 05 May 2021 10:09:18
 GMT
Sender: sibis=codeaurora.org@mg.codeaurora.org
Received: by smtp.codeaurora.org (Postfix, from userid 1001)
        id 3F97DC43460; Wed,  5 May 2021 10:09:18 +0000 (UTC)
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
        aws-us-west-2-caf-mail-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.9 required=2.0 tests=ALL_TRUSTED,BAYES_00
        autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.codeaurora.org (localhost.localdomain [127.0.0.1])
        (using TLSv1 with cipher ECDHE-RSA-AES256-SHA (256/256 bits))
        (No client certificate requested)
        (Authenticated sender: sibis)
        by smtp.codeaurora.org (Postfix) with ESMTPSA id 66FFDC433F1;
        Wed,  5 May 2021 10:09:17 +0000 (UTC)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII;
 format=flowed
Content-Transfer-Encoding: 7bit
Date:   Wed, 05 May 2021 15:39:17 +0530
From:   Sibi Sankar <sibis@codeaurora.org>
To:     Sudeep Holla <sudeep.holla@arm.com>
Cc:     bjorn.andersson@linaro.org, viresh.kumar@linaro.org,
        swboyd@chromium.org, agross@kernel.org, robh+dt@kernel.org,
        rjw@rjwysocki.net, linux-arm-msm@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-pm@vger.kernel.org, dianders@chromium.org, mka@chromium.org
Subject: Re: [PATCH 2/2] arm64: dts: qcom: sc7280: Add cpu OPP tables
In-Reply-To: <20210505084908.3lynedmblmqagr72@bogus>
References: <1619792901-32701-1-git-send-email-sibis@codeaurora.org>
 <1619792901-32701-3-git-send-email-sibis@codeaurora.org>
 <20210504144215.svmrmmsy4jtoixzv@bogus>
 <1fc9fb8d9a94909ff9b7b76d598bd266@codeaurora.org>
 <20210505084908.3lynedmblmqagr72@bogus>
Message-ID: <5cc53032c1f9f4e0170559c006133f47@codeaurora.org>
X-Sender: sibis@codeaurora.org
User-Agent: Roundcube Webmail/1.3.9
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

On 2021-05-05 14:19, Sudeep Holla wrote:
> Hi Sibi,
> 
> On Tue, May 04, 2021 at 11:55:10PM +0530, Sibi Sankar wrote:
>> Hey Sudeep,
>> 
>> Thanks for the review!
>> 
>> On 2021-05-04 20:12, Sudeep Holla wrote:
> 
> [...]
> 
>> >
>> > NACK, this breaks if there is a mismatch from what is read from the
>> > hardware and what is presented in this table above. Either add it from the
>> > some bootloader or other boot code to this table reading from the
>> > hardware/firmware or find a way to link them without this.
>> >
>> > Sorry I had warned long back about this when such links were discussed
>> > as part of interconnect binding.
>> 
>> Not sure why this warrants a NACK, as this was consensus for mapping 
>> cpu
>> freq to DDR/L3 bandwidth votes. (We use the same solution on SDM845 
>> and
>> SC7180). The opp tables are optional and when specified puts in votes 
>> for
>> DDR/L3. In the future the table can be safely dropped when more useful
>> devfreq governors are upstreamed.
>> cpufreq: qcom: Don't add frequencies without an OPP
> 
> (You can always add commit sha to make it easy to search)
> 
> But I am not sure how this is related to the above commit anyways.
> 
>> 
>> I guess your main concern for breakage is ^^ commit? The original 
>> design is
>> to list a super set of frequencies supported by all variants of the 
>> SoC
>> along with the required DDR/L3 bandwidth values. When we run into
>> non-documented frequency we just wouldn't put in bw votes for it which
>> should be fine since the entire opp_table is optional. If this is the 
>> reason
>> for the NACK I can try get it reverted with Matthias's ack.
> 
> No my main concern is this platform uses "qcom-cpufreq-hw" driver and 
> the
> fact that the OPPs are retrieved from the hardware lookup table 
> invalidates
> whatever we have in DT. In short it will be junk and becomes obsolete.

The table provides mapping to bandwidths
which aren't available in the firmware
though. In short we do have to store the
mapping somewhere i.e. a mapping that
lists all possible frequencies to its
bandwidth requirements needs to be present
and using a opp table with the interconnect
bw bindings was the consensus reached.

Given that a duplicate mapping that lists
all possible frequencies to bw is inevitable
and Qualcomm has a way of listing all the
supported frequencies for the SoC, I feel
that dt breakage in the future should be
a non-concern. Not sure why you call it
junk since it solves the perf/power
requirements on SDM845/SC7180 SoCs. When
it becomes obsolete it would mean that
they are better devfreq governors available
upstream and that's a good reason for the
opp tables to go away.

> So what I suggested before is still valid. You simply can't have static
> OPP tables in the DT for this platform. Do get some boot code to fetch 
> the
> same from the h/w LUT and patch to the DT or figure out any other way 
> to
> manage dynamically.

moving the logic to boot loader doesn't
magically fix your concerns though (since
it would also need a superset of available
frequencies). It will suffer from the same
problems with an additional dependency on
firmware propagation in case of breakages
which is something you can avoid for the
simple cpu based scaling solution.

> 
> So NACK still stands for static addition of OPPs to the DT as in this 
> patch.

I'll let Viresh take the call since this
solution is already used on older SoCs.

> 
> --
> Regards,
> Sudeep

-- 
Qualcomm Innovation Center, Inc. is a member of Code Aurora Forum,
a Linux Foundation Collaborative Project.
