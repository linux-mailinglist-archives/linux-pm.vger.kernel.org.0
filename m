Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7548F3EF9A2
	for <lists+linux-pm@lfdr.de>; Wed, 18 Aug 2021 06:43:31 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237580AbhHREoD (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Wed, 18 Aug 2021 00:44:03 -0400
Received: from so254-9.mailgun.net ([198.61.254.9]:44242 "EHLO
        so254-9.mailgun.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236664AbhHREoC (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Wed, 18 Aug 2021 00:44:02 -0400
DKIM-Signature: a=rsa-sha256; v=1; c=relaxed/relaxed; d=mg.codeaurora.org; q=dns/txt;
 s=smtp; t=1629261808; h=Content-Transfer-Encoding: Content-Type:
 In-Reply-To: MIME-Version: Date: Message-ID: References: Cc: To:
 Subject: From: Sender; bh=84d/b9xhLIn1Jlz2CQezqi4i1lRkW5aMddLb9rwJBHg=;
 b=bzchOXhGxi3vGkAR/3bNZQhvKdkZOpku5hLehJshCk3iBPKMgBHtPRtM8q5+8zDmQnQxDqWB
 2PaX5095YWidUR3oXHza4lCtluNIZle6YZhjFPvAUFwwFq9IfaoF7wUVDtOjIE499OFlrUqc
 PzUgQwOX41OH2Zz9CscqR/rPiuI=
X-Mailgun-Sending-Ip: 198.61.254.9
X-Mailgun-Sid: WyI5ZDFmMiIsICJsaW51eC1wbUB2Z2VyLmtlcm5lbC5vcmciLCAiYmU5ZTRhIl0=
Received: from smtp.codeaurora.org
 (ec2-35-166-182-171.us-west-2.compute.amazonaws.com [35.166.182.171]) by
 smtp-out-n05.prod.us-west-2.postgun.com with SMTP id
 611c8ff03f142481723e3455 (version=TLS1.2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256); Wed, 18 Aug 2021 04:43:28
 GMT
Sender: mdtipton=codeaurora.org@mg.codeaurora.org
Received: by smtp.codeaurora.org (Postfix, from userid 1001)
        id 20FA4C4361A; Wed, 18 Aug 2021 04:43:28 +0000 (UTC)
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
        aws-us-west-2-caf-mail-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.9 required=2.0 tests=ALL_TRUSTED,BAYES_00,
        NICE_REPLY_A,SPF_FAIL,URIBL_BLOCKED autolearn=unavailable autolearn_force=no
        version=3.4.0
Received: from [192.168.1.159] (ip70-179-20-127.sd.sd.cox.net [70.179.20.127])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        (Authenticated sender: mdtipton)
        by smtp.codeaurora.org (Postfix) with ESMTPSA id 63EACC4360C;
        Wed, 18 Aug 2021 04:43:26 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.1 smtp.codeaurora.org 63EACC4360C
Authentication-Results: aws-us-west-2-caf-mail-1.web.codeaurora.org; dmarc=none (p=none dis=none) header.from=codeaurora.org
Authentication-Results: aws-us-west-2-caf-mail-1.web.codeaurora.org; spf=fail smtp.mailfrom=codeaurora.org
From:   Mike Tipton <mdtipton@codeaurora.org>
Subject: Re: [PATCH v2 4/4] interconnect: qcom: icc-rpmh: Add BCMs to commit
 list in pre_aggregate
To:     Bjorn Andersson <bjorn.andersson@linaro.org>,
        Stephen Boyd <swboyd@chromium.org>
Cc:     djakov@kernel.org, agross@kernel.org, saravanak@google.com,
        okukatla@codeaurora.org, linux-pm@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-arm-msm@vger.kernel.org,
        Alex Elder <elder@linaro.org>
References: <20210721175432.2119-1-mdtipton@codeaurora.org>
 <20210721175432.2119-5-mdtipton@codeaurora.org>
 <CAE-0n52iVgX0JjjnYi=NDg49xP961p=+W5R2bmO+2xwRceFhfA@mail.gmail.com>
 <YRMXOlA5a98BwT3i@builder.lan>
Message-ID: <1484f6d6-0eac-b3e0-57e5-0443043debd1@codeaurora.org>
Date:   Tue, 17 Aug 2021 21:43:25 -0700
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:78.0) Gecko/20100101
 Thunderbird/78.11.0
MIME-Version: 1.0
In-Reply-To: <YRMXOlA5a98BwT3i@builder.lan>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

On 8/10/2021 5:18 PM, Bjorn Andersson wrote:
> On Tue 10 Aug 18:31 CDT 2021, Stephen Boyd wrote:
> 
>> Quoting Mike Tipton (2021-07-21 10:54:32)
>>> We're only adding BCMs to the commit list in aggregate(), but there are
>>> cases where pre_aggregate() is called without subsequently calling
>>> aggregate(). In particular, in icc_sync_state() when a node with initial
>>> BW has zero requests. Since BCMs aren't added to the commit list in
>>> these cases, we don't actually send the zero BW request to HW. So the
>>> resources remain on unnecessarily.
>>>
>>> Add BCMs to the commit list in pre_aggregate() instead, which is always
>>> called even when there are no requests.
>>>
>>> Fixes: 976daac4a1c5 ("interconnect: qcom: Consolidate interconnect RPMh support")
>>> Signed-off-by: Mike Tipton <mdtipton@codeaurora.org>
>>> ---
>>
>> This patch breaks reboot for me on sc7180 Lazor
>>
> 
> FWIW, it prevents at least SM8150 from booting (need to check my other
> boards as well), because its no longer okay to have the interconnect
> providers defined without having all client paths specified.

My testing was limited to sdm845, which didn't show any boot issues. But 
it's not terribly surprising for this to cause problems on some targets. 
Previously every node was enabled by default and left on permanently if 
nobody explicitly voted for them. This would happen even if these nodes 
weren't enabled in bootloaders, since most of the qcom providers aren't 
defining a get_bw() callback and thus the framework defaults 
init_avg/init_peak to INT_MAX. So any drivers relying on this default-on 
behavior would break.

We can try to get dumps of the NOC error registers at the time of 
failure to pinpoint the problematic access. Or we could try to narrow it 
down by marking more BCMs as keepalive. If they're marked as keepalive 
then we won't let them turn off even with this patch.

> 
> Regards,
> Bjorn
> 
