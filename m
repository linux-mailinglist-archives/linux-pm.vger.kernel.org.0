Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 456615C010E
	for <lists+linux-pm@lfdr.de>; Wed, 21 Sep 2022 17:24:19 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230034AbiIUPYR (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Wed, 21 Sep 2022 11:24:17 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57842 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229774AbiIUPYQ (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Wed, 21 Sep 2022 11:24:16 -0400
Received: from mail-lf1-x12b.google.com (mail-lf1-x12b.google.com [IPv6:2a00:1450:4864:20::12b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3B6BF8E4D6
        for <linux-pm@vger.kernel.org>; Wed, 21 Sep 2022 08:24:15 -0700 (PDT)
Received: by mail-lf1-x12b.google.com with SMTP id o2so9774161lfc.10
        for <linux-pm@vger.kernel.org>; Wed, 21 Sep 2022 08:24:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date;
        bh=IkfBzR1pPL4sqH+SzuxDp3p3OntI0w5vunqXgMMZcmo=;
        b=rNBsowUvNyhij2xBv5rDeBpR/yfpdhLrm03ppABwWh8FFbkd/2LG/aHo3skupAQDvq
         56axzEakXeiqhXDy7AL26VkZtFfcHWwtdDe7XC+F2XHK6QeAcQYI7YriAKuk8Q5jXif8
         DSg6iPIcvh4ipe9t90qFpASbcrJ0LsjFYGLGCwAKGqQAH5wJ8z6tI3sV883v1vc4yrKZ
         nmAO6qHeNrD0KQbj8HPcIqlCkJSHP8ftl1/rhz9RsJo/kohlgbdJNfP/ruplDpE9Bkxz
         AemZrWm0VrxTeapXQRFbKWRNUqYeR3p5PgqWvjDHhYb+59d84pFwkPxkmCMupiX/jFmN
         kq7g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date;
        bh=IkfBzR1pPL4sqH+SzuxDp3p3OntI0w5vunqXgMMZcmo=;
        b=5lrR/AOcXdnZPuWQA29Ne2ki5VpU3DikVyM8E7+vM3bVBVSqu2N/O0QCMdWCdnHyLA
         sItcnJCwA+xcs6b7YMdsmqgiknh3ai/c36V9MKXB2DvlmPAJfE3IDP+DLBq9QBQRMDyV
         a9UF9m5XSEczX48M52r2Oeepzdy9sUW/IozJr9kNSniv6FkiKEulpBdgAmXS/pcxX0Dx
         VV3kQM5GGrc7pIDR/4nkD4WYPLjfxjtf5RvZQ6K0EnxLi08xNJ9iQotNbzKhkKkEO4V/
         aiydwXIeeyTpiNeRDznPGTYvWl/jJKWZYb/FoAURzEfRBuoq4qjNgRirnB4KkAjumcKa
         m+Gg==
X-Gm-Message-State: ACrzQf2cGKwE9bcMKOoyWcmTXTBkJXCAiejwzyO+OTQzvIlygLBKXc0Z
        ekAehpZizWMSwp3McBz+JOBAng==
X-Google-Smtp-Source: AMsMyM6t3a9lk8UQZAxKjOsgUpQi1lKsFwa3+vxfPNHOsjx9aGEV8R/rZQ6AF7qqASbhYiSJ3jVZyA==
X-Received: by 2002:a05:6512:c13:b0:49f:9a2f:8b86 with SMTP id z19-20020a0565120c1300b0049f9a2f8b86mr6452173lfu.413.1663773853473;
        Wed, 21 Sep 2022 08:24:13 -0700 (PDT)
Received: from [192.168.0.21] (78-11-189-27.static.ip.netia.com.pl. [78.11.189.27])
        by smtp.gmail.com with ESMTPSA id z18-20020a19f712000000b0049adbc24b99sm483777lfe.24.2022.09.21.08.24.12
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 21 Sep 2022 08:24:13 -0700 (PDT)
Message-ID: <a1ec1143-6340-8572-c46b-0a4f923d7a92@linaro.org>
Date:   Wed, 21 Sep 2022 17:24:12 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.2.2
Subject: Re: [PATCH v4 10/30] thermal/drivers/exynos: Replace
 of_thermal_is_trip_valid() by thermal_zone_get_trip()
Content-Language: en-US
To:     Daniel Lezcano <daniel.lezcano@linaro.org>, rafael@kernel.org
Cc:     linux-kernel@vger.kernel.org, linux-pm@vger.kernel.org,
        rui.zhang@intel.com,
        Bartlomiej Zolnierkiewicz <bzolnier@gmail.com>,
        Amit Kucheria <amitk@kernel.org>,
        Alim Akhtar <alim.akhtar@samsung.com>,
        "open list:SAMSUNG THERMAL DRIVER" 
        <linux-samsung-soc@vger.kernel.org>,
        "moderated list:ARM/SAMSUNG S3C, S5P AND EXYNOS ARM ARCHITECTURES" 
        <linux-arm-kernel@lists.infradead.org>
References: <20220921094244.606948-1-daniel.lezcano@linaro.org>
 <20220921094244.606948-11-daniel.lezcano@linaro.org>
From:   Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
In-Reply-To: <20220921094244.606948-11-daniel.lezcano@linaro.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-5.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

On 21/09/2022 11:42, Daniel Lezcano wrote:
> The thermal_zone_get_trip() does the same check as
> of_thermal_is_trip_valid(). Replace the call to
> of_thermal_is_trip_valid() by thermal_zone_get_trip().
> 
> Signed-off-by: Daniel Lezcano <daniel.lezcano@linaro.org>
> ---


Reviewed-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>

Best regards,
Krzysztof

