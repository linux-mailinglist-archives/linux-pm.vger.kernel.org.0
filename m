Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EB9A66E3AE4
	for <lists+linux-pm@lfdr.de>; Sun, 16 Apr 2023 19:55:30 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229791AbjDPRz3 (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Sun, 16 Apr 2023 13:55:29 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57658 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229725AbjDPRz2 (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Sun, 16 Apr 2023 13:55:28 -0400
Received: from mail-ed1-x532.google.com (mail-ed1-x532.google.com [IPv6:2a00:1450:4864:20::532])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0E2BC1FDB
        for <linux-pm@vger.kernel.org>; Sun, 16 Apr 2023 10:55:26 -0700 (PDT)
Received: by mail-ed1-x532.google.com with SMTP id 4fb4d7f45d1cf-50489c109f4so6448622a12.2
        for <linux-pm@vger.kernel.org>; Sun, 16 Apr 2023 10:55:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1681667724; x=1684259724;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=x7wT7n+DJMWXCwF/JmEqtyfQLfvwMTp3PMeKPlacVvI=;
        b=N50SBxfRyEvNTrmfJYbWrp3K5WfAffRN7269lKy7ZahDLbF6YzyDwCeQmn5st8ZNVU
         TiWP59+AIx+c+ZAGcexmwq8zozFdGU5WSKa0UB25+PDCSc4DR2aFOxSshDG+yG6lZTtE
         VMUmyj7xEqwhgDxlwjVLbKZKrUgLZnSKjeZhv+bN3aVy2SnxHo3wD+ssFpSxvT0fw9Ji
         nJvfEOqJZiPies9FMmCiYIx+QgQtaXzqnJjIOFIiaOXhUbVZsKOGnjX81ore0i2FBzsQ
         emUEEbZhA3wQAmVg2rwJObOsNrFJMsE1DgyeFgvnwHPLIUuX6x4NX+GzS89nY5R8k+q6
         g9Hw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1681667724; x=1684259724;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=x7wT7n+DJMWXCwF/JmEqtyfQLfvwMTp3PMeKPlacVvI=;
        b=epAa9Yu91PMKzzqnpmj5BJzo8+hN5Ip/u+Tou0E3khZ/pGEf1icmSZSc5sn4JGzwtT
         vjlv4Lw6CHMGCUHs3duz5E6s0+C0HCV9pIGyd23cWIQDPgtQyo0r60HF/raHAFkv4OPW
         WitZyQ6BYxO5sFUYIIZyHFFaoR5KOYOdQ0P5VaCm8lcCL2hVfAOsxJMlg0iRI8xLw940
         Vvso4ffVZv6iZZl6gupkXS9HCNK1YpTxks47Mh4UBNH7n3BNb1l4TrDIjOUCTk7hK4SB
         Kd0a9VLHE593PGEbkGEQwmJRaQ30IoOt/wcpIexLdc50xcErLXgNySIgWuANekPu6pVA
         9VnQ==
X-Gm-Message-State: AAQBX9fh80a3I/DWP6LxH+Tl3DOMA6TK5cv3xp9L/9p0mtVFL1mJ6aqK
        XFWVyvmVegvAcw9g+h5Db3zqyA==
X-Google-Smtp-Source: AKy350avKh9PmUHvsOygNn3GPct8a9xHAE66Mg83Bz+YU/JqH0f5dabMl/mfcrMIbTTp5Lai6EdXjw==
X-Received: by 2002:aa7:d352:0:b0:505:394:157b with SMTP id m18-20020aa7d352000000b005050394157bmr12230901edr.17.1681667724514;
        Sun, 16 Apr 2023 10:55:24 -0700 (PDT)
Received: from ?IPV6:2a02:810d:15c0:828:f9e3:1d38:66a7:ae92? ([2a02:810d:15c0:828:f9e3:1d38:66a7:ae92])
        by smtp.gmail.com with ESMTPSA id b11-20020a056402138b00b0050690bc07a3sm2240983edv.18.2023.04.16.10.55.23
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sun, 16 Apr 2023 10:55:24 -0700 (PDT)
Message-ID: <99b7f216-114b-c01a-cb27-7dbcfc0c3b5c@linaro.org>
Date:   Sun, 16 Apr 2023 19:55:22 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.10.0
Subject: Re: [PATCH v2 02/12] dt-bindings: clock: add Exynos4212 clock
 compatible
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
References: <20230416133422.1949-1-aweber.kernel@gmail.com>
 <20230416133422.1949-3-aweber.kernel@gmail.com>
From:   Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
In-Reply-To: <20230416133422.1949-3-aweber.kernel@gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-3.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

On 16/04/2023 15:34, Artur Weber wrote:
> The platform was originally dropped in commit bca9085e0ae9 ("ARM:
> dts: exynos: remove Exynos4212 support (dead code)"), as there were
> no boards using it.

Also wrong commit. Reference the one which dropped compatible from bindings.

> 
> We will be adding a device that uses it, so add it back.
> 
> Signed-off-by: Artur Weber <aweber.kernel@gmail.com>


Best regards,
Krzysztof

