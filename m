Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A20C66DAAC3
	for <lists+linux-pm@lfdr.de>; Fri,  7 Apr 2023 11:22:33 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239013AbjDGJWb (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Fri, 7 Apr 2023 05:22:31 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39858 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230265AbjDGJWa (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Fri, 7 Apr 2023 05:22:30 -0400
Received: from mail-wr1-x42c.google.com (mail-wr1-x42c.google.com [IPv6:2a00:1450:4864:20::42c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 10F70525D
        for <linux-pm@vger.kernel.org>; Fri,  7 Apr 2023 02:22:29 -0700 (PDT)
Received: by mail-wr1-x42c.google.com with SMTP id e18so41818762wra.9
        for <linux-pm@vger.kernel.org>; Fri, 07 Apr 2023 02:22:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1680859347; x=1683451347;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=Kl+r+1eAwUmcO3yIvLHoGLAdyBZhiAmwImrb6DiZvqw=;
        b=f4fj7uc/i6H265MoHUlDrKBrHhdyisQvssObqt0dhKmwQGrmtrAajdMaWJXQ5ZsaxW
         bE06FHKnR1SgnIuLPld2A7hlrhdsX6glSBvpUm9DTOZktf3PXpi+XxOcB9UqQ6u1ZBJ8
         anaK6QIs11IkblOhbgJRgRkNo6ZQAUgIYtd6TiOdlOtSkiSB0CB7Bcxf3PFIyLJo6XBX
         BGXokeZKPOn8WixKjcL5lBG5wA7j+VL0Q5K0q3ncUtJyYaVEEGGe4PQTtzdRPqtTBPEv
         HeR/jV2tvvIWg+nC1APJdGdT6fSwEou+63CG51cNKpo0ja9cdrH8gsya5SKwv/DiR1xT
         ahbQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1680859347; x=1683451347;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=Kl+r+1eAwUmcO3yIvLHoGLAdyBZhiAmwImrb6DiZvqw=;
        b=DE8TfYh/dL/y4CkkJw+2hX64n6MgSYkLahIBETgM5tQ2u/lNQZH3HQQowzdpErcyCu
         JDQU+V+J/NyJFPg8oI8Hy3ZlxO6nPyG53TC2BOPmc2/YKFaqRhKc3L7xEO3hd3fYI+kZ
         1wySL/dUdfW+OcbcNqb3sB7XCBu7K9Hfqg4aKa3zXO+Oax1XBvjJMmoIUUIFx49E+GWQ
         BzmYJcY70K+37LL/91xdTviEayXv9zoSj27MmTOyZTQXDQRtLkfk6gbJ1q/R283KoJOk
         /KC46YhdTgqog/zOVT9W1rP9gXCNsQcipkl+K8T4rZV91fjOgjH7EEwQWV/rYxTDc7pb
         9Itw==
X-Gm-Message-State: AAQBX9eXqhg8lE8VMT+d+PTmck2eGkiKX1fesbgj1W+uHXciElW9+hRj
        CmS/jQL0ZFlJlHAyIb6ni3tOrA==
X-Google-Smtp-Source: AKy350bBjbWNKXKt3qNiC277f7nt1WJaKLR8W6DDuzOEBUJz2ryNsKn3aPZFHGIZe/tdUpnx0OOoTQ==
X-Received: by 2002:adf:e643:0:b0:2ef:b32d:f54a with SMTP id b3-20020adfe643000000b002efb32df54amr537373wrn.33.1680859347328;
        Fri, 07 Apr 2023 02:22:27 -0700 (PDT)
Received: from ?IPV6:2a05:6e02:1041:c10:dc55:c7a2:94a8:f03b? ([2a05:6e02:1041:c10:dc55:c7a2:94a8:f03b])
        by smtp.googlemail.com with ESMTPSA id c4-20020a5d5284000000b002d1801018e2sm4046798wrv.63.2023.04.07.02.22.26
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 07 Apr 2023 02:22:26 -0700 (PDT)
Message-ID: <626fa1d8-dadd-9ecf-3eb0-fec651b331e6@linaro.org>
Date:   Fri, 7 Apr 2023 11:22:26 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.9.0
Subject: Re: [PATCH] thermal/drivers/mediatek/lvts_thermal: only update
 registered thermal zones
Content-Language: en-US
To:     Chen-Yu Tsai <wenst@chromium.org>
Cc:     "Rafael J. Wysocki" <rafael@kernel.org>,
        Amit Kucheria <amitk@kernel.org>,
        Zhang Rui <rui.zhang@intel.com>,
        Matthias Brugger <matthias.bgg@gmail.com>,
        AngeloGioacchino Del Regno 
        <angelogioacchino.delregno@collabora.com>,
        Balsam CHIHI <bchihi@baylibre.com>, linux-pm@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org,
        linux-mediatek@lists.infradead.org
References: <20230328031037.1361048-1-wenst@chromium.org>
 <9ab8d176-378c-9720-3794-c710e2bd6272@linaro.org>
 <CAGXv+5H7QdNJ0Pj4xS_Ce=N63Csd1rCc+BoFJALyETLsA521NQ@mail.gmail.com>
From:   Daniel Lezcano <daniel.lezcano@linaro.org>
In-Reply-To: <CAGXv+5H7QdNJ0Pj4xS_Ce=N63Csd1rCc+BoFJALyETLsA521NQ@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.2 required=5.0 tests=DKIM_SIGNED,DKIM_VALID,
        DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

On 07/04/2023 10:45, Chen-Yu Tsai wrote:
> On Sun, Apr 2, 2023 at 4:34 AM Daniel Lezcano <daniel.lezcano@linaro.org> wrote:
>>
>> On 28/03/2023 05:10, Chen-Yu Tsai wrote:
>>> It's possible for some sensors or thermal zones to not be registered,
>>> either because they are unused or not fully declared in the device tree.
>>> Nevertheless the driver enables interrupts for all sensors. If an
>>> interrupt happens for an not-registered sensor, the driver would end up
>>> updating a non-existent thermal zone, which leads to a NULL pointer
>>> dereference.
>>>
>>> Change it so that only registered thermal zones get updated.
>>
>> Why not change the interrupt initialization ?
> 
> I'll send another patch for that.
> 
> However I think the part in this patch should still be fixed?

If you are receiving an unexpected interrupt, there is something wrong 
with the initialization. If only the monitored thermal zones have their 
interrupt enabled, then you should never enter in the interrupt handler 
for a thermal zone which is not monitored, or did I miss something ?

-- 
<http://www.linaro.org/> Linaro.org │ Open source software for ARM SoCs

Follow Linaro:  <http://www.facebook.com/pages/Linaro> Facebook |
<http://twitter.com/#!/linaroorg> Twitter |
<http://www.linaro.org/linaro-blog/> Blog

