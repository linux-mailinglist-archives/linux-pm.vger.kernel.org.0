Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1827B52B741
	for <lists+linux-pm@lfdr.de>; Wed, 18 May 2022 12:13:11 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234991AbiERKKn (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Wed, 18 May 2022 06:10:43 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58610 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229458AbiERKKm (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Wed, 18 May 2022 06:10:42 -0400
Received: from mail-wr1-x434.google.com (mail-wr1-x434.google.com [IPv6:2a00:1450:4864:20::434])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 087FA15BAF9
        for <linux-pm@vger.kernel.org>; Wed, 18 May 2022 03:10:39 -0700 (PDT)
Received: by mail-wr1-x434.google.com with SMTP id u27so1156230wru.8
        for <linux-pm@vger.kernel.org>; Wed, 18 May 2022 03:10:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=message-id:date:mime-version:user-agent:subject:content-language:to
         :cc:references:from:in-reply-to:content-transfer-encoding;
        bh=jnKfNfztSdS59UZk3nARkPtr0csOM/dhuQCD/x6wD88=;
        b=ZZvH0+O6hCs/PlKB9YglIyXDAEaJ+S0+HzLFXnciXkIPu1OgeIHs0fyu3tHjc41u0d
         0P5iOruoikfmTPKBOpKor2az84wyjJwfGEZh2uB2tkrhgrjhHNoXfi502Zn1M000glNc
         KmK/0rZR1A3VrnH4qRXwM3DxcCSXHWp4JoBOq5FfyPG6fNSRfcOXRMCHLOjAgyfiBWcE
         VigvEM06FICne4PsgstCAVIOVkNhDZTLi3dWdO4PZ7nfIxsaEq+8vX7aD0Oe4mzPjAMm
         y5hbhAQo2Lke7m4u+LgRHUxnGkzBPS11E5r8rEa3clDVOw3Ea0a6D27eiCzrBxlBv9mq
         2ECQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:to:cc:references:from:in-reply-to
         :content-transfer-encoding;
        bh=jnKfNfztSdS59UZk3nARkPtr0csOM/dhuQCD/x6wD88=;
        b=PEJHHb3iNwuq2EhVMoSq14HNKOppmfuQKjsSRLmayXKEVH7aHNWQCGZLjlOcppuXf2
         Q+ODjtK1ccXwJNbmAirTgcZs+XOXjBR0i+S4UkqQQyWiQMT5hE2N8Em4su0jpLnaCNqn
         OOm9rVs/8NoNWswhQgRbhzwp1P2sBivDQ8MY51H5ELHTGAd5M1bysiWs13Yfqf5MR8SP
         0bTVCZzaJGQLzFNEsVAyyMEHbsAlY/YhW6rA6rN0kia3OO6BG9UrnnLme6nCy3vlvN89
         JSvNR+N9p2rhdx4CF4LydHE0QsdONafP3OM02fAf5q6wPcTsApVtjdMlwpIEE8qHfuyT
         Qv8Q==
X-Gm-Message-State: AOAM533SQd0iTi79HRsasZEUxP2bDXG1EaHGGoQc10O1W7+9gpQnQuv1
        8hMqBO9G7/wnLqah0bUQMAZJEQ==
X-Google-Smtp-Source: ABdhPJyl41P+OltOTSOzio6zdfSBakJhvYn2mInANE6lNtsEwVQg/K7Ko9ZkVAceVZlWPJuJFpeKPg==
X-Received: by 2002:a5d:648f:0:b0:20c:4eba:f529 with SMTP id o15-20020a5d648f000000b0020c4ebaf529mr22683270wri.237.1652868638019;
        Wed, 18 May 2022 03:10:38 -0700 (PDT)
Received: from ?IPV6:2a01:e34:ed2f:f020:8ba:b9c:a451:5abb? ([2a01:e34:ed2f:f020:8ba:b9c:a451:5abb])
        by smtp.googlemail.com with ESMTPSA id z22-20020a05600c0a1600b003942a244f38sm3980982wmp.17.2022.05.18.03.10.35
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 18 May 2022 03:10:37 -0700 (PDT)
Message-ID: <0006b8cb-b4fc-5015-5c86-be2a6a39be93@linaro.org>
Date:   Wed, 18 May 2022 12:10:34 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.8.1
Subject: Re: [PATCH v1] thermal: imx: Make trip point offset configurable
Content-Language: en-US
To:     Francesco Dolcini <francesco.dolcini@toradex.com>,
        Marco Felsch <m.felsch@pengutronix.de>
Cc:     l.stach@pengutronix.de, linux-pm@vger.kernel.org,
        "Rafael J . Wysocki" <rafael@kernel.org>,
        Fabio Estevam <festevam@gmail.com>,
        Sascha Hauer <s.hauer@pengutronix.de>,
        Amit Kucheria <amitk@kernel.org>,
        Jon Nettleton <jon@solid-run.com>,
        NXP Linux Team <linux-imx@nxp.com>,
        Pengutronix Kernel Team <kernel@pengutronix.de>,
        Shawn Guo <shawnguo@kernel.org>,
        Tim Harvey <tharvey@gateworks.com>,
        linux-arm-kernel@lists.infradead.org
References: <20220516190001.147919-1-francesco.dolcini@toradex.com>
 <20220518085522.3fpzy37kkbkn4hpl@pengutronix.de>
 <20220518094916.GA27037@francesco-nb.int.toradex.com>
From:   Daniel Lezcano <daniel.lezcano@linaro.org>
In-Reply-To: <20220518094916.GA27037@francesco-nb.int.toradex.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.2 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

On 18/05/2022 11:49, Francesco Dolcini wrote:
> Hello Marco,
> 
> On Wed, May 18, 2022 at 10:55:22AM +0200, Marco Felsch wrote:
>> On 22-05-16, Francesco Dolcini wrote:
>>> Currently the imx thermal driver has a hardcoded critical temperature
>>> value offset of 5 Celsius degrees from the actual SoC maximum
>>> temperature.
>>>
>>> This affects applications and systems designed to be working on this close
>>> to the limit, but yet valid, temperature range.
>>>
>>> Given that there is no single value that will fit all the use cases make
>>> the critical trip point offset from the max temperature configurable
>>> using a newly added trip_offset module parameter, passive trip point is
>>> set to 5 Celsius degrees less than the critical. By default the
>>> system behaves exactly as before.
>>
>> I thought the conclusion of the discussion was to use a dt-property?
>> Since it is device and/or environment specific.
> 
> Daniel proposed to use a module parameter [0], but if you prefer a
> dt-property I can change this. I would keep the same semantic (offset
> from max temperature to compute the critical trip point).
> 
> [0] https://lore.kernel.org/all/7f5a919c-2fa1-a463-1f6b-6b531d5ee27d@linaro.org/


It would have been easier if the imx6/7 platforms were defining the 
thermal zones in their DT ...


-- 
<http://www.linaro.org/> Linaro.org │ Open source software for ARM SoCs

Follow Linaro:  <http://www.facebook.com/pages/Linaro> Facebook |
<http://twitter.com/#!/linaroorg> Twitter |
<http://www.linaro.org/linaro-blog/> Blog
