Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5B8836196B9
	for <lists+linux-pm@lfdr.de>; Fri,  4 Nov 2022 13:58:45 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230045AbiKDM6n (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Fri, 4 Nov 2022 08:58:43 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38786 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231540AbiKDM6m (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Fri, 4 Nov 2022 08:58:42 -0400
Received: from mail-qt1-x834.google.com (mail-qt1-x834.google.com [IPv6:2607:f8b0:4864:20::834])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9C4422E6B4
        for <linux-pm@vger.kernel.org>; Fri,  4 Nov 2022 05:58:40 -0700 (PDT)
Received: by mail-qt1-x834.google.com with SMTP id x15so2927627qtv.9
        for <linux-pm@vger.kernel.org>; Fri, 04 Nov 2022 05:58:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=moqbqvYx7dG3T4E7vDnFlU7Tn4z9XlmX1OvQ8lKwg3M=;
        b=DrrQSw00extJY/Sn63aVhqjp3JHTVzrJv3l4dZCFwS9axxDqtTadaD41md36CNvnd0
         dO6bT6JRavrLT1WgLU5OuS0jNQ9hXw9vtgGxPRoyhMDo9Eq7fzL8eSs/1Ni6vyV6XwE4
         WAfdbckcVy86XOAByKe8q1SNqxGuCR9Q7vnuEDVw7HF/q8cE0dh2PApeQGoFyO0XCR/d
         U5LVTPrvcd1VyWvIFLYKfvGAJPr1HBvgDUb56AphGbi6ZshrqebQmQGxkgiliiPceE6P
         /0CMygI6iYWyDP3pO1gHNAxfiEVmo0pGKSeuUmKotcd+A2UFr0a7OUVEuBowkLjz6Yt6
         r3JQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=moqbqvYx7dG3T4E7vDnFlU7Tn4z9XlmX1OvQ8lKwg3M=;
        b=ZSZS5b8WCeFZ3rJQ/HWprFSq2d0hduDrou+tlsG6XAsBZ3duFBH71Ha0UZcwZtUSaq
         yR6lhxWjkhDAVoAXqr2KaJdZ5D7+qxFshRD9ucWsHr8rS5UOY4WMSJFTtqzpXDBqs/UE
         Mky9ErlxVwb3rcvlsoS0HoDxoM9iuIB7aYbGblAUI5jFbBslhgifQTGlsn2PyQ+bu7ET
         sQ1Ivj3YgC63SIrHVPEAJM9GrckncxxHD3RtO2osKLc+i2L1b88c6Lu3S/0YBMMXv+xN
         z2tbAQdWdOhlBD3lL7O1vpYgKkMST2km9t+6qsQtMNVOiu2jD9Hy2szaozgDvIq+QAVr
         8Rhw==
X-Gm-Message-State: ACrzQf3WpI4ReFqX/d2XJpE1JTbZSyU6UDHttPffVQKgtDTwEORGSDlc
        BpiCqpcX9nYYPuIO7pPbouuWtw==
X-Google-Smtp-Source: AMsMyM6EWr72hG88VTGxDBrFTwz2rAouY9NI70AhYLCDppkyUfAzcruHrq5aTMvwZrR1LXVNIxFSkA==
X-Received: by 2002:a05:622a:8c:b0:39c:d644:b25 with SMTP id o12-20020a05622a008c00b0039cd6440b25mr28506860qtw.2.1667566719803;
        Fri, 04 Nov 2022 05:58:39 -0700 (PDT)
Received: from ?IPV6:2601:586:5000:570:aad6:acd8:4ed9:299b? ([2601:586:5000:570:aad6:acd8:4ed9:299b])
        by smtp.gmail.com with ESMTPSA id g14-20020a05620a218e00b006ce580c2663sm2818345qka.35.2022.11.04.05.58.38
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 04 Nov 2022 05:58:39 -0700 (PDT)
Message-ID: <1fa6ca95-ec2f-b9fb-7c6a-24cb7c2a5904@linaro.org>
Date:   Fri, 4 Nov 2022 08:58:38 -0400
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.4.2
Subject: Re: [PATCH v5 0/8] Add support for mp2733 battery charger
Content-Language: en-US
To:     saravanan sekar <sravanhome@gmail.com>
Cc:     linux-pm@vger.kernel.org, devicetree@vger.kernel.org,
        lee.jones@linaro.org, linux-iio@vger.kernel.org, jic23@kernel.org,
        sre@kernel.org, andy.shevchenko@gmail.com, lars@metafoo.de,
        krzysztof.kozlowski+dt@linaro.org, robh+dt@kernel.org
References: <20221029093000.45451-1-sravanhome@gmail.com>
 <8ba915b1-be77-f78e-87b0-9a00c8387084@linaro.org>
 <3e1b8549-0961-697b-63b8-db6b37d53c6b@gmail.com>
From:   Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
In-Reply-To: <3e1b8549-0961-697b-63b8-db6b37d53c6b@gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

On 04/11/2022 03:13, saravanan sekar wrote:
>>>   .../ABI/testing/sysfs-class-power-mp2629      |  16 ++
>>>   drivers/iio/adc/mp2629_adc.c                  |   8 +-
>>>   drivers/mfd/mp2629.c                          |   7 +-
>>>   drivers/power/supply/mp2629_charger.c         | 229 +++++++++++++++---
>>>   include/linux/mfd/mp2629.h                    |   6 +
>>
>> Why do you Cc DT maintainers?
>>
> 
> This patch series includes DT bindings documentation which has already 
> merged by 15Jun2022.

I don't see the DT bindings patch in above log. I did not get it and it
is not here:

https://lore.kernel.org/all/3e1b8549-0961-697b-63b8-db6b37d53c6b@gmail.com/

> 
> https://lore.kernel.org/all/20220615145357.2370044-3-sravanhome@gmail.com/

This is v3, how is it related?

Best regards,
Krzysztof

