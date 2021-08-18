Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3CBCA3EF9A5
	for <lists+linux-pm@lfdr.de>; Wed, 18 Aug 2021 06:44:05 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236287AbhHREoh (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Wed, 18 Aug 2021 00:44:37 -0400
Received: from m43-7.mailgun.net ([69.72.43.7]:13628 "EHLO m43-7.mailgun.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S237565AbhHREoh (ORCPT <rfc822;linux-pm@vger.kernel.org>);
        Wed, 18 Aug 2021 00:44:37 -0400
DKIM-Signature: a=rsa-sha256; v=1; c=relaxed/relaxed; d=mg.codeaurora.org; q=dns/txt;
 s=smtp; t=1629261843; h=Content-Transfer-Encoding: Content-Type:
 In-Reply-To: MIME-Version: Date: Message-ID: References: Cc: To:
 Subject: From: Sender; bh=5gfuhlHOrex3OrHOs8ZwU6QWvfo1GgFjx0nSGuiUXvg=;
 b=t556L1xDESsHnSv48u9xlM/q7SAJ3W+2B0mpoM7FTKcVKuCJHl1EFnMt5pfScaefLzvnX4w5
 yCzLuFk8uc8Vs7BHZhWbh5+w6spczWIrQeDypNXOW9BESmGGDM2XEWaK8MnlBaudFrY6d1u2
 CiLLeiVZYlRtHPpwI1FwjK3q9yo=
X-Mailgun-Sending-Ip: 69.72.43.7
X-Mailgun-Sid: WyI5ZDFmMiIsICJsaW51eC1wbUB2Z2VyLmtlcm5lbC5vcmciLCAiYmU5ZTRhIl0=
Received: from smtp.codeaurora.org
 (ec2-35-166-182-171.us-west-2.compute.amazonaws.com [35.166.182.171]) by
 smtp-out-n03.prod.us-east-1.postgun.com with SMTP id
 611c90099507ca1a34a037a8 (version=TLS1.2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256); Wed, 18 Aug 2021 04:43:53
 GMT
Sender: mdtipton=codeaurora.org@mg.codeaurora.org
Received: by smtp.codeaurora.org (Postfix, from userid 1001)
        id B32CCC4360D; Wed, 18 Aug 2021 04:43:52 +0000 (UTC)
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
        aws-us-west-2-caf-mail-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.9 required=2.0 tests=ALL_TRUSTED,BAYES_00,
        NICE_REPLY_A,SPF_FAIL,URIBL_BLOCKED autolearn=ham autolearn_force=no
        version=3.4.0
Received: from [192.168.1.159] (ip70-179-20-127.sd.sd.cox.net [70.179.20.127])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        (Authenticated sender: mdtipton)
        by smtp.codeaurora.org (Postfix) with ESMTPSA id 6ADF9C43460;
        Wed, 18 Aug 2021 04:43:51 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.1 smtp.codeaurora.org 6ADF9C43460
Authentication-Results: aws-us-west-2-caf-mail-1.web.codeaurora.org; dmarc=none (p=none dis=none) header.from=codeaurora.org
Authentication-Results: aws-us-west-2-caf-mail-1.web.codeaurora.org; spf=fail smtp.mailfrom=codeaurora.org
From:   Mike Tipton <mdtipton@codeaurora.org>
Subject: Re: [PATCH v2 4/4] interconnect: qcom: icc-rpmh: Add BCMs to commit
 list in pre_aggregate
To:     Stephen Boyd <swboyd@chromium.org>, Alex Elder <elder@linaro.org>,
        djakov@kernel.org
Cc:     bjorn.andersson@linaro.org, agross@kernel.org,
        saravanak@google.com, okukatla@codeaurora.org,
        linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-arm-msm@vger.kernel.org
References: <20210721175432.2119-1-mdtipton@codeaurora.org>
 <20210721175432.2119-5-mdtipton@codeaurora.org>
 <CAE-0n52iVgX0JjjnYi=NDg49xP961p=+W5R2bmO+2xwRceFhfA@mail.gmail.com>
 <0e659a74-ba52-2262-f7ce-eddf4a655b63@linaro.org>
 <CAE-0n53GfD-8d0NJ+Hv1wcx0DDACc5_gT3qV0NR-vLiZgtCKpg@mail.gmail.com>
Message-ID: <49eeb675-3c76-ef3e-708d-230ec980202f@codeaurora.org>
Date:   Tue, 17 Aug 2021 21:43:50 -0700
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:78.0) Gecko/20100101
 Thunderbird/78.11.0
MIME-Version: 1.0
In-Reply-To: <CAE-0n53GfD-8d0NJ+Hv1wcx0DDACc5_gT3qV0NR-vLiZgtCKpg@mail.gmail.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

On 8/11/2021 11:13 AM, Stephen Boyd wrote:
> Quoting Alex Elder (2021-08-11 09:01:27)
>> On 8/10/21 6:31 PM, Stephen Boyd wrote:
>>> Quoting Mike Tipton (2021-07-21 10:54:32)
>>>> We're only adding BCMs to the commit list in aggregate(), but there are
>>>> cases where pre_aggregate() is called without subsequently calling
>>>> aggregate(). In particular, in icc_sync_state() when a node with initial
>>>> BW has zero requests. Since BCMs aren't added to the commit list in
>>>> these cases, we don't actually send the zero BW request to HW. So the
>>>> resources remain on unnecessarily.
>>>>
>>>> Add BCMs to the commit list in pre_aggregate() instead, which is always
>>>> called even when there are no requests.
>>>>
>>>> Fixes: 976daac4a1c5 ("interconnect: qcom: Consolidate interconnect RPMh support")
>>>> Signed-off-by: Mike Tipton <mdtipton@codeaurora.org>
>>>> ---
>>>
>>> This patch breaks reboot for me on sc7180 Lazor
>>
>> If I am using the interface improperly or something in the
>> IPA driver, please let me know.  I actually plan to switch
>> to using the bulk interfaces soon (FYI).
>>
> 
> I suspect I'm seeing a shutdown ordering issue, where we start dropping
> interconnect requests in driver shutdown callbacks and then some bus
> turns off and the CPU can't access a device. Maybe to fix this problem
> (if reverting isn't an option) would be to add a shutdown hook to
> rpmh-icc that effectively "props up" the bandwidth requests during
> shutdown so that we don't have to think about finding the place that the
> interconnect is turned off. We're shutting down/restarting anyway, so
> there isn't much point in trying to be power efficient for the last few
> moments of runtime.
> 

I wouldn't have expected this change to impact reboot, since this change 
should only impact places where pre_aggregate() is called without 
subsequently calling aggregate(). I don't think there are currently any 
places that can happen other than icc_sync_state().

I suppose what could be happening is we're now disabling certain paths 
in icc_sync_state() and their associated drivers just aren't used or 
attempting accesses until they're being torn down in reboot. That 
doesn't seem particularly likely, but nothing else immediately comes to 
mind.

We already mark paths critical for the CPU as "keepalive" such that 
they'll never turn off. This includes the CPU path to DDR and top-level 
CSRs. Basically just paths that can't actually be turned off while SW is 
running. That logic is unchanged in this patch. So we generally 
shouldn't need any shutdown-specific callbacks to place BW votes during 
this window. Client drivers should still ensure they're sequencing their 
shutdown logic such that any bus accesses happen before they remove 
their BW requests.
