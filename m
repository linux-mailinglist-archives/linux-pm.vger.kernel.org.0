Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 617FE7C756F
	for <lists+linux-pm@lfdr.de>; Thu, 12 Oct 2023 19:59:07 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1442135AbjJLR7E (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Thu, 12 Oct 2023 13:59:04 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59138 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1441988AbjJLR6y (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Thu, 12 Oct 2023 13:58:54 -0400
Received: from mail-ej1-x632.google.com (mail-ej1-x632.google.com [IPv6:2a00:1450:4864:20::632])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 431AEBB;
        Thu, 12 Oct 2023 10:58:53 -0700 (PDT)
Received: by mail-ej1-x632.google.com with SMTP id a640c23a62f3a-9b9ad5760b9so191034466b.3;
        Thu, 12 Oct 2023 10:58:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1697133532; x=1697738332; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=7ELKFj0+qwx602dBNPDkLuBnOHW0DDGSOaKlxLMtsdk=;
        b=PeUHk4S5ewizYX3+aZ7Ogd8PW371rSnSmGXBpy5KLLbM+wsTXQrEpP7Jxt1b6Poou8
         K6wZP5YIgs85pDGR+4NPHX4NtoIzSNadlcyeQCf+4TrjGQDvxMWyFmWyp2j7zKKiBc3l
         YJuRj7GXlAEhFcDhSN1mWG+C5noh0oV0BB5NAmLtA/pXmy4l21Er78Bqrx1DAQK9rSLS
         xcezrSY4mwgjT8VB94VXQPOjubfAyU9MH415N18SXFQqeLerXwgHoxEiSjh0xhEcn5Iq
         RwOC23YAmQOZRZsTD4NeOYyH+8qNbclr1vU6EFkrNWRfCarFtvZmcDjjyokA+QsZ8M9G
         tf3g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1697133532; x=1697738332;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=7ELKFj0+qwx602dBNPDkLuBnOHW0DDGSOaKlxLMtsdk=;
        b=hPuFjytMAbpTFEr3a8MRoE1g0Jfic7JyJc5rfZBV14lDWgbAG9OgNCsrCreuk9PeAJ
         wAFkZrX8X4PGjyczBNpHEoizt0gzqqoYz+Ev7Ac0kuiJ/g81RB9z6UBE0UDESOMK/RKK
         7+14pdw/iTa9gcUGro3yFX1xfJG8Yw38vZH1cd/rpV/7uQhqel50SrlJJFhd2cRnyZKY
         jq2ZXEFuFP82mdnfHpzBMfCJ8EHkPWELUvOBNUwPRnQSg9tVptaIx5h4uayimmC69Ime
         LVvcyfF+44HfOpAHgFtE0Tr24z4C0tvWnPGIS0KtZmL4YMJxJHbxJlEjjMtgrqc7in0P
         Mbdw==
X-Gm-Message-State: AOJu0YwoOgiW/XzwSh+w4JcHm+OGxKWt8X4f66N1AJ+ZLoJdx7urDaY2
        QkHGTF4NVO6ddjRz1xItyAQ=
X-Google-Smtp-Source: AGHT+IHIjSsROs6bU4Js5hvjjtxI5Xvs1CwAEk0MHHEswQSZqLZS/riCBYVDjLWBqtEZFJtN8F7gDQ==
X-Received: by 2002:a17:907:784d:b0:9b8:e253:9a1e with SMTP id lb13-20020a170907784d00b009b8e2539a1emr19870063ejc.38.1697133531684;
        Thu, 12 Oct 2023 10:58:51 -0700 (PDT)
Received: from localhost (p200300e41f3f4900f22f74fffe1f3a53.dip0.t-ipconnect.de. [2003:e4:1f3f:4900:f22f:74ff:fe1f:3a53])
        by smtp.gmail.com with ESMTPSA id m14-20020a1709066d0e00b00991d54db2acsm11296068ejr.44.2023.10.12.10.58.50
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 12 Oct 2023 10:58:50 -0700 (PDT)
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
Subject: [PATCH v2 08/13] thermal: tegra: Avoid over-allocation of temporary array
Date:   Thu, 12 Oct 2023 19:58:29 +0200
Message-ID: <20231012175836.3408077-9-thierry.reding@gmail.com>
X-Mailer: git-send-email 2.42.0
In-Reply-To: <20231012175836.3408077-1-thierry.reding@gmail.com>
References: <20231012175836.3408077-1-thierry.reding@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
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
index c7f8e36cbeab..88ceeb8491cc 100644
--- a/drivers/thermal/tegra/soctherm.c
+++ b/drivers/thermal/tegra/soctherm.c
@@ -1469,7 +1469,6 @@ static int soctherm_clk_enable(struct tegra_soctherm *tegra, bool enable)
 static int soctherm_thermtrips_parse(struct tegra_soctherm *ts)
 {
 	struct tsensor_group_thermtrips *tt = ts->soc->thermtrips;
-	const int max_num_prop = ts->soc->num_ttgs * 2;
 	unsigned int i, j, count;
 	u32 *tlb;
 	int ret;
@@ -1486,7 +1485,7 @@ static int soctherm_thermtrips_parse(struct tegra_soctherm *ts)
 
 	count = min_t(unsigned int, ret, ts->soc->num_ttgs * 2);
 
-	tlb = devm_kcalloc(ts->dev, max_num_prop, sizeof(u32), GFP_KERNEL);
+	tlb = devm_kcalloc(ts->dev, count, sizeof(u32), GFP_KERNEL);
 	if (!tlb)
 		return -ENOMEM;
 
@@ -1506,6 +1505,8 @@ static int soctherm_thermtrips_parse(struct tegra_soctherm *ts)
 		i++;
 	}
 
+	devm_kfree(ts->dev, tlb);
+
 	return 0;
 }
 
-- 
2.42.0

