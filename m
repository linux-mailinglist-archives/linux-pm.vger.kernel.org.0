Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1D2DE7B1451
	for <lists+linux-pm@lfdr.de>; Thu, 28 Sep 2023 09:13:33 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231339AbjI1HNb (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Thu, 28 Sep 2023 03:13:31 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36526 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231324AbjI1HNP (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Thu, 28 Sep 2023 03:13:15 -0400
Received: from mail-wm1-x32e.google.com (mail-wm1-x32e.google.com [IPv6:2a00:1450:4864:20::32e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AAD9BCC4
        for <linux-pm@vger.kernel.org>; Thu, 28 Sep 2023 00:10:30 -0700 (PDT)
Received: by mail-wm1-x32e.google.com with SMTP id 5b1f17b1804b1-40572aeb673so97571485e9.0
        for <linux-pm@vger.kernel.org>; Thu, 28 Sep 2023 00:10:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1695885027; x=1696489827; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=VkIBE+TCRLRjYetF+cyx1hJuGQDYf3kDYmaiNSOiVj8=;
        b=ToJAxIDp6VFXWlWb9DUZLg5P7nRl9fmM4fKmYEhYvJCfiPil3rk7zNjn1yA8z1WpHc
         gfT09oiqoHSOsb29kRx0tFs9gDqPCQ7PiR+S7rdgM/+BxJp7W+avKLgHFZ33STC14Q6Z
         PVZZA/PTN6jS0DC/MCcjgEX5rkPK3YAwmkaT51xs03yu6MZKPxgtBx9mAK8G96voUFGd
         tSAXJU6Pp8lswGLUf3f7Yhf2UQ+n2DEPz/6N5natsNnZvKF7+Sq7JGzAlJDvSs7bX+k7
         O73fuvtNp0mNN666XKwMFE3zgV3GFG1JbkqHl3Tgyv6+4LnggB0CJ0rRTSKXpC1Hh7Vo
         gkuA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1695885027; x=1696489827;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=VkIBE+TCRLRjYetF+cyx1hJuGQDYf3kDYmaiNSOiVj8=;
        b=ua7xo4KOam1m8yxKuPzT1FuwAcPWpoTotuveF+p25fwhB/dBUKH7zxqzOb+hX2W3Rz
         Zk2CzPAQZ+2aVYXBTzGGLjz7G5xAuv+m/mYlgpyXcLdc5TGgUmQAkrgKAZvFG1Y4zm9G
         gizPVLfPPm2zAtRH1pxb+rh1efFfnE5zfG3NtodcyR6UkWn8Jq5sunPOEhFOuW521h2m
         mggAiL9QPGloiPPPRt0wbZ84bhOJ4KZW5EIhAIZpJm/suCg+Km3aTCupwOOEOGs6G22s
         jMUoky//Te0RkE17/hTJDmyOSsbm0orlLK6a9NX9PcdIJHbbbhAjHWKHkYW0GCjQvXbB
         99sg==
X-Gm-Message-State: AOJu0Yy+1B8IjiEI5NqCVe+8uHx6GKOHFLXYVvPKxP0fM/9DM51Lu+0Q
        F6JS/e00cgk2oCURCNgNqi7fUA==
X-Google-Smtp-Source: AGHT+IGNaZcVgF8TWexpbmorAxSeNepOwNaCRGtwfaC9auOLiO/MLnnmv7ZMk5XMR5I+ZC87mTNoRQ==
X-Received: by 2002:a05:600c:b4e:b0:402:95a0:b2ae with SMTP id k14-20020a05600c0b4e00b0040295a0b2aemr405295wmr.32.1695885027206;
        Thu, 28 Sep 2023 00:10:27 -0700 (PDT)
Received: from ?IPV6:2a05:6e02:1041:c10:c49e:e1a5:3210:b8c0? ([2a05:6e02:1041:c10:c49e:e1a5:3210:b8c0])
        by smtp.googlemail.com with ESMTPSA id a24-20020a05600c225800b004063c9f68f2sm5664262wmm.26.2023.09.28.00.10.26
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 28 Sep 2023 00:10:26 -0700 (PDT)
Message-ID: <065636fa-e6ac-4fcb-5d78-b3f281ac4609@linaro.org>
Date:   Thu, 28 Sep 2023 09:10:26 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.13.0
Subject: Re: [PATCH v1 10/13] thermal: core: Allow trip pointers to be used
 for cooling device binding
Content-Language: en-US
To:     "Rafael J. Wysocki" <rjw@rjwysocki.net>,
        Linux PM <linux-pm@vger.kernel.org>
Cc:     LKML <linux-kernel@vger.kernel.org>,
        Linux ACPI <linux-acpi@vger.kernel.org>,
        Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>,
        Zhang Rui <rui.zhang@intel.com>,
        Lukasz Luba <lukasz.luba@arm.com>,
        "Rafael J. Wysocki" <rafael@kernel.org>
References: <1957441.PYKUYFuaPT@kreacher> <45837158.fMDQidcC6G@kreacher>
From:   Daniel Lezcano <daniel.lezcano@linaro.org>
In-Reply-To: <45837158.fMDQidcC6G@kreacher>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-3.6 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

On 21/09/2023 20:01, Rafael J. Wysocki wrote:
> From: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
> 
> Add new helper functions, thermal_bind_cdev_to_trip() and
> thermal_unbind_cdev_from_trip(), to allow a trip pointer to be used for
> binding a cooling device to a trip point and unbinding it, respectively,
> and redefine the existing helpers, thermal_zone_bind_cooling_device()
> and thermal_zone_unbind_cooling_device(), as wrappers around the new
> ones, respectively.
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

