Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BBB6367F0C4
	for <lists+linux-pm@lfdr.de>; Fri, 27 Jan 2023 22:59:56 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232062AbjA0V7x (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Fri, 27 Jan 2023 16:59:53 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36886 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231985AbjA0V7v (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Fri, 27 Jan 2023 16:59:51 -0500
Received: from mail-wr1-x42a.google.com (mail-wr1-x42a.google.com [IPv6:2a00:1450:4864:20::42a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9E17C80F9E
        for <linux-pm@vger.kernel.org>; Fri, 27 Jan 2023 13:59:32 -0800 (PST)
Received: by mail-wr1-x42a.google.com with SMTP id m14so5721453wrg.13
        for <linux-pm@vger.kernel.org>; Fri, 27 Jan 2023 13:59:32 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=+Cz5Q9QqxBT/mJ42tlkxiPXIwzy6fjExSclfG0wKHfI=;
        b=VjEoXjIr7IVVZyO+Rf5tXpFVDXNmFU2VGHrg6Y27hxxINfHRN3yuLXS0Gm39WZz9LV
         o+Rl3JBrr+JKhdJhfDsOtNfTAO2dPDbGXEPYY2vrDpwJZGy9iBDWrW2jtd7nbJ1NKnrA
         Ar9Snn64+bw2fVzFS5NC9gxnjTAImX+uWfzpLw8yZbaliJ0rpRc4kes3hoNW3TAfY46+
         ujOjQVD74dmDRifH6/9DCjBvAingP6reqJBmgjnpOEDfc3IU6bvMSof7VseseFCroQoO
         PDafqviQ+3QngfDtKMWOlsGxRfo9dMSx2U4r686FF9EI3Z7ETmiNcYBE4SwRHnSwXo0D
         nSVQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=+Cz5Q9QqxBT/mJ42tlkxiPXIwzy6fjExSclfG0wKHfI=;
        b=rJvVXvWDJFcO4Bkiq2Afr5rCAclu0us1Oc/rFg8HgDuJ4iuszEkBDE4EHD0DVzIi8B
         JLPMq2XUooUv1vqzvKal5zNNW0frXitdOigoHJtZ1JU3wMO5ukNOVyu31fxdi0j0rnWI
         6R7SXlsQKlc1q30zBMT1OTQiz/1T3o/57Gikrrsj3SR6UONGG/8LYa3EJx24lX+sLQBL
         FJ2JDkcbshhEwB60gEYKtkWahRKGo/YlrBlFUVeCOjMx6oimp6vrroZBw0JPgIYkfXfV
         1htNOReygMXramB6jpGPm+KFFHNIQ+4DUy7If2ZyxS/lb2+k28yWefZ0beSBIS4V+zVk
         qm1w==
X-Gm-Message-State: AFqh2kpnj1PHD02tsEH0zQgtISfyqHgmjss8lLR3azZH6dpUb8ooW/ga
        iluakzOE0/gqM8yjITBqW5kR9Q==
X-Google-Smtp-Source: AMrXdXsco7rdfIpvU1ee1v+Fg46FuX6WTwlVLTcQ3THl9hinHIVdvLedq1TNXWbLD76RPI9IPu1BVg==
X-Received: by 2002:adf:db90:0:b0:2bc:7d3c:5a57 with SMTP id u16-20020adfdb90000000b002bc7d3c5a57mr30437667wri.1.1674856770961;
        Fri, 27 Jan 2023 13:59:30 -0800 (PST)
Received: from [192.168.10.46] (146725694.box.freepro.com. [130.180.211.218])
        by smtp.googlemail.com with ESMTPSA id u13-20020a5d514d000000b002be2f18938csm4744904wrt.41.2023.01.27.13.59.29
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 27 Jan 2023 13:59:30 -0800 (PST)
Message-ID: <afa4aacd-bacf-a545-3973-474286fd4b9c@linaro.org>
Date:   Fri, 27 Jan 2023 22:59:29 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.4.2
Subject: Re: [PATCH v9 0/5] thermal: mediatek: Add support for MT8365 SoC
Content-Language: en-US
To:     Amjad Ouled-Ameur <aouledameur@baylibre.com>,
        "Rafael J. Wysocki" <rafael@kernel.org>,
        Amit Kucheria <amitk@kernel.org>,
        Zhang Rui <rui.zhang@intel.com>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>
Cc:     linux-pm@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-mediatek@lists.infradead.org,
        Fabien Parent <fparent@baylibre.com>,
        Matthias Brugger <matthias.bgg@gmail.com>,
        AngeloGioacchino Del Regno 
        <angelogioacchino.delregno@collabora.com>,
        Rob Herring <robh@kernel.org>,
        Markus Schneider-Pargmann <msp@baylibre.com>,
        Hsin-Yi Wang <hsinyi@chromium.org>,
        Michael Kao <michael.kao@mediatek.com>
References: <20221018-up-i350-thermal-bringup-v9-0-55a1ae14af74@baylibre.com>
From:   Daniel Lezcano <daniel.lezcano@linaro.org>
In-Reply-To: <20221018-up-i350-thermal-bringup-v9-0-55a1ae14af74@baylibre.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=0.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        RCVD_IN_SBL_CSS,SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

On 27/01/2023 16:44, Amjad Ouled-Ameur wrote:
> This patchset adds thermal support for MT8365 SoC.
> 
> MT8365 has 4 thermal sensors, one for CPUs and the rest for debug/dev
> purposes. The CPU thermal zone uses passive cooling device with
> CPU{0..3}.
> 
> Changes in v9:
> - Use delay between bank init and the thermal zone device register.
> - Link to v8: https://lore.kernel.org/r/20221018-up-i350-thermal-bringup-v8-0-23e8fbb08837@baylibre.com
> 
> Signed-off-by: Amjad Ouled-Ameur <aouledameur@baylibre.com>
> ---
> Amjad Ouled-Ameur (2):
>        thermal: mediatek: add callback for raw to mcelsius conversion
>        thermal: mediatek: add delay after thermal banks initialization
> 
> Fabien Parent (2):
>        dt-bindings: thermal: mediatek: add binding documentation for MT8365 SoC
>        thermal: mediatek: add support for MT8365 SoC
> 
> Markus Schneider-Pargmann (1):
>        thermal: mediatek: control buffer enablement tweaks
> 
>   .../bindings/thermal/mediatek-thermal.txt          |   1 +
>   drivers/thermal/mtk_thermal.c                      | 117 +++++++++++++++++----
>   2 files changed, 96 insertions(+), 22 deletions(-)
> ---

Applied, with some changes and the subject fixed:

Subject format for thermal is: thermal/drivers/<thedriver>: [A-Z]*.

Thanks

   -- Daniel

-- 
<http://www.linaro.org/> Linaro.org │ Open source software for ARM SoCs

Follow Linaro:  <http://www.facebook.com/pages/Linaro> Facebook |
<http://twitter.com/#!/linaroorg> Twitter |
<http://www.linaro.org/linaro-blog/> Blog

