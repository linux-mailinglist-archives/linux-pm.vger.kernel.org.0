Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6E94827A192
	for <lists+linux-pm@lfdr.de>; Sun, 27 Sep 2020 17:10:06 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726280AbgI0PKF (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Sun, 27 Sep 2020 11:10:05 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50860 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726196AbgI0PKE (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Sun, 27 Sep 2020 11:10:04 -0400
Received: from mail-wm1-x342.google.com (mail-wm1-x342.google.com [IPv6:2a00:1450:4864:20::342])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 91AF0C0613CE;
        Sun, 27 Sep 2020 08:10:04 -0700 (PDT)
Received: by mail-wm1-x342.google.com with SMTP id e2so4113214wme.1;
        Sun, 27 Sep 2020 08:10:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=IQU/5no96PfQVnDWZvRJxAMbJR8IojKL6s+SB7SMMPA=;
        b=mU8e0vtY9QN5IrHDotz7Fgyf4RdU20rP+QnbHLKsPR7mD5Bp7Naam4oldT6+ebRG64
         9kY1nkqtzMVoL3i7J7M3sE3l4gqVrtKAh0D9qYYXhJNrvPL3S2NrbU+hvG/r2D4D87mS
         wwf6ZW3bKBcec68FnZNb4pRp6qSdCuuK86JlXA2TmD6lq0CzRGzVX5voBpt1R3NfBj09
         cjo5zhdBzO32+Gk4yXdyv212M2D/bLIke6oBpXsUULAYJhQuos9CR9Ptk/YK8oYZdJRx
         Xh51bmNeKV2NMfvELh1rwgrBR/OiQ/oAEkUAFP3xN+AZnsPLxWmx38sQNM6xUwjYPtRg
         02LA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=IQU/5no96PfQVnDWZvRJxAMbJR8IojKL6s+SB7SMMPA=;
        b=SB6StpGvyKdwH8NLAiHgunl+Ffo7QjOujLXayu/WKZ04QxjZtPmRPlHANlZqv7d1yN
         Uh+9qAceo0O6LAOIzkXTh6w63tsRecFvKdBqqwKrdE40of9/uPf5nlZ1GRpRcydxMeOD
         oZdzphy61oY1RsDUSv+/H3g0ld3ZQkewzGMSawSxPl7nF3b74udUyrKqmUaZbmeqM3O3
         ubtUUBSFXft6KA4j6hXkWxfDSkgxRGKGEHPO9T2E21nDA2jZIZy+1bLikv5sPeJz3fzN
         1EEDSaAVoN6heO/tJh2xz895feu7f0nFkQUdueeeTx6CHwMmt3LPaUaCWiNFpunKjFut
         FXpw==
X-Gm-Message-State: AOAM532BZkwoS6Ghq1Hv8VU1pG4Ii8sdkMjAl0k1bUvlczlx0mSinvOH
        mDVx6OrqQVNpwN7UHZ1OMBc=
X-Google-Smtp-Source: ABdhPJyRKBrj4QfpDb+e1kJEIQs4AmQ0NQQRZXPqEl6jo4XI0Gfuk7IK8exT/uG7zrS5lYWQ5ORuPw==
X-Received: by 2002:a05:600c:21c4:: with SMTP id x4mr7446993wmj.107.1601219403352;
        Sun, 27 Sep 2020 08:10:03 -0700 (PDT)
Received: from arrakis.kwizart.net (lfbn-nic-1-212-171.w2-15.abo.wanadoo.fr. [2.15.59.171])
        by smtp.gmail.com with ESMTPSA id s11sm9565114wrt.43.2020.09.27.08.10.02
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 27 Sep 2020 08:10:02 -0700 (PDT)
From:   Nicolas Chauvet <kwizart@gmail.com>
To:     Thierry Reding <thierry.reding@gmail.com>,
        Jonathan Hunter <jonathanh@nvidia.com>,
        Zhang Rui <rui.zhang@intel.com>,
        Daniel Lezcano <daniel.lezcano@linaro.org>
Cc:     linux-tegra@vger.kernel.org, linux-pm@vger.kernel.org,
        Nicolas Chauvet <kwizart@gmail.com>
Subject: [PATCH v2 2/6] ARM: tegra: Add missing hot temperatures to tegra124 thermal-zones
Date:   Sun, 27 Sep 2020 17:09:52 +0200
Message-Id: <20200927150956.34609-3-kwizart@gmail.com>
X-Mailer: git-send-email 2.25.4
In-Reply-To: <20200927150956.34609-1-kwizart@gmail.com>
References: <20200927150956.34609-1-kwizart@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

According to dmesg, thermal-zones for mem and cpu are missing hot
temperatures properties.

  throttrip: pll: missing hot temperature
...
  throttrip: mem: missing hot temperature
...

Adding them will clear the messages.

Signed-off-by: Nicolas Chauvet <kwizart@gmail.com>
---
 arch/arm/boot/dts/tegra124.dtsi | 10 ++++++++++
 1 file changed, 10 insertions(+)

diff --git a/arch/arm/boot/dts/tegra124.dtsi b/arch/arm/boot/dts/tegra124.dtsi
index a0fa5821a232..c71d597ace01 100644
--- a/arch/arm/boot/dts/tegra124.dtsi
+++ b/arch/arm/boot/dts/tegra124.dtsi
@@ -1248,6 +1248,11 @@ mem-shutdown-trip {
 					hysteresis = <0>;
 					type = "critical";
 				};
+				mem-throttle-trip {
+					temperature = <99000>;
+					hysteresis = <1000>;
+					type = "hot";
+				};
 			};
 
 			cooling-maps {
@@ -1299,6 +1304,11 @@ pllx-shutdown-trip {
 					hysteresis = <0>;
 					type = "critical";
 				};
+				pllx-throttle-trip {
+					temperature = <99000>;
+					hysteresis = <1000>;
+					type = "hot";
+				};
 			};
 
 			cooling-maps {
-- 
2.25.4

