Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 021CF12542C
	for <lists+linux-pm@lfdr.de>; Wed, 18 Dec 2019 22:07:32 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726867AbfLRVG7 (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Wed, 18 Dec 2019 16:06:59 -0500
Received: from mail-lj1-f194.google.com ([209.85.208.194]:35563 "EHLO
        mail-lj1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726824AbfLRVG6 (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Wed, 18 Dec 2019 16:06:58 -0500
Received: by mail-lj1-f194.google.com with SMTP id j6so3739244lja.2;
        Wed, 18 Dec 2019 13:06:56 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=knR00ggshGiSq9D+iSExGzRY0OKCDWpZOMHL9ri5sUI=;
        b=Wt0buarEZpL3wn7TIypAv8IsvBnOPNd3fgNP1hwQaJA80cmvm2VUSCV9Jr/9fYzTWs
         DnIFeZICqsgQ8TfIgr4wNN6krZnCcT3Wq3SO74hU9dUE4weIiWU/nXrFjI39rs3KoxN2
         9B0pG2eT1sNfimYfkn+rXB0FMH5oYL+QVOM0RPaO+slZSDaNT0I/AyzpuW9JuM1O5iv3
         fD3FS5yApEJ2qgi1heciiZxOhzLFexFFH4FtDKrklpu0BI97xhE1IbWq+ZI+f3pW9MKs
         L5qeDehmCfM3FlJ21SOCIHmUey7jVHYprUntpGJZ+2uy92+rYPdEdZmg54DddnvwMhDu
         RFCQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=knR00ggshGiSq9D+iSExGzRY0OKCDWpZOMHL9ri5sUI=;
        b=M0SrKct7KJTYWi/eNe9BcnGxPhFu+FdkZgs0Wn23w+mbB2BnzX/l7DuIzBNE39fXi+
         gUXP/9Tt4h8Ei6Ozy6nQWL4jEe5O3lauOPcu7or7c9FPVo/DC2ZlTESShiJITQbI1q8q
         0o474dd40Xja9dj+/eTcgtnNnOA7KoFfVBNEHnGP3X6OJq8t/KTa0PpBIiChlzWrztwD
         o/aJi1x9PuKNQcQ19bMjpdacIlDkSF/eMyXyvCRZpFZ/WODdDfzSeh8b3Xei7YR9h5cl
         PHi73iC8TAknKUgAfV8LCsBugZTyPKIbEg+Xy09aAF4ttc8qpSpNPlKfyqDMTe4hTmit
         Wz9w==
X-Gm-Message-State: APjAAAVjrS8jxYSSJYJzvvG8+yRWfU9/Tg4D91aB3AMchwlV1AvjNpEJ
        lWH/EWE+X6udJphr5x99zaU=
X-Google-Smtp-Source: APXvYqwdbNIgzxaDSt48j+jKXeWeTfYsIANcwxxYZSuiHC4p0VlISRF5WZDiam6+XsRe4K5+66z1cA==
X-Received: by 2002:a2e:461a:: with SMTP id t26mr3438827lja.204.1576703216207;
        Wed, 18 Dec 2019 13:06:56 -0800 (PST)
Received: from localhost.localdomain (79-139-233-37.dynamic.spd-mgts.ru. [79.139.233.37])
        by smtp.gmail.com with ESMTPSA id r15sm1754648ljk.3.2019.12.18.13.06.55
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 18 Dec 2019 13:06:55 -0800 (PST)
From:   Dmitry Osipenko <digetx@gmail.com>
To:     Thierry Reding <thierry.reding@gmail.com>,
        Jonathan Hunter <jonathanh@nvidia.com>,
        Peter De Schrijver <pdeschrijver@nvidia.com>,
        "Rafael J. Wysocki" <rjw@rjwysocki.net>,
        Daniel Lezcano <daniel.lezcano@linaro.org>,
        =?UTF-8?q?Micha=C5=82=20Miros=C5=82aw?= <mirq-linux@rere.qmqm.pl>
Cc:     linux-pm@vger.kernel.org, linux-tegra@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH v9 16/17] ARM: multi_v7_defconfig: Enable Tegra cpuidle driver
Date:   Thu, 19 Dec 2019 00:05:02 +0300
Message-Id: <20191218210503.6689-17-digetx@gmail.com>
X-Mailer: git-send-email 2.24.0
In-Reply-To: <20191218210503.6689-1-digetx@gmail.com>
References: <20191218210503.6689-1-digetx@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

The Tegra CPU Idle driver was moved out into driver/cpuidle/ directory and
it is now a proper platform driver.

Acked-by: Peter De Schrijver <pdeschrijver@nvidia.com>
Signed-off-by: Dmitry Osipenko <digetx@gmail.com>
---
 arch/arm/configs/multi_v7_defconfig | 1 +
 1 file changed, 1 insertion(+)

diff --git a/arch/arm/configs/multi_v7_defconfig b/arch/arm/configs/multi_v7_defconfig
index 3f1b96dc7faa..1d1b595c998c 100644
--- a/arch/arm/configs/multi_v7_defconfig
+++ b/arch/arm/configs/multi_v7_defconfig
@@ -113,6 +113,7 @@ CONFIG_CPU_IDLE=y
 CONFIG_ARM_CPUIDLE=y
 CONFIG_ARM_ZYNQ_CPUIDLE=y
 CONFIG_ARM_EXYNOS_CPUIDLE=y
+CONFIG_ARM_TEGRA_CPUIDLE=y
 CONFIG_KERNEL_MODE_NEON=y
 CONFIG_RASPBERRYPI_FIRMWARE=y
 CONFIG_TRUSTED_FOUNDATIONS=y
-- 
2.24.0

