Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id ADCF75BA050
	for <lists+linux-pm@lfdr.de>; Thu, 15 Sep 2022 19:20:43 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229924AbiIORUh (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Thu, 15 Sep 2022 13:20:37 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36426 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229904AbiIORUg (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Thu, 15 Sep 2022 13:20:36 -0400
Received: from mail-wm1-x329.google.com (mail-wm1-x329.google.com [IPv6:2a00:1450:4864:20::329])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 17E7249B43
        for <linux-pm@vger.kernel.org>; Thu, 15 Sep 2022 10:20:34 -0700 (PDT)
Received: by mail-wm1-x329.google.com with SMTP id ay36so4757107wmb.0
        for <linux-pm@vger.kernel.org>; Thu, 15 Sep 2022 10:20:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date;
        bh=GMQu+Y5MmIbydykdiifw+beEBbT3HPvfrEgmPiWWPA4=;
        b=C9sQs9sk1ckiPcvzOIsgVxkZl7PhKg8R3xxYZG8w1Re81id1DuBl24tWMV6fJIMuAh
         7Jh1BUO+vpE+d7M09+aeNubo5Qou7BItDPmnhLpbMYIOULmwHvCgwHNqOVJBWXsGFD4R
         8xQIVU9cqnq4pqvoBwKJip18cRkUIwqHffNJ27LOtjuw8Dd0JCVr3YV0QpfhaGXK2uHd
         Vsgsi0YLbgVVOgP3oIglxUNHlBE06zfkDFvattpKst0rAlk8aez4WGJmLXHnIpG/7cyv
         2Ri4Q3fekfYMye/xvD4nmOShZfj6zfpqOCiYP9wHQ19lrOmnjAg5o8CJmY5pvU91xjdo
         osUA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date;
        bh=GMQu+Y5MmIbydykdiifw+beEBbT3HPvfrEgmPiWWPA4=;
        b=VJ+5gZCvqfdLGWxbZ6rCr2spwcl201TOSLHGF1shMtCUJrkiesLWwiz5RSb0rwDhGa
         lqb8P4wat/sSwkZXWH+CBh37rS1S5r15FMDHzwXPr4Lu2QdweyJzB0RSyHNfor3p56k/
         zSPXlP4/kiOB2AKOKuuS95BWihBmBprP7SfvdM7oTJWBLfCYnk4DTsRw7riJxrfaLDs3
         5q7iOy7GxURyhWyQlxQu3GdweGZFaU5fE6Kw8sOd5DA2Z6dK9xB8wYYQHvz4q1DKzlx4
         OTiYyAOQt1FScEUaP21Rp7ED34XjMl6yMyg7AVYWyhHDedGWrQe904TSBLxLGLj6xSge
         Oxjw==
X-Gm-Message-State: ACrzQf2R+FnxxZKlGBtVpxJHBtcDqO2Xf/IdbCY7uj2prhJyF/Y1pxiJ
        2hZ43BFJ2vXaDNn65z2Nkev1QQ==
X-Google-Smtp-Source: AMsMyM6G4CD/tMHlq2tzVSbpToSXOyOrtSoAAC5uClinvbXwxCGIVWwya+GRyFBf6LQxfXbbcQ914Q==
X-Received: by 2002:a05:600c:5122:b0:3b4:768d:f491 with SMTP id o34-20020a05600c512200b003b4768df491mr680108wms.68.1663262432570;
        Thu, 15 Sep 2022 10:20:32 -0700 (PDT)
Received: from [192.168.2.1] (146725694.box.freepro.com. [130.180.211.218])
        by smtp.googlemail.com with ESMTPSA id o11-20020a05600c510b00b003a845621c5bsm3408304wms.34.2022.09.15.10.20.28
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 15 Sep 2022 10:20:32 -0700 (PDT)
Message-ID: <789f2638-b4da-146d-64ce-3e156428bcd7@linaro.org>
Date:   Thu, 15 Sep 2022 19:20:19 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.11.0
Subject: Re: [PATCH v4 0/4] thermal: mediatek: Add support for MT8365 SoC
Content-Language: en-US
To:     Amjad Ouled-Ameur <aouledameur@baylibre.com>,
        matthias.bgg@gmail.com
Cc:     rafael@kernel.org, fparent@baylibre.com, amitk@kernel.org,
        devicetree@vger.kernel.org, krzysztof.kozlowski+dt@linaro.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        linux-mediatek@lists.infradead.org, linux-pm@vger.kernel.org,
        robh+dt@kernel.org, rui.zhang@intel.com
References: <20220909073609.32337-1-aouledameur@baylibre.com>
From:   Daniel Lezcano <daniel.lezcano@linaro.org>
In-Reply-To: <20220909073609.32337-1-aouledameur@baylibre.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-3.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

On 09/09/2022 09:36, Amjad Ouled-Ameur wrote:
> This patchset adds thermal support for MT8365 SoC which contains three
> thermal sensors.
> 
> Changes in V4:
> - rebased on thermal/linux-next
> - Use callback for raw_to_mcelsius()
> - Use struct 'struct thermal_zone_device_ops' instead of
> no longer existent 'struct thermal_zone_of_device_ops'
> 
> Amjad Ouled-Ameur (1):
>    thermal: mediatek: add another get_temp ops for thermal sensors
> 
> Fabien Parent (2):
>    dt-bindings: thermal: mediatek: add binding documentation for MT8365
>      SoC
>    thermal: mediatek: add support for MT8365 SoC
> 
> Markus Schneider-Pargmann (1):
>    thermal: mediatek: control buffer enablement tweaks
> 
>   .../bindings/thermal/mediatek-thermal.txt     |   1 +
>   drivers/thermal/mtk_thermal.c                 | 197 +++++++++++++++---
>   2 files changed, 166 insertions(+), 32 deletions(-)

The series does not apply on the thermal tree.

Please refresh the series against:

https://git.kernel.org/pub/scm/linux/kernel/git/thermal/linux.git/log/?h=thermal/linux-next

Thanks

   -- D.

-- 
<http://www.linaro.org/> Linaro.org │ Open source software for ARM SoCs

Follow Linaro:  <http://www.facebook.com/pages/Linaro> Facebook |
<http://twitter.com/#!/linaroorg> Twitter |
<http://www.linaro.org/linaro-blog/> Blog
