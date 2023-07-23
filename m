Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0770575E12C
	for <lists+linux-pm@lfdr.de>; Sun, 23 Jul 2023 12:19:30 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229665AbjGWKT1 (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Sun, 23 Jul 2023 06:19:27 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49084 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229452AbjGWKT1 (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Sun, 23 Jul 2023 06:19:27 -0400
Received: from mail-wr1-x42b.google.com (mail-wr1-x42b.google.com [IPv6:2a00:1450:4864:20::42b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C9386120
        for <linux-pm@vger.kernel.org>; Sun, 23 Jul 2023 03:19:25 -0700 (PDT)
Received: by mail-wr1-x42b.google.com with SMTP id ffacd0b85a97d-31427ddd3fbso2461845f8f.0
        for <linux-pm@vger.kernel.org>; Sun, 23 Jul 2023 03:19:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1690107564; x=1690712364;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=sQnaHUD9wuMOE3wezpKDM9nUt7ND/gLr6iVuqLZzBH4=;
        b=XzLZ9kIQIPdAT2k56oxPsSoqbz+G1OM4yafqVUQgldpGNve6mYzAXJasO+quR2LeXX
         QbR7hyaXoq+9WWS9zJfRi0jzj1BeaGg1p6NgGDKnQGWZyBEuWrRUb/ph5OHsfk5r/COx
         5h9n11aITNmrOVTaHmOTAbYUy0gpU/SjMwKDgrdZR1RW27NFCEjNEQKqPGX97F45S+sR
         ItpDU4WrRGC2rRr0CqH6btFrLcL6ee11TYh209HJFTWEvXJcscAnxNHDEm2oL7cDIqeA
         Mt9sAO5OwxLSfhOb/UcbxkNj1obGZqA4vA1+aanPwhN0Ce13uj9ox9k1lWIdkwuDjk9G
         JrvA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1690107564; x=1690712364;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=sQnaHUD9wuMOE3wezpKDM9nUt7ND/gLr6iVuqLZzBH4=;
        b=KSK4k1Igcdfx4Liyq5BLYOdDLbhJjARTVbXzS1suoyGorWeMOBH4uRSzqOF8g789Xk
         bcKJ4d/BjLTr8b8QjFqEljkY2WETw2pBPaqJncys9emVwMZA6h2YVx6uVHNC1JmDTi+m
         dUKHiv0Oai73clGriUbMMC6/fCI+FGJGht7b6/T/D4x4fQqR5B4Yokfq8LsOY2cS1Y3H
         gi6G5NZdIbkhD3np7vZ0A/0ALKjpp7m2WM0jX51enPH9VeW/au5zP62IuYUHiEoviVH4
         9azCt71tmjfTDYTu/UsqpeC0xSEWiCl/EnBFt7amDzKDRhzojLb0c1vSamDqvbR8/6tF
         5GQg==
X-Gm-Message-State: ABy/qLY81JnOW+G6Swef7lnoySVMhSX8d7zD5C7FaxNvXEnrMwPwoF4c
        6QCWo/xoEO29rEVozOzW2oA7Lg/yXfuJqiO5qkw=
X-Google-Smtp-Source: APBJJlG0zlSmLSbU8uURWCUktFiC361bYbJmxoldBGQF58ttb/xv9nOdCNBk6gzW5OCQ8fa2RT/izw==
X-Received: by 2002:a5d:4845:0:b0:317:5b29:f10a with SMTP id n5-20020a5d4845000000b003175b29f10amr634212wrs.47.1690107564264;
        Sun, 23 Jul 2023 03:19:24 -0700 (PDT)
Received: from [192.168.10.46] (146725694.box.freepro.com. [130.180.211.218])
        by smtp.googlemail.com with ESMTPSA id m24-20020a056000181800b003143ac73fd0sm9319421wrh.1.2023.07.23.03.19.23
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sun, 23 Jul 2023 03:19:23 -0700 (PDT)
Message-ID: <2e0bf65f-0452-c859-d287-a9762bd965ef@linaro.org>
Date:   Sun, 23 Jul 2023 12:19:23 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.11.0
Subject: Re: [PATCH v2 0/8] ACPI: thermal: Use trip point table to register
 thermal zones
Content-Language: en-US
To:     "Rafael J. Wysocki" <rjw@rjwysocki.net>,
        Linux ACPI <linux-acpi@vger.kernel.org>
Cc:     LKML <linux-kernel@vger.kernel.org>,
        Linux PM <linux-pm@vger.kernel.org>,
        Michal Wilczynski <michal.wilczynski@intel.com>,
        Zhang Rui <rui.zhang@intel.com>,
        Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>
References: <13318886.uLZWGnKmhe@kreacher> <5710197.DvuYhMxLoT@kreacher>
From:   Daniel Lezcano <daniel.lezcano@linaro.org>
In-Reply-To: <5710197.DvuYhMxLoT@kreacher>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.2 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org


Hi Rafael,

could you wait before applying I would like to review the series but I'm 
OoO ATM, coming back next week?



On 21/07/2023 14:44, Rafael J. Wysocki wrote:
> Hi Everyone,
> 
> This is the second iteration of the $subject patch series and its original
> description below is still applicable
> 
> On Tuesday, July 18, 2023 8:01:20 PM CEST Rafael J. Wysocki wrote:
>>
>> This patch series makes the ACPI thermal driver register thermal zones
>> with the help of thermal_zone_device_register_with_trips(), so it
>> doesn't need to use the thermal zone callbacks related to trip points
>> any more (and they are dropped in the last patch).
>>
>> The approach presented here is quite radically different from the
>> previous attempts, as it doesn't really rearrange the driver's
>> internal data structures, but adds the trip table support on top of
>> them.  For this purpose, it uses an additional field in struct thermal_trip
>> introduced in the first patch.
> 
> In the meantime I have updated the patches and tested them on a system with
> a couple of ACPI thermal zones.  No differences in functionality after applying
> the patches have been observed.
> 
> The update is mostly related to adding extra locking around trip point
> temperature updates and some hardening of the .get_trend() callback routine
> against invalid trip point indices.
> 
> Please see patch changelogs for details.
> 
> Thanks!
> 
> 
> 

-- 
<http://www.linaro.org/> Linaro.org │ Open source software for ARM SoCs

Follow Linaro:  <http://www.facebook.com/pages/Linaro> Facebook |
<http://twitter.com/#!/linaroorg> Twitter |
<http://www.linaro.org/linaro-blog/> Blog

