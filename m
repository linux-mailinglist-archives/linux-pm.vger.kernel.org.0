Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 643F425C5BE
	for <lists+linux-pm@lfdr.de>; Thu,  3 Sep 2020 17:50:39 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728514AbgICPuU (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Thu, 3 Sep 2020 11:50:20 -0400
Received: from m43-7.mailgun.net ([69.72.43.7]:45813 "EHLO m43-7.mailgun.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728372AbgICPuS (ORCPT <rfc822;linux-pm@vger.kernel.org>);
        Thu, 3 Sep 2020 11:50:18 -0400
DKIM-Signature: a=rsa-sha256; v=1; c=relaxed/relaxed; d=mg.codeaurora.org; q=dns/txt;
 s=smtp; t=1599148218; h=In-Reply-To: Content-Transfer-Encoding:
 Content-Type: MIME-Version: References: Message-ID: Subject: Cc: To:
 From: Date: Sender; bh=YmNSPzX7Rssmeydnknj+Kk/0kRWPES/mHUw8d72by64=; b=u0GIW3h1VbD+mH6VAvIaqoluxEnJQDWOICUqIBmJaV1PnwD3KeF6zxogdzp5t+7KFNlBZn6Z
 qpA+DD1BgYgZBwAvwEi1GPhJ/2pWWlvk7aq1pumv0JOEjqVnDml7dyqgp1gnzMFQtO8y2Out
 Tz/HtFFdDwX8epxrOMLAiAKKezY=
X-Mailgun-Sending-Ip: 69.72.43.7
X-Mailgun-Sid: WyI5ZDFmMiIsICJsaW51eC1wbUB2Z2VyLmtlcm5lbC5vcmciLCAiYmU5ZTRhIl0=
Received: from smtp.codeaurora.org
 (ec2-35-166-182-171.us-west-2.compute.amazonaws.com [35.166.182.171]) by
 smtp-out-n05.prod.us-east-1.postgun.com with SMTP id
 5f5110b89f3347551f9d0025 (version=TLS1.2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256); Thu, 03 Sep 2020 15:50:16
 GMT
Received: by smtp.codeaurora.org (Postfix, from userid 1001)
        id C7A6FC433C8; Thu,  3 Sep 2020 15:50:15 +0000 (UTC)
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
        aws-us-west-2-caf-mail-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=2.0 tests=ALL_TRUSTED,SPF_NONE
        autolearn=ham autolearn_force=no version=3.4.0
Received: from localhost (i-global254.qualcomm.com [199.106.103.254])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        (Authenticated sender: ilina)
        by smtp.codeaurora.org (Postfix) with ESMTPSA id 4358EC433C9;
        Thu,  3 Sep 2020 15:50:15 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 smtp.codeaurora.org 4358EC433C9
Authentication-Results: aws-us-west-2-caf-mail-1.web.codeaurora.org; dmarc=none (p=none dis=none) header.from=codeaurora.org
Authentication-Results: aws-us-west-2-caf-mail-1.web.codeaurora.org; spf=none smtp.mailfrom=ilina@codeaurora.org
Date:   Thu, 3 Sep 2020 09:50:14 -0600
From:   Lina Iyer <ilina@codeaurora.org>
To:     Daniel Lezcano <daniel.lezcano@linaro.org>
Cc:     rjw@rjwysocki.net, linux-pm@vger.kernel.org,
        linux-arm-msm@vger.kernel.org
Subject: Re: [PATCH] cpuidle: governor: export cpuidle_register_governor
Message-ID: <20200903155014.GB481@codeaurora.org>
References: <20200902205720.2548-1-ilina@codeaurora.org>
 <a36052ae-d9a9-37e4-53fc-5d8d6b541a50@linaro.org>
 <20200903152354.GA481@codeaurora.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20200903152354.GA481@codeaurora.org>
User-Agent: Mutt/1.5.24 (2015-08-30)
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

On Thu, Sep 03 2020 at 09:23 -0600, Lina Iyer wrote:
>On Thu, Sep 03 2020 at 04:35 -0600, Daniel Lezcano wrote:
>>On 02/09/2020 22:57, Lina Iyer wrote:
>>>Commit 83788c0caed3 ("cpuidle: remove unused exports") removed
>>>capability of registering cpuidle governors, which was unused at that
>>>time. By exporting the symbol, let's allow platform specific modules to
>>>register cpuidle governors.
>>
>>That would make sense as that follows the same pattern than the cpufreq
>>framework. However, the unregister part is missing.
>>
>Sure, let me add that too and repost.
>
Looks like there isn't any call to unregister a governor, which seems
fair.

Also, what do you think about exporting cpuidle_governor_latency_req()?
This could prove quite useful for a governor. I could add that in a
repost.

>--Lina
>
>>>Signed-off-by: Lina Iyer <ilina@codeaurora.org>
>>>---
>>> drivers/cpuidle/governor.c | 1 +
>>> 1 file changed, 1 insertion(+)
>>>
>>>diff --git a/drivers/cpuidle/governor.c b/drivers/cpuidle/governor.c
>>>index 29acaf48e575..480ec58cffa9 100644
>>>--- a/drivers/cpuidle/governor.c
>>>+++ b/drivers/cpuidle/governor.c
>>>@@ -102,6 +102,7 @@ int cpuidle_register_governor(struct cpuidle_governor *gov)
>>>
>>> 	return ret;
>>> }
>>>+EXPORT_SYMBOL_GPL(cpuidle_register_governor);
>>>
>>> /**
>>>  * cpuidle_governor_latency_req - Compute a latency constraint for CPU
>>>
>>
>>
>>-- 
>><http://www.linaro.org/> Linaro.org │ Open source software for ARM SoCs
>>
>>Follow Linaro:  <http://www.facebook.com/pages/Linaro> Facebook |
>><http://twitter.com/#!/linaroorg> Twitter |
>><http://www.linaro.org/linaro-blog/> Blog
