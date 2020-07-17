Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 05A97223654
	for <lists+linux-pm@lfdr.de>; Fri, 17 Jul 2020 09:57:30 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726923AbgGQH4X (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Fri, 17 Jul 2020 03:56:23 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39824 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726105AbgGQH4V (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Fri, 17 Jul 2020 03:56:21 -0400
Received: from mail-wm1-x342.google.com (mail-wm1-x342.google.com [IPv6:2a00:1450:4864:20::342])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 61864C061755
        for <linux-pm@vger.kernel.org>; Fri, 17 Jul 2020 00:56:21 -0700 (PDT)
Received: by mail-wm1-x342.google.com with SMTP id f18so15852845wml.3
        for <linux-pm@vger.kernel.org>; Fri, 17 Jul 2020 00:56:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=o5nIopuM74BtlFzAImb/PK0gyySVM6KhH9dqp/om8uc=;
        b=NViLlxEklhp1mf7knnPOTkE3tfi428+VHQSNEDbHSufq2Kp0CtIaRQ6KLH/dp/bthm
         5KB6kGNDHPBndZPUjVblnnJCuGZf5aRnunRSI+4jjCviFmVd6OCmsbIxO8Wz1lZ4gMV7
         mo8OG0Z+4l6xUg1vCqprcFAf6fROOuI+9MeoYuRD66Zof1qzxtVhyLLPtpXozMRZImi0
         6aaE1etFK/dZtL8XBO/+qgJzFimkfgrPuVuxMGKHD65yVqrQKijg49ibw7kavHy5IL9O
         JgrA2mSWlNt4z3w2tSzq6FlYyJf+N6qAGTmHUAZa6sNoUVkmaml6SBt0+qk4VI6uX7KD
         kt+w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=o5nIopuM74BtlFzAImb/PK0gyySVM6KhH9dqp/om8uc=;
        b=p6rgTxq7okVB9/xhxQro3Dl++zIny+O8iERZEd3ocXGHXmD9HpBhz+k80cBZFt0Wc8
         zYTMAXWmMjHSjT9ZLC3yGd4qYeJCu0RbA+XroIiIcDdDbCMxqJiKZVRLnCoip+P+8Glz
         x8/e2+H4pr2dFDpa5PtSRBjWy6WB36hwfpcc2CAgPrCVSxELaeAcqhfRqfxR6JTDJA07
         YyTUs3NsPQR1NzrPiW5xDHu5kZSlV93srxvLHaaKPsdYurdkZSX+rZPuwwCKDMa6OIwI
         Ip9FfoFyLQIGkfzMM+TPmeVUbRT69tu2Bk3GiCSK3Kl5sVx5LPceB2S3MBKlvpYRq5cz
         O7Uw==
X-Gm-Message-State: AOAM533XdIApcAiGih97uA02yiMhCvP40ze+6m5ihdgsOg6Z8iR1572H
        qN/VWOZauUDNFA6t2HPKcbi/NA==
X-Google-Smtp-Source: ABdhPJyQffzOr3evg0fAENlwAmDQoBs8yLbdDfhUB2Pv/w4X9/+ZCM+homnG3Ny/Q26Zm37J79d9mw==
X-Received: by 2002:a1c:9e84:: with SMTP id h126mr7660444wme.61.1594972579968;
        Fri, 17 Jul 2020 00:56:19 -0700 (PDT)
Received: from ?IPv6:2a01:e34:ed2f:f020:9880:a643:3e69:6393? ([2a01:e34:ed2f:f020:9880:a643:3e69:6393])
        by smtp.googlemail.com with ESMTPSA id q7sm12848370wrs.27.2020.07.17.00.56.18
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 17 Jul 2020 00:56:19 -0700 (PDT)
Subject: Re: [PATCH v4 08/16] thermal: sun8i: add TEMP_CALIB_MASK for
 calibration data in sun50i_h6_ths_calibrate
To:     Frank Lee <tiny.windzz@gmail.com>
Cc:     Frank Lee <frank@allwinnertech.com>,
        Vasily Khoruzhick <anarsoul@gmail.com>,
        Zhang Rui <rui.zhang@intel.com>,
        Amit Kucheria <amit.kucheria@verdurent.com>,
        Maxime Ripard <mripard@kernel.org>,
        Chen-Yu Tsai <wens@csie.org>,
        Linux PM <linux-pm@vger.kernel.org>,
        Linux ARM <linux-arm-kernel@lists.infradead.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        =?UTF-8?B?6buE54OB55Sf?= <huangshuosheng@allwinnertech.com>,
        liyong@allwinnertech.com
References: <cover.1594708863.git.frank@allwinnertech.com>
 <b8761e036b25f20873534e5f8d10b37b5d2ce72c.1594708864.git.frank@allwinnertech.com>
 <4771acd6-ecd3-b8e1-8605-75d78720b1d3@linaro.org>
 <CAEExFWv9_1kec_b+t+nnvT3cziXzmVa8GzJT3pQAZiCf4KA0ig@mail.gmail.com>
From:   Daniel Lezcano <daniel.lezcano@linaro.org>
Message-ID: <836e1b23-1c75-57fe-6e45-f7141272071c@linaro.org>
Date:   Fri, 17 Jul 2020 09:56:18 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
MIME-Version: 1.0
In-Reply-To: <CAEExFWv9_1kec_b+t+nnvT3cziXzmVa8GzJT3pQAZiCf4KA0ig@mail.gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

On 17/07/2020 09:35, Frank Lee wrote:
> On Fri, Jul 17, 2020 at 12:26 PM Daniel Lezcano
> <daniel.lezcano@linaro.org> wrote:
>>
>> On 14/07/2020 09:13, Frank Lee wrote:
>>> From: Yangtao Li <frank@allwinnertech.com>
>>>
>>> For sun50i_h6_ths_calibrate(), the data read from nvmem needs a round of
>>> calculation. On the other hand, the newer SOC may store other data in
>>> the space other than 12bit sensor data. Add mask operation to read data
>>> to avoid conversion error.
>>>
>>> Signed-off-by: Yangtao Li <frank@allwinnertech.com>
>>> Reviewed-by: Yangtao Li <tiny.windzz@gmail.com>
>>
>> Can you clarify these SoB ?
> 
> Previously I used 'Signed-off-by: Yangtao Li <tiny.windzz@gmail.com>',
> maybe this should be removed directly?
> 
>>
>> Frank Lee==Yangtao Li==frank@allwinnertech.com==tiny.windzz@gmail.com ?
>>
> 
> Yeah.

You are not supposed to add reviewed-by yourself. Please remove it.


-- 
<http://www.linaro.org/> Linaro.org │ Open source software for ARM SoCs

Follow Linaro:  <http://www.facebook.com/pages/Linaro> Facebook |
<http://twitter.com/#!/linaroorg> Twitter |
<http://www.linaro.org/linaro-blog/> Blog
