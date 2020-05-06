Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id DD9FF1C731F
	for <lists+linux-pm@lfdr.de>; Wed,  6 May 2020 16:42:13 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729226AbgEFOmK (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Wed, 6 May 2020 10:42:10 -0400
Received: from mail26.static.mailgun.info ([104.130.122.26]:48764 "EHLO
        mail26.static.mailgun.info" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1729228AbgEFOmH (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Wed, 6 May 2020 10:42:07 -0400
DKIM-Signature: a=rsa-sha256; v=1; c=relaxed/relaxed; d=mg.codeaurora.org; q=dns/txt;
 s=smtp; t=1588776126; h=Message-ID: References: In-Reply-To: Subject:
 Cc: To: From: Date: Content-Transfer-Encoding: Content-Type:
 MIME-Version: Sender; bh=cx846LpCI/mxVQVVyh+RuRGtZ75GrHh3+ShglsOfGD4=;
 b=EOuGnAExIo56lhE9mEEDQDLe72kFyDE9Vb/RwLE7TEiWCb0UIDvzuXDXSdkGm+HXtjby7Yw+
 p3QRf56mEy+NDDBWwQ17djdMCne/uMGPqRVAbs3Bg8G8lD3/Aj/HFQ/hkhU/c6hrYQwDDhP0
 cqfKXmocpSiZ+OPDi+/eFAP7FEo=
X-Mailgun-Sending-Ip: 104.130.122.26
X-Mailgun-Sid: WyI5ZDFmMiIsICJsaW51eC1wbUB2Z2VyLmtlcm5lbC5vcmciLCAiYmU5ZTRhIl0=
Received: from smtp.codeaurora.org (ec2-35-166-182-171.us-west-2.compute.amazonaws.com [35.166.182.171])
 by mxa.mailgun.org with ESMTP id 5eb2ccb5.7f1064742c70-smtp-out-n02;
 Wed, 06 May 2020 14:41:57 -0000 (UTC)
Received: by smtp.codeaurora.org (Postfix, from userid 1001)
        id E0711C44791; Wed,  6 May 2020 14:41:55 +0000 (UTC)
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
        aws-us-west-2-caf-mail-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=2.0 tests=ALL_TRUSTED
        autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.codeaurora.org (localhost.localdomain [127.0.0.1])
        (using TLSv1 with cipher ECDHE-RSA-AES256-SHA (256/256 bits))
        (No client certificate requested)
        (Authenticated sender: sibis)
        by smtp.codeaurora.org (Postfix) with ESMTPSA id 887D4C433F2;
        Wed,  6 May 2020 14:41:54 +0000 (UTC)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII;
 format=flowed
Content-Transfer-Encoding: 7bit
Date:   Wed, 06 May 2020 20:11:54 +0530
From:   Sibi Sankar <sibis@codeaurora.org>
To:     Amit Kucheria <amit.kucheria@linaro.org>
Cc:     Viresh Kumar <viresh.kumar@linaro.org>,
        Stephen Boyd <sboyd@kernel.org>,
        Georgi Djakov <georgi.djakov@linaro.org>,
        Bjorn Andersson <bjorn.andersson@linaro.org>,
        Saravana Kannan <saravanak@google.com>,
        Matthias Kaehlcke <mka@chromium.org>,
        Nishanth Menon <nm@ti.com>, Andy Gross <agross@kernel.org>,
        David Brown <david.brown@linaro.org>,
        Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        "Rafael J. Wysocki" <rjw@rjwysocki.net>,
        linux-arm-msm <linux-arm-msm@vger.kernel.org>,
        "open list:OPEN FIRMWARE AND FLATTENED DEVICE TREE BINDINGS" 
        <devicetree@vger.kernel.org>, LKML <linux-kernel@vger.kernel.org>,
        Linux PM list <linux-pm@vger.kernel.org>,
        Douglas Anderson <dianders@chromium.org>,
        Vincent Guittot <vincent.guittot@linaro.org>,
        Ulf Hansson <ulf.hansson@linaro.org>,
        Lukasz Luba <lukasz.luba@arm.com>,
        Sudeep Holla <sudeep.holla@arm.com>,
        linux-kernel-owner@vger.kernel.org
Subject: Re: [PATCH v4 00/12] DDR/L3 Scaling support on SDM845 and SC7180 SoCs
In-Reply-To: <CAHLCerM_wdHDwzEDN7YxU9pBdHo3KvNyJeRWMC6seTG6aCH7nw@mail.gmail.com>
References: <20200504202243.5476-1-sibis@codeaurora.org>
 <CAHLCerM_wdHDwzEDN7YxU9pBdHo3KvNyJeRWMC6seTG6aCH7nw@mail.gmail.com>
Message-ID: <87126044e367432ee8722ec2346d1dd5@codeaurora.org>
X-Sender: sibis@codeaurora.org
User-Agent: Roundcube Webmail/1.3.9
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

Hey Amit,
Thanks for taking time to review
the series!

On 2020-05-06 18:08, Amit Kucheria wrote:
> On Tue, May 5, 2020 at 1:54 AM Sibi Sankar <sibis@codeaurora.org> 
> wrote:
>> 
>> This patch series aims to extend cpu based scaling support to L3/DDR 
>> on
>> SDM845 and SC7180 SoCs.
>> 
>> Patches [1-3] - Blacklist SDM845 and SC7180 in cpufreq-dt-platdev
>> Patches [4-8] - Update bw levels based on cpu frequency change
>> Patches [9-10] - Add tag setting support to OPP
>> Patches [11-12] - Add the cpu opp tables for SDM845 and SC7180 SoCs.
>> 
>> Depends on the following series:
>> https://lore.kernel.org/patchwork/cover/1230626/
> 
> Are there any other dependencies for this series? I tried applying
> this on top of Georgi's series on v5.7-rc3. Patch 12 didn't apply
> cleanly and needed a manual fixup for the include change.
> 

When I posted out it was based on
next-20200428 tree, there shouldn't
be any other dependency needed.

> Compilation failed with:
> Error:
> /home/amit/work/sources/worktree-review-pipeline/arch/arm64/boot/dts/qcom/sc7180.dtsi:101.30-31
> syntax error
> FATAL ERROR: Unable to parse input tree
> 
> I've been squinting at the offending lines with no success:
>                         interconnects = <&gem_noc MASTER_APPSS_PROC
> &mc_virt SLAVE_EBI1>,
>                                         <&osm_l3 MASTER_OSM_L3_APPS
> &osm_l3 SLAVE_OSM_L3>;
> 

#include <dt-bindings/interconnect/qcom,sc7180.h>
You are probably missing ^^ which
is present in next.

>> Georgi,
>>  Would it make sense to include tag support patches [9-10] in your 
>> next
>>  re-spin?
>> 
>> V4:
>>  * Migrate to using Georgi's new bindings
>>  * Misc fixups based on Matthias comments
>>  * API fixups based on Bjorn's comments on v2
>>  * Picked up a few R-bs from Matthias
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
>> Sibi Sankar (12):
>>   arm64: dts: qcom: sdm845: Add SoC compatible to MTP
>>   cpufreq: blacklist SDM845 in cpufreq-dt-platdev
>>   cpufreq: blacklist SC7180 in cpufreq-dt-platdev
>>   OPP: Add and export helper to update voltage
>>   OPP: Add and export helper to set bandwidth
>>   cpufreq: qcom: Update the bandwidth levels on frequency change
>>   OPP: Add and export helper to get icc path count
>>   cpufreq: qcom: Disable fast switch when scaling ddr/l3
>>   dt-bindings: interconnect: Add interconnect-tags bindings
>>   OPP: Add support for setting interconnect-tags
>>   arm64: dts: qcom: sdm845: Add cpu OPP tables
>>   arm64: dts: qcom: sc7180: Add cpu OPP tables
>> 
>>  .../bindings/interconnect/interconnect.txt    |   5 +
>>  arch/arm64/boot/dts/qcom/sc7180.dtsi          | 168 ++++++++++++
>>  arch/arm64/boot/dts/qcom/sdm845-mtp.dts       |   2 +-
>>  arch/arm64/boot/dts/qcom/sdm845.dtsi          | 258 
>> ++++++++++++++++++
>>  drivers/cpufreq/cpufreq-dt-platdev.c          |   2 +
>>  drivers/cpufreq/qcom-cpufreq-hw.c             |  89 +++++-
>>  drivers/opp/core.c                            | 114 ++++++++
>>  drivers/opp/of.c                              |  25 +-
>>  include/linux/pm_opp.h                        |  22 ++
>>  9 files changed, 675 insertions(+), 10 deletions(-)
>> 
>> --
>> The Qualcomm Innovation Center, Inc. is a member of the Code Aurora 
>> Forum,
>> a Linux Foundation Collaborative Project

-- 
Qualcomm Innovation Center, Inc. is a member of Code Aurora Forum,
a Linux Foundation Collaborative Project.
