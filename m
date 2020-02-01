Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 9061914F7BB
	for <lists+linux-pm@lfdr.de>; Sat,  1 Feb 2020 13:22:10 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726495AbgBAMWI (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Sat, 1 Feb 2020 07:22:08 -0500
Received: from mail26.static.mailgun.info ([104.130.122.26]:51538 "EHLO
        mail26.static.mailgun.info" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726480AbgBAMWI (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Sat, 1 Feb 2020 07:22:08 -0500
DKIM-Signature: a=rsa-sha256; v=1; c=relaxed/relaxed; d=mg.codeaurora.org; q=dns/txt;
 s=smtp; t=1580559728; h=Message-ID: References: In-Reply-To: Subject:
 Cc: To: From: Date: Content-Transfer-Encoding: Content-Type:
 MIME-Version: Sender; bh=6g00UFIo11fls4SoPhp5QqjHM3g8x0gvkFYVg+qT4ts=;
 b=Xe04GkMw/FRmduzTBL/Bwex3pJq2IMUU7fOmKMqpuupUeKeX4IAq7FMddF6i+rd6x0qJTPIY
 Ch7T8KO3f4/trRQ2H32UYWfr38FZbeqx/B6taVZ0E6APxaJBzB3r+3h+U0r/bX+4lwVbk4fr
 609BkvXZKzAX6FG4F8sSDFFxyhc=
X-Mailgun-Sending-Ip: 104.130.122.26
X-Mailgun-Sid: WyI5ZDFmMiIsICJsaW51eC1wbUB2Z2VyLmtlcm5lbC5vcmciLCAiYmU5ZTRhIl0=
Received: from smtp.codeaurora.org (ec2-35-166-182-171.us-west-2.compute.amazonaws.com [35.166.182.171])
 by mxa.mailgun.org with ESMTP id 5e356d6a.7f4c17c37570-smtp-out-n02;
 Sat, 01 Feb 2020 12:22:02 -0000 (UTC)
Received: by smtp.codeaurora.org (Postfix, from userid 1001)
        id 4A140C447A5; Sat,  1 Feb 2020 12:22:00 +0000 (UTC)
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
        aws-us-west-2-caf-mail-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=2.0 tests=ALL_TRUSTED
        autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.codeaurora.org (localhost.localdomain [127.0.0.1])
        (using TLSv1 with cipher ECDHE-RSA-AES256-SHA (256/256 bits))
        (No client certificate requested)
        (Authenticated sender: sibis)
        by smtp.codeaurora.org (Postfix) with ESMTPSA id 8C0D8C433A2;
        Sat,  1 Feb 2020 12:21:59 +0000 (UTC)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII;
 format=flowed
Content-Transfer-Encoding: 7bit
Date:   Sat, 01 Feb 2020 17:51:59 +0530
From:   Sibi Sankar <sibis@codeaurora.org>
To:     Sudeep Holla <sudeep.holla@arm.com>
Cc:     Matthias Kaehlcke <mka@chromium.org>, viresh.kumar@linaro.org,
        sboyd@kernel.org, georgi.djakov@linaro.org, saravanak@google.com,
        nm@ti.com, bjorn.andersson@linaro.org, agross@kernel.org,
        david.brown@linaro.org, robh+dt@kernel.org, mark.rutland@arm.com,
        rjw@rjwysocki.net, linux-arm-msm@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-pm@vger.kernel.org, dianders@chromium.org,
        vincent.guittot@linaro.org, amit.kucheria@linaro.org,
        ulf.hansson@linaro.org, linux-kernel-owner@vger.kernel.org
Subject: Re: [RFC v3 02/10] cpufreq: blacklist SDM845 in cpufreq-dt-platdev
In-Reply-To: <20200130114004.GA56122@bogus>
References: <20200127200350.24465-1-sibis@codeaurora.org>
 <20200127200350.24465-3-sibis@codeaurora.org>
 <20200128204423.GF46072@google.com> <20200130114004.GA56122@bogus>
Message-ID: <b886c49e4bdab4054d08f10b0d8fa763@codeaurora.org>
X-Sender: sibis@codeaurora.org
User-Agent: Roundcube Webmail/1.3.9
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

Hey Sudeep,

Thanks for the review!

On 2020-01-30 17:10, Sudeep Holla wrote:
> On Tue, Jan 28, 2020 at 12:44:23PM -0800, Matthias Kaehlcke wrote:
>> On Tue, Jan 28, 2020 at 01:33:42AM +0530, Sibi Sankar wrote:
>> > Add SDM845 to cpufreq-dt-platdev blacklist.
>> 
>> nit: you could mention that cpufreq is handled by the
>> 'qcom-cpufreq-hw' driver.
>> 
> 
> IIUC, these platforms get the OPP table from the firmware and there 
> shouldn't
> be OPP entries in the DT. If not, why not fix that to avoid more 
> confusion.
> Can we make cpu0_node_has_opp_v2_prop return false in short.

The entire point of the series is to
define a way of identifying required
opp-kBps values for L3/DDR at different
cpu frequencies. The required-opps is
chosen as the way of showcasing the
dependencies. Hence the need to for a
superset cpu opp-table consisting of
all possible cpu freq values supported
by the family of SoCs and enabling only
the opps that are supported by the board
from the values read back from firmware.

> 
> --
> Regards,
> Sudeep

-- 
Qualcomm Innovation Center, Inc. is a member of Code Aurora Forum,
a Linux Foundation Collaborative Project.
