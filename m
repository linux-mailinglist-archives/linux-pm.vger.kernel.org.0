Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B4693687C8A
	for <lists+linux-pm@lfdr.de>; Thu,  2 Feb 2023 12:44:23 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232099AbjBBLoW (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Thu, 2 Feb 2023 06:44:22 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37242 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231743AbjBBLoV (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Thu, 2 Feb 2023 06:44:21 -0500
Received: from mail-wr1-x42d.google.com (mail-wr1-x42d.google.com [IPv6:2a00:1450:4864:20::42d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 43C197923D
        for <linux-pm@vger.kernel.org>; Thu,  2 Feb 2023 03:44:20 -0800 (PST)
Received: by mail-wr1-x42d.google.com with SMTP id m7so1429855wru.8
        for <linux-pm@vger.kernel.org>; Thu, 02 Feb 2023 03:44:20 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=nCHejXhzVWqFTVZyLcdF4swd6AONbEaaLxACeSyN1HY=;
        b=uvFhN3rLZVF1afPjrHRSt8+dkrUJgBkkEqLZHWcSDHskFxqWoSRc17t8lWVcsj5TKI
         bCrJbXhS4C91YlI91ApwQR4mZbInnmc3/mEiwLMTbBS5dSibfFxRD0L8mE8ppELFhvou
         y9fWBjV9TAlqu7fDSzKMY9KLF8MZvDkBD+Jt/K7fFay54RXA63C8VFH5pewPLEjvlZCW
         lzQy5VGprXMEjMCvC3LTcfVkwyTO3O+gd8jRsLSHTo4IUdfzI1l1V5NAbfiS3G8QIMaj
         MVa8D+YEiL10Wd3lFIFlTzPmQtugWuNGJCYr1cX7ihnMgDWdpJg+WWmydESSjnQIsFgm
         TTCg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=nCHejXhzVWqFTVZyLcdF4swd6AONbEaaLxACeSyN1HY=;
        b=fY9s4VO2HkS2FI26jtBvVVemnOzozrfuTxr21j3DMMx1DFNp36K0ZB3QaLhuMGWB7A
         WV55lPWgrh859BxbNXFc4lT5l9Me/jnsvgsIyqKrvBCa78AWJ194ZIZ55+6GADBdQQz7
         pgfYA8QHxQ2R1pxzMtsNFt1r/TkRwxkdSVWlU7pxbixNtiTLGZyc+vexGUsxq1hAZqlJ
         xcIk/tahPBdz8Fo+FA/bNlR9c36Yz2f8zF39GWfzX9BJ0o2gx3jCFn6EbmdkwhcvLqF4
         dLChjwIC9e0qwA58rXtTWP7gL3TNZZ/l4GdScH+FuyDxSVJGVSew/6LmYoaNVh3yh4mN
         eVNQ==
X-Gm-Message-State: AO0yUKXDBQnjbE7Pmdsi8YB1/X7qBzvkm/DT2D3WvrGSWzjMcHRAU4B6
        eBe5wl/i9OTYeujUlADUgYnyXSPXnvoL/2YS
X-Google-Smtp-Source: AK7set8UU7ws8XjaNdTE+B4sJRlBCk+opRei+C9yXbDCk4VrtIC1lx5AfEbB+AMDV9VVNKM5XTqiUg==
X-Received: by 2002:a5d:598a:0:b0:2bf:ae16:98f4 with SMTP id n10-20020a5d598a000000b002bfae1698f4mr1784314wri.30.1675338258757;
        Thu, 02 Feb 2023 03:44:18 -0800 (PST)
Received: from [192.168.10.46] (146725694.box.freepro.com. [130.180.211.218])
        by smtp.googlemail.com with ESMTPSA id z12-20020a5d4d0c000000b002bbb2d43f65sm19688663wrt.14.2023.02.02.03.44.17
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 02 Feb 2023 03:44:18 -0800 (PST)
Message-ID: <a30c16bc-041d-31c2-dfda-f16b0fa51eca@linaro.org>
Date:   Thu, 2 Feb 2023 12:44:17 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.4.2
Subject: Re: [PATCH v1] thermal: ACPI: Make helpers retrieve temperature only
Content-Language: en-US
To:     "Rafael J. Wysocki" <rjw@rjwysocki.net>,
        Linux PM <linux-pm@vger.kernel.org>,
        Zhang Rui <rui.zhang@intel.com>
Cc:     LKML <linux-kernel@vger.kernel.org>,
        Linux ACPI <linux-acpi@vger.kernel.org>,
        Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>
References: <5641279.DvuYhMxLoT@kreacher>
From:   Daniel Lezcano <daniel.lezcano@linaro.org>
In-Reply-To: <5641279.DvuYhMxLoT@kreacher>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=1.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        RCVD_IN_SBL_CSS,SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no
        version=3.4.6
X-Spam-Level: *
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

On 27/01/2023 19:17, Rafael J. Wysocki wrote:
> From: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
> 
> It is slightly better to make the ACPI thermal helper functions retrieve
> the trip point temperature only instead of doing the full trip point
> initialization, because they are also used for updating some already
> registered trip points, in which case initializing a new trip just
> in order to update the temperature of an existing one is somewhat
> wasteful.
> 
> Modify the ACPI thermal helpers accordingly and update their users.
> 
> No intentional functional impact.
> 
> Signed-off-by: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
> ---

Acked-by: Daniel Lezcano <daniel.lezcano@linaro.org>


-- 
<http://www.linaro.org/> Linaro.org │ Open source software for ARM SoCs

Follow Linaro:  <http://www.facebook.com/pages/Linaro> Facebook |
<http://twitter.com/#!/linaroorg> Twitter |
<http://www.linaro.org/linaro-blog/> Blog

