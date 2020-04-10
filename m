Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 76E6A1A4A19
	for <lists+linux-pm@lfdr.de>; Fri, 10 Apr 2020 21:02:45 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726648AbgDJTCj (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Fri, 10 Apr 2020 15:02:39 -0400
Received: from mail-lj1-f193.google.com ([209.85.208.193]:38770 "EHLO
        mail-lj1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726646AbgDJTCj (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Fri, 10 Apr 2020 15:02:39 -0400
Received: by mail-lj1-f193.google.com with SMTP id v16so2894056ljg.5;
        Fri, 10 Apr 2020 12:02:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=PYKcTVIV4hyvh7eYr2ZVXran4rltE2Q1T3gTm8AMtDs=;
        b=RSyEvYJvOqY0KhhjOQhe7BPWwgzk38OSAtjb4e86Zn6ANKrVOq2V4auUZJvD4Q3y2x
         QkeWukpU82Xz48weMvWTAtLlRh4hhxR9naz+TXzRyH6STBreqv1nqvcUnvySEo5XESR3
         hmTcNtzVuniuGue7H4AtHOuql4Hd8hY9zGUdiAcuMVyC/9EjDdNNgkyuqelJACt2zBjt
         pRXqK/sRVqNfhmgYiC0KWBLwQ5606XyFwqBin/lduMQ0YdrvIGVwjEp0G2mwjbRyeG2Q
         NjXDK951Y8D1tMy0aCFif/paZrqO9PrIk6RYkezrRnz4bTqeuQggGjrF0yiU/PddrrmP
         Yu5w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=PYKcTVIV4hyvh7eYr2ZVXran4rltE2Q1T3gTm8AMtDs=;
        b=Vs0yBr0gSW7q6gwYsI+9ZGzjeXcj1HURO/8ks3GPvhpv1Ocyq5fXbsxaUZRfkuTWeA
         IdmXK5mIm/KJAF3k9a7whPCch0nx70P9tPnwTo79a0zi/e4P7ztYGEM7kTxnWza9fgvp
         tH+1ZcwmQ/Inzq5ODrr0q4/vmsySvsD2VX8vXXzYIx4hr64SdEXS8dTij8j/d8vdMxAF
         +qKYB8XJdCwtOuy8shweU70jrC2Rd39v+28xbQZAzNrt5qxcUPo2P3cwPVtni9vy2IIH
         2MoES9bzkCHsaZ4v5wAR/Ow3Y+7UtweW/GPbyUnYR8NcoO/XX6/+ldbQ5yVMil/oXLlU
         xfOw==
X-Gm-Message-State: AGi0PuaDsz0eJIb9iov/mqbHd8K4PUV7eRTkLTRMdEVF40p1VyYhK7jZ
        FplGv72GuwPxsx1hmgJgaGO2gmfE
X-Google-Smtp-Source: APiQypJ7yEEZbmoRR3GUh5umTAf4/y8qh40+fhTFXAvoCq/oM8h7IMbGYuCADkYMUfcoKj0dLKvlTQ==
X-Received: by 2002:a2e:9605:: with SMTP id v5mr3691202ljh.258.1586545357403;
        Fri, 10 Apr 2020 12:02:37 -0700 (PDT)
Received: from [192.168.2.145] (ppp91-78-208-152.pppoe.mtu-net.ru. [91.78.208.152])
        by smtp.googlemail.com with ESMTPSA id k11sm2132420ljj.36.2020.04.10.12.02.36
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 10 Apr 2020 12:02:36 -0700 (PDT)
Subject: Re: [PATCH 4/9] dt-bindings: power: supply: Add device-tree binding
 for Summit SMB3xx
To:     Rob Herring <robh@kernel.org>, David Heidelberg <david@ixit.cz>
Cc:     Sebastian Reichel <sre@kernel.org>,
        Jonghwa Lee <jonghwa3.lee@samsung.com>,
        Chanwoo Choi <cw00.choi@samsung.com>,
        Myungjoo Ham <myungjoo.ham@samsung.com>,
        Sumit Semwal <sumit.semwal@linaro.org>,
        John Stultz <john.stultz@linaro.org>,
        Vinay Simha BN <simhavcs@gmail.com>,
        mika.westerberg@linux.intel.com, ramakrishna.pallala@intel.com,
        linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org,
        devicetree@vger.kernel.org
References: <20200329161552.215075-1-david@ixit.cz>
 <20200329162128.218584-5-david@ixit.cz> <20200410164905.GA719@bogus>
From:   Dmitry Osipenko <digetx@gmail.com>
Message-ID: <8c4ab1ce-1947-ab38-3f8c-9055406428e4@gmail.com>
Date:   Fri, 10 Apr 2020 22:02:35 +0300
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.5.0
MIME-Version: 1.0
In-Reply-To: <20200410164905.GA719@bogus>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

10.04.2020 19:49, Rob Herring пишет:
...
>> +  summit,max-chg-curr:
>> +    description: Maximum current for charging (in uA)
>> +    allOf:
>> +      - $ref: /schemas/types.yaml#/definitions/uint32
>> +
>> +  summit,max-chg-volt:
>> +    description: Maximum voltage for charging (in uV)
>> +    allOf:
>> +      - $ref: /schemas/types.yaml#/definitions/uint32
>> +    minimum: 3500000
>> +    maximum: 4500000
>> +
>> +  summit,pre-chg-curr:
>> +    description: Pre-charging current for charging (in uA)
>> +    allOf:
>> +      - $ref: /schemas/types.yaml#/definitions/uint32
>> +
>> +  summit,term-curr:
>> +    description: Charging cycle termination current (in uA)
>> +    allOf:
>> +      - $ref: /schemas/types.yaml#/definitions/uint32
...
> These are all properties of the battery attached and we have standard 
> properties for some/all of these.

Looks like only four properties seem to be matching the properties of
the battery.txt binding.

Are you suggesting that these matching properties should be renamed
after the properties in battery.txt?

> Also, any property with units should have a unit suffix as defined in 
> property-units.txt. And with that, you don't need to define the type.

Indeed, thank you for the suggestion.
