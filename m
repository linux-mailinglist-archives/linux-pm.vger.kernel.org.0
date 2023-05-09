Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DCAFD6FCD6F
	for <lists+linux-pm@lfdr.de>; Tue,  9 May 2023 20:10:27 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235095AbjEISKY (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Tue, 9 May 2023 14:10:24 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36730 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229627AbjEISKD (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Tue, 9 May 2023 14:10:03 -0400
Received: from mail-ed1-x533.google.com (mail-ed1-x533.google.com [IPv6:2a00:1450:4864:20::533])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3D4C65252
        for <linux-pm@vger.kernel.org>; Tue,  9 May 2023 11:09:54 -0700 (PDT)
Received: by mail-ed1-x533.google.com with SMTP id 4fb4d7f45d1cf-50be17a1eceso12021958a12.2
        for <linux-pm@vger.kernel.org>; Tue, 09 May 2023 11:09:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1683655793; x=1686247793;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Ykc+NJpWYwnllZDoX+4ReA3Lc/adaxGurWdFgmTtwT0=;
        b=B6Yv33IStPyelhF8OdQygmYARdIpTY5gvloVmpFKVFLdmY36IHBVaIqGzzC5awUkeN
         /IkIB9KZxwsd3X5wqYzNtkm/8WuidZ39KahyAroxdgonmgJprWHZLx06lUeOSWhvTLFX
         2nEPns/1AE9vYOfufWTnTHwL+KDXRF2nWToaeiaBH0YaCCBXcmTHk1ia03YOuMN+qh4g
         nQfU874wLJOcTPMvwggyb2PLML1Z8y+KxRvxqvm//kJzsW37Ry7j4oBBmdDVjjbTrUKc
         OrzU7aKP6lTL7mwQgjZajKzB4caL1HBVIphp38ZfnuM9BngPb6E/t82gJV6hu0H2NKef
         S7iw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1683655793; x=1686247793;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Ykc+NJpWYwnllZDoX+4ReA3Lc/adaxGurWdFgmTtwT0=;
        b=aZgb58c91Z6MUpGJb4yhItqzb7vchHgzOihsrSrfD6o/Ks+0aoeID1+JejkzjNxTNW
         A2EgoKIKL5zey16GnATi7HOrYtSYWuHgVj+mm3B9qvdLqa+Na/QfZXEo8D8NUS9wSt98
         jImmql5UZgXrvj24iiRgqdtVUwtahdpiN06ow4Ys5IR8q/4yogreNhs06XVebETznCZ1
         KoA1TU0vzIib7ftRSh6V164OtNbphUhaEsi25wCCY8qodBCMWpjpABavvbDMecce2ldo
         2sFUxR9t6kldbyTSJpUo6uzvCLE5OfI2oi5POx9scz2BmClNrQg9hKx3eyTxwKahDwOm
         gj8g==
X-Gm-Message-State: AC+VfDx+WxTfCyazYeS5FFykpmf/UD6lNrQrEtVhV7biWn1XsNgVLxSt
        tAeZXBbKWXUFM3E+a/DjwNht3A==
X-Google-Smtp-Source: ACHHUZ4K/EPxDUp5cN5i+MrYJtRHUxzNOUDZ9RANSIgFtgZnmxcaiqDZslD35IsjyHMjpIBOsiCHEQ==
X-Received: by 2002:aa7:cb87:0:b0:50b:c8b1:574b with SMTP id r7-20020aa7cb87000000b0050bc8b1574bmr10792916edt.3.1683655792838;
        Tue, 09 May 2023 11:09:52 -0700 (PDT)
Received: from krzk-bin.. ([2a02:810d:15c0:828:d0d5:7818:2f46:5e76])
        by smtp.gmail.com with ESMTPSA id dy28-20020a05640231fc00b0050d8b5757d1sm1015286edb.54.2023.05.09.11.09.51
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 09 May 2023 11:09:52 -0700 (PDT)
From:   Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
To:     Artur Weber <aweber.kernel@gmail.com>
Cc:     Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>,
        Alim Akhtar <alim.akhtar@samsung.com>,
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
Subject: Re: (subset) [PATCH v3 10/13] ARM: dts: Re-introduce Exynos4212 DTSI
Date:   Tue,  9 May 2023 20:09:35 +0200
Message-Id: <168365575566.242810.2057690967168679631.b4-ty@linaro.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20230501195525.6268-11-aweber.kernel@gmail.com>
References: <20230501195525.6268-1-aweber.kernel@gmail.com> <20230501195525.6268-11-aweber.kernel@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org


On Mon, 01 May 2023 21:55:22 +0200, Artur Weber wrote:
> Support for the Exynos4212 SoC was originally dropped as there were
> no boards using it. We will be adding a device that uses it, so add
> it back.
> 
> This reverts commit bca9085e0ae93253bc93ce218c85ac7d7e7f1831.
> 
> 
> [...]

Applied, thanks!

[10/13] ARM: dts: Re-introduce Exynos4212 DTSI
        https://git.kernel.org/krzk/linux/c/41bf1a9f9fbdec5dd1ba69fe26157f42e44dcee4

Best regards,
-- 
Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
