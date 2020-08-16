Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 036BE245797
	for <lists+linux-pm@lfdr.de>; Sun, 16 Aug 2020 14:31:35 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726978AbgHPMbb (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Sun, 16 Aug 2020 08:31:31 -0400
Received: from mail29.static.mailgun.info ([104.130.122.29]:27547 "EHLO
        mail29.static.mailgun.info" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726111AbgHPMb2 (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Sun, 16 Aug 2020 08:31:28 -0400
DKIM-Signature: a=rsa-sha256; v=1; c=relaxed/relaxed; d=mg.codeaurora.org; q=dns/txt;
 s=smtp; t=1597581088; h=Content-Transfer-Encoding: Content-Type:
 In-Reply-To: MIME-Version: Date: Message-ID: From: References: Cc: To:
 Subject: Sender; bh=A5endb3UXC0CBZPpVKQijXSpyYPPkWE4IYQIb4AXgrY=; b=A8/paoz9slfYRExd73VahG2LlP0hLULZueQiu9modXaLwNzWGBW6HrsiKaqQYLCvRi2Douuq
 UxNL6MvbSN6vma/10k13ONmY59L5WL1TKgfeDKmp0QTPGg0mrZI7NDtB+j/SSMwWLoWTeGK4
 nVF1CnVelYi76BRXUDIeBlrDBDo=
X-Mailgun-Sending-Ip: 104.130.122.29
X-Mailgun-Sid: WyI5ZDFmMiIsICJsaW51eC1wbUB2Z2VyLmtlcm5lbC5vcmciLCAiYmU5ZTRhIl0=
Received: from smtp.codeaurora.org
 (ec2-35-166-182-171.us-west-2.compute.amazonaws.com [35.166.182.171]) by
 smtp-out-n05.prod.us-west-2.postgun.com with SMTP id
 5f3926f8d96d28d61ed51d0c (version=TLS1.2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256); Sun, 16 Aug 2020 12:30:48
 GMT
Received: by smtp.codeaurora.org (Postfix, from userid 1001)
        id F3521C43395; Sun, 16 Aug 2020 12:30:47 +0000 (UTC)
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
        aws-us-west-2-caf-mail-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.0 required=2.0 tests=ALL_TRUSTED,NICE_REPLY_A,
        SPF_NONE autolearn=unavailable autolearn_force=no version=3.4.0
Received: from [192.168.1.15] (unknown [117.247.20.134])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        (Authenticated sender: rnayak)
        by smtp.codeaurora.org (Postfix) with ESMTPSA id 40B76C433C6;
        Sun, 16 Aug 2020 12:30:44 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 smtp.codeaurora.org 40B76C433C6
Authentication-Results: aws-us-west-2-caf-mail-1.web.codeaurora.org; dmarc=none (p=none dis=none) header.from=codeaurora.org
Authentication-Results: aws-us-west-2-caf-mail-1.web.codeaurora.org; spf=none smtp.mailfrom=rnayak@codeaurora.org
Subject: Re: [PATCH] opp: Fix dev_pm_opp_set_rate() to not return early
To:     Viresh Kumar <viresh.kumar@linaro.org>,
        Stephen Boyd <sboyd@kernel.org>
Cc:     nm@ti.com, vireshk@kernel.org, linux-pm@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-arm-msm@vger.kernel.org
References: <1597043179-17903-1-git-send-email-rnayak@codeaurora.org>
 <159718019170.1360974.4800051292737590657@swboyd.mtv.corp.google.com>
 <20200813042940.dg75g7oj3iiyuu4k@vireshk-mac-ubuntu>
From:   Rajendra Nayak <rnayak@codeaurora.org>
Message-ID: <40a1e82d-96b4-4930-a0e8-740e41a57cbf@codeaurora.org>
Date:   Sun, 16 Aug 2020 18:00:41 +0530
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:68.0) Gecko/20100101
 Thunderbird/68.11.0
MIME-Version: 1.0
In-Reply-To: <20200813042940.dg75g7oj3iiyuu4k@vireshk-mac-ubuntu>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org


On 8/13/2020 9:59 AM, Viresh Kumar wrote:
> On 11-08-20, 14:09, Stephen Boyd wrote:
>> This is a goto maze! Any chance we can clean this up?
> 
> I have sent a short series in reply to this series, please have a
> look. It should look better now.

Thanks, I was out a few days so could not get to the cleanups
that Stephen was suggesting.
I will give your series a try.

-- 
QUALCOMM INDIA, on behalf of Qualcomm Innovation Center, Inc. is a member
of Code Aurora Forum, hosted by The Linux Foundation
