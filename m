Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0B6BE24C630
	for <lists+linux-pm@lfdr.de>; Thu, 20 Aug 2020 21:11:54 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726132AbgHTTLw (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Thu, 20 Aug 2020 15:11:52 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34118 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725823AbgHTTLv (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Thu, 20 Aug 2020 15:11:51 -0400
Received: from mail-ot1-x32b.google.com (mail-ot1-x32b.google.com [IPv6:2607:f8b0:4864:20::32b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 03101C061385
        for <linux-pm@vger.kernel.org>; Thu, 20 Aug 2020 12:11:50 -0700 (PDT)
Received: by mail-ot1-x32b.google.com with SMTP id v6so2342545ota.13
        for <linux-pm@vger.kernel.org>; Thu, 20 Aug 2020 12:11:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linuxfoundation.org; s=google;
        h=subject:to:references:cc:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=0s3T2ISMB3z3CBSCBynyLvh3qAUZ+j3gQbjXPZY8cmw=;
        b=R6AGFm7YTP/LI83fcw9X30B0vAGORqbL91L3O8KmpVlVTR0ieWKNX4Jxsep15zFexK
         Fdcib3TTVfYczV2nevNioYpnGfEwLrjGBCOPUy0zK1oqLkGvacA5GywxAc9UgOBLCFJO
         4SD4WJRs+vIdhdCetL2rnCpz1BU+uxlpztMu8=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:references:cc:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=0s3T2ISMB3z3CBSCBynyLvh3qAUZ+j3gQbjXPZY8cmw=;
        b=Yt3hm2wtsfBpChkdyD6bIidWb9LH7ofk3vM7JNQWrxEANOOAgVhqEzX65x9JIOWP9g
         pAq8V1nxD0aI92shv1E5vAdKUCik11oVrOxJQXeYfYTHCTvyKcTw5cstcbMJ7VQXRe+h
         g5+2nE4C29r+fp3A+2+9FvoSha0H/s1VIZsWNLZD2LuhCpwigrWZR9wmkypU9X3V6Kf+
         PIq/i3kNIM9VxbTBzzpOSCae94QrLORa5pjEMlNDseEEIzLmXwlVNcZx84eVRnjGW97b
         Gh473bZLZzZUUmiFr+5jZZd25lWCsJliTMZbPbujBVzNu9pHChSHWhiNXw4jjsXJ6PBf
         Srzg==
X-Gm-Message-State: AOAM530God2WPe4U1rsWiXoQll6OE/royQ/ZZ1SktAckDIqokrWuZmw4
        Cj+9RwEpWNagjv5KESaMxwmLAw==
X-Google-Smtp-Source: ABdhPJzCB0nDGgD2ziFq+PqmK4aAaUNIr21mWoILm+cKHgLONNVzpz4wIXZSblHu0ZKcaiTfQeWSLA==
X-Received: by 2002:a05:6830:310b:: with SMTP id b11mr81055ots.71.1597950709339;
        Thu, 20 Aug 2020 12:11:49 -0700 (PDT)
Received: from [192.168.1.112] (c-24-9-64-241.hsd1.co.comcast.net. [24.9.64.241])
        by smtp.gmail.com with ESMTPSA id y15sm636706oto.60.2020.08.20.12.11.48
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 20 Aug 2020 12:11:48 -0700 (PDT)
Subject: Re: [PATCH] cpupower: Replace HTTP links with HTTPS ones
To:     Thomas Renninger <trenn@suse.com>, shuah@kernel.org,
        linux-pm@vger.kernel.org,
        "Alexander A. Klimov" <grandmaster@al2klimov.de>
References: <20200713110511.33549-1-grandmaster@al2klimov.de>
 <7169450.1KdEUtMQry@c100>
Cc:     Shuah Khan <skhan@linuxfoundation.org>
From:   Shuah Khan <skhan@linuxfoundation.org>
Message-ID: <03bde172-814c-5e4f-ffae-b41c2706d2c3@linuxfoundation.org>
Date:   Thu, 20 Aug 2020 13:11:47 -0600
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
MIME-Version: 1.0
In-Reply-To: <7169450.1KdEUtMQry@c100>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

On 8/20/20 4:26 AM, Thomas Renninger wrote:
> Am Montag, 13. Juli 2020, 13:05:11 CEST schrieb Alexander A. Klimov:
>>   .SH REFERENCES
>>   "BIOS and Kernel Developer’s Guide (BKDG) for AMD Family 14h Processors"
>> -http://support.amd.com/us/Processor_TechDocs/43170.pdf
>> +https://support.amd.com/us/Processor_TechDocs/43170.pdf
>>
>>   "Intel® Turbo Boost Technology
>>   in Intel® Core™ Microarchitecture (Nehalem) Based Processors"
>> @@ -178,7 +178,7 @@
>> http://download.intel.com/design/processor/applnots/320354.pdf
>>
>>   "Intel® 64 and IA-32 Architectures Software Developer's Manual
>>   Volume 3B: System Programming Guide"
>> -http://www.intel.com/products/processor/manuals
>> +https://www.intel.com/products/processor/manuals
> 
> The 2 above https:// links are still valid.
> 
> No idea it's worth replacing. If this is checked and done through the whole
> kernel, then I agree that it would be nice if Shuah picks it up...
> 

Thanks. It made it into Linux 5.9-rc1.

thanks,
-- Shuah
