Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0F9D921A802
	for <lists+linux-pm@lfdr.de>; Thu,  9 Jul 2020 21:45:15 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726213AbgGITpI (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Thu, 9 Jul 2020 15:45:08 -0400
Received: from mail29.static.mailgun.info ([104.130.122.29]:15711 "EHLO
        mail29.static.mailgun.info" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726260AbgGITpG (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Thu, 9 Jul 2020 15:45:06 -0400
DKIM-Signature: a=rsa-sha256; v=1; c=relaxed/relaxed; d=mg.codeaurora.org; q=dns/txt;
 s=smtp; t=1594323906; h=Content-Transfer-Encoding: Content-Type:
 In-Reply-To: MIME-Version: Date: Message-ID: From: References: Cc: To:
 Subject: Sender; bh=QE+bNVj/SQwtedJ12CCaAW9op0bzYQQpyVC83CKXLmY=; b=vS0pBgrqr1QqKZvRby34xDuHoZGuPjapwi+XlHgJ0UK91cMXMjdFPgFckjh5VeRpVnCdl5W9
 R1x5zpF2/7lNi0VyQb2c4s1/XK6MEsUZQ5TLrYLEYMKLl7uD1qaPppJP2f5sbWBRtgR8fiHX
 eFtRpwyKm5kLYLPsrrp/pVZa3PQ=
X-Mailgun-Sending-Ip: 104.130.122.29
X-Mailgun-Sid: WyI5ZDFmMiIsICJsaW51eC1wbUB2Z2VyLmtlcm5lbC5vcmciLCAiYmU5ZTRhIl0=
Received: from smtp.codeaurora.org
 (ec2-35-166-182-171.us-west-2.compute.amazonaws.com [35.166.182.171]) by
 smtp-out-n14.prod.us-west-2.postgun.com with SMTP id
 5f0773c09b7f1f3df712d0ee (version=TLS1.2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256); Thu, 09 Jul 2020 19:45:04
 GMT
Received: by smtp.codeaurora.org (Postfix, from userid 1001)
        id D1D00C433C6; Thu,  9 Jul 2020 19:45:03 +0000 (UTC)
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
        aws-us-west-2-caf-mail-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=2.0 tests=ALL_TRUSTED,SPF_NONE,
        URIBL_BLOCKED autolearn=unavailable autolearn_force=no version=3.4.0
Received: from [192.168.1.117] (ip70-179-20-127.sd.sd.cox.net [70.179.20.127])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        (Authenticated sender: mdtipton)
        by smtp.codeaurora.org (Postfix) with ESMTPSA id 616E4C433CA;
        Thu,  9 Jul 2020 19:45:02 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 smtp.codeaurora.org 616E4C433CA
Authentication-Results: aws-us-west-2-caf-mail-1.web.codeaurora.org; dmarc=none (p=none dis=none) header.from=codeaurora.org
Authentication-Results: aws-us-west-2-caf-mail-1.web.codeaurora.org; spf=none smtp.mailfrom=mdtipton@codeaurora.org
Subject: Re: [PATCH 1/2] dt-bindings: interconnect: Add generic qcom bindings
To:     Matthias Kaehlcke <mka@chromium.org>
Cc:     georgi.djakov@linaro.org, bjorn.andersson@linaro.org,
        robh+dt@kernel.org, agross@kernel.org, linux-pm@vger.kernel.org,
        linux-arm-msm@vger.kernel.org, linux-kernel@vger.kernel.org,
        devicetree@vger.kernel.org
References: <20200623040515.23317-1-mdtipton@codeaurora.org>
 <20200623040515.23317-2-mdtipton@codeaurora.org>
 <20200709153527.GJ3191083@google.com>
From:   Mike Tipton <mdtipton@codeaurora.org>
Message-ID: <265041af-2a5c-4a09-457f-f4b39cbdb8eb@codeaurora.org>
Date:   Thu, 9 Jul 2020 12:45:01 -0700
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
MIME-Version: 1.0
In-Reply-To: <20200709153527.GJ3191083@google.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

On 7/9/2020 8:35 AM, Matthias Kaehlcke wrote:
> On Mon, Jun 22, 2020 at 09:05:14PM -0700, Mike Tipton wrote:
>> Add generic qcom interconnect bindings that are common across platforms. In
>> particular, these include QCOM_ICC_TAG_* macros that clients can use when
>> calling icc_set_tag().
>>
>> Signed-off-by: Mike Tipton <mdtipton@codeaurora.org>
>> ---
>>   include/dt-bindings/interconnect/qcom,icc.h | 26 +++++++++++++++++++++
>>   1 file changed, 26 insertions(+)
>>   create mode 100644 include/dt-bindings/interconnect/qcom,icc.h
>>
>> diff --git a/include/dt-bindings/interconnect/qcom,icc.h b/include/dt-bindings/interconnect/qcom,icc.h
>> new file mode 100644
>> index 000000000000..cd34f36daaaa
>> --- /dev/null
>> +++ b/include/dt-bindings/interconnect/qcom,icc.h
>> @@ -0,0 +1,26 @@
>> +/* SPDX-License-Identifier: GPL-2.0-only */
>> +/*
>> + * Copyright (c) 2020, The Linux Foundation. All rights reserved.
>> + */
>> +
>> +#ifndef __DT_BINDINGS_INTERCONNECT_QCOM_ICC_H
>> +#define __DT_BINDINGS_INTERCONNECT_QCOM_ICC_H
>> +
>> +/*
>> + * The AMC bucket denotes constraints that are applied to hardware when
>> + * icc_set_bw() completes, whereas the WAKE and SLEEP constraints are applied
>> + * when the execution environment transitions between active and low power mode.
>> + */
>> +#define QCOM_ICC_BUCKET_AMC		0
>> +#define QCOM_ICC_BUCKET_WAKE		1
>> +#define QCOM_ICC_BUCKET_SLEEP		2
>> +#define QCOM_ICC_NUM_BUCKETS		3
>> +
>> +#define QCOM_ICC_TAG_AMC		(1 << QCOM_ICC_BUCKET_AMC)
>> +#define QCOM_ICC_TAG_WAKE		(1 << QCOM_ICC_BUCKET_WAKE)
>> +#define QCOM_ICC_TAG_SLEEP		(1 << QCOM_ICC_BUCKET_SLEEP)
>> +#define QCOM_ICC_TAG_ACTIVE_ONLY	(QCOM_ICC_TAG_AMC | QCOM_ICC_TAG_WAKE)
>> +#define QCOM_ICC_TAG_ALWAYS		(QCOM_ICC_TAG_AMC | QCOM_ICC_TAG_WAKE |\
>> +					 QCOM_ICC_TAG_SLEEP)
>> +
>> +#endif
> 
> Would it make sense to squash the two patches of this series into a
> single patch? This would make it more evident that this was moved
> from drivers/interconnect/qcom/icc-rpmh.h and avoid duplicate
> definitions if only this patch was applied.

Makes sense to me. I'm going to have to move this to my other patch 
series anyway, so I can squash these two and include it in v2 of 
"interconnect: qcom: Misc bcm-voter changes and fixes".
