Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 477404B575C
	for <lists+linux-pm@lfdr.de>; Mon, 14 Feb 2022 17:46:22 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240127AbiBNQqX (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Mon, 14 Feb 2022 11:46:23 -0500
Received: from mxb-00190b01.gslb.pphosted.com ([23.128.96.19]:50464 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1356734AbiBNQpw (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Mon, 14 Feb 2022 11:45:52 -0500
Received: from smtp-relay-internal-1.canonical.com (smtp-relay-internal-1.canonical.com [185.125.188.123])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 875C660DB4
        for <linux-pm@vger.kernel.org>; Mon, 14 Feb 2022 08:45:44 -0800 (PST)
Received: from mail-ed1-f70.google.com (mail-ed1-f70.google.com [209.85.208.70])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (No client certificate requested)
        by smtp-relay-internal-1.canonical.com (Postfix) with ESMTPS id 89009402DF
        for <linux-pm@vger.kernel.org>; Mon, 14 Feb 2022 16:45:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canonical.com;
        s=20210705; t=1644857142;
        bh=tJAqFxG57f51iV+zIdkcN4fACREExxQK2T3qjt956q4=;
        h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
         In-Reply-To:Content-Type;
        b=eGgu7fwUDmotOJKIJHgTnID3WTiT6hfTYCnDsVERIVknHn8mE9wWk5uY9s7qpPWMV
         J3w21Pa7F69BKIrZCkKQzbsZ2r3Z3cC8o3lztOv57gZRCjSpbvXEmP2SpQg/hM4zQ3
         Jhv0iUeVpWJuis4VtV5WsPV8BTAf2LVXvZVD7RMidhePGw8mw0J4LXZ0qIYD2o0/r7
         sLnEgQFRDHdIN3hF8joDi8UyZ50TyeHLm6W+ORqHukSU3LHeg+ROoYvaQZ42ozT4ir
         L38wR0iFeWQPDQHWOY0t8vDnykUxydeWRQGC0LdQF1IU4CTMI2Gt150FC4S9LzIjsA
         dC128GarEm18w==
Received: by mail-ed1-f70.google.com with SMTP id o8-20020a056402438800b00410b9609a62so2333657edc.3
        for <linux-pm@vger.kernel.org>; Mon, 14 Feb 2022 08:45:42 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:to:cc:references:from:in-reply-to
         :content-transfer-encoding;
        bh=tJAqFxG57f51iV+zIdkcN4fACREExxQK2T3qjt956q4=;
        b=l5PimXHmZegzCWxTTr+p/1t+Gn+vtz1qu7StFzl+ggmetCRaowC9BBfLqbzjxjxbXF
         Jec2dKnJ8jP5DnTppoBBz5X5OOv3pL9TJgJEIcy1AoYs5Z5UZXrsZ7EqZG/fSO+Ox7TN
         3DE8G04ZDDtUGyDO74hwf4DUqULbrYuluihDRTzn8qBwiMHwRE/zMy//xxjOOBu7ZMaK
         hy+c+EB6b6kLeMkgZ7H+l9iRJlKfxWS82XVGIzmwkHK3FgBvo9a99zB/MGBIhXsmyjgE
         Qa+b75FxTodJDmpxbL4dqYS5A0OGTPQA+DU+t28MTz1PfE2TySoRobVUBjUYDWt3U5kc
         zHRA==
X-Gm-Message-State: AOAM531JXa1tYQLVUtz4Colw6qluqcIF7UxTk2VfMrfgbfKZgoFkJt1p
        YWkA4SHEwcqxf7MZLYKFLX0xlIWRKNpuZXaJbQB22hKFWFgnbMgXKRLWTWvCbcZ5fvA6A4t46J1
        6cnXRpDZqF/TVbvUH6kKPNOS/czted+kn3Daw
X-Received: by 2002:a17:906:c154:: with SMTP id dp20mr389431ejc.184.1644857142236;
        Mon, 14 Feb 2022 08:45:42 -0800 (PST)
X-Google-Smtp-Source: ABdhPJwc2+VExzAVY/W5vInmueb+5alFIdvPQ/yNYAlAMwX6l6zMLtEWTUGsPjknL77MCoUNePY9yg==
X-Received: by 2002:a17:906:c154:: with SMTP id dp20mr389418ejc.184.1644857142074;
        Mon, 14 Feb 2022 08:45:42 -0800 (PST)
Received: from [192.168.0.106] (xdsl-188-155-168-84.adslplus.ch. [188.155.168.84])
        by smtp.gmail.com with ESMTPSA id i1sm7437488ejy.138.2022.02.14.08.45.41
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 14 Feb 2022 08:45:41 -0800 (PST)
Message-ID: <12c66ced-c4a4-3a4e-f84b-83edb9e3fc58@canonical.com>
Date:   Mon, 14 Feb 2022 17:45:40 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.5.0
Subject: Re: [PATCH v2 3/4] regulator: dt-bindings: maxim,max77693: convert to
 dtschema
Content-Language: en-US
To:     Mark Brown <broonie@kernel.org>
Cc:     Chanwoo Choi <cw00.choi@samsung.com>, Pavel Machek <pavel@ucw.cz>,
        Rob Herring <robh+dt@kernel.org>,
        Lee Jones <lee.jones@linaro.org>,
        Sebastian Reichel <sre@kernel.org>,
        Liam Girdwood <lgirdwood@gmail.com>,
        linux-kernel@vger.kernel.org, linux-leds@vger.kernel.org,
        devicetree@vger.kernel.org, linux-pm@vger.kernel.org
References: <20220111175017.223966-1-krzysztof.kozlowski@canonical.com>
 <20220111175017.223966-4-krzysztof.kozlowski@canonical.com>
 <YgqGT999nsjUGp9Z@sirena.org.uk>
From:   Krzysztof Kozlowski <krzysztof.kozlowski@canonical.com>
In-Reply-To: <YgqGT999nsjUGp9Z@sirena.org.uk>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-4.5 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_MED,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

On 14/02/2022 17:41, Mark Brown wrote:
> On Tue, Jan 11, 2022 at 06:50:16PM +0100, Krzysztof Kozlowski wrote:
> 
>> +    properties:
>> +      regulator-name: true
>> +      regulator-always-on: true
>> +      regulator-boot-on: true
> 
> Why are these specific generic regulator properties enumerated?  

additionalProperties=false is used, so all properties, also ones from
regulator.yaml, have to be mentioned.

Why this approach was used? Because the hardware here is very limited,
so no other properties are expected. No other features are supported.


Best regards,
Krzysztof
