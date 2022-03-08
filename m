Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4B4114D1FAB
	for <lists+linux-pm@lfdr.de>; Tue,  8 Mar 2022 19:05:56 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236694AbiCHSGq (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Tue, 8 Mar 2022 13:06:46 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43028 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231637AbiCHSGp (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Tue, 8 Mar 2022 13:06:45 -0500
Received: from smtp-relay-internal-1.canonical.com (smtp-relay-internal-1.canonical.com [185.125.188.123])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3BAD35622F
        for <linux-pm@vger.kernel.org>; Tue,  8 Mar 2022 10:05:49 -0800 (PST)
Received: from mail-ed1-f72.google.com (mail-ed1-f72.google.com [209.85.208.72])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (No client certificate requested)
        by smtp-relay-internal-1.canonical.com (Postfix) with ESMTPS id 17F1A3F5F2
        for <linux-pm@vger.kernel.org>; Tue,  8 Mar 2022 18:05:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canonical.com;
        s=20210705; t=1646762748;
        bh=fxacC+X8vGcG34HtZ40W460Prid6yVdnSvuBB2MttQg=;
        h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
         In-Reply-To:Content-Type;
        b=KtWGQb3j5DR2k6y0Ib7v6XVXq5P4j2ACXXTWJY7woCQXOTik0JWywl2sn36SRXBHx
         e0CuJTsf5kJ0QFr9+8MwY/CPfxbFQrbNxv8DTNwPl+WRic468vvgb9sqXyqc64l70f
         YzgJd6X/SpjVbg17i3ExLfbPDPJqnYJtljgd7it/RIgvBfzpPDZRIHHOXFaEapNV2x
         c8zjeLcLhZoXIFDKPmWySIMHwwTMxWy10urzXndeVgRQmSS0eLiJda4SqXp+N87f/I
         S/WxfWCZh8y0f7B0qIsd0dJ2xJ/Ofei6xsS9vDiWTE25hYZAUgsI2unSq6hZ1EGEVh
         CiVfyV/pae7MA==
Received: by mail-ed1-f72.google.com with SMTP id cf6-20020a0564020b8600b00415e9b35c81so1677468edb.9
        for <linux-pm@vger.kernel.org>; Tue, 08 Mar 2022 10:05:48 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:to:cc:references:from:in-reply-to
         :content-transfer-encoding;
        bh=fxacC+X8vGcG34HtZ40W460Prid6yVdnSvuBB2MttQg=;
        b=aPjdCWEBJJzK8a5lavaOsVk54q7/Gvm0+0yrUV7+ulcMGMk/5kolifZ3Nwf51NDmlg
         iXsuxperT/f/6ipSxUIx4+vBdRrUmIjdOf6nq8r9zK3AYuajg4cM5uhQb5scyhfBxdAb
         IfS1dPIQ/XUhpucFaCE9r6Tz54mALjP0ObkaEffWjBdNkU1WsHG6tVpmYJEejo+3iliA
         rKs74rfzC8kBTajNSRoH2kWz1pLNr3Zr6KSAe4LYMfEjxspbwXHBvFJlTLfuu4vqgAhW
         p+Dq2BAc7jQAWtuDJzkyNI7YbwU6u7iLY4/Vd8SxoaC6+ZA5/J+RRXIYuZGB19sYQXUE
         P2LQ==
X-Gm-Message-State: AOAM531/lJPv9l8iKx4qNu1MZJJ+Iy1WhoSmFhlDdjBMTZGkHS459UIb
        eqtTpGNW9uo5i4Iul2zIVFwiYG2mKzyH+8g0BrBDNhiKwvNyyWMEGmT0ByFUOem7yN79mP0sgI6
        6t29S8dNeWX95p6QpyTE1idgFGCroUCsCljjL
X-Received: by 2002:a05:6402:27c9:b0:416:70e5:d655 with SMTP id c9-20020a05640227c900b0041670e5d655mr3923391ede.410.1646762747286;
        Tue, 08 Mar 2022 10:05:47 -0800 (PST)
X-Google-Smtp-Source: ABdhPJy5d/d+xm6Ot6fJtpnZgQ+JM9cB5VCZXtwrRwiowWcRB4VNvhr/RyYIAAt3oB9t0PwptC3WOw==
X-Received: by 2002:a05:6402:27c9:b0:416:70e5:d655 with SMTP id c9-20020a05640227c900b0041670e5d655mr3923256ede.410.1646762745914;
        Tue, 08 Mar 2022 10:05:45 -0800 (PST)
Received: from [192.168.0.144] (xdsl-188-155-174-239.adslplus.ch. [188.155.174.239])
        by smtp.gmail.com with ESMTPSA id n13-20020a1709062bcd00b006cf71d46a1csm6092052ejg.136.2022.03.08.10.05.44
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 08 Mar 2022 10:05:45 -0800 (PST)
Message-ID: <c767eeb0-07d1-f6d5-4c63-969105194455@canonical.com>
Date:   Tue, 8 Mar 2022 19:05:44 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.5.0
Subject: Re: [PATCH v3 03/15] dt-bindings: devfreq: rk3399_dmc: Fix Hz units
Content-Language: en-US
To:     Brian Norris <briannorris@chromium.org>,
        MyungJoo Ham <myungjoo.ham@samsung.com>,
        Kyungmin Park <kyungmin.park@samsung.com>,
        Chanwoo Choi <cw00.choi@samsung.com>,
        Rob Herring <robh+dt@kernel.org>
Cc:     Lin Huang <hl@rock-chips.com>, Heiko Stuebner <heiko@sntech.de>,
        Derek Basehore <dbasehore@chromium.org>,
        linux-rockchip@lists.infradead.org, linux-kernel@vger.kernel.org,
        linux-pm@vger.kernel.org, devicetree@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, Rob Herring <robh@kernel.org>
References: <20220308000945.706701-1-briannorris@chromium.org>
 <20220307160918.v3.3.I9341269171c114d0e04e41d48037fd32816e2d8c@changeid>
From:   Krzysztof Kozlowski <krzysztof.kozlowski@canonical.com>
In-Reply-To: <20220307160918.v3.3.I9341269171c114d0e04e41d48037fd32816e2d8c@changeid>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-4.9 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_MED,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

On 08/03/2022 01:09, Brian Norris wrote:
> The driver and all downstream device trees [1] are using Hz units, but
> the document claims MHz. DRAM frequency for these systems can't possibly
> exceed 2^32-1 Hz, so the choice of unit doesn't really matter than much.
> 
> Rather than add unnecessary risk in getting the units wrong, let's just
> go with the unofficial convention and make the docs match reality.
> 
> A sub-1MHz frequency is extremely unlikely, so include a minimum in the
> schema, to help catch anybody who might have believed this was MHz.
> 
> [1] And notably, also those trying to upstream them:
> https://lore.kernel.org/lkml/20210308233858.24741-3-daniel.lezcano@linaro.org/
> 
> Signed-off-by: Brian Norris <briannorris@chromium.org>
> Reviewed-by: Rob Herring <robh@kernel.org>
> Acked-by: Chanwoo Choi <cw00.choi@samsung.com>
> ---
> 
> Changes in v3:
>  * Add Reviewed-by, Acked-by
> 


Reviewed-by: Krzysztof Kozlowski <krzysztof.kozlowski@canonical.com>


Best regards,
Krzysztof
