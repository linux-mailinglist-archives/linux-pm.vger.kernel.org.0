Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 1DE46156BF2
	for <lists+linux-pm@lfdr.de>; Sun,  9 Feb 2020 19:04:34 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727416AbgBISEd (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Sun, 9 Feb 2020 13:04:33 -0500
Received: from mail25.static.mailgun.info ([104.130.122.25]:42627 "EHLO
        mail25.static.mailgun.info" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1727413AbgBISEd (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Sun, 9 Feb 2020 13:04:33 -0500
DKIM-Signature: a=rsa-sha256; v=1; c=relaxed/relaxed; d=mg.codeaurora.org; q=dns/txt;
 s=smtp; t=1581271472; h=Message-ID: References: In-Reply-To: Subject:
 Cc: To: From: Date: Content-Transfer-Encoding: Content-Type:
 MIME-Version: Sender; bh=3YNWSYMoJexU1K7Lnppn35aqHLf4l6mY47g6wBduzFk=;
 b=K3sa6KbQPkOUuQoskytDLZig4TnmOdFInwlvy3y9pRbowacS947P8A/lDtJn73Jn8t+gUZHv
 37wZerxV0mqN8oK2AJbdF+t90MPeSdR6QT13n2vY3eZsay6YvcxZNuM934BRSGLrD3I8A7qs
 fnL1ku5V0Dc9wjNR/IvRcARK3NQ=
X-Mailgun-Sending-Ip: 104.130.122.25
X-Mailgun-Sid: WyI5ZDFmMiIsICJsaW51eC1wbUB2Z2VyLmtlcm5lbC5vcmciLCAiYmU5ZTRhIl0=
Received: from smtp.codeaurora.org (ec2-35-166-182-171.us-west-2.compute.amazonaws.com [35.166.182.171])
 by mxa.mailgun.org with ESMTP id 5e4049af.7f79df5244c8-smtp-out-n02;
 Sun, 09 Feb 2020 18:04:31 -0000 (UTC)
Received: by smtp.codeaurora.org (Postfix, from userid 1001)
        id 8C9AAC4479D; Sun,  9 Feb 2020 18:04:30 +0000 (UTC)
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
        aws-us-west-2-caf-mail-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=2.0 tests=ALL_TRUSTED
        autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.codeaurora.org (localhost.localdomain [127.0.0.1])
        (using TLSv1 with cipher ECDHE-RSA-AES256-SHA (256/256 bits))
        (No client certificate requested)
        (Authenticated sender: sibis)
        by smtp.codeaurora.org (Postfix) with ESMTPSA id 4752DC43383;
        Sun,  9 Feb 2020 18:04:29 +0000 (UTC)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII;
 format=flowed
Content-Transfer-Encoding: 7bit
Date:   Sun, 09 Feb 2020 23:34:29 +0530
From:   Sibi Sankar <sibis@codeaurora.org>
To:     Evan Green <evgreen@google.com>
Cc:     David Dai <daidavid1@codeaurora.org>,
        Georgi Djakov <georgi.djakov@linaro.org>,
        Bjorn Andersson <bjorn.andersson@linaro.org>,
        Rob Herring <robh+dt@kernel.org>, sboyd@kernel.org,
        Lina Iyer <ilina@codeaurora.org>,
        Sean Sweeney <seansw@qti.qualcomm.com>,
        Alex Elder <elder@linaro.org>,
        LKML <linux-kernel@vger.kernel.org>,
        "open list:OPEN FIRMWARE AND FLATTENED DEVICE TREE BINDINGS" 
        <devicetree@vger.kernel.org>,
        linux-arm-msm <linux-arm-msm@vger.kernel.org>,
        linux-pm@vger.kernel.org, linux-arm-msm-owner@vger.kernel.org
Subject: Re: [PATCH v2 5/6] interconnect: qcom: sdm845: Split qnodes into
 their respective NoCs
In-Reply-To: <CAE=gft6--=zhxfR9G=S0g-5c9YdpvaFWz9dcgV7zJQAzcreZjg@mail.gmail.com>
References: <1578630784-962-1-git-send-email-daidavid1@codeaurora.org>
 <1578630784-962-6-git-send-email-daidavid1@codeaurora.org>
 <CAE=gft6--=zhxfR9G=S0g-5c9YdpvaFWz9dcgV7zJQAzcreZjg@mail.gmail.com>
Message-ID: <9f1675f15fdf6b627f0ce12b1a6cea9a@codeaurora.org>
X-Sender: sibis@codeaurora.org
User-Agent: Roundcube Webmail/1.3.9
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

On 2020-02-04 23:51, Evan Green wrote:
> On Thu, Jan 9, 2020 at 8:33 PM David Dai <daidavid1@codeaurora.org> 
> wrote:
>> 
>> In order to better represent the hardware and its different 
>> Network-On-Chip
>> devices, split the sdm845 provider driver into NoC specific providers.
>> Remove duplicate functionality already provided by the icc rpmh and
>> bcm voter drivers to calculate and commit bandwidth requests to 
>> hardware.
>> 
>> Signed-off-by: David Dai <daidavid1@codeaurora.org>
>> ---
>>  drivers/interconnect/qcom/sdm845.c             | 1132 
>> ++++++++++--------------
>>  include/dt-bindings/interconnect/qcom,sdm845.h |  263 +++---
>>  2 files changed, 609 insertions(+), 786 deletions(-)
>> 
>> diff --git a/drivers/interconnect/qcom/sdm845.c 
>> b/drivers/interconnect/qcom/sdm845.c
>> index f078cf0..8145612 100644
>> --- a/drivers/interconnect/qcom/sdm845.c
>> +++ b/drivers/interconnect/qcom/sdm845.c
>> @@ -5,283 +5,285 @@
>>   */
>> 
>>  #include <asm/div64.h>
> 
> You don't need this header anymore, right?
> 
>> -#include <dt-bindings/interconnect/qcom,sdm845.h>
>>  #include <linux/device.h>
>>  #include <linux/interconnect.h>
>>  #include <linux/interconnect-provider.h>
>>  #include <linux/io.h>

^^ can also be dropped

>>  #include <linux/module.h>
>>  #include <linux/of_device.h>
>> -#include <linux/of_platform.h>

^^ can also be dropped

>> -#include <linux/platform_device.h>
>>  #include <linux/sort.h>
> 
> ..or this one.

-- 
Qualcomm Innovation Center, Inc. is a member of Code Aurora Forum,
a Linux Foundation Collaborative Project.
