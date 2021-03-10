Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id DB2D3333F70
	for <lists+linux-pm@lfdr.de>; Wed, 10 Mar 2021 14:42:18 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233169AbhCJNkp (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Wed, 10 Mar 2021 08:40:45 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49538 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232938AbhCJNkc (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Wed, 10 Mar 2021 08:40:32 -0500
Received: from mail-wm1-x330.google.com (mail-wm1-x330.google.com [IPv6:2a00:1450:4864:20::330])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 99A7EC061763
        for <linux-pm@vger.kernel.org>; Wed, 10 Mar 2021 05:40:31 -0800 (PST)
Received: by mail-wm1-x330.google.com with SMTP id u187so7119990wmg.4
        for <linux-pm@vger.kernel.org>; Wed, 10 Mar 2021 05:40:31 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=iKsE0EavC1CLlzfIfD/fKBxBbrFrxqX+26sqGfTHMV8=;
        b=leMYdBbDQlGXgyyavvR95hKrY0+7odc90shjgJ+CMR0SvBi1BW9gy6+rRC3yxjISq+
         1zJQNl+pZo52vxXtZHP2kT4NV8PP/qzZu/Us3N2vZsVViCMz7Dmlv2FcqcBmAygx5HBt
         h5a8sze9WbM1vnoq816rd3jREVYbslDmMqQeOPHgoBGxhwyf4z0pBXYRmRgYD9btqnJr
         ZGXOjq+r0HzKiu6WW/uCyAJ4f20kgWHEkHewh9aLfCsGu20NIWRWgPIOvSOtwjz9ybqv
         TVPdYWzHcHD1eFUilNWICv4u5LVpQHOKxu6YYSAeOKn24we690BNnpq+UlQs/1Dv0CbI
         Nwmg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=iKsE0EavC1CLlzfIfD/fKBxBbrFrxqX+26sqGfTHMV8=;
        b=VsK92ZD5A4uWzKc2Dz+md/YUdxgri1EbHXkjikhci67oo0FP9zGr2IB2zXoVAYvfEw
         f3DOF2TtChv/hEzXox3HeCV2b/TCaVkQBPSxvjZk97FFkZwkRZly51+HnM6K75Q8Cc7x
         /Oqo2ljONM0CbjKFw1mHmpG8bKILT+9kEUG8YAwbvlemgYRhbhssr63xbUT31waO1HWT
         VqQi9tKmgewYrMWGoqoMjpTBFfWRUcqF/oQm2X3MCuWUvLWC27MnKK/nREAxvXXd1uF0
         COuW+7aZraaWx0/q1TT+lmOrMbYD+utoSFhjiQw91djmf94hRWyg/JDWhXt/8JmAIFmD
         mRQA==
X-Gm-Message-State: AOAM5308AKeIPx2IEw0jS1izTNL0oKSDsMycDKmiYezM/ywe1t63iTW/
        JED4pRX22SPEGCkOQmC81ToxGQ==
X-Google-Smtp-Source: ABdhPJw07Ohry8VNeu8htAp3nJyjbkw5TzsikJvbyRHKOvmZOE/of10qitCSXCG1DbQgZK+HK2agcw==
X-Received: by 2002:a1c:600a:: with SMTP id u10mr2818048wmb.139.1615383630025;
        Wed, 10 Mar 2021 05:40:30 -0800 (PST)
Received: from ?IPv6:2a01:e34:ed2f:f020:8018:efa9:4421:9140? ([2a01:e34:ed2f:f020:8018:efa9:4421:9140])
        by smtp.googlemail.com with ESMTPSA id j14sm27563708wrw.69.2021.03.10.05.40.28
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 10 Mar 2021 05:40:29 -0800 (PST)
Subject: Re: [PATCH v10 0/8] Add support for ipq8064 tsens
To:     Thara Gopinath <thara.gopinath@linaro.org>,
        Ansuel Smith <ansuelsmth@gmail.com>,
        Amit Kucheria <amitk@kernel.org>
Cc:     Andy Gross <agross@kernel.org>,
        Bjorn Andersson <bjorn.andersson@linaro.org>,
        Zhang Rui <rui.zhang@intel.com>,
        Rob Herring <robh+dt@kernel.org>,
        linux-arm-msm@vger.kernel.org, linux-pm@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20210217194011.22649-1-ansuelsmth@gmail.com>
 <f0ab094e-440d-993c-6618-bf80fd05d484@linaro.org>
 <44c7919c-0ed4-abba-21e0-226bb553aad3@linaro.org>
From:   Daniel Lezcano <daniel.lezcano@linaro.org>
Message-ID: <72427874-244b-6344-411c-ea53770bc1f0@linaro.org>
Date:   Wed, 10 Mar 2021 14:40:28 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
MIME-Version: 1.0
In-Reply-To: <44c7919c-0ed4-abba-21e0-226bb553aad3@linaro.org>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

On 10/03/2021 14:32, Thara Gopinath wrote:
> 
> 
> On 3/10/21 7:19 AM, Daniel Lezcano wrote:
>>
>> Hi Ansuel,
>>
>> On 17/02/2021 20:40, Ansuel Smith wrote:
>>> This patchset convert msm8960 to reg_filed, use int_common instead
>>> of a custom function and fix wrong tsens get_temp function for msm8960.
>>> Ipq8064 SoCs tsens driver is based on 8960 tsens driver. Ipq8064 needs
>>> to be registered as a gcc child as the tsens regs on this platform are
>>> shared with the controller.
>>> This is based on work and code here
>>> https://git.linaro.org/people/amit.kucheria/kernel.git/log/?h=wrk3/tsens-8960-breakage
>>>
>>
>> I don't have major concerns with the series except there is no comment
>> from the maintainer / reviewer of the sensor.
>>
>> Given it is based on Amit's work, I can assume they are correct.
>>
>> I added Thara in Cc hoping she has time to review the changes. If nobody
>> complains with the series, I'll merge them in the next days
> 
> Hi Ansuel/Daniel,
> 
> Just wanted to let you know that I have started looking into this and
> review this within next week or two.

Great, thank you


-- 
<http://www.linaro.org/> Linaro.org │ Open source software for ARM SoCs

Follow Linaro:  <http://www.facebook.com/pages/Linaro> Facebook |
<http://twitter.com/#!/linaroorg> Twitter |
<http://www.linaro.org/linaro-blog/> Blog
