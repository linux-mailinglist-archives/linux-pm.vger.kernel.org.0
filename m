Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9E1D63FB15F
	for <lists+linux-pm@lfdr.de>; Mon, 30 Aug 2021 08:47:44 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232855AbhH3Gsd (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Mon, 30 Aug 2021 02:48:33 -0400
Received: from so254-9.mailgun.net ([198.61.254.9]:59979 "EHLO
        so254-9.mailgun.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232862AbhH3Gsb (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Mon, 30 Aug 2021 02:48:31 -0400
DKIM-Signature: a=rsa-sha256; v=1; c=relaxed/relaxed; d=mg.codeaurora.org; q=dns/txt;
 s=smtp; t=1630306058; h=Message-ID: References: In-Reply-To: Subject:
 Cc: To: From: Date: Content-Transfer-Encoding: Content-Type:
 MIME-Version: Sender; bh=Ij1fbEpBts73q2JaEtuGhklwHwIsAQxjOqsm7O6ni4w=;
 b=uzK27MU1GdWw820OqQpAK8E6MGnDfeVZttCOUX+s6B3PAtBxRB0qnadCVJgzfugSQdB2k5+z
 BH9OFUIH9MnNiEMCb7PR+uAAEy1KjrWk1ub3chOjMFC0AZkD+fHLA7XkSTKLw9hCwYdxCv2G
 dSIPl9jsJ/HtBrjO1ztbNxv5IjM=
X-Mailgun-Sending-Ip: 198.61.254.9
X-Mailgun-Sid: WyI5ZDFmMiIsICJsaW51eC1wbUB2Z2VyLmtlcm5lbC5vcmciLCAiYmU5ZTRhIl0=
Received: from smtp.codeaurora.org
 (ec2-35-166-182-171.us-west-2.compute.amazonaws.com [35.166.182.171]) by
 smtp-out-n06.prod.us-west-2.postgun.com with SMTP id
 612c7f084d644b7d1c50b873 (version=TLS1.2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256); Mon, 30 Aug 2021 06:47:36
 GMT
Sender: sibis=codeaurora.org@mg.codeaurora.org
Received: by smtp.codeaurora.org (Postfix, from userid 1001)
        id 391ABC4360C; Mon, 30 Aug 2021 06:47:36 +0000 (UTC)
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
        aws-us-west-2-caf-mail-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.9 required=2.0 tests=ALL_TRUSTED,BAYES_00
        autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.codeaurora.org (localhost.localdomain [127.0.0.1])
        (using TLSv1 with cipher ECDHE-RSA-AES256-SHA (256/256 bits))
        (No client certificate requested)
        (Authenticated sender: sibis)
        by smtp.codeaurora.org (Postfix) with ESMTPSA id 95346C4338F;
        Mon, 30 Aug 2021 06:47:35 +0000 (UTC)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII;
 format=flowed
Content-Transfer-Encoding: 7bit
Date:   Mon, 30 Aug 2021 12:17:35 +0530
From:   Sibi Sankar <sibis@codeaurora.org>
To:     Matthias Kaehlcke <mka@chromium.org>,
        Bjorn Andersson <bjorn.andersson@linaro.org>
Cc:     sboyd@kernel.org, robh+dt@kernel.org, viresh.kumar@linaro.org,
        agross@kernel.org, rjw@rjwysocki.net,
        linux-arm-msm@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-pm@vger.kernel.org,
        dianders@chromium.org, tdas@codeaurora.org
Subject: Re: [PATCH 4/4] arm64: dts: qcom: sm8350: Fixup the cpufreq node
In-Reply-To: <YQsprr4rLVPwVfqR@google.com>
References: <1627581885-32165-1-git-send-email-sibis@codeaurora.org>
 <1627581885-32165-5-git-send-email-sibis@codeaurora.org>
 <YQsbuN1xyAlCYRqK@builder.lan> <YQsprr4rLVPwVfqR@google.com>
Message-ID: <cafed46a38a29072f9241de2154a502b@codeaurora.org>
X-Sender: sibis@codeaurora.org
User-Agent: Roundcube Webmail/1.3.9
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

On 2021-08-05 05:28, Matthias Kaehlcke wrote:
> On Wed, Aug 04, 2021 at 05:59:04PM -0500, Bjorn Andersson wrote:
>> On Thu 29 Jul 13:04 CDT 2021, Sibi Sankar wrote:
>> 
>> > Fixup the register regions used by the cpufreq node on SM8350 SoC to
>> > support per core L3 DCVS.
>> >
>> 
>> That sounds good, but why are you dropping the platform-specific
>> compatible?
>> 
> 
> I also stared at this and the patch that changes the code for a while.
> 
> My understanding is that removing the platform-specific compatible is 
> part
> of not breaking 'old' DTBs. Old DTBs for SM8350 contain the larger 
> register
> regions and must be paired with 'epss_sm8250_soc_data' (driver code) 
> which
> has the 'old' 'reg_perf_state' offset. New SM8350 DTs only have the
> 'qcom,cpufreq-epss' compatible, which pairs their smaller register 
> regions
> with 'epss_soc_data' with the new 'reg_perf_state' offset.
> 
> It is super-confusing that the platform-specific compatible string is
> missing. The binding should probably mention that the two
> platform-specific compatible strings are for backwards compatibility
> only and should not be added to new or existing DT files that don't
> have them already. Maybe a 'qcom,sm8350-cpufreq-epss-v2' or similar
> should be added to avoid/reduce possible confusion and have to option
> to add SM8350 specific code later.

Bjorn,

https://patchwork.kernel.org/project/linux-arm-msm/cover/1629458622-4915-1-git-send-email-okukatla@codeaurora.org/

This series affects the design of the l3
provider support for sc7280 which will be
in a position to land in ~1-2 respins. So,
please share an early ACK or NACK regarding
the register re-ordering series so that we
can plan to get alternate acceptable versions
out faster on the list.


-- 
Qualcomm Innovation Center, Inc. is a member of Code Aurora Forum,
a Linux Foundation Collaborative Project.
