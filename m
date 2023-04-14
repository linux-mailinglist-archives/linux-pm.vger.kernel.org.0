Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7C1AE6E23D6
	for <lists+linux-pm@lfdr.de>; Fri, 14 Apr 2023 14:58:03 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230286AbjDNM6B (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Fri, 14 Apr 2023 08:58:01 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42390 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229847AbjDNM57 (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Fri, 14 Apr 2023 08:57:59 -0400
Received: from mail-wm1-x32e.google.com (mail-wm1-x32e.google.com [IPv6:2a00:1450:4864:20::32e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0CBFAB741;
        Fri, 14 Apr 2023 05:57:35 -0700 (PDT)
Received: by mail-wm1-x32e.google.com with SMTP id bd13-20020a05600c1f0d00b003f14c42cc99so536961wmb.2;
        Fri, 14 Apr 2023 05:57:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1681477053; x=1684069053;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=R1g6kj74AkM9jNZdPSLLTF4OlvwI6sCwkaDV/qucOx0=;
        b=TLLnDGHtgAPw/ZieA+Dxx6OioK5HZByNOO7b8+Rhxc4N2VW5fxeTLsRIo3iE7Oq3Z9
         e/eHXgoydknFyFHu5ncrc6yeTdRwYL6O7ZMiPCRIcHKg+RXOIwMc2YkhVIxleVWwtbda
         ln1S5+Cxh1fKe42e3DK+GEXp4j2gH/PnxU2yOFwCqTyjtlFG3ePYncp0alKdKaSvQ1sI
         sgwQruKi6+8Ge6RL3wteUfcSGA4GkURqPUkwusI/rfsL4l1VVRe/qqxuMIqbvFaWGtYy
         aNUgrrqBYAdVId8qSr7rMPmPlg9ALnH0bYB3t5vE+OcwJA3gtCIVG4f4/bWURNoVHCxT
         ktQQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1681477053; x=1684069053;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=R1g6kj74AkM9jNZdPSLLTF4OlvwI6sCwkaDV/qucOx0=;
        b=c3sqdqCSl9r093CxLcYHpJhLqn4OTO0XNFYhmhUp7C6GL9KJQR5Bacrm6cpuCrzhKb
         PPrTRO2ucjDMhQFEbrLAZgZRKOEsUbRDO/YKJLeYiGc0tcLu2WdFw/qjpffc2u60xy5s
         LqjhN2YelmdV45ZLb1ZuJ1D6H6zj3e2hNC9ZYO9qGg+9laLniK07ulSeoxCmxy0n0mg2
         idx+qYylhGyEXLV2B2f+JrkF2Hj9jEZJjDw17mtn71qpC4M1ftN+qvu0Xo/v+Oq86Eqv
         bsbWoLtp+D0uxrjgeIq3ZGGUM6xJJIujw69CsShI+lGyKA9+jOPCNzeZ5eG+kNSRelWZ
         +GLw==
X-Gm-Message-State: AAQBX9c/JKJOFGfShtzhx41VlVJJXQkuThTUPhhChq11gQQ3x5noXwck
        MIQFm5hPw1Ev9ri50S4OdHw=
X-Google-Smtp-Source: AKy350a1j6nYJKAO6kuCTeMuQbSJOYukzAlO5dyg/KS+FnEP7KGHzLv4EdmH3zh989LpEDkDbCRgcA==
X-Received: by 2002:a7b:c008:0:b0:3dc:5b88:e6dd with SMTP id c8-20020a7bc008000000b003dc5b88e6ddmr4475239wmb.10.1681477052743;
        Fri, 14 Apr 2023 05:57:32 -0700 (PDT)
Received: from localhost (p200300e41f1c0800f22f74fffe1f3a53.dip0.t-ipconnect.de. [2003:e4:1f1c:800:f22f:74ff:fe1f:3a53])
        by smtp.gmail.com with ESMTPSA id c8-20020a05600c0a4800b003ee5fa61f45sm8044218wmq.3.2023.04.14.05.57.32
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 14 Apr 2023 05:57:32 -0700 (PDT)
From:   Thierry Reding <thierry.reding@gmail.com>
To:     Daniel Lezcano <daniel.lezcano@linaro.org>,
        "Rafael J . Wysocki" <rafael@kernel.org>,
        Thierry Reding <thierry.reding@gmail.com>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>
Cc:     Amit Kucheria <amitk@kernel.org>, Zhang Rui <rui.zhang@intel.com>,
        Jon Hunter <jonathanh@nvidia.com>, linux-pm@vger.kernel.org,
        devicetree@vger.kernel.org, linux-tegra@vger.kernel.org
Subject: [PATCH 06/10] thermal: tegra: Avoid over-allocation of temporary array
Date:   Fri, 14 Apr 2023 14:57:17 +0200
Message-Id: <20230414125721.1043589-7-thierry.reding@gmail.com>
X-Mailer: git-send-email 2.40.0
In-Reply-To: <20230414125721.1043589-1-thierry.reding@gmail.com>
References: <20230414125721.1043589-1-thierry.reding@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

From: Thierry Reding <treding@nvidia.com>

The code will attempt to read "count" entries from DT, but the code
allocates the maximum number that is possible, potentially over-
allocating the array. Use the actual number of entries when allocating.

Signed-off-by: Thierry Reding <treding@nvidia.com>
---
 drivers/thermal/tegra/soctherm.c | 5 +++--
 1 file changed, 3 insertions(+), 2 deletions(-)

diff --git a/drivers/thermal/tegra/soctherm.c b/drivers/thermal/tegra/soctherm.c
index 730b034004cb..16fa00fa0839 100644
--- a/drivers/thermal/tegra/soctherm.c
+++ b/drivers/thermal/tegra/soctherm.c
@@ -1436,7 +1436,6 @@ static int soctherm_clk_enable(struct tegra_soctherm *tegra, bool enable)
 static int soctherm_thermtrips_parse(struct tegra_soctherm *ts)
 {
 	struct tsensor_group_thermtrips *tt = ts->soc->thermtrips;
-	const int max_num_prop = ts->soc->num_ttgs * 2;
 	unsigned int i, j, count;
 	u32 *tlb;
 	int ret;
@@ -1453,7 +1452,7 @@ static int soctherm_thermtrips_parse(struct tegra_soctherm *ts)
 
 	count = min_t(unsigned int, ret, ts->soc->num_ttgs * 2);
 
-	tlb = devm_kcalloc(ts->dev, max_num_prop, sizeof(u32), GFP_KERNEL);
+	tlb = devm_kcalloc(ts->dev, count, sizeof(u32), GFP_KERNEL);
 	if (!tlb)
 		return -ENOMEM;
 
@@ -1473,6 +1472,8 @@ static int soctherm_thermtrips_parse(struct tegra_soctherm *ts)
 		i++;
 	}
 
+	devm_kfree(ts->dev, tlb);
+
 	return 0;
 }
 
-- 
2.40.0

