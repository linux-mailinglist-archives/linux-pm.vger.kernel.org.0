Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 94FBA65085
	for <lists+linux-pm@lfdr.de>; Thu, 11 Jul 2019 05:14:00 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728028AbfGKDNn (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Wed, 10 Jul 2019 23:13:43 -0400
Received: from mail-lj1-f196.google.com ([209.85.208.196]:37210 "EHLO
        mail-lj1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727906AbfGKDNl (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Wed, 10 Jul 2019 23:13:41 -0400
Received: by mail-lj1-f196.google.com with SMTP id z28so4197378ljn.4;
        Wed, 10 Jul 2019 20:13:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=sFkiOd23q9EvJCGM6pGQ1kpqTDNZadVb1n2KsuaSyUw=;
        b=ERMyB1Q4XqTA31kKW7Ssb16HrXJwGgQYJJ1xQihR4GHlPleyQIWmHIM1Qv3bWwupRz
         DGYO3yW9gpM2MVQ3Cf2iPqz541oS6QJnT9J3xqsGwCeO24NdOSmIoLGUYam4y8UahI2L
         SSA3aGPxdelFefk/URt+/aSAuTfZLXclmsLV03H93weH1A9wo7H/77hEtDGSloYp728v
         K8yeNPZnTpL1nFjdAkW1ucQcCJtioDqCXc0xv53qRWC6eQxu7I2yEaCbD0QY7JSQd2Zh
         2CfxM7OJdr2L5Smb2jnn7B1hvCwY9MxIfSKeqoH5URdSZlpAboeLMEGA0kXF7DnC4AM2
         npuA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=sFkiOd23q9EvJCGM6pGQ1kpqTDNZadVb1n2KsuaSyUw=;
        b=o4EeCwZbSo5UU3UFkh0lPMCnb0SQSkfGjIGdVLqNGSmnqiFGGpfM7bqGsYvCHjRWir
         llOg95ku5uacVlcexXKuAVEve49kFJ/23uhboPsK4WsviPVsfkwU9C+7sirsvkkp4+CZ
         jTCATttUShQZXfRayLqUyaoFI4GgU5E6ell80gGZziiWy4q0seXNp17zn8/8FnO6JxW7
         YzmSIy1rEFMQty3j5Sv1dlYfyxjGq7aD8ih3fDK0gv1I+54nWrGxMQcG/wNqFd+qJiWU
         kBxB77Tgm6CMD7PQzs5byffYbOCzLpFr1dabjbUbHi/dZliogZ4Aty2Z+vjSEkbuNpJr
         E45w==
X-Gm-Message-State: APjAAAX4pDIb7o0OEdVsG43MoVtUgANqh7SsBHpsalFB8hA1wuAsKd17
        AL2RJGKQ/otvCUnPqyC3+ZU=
X-Google-Smtp-Source: APXvYqwERzyTA76rDln2OycEkk/XL9J2Jaz9orJC5T4/Jq0hdYJ4zYFK6CeGVmyNyRvHS/qKBJpPgw==
X-Received: by 2002:a2e:86cc:: with SMTP id n12mr852397ljj.146.1562814819236;
        Wed, 10 Jul 2019 20:13:39 -0700 (PDT)
Received: from localhost.localdomain (ppp79-139-233-208.pppoe.spdop.ru. [79.139.233.208])
        by smtp.gmail.com with ESMTPSA id h84sm753915ljf.42.2019.07.10.20.13.38
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 10 Jul 2019 20:13:38 -0700 (PDT)
From:   Dmitry Osipenko <digetx@gmail.com>
To:     Thierry Reding <thierry.reding@gmail.com>,
        Jonathan Hunter <jonathanh@nvidia.com>,
        Peter De Schrijver <pdeschrijver@nvidia.com>,
        "Rafael J. Wysocki" <rjw@rjwysocki.net>,
        Daniel Lezcano <daniel.lezcano@linaro.org>
Cc:     linux-pm@vger.kernel.org, linux-tegra@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: [PATCH v2 4/6] cpuidle: tegra: Support CPU cluster power-down on Tegra30
Date:   Thu, 11 Jul 2019 06:13:10 +0300
Message-Id: <20190711031312.10038-5-digetx@gmail.com>
X-Mailer: git-send-email 2.22.0
In-Reply-To: <20190711031312.10038-1-digetx@gmail.com>
References: <20190711031312.10038-1-digetx@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

The new CPU Idle driver has all necessary features in order to allow
the deepest idling state on Tegra30 SoC where the whole CPU cluster is
power-gated using the coupled idle state.

Note that outer_disable() now need to be invoked directly since it
produces erroneous warning message about secondary CPUs being online
because it doesn't know that secondaries are turned off at that point
by the cpuidle driver.

Signed-off-by: Dmitry Osipenko <digetx@gmail.com>
---
 arch/arm/mach-tegra/pm.c        | 4 ++--
 drivers/cpuidle/cpuidle-tegra.c | 1 -
 2 files changed, 2 insertions(+), 3 deletions(-)

diff --git a/arch/arm/mach-tegra/pm.c b/arch/arm/mach-tegra/pm.c
index f9c9bce9e15d..cc941b0c97e8 100644
--- a/arch/arm/mach-tegra/pm.c
+++ b/arch/arm/mach-tegra/pm.c
@@ -146,8 +146,8 @@ static int tegra_sleep_cpu(unsigned long v2p)
 	 * if any of secondary CPU's is online and this is the LP2-idle
 	 * code-path only for Tegra20/30.
 	 */
-	if (trusted_foundations_registered())
-		outer_disable();
+	if (trusted_foundations_registered() && outer_cache.disable)
+		outer_cache.disable();
 
 	/*
 	 * Note that besides of setting up CPU reset vector this firmware
diff --git a/drivers/cpuidle/cpuidle-tegra.c b/drivers/cpuidle/cpuidle-tegra.c
index 54974cd2255f..1412c4b0f6ee 100644
--- a/drivers/cpuidle/cpuidle-tegra.c
+++ b/drivers/cpuidle/cpuidle-tegra.c
@@ -278,7 +278,6 @@ static int tegra_cpuidle_probe(struct platform_device *pdev)
 		tegra_idle_driver.states[TEGRA_C7].disabled = true;
 		break;
 	case TEGRA30:
-		tegra_idle_driver.states[TEGRA_CC6].disabled = true;
 		break;
 	case TEGRA114:
 	case TEGRA124:
-- 
2.22.0

