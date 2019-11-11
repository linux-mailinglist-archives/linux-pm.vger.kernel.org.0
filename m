Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 2E0F2F821E
	for <lists+linux-pm@lfdr.de>; Mon, 11 Nov 2019 22:17:44 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727104AbfKKVQ2 (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Mon, 11 Nov 2019 16:16:28 -0500
Received: from mail-lj1-f193.google.com ([209.85.208.193]:37894 "EHLO
        mail-lj1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726916AbfKKVQ2 (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Mon, 11 Nov 2019 16:16:28 -0500
Received: by mail-lj1-f193.google.com with SMTP id v8so15363391ljh.5;
        Mon, 11 Nov 2019 13:16:26 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=AJsM8Od2cQbwnjMd2WWbJxd1SHRmM5N6fXuOeZ21tBs=;
        b=PAD7MzK8qKyr/5DC1SX/bWu/6WPrOGRzHIzAHpN07byU/XavHfOH4nsVQk/6vuiF+e
         On28owfl73Vqmo4QMyuZYf+GjDk9D4HAeh81+nAWNxHgEqyjWB9l/XI/Kv0dYjnr1QGp
         KLUhuzvn0iPFZGhha2t/ausahpwtuWpnb+yIy5iHdc1CqGd3DANRu3bgHNZ1vdzYOHSB
         Kv/S3RZxnTAPmQKufQMNY7uokJ8Yh0g90t6s5Nu434MQYjDE49vmULjjLB9m2G6HoNoH
         d3ETC488CIixKb2WmX/1RLoqVfMuGba8rOnsIlkoaEt1QmZTYT5ifLZ88RGrTvg3+PxJ
         NJTw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=AJsM8Od2cQbwnjMd2WWbJxd1SHRmM5N6fXuOeZ21tBs=;
        b=ZHtmQtXCTS93yEwLgSdh6WOTPjHbzN5LP3QEgWSJserZpzzuGxUk/P9NHR+XmsJtAA
         +Bp3L7bdm+3PB/WFX/cald+Zq7AyyJu7pctOWUbavE3KChvWNw959O/iz/pCqtzYlAGj
         inWoJzYZluBKIISi1OimNFFSHSnihBJ3rZeWACSy5h2r2FmKxpeLzfZRDyR09t8GRj5r
         +8g0uz3gg9wSY3+dvSqfYJriO42FMaUBLB3JZPwnjN/xR5acKEinpuP4cFkZWHayMeYj
         r4e5fHH2Vpe9m4peYOcky+xE8A2bZemHE9dfxbbyzYnDAJF1th54J42dc0O+t9z4qK+5
         SOZA==
X-Gm-Message-State: APjAAAW0W3ui8PElSB/YjikFWA41IqhYO+T+m5mXmS1at6XqfAM5U/ed
        9G28PzoqnlgEnxEhRhzqFcY=
X-Google-Smtp-Source: APXvYqxHIMp2EWsXJvYmtynLMilk1ROjHzfYLjWofW1N6f5khsq4Mo5Y//7UjiyFJz3JUngdHp90EQ==
X-Received: by 2002:a2e:b5c4:: with SMTP id g4mr11731518ljn.169.1573506985570;
        Mon, 11 Nov 2019 13:16:25 -0800 (PST)
Received: from localhost.localdomain (94-29-10-250.dynamic.spd-mgts.ru. [94.29.10.250])
        by smtp.gmail.com with ESMTPSA id n19sm7913150lfl.85.2019.11.11.13.16.24
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 11 Nov 2019 13:16:25 -0800 (PST)
From:   Dmitry Osipenko <digetx@gmail.com>
To:     Thierry Reding <thierry.reding@gmail.com>,
        Jonathan Hunter <jonathanh@nvidia.com>,
        Peter De Schrijver <pdeschrijver@nvidia.com>,
        "Rafael J. Wysocki" <rjw@rjwysocki.net>,
        Daniel Lezcano <daniel.lezcano@linaro.org>
Cc:     linux-pm@vger.kernel.org, linux-tegra@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH v7 01/17] ARM: tegra: Compile sleep-tegra20/30.S unconditionally
Date:   Tue, 12 Nov 2019 00:15:40 +0300
Message-Id: <20191111211556.20723-2-digetx@gmail.com>
X-Mailer: git-send-email 2.23.0
In-Reply-To: <20191111211556.20723-1-digetx@gmail.com>
References: <20191111211556.20723-1-digetx@gmail.com>
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
2.23.0

