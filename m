Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 85B113EE9EB
	for <lists+linux-pm@lfdr.de>; Tue, 17 Aug 2021 11:32:04 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237640AbhHQJce (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Tue, 17 Aug 2021 05:32:34 -0400
Received: from so254-9.mailgun.net ([198.61.254.9]:30053 "EHLO
        so254-9.mailgun.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235402AbhHQJce (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Tue, 17 Aug 2021 05:32:34 -0400
DKIM-Signature: a=rsa-sha256; v=1; c=relaxed/relaxed; d=mg.codeaurora.org; q=dns/txt;
 s=smtp; t=1629192721; h=Content-Transfer-Encoding: Content-Type:
 In-Reply-To: MIME-Version: Date: Message-ID: From: References: Cc: To:
 Subject: Sender; bh=6sHZ1ZtwteF4o5eU2+kx2gIR+Rvv1gmPIdGlHOP95Yo=; b=ikmsG1QnyEj5qen/mUeEv6AwWa2GGtGvWc6OYMVjUWFSFTPUH0gr7hbK1b6WYEa2C8iU461I
 yZfHMC/Br8h3XduxamZSfZ9mEidGOz3Ri/VbDOT8JlicrasOB8MYc0smfcrXfW4YPa79XMTG
 Ifmhm/s5MTk3tUzZjGNgI/9a+LU=
X-Mailgun-Sending-Ip: 198.61.254.9
X-Mailgun-Sid: WyI5ZDFmMiIsICJsaW51eC1wbUB2Z2VyLmtlcm5lbC5vcmciLCAiYmU5ZTRhIl0=
Received: from smtp.codeaurora.org
 (ec2-35-166-182-171.us-west-2.compute.amazonaws.com [35.166.182.171]) by
 smtp-out-n07.prod.us-west-2.postgun.com with SMTP id
 611b820bf746c298d9e3d234 (version=TLS1.2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256); Tue, 17 Aug 2021 09:31:55
 GMT
Sender: mkshah=codeaurora.org@mg.codeaurora.org
Received: by smtp.codeaurora.org (Postfix, from userid 1001)
        id 79B3FC4360C; Tue, 17 Aug 2021 09:31:55 +0000 (UTC)
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
        aws-us-west-2-caf-mail-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.9 required=2.0 tests=ALL_TRUSTED,BAYES_00,
        NICE_REPLY_A,SPF_FAIL,URIBL_BLOCKED autolearn=ham autolearn_force=no
        version=3.4.0
Received: from [192.168.29.129] (unknown [49.36.81.12])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        (Authenticated sender: mkshah)
        by smtp.codeaurora.org (Postfix) with ESMTPSA id 2C78CC4338F;
        Tue, 17 Aug 2021 09:31:51 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.1 smtp.codeaurora.org 2C78CC4338F
Authentication-Results: aws-us-west-2-caf-mail-1.web.codeaurora.org; dmarc=none (p=none dis=none) header.from=codeaurora.org
Authentication-Results: aws-us-west-2-caf-mail-1.web.codeaurora.org; spf=fail smtp.mailfrom=codeaurora.org
Subject: Re: [PATCH] cpuidle: governor: export cpuidle governor functions
To:     Daniel Lezcano <daniel.lezcano@linaro.org>,
        "Rafael J. Wysocki" <rafael@kernel.org>
Cc:     "Rafael J. Wysocki" <rjw@rjwysocki.net>,
        Linux PM <linux-pm@vger.kernel.org>,
        linux-arm-msm <linux-arm-msm@vger.kernel.org>,
        Saravana Kannan <saravanak@google.com>,
        Todd Kjos <tkjos@google.com>,
        Srinivas Rao L <lsrao@codeaurora.org>
References: <010101746fc98add-45e77496-d2d6-4bc1-a1ce-0692599a9a7a-000000@us-west-2.amazonses.com>
 <CAJZ5v0hJJxxb+J5UtyZe2S_Tn7ARoGvjwDjw4dq601VJrriH9g@mail.gmail.com>
 <20200922161215.GD30658@codeaurora.org>
 <CAJZ5v0ipDRkPe6N9B6RzvHyCBobz8B9EoBfPh4DANrL_e86+Ww@mail.gmail.com>
 <bd62ffea-9736-f8f7-6a48-13e81f802aea@linaro.org>
From:   Maulik Shah <mkshah@codeaurora.org>
Message-ID: <2fe42a4d-469a-0424-45d4-5d7027c88263@codeaurora.org>
Date:   Tue, 17 Aug 2021 15:01:49 +0530
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:78.0) Gecko/20100101
 Thunderbird/78.12.0
MIME-Version: 1.0
In-Reply-To: <bd62ffea-9736-f8f7-6a48-13e81f802aea@linaro.org>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Content-Language: en-GB
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

Hi Daniel/Rafael,

 >> would it make sense to convert the governors into modules

i am not aware if this was not pursued further due to any issue.

Do you see any concerns to allow existing governors compiled as loadable 
module?
if not i can work on same and post. please do let me know your thoughts 
on this.

i have CCed Saravana and Todd for awareness.

Thanks,
Maulik

On 10/10/2020 1:56 AM, Daniel Lezcano wrote:
> Hi Rafael,
>
> On 22/09/2020 19:27, Rafael J. Wysocki wrote:
>> Hi Lina,
>>
>> On Tue, Sep 22, 2020 at 6:12 PM Lina Iyer <ilina@codeaurora.org> wrote:
>>> Hi Rafael,
>>>
>>> On Tue, Sep 22 2020 at 10:00 -0600, Rafael J. Wysocki wrote:
>>>> Sorry for the delay.
>>>>
>>>> On Wed, Sep 9, 2020 at 12:15 AM Lina Iyer <ilina@codeaurora.org> wrote:
>>>>> Commit 83788c0caed3 ("cpuidle: remove unused exports") removed
>>>>> capability of registering cpuidle governors, which was unused at that
>>>>> time. By exporting the symbol, let's allow platform specific modules to
>>>>> register cpuidle governors and use cpuidle_governor_latency_req() to get
>>>>> the QoS for the CPU.
>>>> Which platform-specific modules may want to do that and why?
>>>>
>>> We are planning a custom cpuidle governor for QCOM SoCs. With Android,
>>> the idea is to make them loadable modules so they can be in a separate
>>> partition.
>> Well, the $subject patch is not applicable without a mainline user
>> requiring this, so it needs to be posted along with that user.
> Putting apart the custom cpuidle governor mentioned above, would it make
> sense to convert the governors into modules ? It is pointless to have
> all of them compiled in, especially with distros doing make
> allmodconfig, no?
>
>
-- 
QUALCOMM INDIA, on behalf of Qualcomm Innovation Center, Inc. is a member of Code Aurora Forum, hosted by The Linux Foundation

