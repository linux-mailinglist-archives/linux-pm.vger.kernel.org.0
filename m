Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 769334F1A6E
	for <lists+linux-pm@lfdr.de>; Mon,  4 Apr 2022 23:16:37 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1378927AbiDDVSY (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Mon, 4 Apr 2022 17:18:24 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37086 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1379014AbiDDQT7 (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Mon, 4 Apr 2022 12:19:59 -0400
Received: from mail-wm1-x32f.google.com (mail-wm1-x32f.google.com [IPv6:2a00:1450:4864:20::32f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5660331922
        for <linux-pm@vger.kernel.org>; Mon,  4 Apr 2022 09:18:03 -0700 (PDT)
Received: by mail-wm1-x32f.google.com with SMTP id k124-20020a1ca182000000b0038c9cf6e2a6so5955391wme.0
        for <linux-pm@vger.kernel.org>; Mon, 04 Apr 2022 09:18:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=message-id:date:mime-version:user-agent:subject:content-language:to
         :cc:references:from:in-reply-to:content-transfer-encoding;
        bh=YATu+tfw31GSz41b5CTKhB5HbxvgHUcP6Ebg25sVMHI=;
        b=mA0W820ViwlJyrK0ssBga0gNu7FmrwKbBiRzKR1++FD6ONeK32Nsz3ERwR+hlqgNyW
         8AfIh2spcx57WDyTwjearqZOreDolImi1mIhZL8T3x/Rhgq3ugbA+bwaopt/TxfyQX+d
         dOpBHc3hmkA13c2eg+Qx1N/dKFsFPc5UPz3Tb3RpA8bcEH/6unqRqkkt2vvjXZcvokCI
         tapKQJCDvYsl25ONAYf5FPUgAXchSpJnVjOb5HcbCDo65ScuFHBGSj88s9mF+uaiZ6ym
         nLRQ78vFeiFuOH1f3wamgEdseP6hhLtHS3uVAA7R8/4LS+HV1LBH0Naz0vsteQ/0S7mC
         zQbA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:to:cc:references:from:in-reply-to
         :content-transfer-encoding;
        bh=YATu+tfw31GSz41b5CTKhB5HbxvgHUcP6Ebg25sVMHI=;
        b=VDGeUtzfcekcoD1Qmzn0zc8hnKu+ERkfLYZvWyOYpFBQSxZVHQ+7o5hy2PF9rP7/ZV
         Nb3a/ZosBEv15HTX+naBo11ha9oq9cIGDMefZXIcObM7VOJuoUdSq3IhVkoLgS7EGTu2
         yF9WZZFg8vaED81RZp3/oYrVtdjb+6quyaJrzcdilYQgsjfgnEpaY1W/ro/Lc7kMJdJw
         DHvfjAlrWnwCgDGmJkGsfI9zKniQhTLn4ogFi4EQBu/4cy1vI/GnHoQPGbb2DSR9Svm5
         IfNJeWOK5n2NMTdqzaYzIDBQ2oxSwtE0J4iCG0/WvlwKrSffITq3E1AtORwL+c9bIwcC
         b5sA==
X-Gm-Message-State: AOAM532PtcwXDCUvnzNlejkfwERl1fHylkCu29hyWdu/vLpeDHmPJe50
        /FWPjduLvYGJZz0fsAGpCXUUHaJamn5X6A==
X-Google-Smtp-Source: ABdhPJwyBvT+oh6DiTmWDVwxmFuqBqBH+x5MSl0FCvRxTnjB5WvMT0v95hh2fzNKBWqkgfFvlx3QdA==
X-Received: by 2002:a05:600c:1910:b0:38d:1403:da8b with SMTP id j16-20020a05600c191000b0038d1403da8bmr20204357wmq.3.1649089081631;
        Mon, 04 Apr 2022 09:18:01 -0700 (PDT)
Received: from ?IPV6:2a01:e34:ed2f:f020:9cdc:22ce:6a8e:1fc8? ([2a01:e34:ed2f:f020:9cdc:22ce:6a8e:1fc8])
        by smtp.googlemail.com with ESMTPSA id i3-20020adffc03000000b0020616ee90dbsm1908053wrr.42.2022.04.04.09.18.00
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 04 Apr 2022 09:18:00 -0700 (PDT)
Message-ID: <8f1428c7-cf0e-b2cc-c898-09935a9017da@linaro.org>
Date:   Mon, 4 Apr 2022 18:17:59 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.7.0
Subject: Re: Thermal notifications without setting thermal governor to
 userspace?
Content-Language: en-US
To:     Chris Down <chris@chrisdown.name>
Cc:     linux-pm@vger.kernel.org, "Rafael J. Wysocki" <rafael@kernel.org>,
        Amit Kucheria <amitk@kernel.org>,
        Zhang Rui <rui.zhang@intel.com>,
        Guenter Roeck <linux@roeck-us.net>
References: <YkR6/KnH/f9U+2qf@chrisdown.name>
 <faf9e24f-4419-cdbb-573f-4cf2d9e506e2@linaro.org>
 <YksL8a+cINo7K/xX@chrisdown.name>
From:   Daniel Lezcano <daniel.lezcano@linaro.org>
In-Reply-To: <YksL8a+cINo7K/xX@chrisdown.name>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.7 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org


Hi Chris,

On 04/04/2022 17:17, Chris Down wrote:
> Hey Daniel,
> 
> Thanks a lot for getting back!
> 
> Daniel Lezcano writes:
>> For that it would require to setup a trip point from the firmware 
>> dedicated to userspace management along with the writable trip point 
>> kernel config option.
>>
>> On embedded systems, the trip point can be added easily in the device 
>> tree.
>>
>> You would end up with:
>>
>> - one passive trip point : writable and used by userspace
>>
>> - one passive trip point to protect the system tied with a cooling 
>> device and handled by the kernel
>>
>> - one hot trip point to notify the userspace critical is about to be 
>> reach
>>
>> - one critical trip point to reboot the system
>>
>> From the userspace, you change the trip temp to 50°C, 70°C and 90°C 
>> when crossing the way up or the way down.
>>
>> The sensor should implement the set_trip in order to program the 
>> register to fire the interrupt at the specified temperature. 
>> Otherwise, monitoring will be needed.
>>
>> On ACPI, except hacking the table and reload from the kernel I don't 
>> see how to do that.
> 
> In my case I'm dealing with "normal" desktop machines and a distribution 
> kernel, so it isn't possible to have fine grained control over the 
> kernel configuration or device tree (especially since ideally this would 
> be usable as an unprivileged user).
> 
> Is it still possible to use this in such a scenario?

Well on regular desktop, the thermal is managed under the hood by the 
firmware/hardware, few sensors are exported AFAICT. I don't think a 
thermal daemon would have a benefit on these platforms.

Anyway. The temperature is not moving so quickly with all the heat sinks 
on the desktop components usually, so monitoring the temperature with a 
pid loop and increase the sampling when getting closer to a temperature 
should be fine.

Just to clarify, userspace should not manage the thermal zones but the 
overall temperature by acting on the different heating sources' 
performance indexes.

Regarding the unprivileged access, it is not possible to act on the 
performance state of the different components for non-root users. It 
would require to setup the file capabilities for your program which is 
probably what you want.



-- 
<http://www.linaro.org/> Linaro.org │ Open source software for ARM SoCs

Follow Linaro:  <http://www.facebook.com/pages/Linaro> Facebook |
<http://twitter.com/#!/linaroorg> Twitter |
<http://www.linaro.org/linaro-blog/> Blog
