Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 41F54221847
	for <lists+linux-pm@lfdr.de>; Thu, 16 Jul 2020 01:13:12 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726941AbgGOXNL (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Wed, 15 Jul 2020 19:13:11 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47580 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726778AbgGOXNL (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Wed, 15 Jul 2020 19:13:11 -0400
Received: from mail-qk1-x743.google.com (mail-qk1-x743.google.com [IPv6:2607:f8b0:4864:20::743])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E4804C061755
        for <linux-pm@vger.kernel.org>; Wed, 15 Jul 2020 16:13:10 -0700 (PDT)
Received: by mail-qk1-x743.google.com with SMTP id l6so3678101qkc.6
        for <linux-pm@vger.kernel.org>; Wed, 15 Jul 2020 16:13:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=vAehlSiMXOBCPl2Wze087kwOurzcuZOvn7IQRZzFikA=;
        b=JiuD8YFqFvnmHOANaz54QgP0xf5g9vCr6TrkO7SwhU4atcBVlXcC9PAv+zepmyi7io
         El06x5r7w14+Ax+DURpDvK4pIPmZPSrfc8xb0unaS3EpJl8p96f4tx5PVGgThhzrblfF
         QFyHm1DiRVQAgEGdBjWowRsR0lhPVCj1tueD3q82qLTWkgCJPro08Jp7Y2xc2vZPH9zN
         yJ0EDiSov7q0EwN6K81zJY9XwzdVpF4VkSt2nQ0z+fll5dBolw2RAKxL0Pqbk4YV2+5D
         Z3hve+BvRo9I1Rlwg53Xa92dBr/wLgAg5UN89r7LhHFK4oJAbWMHcAcUzdiv5N8xPlWJ
         FcQg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=vAehlSiMXOBCPl2Wze087kwOurzcuZOvn7IQRZzFikA=;
        b=M6y1Tk3oW5WJWVaETUIa8vMvJUQkSGAHCGsQgHotSdKjYgLLOvOs3D6Pby+0st9y0+
         pSCbUEHVmfJ/P5I/Ee8QVNG5VKVat+44VDO1k8feJeRcZ8YKOc+UZ3t0uVzy8GCAN24u
         4Bn1+J3aiiMAXo49LH4rnoj4cm4H8IcEoH5EnGME62+XXWMtTCknYDkSdnudSLsiEjxj
         IaC3T1SRMzj9Ee5y819cWoVHoXz2qrFKeBVvO+gAyFPGRTKO7Y1CGDhjcivzNdReQqlf
         jATQgrTyFNxVav/G3YXXHS1aqlZWrcAJ4du/DgiB3vlwjOAGeMZ/LkSEzqEnp5d/OD05
         vGUA==
X-Gm-Message-State: AOAM533ixWC0sg3ltrp07XITwlpppnL+kEbmiqSTa1ikNLaMW5UIf3OL
        iVMS/O0kkngbYk4pIwC5YoE/Dw==
X-Google-Smtp-Source: ABdhPJxZ6l+FRJikK5oRIE1iuRzwQaeFAf5CQjSwrXbnAa5rSaFlH93xrFhXfS2XG+jV25NHNcAVig==
X-Received: by 2002:a37:b58:: with SMTP id 85mr1435240qkl.26.1594854789870;
        Wed, 15 Jul 2020 16:13:09 -0700 (PDT)
Received: from [192.168.1.92] (pool-71-255-246-27.washdc.fios.verizon.net. [71.255.246.27])
        by smtp.gmail.com with ESMTPSA id v28sm4059355qkv.31.2020.07.15.16.13.08
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 15 Jul 2020 16:13:08 -0700 (PDT)
Subject: Re: [RFC PATCH 4/4] thermal: Modify thermal governors to do nothing
 for "cold" trip points
To:     Zhang Rui <rui.zhang@intel.com>, daniel.lezcano@linaro.org,
        robh+dt@kernel.org
Cc:     linux-pm@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
References: <20200710135154.181454-1-thara.gopinath@linaro.org>
 <20200710135154.181454-5-thara.gopinath@linaro.org>
 <d2eeca29328a87433a46c35947ffb490d49c168a.camel@intel.com>
From:   Thara Gopinath <thara.gopinath@linaro.org>
Message-ID: <5c9eec96-79b6-3499-fe06-7312504ffc4a@linaro.org>
Date:   Wed, 15 Jul 2020 19:13:08 -0400
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.8.0
MIME-Version: 1.0
In-Reply-To: <d2eeca29328a87433a46c35947ffb490d49c168a.camel@intel.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org



On 7/15/20 4:35 AM, Zhang Rui wrote:
> On Fri, 2020-07-10 at 09:51 -0400, Thara Gopinath wrote:
>> For now, thermal governors do not support monitoring of falling
>> temperature. Hence, in case of calls to the governor for trip points
>> marked
>> as cold, return doing nothing.
>>
>> Signed-off-by: Thara Gopinath <thara.gopinath@linaro.org>
>> ---
>>   drivers/thermal/gov_bang_bang.c       | 8 ++++++++
>>   drivers/thermal/gov_fair_share.c      | 8 ++++++++
>>   drivers/thermal/gov_power_allocator.c | 8 ++++++++
>>   drivers/thermal/gov_step_wise.c       | 8 ++++++++
>>   4 files changed, 32 insertions(+)
> 
> userspace governor does not support cold trip point neither.
> 
> So how about adding the check in handle_non_critical_trips first, and
> remove the check later, after all the governors support cold trip?

Yeah, no governors support cold trip for now. Putting check in 
handle_non_critical_trips is another way to handle this. I can do it and 
come back to this solution when one or more governors start supporting 
cold trip points.


-- 
Warm Regards
Thara
