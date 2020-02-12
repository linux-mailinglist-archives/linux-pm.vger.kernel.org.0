Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 2452415B54D
	for <lists+linux-pm@lfdr.de>; Thu, 13 Feb 2020 00:52:34 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729454AbgBLXw3 (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Wed, 12 Feb 2020 18:52:29 -0500
Received: from mail-lf1-f68.google.com ([209.85.167.68]:40050 "EHLO
        mail-lf1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729434AbgBLXw3 (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Wed, 12 Feb 2020 18:52:29 -0500
Received: by mail-lf1-f68.google.com with SMTP id c23so2875762lfi.7;
        Wed, 12 Feb 2020 15:52:27 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=zsiGVctojQQ/6++c4wQ+fRDwiUrqLwmb6/O4RUjlNXE=;
        b=OU7ZIoH6xa+RHKvzKulLNccHwssYjB1zeJg521ypdoR6sRKoJsmJ2nKPcwohrYHCZr
         m+j5R/XsjR3vmmdB2r9Rqq2qyYCGq4iX/6ftkIdcJtaPhgQix9G1jallZ3WficK/4MyQ
         81LYxBMqhzu/g+JvedxO0kgLrr/99RoACcF63aPmxxQJWzxLC7wfoFPexwTRFnWNic4w
         j7kVxrxPNAhbbswkCE0VrSTNDqOIUvcXvAQPSONtrsTyeRNKpLS7sqCBwXZuobxzu327
         6889rNENjD6+Do/lERUsdv1qmd/1ZOfnR5KaD3xnchMeu8s5q1+At+JiUKAxCQ2PTudD
         qoxw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=zsiGVctojQQ/6++c4wQ+fRDwiUrqLwmb6/O4RUjlNXE=;
        b=Nd0v8/CJwNxuFZQxWsoU3uUfDFokqL4pXp7ioBPNj64E7k0A6ZHjGMNwiLbpU2Ampy
         KsYuj+ix/BYg4glAm9H9716tfclZs2KUqaPAQ9GV0tLkEqEvg9LAqUfyZwZfkoGsoJRG
         6ay3BGys6Wm02/JqlW/FfqOf8OcYs6FiVXr+8Uw9CZ/ZWye0SflHH2UzDI+BgjDeJvQo
         Dk41kUt/yTUjAQU+HyBC2QwSgyg18tf+iD35qZqv9V60tSQ3Ro7S0t9/p09iAW6d4afS
         5Jgji6sWKIQHUvrihKmZr94DUbPNfm9rIEYydLwUY+Ns7n1kGxFL/JL5I57FjhU0fSeG
         nV/Q==
X-Gm-Message-State: APjAAAWNslwnhU3LyGBCpWn661fvXiqS16R1GjOAkNOMfbcrbdZ6sFe4
        EuBsKAuLw1ODYH3RrbNUAFY=
X-Google-Smtp-Source: APXvYqznhcpF7KnI+KM7LHINL4een5Ysq+21b+f/U4l60sOASA+jqVYxQ1lri4YNGc2FKdl2s0EJDA==
X-Received: by 2002:a19:9d5:: with SMTP id 204mr7661617lfj.120.1581551546802;
        Wed, 12 Feb 2020 15:52:26 -0800 (PST)
Received: from localhost.localdomain (79-139-233-37.dynamic.spd-mgts.ru. [79.139.233.37])
        by smtp.gmail.com with ESMTPSA id d5sm251686lfb.20.2020.02.12.15.52.25
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 12 Feb 2020 15:52:26 -0800 (PST)
From:   Dmitry Osipenko <digetx@gmail.com>
To:     Thierry Reding <thierry.reding@gmail.com>,
        Jonathan Hunter <jonathanh@nvidia.com>,
        Peter De Schrijver <pdeschrijver@nvidia.com>,
        "Rafael J. Wysocki" <rjw@rjwysocki.net>,
        Daniel Lezcano <daniel.lezcano@linaro.org>,
        =?UTF-8?q?Micha=C5=82=20Miros=C5=82aw?= <mirq-linux@rere.qmqm.pl>,
        Jasper Korten <jja2000@gmail.com>,
        David Heidelberg <david@ixit.cz>,
        Peter Geis <pgwipeout@gmail.com>
Cc:     linux-pm@vger.kernel.org, linux-tegra@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH v9 16/17] ARM: multi_v7_defconfig: Enable Tegra cpuidle driver
Date:   Thu, 13 Feb 2020 02:51:33 +0300
Message-Id: <20200212235134.12638-17-digetx@gmail.com>
X-Mailer: git-send-email 2.24.0
In-Reply-To: <20200212235134.12638-1-digetx@gmail.com>
References: <20200212235134.12638-1-digetx@gmail.com>
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
index 017d65f86eba..7c8a1c310bbb 100644
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

