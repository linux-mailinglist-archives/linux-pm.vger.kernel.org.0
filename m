Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3CC204D0515
	for <lists+linux-pm@lfdr.de>; Mon,  7 Mar 2022 18:18:24 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235109AbiCGRTQ (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Mon, 7 Mar 2022 12:19:16 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53240 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239963AbiCGRTP (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Mon, 7 Mar 2022 12:19:15 -0500
Received: from mail-ed1-x52e.google.com (mail-ed1-x52e.google.com [IPv6:2a00:1450:4864:20::52e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 193B833371
        for <linux-pm@vger.kernel.org>; Mon,  7 Mar 2022 09:18:20 -0800 (PST)
Received: by mail-ed1-x52e.google.com with SMTP id g20so20938764edw.6
        for <linux-pm@vger.kernel.org>; Mon, 07 Mar 2022 09:18:20 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=message-id:date:mime-version:user-agent:content-language:to:cc
         :references:from:subject:in-reply-to:content-transfer-encoding;
        bh=CqPCe+Bhg9Wj2ztq5D9thXMUJynMv0XtLyEr/aI3VGM=;
        b=qCIS13lgrRJhjZMfTXEXXwrTh7mm+sw4JME76GDpWza7C3fIP//bM2vyT5urTIfzEh
         uZP+5lODZrTp68Q5c0AFb5FrUNjXCAQkmMbCx0dwNbYNoTadk2QGIWu45mJ7Z8tvZ8az
         NBkxSJqlGJsZ2NvvNoGU+NLFxlOPMQiyyPR+I+75pCkjdNLkZEmLQhBxLgIMFcQWC9cc
         4CaP2yOYqcYd+XidvUcCZBT7Z9u34McMtgUMMRTePEqjwv12eHEzX/EUDDJK6wLbraW/
         /cd4gXFN/2t4cd0jbvUd1lr3wc1jKsuyapb9+ZZDbi8K+1wk0hFH2thA6RP4sqUTrv6z
         +4ng==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent
         :content-language:to:cc:references:from:subject:in-reply-to
         :content-transfer-encoding;
        bh=CqPCe+Bhg9Wj2ztq5D9thXMUJynMv0XtLyEr/aI3VGM=;
        b=wLyrlsz4KmvNyrt/glOnVfOdZ5vNIaUNmptid57DikqlZijllb+d8kzskTeYUl9Hy4
         8Ghm0TdK5qaAaFS4oIJFKLRp2ozceySnVZTDSGa2wvLmzQp9P5fct+ocfSTpE+PktYvn
         KkMHVPhoSeNnqi9IuIchYNlYpGZjJ5wJA9pIWqbJMuJOQ5dXNRkx6r7p4kR7Gt/ZBShK
         eUUC0xc1ELmx/NEtXeGkd3+qtfPDrVrtNqERclgLJaQ15h7aT9q0zP7N2Cuds/7rQSuI
         oePGHH/SwW9U8M4JNKiUiVrO6pa+PMwDoBvVYIhrD09Sawg1oihDw91ESn90Ygbc2qx8
         ZudA==
X-Gm-Message-State: AOAM531qM50ITpge1X50Urc1JRE+HHHzsC1Ex1dDaXj2tQhCcXzM15BU
        qfYqaOf5iNKmZG6BDrWW++8=
X-Google-Smtp-Source: ABdhPJzsi8+XviWjaOXbjO7wjbYg81vGZU07oeqkHyCdEqeNhlgFeBKnvHA73xVPyXm24BRyjghffw==
X-Received: by 2002:a05:6402:2065:b0:407:eb07:740 with SMTP id bd5-20020a056402206500b00407eb070740mr11959631edb.406.1646673498474;
        Mon, 07 Mar 2022 09:18:18 -0800 (PST)
Received: from ?IPV6:2a01:c22:7b92:be00:a93d:d4bf:2053:56d? (dynamic-2a01-0c22-7b92-be00-a93d-d4bf-2053-056d.c22.pool.telefonica.de. [2a01:c22:7b92:be00:a93d:d4bf:2053:56d])
        by smtp.googlemail.com with ESMTPSA id q10-20020aa7cc0a000000b0040f826f09fdsm6436180edt.81.2022.03.07.09.18.17
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 07 Mar 2022 09:18:17 -0800 (PST)
Message-ID: <39bce0ca-2ff1-399e-d3d4-f424e141a553@gmail.com>
Date:   Mon, 7 Mar 2022 18:18:12 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:91.0) Gecko/20100101
 Thunderbird/91.6.2
Content-Language: en-US
To:     Viresh Kumar <viresh.kumar@linaro.org>
Cc:     Viresh Kumar <vireshk@kernel.org>, Nishanth Menon <nm@ti.com>,
        Stephen Boyd <sboyd@kernel.org>,
        Linux PM <linux-pm@vger.kernel.org>
References: <91e37a12-b393-8ae9-996b-6cbb63ea9255@gmail.com>
 <20220307052744.s4ed3vinz5umbtlm@vireshk-i7>
From:   Heiner Kallweit <hkallweit1@gmail.com>
Subject: Re: [PATCH] opp: Don't print error message if getting optional
 regulator fails
In-Reply-To: <20220307052744.s4ed3vinz5umbtlm@vireshk-i7>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,
        FREEMAIL_FROM,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

On 07.03.2022 06:27, Viresh Kumar wrote:
> On 06-03-22, 22:46, Heiner Kallweit wrote:
>> The regulators are optional, therefore I see no need to bother users
>> with an error level message if -ENODEV is returned.
>>
>> Inspiration was the following error on my system:
>> lima d00c0000.gpu: dev_pm_opp_set_regulators: no regulator (mali) found: -19
>>
>> Signed-off-by: Heiner Kallweit <hkallweit1@gmail.com>
>> ---
>>  drivers/opp/core.c | 5 ++++-
>>  1 file changed, 4 insertions(+), 1 deletion(-)
>>
>> diff --git a/drivers/opp/core.c b/drivers/opp/core.c
>> index 740407252..8af5979cc 100644
>> --- a/drivers/opp/core.c
>> +++ b/drivers/opp/core.c
>> @@ -2020,7 +2020,10 @@ struct opp_table *dev_pm_opp_set_regulators(struct device *dev,
> 
> If this API is called by the platform specific code, then the
> regulator should be compulsory. Isn't it ?
> 
> Maybe we shouldn't use regulator_get_optional() here.
> 
There are two types of users of dev(m)_pm_opp_set_regulators():
1. Caller ignores -ENODEV and goes on.
2. Caller treats -ENODEV like any other error and bails out.

For type 1 callers a missing regulator should not result in an error message.
Switching to regulator_get() wouldn't be too nice because then a missing
regulator would result in the dummy regulator being used. This would create
a related warning and a functional change that may break something.

Type 2 callers still have the option to print an own error message in
case of -ENODEV. AFAICS all of them do so already.

>>  		reg = regulator_get_optional(dev, names[i]);
>>  		if (IS_ERR(reg)) {
>>  			ret = PTR_ERR(reg);
>> -			if (ret != -EPROBE_DEFER)
>> +			if (ret == -ENODEV)
>> +				dev_info(dev, "%s: no regulator (%s) found\n",
>> +					 __func__, names[i]);
>> +			else if (ret != -EPROBE_DEFER)
>>  				dev_err(dev, "%s: no regulator (%s) found: %d\n",
>>  					__func__, names[i], ret);
>>  			goto free_regulators;
> 

