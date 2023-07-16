Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 941C3754DAD
	for <lists+linux-pm@lfdr.de>; Sun, 16 Jul 2023 09:39:58 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229569AbjGPHj5 (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Sun, 16 Jul 2023 03:39:57 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44292 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229554AbjGPHj4 (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Sun, 16 Jul 2023 03:39:56 -0400
Received: from mail-yw1-x1133.google.com (mail-yw1-x1133.google.com [IPv6:2607:f8b0:4864:20::1133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 60B2E198A
        for <linux-pm@vger.kernel.org>; Sun, 16 Jul 2023 00:39:55 -0700 (PDT)
Received: by mail-yw1-x1133.google.com with SMTP id 00721157ae682-56fff21c2ebso33686877b3.3
        for <linux-pm@vger.kernel.org>; Sun, 16 Jul 2023 00:39:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1689493194; x=1692085194;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=MqGwUtJpAcMrVUipzRO8IB3DZFIzvFpZipgynnDMvzk=;
        b=d5i/jp4nAKbbSg2bDvAsll6fgPPSpKB66/m8r/O0Zo1LmIzlFY0kSkXMKsqdyVJRHf
         dacI7QkF5O52di13883RiIqKFV77rC+Cf1g4iIU9bLHleB2aaGqpBizUmrV9xFrcRGTe
         zsCSqcq/SpQl2QnHSjEhAyRwVPLZlwVHhro7cDiHtJVpEzOrxiVKlbcX0Kr4W0spwbzD
         6vQ3okb7Q6+LKWvgqTrv59AnQDjsvE+MSsm7cPjskvT3mw0KNV5mFISPx7mXIpfL8IM/
         VHLhPv6jb3zwVffQZQu3a3KPz9A1De/btD1N5dCnKqWTxhNMr5B8MuVDOWFoAQeP3V6B
         RyBw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1689493194; x=1692085194;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=MqGwUtJpAcMrVUipzRO8IB3DZFIzvFpZipgynnDMvzk=;
        b=R2l2CcZM9/a3qd1BGO+zkVV55HtYbhGvoSCUroTtsejJk1c6EK3AiI1i3hN+ib7JJb
         AyxpnOxArnz46QFFqA5BKz0GSfAXUoXKnAAtlaOeBsFcTPyJSGWJ+EZHbh9FyQtKHz8B
         LSaBfbAHRo5jMTrVz8LTe7OVzdnlkuzgme1ncgUmRgBh3BS1YsZpVN9OnEpdwxXmkuFV
         rz7feoZJoXE7jgX1mNyL/krB5zmnqWXMp3YL67CUlcMcrP+0BrH33bTFD454UcIhl/ZI
         +DaNT3bHJWXGhji/kFOB7EhiXOiz4+MF0aTiB5iGxXjQzdOZN+3ZsdxJldTwGvLJWXGx
         0zxQ==
X-Gm-Message-State: ABy/qLYQd4KesHoEo53Af7DxWRtaGihPEGKDSmxRoX/klnrM+0GBiWsR
        x+F/c6nT7GukRtq81Ba1EnQUYGzfdoEYaAd4sXP3NQ==
X-Google-Smtp-Source: APBJJlFzHDafRFrGq2QYjss0hmMh6Hi8+fNcwNklS+FDpazpjC8ANqULn3C4fVrffOp0p4ME7TKRkMLbwrtAcohFQr8=
X-Received: by 2002:a0d:d9cc:0:b0:56f:ecc4:7dbe with SMTP id
 b195-20020a0dd9cc000000b0056fecc47dbemr9489335ywe.34.1689493194654; Sun, 16
 Jul 2023 00:39:54 -0700 (PDT)
MIME-Version: 1.0
References: <20230711141956.751529-1-ulf.hansson@linaro.org>
In-Reply-To: <20230711141956.751529-1-ulf.hansson@linaro.org>
From:   Linus Walleij <linus.walleij@linaro.org>
Date:   Sun, 16 Jul 2023 09:39:43 +0200
Message-ID: <CACRpkdbo60gvXLA4cNegVq_5=LxcBOVbhfVSEQQAGgQBoBkH8g@mail.gmail.com>
Subject: Re: [PATCH v2 01/18] genpd: Create a new subsystem directory to host
 genpd providers
To:     Ulf Hansson <ulf.hansson@linaro.org>
Cc:     Arnd Bergmann <arnd@arndb.de>, Olof Johansson <olof@lixom.net>,
        Michal Simek <michal.simek@amd.com>,
        Nishanth Menon <nm@ti.com>,
        Santosh Shilimkar <ssantosh@kernel.org>,
        Tero Kristo <kristo@kernel.org>,
        Tony Lindgren <tony@atomide.com>,
        Thierry Reding <thierry.reding@gmail.com>,
        Jonathan Hunter <jonathanh@nvidia.com>,
        Mikko Perttunen <mperttunen@nvidia.com>,
        Chen-Yu Tsai <wens@csie.org>,
        Jernej Skrabec <jernej.skrabec@gmail.com>,
        Samuel Holland <samuel@sholland.org>,
        Walker Chen <walker.chen@starfivetech.com>,
        Conor Dooley <conor@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>,
        Alim Akhtar <alim.akhtar@samsung.com>,
        Heiko Stuebner <heiko@sntech.de>,
        Geert Uytterhoeven <geert+renesas@glider.be>,
        Magnus Damm <magnus.damm@gmail.com>,
        Bjorn Andersson <andersson@kernel.org>,
        Konrad Dybcio <konrad.dybcio@linaro.org>,
        Andy Gross <agross@kernel.org>,
        Matthias Brugger <matthias.bgg@gmail.com>,
        AngeloGioacchino Del Regno 
        <angelogioacchino.delregno@collabora.com>,
        Shawn Guo <shawnguo@kernel.org>,
        Sascha Hauer <s.hauer@pengutronix.de>,
        Fabio Estevam <festevam@gmail.com>,
        Florian Fainelli <florian.fainelli@broadcom.com>,
        Ray Jui <rjui@broadcom.com>,
        Scott Branden <sbranden@broadcom.com>,
        Hector Martin <marcan@marcan.st>,
        Sven Peter <sven@svenpeter.dev>,
        Alyssa Rosenzweig <alyssa@rosenzweig.io>,
        Neil Armstrong <neil.armstrong@linaro.org>,
        Kevin Hilman <khilman@baylibre.com>,
        Jerome Brunet <jbrunet@baylibre.com>,
        Martin Blumenstingl <martin.blumenstingl@googlemail.com>,
        Andreas Farber <afaerber@suse.de>,
        Manivannan Sadhasivam <mani@kernel.org>,
        linux-pm@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

On Tue, Jul 11, 2023 at 4:20=E2=80=AFPM Ulf Hansson <ulf.hansson@linaro.org=
> wrote:

> +GENERIC PM DOMAIN PROVIDERS

Maybe not everyone will understand the acronym?
"GENERIC POWER MANAGEMENT DOMAIN PROVIDERS"?

Either way:

Reviewed-by: Linus Walleij <linus.walleij@linaro.org>

Yours,
Linus Walleij
