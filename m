Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 94EF1C18DB
	for <lists+linux-pm@lfdr.de>; Sun, 29 Sep 2019 20:01:28 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728995AbfI2SBB (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Sun, 29 Sep 2019 14:01:01 -0400
Received: from mail-lj1-f194.google.com ([209.85.208.194]:37757 "EHLO
        mail-lj1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729204AbfI2SAO (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Sun, 29 Sep 2019 14:00:14 -0400
Received: by mail-lj1-f194.google.com with SMTP id l21so7104523lje.4;
        Sun, 29 Sep 2019 11:00:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=QTe520CmQimwT2xQ5E8nuav6QtZ6H2RpuHeGJzEXlUU=;
        b=rVkS1bYq7yTo5Wid5Q7+gJrdUik9pzwimLaTHB5lcZlF+eUDw7FRwmbJiGLZHcENO/
         bDewtVS21qX7a346iZHlce2bdxQy3XxSo1XgHlKBHJfZpytRG5aAx6Z62NVtgW6pJHFX
         gmQR5bDn4FOkupXzZ41EyPOJHhynsqhxsCPi/Pu9R7K527TLe7cnYycmMXju9TrW82O1
         ev7GFPqNC2VmO3mwjCH4Vv1sBFRQl1feJ6tZQR1+nJU2w32+A6JT/HR4AyRk1NFHBfH+
         IJDp4LmO7uaZrXtAjVnKChCGRqKcIUpEzsixCOHy+yKi0ebRwyKXi+pO12tegUwc7Kaj
         qcxg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=QTe520CmQimwT2xQ5E8nuav6QtZ6H2RpuHeGJzEXlUU=;
        b=PB0diX8YHbAvTyhQlSBRfth237mcn5+/Vf3y5P0l2PYgqxJ10bR7Ep9bWiQCk/o51k
         TPb9cbu7yVRkTeoU8Obqz5xftIXjS6wQlWfYxLnaW/2UfsjniLnCdzN21cjLi8zz9H6P
         zu8/L4kKW/LQrPnvpwJ2vkCdg+qdzbDjtBgmYUiQH4EtdMndL0x9w2z2mbtGJQLX1uBA
         A0yzMuu1WMjUmWPbXN2mqU/VCi3NVMimLI2fce/wkBuX2yNhW1f9C9ksPdfnUNMhwaX8
         SvhmJS3seZrkCVd/YYqFralH93gT/oAAB/cN6ycqGUw7uLnlU63rbvtaMWMqsDkZ/sGv
         Vu3A==
X-Gm-Message-State: APjAAAVbFKXtUChV0lvymJaOzf8pX1AmGUAB12jutxELg3URbE6f5jDo
        +45ZeneM8nGj1bLNcWXPNSE=
X-Google-Smtp-Source: APXvYqywmKThcID9Y4bQDnpwwINY5zGv1U0D25LkbKaYwBszzmAuZ2kNcnAhInBPPy+nRhLXFMYnRw==
X-Received: by 2002:a2e:85d2:: with SMTP id h18mr8911567ljj.18.1569780011874;
        Sun, 29 Sep 2019 11:00:11 -0700 (PDT)
Received: from localhost.localdomain (ppp94-29-32-67.pppoe.spdop.ru. [94.29.32.67])
        by smtp.gmail.com with ESMTPSA id y3sm2355511lfh.97.2019.09.29.11.00.11
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 29 Sep 2019 11:00:11 -0700 (PDT)
From:   Dmitry Osipenko <digetx@gmail.com>
To:     Thierry Reding <thierry.reding@gmail.com>,
        Jonathan Hunter <jonathanh@nvidia.com>,
        Peter De Schrijver <pdeschrijver@nvidia.com>,
        "Rafael J. Wysocki" <rjw@rjwysocki.net>,
        Daniel Lezcano <daniel.lezcano@linaro.org>
Cc:     linux-pm@vger.kernel.org, linux-tegra@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH v5 04/14] ARM: tegra: Compile sleep-tegra20/30.S unconditionally
Date:   Sun, 29 Sep 2019 20:59:42 +0300
Message-Id: <20190929175952.22690-5-digetx@gmail.com>
X-Mailer: git-send-email 2.23.0
In-Reply-To: <20190929175952.22690-1-digetx@gmail.com>
References: <20190929175952.22690-1-digetx@gmail.com>
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
 arch/arm/mach-tegra/Makefile | 10 ++++------
 arch/arm/mach-tegra/sleep.h  |  2 --
 2 files changed, 4 insertions(+), 8 deletions(-)

diff --git a/arch/arm/mach-tegra/Makefile b/arch/arm/mach-tegra/Makefile
index 5d93a0b36866..3bb44246d928 100644
--- a/arch/arm/mach-tegra/Makefile
+++ b/arch/arm/mach-tegra/Makefile
@@ -8,16 +8,14 @@ obj-y					+= reset.o
 obj-y					+= reset-handler.o
 obj-y					+= sleep.o
 obj-y					+= tegra.o
-obj-$(CONFIG_ARCH_TEGRA_2x_SOC)		+= sleep-tegra20.o
-obj-$(CONFIG_ARCH_TEGRA_2x_SOC)		+= pm-tegra20.o
-obj-$(CONFIG_ARCH_TEGRA_3x_SOC)		+= sleep-tegra30.o
-obj-$(CONFIG_ARCH_TEGRA_3x_SOC)		+= pm-tegra30.o
+obj-y					+= sleep-tegra20.o
+obj-y					+= sleep-tegra30.o
 obj-$(CONFIG_SMP)			+= platsmp.o
 obj-$(CONFIG_HOTPLUG_CPU)               += hotplug.o
 
-obj-$(CONFIG_ARCH_TEGRA_114_SOC)	+= sleep-tegra30.o
+obj-$(CONFIG_ARCH_TEGRA_2x_SOC)		+= pm-tegra20.o
+obj-$(CONFIG_ARCH_TEGRA_3x_SOC)		+= pm-tegra30.o
 obj-$(CONFIG_ARCH_TEGRA_114_SOC)	+= pm-tegra30.o
-obj-$(CONFIG_ARCH_TEGRA_124_SOC)	+= sleep-tegra30.o
 obj-$(CONFIG_ARCH_TEGRA_124_SOC)	+= pm-tegra30.o
 
 obj-$(CONFIG_ARCH_TEGRA_2x_SOC)		+= board-paz00.o
diff --git a/arch/arm/mach-tegra/sleep.h b/arch/arm/mach-tegra/sleep.h
index d219872b7546..4978def9db46 100644
--- a/arch/arm/mach-tegra/sleep.h
+++ b/arch/arm/mach-tegra/sleep.h
@@ -118,10 +118,8 @@ void tegra_resume(void);
 int tegra_sleep_cpu_finish(unsigned long);
 void tegra_disable_clean_inv_dcache(u32 flag);
 
-#ifdef CONFIG_HOTPLUG_CPU
 void tegra20_hotplug_shutdown(void);
 void tegra30_hotplug_shutdown(void);
-#endif
 
 void tegra20_tear_down_cpu(void);
 int tegra30_sleep_cpu_secondary_finish(unsigned long);
-- 
2.23.0

