Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4425028CAF7
	for <lists+linux-pm@lfdr.de>; Tue, 13 Oct 2020 11:27:17 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2391442AbgJMJ1Q (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Tue, 13 Oct 2020 05:27:16 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45776 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2391427AbgJMJ1P (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Tue, 13 Oct 2020 05:27:15 -0400
Received: from mail-wr1-x42f.google.com (mail-wr1-x42f.google.com [IPv6:2a00:1450:4864:20::42f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 90CAAC0613D2
        for <linux-pm@vger.kernel.org>; Tue, 13 Oct 2020 02:27:15 -0700 (PDT)
Received: by mail-wr1-x42f.google.com with SMTP id b8so9915864wrn.0
        for <linux-pm@vger.kernel.org>; Tue, 13 Oct 2020 02:27:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=wJ7jRoPXGiiAoDBzp6DBsjtx/DuGJsa9AjjDde8Qs2M=;
        b=cQ54tMtqQbU/rbyhWDIkZM7lwDcs2jxlxfyBx5bPEBf8BeqFrSi7X7vCtcH8pK2YTW
         6s0Jpf2qf2E7imqT79CYWPXFfJslyeu2TrCIPVsUJJyXjZEPKD1ebcQXy8qnLnDVrts7
         tpCwGNEWtxv9mzWU/01SCi5SkXb7vGEaFwCOaKL+DLkRBA2TRysw2cUPwZX3qZxlE6Eq
         nuidr+y0mMmbs4oP+grNn/EdCN1DrdH6wbh2/WwV/j+TP5rhPpljGxjNF5WJZpw888HY
         O+OIhOw5zWDAJ5HR6V8mUfFP0kAsenEWFWUXbCr3KdQA59SD7WmB2bOIN6XixCHD/I7e
         XKKw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=wJ7jRoPXGiiAoDBzp6DBsjtx/DuGJsa9AjjDde8Qs2M=;
        b=PAx7q38UOEI0TApvp77AsT5nqUJSiYvvl9ir9Gg+rnch0k9mWDoPGVUzbrpAmapTT0
         UjhTT1FZQ8y3FndHEIVgTe1lIucb+LWVRHSzvc9ZTmpDFW7yJ7MNyU4X2veVwkbTka77
         wvwujpLC9Dm3tDA2HP/MHZi+1QfgG2Xzpjjt0Md7fB4uNdf4yXgXr7HVK3x3fV13vq+3
         yUvSbvZCCOqpenUCnvkv7aq4Sy/ktUs6EZ20vt2RMh226zddimFHOsmkH7pJR65Dil7Q
         uk/QeZcdni3bV5Yi794eK4KFil6w7KoqVtYyubQ0WffYpNcUGOxyEO9dxQgWIuPJp0kl
         6wVA==
X-Gm-Message-State: AOAM530WJ4msannOJ38OYQQgEcBbYQsit9PegpNuZ8zD0NUuMDX07gXn
        SNHixISJ+qTaKPqg52xEHqDtNA==
X-Google-Smtp-Source: ABdhPJy14F6d0h2r7/4p6oqrAM5LS8peDKXMcattGlrM2R297ZmvNMjauNFeh/ITF40zFAd3D86YDQ==
X-Received: by 2002:adf:8b48:: with SMTP id v8mr34705235wra.21.1602581234070;
        Tue, 13 Oct 2020 02:27:14 -0700 (PDT)
Received: from localhost.localdomain (147.169.185.81.rev.sfr.net. [81.185.169.147])
        by smtp.gmail.com with ESMTPSA id f6sm14484830wru.50.2020.10.13.02.27.12
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 13 Oct 2020 02:27:13 -0700 (PDT)
From:   Fabien Parent <fparent@baylibre.com>
To:     linux-mediatek@lists.infradead.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        linux-pm@vger.kernel.org
Cc:     matthias.bgg@gmail.com, viresh.kumar@linaro.org, rjw@rjwysocki.net,
        Fabien Parent <fparent@baylibre.com>
Subject: [PATCH 1/2] cpufreq: mediatek: Add support for mt8167
Date:   Tue, 13 Oct 2020 11:27:08 +0200
Message-Id: <20201013092709.3336709-1-fparent@baylibre.com>
X-Mailer: git-send-email 2.28.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

Add compatible string for mediatek mt8167

Signed-off-by: Fabien Parent <fparent@baylibre.com>
---
 drivers/cpufreq/cpufreq-dt-platdev.c | 1 +
 drivers/cpufreq/mediatek-cpufreq.c   | 1 +
 2 files changed, 2 insertions(+)

diff --git a/drivers/cpufreq/cpufreq-dt-platdev.c b/drivers/cpufreq/cpufreq-dt-platdev.c
index 7d01df7bfa6c..b8d48ed37156 100644
--- a/drivers/cpufreq/cpufreq-dt-platdev.c
+++ b/drivers/cpufreq/cpufreq-dt-platdev.c
@@ -119,6 +119,7 @@ static const struct of_device_id blacklist[] __initconst = {
 	{ .compatible = "mediatek,mt2712", },
 	{ .compatible = "mediatek,mt7622", },
 	{ .compatible = "mediatek,mt7623", },
+	{ .compatible = "mediatek,mt8167", },
 	{ .compatible = "mediatek,mt817x", },
 	{ .compatible = "mediatek,mt8173", },
 	{ .compatible = "mediatek,mt8176", },
diff --git a/drivers/cpufreq/mediatek-cpufreq.c b/drivers/cpufreq/mediatek-cpufreq.c
index 7d1212c9b7c8..c09bff86bb9b 100644
--- a/drivers/cpufreq/mediatek-cpufreq.c
+++ b/drivers/cpufreq/mediatek-cpufreq.c
@@ -532,6 +532,7 @@ static const struct of_device_id mtk_cpufreq_machines[] __initconst = {
 	{ .compatible = "mediatek,mt2712", },
 	{ .compatible = "mediatek,mt7622", },
 	{ .compatible = "mediatek,mt7623", },
+	{ .compatible = "mediatek,mt8167", },
 	{ .compatible = "mediatek,mt817x", },
 	{ .compatible = "mediatek,mt8173", },
 	{ .compatible = "mediatek,mt8176", },
-- 
2.28.0

