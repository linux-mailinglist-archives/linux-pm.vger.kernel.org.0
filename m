Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id CAF4C333C44
	for <lists+linux-pm@lfdr.de>; Wed, 10 Mar 2021 13:11:34 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232934AbhCJMJj (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Wed, 10 Mar 2021 07:09:39 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57702 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232073AbhCJMJb (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Wed, 10 Mar 2021 07:09:31 -0500
Received: from mail-pg1-x533.google.com (mail-pg1-x533.google.com [IPv6:2607:f8b0:4864:20::533])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 576A0C061760;
        Wed, 10 Mar 2021 04:09:31 -0800 (PST)
Received: by mail-pg1-x533.google.com with SMTP id w34so10219109pga.8;
        Wed, 10 Mar 2021 04:09:31 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-transfer-encoding:content-language;
        bh=EGYkQJ9FJJaI5eGPOqdWnbYRXcHETF+ClVAnsVwF5+w=;
        b=kjttHZDsCbGL7E392wZMMsNEOP1cKrFYs0OCWryWfTJ20IGobyoI3PMtH9vo+fAhHU
         /QdLtw/XBR/ZJneft7H++HVEpno1/mbTC816sb1yXPBUR6R44s15A3UUUQ6/2IiNCKBW
         MQepIDYPV4dNhPh1QkHcf4k3kM4ZptiJ0GO9wtPgRy2ru18abRFvGKZ8sn7q+l/BMO4X
         qkcjvKqauC/dS9ahsyNPCpCZQzh/hukoOurD60FfN23nnLS2gQsUrb8FcSpFYrceZOQU
         euS8LMSUOCxkxyunYEWRu58DNGKuKCWw/ztSIgLp/+WHBbvsw5YreXA3na1mc5Dahk9O
         ZtqQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-transfer-encoding
         :content-language;
        bh=EGYkQJ9FJJaI5eGPOqdWnbYRXcHETF+ClVAnsVwF5+w=;
        b=a+1tvYAIftmM7yXXW0ML2o2eHrSvna8U6f8JgEAjvUNEufOujl3HvNOXVFqteQlScc
         SfA1tlP5qOSuPzU4H16jOMroEbCN38n7k8nqIJPtRHuoB9O68YOAF4MSS6mtAVqVWjCk
         tm/HTHJY+OdfvO0vzNSeLMLSAL26c0yfZ8S0cFMjd0XVFVkhN39MGdL/DZM6l6u/ZHk+
         ndOerAKCNbZNKsRyF1Dpb0rIu1wtqIbv7GaGpb52PgYyFGldeTPi/qHsPT56U2igpOvZ
         3oQ5fU2W0AiuvhXww9YKC36ecpL6CKL6iHKw21t/nveeVvnELVziCeKthk3Lev/ReONz
         Ul2A==
X-Gm-Message-State: AOAM531K1x4IMfhOxwbEAk/pxiknVfk4u45HMOipGW+uJl6+WX0GSqe0
        OMfE5xszdFAikzzP1t7dhOd0whOJy7ZN9Q==
X-Google-Smtp-Source: ABdhPJzPzP1RJtWKMOkELkXPAeDPTK040moyRZg7kfRsBua91nb7RT8r8pxxDO56uMqEoWBjn69ftQ==
X-Received: by 2002:aa7:9797:0:b029:1f8:1a14:b055 with SMTP id o23-20020aa797970000b02901f81a14b055mr2774190pfp.57.1615378170592;
        Wed, 10 Mar 2021 04:09:30 -0800 (PST)
Received: from [10.38.0.10] ([45.135.186.59])
        by smtp.gmail.com with ESMTPSA id a15sm6442537pju.34.2021.03.10.04.09.28
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 10 Mar 2021 04:09:30 -0800 (PST)
Subject: Re: [PATCH] thermal: thermal_of: fix error return code of
 thermal_of_populate_bind_params()
To:     Daniel Lezcano <daniel.lezcano@linaro.org>, rui.zhang@intel.com,
        amitk@kernel.org
Cc:     linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20210306141106.18695-1-baijiaju1990@gmail.com>
 <ac49897d-fdcd-57aa-fb1a-2bf7f3b2296d@linaro.org>
From:   Jia-Ju Bai <baijiaju1990@gmail.com>
Message-ID: <e3d1aacd-ecbd-aa93-a547-11f89ca5f487@gmail.com>
Date:   Wed, 10 Mar 2021 20:09:26 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:68.0) Gecko/20100101
 Thunderbird/68.4.1
MIME-Version: 1.0
In-Reply-To: <ac49897d-fdcd-57aa-fb1a-2bf7f3b2296d@linaro.org>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Content-Language: en-US
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org



On 2021/3/10 20:02, Daniel Lezcano wrote:
> On 06/03/2021 15:11, Jia-Ju Bai wrote:
>> When kcalloc() fails and __tcbp is NULL, no error return code of
>> thermal_of_populate_bind_params() is assigned.
>> To fix this bug, ret is assigned with -ENOMEM in this case.
>>
>> Reported-by: TOTE Robot <oslab@tsinghua.edu.cn>
>> Signed-off-by: Jia-Ju Bai <baijiaju1990@gmail.com>
>> ---
>>   drivers/thermal/thermal_of.c | 4 +++-
>>   1 file changed, 3 insertions(+), 1 deletion(-)
>>
>> diff --git a/drivers/thermal/thermal_of.c b/drivers/thermal/thermal_of.c
>> index 69ef12f852b7..e8c9041482e9 100644
>> --- a/drivers/thermal/thermal_of.c
>> +++ b/drivers/thermal/thermal_of.c
>> @@ -710,8 +710,10 @@ static int thermal_of_populate_bind_params(struct device_node *np,
>>   	}
>>   
>>   	__tcbp = kcalloc(count, sizeof(*__tcbp), GFP_KERNEL);
>> -	if (!__tcbp)
>> +	if (!__tcbp) {
>> +		ret = -ENOMEM;
>>   		goto end;
>> +	}
> Thank you for your patch.
>
> Seems like the same happens a few lines before:
>
>          count = of_count_phandle_with_args(np, "cooling-device",
>                                             "#cooling-cells");
>          if (!count) {
>                  pr_err("Add a cooling_device property with at least one
> device\n");
>                  goto end;
>          }
>
> Mind to send a patch fixing both ?
>

Thanks for the reply and advice.
I will send a new version of the patch to fix them both.


Best wishes,
Jia-Ju Bai
