Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7F2553AA3D5
	for <lists+linux-pm@lfdr.de>; Wed, 16 Jun 2021 21:05:43 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232260AbhFPTHn (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Wed, 16 Jun 2021 15:07:43 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59110 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232287AbhFPTHl (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Wed, 16 Jun 2021 15:07:41 -0400
Received: from mail-lj1-x235.google.com (mail-lj1-x235.google.com [IPv6:2a00:1450:4864:20::235])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3C59BC06175F;
        Wed, 16 Jun 2021 12:05:33 -0700 (PDT)
Received: by mail-lj1-x235.google.com with SMTP id d13so5253209ljg.12;
        Wed, 16 Jun 2021 12:05:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=W4XYgA9FTIuq7IUiliTgLv6U+XMmEN4JcS1gayFO6x4=;
        b=aklR4i1hXUfrG04ATZc3V7d+pNg97LBgCrO/h9uWp4jIOT472wYtTxe+VbT0INQcVD
         35O/SLUJCp5nq3ekPbI3eLMc38t1LZaRteIlYjQiiZJZQsh+e35rbvgFUDR8HQFZ3iIf
         2x8aizooDp+amUUmre6yT/w9LfT1RiHMJlSfnC1y+3IVnJohFr61rdQMKPS8PISwZFYo
         ni3Zu6omNFLOlwS+KQYud1yNmCgl8vA0ShvGayUPN8IQCIlnxW5dboyeRjhFbodv12Dc
         rl2/VhYDuLPlRg4dVVe5O+2OskGWRhgE1V8FRBn4BOOKdns8r1MlZCj+RNo4jq7qIrEB
         NW/A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=W4XYgA9FTIuq7IUiliTgLv6U+XMmEN4JcS1gayFO6x4=;
        b=VQP4gMnokUNXtvIeV2o+HJl/iOgrutN3DVIcZdjLKaKcmWr7pbEjIf8eECZW8vXQQp
         ftuMkcQ+gls6NtfZxIqZJcZZXUx5ECG9mtGrEJ9BhXwONyXlBlbG2kJyTTd8szfTI+C3
         H5VI7Yka2o3UkAy+MTj8sT22yVXM1WTnA1+z1wTE2Fz2CpexP8ZcbsxIqcUWWLCgnhgp
         VCBBZR6uKBZPQ2AHqHbCoIu9u9oMl4CCno8iui7NAOo/MptMXY5RMexWuiSyFtv/4qKe
         jVvN6f9/vIJQj6MzvsnQjUdFFKGhBtmRQ8b+waUZOu0ppYNvFOjLEEkc8zxgEOY2BuYu
         NnRw==
X-Gm-Message-State: AOAM5335MlTgnlqMeco6zaad0aWP2fP+FRgroacgwD0oRRvmeWnc6tUF
        2oAK5WsV6t6I+LEpc+mUHWg=
X-Google-Smtp-Source: ABdhPJwK6jUzWK2YqOeiBtOplt59KXlk2jlcQRswgLSbu8WNnf8HPDHv0Fnq8B0j58B6bAoy2vqyjg==
X-Received: by 2002:a2e:b4bc:: with SMTP id q28mr1182302ljm.286.1623870331674;
        Wed, 16 Jun 2021 12:05:31 -0700 (PDT)
Received: from localhost.localdomain (94-29-29-31.dynamic.spd-mgts.ru. [94.29.29.31])
        by smtp.gmail.com with ESMTPSA id e20sm365951ljk.67.2021.06.16.12.05.30
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 16 Jun 2021 12:05:31 -0700 (PDT)
From:   Dmitry Osipenko <digetx@gmail.com>
To:     Thierry Reding <thierry.reding@gmail.com>,
        Jonathan Hunter <jonathanh@nvidia.com>,
        Zhang Rui <rui.zhang@intel.com>,
        Daniel Lezcano <daniel.lezcano@linaro.org>,
        Amit Kucheria <amitk@kernel.org>,
        Andreas Westman Dorcsak <hedmoo@yahoo.com>,
        Maxim Schwalm <maxim.schwalm@gmail.com>,
        Svyatoslav Ryhel <clamor95@gmail.com>,
        Ihor Didenko <tailormoon@rambler.ru>,
        Ion Agorria <ion@agorria.com>,
        Matt Merhar <mattmerhar@protonmail.com>,
        Peter Geis <pgwipeout@gmail.com>
Cc:     linux-pm@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-tegra@vger.kernel.org
Subject: [PATCH v4 4/6] ARM: tegra_defconfig: Enable CONFIG_TEGRA30_TSENSOR
Date:   Wed, 16 Jun 2021 22:04:15 +0300
Message-Id: <20210616190417.32214-5-digetx@gmail.com>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20210616190417.32214-1-digetx@gmail.com>
References: <20210616190417.32214-1-digetx@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

Enable NVIDIA Tegra30 SoC thermal sensor driver in tegra_defconfig.

Signed-off-by: Dmitry Osipenko <digetx@gmail.com>
---
 arch/arm/configs/tegra_defconfig | 1 +
 1 file changed, 1 insertion(+)

diff --git a/arch/arm/configs/tegra_defconfig b/arch/arm/configs/tegra_defconfig
index 3d8d8af9524d..63e7f3261e6d 100644
--- a/arch/arm/configs/tegra_defconfig
+++ b/arch/arm/configs/tegra_defconfig
@@ -169,6 +169,7 @@ CONFIG_THERMAL_STATISTICS=y
 CONFIG_CPU_THERMAL=y
 CONFIG_DEVFREQ_THERMAL=y
 CONFIG_TEGRA_SOCTHERM=m
+CONFIG_TEGRA30_TSENSOR=m
 CONFIG_WATCHDOG=y
 CONFIG_MAX77620_WATCHDOG=y
 CONFIG_TEGRA_WATCHDOG=y
-- 
2.30.2

