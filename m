Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5CF38274645
	for <lists+linux-pm@lfdr.de>; Tue, 22 Sep 2020 18:12:46 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726667AbgIVQMp (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Tue, 22 Sep 2020 12:12:45 -0400
Received: from z5.mailgun.us ([104.130.96.5]:32738 "EHLO z5.mailgun.us"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726637AbgIVQMp (ORCPT <rfc822;linux-pm@vger.kernel.org>);
        Tue, 22 Sep 2020 12:12:45 -0400
DKIM-Signature: a=rsa-sha256; v=1; c=relaxed/relaxed; d=mg.codeaurora.org; q=dns/txt;
 s=smtp; t=1600791165; h=In-Reply-To: Content-Type: MIME-Version:
 References: Message-ID: Subject: Cc: To: From: Date: Sender;
 bh=EZRwqUT9E3jZrgdjNm8FFMtkMTg/4V6XnlWG1JPmllI=; b=Og5ae/8y9kZ/ds9RgXrBG9/ZCVbkyDrpXcS2JtkqgZmJIGMln2yjiuh/tY7zZS4VSwkVXpFZ
 5YiTy07WQOhoPhkDXrZZobwfTrUzFgVAChqWBFKmkP3SNEoEtaV/IBF4Km38mQR1qNc5dSir
 AmdkmG5vAJz06k1YFo6PpwDMzoE=
X-Mailgun-Sending-Ip: 104.130.96.5
X-Mailgun-Sid: WyI5ZDFmMiIsICJsaW51eC1wbUB2Z2VyLmtlcm5lbC5vcmciLCAiYmU5ZTRhIl0=
Received: from smtp.codeaurora.org
 (ec2-35-166-182-171.us-west-2.compute.amazonaws.com [35.166.182.171]) by
 smtp-out-n03.prod.us-east-1.postgun.com with SMTP id
 5f6a226145a0e38d8175087b (version=TLS1.2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256); Tue, 22 Sep 2020 16:12:17
 GMT
Sender: ilina=codeaurora.org@mg.codeaurora.org
Received: by smtp.codeaurora.org (Postfix, from userid 1001)
        id 309DCC433F1; Tue, 22 Sep 2020 16:12:17 +0000 (UTC)
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
        aws-us-west-2-caf-mail-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.9 required=2.0 tests=ALL_TRUSTED,BAYES_00,SPF_FAIL,
        URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from localhost (i-global254.qualcomm.com [199.106.103.254])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        (Authenticated sender: ilina)
        by smtp.codeaurora.org (Postfix) with ESMTPSA id 7583FC433C8;
        Tue, 22 Sep 2020 16:12:16 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 smtp.codeaurora.org 7583FC433C8
Authentication-Results: aws-us-west-2-caf-mail-1.web.codeaurora.org; dmarc=none (p=none dis=none) header.from=codeaurora.org
Authentication-Results: aws-us-west-2-caf-mail-1.web.codeaurora.org; spf=fail smtp.mailfrom=ilina@codeaurora.org
Date:   Tue, 22 Sep 2020 10:12:15 -0600
From:   Lina Iyer <ilina@codeaurora.org>
To:     "Rafael J. Wysocki" <rafael@kernel.org>
Cc:     "Rafael J. Wysocki" <rjw@rjwysocki.net>,
        Daniel Lezcano <daniel.lezcano@linaro.org>,
        Linux PM <linux-pm@vger.kernel.org>,
        linux-arm-msm <linux-arm-msm@vger.kernel.org>
Subject: Re: [PATCH] cpuidle: governor: export cpuidle governor functions
Message-ID: <20200922161215.GD30658@codeaurora.org>
References: <010101746fc98add-45e77496-d2d6-4bc1-a1ce-0692599a9a7a-000000@us-west-2.amazonses.com>
 <CAJZ5v0hJJxxb+J5UtyZe2S_Tn7ARoGvjwDjw4dq601VJrriH9g@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Disposition: inline
In-Reply-To: <CAJZ5v0hJJxxb+J5UtyZe2S_Tn7ARoGvjwDjw4dq601VJrriH9g@mail.gmail.com>
User-Agent: Mutt/1.5.24 (2015-08-30)
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

Hi Rafael,

On Tue, Sep 22 2020 at 10:00 -0600, Rafael J. Wysocki wrote:
>Sorry for the delay.
>
>On Wed, Sep 9, 2020 at 12:15 AM Lina Iyer <ilina@codeaurora.org> wrote:
>>
>> Commit 83788c0caed3 ("cpuidle: remove unused exports") removed
>> capability of registering cpuidle governors, which was unused at that
>> time. By exporting the symbol, let's allow platform specific modules to
>> register cpuidle governors and use cpuidle_governor_latency_req() to get
>> the QoS for the CPU.
>
>Which platform-specific modules may want to do that and why?
>
We are planning a custom cpuidle governor for QCOM SoCs. With Android,
the idea is to make them loadable modules so they can be in a separate
partition.

Thanks,
Lina

>> Signed-off-by: Lina Iyer <ilina@codeaurora.org>
>> ---
>>  drivers/cpuidle/governor.c | 2 ++
>>  1 file changed, 2 insertions(+)
>>
>> diff --git a/drivers/cpuidle/governor.c b/drivers/cpuidle/governor.c
>> index 29acaf48e575..0e51ed25665e 100644
>> --- a/drivers/cpuidle/governor.c
>> +++ b/drivers/cpuidle/governor.c
>> @@ -102,6 +102,7 @@ int cpuidle_register_governor(struct cpuidle_governor *gov)
>>
>>         return ret;
>>  }
>> +EXPORT_SYMBOL_GPL(cpuidle_register_governor);
>>
>>  /**
>>   * cpuidle_governor_latency_req - Compute a latency constraint for CPU
>> @@ -118,3 +119,4 @@ s64 cpuidle_governor_latency_req(unsigned int cpu)
>>
>>         return (s64)device_req * NSEC_PER_USEC;
>>  }
>> +EXPORT_SYMBOL_GPL(cpuidle_governor_latency_req);
>> --
>> The Qualcomm Innovation Center, Inc. is a member of the Code Aurora Forum,
>> a Linux Foundation Collaborative Project
>>
