Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id AE96A1E2959
	for <lists+linux-pm@lfdr.de>; Tue, 26 May 2020 19:48:24 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2389176AbgEZRsY (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Tue, 26 May 2020 13:48:24 -0400
Received: from mail26.static.mailgun.info ([104.130.122.26]:19235 "EHLO
        mail26.static.mailgun.info" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S2389136AbgEZRsX (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Tue, 26 May 2020 13:48:23 -0400
DKIM-Signature: a=rsa-sha256; v=1; c=relaxed/relaxed; d=mg.codeaurora.org; q=dns/txt;
 s=smtp; t=1590515303; h=Message-ID: References: In-Reply-To: Subject:
 Cc: To: From: Date: Content-Transfer-Encoding: Content-Type:
 MIME-Version: Sender; bh=7keFiYQqaL3DuPDgQ1CTQxclwRsZANwrQiftoCTSuPc=;
 b=wqeCS4Fo89xkLbREIf3CQM9saoPbjiLfdWl7YnycJgQEbioB0EzbzPMIr3haXYu39eQhz4Ce
 ofRfFh/EIjrjZlFMi4BLlon5cgYXqD9gTyqW04Mx7CDn2g6V8P51/DEXu6KJ6RGccJ/RqBn3
 8sbqWuIAcO3203UFSy40z90sZts=
X-Mailgun-Sending-Ip: 104.130.122.26
X-Mailgun-Sid: WyI5ZDFmMiIsICJsaW51eC1wbUB2Z2VyLmtlcm5lbC5vcmciLCAiYmU5ZTRhIl0=
Received: from smtp.codeaurora.org
 (ec2-35-166-182-171.us-west-2.compute.amazonaws.com [35.166.182.171]) by
 smtp-out-n03.prod.us-east-1.postgun.com with SMTP id
 5ecd5665cb04586933a7b977 (version=TLS1.2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256); Tue, 26 May 2020 17:48:21
 GMT
Received: by smtp.codeaurora.org (Postfix, from userid 1001)
        id 6262DC433AD; Tue, 26 May 2020 17:48:20 +0000 (UTC)
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
        aws-us-west-2-caf-mail-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=2.0 tests=ALL_TRUSTED
        autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.codeaurora.org (localhost.localdomain [127.0.0.1])
        (using TLSv1 with cipher ECDHE-RSA-AES256-SHA (256/256 bits))
        (No client certificate requested)
        (Authenticated sender: sibis)
        by smtp.codeaurora.org (Postfix) with ESMTPSA id 73091C433C6;
        Tue, 26 May 2020 17:48:19 +0000 (UTC)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII;
 format=flowed
Content-Transfer-Encoding: 7bit
Date:   Tue, 26 May 2020 23:18:19 +0530
From:   Sibi Sankar <sibis@codeaurora.org>
To:     Viresh Kumar <viresh.kumar@linaro.org>
Cc:     sboyd@kernel.org, georgi.djakov@linaro.org,
        bjorn.andersson@linaro.org, saravanak@google.com, mka@chromium.org,
        nm@ti.com, agross@kernel.org, david.brown@linaro.org,
        robh+dt@kernel.org, mark.rutland@arm.com, rjw@rjwysocki.net,
        linux-arm-msm@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-pm@vger.kernel.org,
        dianders@chromium.org, vincent.guittot@linaro.org,
        amit.kucheria@linaro.org, ulf.hansson@linaro.org,
        lukasz.luba@arm.com, sudeep.holla@arm.com
Subject: Re: [PATCH v4 06/12] cpufreq: qcom: Update the bandwidth levels on
 frequency change
In-Reply-To: <8fc5b72c9af6fd6a707a280cfc678677@codeaurora.org>
References: <20200504202243.5476-1-sibis@codeaurora.org>
 <20200504202243.5476-7-sibis@codeaurora.org>
 <20200505045012.zfx2e6chqo5f3e4n@vireshk-i7>
 <8fc5b72c9af6fd6a707a280cfc678677@codeaurora.org>
Message-ID: <b7e184b2da5b780a4e7e6ee47963f9b4@codeaurora.org>
X-Sender: sibis@codeaurora.org
User-Agent: Roundcube Webmail/1.3.9
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

On 2020-05-05 12:49, Sibi Sankar wrote:
> On 2020-05-05 10:20, Viresh Kumar wrote:
>> On 05-05-20, 01:52, Sibi Sankar wrote:
>>> Add support to parse optional OPP table attached to the cpu node when
>>> the OPP bandwidth values are populated. This allows for scaling of
>>> DDR/L3 bandwidth levels with frequency change.
>>> 
>>> Signed-off-by: Sibi Sankar <sibis@codeaurora.org>
>> 
>> What about using opp_set_rate instead ?
> 
> I can't use opp_set_rate since
> the cpu dev does not have a
> clock associated with it and the
> scaling is done through writing
> on perf state register.

Viresh,

https://patchwork.kernel.org/cover/11548479/
GPU driver uses Georgi's series
for scaling and will need a way to
remove the icc votes in the suspend
path, (this looks like a pattern
that might be used by other clients
as well) I could probably update
opp_set_bw to support removing bw
when NULL opp is specified. Similarly
opp_set_rate will need to support
set bw to 0 when set_rate is passed
0 as target freq for the same use case.

-- 
Qualcomm Innovation Center, Inc. is a member of Code Aurora Forum,
a Linux Foundation Collaborative Project.
