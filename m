Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 683D62529DA
	for <lists+linux-pm@lfdr.de>; Wed, 26 Aug 2020 11:19:19 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728030AbgHZJTL (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Wed, 26 Aug 2020 05:19:11 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38610 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728022AbgHZJTG (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Wed, 26 Aug 2020 05:19:06 -0400
Received: from mail-wm1-x342.google.com (mail-wm1-x342.google.com [IPv6:2a00:1450:4864:20::342])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 476CDC061574
        for <linux-pm@vger.kernel.org>; Wed, 26 Aug 2020 02:19:05 -0700 (PDT)
Received: by mail-wm1-x342.google.com with SMTP id x5so1035709wmi.2
        for <linux-pm@vger.kernel.org>; Wed, 26 Aug 2020 02:19:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=aQcWyWsk38YmTkWkQQedY4JUFqd5lel0GI59fGELsZY=;
        b=Re5YAll6kM+/qHPCwaFGTdAnaHmZFyhlrOR8z0SsaMrpkbz9oS7+ticj73RwOxcTDi
         RsOCnIs8KaS/IqFMdZfnjdweWuO9R3Kjcx64KRlceaGgkhy31LEhdxX+uTl+lAGRafEc
         lGLwqWRl4u6I3+rFr+hEryjlZXhDFSEBtpmFVAPd4BS+gsjT9cgbd6KOSLWBZldrMFfc
         pkezhSnTJ7ARy9H55SYkJoxVM+NfD0V45Q9cQd48Ci1O5Okj8A3qS1GRxFwlFFagJzPE
         DzYfsQtpLWJdpIIZ6tBHIlw6PejlOz+cejV8SeLwemZ4xXVghtUvtTa0XWwqYC5fPXGj
         lkrQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=aQcWyWsk38YmTkWkQQedY4JUFqd5lel0GI59fGELsZY=;
        b=J8cHmr2GgbmhJIitqfuHhlvxWnaiRuSfW74A9KkJMdBc1/O3QrZP096+wNgvLToVRr
         k/GaYs/gSSKQIP9ZMl7qPWEA+tRexlXjZhmYbxlo4Rm9wX+/ALePM8x62eH42UJ09k5+
         fpoFwQvs0Jo/IRh2Ve8fPpd8qVRKcx+qszUWdXpd0lCI6zjsNnyJknEZkeJisHgOoWee
         VIuytrQ32iZCnKxaSVdq7WdYDfEV3guSBGNWoZkDcCMjueqhSGGT27hhJkNYN4pWnLFf
         X+ANyrw1U4d7WSx+iA20Hp7DxzD+OEJxnOqUlG5dM/Urg+Wd0Qps6k1a2ckchYC9l/vJ
         myLw==
X-Gm-Message-State: AOAM530QJ06JgkT9VjIPUKLw1bw0T9qUf6GC868PcWrihlxnqlZj7qPs
        k2qcgAtBWcC5uBN7lI+2+PdqqQ==
X-Google-Smtp-Source: ABdhPJx/tuIFtWZKSy7AJh6YwPDzBe15yli6WSJ1VCxEeq3keSaGzRbAVGb3KLflm17pbZnrvz1zbA==
X-Received: by 2002:a1c:b143:: with SMTP id a64mr5924451wmf.43.1598433543749;
        Wed, 26 Aug 2020 02:19:03 -0700 (PDT)
Received: from ?IPv6:2a01:e34:ed2f:f020:5838:da98:5a96:aea3? ([2a01:e34:ed2f:f020:5838:da98:5a96:aea3])
        by smtp.googlemail.com with ESMTPSA id a85sm4581111wmd.26.2020.08.26.02.19.02
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 26 Aug 2020 02:19:03 -0700 (PDT)
Subject: Re: [PATCH] thermal: sysfs: fall back to vzalloc for cooling device's
 statistics
To:     Yue Hu <zbestahu@gmail.com>
Cc:     rui.zhang@intel.com, amit.kucheria@verdurent.com,
        viresh.kumar@linaro.org, linux-pm@vger.kernel.org,
        linux-kernel@vger.kernel.org, huyue2@yulong.com, zbestahu@163.com
References: <20200818063005.13828-1-zbestahu@gmail.com>
 <40b69f97-46e5-d62e-0d2f-604dfd4dafa1@linaro.org>
 <20200826101319.00003048.zbestahu@gmail.com>
From:   Daniel Lezcano <daniel.lezcano@linaro.org>
Message-ID: <c3fd7949-b33a-aca3-8dd5-1c2df35fb63d@linaro.org>
Date:   Wed, 26 Aug 2020 11:19:02 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
MIME-Version: 1.0
In-Reply-To: <20200826101319.00003048.zbestahu@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org


Hi Yue,

On 26/08/2020 04:13, Yue Hu wrote:
> On Mon, 24 Aug 2020 12:40:35 +0200
> Daniel Lezcano <daniel.lezcano@linaro.org> wrote:
> 
>> On 18/08/2020 08:30, Yue Hu wrote:
>>> From: Yue Hu <huyue2@yulong.com>
>>>
>>> We observed warning about kzalloc() when register thermal cooling device
>>> in backlight_device_register(). backlight display can be a cooling device
>>> since reducing screen brightness will can help reduce temperature.
>>>
>>> However, ->get_max_state of backlight will assign max brightness of 1024
>>> to states. The memory size can be getting 1MB+ due to states * states.  
>>
>> What are the benefits of a 1024 states cooling device ? Is the
>> difference noticeable with a such small step ?
> 
> Okay, this issue is happened under MSM/Android platform. QCOM spmi wled driver
> will define the max brightness. We needs to fix the issue to get thermal statistics.

Let me rephrase my questions:

Don't you think there is something wrong in creating a 1024 x 1024
matrix to show transitions ?

What is the benefit of such stats ?

What is the benefit of having a 1024 states cooling device ?




-- 
<http://www.linaro.org/> Linaro.org │ Open source software for ARM SoCs

Follow Linaro:  <http://www.facebook.com/pages/Linaro> Facebook |
<http://twitter.com/#!/linaroorg> Twitter |
<http://www.linaro.org/linaro-blog/> Blog
