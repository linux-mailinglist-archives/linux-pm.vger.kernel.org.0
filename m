Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DAE556BA836
	for <lists+linux-pm@lfdr.de>; Wed, 15 Mar 2023 07:45:00 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231656AbjCOGow (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Wed, 15 Mar 2023 02:44:52 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59652 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230508AbjCOGob (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Wed, 15 Mar 2023 02:44:31 -0400
Received: from mail-ed1-x52e.google.com (mail-ed1-x52e.google.com [IPv6:2a00:1450:4864:20::52e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6FC5B36FF7
        for <linux-pm@vger.kernel.org>; Tue, 14 Mar 2023 23:44:01 -0700 (PDT)
Received: by mail-ed1-x52e.google.com with SMTP id eg48so12182369edb.13
        for <linux-pm@vger.kernel.org>; Tue, 14 Mar 2023 23:44:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1678862637;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=9Igrmt5V9yzytVg5K/E/KsrHYKAvQNgfPbYcTDvqYxQ=;
        b=f2HRmsjB5wc74FMj9jehEoePOfsQm8m0W+mI6MhhhEV7kGkiyV9N+qmB8q06w/xcAM
         pcdMV0Yz+jlMNlTT9fU+yfTSwu08xojPmxgv1dJfak6BMx3Bl7kJE0kdgFryta0kYrbn
         XyeChxTvCOTyd3tHg9CTYd3poEXhrRDY7ZaocX+NW/8VHAwphoInWkr94kpZBlH3GswQ
         9PS+9Gx7eoG65Ac3sFSumK/dhD2Jntbv3K3Ib3gbtSnE7i2xHJCOHA88nfpLOEN/Tw1x
         qUplsZJh/s46R2EwSqP921xhMlCUDPGMlipnepxpkIUEi1eugdc8eipx0devwD54Js4r
         eyYA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1678862637;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=9Igrmt5V9yzytVg5K/E/KsrHYKAvQNgfPbYcTDvqYxQ=;
        b=iXwZqjXaHmxrT+VzARwd5J5Q5alFXpyDYYiyvGbbweeWNn8gHlBnFgct1fyQ5axMz5
         5pfbN7oijdTJZgOlf9XbX9Kbf8oPS3Nlq0U31zAjzBrOB9GYxrhpkPfk5Bu5A402IcpD
         AMNHIOEAWs/rIZNYx0MkpiRgRTNju9jm7MlZdvMXI/EgH9uR/ENcnOpdEtNnHRBaEm0j
         UmVMKWAYlJ2hCyIL7/aWYndwJ0HYlrwBzQdACNAnvEjZXOI7uFqm3ldsLvEhSCqKIV9k
         IImBYJ64U1dP3LH1razL7ESpWJOqVSvl4xGW7RUvvK9El9G5ATGgsKfZAVBgT4IHVCc1
         NHCg==
X-Gm-Message-State: AO0yUKUwca/PoN+sEXPlHh8xlLXjrQlIYz6j4oY/hEsJMNeBysP1HC0q
        /seuJ+N3nHZ8RNBGqIgktXXHIA==
X-Google-Smtp-Source: AK7set8wtsK5fUOkNDWX9RoG3LFq/DqpKz+JpaVGTBmVf00PthmWH2c2uGAoUbTqhmun8tDAhcMgiQ==
X-Received: by 2002:a17:907:3fa6:b0:878:7189:a457 with SMTP id hr38-20020a1709073fa600b008787189a457mr6027737ejc.51.1678862637025;
        Tue, 14 Mar 2023 23:43:57 -0700 (PDT)
Received: from ?IPV6:2a02:810d:15c0:828:940e:8615:37dc:c2bd? ([2a02:810d:15c0:828:940e:8615:37dc:c2bd])
        by smtp.gmail.com with ESMTPSA id a12-20020a1709066d4c00b00914001c91fcsm2054072ejt.86.2023.03.14.23.43.56
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 14 Mar 2023 23:43:56 -0700 (PDT)
Message-ID: <9698192b-6e23-b4fb-0af9-33e8bb0f802e@linaro.org>
Date:   Wed, 15 Mar 2023 07:43:55 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.8.0
Subject: Re: [PATCHv2 01/12] dt-bindings: power: supply: adc-battery: add
 binding
Content-Language: en-US
To:     Sebastian Reichel <sre@kernel.org>
Cc:     Linus Walleij <linus.walleij@linaro.org>,
        Matti Vaittinen <mazziesaccount@gmail.com>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        linux-kernel@vger.kernel.org, linux-pm@vger.kernel.org,
        devicetree@vger.kernel.org
References: <20230314225535.1321736-1-sre@kernel.org>
 <20230314225535.1321736-2-sre@kernel.org>
From:   Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
In-Reply-To: <20230314225535.1321736-2-sre@kernel.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

On 14/03/2023 23:55, Sebastian Reichel wrote:
> Add binding for a battery that is only monitored via ADC
> channels and simple status GPIOs.
> 
> Signed-off-by: Sebastian Reichel <sre@kernel.org>


Reviewed-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>

Best regards,
Krzysztof

