Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4AB506DD20E
	for <lists+linux-pm@lfdr.de>; Tue, 11 Apr 2023 07:48:01 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230182AbjDKFsA (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Tue, 11 Apr 2023 01:48:00 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57160 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229928AbjDKFri (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Tue, 11 Apr 2023 01:47:38 -0400
Received: from mail-ej1-x633.google.com (mail-ej1-x633.google.com [IPv6:2a00:1450:4864:20::633])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 377F830ED
        for <linux-pm@vger.kernel.org>; Mon, 10 Apr 2023 22:47:13 -0700 (PDT)
Received: by mail-ej1-x633.google.com with SMTP id ud9so17241015ejc.7
        for <linux-pm@vger.kernel.org>; Mon, 10 Apr 2023 22:47:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1681192031;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=pVh755DKDNmveu85FDiALetnqXyLZJdSZZC58t6k7ZI=;
        b=w90KoYAZQND2DqJ/iBjBd6yWNI4zSEgciruIcBm6srEoZKqLWmyk2qTvfM/CiQwCeu
         SCZNTXVHLnr9Y93ZmqQHs+zW80GwZnahVY09ZksGCVrn/FVccFOyYpQsI9EWHeFosagN
         nWWWHwk4Z4hk9S9evSU7h55Oa5vBb4OTXtztBIId7dPyT3P55h7b4Si/Uza6wq890kj1
         voLL8AkRu4zSJnT2OFRFpfnyxcrd1abfxWF30HGV8X4ej2IRwCy7AgkJT5As7T+NzP/9
         YIlFssqYDFuejHp02b6XFZRLoi87llY6clibxinXE+RjtGMWfzpsWyxJLS81enEMVH50
         UTgA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1681192031;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=pVh755DKDNmveu85FDiALetnqXyLZJdSZZC58t6k7ZI=;
        b=OH5UjAtQ/8It8yEHobbk3maVsdUaR73K5XGKAXwLCtXEJiwoOIFUzcoaXjNZ9sgoeW
         6SWwGxA83vS7kt4gj3TIm+YBaV+WFbrRttoGPjxmD0NNWqL6LZ/s3TAqluR4Qmg9/1ml
         3GpRs1dAf/bwaWRsGC+luP2pqRnRSssRYLKKnhUkKJfOtsoif2V6Hevzgs4YmLoyum7E
         AGmkgy+xcEMbxEqVjeA3b0alXHN5b/Z4bo13RaOtLv0MeTz1RnEII/RVI6VLqDechVfz
         tS2WzYtaIiLT0QLsUhYlYO2xJV4C/Xd3+kTvGx7gJy1+oMNuM5Nk0AYombZN3EuJhl5/
         qffg==
X-Gm-Message-State: AAQBX9c1Pt3xVJYzhbKzMybkRkqCj+f4rcP77ujuys4Mp5CIjvQv6W7P
        EgDTBmXEV8mSnoSis3mZkpyzjg==
X-Google-Smtp-Source: AKy350ZUAGxpvhR4romk+59laXw1jS7kpNVeZaxQmbOsaNlEvHIU4tTd8ZbvnbFRkhNSMQoUO4Gtbg==
X-Received: by 2002:a17:907:76eb:b0:93b:2d0b:b60e with SMTP id kg11-20020a17090776eb00b0093b2d0bb60emr1582180ejc.74.1681192031168;
        Mon, 10 Apr 2023 22:47:11 -0700 (PDT)
Received: from ?IPV6:2a02:810d:15c0:828:dad2:72b7:3626:af61? ([2a02:810d:15c0:828:dad2:72b7:3626:af61])
        by smtp.gmail.com with ESMTPSA id n6-20020a170906840600b0094a7d367554sm1943521ejx.32.2023.04.10.22.47.09
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 10 Apr 2023 22:47:10 -0700 (PDT)
Message-ID: <b3287bb9-2127-4d00-8679-b4b30968191e@linaro.org>
Date:   Tue, 11 Apr 2023 07:47:09 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.9.1
Subject: Re: [PATCH V2 2/6] dt-bindings: crypto: fsl-dcp: add imx6sl and
 imx6ull compatible
Content-Language: en-US
To:     Stefan Wahren <stefan.wahren@i2se.com>,
        Herbert Xu <herbert@gondor.apana.org.au>,
        "David S. Miller" <davem@davemloft.net>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Shawn Guo <shawnguo@kernel.org>,
        Sascha Hauer <s.hauer@pengutronix.de>
Cc:     kernel@pengutronix.de, Fabio Estevam <festevam@gmail.com>,
        linux-imx@nxp.com, "Rafael J . Wysocki" <rafael@kernel.org>,
        Daniel Lezcano <daniel.lezcano@linaro.org>,
        Amit Kucheria <amitk@kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        linux-crypto@vger.kernel.org, devicetree@vger.kernel.org,
        linux-serial@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-pm@vger.kernel.org
References: <20230410205803.45853-1-stefan.wahren@i2se.com>
 <20230410205803.45853-3-stefan.wahren@i2se.com>
From:   Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
In-Reply-To: <20230410205803.45853-3-stefan.wahren@i2se.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-3.4 required=5.0 tests=DKIM_SIGNED,DKIM_VALID,
        DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

On 10/04/2023 22:57, Stefan Wahren wrote:
> Currently the dtbs_check for imx6 generates warnings like this:
> 
> 'fsl,imx6sl-dcp' is not one of ['fsl,imx23-dcp', 'fsl,imx28-dcp']
> ['fsl,imx6sl-dcp', 'fsl,imx28-dcp'] is too long
> 
> or
> 
> 'fsl,imx6ull-dcp' is not one of ['fsl,imx23-dcp', 'fsl,imx28-dcp']
> ['fsl,imx6ull-dcp', 'fsl,imx28-dcp'] is too long
> 
> So add them to the devicetree binding.
> 
> Signed-off-by: Stefan Wahren <stefan.wahren@i2se.com>


Reviewed-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>

Best regards,
Krzysztof

