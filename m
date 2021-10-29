Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4E11744051B
	for <lists+linux-pm@lfdr.de>; Fri, 29 Oct 2021 23:53:00 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231229AbhJ2Vz1 (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Fri, 29 Oct 2021 17:55:27 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33664 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230521AbhJ2Vz0 (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Fri, 29 Oct 2021 17:55:26 -0400
Received: from mail-qt1-x82e.google.com (mail-qt1-x82e.google.com [IPv6:2607:f8b0:4864:20::82e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C363DC061570;
        Fri, 29 Oct 2021 14:52:57 -0700 (PDT)
Received: by mail-qt1-x82e.google.com with SMTP id h4so9865778qth.5;
        Fri, 29 Oct 2021 14:52:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=sender:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=V1UdoqKDsTMGzj57sLAYdTWbd/KAocfHPIazuse7XdQ=;
        b=S3S47+H+iAK4LSyp1CpV0IVNmPUxGpr4JfKLjSwxPKb3D5t9vdLQo39KpDqZSZfgv/
         rQlIPTjW041Z9zHYpYMadmLZzeVYzK/dydVfPbfOrEijfNhtvToL/v1ZolaDBnWGx5jM
         B5rPvOMExJ2d3P8gs0D+LNBz6I9urC3cdYTABdrdbKHx+gm9SiT+xvCJiL1eCrGMD7H5
         u/5MQbIBZA7UhU3ExUj95bo+8wQoE6TAOgd3XcfxceAJlFeCPXXu/8X27fJEtGjfQQe+
         D5mN38M99FEN19yzKeKaltqRrzfUtK+NiTt55C4kXDHMIoAtfVUE5XfUAaZrTGS/Og/M
         FTwA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:sender:from:to:cc:subject:date:message-id
         :mime-version:content-transfer-encoding;
        bh=V1UdoqKDsTMGzj57sLAYdTWbd/KAocfHPIazuse7XdQ=;
        b=qvm0mWgym/aUB+zmvAeHRrJ3f8tCbDb6WM5Gh76kHQWO44e9AbUzIz48elSVkkAgI9
         sOHMAVrqZ6QWJ52+QBzGxxoCRTtQ2nyFnlNRS14fFlY4vkvcXSzSTVimYUNQBC/uztWu
         5sRFyAHWhZYYn9/UryGk6b4ZapczyQ0z36c81ilgj71OzXLgkgCflbnOxoODIrsmFZf7
         Ydr8T+f4PdNLIZ1HUwNZdRVIoQS+0Qyn6Dv0kfilrtkCGnDrnK45W2Y1fXvAYsgT4yex
         PKeyiEl4OSjGX4WTmlDqPrkLtlx+3jisvpkdHkYRyUG86fy7eI90rydDKVmyQ2w4z1rf
         Gp/A==
X-Gm-Message-State: AOAM531iHEtUMV6o8JILEa3CwHivPyG9VeARZ20N/8yhOOrsbIp/Fi/k
        ITiq+ogOqs69YMRh6a4P4HinAoYAVlNLkB1eaok=
X-Google-Smtp-Source: ABdhPJwr8IeC8d9CyxpV9jQ6HCn0WZtsIlg7iPZXIe6EDl/xrsIhxCIm4BnbUq7XrtQLJNscsS6Bmg==
X-Received: by 2002:ac8:5988:: with SMTP id e8mr14679768qte.32.1635544376985;
        Fri, 29 Oct 2021 14:52:56 -0700 (PDT)
Received: from ubuntu-mate-laptop.eecs.ucf.edu ([132.170.15.255])
        by smtp.gmail.com with ESMTPSA id h5sm5253808qtk.30.2021.10.29.14.52.56
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 29 Oct 2021 14:52:56 -0700 (PDT)
Sender: Julian Braha <julian.braha@gmail.com>
From:   Julian Braha <julianbraha@gmail.com>
To:     rafael@kernel.org, daniel.lezcano@linaro.org
Cc:     linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org,
        fazilyildiran@gmail.com
Subject: [PATCH] cpuidle: fix unmet dependencies on ARCH_SUSPEND_POSSIBLE for ARM_CPU_SUSPEND
Date:   Fri, 29 Oct 2021 17:52:56 -0400
Message-Id: <20211029215256.20329-1-julianbraha@gmail.com>
X-Mailer: git-send-email 2.30.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

When ARM_TEGRA_CPUIDLE or ARM_QCOM_SPM_CPUIDLE are selected,
and ARCH_SUSPEND_POSSIBLE is disabled, Kbuild gives the
following warnings:

WARNING: unmet direct dependencies detected for ARM_CPU_SUSPEND
  Depends on [n]: ARCH_SUSPEND_POSSIBLE [=n]
  Selected by [y]:
  - ARM_TEGRA_CPUIDLE [=y] && CPU_IDLE [=y] && (ARM [=y] || ARM64) && (ARCH_TEGRA [=n] || COMPILE_TEST [=y]) && !ARM64 && MMU [=y]

and

WARNING: unmet direct dependencies detected for ARM_CPU_SUSPEND
  Depends on [n]: ARCH_SUSPEND_POSSIBLE [=n]
  Selected by [y]:
  - ARM_QCOM_SPM_CPUIDLE [=y] && CPU_IDLE [=y] && (ARM [=y] || ARM64) && (ARCH_QCOM [=n] || COMPILE_TEST [=y]) && !ARM64 && MMU [=y]

This is because these options enable ARM_CPU_SUSPEND
without selecting or depending on ARCH_SUSPEND_POSSIBLE,
despite ARM_CPU_SUSPEND depending on ARCH_SUSPEND_POSSIBLE.

These unmet dependency bugs were detected by Kismet,
a static analysis tool for Kconfig. Please advise if
this is not the appropriate solution.

Signed-off-by: Julian Braha <julianbraha@gmail.com>
---
 drivers/cpuidle/Kconfig.arm | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/drivers/cpuidle/Kconfig.arm b/drivers/cpuidle/Kconfig.arm
index 15d6c46c0a47..1b4f5ae1ee05 100644
--- a/drivers/cpuidle/Kconfig.arm
+++ b/drivers/cpuidle/Kconfig.arm
@@ -100,6 +100,7 @@ config ARM_MVEBU_V7_CPUIDLE
 config ARM_TEGRA_CPUIDLE
 	bool "CPU Idle Driver for NVIDIA Tegra SoCs"
 	depends on (ARCH_TEGRA || COMPILE_TEST) && !ARM64 && MMU
+	depends on ARCH_SUSPEND_POSSIBLE
 	select ARCH_NEEDS_CPU_IDLE_COUPLED if SMP
 	select ARM_CPU_SUSPEND
 	help
@@ -108,6 +109,7 @@ config ARM_TEGRA_CPUIDLE
 config ARM_QCOM_SPM_CPUIDLE
 	bool "CPU Idle Driver for Qualcomm Subsystem Power Manager (SPM)"
 	depends on (ARCH_QCOM || COMPILE_TEST) && !ARM64 && MMU
+	depends on ARCH_SUSPEND_POSSIBLE
 	select ARM_CPU_SUSPEND
 	select CPU_IDLE_MULTIPLE_DRIVERS
 	select DT_IDLE_STATES
-- 
2.30.2

