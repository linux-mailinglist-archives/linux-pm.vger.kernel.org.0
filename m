Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id CF79D125416
	for <lists+linux-pm@lfdr.de>; Wed, 18 Dec 2019 22:06:45 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726546AbfLRVGk (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Wed, 18 Dec 2019 16:06:40 -0500
Received: from mail-lj1-f196.google.com ([209.85.208.196]:42880 "EHLO
        mail-lj1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725985AbfLRVGk (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Wed, 18 Dec 2019 16:06:40 -0500
Received: by mail-lj1-f196.google.com with SMTP id e28so3713253ljo.9;
        Wed, 18 Dec 2019 13:06:38 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=mWavUsy63Myr06DtRlRJItAe45X9tnU2gUPobdy7CAw=;
        b=M3ntVZ9XGM1zxPHS3li8mquGBrVGyz5/ykokRkrzXKTGG0gwG5h/03CLp3eLe2J4Uo
         mY02+/gtuOOVXDwuqPvKJLvRgRmRxis0sMf1iB7PY8m+zdB5XK+YCO/YYY9eIf9GBA1s
         AG8yi9WY4BM3+a2j/FjkLEE2WKdKr+SVExM1KJbclr8m2rhYafZrtOout8tT7QQlAN5W
         iywQkdoewV1F0myCzlTqvm7dcHdzeFarKFeX+us7QW2kQekrWWbnjE81InVxTyyq3Cna
         7JD8lcQwgeQS5a2+6xbeiaIH9LJg2rU8DX1Z7TGTXf4LWeFsSlycSUr4X7DsUnaiWYQE
         Mh/g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=mWavUsy63Myr06DtRlRJItAe45X9tnU2gUPobdy7CAw=;
        b=AoatmZBwHwbGGUqnOUWfUJNY0IQ77OEzDOQUGqzfaY90WDUbF5VudM2nVOz9N5dBa+
         wow/G6r/K65fPsRtIxtgP0iaVc3uFQh63THqfrjR+p3xSnESsXHv9e2nw9voW6DVba7b
         0E0gn3l3WUbUml7mvOp4sIWFubdqtUw6Z6di5QqPYl7B+mnR5RZ1vKBhbnUlTRMysExp
         l7bh04OElUY3nxBGTnlZo/2kBuh8J/0q79peRx2CBdMyPnkHtiXJwPAXK+QYniKSAYwW
         ZWRDO610nqgGrbH5ZutiMwyo6O0t2D3vRAxYa6xsygtR51gY5O7dKmyUc7bktUqBnsFY
         Qi1A==
X-Gm-Message-State: APjAAAVxtbXgOv/RB4tyElFC8gjHtFiC/sN2pJbyQggt85Ia8tARrf2I
        959IOd+61oG1gJvwBhIzby8=
X-Google-Smtp-Source: APXvYqxHwjRHmn9QXzTwE2jGlguasAidzGuMvDBOK/tCwzmx+wemk0pqgHqheskVVRzGREC6bYFzmw==
X-Received: by 2002:a05:651c:111c:: with SMTP id d28mr3421894ljo.32.1576703198031;
        Wed, 18 Dec 2019 13:06:38 -0800 (PST)
Received: from localhost.localdomain (79-139-233-37.dynamic.spd-mgts.ru. [79.139.233.37])
        by smtp.gmail.com with ESMTPSA id r15sm1754648ljk.3.2019.12.18.13.06.31
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 18 Dec 2019 13:06:37 -0800 (PST)
From:   Dmitry Osipenko <digetx@gmail.com>
To:     Thierry Reding <thierry.reding@gmail.com>,
        Jonathan Hunter <jonathanh@nvidia.com>,
        Peter De Schrijver <pdeschrijver@nvidia.com>,
        "Rafael J. Wysocki" <rjw@rjwysocki.net>,
        Daniel Lezcano <daniel.lezcano@linaro.org>,
        =?UTF-8?q?Micha=C5=82=20Miros=C5=82aw?= <mirq-linux@rere.qmqm.pl>
Cc:     linux-pm@vger.kernel.org, linux-tegra@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH v9 01/17] ARM: tegra: Compile sleep-tegra20/30.S unconditionally
Date:   Thu, 19 Dec 2019 00:04:47 +0300
Message-Id: <20191218210503.6689-2-digetx@gmail.com>
X-Mailer: git-send-email 2.24.0
In-Reply-To: <20191218210503.6689-1-digetx@gmail.com>
References: <20191218210503.6689-1-digetx@gmail.com>
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

