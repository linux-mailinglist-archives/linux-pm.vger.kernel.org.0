Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5F50A6FCCE6
	for <lists+linux-pm@lfdr.de>; Tue,  9 May 2023 19:42:06 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229555AbjEIRmE (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Tue, 9 May 2023 13:42:04 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48712 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229491AbjEIRmD (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Tue, 9 May 2023 13:42:03 -0400
Received: from mail-ed1-x52b.google.com (mail-ed1-x52b.google.com [IPv6:2a00:1450:4864:20::52b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E4D0740C4
        for <linux-pm@vger.kernel.org>; Tue,  9 May 2023 10:42:01 -0700 (PDT)
Received: by mail-ed1-x52b.google.com with SMTP id 4fb4d7f45d1cf-50b383222f7so9391657a12.3
        for <linux-pm@vger.kernel.org>; Tue, 09 May 2023 10:42:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1683654120; x=1686246120;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=mgSfezJnFheHWxl/J/jtAx9CEBA9nZXTq9vupUNGWSQ=;
        b=lRC7iU5SK3AyepBwA/3/NM8aYtocWUOdo7lkdukNvXDY4Jytb85mFREGFNsTrtQ8+j
         szziW02hihhrpUODgNheXG3gP74Z8t+sHnn0Eb2icPma5NcrzR5G2rYx+NUOeKP52tEG
         WIJLi6DQSmFhy59cZx8SugPE+sfAaRzkNp5K/qL3umIoGqQGjgJuPXKcn0BDXRCVBqX2
         5LMf+vPOpJ/BnboXLCMwO0/mL1b5jyE1uYGfXMzdaR2AcPgbi9SQzOlnFQIdKYq1hVG9
         jYH+NA48cM96FtvteXPLLgUkYc5Cuk6oeXCP2bfYAG/k6DeHLlFW356ohpQvYXETL/AI
         LEdA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1683654120; x=1686246120;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=mgSfezJnFheHWxl/J/jtAx9CEBA9nZXTq9vupUNGWSQ=;
        b=ahJZQa9CJIX7jAKtBHTc9oJES/UFTN1rvwlG4PKj6Uv/cHoSCGdJYB5HmsCpkYcMlv
         AenSQtycKSC1z+pmWbhbWP9fX527T7a1k+qLCXYvSIB2vl097XOc7Lgn1vN9MHTsWjE+
         gJ1SCTDFhrdgj1LxYW1bov9E9bCDwrRQVDc2kA3DHEQlsuPjt3s6aZSuc+ArVYflENVb
         Dr8eOngbfJcuB+E0jFGllciTJkBmsWZSPGrAHNRmH+7mgVZngmmyZq5YM9SpywjMXV5E
         PzWSNjtmNW+O3wjIqR4DLwVKAqZdhqcDzC+iMYS4IBpdu0tBBf2aqwMB91AVUfOBhlim
         oxNg==
X-Gm-Message-State: AC+VfDwdVk0M7eBTKRFjuff5/jxXtIs6x1fQfyegvWq6pjk8jfWz76x/
        tKmwLv2fnfNKj9+g5USdVk4Mdg==
X-Google-Smtp-Source: ACHHUZ7eebYnB6rhiI+xoinXTZKwvRZJY07rLy5XPSTfTbZWrjT1idLyIRNVuDPZtkAUIN71D6Aavg==
X-Received: by 2002:a17:907:6d20:b0:969:e304:441d with SMTP id sa32-20020a1709076d2000b00969e304441dmr3709171ejc.4.1683654120430;
        Tue, 09 May 2023 10:42:00 -0700 (PDT)
Received: from ?IPV6:2a02:810d:15c0:828:d0d5:7818:2f46:5e76? ([2a02:810d:15c0:828:d0d5:7818:2f46:5e76])
        by smtp.gmail.com with ESMTPSA id 13-20020a170906328d00b00969f44bbef1sm960264ejw.89.2023.05.09.10.41.58
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 09 May 2023 10:41:59 -0700 (PDT)
Message-ID: <254dcea1-636a-550d-59ae-5889ffe49f6c@linaro.org>
Date:   Tue, 9 May 2023 19:41:58 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.11.0
Subject: Re: [PATCH v3 07/13] Revert "media: exynos4-is: Remove dependency on
 obsolete SoC support"
Content-Language: en-US
To:     Artur Weber <aweber.kernel@gmail.com>
Cc:     Alim Akhtar <alim.akhtar@samsung.com>,
        Rob Herring <robh+dt@kernel.org>,
        Sylwester Nawrocki <s.nawrocki@samsung.com>,
        Tomasz Figa <tomasz.figa@gmail.com>,
        Chanwoo Choi <cw00.choi@samsung.com>,
        Michael Turquette <mturquette@baylibre.com>,
        Stephen Boyd <sboyd@kernel.org>, Arnd Bergmann <arnd@arndb.de>,
        Olof Johansson <olof@lixom.net>, soc@kernel.org,
        Russell King <linux@armlinux.org.uk>,
        Daniel Lezcano <daniel.lezcano@linaro.org>,
        Kukjin Kim <kgene@kernel.org>,
        Mauro Carvalho Chehab <mchehab@kernel.org>,
        Vinod Koul <vkoul@kernel.org>,
        Kishon Vijay Abraham I <kishon@kernel.org>,
        linux-arm-kernel@lists.infradead.org,
        linux-samsung-soc@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-clk@vger.kernel.org,
        linux-pm@vger.kernel.org, linux-media@vger.kernel.org,
        linux-phy@lists.infradead.org,
        ~postmarketos/upstreaming@lists.sr.ht
References: <20230501195525.6268-1-aweber.kernel@gmail.com>
 <20230501195525.6268-8-aweber.kernel@gmail.com>
From:   Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
In-Reply-To: <20230501195525.6268-8-aweber.kernel@gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.5 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

On 01/05/2023 21:55, Artur Weber wrote:
> Support for the Exynos4212 SoC was originally dropped as there were
> no boards using it. We will be adding a device that uses it, so add
> it back.
> 
> This reverts commit 2d41a0c9ae51ac363d107f2510022106e7234b33.
> 
> Signed-off-by: Artur Weber <aweber.kernel@gmail.com>
> ---
>  drivers/media/platform/samsung/exynos4-is/Kconfig     | 2 +-
>  drivers/media/platform/samsung/exynos4-is/fimc-core.c | 2 +-
>  drivers/media/platform/samsung/exynos4-is/fimc-lite.c | 2 +-

Subject:
media: Revert "media: Remove dependency on obsolete SoC support"

I assume this will go via media tree. If not, let me know.

Reviewed-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>


Best regards,
Krzysztof

