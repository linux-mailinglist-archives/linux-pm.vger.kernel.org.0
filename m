Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 5B95114C852
	for <lists+linux-pm@lfdr.de>; Wed, 29 Jan 2020 10:47:01 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726068AbgA2Jq4 (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Wed, 29 Jan 2020 04:46:56 -0500
Received: from foss.arm.com ([217.140.110.172]:38660 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726010AbgA2Jq4 (ORCPT <rfc822;linux-pm@vger.kernel.org>);
        Wed, 29 Jan 2020 04:46:56 -0500
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 9C2011FB;
        Wed, 29 Jan 2020 01:46:55 -0800 (PST)
Received: from [10.37.12.123] (unknown [10.37.12.123])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 2C0A23F52E;
        Wed, 29 Jan 2020 01:46:46 -0800 (PST)
Subject: Re: [RFC v3 00/10] DDR/L3 Scaling support on SDM845 and SC7180 SoCs
To:     Sibi Sankar <sibis@codeaurora.org>, viresh.kumar@linaro.org,
        sboyd@kernel.org, georgi.djakov@linaro.org, saravanak@google.com
Cc:     nm@ti.com, bjorn.andersson@linaro.org, agross@kernel.org,
        david.brown@linaro.org, robh+dt@kernel.org, mark.rutland@arm.com,
        rjw@rjwysocki.net, linux-arm-msm@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-pm@vger.kernel.org, dianders@chromium.org, mka@chromium.org,
        vincent.guittot@linaro.org, amit.kucheria@linaro.org,
        ulf.hansson@linaro.org
References: <20200127200350.24465-1-sibis@codeaurora.org>
From:   Lukasz Luba <lukasz.luba@arm.com>
Message-ID: <88b3885a-5ddd-b942-c5a5-d560b2f196bd@arm.com>
Date:   Wed, 29 Jan 2020 09:46:44 +0000
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.9.0
MIME-Version: 1.0
In-Reply-To: <20200127200350.24465-1-sibis@codeaurora.org>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

Hi Sibi,

In my opinion this solution depends on not always true assumption that
CPUFreq notification chain will be triggered when there is a frequency
switch. Extending devfreq governor (as in one of the dependent patch
series that you have referred) by attaching to this notification
chain makes sense only when the SchedUtil and fast_switch is not in use.
The Schedutil CPUFreq governor might use the fast_switch from this
driver and the notifications will not be triggered. I have also
commented patch 08/10 which tries to disable it.

Regards,
Lukasz

On 1/27/20 8:03 PM, Sibi Sankar wrote:
> This RFC series aims to extend cpu based scaling support to L3/DDR on
> SDM845 and SC7180 SoCs.
> 
> Patches [1-3] - Blacklist SDM845 and SC7180 in cpufreq-dt-platdev
> Patches [5-7] - Hack in a way to add/remove multiple opp tables to
>                  a single device. I am yet to fix the debugfs to
> 		support multiple opp_tables per device but wanted to
> 		send what was working upstream to get an idea if multiple
> 		opp tables per device is a feature that will be useful
> 		upstream.
> Patches [9-10] - Add the cpu/cpu-ddr/cpu-l3 opp tables for SDM845
>                   and SC7180 SoCs.
> 
> v3:
>   * Migrated to using Saravana's opp-kBps bindings [1]
>   * Fixed some misc comments from Rajendra
>   * Added support for SC7180
> 
> v2:
>   * Incorporated Viresh's comments from:
>   https://lore.kernel.org/lkml/20190410102429.r6j6brm5kspmqxc3@vireshk-i7/
>   https://lore.kernel.org/lkml/20190410112516.gnh77jcwawvld6et@vireshk-i7/
>   * Dropped cpufreq-map passive governor
> 
> Git-branch: https://github.com/QuinAsura/linux/tree/lnext-012420
> 
> Some alternate ways of hosting the opp-tables:
> https://github.com/QuinAsura/linux/commit/50b92bfaadc8f9a0d1e12249646e018bd6d1a9d3
> https://github.com/QuinAsura/linux/commit/3d23d1eefd16ae6d9e3ef91e93e78749d8844e98
> Viresh didn't really like ^^ bindings and they dont really scale well. Just
> including them here for completeness.
> 
> Depends on the following series:
> [1] https://patchwork.kernel.org/cover/11277199/
> [2] https://patchwork.kernel.org/cover/11055499/
> [3] https://patchwork.kernel.org/cover/11326381/
> 
> Sibi Sankar (10):
>    arm64: dts: qcom: sdm845: Add SoC compatible to MTP
>    cpufreq: blacklist SDM845 in cpufreq-dt-platdev
>    cpufreq: blacklist SC7180 in cpufreq-dt-platdev
>    OPP: Add and export helper to update voltage
>    opp: of: export _opp_of_get_opp_desc_node
>    opp: Allow multiple opp_tables to be mapped to a single device
>    opp: Remove multiple attached opp tables from a device
>    cpufreq: qcom: Update the bandwidth levels on frequency change
>    arm64: dts: qcom: sdm845: Add cpu OPP tables
>    arm64: dts: qcom: sc7180: Add cpu OPP tables
> 
>   arch/arm64/boot/dts/qcom/sc7180.dtsi    | 287 +++++++++++++++
>   arch/arm64/boot/dts/qcom/sdm845-mtp.dts |   2 +-
>   arch/arm64/boot/dts/qcom/sdm845.dtsi    | 453 ++++++++++++++++++++++++
>   drivers/cpufreq/cpufreq-dt-platdev.c    |   2 +
>   drivers/cpufreq/qcom-cpufreq-hw.c       | 246 +++++++++++--
>   drivers/opp/core.c                      | 111 +++++-
>   drivers/opp/of.c                        |   3 +-
>   drivers/opp/opp.h                       |   2 +
>   include/linux/pm_opp.h                  |  10 +
>   9 files changed, 1083 insertions(+), 33 deletions(-)
> 
