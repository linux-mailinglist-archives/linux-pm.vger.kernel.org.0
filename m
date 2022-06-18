Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 172DC550188
	for <lists+linux-pm@lfdr.de>; Sat, 18 Jun 2022 03:06:54 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237595AbiFRBGv (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Fri, 17 Jun 2022 21:06:51 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45920 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235826AbiFRBGv (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Fri, 17 Jun 2022 21:06:51 -0400
Received: from mail-pf1-x429.google.com (mail-pf1-x429.google.com [IPv6:2607:f8b0:4864:20::429])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5750A3F31F
        for <linux-pm@vger.kernel.org>; Fri, 17 Jun 2022 18:06:50 -0700 (PDT)
Received: by mail-pf1-x429.google.com with SMTP id bo5so5487452pfb.4
        for <linux-pm@vger.kernel.org>; Fri, 17 Jun 2022 18:06:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=message-id:date:mime-version:user-agent:subject:content-language:to
         :cc:references:from:in-reply-to:content-transfer-encoding;
        bh=4i6UuDHyzuXvWTD9bTZ/UWmTwk5+Cya+i2clQmaWGpo=;
        b=NL+o1GuVsnymvPYdItw6MpiuCNqHscAzvnTWgjRqqnJXYoZSeLUgC+8SvVmImaKSbN
         VdiEQ0fJ72lz+iTRfrqJUHfhDxXity0DC5GYrTYDr6CBMnr7lABKrW1rqd7/+9vhk/Bw
         xD82jmuMMhCK94Z0aS7QPZ8+mZ5t0GMk4fZFu98Db8M1w7fO9iPJOCOLnI/XygT/Zij3
         n588bRsCuJSgkdHRbpBQ4viT8qbHrLxd6NT3mxJM/4gmk5O/wFT3GCJmwcuUfAA06pWy
         q03AyLgqcVQ3N7BLMnsyyV7BReJTvrInOKmOYSYIZVHn+4lLTkHofmLD1SpsBt5n12fF
         3D3Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:to:cc:references:from:in-reply-to
         :content-transfer-encoding;
        bh=4i6UuDHyzuXvWTD9bTZ/UWmTwk5+Cya+i2clQmaWGpo=;
        b=LJd9lezBgT9MVqqaM0oXuxwlPtX2sIkJ7qN94FtA0UTrlClZqed6NaH/IUsPjOji1X
         Tj4GQslPIyKYPRElQYBLHaM9kbqVVc2Vkrkr8oGduNi/+A/tVKFjqJ2mMGIZOoyIlELx
         ZEIV8tHRxz42SQ92qrKrlo3DPa70Hs5S7VjDTibR3Fjfv1bQObkqTao3EsLG1+G8lzn6
         ez1y+0M97vhdP5yKsaEAtT+q0/+Wg/kUW2Ryi+7fkVBRvuOF0fHNmU63RL68+HxZ5BG5
         3K7RXdPSeyQ5WjQbxXRaIdZh30h9s6OknQ19urWViV2Jn9p0uHV8zHNMYv1OHxJ10lgx
         /prg==
X-Gm-Message-State: AJIora/T6Nd2gaACLpRsJQIIYSvGfhq7NylZ0u4SSo91Wl7Bu5mC7eig
        +eZ3RhdQ5BW39ndvfgDSgAk99Q==
X-Google-Smtp-Source: AGRyM1tp0JoLvAi08jKV+3kv4u96brbrn/fmSLtPjO/hgImVyYTbyQEshIukEd3sRH8lyLmJaRnDGg==
X-Received: by 2002:a63:b50a:0:b0:409:8661:cd56 with SMTP id y10-20020a63b50a000000b004098661cd56mr10565087pge.511.1655514409810;
        Fri, 17 Jun 2022 18:06:49 -0700 (PDT)
Received: from [172.31.235.92] ([216.9.110.6])
        by smtp.gmail.com with ESMTPSA id h2-20020a170902f70200b0015e8d4eb231sm4123069plo.123.2022.06.17.18.06.48
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 17 Jun 2022 18:06:49 -0700 (PDT)
Message-ID: <268a2d44-8bd4-158a-41d8-b41dfc15cd88@linaro.org>
Date:   Fri, 17 Jun 2022 18:06:40 -0700
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.10.0
Subject: Re: [RESEND PATCH v2 0/9] imx: thermal: Allow trip point
 configuration from DT
Content-Language: en-US
To:     Francesco Dolcini <francesco.dolcini@toradex.com>,
        Daniel Lezcano <daniel.lezcano@linaro.org>,
        Rob Herring <robh+dt@kernel.org>,
        "Rafael J. Wysocki" <rafael@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Shawn Guo <shawnguo@kernel.org>,
        Marco Felsch <m.felsch@pengutronix.de>,
        Anson Huang <Anson.Huang@nxp.com>
Cc:     Amit Kucheria <amitk@kernel.org>, Zhang Rui <rui.zhang@intel.com>,
        linux-pm@vger.kernel.org, devicetree@vger.kernel.org,
        Pengutronix Kernel Team <kernel@pengutronix.de>,
        Sascha Hauer <s.hauer@pengutronix.de>,
        Fabio Estevam <festevam@gmail.com>,
        NXP Linux Team <linux-imx@nxp.com>,
        linux-arm-kernel@lists.infradead.org
References: <20220617071411.187542-1-francesco.dolcini@toradex.com>
From:   Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
In-Reply-To: <20220617071411.187542-1-francesco.dolcini@toradex.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-4.3 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

On 17/06/2022 00:14, Francesco Dolcini wrote:
> This series allows to specify the imx thermal drivers trip point from the device tree,
> without this change the threshold are hard-coded and this might not be correct given the
> thermal design of the final system.

Why resending? What was wrong with your v2 to which I replied?

Best regards,
Krzysztof
