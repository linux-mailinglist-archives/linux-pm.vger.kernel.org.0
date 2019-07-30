Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 6A6CC7AF1F
	for <lists+linux-pm@lfdr.de>; Tue, 30 Jul 2019 19:11:14 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730141AbfG3RKN (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Tue, 30 Jul 2019 13:10:13 -0400
Received: from mail-wm1-f67.google.com ([209.85.128.67]:52371 "EHLO
        mail-wm1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730074AbfG3RKN (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Tue, 30 Jul 2019 13:10:13 -0400
Received: by mail-wm1-f67.google.com with SMTP id s3so57863008wms.2;
        Tue, 30 Jul 2019 10:10:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=FDvoYJijQDj0e5NVUU9jZaC+GnZsfGAQXtnAmVIR6ZQ=;
        b=XJm1ipzjBWgrVFPPb5UvbmM8LfdE+bpPm1dczBNYrddV/g+tKGwrJ1FaK8Dl/BhURJ
         CTvOxcKmVPF/rlHWuK7BHX0+V1FAlFp1Q+U5hM+U76juHAapequTchs8H+QjfyBJZIvR
         ITyEjYEa6BMtKV0RomplhERSvJjylmAp9YAQ2OCF8KulF3X1SC60V9fUWBAhXVx5tV35
         0E5+fBIb4eZgNPcQ2iOPDZShIMBbnASXODqVCn+jfpUc3pudF3KiOL33bqkuSUtrDRYd
         IGid9Ewjicy+DbKdY6cDjMIPRCsyUGd7L/VBJbqGFEHh8WhI3tf+3eR7yWhy+4AIKgd8
         WS2Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=FDvoYJijQDj0e5NVUU9jZaC+GnZsfGAQXtnAmVIR6ZQ=;
        b=fnPlzwSBGaTdoJZvAPJV/rmA4WVLVYkqfPFZZ9Owvi4i/9Hp8xvo5BaL4ZGbfNHkSR
         J8p1FUWL+8+xYbWy4IHaF1/VD+7HTxe1rTK8riHwTH+5g+3NpClOFUxAMKa414VXZ3fq
         OfvednKWQeL1TU9koeN/yUruCe7WGbKG6qXwu4kxmJNfLLC0Unv6g5yBLP3dZqEB1miD
         m20Avl92GdrI5O+PV94d13QN42aMbgfyDNhiIr3WZHXCAjMye+sj5ZYMEsGEYIy3IzlG
         lCPLfZw31QlbcjIyC9zldsmza30iXa7mXH6u7yMjaDUIrN7kW6Vy+irsEiuPVqL/askj
         z08A==
X-Gm-Message-State: APjAAAVn/njXS95qlisP4k2qwb0Cws13qC/ZYSoolH5bLNXNbT3s3Ap5
        yPl0i4o//R7jyupStA6nG7XTBwzj
X-Google-Smtp-Source: APXvYqzMVl2dKRvFwele7lGvgMMwXksO/r6Jg2l1V5MYJ4X2utW1ib9WVxkej6z3koAhW7JRKzAkMA==
X-Received: by 2002:a1c:ac81:: with SMTP id v123mr108902879wme.145.1564506611385;
        Tue, 30 Jul 2019 10:10:11 -0700 (PDT)
Received: from localhost.localdomain (ppp91-78-220-99.pppoe.mtu-net.ru. [91.78.220.99])
        by smtp.gmail.com with ESMTPSA id i13sm58897736wrr.73.2019.07.30.10.10.10
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 30 Jul 2019 10:10:10 -0700 (PDT)
From:   Dmitry Osipenko <digetx@gmail.com>
To:     Thierry Reding <thierry.reding@gmail.com>,
        Jonathan Hunter <jonathanh@nvidia.com>,
        Peter De Schrijver <pdeschrijver@nvidia.com>,
        "Rafael J. Wysocki" <rjw@rjwysocki.net>,
        Daniel Lezcano <daniel.lezcano@linaro.org>
Cc:     linux-pm@vger.kernel.org, linux-tegra@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: [PATCH v4 04/13] ARM: tegra: Compile sleep-tegra20/30.S unconditionally
Date:   Tue, 30 Jul 2019 20:09:46 +0300
Message-Id: <20190730170955.11987-5-digetx@gmail.com>
X-Mailer: git-send-email 2.22.0
In-Reply-To: <20190730170955.11987-1-digetx@gmail.com>
References: <20190730170955.11987-1-digetx@gmail.com>
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
2.22.0

