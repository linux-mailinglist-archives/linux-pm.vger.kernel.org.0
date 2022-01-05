Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D27614851BE
	for <lists+linux-pm@lfdr.de>; Wed,  5 Jan 2022 12:26:03 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232763AbiAEL0C (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Wed, 5 Jan 2022 06:26:02 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56532 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239659AbiAEL0B (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Wed, 5 Jan 2022 06:26:01 -0500
Received: from mail-wm1-x331.google.com (mail-wm1-x331.google.com [IPv6:2a00:1450:4864:20::331])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 70560C061784
        for <linux-pm@vger.kernel.org>; Wed,  5 Jan 2022 03:26:00 -0800 (PST)
Received: by mail-wm1-x331.google.com with SMTP id c66so25231980wma.5
        for <linux-pm@vger.kernel.org>; Wed, 05 Jan 2022 03:26:00 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=hsOdhykBVoRpV1A6nkjk34+J7F6kYYhhy3JOQFljBCU=;
        b=nMfymIA9n5MNJAsM9qhczPmfZCvqNR6kdxO+YkLux67QGpT4JHlzu4q5UM2a3xTVij
         DUKhETg/ZWuod6r1deiSkU9S5ErT8vizvP/ecK/ww3UNuIJaEU1vqVP/GAsnBhF9x1tL
         Bsx80MnbcRAGwblf6RK6/lTTSSvcPGEIWu72P12WD2fmlCi7VFMTEcawkhqnW/vzkHL7
         IsY7YN9EGhw5g6S24qZWV0wLtNBpg86idrFGREFjRNgSrpSBeY5VIc/s/hMMQcq08o/x
         +/n+uB66ZfPKjA01ZUf1B34yOR+h973RjlieYeRTbGL0XbCRnH4kWB0zvYWWfSsEk+4G
         9BFg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=hsOdhykBVoRpV1A6nkjk34+J7F6kYYhhy3JOQFljBCU=;
        b=qr2DwLu4VDYugCKneX5S7/wxktQC88FPa3wryfJMaCztXSaZniMwDDZbtwXdU4jexW
         3bBPAqMg3NsMCK7qZb0XbG1+8jCW9UioUut3/q0vdVddspe+njONizwbNB1RSNctorxc
         A/UJ3DHolfwd0buVL6wt5G7PvTcgANxmjcz/13BpXtSOcoMiMzT6aHBm0sUR1tEUMQcV
         nMFDGPHcXlH1IlFfwD4IqL/uvS1l/wnHbevzFy2HDCSM92dmRd/mhOgMIcoanEiP68VZ
         ugf7tE2MPH4QTChx4Fl3IT3N1QOTqHUSV0iT+ZFVmXsSgEfwVcjzit/xX/5MlJ2tKBNk
         UjAQ==
X-Gm-Message-State: AOAM533dgvBjJzKKzG8Cb2Wx9kdzE+lg2SRL1/9Ndw2BH2WLC/6ZUHOM
        z9Jk9qAaarX8KiAIJ8JLoqenuTYqpbq+S3Aw
X-Google-Smtp-Source: ABdhPJyM6lmDmwiopuloo5rN2kMQmZspTefyZc+7qdhabb+2+8bDho3RaBb/Lr0JQl7ajRS3iwNglw==
X-Received: by 2002:a05:600c:3844:: with SMTP id s4mr2415497wmr.124.1641381958883;
        Wed, 05 Jan 2022 03:25:58 -0800 (PST)
Received: from ?IPv6:2a01:e34:ed2f:f020:9997:55b1:2e48:dc4a? ([2a01:e34:ed2f:f020:9997:55b1:2e48:dc4a])
        by smtp.googlemail.com with ESMTPSA id l14sm35899869wrr.53.2022.01.05.03.25.57
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 05 Jan 2022 03:25:58 -0800 (PST)
Subject: Re: [PATCH v5 5/6] rockchip/soc/drivers: Add DTPM description for
 rk3399
To:     Ulf Hansson <ulf.hansson@linaro.org>, Rob Herring <robh@kernel.org>
Cc:     rjw@rjwysocki.net, lukasz.luba@arm.com, heiko@sntech.de,
        arnd@linaro.org, linux-kernel@vger.kernel.org,
        linux-pm@vger.kernel.org,
        Geert Uytterhoeven <geert+renesas@glider.be>,
        "moderated list:ARM/Rockchip SoC support" 
        <linux-arm-kernel@lists.infradead.org>,
        "open list:ARM/Rockchip SoC support" 
        <linux-rockchip@lists.infradead.org>
References: <20211218130014.4037640-1-daniel.lezcano@linaro.org>
 <20211218130014.4037640-6-daniel.lezcano@linaro.org>
 <CAPDyKFqWUJTKte3dM=7xG6EtKR8i9neCCNYFs7Jf1J34TezUEQ@mail.gmail.com>
From:   Daniel Lezcano <daniel.lezcano@linaro.org>
Message-ID: <dee9df5e-acab-579a-017c-d5f22e9e042c@linaro.org>
Date:   Wed, 5 Jan 2022 12:25:56 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.14.0
MIME-Version: 1.0
In-Reply-To: <CAPDyKFqWUJTKte3dM=7xG6EtKR8i9neCCNYFs7Jf1J34TezUEQ@mail.gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

On 31/12/2021 14:57, Ulf Hansson wrote:

[ ... ]

>> +static struct dtpm_node __initdata rk3399_hierarchy[] = {
>> +       [0]{ .name = "rk3399" },
>> +       [1]{ .name = "package",
>> +            .parent = &rk3399_hierarchy[0] },
>> +       [2]{ .name = "/cpus/cpu@0",
>> +            .type = DTPM_NODE_DT,
>> +            .parent = &rk3399_hierarchy[1] },
>> +       [3]{ .name = "/cpus/cpu@1",
>> +            .type = DTPM_NODE_DT,
>> +            .parent = &rk3399_hierarchy[1] },
>> +       [4]{ .name = "/cpus/cpu@2",
>> +            .type = DTPM_NODE_DT,
>> +            .parent = &rk3399_hierarchy[1] },
>> +       [5]{ .name = "/cpus/cpu@3",
>> +            .type = DTPM_NODE_DT,
>> +            .parent = &rk3399_hierarchy[1] },
>> +       [6]{ .name = "/cpus/cpu@100",
>> +            .type = DTPM_NODE_DT,
>> +            .parent = &rk3399_hierarchy[1] },
>> +       [7]{ .name = "/cpus/cpu@101",
>> +            .type = DTPM_NODE_DT,
>> +            .parent = &rk3399_hierarchy[1] },
>> +       [8]{ .name = "rockchip,rk3399-mali",
>> +            .type = DTPM_NODE_DT,
>> +            .parent = &rk3399_hierarchy[1] },
>> +       [9]{ },
>> +};
> 
> I will not object to this, as in the end this seems like what we need
> to do, unless we can describe things through generic DT bindings for
> DTPM. Right?

Yes, as asked by Rob, we should try to describe in the kernel first.

> Although, if the above is correct, I need to stress that I am kind of
> worried that this doesn't really scale. We would need to copy lots of
> information from the DTS files into platform specific c-files, to be
> able to describe the DTPM hierarchy.

TBH I don't think it is a lot and it is a __initdata. At least we should
begin with something and see later how to consolidate if it is needed, no?


-- 
<http://www.linaro.org/> Linaro.org │ Open source software for ARM SoCs

Follow Linaro:  <http://www.facebook.com/pages/Linaro> Facebook |
<http://twitter.com/#!/linaroorg> Twitter |
<http://www.linaro.org/linaro-blog/> Blog
