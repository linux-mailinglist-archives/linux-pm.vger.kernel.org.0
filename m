Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id F1C726F0D7D
	for <lists+linux-pm@lfdr.de>; Thu, 27 Apr 2023 22:53:54 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344053AbjD0Uxw (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Thu, 27 Apr 2023 16:53:52 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46404 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229750AbjD0Uxv (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Thu, 27 Apr 2023 16:53:51 -0400
Received: from mail-wm1-x330.google.com (mail-wm1-x330.google.com [IPv6:2a00:1450:4864:20::330])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A55B4E56
        for <linux-pm@vger.kernel.org>; Thu, 27 Apr 2023 13:53:47 -0700 (PDT)
Received: by mail-wm1-x330.google.com with SMTP id 5b1f17b1804b1-3f173af665fso60079425e9.3
        for <linux-pm@vger.kernel.org>; Thu, 27 Apr 2023 13:53:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1682628826; x=1685220826;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=xD786TZT7B+/3S4wzJgEnZTLWsTRx10unO92/z5CZGc=;
        b=azCUsh6921oUgHNRyfqO5FxwrJoviUyl7ZwWzqkMETiUgEFKwDsNBbFg8S1Gt0NXTb
         IGJS/yps0R6b3f3LrWeXIFIpH/68i+amTZYzApkLKMjRZi2M2vywnpPubCuI+G9DWxil
         d520ZYFUy8llub9eQ9lomnW9eCqPwOx8UmXUejcTJuXzYG6bLXLh4100x614KXVrZnNE
         LpSc8qHZMAN6UrZCgZvOpjA6Btf1nvCFoRhUOhtIs2nqH44oQTk0Q3ZSsKw1CNfsV/0t
         XoTO+m7tIBeKEh6Sf/H/mN81A7CsU8nY5JbJhXvxU4Ddnu45W65pc+VyAYwG5dyWn+8k
         d60A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1682628826; x=1685220826;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=xD786TZT7B+/3S4wzJgEnZTLWsTRx10unO92/z5CZGc=;
        b=Zr7QSFOQKCra2QviNNdXKSLD8KBnwR02D7gUHeyfMLDn078lsn687IfQTNGjr9s3mJ
         OKZBzODnTppVqW5nlXXkDOtJWBijzOExIFAmWkKJC+CJ9EGMsfYzNfICE9wIukSXjXFX
         FasaN3J9zOkRunMnSMub7zhlhUrtEn0nkb1ys+U/twvLUkB9mYn5s1gVHc49iX7M4o/E
         BlzJWVh/jxF+kfG3Vsbj0WitzOInK47RYLLXD83Lm6F+VTW7j3PGf6vUs6ENkHjs6xzz
         OPyCCzetQDCVeZtoVWADRDiqKydtJtIAPWT2zxCSvnbRFoSxpgW0X8hInOsYjZv8TeAA
         A7AA==
X-Gm-Message-State: AC+VfDxugg7BN6qjUun6jcae9u1U6MUYsOx5FwuOyzxn3vJjps903wtH
        0KQpTpbXWOUxAY6AYWZsL1BBQA==
X-Google-Smtp-Source: ACHHUZ5s+2AVbZ7GKUo6usOUQ4yRJYhHyyrpGJYDTK9r1qH0dGog9PlLpihu9NJZ9VsCjwEgfuZVUQ==
X-Received: by 2002:a7b:c7d0:0:b0:3f1:75b3:60df with SMTP id z16-20020a7bc7d0000000b003f175b360dfmr2300008wmk.41.1682628826054;
        Thu, 27 Apr 2023 13:53:46 -0700 (PDT)
Received: from [172.23.3.48] ([31.221.30.162])
        by smtp.googlemail.com with ESMTPSA id h15-20020a05600c314f00b003f1978bbcd6sm23530408wmo.3.2023.04.27.13.53.45
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 27 Apr 2023 13:53:45 -0700 (PDT)
Message-ID: <93fcee42-0157-52e2-d694-83307f0eadaf@linaro.org>
Date:   Thu, 27 Apr 2023 22:53:43 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.10.0
Subject: Re: [PATCH v4 0/6] Thermal zone device structure encapsulation
Content-Language: en-US
To:     "Rafael J. Wysocki" <rafael@kernel.org>
Cc:     rui.zhang@intel.com, linux-kernel@vger.kernel.org,
        linux-pm@vger.kernel.org
References: <20230419083343.505780-1-daniel.lezcano@linaro.org>
 <CAJZ5v0jKRew48KNXXBJjENxpOhEE5jxwfAcmiuu_4nvhQL-FGA@mail.gmail.com>
From:   Daniel Lezcano <daniel.lezcano@linaro.org>
In-Reply-To: <CAJZ5v0jKRew48KNXXBJjENxpOhEE5jxwfAcmiuu_4nvhQL-FGA@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-3.5 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

On 27/04/2023 19:23, Rafael J. Wysocki wrote:
> On Wed, Apr 19, 2023 at 10:33 AM Daniel Lezcano
> <daniel.lezcano@linaro.org> wrote:
>>
>> The thermal zone device structure is defined in the exported thermal
>> header include/linux/thermal.h
>>
>> Given the definition being public, the structure is exposed to the
>> external components other than the thermal framework core code. It
>> results the drivers are tampering the structure internals like taking
>> the lock or changing the field values.
>>
>> Obviously that is bad for several reasons as the drivers can hook the
>> thermal framework behavior and makes very difficult the changes in the
>> core code as external components depend on it directly.
>>
>> Moreover, the thermal trip points being reworked, we don't want the
>> drivers to access the trips array directly in the thermal zone
>> structure and doing assumptions on how they are organized.
>>
>> This series provides a second set of changes moving to the thermal
>> zone device structure self-encapsulation.
>>
>> The ACPI and the Menlon drivers are using the thermal zone's device
>> fields to create symlinks and new attributes in the sysfs thermal zone
>> directory. These changes provide a hopefully temporary wrapper to
>> access it in order to allow moving forward in the thermal zone device
>> self-encapsulation and a Kconfig option to disable by default such a
>> extra sysfs information.
>>

[ ... ]

> Patches [4/6] and [6/6] were superseded by the Menlow driver removal.
> 
> I've applied the rest as 6.4-rc material, with some subject
> adjustments and after removing some trailing white space in a few
> places.


Thanks!

-- 
<http://www.linaro.org/> Linaro.org │ Open source software for ARM SoCs

Follow Linaro:  <http://www.facebook.com/pages/Linaro> Facebook |
<http://twitter.com/#!/linaroorg> Twitter |
<http://www.linaro.org/linaro-blog/> Blog

