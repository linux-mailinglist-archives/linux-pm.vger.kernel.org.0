Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B38F836A43B
	for <lists+linux-pm@lfdr.de>; Sun, 25 Apr 2021 04:42:03 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229592AbhDYCml (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Sat, 24 Apr 2021 22:42:41 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59210 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229580AbhDYCmk (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Sat, 24 Apr 2021 22:42:40 -0400
Received: from mail-pj1-x1031.google.com (mail-pj1-x1031.google.com [IPv6:2607:f8b0:4864:20::1031])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 06615C061574;
        Sat, 24 Apr 2021 19:42:01 -0700 (PDT)
Received: by mail-pj1-x1031.google.com with SMTP id u11so21419947pjr.0;
        Sat, 24 Apr 2021 19:42:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-transfer-encoding;
        bh=+SCTdclT0hokdrzYrWlRFY0qufMkTB7i1ku1nmB//ro=;
        b=HUDxu27MuN3huR1BrhjumYWPiC/G95/QWWEFcF2t0vG6Shslkbp/O3gY2TvHKtwejy
         zj7dvHggbast1op9n6+wCTNIlA1/2/OTIRypLY9JKAQtRYPp4Rf23WeR8w1QpHgI9xN3
         FuZi00lg3Ftq8n+8nR1aQ1g8WCdaU3QWRcDheTZagQY2r13w4b7A8ZRFSdPNYu+U+5vF
         py5Hx7DrEV0eO3FcFHmJ3kapaP4vrZ2t465Too1fauHymZuEa2VSi0S+BrFT4ZVd/1ut
         DiijwNa2quFXq6olXoaVyvNuDig87qj0gJ6/Swn2q6TR9Vt7NTr+ZEC2wlKqeScfbqNo
         ukuA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-transfer-encoding;
        bh=+SCTdclT0hokdrzYrWlRFY0qufMkTB7i1ku1nmB//ro=;
        b=a0/0e/Bt1/E7ln31IH9xdBCe/4tES6cy/vFzEUliADwpUZCulBrlpag3mkJOw7sf5O
         PbXPyWLE7A19y9d93MbT4nDnGmgdbVFixrxiKk6IzCM04kupk277tN791hSCQJm4j2Kp
         h2XV0MGduIqpr5zhMC9sjMKpOWvG+OTBfn+rNLthosyICzArg2EPFxLZjE+9vfUfbN8x
         otXYpiErX7ve278EMW1al/egYGP3/ZxbXPatF16MIqjqBTpIpSRHXhaAPCMOLYA9WswD
         PbKpZS2EcJFG3gzI+1pZvmBBPrqiC46YT+61qc9SQvog0LI6mTFSoWY9qTtVNSuQfu5d
         wtgw==
X-Gm-Message-State: AOAM5332f8VeB/Nuv8IykGJq2m9+5skV++piUMcvxP2pEkzGGJBnZFER
        8ZPyrgYRMMdQjYSqX76mguA=
X-Google-Smtp-Source: ABdhPJxNNvBlAGs4C5zdDZSd9HX8tXl4eVujm64KPKFUFBzRn/4ZViNa9tDkrTVVCZKrmfA+nP6IlQ==
X-Received: by 2002:a17:90a:6f45:: with SMTP id d63mr14256329pjk.39.1619318521481;
        Sat, 24 Apr 2021 19:42:01 -0700 (PDT)
Received: from MacBook-Pro.local ([122.10.101.135])
        by smtp.gmail.com with ESMTPSA id f20sm8138627pgb.47.2021.04.24.19.41.58
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sat, 24 Apr 2021 19:42:00 -0700 (PDT)
Subject: Re: [PATCH 1/2] cpupower: Fix amd cpu (family < 0x17) active state
 issue
To:     Shuah Khan <skhan@linuxfoundation.org>, shuah@kernel.org,
        Thomas Renninger <trenn@suse.com>
Cc:     linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org,
        lishujin@kuaishou.com, xufuhai <xufuhai@kuaishou.com>
References: <bf312780-dda7-d08f-6098-1d8a7d4044e4@gmail.com>
 <378e58d3-5300-1179-44bb-bc2b42a3beb0@gmail.com>
 <87e43451-e7d3-877e-7081-92838ae699e6@linuxfoundation.org>
From:   =?UTF-8?B?5b6Q56aP5rW3?= <xufuhai1992@gmail.com>
Message-ID: <a7418aab-847f-3c06-ddc4-3c6aaea90b7c@gmail.com>
Date:   Sun, 25 Apr 2021 10:41:40 +0800
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:78.0)
 Gecko/20100101 Thunderbird/78.9.1
MIME-Version: 1.0
In-Reply-To: <87e43451-e7d3-877e-7081-92838ae699e6@linuxfoundation.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

okay, I believe the two patches are for fixing defferent issue, I will update my patches as your mention

THANKS

在 2021/4/24 上午6:26, Shuah Khan 写道:
> On 4/19/21 8:27 PM, 徐福海 wrote:
>> From: xufuhai<xufuhai@kuaishou.com>
>>
>> For the old  AMD processor (family < 0x17), cpupower will call the
>> amd_pci_get_num_boost_states function, but for the non-root user
>> pci_read_byte function (implementation comes from the psutil library),
>> val will be set to 0xff, indicating that there is no read function
>> callback. At this time, the original logic will set the cpupower turbo
>> active state to yes. This is an obvious issue~
>>
>> Reproduce procedure:
>>     cpupower frequency-info
>>
>> Reported-by: yangrui<yangrui@kuaishou.com>
>> Signed-off-by: xufuhai<xufuhai@kuaishou.com>
>
> Also your Signed-off-by should match the from address.
> There is a mismatch between the two.
>
>> Signed-off-by: chenguanqiao<chenguanqiao@kuaishou.com>
>> Signed-off-by: lishujin<lishujin@kuaishou.com>
>> Reviewed-by: Thomas Renninger<trenn@suse.com>
>> ---
>>   tools/power/cpupower/utils/helpers/amd.c | 7 +++++++
>>   1 file changed, 7 insertions(+)
>>
>> diff --git a/tools/power/cpupower/utils/helpers/amd.c b/tools/power/cpupower/utils/helpers/amd.c
>> index 97f2c857048e..6f9504906afa 100644
>> --- a/tools/power/cpupower/utils/helpers/amd.c
>> +++ b/tools/power/cpupower/utils/helpers/amd.c
>> @@ -137,6 +137,13 @@ int amd_pci_get_num_boost_states(int *active, int *states)
>>           return -ENODEV;
>>         val = pci_read_byte(device, 0x15c);
>> +
>> +    /* If val is 0xff, meaning has no permisson to
>> +     * get the boost states, return -1
>> +     */
>> +    if (val == 0xff)
>> +        return -1;
>> +
>>       if (val & 3)
>>           *active = 1;
>>       else
>> -- 
>> 2.24.3 (Apple Git-128)
>>
>
> I am seeing two patches with the same commit summary,
> should these two be a singles patch?
>
> https://patchwork.kernel.org/project/linux-pm/patch/6e35df20-753a-6c9c-8786-3fc87cdd17ba@gmail.com/
>
> Please combine the two and send single patch if they fix the
> same problem. If not, please change the commit log to reflect
> the difference.
>
> thanks,
> -- Shuah
>
>
