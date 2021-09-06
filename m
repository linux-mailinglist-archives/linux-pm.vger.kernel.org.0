Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2BD17401539
	for <lists+linux-pm@lfdr.de>; Mon,  6 Sep 2021 05:20:52 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231630AbhIFDVy (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Sun, 5 Sep 2021 23:21:54 -0400
Received: from so254-9.mailgun.net ([198.61.254.9]:41938 "EHLO
        so254-9.mailgun.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231207AbhIFDVx (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Sun, 5 Sep 2021 23:21:53 -0400
DKIM-Signature: a=rsa-sha256; v=1; c=relaxed/relaxed; d=mg.codeaurora.org; q=dns/txt;
 s=smtp; t=1630898449; h=Message-ID: References: In-Reply-To: Subject:
 Cc: To: From: Date: Content-Transfer-Encoding: Content-Type:
 MIME-Version: Sender; bh=zeI7cb88S3dlLs0mexnW614GGMS9653bA0VelDKM6RQ=;
 b=UoIM8aum2nVNqUwb4wKY38i/fqYVKbbHTcPJ2I8SP6QkWabiS0si04pQoJ2mopVXNUq87LNB
 wTV2tPnAIcwk1tMUcwzJAYAJ55+HR58v7Y+u7+r1MmIF0+WmtVar8t9tlMYJic9R7cvJ1/fX
 fOjp47n2ktQ/aNIQ+6VF0WN6/T8=
X-Mailgun-Sending-Ip: 198.61.254.9
X-Mailgun-Sid: WyI5ZDFmMiIsICJsaW51eC1wbUB2Z2VyLmtlcm5lbC5vcmciLCAiYmU5ZTRhIl0=
Received: from smtp.codeaurora.org
 (ec2-35-166-182-171.us-west-2.compute.amazonaws.com [35.166.182.171]) by
 smtp-out-n05.prod.us-west-2.postgun.com with SMTP id
 6135890589cdb6206103d8f0 (version=TLS1.2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256); Mon, 06 Sep 2021 03:20:37
 GMT
Sender: sibis=codeaurora.org@mg.codeaurora.org
Received: by smtp.codeaurora.org (Postfix, from userid 1001)
        id C3790C4360D; Mon,  6 Sep 2021 03:20:37 +0000 (UTC)
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
        aws-us-west-2-caf-mail-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.9 required=2.0 tests=ALL_TRUSTED,BAYES_00
        autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.codeaurora.org (localhost.localdomain [127.0.0.1])
        (using TLSv1 with cipher ECDHE-RSA-AES256-SHA (256/256 bits))
        (No client certificate requested)
        (Authenticated sender: sibis)
        by smtp.codeaurora.org (Postfix) with ESMTPSA id 3DBE6C4338F;
        Mon,  6 Sep 2021 03:20:36 +0000 (UTC)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII;
 format=flowed
Content-Transfer-Encoding: 7bit
Date:   Mon, 06 Sep 2021 08:50:36 +0530
From:   Sibi Sankar <sibis@codeaurora.org>
To:     Bjorn Andersson <bjorn.andersson@linaro.org>
Cc:     Matthias Kaehlcke <mka@chromium.org>, sboyd@kernel.org,
        robh+dt@kernel.org, viresh.kumar@linaro.org, agross@kernel.org,
        rjw@rjwysocki.net, linux-arm-msm@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-pm@vger.kernel.org, dianders@chromium.org,
        tdas@codeaurora.org
Subject: Re: [PATCH 3/4] arm64: dts: qcom: sc7280: Fixup the cpufreq node
In-Reply-To: <YS5hDq+xblntYbh0@ripper>
References: <1627581885-32165-1-git-send-email-sibis@codeaurora.org>
 <1627581885-32165-4-git-send-email-sibis@codeaurora.org>
 <YS5LDb4KDFx/dRnM@google.com> <YS5hDq+xblntYbh0@ripper>
Message-ID: <fde7bac239f796b039b9be58b391fb77@codeaurora.org>
X-Sender: sibis@codeaurora.org
User-Agent: Roundcube Webmail/1.3.9
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

On 2021-08-31 22:34, Bjorn Andersson wrote:
> On Tue 31 Aug 08:30 PDT 2021, Matthias Kaehlcke wrote:
> 
>> On Thu, Jul 29, 2021 at 11:34:44PM +0530, Sibi Sankar wrote:
>> > Fixup the register regions used by the cpufreq node on SC7280 SoC to
>> > support per core L3 DCVS.
>> >
>> > Fixes: 7dbd121a2c58 ("arm64: dts: qcom: sc7280: Add cpufreq hw node")
>> > Signed-off-by: Sibi Sankar <sibis@codeaurora.org>
>> 
>> This patch landed in the Bjorn's tree, however the corresponding 
>> driver
>> change ("cpufreq: qcom: Re-arrange register offsets to support per 
>> core
>> L3 DCVS" / 
>> https://patchwork.kernel.org/project/linux-arm-msm/patch/1627581885-32165-3-git-send-email-sibis@codeaurora.org/)
>> did not land in any maintainer tree yet AFAIK. IIUC the DT change 
>> alone
>> breaks cpufreq since the changed register regions require the changed
>> offset in the cpufreq driver.
>> 
> 
> Thanks for the note Matthias, it must have slipped by as I scraped the
> inbox for things that looked ready.
> 
> I'm actually not in favor of splitting these memory blocks in DT to
> facilitate the Linux implementation of splitting that in multiple
> drivers...
> 
> But I've not been following up on that discussion.
> 
> Regards,
> Bjorn
> 
>> Sibi, please confirm or clarify that my concern is unwarranted.

Let's drop the patch asap as it breaks
SC7280 cpufreq on lnext without the driver
changes.

-- 
Qualcomm Innovation Center, Inc. is a member of Code Aurora Forum,
a Linux Foundation Collaborative Project.
