Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C7BC3396B36
	for <lists+linux-pm@lfdr.de>; Tue,  1 Jun 2021 04:33:39 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232805AbhFACfP (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Mon, 31 May 2021 22:35:15 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33694 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232731AbhFACfM (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Mon, 31 May 2021 22:35:12 -0400
Received: from mail-lj1-x22f.google.com (mail-lj1-x22f.google.com [IPv6:2a00:1450:4864:20::22f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 360E6C061760;
        Mon, 31 May 2021 19:33:30 -0700 (PDT)
Received: by mail-lj1-x22f.google.com with SMTP id a4so10426114ljq.9;
        Mon, 31 May 2021 19:33:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=HXT+IvjVluiKH3yhs5geuypz9CaKXis2aNZdKmGa0hs=;
        b=kCB1uaH8+3YCfBcJRWhQYbFxvFFc/dX8aG7SETbuWSznv1t6P9RAGXAn539OqULoLD
         0MEvBL3L0t6mzMFFwpPt1ZCv5R2LTZM+e4nm8C1q1BUAm5mecSMIm2/xNEO/pPcTm7ye
         Lx2iwfguoYjhKhMFqAgZaG/gIilWkN0TmDJM9MeqW5dgRiTtjORZRqRVVp5HiXiTPIla
         MUrTPpOVIy1eLZ53I8RtbJK+OrSnGQ7nBX7tqz+u6ttQp7HdZKI6Oh7vWvaa2vdFos4x
         iX3ECwHsxtPCPQQRdAxemhXMdWDysizvZ1OGsbCclDScAnhDRmhpGeCL9OoJOr4HFAD4
         Ry8A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=HXT+IvjVluiKH3yhs5geuypz9CaKXis2aNZdKmGa0hs=;
        b=M98lb5s+wuRMWJirPxz6ZzfCRFt/sHhEJ3BOTe1JGgHKYz3el2szsTNVdqsx6Y+QvX
         MZaSMZCYpxWLxPW2x97Tx0SxGBarsKbaMWc4kzC5PhbPMnkD13a6a3vIRnN/yIIu1kVE
         AsrLGH+/9UUCyyzPL68WuuPHBWyXDEOkRdPRpQ2yHEjzbK8+iUu3BQTWWPb5WwyYYAOZ
         FsSlDsvyULuOch0uLYvwkj8MU7dcgPUxQGeCuvOl0MYWv+hdeFakrIs1Bk1GsgGgAi7K
         agfvaKLdCWsuSBYLzTkGcmF1Yetz3dtprOhUguCGtoSgHlzAjvUrXz6vWX/gHeSxzKOH
         k5Hw==
X-Gm-Message-State: AOAM530z8mAOaG24ThOS1tV/9pMuxBSUkcMfb8FpKX2DsjReCE12f4mp
        eTjKtYV9cZ8ESK69iprNm9M=
X-Google-Smtp-Source: ABdhPJzcTI1kEqoHnCkA+1cxDaaDR80YxZgRpqNecNQgJv+cGhA9pa964T0ywG+Rr7amDwze18W0gA==
X-Received: by 2002:a2e:2e08:: with SMTP id u8mr7456379lju.319.1622514808588;
        Mon, 31 May 2021 19:33:28 -0700 (PDT)
Received: from localhost.localdomain (79-139-170-222.dynamic.spd-mgts.ru. [79.139.170.222])
        by smtp.gmail.com with ESMTPSA id l21sm107848lfc.28.2021.05.31.19.33.27
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 31 May 2021 19:33:28 -0700 (PDT)
From:   Dmitry Osipenko <digetx@gmail.com>
To:     Thierry Reding <thierry.reding@gmail.com>,
        Jonathan Hunter <jonathanh@nvidia.com>,
        =?UTF-8?q?Micha=C5=82=20Miros=C5=82aw?= <mirq-linux@rere.qmqm.pl>,
        =?UTF-8?q?Nikola=20Milosavljevi=C4=87?= <mnidza@outlook.com>,
        Ulf Hansson <ulf.hansson@linaro.org>,
        Peter Geis <pgwipeout@gmail.com>,
        Nicolas Chauvet <kwizart@gmail.com>,
        Viresh Kumar <vireshk@kernel.org>,
        Stephen Boyd <sboyd@kernel.org>,
        Matt Merhar <mattmerhar@protonmail.com>,
        Paul Fertser <fercerpav@gmail.com>,
        Mark Brown <broonie@kernel.org>,
        Liam Girdwood <lgirdwood@gmail.com>,
        Krzysztof Kozlowski <krzysztof.kozlowski@canonical.com>,
        Mikko Perttunen <mperttunen@nvidia.com>
Cc:     linux-kernel@vger.kernel.org, linux-tegra@vger.kernel.org,
        devicetree@vger.kernel.org, linux-pm@vger.kernel.org,
        Nathan Chancellor <nathan@kernel.org>,
        linux-clk@vger.kernel.org
Subject: [PATCH v6 05/14] soc/tegra: fuse: Add stubs needed for compile-testing
Date:   Tue,  1 Jun 2021 05:31:10 +0300
Message-Id: <20210601023119.22044-6-digetx@gmail.com>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20210601023119.22044-1-digetx@gmail.com>
References: <20210601023119.22044-1-digetx@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

Add missing stubs that will allow Tegra memory driver to be compile-tested
by kernel build bots.

Signed-off-by: Dmitry Osipenko <digetx@gmail.com>
---
 include/soc/tegra/fuse.h | 20 +++++++++++++++++---
 1 file changed, 17 insertions(+), 3 deletions(-)

diff --git a/include/soc/tegra/fuse.h b/include/soc/tegra/fuse.h
index 78cbc787a4dc..990701f788bc 100644
--- a/include/soc/tegra/fuse.h
+++ b/include/soc/tegra/fuse.h
@@ -52,14 +52,28 @@ struct tegra_sku_info {
 	enum tegra_revision revision;
 };
 
+#ifdef CONFIG_ARCH_TEGRA
+extern struct tegra_sku_info tegra_sku_info;
 u32 tegra_read_straps(void);
 u32 tegra_read_ram_code(void);
 int tegra_fuse_readl(unsigned long offset, u32 *value);
-
-#ifdef CONFIG_ARCH_TEGRA
-extern struct tegra_sku_info tegra_sku_info;
 #else
 static struct tegra_sku_info tegra_sku_info __maybe_unused;
+
+static inline u32 tegra_read_straps(void)
+{
+	return 0;
+}
+
+static inline u32 tegra_read_ram_code(void)
+{
+	return 0;
+}
+
+static inline int tegra_fuse_readl(unsigned long offset, u32 *value)
+{
+	return -ENODEV;
+}
 #endif
 
 struct device *tegra_soc_device_register(void);
-- 
2.30.2

