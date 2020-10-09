Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5159E2885D5
	for <lists+linux-pm@lfdr.de>; Fri,  9 Oct 2020 11:16:24 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1733054AbgJIJQX (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Fri, 9 Oct 2020 05:16:23 -0400
Received: from foss.arm.com ([217.140.110.172]:45660 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1731262AbgJIJQW (ORCPT <rfc822;linux-pm@vger.kernel.org>);
        Fri, 9 Oct 2020 05:16:22 -0400
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id D5C1ED6E;
        Fri,  9 Oct 2020 02:16:21 -0700 (PDT)
Received: from [10.57.51.133] (unknown [10.57.51.133])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id BD9AF3F66B;
        Fri,  9 Oct 2020 02:16:18 -0700 (PDT)
Subject: Re: [PATCH v2 0/3] Clarify abstract scale usage for power values in
 Energy Model, EAS and IPA
To:     rjw@rjwysocki.net
Cc:     linux-kernel@vger.kernel.org, linux-pm@vger.kernel.org,
        linux-doc@vger.kernel.org, devicetree@vger.kernel.org,
        robh+dt@kernel.org, amitk@kernel.org, corbet@lwn.net,
        daniel.lezcano@linaro.org, Dietmar.Eggemann@arm.com,
        qperret@google.com, dianders@chromium.org, mka@chromium.org,
        rnayak@codeaurora.org
References: <20201002114426.31277-1-lukasz.luba@arm.com>
From:   Lukasz Luba <lukasz.luba@arm.com>
Message-ID: <d2960f6a-1805-1fb4-98ae-4a756d20370b@arm.com>
Date:   Fri, 9 Oct 2020 10:16:17 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.9.0
MIME-Version: 1.0
In-Reply-To: <20201002114426.31277-1-lukasz.luba@arm.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

Hi Rafael,

On 10/2/20 12:44 PM, Lukasz Luba wrote:
> Hi all,
> 
> The Energy Model supports power values expressed in an abstract scale.
> This has an impact on Intelligent Power Allocation (IPA) and should be
> documented properly. There is also a need to update the DT binding for the
> 'sustainable-power' and allow it to have abstract scale as well.
> 
> Changes:
> v2:
> - updated sustainable power section in IPA documentation
> - updated DT binding for the 'sustainable-power'
> 
> The v1 of the patch set and related discussion can be found in [1].
> 
> Regards,
> Lukasz Luba
> 
> [1] https://lore.kernel.org/linux-doc/20200929121610.16060-1-lukasz.luba@arm.com/
> 
> Lukasz Luba (3):
>    docs: Clarify abstract scale usage for power values in Energy Model
>    PM / EM: update the comments related to power scale
>    dt-bindings: thermal: update sustainable-power with abstract scale
> 
>   .../devicetree/bindings/thermal/thermal-zones.yaml  | 13 +++++++++----
>   .../driver-api/thermal/power_allocator.rst          | 13 ++++++++++++-
>   Documentation/power/energy-model.rst                | 13 +++++++++++++
>   Documentation/scheduler/sched-energy.rst            |  5 +++++
>   include/linux/energy_model.h                        | 11 +++++------
>   kernel/power/energy_model.c                         |  2 +-
>   6 files changed, 45 insertions(+), 12 deletions(-)
> 

Could you take patch 1/3 and patch 2/3 via your PM tree,
please? I will be very grateful.

These patches just update the documentation and comments regarding
an issue that we can have: bogoWatts in the Energy Model (and we
already have). One of the drawbacks is that we cannot derive real energy
from these numbers. Will see how this would evolve.

The patch 3/3 with dt-binding is not going to fly upstream [1].
I hope developers will put a real number in DT so we could
have real milliWatts from that source (wishful thinking).
Doug even made a script, which might be helpful for that [2].

Regards,
Lukasz

[1] 
https://lore.kernel.org/linux-pm/45fae8cd-0635-41dc-c744-3c9833bf6492@arm.com/
[2] 
https://lore.kernel.org/linux-pm/CAD=FV=U1FP0e3_AVHpauUUZtD-5X3XCwh5aT9fH_8S_FFML2Uw@mail.gmail.com/
