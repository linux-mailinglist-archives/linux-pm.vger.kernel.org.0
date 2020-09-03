Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 75C2E25C530
	for <lists+linux-pm@lfdr.de>; Thu,  3 Sep 2020 17:24:02 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728469AbgICPYA (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Thu, 3 Sep 2020 11:24:00 -0400
Received: from mail29.static.mailgun.info ([104.130.122.29]:52288 "EHLO
        mail29.static.mailgun.info" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1728331AbgICPX7 (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Thu, 3 Sep 2020 11:23:59 -0400
DKIM-Signature: a=rsa-sha256; v=1; c=relaxed/relaxed; d=mg.codeaurora.org; q=dns/txt;
 s=smtp; t=1599146637; h=In-Reply-To: Content-Transfer-Encoding:
 Content-Type: MIME-Version: References: Message-ID: Subject: Cc: To:
 From: Date: Sender; bh=1X4vn8rOorK5dJlqVRwXA3EBxlOggWWanY3wFSkuPqQ=; b=PUuCh0kNxJsHvCM7hXOCKCLPwCJpOnUu9f/f65Jx2bENi1zdBvH/gWN1BTJU0U8w0hvw+43w
 IWVzcYfz2s3WBnW0sRzcEmPPJOh5W+S6bwqz3DJEB57THZcpZybB+y3FtrSag2V2clnDzuKp
 QGo53O0LUc7mqWrDWK+osg15/bc=
X-Mailgun-Sending-Ip: 104.130.122.29
X-Mailgun-Sid: WyI5ZDFmMiIsICJsaW51eC1wbUB2Z2VyLmtlcm5lbC5vcmciLCAiYmU5ZTRhIl0=
Received: from smtp.codeaurora.org
 (ec2-35-166-182-171.us-west-2.compute.amazonaws.com [35.166.182.171]) by
 smtp-out-n04.prod.us-east-1.postgun.com with SMTP id
 5f510a8d9f3347551f8ca507 (version=TLS1.2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256); Thu, 03 Sep 2020 15:23:57
 GMT
Received: by smtp.codeaurora.org (Postfix, from userid 1001)
        id 708C5C43387; Thu,  3 Sep 2020 15:23:56 +0000 (UTC)
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
        aws-us-west-2-caf-mail-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=2.0 tests=ALL_TRUSTED,SPF_NONE
        autolearn=unavailable autolearn_force=no version=3.4.0
Received: from localhost (i-global254.qualcomm.com [199.106.103.254])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        (Authenticated sender: ilina)
        by smtp.codeaurora.org (Postfix) with ESMTPSA id 94516C433CB;
        Thu,  3 Sep 2020 15:23:55 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 smtp.codeaurora.org 94516C433CB
Authentication-Results: aws-us-west-2-caf-mail-1.web.codeaurora.org; dmarc=none (p=none dis=none) header.from=codeaurora.org
Authentication-Results: aws-us-west-2-caf-mail-1.web.codeaurora.org; spf=none smtp.mailfrom=ilina@codeaurora.org
Date:   Thu, 3 Sep 2020 09:23:54 -0600
From:   Lina Iyer <ilina@codeaurora.org>
To:     Daniel Lezcano <daniel.lezcano@linaro.org>
Cc:     rjw@rjwysocki.net, linux-pm@vger.kernel.org,
        linux-arm-msm@vger.kernel.org
Subject: Re: [PATCH] cpuidle: governor: export cpuidle_register_governor
Message-ID: <20200903152354.GA481@codeaurora.org>
References: <20200902205720.2548-1-ilina@codeaurora.org>
 <a36052ae-d9a9-37e4-53fc-5d8d6b541a50@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <a36052ae-d9a9-37e4-53fc-5d8d6b541a50@linaro.org>
User-Agent: Mutt/1.5.24 (2015-08-30)
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

On Thu, Sep 03 2020 at 04:35 -0600, Daniel Lezcano wrote:
>On 02/09/2020 22:57, Lina Iyer wrote:
>> Commit 83788c0caed3 ("cpuidle: remove unused exports") removed
>> capability of registering cpuidle governors, which was unused at that
>> time. By exporting the symbol, let's allow platform specific modules to
>> register cpuidle governors.
>
>That would make sense as that follows the same pattern than the cpufreq
>framework. However, the unregister part is missing.
>
Sure, let me add that too and repost.

--Lina

>> Signed-off-by: Lina Iyer <ilina@codeaurora.org>
>> ---
>>  drivers/cpuidle/governor.c | 1 +
>>  1 file changed, 1 insertion(+)
>>
>> diff --git a/drivers/cpuidle/governor.c b/drivers/cpuidle/governor.c
>> index 29acaf48e575..480ec58cffa9 100644
>> --- a/drivers/cpuidle/governor.c
>> +++ b/drivers/cpuidle/governor.c
>> @@ -102,6 +102,7 @@ int cpuidle_register_governor(struct cpuidle_governor *gov)
>>
>>  	return ret;
>>  }
>> +EXPORT_SYMBOL_GPL(cpuidle_register_governor);
>>
>>  /**
>>   * cpuidle_governor_latency_req - Compute a latency constraint for CPU
>>
>
>
>-- 
><http://www.linaro.org/> Linaro.org │ Open source software for ARM SoCs
>
>Follow Linaro:  <http://www.facebook.com/pages/Linaro> Facebook |
><http://twitter.com/#!/linaroorg> Twitter |
><http://www.linaro.org/linaro-blog/> Blog
