Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D322470F02A
	for <lists+linux-pm@lfdr.de>; Wed, 24 May 2023 10:06:40 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239963AbjEXIGj (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Wed, 24 May 2023 04:06:39 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57048 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236097AbjEXIGi (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Wed, 24 May 2023 04:06:38 -0400
Received: from mail-wm1-x334.google.com (mail-wm1-x334.google.com [IPv6:2a00:1450:4864:20::334])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5FD42132
        for <linux-pm@vger.kernel.org>; Wed, 24 May 2023 01:06:33 -0700 (PDT)
Received: by mail-wm1-x334.google.com with SMTP id 5b1f17b1804b1-3f42ba32e24so5481985e9.3
        for <linux-pm@vger.kernel.org>; Wed, 24 May 2023 01:06:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1684915592; x=1687507592;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=HwbNoKB5p2KN5UId3Q0LMqV7ovAxqYQAJR4c7Ml8rDk=;
        b=qDVj+No7I+Ps3m58gE0IADmUr4Qzh2MxHm8us4RF7UfMEeMX1Y3ET6HYNXKv1rKbxf
         ZTPyxw8zFG+N++mEjM4+nsqjXDaDjDd3im4eeFf1ksHe9/hlHb//Q4AZ6nbp/hQBxerb
         4VqCB6aGZnA1wiuWH4gX8Kvz8WgHrSBaEDD8T3u3U6fwcT0Ew6HGGLIR/DtQVj7LjZzy
         i4fw5E1gcOjoYam4z9nwTJd8oXnS+tm2C/bgA755N0DxVbOjj0DVhHqs191n7ecyiLbQ
         8M/JnldkoesjV4YPbm5xj2FSAGagmGy5BIcQaaKkv4PZTd/bFzv10cNhNvpeTeMwS1wL
         tOKw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1684915592; x=1687507592;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=HwbNoKB5p2KN5UId3Q0LMqV7ovAxqYQAJR4c7Ml8rDk=;
        b=WxmHs6xuYzA8bWGsuYoYWg25lXa7lKMCuH0t7L/hynkdLrFczY8S4KwD+NTQqoKTUs
         GEVJaHVahcS5BNMSvYumPMO8xeBR7n9onv0NPxEq0AmC4xvC4KWAZN2CTFSFInQy2SSL
         Eg4mr0Em+ybyxJQFf1AzpQspUHCzBpqtwpC3qeGuxodOENpn/g0E6tApOvhpT8agkK90
         njFs1vFEs3Zfwgqr+A5n6qXnfhwcEcnCwWDSmn0Wq+hZy/IOk7lPqtmuBVjn59wIaRLX
         bdCR3sLg+Fso7Ma01pqkw5YRuyKxNmJ2SkD4HvprkHKmQFKho9b8Mbatrs8CzA6WI0Zs
         MfgA==
X-Gm-Message-State: AC+VfDxnUdDPUMtizTpZQI66pnkK1xi9VehQTJ7g52dkYTKr/0C0YM9w
        MfMze/ZEGsQHdq0jh8hK0ykCdg==
X-Google-Smtp-Source: ACHHUZ7t8gpOOx0CHrHzvgUooc6H0QeQPcutqofSnkvpUXer1qV+jq1pKkXvoZolz9hSXed9ObeBNg==
X-Received: by 2002:a7b:c412:0:b0:3f4:2267:10cf with SMTP id k18-20020a7bc412000000b003f4226710cfmr12186809wmi.32.1684915591711;
        Wed, 24 May 2023 01:06:31 -0700 (PDT)
Received: from ?IPV6:2a05:6e02:1041:c10:4b66:e1c1:7cd0:485e? ([2a05:6e02:1041:c10:4b66:e1c1:7cd0:485e])
        by smtp.googlemail.com with ESMTPSA id v7-20020a05600c214700b003f4f89bc48dsm1455679wml.15.2023.05.24.01.06.30
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 24 May 2023 01:06:31 -0700 (PDT)
Message-ID: <745b8b17-af4d-e8e1-83c1-89d600e7cd19@linaro.org>
Date:   Wed, 24 May 2023 10:06:30 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.9.0
Subject: Re: [CfP] Power Management and Thermal Control MC (LPC2023)
Content-Language: en-US
To:     "Rafael J. Wysocki" <rafael@kernel.org>,
        Linux PM <linux-pm@vger.kernel.org>
Cc:     Viresh Kumar <viresh.kumar@linaro.org>,
        Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>,
        "Zhang, Rui" <rui.zhang@intel.com>,
        Lukasz Luba <lukasz.luba@arm.com>,
        Sudeep Holla <sudeep.holla@arm.com>,
        Morten Rasmussen <morten.rasmussen@arm.com>,
        Ulf Hansson <ulf.hansson@linaro.org>,
        Mario Limonciello <mario.limonciello@amd.com>
References: <CAJZ5v0juUuy2xKZHMXAKSRtfQxMyL6z12AFdU8_ZbdFRKKrR=Q@mail.gmail.com>
From:   Daniel Lezcano <daniel.lezcano@linaro.org>
In-Reply-To: <CAJZ5v0juUuy2xKZHMXAKSRtfQxMyL6z12AFdU8_ZbdFRKKrR=Q@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.2 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

On 22/05/2023 19:12, Rafael J. Wysocki wrote:
> Hi Folks,
> 
> I'm going to submit a Power Management and Thermal Control
> micro-conference proposal for LPC2023 along the lines of what happened
> in the previous iterations of it.
> 
> If you have topics that you'd like to be discussed there, please let
> me know by Friday, May 26.
> 
> Please note that LPC MC topics are expected to cover work in progress
> or at the concept stage.  They are not supposed to be about work that
> has been done already.

* Create a relevant debugfs thermal infrastructure + cleanup the sysfs 
debug related information.
    -> average temperature (overall / moving)
    -> mitigation episodes (duration, temperature max, min, avg, average 
performance througput)
    -> thermal zone behavior (temperature slope dT/dt vs performance 
througput)
    -> more TBD at LPC

[ RFC series ready but depends on the generic trip point ]

* New thermal trip types. Currently we have 'hot', 'passive', 'active', 
'critical' trip points. The userspace needs to deal with the thermal 
also but in a different manner. Currently, it has to poll the thermal 
zone to get the temperature, thus introducing more wakes up on the 
system. However the sensors have now a programmable register to trigger 
an interrupt and the userspace may benefit that. By adding one or 
several writable 'custom' trip points, the userspace can program a point 
to be notified and do an action. So we separate the actions from the 
kernel to protect the silicon and the ones from userspace to manage the 
overall thermal behavior in the system at lower temperatures.

[ depends on the generic trip points ]

* Thermal management without the time dimension taken into account is 
too simplistic. Add this dimension in the thermal information for better 
decision (eg. notification when a temperature is above a temperature 
after a duration)

* Improve the step wise governor. The step wise governor may take too 
much time to react when there are many cooling device states as it will 
increment with one step at each update (eg. idle cooling device has 100 
states). That may result on overshoots. Depending on the temperature 
slope we should increase the number of steps for the cooling action. The 
result should be some kind of PID regulation loop but simplified 
regarding the power allocator.



-- 
<http://www.linaro.org/> Linaro.org │ Open source software for ARM SoCs

Follow Linaro:  <http://www.facebook.com/pages/Linaro> Facebook |
<http://twitter.com/#!/linaroorg> Twitter |
<http://www.linaro.org/linaro-blog/> Blog

