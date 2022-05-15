Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4E34852769D
	for <lists+linux-pm@lfdr.de>; Sun, 15 May 2022 11:39:31 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234518AbiEOJjJ (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Sun, 15 May 2022 05:39:09 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59762 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231134AbiEOJjH (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Sun, 15 May 2022 05:39:07 -0400
Received: from mail-lj1-x233.google.com (mail-lj1-x233.google.com [IPv6:2a00:1450:4864:20::233])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CEED217066
        for <linux-pm@vger.kernel.org>; Sun, 15 May 2022 02:39:05 -0700 (PDT)
Received: by mail-lj1-x233.google.com with SMTP id 16so14910328lju.13
        for <linux-pm@vger.kernel.org>; Sun, 15 May 2022 02:39:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=message-id:date:mime-version:user-agent:subject:content-language:to
         :references:from:in-reply-to:content-transfer-encoding;
        bh=Yu4O7LagtKlxKt7NrmLqocjDNakJ5fWhw384x76bvFY=;
        b=j5hAylij16pQUUnT9WOaTb8Ww/4Hw9j0CSEdTqNrsBWh/N+N7+k4ROEomJRr/yycJ2
         IyBQsdHZt04OsCiExwtG6dQMu6L8ulaIErjWXAEnIVR0jP+wdfgVXRQUyX7S9WGskDAk
         E84Was24QN+czkYskakd96p3zQG63UQzhkxSCzjXM/hfLT1RwZgrn0HtCfqMC22x9OH1
         9RaDjFBMqWwhMCDdJ6lpY3RF9DIsMPunpgAgA4CLae8U8SIY3Z1Wg8sLC8rPrTGxjs0y
         jlmwGJH6H2K4Mymgcl4TxqPAycqBe4mbwrwdyMnyKGK7UvBnpTkMA91UKiILIpYK4ZOP
         7rgQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:to:references:from:in-reply-to
         :content-transfer-encoding;
        bh=Yu4O7LagtKlxKt7NrmLqocjDNakJ5fWhw384x76bvFY=;
        b=sU76OvBGikYIgdMcwt5xhh/vW3E55SEGbKxk4mF1pZrsb5dXMtcj9Iu2xmrww6wFup
         kVmji0Q6ILGu+PiG3MJC52SuGLOcPjW5z7RvmXlGDGee6ztONvOHAKeQRIGhEC/K3R/B
         tW00mslxMQzSXZsFulAc32CBTjZ7vL2nsNhWvmU5BVRlBEXbhmQyJHYiDz+d12bsZ1qt
         D+M8jd1CEbVCWvBqFW10vGXrCndr9iYsvJ0FTrzZEjXUOv1Q2Azz/GUbFJpp/BPiSK/P
         LOuq4tuYRCZD0vjf8xhaxKb/B1i445Z2uSc5Gkxq9BagOAWVyVZOMKrr4v7+pr1DDu8A
         D7Bg==
X-Gm-Message-State: AOAM5315rajB0gTHC3EYlHxDEzH3tzhIfjIuH5tZmH77l+91FIVRCFpT
        E+S7L94HSks4wCIMFcQmLsLUWQ==
X-Google-Smtp-Source: ABdhPJyIGsAf1NokiFpll09E/rE+AGFeWkwPoYBvHo4R36v8Eu4PtSNmQ+sgfHOXddu8560EQDwtbA==
X-Received: by 2002:a2e:b705:0:b0:250:808a:f7cc with SMTP id j5-20020a2eb705000000b00250808af7ccmr7637249ljo.455.1652607544107;
        Sun, 15 May 2022 02:39:04 -0700 (PDT)
Received: from [192.168.0.17] (78-11-189-27.static.ip.netia.com.pl. [78.11.189.27])
        by smtp.gmail.com with ESMTPSA id a10-20020ac25e6a000000b0047255d21165sm964964lfr.148.2022.05.15.02.39.03
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sun, 15 May 2022 02:39:03 -0700 (PDT)
Message-ID: <666cfe69-f61a-b89f-b186-278150d0ab3b@linaro.org>
Date:   Sun, 15 May 2022 11:39:02 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.8.1
Subject: Re: [PATCHv2 1/6] thermal: exynos: Enable core tmu hardware clk flag
 on exynos platform
Content-Language: en-US
To:     Anand Moon <linux.amoon@gmail.com>,
        Bartlomiej Zolnierkiewicz <bzolnier@gmail.com>,
        "Rafael J. Wysocki" <rafael@kernel.org>,
        Daniel Lezcano <daniel.lezcano@linaro.org>,
        Amit Kucheria <amitk@kernel.org>,
        Zhang Rui <rui.zhang@intel.com>,
        Alim Akhtar <alim.akhtar@samsung.com>,
        linux-pm@vger.kernel.org, linux-samsung-soc@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
References: <20220515064126.1424-1-linux.amoon@gmail.com>
 <20220515064126.1424-2-linux.amoon@gmail.com>
From:   Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
In-Reply-To: <20220515064126.1424-2-linux.amoon@gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-3.7 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

On 15/05/2022 08:41, Anand Moon wrote:
> Use clk_prepare_enable api to enable tmu internal hardware clock
> flag on, use clk_disable_unprepare to disable the clock.

Please explain why this is needed. Each change needs explanation why you
are doing it.


Best regards,
Krzysztof
