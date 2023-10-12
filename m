Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C7DA67C7579
	for <lists+linux-pm@lfdr.de>; Thu, 12 Oct 2023 19:59:10 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1442046AbjJLR7G (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Thu, 12 Oct 2023 13:59:06 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41332 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1442095AbjJLR66 (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Thu, 12 Oct 2023 13:58:58 -0400
Received: from mail-ej1-x630.google.com (mail-ej1-x630.google.com [IPv6:2a00:1450:4864:20::630])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3E385DC;
        Thu, 12 Oct 2023 10:58:55 -0700 (PDT)
Received: by mail-ej1-x630.google.com with SMTP id a640c23a62f3a-9b275afb6abso510955266b.1;
        Thu, 12 Oct 2023 10:58:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1697133534; x=1697738334; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=PFkzZubIKvHWWywCOt/a5WVYYq1z0VOWDgSVq/0tCKQ=;
        b=HOcHNhzpb2NmGar5HN4GdRTKm17L/wKTwf+A1HqCCtDbP+BZ2rfVT9AeP+Xexudvvc
         toZQJmU7z3aDEE4ySW2uNDrzVXI/9s8KYQc3aehlK0+liPul0XBuWKIb3bksfi89hIvW
         /KqLXccxY3P0QoQCytdbFfmLIKrsbnhFrA0+nQ5SyRj0xRsEmL4VLVXLtpWkNP9zrA8e
         /popt95cjztHQTRc6yBbf0s80qTy2IVVcRhEzu44NMJIPz9b0BSE8dtN4Y6L8RdgHNE5
         ACjuFT4wMAKXwwNpluuRVJo3wFV/n3+Rt7nJpht9ByET95HChLhzIEo8CvDrd5QabSoc
         4aoQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1697133534; x=1697738334;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=PFkzZubIKvHWWywCOt/a5WVYYq1z0VOWDgSVq/0tCKQ=;
        b=SBD0NInu9aTcp0cj5czeKyAEaIuMGlD7PMqCnuUfaJxRo0VsTLz8BMPe3c6bn/iiKk
         t9jUcAD3RFNeAgX0aL8xB2r75ivO8pSB6wZd1idK50vje/VEgyJ1DecJ0m/2nN67f+2K
         ZA/gCBN62yI4evj2OKpuzr/8sXqlcY47nYp4iayPPNrZE2QaXOQXJRK3S9SsNX+J93jM
         cpITLtu8ZoyjMsG0frIQDiyA2V1b0Fnl9jM/eiDL21hizLLLzQSRDSdHREIXL2LkT90v
         jzH0kAUWlNpEu+jJy7hSoRFODbnNsxxhw8lWqrD7ufFNes4lXT3QpzKj4yKB10xS7R1d
         gBcw==
X-Gm-Message-State: AOJu0YzQoMB3W4IKX5q0VNWDpEU/NGNorZ8MyQ05X+x21T/Z2/ZTv5V9
        6/EmQoDXVTwM/jWNqvRjQv/5cOUg3I8=
X-Google-Smtp-Source: AGHT+IEhP9J0SWf1YHmceNjScXupZVhu4lkNIj+37J22fpuqGX9MwnE3bgI+e3ppoizrDWiSWqDO4Q==
X-Received: by 2002:a17:907:36c9:b0:9a9:fa4a:5a4e with SMTP id bj9-20020a17090736c900b009a9fa4a5a4emr17202083ejc.13.1697133533694;
        Thu, 12 Oct 2023 10:58:53 -0700 (PDT)
Received: from localhost (p200300e41f3f4900f22f74fffe1f3a53.dip0.t-ipconnect.de. [2003:e4:1f3f:4900:f22f:74ff:fe1f:3a53])
        by smtp.gmail.com with ESMTPSA id n14-20020aa7c44e000000b005361fadef32sm10260121edr.23.2023.10.12.10.58.53
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 12 Oct 2023 10:58:53 -0700 (PDT)
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
Subject: [PATCH v2 10/13] thermal: tegra: Minor stylistic cleanups
Date:   Thu, 12 Oct 2023 19:58:31 +0200
Message-ID: <20231012175836.3408077-11-thierry.reding@gmail.com>
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

Fix up some whitespace (padding, identation) issues and reword an
unreadable comment.

Signed-off-by: Thierry Reding <treding@nvidia.com>
---
 drivers/thermal/tegra/soctherm.c | 11 +++++++----
 1 file changed, 7 insertions(+), 4 deletions(-)

diff --git a/drivers/thermal/tegra/soctherm.c b/drivers/thermal/tegra/soctherm.c
index 77051d08e69f..f749fb960ebe 100644
--- a/drivers/thermal/tegra/soctherm.c
+++ b/drivers/thermal/tegra/soctherm.c
@@ -1492,7 +1492,9 @@ static int soctherm_thermtrips_parse(struct tegra_soctherm *ts)
 	ret = of_property_read_u32_array(ts->dev->of_node, "nvidia,thermtrips",
 					 tlb, count);
 	if (ret) {
-		dev_err(ts->dev, "invalid num ele: thermtrips:%d\n", ret);
+		dev_err(ts->dev,
+			"failed to read \"nvidia,thermtrips\" property: %d\n",
+			ret);
 		return ret;
 	}
 
@@ -1812,7 +1814,7 @@ static void throttlectl_gpu_level_select(struct tegra_soctherm *ts,
 }
 
 static int soctherm_oc_cfg_program(struct tegra_soctherm *ts,
-				      enum soctherm_throttle_id throt)
+				   enum soctherm_throttle_id throt)
 {
 	u32 r;
 	struct soctherm_oc_cfg *oc = &ts->throt_cfgs[throt].oc_cfg;
@@ -2104,8 +2106,9 @@ static int tegra_soctherm_probe(struct platform_device *pdev)
 	soctherm_init(tegra);
 
 	for (i = 0; i < soc->num_ttgs; ++i) {
-		struct tegra_thermctl_zone *zone =
-			devm_kzalloc(&pdev->dev, sizeof(*zone), GFP_KERNEL);
+		struct tegra_thermctl_zone *zone;
+
+		zone = devm_kzalloc(&pdev->dev, sizeof(*zone), GFP_KERNEL);
 		if (!zone) {
 			err = -ENOMEM;
 			goto disable_clocks;
-- 
2.42.0

