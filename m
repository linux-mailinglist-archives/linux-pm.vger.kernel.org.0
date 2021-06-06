Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B1D2D39D1E4
	for <lists+linux-pm@lfdr.de>; Mon,  7 Jun 2021 00:30:19 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230383AbhFFWcI (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Sun, 6 Jun 2021 18:32:08 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40624 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230355AbhFFWcI (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Sun, 6 Jun 2021 18:32:08 -0400
Received: from mail-lf1-x134.google.com (mail-lf1-x134.google.com [IPv6:2a00:1450:4864:20::134])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 84E77C06178B;
        Sun,  6 Jun 2021 15:30:06 -0700 (PDT)
Received: by mail-lf1-x134.google.com with SMTP id f30so22965358lfj.1;
        Sun, 06 Jun 2021 15:30:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=RU0cfAbIhBSWaGdmjD9oXjfTzzANl3XSARh7hkPnc+s=;
        b=TkKrt76l3tSdnfBcZ+qa2I0kk/5WBh4IQ9z0CBmBDUKErT8sUXHpqhKEf5lQZP7Muv
         JjbWmfE3fgyqydr6jL8eK3lp/uizFv2dGy7XjLH/Ek4ZV7vlOyjXARBUI5i2hMuLCHSQ
         fancm8ULq+LF5aMlLX0U3sdOuXD4kfUv2wOTx6oKg8s6s1DnKmRkO2XIpwRL9y7H97Y4
         Okp14koytWx32d3s6fOQ/xPWtG3KsgoPZ6peN6Bz5Fqiat3OgOv7FqWBKKk5baUGtKFG
         dg+iT9m8YIPErhL4XTsbJrtrdmDSqyKw96hRCVXaq5pgwBM42/81UY+KGaIvLQ3A7hJg
         eFqg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=RU0cfAbIhBSWaGdmjD9oXjfTzzANl3XSARh7hkPnc+s=;
        b=muhRmQ6w17Tbq0HJxzQIM6zwpswRS2/eTKlOaVokynOgqnujmj5EaLadlTzrsnpsRz
         a6HOCeQRdUsXkgqnfqnWVGJ/hAZyewVpXJdgl1m/7P9E9OdbaurJB8PfBlmjy7hBmsFM
         00iZgUhz2kOxuUk9hTDysVKQDDkazmkBPpzpIyzt2WonwWzTxxuFUbLEwuFB06RX51MQ
         XOxj71y8RraC18YSoLAERDuRc7aJYtXQhLXm4E+MLUu7bEjDy643BiYikF6dFflewoam
         PX0aMh+LruA1QARa7A5iaYXGG+sifUsQ75MXTggLlJrgpVsR/fZA2MDp5PjrIuPNd7JP
         vxJg==
X-Gm-Message-State: AOAM533+lU2hfRS++63E4PjOtI51cLoz2gxudMYFdcQaQnayQbvFgdUy
        J3MbK3uEdLPySxqMt/OENwg=
X-Google-Smtp-Source: ABdhPJw1lo1EbJOp06U3lbVHIupxERopOZSd5cwcw4onZximzGITRFM4oyzoAu0Kv3TJXeAROWDfTg==
X-Received: by 2002:a19:4c57:: with SMTP id z84mr9614125lfa.58.1623018604891;
        Sun, 06 Jun 2021 15:30:04 -0700 (PDT)
Received: from localhost.localdomain (94-29-51-134.dynamic.spd-mgts.ru. [94.29.51.134])
        by smtp.gmail.com with ESMTPSA id i23sm1017778ljg.38.2021.06.06.15.30.04
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 06 Jun 2021 15:30:04 -0700 (PDT)
From:   Dmitry Osipenko <digetx@gmail.com>
To:     Thierry Reding <thierry.reding@gmail.com>,
        Jonathan Hunter <jonathanh@nvidia.com>,
        "Rafael J. Wysocki" <rjw@rjwysocki.net>,
        Daniel Lezcano <daniel.lezcano@linaro.org>
Cc:     linux-pm@vger.kernel.org, linux-tegra@vger.kernel.org
Subject: [PATCH v1 5/5] cpuidle: tegra: Enable compile testing
Date:   Mon,  7 Jun 2021 01:28:17 +0300
Message-Id: <20210606222817.12388-6-digetx@gmail.com>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20210606222817.12388-1-digetx@gmail.com>
References: <20210606222817.12388-1-digetx@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

Enable compile testing of tegra-cpuidle driver.

Signed-off-by: Dmitry Osipenko <digetx@gmail.com>
---
 drivers/cpuidle/Kconfig.arm | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/cpuidle/Kconfig.arm b/drivers/cpuidle/Kconfig.arm
index 334f83e56120..98f8ee6b3552 100644
--- a/drivers/cpuidle/Kconfig.arm
+++ b/drivers/cpuidle/Kconfig.arm
@@ -99,7 +99,7 @@ config ARM_MVEBU_V7_CPUIDLE
 
 config ARM_TEGRA_CPUIDLE
 	bool "CPU Idle Driver for NVIDIA Tegra SoCs"
-	depends on ARCH_TEGRA && !ARM64
+	depends on (ARCH_TEGRA || COMPILE_TEST) && !ARM64
 	select ARCH_NEEDS_CPU_IDLE_COUPLED if SMP
 	select ARM_CPU_SUSPEND
 	help
-- 
2.30.2

