Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id F1D9A14CC4A
	for <lists+linux-pm@lfdr.de>; Wed, 29 Jan 2020 15:22:08 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726865AbgA2OWF (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Wed, 29 Jan 2020 09:22:05 -0500
Received: from mail26.static.mailgun.info ([104.130.122.26]:33365 "EHLO
        mail26.static.mailgun.info" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726856AbgA2OWF (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Wed, 29 Jan 2020 09:22:05 -0500
DKIM-Signature: a=rsa-sha256; v=1; c=relaxed/relaxed; d=mg.codeaurora.org; q=dns/txt;
 s=smtp; t=1580307724; h=Message-ID: References: In-Reply-To: Subject:
 Cc: To: From: Date: Content-Transfer-Encoding: Content-Type:
 MIME-Version: Sender; bh=IDT6XEpptolSA5GAweBHLJ1Npa9q5AS8n9iMKmwahvI=;
 b=vmMWBLG/zjGDUenAwIb4vBDTR2G5jkmFWcdGukLMVUGkCNDIo+b7rO8hXscd80L8xba3TwIe
 j6u0I//p8nwskiHbEihLQm41AnBrBcIp+am1ejFemrWj36RGPhTF4sJTQxwwWcidULrWOBsW
 lcYmRqA0fWijw4y07r7lAPIysTk=
X-Mailgun-Sending-Ip: 104.130.122.26
X-Mailgun-Sid: WyI5ZDFmMiIsICJsaW51eC1wbUB2Z2VyLmtlcm5lbC5vcmciLCAiYmU5ZTRhIl0=
Received: from smtp.codeaurora.org (ec2-35-166-182-171.us-west-2.compute.amazonaws.com [35.166.182.171])
 by mxa.mailgun.org with ESMTP id 5e31950b.7f7972043928-smtp-out-n02;
 Wed, 29 Jan 2020 14:22:03 -0000 (UTC)
Received: by smtp.codeaurora.org (Postfix, from userid 1001)
        id A31E4C447A6; Wed, 29 Jan 2020 14:22:01 +0000 (UTC)
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
        aws-us-west-2-caf-mail-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=2.0 tests=ALL_TRUSTED
        autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.codeaurora.org (localhost.localdomain [127.0.0.1])
        (using TLSv1 with cipher ECDHE-RSA-AES256-SHA (256/256 bits))
        (No client certificate requested)
        (Authenticated sender: sibis)
        by smtp.codeaurora.org (Postfix) with ESMTPSA id C4A90C447A4;
        Wed, 29 Jan 2020 14:21:59 +0000 (UTC)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII;
 format=flowed
Content-Transfer-Encoding: 7bit
Date:   Wed, 29 Jan 2020 19:51:59 +0530
From:   Sibi Sankar <sibis@codeaurora.org>
To:     Rob Clark <robdclark@gmail.com>
Cc:     Viresh Kumar <viresh.kumar@linaro.org>,
        Stephen Boyd <sboyd@kernel.org>,
        Georgi Djakov <georgi.djakov@linaro.org>, saravanak@google.com,
        "Menon, Nishanth" <nm@ti.com>,
        Bjorn Andersson <bjorn.andersson@linaro.org>,
        Andy Gross <agross@kernel.org>,
        David Brown <david.brown@linaro.org>,
        Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Rafael Wysocki <rjw@rjwysocki.net>,
        linux-arm-msm <linux-arm-msm@vger.kernel.org>,
        "open list:OPEN FIRMWARE AND FLATTENED DEVICE TREE BINDINGS" 
        <devicetree@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Linux PM <linux-pm@vger.kernel.org>,
        Douglas Anderson <dianders@chromium.org>,
        Matthias Kaehlcke <mka@chromium.org>,
        Vincent Guittot <vincent.guittot@linaro.org>,
        Amit Kucheria <amit.kucheria@linaro.org>,
        Ulf Hansson <ulf.hansson@linaro.org>,
        Jordan Crouse <jcrouse@codeaurora.org>,
        Sharat Masetty <smasetty@codeaurora.org>,
        linux-arm-msm-owner@vger.kernel.org
Subject: Re: [RFC v3 00/10] DDR/L3 Scaling support on SDM845 and SC7180 SoCs
In-Reply-To: <CAF6AEGuhKKbmK7xGX2RT=LbGz_r_4LsPOuU3-mj4gfhX3EBU-Q@mail.gmail.com>
References: <20200127200350.24465-1-sibis@codeaurora.org>
 <CAF6AEGuhKKbmK7xGX2RT=LbGz_r_4LsPOuU3-mj4gfhX3EBU-Q@mail.gmail.com>
Message-ID: <845c9045cd3462164fdd8f0550a2fea1@codeaurora.org>
X-Sender: sibis@codeaurora.org
User-Agent: Roundcube Webmail/1.3.9
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

Hey Rob,

On 2020-01-29 08:24, Rob Clark wrote:
> On Mon, Jan 27, 2020 at 12:05 PM Sibi Sankar <sibis@codeaurora.org> 
> wrote:
>> 
>> This RFC series aims to extend cpu based scaling support to L3/DDR on
>> SDM845 and SC7180 SoCs.
>> 
>> Patches [1-3] - Blacklist SDM845 and SC7180 in cpufreq-dt-platdev
>> Patches [5-7] - Hack in a way to add/remove multiple opp tables to
>>                 a single device. I am yet to fix the debugfs to
>>                 support multiple opp_tables per device but wanted to
>>                 send what was working upstream to get an idea if 
>> multiple
>>                 opp tables per device is a feature that will be useful
>>                 upstream.
>> Patches [9-10] - Add the cpu/cpu-ddr/cpu-l3 opp tables for SDM845
>>                  and SC7180 SoCs.
>> 
>> v3:
>>  * Migrated to using Saravana's opp-kBps bindings [1]
>>  * Fixed some misc comments from Rajendra
>>  * Added support for SC7180
>> 
>> v2:
>>  * Incorporated Viresh's comments from:
>>  
>> https://lore.kernel.org/lkml/20190410102429.r6j6brm5kspmqxc3@vireshk-i7/
>>  
>> https://lore.kernel.org/lkml/20190410112516.gnh77jcwawvld6et@vireshk-i7/
>>  * Dropped cpufreq-map passive governor
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
> 
> So drive-by question, from the perspective of someone who cares about
> a non-cpu device that frequently enjoys a lot of bandwidth (ie. the
> GPU).. any thoughts on how ddr scaling would/should work for workloads
> where the CPU is not particularly busy?

I guess Jordan would have more info
about ^^. From what I can see from
the CAF trees there is a similar
device freq -> DDR Freq mapping that
you can achieve with required-opps
bindings and a custom governor ;)

> 
> BR,
> -R
> 
>> 
>> Sibi Sankar (10):
>>   arm64: dts: qcom: sdm845: Add SoC compatible to MTP
>>   cpufreq: blacklist SDM845 in cpufreq-dt-platdev
>>   cpufreq: blacklist SC7180 in cpufreq-dt-platdev
>>   OPP: Add and export helper to update voltage
>>   opp: of: export _opp_of_get_opp_desc_node
>>   opp: Allow multiple opp_tables to be mapped to a single device
>>   opp: Remove multiple attached opp tables from a device
>>   cpufreq: qcom: Update the bandwidth levels on frequency change
>>   arm64: dts: qcom: sdm845: Add cpu OPP tables
>>   arm64: dts: qcom: sc7180: Add cpu OPP tables
>> 
>>  arch/arm64/boot/dts/qcom/sc7180.dtsi    | 287 +++++++++++++++
>>  arch/arm64/boot/dts/qcom/sdm845-mtp.dts |   2 +-
>>  arch/arm64/boot/dts/qcom/sdm845.dtsi    | 453 
>> ++++++++++++++++++++++++
>>  drivers/cpufreq/cpufreq-dt-platdev.c    |   2 +
>>  drivers/cpufreq/qcom-cpufreq-hw.c       | 246 +++++++++++--
>>  drivers/opp/core.c                      | 111 +++++-
>>  drivers/opp/of.c                        |   3 +-
>>  drivers/opp/opp.h                       |   2 +
>>  include/linux/pm_opp.h                  |  10 +
>>  9 files changed, 1083 insertions(+), 33 deletions(-)
>> 
>> --
>> The Qualcomm Innovation Center, Inc. is a member of the Code Aurora 
>> Forum,
>> a Linux Foundation Collaborative Project

-- 
Qualcomm Innovation Center, Inc. is a member of Code Aurora Forum,
a Linux Foundation Collaborative Project.
