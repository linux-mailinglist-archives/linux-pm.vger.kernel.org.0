Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D300A24EBAC
	for <lists+linux-pm@lfdr.de>; Sun, 23 Aug 2020 07:49:08 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726079AbgHWFtH (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Sun, 23 Aug 2020 01:49:07 -0400
Received: from m43-7.mailgun.net ([69.72.43.7]:13869 "EHLO m43-7.mailgun.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725908AbgHWFtH (ORCPT <rfc822;linux-pm@vger.kernel.org>);
        Sun, 23 Aug 2020 01:49:07 -0400
DKIM-Signature: a=rsa-sha256; v=1; c=relaxed/relaxed; d=mg.codeaurora.org; q=dns/txt;
 s=smtp; t=1598161746; h=Content-Transfer-Encoding: Content-Type:
 In-Reply-To: MIME-Version: Date: Message-ID: From: References: Cc: To:
 Subject: Sender; bh=VVsAV6RJurfzrc+Bc09hMPCBHRTFLKJUd/JUAnKTN6c=; b=QoZo+SsKtpHF6/k1SjEQ/n4WUy8wkAR4boNNOnWYhdeOlpm0jTKawdXr5k2iyowd2McY+ESe
 yNj1WmmEjAWQZQXssZkHTqEl9hlUkcoDxGARtbJqoeYr1ljfSJc30QJDzIsNYD1zZntItMEC
 P5Bfq/R/e48o9bFI5jp+7gy4fv8=
X-Mailgun-Sending-Ip: 69.72.43.7
X-Mailgun-Sid: WyI5ZDFmMiIsICJsaW51eC1wbUB2Z2VyLmtlcm5lbC5vcmciLCAiYmU5ZTRhIl0=
Received: from smtp.codeaurora.org
 (ec2-35-166-182-171.us-west-2.compute.amazonaws.com [35.166.182.171]) by
 smtp-out-n05.prod.us-west-2.postgun.com with SMTP id
 5f42034d52709f5476d9e156 (version=TLS1.2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256); Sun, 23 Aug 2020 05:49:01
 GMT
Received: by smtp.codeaurora.org (Postfix, from userid 1001)
        id 86C34C4339C; Sun, 23 Aug 2020 05:49:01 +0000 (UTC)
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
        aws-us-west-2-caf-mail-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.4 required=2.0 tests=ALL_TRUSTED,NICE_REPLY_A,
        SPF_NONE autolearn=unavailable autolearn_force=no version=3.4.0
Received: from [192.168.1.16] (unknown [61.3.22.212])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        (Authenticated sender: rnayak)
        by smtp.codeaurora.org (Postfix) with ESMTPSA id 3A823C433CA;
        Sun, 23 Aug 2020 05:48:57 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 smtp.codeaurora.org 3A823C433CA
Authentication-Results: aws-us-west-2-caf-mail-1.web.codeaurora.org; dmarc=none (p=none dis=none) header.from=codeaurora.org
Authentication-Results: aws-us-west-2-caf-mail-1.web.codeaurora.org; spf=none smtp.mailfrom=rnayak@codeaurora.org
Subject: Re: [PATCH V3 0/4] opp: general cleanups
To:     Viresh Kumar <viresh.kumar@linaro.org>, Nishanth Menon <nm@ti.com>,
        Stephen Boyd <sboyd@kernel.org>,
        Viresh Kumar <vireshk@kernel.org>
Cc:     linux-pm@vger.kernel.org,
        Vincent Guittot <vincent.guittot@linaro.org>,
        Rafael Wysocki <rjw@rjwysocki.net>, sibis@codeaurora.org,
        sbhanu@codeaurora.org, linux-kernel@vger.kernel.org
References: <cover.1597909885.git.viresh.kumar@linaro.org>
From:   Rajendra Nayak <rnayak@codeaurora.org>
Message-ID: <11c1cb5f-2ac3-3d30-f554-c782c1ab8a42@codeaurora.org>
Date:   Sun, 23 Aug 2020 11:18:55 +0530
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:68.0) Gecko/20100101
 Thunderbird/68.11.0
MIME-Version: 1.0
In-Reply-To: <cover.1597909885.git.viresh.kumar@linaro.org>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org


On 8/20/2020 1:26 PM, Viresh Kumar wrote:
> Hi,
> 
> Here is another version of the cleanups I sent earlier.
> 
> Rajendra: Please see if these work fine now.

I gave these a quick spin, and they don';t result in the crash I
earlier observed

Tested-by: Rajendra Nayak <rnayak@codeaurora.org>

> 
> V3:
> - Dropped v2 1/4 as it is already merged.
> - New patch 4/4 added.
> - Reordered the first two patches here (Stephen)
> - disable regulator only if present
> 
> Viresh Kumar (4):
>    opp: Rename regulator_enabled and use it as status of all resources
>    opp: Track device's resources configuration status
>    opp: Split out _opp_set_rate_zero()
>    opp: Remove _dev_pm_opp_find_and_remove_table() wrapper
> 
>   drivers/opp/core.c | 103 +++++++++++++++++++++------------------------
>   drivers/opp/cpu.c  |   2 +-
>   drivers/opp/of.c   |   2 +-
>   drivers/opp/opp.h  |   5 +--
>   4 files changed, 52 insertions(+), 60 deletions(-)
> 

-- 
QUALCOMM INDIA, on behalf of Qualcomm Innovation Center, Inc. is a member
of Code Aurora Forum, hosted by The Linux Foundation
