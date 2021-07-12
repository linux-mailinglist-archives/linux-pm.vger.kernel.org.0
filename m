Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D5A523C5F7B
	for <lists+linux-pm@lfdr.de>; Mon, 12 Jul 2021 17:41:36 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235474AbhGLPoY (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Mon, 12 Jul 2021 11:44:24 -0400
Received: from so254-9.mailgun.net ([198.61.254.9]:43186 "EHLO
        so254-9.mailgun.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235637AbhGLPoY (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Mon, 12 Jul 2021 11:44:24 -0400
DKIM-Signature: a=rsa-sha256; v=1; c=relaxed/relaxed; d=mg.codeaurora.org; q=dns/txt;
 s=smtp; t=1626104495; h=Content-Transfer-Encoding: Content-Type:
 In-Reply-To: MIME-Version: Date: Message-ID: References: Cc: To:
 Subject: From: Sender; bh=HfDY19Td7Yb6LP09Ydf7zDiMxK8u7WGqFqG3C/QOekU=;
 b=Wzplgz6+FTc6zUX7gxGf1SwCiwEaispGFitDd2RgLrRGhy+0uzNO3QNFG0cT+ypvu0DwJhzI
 P/bkEQaZOGebO+R1eZGGlEcWPyFR8Pe8juPF45tyqMppMTALdaPgF9iSvdKEOTB2Si5FEa7P
 U1IYj7jeuuhNNzQfzztGhwo6IFY=
X-Mailgun-Sending-Ip: 198.61.254.9
X-Mailgun-Sid: WyI5ZDFmMiIsICJsaW51eC1wbUB2Z2VyLmtlcm5lbC5vcmciLCAiYmU5ZTRhIl0=
Received: from smtp.codeaurora.org
 (ec2-35-166-182-171.us-west-2.compute.amazonaws.com [35.166.182.171]) by
 smtp-out-n05.prod.us-east-1.postgun.com with SMTP id
 60ec62941938941955eb8ed2 (version=TLS1.2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256); Mon, 12 Jul 2021 15:41:08
 GMT
Sender: mdtipton=codeaurora.org@mg.codeaurora.org
Received: by smtp.codeaurora.org (Postfix, from userid 1001)
        id F393FC43460; Mon, 12 Jul 2021 15:41:07 +0000 (UTC)
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
        by smtp.codeaurora.org (Postfix) with ESMTPSA id 05E4DC433D3;
        Mon, 12 Jul 2021 15:41:04 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 smtp.codeaurora.org 05E4DC433D3
Authentication-Results: aws-us-west-2-caf-mail-1.web.codeaurora.org; dmarc=none (p=none dis=none) header.from=codeaurora.org
Authentication-Results: aws-us-west-2-caf-mail-1.web.codeaurora.org; spf=fail smtp.mailfrom=mdtipton@codeaurora.org
From:   Mike Tipton <mdtipton@codeaurora.org>
Subject: Re: [PATCH 1/4] interconnect: Zero initial BW after sync-state
To:     okukatla@codeaurora.org
Cc:     djakov@kernel.org, bjorn.andersson@linaro.org, agross@kernel.org,
        saravanak@google.com, linux-arm-msm@vger.kernel.org,
        linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org,
        mdtipton=codeaurora.org@codeaurora.org
References: <20210625212839.24155-1-mdtipton@codeaurora.org>
 <20210625212839.24155-2-mdtipton@codeaurora.org>
 <14c52b496918900c9cb3bef662a9e833@codeaurora.org>
Message-ID: <86e76352-1199-0fc6-9e5d-b7d45db37636@codeaurora.org>
Date:   Mon, 12 Jul 2021 08:41:03 -0700
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:78.0) Gecko/20100101
 Thunderbird/78.11.0
MIME-Version: 1.0
In-Reply-To: <14c52b496918900c9cb3bef662a9e833@codeaurora.org>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

On 7/1/2021 9:56 AM, okukatla@codeaurora.org wrote:
> On 2021-06-26 02:58, Mike Tipton wrote:
>> The initial BW values may be used by providers to enforce floors. Zero
>> these values after sync-state so that providers know when to stop
>> enforcing them.
>>
>> Fixes: b1d681d8d324 ("interconnect: Add sync state support")
>> Signed-off-by: Mike Tipton <mdtipton@codeaurora.org>
>> ---
>>  drivers/interconnect/core.c | 2 ++
>>  1 file changed, 2 insertions(+)
>>
>> diff --git a/drivers/interconnect/core.c b/drivers/interconnect/core.c
>> index 8a1e70e00876..945121e18b5c 100644
>> --- a/drivers/interconnect/core.c
>> +++ b/drivers/interconnect/core.c
>> @@ -1106,6 +1106,8 @@ void icc_sync_state(struct device *dev)
>>          dev_dbg(p->dev, "interconnect provider is in synced state\n");
>>          list_for_each_entry(n, &p->nodes, node_list) {
>>              if (n->init_avg || n->init_peak) {
>> +                n->init_avg = 0;
>> +                n->init_peak = 0;
> nit: It is good to reset init/floor levels back to zero, but we don't 
> need to do this as we have sync_state flag to let providers know when to 
> stop enforcing.

The synced_state variable is static to this file. It's not exposed to 
providers. In fact, we could entirely remove synced_state with this 
patch since it's unnecessary after zeroing the initial floors.

>>                  aggregate_requests(n);
>>                  p->set(n, n);
>>              }
