Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id EF7C6154D16
	for <lists+linux-pm@lfdr.de>; Thu,  6 Feb 2020 21:45:26 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727877AbgBFUpW (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Thu, 6 Feb 2020 15:45:22 -0500
Received: from mail26.static.mailgun.info ([104.130.122.26]:17247 "EHLO
        mail26.static.mailgun.info" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1727831AbgBFUpW (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Thu, 6 Feb 2020 15:45:22 -0500
DKIM-Signature: a=rsa-sha256; v=1; c=relaxed/relaxed; d=mg.codeaurora.org; q=dns/txt;
 s=smtp; t=1581021922; h=In-Reply-To: Content-Type: MIME-Version:
 References: Message-ID: Subject: Cc: To: From: Date: Sender;
 bh=DcZBAjG2VO2WTzYOcZCs8ZVgMYwd7rbCdreK1KsqE9E=; b=IHTk2DDihRdL0gfg2FQLuj88LXfGSeNLzjssQir1pK17BOPaxEFtMxMHYs0V4aZQQTYuedKX
 Y8qkQEjFWPvXCEws1lb6vYElSZHRh9XjnRthlccLYiVuu+GzwTgNzvgSvPsb/b92YnnVsT4a
 4WyT7YpFK1F29HmLS/Th2qctGdk=
X-Mailgun-Sending-Ip: 104.130.122.26
X-Mailgun-Sid: WyI5ZDFmMiIsICJsaW51eC1wbUB2Z2VyLmtlcm5lbC5vcmciLCAiYmU5ZTRhIl0=
Received: from smtp.codeaurora.org (ec2-35-166-182-171.us-west-2.compute.amazonaws.com [35.166.182.171])
 by mxa.mailgun.org with ESMTP id 5e3c7adc.7f666d8d2030-smtp-out-n03;
 Thu, 06 Feb 2020 20:45:16 -0000 (UTC)
Received: by smtp.codeaurora.org (Postfix, from userid 1001)
        id 8F21FC43383; Thu,  6 Feb 2020 20:45:16 +0000 (UTC)
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
        aws-us-west-2-caf-mail-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=2.0 tests=ALL_TRUSTED,SPF_NONE
        autolearn=unavailable autolearn_force=no version=3.4.0
Received: from localhost (i-global254.qualcomm.com [199.106.103.254])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        (Authenticated sender: ilina)
        by smtp.codeaurora.org (Postfix) with ESMTPSA id 6E80CC433CB;
        Thu,  6 Feb 2020 20:45:15 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 smtp.codeaurora.org 6E80CC433CB
Authentication-Results: aws-us-west-2-caf-mail-1.web.codeaurora.org; dmarc=none (p=none dis=none) header.from=codeaurora.org
Authentication-Results: aws-us-west-2-caf-mail-1.web.codeaurora.org; spf=none smtp.mailfrom=ilina@codeaurora.org
Date:   Thu, 6 Feb 2020 13:45:14 -0700
From:   Lina Iyer <ilina@codeaurora.org>
To:     Ulf Hansson <ulf.hansson@linaro.org>
Cc:     Sudeep Holla <sudeep.holla@arm.com>,
        Maulik Shah <mkshah@codeaurora.org>,
        Stephen Boyd <swboyd@chromium.org>,
        Andy Gross <agross@kernel.org>,
        David Brown <david.brown@linaro.org>,
        Lorenzo Pieralisi <Lorenzo.Pieralisi@arm.com>,
        linux-arm-msm <linux-arm-msm@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Linux PM <linux-pm@vger.kernel.org>,
        Linux ARM <linux-arm-kernel@lists.infradead.org>,
        Bjorn Andersson <bjorn.andersson@linaro.org>,
        Evan Green <evgreen@chromium.org>,
        Doug Anderson <dianders@chromium.org>,
        Rajendra Nayak <rnayak@codeaurora.org>, lsrao@codeaurora.org,
        "Rafael J. Wysocki" <rjw@rjwysocki.net>
Subject: Re: [PATCH v3 5/7] drivers: firmware: psci: Add hierarchical domain
 idle states converter
Message-ID: <20200206204514.GB8107@codeaurora.org>
References: <1580736940-6985-1-git-send-email-mkshah@codeaurora.org>
 <1580736940-6985-6-git-send-email-mkshah@codeaurora.org>
 <20200203170832.GA38466@bogus>
 <0d7f7ade-3a1e-5428-d851-f1a886f58712@codeaurora.org>
 <20200204152132.GA44858@bogus>
 <6ff7c82d-4204-a339-4070-0154ab4515f1@codeaurora.org>
 <20200205140603.GB38466@bogus>
 <CAPDyKFoyepN2VX4COMomp1e9dXPozzrgCdcy0paee2jp8Wm3YA@mail.gmail.com>
 <20200205161816.GD38466@bogus>
 <CAPDyKFqaA7oN2+oLS=Puw+jQXke_ErGQAWYuTuU-6PS7mo5YbQ@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Disposition: inline
In-Reply-To: <CAPDyKFqaA7oN2+oLS=Puw+jQXke_ErGQAWYuTuU-6PS7mo5YbQ@mail.gmail.com>
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

On Thu, Feb 06 2020 at 01:46 -0700, Ulf Hansson wrote:
>On Wed, 5 Feb 2020 at 17:18, Sudeep Holla <sudeep.holla@arm.com> wrote:
>>
>> On Wed, Feb 05, 2020 at 04:55:17PM +0100, Ulf Hansson wrote:
>> > On Wed, 5 Feb 2020 at 15:06, Sudeep Holla <sudeep.holla@arm.com> wrote:
>> > >
>> > > On Wed, Feb 05, 2020 at 05:53:00PM +0530, Maulik Shah wrote:
>> > > >
>> > > > On 2/4/2020 8:51 PM, Sudeep Holla wrote:
>> > > > > On Tue, Feb 04, 2020 at 10:22:42AM +0530, Maulik Shah wrote:
>> > > > > > On 2/3/2020 10:38 PM, Sudeep Holla wrote:
>> > > > > > > On Mon, Feb 03, 2020 at 07:05:38PM +0530, Maulik Shah wrote:
>> > > > > > > > From: Ulf Hansson <ulf.hansson@linaro.org>
>> > > > > > > >
>> I was, but not anymore, especially if we want such changes in the kernel
>> to do so.
>>
>> Just use OSI as that was the point of adding all these after years of
>> discussion claiming it's more optimal compared to PC. Now telling that
>> you need more changes to compare it with PC just doesn't make any sense
>> at all to me.
>
>Fair enough.
>
>I was just pondering over if there are other reasons to why we may want this.
>
>One other thing that could be problematic to support, is when are
>other resources, I/O controllers for example, sharing the same power
>rail as a cluster. When such controller is in use, idle states of the
>cluster must be prevented. Without using genpd to model the CPU
>topology, it may be difficult to deal with this.
>
>Of course, using PC mode when trying to deal with this
>platform/board-requirement would also be suboptimal. In other words,
>your argument about when using OSI vs PC mode, still stands.
>
I understand the arguments for using PC vs OSI and agree with it. But
what in PSCI is against Linux knowing when the last core is powering
down when the PSCI is configured to do only Platform Cordinated.
There should not be any objection to drivers knowing when all the cores
are powered down, be it reference counting CPU PM notifications or using
a cleaner approach like this where GendPD framwork does everything
cleanly and gives a nice callback. ARM architecture allows for different
aspects of CPU access be handled at different levels. I see this as an
extension of that approach.

-- Lina
