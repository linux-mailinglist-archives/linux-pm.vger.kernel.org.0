Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 06FC3590E9B
	for <lists+linux-pm@lfdr.de>; Fri, 12 Aug 2022 12:03:08 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231237AbiHLKDG (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Fri, 12 Aug 2022 06:03:06 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51872 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238001AbiHLKDF (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Fri, 12 Aug 2022 06:03:05 -0400
Received: from mail-lf1-x130.google.com (mail-lf1-x130.google.com [IPv6:2a00:1450:4864:20::130])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 95692A9252
        for <linux-pm@vger.kernel.org>; Fri, 12 Aug 2022 03:03:04 -0700 (PDT)
Received: by mail-lf1-x130.google.com with SMTP id e15so728964lfs.0
        for <linux-pm@vger.kernel.org>; Fri, 12 Aug 2022 03:03:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc;
        bh=7XCMouDowcv3LrNhIXPQ3Y5PTFI9QQ/MPyoPgacMrBE=;
        b=rhZ1Y8wuTv6tETnnEUcu4kXuxhUVCd0Qjj2ZcY6rurXdhS0cLI1z94igGIm1ACF9CQ
         eI6hgdo1Qcy7RHQWrPDQq8qKRYy79Rg7NCZfQqcjXDPQx+bd7NsgAOChY7HIwgjrDQ/A
         m3XCgqp6t4YfllXTM4SSGuEjUd7FPs7E26XM9jtnd1xIxFSQlwNZx2gCGeTVTZrVaLmp
         lZjFMuDC3Gtr7WtmrzP8hlATvkxtQJn3MUyPZ/32g7w0cixe0KS6a6ArHfsrREbTQMoV
         PXD6UNO7f1+eoOijDjSFWQziCeRYlpR2qQuNorYAmPQS3WvJk2CRQZLwXZWNVKh+bKUr
         G9xA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc;
        bh=7XCMouDowcv3LrNhIXPQ3Y5PTFI9QQ/MPyoPgacMrBE=;
        b=lLyi6Jn826GHlLrJgkCi9EyLiQHphtOA2g7Qd4lpLkCgHN+UsV9qeIG3l+c6w8AFwy
         8Ly9Nt+OW0mAQIkEDrVzd8VxmlrEjZTv+YAugkL8UNKaEXHy4bHwX+iauiWLDGDGacce
         +nJhYVJsra7+1IQgKfDdPkfRcWMqdJOi2Op4fayjBdKMPxXt76AC6PVO0c3L8Z6yPktc
         kCHcpLYlelYmpKKOy10yokYVGOlY6vH6wBYaxVqMZBB6t4DXHm0UxColATDHCzK5vAPd
         CiUz8HUHwV3onWN7NLX2sjiqoiiQMmp36r4Adcl6ruzqADCENpp6tYUyG3b3ffaUWSK8
         FlJA==
X-Gm-Message-State: ACgBeo2SIoQolbPY8DwqZXrE6zgHfHh5hPPwAagxVHous2U+OTiLDXDv
        487vS1B8PZNKULACBdYVTg78NA==
X-Google-Smtp-Source: AA6agR4Q2zKJuK5lITEVBPgcjvjTJoOGAyrwneRqBBawJ91Q6mMigIMsYYnZ8xwOnk8YuaziOl5CDQ==
X-Received: by 2002:a05:6512:a8f:b0:48b:685b:4ebc with SMTP id m15-20020a0565120a8f00b0048b685b4ebcmr976744lfu.258.1660298582823;
        Fri, 12 Aug 2022 03:03:02 -0700 (PDT)
Received: from [192.168.1.39] ([83.146.140.105])
        by smtp.gmail.com with ESMTPSA id l6-20020a19c206000000b0048a9f1933f2sm155333lfc.247.2022.08.12.03.02.59
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 12 Aug 2022 03:03:02 -0700 (PDT)
Message-ID: <a9a0e625-6476-02b4-18ba-9ab2e4e9925b@linaro.org>
Date:   Fri, 12 Aug 2022 13:02:57 +0300
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.12.0
Subject: Re: [PATCH v2 18/26] thermal/drivers/exynos: Replace
 of_thermal_is_trip_valid() by thermal_zone_get_trip()
Content-Language: en-US
To:     Daniel Lezcano <daniel.lezcano@linaro.org>, rafael@kernel.org
Cc:     rui.zhang@intel.com, linux-pm@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        Bartlomiej Zolnierkiewicz <bzolnier@gmail.com>,
        Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>,
        Amit Kucheria <amitk@kernel.org>,
        Alim Akhtar <alim.akhtar@samsung.com>,
        "open list:SAMSUNG THERMAL DRIVER" 
        <linux-samsung-soc@vger.kernel.org>,
        "moderated list:ARM/SAMSUNG S3C, S5P AND EXYNOS ARM ARCHITECTURES" 
        <linux-arm-kernel@lists.infradead.org>
References: <20220809220436.711020-1-daniel.lezcano@linaro.org>
 <20220809220436.711020-19-daniel.lezcano@linaro.org>
From:   Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
In-Reply-To: <20220809220436.711020-19-daniel.lezcano@linaro.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

On 10/08/2022 01:04, Daniel Lezcano wrote:
> Signed-off-by: Daniel Lezcano <daniel.lezcano@linaro.org>

Missing commit msg.

> ---
>  drivers/thermal/samsung/exynos_tmu.c | 12 +++++++++---
>  1 file changed, 9 insertions(+), 3 deletions(-)



Best regards,
Krzysztof
