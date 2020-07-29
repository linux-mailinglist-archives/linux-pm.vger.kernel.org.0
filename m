Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 63FF8231B5C
	for <lists+linux-pm@lfdr.de>; Wed, 29 Jul 2020 10:40:13 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726710AbgG2IkM (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Wed, 29 Jul 2020 04:40:12 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34212 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726707AbgG2IkL (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Wed, 29 Jul 2020 04:40:11 -0400
Received: from mail-wr1-x441.google.com (mail-wr1-x441.google.com [IPv6:2a00:1450:4864:20::441])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0D141C0619D2
        for <linux-pm@vger.kernel.org>; Wed, 29 Jul 2020 01:40:11 -0700 (PDT)
Received: by mail-wr1-x441.google.com with SMTP id r12so20736464wrj.13
        for <linux-pm@vger.kernel.org>; Wed, 29 Jul 2020 01:40:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=YJUVSZqIXAUcxRK135uPMY26TWenUYdXUZWwq11zSBY=;
        b=MqLsZu9YbOlKS6mFOepKH+8KAfFJ/mtQQ0W+tGHPTucR2LdBY1Q2npnk0CTYTUS82h
         v9DXVj08hSt0kgyjKdoOiFBiDeVm3mN0e0cH5SF2aXtwwKbqUGuWParVuF+FOIY6B9gu
         nKIxdcOP6Qlhvc8mKlcrghAM9VRsEDDMlPJbPBRZYj7C0flFcABs9hdykujWP/lbuoDA
         lfMZx4bKXqnfr1p7MTXunNw5H7vnkDZX9KMEyp+HYWB9k7PyO/yV1VClXzcCBBG3M0Yj
         WIMP2O9oXMJ4hwdq2iOJPGyCsPgyKU9TDPYTjek/WVV1BVvvemro+FkmjnfDBs26YF4I
         PyYg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=YJUVSZqIXAUcxRK135uPMY26TWenUYdXUZWwq11zSBY=;
        b=FuFf+QLQQlDFbc4rTVynfMCEkJf7uO/KlPpJy7VOQCK0k056shCcgA+Kr2GU2qXiiZ
         K0jopJfwGC8UGMMRMH5yrbVcEC+k98Dikg6mBVW53UH57WK0zRYb6taf3r4o8dpTntl5
         R6ztJKn4AZT8O7ds/7/IfrRcTqf1a+ZYVuzfS5Ihq9A47pgFHMA49BI/8NN5oWZIW7V0
         Z9HZKRrQoWdcYrRVzvpRrl1M6HUcYGCNZ6sDaehgtZE08j3I6TWaPmsmPSfY1MPhkN70
         /bUYBeHlHAxz62SdfXgSnQAl9uma9L/wMq+/sFLQRIqmgz2qjN/omCTCK57OscTs++cZ
         dlOQ==
X-Gm-Message-State: AOAM532/82LGNB8hJUecmW/LFrTsSJAanAAIjqcsbObUIuCnvRkd+FPG
        Oi3vodl/Z1Cd7UNcfPQeA7HXrw==
X-Google-Smtp-Source: ABdhPJw5yvp3nWT258bEQHmRZ9EmQ9SNB++YPU6N3KfBaR1N4H9HAOwkeizVkcJsFE7XH06WG/cGTA==
X-Received: by 2002:adf:fd41:: with SMTP id h1mr30692686wrs.124.1596012009544;
        Wed, 29 Jul 2020 01:40:09 -0700 (PDT)
Received: from ?IPv6:2a01:e34:ed2f:f020:812d:95b8:6384:6e20? ([2a01:e34:ed2f:f020:812d:95b8:6384:6e20])
        by smtp.googlemail.com with ESMTPSA id x9sm3752135wmk.45.2020.07.29.01.40.08
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 29 Jul 2020 01:40:08 -0700 (PDT)
Subject: Re: [PATCH] thermal: core: Add thermal zone enable/disable
 notification
To:     Amit Kucheria <amit.kucheria@linaro.org>
Cc:     Zhang Rui <rui.zhang@intel.com>,
        Andrzej Pietrasiewicz <andrzej.p@collabora.com>,
        Linux PM list <linux-pm@vger.kernel.org>,
        LKML <linux-kernel@vger.kernel.org>,
        Thierry Reding <thierry.reding@gmail.com>
References: <20200727231033.26512-1-daniel.lezcano@linaro.org>
 <CAHLCerO=KPUR-2qEuFpNV9UUV_O7GoXY-EPhyefOFfL_jZ_0gA@mail.gmail.com>
From:   Daniel Lezcano <daniel.lezcano@linaro.org>
Message-ID: <90f14da8-a197-08cb-cf55-5c88fa8eed58@linaro.org>
Date:   Wed, 29 Jul 2020 10:40:08 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
MIME-Version: 1.0
In-Reply-To: <CAHLCerO=KPUR-2qEuFpNV9UUV_O7GoXY-EPhyefOFfL_jZ_0gA@mail.gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

On 29/07/2020 07:36, Amit Kucheria wrote:
> On Tue, Jul 28, 2020 at 4:40 AM Daniel Lezcano
> <daniel.lezcano@linaro.org> wrote:
>>
>> Now the calls to enable/disable a thermal zone are centralized in a
>> call to a function, we can add in these the corresponding netlink
>> notifications.
>>
>> Signed-off-by: Daniel Lezcano <daniel.lezcano@linaro.org>
> 
> Reviewed-by: Amit Kucheria <amit.kucheria@linaro.org>

I've applied the changes, thanks for the review.


-- 
<http://www.linaro.org/> Linaro.org │ Open source software for ARM SoCs

Follow Linaro:  <http://www.facebook.com/pages/Linaro> Facebook |
<http://twitter.com/#!/linaroorg> Twitter |
<http://www.linaro.org/linaro-blog/> Blog
