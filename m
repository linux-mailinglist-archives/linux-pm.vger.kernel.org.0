Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 141B73B46D7
	for <lists+linux-pm@lfdr.de>; Fri, 25 Jun 2021 17:45:49 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229774AbhFYPsI (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Fri, 25 Jun 2021 11:48:08 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46576 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229630AbhFYPsI (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Fri, 25 Jun 2021 11:48:08 -0400
Received: from mail-qk1-x72e.google.com (mail-qk1-x72e.google.com [IPv6:2607:f8b0:4864:20::72e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 74DAAC061574
        for <linux-pm@vger.kernel.org>; Fri, 25 Jun 2021 08:45:47 -0700 (PDT)
Received: by mail-qk1-x72e.google.com with SMTP id w21so19462735qkb.9
        for <linux-pm@vger.kernel.org>; Fri, 25 Jun 2021 08:45:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=mwj/CahjscU+y04bpHECBUvebi/V1MfEC2fzu395QLo=;
        b=nGN4vMQZ8P1icKs0xdH3WkkvUZPThVxP/td0QdTl39qQJOP6NhKPS3e9RK+pI4LHdI
         a2dGLPdCebQ+VeD0V/jh4Im7m46MIeigsGvBjy27GgG8SjVOPd5CYbtHw/86Fuegahfu
         bXsWZDt7oTfEtuHt0FwS+6OS5EtwpT4QDzW4mBvC9IJeN3L+rPP9lRWeHKB0ww7eFHGx
         681j/vv0uF6uiKG5FzsFC9hoMRqsUCpf2zmHWadlm/SUeUsuo/TX7+U1sThnPRH+9wKP
         HESKor79vVfbqqfmzqJP7qFeNN0zL9YYJAK98R83MaIf4fqTQGLSOTS3FSwgK+w1+pMO
         qopA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=mwj/CahjscU+y04bpHECBUvebi/V1MfEC2fzu395QLo=;
        b=rsQbQ4Gkg4JFVL97quPkAulhcqGJiPXV6zc28FfEbtDvg7+H5aMOt9Lf0uZ0CjOY6o
         pb9z8SjTGShvDDgGoAI7Bf7a5oQiRcQTZUluI1Wa2Bjexpeqlt8PiTisGZmfQM3EmTHC
         6SQQTqSe/vc8bKq4puwVzG9//qGPdca2PYMK90L5MtfDgkByq4EJJh00XPZisBTU3huK
         BXZM3JNK+Qru9dwnq9g0sPV8CHkCO3se9M/Owq/wXg1uJgUGomV4n19UY3S5n8/0OY7+
         9zx9x653xRLZWgh+DmS1lvwYTnMcRHGyQHYmZC2la2mxAkoOmLNRLS1lB0/4oSzaYWKC
         Humg==
X-Gm-Message-State: AOAM531LeGizdAwav8ojop7+FuwqaTu0Dt5a8x8PvTl3amMSxx+LYGsY
        NK6Lod+lFxS0J1zB0sG1LCR7wA==
X-Google-Smtp-Source: ABdhPJwWTpsA8qfT4xts8nRvl/v0ZS30IZkHdZR0u40CfAR/R+mZvZlElQB5EgtIN1cIYBwALUmv8Q==
X-Received: by 2002:a37:a254:: with SMTP id l81mr11818502qke.90.1624635946664;
        Fri, 25 Jun 2021 08:45:46 -0700 (PDT)
Received: from [192.168.1.93] (pool-71-163-245-5.washdc.fios.verizon.net. [71.163.245.5])
        by smtp.gmail.com with ESMTPSA id s8sm3805562qtk.96.2021.06.25.08.45.45
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 25 Jun 2021 08:45:46 -0700 (PDT)
Subject: Re: [Patch v2 1/5] firmware: qcom_scm: Introduce SCM calls to access
 LMh
To:     Matthias Kaehlcke <mka@chromium.org>
Cc:     agross@kernel.org, bjorn.andersson@linaro.org, rui.zhang@intel.com,
        daniel.lezcano@linaro.org, viresh.kumar@linaro.org,
        rjw@rjwysocki.net, robh+dt@kernel.org,
        linux-arm-msm@vger.kernel.org, linux-pm@vger.kernel.org,
        linux-kernel@vger.kernel.org, devicetree@vger.kernel.org
References: <20210624115813.3613290-1-thara.gopinath@linaro.org>
 <20210624115813.3613290-2-thara.gopinath@linaro.org>
 <YNTFdCPU2saMCT/y@google.com>
From:   Thara Gopinath <thara.gopinath@linaro.org>
Message-ID: <9f302951-e65b-8b4f-7608-8b96e8d341a6@linaro.org>
Date:   Fri, 25 Jun 2021 11:45:43 -0400
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
MIME-Version: 1.0
In-Reply-To: <YNTFdCPU2saMCT/y@google.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org



On 6/24/21 1:48 PM, Matthias Kaehlcke wrote:
> On Thu, Jun 24, 2021 at 07:58:09AM -0400, Thara Gopinath wrote:
>> Introduce SCM calls to access/configure limits management hardware(LMH).
>>
>> Signed-off-by: Thara Gopinath <thara.gopinath@linaro.org>
>> ---
>>
>> v1->v2:
>> 	Changed the input parameters in qcom_scm_lmh_dcvsh from payload_buf and
>> 	payload_size to payload_fn, payload_reg, payload_val as per Bjorn's review
>> 	comments.
>>
>>   drivers/firmware/qcom_scm.c | 54 +++++++++++++++++++++++++++++++++++++
>>   drivers/firmware/qcom_scm.h |  4 +++
>>   include/linux/qcom_scm.h    | 14 ++++++++++
>>   3 files changed, 72 insertions(+)
>>
>> diff --git a/drivers/firmware/qcom_scm.c b/drivers/firmware/qcom_scm.c
>> index ee9cb545e73b..19e9fb91d084 100644
>> --- a/drivers/firmware/qcom_scm.c
>> +++ b/drivers/firmware/qcom_scm.c
>> @@ -1147,6 +1147,60 @@ int qcom_scm_qsmmu500_wait_safe_toggle(bool en)
>>   }
>>   EXPORT_SYMBOL(qcom_scm_qsmmu500_wait_safe_toggle);
>>   
>> +bool qcom_scm_lmh_dcvsh_available(void)
>> +{
>> +	return __qcom_scm_is_call_available(__scm->dev, QCOM_SCM_SVC_LMH, QCOM_SCM_LMH_LIMIT_DCVSH);
>> +}
>> +EXPORT_SYMBOL(qcom_scm_lmh_dcvsh_available);
>> +
>> +int qcom_scm_lmh_profile_change(u32 profile_id)
>> +{
>> +	struct qcom_scm_desc desc = {
>> +		.svc = QCOM_SCM_SVC_LMH,
>> +		.cmd = QCOM_SCM_LMH_LIMIT_PROFILE_CHANGE,
>> +		.arginfo = QCOM_SCM_ARGS(1, QCOM_SCM_VAL),
>> +		.args[0] = profile_id,
>> +		.owner = ARM_SMCCC_OWNER_SIP,
>> +	};
>> +
>> +	return qcom_scm_call(__scm->dev, &desc, NULL);
>> +}
>> +EXPORT_SYMBOL(qcom_scm_lmh_profile_change);
>> +
>> +int qcom_scm_lmh_dcvsh(u32 payload_fn, u32 payload_reg, u32 payload_val,
>> +		       u64 limit_node, u32 node_id, u64 version)
>> +{
>> +	dma_addr_t payload_phys;
>> +	u32 *payload_buf;
>> +	int payload_size = 5 * sizeof(u32);
>> +
>> +	struct qcom_scm_desc desc = {
>> +		.svc = QCOM_SCM_SVC_LMH,
>> +		.cmd = QCOM_SCM_LMH_LIMIT_DCVSH,
>> +		.arginfo = QCOM_SCM_ARGS(5, QCOM_SCM_RO, QCOM_SCM_VAL, QCOM_SCM_VAL,
>> +					QCOM_SCM_VAL, QCOM_SCM_VAL),
>> +		.args[1] = payload_size,
>> +		.args[2] = limit_node,
>> +		.args[3] = node_id,
>> +		.args[4] = version,
>> +		.owner = ARM_SMCCC_OWNER_SIP,
>> +	};
>> +
>> +	payload_buf = dma_alloc_coherent(__scm->dev, payload_size, &payload_phys, GFP_KERNEL);
>> +	if (!payload_buf)
>> +		return -ENOMEM;
>> +
>> +	payload_buf[0] = payload_fn;
>> +	payload_buf[1] = 0;
>> +	payload_buf[2] = payload_reg;
>> +	payload_buf[3] = 1;
>> +	payload_buf[4] = payload_val;
>> +
>> +	desc.args[0] = payload_phys;
>> +	return qcom_scm_call(__scm->dev, &desc, NULL);
> 
> dma_free_coherent()?

yep.. A free should be done here. Will fix it

> 

-- 
Warm Regards
Thara (She/Her/Hers)
