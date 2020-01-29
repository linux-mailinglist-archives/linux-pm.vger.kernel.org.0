Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id AA67B14CC87
	for <lists+linux-pm@lfdr.de>; Wed, 29 Jan 2020 15:37:57 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726358AbgA2Oh4 (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Wed, 29 Jan 2020 09:37:56 -0500
Received: from mail25.static.mailgun.info ([104.130.122.25]:39015 "EHLO
        mail25.static.mailgun.info" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726339AbgA2Oh4 (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Wed, 29 Jan 2020 09:37:56 -0500
DKIM-Signature: a=rsa-sha256; v=1; c=relaxed/relaxed; d=mg.codeaurora.org; q=dns/txt;
 s=smtp; t=1580308676; h=Message-ID: References: In-Reply-To: Subject:
 Cc: To: From: Date: Content-Transfer-Encoding: Content-Type:
 MIME-Version: Sender; bh=UXI/hhlOLak0WLD4Gd5HAGmNN/toFyZPzE+/lDtDp7s=;
 b=pyD9VsHeT5Yrzlqw4ksamJG8/KAFtod7MvmW09tNYkKFWMUlQNUhQ5Zc4rZ0kI4PWPSrAbHx
 CBCil6+/aME97ZjJxgkFvmOEEh1vyOja/SEvyFsrP4JMF0Hbb81m/uBpG0tbM6Oe+iZPG2G4
 Itnz7ZW3N8ZEo0kCyztbqflxdXo=
X-Mailgun-Sending-Ip: 104.130.122.25
X-Mailgun-Sid: WyI5ZDFmMiIsICJsaW51eC1wbUB2Z2VyLmtlcm5lbC5vcmciLCAiYmU5ZTRhIl0=
Received: from smtp.codeaurora.org (ec2-35-166-182-171.us-west-2.compute.amazonaws.com [35.166.182.171])
 by mxa.mailgun.org with ESMTP id 5e3198c0.7f8308bec880-smtp-out-n01;
 Wed, 29 Jan 2020 14:37:52 -0000 (UTC)
Received: by smtp.codeaurora.org (Postfix, from userid 1001)
        id D1464C4479F; Wed, 29 Jan 2020 14:37:52 +0000 (UTC)
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
        aws-us-west-2-caf-mail-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=2.0 tests=ALL_TRUSTED
        autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.codeaurora.org (localhost.localdomain [127.0.0.1])
        (using TLSv1 with cipher ECDHE-RSA-AES256-SHA (256/256 bits))
        (No client certificate requested)
        (Authenticated sender: sibis)
        by smtp.codeaurora.org (Postfix) with ESMTPSA id 00F6AC43383;
        Wed, 29 Jan 2020 14:37:51 +0000 (UTC)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII;
 format=flowed
Content-Transfer-Encoding: 7bit
Date:   Wed, 29 Jan 2020 20:07:51 +0530
From:   Sibi Sankar <sibis@codeaurora.org>
To:     Lukasz Luba <lukasz.luba@arm.com>
Cc:     viresh.kumar@linaro.org, sboyd@kernel.org,
        georgi.djakov@linaro.org, saravanak@google.com, nm@ti.com,
        bjorn.andersson@linaro.org, agross@kernel.org,
        david.brown@linaro.org, robh+dt@kernel.org, mark.rutland@arm.com,
        rjw@rjwysocki.net, linux-arm-msm@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-pm@vger.kernel.org, dianders@chromium.org, mka@chromium.org,
        vincent.guittot@linaro.org, amit.kucheria@linaro.org,
        ulf.hansson@linaro.org, linux-arm-msm-owner@vger.kernel.org
Subject: Re: [RFC v3 00/10] DDR/L3 Scaling support on SDM845 and SC7180 SoCs
In-Reply-To: <88b3885a-5ddd-b942-c5a5-d560b2f196bd@arm.com>
References: <20200127200350.24465-1-sibis@codeaurora.org>
 <88b3885a-5ddd-b942-c5a5-d560b2f196bd@arm.com>
Message-ID: <57f9a785d93193719ee0b91e43d0922f@codeaurora.org>
X-Sender: sibis@codeaurora.org
User-Agent: Roundcube Webmail/1.3.9
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

Hey Lukasz,
Thanks for taking time to review
the series!

On 2020-01-29 15:16, Lukasz Luba wrote:
> Hi Sibi,
> 
> In my opinion this solution depends on not always true assumption that
> CPUFreq notification chain will be triggered when there is a frequency

This series does not create any
devfreq devices nor use the cpufreq
notification chain. It just relies
on the opening up of required-opps
from being exclusive to gen-pd using
patches 1,2,3 from patch series[1].
With the fast path disabled and
schedutil enabled, this series will
not miss any cpufreq changes.

[1] https://patchwork.kernel.org/cover/11055499/

> switch. Extending devfreq governor (as in one of the dependent patch
> series that you have referred) by attaching to this notification
> chain makes sense only when the SchedUtil and fast_switch is not in 
> use.

fast_switch and cpu notifier chains
are mutually exclusive but schedutil
will still operate in the slow path
IIRC.

> The Schedutil CPUFreq governor might use the fast_switch from this
> driver and the notifications will not be triggered. I have also
> commented patch 08/10 which tries to disable it.
> 
> Regards,
> Lukasz
> 
> On 1/27/20 8:03 PM, Sibi Sankar wrote:
>> This RFC series aims to extend cpu based scaling support to L3/DDR on
>> SDM845 and SC7180 SoCs.
>> 
>> Patches [1-3] - Blacklist SDM845 and SC7180 in cpufreq-dt-platdev
>> Patches [5-7] - Hack in a way to add/remove multiple opp tables to
>>                  a single device. I am yet to fix the debugfs to
>> 		support multiple opp_tables per device but wanted to
>> 		send what was working upstream to get an idea if multiple
>> 		opp tables per device is a feature that will be useful
>> 		upstream.
>> Patches [9-10] - Add the cpu/cpu-ddr/cpu-l3 opp tables for SDM845
>>                   and SC7180 SoCs.
>> 
>> v3:
>>   * Migrated to using Saravana's opp-kBps bindings [1]
>>   * Fixed some misc comments from Rajendra
>>   * Added support for SC7180
>> 
>> v2:
>>   * Incorporated Viresh's comments from:
>>   
>> https://lore.kernel.org/lkml/20190410102429.r6j6brm5kspmqxc3@vireshk-i7/
>>   
>> https://lore.kernel.org/lkml/20190410112516.gnh77jcwawvld6et@vireshk-i7/
>>   * Dropped cpufreq-map passive governor
>> 
>> Git-branch: https://github.com/QuinAsura/linux/tree/lnext-012420
>> 
>> Some alternate ways of hosting the opp-tables:
>> https://github.com/QuinAsura/linux/commit/50b92bfaadc8f9a0d1e12249646e018bd6d1a9d3
>> https://github.com/QuinAsura/linux/commit/3d23d1eefd16ae6d9e3ef91e93e78749d8844e98
>> Viresh didn't really like ^^ bindings and they dont really scale well. 
>> Just
>> including them here for completeness.
>> 
>> Depends on the following series:
>> [1] https://patchwork.kernel.org/cover/11277199/
>> [2] https://patchwork.kernel.org/cover/11055499/
>> [3] https://patchwork.kernel.org/cover/11326381/
>> 
>> Sibi Sankar (10):
>>    arm64: dts: qcom: sdm845: Add SoC compatible to MTP
>>    cpufreq: blacklist SDM845 in cpufreq-dt-platdev
>>    cpufreq: blacklist SC7180 in cpufreq-dt-platdev
>>    OPP: Add and export helper to update voltage
>>    opp: of: export _opp_of_get_opp_desc_node
>>    opp: Allow multiple opp_tables to be mapped to a single device
>>    opp: Remove multiple attached opp tables from a device
>>    cpufreq: qcom: Update the bandwidth levels on frequency change
>>    arm64: dts: qcom: sdm845: Add cpu OPP tables
>>    arm64: dts: qcom: sc7180: Add cpu OPP tables
>> 
>>   arch/arm64/boot/dts/qcom/sc7180.dtsi    | 287 +++++++++++++++
>>   arch/arm64/boot/dts/qcom/sdm845-mtp.dts |   2 +-
>>   arch/arm64/boot/dts/qcom/sdm845.dtsi    | 453 
>> ++++++++++++++++++++++++
>>   drivers/cpufreq/cpufreq-dt-platdev.c    |   2 +
>>   drivers/cpufreq/qcom-cpufreq-hw.c       | 246 +++++++++++--
>>   drivers/opp/core.c                      | 111 +++++-
>>   drivers/opp/of.c                        |   3 +-
>>   drivers/opp/opp.h                       |   2 +
>>   include/linux/pm_opp.h                  |  10 +
>>   9 files changed, 1083 insertions(+), 33 deletions(-)
>> 

-- 
Qualcomm Innovation Center, Inc. is a member of Code Aurora Forum,
a Linux Foundation Collaborative Project.
