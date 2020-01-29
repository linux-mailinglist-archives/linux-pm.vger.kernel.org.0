Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 6407114CBAB
	for <lists+linux-pm@lfdr.de>; Wed, 29 Jan 2020 14:46:46 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726719AbgA2Nqn (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Wed, 29 Jan 2020 08:46:43 -0500
Received: from mail26.static.mailgun.info ([104.130.122.26]:64434 "EHLO
        mail26.static.mailgun.info" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726617AbgA2Nqn (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Wed, 29 Jan 2020 08:46:43 -0500
DKIM-Signature: a=rsa-sha256; v=1; c=relaxed/relaxed; d=mg.codeaurora.org; q=dns/txt;
 s=smtp; t=1580305602; h=Message-ID: References: In-Reply-To: Subject:
 Cc: To: From: Date: Content-Transfer-Encoding: Content-Type:
 MIME-Version: Sender; bh=tYnhvPtUZWMfIu+rPetMRGgQXJ3DSZh8Ukm/WNsB5/o=;
 b=bC+fkcLTIWeuhsXuOi3oARK7We9ipgoajGNS4qcey6biaNfLfCp+nZc2z3y72LJPhWn4t/A4
 6lQ+KXM8A9rlhThBJfv+PBUaLeNig359miiuh/kJvmlVYLB3SRVJifm3klH/uqHpPk6crb3m
 szhFtlfzQfHN3dolYkfo6uImGvM=
X-Mailgun-Sending-Ip: 104.130.122.26
X-Mailgun-Sid: WyI5ZDFmMiIsICJsaW51eC1wbUB2Z2VyLmtlcm5lbC5vcmciLCAiYmU5ZTRhIl0=
Received: from smtp.codeaurora.org (ec2-35-166-182-171.us-west-2.compute.amazonaws.com [35.166.182.171])
 by mxa.mailgun.org with ESMTP id 5e318cbc.7ff49ee484c8-smtp-out-n02;
 Wed, 29 Jan 2020 13:46:36 -0000 (UTC)
Received: by smtp.codeaurora.org (Postfix, from userid 1001)
        id 451A3C433A2; Wed, 29 Jan 2020 13:46:36 +0000 (UTC)
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
        aws-us-west-2-caf-mail-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=2.0 tests=ALL_TRUSTED
        autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.codeaurora.org (localhost.localdomain [127.0.0.1])
        (using TLSv1 with cipher ECDHE-RSA-AES256-SHA (256/256 bits))
        (No client certificate requested)
        (Authenticated sender: sibis)
        by smtp.codeaurora.org (Postfix) with ESMTPSA id 1628EC43383;
        Wed, 29 Jan 2020 13:46:35 +0000 (UTC)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII;
 format=flowed
Content-Transfer-Encoding: 7bit
Date:   Wed, 29 Jan 2020 19:16:35 +0530
From:   Sibi Sankar <sibis@codeaurora.org>
To:     Matthias Kaehlcke <mka@chromium.org>
Cc:     viresh.kumar@linaro.org, sboyd@kernel.org,
        georgi.djakov@linaro.org, saravanak@google.com, nm@ti.com,
        bjorn.andersson@linaro.org, agross@kernel.org,
        david.brown@linaro.org, robh+dt@kernel.org, mark.rutland@arm.com,
        rjw@rjwysocki.net, linux-arm-msm@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-pm@vger.kernel.org, dianders@chromium.org,
        vincent.guittot@linaro.org, amit.kucheria@linaro.org,
        ulf.hansson@linaro.org, linux-arm-msm-owner@vger.kernel.org
Subject: Re: [RFC v3 02/10] cpufreq: blacklist SDM845 in cpufreq-dt-platdev
In-Reply-To: <20200128204423.GF46072@google.com>
References: <20200127200350.24465-1-sibis@codeaurora.org>
 <20200127200350.24465-3-sibis@codeaurora.org>
 <20200128204423.GF46072@google.com>
Message-ID: <90e6f5aa28b907ad0331fed6ef75b797@codeaurora.org>
X-Sender: sibis@codeaurora.org
User-Agent: Roundcube Webmail/1.3.9
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

Thanks for the review!

On 2020-01-29 02:14, Matthias Kaehlcke wrote:
> On Tue, Jan 28, 2020 at 01:33:42AM +0530, Sibi Sankar wrote:
>> Add SDM845 to cpufreq-dt-platdev blacklist.
> 
> nit: you could mention that cpufreq is handled by the
> 'qcom-cpufreq-hw' driver.

will add it in the next
re-spin.

> 
>> 
>> Signed-off-by: Sibi Sankar <sibis@codeaurora.org>
>> ---
>>  drivers/cpufreq/cpufreq-dt-platdev.c | 1 +
>>  1 file changed, 1 insertion(+)
>> 
>> diff --git a/drivers/cpufreq/cpufreq-dt-platdev.c 
>> b/drivers/cpufreq/cpufreq-dt-platdev.c
>> index f2ae9cd455c17..5492cf3c9dc18 100644
>> --- a/drivers/cpufreq/cpufreq-dt-platdev.c
>> +++ b/drivers/cpufreq/cpufreq-dt-platdev.c
>> @@ -130,6 +130,7 @@ static const struct of_device_id blacklist[] 
>> __initconst = {
>>  	{ .compatible = "qcom,apq8096", },
>>  	{ .compatible = "qcom,msm8996", },
>>  	{ .compatible = "qcom,qcs404", },
>> +	{ .compatible = "qcom,sdm845", },
>> 
>>  	{ .compatible = "st,stih407", },
>>  	{ .compatible = "st,stih410", },
> 
> Reviewed-by: Matthias Kaehlcke <mka@chromium.org>

-- 
Qualcomm Innovation Center, Inc. is a member of Code Aurora Forum,
a Linux Foundation Collaborative Project.
