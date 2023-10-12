Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1F4087C7577
	for <lists+linux-pm@lfdr.de>; Thu, 12 Oct 2023 19:59:10 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1442146AbjJLR7F (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Thu, 12 Oct 2023 13:59:05 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41282 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1442046AbjJLR64 (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Thu, 12 Oct 2023 13:58:56 -0400
Received: from mail-ej1-x62a.google.com (mail-ej1-x62a.google.com [IPv6:2a00:1450:4864:20::62a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9611AB8;
        Thu, 12 Oct 2023 10:58:54 -0700 (PDT)
Received: by mail-ej1-x62a.google.com with SMTP id a640c23a62f3a-9ae7383b7ecso514250066b.0;
        Thu, 12 Oct 2023 10:58:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1697133533; x=1697738333; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=suA2GBuE0EXCDow+nw+BwHpE/bwHpzrny/kQXeENrx0=;
        b=D3a/tBiLlrA5xxFo3P+D8d3OojjsMS/glAHnXu7A9sczbboQaZHHVscdkntmlPCIWT
         8PiKcS1XVEAr8Ox0sh5TWj3fzabztteEJQdhrbSEqHY0UtvFwfIV6+m+qV3NfxapNnfo
         j1Z11cK6n8i/Wz1g5jC5l541Tw4ToAxFaawPKMlgpNE2gIlGZPr1eWKQFqPQZDeRuBDd
         U0KeXc/lwY+LkP8tR8dr1t8EuYtnRU8HU8deMDwA3wRBcJ+DLJD80O9DxZlwZ20BegMM
         DqvW43vbXcEiN5YTEvsPkjf3z1yD/l6f7+e1BY0/UBNaGNOcc2A4LNrR1juo01itLvMY
         NrhQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1697133533; x=1697738333;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=suA2GBuE0EXCDow+nw+BwHpE/bwHpzrny/kQXeENrx0=;
        b=NMaWDgZnDsjBA2KTtgM8x0S2AzdN3pyFDwOBdDrmCWge9zGz6HbBtQ7yF4H33tgPMs
         sR9Pb0YME5xBm3IoPFA6v+Phm6/N9pE7N5n7JGWxmZfa1EMpirkmWyETgl5HpkNxDkOn
         6WrHW89/WOevHrKXTrs1MRGMd/cU+l1pnrEeC0uT3DJgb/k3bZid4NKK5emP7+B1Qfn+
         gIEfyfJvaMSJkGbDqE9QbLQeChngKcYQxekUyMyWn38awGqvDx3Y81cJ/hyiEtjEioLn
         xLqrk2LlDBB9o4LZoAtEec8RH/8YBlMP9Jj3W/+gHex86Yaz/P9CPVbejUM18BtBFPLi
         oVeQ==
X-Gm-Message-State: AOJu0Yyq/ednwPK5VdsGcHjYAu7WV5X0U0fJXeCCHuVh7QhO8f1yNQOe
        xa9SULTcjuHa06TrCSzAOIc=
X-Google-Smtp-Source: AGHT+IGv+nXgp3Pb3lI5hrfvA7a/uR53U/STjJOQIoIERiRQ4CjFHuLTYXUMOIqGxlTXsyVJrF6zJw==
X-Received: by 2002:a17:906:1005:b0:9ad:f60c:7287 with SMTP id 5-20020a170906100500b009adf60c7287mr20872676ejm.28.1697133532741;
        Thu, 12 Oct 2023 10:58:52 -0700 (PDT)
Received: from localhost (p200300e41f3f4900f22f74fffe1f3a53.dip0.t-ipconnect.de. [2003:e4:1f3f:4900:f22f:74ff:fe1f:3a53])
        by smtp.gmail.com with ESMTPSA id u2-20020a17090617c200b009ad8084e08asm11175901eje.0.2023.10.12.10.58.52
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 12 Oct 2023 10:58:52 -0700 (PDT)
From:   Thierry Reding <thierry.reding@gmail.com>
To:     Daniel Lezcano <daniel.lezcano@linaro.org>,
        "Rafael J . Wysocki" <rafael@kernel.org>,
        Thierry Reding <thierry.reding@gmail.com>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley <conor+dt@kernel.org>
Cc:     Amit Kucheria <amitk@kernel.org>, Zhang Rui <rui.zhang@intel.com>,
        Jon Hunter <jonathanh@nvidia.com>, linux-pm@vger.kernel.org,
        devicetree@vger.kernel.org, linux-tegra@vger.kernel.org
Subject: [PATCH v2 09/13] thermal: tegra: Remove gratuitous error assignment
Date:   Thu, 12 Oct 2023 19:58:30 +0200
Message-ID: <20231012175836.3408077-10-thierry.reding@gmail.com>
X-Mailer: git-send-email 2.42.0
In-Reply-To: <20231012175836.3408077-1-thierry.reding@gmail.com>
References: <20231012175836.3408077-1-thierry.reding@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

From: Thierry Reding <treding@nvidia.com>

Interrupts are optional, so errors during their initialization are
ignored. However, the code confusingly stores the error code and makes
it looks like it is somehow relevant. Remove the gratuitous assignment
to make it clearer that these errors are being purposefully ignored.

Signed-off-by: Thierry Reding <treding@nvidia.com>
---
 drivers/thermal/tegra/soctherm.c | 3 +--
 1 file changed, 1 insertion(+), 2 deletions(-)

diff --git a/drivers/thermal/tegra/soctherm.c b/drivers/thermal/tegra/soctherm.c
index 88ceeb8491cc..77051d08e69f 100644
--- a/drivers/thermal/tegra/soctherm.c
+++ b/drivers/thermal/tegra/soctherm.c
@@ -2135,8 +2135,7 @@ static int tegra_soctherm_probe(struct platform_device *pdev)
 	}
 
 	soctherm_enable_hw_throttling(tegra);
-	err = soctherm_interrupts_init(tegra);
-
+	soctherm_interrupts_init(tegra);
 	soctherm_debug_init(tegra);
 
 	return 0;
-- 
2.42.0

