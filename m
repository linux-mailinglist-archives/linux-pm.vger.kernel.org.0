Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9391D616D38
	for <lists+linux-pm@lfdr.de>; Wed,  2 Nov 2022 19:56:05 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231529AbiKBS4D (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Wed, 2 Nov 2022 14:56:03 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53038 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231502AbiKBS4D (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Wed, 2 Nov 2022 14:56:03 -0400
Received: from mail-wm1-x334.google.com (mail-wm1-x334.google.com [IPv6:2a00:1450:4864:20::334])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A3EDCC29
        for <linux-pm@vger.kernel.org>; Wed,  2 Nov 2022 11:56:01 -0700 (PDT)
Received: by mail-wm1-x334.google.com with SMTP id a11-20020a05600c2d4b00b003cf6f5fd9f1so1908132wmg.2
        for <linux-pm@vger.kernel.org>; Wed, 02 Nov 2022 11:56:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=oaovhureZcWjvGqUqifYJVmSn464HenN8mk15Mi2ky4=;
        b=utRUWUjK7OkxdfEuke86RY6tHDlUxB7e/beDgaFaEsrlzlfXvETPNrkc9NSJcNo0VH
         4yIW53toBK5ma++yRcKc34/bwUiLUvp8a1DXFsE/gwERXhzAcko2cjVJeQwUPrFakEA3
         WXwbazOLVHyIl4r3pOyVgsxTNeWMEjpu33STo3PrCgP8yvMKDupgoeQYmcXIYS0Zv9an
         yFRh95nMwtNZIKPntv4BA8G+bEZOQVuWCgrVM10mZsLQIKCZw4zJ7qo7h69SxP54an2e
         OEhZf6nd9lJ1AXthi2zFMHkaOIZ8U3yjR2jEtpxBcTadI+Aic/R5U6xvHoUeVVCt5HR5
         RfqA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=oaovhureZcWjvGqUqifYJVmSn464HenN8mk15Mi2ky4=;
        b=wt8fKqQHoBhi3LhM59doTtzO07PSbXw6ZBaL0mKvgroiUULuZCj9t5jPXTTx6h84M2
         JeuL4bgT+vsKlkQOKuzfBHqkB6qlqKi4tpZXxfYrRg9mUseXoTmZfVZnZiFrX+dqpc5F
         5l86eR+dWnQbm+vVozVu1cMBT+I7jpVLw8FglDnhXAuMep3lF5RUdzpLJYQuBHVp/OyH
         JZgUHHc+cyni8Zuqhd1j10LXqseEiVeytsZ6PkSmU8eiqO4SDjVXoeso8/Lq1JylDWkH
         9mkh0k8pwMuKsVNHm6nacSGaAuf++zFjoFrBjaZ1AOP0ZZiTBz+2f5D9M291HxIUNQ7y
         mJeQ==
X-Gm-Message-State: ACrzQf286pxji3hzynmachXnI/nEUZGvO3lzI/gGZtOsBUHK0cfX99lc
        vPK91VEpPISXYwQRP/cRAd18aw==
X-Google-Smtp-Source: AMsMyM5EFiOz0wsKu+NdCjYg3vPBZXYxOx5aXpiv00GIKDkDi92siTK9NlzX4S564iCceJiNT9a2lg==
X-Received: by 2002:a05:600c:35cb:b0:3c6:e382:62fb with SMTP id r11-20020a05600c35cb00b003c6e38262fbmr16390566wmq.22.1667415360072;
        Wed, 02 Nov 2022 11:56:00 -0700 (PDT)
Received: from ?IPV6:2a05:6e02:1041:c10:5651:27e1:bcce:4ed7? ([2a05:6e02:1041:c10:5651:27e1:bcce:4ed7])
        by smtp.googlemail.com with ESMTPSA id z7-20020a05600c0a0700b003cf483ee8e0sm3493402wmp.24.2022.11.02.11.55.59
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 02 Nov 2022 11:55:59 -0700 (PDT)
Message-ID: <e60c7b98-aa78-1918-c1dd-6e1e73894d6d@linaro.org>
Date:   Wed, 2 Nov 2022 19:55:58 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.2.2
Subject: Re: [PATCH 0/9] thermal/core: Protect thermal device operations
 against removal
Content-Language: en-US
To:     Guenter Roeck <linux@roeck-us.net>,
        "Rafael J . Wysocki" <rafael@kernel.org>
Cc:     Amit Kucheria <amitk@kernel.org>, Zhang Rui <rui.zhang@intel.com>,
        linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20221017130910.2307118-1-linux@roeck-us.net>
 <20221102185030.GA2026081@roeck-us.net>
From:   Daniel Lezcano <daniel.lezcano@linaro.org>
In-Reply-To: <20221102185030.GA2026081@roeck-us.net>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

On 02/11/2022 19:50, Guenter Roeck wrote:
> Hi,
> 
> On Mon, Oct 17, 2022 at 06:09:01AM -0700, Guenter Roeck wrote:
>> Accesses to thermal zones, and with it to thermal zone device operations,
>> are still possible after the thermal zone device has been unregistered.
>> For example, thermal_zone_get_temp() can be called from temp_show()
>> in thermal_sysfs.c if the sysfs attribute was opened before the thermal
>> device was unregistered. This is problematic and may result in crashes
>> since the operations data structure and the underlying code may be gone
>> when the calls are made.
>>
>> The following series solves the problem by protecting accesses to thermal
>> device operations with the thermal device mutex, and by verifying that the
>> thermal device is still registered after the mutex has been acquired.
>>
>> This was previously sent as RFC/RFT as single patch [1]. The code was reworked
>> to match thermal subsystem changes made between v6.0 and v6.1, and it was
>> split into several patches to simplify review.
>>
> 
> Any thoughts / comments / feedback on this series ?

I'm out of the office ATM, I'll have a look on the series in a few days.


-- 
<http://www.linaro.org/> Linaro.org │ Open source software for ARM SoCs

Follow Linaro:  <http://www.facebook.com/pages/Linaro> Facebook |
<http://twitter.com/#!/linaroorg> Twitter |
<http://www.linaro.org/linaro-blog/> Blog

