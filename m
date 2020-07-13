Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 86BAB21D3C0
	for <lists+linux-pm@lfdr.de>; Mon, 13 Jul 2020 12:29:03 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729043AbgGMK3C (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Mon, 13 Jul 2020 06:29:02 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47236 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727035AbgGMK3C (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Mon, 13 Jul 2020 06:29:02 -0400
Received: from mail-wr1-x442.google.com (mail-wr1-x442.google.com [IPv6:2a00:1450:4864:20::442])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D72D3C061755
        for <linux-pm@vger.kernel.org>; Mon, 13 Jul 2020 03:29:01 -0700 (PDT)
Received: by mail-wr1-x442.google.com with SMTP id z2so15690946wrp.2
        for <linux-pm@vger.kernel.org>; Mon, 13 Jul 2020 03:29:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=3MJX5x5YwOBMETG5rGZnV0iZGjYD8NtnFnnMSRYbSiA=;
        b=wbrqOCwaE5Lrdh5sth6gvUV9+kdt8nDAVw6kTEFQEoIr6lB9BhI8hULrjO4swEcZ71
         CyTJo6bPo7TDNfcXoobVGcX1n2DjDv5d/lVO1S6QZPqS77ANfajhhN3OtL8rxAkD/Ryn
         R86Drdxu5CHmRmxYuL3T2gGccFaa1dNZAxNRQGgUZZ515YCGkOBKUrP2+6WXgj1UQAUf
         qJzIO0dzIWp+rlOvctUbAYkEOSZasleU1SMYxsybVMPoiRqJk2P1XOnuk9Xs07yzauA7
         zuCGVAaLRMWnX3DjcT6C8OTcn4+cVD4xdMiHrjNtKfMwj+9ZgABItg9FKzTyhs0IEzg2
         qxCw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=3MJX5x5YwOBMETG5rGZnV0iZGjYD8NtnFnnMSRYbSiA=;
        b=QQ2m7WAmKERstLZ8iFTaqW5Y5Fuj6un6tFli3FJMAVaAoeAn9o3RjdxVI/GwLIOemW
         o95244jLmdCIN9SmX40vVPDecbzzszy4Ux9GHLoWh0PwHTP+b6Y6L/1+XtsOgCY1td7X
         mLgBimL0GHSa6HL57v7iFv3QGgfuecSazl1ns4THKOT4pc5BWRqaP88/4+QicB7lpeiO
         KJfEMGSmWw8AGinQHuD7apbhun9GrtXzc7RRAuRrQA63vNBsPTM0RNbDqLesQWaaj3ST
         i/M8R4ZrozT1itsfax31ees35jKbm/xEHqHsQlp4BiGrnQbPvCY5x5A/NRK9AKkQ0gJ9
         MGDQ==
X-Gm-Message-State: AOAM531DIQ3TOpBP6QZbkTiTFBbuM8J39V2IDFohAGk80cHrjYFkfKJw
        RpXK4L0hN+VtP+D6wCuESzt75Q==
X-Google-Smtp-Source: ABdhPJx5eiayCX5gKHrF27TtdrsfGxYcPWYLSfX24i9X7ZnmB1weVmvQ2a9Sinp8q04khH2B8N/Sog==
X-Received: by 2002:a5d:6912:: with SMTP id t18mr77882766wru.411.1594636140316;
        Mon, 13 Jul 2020 03:29:00 -0700 (PDT)
Received: from ?IPv6:2a01:e34:ed2f:f020:501b:b12d:3463:93f8? ([2a01:e34:ed2f:f020:501b:b12d:3463:93f8])
        by smtp.googlemail.com with ESMTPSA id u23sm25191253wru.94.2020.07.13.03.28.59
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 13 Jul 2020 03:28:59 -0700 (PDT)
Subject: Re: [PATCH v4 4/4] thermal: core: Add notifications call in the
 framework
To:     Marek Szyprowski <m.szyprowski@samsung.com>, rui.zhang@intel.com
Cc:     srinivas.pandruvada@linux.intel.com, rkumbako@codeaurora.org,
        amit.kucheria@linaro.org, linux-kernel@vger.kernel.org,
        linux-pm@vger.kernel.org,
        Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>
References: <20200706105538.2159-1-daniel.lezcano@linaro.org>
 <20200706105538.2159-4-daniel.lezcano@linaro.org>
 <CGME20200706131708eucas1p1487955a7632584c17df724399f48825a@eucas1p1.samsung.com>
 <c7ed6c63-cbb5-07dc-c292-2c473af8c4fb@samsung.com>
 <23c5830d-0a7c-9e87-e859-821d2dccb200@linaro.org>
 <8a34e9c4-6457-cfd2-3d05-05f80a630a0d@samsung.com>
 <41466d5a-24fb-b861-93ae-3ed190af7174@samsung.com>
From:   Daniel Lezcano <daniel.lezcano@linaro.org>
Message-ID: <adfbb6a5-4cce-a1f3-c6a7-a56a72ac38ba@linaro.org>
Date:   Mon, 13 Jul 2020 12:28:58 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.8.0
MIME-Version: 1.0
In-Reply-To: <41466d5a-24fb-b861-93ae-3ed190af7174@samsung.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

On 13/07/2020 11:31, Marek Szyprowski wrote:
> Hi
> 
> On 07.07.2020 11:15, Marek Szyprowski wrote:
>> On 06.07.2020 15:46, Daniel Lezcano wrote:
>>> On 06/07/2020 15:17, Marek Szyprowski wrote:
>>>> On 06.07.2020 12:55, Daniel Lezcano wrote:
>>>>> The generic netlink protocol is implemented but the different
>>>>> notification functions are not yet connected to the core code.
>>>>>
>>>>> These changes add the notification calls in the different
>>>>> corresponding places.
>>>>>
>>>>> Reviewed-by: Amit Kucheria <amit.kucheria@linaro.org>
>>>>> Signed-off-by: Daniel Lezcano <daniel.lezcano@linaro.org>
>>>> This patch landed in today's linux-next 20200706 as commit 5df786e46560
>>>> ("thermal: core: Add notifications call in the framework"). Sadly it
>>>> breaks booting various Samsung Exynos based boards. Here is an example
>>>> log from Odroid U3 board:

Does it break also arm64 platforms?


-- 
<http://www.linaro.org/> Linaro.org │ Open source software for ARM SoCs

Follow Linaro:  <http://www.facebook.com/pages/Linaro> Facebook |
<http://twitter.com/#!/linaroorg> Twitter |
<http://www.linaro.org/linaro-blog/> Blog
