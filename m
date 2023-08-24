Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C3894786F44
	for <lists+linux-pm@lfdr.de>; Thu, 24 Aug 2023 14:39:48 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231428AbjHXMjQ (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Thu, 24 Aug 2023 08:39:16 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35460 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239371AbjHXMjB (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Thu, 24 Aug 2023 08:39:01 -0400
Received: from mail-lj1-x22f.google.com (mail-lj1-x22f.google.com [IPv6:2a00:1450:4864:20::22f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F0B7919B0
        for <linux-pm@vger.kernel.org>; Thu, 24 Aug 2023 05:38:58 -0700 (PDT)
Received: by mail-lj1-x22f.google.com with SMTP id 38308e7fff4ca-2bc63e0d8cdso77501961fa.2
        for <linux-pm@vger.kernel.org>; Thu, 24 Aug 2023 05:38:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1692880737; x=1693485537;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=Ow9NOphQ8IONMB2AXu8+252ehewy1z2boFnf/IKv/6M=;
        b=eambqQ7pCYYmPdWFTxoyYu6uNFh5RJAGvl1KuHiF+JiLQCkcwk1qwhYKUoC8duBvIt
         UGNesT9QHKJpk+Jl21nGs5aMbW8guDl+B2nayZHEA3NBQIX/1YzVwOajmaOJ87xyzBHd
         89S4CfbMFpZrkk0iScQu3P+zmMF4Ftgi66dVGxvO06D5pZtrMKVjIvv6kr7P8UiWA5uR
         Gw+gu+LpUDxT7dwgSSAqb58GnAqW2dXfnCbXRd8pt84XRtBbouS+DRqxw+YfoaMmxOqi
         /c+PlP9rLRIFygSaopcWSuvHBSmNnbHsnNPn/KeMt/mhTicjwSJ2towFXy/WCKyo+go3
         kxZg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1692880737; x=1693485537;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=Ow9NOphQ8IONMB2AXu8+252ehewy1z2boFnf/IKv/6M=;
        b=kf4vY6fE5R3ZurOP/7vHJB/2a1tnMvxZsiYiZiv5knjn+XJTHYWGezxt/xZS5l6ywt
         jB++l4L29yVXod8RnUejtHDS7o3ZKcF50gj6z5eJl1LI8q4PKlTF7GJJy8eTzGirJP4p
         TRPbrVQAcLx8fgpEF9/SK63a6mRmYTUYg+lzVmR2m4TFd0Nz6vI9hSPpr+pg569lI9if
         6DAbl99+c9Be8PtWyrag4Rn3brRoHFh06qSMAO6x3SYGo+idhCte5DWJCl0jPq8usHYm
         SzZMO5k68rGsj37R+4Xl964KQhdhz/99rpDOhh2Yk8zCY3YMn+e+dgXbBaEBrsJ5kWrQ
         o/EQ==
X-Gm-Message-State: AOJu0Yx9QHMAweCkjY19c0AbKiFbRqVThJmuPeNqAPEb3sD6/Noi64u8
        o3OYDXxzrM8ek/EfWO4gEC0PxA==
X-Google-Smtp-Source: AGHT+IGf+t2VSlw4E7BuiJ9UKPIOHMulAO3nhihDW7DtQAJO45zjGFW9mqDUSVrDAXTQ0TVcSk7qBA==
X-Received: by 2002:a2e:860d:0:b0:2b7:1005:931b with SMTP id a13-20020a2e860d000000b002b71005931bmr11740315lji.0.1692880737196;
        Thu, 24 Aug 2023 05:38:57 -0700 (PDT)
Received: from [192.168.0.22] ([77.252.47.198])
        by smtp.gmail.com with ESMTPSA id jt11-20020a170906dfcb00b0098921e1b064sm10884955ejc.181.2023.08.24.05.38.56
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 24 Aug 2023 05:38:56 -0700 (PDT)
Message-ID: <36e24244-3382-b6bb-5975-044112d21eed@linaro.org>
Date:   Thu, 24 Aug 2023 14:38:55 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.14.0
Subject: Re: [PATCH 1/2] dt-bindings: imx8mm-thermal: Document
 'nxp,reboot-on-critical'
To:     Fabio Estevam <festevam@gmail.com>,
        Daniel Lezcano <daniel.lezcano@linaro.org>
Cc:     linux-pm@vger.kernel.org, krzysztof.kozlowski+dt@linaro.org,
        robh+dt@kernel.org, conor+dt@kernel.org,
        devicetree@vger.kernel.org, Fabio Estevam <festevam@denx.de>
References: <20230823173334.304201-1-festevam@gmail.com>
 <cd1985cf-f13b-8d5b-1f67-f93bae98ce7d@linaro.org>
 <CAOMZO5CPz=ysfjb_x3T0FqKxjTPy1zippZRnkMXCTuyD7fF57g@mail.gmail.com>
 <8070b293-b187-b0cc-fd3d-d057c5623094@linaro.org>
 <CAOMZO5AZh6DUbZJecwaK8jwGBRCj+40GF5OqyuV2c8mgXT9ZYg@mail.gmail.com>
Content-Language: en-US
From:   Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
In-Reply-To: <CAOMZO5AZh6DUbZJecwaK8jwGBRCj+40GF5OqyuV2c8mgXT9ZYg@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-5.0 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

On 24/08/2023 12:53, Fabio Estevam wrote:
> Hi Daniel,
> 
> On Thu, Aug 24, 2023 at 7:35 AM Daniel Lezcano
> <daniel.lezcano@linaro.org> wrote:
> 
>>> I will try a different approach by introducing a Kconfig option.
>>
>> Alternatively, the 'chosen' DT node could be used, no ?

Any DT property would be a problem, because I don't think it is static
configuration. For example board with the same DTS once should reboot
(during development) and once shutdown (some customer wants to be sure
it will stay shutdown after critical condition). It's runtime feature.

> 
> Good idea. I will introduce a module_param() then.

Module params are usually discouraged and it also does not allow any
runtime configuration. I think you need sysfs ABI.

Best regards,
Krzysztof

