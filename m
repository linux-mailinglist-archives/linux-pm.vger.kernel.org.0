Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1061134B923
	for <lists+linux-pm@lfdr.de>; Sat, 27 Mar 2021 20:42:17 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230114AbhC0Tlm (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Sat, 27 Mar 2021 15:41:42 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59096 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230015AbhC0Tl2 (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Sat, 27 Mar 2021 15:41:28 -0400
Received: from mail-wr1-x435.google.com (mail-wr1-x435.google.com [IPv6:2a00:1450:4864:20::435])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E6D7AC0613B2
        for <linux-pm@vger.kernel.org>; Sat, 27 Mar 2021 12:41:27 -0700 (PDT)
Received: by mail-wr1-x435.google.com with SMTP id c8so8828329wrq.11
        for <linux-pm@vger.kernel.org>; Sat, 27 Mar 2021 12:41:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=ijT/RGW2Oruf35uIX4P52vJI8Z11oGvR31aKC7kUzBY=;
        b=nzxoKcrUAkF+l/1YTJ2iBy24d7u1ggVNPgLL4wlwSkwGy0pXFnkhQfEOGvu/6z+cUj
         BnNTD9CNiE5EHRGLz6Qm74077pX59q1I4fM+uj4CCzaMrLF99cqYHz4xyBFC6z2ahYkv
         SjD+UUg6MfT7NXTlT08WvRByF2/9CVXBbtRA8wqvoeDHB7qGHnWep5g4+HNN+9dsZLNw
         3+tGCgiTXGNCBcvhYJ8R+9zmFL2ZDHCYz25qy5ajppb8768SW9Z5drJ/GtIPPZ4c6/xU
         Sk3+CQ5VzkbT84pLzqiRn2cJuBi/Xal5qOzLbFSxbj0ZXI7ydxvoOerz/YLu4DsSsjdO
         FvkQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=ijT/RGW2Oruf35uIX4P52vJI8Z11oGvR31aKC7kUzBY=;
        b=VNkNT42N1e0RXr7JtiCWjrF9dB23VbB7we5RASG31rrRRwP3f5AwZPTwHuMIpdEQRG
         NWEWSgaaf5ZGh/lWiXT8U0icLlBzqrsIc9ufTtou+EtOT/WRkb9gYqqUgW473m+b96f2
         ABuWtVV1z256YvKnqtHiDA1a69P/P6/Ebfj8eTgtZE1CX/MHD+ihUFbKG9NAtohM67Rw
         /xNT+W+F5+pfZUzIGI/BYq3K2wK/gQwW9ibd/SXomcmK97281mxF4PUTGIjk5PJhQRom
         Ifrpi2u1qicowaAd8E26QM0pcbFaXdsFvy1VLIFwKZAHGekS2mMCrZrLDrkGIjEBlkBN
         YTvg==
X-Gm-Message-State: AOAM530qH4ehMzBQhMvL7U9qLXr9Dki7Y8cKAay4uKN5L20lIdWofkVf
        2sFtpQurSZCR3HnGh1POoACk9w==
X-Google-Smtp-Source: ABdhPJzEzxZyBR1DY3Q5pHHVrjiQBXLW3ok1jhaSsQsJaiVqRb+qLmrJJTUQkyzklSXRZWONzBdJvg==
X-Received: by 2002:a5d:4443:: with SMTP id x3mr20773159wrr.49.1616874086050;
        Sat, 27 Mar 2021 12:41:26 -0700 (PDT)
Received: from ?IPv6:2a01:e34:ed2f:f020:2d8b:2e0e:777b:e562? ([2a01:e34:ed2f:f020:2d8b:2e0e:777b:e562])
        by smtp.googlemail.com with ESMTPSA id i8sm19202067wrx.43.2021.03.27.12.41.25
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sat, 27 Mar 2021 12:41:25 -0700 (PDT)
Subject: Re: [PATCH v4 2/5] powercap/drivers/dtpm: Create a registering system
To:     Greg KH <gregkh@linuxfoundation.org>
Cc:     rafael@kernel.org, linux-kernel@vger.kernel.org,
        linux-pm@vger.kernel.org, lukasz.luba@arm.com
References: <20210312130411.29833-1-daniel.lezcano@linaro.org>
 <20210312130411.29833-2-daniel.lezcano@linaro.org>
 <YF8qIw4UBLnj9TCA@kroah.com>
From:   Daniel Lezcano <daniel.lezcano@linaro.org>
Message-ID: <433ec4ac-a7a9-ecf9-f1c1-f658d279a2df@linaro.org>
Date:   Sat, 27 Mar 2021 20:41:24 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
MIME-Version: 1.0
In-Reply-To: <YF8qIw4UBLnj9TCA@kroah.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

On 27/03/2021 13:50, Greg KH wrote:
> On Fri, Mar 12, 2021 at 02:04:08PM +0100, Daniel Lezcano wrote:
>> A SoC can be differently structured depending on the platform and the
>> kernel can not be aware of all the combinations, as well as the
>> specific tweaks for a particular board.
>>
>> The creation of the hierarchy must be delegated to userspace.
>>
>> These changes provide a registering mechanism where the different
>> subsystems will initialize their dtpm backends and register with a
>> name the dtpm node in a list.
>>
>> The next changes will provide an userspace interface to create
>> hierarchically the different nodes. Those will be created by name and
>> found via the list filled by the different subsystem.
>>
>> If a specified name is not found in the list, it is assumed to be a
>> virtual node which will have children and the default is to allocate
>> such node.
>>
>> When the node register in the list, the function will be dtpm_register
>> where the previous semantic was to create the node. Thus, the
>> functions are renamed to reflect their purpose.
>>
>> Signed-off-by: Daniel Lezcano <daniel.lezcano@linaro.org>
>> Reviewed-by: Lukasz Luba <lukasz.luba@arm.com>
>> ---

[ ... ]

>> +static void dtpm_release(struct kref *kref)
>> +{
>> +	struct dtpm *dtpm = container_of(kref, struct dtpm, kref);
>> +
>> +	kfree(dtpm);
>> +}
>> +
>> +/**
>> + * dtpm_put - Release a reference on a dtpm device
>> + * @dtpm: a pointer to a dtpm structure
>> + *
>> + * Release the reference on the specified dtpm device. The last
>> + * reference leads to a memory release.
>> + */
>> +void dtpm_put(struct dtpm *dtpm)
>> +{
>> +	kref_put(&dtpm->kref, dtpm_release);
> 
> You forgot to also grab the dtpm_lock before calling this, right?  What
> is preventing a get and put from being called at the same time?
> 
> You protect things at get time, but not put from what I can see :(

Thanks for spotting this, I will send a fix for that.

[ ... ]

>> +	list_add(&node->node, &dtpm_list);
>> +
>> +	pr_info("Registered %s\n", name);
> 
> When kernel code works properly, it is quiet.  This is debugging code a
> the most, never something that everyone should be seeing all the time,
> please remove.

Initially, a comment asked for debug traces in the code. There are more
traces in the code at the pr_debug level.

Is your suggestion to remove the pr_info as well as other debug traces
or convert those pr_info to pr_debug ?

[ ... ]

> And any reason why you are not using "real" struct devices in this
> subsystem?  You seem to be rolling your own infrastructure for no good
> reason.  I imagine you want sysfs support next, right?

Actually, the framework is on top of powercap, so it has de facto the
sysfs support. On the other side, the dtpm backends are tied with the
device they manage.



-- 
<http://www.linaro.org/> Linaro.org │ Open source software for ARM SoCs

Follow Linaro:  <http://www.facebook.com/pages/Linaro> Facebook |
<http://twitter.com/#!/linaroorg> Twitter |
<http://www.linaro.org/linaro-blog/> Blog
