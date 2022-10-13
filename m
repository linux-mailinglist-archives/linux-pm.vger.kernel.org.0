Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2724F5FE5E2
	for <lists+linux-pm@lfdr.de>; Fri, 14 Oct 2022 01:32:55 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229673AbiJMXcx (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Thu, 13 Oct 2022 19:32:53 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41544 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229572AbiJMXcw (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Thu, 13 Oct 2022 19:32:52 -0400
Received: from mail-qt1-x82c.google.com (mail-qt1-x82c.google.com [IPv6:2607:f8b0:4864:20::82c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AC88E189C16
        for <linux-pm@vger.kernel.org>; Thu, 13 Oct 2022 16:32:50 -0700 (PDT)
Received: by mail-qt1-x82c.google.com with SMTP id r19so2749392qtx.6
        for <linux-pm@vger.kernel.org>; Thu, 13 Oct 2022 16:32:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=0+QfEwy7B/NrkymaL7q2hDY+q10f+0eJfcatFNx6Eqs=;
        b=g/Vu/8osdQ1PPPGH7vBzzXaURD1oaMlsGgq3jdnsKjd5krGykX/Cle2SBf169AE5ys
         hdM4wPEzDLwwMKvQH3DPzWGk1iRcWbR+snhitd0/pRftFXoi2wVL2nMGctYk38p33na1
         n0c10dea0uI6lAQj4EDXgjTP5etp24/JKkyGVjqo9CZXtIZKcMlsiWx071FNqELvDsdE
         uYsaK6blFQNGCXMnSVgUY08ZM8xJVeAc5QtVuqW7wOTq9U+VLtqh+N/1PNiw6ZYlwIpA
         T9ERcCWX1wv8jru0xXngfVU/bYH51AerLE3rdIQTum7Z5z7qSaWqzVBYI89PBnU9NhsY
         tH7A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=0+QfEwy7B/NrkymaL7q2hDY+q10f+0eJfcatFNx6Eqs=;
        b=dMmzYdNh5a3f17EDZ4D9Ljfm/RxdkQDvoeEPvsuvP8mB8mGwSogDePSuMZQWLbYn3C
         mIo7SdZhpJzhv8WAvzpzTbj0oRfoE3rCDeu/Neojv+qk3htMxbprfs4hWWno+ues1MsX
         qN7j6Tl59tBcAeBbMy3DI26tnOE3iVGJgiIhtmhxDWCPDyIxM2KAZGZl6FWh86s106y5
         ZSS6d6z/cLyp1HEotG45YChx5+hNLikGJP7sHQZjcd6EAkrlugfVWugXtJZ5NFn4x3ww
         zuCYVuXy0RY2q9I2TgMFO39O1CiSaME0atmmhY7POYZQNd6iNfkcudrk1veEY0guGwJU
         hvAQ==
X-Gm-Message-State: ACrzQf0MWJMhER+Z6jvPzHIWTRteiVVh6p1jwEoXJlGPJ7R9WjCukvrO
        YzK2dBajhs/gHGksmGAPoodZYA==
X-Google-Smtp-Source: AMsMyM4IKZBPcrAkKgLQFL2CqgM5z3RNWKbjf6LsalpKHQodpII16MZttEiPtH4fRBxp/igpWcV2Vg==
X-Received: by 2002:a05:622a:178b:b0:39c:c9db:2c5e with SMTP id s11-20020a05622a178b00b0039cc9db2c5emr2056358qtk.111.1665703969887;
        Thu, 13 Oct 2022 16:32:49 -0700 (PDT)
Received: from [192.168.1.57] (cpe-72-225-192-120.nyc.res.rr.com. [72.225.192.120])
        by smtp.gmail.com with ESMTPSA id n1-20020a05620a294100b006e8f8ca8287sm903306qkp.120.2022.10.13.16.32.48
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 13 Oct 2022 16:32:48 -0700 (PDT)
Message-ID: <1e02c8ae-d3b1-e226-f14b-c7f7d0292237@linaro.org>
Date:   Thu, 13 Oct 2022 19:30:36 -0400
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.3.2
Subject: Re: [PATCH 05/11] dt-bindings: thermal: k3-j72xx: elaborate on
 binding descriptions
Content-Language: en-US
To:     Bryan Brattlof <bb@ti.com>
Cc:     Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        "Rafael J. Wysocki" <rafael@kernel.org>,
        Daniel Lezcano <daniel.lezcano@linaro.org>,
        Amit Kucheria <amitk@kernel.org>,
        Zhang Rui <rui.zhang@intel.com>, Nishanth Menon <nm@ti.com>,
        Vignesh Raghavendra <vigneshr@ti.com>,
        Tero Kristo <kristo@kernel.org>, Keerthy <j-keerthy@ti.com>,
        Linux Thermal <linux-pm@vger.kernel.org>,
        Linux Device Tree <devicetree@vger.kernel.org>,
        LKML <linux-kernel@vger.kernel.org>,
        Linux ARM <linux-arm-kernel@lists.infradead.org>
References: <20221011231727.8090-1-bb@ti.com>
 <20221011231727.8090-6-bb@ti.com>
 <06249fe9-97eb-1ab8-5e35-00b3c613d3a7@linaro.org>
 <20221012181911.qk7v3yabo726lmtl@bryanbrattlof.com>
From:   Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
In-Reply-To: <20221012181911.qk7v3yabo726lmtl@bryanbrattlof.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-3.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

On 12/10/2022 14:19, Bryan Brattlof wrote:
>>> +          temperatures accurately.
>>>  
>>>    power-domains:
>>> +    description: |
>>> +      Should contain the phandle to a power management (PM) domain
>>> +      node and the device-id of this device.
>>
>> This is quite generic - why adding it?
> 
> This was really a "while I'm here" addition. But there is no need, I can 
> drop this

Drop it, we do not describe generic properties (already described in
core schema).

Best regards,
Krzysztof

