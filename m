Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7C2E26FCD4D
	for <lists+linux-pm@lfdr.de>; Tue,  9 May 2023 20:09:48 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234911AbjEISJq (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Tue, 9 May 2023 14:09:46 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36374 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229595AbjEISJp (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Tue, 9 May 2023 14:09:45 -0400
Received: from mail-ed1-x532.google.com (mail-ed1-x532.google.com [IPv6:2a00:1450:4864:20::532])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 591B01738
        for <linux-pm@vger.kernel.org>; Tue,  9 May 2023 11:09:43 -0700 (PDT)
Received: by mail-ed1-x532.google.com with SMTP id 4fb4d7f45d1cf-50bd2d7ba74so61377995a12.1
        for <linux-pm@vger.kernel.org>; Tue, 09 May 2023 11:09:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1683655782; x=1686247782;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=P531oV9/x4YHyyJQpy3FZFac9rbq6io6m/JeWQjftLM=;
        b=PzuJq0GFfFoj6RYV71gN0FpO0c7kgBNVclZp3ScvSdrwCgPvIvtiitjlQPUWYijCzT
         lgBdMEDYmo16sorhdRCZZ2BzE9NTB6YkYxizyhW+4l4IToWnsjGCUcqoSwstw4QUuz1I
         xDa/2rT4imCNx4inRSVeLRv0OHxZduyxfjcMCltpuEu7L5mbtkS7LzDdl27CCybJpBAw
         u+GW6TUZ2NxRNiXYs6juxBtzEnhBI4097rg6luDHEgMDzsCkvOzqj/tEp0f4jk0WU8v3
         +yV/GyHj6smfz9rDL9C0ni0qAjQK/+JArtvwNPvSbL7p95MOF7wXb8+yCAVTwEujSZTt
         TkNg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1683655782; x=1686247782;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=P531oV9/x4YHyyJQpy3FZFac9rbq6io6m/JeWQjftLM=;
        b=alropaHCjL8iRY/qX5iGiWuy0opJsjwaj6E3PHelC6opFElx1sbKbnJY/xVHnk3pel
         ldIrH8Bu7IbnaCdv7a56ByhN+adxXuxshTds8Cdh+to/JXphaU5FCXqY4qpmu+toaR96
         +El8T9z9ABlR7SZlEM7hx3EKPZ0IL7n+eLN5oz3p59oW5l4hzttz29sW/pclghHt69V1
         cqNuRdfFgBasEd8A+lxWnLWDQy++Hn1daZe2nb/C9aGd/1X2AAzsyuu4otecFnLCTbGA
         ivy7W4kpf4ffoJ75PeFaK2aOVolJogX1fIxYL55y35K1GFnM5onqVLb0fV/G/chrcg5o
         lo3w==
X-Gm-Message-State: AC+VfDyeBIvYfaGoZZJw+IJ84DJLQhT2DyIqHdqK7eXcKDbt/LH1KbXl
        jb8vOY0kwotu7+JtAyP39+Q95Q==
X-Google-Smtp-Source: ACHHUZ6Z2hWW4kJo4XA6wPEBn0RJsE0vvL841HD+tBBP3RwHP6qfpE0ZE/ZwoCyHJIplknssHD1coQ==
X-Received: by 2002:a05:6402:5202:b0:506:bd27:a2f0 with SMTP id s2-20020a056402520200b00506bd27a2f0mr13339691edd.15.1683655781945;
        Tue, 09 May 2023 11:09:41 -0700 (PDT)
Received: from krzk-bin.. ([2a02:810d:15c0:828:d0d5:7818:2f46:5e76])
        by smtp.gmail.com with ESMTPSA id dy28-20020a05640231fc00b0050d8b5757d1sm1015286edb.54.2023.05.09.11.09.40
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 09 May 2023 11:09:41 -0700 (PDT)
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
Subject: Re: (subset) [PATCH v3 02/13] dt-bindings: clock: add Exynos4212 clock compatible
Date:   Tue,  9 May 2023 20:09:29 +0200
Message-Id: <168365575564.242810.8233098910658144453.b4-ty@linaro.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20230501195525.6268-3-aweber.kernel@gmail.com>
References: <20230501195525.6268-1-aweber.kernel@gmail.com> <20230501195525.6268-3-aweber.kernel@gmail.com>
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


On Mon, 01 May 2023 21:55:14 +0200, Artur Weber wrote:
> Support for the Exynos4212 SoC was originally dropped as there were
> no boards using it. We will be adding a device that uses it, so add
> back the relevant compatible.
> 
> 

Applied, thanks!

[02/13] dt-bindings: clock: add Exynos4212 clock compatible
        https://git.kernel.org/krzk/linux/c/5b40732af063c3fa2085b247129f065276c4947c

Best regards,
-- 
Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
