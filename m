Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D67723C4049
	for <lists+linux-pm@lfdr.de>; Mon, 12 Jul 2021 02:03:54 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231318AbhGLAGl (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Sun, 11 Jul 2021 20:06:41 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54674 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230504AbhGLAGk (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Sun, 11 Jul 2021 20:06:40 -0400
Received: from mail-qk1-x733.google.com (mail-qk1-x733.google.com [IPv6:2607:f8b0:4864:20::733])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7132DC0613DD;
        Sun, 11 Jul 2021 17:03:53 -0700 (PDT)
Received: by mail-qk1-x733.google.com with SMTP id 201so2162783qkj.13;
        Sun, 11 Jul 2021 17:03:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=a0H54VcaSkULvQ0XfRhbooC/ZXW5WM4Ks5Bh/dzSIL8=;
        b=e4tTE5FEkSBBCbpxxhRslLR+2FSeJg8YMnsImNK0Vb6m+wvbITg7MnJXonZnXBbUI8
         WU0Chy8hffriA4Mxca7sOqC/Nb7YMxIaKhqmou3VHd2rso2j3Dhok9m1rKd7cBEfZTA5
         Gnj/eOrtQm/srWOmYlViEMQUVzEY5Ws7KLb6a316TGPj5WEEbmRNEQ0pLBGihwv3A60Z
         YOQRs9UftzToLoZ1ZyChxBAzzRGkWUPzE4XZkk+CseOxRL/ipGW6UXQQ9YvYL8Aa4sx7
         RgNIN4806+p327bw/xw41UU0Y/XBtQVmGrml6jUFrCn9z/kaDyrb87xb0DO835uYDnsI
         Fm9w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=a0H54VcaSkULvQ0XfRhbooC/ZXW5WM4Ks5Bh/dzSIL8=;
        b=PMYY7IE6ZzuqGGQvqQtUrGQPi9UIDEHVmIAsGDsdXvttnvf8zNGNNlVXGssRORLIRk
         Gomsn6SkzN1cYAqBHxFC1gPPE7v5DKwPbAo5aVuT4R36kfZjQa2l3BIYUNDB/Q1l4Bv3
         5dLnt6hgo2lxPLDkn2ArOkZsmaXBLFHP1NrauJ1eolKFvXtbf2zwJz4tRrQQ7shdaSPR
         kDbNP0TQNq3eFySv4XJkyqbhDFvoEIVQaov3icueK4qcyzR/rv9gCgQgqn7EkK8F9EUU
         UbEdafFOGe/3U96WirO5h5IOGln03jOnqu3HxRawcjSgp6WXr3tjpgbZHurrYqqoTcYH
         gKKQ==
X-Gm-Message-State: AOAM530b/ypcVe2ZiPsG4U8bvTME01SFV8W/PPv7FgeHKWI7DM5Nl70W
        FhmjZA/TNeaOVMtYvXmG/qo=
X-Google-Smtp-Source: ABdhPJxByIV3MBJU0iRjyJ3lWh3bHIqYzT937mhcsMmKxM8++/Z3qM4wD0GiITUg/5s1XiLMjTkHLQ==
X-Received: by 2002:a05:620a:16b7:: with SMTP id s23mr27610431qkj.495.1626048232722;
        Sun, 11 Jul 2021 17:03:52 -0700 (PDT)
Received: from localhost.localdomain (94-29-37-113.dynamic.spd-mgts.ru. [94.29.37.113])
        by smtp.gmail.com with ESMTPSA id h10sm4970290qta.74.2021.07.11.17.03.50
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 11 Jul 2021 17:03:52 -0700 (PDT)
From:   Dmitry Osipenko <digetx@gmail.com>
To:     Thierry Reding <thierry.reding@gmail.com>,
        Jonathan Hunter <jonathanh@nvidia.com>,
        "Rafael J. Wysocki" <rjw@rjwysocki.net>,
        Daniel Lezcano <daniel.lezcano@linaro.org>
Cc:     linux-pm@vger.kernel.org, linux-tegra@vger.kernel.org
Subject: [PATCH v2 5/5] cpuidle: tegra: Enable compile testing
Date:   Mon, 12 Jul 2021 03:03:22 +0300
Message-Id: <20210712000322.4224-6-digetx@gmail.com>
X-Mailer: git-send-email 2.32.0
In-Reply-To: <20210712000322.4224-1-digetx@gmail.com>
References: <20210712000322.4224-1-digetx@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

Enable compile testing of tegra-cpuidle driver.

Signed-off-by: Dmitry Osipenko <digetx@gmail.com>
---
 drivers/cpuidle/Kconfig.arm | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/cpuidle/Kconfig.arm b/drivers/cpuidle/Kconfig.arm
index 334f83e56120..599286fc0b08 100644
--- a/drivers/cpuidle/Kconfig.arm
+++ b/drivers/cpuidle/Kconfig.arm
@@ -99,7 +99,7 @@ config ARM_MVEBU_V7_CPUIDLE
 
 config ARM_TEGRA_CPUIDLE
 	bool "CPU Idle Driver for NVIDIA Tegra SoCs"
-	depends on ARCH_TEGRA && !ARM64
+	depends on (ARCH_TEGRA || COMPILE_TEST) && !ARM64 && MMU
 	select ARCH_NEEDS_CPU_IDLE_COUPLED if SMP
 	select ARM_CPU_SUSPEND
 	help
-- 
2.32.0

