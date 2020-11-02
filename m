Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id AD7502A2671
	for <lists+linux-pm@lfdr.de>; Mon,  2 Nov 2020 09:54:49 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728266AbgKBIyp (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Mon, 2 Nov 2020 03:54:45 -0500
Received: from foss.arm.com ([217.140.110.172]:56080 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728254AbgKBIyp (ORCPT <rfc822;linux-pm@vger.kernel.org>);
        Mon, 2 Nov 2020 03:54:45 -0500
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 548E5101E;
        Mon,  2 Nov 2020 00:54:44 -0800 (PST)
Received: from [10.57.13.99] (unknown [10.57.13.99])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 458FE3F718;
        Mon,  2 Nov 2020 00:54:39 -0800 (PST)
Subject: Re: [PATCH v3 0/4] Clarify abstract scale usage for power values in
 Energy Model, EAS and IPA
To:     linux-kernel@vger.kernel.org, linux-pm@vger.kernel.org,
        linux-doc@vger.kernel.org, devicetree@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, daniel.lezcano@linaro.org,
        qperret@google.com
Cc:     robh+dt@kernel.org, amitk@kernel.org, corbet@lwn.net,
        Dietmar.Eggemann@arm.com, morten.rasmussen@arm.com,
        dianders@chromium.org, mka@chromium.org, rnayak@codeaurora.org,
        rafael@kernel.org, sudeep.holla@arm.com, viresh.kumar@linaro.org,
        sboyd@kernel.org, nm@ti.com
References: <20201019140601.3047-1-lukasz.luba@arm.com>
From:   Lukasz Luba <lukasz.luba@arm.com>
Message-ID: <d3c64655-dc31-73dc-8483-bf5805a9d389@arm.com>
Date:   Mon, 2 Nov 2020 08:54:38 +0000
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.9.0
MIME-Version: 1.0
In-Reply-To: <20201019140601.3047-1-lukasz.luba@arm.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org



On 10/19/20 3:05 PM, Lukasz Luba wrote:
> Hi all,
> 
> The Energy Model supports power values expressed in an abstract scale.
> This has an impact on Intelligent Power Allocation (IPA) and should be
> documented properly. Kernel sub-systems like EAS, IPA and DTPM
> (new comming PowerCap framework) would use the new flag to capture
> potential miss-configuration where the devices have registered different
> power scales, thus cannot operate together.
> 
> There was a discussion below v2 of this patch series, which might help
> you to get context of these changes [2].
> 
> The agreed approach is to have the DT as a source of power values expressed
> always in milli-Watts and the only way to submit with abstract scale values
> is via the em_dev_register_perf_domain() API.
> 
> Changes:
> v3:
> - added boolean flag to struct em_perf_domain and registration function
>    indicating if EM holds real power values in milli-Watts (suggested by
>    Daniel and aggreed with Quentin)
> - updated documentation regarding this new flag
> - dropped DT binding change for 'sustainable-power'
> - added more maintainers on CC (due to patch 1/4 touching different things)
> v2 [2]:
> - updated sustainable power section in IPA documentation
> - updated DT binding for the 'sustainable-power'
> v1 [1]:
> - simple documenation update with new 'abstract scale' in EAS, EM, IPA
> 
> Regards,
> Lukasz Luba
> 
> [1] https://lore.kernel.org/linux-doc/20200929121610.16060-1-lukasz.luba@arm.com/
> [2] https://lore.kernel.org/lkml/20201002114426.31277-1-lukasz.luba@arm.com/
> 
> Lukasz Luba (4):
>    PM / EM: Add a flag indicating units of power values in Energy Model
>    docs: Clarify abstract scale usage for power values in Energy Model
>    PM / EM: update the comments related to power scale
>    docs: power: Update Energy Model with new flag indicating power scale
> 
>   .../driver-api/thermal/power_allocator.rst    | 13 +++++++-
>   Documentation/power/energy-model.rst          | 30 +++++++++++++++----
>   Documentation/scheduler/sched-energy.rst      |  5 ++++
>   drivers/cpufreq/scmi-cpufreq.c                |  3 +-
>   drivers/opp/of.c                              |  2 +-
>   include/linux/energy_model.h                  | 20 ++++++++-----
>   kernel/power/energy_model.c                   | 26 ++++++++++++++--
>   7 files changed, 81 insertions(+), 18 deletions(-)
> 


Gentle ping to Quentin and Daniel for sharing opinion on this patch set.
If you are OK, then I could use this as a base for next work.

As you probably know I am working also on 'sustainable power' estimation
which could be used when there is no DT value but it comes from FW.
That would meet requirement from Doug, when the DT cannot be used,
but we have sustainable levels from FW [1].

Regards,
Lukasz

[1] https://lore.kernel.org/lkml/20201028140847.1018-5-lukasz.luba@arm.com/
