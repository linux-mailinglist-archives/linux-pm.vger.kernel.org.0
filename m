Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C4CF233CE35
	for <lists+linux-pm@lfdr.de>; Tue, 16 Mar 2021 07:58:17 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235791AbhCPG5q (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Tue, 16 Mar 2021 02:57:46 -0400
Received: from foss.arm.com ([217.140.110.172]:48936 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S235775AbhCPG5S (ORCPT <rfc822;linux-pm@vger.kernel.org>);
        Tue, 16 Mar 2021 02:57:18 -0400
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 33DEAD6E;
        Mon, 15 Mar 2021 23:57:16 -0700 (PDT)
Received: from bogus (unknown [10.163.66.225])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 846613F792;
        Mon, 15 Mar 2021 23:57:12 -0700 (PDT)
Date:   Tue, 16 Mar 2021 06:57:05 +0000
From:   Sudeep Holla <sudeep.holla@arm.com>
To:     Sowjanya Komatineni <skomatineni@nvidia.com>
Cc:     thierry.reding@gmail.com, jonathanh@nvidia.com,
        daniel.lezcano@linaro.org, robh+dt@kernel.org,
        Lorenzo Pieralisi <Lorenzo.Pieralisi@arm.com>,
        Sudeep Holla <sudeep.holla@arm.com>, ksitaraman@nvidia.com,
        sanjayc@nvidia.com, linux-tegra@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-pm@vger.kernel.org,
        devicetree@vger.kernel.org
Subject: Re: [PATCH v1 3/5] dt-bindings: arm: Add cpu-idle-states to Tegra194
 CPU nodes
Message-ID: <20210316065705.bpuhsdjfa5nnwrik@bogus>
References: <1614838092-30398-1-git-send-email-skomatineni@nvidia.com>
 <1614838092-30398-4-git-send-email-skomatineni@nvidia.com>
 <20210308043755.llvdsuz2jwvweovb@bogus>
 <4cebf482-a2f8-5a79-a2f6-4ccd7d31c6ad@nvidia.com>
 <20210311025138.o4ub4j2ss725zpv4@bogus>
 <b31d14ef-81d8-0480-805b-a3cb64404b12@nvidia.com>
 <08ac26c1-8257-4c6d-d274-595fee28a00f@nvidia.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <08ac26c1-8257-4c6d-d274-595fee28a00f@nvidia.com>
User-Agent: NeoMutt/20171215
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

On Fri, Mar 12, 2021 at 02:27:30PM -0800, Sowjanya Komatineni wrote:
> Hi Sudeep,
>
> To make our driver PSCI compliant below are few updates to be done
>
> 1. Standardize passing residency time run-time thru PSCI to ATF.
>

Yes that was my initial understanding, but your previous response was
confusing. I should have read this first.

>     From PSCI specification I only see PSCI_STAT_RESIDENCY and
> PSCI_STAT_COUNT optional functions for PSCI1.0/PSCI1.1
>

Indeed, we don't have any support to pass run-time residency hints in PSCI
today.

>    Can you please help add right people to explore on possible ways to add
> PSCI function for passing corresponding state residency time to ATF?
>

Before we jump to implementation in TF-A we need to get agreement to get this
added to the specification to support in OSPM/Linux. TF-A is just one
implementation of PSCI and may not be only one.

Formally you can raise any specification related queries to
https://developer.arm.com/support or support@arm.com. I will ask the author
of PSCI specification internally to take a look at this thread and chime in
if they can.

> 2. Tegra CPU Idle support definitely need to pass deepest cluster state and
> threshold to MCE firmware from DT and looks like we can move this
> implementation to ATF
>

Yes, I just asked the same question as response to your earlier email. Thanks
for confirming that it can be moved out of OSPM/Linux and DT

>      With both of the above implementation changes Tegra194 driver will be
> PSCI compliant.
>

We still need to get agreement on the specification front 😉.

--
Regards,
Sudeep
