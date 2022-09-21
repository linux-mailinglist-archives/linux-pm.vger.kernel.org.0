Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D22C55BF630
	for <lists+linux-pm@lfdr.de>; Wed, 21 Sep 2022 08:20:13 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229496AbiIUGUM (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Wed, 21 Sep 2022 02:20:12 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46934 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229728AbiIUGUK (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Wed, 21 Sep 2022 02:20:10 -0400
Received: from mail-lf1-x132.google.com (mail-lf1-x132.google.com [IPv6:2a00:1450:4864:20::132])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B0D055E335
        for <linux-pm@vger.kernel.org>; Tue, 20 Sep 2022 23:20:09 -0700 (PDT)
Received: by mail-lf1-x132.google.com with SMTP id f9so7540439lfr.3
        for <linux-pm@vger.kernel.org>; Tue, 20 Sep 2022 23:20:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date;
        bh=K2Vn5G0yTW/j5XgAj9JCoNxrCyRR5X+mY8QlkyyA2rU=;
        b=Ub0c82oCNX+DnfSTSMugjJOPXrTYCcLmbHxmkNTs8LEwnXNK6neBTaFjmCMw8YbAxO
         H6VV7KQPSNM2HrnYnCM6wWLEN9moUG6+nzr3/hHoIEC7tzhOyhuVVnKtqNQlOYt6XkL2
         F3TlT5GDUIsehcBlq5tvpHTf2pIfT/Uqf+FQEO9g7YGL4THNQ4naUPApcY/7NzIu8uVz
         SxVT6SIhNyCnBXF/tvHfefliTILIuiRXHNA1340la8yJZKEUafl0RUp8BKD7NsRiVOYF
         C1CVYyyS0O2TnII2TsmEOnehR3DpjZJs6S89U/+pwTbSMQjGR7FPHgetC4mcBQBjv5G/
         e/Aw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date;
        bh=K2Vn5G0yTW/j5XgAj9JCoNxrCyRR5X+mY8QlkyyA2rU=;
        b=QZuAkcextwzVFBYHoHgibWRUt/mdM0NGj8hEzzmnhX7glq0A6AXKOSHX98XOEiKkAC
         zJ4lZ9zce9ozG5RsdDLZ3e6DBBQ4lwE9wvqka7x5BhUo/pbTCk7Q4py/sbbKIRMCZL5o
         oPjZx1aW79G6aqbn2KY3n0FM/MhL7Om4+gdsnPbi6wLhzRNXZmOnNFysaO+jRbLhk2El
         Wnpt8nHgj5VygfwYeDhW6EwZB7yWMCANiJtAnkcC9qyu00pmBoDniFGvcjaSZJa6Z1+t
         MD/cL+7yxWi1IEqcdupoXmTFk8e/5pm+a9+UcLej679fx2wFIbeAKtsQCW9AQpHHY9uk
         sKpA==
X-Gm-Message-State: ACrzQf35REIEJlwTfrAIK8cXM3IPEj3VQx8uijdmM8BzyCaboz1Xi2hB
        RhH6/isf8IfHSJskHvnpgqyLTg==
X-Google-Smtp-Source: AMsMyM4oGG69OdP5ujI+L+C6vfHXUbM1QVUuGbwI9wfkrrtvbDD+w6xG9LRKbzeWdihzJLflRV/7xA==
X-Received: by 2002:a05:6512:3f01:b0:49f:d13e:3cc7 with SMTP id y1-20020a0565123f0100b0049fd13e3cc7mr3036097lfa.368.1663741207897;
        Tue, 20 Sep 2022 23:20:07 -0700 (PDT)
Received: from [192.168.0.21] (78-11-189-27.static.ip.netia.com.pl. [78.11.189.27])
        by smtp.gmail.com with ESMTPSA id o16-20020a05651205d000b00492aefd73a5sm295514lfo.132.2022.09.20.23.20.06
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 20 Sep 2022 23:20:07 -0700 (PDT)
Message-ID: <c439ce1d-4e71-0630-3982-a4db95a1926a@linaro.org>
Date:   Wed, 21 Sep 2022 08:20:06 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.13.0
Subject: Re: [PATCH v9,2/7] dt-bindings: thermal: Add dt-binding document for
 LVTS thermal controllers
Content-Language: en-US
To:     AngeloGioacchino Del Regno 
        <angelogioacchino.delregno@collabora.com>, bchihi@baylibre.com,
        rafael@kernel.org, rui.zhang@intel.com, daniel.lezcano@linaro.org,
        amitk@kernel.org
Cc:     linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org,
        khilman@baylibre.com, mka@chromium.org, robh+dt@kernel.org,
        krzk+dt@kernel.org, matthias.bgg@gmail.com, p.zabel@pengutronix.de,
        devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-mediatek@lists.infradead.org, james.lo@mediatek.com,
        fan.chen@mediatek.com, louis.yu@mediatek.com,
        rex-bc.chen@mediatek.com, abailon@baylibre.com
References: <20220817080757.352021-1-bchihi@baylibre.com>
 <20220817080757.352021-3-bchihi@baylibre.com>
 <716d6471-f0e2-489e-5f9e-9e38e9e7953a@collabora.com>
From:   Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
In-Reply-To: <716d6471-f0e2-489e-5f9e-9e38e9e7953a@collabora.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-4.3 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

On 14/09/2022 14:19, AngeloGioacchino Del Regno wrote:
> 
>> +
>> +  nvmem-cell-names:
>> +    minItems: 1
>> +    maxItems: 2
>> +    description: Calibration efuse cell names for LVTS
> 
> Actually, maxItems is not really two, but it depends on how many
> eFuse arrays / nvmem cells we have for each SoC, so I was thinking...
> 
> ...what about doing something like
> 
>    nvmem-cell-names:
>      minItems: 1
>      items:
>        pattern: 'lvts-calib-data[0-9]+$'
> 
> and then,
>    if:
>      properties:
>        compatible:
>          contains:
>            enum:
>              - mediatek,blahblah-something
>    then:
>      properties:
>        nvmem-cell-names:
>          maxItems: 2 (or 3, 4, 5...)
> 
> P.S.: I haven't tried any binding check on the proposed lines.
> 

Should work, but does not enforce the order, so I would rather propose
something longer:

properties:
  nvmem-cell-names:
    items:
      - lvts-calib-data0
      - lvts-calib-data1
    minItems: 1


and then in allOf:if:then set minItems:2 or maxItems:1




Best regards,
Krzysztof
