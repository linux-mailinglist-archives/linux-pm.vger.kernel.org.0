Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id DC32434BDDB
	for <lists+linux-pm@lfdr.de>; Sun, 28 Mar 2021 20:02:59 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231308AbhC1SCZ (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Sun, 28 Mar 2021 14:02:25 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33976 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229647AbhC1SB6 (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Sun, 28 Mar 2021 14:01:58 -0400
Received: from mail-wm1-x334.google.com (mail-wm1-x334.google.com [IPv6:2a00:1450:4864:20::334])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DA507C061762
        for <linux-pm@vger.kernel.org>; Sun, 28 Mar 2021 11:01:57 -0700 (PDT)
Received: by mail-wm1-x334.google.com with SMTP id b2-20020a7bc2420000b029010be1081172so5538627wmj.1
        for <linux-pm@vger.kernel.org>; Sun, 28 Mar 2021 11:01:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=FSV6rta3hJrwpk1P4mXDAcDYdRJg95MvBSYZceCodik=;
        b=oSOYYdNRkdQVtznXgt78DhiwTWTyzGZF3oJMe8w4KEtcPyBLXe+SMFYvGd+1oj9LQU
         r+3uWqxIghxhPFZU6Wuc3lTsr1obuN/1XT+oueshAk+gbGImzMAYJdf85a6crcqhy0e1
         +wZlhI6QwSVp9fLFMCSC4+ilP5ANqr7SeCPSHFAjZvo4GtktRLFRtw0ftjbX+D8y7QhE
         kOKivr+Xaqy/9hlXYLyfK3URX9DHSdP8BlWHVxIGKPZyn5bMqhtXBFITvpGaI+/xd/rM
         sFNiokpGBV5ArT1Z24VLOrvllQ0LUemSArwJLtk2pUBXbSKIRoROtHU9pA39vqDdmQwk
         xaSA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=FSV6rta3hJrwpk1P4mXDAcDYdRJg95MvBSYZceCodik=;
        b=JZsvcfnkgU4eVzxigAQz7OVhuWbg7Mf8B4iuwpUMS9+1BwPC0maxzFYU0rHpKAKYr2
         SQU0U9j7D7nmqt0ZYHXnEZc8Q2c05ssYTsaGjQwqfSPpu1ihvIaSRug7LkcQpt44wXpl
         5jH6xa1iMDMxisfA1ogmL51q+52bH66OB+xy22JyeHH5jsOeSVq98mHY1wI279v3mOVJ
         370gFcPk9XnJjivla6a9VF8gb31H1o3E03E+MQRl8WuxhWexe8DumK0K9e944vkrWqWK
         TyvVqN0ByAi9QBpY5PJX3WuMNGeJSw2SgFbU7tVyiVfYvKp6mjfiV0CwV8uzKF4y08OW
         U02Q==
X-Gm-Message-State: AOAM531dVWTJREKONhkvYn0Oc+CDRTuv4kRPIHFCxLE2jpqLp4eTMNsb
        9VRY9bNKQiwuFEzUYDQQ3gi1Vg==
X-Google-Smtp-Source: ABdhPJy+gVLRWMbs9MBvQ5wgzJ1R9N4zHUB5GvTCe8IVgfnknokeggtcfnLxxlZFMTEPF9ziKiZFcw==
X-Received: by 2002:a05:600c:1992:: with SMTP id t18mr21563797wmq.125.1616954516332;
        Sun, 28 Mar 2021 11:01:56 -0700 (PDT)
Received: from ?IPv6:2a01:e34:ed2f:f020:1945:696f:a453:cac9? ([2a01:e34:ed2f:f020:1945:696f:a453:cac9])
        by smtp.googlemail.com with ESMTPSA id g11sm25154394wrw.89.2021.03.28.11.01.55
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sun, 28 Mar 2021 11:01:55 -0700 (PDT)
Subject: Re: [PATCH v4 2/5] powercap/drivers/dtpm: Create a registering system
To:     Greg KH <gregkh@linuxfoundation.org>
Cc:     rafael@kernel.org, linux-kernel@vger.kernel.org,
        linux-pm@vger.kernel.org, lukasz.luba@arm.com
References: <20210312130411.29833-1-daniel.lezcano@linaro.org>
 <20210312130411.29833-2-daniel.lezcano@linaro.org>
 <YF8qIw4UBLnj9TCA@kroah.com>
 <433ec4ac-a7a9-ecf9-f1c1-f658d279a2df@linaro.org>
 <YGAnRx8SiZHFPpY6@kroah.com>
 <7df276d1-abea-622c-2c7e-2c5e412aa4a9@linaro.org>
 <YGBng8D+nPS4/LJO@kroah.com>
 <7ba5094b-7fac-72ff-0e52-6f60eb86f253@linaro.org>
 <YGC8Yj9OTgc4aU0y@kroah.com>
From:   Daniel Lezcano <daniel.lezcano@linaro.org>
Message-ID: <35b543d1-5559-b814-11b0-8a53c1218750@linaro.org>
Date:   Sun, 28 Mar 2021 20:01:54 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
MIME-Version: 1.0
In-Reply-To: <YGC8Yj9OTgc4aU0y@kroah.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

On 28/03/2021 19:26, Greg KH wrote:

[ ... ]

>>> So why are you trying to add a kref here as the structure already has
>>> support for proper lifetimes?
>>
>> Right, I'll revisit that part. Thanks for the review.
>>
>> I've a branch which is pulled by Rafael [1]. These parts are already
>> merged in the dtpm/next branch but not yet in Rafael's tree.
> 
> I would recommend fixing that up if you can rebase it.  If not, you need
> to revert it and start over.  I'll be glad to review it if you cc: me on
> the patches.
> 
>> I think a rebase is possible but I would like to avoid that. Would be a
>> patch on top of the dtpm/next acceptable given your flow with Android ?
> 
> This has nothing to do with the Android kernel workflow, sorry.  I am
> concerned about proper kernel development and keeping bugs out of it.


Fair enough, I will fix it up and send a v5.

Thanks

  -- Daniel


-- 
<http://www.linaro.org/> Linaro.org │ Open source software for ARM SoCs

Follow Linaro:  <http://www.facebook.com/pages/Linaro> Facebook |
<http://twitter.com/#!/linaroorg> Twitter |
<http://www.linaro.org/linaro-blog/> Blog
