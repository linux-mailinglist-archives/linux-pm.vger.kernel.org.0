Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 74038683339
	for <lists+linux-pm@lfdr.de>; Tue, 31 Jan 2023 18:01:35 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231786AbjAaRBc (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Tue, 31 Jan 2023 12:01:32 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37954 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231817AbjAaRB3 (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Tue, 31 Jan 2023 12:01:29 -0500
Received: from mail-wm1-x32c.google.com (mail-wm1-x32c.google.com [IPv6:2a00:1450:4864:20::32c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E35033802C
        for <linux-pm@vger.kernel.org>; Tue, 31 Jan 2023 09:01:26 -0800 (PST)
Received: by mail-wm1-x32c.google.com with SMTP id d4-20020a05600c3ac400b003db1de2aef0so11138828wms.2
        for <linux-pm@vger.kernel.org>; Tue, 31 Jan 2023 09:01:26 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=2GALk2yOZBKbLsxNTrFUIpXFTaX4N6lDPW1UKlHm5KE=;
        b=lwqm7TzjZO5Sfs1RFWBEMFVWW0RImKhn5FMLNqY6xLCU5ZJbh2Ajf0a1h36kTfKQvW
         L4YJovqVAgbzrUeXFedhWhORzjpBrKFvFpiY6NFQm4dFBfyTxkVoCGDt9R8fElvtqQPP
         lTebqPZFct7DrsKT0ll2poNNAyLwzsDxZKFxlymI3hjWo/SKqrOhHheBxMU7XMKGVeW6
         2NYnL5e81jVdTSrSs3yMWVPPQV6XvgWqjxxRq6+pp43eNS9HkwLGmyPwEktMRjDoiCpP
         uDwT8g/RDF6WV9QEnHR9YVzV3xkMjtkJc/eBiN2neWXtjVIqgQBaqh9Ox18900tbhc34
         Vznw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=2GALk2yOZBKbLsxNTrFUIpXFTaX4N6lDPW1UKlHm5KE=;
        b=KsQTBZLRq2j0clhhlkXKHPYtKXO8qhoGb17cRIZ3NJPknduxRYB+lO70W9ttxh+7mS
         OJGIVBh1HpP9bPLgfZmoKXzPtoxD3Pm1vvCRDwUC0lwkbIXSnPC/FbKjnYcsIZtzi4jw
         M9v4O3MbRtLMBo9JrCJflDRrB2oAdbGaLXymg8rAgfMG88XHf4sBJeYVZcml/Sk803dl
         iV81Ott2VDmzCmOqeJHrAHZBdnCblV2PFIz8L583bO0mpkJBDSFDS9zEeiar8aXbnHkS
         kGMubtJCRshoEEVrEwVCCxjqpany+U1fPqOcGYm8FFZMDHDGq3jIHtSmT/A1ecTowyK+
         jbNg==
X-Gm-Message-State: AFqh2kqoEOA/yYdTVSXxbnFbzuZcA9dSjEw0dala3l1NCvBhLFK9nM9m
        wXZQOID+sLklXQGBafr0Cdnxjg==
X-Google-Smtp-Source: AMrXdXtLemWqndR75w4l1MF5cQPb/cZFGAuLxWq3kqfaP3oIS7sIEJiokNLJlE2yqgs02Oz1Ya5i6A==
X-Received: by 2002:a05:600c:1c1b:b0:3d9:ebf9:7004 with SMTP id j27-20020a05600c1c1b00b003d9ebf97004mr52008187wms.29.1675184485343;
        Tue, 31 Jan 2023 09:01:25 -0800 (PST)
Received: from [192.168.10.46] (146725694.box.freepro.com. [130.180.211.218])
        by smtp.googlemail.com with ESMTPSA id c7-20020adfe707000000b002bfb0c5527esm15291583wrm.109.2023.01.31.09.01.23
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 31 Jan 2023 09:01:24 -0800 (PST)
Message-ID: <17b57e3a-48ec-5e70-d659-fcbbfb3e22ca@linaro.org>
Date:   Tue, 31 Jan 2023 18:01:23 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.4.2
Subject: Re: [PATCH v12 2/6] dt-bindings: thermal: mediatek: Add LVTS thermal
 controllers dt-binding definition
Content-Language: en-US
To:     Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>,
        Balsam CHIHI <bchihi@baylibre.com>
Cc:     angelogioacchino.delregno@collabora.com, rafael@kernel.org,
        amitk@kernel.org, rui.zhang@intel.com, matthias.bgg@gmail.com,
        robh+dt@kernel.org, krzysztof.kozlowski+dt@linaro.org,
        rdunlap@infradead.org, ye.xingchen@zte.com.cn,
        p.zabel@pengutronix.de, linux-pm@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-mediatek@lists.infradead.org, devicetree@vger.kernel.org,
        khilman@baylibre.com, james.lo@mediatek.com,
        rex-bc.chen@mediatek.com
References: <20230124131717.128660-3-bchihi@baylibre.com>
 <20230126161048.94089-1-bchihi@baylibre.com>
 <5ec49108-6ad8-daf7-54ec-104f0923a31d@linaro.org>
 <CAGuA+opQboxH8qoNv4GG+raX=ZZAyRVLC9VLjVCzbT_cUQWWTA@mail.gmail.com>
 <35a4d692-e4f3-e5c7-2d33-2d5e15694c33@linaro.org>
From:   Daniel Lezcano <daniel.lezcano@linaro.org>
In-Reply-To: <35a4d692-e4f3-e5c7-2d33-2d5e15694c33@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=1.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        RCVD_IN_SBL_CSS,SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no
        version=3.4.6
X-Spam-Level: *
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

On 31/01/2023 17:53, Krzysztof Kozlowski wrote:
> On 30/01/2023 11:40, Balsam CHIHI wrote:
>>>> diff --git a/include/dt-bindings/thermal/mediatek-lvts.h b/include/dt-bindings/thermal/mediatek-lvts.h
>>>> new file mode 100644
>>>> index 000000000000..902d5b1e4f43
>>>> --- /dev/null
>>>> +++ b/include/dt-bindings/thermal/mediatek-lvts.h
>>>
>>> Same filename as bindings.
>>
>> fixed.
>> rename :
>> include/dt-bindings/thermal/mediatek-lvts.h =>
>> include/dt-bindings/thermal/mediatek-lvts-thermal.h
> 
> Missing coma, so mediatek,lvts-thermal.h

Yeah, actually Balsam resent a new version but numbered v3 taking into 
account your comments.

The versioning is becoming a bit messy now but if you are ok with the 
changes I'll pick the patch as is so we can go forward for this series.

-- 
<http://www.linaro.org/> Linaro.org │ Open source software for ARM SoCs

Follow Linaro:  <http://www.facebook.com/pages/Linaro> Facebook |
<http://twitter.com/#!/linaroorg> Twitter |
<http://www.linaro.org/linaro-blog/> Blog

