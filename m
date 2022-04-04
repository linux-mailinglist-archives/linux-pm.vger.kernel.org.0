Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C941A4F1A61
	for <lists+linux-pm@lfdr.de>; Mon,  4 Apr 2022 23:16:34 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1378921AbiDDVSX (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Mon, 4 Apr 2022 17:18:23 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60540 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1380563AbiDDU3p (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Mon, 4 Apr 2022 16:29:45 -0400
Received: from mail-wr1-x430.google.com (mail-wr1-x430.google.com [IPv6:2a00:1450:4864:20::430])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 472442DAB8
        for <linux-pm@vger.kernel.org>; Mon,  4 Apr 2022 13:27:48 -0700 (PDT)
Received: by mail-wr1-x430.google.com with SMTP id d3so5466170wrb.7
        for <linux-pm@vger.kernel.org>; Mon, 04 Apr 2022 13:27:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=message-id:date:mime-version:user-agent:subject:content-language:to
         :cc:references:from:in-reply-to:content-transfer-encoding;
        bh=XynzE6reIDw0ntgLHGWyU1PpLfFWXIFA6RBKvGsJOBc=;
        b=s1jp3WpRqKvo/gbJr/QjpC4Gi1j8Ut51pEL7WKMdx6+D5xuJcIdRdoYluu/vIRUIw7
         qGFGQszup9G9+8gjP7C/NHbZFdsCy+8iYLzXJtsVwpAE8w6oFS6DS7bSqzsjZ6Q82XNJ
         eTIHK9Nwmamwb2jJiuDYS6jYI5hBcDpil+8xP4FIO2aZwTGwEavn25c4uZba+u8SMN0f
         J592ngpszHwIjLzBwPKsSATSuKd+yQW/S4qbVtfJfj6Z/ytsqBD5X0mv8YXOQWcWK5Uy
         2HkKL2pvh339PkjnytDHqvLmNOhTI3GzMK07fvRuqRdlEGx9FFML/4S2HGOwsrGDJnRg
         F+sw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:to:cc:references:from:in-reply-to
         :content-transfer-encoding;
        bh=XynzE6reIDw0ntgLHGWyU1PpLfFWXIFA6RBKvGsJOBc=;
        b=DYN0HnldTAeSjqVPmd4kcW+p99cN5n5lUoC6aZdzQK7Ow6AgShzm667+lrPF47PnQc
         bgt+lM7/oI6jWRt/JzxvWiNSIGpjRxm8qehp8GCuW0T+AEghKet8/gNrs9d6F/PF3ltG
         HWM/+X9rMD9xsL5b232akl2Eui3+EFjdpneNtpZZX4AwiZoUuyGLR/YCLDoIO+hXOe4p
         NZnlKEOSs/9KeuaJHuEm6SKPqGk7H6Zgx0wZHn6qyrkc5xJM5536Pyf6rlvJ/pzd2x/j
         Qt8Y0EQCbJoXcs4/2kliolXu3/6T4QXsuhT/t7uNUtixDIGK+Qplzjb4DIY+pbElYhVY
         C1Ig==
X-Gm-Message-State: AOAM530GSN7MIkHEd95NX+g4onV8IRHgsCNEHlj20LrLjj0S/5jlqr7G
        hclMe/78d5QzFHuq5KEk2V3poA==
X-Google-Smtp-Source: ABdhPJwz6IvnJfhpgvW2CeEv7UEht3Rziq/qyzZEpwjd6DhJzX6L66Vj8kKLQRErCOhpdzDNIzakkg==
X-Received: by 2002:a5d:5987:0:b0:204:1f21:6a29 with SMTP id n7-20020a5d5987000000b002041f216a29mr286wri.716.1649104066683;
        Mon, 04 Apr 2022 13:27:46 -0700 (PDT)
Received: from ?IPV6:2a01:e34:ed2f:f020:9cdc:22ce:6a8e:1fc8? ([2a01:e34:ed2f:f020:9cdc:22ce:6a8e:1fc8])
        by smtp.googlemail.com with ESMTPSA id a11-20020a5d456b000000b0020406ce0e06sm10165995wrc.94.2022.04.04.13.27.44
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 04 Apr 2022 13:27:45 -0700 (PDT)
Message-ID: <e9d0f787-b23e-1266-c31a-60f9c1643a10@linaro.org>
Date:   Mon, 4 Apr 2022 22:27:43 +0200
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
 <8f1428c7-cf0e-b2cc-c898-09935a9017da@linaro.org>
 <YksoQ62CObN1R/oG@chrisdown.name>
From:   Daniel Lezcano <daniel.lezcano@linaro.org>
In-Reply-To: <YksoQ62CObN1R/oG@chrisdown.name>
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

On 04/04/2022 19:17, Chris Down wrote:
> Daniel Lezcano writes:
>> Well on regular desktop, the thermal is managed under the hood by the 
>> firmware/hardware, few sensors are exported AFAICT. I don't think a 
>> thermal daemon would have a benefit on these platforms.
> 
> Maybe we have different expectations? On my laptop, a Thinkpad T14s, 
> things seem not too bad:

That is not a desktop but a laptop, it is different :)

Can you give the content of:

cat /sys/class/thermal/thermal_zone*/type
cat /sys/class/thermal/thermal_zone*/trip_*type

and

cat /sys/class/thermal/cooling_device*/type

?


>      % printf '%s\n' /sys/class/hwmon/hwmon*/temp*_input
>      /sys/class/hwmon/hwmon1/temp1_input
>      /sys/class/hwmon/hwmon2/temp1_input
>      /sys/class/hwmon/hwmon2/temp2_input
>      /sys/class/hwmon/hwmon2/temp3_input
>      /sys/class/hwmon/hwmon4/temp1_input
>      /sys/class/hwmon/hwmon4/temp2_input
>      /sys/class/hwmon/hwmon4/temp3_input
>      /sys/class/hwmon/hwmon4/temp4_input
>      /sys/class/hwmon/hwmon4/temp5_input
>      /sys/class/hwmon/hwmon4/temp6_input
>      /sys/class/hwmon/hwmon4/temp7_input
>      /sys/class/hwmon/hwmon4/temp8_input
>      /sys/class/hwmon/hwmon6/temp1_input
>      /sys/class/hwmon/hwmon8/temp1_input
>      /sys/class/hwmon/hwmon8/temp2_input
>      /sys/class/hwmon/hwmon8/temp3_input
>      /sys/class/hwmon/hwmon8/temp4_input
>      /sys/class/hwmon/hwmon8/temp5_input
> 
> There are working temperature sensors out of the box for the CPU, wifi 
> card, ACPI thermal zone, and extended sensors from thinkpad_acpi.
> 
> In my case, I'd like to get notifications in userspace when certain 
> temperatures are reached.
> 
> So if I understood correctly, there's no way to dynamically configure 
> temperature thresholds and get breach events even as root, even with the 
> new netlink solution?

There is a way but you need:

1. A programmable trip point

 
https://uefi.org/specs/ACPI/6.4/11_Thermal_Management/thermal-control.html#dynamically-changing-cooling-temperature-trip-points

1.1 A passive trip point dedicated for userspace (no cooling device 
associated)

1.2 Writable kernel config option

The trip point will be writable in sysfs

2. Get trip point crossed

Use the netlink

But you don't need to monitor all these thermal zones, it is up to the 
in-kernel thermal framework to deal with the trip point individually and 
protect the system.

The userspace should monitor what is considered as the 'case' sensor or 
'skin' sensor. The temperature on those sensor moves very slowly, so 
monitoring them by getting the temperature every second should be enough.



-- 
<http://www.linaro.org/> Linaro.org │ Open source software for ARM SoCs

Follow Linaro:  <http://www.facebook.com/pages/Linaro> Facebook |
<http://twitter.com/#!/linaroorg> Twitter |
<http://www.linaro.org/linaro-blog/> Blog
