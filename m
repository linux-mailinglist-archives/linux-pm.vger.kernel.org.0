Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BDC85683202
	for <lists+linux-pm@lfdr.de>; Tue, 31 Jan 2023 16:59:27 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232261AbjAaP70 (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Tue, 31 Jan 2023 10:59:26 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37624 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232678AbjAaP7Z (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Tue, 31 Jan 2023 10:59:25 -0500
Received: from mail-wm1-x32a.google.com (mail-wm1-x32a.google.com [IPv6:2a00:1450:4864:20::32a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0656B4DBFA
        for <linux-pm@vger.kernel.org>; Tue, 31 Jan 2023 07:59:21 -0800 (PST)
Received: by mail-wm1-x32a.google.com with SMTP id hn2-20020a05600ca38200b003dc5cb96d46so3849600wmb.4
        for <linux-pm@vger.kernel.org>; Tue, 31 Jan 2023 07:59:20 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=gy60lnqwsFgibbl6FIK3uNd3/3EXRAElNDgEcBOe6pA=;
        b=bv9P5Kz4q7aTMNAlVEYfJ+G/hLuUToqpKB+z0WCbp9oiGBs9Sipam0u38gQTGwIOxD
         G+bmt4cnBdiCtFAKNyiOsELwgIkaXcAoP1XRuPK9tvIrMQWG46L5hMLhIbyF/+aALZab
         jHfVvUb94Eszj7vux5wp4tZET1A4s48Vr6UnI8IS3lMkLk2QbE3w5tAYvHqJAmtuHaPN
         8IjAz2Xbg1EsnUHgtfL85kTcjcaBaLTI6j6pO7HnrLu8ragnvGx1tx3WJJeIsveP6uHM
         bB8qPH+0EhO0pzTCMNsPqnX9MnkwnQnjU4RcdaiDhmSR94uS0owAiUD6Pz8gb4/Goh0C
         4vjQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=gy60lnqwsFgibbl6FIK3uNd3/3EXRAElNDgEcBOe6pA=;
        b=kymquABbFVlIgostdiRwc2QHDYl3LWKx2U+GwySwN1HpVgKN8JLpvVQBU2BqUuE9re
         qSI/pjEaO/uKNjjt0OjU8dIx9oiwLIgNkD0HqTVbMSN96fvdazS/t/Veys3FfxU8CvjR
         jHCIRXW7Mia0wah8NAIgiszFbUMFY1FXL8R+prOzsXZvISqfgmxGYjJxfyM+Vs1Ll7oA
         270Ad21X8PGdZW+S8X/6fK+Vxeau5rEVvrgJyucSck52NoInHwWAof1Lg6H15i2+CW7c
         Kln/+qTJITOflIoYHfkPS7zF9Vc4r6Ct9IMbIj1EZqCrxfxI6QegwtCIJngLlaDPPQMl
         cqVg==
X-Gm-Message-State: AO0yUKWj85AzunxunXVREDAdWBoB/3Lc4g4svls3NNCwfW3ypx0D25FG
        vB4PMnThxxq/kBJbsdAvmFo4ZA==
X-Google-Smtp-Source: AK7set8iRLzAP1Amba9wv39SNh8vQgidfElJUv4Uc88oJ+tBSE6QY2iu8UtAR6V8fLZriHZoEMejwQ==
X-Received: by 2002:a05:600c:4f41:b0:3dc:52fc:7f06 with SMTP id m1-20020a05600c4f4100b003dc52fc7f06mr4028196wmq.41.1675180759368;
        Tue, 31 Jan 2023 07:59:19 -0800 (PST)
Received: from [192.168.10.46] (146725694.box.freepro.com. [130.180.211.218])
        by smtp.googlemail.com with ESMTPSA id g11-20020a5d488b000000b002be5bdbe40csm17120908wrq.27.2023.01.31.07.59.18
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 31 Jan 2023 07:59:19 -0800 (PST)
Message-ID: <e75d5272-f110-4f2f-eb02-65f1e7556bc3@linaro.org>
Date:   Tue, 31 Jan 2023 16:59:18 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.4.2
Subject: Re: [PATCH v1 6/8] thermal: intel: intel_pch: Fold suspend and resume
 routines into their callers
Content-Language: en-US
To:     "Rafael J. Wysocki" <rjw@rjwysocki.net>,
        Linux PM <linux-pm@vger.kernel.org>
Cc:     Zhang Rui <rui.zhang@intel.com>,
        Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>,
        Linux ACPI <linux-acpi@vger.kernel.org>,
        LKML <linux-kernel@vger.kernel.org>,
        David Box <david.e.box@linux.intel.com>
References: <1751684.VLH7GnMWUR@kreacher> <1817848.atdPhlSkOF@kreacher>
From:   Daniel Lezcano <daniel.lezcano@linaro.org>
In-Reply-To: <1817848.atdPhlSkOF@kreacher>
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

On 30/01/2023 20:04, Rafael J. Wysocki wrote:
> From: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
> 
> Fold pch_suspend() and pch_resume(), that each have only one caller,
> into their respective callers to make the code somewhat easier to
> follow.
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

