Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6EE68394D79
	for <lists+linux-pm@lfdr.de>; Sat, 29 May 2021 19:10:54 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229881AbhE2RM0 (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Sat, 29 May 2021 13:12:26 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42858 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229851AbhE2RMX (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Sat, 29 May 2021 13:12:23 -0400
Received: from mail-lf1-x136.google.com (mail-lf1-x136.google.com [IPv6:2a00:1450:4864:20::136])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9C33FC061574;
        Sat, 29 May 2021 10:10:45 -0700 (PDT)
Received: by mail-lf1-x136.google.com with SMTP id f30so10130287lfj.1;
        Sat, 29 May 2021 10:10:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=uG0wF9x5J31B5QovgpxzHE3VxGkFw0gZRlBKzlTkO48=;
        b=YNpD36hsPQ45qUtw8B28Q9nG9ZzBBjoeBj5/0zS6S9J+LiA4+6Qdh4dYVss7GfIGkt
         74iJBtqxqzgCIGq1/7riA7MkLShiUGI8hBsQLGeQp6L3uauf8TtdGgLGsP1twXQf2sac
         TMu9OW4wm7onG4Zfo0HJmXRZl+cFRX0dIYxxmcIVk9M/N+lQDVuASZ+Wn61G81McwJGc
         LnjilsCskV4NofFzaKPblkcdNDuIfAjesRYaeaN/Lb4SUm9ZAU7+feUK19WDBA6ix0Vi
         MIotrfcDPW3GiF3oIkPLn7pnxt78mG7ZEnDicDFlKjvklpZsNRVdL8k8YH8tSsTfk90F
         Fz/g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=uG0wF9x5J31B5QovgpxzHE3VxGkFw0gZRlBKzlTkO48=;
        b=Xqmv/o9ovlPgLwD0KEImh+D0ZST+0AE2+vghc/v97xE2WdB/ydM6Otmqz6qJ12eU1N
         hWlTRHkGL3JZDKmsZhplva9PmoT/AxHiH2kF3JGrD4IEcT0G3MG3VE2tHlSWaCSuP9Vz
         l7PLUDm6FPU+7j0UeNbc0z42fFNEOfAhtgqIEh11rL98EHuVk+Z64cUnh4hEktx21Em+
         Cnlbb44UqLXgIH/guPP+Ks30VFQSP9ueUPUJGB0MsYaT1Zaz/lOm+c0kJ7GNwpttxcXO
         UzG1i4VHZ61GZSliT+ZbROGc8kAVjojK6ciSRYTMqAdzvdlv5Y3nw40pulT1nv91gqrr
         dNAQ==
X-Gm-Message-State: AOAM532CwEsPVuoXOHNxeiAjt30dOJqctj8LHOSNSIejCRUUW0R5/SiX
        V/9ZnSdq+T4jeQEsP6BkYRDyvMpn5yc=
X-Google-Smtp-Source: ABdhPJy6gHfOnZuQmJd7NMeqZJaT8AyHCBdb2KRGRIy4gpCNNP1NevOiAgYPasZ3Bf7LwFV8OmgJ+Q==
X-Received: by 2002:a05:6512:308a:: with SMTP id z10mr9363913lfd.601.1622308244024;
        Sat, 29 May 2021 10:10:44 -0700 (PDT)
Received: from localhost.localdomain (46-138-84-89.dynamic.spd-mgts.ru. [46.138.84.89])
        by smtp.gmail.com with ESMTPSA id h12sm901715ljh.130.2021.05.29.10.10.43
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 29 May 2021 10:10:43 -0700 (PDT)
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
Cc:     devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-tegra@vger.kernel.org, linux-pm@vger.kernel.org
Subject: [PATCH v3 6/7] ARM: multi_v7_defconfig: Enable CONFIG_TEGRA30_TSENSOR
Date:   Sat, 29 May 2021 20:09:54 +0300
Message-Id: <20210529170955.32574-7-digetx@gmail.com>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20210529170955.32574-1-digetx@gmail.com>
References: <20210529170955.32574-1-digetx@gmail.com>
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

