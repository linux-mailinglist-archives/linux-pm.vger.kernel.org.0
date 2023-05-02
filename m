Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6FE0D6F3D82
	for <lists+linux-pm@lfdr.de>; Tue,  2 May 2023 08:33:28 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231610AbjEBGd0 (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Tue, 2 May 2023 02:33:26 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47222 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229653AbjEBGdZ (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Tue, 2 May 2023 02:33:25 -0400
Received: from mail-ej1-x62e.google.com (mail-ej1-x62e.google.com [IPv6:2a00:1450:4864:20::62e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5C15126A8
        for <linux-pm@vger.kernel.org>; Mon,  1 May 2023 23:33:24 -0700 (PDT)
Received: by mail-ej1-x62e.google.com with SMTP id a640c23a62f3a-94f7a7a3351so666675966b.2
        for <linux-pm@vger.kernel.org>; Mon, 01 May 2023 23:33:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1683009203; x=1685601203;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=uaq8RBsdIqA9qX9LHQLxBDk7YAiPOkXhWlKDq4LcMaQ=;
        b=EpygdFOp3Lz9pVvAeiqhRO4O0tSkCEG98YuTXFSr4DGYFduehhNrQkFQ5T+I9eaUiK
         cIGtzHJFJ8+/339aQa/xr2TGVtQvBH+tSaZsm6atNza48b+aGrOAH4OV5mdZlQNMbLzQ
         7P5L03w64lexL7WTFwFZwKaAP6hUEqOTF/kxpaTM1uNi+y6blULTspzwTlhjOCvUX6Uw
         wGBhtpKDS+bBuRE0hHKCl4cosrVEmT9r7lPwhRO3/EoBV8jC+8j2yT1wgTTdu/L1D9yX
         7cUFb+aQozs+IlrMxvz5tLpg3yUUDGP7dCjz091cUhPCpqIeadiLehf6GbZ1fFwsSG7O
         s1tw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1683009203; x=1685601203;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=uaq8RBsdIqA9qX9LHQLxBDk7YAiPOkXhWlKDq4LcMaQ=;
        b=SbDsfjZCkCB9wcKEBLlUriaEoxRfisq7G9D2oY7RWcsEK7y00zR55bOlxBOCQ1gANG
         kT34lQsnidju/zYdQicS5L3hFcTZP3NbTZeQetMg/q1LqNVT7yeUuagzTXVNyfhW9+xM
         CbOVHshg208SUWwYaG+IKWPECzcTEui84i/uqoXPOwJAGho2G8f4NwDJQg7cfEYJr0o1
         1GfTe75xMHLr3+NQGfNXKrU/DKfQY9PKmGFb3J9iHZ7tLJoE0B5qAQ2Bmy+enx7Cuom5
         1ahymDLDahkWhMG+J1yXDaywpddlVtwAiT2RQOKrD7KBHY+iV6J4MreHcfPtDEt/CweK
         gt6Q==
X-Gm-Message-State: AC+VfDyujYNgudFBqV8g3cWazb7oNmNLbxfC+MnpTN6HlRna24H7QIId
        wspjEyBcS7Uq5xwqYJ5CDDYU5w==
X-Google-Smtp-Source: ACHHUZ6apAeClITPtCDbSvp+k0+epqog8ZneVuhMCyHGOrgUaR0bY1xE7MdImkH2oGmxG23D9UxS+w==
X-Received: by 2002:a17:907:9345:b0:961:272d:bda5 with SMTP id bv5-20020a170907934500b00961272dbda5mr9382786ejc.49.1683009202824;
        Mon, 01 May 2023 23:33:22 -0700 (PDT)
Received: from ?IPV6:2a02:810d:15c0:828:bafd:1283:b136:5f6a? ([2a02:810d:15c0:828:bafd:1283:b136:5f6a])
        by smtp.gmail.com with ESMTPSA id qt2-20020a170906ece200b0094e1344ddfdsm15562427ejb.34.2023.05.01.23.33.20
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 01 May 2023 23:33:21 -0700 (PDT)
Message-ID: <1f520e8a-7785-f4dc-2f9b-d6afd1e3f671@linaro.org>
Date:   Tue, 2 May 2023 08:33:20 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.10.1
Subject: Re: [PATCH v2 5/8] dt-bindings: power: supply: max77658: Add ADI
 MAX77658 Battery
Content-Language: en-US
To:     "Arslanbenzer, Zeynep" <Zeynep.Arslanbenzer@analog.com>
Cc:     "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
        "linux-pm@vger.kernel.org" <linux-pm@vger.kernel.org>,
        "lee@kernel.org" <lee@kernel.org>,
        "robh+dt@kernel.org" <robh+dt@kernel.org>,
        "krzysztof.kozlowski+dt@linaro.org" 
        <krzysztof.kozlowski+dt@linaro.org>,
        "sre@kernel.org" <sre@kernel.org>,
        "lgirdwood@gmail.com" <lgirdwood@gmail.com>,
        "broonie@kernel.org" <broonie@kernel.org>
References: <20230322055628.4441-1-Zeynep.Arslanbenzer@analog.com>
 <20230322055628.4441-6-Zeynep.Arslanbenzer@analog.com>
 <afeecd42-ecda-4d92-bbb5-6dcff84fca7d@linaro.org>
 <MN2PR03MB5197BC6AEE58EFE098AF08358B6E9@MN2PR03MB5197.namprd03.prod.outlook.com>
From:   Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
In-Reply-To: <MN2PR03MB5197BC6AEE58EFE098AF08358B6E9@MN2PR03MB5197.namprd03.prod.outlook.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-3.5 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

On 01/05/2023 22:20, Arslanbenzer, Zeynep wrote:

>> You already said it above.
>>
>>> +      in battery.yaml, with the following properties being required:
>>> +      - alert-celsius
>>> +
>>> +required:
>>> +  - compatible
>>
>> Why reg and monitored-batter are not required?
>>
> If no monitored-battery information is supplied, we set default values for alert-celsius.

So the device can operate without battery? Interesting... are you sure,
you can physically remove battery and device will work?

> The reg property is the I2C address of the device and it is part of the parent schema. Therefore, both are not required in this file.

What does it mean "in parent schema"? You have reg here, so how parent
schema is related to this?

Since you did not reply, I assume all other comments will be implemented.

Best regards,
Krzysztof

