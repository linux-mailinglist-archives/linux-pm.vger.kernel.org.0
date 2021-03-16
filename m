Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A5CE533D4A9
	for <lists+linux-pm@lfdr.de>; Tue, 16 Mar 2021 14:16:16 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232042AbhCPNPo (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Tue, 16 Mar 2021 09:15:44 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35364 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231435AbhCPNPS (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Tue, 16 Mar 2021 09:15:18 -0400
Received: from mail-wr1-x42b.google.com (mail-wr1-x42b.google.com [IPv6:2a00:1450:4864:20::42b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 53CE3C06174A
        for <linux-pm@vger.kernel.org>; Tue, 16 Mar 2021 06:15:18 -0700 (PDT)
Received: by mail-wr1-x42b.google.com with SMTP id j2so10414147wrx.9
        for <linux-pm@vger.kernel.org>; Tue, 16 Mar 2021 06:15:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=qTk5N1IpkxIibwyn9bbhUralfnLiAzs7yG7ASyyW9kw=;
        b=qtreXu9j7BKmXxpIigSADC5KNdGIlXWAKszx/c0u4zPrR9zyY9zOGtI+Y5bXQMGRBP
         cBi0R3nLKr5TfYoE1mUtRCPd2096OqUq5XCJGSJx/jB1E3gk0eHA/AMbmPzuSMUdyKeR
         G4g+0uHqQVw8rIiJBpypv7hV2Vhmg6go60jfSLZrqXrk3Fn63K4TxiOSIewak0PuqTOB
         ZOwdCVyMMnEg43K0vUqUsh15YQxaGr27ivuaEO++SQN4Igv1dTUVgdaqSqVGWKw7Hex2
         pqCern2i6er1fqkMoY1y+bRziHDG0KTvyhBhjFuSPEniJyVRBwOIJ/mIhKpxCR+1WeRn
         adyQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=qTk5N1IpkxIibwyn9bbhUralfnLiAzs7yG7ASyyW9kw=;
        b=tlgCAbcX7uuzzbS4Umckzz1a4+sGZ+LmpXcSPr6iFjOY8wBq0vCVTpVOzovsvmbmou
         S2F8ri7bw17lrAplefwLhHcihw0n2s0Fgnk2+1aiPhhwLkaJ28uSF9x1SiAZi/mufw8e
         aY0lR3HY9hRmAg5OFCQ1RJ+A+Vp+Uxv5gAX7higvZpA3oOhp8kQFlPxTLbkQvOAlDGxK
         98dzR6siMD8NoNBkF2Q99AJeQjQlsm5xTijrwu7uMgIHfFura4BVC3oe8FS2TWG6PuQV
         /ZkPElsYYG+MRlRoITxD/kYUZFJgXatcUUlhbGxOkuO/rsyKD7/IV8MyCjDvs9TqRKJL
         psag==
X-Gm-Message-State: AOAM531GvfrMQZx1/8GkTWLwjSQxjjZkLbp2dul06bZqaXP1mJxQchau
        V1IYS3lGkSSdjSVqSKV8W3RDxw==
X-Google-Smtp-Source: ABdhPJyFQrQrzmwwosnMOODesI33pDMMRoLEdk6wRm8zQLVhwcWbbIhZCHARhvxNy6Om9VPt1Bud0g==
X-Received: by 2002:adf:e94a:: with SMTP id m10mr4847478wrn.55.1615900516782;
        Tue, 16 Mar 2021 06:15:16 -0700 (PDT)
Received: from ?IPv6:2a01:e34:ed2f:f020:fcf7:1d46:a8c5:fa1b? ([2a01:e34:ed2f:f020:fcf7:1d46:a8c5:fa1b])
        by smtp.googlemail.com with ESMTPSA id m17sm22591275wrx.92.2021.03.16.06.15.15
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 16 Mar 2021 06:15:16 -0700 (PDT)
Subject: Re: [PATCH] thermal: power_allocator: using round the division when
 re-divvying up power
To:     Lukasz Luba <lukasz.luba@arm.com>, gao.yunxiao6@gmail.com
Cc:     rui.zhang@intel.com, amitk@kernel.org, linux-pm@vger.kernel.org,
        linux-kernel@vger.kernel.org, orsonzhai@gmail.com,
        zhang.lyra@gmail.com, "jeson.gao" <jeson.gao@unisoc.com>
References: <1615796737-4688-1-git-send-email-gao.yunxiao6@gmail.com>
 <9c14451e-be6f-0713-4c26-8b67e1fa51a5@arm.com>
From:   Daniel Lezcano <daniel.lezcano@linaro.org>
Message-ID: <381a12bf-c917-c2c4-1915-f129221d6475@linaro.org>
Date:   Tue, 16 Mar 2021 14:15:15 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
MIME-Version: 1.0
In-Reply-To: <9c14451e-be6f-0713-4c26-8b67e1fa51a5@arm.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

On 15/03/2021 10:51, Lukasz Luba wrote:
> 
> 
> On 3/15/21 8:25 AM, gao.yunxiao6@gmail.com wrote:
>> From: "jeson.gao" <jeson.gao@unisoc.com>
>>
>> The division is used directly in re-divvying up power, the decimal
>> part will
>> be discarded, devices will get less than the extra_actor_power - 1.
>> if using round the division to make the calculation more accurate.
>>
>> For example:
>> actor0 received more than it's max_power, it has the extra_power 759
>> actor1 received less than it's max_power, it require extra_actor_power
>> 395
>> actor2 received less than it's max_power, it require extra_actor_power
>> 365
>> actor1 and actor2 require the total capped_extra_power 760
>>
>> using division in re-divvying up power
>> actor1 would actually get the extra_actor_power 394
>> actor2 would actually get the extra_actor_power 364
>>
>> if using round the division in re-divvying up power
>> actor1 would actually get the extra_actor_power 394
>> actor2 would actually get the extra_actor_power 365
>>
>> Signed-off-by: Jeson Gao <jeson.gao@unisoc.com>
>> ---

Applied, thanks

-- 
<http://www.linaro.org/> Linaro.org │ Open source software for ARM SoCs

Follow Linaro:  <http://www.facebook.com/pages/Linaro> Facebook |
<http://twitter.com/#!/linaroorg> Twitter |
<http://www.linaro.org/linaro-blog/> Blog
