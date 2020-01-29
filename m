Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id D49D414CB7A
	for <lists+linux-pm@lfdr.de>; Wed, 29 Jan 2020 14:35:03 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726528AbgA2NfD (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Wed, 29 Jan 2020 08:35:03 -0500
Received: from mail25.static.mailgun.info ([104.130.122.25]:50640 "EHLO
        mail25.static.mailgun.info" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726069AbgA2NfD (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Wed, 29 Jan 2020 08:35:03 -0500
DKIM-Signature: a=rsa-sha256; v=1; c=relaxed/relaxed; d=mg.codeaurora.org; q=dns/txt;
 s=smtp; t=1580304902; h=Content-Transfer-Encoding: Content-Type:
 In-Reply-To: MIME-Version: Date: Message-ID: From: References: Cc: To:
 Subject: Sender; bh=2sxskHCGXQhVALsZwgwhTjZajzTjZeZfv8scmDcudzQ=; b=b3xh+Ti2PZMnIAsFYnhipQdV+F1cZGF1k72AFq46QDSJOLORn/EcELdiayBJm3DjowYidBQv
 Ae2lma/rTmdaDEoOvHVd5kD9X0e3oXK2zUa9/XbvRpT9J+ooE7c8TLmoCE3kEYus4OPHhrjl
 CGPAHlZH3hir94QfMvpmV909o6M=
X-Mailgun-Sending-Ip: 104.130.122.25
X-Mailgun-Sid: WyI5ZDFmMiIsICJsaW51eC1wbUB2Z2VyLmtlcm5lbC5vcmciLCAiYmU5ZTRhIl0=
Received: from smtp.codeaurora.org (ec2-35-166-182-171.us-west-2.compute.amazonaws.com [35.166.182.171])
 by mxa.mailgun.org with ESMTP id 5e318a03.7ff1150a60d8-smtp-out-n02;
 Wed, 29 Jan 2020 13:34:59 -0000 (UTC)
Received: by smtp.codeaurora.org (Postfix, from userid 1001)
        id E0D8EC447A1; Wed, 29 Jan 2020 13:34:58 +0000 (UTC)
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
        aws-us-west-2-caf-mail-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=2.0 tests=ALL_TRUSTED,SPF_NONE
        autolearn=unavailable autolearn_force=no version=3.4.0
Received: from [10.79.43.230] (blr-bdr-fw-01_GlobalNAT_AllZones-Outside.qualcomm.com [103.229.18.19])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        (Authenticated sender: sibis)
        by smtp.codeaurora.org (Postfix) with ESMTPSA id B794DC43383;
        Wed, 29 Jan 2020 13:34:54 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 smtp.codeaurora.org B794DC43383
Authentication-Results: aws-us-west-2-caf-mail-1.web.codeaurora.org; dmarc=none (p=none dis=none) header.from=codeaurora.org
Authentication-Results: aws-us-west-2-caf-mail-1.web.codeaurora.org; spf=none smtp.mailfrom=sibis@codeaurora.org
Subject: Re: [PATCH v3 3/5] OPP: Improve require-opps linking
To:     Viresh Kumar <viresh.kumar@linaro.org>,
        Saravana Kannan <saravanak@google.com>
Cc:     MyungJoo Ham <myungjoo.ham@samsung.com>,
        Kyungmin Park <kyungmin.park@samsung.com>,
        Chanwoo Choi <cw00.choi@samsung.com>,
        Viresh Kumar <vireshk@kernel.org>, Nishanth Menon <nm@ti.com>,
        Stephen Boyd <sboyd@kernel.org>,
        "Rafael J. Wysocki" <rjw@rjwysocki.net>, kernel-team@android.com,
        linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20190717222340.137578-1-saravanak@google.com>
 <20190717222340.137578-4-saravanak@google.com>
 <20191125112812.26jk5hsdwqfnofc2@vireshk-i7>
 <20200127061118.5bxei6nghowlmf53@vireshk-i7>
From:   Sibi Sankar <sibis@codeaurora.org>
Message-ID: <b0be1275-c5cb-8171-58fa-64d65f60eaf8@codeaurora.org>
Date:   Wed, 29 Jan 2020 19:04:44 +0530
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.6.1
MIME-Version: 1.0
In-Reply-To: <20200127061118.5bxei6nghowlmf53@vireshk-i7>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

Hey Viresh,


On 1/27/20 11:41 AM, Viresh Kumar wrote:
> On 25-11-19, 16:58, Viresh Kumar wrote:
>> >From 8df083ca64d82ff57f778689271cc1be75aa99c4 Mon Sep 17 00:00:00 2001
>> Message-Id: <8df083ca64d82ff57f778689271cc1be75aa99c4.1574681211.git.viresh.kumar@linaro.org>
>> From: Viresh Kumar <viresh.kumar@linaro.org>
>> Date: Mon, 25 Nov 2019 13:57:58 +0530
>> Subject: [PATCH] opp: Allow lazy-linking of required-opps
>>
>> The OPP core currently requires the required opp tables to be available
>> before the dependent OPP table is added, as it needs to create links
>> from the dependent OPP table to the required ones. This may not be
>> convenient to all the platforms though, as this requires strict ordering
>> of probing of drivers.
>>
>> This patch allows lazy-linking of the required-opps. The OPP tables for
>> which the required-opp-tables aren't available at the time of their
>> initialization, are added to a special list of OPP tables:
>> pending_opp_tables. Later on, whenever a new OPP table is registered
>> with the OPP core, we check if it is required by an OPP table in the
>> pending list; if yes, then we complete the linking then and there.
>>
>> An OPP table is marked unusable until the time all its required-opp
>> tables are available. And if lazy-linking fails for an OPP table, the
>> OPP core disables all of its OPPs to make sure no one can use them.
>>
>> Signed-off-by: Viresh Kumar <viresh.kumar@linaro.org>
>> ---
>>   drivers/opp/core.c |  13 ++++++
>>   drivers/opp/of.c   | 113 +++++++++++++++++++++++++++++++++++++++++++--
>>   drivers/opp/opp.h  |   4 +-
>>   3 files changed, 124 insertions(+), 6 deletions(-)
> 
> I was hoping to queue this up for next release, any update on getting
> this tested ?

I don't have a gen-pd use case to test against but with the is_genpd
check removed it works as expected when I used it against this
series: https://patchwork.kernel.org/cover/11353185/

In the lazy_link_required_opps fn shouldn't we skip the dynamic
opps in the the opp list?

With ^^ addressed:
Reviewed-by: Sibi Sankar <sibis@codeaurora.org>
Tested-by: Sibi Sankar <sibis@codeaurora.org>

> 
> 

-- 
Qualcomm Innovation Center, Inc.
Qualcomm Innovation Center, Inc, is a member of Code Aurora Forum,
a Linux Foundation Collaborative Project
