Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7B32433CE76
	for <lists+linux-pm@lfdr.de>; Tue, 16 Mar 2021 08:19:06 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231311AbhCPHSe (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Tue, 16 Mar 2021 03:18:34 -0400
Received: from foss.arm.com ([217.140.110.172]:50050 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S231630AbhCPHSS (ORCPT <rfc822;linux-pm@vger.kernel.org>);
        Tue, 16 Mar 2021 03:18:18 -0400
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 12BABD6E;
        Tue, 16 Mar 2021 00:18:18 -0700 (PDT)
Received: from bogus (unknown [10.163.66.225])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 443473F792;
        Tue, 16 Mar 2021 00:18:14 -0700 (PDT)
Date:   Tue, 16 Mar 2021 07:18:11 +0000
From:   Sudeep Holla <sudeep.holla@arm.com>
To:     Sowjanya Komatineni <skomatineni@nvidia.com>
Cc:     thierry.reding@gmail.com, jonathanh@nvidia.com,
        daniel.lezcano@linaro.org, robh+dt@kernel.org,
        ksitaraman@nvidia.com, sanjayc@nvidia.com,
        Lorenzo Pieralisi <Lorenzo.Pieralisi@arm.com>,
        Sudeep Holla <Sudeep.Holla@arm.com>,
        linux-tegra@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-pm@vger.kernel.org, devicetree@vger.kernel.org
Subject: Re: [PATCH v1 3/5] dt-bindings: arm: Add cpu-idle-states to Tegra194
 CPU nodes
Message-ID: <20210316071811.5mqcatmmbvrask2p@bogus>
References: <1614838092-30398-1-git-send-email-skomatineni@nvidia.com>
 <1614838092-30398-4-git-send-email-skomatineni@nvidia.com>
 <20210308043755.llvdsuz2jwvweovb@bogus>
 <4cebf482-a2f8-5a79-a2f6-4ccd7d31c6ad@nvidia.com>
 <20210311025138.o4ub4j2ss725zpv4@bogus>
 <b31d14ef-81d8-0480-805b-a3cb64404b12@nvidia.com>
 <08ac26c1-8257-4c6d-d274-595fee28a00f@nvidia.com>
 <4b21f4c7-19cd-fcea-dd1b-9203be60a523@nvidia.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <4b21f4c7-19cd-fcea-dd1b-9203be60a523@nvidia.com>
User-Agent: NeoMutt/20171215
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

On Mon, Mar 15, 2021 at 11:13:24AM -0700, Sowjanya Komatineni wrote:
> Hi Sudeep,
>
> I see you are one of the maintainer of PSCI driver. Please add any other
> right persons if you think should also agree/comment.
>
> Can you please comment on below 2 items based on your feedback?
>
> 1. Can you please suggest on proper way of generalizing to pass state
> residency time run-time along with state during state enter?
>
> Not sure if any other drivers need this but for Tegra as MCE firmware is
> in-charge of states enter and decisions, passing run-time state residency
> from kernel to ATF is required and agree on not using power_state value for
> this which is against PSCI spec.
>

Yes, I prefer you need to get this added in the PSCI specification.
I have passed this thread to the author of the specification.

> 2. Regarding state thresholds, although state thresholds are policy related
> in Tegra cpu idle perspective these thresholds are platform specific based
> on use case and mainly for MCE firmware usage to decide on state transitions
> for core and core clusters as well.
>
From previous emails, I gather these can be moved to firmware and need not be
there in DT ?

> As these are Tegra platform specific, Please comment if any other concerns
> in having this configured by Tegra CPU Idle kernel driver.
>

I prefer not to have Tegra specific idle driver if we can get the necessary
changes in PSCI spec. We must then have just one PSCI idle driver in the
kernel.


> Based on my understanding only above issue-1 is PSCI compliant related.
> Please confirm.
>

Correct.

--
Regards,
Sudeep
