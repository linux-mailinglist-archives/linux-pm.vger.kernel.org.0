Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C453828D7D6
	for <lists+linux-pm@lfdr.de>; Wed, 14 Oct 2020 03:10:31 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730816AbgJNBKZ (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Tue, 13 Oct 2020 21:10:25 -0400
Received: from m42-4.mailgun.net ([69.72.42.4]:22847 "EHLO m42-4.mailgun.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1730746AbgJNBKY (ORCPT <rfc822;linux-pm@vger.kernel.org>);
        Tue, 13 Oct 2020 21:10:24 -0400
DKIM-Signature: a=rsa-sha256; v=1; c=relaxed/relaxed; d=mg.codeaurora.org; q=dns/txt;
 s=smtp; t=1602637824; h=Content-Transfer-Encoding: Content-Type:
 In-Reply-To: MIME-Version: Date: Message-ID: From: References: Cc: To:
 Subject: Sender; bh=jjLKhfAQlUtz5Rcyx45kgleXOq80qXSbQQgEXyBeLjw=; b=hAoz3zsz1dJUkzAvfcZgDo+zg/rRu2wlVxd4/EbFecugAIwePAtVqSjNvKTeJpH6Nb1NeKJ3
 uYEH16IDjbMOFtKJH3L4UAJGZhUML01jeNEwVMnUdM+/eXPETCMAx2Rk+7vc95rMwURr/K6R
 1HzWmxcW6VJdzteff7yrHV0Stf8=
X-Mailgun-Sending-Ip: 69.72.42.4
X-Mailgun-Sid: WyI5ZDFmMiIsICJsaW51eC1wbUB2Z2VyLmtlcm5lbC5vcmciLCAiYmU5ZTRhIl0=
Received: from smtp.codeaurora.org
 (ec2-35-166-182-171.us-west-2.compute.amazonaws.com [35.166.182.171]) by
 smtp-out-n03.prod.us-west-2.postgun.com with SMTP id
 5f864ffff9168450ea7bb1e4 (version=TLS1.2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256); Wed, 14 Oct 2020 01:10:23
 GMT
Sender: mdtipton=codeaurora.org@mg.codeaurora.org
Received: by smtp.codeaurora.org (Postfix, from userid 1001)
        id 62423C433F1; Wed, 14 Oct 2020 01:10:23 +0000 (UTC)
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
        aws-us-west-2-caf-mail-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.9 required=2.0 tests=ALL_TRUSTED,BAYES_00,
        NICE_REPLY_A,SPF_FAIL,URIBL_BLOCKED autolearn=no autolearn_force=no
        version=3.4.0
Received: from [192.168.1.159] (ip70-179-20-127.sd.sd.cox.net [70.179.20.127])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        (Authenticated sender: mdtipton)
        by smtp.codeaurora.org (Postfix) with ESMTPSA id 0B607C433CB;
        Wed, 14 Oct 2020 01:10:21 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 smtp.codeaurora.org 0B607C433CB
Authentication-Results: aws-us-west-2-caf-mail-1.web.codeaurora.org; dmarc=none (p=none dis=none) header.from=codeaurora.org
Authentication-Results: aws-us-west-2-caf-mail-1.web.codeaurora.org; spf=fail smtp.mailfrom=mdtipton@codeaurora.org
Subject: Re: [PATCH] interconnect: qcom: sdm845: Enable keepalive for the MM1
 BCM
To:     Georgi Djakov <georgi.djakov@linaro.org>, linux-pm@vger.kernel.org
Cc:     okukatla@codeaurora.org, sibis@codeaurora.org,
        bjorn.andersson@linaro.org, amit.pundir@linaro.org,
        linux-arm-msm@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20201012194034.26944-1-georgi.djakov@linaro.org>
From:   Mike Tipton <mdtipton@codeaurora.org>
Message-ID: <56dc5ac7-2bed-4dbb-b7fc-c0308a2a454a@codeaurora.org>
Date:   Tue, 13 Oct 2020 18:10:21 -0700
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:78.0) Gecko/20100101
 Thunderbird/78.3.2
MIME-Version: 1.0
In-Reply-To: <20201012194034.26944-1-georgi.djakov@linaro.org>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

On 10/12/2020 12:40 PM, Georgi Djakov wrote:
> After enabling interconect scaling for display on the db845c board,
s/interconect/interconnect/

> in certain configurations the board hangs, while the following errors
> are observed on the console:
> 
>    Error sending AMC RPMH requests (-110)
>    qcom_rpmh TCS Busy, retrying RPMH message send: addr=0x50000
>    qcom_rpmh TCS Busy, retrying RPMH message send: addr=0x50000
>    qcom_rpmh TCS Busy, retrying RPMH message send: addr=0x50000
>    ...
> 
> In this specific case, the above is related to one of the sequencers
> being stuck, while client drivers are returning from probe and trying
> to disable the currently unused clock and interconnect resources.
> Generally we want to keep the multimedia NoC enabled like the rest of
> the NoCs, so let's set the keepalive flag on it too.
> 
> Fixes: aae57773fbe0 ("interconnect: qcom: sdm845: Split qnodes into their respective NoCs")
> Reported-by: Amit Pundir <amit.pundir@linaro.org>
> Signed-off-by: Georgi Djakov <georgi.djakov@linaro.org>
> ---
>   drivers/interconnect/qcom/sdm845.c | 2 +-
>   1 file changed, 1 insertion(+), 1 deletion(-)
> 

Reviewed-by: Mike Tipton <mdtipton@codeaurora.org>
