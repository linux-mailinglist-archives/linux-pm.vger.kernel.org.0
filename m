Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 50B703C5F70
	for <lists+linux-pm@lfdr.de>; Mon, 12 Jul 2021 17:40:32 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235474AbhGLPnT (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Mon, 12 Jul 2021 11:43:19 -0400
Received: from m43-7.mailgun.net ([69.72.43.7]:45442 "EHLO m43-7.mailgun.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S233225AbhGLPnT (ORCPT <rfc822;linux-pm@vger.kernel.org>);
        Mon, 12 Jul 2021 11:43:19 -0400
DKIM-Signature: a=rsa-sha256; v=1; c=relaxed/relaxed; d=mg.codeaurora.org; q=dns/txt;
 s=smtp; t=1626104430; h=Content-Transfer-Encoding: Content-Type:
 In-Reply-To: MIME-Version: Date: Message-ID: References: Cc: To:
 Subject: From: Sender; bh=KVqF9QLdzAaHdNmKyTR6MevSTnWOxaAjQ+zmx82O5i4=;
 b=d/0kgEAc7uxR7Bf6uKjd1Bp1++ZEphG5zi5m+Td1nUsovJVQlZUwragkmgziORWXMFxO3ZGe
 QvId/cK2J1CO/6G+a+MHXa9dGo7PBPgm+Gsq4e3uLXX+Wlo0HWLAgImJdnVVV+vNbT5iVbFs
 87r1Ft9Uxvu3Dj8VnVFAjfhWyW8=
X-Mailgun-Sending-Ip: 69.72.43.7
X-Mailgun-Sid: WyI5ZDFmMiIsICJsaW51eC1wbUB2Z2VyLmtlcm5lbC5vcmciLCAiYmU5ZTRhIl0=
Received: from smtp.codeaurora.org
 (ec2-35-166-182-171.us-west-2.compute.amazonaws.com [35.166.182.171]) by
 smtp-out-n03.prod.us-east-1.postgun.com with SMTP id
 60ec6251f30429861417df68 (version=TLS1.2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256); Mon, 12 Jul 2021 15:40:01
 GMT
Sender: mdtipton=codeaurora.org@mg.codeaurora.org
Received: by smtp.codeaurora.org (Postfix, from userid 1001)
        id C8F7DC4338A; Mon, 12 Jul 2021 15:40:00 +0000 (UTC)
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
        aws-us-west-2-caf-mail-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.4 required=2.0 tests=ALL_TRUSTED,BAYES_00,
        NICE_REPLY_A,SPF_FAIL,URIBL_BLOCKED autolearn=unavailable autolearn_force=no
        version=3.4.0
Received: from [192.168.1.12] (pool-96-253-99-54.rcmdva.fios.verizon.net [96.253.99.54])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        (Authenticated sender: mdtipton)
        by smtp.codeaurora.org (Postfix) with ESMTPSA id 01AB0C433D3;
        Mon, 12 Jul 2021 15:39:58 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 smtp.codeaurora.org 01AB0C433D3
Authentication-Results: aws-us-west-2-caf-mail-1.web.codeaurora.org; dmarc=none (p=none dis=none) header.from=codeaurora.org
Authentication-Results: aws-us-west-2-caf-mail-1.web.codeaurora.org; spf=fail smtp.mailfrom=mdtipton@codeaurora.org
From:   Mike Tipton <mdtipton@codeaurora.org>
Subject: Re: [PATCH 2/4] interconnect: Always call pre_aggregate before
 aggregate
To:     okukatla@codeaurora.org
Cc:     djakov@kernel.org, bjorn.andersson@linaro.org, agross@kernel.org,
        saravanak@google.com, linux-arm-msm@vger.kernel.org,
        linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org,
        mdtipton=codeaurora.org@codeaurora.org
References: <20210625212839.24155-1-mdtipton@codeaurora.org>
 <20210625212839.24155-3-mdtipton@codeaurora.org>
 <000574efe90897c1738299cfba4fea7d@codeaurora.org>
Message-ID: <d847ed42-e6ba-1686-f753-7dfecd7efa57@codeaurora.org>
Date:   Mon, 12 Jul 2021 08:39:57 -0700
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:78.0) Gecko/20100101
 Thunderbird/78.11.0
MIME-Version: 1.0
In-Reply-To: <000574efe90897c1738299cfba4fea7d@codeaurora.org>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

On 7/1/2021 11:55 AM, okukatla@codeaurora.org wrote:
> On 2021-06-26 02:58, Mike Tipton wrote:
>> The pre_aggregate callback isn't called in all cases before calling
>> aggregate. Add the missing calls so providers can rely on consistent
>> framework behavior.
>>
>> Fixes: d3703b3e255f ("interconnect: Aggregate before setting initial 
>> bandwidth")
>> Signed-off-by: Mike Tipton <mdtipton@codeaurora.org>
>> ---
>>  drivers/interconnect/core.c | 5 ++++-
>>  1 file changed, 4 insertions(+), 1 deletion(-)
>>
>> diff --git a/drivers/interconnect/core.c b/drivers/interconnect/core.c
>> index 945121e18b5c..cfd54c90a6bb 100644
>> --- a/drivers/interconnect/core.c
>> +++ b/drivers/interconnect/core.c
>> @@ -973,9 +973,12 @@ void icc_node_add(struct icc_node *node, struct
>> icc_provider *provider)
>>      }
>>      node->avg_bw = node->init_avg;
>>      node->peak_bw = node->init_peak;
>> -    if (provider->aggregate)
>> +    if (provider->aggregate) {
>> +        if (provider->pre_aggregate)
>> +            provider->pre_aggregate(node);
> nit: we can invoke pre_aggregate() out side of if (qcom_icc_aggregate).

Sure, will update this.

> 
>>          provider->aggregate(node, 0, node->init_avg, node->init_peak,
>>                      &node->avg_bw, &node->peak_bw);
>> +    }
>>      provider->set(node, node);
>>      node->avg_bw = 0;
>>      node->peak_bw = 0;
