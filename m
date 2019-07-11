Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id F10D06507D
	for <lists+linux-pm@lfdr.de>; Thu, 11 Jul 2019 05:13:43 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728026AbfGKDNm (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Wed, 10 Jul 2019 23:13:42 -0400
Received: from mail-lj1-f194.google.com ([209.85.208.194]:44831 "EHLO
        mail-lj1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727874AbfGKDNm (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Wed, 10 Jul 2019 23:13:42 -0400
Received: by mail-lj1-f194.google.com with SMTP id k18so4162841ljc.11;
        Wed, 10 Jul 2019 20:13:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=3Bk1blV5oQEyQV3BicG+2hmfkOduACJXlcdjcBUfd1g=;
        b=c9HpTO2ig6B+SiMO23kHDjqljR4JBbZCFeobLD2jX3lQ25AoPcT5cW/Qdxfj8dY9AC
         BLhc2+GyJmGwP+rJPxnHZnBCwtdwYlABjvo0SJQ2IXa4VKg2Jw6DQ2x5gdUlen033rAO
         tIv5ebyR0k/6U9ZdSHD7OgHgimv4PTPR4rt0Aus4fIW9Xb+SXR9w/dKtD6SfXgI1Ft3X
         3FUw0a4w9VFWwMxzUlpN7vxY0h5M4qggdSAmmt6PjAMetkForHZaq4ZhzXJco01HQTQu
         hiuKVDzAhB/rHWIhU5QgYu3kvjnrQsxZjVDrdgJnsb0UBNvkqzCnFIW8zA9F4Yb2SMt/
         84Lg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=3Bk1blV5oQEyQV3BicG+2hmfkOduACJXlcdjcBUfd1g=;
        b=PvIIZmTpEE0/OpI0Rx2S9XU0usdXpOeq4NbJE22ETxLpZyMpjkFnaMthkwRMeh8A/L
         hrZJG/8Ik9p80su2K9Uinl20fMGCi7l9Px7035Gbgnu3pldk0EJ3iIfnnNcPhfKKlKAF
         iaRouTZ3sCH77lkSia21THsdiYLFZAbhFgoV+i2WkKm1bEb/D3XXp3l72fUJspjtxUNv
         /j0xgOBCqB2Wrc6V5kD0mHM4KPvEsUVeSMaMjQldef9+4B92rcdRX0KzB55wQ6H3ictG
         CyKDJB4kewBWuMj/TwD6q/e7HzQQa9Esd1TdVIMcrmSZj2D/UZUmV16E7tdGpM6Kpx1x
         upOA==
X-Gm-Message-State: APjAAAWaNpt7qaQ8Jhwxi8GYTW1v7xVEXkhRzhyIMWs+IZ4GfMbCPZhZ
        RWIMctNkM2nEUIrEUS9RbVU=
X-Google-Smtp-Source: APXvYqz1xa5euZ79IKq4iDtYx9Cl2OrfI1H9xAMWaAw4WTe5wxF75jFFc1u3Yr810Lfq079dF9Shew==
X-Received: by 2002:a2e:9045:: with SMTP id n5mr453281ljg.66.1562814820197;
        Wed, 10 Jul 2019 20:13:40 -0700 (PDT)
Received: from localhost.localdomain (ppp79-139-233-208.pppoe.spdop.ru. [79.139.233.208])
        by smtp.gmail.com with ESMTPSA id h84sm753915ljf.42.2019.07.10.20.13.39
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 10 Jul 2019 20:13:39 -0700 (PDT)
From:   Dmitry Osipenko <digetx@gmail.com>
To:     Thierry Reding <thierry.reding@gmail.com>,
        Jonathan Hunter <jonathanh@nvidia.com>,
        Peter De Schrijver <pdeschrijver@nvidia.com>,
        "Rafael J. Wysocki" <rjw@rjwysocki.net>,
        Daniel Lezcano <daniel.lezcano@linaro.org>
Cc:     linux-pm@vger.kernel.org, linux-tegra@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: [PATCH v2 5/6] ARM: multi_v7_defconfig: Enable Tegra cpuidle driver
Date:   Thu, 11 Jul 2019 06:13:11 +0300
Message-Id: <20190711031312.10038-6-digetx@gmail.com>
X-Mailer: git-send-email 2.22.0
In-Reply-To: <20190711031312.10038-1-digetx@gmail.com>
References: <20190711031312.10038-1-digetx@gmail.com>
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
 arch/arm/configs/multi_v7_defconfig | 1 +
 1 file changed, 1 insertion(+)

diff --git a/arch/arm/configs/multi_v7_defconfig b/arch/arm/configs/multi_v7_defconfig
index 6a40bc2ef271..2c0fc7968c42 100644
--- a/arch/arm/configs/multi_v7_defconfig
+++ b/arch/arm/configs/multi_v7_defconfig
@@ -107,6 +107,7 @@ CONFIG_CPU_IDLE=y
 CONFIG_ARM_CPUIDLE=y
 CONFIG_ARM_ZYNQ_CPUIDLE=y
 CONFIG_ARM_EXYNOS_CPUIDLE=y
+CONFIG_ARM_TEGRA_CPUIDLE=y
 CONFIG_KERNEL_MODE_NEON=y
 CONFIG_RASPBERRYPI_FIRMWARE=y
 CONFIG_TRUSTED_FOUNDATIONS=y
-- 
2.22.0

