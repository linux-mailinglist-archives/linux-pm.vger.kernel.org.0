Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id D183816B456
	for <lists+linux-pm@lfdr.de>; Mon, 24 Feb 2020 23:43:16 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728407AbgBXWnG (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Mon, 24 Feb 2020 17:43:06 -0500
Received: from mail-lj1-f194.google.com ([209.85.208.194]:37380 "EHLO
        mail-lj1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728420AbgBXWmy (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Mon, 24 Feb 2020 17:42:54 -0500
Received: by mail-lj1-f194.google.com with SMTP id q23so11938239ljm.4;
        Mon, 24 Feb 2020 14:42:52 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=0hUJ+JgfxZEA468vXjntT4RJZ/+VagueJ/BTp8613xY=;
        b=C0scDf7PrZ5FnBGFEJYsiBSVRQ8WGDHyNXCilBLVpql+IJBQVXCT0i0/NoasEg4p2G
         Gb7rOCWWDp0pACOSPgyZFC0kO1MSJuUtSj1yNg+jX1k/ysgcemLhbMN3Uw9UMaholkLI
         nnBsNlILbHrhzPn+Gkk58hrEOLJSwuDFASoq8CFtq4orlFQ5OJ6ZxR2slaqsdbEOPMJt
         clmQy1Fd63AGvt89ObPpk0Koj6bwDG1BW86dZfh4rJL7ela3knNby5jEnMsCgFvFRnkW
         lo8/LvDDK2CW56JnPFom6GZIomaGEogLGmaN1zFyV4c3OA+5LUTWafp615yJCmYUF0e6
         yJ4A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=0hUJ+JgfxZEA468vXjntT4RJZ/+VagueJ/BTp8613xY=;
        b=T4Jy62o1U1XBbQ8Idjj6cN95oNkYBN2nr3Ogre3ghQz9AZm9rEfXkbgQIzqmcJYJGu
         N/00UPIpJN3wc7CcCKS/9+JV2fst1z03ujncjCDl7TfKAbJda6QqdMNkUPuti7BgVgxG
         CmV3oJxfBVDbv2ystSRvu8/va6kvOKWDrJkZj9PYFsF5JkIOfv/2TWpW/uVvR7Jz91ir
         FOPMQgyoi5RnKv66m1AImoTYVg4crF6QiERBFiauvlAYAHG/XM8hiEFp+cCCVofK7XUx
         6lNVK9O142r0p/WSQAu+eotvNI6uTQQzhGSo9H8PKkYLSwH9TQUbfX453JT493R6rhHM
         OJBA==
X-Gm-Message-State: APjAAAUAZCzn+YVrTGEcBeNTcFzseiti07ZBiqddDWsp1SPT7RcP1Szb
        83HyyqPxhRc2hA1rfskMK3k=
X-Google-Smtp-Source: APXvYqxD3LcoWtS/nitwx99ej+V+ekLaikYfKtxV7NjwwHGQFzMx8LTBw+Y0C7UjDlaQoBoJUMtfSA==
X-Received: by 2002:a2e:9b52:: with SMTP id o18mr31069962ljj.270.1582584171731;
        Mon, 24 Feb 2020 14:42:51 -0800 (PST)
Received: from localhost.localdomain (79-139-233-37.dynamic.spd-mgts.ru. [79.139.233.37])
        by smtp.gmail.com with ESMTPSA id j7sm6264833lfh.25.2020.02.24.14.42.50
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 24 Feb 2020 14:42:51 -0800 (PST)
From:   Dmitry Osipenko <digetx@gmail.com>
To:     Thierry Reding <thierry.reding@gmail.com>,
        Jonathan Hunter <jonathanh@nvidia.com>,
        Peter De Schrijver <pdeschrijver@nvidia.com>,
        "Rafael J. Wysocki" <rjw@rjwysocki.net>,
        Daniel Lezcano <daniel.lezcano@linaro.org>,
        =?UTF-8?q?Micha=C5=82=20Miros=C5=82aw?= <mirq-linux@rere.qmqm.pl>,
        Jasper Korten <jja2000@gmail.com>,
        David Heidelberg <david@ixit.cz>,
        Peter Geis <pgwipeout@gmail.com>,
        Nicolas Chauvet <kwizart@gmail.com>
Cc:     linux-pm@vger.kernel.org, linux-tegra@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH v11 16/17] ARM: multi_v7_defconfig: Enable Tegra cpuidle driver
Date:   Tue, 25 Feb 2020 01:40:56 +0300
Message-Id: <20200224224057.21877-17-digetx@gmail.com>
X-Mailer: git-send-email 2.24.0
In-Reply-To: <20200224224057.21877-1-digetx@gmail.com>
References: <20200224224057.21877-1-digetx@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

The Tegra CPU Idle driver was moved out into driver/cpuidle/ directory and
it is now a proper platform driver.

Acked-by: Peter De Schrijver <pdeschrijver@nvidia.com>
Acked-by: Daniel Lezcano <daniel.lezcano@linaro.org>
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

