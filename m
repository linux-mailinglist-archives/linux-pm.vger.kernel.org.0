Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 463EB1F3BAE
	for <lists+linux-pm@lfdr.de>; Tue,  9 Jun 2020 15:15:56 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729655AbgFINPs (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Tue, 9 Jun 2020 09:15:48 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55292 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728767AbgFINPG (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Tue, 9 Jun 2020 09:15:06 -0400
Received: from mail-lj1-x242.google.com (mail-lj1-x242.google.com [IPv6:2a00:1450:4864:20::242])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D642BC08C5C3;
        Tue,  9 Jun 2020 06:15:05 -0700 (PDT)
Received: by mail-lj1-x242.google.com with SMTP id s1so24998545ljo.0;
        Tue, 09 Jun 2020 06:15:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=gODohnu3Esv2qlUienjAVp66GFOWKMfQEeRzgVApqO8=;
        b=q4s89G5iheCGw9OQAjJe2Zc6d+GgU/j8R0VUdl5NnYbuBl/XK2ztpBsz2Ef3lR4KuW
         JWioKUSN8scZ1jlt622kBg9OsW6EIhozc9XVBh9w2w0xrIYsWIAkJvIMD8+rOFMTftLP
         raRlky6+p1TUfxgB093IFSiTZWzQdPoRUK5PiNfWmeWUh5I9SA1WV2nEgPooQrYiNAlT
         CMRiHzk6L+H5f3CXce7iG1XxWJn+n9VSEOGY19V/u+3GJwljxr04lUnfd8G0cGsWv0I0
         B9CiR099u9pr5P+TANsbtEG9lIsHOYGauGX8i+f/2OxRYOaLmstOwQH4NOHQvDghYIj3
         yrtg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=gODohnu3Esv2qlUienjAVp66GFOWKMfQEeRzgVApqO8=;
        b=g6jmoVIT8BvdX0jMMOLGbVDYXdEBmM3/yLAiDe1LJaFV4351cyenz91D+WJ9ii4Sut
         HLtVTjuWElcxiSqL2VxamOc5qUxxePiJXJ/lqXrk2LaACG9I29hgC3itxfB5kp+uRrds
         4x0skbx3TNJCwZ5evVXhnCXRsCa3vCoHOi0/RO21nFbdW9ZHfnP7ODsrO4XylFbT03Fv
         qvz+H4z1m8wJ1JZNCWXI6eKqNv/YrTYZd1WC2RPKGNMb6ZJOwnbSNiPyzpHCXMEaeKcj
         5Ckx51UebImtWYgrccQxoaptb5CoKDqgcVn7AUWaKsWmYJXBuHstW07bN9vla0+XfvHK
         InIA==
X-Gm-Message-State: AOAM530/0n1h/AIMQgAf5RFJfWb+tSJiZ4Eir1i3RGln5wDEs77Anj5b
        FC36xKW9FpUFtK3m7ii4NQg=
X-Google-Smtp-Source: ABdhPJzd7UuFrG5+2ucgDJRuP1i8bPa5bf+kKpq/V4rrtNjWPdK7qWtfkrqYiWuUfcb/29MAQnnLFw==
X-Received: by 2002:a05:651c:2cc:: with SMTP id f12mr684410ljo.329.1591708504216;
        Tue, 09 Jun 2020 06:15:04 -0700 (PDT)
Received: from localhost.localdomain (79-139-237-54.dynamic.spd-mgts.ru. [79.139.237.54])
        by smtp.gmail.com with ESMTPSA id l22sm4323522lji.120.2020.06.09.06.15.03
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 09 Jun 2020 06:15:03 -0700 (PDT)
From:   Dmitry Osipenko <digetx@gmail.com>
To:     Thierry Reding <thierry.reding@gmail.com>,
        Jonathan Hunter <jonathanh@nvidia.com>,
        Georgi Djakov <georgi.djakov@linaro.org>,
        Rob Herring <robh+dt@kernel.org>,
        Michael Turquette <mturquette@baylibre.com>,
        Stephen Boyd <sboyd@kernel.org>,
        Peter De Schrijver <pdeschrijver@nvidia.com>,
        MyungJoo Ham <myungjoo.ham@samsung.com>,
        Kyungmin Park <kyungmin.park@samsung.com>,
        Chanwoo Choi <cw00.choi@samsung.com>,
        Mikko Perttunen <cyndis@kapsi.fi>
Cc:     =?UTF-8?q?Artur=20=C5=9Awigo=C5=84?= <a.swigon@samsung.com>,
        linux-tegra@vger.kernel.org, linux-pm@vger.kernel.org,
        linux-kernel@vger.kernel.org, dri-devel@lists.freedesktop.org,
        devicetree@vger.kernel.org
Subject: [PATCH v4 32/37] memory: tegra20-emc: Create tegra20-devfreq device
Date:   Tue,  9 Jun 2020 16:13:59 +0300
Message-Id: <20200609131404.17523-33-digetx@gmail.com>
X-Mailer: git-send-email 2.26.0
In-Reply-To: <20200609131404.17523-1-digetx@gmail.com>
References: <20200609131404.17523-1-digetx@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

The tegra20-devfreq driver provides memory frequency scaling functionality
and it uses EMC clock for the scaling. Since tegra20-devfreq is a software
driver, the device for the driver needs to be created manually. Let's do
it from EMC driver since it provides the clk rate-change functionality.

Signed-off-by: Dmitry Osipenko <digetx@gmail.com>
---
 drivers/memory/tegra/tegra20-emc.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/drivers/memory/tegra/tegra20-emc.c b/drivers/memory/tegra/tegra20-emc.c
index ef0f5a69f24b..59d85e527516 100644
--- a/drivers/memory/tegra/tegra20-emc.c
+++ b/drivers/memory/tegra/tegra20-emc.c
@@ -877,6 +877,9 @@ static int tegra_emc_probe(struct platform_device *pdev)
 	tegra_emc_debugfs_init(emc);
 	tegra_emc_interconnect_init(emc);
 
+	if (IS_ENABLED(CONFIG_ARM_TEGRA20_DEVFREQ))
+		platform_device_register_simple("tegra20-devfreq", -1, NULL, 0);
+
 	/*
 	 * Don't allow the kernel module to be unloaded. Unloading adds some
 	 * extra complexity which doesn't really worth the effort in a case of
-- 
2.26.0

