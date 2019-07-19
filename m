Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 692EA6EA5D
	for <lists+linux-pm@lfdr.de>; Fri, 19 Jul 2019 19:52:25 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728328AbfGSRwY (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Fri, 19 Jul 2019 13:52:24 -0400
Received: from mail-lf1-f67.google.com ([209.85.167.67]:46177 "EHLO
        mail-lf1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727497AbfGSRwX (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Fri, 19 Jul 2019 13:52:23 -0400
Received: by mail-lf1-f67.google.com with SMTP id z15so18032902lfh.13;
        Fri, 19 Jul 2019 10:52:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=Wy2x8pwTjFkJ2F2BYzzzdzt5kgC8pQdrsxP6mCTGO+Q=;
        b=h/LPUlN7kHotEIBWuuJgZrJE0UAznhlWL+6s2j8ZaSHgm4/sRgi2VJJILERoXIJS7Z
         RpVASIkXHMOpPtfYJWKm5rDBQLFupOLiVaT0I/raPmo6sJlKlY5zvUjaPAUPrayL0R4p
         /sCt1r9ixB3hsYITxYM7IOFUUBJMg8cATKzp4IQ9Aidfjxe41s0AuEhxBThMiRkWhdc/
         XnCbm93Hg9BaML5TiBhAoaUd7i3D7I7xOIAgWghZSxmMXIUldcPZkAEEj0o2nnzJOWdm
         khFa1lTI4D58ZNFOPkFFiDUJh1dlMW2/xTotuqdWyYw6e2C0bNEnWYAHVBUDtUDi/mVz
         11eQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=Wy2x8pwTjFkJ2F2BYzzzdzt5kgC8pQdrsxP6mCTGO+Q=;
        b=TqQxR/zgIRNTK2X6B/vBfMmd6XVARZqtVAY4no+DEdBfIp9DRNN1e21gRCNWZsvzxs
         aIYZu8+A1btywKVvt4y91VZnVM0hRJOSPZB0qGWuQUxBpTcYnDgXuqd1okunBu9yUAZC
         zofKYvqSaEpMXEpnlav9OdNd3bubDG1+JfEF5ycn9Bae6QZucYc1NRhUhyALxWPVa7Wk
         FbSia80aJhDtIFIm/tnIWk6Hqg2zuU+iPOylemrDedA1h6M5685sQBilZ/QiqHYvLWA/
         s3+WwimD/9fzJvr5L/b4M7ZUkIl4jl1osZ060SpVvBkOStk8Ly3nEh0C6iya98Lh1swj
         UtQw==
X-Gm-Message-State: APjAAAWtt/KvTOBZKbJbJeTKo3rxrFW8K/b6L3f67Or6MwtTxFr8/gg7
        Lc3sBrCWyYBC/2x5jxkFUbMvCOND
X-Google-Smtp-Source: APXvYqzAHUuuxGIlzRhHUnbt8/msQLk1xdcaoeW/+LxKsjxPjD3L0MZyqXGI6QwL/951nnUnWmGJrA==
X-Received: by 2002:ac2:4c84:: with SMTP id d4mr24593601lfl.1.1563558740513;
        Fri, 19 Jul 2019 10:52:20 -0700 (PDT)
Received: from [192.168.2.145] (ppp79-139-233-208.pppoe.spdop.ru. [79.139.233.208])
        by smtp.googlemail.com with ESMTPSA id j23sm4625482lfb.93.2019.07.19.10.52.18
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 19 Jul 2019 10:52:19 -0700 (PDT)
Subject: Re: [PATCH v4 20/24] PM / devfreq: tegra30: Optimize upper average
 watermark selection
To:     Chanwoo Choi <cw00.choi@samsung.com>
Cc:     Thierry Reding <thierry.reding@gmail.com>,
        MyungJoo Ham <myungjoo.ham@samsung.com>,
        Kyungmin Park <kyungmin.park@samsung.com>,
        Jonathan Hunter <jonathanh@nvidia.com>,
        Tomeu Vizoso <tomeu.vizoso@collabora.com>,
        linux-pm@vger.kernel.org, linux-tegra@vger.kernel.org,
        linux-kernel@vger.kernel.org
References: <20190707223303.6755-1-digetx@gmail.com>
 <CGME20190707223619epcas4p333f556dcf5a477b5cad5c9362a6f9b97@epcas4p3.samsung.com>
 <20190707223303.6755-21-digetx@gmail.com>
 <e3358039-d1b3-a5a0-1a37-aeb8edd49d6b@samsung.com>
 <20190719045943.73b53e31@dimatab>
 <1cec80ae-c03e-98a7-1d9f-6b57690610c7@samsung.com>
 <20190719052111.6641285d@dimatab>
 <3c9c6a3a-8bce-d304-8472-029e6e673a99@samsung.com>
 <c3e4330a-a96c-1ae9-761e-9eb1179e9b01@samsung.com>
From:   Dmitry Osipenko <digetx@gmail.com>
Message-ID: <01b442e4-437d-799d-ed0d-4628bd0d683b@gmail.com>
Date:   Fri, 19 Jul 2019 20:52:18 +0300
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.7.2
MIME-Version: 1.0
In-Reply-To: <c3e4330a-a96c-1ae9-761e-9eb1179e9b01@samsung.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

19.07.2019 9:11, Chanwoo Choi пишет:
> On 19. 7. 19. 오후 3:09, Chanwoo Choi wrote:
>> On 19. 7. 19. 오전 11:21, Dmitry Osipenko wrote:
>>> В Fri, 19 Jul 2019 11:06:05 +0900
>>> Chanwoo Choi <cw00.choi@samsung.com> пишет:
>>>
>>>> On 19. 7. 19. 오전 10:59, Dmitry Osipenko wrote:
>>>>> В Fri, 19 Jul 2019 10:36:30 +0900
>>>>> Chanwoo Choi <cw00.choi@samsung.com> пишет:
>>>>>   
>>>>>> On 19. 7. 8. 오전 7:32, Dmitry Osipenko wrote:  
>>>>>>> I noticed that CPU may be crossing the dependency threshold very
>>>>>>> frequently for some workloads and this results in a lot of
>>>>>>> interrupts which could be avoided if MCALL client is keeping
>>>>>>> actual EMC frequency at a higher rate.
>>>>>>>
>>>>>>> Signed-off-by: Dmitry Osipenko <digetx@gmail.com>
>>>>>>> ---
>>>>>>>  drivers/devfreq/tegra30-devfreq.c | 23 ++++++++++++++++++-----
>>>>>>>  1 file changed, 18 insertions(+), 5 deletions(-)
>>>>>>>
>>>>>>> diff --git a/drivers/devfreq/tegra30-devfreq.c
>>>>>>> b/drivers/devfreq/tegra30-devfreq.c index
>>>>>>> c3cf87231d25..4d582809acb6 100644 ---
>>>>>>> a/drivers/devfreq/tegra30-devfreq.c +++
>>>>>>> b/drivers/devfreq/tegra30-devfreq.c @@ -314,7 +314,8 @@ static
>>>>>>> void tegra_actmon_get_lower_upper(struct tegra_devfreq *tegra, }
>>>>>>>  
>>>>>>>  static void tegra_devfreq_update_avg_wmark(struct tegra_devfreq
>>>>>>> *tegra,
>>>>>>> -					   struct
>>>>>>> tegra_devfreq_device *dev)
>>>>>>> +					   struct
>>>>>>> tegra_devfreq_device *dev,
>>>>>>> +					   unsigned long freq)
>>>>>>>  {
>>>>>>>  	unsigned long avg_threshold, lower, upper;
>>>>>>>  
>>>>>>> @@ -323,6 +324,15 @@ static void
>>>>>>> tegra_devfreq_update_avg_wmark(struct tegra_devfreq *tegra,
>>>>>>> avg_threshold = dev->config->avg_dependency_threshold;
>>>>>>> avg_threshold = avg_threshold * ACTMON_SAMPLING_PERIOD; 
>>>>>>> +	/*
>>>>>>> +	 * If cumulative EMC frequency selection is higher than
>>>>>>> the
>>>>>>> +	 * device's, then there is no need to set upper watermark
>>>>>>> to
>>>>>>> +	 * a lower value because it will result in unnecessary
>>>>>>> upper
>>>>>>> +	 * interrupts.
>>>>>>> +	 */
>>>>>>> +	if (freq * ACTMON_SAMPLING_PERIOD > upper)
>>>>>>> +		upper = freq * ACTMON_SAMPLING_PERIOD;    
>>>>>>
>>>>>> Also, 'upper value is used on the patch5. You can combine this code
>>>>>> to patch5 or if this patch depends on the cpu notifier, you can
>>>>>> combine it to the patch of adding cpu notifier without separate
>>>>>> patch.  
>>>>>
>>>>> Well okay, I'll try to squash some of the patches in the next
>>>>> revision. Usually I'm receiving comments in the other direction,
>>>>> asking to separate patches into smaller changes ;) So that's more a
>>>>> personal preference of each maintainer, I'd say.
>>>>>   
>>>>
>>>> Right. We have to make the patch with atomic attribute.
>>>> But, if there are patches which touch the same code
>>>> in the same patchset. We can squash or do refactorig
>>>> of this code.
>>>
>>> The main benefit of having smaller logical changes is that when there is
>>> a bug, it's easier to narrow down the offending change using bisection.
>>> And it's just easier to review smaller patches, of course.
>>
>> I agree that the patch should contain the atomic feature.
>> To remove the some communication confusion between us,
>> I don't mean that you have to merge patches to only one patch.
> 
> If each patch has the atomic attribute, it have to be made as the separate patch.
> But, if some patches are included in the the following two case,
> can combine patches to one patch.
> 
>>
>> It is important to remove the following two cases on the same patchset.
>>
>> 1. the front patch adds the code and then later patch remove the added code.

Okay, I agree that this is applicable to patch #11.

>> 2. the front patch changes the code and the later patch again modified
>>    the changed code of the front patch

If patch A adds a new feature and then patch B adds another new feature
on top of A, do you consider each of these patches as atomic?

[snip]
