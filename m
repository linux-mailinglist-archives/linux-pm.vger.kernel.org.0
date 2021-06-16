Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 20B8E3AA3D1
	for <lists+linux-pm@lfdr.de>; Wed, 16 Jun 2021 21:05:42 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232297AbhFPTHm (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Wed, 16 Jun 2021 15:07:42 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59104 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232283AbhFPTHk (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Wed, 16 Jun 2021 15:07:40 -0400
Received: from mail-lf1-x134.google.com (mail-lf1-x134.google.com [IPv6:2a00:1450:4864:20::134])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1758FC0617A6;
        Wed, 16 Jun 2021 12:05:34 -0700 (PDT)
Received: by mail-lf1-x134.google.com with SMTP id p17so6028379lfc.6;
        Wed, 16 Jun 2021 12:05:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=uG0wF9x5J31B5QovgpxzHE3VxGkFw0gZRlBKzlTkO48=;
        b=bGThFrF/rfr3lNbx8YFa4yk++i0xik8IYr4JabH71d7z+nyjYb3EnbjPsvI9snr5MM
         DDKoU70OwcetVZxmdUUVE9GRYeLhGmBtlH02svuBsQ3Pt6Kou5gwXUb7WMPNTu/kG0u2
         Xvkh3zRKTYNS/9OsSmh4KoMopecPTRQe4LG1cSzy3iiHPFrj6g/gRFR3swzus09vDeBz
         txhhHPAZFGPpCHw4Fq6t5u+5TlqQ5tbOfjjPQgc5LvgBLbu7uCJ7WBedhIpuP/vMa0GL
         +fsxoexLvJ24f78G+CQeYMYaEikN0aOSJHwAv6wgzBFGiPEJpmWsDdhJhIniw4xHZFdX
         14mA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=uG0wF9x5J31B5QovgpxzHE3VxGkFw0gZRlBKzlTkO48=;
        b=b0MalmAt2XZlsKXopCKGRH/kiUOaBd4owgKlEj/XmZl8l8+i6VJ0GXeGW8zGplBDtI
         4dQWefcyVSjAeKqaDOW/0kj/5t7YlUnzFmGAuxuEqMmmBA/Rir58T18TgN9rR1f+wcIa
         6WWB0HJ+d+/34MzTfxPgyHvoG1bZZlQJTYtWJvW9tazQyojZEGlEZrS5YGVB1MKl0wiP
         bp7dZlUhT3zOmOTJxjBvnRZytF4qlANH0MggYziefPiV6FOi5vixGmbuJfm0ISS5pWjM
         i3XvG6vqjIckmaX/qHU+5VZ/AMBoWcgL+zF2pXwA3bRDussVso/lpiq1RNLX+62/xg2e
         R1UQ==
X-Gm-Message-State: AOAM530Lg0pNeGfMmEmGttYTQYltnBC4P38+4Ev5M+7VmV2ZhHMA5Nw0
        BU16YVsciF/pELfopIicGKc=
X-Google-Smtp-Source: ABdhPJypYSOUT59FUV6/4CyE34l4ekEnDqwaMiZuHr0/U9lB0u4GSZ/JlZSGevGXxK3Rr3uAbaL6Hg==
X-Received: by 2002:ac2:43b9:: with SMTP id t25mr862223lfl.253.1623870332500;
        Wed, 16 Jun 2021 12:05:32 -0700 (PDT)
Received: from localhost.localdomain (94-29-29-31.dynamic.spd-mgts.ru. [94.29.29.31])
        by smtp.gmail.com with ESMTPSA id e20sm365951ljk.67.2021.06.16.12.05.31
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 16 Jun 2021 12:05:32 -0700 (PDT)
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
Subject: [PATCH v4 5/6] ARM: multi_v7_defconfig: Enable CONFIG_TEGRA30_TSENSOR
Date:   Wed, 16 Jun 2021 22:04:16 +0300
Message-Id: <20210616190417.32214-6-digetx@gmail.com>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20210616190417.32214-1-digetx@gmail.com>
References: <20210616190417.32214-1-digetx@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

Enable NVIDIA Tegra30 SoC thermal sensor driver in multi_v7_defconfig.

Signed-off-by: Dmitry Osipenko <digetx@gmail.com>
---
 arch/arm/configs/multi_v7_defconfig | 1 +
 1 file changed, 1 insertion(+)

diff --git a/arch/arm/configs/multi_v7_defconfig b/arch/arm/configs/multi_v7_defconfig
index 52a0400fdd92..fc346f87d7f9 100644
--- a/arch/arm/configs/multi_v7_defconfig
+++ b/arch/arm/configs/multi_v7_defconfig
@@ -523,6 +523,7 @@ CONFIG_BRCMSTB_THERMAL=m
 CONFIG_GENERIC_ADC_THERMAL=m
 CONFIG_ST_THERMAL_MEMMAP=y
 CONFIG_TEGRA_SOCTHERM=m
+CONFIG_TEGRA30_TSENSOR=m
 CONFIG_UNIPHIER_THERMAL=y
 CONFIG_DA9063_WATCHDOG=m
 CONFIG_XILINX_WATCHDOG=y
-- 
2.30.2

