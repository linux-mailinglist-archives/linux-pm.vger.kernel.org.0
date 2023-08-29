Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0127C78C179
	for <lists+linux-pm@lfdr.de>; Tue, 29 Aug 2023 11:29:59 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234004AbjH2J3W (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Tue, 29 Aug 2023 05:29:22 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60138 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234975AbjH2J3O (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Tue, 29 Aug 2023 05:29:14 -0400
Received: from mail-ej1-x62d.google.com (mail-ej1-x62d.google.com [IPv6:2a00:1450:4864:20::62d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 27B9318D
        for <linux-pm@vger.kernel.org>; Tue, 29 Aug 2023 02:29:06 -0700 (PDT)
Received: by mail-ej1-x62d.google.com with SMTP id a640c23a62f3a-9a1de3417acso1072433366b.0
        for <linux-pm@vger.kernel.org>; Tue, 29 Aug 2023 02:29:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1693301344; x=1693906144; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=Xmxh5octwGqeO5RGQIVnznkuvhvJoPZ2ZBKJzYLzMwQ=;
        b=Ow4UpjWpu48P7TCcU81IiJy5FVlfi1uJ0H0dJfOD231rq/mWyx9Yp/2yuM1MqT3aqX
         ySKV7pHLwWR/0vMnV7ALxE+bD6v5RkzGBr6EmsA0sAwjug5/NWsSjAifUPxRUaSelnpL
         DwD/xyespKULdivBqVojLMi8s9fW34IoPNDvDBpTLNimmVTrAO1yGmS+S5WBb+5b7tte
         sqAqgLpQVBZ20hU2dRAiakDXc38I7THgy8Q1j+CdeFsobh7DjWsnmox39csDYmOjTR/j
         zayc5Kua53AG2Fss2wB9HkP/Zse4kA5Uy3CLlUaZC0lx98XkMWGWq+lxYN340B9nVfHM
         leKw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1693301344; x=1693906144;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=Xmxh5octwGqeO5RGQIVnznkuvhvJoPZ2ZBKJzYLzMwQ=;
        b=dvP4tYly9YxS5+Kr9lGHBTjFHiXCjNKGF7oEqnqCMf3o9/CDnku+tCMfaNcGHihGbk
         IHSHg1MLVbyI02cZkXDSJrCsfA6q6K+LOXlfc67CGNVTsQoCoV2cPY5dcbySORAc3WDd
         mvgcCNwhj2gKIWwEZBrwLkyVmBA/s2E0Tuhzfu6cy4owm4w/0f7GvaUZDwdJBkGMdI9b
         ocmRvVDoeW9V3fVXlvInhX4Dg2xmo5E0kFPLcRLYujE5En5bmgRYEbPThUqpDr7WnKez
         JlCr2KLmVl+V5ldDheJPjDiaDZ/peIO2AhPXwjSZpopiC6dB/+/TY1r1n6XNnVDX4rVB
         ev6Q==
X-Gm-Message-State: AOJu0YysQtSa2FuKCv0BORRmeqnETY4DE1QSAkZE9gonJcIHPt0OpXRX
        SLSzgiTI9KdXeoixhUFs3rcDuVKZ9qth8Ju23EU=
X-Google-Smtp-Source: AGHT+IHU9KGZGnusU1XYnVHMUzw0uSM+XCIW4t/d5NRt/s1Ewwm94+tSs0D06k+JkxAOvHIM8pTZLQ==
X-Received: by 2002:a17:907:60cf:b0:9a5:aa43:1c7c with SMTP id hv15-20020a17090760cf00b009a5aa431c7cmr2921621ejc.26.1693301344594;
        Tue, 29 Aug 2023 02:29:04 -0700 (PDT)
Received: from [192.168.0.22] ([77.252.47.196])
        by smtp.gmail.com with ESMTPSA id vw7-20020a170907058700b0099b921de301sm5742798ejb.159.2023.08.29.02.29.03
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 29 Aug 2023 02:29:04 -0700 (PDT)
Message-ID: <14e903fd-c1ee-9e75-4477-0d621329fb46@linaro.org>
Date:   Tue, 29 Aug 2023 11:29:02 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.14.0
Subject: Re: [PATCH 02/11] thermal: exynos: drop id field
Content-Language: en-US
To:     Mateusz Majewski <m.majewski2@samsung.com>,
        devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-samsung-soc@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-pm@vger.kernel.org
Cc:     Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley <conor+dt@kernel.org>,
        Alim Akhtar <alim.akhtar@samsung.com>,
        Bartlomiej Zolnierkiewicz <bzolnier@gmail.com>,
        "Rafael J. Wysocki" <rafael@kernel.org>,
        Daniel Lezcano <daniel.lezcano@linaro.org>,
        Amit Kucheria <amitk@kernel.org>,
        Zhang Rui <rui.zhang@intel.com>,
        Liam Girdwood <lgirdwood@gmail.com>,
        Mark Brown <broonie@kernel.org>,
        Marek Szyprowski <m.szyprowski@samsung.com>
References: <20230829091853.626011-1-m.majewski2@samsung.com>
 <CGME20230829092408eucas1p24901bbd192db03b69d774f2c5936f5b3@eucas1p2.samsung.com>
 <20230829091853.626011-3-m.majewski2@samsung.com>
From:   Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
In-Reply-To: <20230829091853.626011-3-m.majewski2@samsung.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-3.3 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

On 29/08/2023 11:18, Mateusz Majewski wrote:
> This field is not used in code, and seems to not have any meaning; in my
> tests, the value was always 0.
> 
> Signed-off-by: Mateusz Majewski <m.majewski2@samsung.com>
> ---

Please drop also remaining alias from DTS.

Reviewed-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>

Best regards,
Krzysztof

