Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 89470295D08
	for <lists+linux-pm@lfdr.de>; Thu, 22 Oct 2020 12:58:03 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2502777AbgJVK6C (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Thu, 22 Oct 2020 06:58:02 -0400
Received: from z5.mailgun.us ([104.130.96.5]:57721 "EHLO z5.mailgun.us"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2502541AbgJVK6C (ORCPT <rfc822;linux-pm@vger.kernel.org>);
        Thu, 22 Oct 2020 06:58:02 -0400
DKIM-Signature: a=rsa-sha256; v=1; c=relaxed/relaxed; d=mg.codeaurora.org; q=dns/txt;
 s=smtp; t=1603364282; h=Content-Transfer-Encoding: Content-Type:
 In-Reply-To: MIME-Version: Date: Message-ID: From: References: Cc: To:
 Subject: Sender; bh=+kg1VPF2Fza8qxQeMDG70QVmpH0siyDmx5l4aqZHJb4=; b=xgBRkbmsSpeqyS58jLPBzYkjeqOelidBdZH3G/DtKM4wyEKc5FdbJZEGb6FcLOpM39lH9vT3
 ypXlTGVmfvAGVOey0k8gb6yBkZZPTo5bEtNtAv0PnIUz7P5Meo81rKMSQjKFbt9nI67a2Q4M
 aS32A5kujGjz//nElWDxUcL8HbQ=
X-Mailgun-Sending-Ip: 104.130.96.5
X-Mailgun-Sid: WyI5ZDFmMiIsICJsaW51eC1wbUB2Z2VyLmtlcm5lbC5vcmciLCAiYmU5ZTRhIl0=
Received: from smtp.codeaurora.org
 (ec2-35-166-182-171.us-west-2.compute.amazonaws.com [35.166.182.171]) by
 smtp-out-n04.prod.us-east-1.postgun.com with SMTP id
 5f9165b9d63768e57bcc4fe2 (version=TLS1.2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256); Thu, 22 Oct 2020 10:58:01
 GMT
Sender: akashast=codeaurora.org@mg.codeaurora.org
Received: by smtp.codeaurora.org (Postfix, from userid 1001)
        id B02EBC433FE; Thu, 22 Oct 2020 10:58:00 +0000 (UTC)
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
        aws-us-west-2-caf-mail-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.0 required=2.0 tests=ALL_TRUSTED,BAYES_00,
        NICE_REPLY_A,SPF_FAIL,URIBL_BLOCKED autolearn=no autolearn_force=no
        version=3.4.0
Received: from [192.168.1.100] (unknown [47.9.142.219])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        (Authenticated sender: akashast)
        by smtp.codeaurora.org (Postfix) with ESMTPSA id D801FC433C9;
        Thu, 22 Oct 2020 10:57:57 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 smtp.codeaurora.org D801FC433C9
Authentication-Results: aws-us-west-2-caf-mail-1.web.codeaurora.org; dmarc=none (p=none dis=none) header.from=codeaurora.org
Authentication-Results: aws-us-west-2-caf-mail-1.web.codeaurora.org; spf=fail smtp.mailfrom=akashast@codeaurora.org
Subject: Re: [PATCH] interconnect: qcom: Ensure that the floor bandwidth value
 is enforced
To:     Georgi Djakov <georgi.djakov@linaro.org>, linux-pm@vger.kernel.org
Cc:     mdtipton@codeaurora.org, saravanak@google.com,
        bjorn.andersson@linaro.org, linux-kernel@vger.kernel.org
References: <20201021155938.9223-1-georgi.djakov@linaro.org>
From:   Akash Asthana <akashast@codeaurora.org>
Message-ID: <7af4f43a-ca05-14a5-0183-2ded0e66b87a@codeaurora.org>
Date:   Thu, 22 Oct 2020 16:27:47 +0530
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:68.0) Gecko/20100101
 Thunderbird/68.12.1
MIME-Version: 1.0
In-Reply-To: <20201021155938.9223-1-georgi.djakov@linaro.org>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Content-Language: en-US
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org


On 10/21/2020 9:29 PM, Georgi Djakov wrote:
> Take into account the initial bandwidth from the framework and update
> the internal sum and max values before committing if needed. This will
> ensure that the floor bandwidth values are enforced until the providers
> get into sync state.
>
> Fixes: 7d3b0b0d8184 ("interconnect: qcom: Use icc_sync_state")
> Signed-off-by: Georgi Djakov <georgi.djakov@linaro.org>

Thanks Georgi,
I removed proxy ICC BW votes for earlycon driver "qcom_geni" introduced by patch [1], trogdor chromium board booted up fine, which use to crash without this patch.

https://patchwork.kernel.org/project/linux-arm-msm/patch/1592908737-7068-3-git-send-email-akashast@codeaurora.org/ [1]

Tested-by: Akash Asthana <akashast@codeaurora.org>
>   

-- 
The Qualcomm Innovation Center, Inc. is a member of the Code Aurora Forum,\na Linux Foundation Collaborative Project

