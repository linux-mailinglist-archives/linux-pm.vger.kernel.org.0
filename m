Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 5E63210F3F7
	for <lists+linux-pm@lfdr.de>; Tue,  3 Dec 2019 01:42:04 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726330AbfLCAmD (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Mon, 2 Dec 2019 19:42:03 -0500
Received: from mail-lj1-f195.google.com ([209.85.208.195]:44266 "EHLO
        mail-lj1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726318AbfLCAmD (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Mon, 2 Dec 2019 19:42:03 -0500
Received: by mail-lj1-f195.google.com with SMTP id c19so1630060lji.11;
        Mon, 02 Dec 2019 16:42:01 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=RXuTZNw4YluF0xsaWYam3YpLe0yLbc8vBZ1dGFmmgz4=;
        b=sUKJcS63tb1/bE2B19Z+utIpq8bnEg+Gv14tzsoDn0iZxdIwWa84H1iUfSvXrk1jAx
         DDab6Omdsv2fQedGajfAymBRLGm8jzauyBWbVtGai9BUe4Eiad9zjHwG5LIjxo9ChRFF
         OG7XH6y0Ha8Cfv2JfoitJNIJ6z7AKTzVKoyonLulHbAE+kbU2THnBEWFg6+8bX0qpNQA
         yy513flUCYmupIqgpsA/oZEe1rkonzPcdO/ipU1aPZ8DLQYigOhqcCI9wsWI+yhXXwG8
         nCmbKPfs7dW1RryL58rQWF6JSNjWchFOnnMYHrqUVqT5/LUnajPwaqidI4ejjfbV3uIh
         VXHQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=RXuTZNw4YluF0xsaWYam3YpLe0yLbc8vBZ1dGFmmgz4=;
        b=SC329KVMU252SLiJJebkvoAeRq66qJGLX8a3AYNDTFQ4CBktK2stXRs9RkiF1Kdafs
         WxthUm96hrkk6J2BlvBl1FQszGdNknVsqjvPDH3EPjuWBW2By1NKgF4MbY3rk0664PZp
         Iq0+XqhJvqwbeL0gyHcgtll2RKVTzk/uFnz8lTY2UfqXW7OL7QPyn4iu1aob9sysdzZ1
         5qT7xcb1AtpNulsPypyx3TktVyvPOSYxZdGmTGk6wqYMhSqzhPRNUeqCuG7MhJfms2Te
         VaLXTZjupcgBvAWXtbLdL7m973wG1p1Zdl6oMICFNVUqvNBi7Wvmuiraxa2ikS1DoDwd
         8D0A==
X-Gm-Message-State: APjAAAWwxGbY7hNowCf4XUC/T/z0rg9UTrqITm+6ffP0AFR6hnnqEcYe
        EokAsOaanrXuLQBugY2WmSE=
X-Google-Smtp-Source: APXvYqyDdCe4cvfThpvsaPkZ+owpBUCZfAhEmQKBt9kVsfCXwF8+pPhTggQwhNStfNVqxDE5Hip0vg==
X-Received: by 2002:a2e:95c4:: with SMTP id y4mr908302ljh.38.1575333720872;
        Mon, 02 Dec 2019 16:42:00 -0800 (PST)
Received: from localhost.localdomain (79-139-233-37.dynamic.spd-mgts.ru. [79.139.233.37])
        by smtp.gmail.com with ESMTPSA id y21sm456384ljm.25.2019.12.02.16.41.59
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 02 Dec 2019 16:42:00 -0800 (PST)
From:   Dmitry Osipenko <digetx@gmail.com>
To:     Thierry Reding <thierry.reding@gmail.com>,
        Jonathan Hunter <jonathanh@nvidia.com>,
        Peter De Schrijver <pdeschrijver@nvidia.com>,
        "Rafael J. Wysocki" <rjw@rjwysocki.net>,
        Daniel Lezcano <daniel.lezcano@linaro.org>
Cc:     linux-pm@vger.kernel.org, linux-tegra@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH v8 01/19] ARM: tegra: Compile sleep-tegra20/30.S unconditionally
Date:   Tue,  3 Dec 2019 03:40:58 +0300
Message-Id: <20191203004116.11771-2-digetx@gmail.com>
X-Mailer: git-send-email 2.24.0
In-Reply-To: <20191203004116.11771-1-digetx@gmail.com>
References: <20191203004116.11771-1-digetx@gmail.com>
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

