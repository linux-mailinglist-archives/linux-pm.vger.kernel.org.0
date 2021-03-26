Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 74F7334AFF1
	for <lists+linux-pm@lfdr.de>; Fri, 26 Mar 2021 21:14:22 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230003AbhCZUNt (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Fri, 26 Mar 2021 16:13:49 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41340 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229957AbhCZUNS (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Fri, 26 Mar 2021 16:13:18 -0400
Received: from mail-il1-x12c.google.com (mail-il1-x12c.google.com [IPv6:2607:f8b0:4864:20::12c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 53C36C0613AA
        for <linux-pm@vger.kernel.org>; Fri, 26 Mar 2021 13:13:18 -0700 (PDT)
Received: by mail-il1-x12c.google.com with SMTP id w2so5578349ilj.12
        for <linux-pm@vger.kernel.org>; Fri, 26 Mar 2021 13:13:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linuxfoundation.org; s=google;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=VZSKNGzGJ60Qyb0f+51PLhvKxGH2rZp6nAQ6/LNBPVA=;
        b=gu6+We8rlAiWth1r7aBhadigDi6vEJyBTG8Eb1XckLfVrjH8TLtxXrmm+WillkipeO
         N9JFST0RhJDni2fMTz1C0GCU1SCaoqxZ9e0U+oQw9HXSoD4GmnyMDsNUh5lRmXBidhrJ
         bh7cPeu+t1mGe2YGSYaogmLpGVauL5K3u3NGY=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=VZSKNGzGJ60Qyb0f+51PLhvKxGH2rZp6nAQ6/LNBPVA=;
        b=czc1/s6bWZu4AxL6KzGRug0SVk0iy3jv81cFZKjGDa/QwjrfiGG/IsUSLaPZbew77M
         Ww/V2Uk+C2XYk/fsN3Eq7dlhWT7x+ke9gz6OKAzeRXApt6VhPb45d1VDfyFCQatSqqUb
         2GVfMMJItmTzDq4FicgcuzCe5PzMTH5lefH3CjIsYgxN171QXnuB1ja4Pg2mZC10zED7
         TPljk1FdEV9KCTZi3JHybuVA4L+AYWN/Am35JcdHVyXjk655m6ccUWfOlEAo0JT4UGXI
         0zVl9O9Uo2A9/2Nt1luhaOY5WQ+4iwrbsR2CItCxnC1znzMRANoaXsBLqJyuOBV2BumR
         ayNA==
X-Gm-Message-State: AOAM530sg6plntHy+lGIHDhKlcbveJrGluM5SMCf0Av+ihK61Ec/C6L9
        gI2iJ8ZVP5eV0eHAYSfycfieag==
X-Google-Smtp-Source: ABdhPJzt8drO79fpapEss5lHXWrwLEVtc4MvNRIPcKaH4x2ayc2/H0bRpRqZ49xfVlzxaNJqiF8Zng==
X-Received: by 2002:a05:6e02:13ad:: with SMTP id h13mr11959183ilo.32.1616789597805;
        Fri, 26 Mar 2021 13:13:17 -0700 (PDT)
Received: from [192.168.1.112] (c-24-9-64-241.hsd1.co.comcast.net. [24.9.64.241])
        by smtp.gmail.com with ESMTPSA id d1sm4864822ils.49.2021.03.26.13.13.16
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 26 Mar 2021 13:13:17 -0700 (PDT)
Subject: Re: [PATCH 2/2] cpupower: fix amd cpu (family >= 0x17) active state
 issue
To:     xufuhai <xufuhai1992@gmail.com>, linux@dominikbrodowski.net,
        sherry.hurwitz@amd.com, trenn@suse.com, linux-pm@vger.kernel.org
Cc:     lishujin@kuaishou.com, Shuah Khan <skhan@linuxfoundation.org>
References: <e3f8c0f1-63dc-9b25-7129-d0a4ee87f62a@gmail.com>
From:   Shuah Khan <skhan@linuxfoundation.org>
Message-ID: <c85e7ec8-0fef-fbb1-772b-4144774353e1@linuxfoundation.org>
Date:   Fri, 26 Mar 2021 14:13:15 -0600
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.7.1
MIME-Version: 1.0
In-Reply-To: <e3f8c0f1-63dc-9b25-7129-d0a4ee87f62a@gmail.com>
Content-Type: text/plain; charset=gbk; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

On 3/24/21 4:28 AM, xufuhai wrote:
> From: xufuhai <xufuhai@kuaishou.com>
> 
> If the read_msr function is executed by a non-root user, the function
> returns -1, which means that there is no permission to access /dev/cpu/%d/msr,
> but cpufreq_has_boost_support should also return -1 immediately, and should not
> follow the original logic to return 0, which will cause amd The cpupower tool
> returns the turbo active status as 0.
> 
> Reproduce procedure:
>          cpupower frequency-info
> 

Please run get_maintainer.pl and send patch maintainers
and others suggested by the tool. I don't see this in my
Inbox for me to review/accept and send it to pm maintainer.

Please include before and after the patch when you run
cpupower frequency-info

thanks,
-- Shuah

