Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DB20F7AFF9F
	for <lists+linux-pm@lfdr.de>; Wed, 27 Sep 2023 11:15:15 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230174AbjI0JPO (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Wed, 27 Sep 2023 05:15:14 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36686 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230385AbjI0JPK (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Wed, 27 Sep 2023 05:15:10 -0400
Received: from mail-wm1-x334.google.com (mail-wm1-x334.google.com [IPv6:2a00:1450:4864:20::334])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BE336193
        for <linux-pm@vger.kernel.org>; Wed, 27 Sep 2023 02:15:08 -0700 (PDT)
Received: by mail-wm1-x334.google.com with SMTP id 5b1f17b1804b1-405e48d8cfdso44573785e9.2
        for <linux-pm@vger.kernel.org>; Wed, 27 Sep 2023 02:15:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1695806107; x=1696410907; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=jQteU9pTpx/ahIZrbklTplbazA8QXQaSLA02EVq9mDk=;
        b=ApvVHJGq6VrYiu1ih883CsWuuc9GbV5pnkK5a4w21mwWEQxdPO6qynjcw1zJRvL/q1
         IRsn3Zn22cgdJGwd3j08u8AoGFoJitzxI+sRqkP2Vm/vJpKHvWpNbOOv6N5mSMbbKgD9
         DHNF3lm1BTRkIWNkCjgp1YjjxC+PzOsovuemi9cqQx64JUBjlwqnPRf3YhtMvPooSLc+
         ACzOt7rjdTBqNh5Uaff4gpSfYocANmcka5ihxp3imjTl1jstken6EWg1ComMdMVLB5vJ
         BogRw/vaDh/tuEbPrFppODp4rhu90PvOv1aDPm6rH3+wNClMZzUdct/ByAXNdp+oBi9O
         aNQg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1695806107; x=1696410907;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=jQteU9pTpx/ahIZrbklTplbazA8QXQaSLA02EVq9mDk=;
        b=qbVQvWjYZzGXOncY6bVVML4OaSoktV5D96RTyEezl6FU5PqzhT0KtVOSKSDhoj47Sw
         mTuwogtBOFFLIODkUxFed08K1Ktaz2KzsF5vjPcb+MW5mK7s+c8cRJmKHwTaeJtAjIZB
         wVMzXdzEGMlKn6kVvTL/MJSrLutiDtYs+/iRZ4hxrXh/i7n9YqyFD4WCnFRZGtDQ1tQL
         1D4S7Avh62QdA0XaLh6Rk7C/u4/u2Vrqiol/IWeTtMb9LfAxH7tIiv2OPXRxPCx6DC1A
         PSf6PW/nE+iJOR6As92TQ4LxjOFjZBS8CnifmPEjQu3H9llO7qJwoR233ZXRLtITQ4JF
         AnSg==
X-Gm-Message-State: AOJu0Yzte+nZAu9w6/pzULqUTI5ttaL+ju77Xi1nBE7WThOKqpOmvAs+
        ZJkdV2tzxiPCWKTwhZWroQR+pjpQH92rXGQZZMY=
X-Google-Smtp-Source: AGHT+IERHdps2mDqYu+cJwU2VeQoE7qdSuzm9UauaAFviG9kxq5YZjOrjV5XMnvlUTwUvHfW1jCUkA==
X-Received: by 2002:a7b:c409:0:b0:405:1c19:476d with SMTP id k9-20020a7bc409000000b004051c19476dmr1337246wmi.39.1695806106621;
        Wed, 27 Sep 2023 02:15:06 -0700 (PDT)
Received: from ?IPV6:2a05:6e02:1041:c10:c49e:e1a5:3210:b8c0? ([2a05:6e02:1041:c10:c49e:e1a5:3210:b8c0])
        by smtp.googlemail.com with ESMTPSA id 4-20020a05600c22c400b00405bbfd5d16sm5076799wmg.7.2023.09.27.02.15.05
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 27 Sep 2023 02:15:06 -0700 (PDT)
Message-ID: <28a739a6-b3c8-6d7d-3eba-3bec41cd4b1e@linaro.org>
Date:   Wed, 27 Sep 2023 11:15:05 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.13.0
Subject: Re: [PATCH v1 03/13] ACPI: thermal: Collapse trip devices update
 function wrappers
Content-Language: en-US
To:     "Rafael J. Wysocki" <rjw@rjwysocki.net>,
        Linux PM <linux-pm@vger.kernel.org>
Cc:     LKML <linux-kernel@vger.kernel.org>,
        Linux ACPI <linux-acpi@vger.kernel.org>,
        Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>,
        Zhang Rui <rui.zhang@intel.com>,
        Lukasz Luba <lukasz.luba@arm.com>,
        "Rafael J. Wysocki" <rafael@kernel.org>
References: <1957441.PYKUYFuaPT@kreacher> <3198428.5fSG56mABF@kreacher>
From:   Daniel Lezcano <daniel.lezcano@linaro.org>
In-Reply-To: <3198428.5fSG56mABF@kreacher>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-3.6 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

On 21/09/2023 19:50, Rafael J. Wysocki wrote:
> From: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
> 
> In order to reduce code duplicationeve further, merge
> acpi_thermal_update_passive/active_devices() into one function
> called acpi_thermal_update_trip_devices() that will be used for
> updating both the passive and active trip points.
> 
> No intentional functional impact.
> 
> Signed-off-by: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
> ---

Reviewed-by: Daniel Lezcano <daniel.lezcano@linaro.org>


-- 
<http://www.linaro.org/> Linaro.org │ Open source software for ARM SoCs

Follow Linaro:  <http://www.facebook.com/pages/Linaro> Facebook |
<http://twitter.com/#!/linaroorg> Twitter |
<http://www.linaro.org/linaro-blog/> Blog

