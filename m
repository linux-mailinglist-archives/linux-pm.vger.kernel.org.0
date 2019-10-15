Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 8074BD7CCD
	for <lists+linux-pm@lfdr.de>; Tue, 15 Oct 2019 19:02:59 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388415AbfJORBo (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Tue, 15 Oct 2019 13:01:44 -0400
Received: from mail-lj1-f194.google.com ([209.85.208.194]:40699 "EHLO
        mail-lj1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726379AbfJORBm (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Tue, 15 Oct 2019 13:01:42 -0400
Received: by mail-lj1-f194.google.com with SMTP id 7so21029917ljw.7;
        Tue, 15 Oct 2019 10:01:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=AJsM8Od2cQbwnjMd2WWbJxd1SHRmM5N6fXuOeZ21tBs=;
        b=FY5C708+7R3R+T2+2UOKodWusasv7UcODH3feQg6EaDVYSPJItMgxs28+Euriicg2p
         DqH9dihcTkCskwC1ydhMiqccrDXHiSeWXlPMNbfCh/4WrgsVrv20bigOsKuMsxe9Z+l6
         L/xcAmGzH8irwMxlSjkZFpZuC6AiqiVDgamhs/L5ZYs0wpIBFOdG+LL6roPkDUMMyo9K
         93N2d/zAXlAk3NIw3VwXdYxKu768n3ijPPIU+1qfRojes3YVddknpTY/46h2D07iBarT
         KJSLn6qaVWTUIIR+JuXkbB2kS4T5/GsapEKcdAW9ZN7L5oimMeautX+uftwmzrI4d5BK
         qzrw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=AJsM8Od2cQbwnjMd2WWbJxd1SHRmM5N6fXuOeZ21tBs=;
        b=T/DX/FOEH3TxCRBC9/dUgYRzewTFgt0D92ea/8gsjAwwSUZE9J+SASAYYSPFdbxvHd
         uJgmOs087T7iao/Z6bzgp4tyeAgQh4X8r8Mz5ZraRRlksKobYBr7JEKhIxf3JCkmJ79Z
         qmesppyWCjYpMOavWJfjTk6NrxLjXh/2sCDJjX2wwl5MIHG1YjCwKsKVEoFmJsbZotRv
         oI9wWcy/Is7smgjq2efIshTE17Zaw++wzVGySyPToWyoegX53urTt9zVR6iIbRG1JBsl
         /RPaf3LhWNjuDsqlnHCxr0KUGcX8Qw04SsnEYGQxxSj3OrEkUNsX73tnW6BgdR7V+yx4
         7m0A==
X-Gm-Message-State: APjAAAXTbJw/Bu8Mj6cvhByLr/gh/LJEpG4u6LEIWAP5tzEyAMzP0RLa
        TdPzrpxkzfyVpMm1d2DWFiM=
X-Google-Smtp-Source: APXvYqxpvul+nMVqpIug+XdB+meqQlQVFNMFw50vLLX2A3w8eaBdAb3LZ0LiyxBd6shpR4An30N4dA==
X-Received: by 2002:a2e:8204:: with SMTP id w4mr23138163ljg.3.1571158900054;
        Tue, 15 Oct 2019 10:01:40 -0700 (PDT)
Received: from localhost.localdomain ([94.29.10.250])
        by smtp.gmail.com with ESMTPSA id t6sm5144992ljd.102.2019.10.15.10.01.39
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 15 Oct 2019 10:01:39 -0700 (PDT)
From:   Dmitry Osipenko <digetx@gmail.com>
To:     Thierry Reding <thierry.reding@gmail.com>,
        Jonathan Hunter <jonathanh@nvidia.com>,
        Peter De Schrijver <pdeschrijver@nvidia.com>,
        "Rafael J. Wysocki" <rjw@rjwysocki.net>,
        Daniel Lezcano <daniel.lezcano@linaro.org>
Cc:     linux-pm@vger.kernel.org, linux-tegra@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH v6 01/18] ARM: tegra: Compile sleep-tegra20/30.S unconditionally
Date:   Tue, 15 Oct 2019 19:59:58 +0300
Message-Id: <20191015170015.1135-2-digetx@gmail.com>
X-Mailer: git-send-email 2.23.0
In-Reply-To: <20191015170015.1135-1-digetx@gmail.com>
References: <20191015170015.1135-1-digetx@gmail.com>
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

