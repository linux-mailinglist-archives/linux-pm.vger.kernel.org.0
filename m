Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 092F4707B9E
	for <lists+linux-pm@lfdr.de>; Thu, 18 May 2023 10:09:59 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229911AbjERIJ5 (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Thu, 18 May 2023 04:09:57 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47938 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229906AbjERIJ4 (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Thu, 18 May 2023 04:09:56 -0400
Received: from mail-ed1-x531.google.com (mail-ed1-x531.google.com [IPv6:2a00:1450:4864:20::531])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CB02210D0
        for <linux-pm@vger.kernel.org>; Thu, 18 May 2023 01:09:54 -0700 (PDT)
Received: by mail-ed1-x531.google.com with SMTP id 4fb4d7f45d1cf-510dabb39aeso1744193a12.2
        for <linux-pm@vger.kernel.org>; Thu, 18 May 2023 01:09:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1684397393; x=1686989393;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=EJxby0a+YmdYDvcCxlD5hpNSZCvF8AURr2ESqmEsXcQ=;
        b=roz1BvvCBDBA1YW13M5M3ur9lJkN+WLNuHW6bv0itetl1VXAc5QvBxAyp9qZfVVOlC
         xPwWe4qc6Uw3XPJBXglJsoJ2ZBgynrplDgJEhknrQNPjrd4zt4t5aXJy7dnX7DH+5UQ7
         46xGeXz6+qGInnV/Wv4Y7/Ut0F+IQf4cBOYUSGuFlYhL9mmwL+QooPtzZ05AnaW4v8Kt
         6pXps0uufagouohv5oiS2lKwb973gHGla86MJBu8NieWOrR1UCdplv6kndrqiylclAK+
         bEb5vrB0ZxpdMM4n3ZFyTaP1rmplZiqB9v6TesrdlUunTWs084mF1/+oLV23QUyQiJqO
         6mMQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1684397393; x=1686989393;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=EJxby0a+YmdYDvcCxlD5hpNSZCvF8AURr2ESqmEsXcQ=;
        b=O8EsSmDfoRFCVr11KojrgYPHygBWjy4wTfXjY7NoLyttyOiK9buwXvA0SIYYKG14Mp
         iiAysAy0rcuTlONUn3R0e+pDCCtzMKe19L4bgjXeeGSOyN+ilHisbKLqtytQUJP8a9hL
         qed+PwxTaKmvosXGnCHlLv3p2YMZMdIeOkPV16bmzJOGTaBjlQCRzQaEuV1x2S3KYX/7
         b8Nfq+wj1CoUOlyKYonhb6GLOGlNWTtmQw0xdtqMLbgRzKPYHnE2z6IrjYgLenzEFpWC
         GrD0KqRXzUPdqCrnvFeDtAQBN7djSGzslqTonKIORuQsGK9MYcfr8pt8i/7/tUP08Gf1
         D4kA==
X-Gm-Message-State: AC+VfDwC+iaTVg/wDBChYfWAD1Ww+0TRFS+xRwJTCYvpitTHJ3b4PVz7
        +J/wL5O1kbU/Bc0yGNnCac5pMA==
X-Google-Smtp-Source: ACHHUZ663LuiIRBItYyQeixKa79sothnq8c+Ju+7jYvjArtC7VoF60c5++HSomzvx7utjoTUGIEH8w==
X-Received: by 2002:a50:ee99:0:b0:50b:fd3c:3590 with SMTP id f25-20020a50ee99000000b0050bfd3c3590mr3989404edr.42.1684397393282;
        Thu, 18 May 2023 01:09:53 -0700 (PDT)
Received: from ?IPV6:2a02:810d:15c0:828:a2b:c408:5834:f48e? ([2a02:810d:15c0:828:a2b:c408:5834:f48e])
        by smtp.gmail.com with ESMTPSA id x21-20020aa7d6d5000000b00509dfb39b52sm278050edr.37.2023.05.18.01.09.52
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 18 May 2023 01:09:52 -0700 (PDT)
Message-ID: <88987336-9558-e49c-326d-779bd3bc2aa0@linaro.org>
Date:   Thu, 18 May 2023 10:09:51 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.11.0
Subject: Re: [PATCH] PM / devfreq: exynos: add Exynos PPMU as a soft module
 dependency
Content-Language: en-US
To:     Marek Szyprowski <m.szyprowski@samsung.com>,
        Chanwoo Choi <cw00.choi@samsung.com>, linux-pm@vger.kernel.org,
        linux-samsung-soc@vger.kernel.org
Cc:     MyungJoo Ham <myungjoo.ham@samsung.com>,
        Alim Akhtar <alim.akhtar@samsung.com>
References: <CGME20230518074416eucas1p1dfd47a3438f2252211cf7daa82e2ac1e@eucas1p1.samsung.com>
 <20230518074403.2894799-1-m.szyprowski@samsung.com>
From:   Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
In-Reply-To: <20230518074403.2894799-1-m.szyprowski@samsung.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-4.7 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

On 18/05/2023 09:44, Marek Szyprowski wrote:
> Commit adf8238ef403 ("ARM: dts: exynos: move exynos-bus nodes out of soc
> in Exynos4412") changed the order of the exynos-bus nodes, what results
> in different probe order of the Exynos Bus devices. Although the driver
> properly handles the deferred probe and all devices seems to be finally
> properly registered, this change revealed some kind of a bug related to
> PPMU counters registration and passive governor operation. Usually in 1
> of 10 boots this results in complete board freeze during loading of the
> kernel modules.
> 
> To avoid that freeze, ensure that the Exynos PPMU driver is already
> loaded before the Exynos Bus driver starts probing.
> 
> Signed-off-by: Marek Szyprowski <m.szyprowski@samsung.com>


Reviewed-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>

Best regards,
Krzysztof

