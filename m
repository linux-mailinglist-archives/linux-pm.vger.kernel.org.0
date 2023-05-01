Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D71C06F2F1A
	for <lists+linux-pm@lfdr.de>; Mon,  1 May 2023 09:21:29 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229737AbjEAHV2 (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Mon, 1 May 2023 03:21:28 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34870 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229861AbjEAHV1 (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Mon, 1 May 2023 03:21:27 -0400
Received: from mail-ej1-x631.google.com (mail-ej1-x631.google.com [IPv6:2a00:1450:4864:20::631])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E588BE73
        for <linux-pm@vger.kernel.org>; Mon,  1 May 2023 00:21:25 -0700 (PDT)
Received: by mail-ej1-x631.google.com with SMTP id a640c23a62f3a-958bb7731a9so458641966b.0
        for <linux-pm@vger.kernel.org>; Mon, 01 May 2023 00:21:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1682925684; x=1685517684;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=dVepgCs67QhYF+S64LwI1sds6PcYZ4iqkhDG4bO/TQk=;
        b=Lt4G/nF6/vWSm70/OJY9L8lReXHWAXuoU2nTlVM5M0iX7otJ/oUOLEbFE3NHeQEu9k
         5McUSTNOiR4Q/p7p9Yjagk7HpBL1xpEINFyHozBz8ZwVlMuRPH9v1s1oWpQGVdb2vEV6
         +IdDb2u1+WQco+ELwRCF/8eO9+4NJ3Kwc5uhxtsobLYJPTPcl71eeMsaD6BoTkyu1AEf
         GLtNdHfQgWX3xS7rB8KQMkyqoYdNtQp96Ea49guBF8fmtvXxGC6ps5qdknpybWRRVHD6
         oLuO0UQ1tFI9uTKHXU6lftF0gLaXY4rapOx/VrNY5LjvPTJffHRR1meq+lKzFW9a/dP5
         4oSQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1682925684; x=1685517684;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=dVepgCs67QhYF+S64LwI1sds6PcYZ4iqkhDG4bO/TQk=;
        b=WdnrbD18oMlFtqRSjPs1UvRBP/gW+pBpjz6a7zoti1LGizrTfqZN6JyCIzxBbTDoIo
         /NPA1CJw3NYL1A4gryHCmOVjyNGVP9jib4G3uVScBCPKFzrDxfiagrVt30P8WhWGeOMo
         1UiQu6EoDqf0TKsLk6izATE9t/BEX7Q+p3MHJU68cE2duX+hW+7saPnUvcyYoZ9UhuN3
         xG7mGougmp4LcGryg6j/sm/r4z0xQpQzoyxD7xZSmriccPL6qymrKn72ezgHRFwCQDmU
         Xx1VNbzOzvqlAsP39KGjJhq0MvRa+i+7ea3KFsP7nDmMqIkRC3KLXQkryoFYIHtyk4Gk
         YkAw==
X-Gm-Message-State: AC+VfDwuDedlNmo4Tz370j2c1tJqkw5gdm8UXQOqu4GxnhHFwqSzqycr
        1tjvQl5CeolF4dnhIDeMefH/RQ==
X-Google-Smtp-Source: ACHHUZ4+mJdUdaGf/klmpEAOu8cRfGyWI064D3ANXCd+js1/C+fb9SATKA4qJcXoaajnxZfbb2zbug==
X-Received: by 2002:a17:907:970d:b0:90b:53f6:fd8b with SMTP id jg13-20020a170907970d00b0090b53f6fd8bmr13404942ejc.31.1682925684312;
        Mon, 01 May 2023 00:21:24 -0700 (PDT)
Received: from ?IPV6:2a02:810d:15c0:828:637a:fd0c:58fd:9f00? ([2a02:810d:15c0:828:637a:fd0c:58fd:9f00])
        by smtp.gmail.com with ESMTPSA id gn2-20020a1709070d0200b009545230e682sm14276029ejc.91.2023.05.01.00.21.23
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 01 May 2023 00:21:23 -0700 (PDT)
Message-ID: <1d187f41-ad9a-4e82-8557-20694a8294d0@linaro.org>
Date:   Mon, 1 May 2023 09:21:22 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.10.1
Subject: Re: [PATCH v3 8/8] dt-bindings: Add rt5033 mfd, regulator and charger
Content-Language: en-US
To:     Jakob Hauser <jahau@rocketmail.com>,
        Sebastian Reichel <sre@kernel.org>, Lee Jones <lee@kernel.org>,
        Liam Girdwood <lgirdwood@gmail.com>,
        Mark Brown <broonie@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>
Cc:     Beomho Seo <beomho.seo@samsung.com>,
        Chanwoo Choi <cw00.choi@samsung.com>,
        Stephan Gerhold <stephan@gerhold.net>,
        Raymond Hackley <raymondhackley@protonmail.com>,
        Pavel Machek <pavel@ucw.cz>, Axel Lin <axel.lin@ingics.com>,
        ChiYuan Huang <cy_huang@richtek.com>,
        Linus Walleij <linus.walleij@linaro.org>,
        linux-pm@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, phone-devel@vger.kernel.org,
        ~postmarketos/upstreaming@lists.sr.ht
References: <cover.1682636929.git.jahau@rocketmail.com>
 <5bd8b90713a61129acf292a941eb7fb5ccaa3db4.1682636929.git.jahau@rocketmail.com>
From:   Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
In-Reply-To: <5bd8b90713a61129acf292a941eb7fb5ccaa3db4.1682636929.git.jahau@rocketmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-3.5 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

On 28/04/2023 01:30, Jakob Hauser wrote:
> Add device tree binding documentation for rt5033 multifunction device, voltage
> regulator and battery charger.
> 
> Cc: Beomho Seo <beomho.seo@samsung.com>
> Cc: Chanwoo Choi <cw00.choi@samsung.com>
> Signed-off-by: Jakob Hauser <jahau@rocketmail.com>


(...)

> +
> +required:
> +  - monitored-battery
> +
> +additionalProperties: false
> +
> +examples:
> +  - |
> +    charger {
> +        compatible = "richtek,rt5033-charger";
> +        monitored-battery = <&battery>;
> +        extcon = <&muic>;


Everything up to here looked ok, but extcon is not a hardware property.
Please do not mix adding missing bindings for existing device with
adding new properties. You should use connector for the USB port.

Best regards,
Krzysztof

