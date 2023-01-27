Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 86E9D67F114
	for <lists+linux-pm@lfdr.de>; Fri, 27 Jan 2023 23:23:13 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230343AbjA0WXK (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Fri, 27 Jan 2023 17:23:10 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56444 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232846AbjA0WXJ (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Fri, 27 Jan 2023 17:23:09 -0500
Received: from mail-wm1-x32d.google.com (mail-wm1-x32d.google.com [IPv6:2a00:1450:4864:20::32d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E0FAB875B7
        for <linux-pm@vger.kernel.org>; Fri, 27 Jan 2023 14:23:07 -0800 (PST)
Received: by mail-wm1-x32d.google.com with SMTP id l41-20020a05600c1d2900b003daf986faaeso4486873wms.3
        for <linux-pm@vger.kernel.org>; Fri, 27 Jan 2023 14:23:07 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20210112.gappssmtp.com; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=hw5WZV22kIf8LV4BYYD5zMZGL9QT6puKpKuaXbM0YSg=;
        b=07HB0DkOvEmzPwgdHTYPWBEwazvDvzxyXCvfZeEWHr7ZQVYrN23FroZHnqI9o3YYHb
         nOWJYm863srNOIMCCwZ2mMY/KM8WhFtuv6NHRyWz2MbzQsVDPELd6js2CKsC4nrYRvI4
         g8Y6/f2s6qoCR3kIyWQ3MO01DIQ7riQpvmCfRabBEjF2zCvpJv7i7FCTrehYbECTWJO3
         qUHmBwjPcl7oPemz/n+ztbqiG6jcanAHYa5sIB4chD0sQ95oaUIX9Hx0AVlal7PEvguQ
         VRlBBwN62OsA0Smn4ziJiYerSpQy3W3RdvWKeyMAlihnyK8qfl5qMQ3Kq+LPoM9VtcQt
         Klow==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=hw5WZV22kIf8LV4BYYD5zMZGL9QT6puKpKuaXbM0YSg=;
        b=ZviseqaUCCWgi1ikM2Fg6dorOZ1o5l9mpHhqHbulCrqZVea1rY7+tQ2g1bAL1fI1S2
         apGHebM7h/CskUFSnLkXRsfCH2vYGx0oECA5sSr03tJkLHQQMEmxgq+J1FT1eDNZl4oZ
         XYgMS3fOToTtcXM98enV1pPQoKlBH8vImFcQG5apAW/0cdwI3bneWZoD+ptnMsbIbuRw
         VqS65bU+K5X0SjSgVC3OQRt42JdenrKJ8V35A12iA1Kqg/SbcwkzgIYAEnhEkQZa7Tso
         rZ/nw+qrey77VmV/foK4UuKGVS5JzFL7HXdBEgODfdddZhnfx4Dp8oCi9kxyOq3x7Dv0
         +EOg==
X-Gm-Message-State: AFqh2kpXBpYtPgPg5tNC24iN/sQKN0HJwHbwozVMEqfryTsPPxe9cLHs
        z8wo4ebB54N5jls3wD+Y1ZhMDg==
X-Google-Smtp-Source: AMrXdXsAOA3YpQ4mwC7XEGlfoY6kbh9XeRRAB2vBaRPH37DPkopUrTvg7H0JBMp+rt9MvYA3N+zi/g==
X-Received: by 2002:a05:600c:4d93:b0:3d9:efd1:214d with SMTP id v19-20020a05600c4d9300b003d9efd1214dmr41147873wmp.25.1674858186392;
        Fri, 27 Jan 2023 14:23:06 -0800 (PST)
Received: from [192.168.0.20] (62.213.132.195.rev.sfr.net. [195.132.213.62])
        by smtp.gmail.com with ESMTPSA id j38-20020a05600c1c2600b003daff80f16esm12461874wms.27.2023.01.27.14.23.05
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 27 Jan 2023 14:23:05 -0800 (PST)
Message-ID: <81989ddf-4439-c176-e003-891f80a4e291@baylibre.com>
Date:   Fri, 27 Jan 2023 23:23:04 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.7.0
Subject: Re: [PATCH v9 0/5] thermal: mediatek: Add support for MT8365 SoC
Content-Language: en-US
To:     Daniel Lezcano <daniel.lezcano@linaro.org>,
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
 <afa4aacd-bacf-a545-3973-474286fd4b9c@linaro.org>
From:   Amjad Ouled-Ameur <aouledameur@baylibre.com>
In-Reply-To: <afa4aacd-bacf-a545-3973-474286fd4b9c@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-3.0 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org


On 1/27/23 22:59, Daniel Lezcano wrote:
> On 27/01/2023 16:44, Amjad Ouled-Ameur wrote:
>> This patchset adds thermal support for MT8365 SoC.
>>
>> MT8365 has 4 thermal sensors, one for CPUs and the rest for debug/dev
>> purposes. The CPU thermal zone uses passive cooling device with
>> CPU{0..3}.
>>
>> Changes in v9:
>> - Use delay between bank init and the thermal zone device register.
>> - Link to v8: https://lore.kernel.org/r/20221018-up-i350-thermal-bringup-v8-0-23e8fbb08837@baylibre.com
>>
>> Signed-off-by: Amjad Ouled-Ameur <aouledameur@baylibre.com>
>> ---
>> Amjad Ouled-Ameur (2):
>>        thermal: mediatek: add callback for raw to mcelsius conversion
>>        thermal: mediatek: add delay after thermal banks initialization
>>
>> Fabien Parent (2):
>>        dt-bindings: thermal: mediatek: add binding documentation for MT8365 SoC
>>        thermal: mediatek: add support for MT8365 SoC
>>
>> Markus Schneider-Pargmann (1):
>>        thermal: mediatek: control buffer enablement tweaks
>>
>>   .../bindings/thermal/mediatek-thermal.txt          |   1 +
>>   drivers/thermal/mtk_thermal.c                      | 117 +++++++++++++++++----
>>   2 files changed, 96 insertions(+), 22 deletions(-)
>> ---
>
> Applied, with some changes and the subject fixed:
>
> Subject format for thermal is: thermal/drivers/<thedriver>: [A-Z]*.
>
> Thanks

Thank you Daniel for applying the patchset.

Kindly,

Amjad

>
>   -- Daniel
>
