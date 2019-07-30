Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 2FAF87AF32
	for <lists+linux-pm@lfdr.de>; Tue, 30 Jul 2019 19:11:23 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730286AbfG3RKY (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Tue, 30 Jul 2019 13:10:24 -0400
Received: from mail-wm1-f67.google.com ([209.85.128.67]:40845 "EHLO
        mail-wm1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730434AbfG3RKY (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Tue, 30 Jul 2019 13:10:24 -0400
Received: by mail-wm1-f67.google.com with SMTP id v19so57368092wmj.5;
        Tue, 30 Jul 2019 10:10:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=9sbsaF7E0TrDeiv6pReKgq+pMBX4p8SmM9uYJr655g4=;
        b=krpSGAIlChVcjlUuj3EF9XDg3prNLpG+C+OGiZNzymZi9ZqV82bfPGcwmqvFnc3+ju
         zCWn11U8+25sjpM2WtTOwm/zZ167E/bKomEKYArY3EzEJW+HvesYCzR6jjMP9ypBk2Pm
         JZwi7z4OpiwPnhhW75XMUG+WbfzIP6NvlDc7NQK3ne4ljopH+g+rJK60PgUYa1U/X22p
         F5+8tynsG5zC0QvrnDKUJqLB3+AJsgds3kWkoAH1f/qp3uRy98yWSObB/rMy4BbgPOIt
         rvb9Yq5fnwmTGk7N9fwGYSADg+mhY+mbXJ1JzTN31AEcqb07PgKFF9mJ/D9LlnlTjj6u
         ku1A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=9sbsaF7E0TrDeiv6pReKgq+pMBX4p8SmM9uYJr655g4=;
        b=HetkST78uG3wd+GcbboEb6wG0x6FLFoja9ov6EEi2Am9Vg2rmjO1TZBgWroCtBW6on
         sxrX1jc+yMzSLiPDvbW6DIrskzd72pa7aF0l1X7byIBDepWDDOf1V0+neLFkiozKGuYP
         YckoyeqF/9EsyRvFpP82e4FCtIgGStiR7mUkTYvt3cLCKlQqB0dxSiKD3yB1fSf2WW3b
         pvR/dFzGxD0ovDeIFFY75DeAFWW7q9KX4WJgr9ktIcY6juEWbSLZBEY5MmCPyKkov306
         ynFfH0z2vMiGV1PyRKvUvpt1VgTlgju96wAiILeI7uq1ORZZIxO136A2SpPkyzZk2QXZ
         zngg==
X-Gm-Message-State: APjAAAXg/umMNSG5HhwaTDHe2t67BE5N8uhsU5dOJNO3Foe2ItjpQJem
        x2shL8SzmXN2XrfHFipSy7M=
X-Google-Smtp-Source: APXvYqwo0XTcvNSkF5Ae3SJz5WKhJIWn0FKkSYOSylnFOXzO08y++ztwmKLzBsZKxOM6/2hzjnGkcQ==
X-Received: by 2002:a1c:c706:: with SMTP id x6mr103932234wmf.162.1564506622730;
        Tue, 30 Jul 2019 10:10:22 -0700 (PDT)
Received: from localhost.localdomain (ppp91-78-220-99.pppoe.mtu-net.ru. [91.78.220.99])
        by smtp.gmail.com with ESMTPSA id i13sm58897736wrr.73.2019.07.30.10.10.21
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 30 Jul 2019 10:10:22 -0700 (PDT)
From:   Dmitry Osipenko <digetx@gmail.com>
To:     Thierry Reding <thierry.reding@gmail.com>,
        Jonathan Hunter <jonathanh@nvidia.com>,
        Peter De Schrijver <pdeschrijver@nvidia.com>,
        "Rafael J. Wysocki" <rjw@rjwysocki.net>,
        Daniel Lezcano <daniel.lezcano@linaro.org>
Cc:     linux-pm@vger.kernel.org, linux-tegra@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: [PATCH v4 13/13] ARM: tegra: Enable Tegra cpuidle driver in tegra_defconfig
Date:   Tue, 30 Jul 2019 20:09:55 +0300
Message-Id: <20190730170955.11987-14-digetx@gmail.com>
X-Mailer: git-send-email 2.22.0
In-Reply-To: <20190730170955.11987-1-digetx@gmail.com>
References: <20190730170955.11987-1-digetx@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

The Tegra CPU Idle driver was moved out into driver/cpuidle/ directory and
it is now a proper platform driver.

Signed-off-by: Dmitry Osipenko <digetx@gmail.com>
---
 arch/arm/configs/tegra_defconfig | 1 +
 1 file changed, 1 insertion(+)

diff --git a/arch/arm/configs/tegra_defconfig b/arch/arm/configs/tegra_defconfig
index 8f5c6a5b444c..9a2f11a780a8 100644
--- a/arch/arm/configs/tegra_defconfig
+++ b/arch/arm/configs/tegra_defconfig
@@ -25,6 +25,7 @@ CONFIG_CPU_FREQ=y
 CONFIG_CPU_FREQ_DEFAULT_GOV_ONDEMAND=y
 CONFIG_CPUFREQ_DT=y
 CONFIG_CPU_IDLE=y
+CONFIG_ARM_TEGRA_CPUIDLE=y
 CONFIG_VFP=y
 CONFIG_NEON=y
 CONFIG_TRUSTED_FOUNDATIONS=y
-- 
2.22.0

