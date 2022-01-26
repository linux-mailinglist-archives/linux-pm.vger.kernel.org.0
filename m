Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1207949C8EF
	for <lists+linux-pm@lfdr.de>; Wed, 26 Jan 2022 12:45:24 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240883AbiAZLpW (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Wed, 26 Jan 2022 06:45:22 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48020 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240891AbiAZLpW (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Wed, 26 Jan 2022 06:45:22 -0500
Received: from mail-pl1-x62e.google.com (mail-pl1-x62e.google.com [IPv6:2607:f8b0:4864:20::62e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3CA7DC06161C
        for <linux-pm@vger.kernel.org>; Wed, 26 Jan 2022 03:45:22 -0800 (PST)
Received: by mail-pl1-x62e.google.com with SMTP id d18so9447620plg.2
        for <linux-pm@vger.kernel.org>; Wed, 26 Jan 2022 03:45:22 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ventanamicro.com; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=+fhSSByGJ1StCm+oVdHQ6+iIgAeqBD8uGJ6nIDfD98Q=;
        b=Xh3abpUhKWutXSa5R1ZrcfayK4Iv8eorhSc5LPbUtCDbBFaBPa9kqT8qgAN7Phl8nU
         CgRXNkYUDQunBNy0SQFPU3KtLxi4nxKVsgyw1npo+bSHe/H7aRQobrLmSB2TwnU35k0O
         kju0hA7bIzlfmUL+MIGzuQRxAyP7rssltUN/QqFgxic+7sxSz+mSIAiJdpRhO7PRMd0y
         D8S7aUCAtEhuYBJecE11TgvnuE1237Ng9D32dCvoYNw57D5ci1E9lQVlxqJ9KARV940R
         J6qOe/dlg9eb1lWi2yiYIJ7wIzyN2rKRIw57gUVIFMPfEA5Nb41eT7R8VPyeoD1tCqX+
         azcA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=+fhSSByGJ1StCm+oVdHQ6+iIgAeqBD8uGJ6nIDfD98Q=;
        b=1/qKrLB2UR8E5/JoiuGTw/vtH+fdZskftVVcFEIwEnTEK2T3+widvyQ4dJ2BfDhkkY
         ZY9aADtQcLyZTcw+KxoSZpz2dtwHnYcU3NhlnZYQwmtzKdGGgpjNfRH38+FOm6n8XS+M
         zdj43ofAeqCHZHTnIlyN8h+a77v/+owTUU3yCUF5MGJE+JJ+6eTPzUH5xWf0Jyu1VN/Y
         hzj4PPlU7ocXFa4pnyrko5e5LWnO12G3WFuGD3sHcKrkwbo0/o3uOY7gBVAm0HsNNavz
         1DWB15iZVmz+Z0FDGoO1N7UiyK0UmUVLkOvf4kXu/+CZpOfIQLnuQQmvmEhYiR0NWLu8
         yhcA==
X-Gm-Message-State: AOAM532cmkuqrpamG4gOG6LDcVDB31QoP4vLeXN/YVisklSalqI5ib0A
        5jQTW5zUJ4ya/y2pcAvOzmHtjA==
X-Google-Smtp-Source: ABdhPJyRC3Dl4A/e6StezF1hozEQZSpNbbOMa429zzx/OGkYNb3FFKnDfVLh7Pv/0LpuLfdKVLTI3w==
X-Received: by 2002:a17:902:8544:b0:14a:bea3:1899 with SMTP id d4-20020a170902854400b0014abea31899mr22998561plo.143.1643197521827;
        Wed, 26 Jan 2022 03:45:21 -0800 (PST)
Received: from localhost.localdomain ([122.167.221.23])
        by smtp.gmail.com with ESMTPSA id nn2sm2994976pjb.35.2022.01.26.03.45.15
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 26 Jan 2022 03:45:21 -0800 (PST)
From:   Anup Patel <apatel@ventanamicro.com>
To:     Palmer Dabbelt <palmer@dabbelt.com>,
        Paul Walmsley <paul.walmsley@sifive.com>,
        Albert Ou <aou@eecs.berkeley.edu>,
        Daniel Lezcano <daniel.lezcano@linaro.org>,
        Ulf Hansson <ulf.hansson@linaro.org>,
        "Rafael J . Wysocki" <rjw@rjwysocki.net>,
        Pavel Machek <pavel@ucw.cz>, Rob Herring <robh+dt@kernel.org>
Cc:     Sandeep Tripathy <milun.tripathy@gmail.com>,
        Atish Patra <atishp@atishpatra.org>,
        Alistair Francis <Alistair.Francis@wdc.com>,
        Liush <liush@allwinnertech.com>,
        Anup Patel <anup@brainfault.org>, devicetree@vger.kernel.org,
        linux-riscv@lists.infradead.org, linux-kernel@vger.kernel.org,
        linux-pm@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        kvm-riscv@lists.infradead.org, Anup Patel <apatel@ventanamicro.com>
Subject: [PATCH v10 2/8] RISC-V: Rename relocate() and make it global
Date:   Wed, 26 Jan 2022 17:14:46 +0530
Message-Id: <20220126114452.692512-3-apatel@ventanamicro.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20220126114452.692512-1-apatel@ventanamicro.com>
References: <20220126114452.692512-1-apatel@ventanamicro.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

From: Anup Patel <anup.patel@wdc.com>

The low-level relocate() function enables mmu and relocates
execution to link-time addresses. We rename relocate() function
to relocate_enable_mmu() function which is more informative.

Also, the relocate_enable_mmu() function will be used in the
resume path when a CPU wakes-up from a non-retentive suspend
so we make it global symbol.

Signed-off-by: Anup Patel <anup.patel@wdc.com>
Signed-off-by: Anup Patel <apatel@ventanamicro.com>
---
 arch/riscv/kernel/head.S | 7 ++++---
 1 file changed, 4 insertions(+), 3 deletions(-)

diff --git a/arch/riscv/kernel/head.S b/arch/riscv/kernel/head.S
index 2363b43312fc..5f4c6b6c4974 100644
--- a/arch/riscv/kernel/head.S
+++ b/arch/riscv/kernel/head.S
@@ -90,7 +90,8 @@ pe_head_start:
 
 .align 2
 #ifdef CONFIG_MMU
-relocate:
+	.global relocate_enable_mmu
+relocate_enable_mmu:
 	/* Relocate return address */
 	la a1, kernel_map
 	XIP_FIXUP_OFFSET a1
@@ -185,7 +186,7 @@ secondary_start_sbi:
 	/* Enable virtual memory and relocate to virtual address */
 	la a0, swapper_pg_dir
 	XIP_FIXUP_OFFSET a0
-	call relocate
+	call relocate_enable_mmu
 #endif
 	call setup_trap_vector
 	tail smp_callin
@@ -329,7 +330,7 @@ clear_bss_done:
 #ifdef CONFIG_MMU
 	la a0, early_pg_dir
 	XIP_FIXUP_OFFSET a0
-	call relocate
+	call relocate_enable_mmu
 #endif /* CONFIG_MMU */
 
 	call setup_trap_vector
-- 
2.25.1

