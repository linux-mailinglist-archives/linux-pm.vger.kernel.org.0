Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 75D4F6FCD78
	for <lists+linux-pm@lfdr.de>; Tue,  9 May 2023 20:10:44 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235252AbjEISKj (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Tue, 9 May 2023 14:10:39 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37888 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230345AbjEISKT (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Tue, 9 May 2023 14:10:19 -0400
Received: from mail-ed1-x529.google.com (mail-ed1-x529.google.com [IPv6:2a00:1450:4864:20::529])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 06587559B
        for <linux-pm@vger.kernel.org>; Tue,  9 May 2023 11:09:56 -0700 (PDT)
Received: by mail-ed1-x529.google.com with SMTP id 4fb4d7f45d1cf-50be17a1eceso12022011a12.2
        for <linux-pm@vger.kernel.org>; Tue, 09 May 2023 11:09:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1683655794; x=1686247794;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=oXjeMbNlFty4Wu6Nx3i/5bDj9AhccjiXqRqHloLRrYU=;
        b=SsmMkRv8ExF0vFpzyDRKwiijGpPNDMPfk41gBcpL3Rf1xjVS3BpyDv61/26D/hNLD4
         4zlBticY2nXaXYb6U710X2Wsl/PO4tMxeJK92PDcUgPoz894sPpE84X9qNstsA4HehUX
         o6Mys+v3xgS752qrf7EtBobou0K94694d7jdg8gKUTEcugptTz51OqGV1My3G/6UnDSw
         Bl1uyb3xpQKT0FD74IwyZcHmsMCo/qiyPJKcostax3ZBzOjxEkbuqaH6wnEd44EjjkFh
         iStUahPL1DL4l8dLo7/SNuhsKeB7Md4CAg2LKB7NRbQUqAcaVqPahLlqdPGE6jT+fc2p
         1u+A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1683655794; x=1686247794;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=oXjeMbNlFty4Wu6Nx3i/5bDj9AhccjiXqRqHloLRrYU=;
        b=ZHIDGnexQ7G1XihmEx3Xw39TlmHeDEPCZE1/SKk/gSVpEdMfQ5WFmJCfzkOlxVczPp
         gK/2If3yiTYRsYuQg4oo1ucvw35f1qzKrdidHUpf+YMrCqg+9/vtc3eZGdPi+Iw+XmRK
         7D8BMwKm/4G9dMkrcLJp8ZFgY2xDCgCSUnkUTjtI/YlwhIpfbh7g20PrP3/QxgePY8+r
         RM7kTgdSwetqgn3oN05ciL/hq0h1cAJDc7MNc1/9mGiSQOvOcS3BUT/NmIo6WeVDAXFa
         GmyXEbuTPKjDf/O6/pOYSlJAK/QERL0ysYtsMgA9SwikBh3p8kmbKHgcSFB233a09qx9
         yaxA==
X-Gm-Message-State: AC+VfDyuawf7Ozo1o51LKrs2Qtccot0WfKP++GmOd5WmHDmb7jgEvWRm
        288P425rXTgQS4c7nS6EbZ6ziQ==
X-Google-Smtp-Source: ACHHUZ5XtO9xWsXdQK462FkDITWtLOlPWTWZE59msHLywpQRrhFOUzpovI44XB2HfWnDrQ4ydwWIbg==
X-Received: by 2002:a17:907:944d:b0:94e:fa56:a74f with SMTP id dl13-20020a170907944d00b0094efa56a74fmr12775313ejc.14.1683655794357;
        Tue, 09 May 2023 11:09:54 -0700 (PDT)
Received: from krzk-bin.. ([2a02:810d:15c0:828:d0d5:7818:2f46:5e76])
        by smtp.gmail.com with ESMTPSA id dy28-20020a05640231fc00b0050d8b5757d1sm1015286edb.54.2023.05.09.11.09.52
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 09 May 2023 11:09:53 -0700 (PDT)
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
Subject: Re: (subset) [PATCH v3 12/13] dt-bindings: arm: samsung: Add Samsung Galaxy Tab3 family boards
Date:   Tue,  9 May 2023 20:09:36 +0200
Message-Id: <168365575566.242810.11963330724766854967.b4-ty@linaro.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20230501195525.6268-13-aweber.kernel@gmail.com>
References: <20230501195525.6268-1-aweber.kernel@gmail.com> <20230501195525.6268-13-aweber.kernel@gmail.com>
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


On Mon, 01 May 2023 21:55:24 +0200, Artur Weber wrote:
> Add the compatible strings for the Samsung Galaxy Tab 3 8.0 series
> of tablets.
> 
> 

Applied, thanks!

[12/13] dt-bindings: arm: samsung: Add Samsung Galaxy Tab3 family boards
        https://git.kernel.org/krzk/linux/c/fd811cce9b92635799ba5c6de657e4a53c68adf6

Best regards,
-- 
Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
