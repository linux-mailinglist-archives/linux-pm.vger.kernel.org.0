Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A6913300AB4
	for <lists+linux-pm@lfdr.de>; Fri, 22 Jan 2021 19:11:20 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728621AbhAVSGh (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Fri, 22 Jan 2021 13:06:37 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41770 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730069AbhAVSDk (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Fri, 22 Jan 2021 13:03:40 -0500
Received: from mail-io1-xd2f.google.com (mail-io1-xd2f.google.com [IPv6:2607:f8b0:4864:20::d2f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6542EC061786
        for <linux-pm@vger.kernel.org>; Fri, 22 Jan 2021 10:02:57 -0800 (PST)
Received: by mail-io1-xd2f.google.com with SMTP id d13so12882703ioy.4
        for <linux-pm@vger.kernel.org>; Fri, 22 Jan 2021 10:02:57 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linuxfoundation.org; s=google;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=RRWXLiLmWBuI4fm8U4nRI+wvAHxIFj8otqT2qPE+lVA=;
        b=KKgfMov5OTn3k0tB49pciUTQMR/L5WzZ8mE7acRHffo48nFOCEBOW2gsq+Q+GC1CAc
         7bPsob0ALvRdGVzrvx7/z3pp7OcMeaCiBp0drxvzsV9tQkPwh4qRwcc2dU3Nkl2d2v9/
         9XvDCoP3jA1UV3WOM9JS/zQeaGqMOFeT/XPZ8=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=RRWXLiLmWBuI4fm8U4nRI+wvAHxIFj8otqT2qPE+lVA=;
        b=gs+WMQO71zwh/d/J2ZZkINWpvlAVBw15spAmdfQWj7SxC7FVZpDnPZ/5hBwItLz63U
         lR6+9Q9XepaVGagsR7KaTgFJ27GecbQHcvD+maxnyFSkKithbCH0az81KcKW4vxO/NdV
         dszTLCybU1AYEFDHljwuKhibfKu6Mo12+xArem8/lM6gyVpxUBtzCefSeDJxVsD95IJi
         rdyqWQM9dmfk5vcUMqUuzchvvT2ksVJjKqxxji1bOFRqDXZHFc1Vzm/4A7XQzzykkPls
         hv4Ood8RyTvcBHfEWmDZDKfFB4fXaPLTLbYbniCNnjNn0UmJFs86FQCTGMVSMHI1rzHk
         leFQ==
X-Gm-Message-State: AOAM5319zyOjwNUMcnzB3dT+WpZAYDfg4ZTtXjkGZTE1aw473vJVSVOl
        wC6savgZYPTMU5/bUb8B9dDdBg==
X-Google-Smtp-Source: ABdhPJymy8tkKYYNiNvhlCKIuwYm6Hj2ZhHWZEJI2Wrsc5RbxREh1wCzSuUjQcqsOuLS/M1oRFCEzg==
X-Received: by 2002:a92:c56b:: with SMTP id b11mr1643583ilj.167.1611338576760;
        Fri, 22 Jan 2021 10:02:56 -0800 (PST)
Received: from [192.168.1.112] (c-24-9-64-241.hsd1.co.comcast.net. [24.9.64.241])
        by smtp.gmail.com with ESMTPSA id f13sm5935980iog.18.2021.01.22.10.02.55
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 22 Jan 2021 10:02:55 -0800 (PST)
Subject: Re: [PATCH] cpupower: add Makefile dependencies for install targets
To:     Thomas Renninger <trenn@suse.com>,
        Ivan Babrou <ivan@cloudflare.com>
Cc:     linux-pm@vger.kernel.org,
        linux-kernel <linux-kernel@vger.kernel.org>,
        kernel-team <kernel-team@cloudflare.com>,
        Shuah Khan <shuah@kernel.org>, rafael@kernel.org,
        Shuah Khan <skhan@linuxfoundation.org>
References: <20210104235719.13525-1-ivan@cloudflare.com>
 <3977966.bfq5YHlNPR@c100>
 <CABWYdi3yOYrLq_Zo2qrvFVZtwhbS85zWbt2+by0Fm6D3S17ZQw@mail.gmail.com>
 <2142020.VHZ5RWNYVy@c100>
From:   Shuah Khan <skhan@linuxfoundation.org>
Message-ID: <356b4879-f633-44fc-59ad-69be6c2f9a92@linuxfoundation.org>
Date:   Fri, 22 Jan 2021 11:02:55 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.5.0
MIME-Version: 1.0
In-Reply-To: <2142020.VHZ5RWNYVy@c100>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

On 1/7/21 2:29 PM, Thomas Renninger wrote:
> Am Donnerstag, 7. Januar 2021, 22:15:16 CET schrieb Ivan Babrou:
>> On Thu, Jan 7, 2021 at 12:59 PM Thomas Renninger <trenn@suse.com> wrote:
>>> Am Donnerstag, 7. Januar 2021, 18:42:25 CET schrieb Ivan Babrou:
>>>> On Thu, Jan 7, 2021 at 2:07 AM Thomas Renninger <trenn@suse.com> wrote:
>>>>> Am Dienstag, 5. Januar 2021, 00:57:18 CET schrieb Ivan Babrou:
>>>>>> This allows building cpupower in parallel rather than serially.
> ...
>>> Can you please show the make calls, ideally with a timing to better
>>> understand and also to reproduce the advantages this patch introduces.
>>>  From what I can see, it only helps if one calls "sub-install" targets
>>> directly?
>>
>> That's exactly what we do: make install directly:
>>
>> /linux-5.10.5$ make -C ./tools/power/cpupower DESTDIR=/tmp/cpupower
>> install -j $(nproc)
> 
> This makes sense then.
> @Shuah @Rafael: Can this patch be queued up, please.
> 
> Thanks for the patch and the details,
> 

Thank you both.

I applied it 
https://git.kernel.org/pub/scm/linux/kernel/git/shuah/linux.git/commit/?h=cpupower

Will send this in my next pull request to Rafael.

thanks,
-- Shuah
