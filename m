Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0C53D227AA4
	for <lists+linux-pm@lfdr.de>; Tue, 21 Jul 2020 10:29:22 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728638AbgGUI3T (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Tue, 21 Jul 2020 04:29:19 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54970 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727018AbgGUI3S (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Tue, 21 Jul 2020 04:29:18 -0400
Received: from mail-wr1-x443.google.com (mail-wr1-x443.google.com [IPv6:2a00:1450:4864:20::443])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EB8D1C0619D9
        for <linux-pm@vger.kernel.org>; Tue, 21 Jul 2020 01:29:17 -0700 (PDT)
Received: by mail-wr1-x443.google.com with SMTP id q5so20289182wru.6
        for <linux-pm@vger.kernel.org>; Tue, 21 Jul 2020 01:29:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=BCc9lQHutdqUheCKRkROi161ZNJWwY3EPFExUcfdRiQ=;
        b=nQZzuMkvsmF8UEWlQ2eMje2ox6IxIQnvVbZvACyM99WUCNYR4mar5iAsEGOMOc1+kZ
         W47xjV3CaLmGqGyhv+1g8jpHCUH2OllbVfcJnsO2LuTUPFgblr8cB3VkvBPBU0eMoS8C
         bDpo4AnqD9Ze142VKWzYhpOd238YloVY6mGh99Pj3KHwXg4yPC5MPHjeWWDd2+cLLFE7
         VWXzcnWEMofCTSbJPcZGPf78ZW/wwbQR3UBjy0EiNgclwxf6YDw2IB5JTQ5l6nd72jFF
         NzSBCKQA6U6T6hQYX5gxJm4mO0jp49pX79cI2b8LyY7hj/iq16n93wrUPjZMA62YVHHw
         0F4w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=BCc9lQHutdqUheCKRkROi161ZNJWwY3EPFExUcfdRiQ=;
        b=p+GQc7vBDsp0P5cFaPqlyxCI0sufVi0JkRBDVqLhDtKQVvgfUc5OtE6SqXcFAQ4aFJ
         gaQK7CekVXz7tBjcBh57A+HIWs78hPUdojBWafmFYoVpr9ahqksfaeDL6c3/KtyXA0NO
         GSzL2IETsKQufgUSJJqXC7CRvj1O+Py08rcBFSREV+fYcTCqvaQBTkRIy+wQI/FyMMxY
         1pkQx5dTnIor/EDVACEUejPmutTuD0W2CoXRzhpm8JFRN7sRf/7jKEDaDmHwQ/WOvI93
         /zjoHX+1RHhFiqyRfGpyO4qDkzqInBdoLkIR9nXhaaygeGAE5nI/GfkyplXMiyzyoVLu
         iHsQ==
X-Gm-Message-State: AOAM530sC4/8/ZIu4WKszmIvF0ELP9+17vT8e+MX7R8gYXpwYT7dkX4h
        z6pglGMVY7XzmqzpzugVcbox0Q==
X-Google-Smtp-Source: ABdhPJx7ILZH2KvjvBFVVZB5grxQumhwOHm/i3j36nylWvTrt1yjKSBvidlCH5i8FTEEGeIg8iA/PA==
X-Received: by 2002:adf:fb06:: with SMTP id c6mr810292wrr.261.1595320156360;
        Tue, 21 Jul 2020 01:29:16 -0700 (PDT)
Received: from ?IPv6:2a01:e34:ed2f:f020:3590:b402:869a:11fc? ([2a01:e34:ed2f:f020:3590:b402:869a:11fc])
        by smtp.googlemail.com with ESMTPSA id d10sm36006628wrx.66.2020.07.21.01.29.13
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 21 Jul 2020 01:29:15 -0700 (PDT)
Subject: Re: [PATCH v2] dt-bindings: thermal: Get rid of thermal.txt and
 replace references
To:     Amit Kucheria <amit.kucheria@linaro.org>,
        linux-kernel@vger.kernel.org, linux-arm-msm@vger.kernel.org,
        lukasz.luba@arm.com, Sudeep Holla <sudeep.holla@arm.com>,
        "Rafael J. Wysocki" <rjw@rjwysocki.net>,
        Viresh Kumar <viresh.kumar@linaro.org>,
        Thierry Reding <thierry.reding@gmail.com>,
        Jonathan Hunter <jonathanh@nvidia.com>,
        Jean Delvare <jdelvare@suse.com>,
        Guenter Roeck <linux@roeck-us.net>,
        Vasily Khoruzhick <anarsoul@gmail.com>,
        Yangtao Li <tiny.windzz@gmail.com>,
        Zhang Rui <rui.zhang@intel.com>,
        Amit Kucheria <amit.kucheria@verdurent.com>,
        Maxime Ripard <mripard@kernel.org>,
        Chen-Yu Tsai <wens@csie.org>, Talel Shenhar <talel@amazon.com>,
        Florian Fainelli <f.fainelli@gmail.com>,
        Ray Jui <rjui@broadcom.com>,
        Scott Branden <sbranden@broadcom.com>,
        bcm-kernel-feedback-list@broadcom.com,
        Nicolas Saenz Julienne <nsaenzjulienne@suse.de>,
        Andy Gross <agross@kernel.org>,
        Bjorn Andersson <bjorn.andersson@linaro.org>,
        Heiko Stuebner <heiko@sntech.de>,
        Marc Gonzalez <marc.w.gonzalez@free.fr>,
        Mans Rullgard <mans@mansr.com>,
        Matthias Brugger <matthias.bgg@gmail.com>,
        Stefan Wahren <wahrenst@gmx.net>
Cc:     Rob Herring <robh@kernel.org>,
        linux-arm-kernel@lists.infradead.org, devicetree@vger.kernel.org,
        linux-pm@vger.kernel.org, linux-tegra@vger.kernel.org,
        linux-hwmon@vger.kernel.org, linux-rpi-kernel@lists.infradead.org,
        linux-rockchip@lists.infradead.org,
        linux-mediatek@lists.infradead.org
References: <e9aacd33071a00568b67e110fa3bcc4d86d3e1e4.1595245166.git.amit.kucheria@linaro.org>
From:   Daniel Lezcano <daniel.lezcano@linaro.org>
Message-ID: <8c7f5c41-746b-f26d-7b3e-4152c17c4812@linaro.org>
Date:   Tue, 21 Jul 2020 10:29:13 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
MIME-Version: 1.0
In-Reply-To: <e9aacd33071a00568b67e110fa3bcc4d86d3e1e4.1595245166.git.amit.kucheria@linaro.org>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

On 20/07/2020 13:53, Amit Kucheria wrote:
> Now that we have yaml bindings for the thermal subsystem, get rid of the
> old bindings (thermal.txt).
> 
> Replace all references to thermal.txt in the Documentation with a link
> to the appropriate YAML bindings using the following search and replace
> pattern:
>  - If the reference is specific to the thermal-sensor-cells property,
>  replace with a pointer to thermal-sensor.yaml
>  - If the reference is to the cooling-cells property, replace with a
>  pointer to thermal-cooling-devices.yaml
>  - If the reference is generic thermal bindings, replace with a
>  reference to thermal*.yaml.
> 
> Signed-off-by: Amit Kucheria <amit.kucheria@linaro.org>
> Reviewed-by: Rob Herring <robh@kernel.org>

Applied, thanks


-- 
<http://www.linaro.org/> Linaro.org │ Open source software for ARM SoCs

Follow Linaro:  <http://www.facebook.com/pages/Linaro> Facebook |
<http://twitter.com/#!/linaroorg> Twitter |
<http://www.linaro.org/linaro-blog/> Blog
