Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 0C054188F34
	for <lists+linux-pm@lfdr.de>; Tue, 17 Mar 2020 21:43:27 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726735AbgCQUnT (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Tue, 17 Mar 2020 16:43:19 -0400
Received: from mail27.static.mailgun.info ([104.130.122.27]:20255 "EHLO
        mail27.static.mailgun.info" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726756AbgCQUnS (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Tue, 17 Mar 2020 16:43:18 -0400
DKIM-Signature: a=rsa-sha256; v=1; c=relaxed/relaxed; d=mg.codeaurora.org; q=dns/txt;
 s=smtp; t=1584477797; h=Message-ID: References: In-Reply-To: Subject:
 Cc: To: From: Date: Content-Transfer-Encoding: Content-Type:
 MIME-Version: Sender; bh=5Sknz7KDOw1qdge5xizFs8Eb5sj7/j6Seo1ppF3kntM=;
 b=Sg4kmayy2Nns/c6Ef3QKTqMsa3mEEEcKankXFwneRrcKfQtIhfR1Soq5bcKetjDYuM/uIoPI
 CX8nQfpO9binfu2bWd22zDh9Zx98vfI3clUaNiupfyp0P5rYLAjBb44NIz7OyvGvBINbwxxO
 3Dm6E8ihkZGAPu78ElNRA/8pPnk=
X-Mailgun-Sending-Ip: 104.130.122.27
X-Mailgun-Sid: WyI5ZDFmMiIsICJsaW51eC1wbUB2Z2VyLmtlcm5lbC5vcmciLCAiYmU5ZTRhIl0=
Received: from smtp.codeaurora.org (ec2-35-166-182-171.us-west-2.compute.amazonaws.com [35.166.182.171])
 by mxa.mailgun.org with ESMTP id 5e713664.7f7a1a189ed8-smtp-out-n03;
 Tue, 17 Mar 2020 20:43:16 -0000 (UTC)
Received: by smtp.codeaurora.org (Postfix, from userid 1001)
        id 278F1C43637; Tue, 17 Mar 2020 20:43:16 +0000 (UTC)
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
        aws-us-west-2-caf-mail-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=2.0 tests=ALL_TRUSTED
        autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.codeaurora.org (localhost.localdomain [127.0.0.1])
        (using TLSv1 with cipher ECDHE-RSA-AES256-SHA (256/256 bits))
        (No client certificate requested)
        (Authenticated sender: sibis)
        by smtp.codeaurora.org (Postfix) with ESMTPSA id 5E54BC433CB;
        Tue, 17 Mar 2020 20:43:15 +0000 (UTC)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII;
 format=flowed
Content-Transfer-Encoding: 7bit
Date:   Wed, 18 Mar 2020 02:13:15 +0530
From:   Sibi Sankar <sibis@codeaurora.org>
To:     viresh.kumar@linaro.org, sboyd@kernel.org,
        georgi.djakov@linaro.org, saravanak@google.com
Cc:     nm@ti.com, bjorn.andersson@linaro.org, agross@kernel.org,
        david.brown@linaro.org, robh+dt@kernel.org, mark.rutland@arm.com,
        rjw@rjwysocki.net, linux-arm-msm@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-pm@vger.kernel.org, dianders@chromium.org, mka@chromium.org,
        vincent.guittot@linaro.org, amit.kucheria@linaro.org,
        ulf.hansson@linaro.org
Subject: Re: [RFC v3 00/10] DDR/L3 Scaling support on SDM845 and SC7180 SoCs
In-Reply-To: <20200127200350.24465-1-sibis@codeaurora.org>
References: <20200127200350.24465-1-sibis@codeaurora.org>
Message-ID: <19cf027ba87ade1b895ea90ac0fedbe2@codeaurora.org>
X-Sender: sibis@codeaurora.org
User-Agent: Roundcube Webmail/1.3.9
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

On 2020-01-28 01:33, Sibi Sankar wrote:
> This RFC series aims to extend cpu based scaling support to L3/DDR on
> SDM845 and SC7180 SoCs.
> 

Hey Viresh/Saravana,

Ping! Can you take a stab at reviewing
the series, it has been on the list for
a while now.

> Patches [1-3] - Blacklist SDM845 and SC7180 in cpufreq-dt-platdev
> Patches [5-7] - Hack in a way to add/remove multiple opp tables to
>                 a single device. I am yet to fix the debugfs to
> 		support multiple opp_tables per device but wanted to
> 		send what was working upstream to get an idea if multiple
> 		opp tables per device is a feature that will be useful
> 		upstream.
> Patches [9-10] - Add the cpu/cpu-ddr/cpu-l3 opp tables for SDM845
>                  and SC7180 SoCs.
> 
> v3:
>  * Migrated to using Saravana's opp-kBps bindings [1]
>  * Fixed some misc comments from Rajendra
>  * Added support for SC7180
> 
> v2:
>  * Incorporated Viresh's comments from:
>  
> https://lore.kernel.org/lkml/20190410102429.r6j6brm5kspmqxc3@vireshk-i7/
>  
> https://lore.kernel.org/lkml/20190410112516.gnh77jcwawvld6et@vireshk-i7/
>  * Dropped cpufreq-map passive governor
> 
> Git-branch: https://github.com/QuinAsura/linux/tree/lnext-012420
> 
> Some alternate ways of hosting the opp-tables:
> https://github.com/QuinAsura/linux/commit/50b92bfaadc8f9a0d1e12249646e018bd6d1a9d3
> https://github.com/QuinAsura/linux/commit/3d23d1eefd16ae6d9e3ef91e93e78749d8844e98
> Viresh didn't really like ^^ bindings and they dont really scale well. 
> Just
> including them here for completeness.
> 
> Depends on the following series:
> [1] https://patchwork.kernel.org/cover/11277199/
> [2] https://patchwork.kernel.org/cover/11055499/
> [3] https://patchwork.kernel.org/cover/11326381/
> 
> Sibi Sankar (10):
>   arm64: dts: qcom: sdm845: Add SoC compatible to MTP
>   cpufreq: blacklist SDM845 in cpufreq-dt-platdev
>   cpufreq: blacklist SC7180 in cpufreq-dt-platdev
>   OPP: Add and export helper to update voltage
>   opp: of: export _opp_of_get_opp_desc_node
>   opp: Allow multiple opp_tables to be mapped to a single device
>   opp: Remove multiple attached opp tables from a device
>   cpufreq: qcom: Update the bandwidth levels on frequency change
>   arm64: dts: qcom: sdm845: Add cpu OPP tables
>   arm64: dts: qcom: sc7180: Add cpu OPP tables
> 
>  arch/arm64/boot/dts/qcom/sc7180.dtsi    | 287 +++++++++++++++
>  arch/arm64/boot/dts/qcom/sdm845-mtp.dts |   2 +-
>  arch/arm64/boot/dts/qcom/sdm845.dtsi    | 453 ++++++++++++++++++++++++
>  drivers/cpufreq/cpufreq-dt-platdev.c    |   2 +
>  drivers/cpufreq/qcom-cpufreq-hw.c       | 246 +++++++++++--
>  drivers/opp/core.c                      | 111 +++++-
>  drivers/opp/of.c                        |   3 +-
>  drivers/opp/opp.h                       |   2 +
>  include/linux/pm_opp.h                  |  10 +
>  9 files changed, 1083 insertions(+), 33 deletions(-)

-- 
Qualcomm Innovation Center, Inc. is a member of Code Aurora Forum,
a Linux Foundation Collaborative Project.
