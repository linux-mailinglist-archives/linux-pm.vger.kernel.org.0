Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4F41921F571
	for <lists+linux-pm@lfdr.de>; Tue, 14 Jul 2020 16:52:07 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729004AbgGNOvi (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Tue, 14 Jul 2020 10:51:38 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57316 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725803AbgGNOu7 (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Tue, 14 Jul 2020 10:50:59 -0400
Received: from mail-wr1-x444.google.com (mail-wr1-x444.google.com [IPv6:2a00:1450:4864:20::444])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C93FEC061794
        for <linux-pm@vger.kernel.org>; Tue, 14 Jul 2020 07:50:58 -0700 (PDT)
Received: by mail-wr1-x444.google.com with SMTP id f2so22124238wrp.7
        for <linux-pm@vger.kernel.org>; Tue, 14 Jul 2020 07:50:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=sa7IFFvEjkUEYkKGNfZ4AaOfAhDNPotc0mtcZbr7pMU=;
        b=Yr1SJcM2AwK2hW8wKdiFtlaK6rKbZ3NlkGx8d1Od6cqVH4nDmmoGCDQVhLHIDws+3d
         2OVvC3aJXzU/ZjRq+haMRmCsqS9W94aOftUL13uUTXk4ZnJIiwTbqrjSFcSQ6+MBToTA
         Wlf9HuAi0Aza+9dtw/LHZF7rOTCDvLKrgawrfm5e6w/OV2eflKYPT6fW2ypIM7ewVmNc
         6sZcE8UtKJDkeu8wqVxcoXJajhBkeReoa/7FhnEB2BS2H5Z5vYRvhfarz4C2XXTsWwBv
         aBmWOuw/i4Vdi3oCKJV1Zdhv/857tPWI3NzjMDJuHyaPTGpybciaeB3NKBD0sTczkWGs
         so9g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=sa7IFFvEjkUEYkKGNfZ4AaOfAhDNPotc0mtcZbr7pMU=;
        b=GJsFrWmZ6PbblctWCTxBPQMrsLtb8KmwguZpEor+M3Bo8/54r1s8v+8MG+/H0WJ9VJ
         2kXtM9EL5SF9dQIty4XcnZ/Hs9B/e0hXnZQAzja4fwP3AQSrf4BbT6UhPVlzYDZjh+Y6
         ObcHToipJKFzg9NHusUv9qOvfoC7a0WH8rdP/rEfUkZVtP9mxLo5Lh8kJ6Qmqa1Z83xj
         lPgZicsZ7eSFV0Mn6yDHT8hsl0eUsVzKYNp+vmWSqvOkegk0gYa7gu1ppBQ4f8BwruoN
         aJCZwh0nDRLx0VRLG19r0tKX1SN3Efr+oxQRtXOZPpieFP/rw8jgf04UK9qwq/VAVbr0
         s0zw==
X-Gm-Message-State: AOAM530xILnVTjvUitBzJ3WOXJNwxkYRyv1ouZA6D9AsfBP0dpCPu8sJ
        I7eAsQ96P089SzLv69BoMGe16w==
X-Google-Smtp-Source: ABdhPJzNf9Z+WHkT0D9c7/YKzZVAjpjagqUFxoxaf/blhTxuH25LgfvUKpph8N2tIaWR9WV7qZZ8hg==
X-Received: by 2002:adf:82f5:: with SMTP id 108mr6084464wrc.218.1594738257584;
        Tue, 14 Jul 2020 07:50:57 -0700 (PDT)
Received: from localhost.localdomain ([2.31.163.61])
        by smtp.gmail.com with ESMTPSA id a84sm4653305wmh.47.2020.07.14.07.50.56
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 14 Jul 2020 07:50:57 -0700 (PDT)
From:   Lee Jones <lee.jones@linaro.org>
To:     rjw@rjwysocki.net, viresh.kumar@linaro.org
Cc:     linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        linux-pm@vger.kernel.org, Lee Jones <lee.jones@linaro.org>,
        Olof Johansson <olof@lixom.net>,
        Michael Ellerman <mpe@ellerman.id.au>,
        Benjamin Herrenschmidt <benh@kernel.crashing.org>,
        Paul Mackerras <paulus@samba.org>,
        linuxppc-dev@lists.ozlabs.org
Subject: [PATCH 05/13] cpufreq/arch: powerpc: pasemi: Move prototypes to shared header
Date:   Tue, 14 Jul 2020 15:50:41 +0100
Message-Id: <20200714145049.2496163-6-lee.jones@linaro.org>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20200714145049.2496163-1-lee.jones@linaro.org>
References: <20200714145049.2496163-1-lee.jones@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

If function callers and providers do not share the same prototypes the
compiler complains of missing prototypes.  Fix this by moving the
already existing prototypes out to a mutually convenient location.

Fixes the following W=1 kernel build warning(s):

 drivers/cpufreq/pasemi-cpufreq.c:109:5: warning: no previous prototype for ‘check_astate’ [-Wmissing-prototypes]
 109 | int check_astate(void)
 | ^~~~~~~~~~~~
 drivers/cpufreq/pasemi-cpufreq.c:114:6: warning: no previous prototype for ‘restore_astate’ [-Wmissing-prototypes]
 114 | void restore_astate(int cpu)
 | ^~~~~~~~~~~~~~

Cc: Olof Johansson <olof@lixom.net>
Cc: Michael Ellerman <mpe@ellerman.id.au>
Cc: Benjamin Herrenschmidt <benh@kernel.crashing.org>
Cc: Paul Mackerras <paulus@samba.org>
Cc: linuxppc-dev@lists.ozlabs.org
Signed-off-by: Lee Jones <lee.jones@linaro.org>
---
 arch/powerpc/platforms/pasemi/pasemi.h    | 15 ------------
 arch/powerpc/platforms/pasemi/powersave.S |  2 ++
 drivers/cpufreq/pasemi-cpufreq.c          |  1 +
 include/linux/platform_data/pasemi.h      | 28 +++++++++++++++++++++++
 4 files changed, 31 insertions(+), 15 deletions(-)
 create mode 100644 include/linux/platform_data/pasemi.h

diff --git a/arch/powerpc/platforms/pasemi/pasemi.h b/arch/powerpc/platforms/pasemi/pasemi.h
index 70b56048ed1be..528d81ef748ad 100644
--- a/arch/powerpc/platforms/pasemi/pasemi.h
+++ b/arch/powerpc/platforms/pasemi/pasemi.h
@@ -15,21 +15,6 @@ extern void __init pasemi_map_registers(void);
 extern void idle_spin(void);
 extern void idle_doze(void);
 
-/* Restore astate to last set */
-#ifdef CONFIG_PPC_PASEMI_CPUFREQ
-extern int check_astate(void);
-extern void restore_astate(int cpu);
-#else
-static inline int check_astate(void)
-{
-	/* Always return >0 so we never power save */
-	return 1;
-}
-static inline void restore_astate(int cpu)
-{
-}
-#endif
-
 extern struct pci_controller_ops pasemi_pci_controller_ops;
 
 #endif /* _PASEMI_PASEMI_H */
diff --git a/arch/powerpc/platforms/pasemi/powersave.S b/arch/powerpc/platforms/pasemi/powersave.S
index d0215d5329ca7..7747b48963286 100644
--- a/arch/powerpc/platforms/pasemi/powersave.S
+++ b/arch/powerpc/platforms/pasemi/powersave.S
@@ -5,6 +5,8 @@
  * Maintained by: Olof Johansson <olof@lixom.net>
  */
 
+#include <linux/platform_data/pasemi.h>
+
 #include <asm/processor.h>
 #include <asm/page.h>
 #include <asm/ppc_asm.h>
diff --git a/drivers/cpufreq/pasemi-cpufreq.c b/drivers/cpufreq/pasemi-cpufreq.c
index c66f566a854cb..c6bb3ecc90ef3 100644
--- a/drivers/cpufreq/pasemi-cpufreq.c
+++ b/drivers/cpufreq/pasemi-cpufreq.c
@@ -15,6 +15,7 @@
 #include <linux/timer.h>
 #include <linux/module.h>
 #include <linux/of_address.h>
+#include <linux/platform_data/pasemi.h>
 
 #include <asm/hw_irq.h>
 #include <asm/io.h>
diff --git a/include/linux/platform_data/pasemi.h b/include/linux/platform_data/pasemi.h
new file mode 100644
index 0000000000000..3fed0687fcc9a
--- /dev/null
+++ b/include/linux/platform_data/pasemi.h
@@ -0,0 +1,28 @@
+/* SPDX-License-Identifier: GPL-2.0-only */
+/*
+ * Copyright (C) 2020 Linaro Ltd.
+ *
+ * Author: Lee Jones <lee.jones@linaro.org>
+ */
+
+#ifndef _LINUX_PLATFORM_DATA_PASEMI_H
+#define _LINUX_PLATFORM_DATA_PASEMI_H
+
+/* Restore astate to last set */
+#ifdef CONFIG_PPC_PASEMI_CPUFREQ
+int check_astate(void);
+void restore_astate(int cpu);
+#else
+static inline int check_astate(void)
+{
+	/* Always return >0 so we never power save */
+	return 1;
+}
+static inline void restore_astate(int cpu)
+{
+}
+#endif
+
+#endif /* _LINUX_PLATFORM_DATA_PASEMI_H */
+
+
-- 
2.25.1

