Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id A44E76E9A7
	for <lists+linux-pm@lfdr.de>; Fri, 19 Jul 2019 18:52:16 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728565AbfGSQwP (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Fri, 19 Jul 2019 12:52:15 -0400
Received: from mail-lj1-f195.google.com ([209.85.208.195]:42074 "EHLO
        mail-lj1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728148AbfGSQwO (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Fri, 19 Jul 2019 12:52:14 -0400
Received: by mail-lj1-f195.google.com with SMTP id t28so31405379lje.9;
        Fri, 19 Jul 2019 09:52:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=F/NqcpcqNnQBv2t10umQVWFAVbQLRfDfp+FWKm32iHs=;
        b=JJW2PMHhieQszRIIrrnKK/J/vACC/ORoGPwTTL120LkaGiTr0HRuJJu9dfNIEqfctP
         2jtVUXgcjMq6bTTDJiWhCogCcjBBHiTtflwn3BsIzC68GJ0DG3RYauKzM4fnda0Jqzvh
         hx/Rn+RYPp9DzqZCPlIUyildnXR47kl4V3K8b7qIHRgsj383A0m3XjCx/Vak4Ok4uXrH
         C7AceBZhdZYGVduc7Ovg5fjtJYYetyHSraf3+6Xmf8p7T6G4hhFWQeQkLqIM+nb6x4Rv
         aWEmsSk2yrSCVlFIvghtEiRMmPEPknEWa6iOy004zykfYbh1MlXHOP5JuEiHp/eK/EEN
         ESdA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=F/NqcpcqNnQBv2t10umQVWFAVbQLRfDfp+FWKm32iHs=;
        b=eQPPvw2a2cFh/aWledFIVQ6GyjT+1fSIcI4OwOSxkzFMjeACAQU0JtzwEO/7X1BEJj
         mH2+Jrwc4gH5qcGMuQKjYZ+dZGYnmt84sOkr1nREnt14NK/B79wj0My0e6KW2tKUZHPK
         toWWmKAmFTYwRb6MMGeqDTo0M8YD6cdHzam0Z9I1nOSCt8TQWP1KDqS8lIg90A63l1RU
         4eTKFUgZuNMGownDCx513Ik34JJ20IH8Q9oQcocBLs10rXKHSEM2XtiFMdB4NqNoDysU
         4QIEKzuIwfnF1uoPHoPJ0wXj/dpUYHUmTG3wiRMfwfpgVjAQoShYR2XxZDBIepdAxcQa
         aA4w==
X-Gm-Message-State: APjAAAXiQk8RsTnuRzeoEUshownh0vWznnj77SJspyXDUxQkpP+jn2hM
        Vyzq08I/uLzGvtk7uAlPjUQqpEHf
X-Google-Smtp-Source: APXvYqyx+NhqwIUFY9oz+GmmOoGEUH37wd39XVbfpVgTHjN1l8sRKyLaxnag4kXhVVhr56Xzl6fRMQ==
X-Received: by 2002:a2e:994:: with SMTP id 142mr27639380ljj.130.1563555131536;
        Fri, 19 Jul 2019 09:52:11 -0700 (PDT)
Received: from [192.168.2.145] (ppp79-139-233-208.pppoe.spdop.ru. [79.139.233.208])
        by smtp.googlemail.com with ESMTPSA id f1sm5764658ljf.53.2019.07.19.09.52.10
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 19 Jul 2019 09:52:10 -0700 (PDT)
Subject: Re: [PATCH v4 12/24] PM / devfreq: tegra30: Inline all one-line
 functions
To:     Chanwoo Choi <cw00.choi@samsung.com>
Cc:     Thierry Reding <thierry.reding@gmail.com>,
        MyungJoo Ham <myungjoo.ham@samsung.com>,
        Kyungmin Park <kyungmin.park@samsung.com>,
        Jonathan Hunter <jonathanh@nvidia.com>,
        Tomeu Vizoso <tomeu.vizoso@collabora.com>,
        linux-pm@vger.kernel.org, linux-tegra@vger.kernel.org,
        linux-kernel@vger.kernel.org
References: <20190707223303.6755-1-digetx@gmail.com>
 <CGME20190707223633epcas4p3873704f3199126be0e8d5cb7454c7a51@epcas4p3.samsung.com>
 <20190707223303.6755-13-digetx@gmail.com>
 <b5634fbe-8bc1-0f04-e13b-6345dfbb5615@samsung.com>
 <b7da3fa2-00d1-5bd6-408c-202c85be917d@gmail.com>
 <45621f73-2f86-cde7-a92e-2a34810b9c05@samsung.com>
 <20190719042251.37cc9cda@dimatab>
 <92f82420-5c50-468f-a403-7b4c36958076@samsung.com>
 <97f2a317-989a-bcad-dd45-ccf00ba18cca@samsung.com>
 <20190719051426.4e4145d8@dimatab>
 <8e3de3b8-d3c6-fba3-0883-a2cd8d0c4c98@samsung.com>
From:   Dmitry Osipenko <digetx@gmail.com>
Message-ID: <12ea5667-bd93-1103-b20f-95b012047d1d@gmail.com>
Date:   Fri, 19 Jul 2019 19:52:09 +0300
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.7.2
MIME-Version: 1.0
In-Reply-To: <8e3de3b8-d3c6-fba3-0883-a2cd8d0c4c98@samsung.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

19.07.2019 9:01, Chanwoo Choi пишет:
> On 19. 7. 19. 오전 11:14, Dmitry Osipenko wrote:
>> В Fri, 19 Jul 2019 10:27:16 +0900
>> Chanwoo Choi <cw00.choi@samsung.com> пишет:
>>
>>> On 19. 7. 19. 오전 10:24, Chanwoo Choi wrote:
>>>> On 19. 7. 19. 오전 10:22, Dmitry Osipenko wrote:  
>>>>> В Thu, 18 Jul 2019 18:09:05 +0900
>>>>> Chanwoo Choi <cw00.choi@samsung.com> пишет:
>>>>>  
>>>>>> On 19. 7. 16. 오후 10:35, Dmitry Osipenko wrote:  
>>>>>>> 16.07.2019 15:26, Chanwoo Choi пишет:    
>>>>>>>> Hi Dmitry,
>>>>>>>>
>>>>>>>> I'm not sure that it is necessary.
>>>>>>>> As I knew, usally, the 'inline' is used on header file
>>>>>>>> to define the empty functions.
>>>>>>>>
>>>>>>>> Do we have to change it with 'inline' keyword?    
>>>>>>>
>>>>>>> The 'inline' attribute tells compiler that instead of jumping
>>>>>>> into the function, it should take the function's code and
>>>>>>> replace the function's invocation with that code. This is done
>>>>>>> in order to help compiler optimize code properly, please see
>>>>>>> [1]. There is absolutely no need to create a function call into
>>>>>>> a function that consists of a single instruction.
>>>>>>>
>>>>>>> [1] https://gcc.gnu.org/onlinedocs/gcc-9.1.0/gcc/Inline.html
>>>>>>>     
>>>>>>
>>>>>> If you want to add 'inline' keyword, I recommend that 
>>>>>> you better to remove the modified function in this patch
>>>>>> and then just call the 'write_relaxed or read_relaxed' function
>>>>>> directly. It is same result when using inline keyword.  
>>>>>
>>>>> That could be done, but it makes code less readable.
>>>>>
>>>>> See the difference:
>>>>>
>>>>> device_writel(dev, ACTMON_INTR_STATUS_CLEAR,
>>>>> ACTMON_DEV_INTR_STATUS);
>>>>>
>>>>> writel_relaxed(ACTMON_INTR_STATUS_CLEAR,
>>>>> 	       dev->regs + ACTMON_DEV_INTR_STATUS);  
>>>>
>>>> No problem if you add the detailed comment and you want to use
>>>> the 'inline' keyword.  
>>>
>>> Basically, I think that 'inline' keyword is not necessary.
>>
>> Sure, but I'm finding that it's always nicer to explicitly inline a very
>> simple functions because compiler may not do it properly itself in some
>> cases.
>>
>>> But if you want to use 'inline' keyword, I recommend
>>> that call the 'write_relaxed or read_relaxed' function directly
>>> with detailed description. 
>>
>> Could you please reword this sentence? Not sure that I'm understanding
>> it correctly.
>>
> 
> If you want to used 'inline' keyword,
> Instead, I recommend that remove 'actmon_readl/writel' wrapper functions
> and then you calls 'write_relaxed or read_relaxed' function directly
> with detailed description.
> 

This is a step into a wrong direction. Look, there is no need for extra
comments and the code is clean with the variant I'm proposing, while you
are asking to make code less readable and then paper that over with
comments.

I'll probably just drop this, #11 and #17 for now. Since these patches
and not essential for the functionality of the driver and they are
raising more questions than should be. Maybe we could get back to them
at some point later.
