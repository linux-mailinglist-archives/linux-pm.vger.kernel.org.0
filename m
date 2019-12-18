Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id A77C112542F
	for <lists+linux-pm@lfdr.de>; Wed, 18 Dec 2019 22:07:33 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726911AbfLRVHH (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Wed, 18 Dec 2019 16:07:07 -0500
Received: from mail-lf1-f68.google.com ([209.85.167.68]:37897 "EHLO
        mail-lf1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726840AbfLRVG7 (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Wed, 18 Dec 2019 16:06:59 -0500
Received: by mail-lf1-f68.google.com with SMTP id r14so2725335lfm.5;
        Wed, 18 Dec 2019 13:06:57 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=OX3etwg8UyXmbbSJQLCscVLMHChzcySiKJD4V7kijDA=;
        b=GIA8G7vs3ssG+kS97bTj/9sDjWnB0kbPTwEOvBXDvEmAmNgHov8HaqJ9Jp637+eJDr
         mLFY1peZ9m/mZdiPvimSZzUZtSmoOyFHxLwT00eOyeWK9oa0RYAonBMkgeTj5WbO4y31
         MB9rrwVxZvEKGkvsKLHBnmqkbebPuO3RVtN7wMK4iJz7xxNOkm7P0PO5RIILldqBwX1t
         wQOIcH/BZtXlAPIafiaXZqTi1jI8ohmqMyhgxVvf1v5AJOEDQaZ9INVQZ9SNlm353r5+
         /+zwSljYFZwCrEOl6K6f7uHZ2p33pKu8ogzOS4Za84lhGj+2GriO/Gq9UVSamYfih0Z0
         K9HA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=OX3etwg8UyXmbbSJQLCscVLMHChzcySiKJD4V7kijDA=;
        b=NvpaRQ0CIbogvjgGR85shzjd6xrToYE1jKv1B3HM6QRJh2/co5ukBh8OBEmAZIKvbA
         iY3hkZywULSm8yAdVoy61TNZ3D9SMEmRs8b13U34flmsVJll53qVB4z0fuTLWN4Pu6Q0
         prbLzVfV/rKyoYyJ5VZYoLimPcp2l1TCKLewkrtuQF7CkJk79rpaPcSCraAlFsBZLKJk
         9RN4PDCJ7ChTXJeTlb6PvoYBuD75dGqyhBad4/aETtOarQu377rNWW8rTq+mphHWF19+
         7uadeqO3eVuYUFYFnKtKxa21EH9I9cdF7/LT8ZTm7IXF3DP3u3vw97NVmTEuzJopihbt
         gAeA==
X-Gm-Message-State: APjAAAVl0zZLJDwP/oSem1oI9rIFLO6jdbNbbUZyJypgytq13d9zXvQ6
        6benhIW6J+o+EQa4kCx2oEs=
X-Google-Smtp-Source: APXvYqwKH8I3c4Sj8soE97dvCZsqMd65HH/e73RXgS6N+7HJggYBIknoIPITBYBlsvTF68+XmZ4mfQ==
X-Received: by 2002:ac2:4194:: with SMTP id z20mr3177996lfh.20.1576703217029;
        Wed, 18 Dec 2019 13:06:57 -0800 (PST)
Received: from localhost.localdomain (79-139-233-37.dynamic.spd-mgts.ru. [79.139.233.37])
        by smtp.gmail.com with ESMTPSA id r15sm1754648ljk.3.2019.12.18.13.06.56
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 18 Dec 2019 13:06:56 -0800 (PST)
From:   Dmitry Osipenko <digetx@gmail.com>
To:     Thierry Reding <thierry.reding@gmail.com>,
        Jonathan Hunter <jonathanh@nvidia.com>,
        Peter De Schrijver <pdeschrijver@nvidia.com>,
        "Rafael J. Wysocki" <rjw@rjwysocki.net>,
        Daniel Lezcano <daniel.lezcano@linaro.org>,
        =?UTF-8?q?Micha=C5=82=20Miros=C5=82aw?= <mirq-linux@rere.qmqm.pl>
Cc:     linux-pm@vger.kernel.org, linux-tegra@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH v9 17/17] ARM: tegra: Enable Tegra cpuidle driver in tegra_defconfig
Date:   Thu, 19 Dec 2019 00:05:03 +0300
Message-Id: <20191218210503.6689-18-digetx@gmail.com>
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
 arch/arm/configs/tegra_defconfig | 1 +
 1 file changed, 1 insertion(+)

diff --git a/arch/arm/configs/tegra_defconfig b/arch/arm/configs/tegra_defconfig
index a27592d3b1fa..aa94369bdd0f 100644
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
2.24.0

