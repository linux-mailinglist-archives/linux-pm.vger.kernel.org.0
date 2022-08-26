Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 86CAA5A2903
	for <lists+linux-pm@lfdr.de>; Fri, 26 Aug 2022 16:03:11 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344399AbiHZOC6 (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Fri, 26 Aug 2022 10:02:58 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41006 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1344191AbiHZOC5 (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Fri, 26 Aug 2022 10:02:57 -0400
Received: from mail-wr1-x42a.google.com (mail-wr1-x42a.google.com [IPv6:2a00:1450:4864:20::42a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CF6D8BE4C2
        for <linux-pm@vger.kernel.org>; Fri, 26 Aug 2022 07:02:55 -0700 (PDT)
Received: by mail-wr1-x42a.google.com with SMTP id bq11so1910638wrb.12
        for <linux-pm@vger.kernel.org>; Fri, 26 Aug 2022 07:02:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20210112.gappssmtp.com; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc;
        bh=Mtje2qEwG9vnhoVDst4lRLcS6qO60Yh1gpKRylhbD4A=;
        b=ILSuAOJFTD/h1f9m7ZfHHZ442rhPDY2W34T7s/khlxcapxirVG63G9Nx3h3mNXeDni
         aTXDqWQkyhIKDTYdjrYtG3KJ3O/qvcUOiPTpfRH9oTj+YXz6NBy1kvlgVIFi/Db89OMZ
         gS6b1Y7Ks+UgHdrVKpeZW3Q40NY69hDKaMNs2nHZNCYtvhDCqw+QbBg1NgsLVWpldqWn
         jqPzvG+2mdT94h2/aGuFgbYB6Vw1r4r6+mXD4qLP2kSi0EfVuwOn7IWs08RejdtArAGZ
         VAWX3jntoqihIWSeXIGeszB2mPqncQxbvQwaHbYMBKeBECb37WyyMYvo0n3OMoMcUwT2
         L92g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc;
        bh=Mtje2qEwG9vnhoVDst4lRLcS6qO60Yh1gpKRylhbD4A=;
        b=6M8ns87pylrbHDezpyPsmtNy0KHUq5h5Ov6SGe8W4Uxdrr9VTSoMQQLTucr9MwJO9C
         GCBx4D+siU6z70XWQMj6W9ECCwd/nQvHap9tp9uxjjcAnvRPFBdQrrxTpxZ6wpLCgFfG
         u37dlw6aXFlWLJKPQuEf02RQoQfz2vsjz3u/pmyWPSESohBQSJdEVDJdJuCC7kRlGkQH
         bvDszTUEAmCKb/I+cxHmc9KR/xFbfY4IJ6cms5F57RK09ADhGMjYk/GlY6KY4t9bY2XM
         0M4vllOtq59DfvCGJWv46uCaObqDFG6kjqvXudhbtM4RElYk/I8pSeyopISE/OgV4N2C
         GTPw==
X-Gm-Message-State: ACgBeo2BnMyg/9TEAAa3OMxNd+8gUn5p0pmU4nUBOvDBAe2oELVa4c+U
        MZ6+bIMIkxNfGG+BPQ3aVvY+yg==
X-Google-Smtp-Source: AA6agR6idNMJp6sisxPJISIGgWJjg9TgG5bw/WX8AqedTH7Pdo4hmYpxkpIXFnZn/XBrUqZf1SWo/w==
X-Received: by 2002:adf:ed92:0:b0:225:464d:b083 with SMTP id c18-20020adfed92000000b00225464db083mr5160595wro.246.1661522574290;
        Fri, 26 Aug 2022 07:02:54 -0700 (PDT)
Received: from [192.168.0.20] (210.145.15.109.rev.sfr.net. [109.15.145.210])
        by smtp.gmail.com with ESMTPSA id f6-20020a0560001b0600b002206203ed3dsm1911823wrz.29.2022.08.26.07.02.53
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 26 Aug 2022 07:02:53 -0700 (PDT)
Message-ID: <577de16a-0a6c-faa5-54da-2d808451b4e9@baylibre.com>
Date:   Fri, 26 Aug 2022 16:02:52 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.13.0
Subject: Re: [PATCH v2 1/4] dt-bindings: thermal: mediatek: add binding
 documentation for MT8365 SoC
Content-Language: en-US
To:     Matthias Brugger <matthias.bgg@gmail.com>
Cc:     rafael@kernel.org, fparent@baylibre.com, amitk@kernel.org,
        daniel.lezcano@linaro.org, devicetree@vger.kernel.org,
        krzysztof.kozlowski+dt@linaro.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        linux-mediatek@lists.infradead.org, linux-pm@vger.kernel.org,
        robh+dt@kernel.org, rui.zhang@intel.com
References: <20220720181854.547881-1-aouledameur@baylibre.com>
 <20220720181854.547881-2-aouledameur@baylibre.com>
 <59dd19f6-8e20-56d6-506a-93656bf15138@gmail.com>
From:   Amjad Ouled-Ameur <aouledameur@baylibre.com>
In-Reply-To: <59dd19f6-8e20-56d6-506a-93656bf15138@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

Hi Matthias,

On 7/21/22 10:57, Matthias Brugger wrote:
>
>
> On 20/07/2022 20:18, Amjad Ouled-Ameur wrote:
>> From: Fabien Parent <fparent@baylibre.com>
>>
>> Add the binding documentation for the thermal support on MT8365 SoC.
>>
>> Signed-off-by: Fabien Parent <fparent@baylibre.com>
>> Acked-by: Amjad Ouled-Ameur <aouledameur@baylibre.com>
>
> I suppose you wanted to add Signed-off-by here, at least 
> get_maintainers.pl doesn't list you.
>
Right, will add my SoB in V3, thank you!

Regards,

Amjad

> Apart from that:
> Reviewed-by: Matthias Brugger <matthias.bgg@gmail.com>
>
>> ---
>>   Documentation/devicetree/bindings/thermal/mediatek-thermal.txt | 1 +
>>   1 file changed, 1 insertion(+)
>>
>> diff --git 
>> a/Documentation/devicetree/bindings/thermal/mediatek-thermal.txt 
>> b/Documentation/devicetree/bindings/thermal/mediatek-thermal.txt
>> index 5c7e7bdd029a..ba4ebffeade4 100644
>> --- a/Documentation/devicetree/bindings/thermal/mediatek-thermal.txt
>> +++ b/Documentation/devicetree/bindings/thermal/mediatek-thermal.txt
>> @@ -14,6 +14,7 @@ Required properties:
>>     - "mediatek,mt2712-thermal" : For MT2712 family of SoCs
>>     - "mediatek,mt7622-thermal" : For MT7622 SoC
>>     - "mediatek,mt8183-thermal" : For MT8183 family of SoCs
>> +  - "mediatek,mt8365-thermal" : For MT8365 family of SoCs
>>     - "mediatek,mt8516-thermal", "mediatek,mt2701-thermal : For 
>> MT8516 family of SoCs
>>   - reg: Address range of the thermal controller
>>   - interrupts: IRQ for the thermal controller
