Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0B42B6E23DB
	for <lists+linux-pm@lfdr.de>; Fri, 14 Apr 2023 14:58:05 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230348AbjDNM6C (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Fri, 14 Apr 2023 08:58:02 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42410 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230316AbjDNM6B (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Fri, 14 Apr 2023 08:58:01 -0400
Received: from mail-wr1-x429.google.com (mail-wr1-x429.google.com [IPv6:2a00:1450:4864:20::429])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7DE22AF3E;
        Fri, 14 Apr 2023 05:57:35 -0700 (PDT)
Received: by mail-wr1-x429.google.com with SMTP id q6so5940736wrc.3;
        Fri, 14 Apr 2023 05:57:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1681477054; x=1684069054;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=9tgm3k/JiwpNenl3OoVPG2vmqD9LEJ/mJhxEqONmm5Y=;
        b=F4b1zNjwqh/Arkm8TkJlrCyxNkBjTVRAO7IF9pLG3xI5fpFifQyZYCGuV+XVjACN1M
         0ijwtm8q8WfmiA3OqODMOcSlJaQnIKQlO/3fDYXUaSHaV95Fh118qTW9S9kpxCpfnpbT
         zpZ4UiNqHBdg/mnt/tUrqyErmuAAz7b7RDrJ/eaYLwVpJxexh1+iL7o1k4oOUC66g3UP
         XUr3qyi0qk38atgWJc6VCcDeG8XHKWzmZiTin+zzNmm9H3PQOh2XX7PXq1irexL0snci
         X305g2RDgAyJM2OBpSLb/gJ55/ohUdAbdoXILhVvdz/OQK8TaMcWmgvxum0v4Kx1B7/7
         SQqg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1681477054; x=1684069054;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=9tgm3k/JiwpNenl3OoVPG2vmqD9LEJ/mJhxEqONmm5Y=;
        b=LEbjISG20j9YgUQqJf+I6y2kE7/iwJibpcYaCQWlOILNrgg7YCuy6/LolpqQlTwBx+
         Mn4qtF0naBpggzVVFCXAEZE6YPn2ndDbtxcO/BQ0V2iWyfBG6kIV+p85s7AqdmZFFPZq
         c6bTqoDBNgjIMEqhMq3BK6NtOQoAHYnxehuOAavDKBgVR+AdiGK1mVoALRBLfIEKGbsO
         AULXmYMnNobsCOdWhfZOucBHBFZ8Cmc+/Vm4elSJaJAQAKVMJ0homySRe2znkb8Iy3sW
         L3rkCxtCuogzY2KqVv8czd5Wt10zI63VDxlUUGhoJA4cvsYOIE0xyQR3P5LbMkD02YVN
         Rk0Q==
X-Gm-Message-State: AAQBX9fJWaEA17LJQZ1pYLzCRLIP91gTWcPTcD1RtdGC9UDcL6dSGgQq
        WSPkg8bNaWz4FhdUF9xQvt8=
X-Google-Smtp-Source: AKy350ZRIXZaqYaswFy2+vnD2nmYKjbjlF45hQSBOeh9aqpEdozYlbR4qfh5xTtml2DFRUTbeIJHcg==
X-Received: by 2002:a5d:640b:0:b0:2f6:4c9c:6b2a with SMTP id z11-20020a5d640b000000b002f64c9c6b2amr3466419wru.0.1681477053697;
        Fri, 14 Apr 2023 05:57:33 -0700 (PDT)
Received: from localhost (p200300e41f1c0800f22f74fffe1f3a53.dip0.t-ipconnect.de. [2003:e4:1f1c:800:f22f:74ff:fe1f:3a53])
        by smtp.gmail.com with ESMTPSA id p13-20020a5d4e0d000000b002f4cf72fce6sm3529473wrt.46.2023.04.14.05.57.33
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 14 Apr 2023 05:57:33 -0700 (PDT)
From:   Thierry Reding <thierry.reding@gmail.com>
To:     Daniel Lezcano <daniel.lezcano@linaro.org>,
        "Rafael J . Wysocki" <rafael@kernel.org>,
        Thierry Reding <thierry.reding@gmail.com>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>
Cc:     Amit Kucheria <amitk@kernel.org>, Zhang Rui <rui.zhang@intel.com>,
        Jon Hunter <jonathanh@nvidia.com>, linux-pm@vger.kernel.org,
        devicetree@vger.kernel.org, linux-tegra@vger.kernel.org
Subject: [PATCH 07/10] thermal: tegra: Remove gratuitous error assignment
Date:   Fri, 14 Apr 2023 14:57:18 +0200
Message-Id: <20230414125721.1043589-8-thierry.reding@gmail.com>
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

Interrupts are optional, so errors during their initialization are
ignored. However, the code confusingly stores the error code and makes
it looks like it is somehow relevant. Remove the gratuitous assignment
to make it clearer that these errors are being purposefully ignored.

Signed-off-by: Thierry Reding <treding@nvidia.com>
---
 drivers/thermal/tegra/soctherm.c | 3 +--
 1 file changed, 1 insertion(+), 2 deletions(-)

diff --git a/drivers/thermal/tegra/soctherm.c b/drivers/thermal/tegra/soctherm.c
index 16fa00fa0839..b6e61393fb8f 100644
--- a/drivers/thermal/tegra/soctherm.c
+++ b/drivers/thermal/tegra/soctherm.c
@@ -2078,8 +2078,7 @@ static int tegra_soctherm_probe(struct platform_device *pdev)
 			goto disable_clocks;
 	}
 
-	err = soctherm_interrupts_init(tegra);
-
+	soctherm_interrupts_init(tegra);
 	soctherm_debug_init(tegra);
 
 	return 0;
-- 
2.40.0

