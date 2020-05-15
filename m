Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id EA9DA1D4C09
	for <lists+linux-pm@lfdr.de>; Fri, 15 May 2020 13:03:12 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725919AbgEOLDM (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Fri, 15 May 2020 07:03:12 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58642 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726144AbgEOLDL (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Fri, 15 May 2020 07:03:11 -0400
Received: from mail-wm1-x344.google.com (mail-wm1-x344.google.com [IPv6:2a00:1450:4864:20::344])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1801BC05BD09
        for <linux-pm@vger.kernel.org>; Fri, 15 May 2020 04:03:11 -0700 (PDT)
Received: by mail-wm1-x344.google.com with SMTP id n5so2208162wmd.0
        for <linux-pm@vger.kernel.org>; Fri, 15 May 2020 04:03:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=iqpq12gc8bTtNBtY5ZIVdxCDS9UGGhps1DCBy7t56Sc=;
        b=KQhWFuX/FjBpvSsD5C4JlqNzD53keqf6x1HZUfMWY9SjMgRvTGdIRcgtfxx+yEhOua
         7FJGFLE/tL21fgq7R1DP6qTmAsILkA7I4iQbUswloXIptvbMaIjLiQ+JuFAqdrgh1K0q
         MbxDuvveGypUJvaM4vhgWjhk+g01QInFSXY+fXcmb8H23HUhzpdgrUgoAPnLuzrQOkWm
         MTgueJG/9fB0PYlgMmHxWSLuDK4wk/ybO7LPPQ3E9Jono3Ly/QGKv6JYwPBZAB34Hyb6
         0R3efCIjIciXDeRMX/oaSGKEeTMXO5WiPRNUMAvLtFGnUIaQHpXivbwnoRATQBzMBAMS
         ZKfg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=iqpq12gc8bTtNBtY5ZIVdxCDS9UGGhps1DCBy7t56Sc=;
        b=rRJqvoK5/7ZaMp7sTSX5M2ttJQH57C6dVpNBGgGbazUod3s/R26CKHlt0MMtqHs4XG
         cGaCTrFU8+GPOmasUqSUtw7gIkmNrWE48H6XoBmE3u7kW9xuIOi8SD7G6riFDgIN04ZR
         oQRw4gXhtXEnGnP9/joKlHXEmmOuG7ewOMDDzbvKlWGG8+5YYr/qbNFXD9ArR9mUdWG9
         vbeXfP0/Tyxk1OJ1LUXlx2jyfv/POMWiBG8kO7eK7+Jw0wWG+N647cP6yggSrIubaHSs
         +v+3UhJVInh3bFM1NRbA3JSSvZ255a3C9KCbNIOniPOI6b3QbvBUVs5Gwav5wynzgqTy
         Uq3Q==
X-Gm-Message-State: AOAM531xU3+iDV1SLc2AAzoBwOmd+EToIOytrrB2zuAcw9sAgvTaOzY9
        pfzWP7bWBOawvkNygt2UCLYJVg==
X-Google-Smtp-Source: ABdhPJz09zqvaqC1JaFDugl18vq78E+RNFXiDIdWvrDoMdsvhWsiQds56u5FrbQHPH1HGgUnZIcgDA==
X-Received: by 2002:a1c:bbc5:: with SMTP id l188mr3289666wmf.163.1589540589509;
        Fri, 15 May 2020 04:03:09 -0700 (PDT)
Received: from ?IPv6:2a01:e34:ed2f:f020:28df:6b80:d69f:9c0a? ([2a01:e34:ed2f:f020:28df:6b80:d69f:9c0a])
        by smtp.googlemail.com with ESMTPSA id z12sm458111wmc.6.2020.05.15.04.03.08
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 15 May 2020 04:03:08 -0700 (PDT)
Subject: Re: [PATCH v4 4/4] thermal: cpuidle: Register cpuidle cooling device
To:     Sudeep Holla <sudeep.holla@arm.com>
Cc:     Lukasz Luba <lukasz.luba@arm.com>, rui.zhang@intel.com,
        "Rafael J. Wysocki" <rjw@rjwysocki.net>,
        Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>,
        "open list:CPU IDLE TIME MANAGEMENT FRAMEWORK" 
        <linux-pm@vger.kernel.org>,
        open list <linux-kernel@vger.kernel.org>,
        "open list:CPUIDLE DRIVER - ARM PSCI" 
        <linux-arm-kernel@lists.infradead.org>
References: <20200429103644.5492-1-daniel.lezcano@linaro.org>
 <20200429103644.5492-4-daniel.lezcano@linaro.org>
 <99b3bc79-f48a-3d51-a8ae-8b9ca4856d36@arm.com>
 <04b5da25-d591-b08a-e554-6e084d7ea908@linaro.org>
 <f3cee834-4946-10bd-a504-df6cf62d9e90@linaro.org>
 <20200515095751.GA25267@bogus>
From:   Daniel Lezcano <daniel.lezcano@linaro.org>
Message-ID: <6faac4ac-b711-11ad-32e7-26ae930db6fa@linaro.org>
Date:   Fri, 15 May 2020 13:03:07 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.7.0
MIME-Version: 1.0
In-Reply-To: <20200515095751.GA25267@bogus>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

On 15/05/2020 11:58, Sudeep Holla wrote:
> On Mon, May 04, 2020 at 08:00:01PM +0200, Daniel Lezcano wrote:
>>
>> Hi,
>>
>> On 29/04/2020 23:01, Daniel Lezcano wrote:
>>> On 29/04/2020 22:02, Lukasz Luba wrote:
>>>>
>>>>
>>>> On 4/29/20 11:36 AM, Daniel Lezcano wrote:
>>>>> The cpuidle driver can be used as a cooling device by injecting idle
>>>>> cycles. The DT binding for the idle state added an optional
>>>>>
>>>>> When the property is set, register the cpuidle driver with the idle
>>>>> state node pointer as a cooling device. The thermal framework will do
>>>>> the association automatically with the thermal zone via the
>>>>> cooling-device defined in the device tree cooling-maps section.
>>>>>
>>>>> Signed-off-by: Daniel Lezcano <daniel.lezcano@linaro.org>
>>>>> ---
>>>>>   - V4:
>>>>>     - Do not check the return value as the function does no longer
>>>>> return one
>>>>> ---
>>>
>>> [ ... ]
>>>
>>>> Reviewed-by: Lukasz Luba <lukasz.luba@arm.com>
>>>
>>> Thanks Lukasz for the review.
>>>
>>> Rafael, as Lorenzo and Sudeep are not responsive, could you consider ack
>>> this patch so I can merge the series through the thermal tree ?
>>
>> Gentle ping ... Sudeep, Lorenzo or Rafael ?
>>
> 
> Sorry for the delay. I ignore this as it was generic and I was fine with
> it. Didn't know you were waiting me, sorry for that.

No problem, thanks for the ack.

> Acked-by: Sudeep Holla <sudeep.holla@arm.com>

Rafael, if you are ok with that, I'll take this patch in the thermal
tree along with the others.


-- 
<http://www.linaro.org/> Linaro.org │ Open source software for ARM SoCs

Follow Linaro:  <http://www.facebook.com/pages/Linaro> Facebook |
<http://twitter.com/#!/linaroorg> Twitter |
<http://www.linaro.org/linaro-blog/> Blog
