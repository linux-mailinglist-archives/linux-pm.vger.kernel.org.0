Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8A1AB2C426B
	for <lists+linux-pm@lfdr.de>; Wed, 25 Nov 2020 15:49:22 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730072AbgKYOtV (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Wed, 25 Nov 2020 09:49:21 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42846 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730060AbgKYOtV (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Wed, 25 Nov 2020 09:49:21 -0500
Received: from mail-pl1-x644.google.com (mail-pl1-x644.google.com [IPv6:2607:f8b0:4864:20::644])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 499ECC0613D4;
        Wed, 25 Nov 2020 06:49:21 -0800 (PST)
Received: by mail-pl1-x644.google.com with SMTP id r2so1225763pls.3;
        Wed, 25 Nov 2020 06:49:21 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=AIKPa1FL2cnfSTR46Lr5Q79oKqEZPubQ7TacswKWIKY=;
        b=GVYg3xM20FqRqiKLB+pnHYwY7Og5m5L8mmEYsKuBbrpOtSSXH1IHLyeckTjRwAujBn
         c67Ur9vcMH2Mie0E3MrpgQ/9gzeJpYRrZe27fCjvzZQyjqtg3aYY7m32WI5Fjzc2q5e6
         4fD7Xw7oJL96BuIJ5pAq08D40uOr8Hu/3v2/lZz3cV02juIWJe9UvQdT/SWDMumOu+ez
         X5I20Wjc/H6mdMI3yVmOdhxfpnhrLvAFKuiRf8FPFPWibkih3wjjXStBWidbvcE9zFxi
         izpR9GsPeXQwzYrPeyP2NiQ2d5sOOF1HCi0mdAAegou9ogXaZISzjTlkLu8Fivfa6D0u
         LfwA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=AIKPa1FL2cnfSTR46Lr5Q79oKqEZPubQ7TacswKWIKY=;
        b=npgQjLGFE/pzaulXJ70+polYLxrYa0AVYYnw7n1RUVxW9DAvvN6UEgZNsA9mf64c1L
         f/Zavfi00k3J8dTpGdYofrkSKxPNmz+H100A+/EZJFrgBntNCqp/TlAGcdTH6saRzwzG
         vhCeLjc/pjt45id1YMa2OkiLfTrCeUiuISfALm1/ueOzzCIDd4fVZwmtHUkHQ8Z7cuGP
         2Puo8hcJEXX/IlrfLm0bQlzcrwBCkzs1WB9Hu50zGgJafMTcDsjhpHqmUDIGb0bzc/OY
         TnkTqhLJ4EeMhAz+XiaLJyPCvpRKQv7LOny/Oy5GhdFoC1+b0Enz4P6X8cdywkwuHXNm
         g0fQ==
X-Gm-Message-State: AOAM532fEImrmUnPzb3SZUWRgh9NSFouZ51ZjjVBTtIsQD9XqH9dDAeN
        KrGF56Avw216bNhRKGe2jpw=
X-Google-Smtp-Source: ABdhPJyYy2zfmyhZSFhYhTYxi01YCv/nD705q1p/WRUWT9/V1nH3K3ts3Cf7mS9tbporYi1Yd9OuMQ==
X-Received: by 2002:a17:902:b688:b029:d6:ad52:ffab with SMTP id c8-20020a170902b688b02900d6ad52ffabmr3480270pls.61.1606315760860;
        Wed, 25 Nov 2020 06:49:20 -0800 (PST)
Received: from localhost ([2405:6580:31a1:500:1ac0:4dff:fe39:5426])
        by smtp.gmail.com with ESMTPSA id 17sm2393448pfu.180.2020.11.25.06.49.20
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 25 Nov 2020 06:49:20 -0800 (PST)
From:   Punit Agrawal <punitagrawal@gmail.com>
To:     rjw@rjwysocki.net
Cc:     Punit Agrawal <punitagrawal@gmail.com>, wei.huang2@amd.com,
        linux-kernel@vger.kernel.org, linux-pm@vger.kernel.org,
        bp@alien8.de, x86@kernel.org, Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>
Subject: [RFC PATCH 3/4] x86/cpu: amd: Define processor families
Date:   Wed, 25 Nov 2020 23:48:46 +0900
Message-Id: <20201125144847.3920-4-punitagrawal@gmail.com>
X-Mailer: git-send-email 2.29.2
In-Reply-To: <20201125144847.3920-1-punitagrawal@gmail.com>
References: <20201125144847.3920-1-punitagrawal@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

So far, the AMD processor identifier (family, models, stepping) are
referred to by raw values making it easy to make mistakes. It is also
harder to read and maintain. Additionally, these values are also being
used in subsystems outside the arch code where not everybody maybe be
as familiar with the processor identifiers.

As a first step towards improving the status quo, add macros for the
AMD processor families and propagate them through the existing
cpu_device_id.h header used for this purpose.

Signed-off-by: Punit Agrawal <punitagrawal@gmail.com>
Cc: Thomas Gleixner <tglx@linutronix.de>
Cc: Ingo Molnar <mingo@redhat.com>
Cc: Borislav Petkov <bp@alien8.de>
Cc: x86@kernel.org
---
 arch/x86/include/asm/amd-family.h    | 18 ++++++++++++++++++
 arch/x86/include/asm/cpu_device_id.h |  2 ++
 2 files changed, 20 insertions(+)
 create mode 100644 arch/x86/include/asm/amd-family.h

diff --git a/arch/x86/include/asm/amd-family.h b/arch/x86/include/asm/amd-family.h
new file mode 100644
index 000000000000..dff4d13b8e74
--- /dev/null
+++ b/arch/x86/include/asm/amd-family.h
@@ -0,0 +1,18 @@
+/* SPDX-License-Identifier: GPL-2.0 */
+#ifndef _ASM_X86_AMD_FAMILY_H
+#define _ASM_X86_AMD_FAMILY_H
+
+#define AMD_FAM_K5			0x04
+#define AMD_FAM_K6			0x05
+#define AMD_FAM_K7			0x06
+#define AMD_FAM_K8			0x0F
+#define AMD_FAM_K10			0x10
+#define AMD_FAM_K8_K10_HYBRID		0x11
+#define AMD_FAM_LLANO			0x12
+#define AMD_FAM_BOBCAT			0x14
+#define AMD_FAM_BULLDOZER		0x15
+#define AMD_FAM_JAGUAR			0x16
+#define AMD_FAM_ZEN			0x17
+#define AMD_FAM_ZEN3			0x19
+
+#endif /* _ASM_X86_AMD_FAMILY_H */
diff --git a/arch/x86/include/asm/cpu_device_id.h b/arch/x86/include/asm/cpu_device_id.h
index eb8fcede9e3b..bbb48ba4c7ff 100644
--- a/arch/x86/include/asm/cpu_device_id.h
+++ b/arch/x86/include/asm/cpu_device_id.h
@@ -12,6 +12,8 @@
 #include <linux/mod_devicetable.h>
 /* Get the INTEL_FAM* model defines */
 #include <asm/intel-family.h>
+/* Get the AMD model defines */
+#include <asm/amd-family.h>
 /* And the X86_VENDOR_* ones */
 #include <asm/processor.h>
 
-- 
2.29.2

