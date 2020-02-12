Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 3035F15B56F
	for <lists+linux-pm@lfdr.de>; Thu, 13 Feb 2020 00:53:33 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729191AbgBLXwL (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Wed, 12 Feb 2020 18:52:11 -0500
Received: from mail-lj1-f196.google.com ([209.85.208.196]:45663 "EHLO
        mail-lj1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727117AbgBLXwL (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Wed, 12 Feb 2020 18:52:11 -0500
Received: by mail-lj1-f196.google.com with SMTP id e18so4398025ljn.12;
        Wed, 12 Feb 2020 15:52:10 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=13G8hNN0tC2CwPlls56+zPP5L9QWYzcTMZQk8uGliWE=;
        b=NFInwqsjGHp4OgV0pxGebl9xn8pqGQaFKbu6Ov8C7G/JJSNDxWM23L63V2iDsUrMa9
         FYVDGOaprvRoIVf3hy74WBNPfMuFSeN5psFl8IXlcrDg+MrSKyYAMCyA4GvsxuQx1AS5
         tHbsY9FmH5qKfftu3I+fHOs85Dzi9kHcQ2nbG4CbGGQLyoBgFqsC6wkTur3sxCkSlPAH
         kGruzIovVHvElgPXNOHurqfExaS7eaCuxw2rFGzoWEt1yk9wcd/vqU26tdkHJgdvrnM0
         Y6CQcngnQSiZViKA3fLwog4CyhvTMMPw0Z07k85EWRFLL1jCOp5Zl2w7Hqdcr5J3JAI/
         YnDA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=13G8hNN0tC2CwPlls56+zPP5L9QWYzcTMZQk8uGliWE=;
        b=V9bFyJgAc4z3BZN3etxmwmMYezqK8xtLZmB/uLmh8Qvib0h7wyJNEIgEbuqvb1T+VN
         oZ6UtT7ep+kcMJJMDQjCJaplSOqFA+BWd2cFAYt+nHmmr6tMTUg95J1liK371/i0sRB1
         jfkdy8MM2gUetpLwRmUr8sd3TGSbA9+x/0GN17UZ6nO7OSVNjrHRe28+NjKQzUpsoCw9
         otFDgILQLGIKHbAnp+IcY1t7WoRCHUMbr0tVWDnKu/Lbrq2H+QM4pNI/HifNugl3kxKR
         RxZAt1RrI4w95fLwihrBJeGYVvGr20/yY743DJuGXw6gvliYV0/wOxiOBive/9muEcuE
         Wcrw==
X-Gm-Message-State: APjAAAUDuAtqIwZ48SePl+HLBak0Wo+vIE+Lml0VhXDfBcAytRTrzECM
        Tdtq6qPcUcfoc7znhFkLSJo=
X-Google-Smtp-Source: APXvYqzMoCOJFO+B7bqE9Dmm4OFN9YAoRIZXxS9vko12q48mVcCoK0M/3v2VH+zm4ni11bzgzYhHDw==
X-Received: by 2002:a2e:8152:: with SMTP id t18mr9304064ljg.255.1581551529587;
        Wed, 12 Feb 2020 15:52:09 -0800 (PST)
Received: from localhost.localdomain (79-139-233-37.dynamic.spd-mgts.ru. [79.139.233.37])
        by smtp.gmail.com with ESMTPSA id d5sm251686lfb.20.2020.02.12.15.52.08
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 12 Feb 2020 15:52:09 -0800 (PST)
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
Subject: [PATCH v9 01/17] ARM: tegra: Compile sleep-tegra20/30.S unconditionally
Date:   Thu, 13 Feb 2020 02:51:18 +0300
Message-Id: <20200212235134.12638-2-digetx@gmail.com>
X-Mailer: git-send-email 2.24.0
In-Reply-To: <20200212235134.12638-1-digetx@gmail.com>
References: <20200212235134.12638-1-digetx@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

The sleep-tegra*.S provides functionality required for suspend/resume
and CPU hotplugging. The new unified CPUIDLE driver will support multiple
hardware generations starting from Terga20 and ending with Tegra124, the
driver will utilize functions that are provided by the assembly and thus
it is cleaner to compile that code without any build-dependencies in order
to avoid churning with #ifdef's.

Acked-by: Peter De Schrijver <pdeschrijver@nvidia.com>
Tested-by: Peter Geis <pgwipeout@gmail.com>
Tested-by: Jasper Korten <jja2000@gmail.com>
Tested-by: David Heidelberg <david@ixit.cz>
Signed-off-by: Dmitry Osipenko <digetx@gmail.com>
---
 arch/arm/mach-tegra/Makefile | 6 ++----
 arch/arm/mach-tegra/sleep.h  | 2 --
 2 files changed, 2 insertions(+), 6 deletions(-)

diff --git a/arch/arm/mach-tegra/Makefile b/arch/arm/mach-tegra/Makefile
index 6c1dff2eccc2..965862608ff6 100644
--- a/arch/arm/mach-tegra/Makefile
+++ b/arch/arm/mach-tegra/Makefile
@@ -8,13 +8,13 @@ obj-y					+= reset.o
 obj-y					+= reset-handler.o
 obj-y					+= sleep.o
 obj-y					+= tegra.o
+obj-y					+= sleep-tegra20.o
+obj-y					+= sleep-tegra30.o
 obj-$(CONFIG_CPU_IDLE)			+= cpuidle.o
-obj-$(CONFIG_ARCH_TEGRA_2x_SOC)		+= sleep-tegra20.o
 obj-$(CONFIG_ARCH_TEGRA_2x_SOC)		+= pm-tegra20.o
 ifeq ($(CONFIG_CPU_IDLE),y)
 obj-$(CONFIG_ARCH_TEGRA_2x_SOC)		+= cpuidle-tegra20.o
 endif
-obj-$(CONFIG_ARCH_TEGRA_3x_SOC)		+= sleep-tegra30.o
 obj-$(CONFIG_ARCH_TEGRA_3x_SOC)		+= pm-tegra30.o
 ifeq ($(CONFIG_CPU_IDLE),y)
 obj-$(CONFIG_ARCH_TEGRA_3x_SOC)		+= cpuidle-tegra30.o
@@ -22,12 +22,10 @@ endif
 obj-$(CONFIG_SMP)			+= platsmp.o
 obj-$(CONFIG_HOTPLUG_CPU)               += hotplug.o
 
-obj-$(CONFIG_ARCH_TEGRA_114_SOC)	+= sleep-tegra30.o
 obj-$(CONFIG_ARCH_TEGRA_114_SOC)	+= pm-tegra30.o
 ifeq ($(CONFIG_CPU_IDLE),y)
 obj-$(CONFIG_ARCH_TEGRA_114_SOC)	+= cpuidle-tegra114.o
 endif
-obj-$(CONFIG_ARCH_TEGRA_124_SOC)	+= sleep-tegra30.o
 obj-$(CONFIG_ARCH_TEGRA_124_SOC)	+= pm-tegra30.o
 ifeq ($(CONFIG_CPU_IDLE),y)
 obj-$(CONFIG_ARCH_TEGRA_124_SOC)	+= cpuidle-tegra114.o
diff --git a/arch/arm/mach-tegra/sleep.h b/arch/arm/mach-tegra/sleep.h
index 78ef32a907c8..63e2205cbc82 100644
--- a/arch/arm/mach-tegra/sleep.h
+++ b/arch/arm/mach-tegra/sleep.h
@@ -120,10 +120,8 @@ void tegra_resume(void);
 int tegra_sleep_cpu_finish(unsigned long);
 void tegra_disable_clean_inv_dcache(u32 flag);
 
-#ifdef CONFIG_HOTPLUG_CPU
 void tegra20_hotplug_shutdown(void);
 void tegra30_hotplug_shutdown(void);
-#endif
 
 void tegra20_cpu_shutdown(int cpu);
 int tegra20_cpu_is_resettable_soon(void);
-- 
2.24.0

