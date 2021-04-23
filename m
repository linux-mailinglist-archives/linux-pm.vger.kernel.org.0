Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E59EE369B2F
	for <lists+linux-pm@lfdr.de>; Fri, 23 Apr 2021 22:17:07 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243798AbhDWURm (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Fri, 23 Apr 2021 16:17:42 -0400
Received: from foss.arm.com ([217.140.110.172]:38832 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S232200AbhDWURl (ORCPT <rfc822;linux-pm@vger.kernel.org>);
        Fri, 23 Apr 2021 16:17:41 -0400
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 6A89711D4;
        Fri, 23 Apr 2021 13:17:03 -0700 (PDT)
Received: from [10.57.2.99] (unknown [10.57.2.99])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 1DB0B3F73B;
        Fri, 23 Apr 2021 13:16:59 -0700 (PDT)
Subject: Re: [RFC PATCH 0/4] Support for passing runtime state idle time to
 TF-A
To:     Sowjanya Komatineni <skomatineni@nvidia.com>
Cc:     sudeep.holla@arm.com, souvik.chakravarty@arm.com,
        thierry.reding@gmail.com, mark.rutland@arm.com,
        lorenzo.pieralisi@arm.com, daniel.lezcano@linaro.org,
        robh+dt@kernel.org, jonathanh@nvidia.com, ksitaraman@nvidia.com,
        sanjayc@nvidia.com, linux-arm-kernel@lists.infradead.org,
        linux-tegra@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-pm@vger.kernel.org, devicetree@vger.kernel.org
References: <1619123448-10138-1-git-send-email-skomatineni@nvidia.com>
From:   Lukasz Luba <lukasz.luba@arm.com>
Message-ID: <064341f7-dce3-5ad4-e69b-9568115035c1@arm.com>
Date:   Fri, 23 Apr 2021 21:16:57 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.9.0
MIME-Version: 1.0
In-Reply-To: <1619123448-10138-1-git-send-email-skomatineni@nvidia.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

Hi Sowjanya,

On 4/22/21 9:30 PM, Sowjanya Komatineni wrote:
> Tegra194 and Tegra186 platforms use separate MCE firmware for CPUs which is
> in charge of deciding on state transition based on target state, state idle
> time, and some other Tegra CPU core cluster states information.
> 
> Current PSCI specification don't have function defined for passing runtime
> state idle time predicted by governor (based on next events and state target
> residency) to ARM trusted firmware.

Do you have some numbers from experiments showing that these idle
governor prediction values, which are passed from kernel to MCE
firmware, are making a good 'guess'?
How much precision (1us? 1ms?) in the values do you need there?

IIRC (probably Rafael's presentations) predicting in the kernel
something like CPU idle time residency is not a trivial thing.

Another idea (depending on DT structure and PSCI bits):
Could this be solved differently, but just having a knowledge that if
the governor requested some C-state, this means governor 'predicted'
an idle residency to be greater that min_residency attached to this
C-state?
Then, when that request shows up in your FW, you know that it must be at
least min_residency because of this C-state id.
It would depend on number of available states, max_residency, scale
that you would choose while assigning values from [0, max_residency]
to each state.
IIRC there can be many state IDs for idle, so it would depend on
number of bits encoding this state, and your needs. Example of
linear scale:
4-bits encoding idle state and max predicted residency 10msec,
that means 10000us / 16 states = 625us/state.
The max_residency might be split differently, using different than
linear function, to have some rage more precised.

Open question is if these idle states must be all represented
in DT, or there is a way of describing a 'set of idle states'
automatically.

Regards,
Lukasz
