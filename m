Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 4589DA58BD
	for <lists+linux-pm@lfdr.de>; Mon,  2 Sep 2019 16:05:22 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730842AbfIBOEN (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Mon, 2 Sep 2019 10:04:13 -0400
Received: from mail-wm1-f66.google.com ([209.85.128.66]:36654 "EHLO
        mail-wm1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730825AbfIBOEM (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Mon, 2 Sep 2019 10:04:12 -0400
Received: by mail-wm1-f66.google.com with SMTP id p13so14794385wmh.1;
        Mon, 02 Sep 2019 07:04:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=DETtNsa6CCp7MhS512rG6yCksW86dRIW7WvIg0/pnDg=;
        b=omUXoxxGO4uVY6IVShKAw4vgYe79oLa84dtEG3I8wogo8h5rakBVjdkteMdwnEYiHy
         V+B2t+5MwIsNccdYdh/AOc8SS3foDLHP5iSHY2vSoWo7d/IPPwzGCvN3BLg8hm2oShRM
         jJuH3+0kcesRT5QWtBAec3c9QXOX721ddRkVCXGPYLdhujvXlYFgVXK4/cDVzE2w4WBZ
         8WamAYRPtgpBTBQ44C02+ADpGEfW4rPeXE7graockJHcTSkQ1sYbdFGwJ6lUeAOdgR2/
         rPImqm4kGL4PdaCw/K7k0L4hdJTuF7pu1m0sP4S0Rsn0tSm3Ivmbov1QYGpdIKsOwBxD
         0ncQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=DETtNsa6CCp7MhS512rG6yCksW86dRIW7WvIg0/pnDg=;
        b=hTKklHAugkoYxshz8U8YGmbuvsBy+UOMwLOiXabLHrUPpfqqbO5bOC4fmAW57Y8A+b
         F7sdK59RzNXqkP4U7YU8XO+Pw9B4SVfVK9zZwx3zaZUuYOmoR0Z8tdcUV0AsTEnuxEnR
         7IAClryIMtxiYh/h2joWB5EE/lEhR/fbvaNigM14yk2OWis98tFA3rfCx8K4e3NTfm2W
         DUofyxFvi0wXErP+X7VJOBgHk5tFwHsLMMO/z6NVL37stp9ZYLj2j7sCsyqnRfTS29PA
         7c5JPjnNcV0nMI0UKGfcnMDFEN4mlY8jMcCu2CoWpNOSNtCiCTbJcQsB23n4BvH2grOZ
         XFSg==
X-Gm-Message-State: APjAAAUb759IRXrZoaPDai9CiGNvQrzussaEMq66tpozighGYCfE6QSf
        u8WBYGdSjCYpKIuVmZou5ss=
X-Google-Smtp-Source: APXvYqx+2wHQ2CkxCTviFYFgut/L74VUrTw3N/8LBVpAV6iOBvxtjl3yY1xkhVCTn3DH4vbXjPVmMA==
X-Received: by 2002:a1c:2e8d:: with SMTP id u135mr36435035wmu.101.1567433050747;
        Mon, 02 Sep 2019 07:04:10 -0700 (PDT)
Received: from localhost.localdomain ([2a01:e34:eecb:7400:8425:c99f:73d7:9637])
        by smtp.gmail.com with ESMTPSA id f186sm20020675wmg.21.2019.09.02.07.04.09
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 02 Sep 2019 07:04:09 -0700 (PDT)
From:   Erwan Velu <erwanaliasr1@gmail.com>
X-Google-Original-From: Erwan Velu <e.velu@criteo.com>
Cc:     Erwan Velu <e.velu@criteo.com>, Len Brown <lenb@kernel.org>,
        linux-pm@vger.kernel.org (open list:TURBOSTAT UTILITY),
        linux-kernel@vger.kernel.org (open list)
Subject: [PATCH] tools/power/x86/turbostat/turbostat: Report MSR_PLATFORM_INFO registers
Date:   Mon,  2 Sep 2019 16:03:55 +0200
Message-Id: <20190902140355.27891-1-e.velu@criteo.com>
X-Mailer: git-send-email 2.21.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
To:     unlisted-recipients:; (no To-header on input)
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

This commit is about report all registers from MSR_PLATFORM_INFO.
This helps understand the actual state of the processor.

This patch also reports the min efficiency frequency.

Signed-off-by: Erwan Velu <e.velu@criteo.com>
---
 tools/power/x86/turbostat/turbostat.c | 42 +++++++++++++++++++++++++--
 1 file changed, 40 insertions(+), 2 deletions(-)

diff --git a/tools/power/x86/turbostat/turbostat.c b/tools/power/x86/turbostat/turbostat.c
index 75fc4fb9901c..5f5b3132bbea 100644
--- a/tools/power/x86/turbostat/turbostat.c
+++ b/tools/power/x86/turbostat/turbostat.c
@@ -2050,13 +2050,51 @@ dump_nhm_platform_info(void)
 	unsigned int ratio;
 
 	get_msr(base_cpu, MSR_PLATFORM_INFO, &msr);
+	fprintf(outf, "cpu%d: MSR_PLATFORM_INFO: 0x%08llx ", base_cpu, msr);
+	fprintf(outf, " (%s%s%s%s%s%s%s%s%s%s%s%s%s%s%s%s%s%s%s%s%s%s%s%s%sCONFIG-TDP-LEVELS:%llu%s%s%s%s%s)\n",
+		(msr & 1 << 0) ? "Bit0, " : "",
+		(msr & 1 << 1) ? "Bit1, " : "",
+		(msr & 1 << 2) ? "Bit2, " : "",
+		(msr & 1 << 3) ? "Bit3, " : "",
+		(msr & 1 << 4) ? "Bit4, " : "",
+		(msr & 1 << 5) ? "Bit5, " : "",
+		(msr & 1 << 6) ? "Bit6, " : "",
+		(msr & 1 << 7) ? "Bit7, " : "",
+		(msr & 1 << 16) ? "SMM-SAVE-CAP, " : "",
+		(msr & 1 << 17) ? "TAPUNLOCK, " : "",
+		(msr & 1 << 18) ? "Bit18, " : "",
+		(msr & 1 << 19) ? "Bit19, " : "",
+		(msr & 1 << 20) ? "Bit20, " : "",
+		(msr & 1 << 21) ? "Bit21, " : "",
+		(msr & 1 << 22) ? "Bit22, " : "",
+		(msr & 1 << 23) ? "PPIN-CAP, " : "",
+		(msr & 1 << 24) ? "OCVOLT-OVRD-AVAIL, " : "",
+		(msr & 1 << 25) ? "Bit25, " : "",
+		(msr & 1 << 26) ? "DCU_MODE_SELECT, " : "",
+		(msr & 1 << 27) ? "SAMPLE-PART, " : "",
+		(msr & 1 << 28) ? "PRG-TURBO-RATIO, " : "",
+		(msr & 1 << 29) ? "PRG-TDP-LIM, " : "",
+		(msr & 1 << 30) ? "PRG-TJ-OFFSET, " : "",
+		(msr & 1 << 31) ? "CPUID-FAULTING, " : "",
+		(msr & 1 << 32) ? "LOW-POWER-MODE-SUPPORT, " : "",
+		(msr >> 33) & 0x3,
+		(msr & 1 << 35) ? "PFAT, " : "",
+		(msr & 1 << 36) ? "Bit36, " : "",
+		(msr & 1 << 37) ? "TIMED_MWAIT, " : "",
+		(msr & 1 << 38) ? "Bit38, " : "",
+		(msr & 1 << 38) ? "Bit39, " : "");
+
+	// MIN_OPERATING_RATIO
+	ratio = (msr >> 48) & 0xFF;
+	fprintf(outf, "%d * %.1f = %.1f MHz min efficiency frequency\n",
+		ratio, bclk, ratio * bclk);
 
-	fprintf(outf, "cpu%d: MSR_PLATFORM_INFO: 0x%08llx\n", base_cpu, msr);
-
+	// MAX_EFFICIENCY_RATIO
 	ratio = (msr >> 40) & 0xFF;
 	fprintf(outf, "%d * %.1f = %.1f MHz max efficiency frequency\n",
 		ratio, bclk, ratio * bclk);
 
+	// MAX_NON_TURBO_LIMIT_RATION
 	ratio = (msr >> 8) & 0xFF;
 	fprintf(outf, "%d * %.1f = %.1f MHz base frequency\n",
 		ratio, bclk, ratio * bclk);
-- 
2.21.0

