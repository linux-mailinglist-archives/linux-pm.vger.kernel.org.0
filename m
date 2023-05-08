Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B8B576FB30E
	for <lists+linux-pm@lfdr.de>; Mon,  8 May 2023 16:36:58 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233903AbjEHOg4 (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Mon, 8 May 2023 10:36:56 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46148 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229690AbjEHOg4 (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Mon, 8 May 2023 10:36:56 -0400
Received: from mail-ej1-x635.google.com (mail-ej1-x635.google.com [IPv6:2a00:1450:4864:20::635])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 475522D62
        for <linux-pm@vger.kernel.org>; Mon,  8 May 2023 07:36:54 -0700 (PDT)
Received: by mail-ej1-x635.google.com with SMTP id a640c23a62f3a-959a3e2dd27so813032766b.3
        for <linux-pm@vger.kernel.org>; Mon, 08 May 2023 07:36:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1683556613; x=1686148613;
        h=content-transfer-encoding:in-reply-to:references:cc:to:from
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=hcq3IX6rjSmrnOp6f9hmH2vtnMCn+snDEOHaKc+ifz8=;
        b=kO+qciox4LmJoqmFAKLbZ8MsmA3XPHHuAw8pgntvadrW8CFfhZgGq8yfxUue09vtIU
         kz8GgITzmdKsZ+w3yD/sq7Sy8+++Vg4XFonnFcOVI1q40ZBpDbShQ2XMwZSNsL5JpESJ
         OdbLm0umuI0rmG57lRBAu5Kml+3yGR4Y+9hXcsXXrvItLFK6o2hD73yV1Nts9harF0Bg
         viaMjapEh6yAERxcHLfw4RNKQjsfKShMWwB8d/a9+0v1co4Nz2Ut0lI6VZvLqu7TWynP
         FZxk6hx1Z1y/nkcgPhUzFgrBx6TJ+xQ3t5oNxekx5PVL7hzFbCA+6OIU6yoO0PHjPV6y
         1pKQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1683556613; x=1686148613;
        h=content-transfer-encoding:in-reply-to:references:cc:to:from
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=hcq3IX6rjSmrnOp6f9hmH2vtnMCn+snDEOHaKc+ifz8=;
        b=RR1gbCVccKfaPmcODVOcMKb7ceaveTR4qzDeVB5PSZPUKCbM0ZSAD1k5PBU6ZIli8w
         DNSD0AIYgqv/+NwiipBN91bzH4eNlfiGSJ3VcB7XfmJcXt8ClZtQdMNCvCplSs+Z74d3
         3DQwXxbslzh7YQjU/ZJmf8M0l8GCcgIkvkzhdI+n/FAxsbiht+YHLroy+ZD3fvW00HQT
         xnhLpdV/MdmN1Ax1F6FRmWzAmWIBki8ZjYKEtRI/+koY0ZUkDeZ7Wj79EoT0em+ILXd8
         2dgNgTSBTdSCkcJvRbfCAwERLIBUe1JoHvLAKDrlQHWf7RPPSE+Svx0ofSC67o4rPZsd
         YHdw==
X-Gm-Message-State: AC+VfDyWqdAOO8t8wTEpfDeyxcmjXYq6PnT2N0J/1+9CntrD8zT3LUIQ
        MsesbCr6x7zCDrkS1cpa3tAe3Q==
X-Google-Smtp-Source: ACHHUZ6ak5O0xqfGMpaeJyP+5kBtu6S3egezDPlgAyUIfeXPPA2Pm84djGFSIvXiKZS26rSH60xx8w==
X-Received: by 2002:a17:907:c1e:b0:94f:250b:2536 with SMTP id ga30-20020a1709070c1e00b0094f250b2536mr9474778ejc.28.1683556612682;
        Mon, 08 May 2023 07:36:52 -0700 (PDT)
Received: from ?IPV6:2a02:810d:15c0:828:50e0:ebdf:b755:b300? ([2a02:810d:15c0:828:50e0:ebdf:b755:b300])
        by smtp.gmail.com with ESMTPSA id hx16-20020a170906847000b0094e4eabb402sm44871ejc.128.2023.05.08.07.36.51
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 08 May 2023 07:36:52 -0700 (PDT)
Message-ID: <c4ccade7-cfb9-6362-703d-f74308bdc313@linaro.org>
Date:   Mon, 8 May 2023 16:36:50 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.11.0
Subject: Re: [PATCH v3 2/7] dt-bindings: power: supply: max77658: Add ADI
 MAX77654/58/59 Charger
Content-Language: en-US
From:   Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
To:     Zeynep Arslanbenzer <Zeynep.Arslanbenzer@analog.com>
Cc:     sre@kernel.org, Nurettin Bolucu <Nurettin.Bolucu@analog.com>,
        broonie@kernel.org, robh+dt@kernel.org, devicetree@vger.kernel.org,
        krzysztof.kozlowski+dt@linaro.org, lee@kernel.org,
        linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org,
        lgirdwood@gmail.com
References: <20230508131045.9399-1-Zeynep.Arslanbenzer@analog.com>
 <20230508131045.9399-3-Zeynep.Arslanbenzer@analog.com>
 <20230508143235.57c4jojkloqavrpo@krzk-bin>
In-Reply-To: <20230508143235.57c4jojkloqavrpo@krzk-bin>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-3.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

On 08/05/2023 16:32, Krzysztof Kozlowski wrote:
> On Mon, 08 May 2023 16:10:40 +0300, Zeynep Arslanbenzer wrote:
>> Add ADI MAX77654/58/59 power supply devicetree document.
>>
>> Signed-off-by: Nurettin Bolucu <Nurettin.Bolucu@analog.com>
>> Signed-off-by: Zeynep Arslanbenzer <Zeynep.Arslanbenzer@analog.com>
>> ---
>>  .../power/supply/adi,max77658-charger.yaml    | 53 +++++++++++++++++++
>>  1 file changed, 53 insertions(+)
>>  create mode 100644 Documentation/devicetree/bindings/power/supply/adi,max77658-charger.yaml
>>
> 
> My bot found errors running 'make DT_CHECKER_FLAGS=-m dt_binding_check'
> on your patch (DT_CHECKER_FLAGS is new in v5.13):
> 
> yamllint warnings/errors:
> 
> doc reference errors (make refcheckdocs):
> Documentation/devicetree/bindings/power/supply/adi,max77658-charger.yaml: Documentation/devicetree/bindings/mfd/adi,max77658.yaml

This can be ignored, there is a kind of circular dependency so it's fine.

Best regards,
Krzysztof

