Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0846D6D6CD3
	for <lists+linux-pm@lfdr.de>; Tue,  4 Apr 2023 21:02:20 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236275AbjDDTCS (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Tue, 4 Apr 2023 15:02:18 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33724 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236276AbjDDTCD (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Tue, 4 Apr 2023 15:02:03 -0400
Received: from mail-wm1-x32e.google.com (mail-wm1-x32e.google.com [IPv6:2a00:1450:4864:20::32e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A56D859DE
        for <linux-pm@vger.kernel.org>; Tue,  4 Apr 2023 12:01:48 -0700 (PDT)
Received: by mail-wm1-x32e.google.com with SMTP id n10-20020a05600c4f8a00b003ee93d2c914so22091256wmq.2
        for <linux-pm@vger.kernel.org>; Tue, 04 Apr 2023 12:01:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1680634907;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=fbI9ejTl1eZYxaGJfUEutb0biNta2syA7d62jWYBjRE=;
        b=HV+GSPgiJ+XLpeKDinv/5bUYZq9if67MO8wKf1iCun1/fkP6PVTGOwfbAyI33QkS46
         tqfy1tzlHhwS/R5bkf2tyhDgaNNHgSFMqQaaENBurZNWDxsSCtbzj40vWWfg3O9Mc7Yo
         wZw6ZrtvHzgvSxt2d3dWN3WJDfzuy6PkjVJg9VNVBz6ny4jrQ/wyHET/SBjQApqYXUCF
         GrFrZ+yabwxuTwKxQ6HUslbelS0rH6SAMpeuzCKDaUNOI0m8g/hBcvX+Pqm6veEedERs
         cW6JEftPmVk84qX+p2/APjrBltwmyDzg+SZoX2o8R032paKHAPsJJSj5CVjCN/4d/2Q8
         jiAQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1680634907;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=fbI9ejTl1eZYxaGJfUEutb0biNta2syA7d62jWYBjRE=;
        b=Jc9s0cjysX23iXXJPLpw0gq7R7PiXx+ov6Mu5sfffdTn30EZmYRfmU8sYk6g8rd1Et
         W/jbk4gwq9+2tLV/8jDkzuJQQQ2OYNGSIu5RJO4hT7L4EZLF6Gpw3kjQWAD/RxX3Kv58
         oUeWEjRA/YExvuFKzTuL8LAudDJxN8sxlI00kDgwz5f1kCQr4g7cJzij6QRqoSY9E2FR
         STlj7FLTraGmTnu2jZO7gntfGvfSfXqpD8Sg+p1dllqPBHfJXiBmes3VSLaj1rfxa1aR
         4D2VYNPVEIGzYYOdmrXykvbNSm0b8oJXyW5yir/CmCUSdJla6V8fSqxfG885qLKITfgC
         HX/w==
X-Gm-Message-State: AAQBX9en4VgoWsUycYI2IGT01HYZWojv7VKXT8AcOMeaR2AFry7ofENZ
        97Bakc1yCxtqzcyCnchiQvFENQ==
X-Google-Smtp-Source: AKy350bIBHo+2GObY+lCT16x4sLljqr+6Bs5zWCJLlFAY4jIr82PanFEsL5h/KuLUXmXd52Kzb4TAA==
X-Received: by 2002:a1c:f617:0:b0:3ee:672d:caae with SMTP id w23-20020a1cf617000000b003ee672dcaaemr2888889wmc.36.1680634906665;
        Tue, 04 Apr 2023 12:01:46 -0700 (PDT)
Received: from ?IPV6:2a05:6e02:1041:c10:abb6:73c6:c885:345d? ([2a05:6e02:1041:c10:abb6:73c6:c885:345d])
        by smtp.googlemail.com with ESMTPSA id bh23-20020a05600c3d1700b003ee9c8cc631sm22794789wmb.23.2023.04.04.12.01.46
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 04 Apr 2023 12:01:46 -0700 (PDT)
Message-ID: <a7cf78b9-84f3-a10a-d192-8f45565d85c9@linaro.org>
Date:   Tue, 4 Apr 2023 21:01:45 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.9.0
Subject: Re: [PATCH v1 09/11] thermal/core: Add a linked device parameter
Content-Language: en-US
To:     "Rafael J. Wysocki" <rafael@kernel.org>
Cc:     amitk@kernel.org, "open list:THERMAL" <linux-pm@vger.kernel.org>,
        open list <linux-kernel@vger.kernel.org>, rui.zhang@intel.com
References: <20230307133735.90772-1-daniel.lezcano@linaro.org>
 <20230307133735.90772-10-daniel.lezcano@linaro.org>
 <CAJZ5v0hW1B7XmU16PHRE2B6z2e-qs=X8m4v8qb--MUttiPuGqw@mail.gmail.com>
From:   Daniel Lezcano <daniel.lezcano@linaro.org>
In-Reply-To: <CAJZ5v0hW1B7XmU16PHRE2B6z2e-qs=X8m4v8qb--MUttiPuGqw@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=DKIM_SIGNED,DKIM_VALID,
        DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

On 27/03/2023 18:16, Rafael J. Wysocki wrote:
> On Tue, Mar 7, 2023 at 2:38 PM Daniel Lezcano <daniel.lezcano@linaro.org> wrote:
>>
>> Some drivers want to create a link from the thermal zone to the device
>> sysfs entry and vice versa.
> 
> Which device is this, exactly?

ls -alh /sys/bus/acpi/drivers/thermal/LNXTHERM:00/

[ ... ]

lrwxrwxrwx    1         0 thermal_zone -> 
../../../virtual/thermal/thermal_zone0

[ ... ]

The ACPI driver is the only one doing this AFAICT.


>> That is the case of the APCI driver.
>>
>> Having a backpointer from the device to the thermal zone sounds akward
>> as we can have the same device instantiating multiple thermal zones so
>> there will be a conflict while creating the second link with the same
>> name. Moreover, the userspace has enough information to build the
>> dependency from the thermal zone device link without having this cyclic
>> link from the device to thermal zone.
>>
>> Anyway, everything in its time.
>>
>> This change allows to create a these cyclic links tz <-> device as
>> ACPI does and will allow to remove the code in the ACPI driver.
> 
> Well, I'd rather have it in the driver than in the core TBH.
> 
> If ACPI is the only user of this, let it do the dirty thing by itself.
> 
> There are two cases which would justify making this change:
> 1. There will be more users of it going forward (seems unlikely from
> the description).
> 2. It gets in the way of some other changes somehow.
> 
> I kind of expect 2. to be the case, so how does it get in the way?

Shall we do the same approach than 'Menlow' and add an option to remove 
the thermal zone link in the acpi sysfs directory ?


-- 
<http://www.linaro.org/> Linaro.org │ Open source software for ARM SoCs

Follow Linaro:  <http://www.facebook.com/pages/Linaro> Facebook |
<http://twitter.com/#!/linaroorg> Twitter |
<http://www.linaro.org/linaro-blog/> Blog

