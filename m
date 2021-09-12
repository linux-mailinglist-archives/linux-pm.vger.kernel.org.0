Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2C0B040817C
	for <lists+linux-pm@lfdr.de>; Sun, 12 Sep 2021 22:29:36 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236499AbhILUao (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Sun, 12 Sep 2021 16:30:44 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58244 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236383AbhILUah (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Sun, 12 Sep 2021 16:30:37 -0400
Received: from mail-wr1-x42c.google.com (mail-wr1-x42c.google.com [IPv6:2a00:1450:4864:20::42c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 73112C061574;
        Sun, 12 Sep 2021 13:29:22 -0700 (PDT)
Received: by mail-wr1-x42c.google.com with SMTP id i23so11367674wrb.2;
        Sun, 12 Sep 2021 13:29:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=cZO3c0fpnwQfqDRvDUKCPGXMXP2rFLnO7bySGQVOuzg=;
        b=Ydfa+q6BwqoWYTb3uTbbugDmElpcXeMJKd7IUmktBODwQDdzCtRfN9jEIWR0MegiIY
         lvx19ENUVFkK8sVlc2wyoaFAQ/ry6evxQ+2/2NSRorWgf17bpechZHo5kEw1ZarcWzJ1
         nrDfXD0sDq+LVMaaIvptcpaKIC3WIKnkcevHEILQDwIxpmNIRQhgfHJFcSTDtdxa1MPX
         qxycbTbL1Bz1kOgmiRWh8ZBk+vO9Wfrg3gdR5Uuk6OFfXhF20JNBZvO4Ev9eN/AMrOzQ
         meGST2SkhQs1zHX9VX0uHYu37bkL5aUIVKV8xhV/noh6IxepvK5zK+Lbm0pWNTiU01Cb
         RTdQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=cZO3c0fpnwQfqDRvDUKCPGXMXP2rFLnO7bySGQVOuzg=;
        b=EATYU66HIFYUIHP03cMecAwyGcZVLwLclyghDB9szF4kKzRqBrWH9se8VoyZzrmbaA
         QB629CgUHHsz7CO9j9NQiLwEBGS37BboR93ovOKdgwiYyoHvPD7tgVfXghtjWB3D6BY6
         /jQkyC2ofErHYTQ2YqnbxDw9rZyCKQkmF1RSCadhhJYRshyuMKEebBEfjVQeXfbmqvLr
         TN4jfk6M2UM/JTy3mRsVYFHDVfgBjGCEVVkUoKLM17+s/ADajgD46sKhgmyc5aWCDAVn
         1lW0xly4f+XbyGlwTJlZHls2f66Lb7Mna/QA1Ni1i9pRxbX+THrwIxy1DeyEB8bJVLTl
         r5ww==
X-Gm-Message-State: AOAM531E7DA1YXVfcKKmHdMvkSAg7MgJ4Xv9PHh4rPlVNMxxo9zqxlwu
        TWAWGyTGcQOKVttB7SIxmYw=
X-Google-Smtp-Source: ABdhPJwM0nLTIrYP/wtpMt2yYOSJNezEQsNl15O/3gO37O6ItP2azMWA+DWR30tWaoQ1BhnOMvz2VA==
X-Received: by 2002:adf:9d45:: with SMTP id o5mr8875561wre.226.1631478560629;
        Sun, 12 Sep 2021 13:29:20 -0700 (PDT)
Received: from localhost.localdomain (46-138-83-36.dynamic.spd-mgts.ru. [46.138.83.36])
        by smtp.gmail.com with ESMTPSA id k29sm4847466wms.24.2021.09.12.13.29.19
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 12 Sep 2021 13:29:20 -0700 (PDT)
From:   Dmitry Osipenko <digetx@gmail.com>
To:     Thierry Reding <thierry.reding@gmail.com>,
        Jonathan Hunter <jonathanh@nvidia.com>,
        Daniel Lezcano <daniel.lezcano@linaro.org>
Cc:     "Rafael J. Wysocki" <rjw@rjwysocki.net>, linux-pm@vger.kernel.org,
        linux-tegra@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH v1 4/6] clk: tegra: Add stubs needed for compile testing
Date:   Sun, 12 Sep 2021 23:29:05 +0300
Message-Id: <20210912202907.28471-5-digetx@gmail.com>
X-Mailer: git-send-email 2.32.0
In-Reply-To: <20210912202907.28471-1-digetx@gmail.com>
References: <20210912202907.28471-1-digetx@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

Add stubs needed for compile-testing of tegra-cpuidle driver.

Signed-off-by: Dmitry Osipenko <digetx@gmail.com>
---
 include/linux/clk/tegra.h | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/include/linux/clk/tegra.h b/include/linux/clk/tegra.h
index d128ad1570aa..9bd06d8a5436 100644
--- a/include/linux/clk/tegra.h
+++ b/include/linux/clk/tegra.h
@@ -42,7 +42,11 @@ struct tegra_cpu_car_ops {
 #endif
 };
 
+#ifdef CONFIG_ARCH_TEGRA
 extern struct tegra_cpu_car_ops *tegra_cpu_car_ops;
+#else
+static struct tegra_cpu_car_ops *tegra_cpu_car_ops __maybe_unused;
+#endif
 
 static inline void tegra_wait_cpu_in_reset(u32 cpu)
 {
-- 
2.32.0

