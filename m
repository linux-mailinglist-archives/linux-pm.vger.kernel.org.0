Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A9A884F1A65
	for <lists+linux-pm@lfdr.de>; Mon,  4 Apr 2022 23:16:35 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1378935AbiDDVS2 (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Mon, 4 Apr 2022 17:18:28 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43426 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1380665AbiDDUwD (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Mon, 4 Apr 2022 16:52:03 -0400
Received: from mail-wr1-x42a.google.com (mail-wr1-x42a.google.com [IPv6:2a00:1450:4864:20::42a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0BB2022516
        for <linux-pm@vger.kernel.org>; Mon,  4 Apr 2022 13:50:05 -0700 (PDT)
Received: by mail-wr1-x42a.google.com with SMTP id h4so16289177wrc.13
        for <linux-pm@vger.kernel.org>; Mon, 04 Apr 2022 13:50:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chrisdown.name; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:content-transfer-encoding:in-reply-to
         :user-agent;
        bh=Ug5WnBDc3P5A59NStXcLW76bV1O5G7jLmAJ0qT91Vr8=;
        b=Psvi4KNCfYcWukoDJp1UHZnge3+IpXsV7j+7Ig4sUvdU0x58GF2YqlL5l1HnCaVQdg
         szl6R4e7e7qC+RBztBwJA2Q3pM1gFxRn7HvNyV8Gawy52cd5xJNy6BP1wzm89XK31SwH
         ElUgu0Z69ymAvrzKenzk/tS26fxyT4Soh1vZM=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:content-transfer-encoding
         :in-reply-to:user-agent;
        bh=Ug5WnBDc3P5A59NStXcLW76bV1O5G7jLmAJ0qT91Vr8=;
        b=AC6MEzfO4gLIK4gLb+/FZPGWJPAXT6fvPu54vd6KRvnZab6KdzcBtz/VlasyoyOmP4
         vJfLyJulBHxdJuZtYCOSP2ZS4K50StzdX0LxbtIbxxHFRkY71e8jtO3URcPzU1/J0VBk
         dWKUJiAPux6OZr5BIMrbOuI+15yYr4878Fy6eg+MZziZSuyuu5pXu9Pvwgz3MlLltvj3
         YZo8rRD6+Knft3erqda5t11v/81VlthbZ9WYuRTMIA015wIZevVnTlWAR5+P97JXQT81
         Upjkjnlent+mk6OXhLRMFDoALgdcP5WEDVElHmUFOn0J+daNdgJDkPAKQpid/rGWTr+F
         I2jg==
X-Gm-Message-State: AOAM530Zyqc6F4ZC9nzJKe/h7aPj0QmGI7+L9vzhlf+4/f05/LOmsmuu
        zuFXy8NGxnEg90bjhMMect8uzw==
X-Google-Smtp-Source: ABdhPJy3W6ySd/l6UPTknEmb5EGDRfL0LaoDa959altgntgg0dvXn5YvyzRvuUBf8BXd4j4kk9knSA==
X-Received: by 2002:a05:6000:1687:b0:205:80b7:afca with SMTP id y7-20020a056000168700b0020580b7afcamr28822wrd.665.1649105403427;
        Mon, 04 Apr 2022 13:50:03 -0700 (PDT)
Received: from localhost ([2620:10d:c092:400::4:521a])
        by smtp.gmail.com with ESMTPSA id x13-20020adfec0d000000b00203ff46f802sm14205902wrn.36.2022.04.04.13.50.02
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 04 Apr 2022 13:50:02 -0700 (PDT)
Date:   Mon, 4 Apr 2022 21:50:01 +0100
From:   Chris Down <chris@chrisdown.name>
To:     Daniel Lezcano <daniel.lezcano@linaro.org>
Cc:     linux-pm@vger.kernel.org, "Rafael J. Wysocki" <rafael@kernel.org>,
        Amit Kucheria <amitk@kernel.org>,
        Zhang Rui <rui.zhang@intel.com>,
        Guenter Roeck <linux@roeck-us.net>
Subject: Re: Thermal notifications without setting thermal governor to
 userspace?
Message-ID: <YktZ+ebgm0TzU/qL@chrisdown.name>
References: <YkR6/KnH/f9U+2qf@chrisdown.name>
 <faf9e24f-4419-cdbb-573f-4cf2d9e506e2@linaro.org>
 <YksL8a+cINo7K/xX@chrisdown.name>
 <8f1428c7-cf0e-b2cc-c898-09935a9017da@linaro.org>
 <YksoQ62CObN1R/oG@chrisdown.name>
 <e9d0f787-b23e-1266-c31a-60f9c1643a10@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1; format=flowed
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <e9d0f787-b23e-1266-c31a-60f9c1643a10@linaro.org>
User-Agent: Mutt/2.2.2 (aa28abe8) (2022-03-25)
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

Daniel Lezcano writes:
>On 04/04/2022 19:17, Chris Down wrote:
>>Daniel Lezcano writes:
>>>Well on regular desktop, the thermal is managed under the hood by 
>>>the firmware/hardware, few sensors are exported AFAICT. I don't 
>>>think a thermal daemon would have a benefit on these platforms.
>>
>>Maybe we have different expectations? On my laptop, a Thinkpad T14s, 
>>things seem not too bad:
>
>That is not a desktop but a laptop, it is different :)

Oh, I see :-) I misread the distinction as embedded vs. consumer-facing.

>Can you give the content of:
>
>cat /sys/class/thermal/thermal_zone*/type
>cat /sys/class/thermal/thermal_zone*/trip_*type
>
>and
>
>cat /sys/class/thermal/cooling_device*/type

   % grep . /sys/class/thermal/thermal_zone*/type
   /sys/class/thermal/thermal_zone0/type:acpitz
   /sys/class/thermal/thermal_zone1/type:INT3400 Thermal
   /sys/class/thermal/thermal_zone2/type:SEN1
   /sys/class/thermal/thermal_zone3/type:SEN2
   /sys/class/thermal/thermal_zone4/type:TCPU
   /sys/class/thermal/thermal_zone5/type:iwlwifi_1
   /sys/class/thermal/thermal_zone6/type:x86_pkg_temp
   % grep . /sys/class/thermal/thermal_zone*/trip_*type
   /sys/class/thermal/thermal_zone0/trip_point_0_type:critical
   /sys/class/thermal/thermal_zone2/trip_point_0_type:critical
   /sys/class/thermal/thermal_zone2/trip_point_1_type:hot
   /sys/class/thermal/thermal_zone2/trip_point_2_type:passive
   /sys/class/thermal/thermal_zone3/trip_point_0_type:critical
   /sys/class/thermal/thermal_zone3/trip_point_1_type:hot
   /sys/class/thermal/thermal_zone3/trip_point_2_type:passive
   /sys/class/thermal/thermal_zone4/trip_point_0_type:critical
   /sys/class/thermal/thermal_zone4/trip_point_1_type:hot
   /sys/class/thermal/thermal_zone4/trip_point_2_type:passive
   /sys/class/thermal/thermal_zone5/trip_point_0_type:passive
   /sys/class/thermal/thermal_zone5/trip_point_1_type:passive
   /sys/class/thermal/thermal_zone5/trip_point_2_type:passive
   /sys/class/thermal/thermal_zone5/trip_point_3_type:passive
   /sys/class/thermal/thermal_zone5/trip_point_4_type:passive
   /sys/class/thermal/thermal_zone5/trip_point_5_type:passive
   /sys/class/thermal/thermal_zone5/trip_point_6_type:passive
   /sys/class/thermal/thermal_zone5/trip_point_7_type:passive
   /sys/class/thermal/thermal_zone6/trip_point_0_type:passive
   /sys/class/thermal/thermal_zone6/trip_point_1_type:passive
   % grep . /sys/class/thermal/cooling_device*/type
   /sys/class/thermal/cooling_device0/type:Processor
   /sys/class/thermal/cooling_device1/type:Processor
   /sys/class/thermal/cooling_device2/type:Processor
   /sys/class/thermal/cooling_device3/type:Processor
   /sys/class/thermal/cooling_device4/type:Processor
   /sys/class/thermal/cooling_device5/type:Processor
   /sys/class/thermal/cooling_device6/type:Processor
   /sys/class/thermal/cooling_device7/type:Processor
   /sys/class/thermal/cooling_device8/type:intel_powerclamp
   /sys/class/thermal/cooling_device9/type:TCC Offset

>
>?
>
>
>>     % printf '%s\n' /sys/class/hwmon/hwmon*/temp*_input
>>     /sys/class/hwmon/hwmon1/temp1_input
>>     /sys/class/hwmon/hwmon2/temp1_input
>>     /sys/class/hwmon/hwmon2/temp2_input
>>     /sys/class/hwmon/hwmon2/temp3_input
>>     /sys/class/hwmon/hwmon4/temp1_input
>>     /sys/class/hwmon/hwmon4/temp2_input
>>     /sys/class/hwmon/hwmon4/temp3_input
>>     /sys/class/hwmon/hwmon4/temp4_input
>>     /sys/class/hwmon/hwmon4/temp5_input
>>     /sys/class/hwmon/hwmon4/temp6_input
>>     /sys/class/hwmon/hwmon4/temp7_input
>>     /sys/class/hwmon/hwmon4/temp8_input
>>     /sys/class/hwmon/hwmon6/temp1_input
>>     /sys/class/hwmon/hwmon8/temp1_input
>>     /sys/class/hwmon/hwmon8/temp2_input
>>     /sys/class/hwmon/hwmon8/temp3_input
>>     /sys/class/hwmon/hwmon8/temp4_input
>>     /sys/class/hwmon/hwmon8/temp5_input
>>
>>There are working temperature sensors out of the box for the CPU, 
>>wifi card, ACPI thermal zone, and extended sensors from 
>>thinkpad_acpi.
>>
>>In my case, I'd like to get notifications in userspace when certain 
>>temperatures are reached.
>>
>>So if I understood correctly, there's no way to dynamically 
>>configure temperature thresholds and get breach events even as root, 
>>even with the new netlink solution?
>
>There is a way but you need:
>
>1. A programmable trip point
>
>
>https://uefi.org/specs/ACPI/6.4/11_Thermal_Management/thermal-control.html#dynamically-changing-cooling-temperature-trip-points
>
>1.1 A passive trip point dedicated for userspace (no cooling device 
>associated)
>
>1.2 Writable kernel config option
>
>The trip point will be writable in sysfs
>
>2. Get trip point crossed
>
>Use the netlink
>
>But you don't need to monitor all these thermal zones, it is up to the 
>in-kernel thermal framework to deal with the trip point individually 
>and protect the system.
>
>The userspace should monitor what is considered as the 'case' sensor 
>or 'skin' sensor. The temperature on those sensor moves very slowly, 
>so monitoring them by getting the temperature every second should be 
>enough.

I see. I suspect this is probably too much to get from a distro kernel and 
myriad hardware, so I guess I'm consigned to using polling for the timebeing 
then.

Thanks a lot for chiming in with your knowledge :-)

Chris
