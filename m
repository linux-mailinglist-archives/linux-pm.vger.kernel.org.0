Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 34E306FCD57
	for <lists+linux-pm@lfdr.de>; Tue,  9 May 2023 20:10:05 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229966AbjEISKA (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Tue, 9 May 2023 14:10:00 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36562 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234985AbjEISJu (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Tue, 9 May 2023 14:09:50 -0400
Received: from mail-ed1-x52a.google.com (mail-ed1-x52a.google.com [IPv6:2a00:1450:4864:20::52a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 476081706
        for <linux-pm@vger.kernel.org>; Tue,  9 May 2023 11:09:49 -0700 (PDT)
Received: by mail-ed1-x52a.google.com with SMTP id 4fb4d7f45d1cf-50b37f3e664so11252256a12.1
        for <linux-pm@vger.kernel.org>; Tue, 09 May 2023 11:09:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1683655787; x=1686247787;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=wTAOCVPOPtOy5y17r+mtI5VSueoAcoLIpQdMbfiTcg8=;
        b=D1PFvAm7SlYpPsPFpbjzQy80gA8ralWcfpyiMeU/EMEfyrmde5hbToU9wgYycOcF5v
         YAGOBiJA9kXiZKh8/GLzZg7upeXk909wM4m461AZhHh7bb2RhFQ8yBduQ0nJJ4Nq/o2K
         RJBJUS6ydoWHlz9PeO/s9mEkytwTeKthMGp9hCNp8d2M6W/gi66naI1GvRJq+QY4uGz3
         ajzSsfVMOtdHHDtZEvJR4ZoDkE3zvfXq1G47DUgEzDOobj7be99w7fHB6KSl80Yqzuw4
         Bzc8ItdSUVWIHCFNGojsGVJQUzgptt6T3EG/wu3hWZwAytyZn5TQuhJcJP6Fph8ngztz
         7J2Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1683655787; x=1686247787;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=wTAOCVPOPtOy5y17r+mtI5VSueoAcoLIpQdMbfiTcg8=;
        b=P6rWtx2KHKuj6JkSy+qt3Kx4rqDABeWNOOsKBi18ni6dJxGvwa6no84SJmREeChEL1
         R4j5EgoJU2omsZ6XrzqJE1rQV4xzC968FYy41gtgW2jlH1QQ9TDvHBww/vd2CApogd/6
         Hrc14F2HRImcDZyZ5FhbKIgNOBDfe6jCuCVBcw/S+GdTMqlsCRYwkmZZ7KwjOiyZwYpd
         6TJaKDktjxAOiXZdYnj5NNtkUyRRV6M8COoFThxbhRtt/M7Gdd4KFkwAPU7BsrmLb/Ng
         BXKmJeXMsiHAjggRgt6tPaSNDE20Dpgb53H8sjiYE06mDa+tjsxU0Nj1ssl81cr8KJtR
         7aHA==
X-Gm-Message-State: AC+VfDx4w83slkoa6GwIeVDdSAE8RYvnS1Sx3q7Xbg2CIHnIyZHEgGEz
        31uvCHoImp4N2l1mjycpEZby+w==
X-Google-Smtp-Source: ACHHUZ5hovFjTjykdEntWpkRkWy8gjb9Ub7wb8Lh4BgtsqFJo3AnBC7o0FPzHT4uW5ImOYI0KpKMUA==
X-Received: by 2002:a05:6402:10d7:b0:50d:bb87:247c with SMTP id p23-20020a05640210d700b0050dbb87247cmr2359508edu.1.1683655787536;
        Tue, 09 May 2023 11:09:47 -0700 (PDT)
Received: from krzk-bin.. ([2a02:810d:15c0:828:d0d5:7818:2f46:5e76])
        by smtp.gmail.com with ESMTPSA id dy28-20020a05640231fc00b0050d8b5757d1sm1015286edb.54.2023.05.09.11.09.45
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 09 May 2023 11:09:47 -0700 (PDT)
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
Subject: Re: (subset) [PATCH v3 05/13] clk: samsung: Add Exynos4212 compatible to CLKOUT driver
Date:   Tue,  9 May 2023 20:09:32 +0200
Message-Id: <168365575565.242810.6906601762854965924.b4-ty@linaro.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20230501195525.6268-6-aweber.kernel@gmail.com>
References: <20230501195525.6268-1-aweber.kernel@gmail.com> <20230501195525.6268-6-aweber.kernel@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org


On Mon, 01 May 2023 21:55:17 +0200, Artur Weber wrote:
> Support for the Exynos4212 SoC was originally dropped as there were
> no boards using it. We will be adding a device that uses it, so add
> it back.
> 
> This reverts commit d5cd103b06f9d766295d18798de484528eb120ea.
> 
> 
> [...]

Applied, thanks!

[05/13] clk: samsung: Add Exynos4212 compatible to CLKOUT driver
        https://git.kernel.org/krzk/linux/c/48b359732e166d0f5d53649e21eac8d9343b8e13

Best regards,
-- 
Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
