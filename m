Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 1961EEF533
	for <lists+linux-pm@lfdr.de>; Tue,  5 Nov 2019 06:54:43 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387520AbfKEFym (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Tue, 5 Nov 2019 00:54:42 -0500
Received: from mail-pl1-f193.google.com ([209.85.214.193]:46065 "EHLO
        mail-pl1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2387443AbfKEFym (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Tue, 5 Nov 2019 00:54:42 -0500
Received: by mail-pl1-f193.google.com with SMTP id y24so8807633plr.12;
        Mon, 04 Nov 2019 21:54:42 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id;
        bh=j/zjH1WsGxqzWXQl7cWzzAx6Ls1Pf10bXD65wF5zXRA=;
        b=Z6WgzEkt/ANlGabZkKqXN6RmV5XMrA5SiDCHoSJKDz3H5pnqawFalWJLWNuaHtsUak
         QA8CwlkHE+KFsS36o6edkbQNBbnrnYwN6TRZOUbUevyEykq34SovXvL5feuZY/48SAbp
         ydPoXk3w1C2mgVjRcHWk1/epIWbn2zycR33cpih3szV8nLVxkUpLATOPbXPgcdm7Fs0q
         kkkrit31SIftidf5ckDzgE6tVJSATMAeaFGMYJ14WNCcyVKhwlIZbfTsGVloEOzWTPmV
         wkTr7mlKBhSRCHM3ZSZrdHcT6C5lGm4m2aFyP+msECEGbFkvuCNgRFxFRpGI0MHXziuU
         gUzg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=j/zjH1WsGxqzWXQl7cWzzAx6Ls1Pf10bXD65wF5zXRA=;
        b=Nssp1qYgb9rDIRkHx4PLREeZkhEvbcav81qpXXn2WPChkaZ1XM7BbOdwGffTCXc4su
         T020jnVEVfQk0z3FkHBhGIjeWjlu+tari6KenahR8ZQoWWmIIoxIAy91jQawKI9sLpRW
         +e9lBddQQNQUQXAGG/B6w7Iw7yp8sVAJrGPFxQbb7SGy02XTbguxg9vdy7nhfaEm0f5p
         +CSyOSNOx7l1M2Ce+GNcdOuPuAlA773XXY3LEphp4I1vIABXru2OIwJmrnjCnnLCBwvr
         CC1L48wFqtDvJL1eMFsWYIYAOOiUPIHSKTGtZXdWOR+/5OP4QEZuNG/UPdmBfnIOAiYy
         zgrQ==
X-Gm-Message-State: APjAAAUII261gS7h15zGE0haYB96hkweAnEp1/14qVbIectTkOS0WE7f
        vSLI63rQUhQfkfebGUv0lcBoeW/beTK77Q==
X-Google-Smtp-Source: APXvYqzoh0Yyyw+RhnZSqLU7FF50fOQSb5iK2ir+hQYvcEAP7bxG99RI/nYlxb1paxMhY3MPJBV+RQ==
X-Received: by 2002:a17:902:7e45:: with SMTP id a5mr7715143pln.315.1572933281462;
        Mon, 04 Nov 2019 21:54:41 -0800 (PST)
Received: from jamal-desktop (97-126-66-56.tukw.qwest.net. [97.126.66.56])
        by smtp.gmail.com with ESMTPSA id w5sm6944900pfd.31.2019.11.04.21.54.40
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 04 Nov 2019 21:54:40 -0800 (PST)
From:   Jamal Shareef <jamal.k.shareef@gmail.com>
To:     outreachy-kernel@googlegroups.com
Cc:     Jamal Shareef <jamal.k.shareef@gmail.com>,
        srinivas.pandruvada@linux.intel.com, lenb@kernel.org,
        rjw@rjwysocki.net, viresh.kumar@linaro.org,
        linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH] cpufreq: intel_pstate: Fix sparse plain int pointer
Date:   Mon,  4 Nov 2019 21:54:27 -0800
Message-Id: <20191105055427.11943-1-jamal.k.shareef@gmail.com>
X-Mailer: git-send-email 2.17.1
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

Patch fixes sparse warning: Using plain integer as NULL pointer.
Replaces assignment of 0 to pointer with NULL assignment.

Signed-off-by: Jamal Shareef <jamal.k.shareef@gmail.com>
---
 drivers/cpufreq/intel_pstate.c | 30 +++++++++++++++---------------
 1 file changed, 15 insertions(+), 15 deletions(-)

diff --git a/drivers/cpufreq/intel_pstate.c b/drivers/cpufreq/intel_pstate.c
index 53a51c169451..cfcf34e04c3d 100644
--- a/drivers/cpufreq/intel_pstate.c
+++ b/drivers/cpufreq/intel_pstate.c
@@ -2664,21 +2664,21 @@ enum {
 
 /* Hardware vendor-specific info that has its own power management modes */
 static struct acpi_platform_list plat_info[] __initdata = {
-	{"HP    ", "ProLiant", 0, ACPI_SIG_FADT, all_versions, 0, PSS},
-	{"ORACLE", "X4-2    ", 0, ACPI_SIG_FADT, all_versions, 0, PPC},
-	{"ORACLE", "X4-2L   ", 0, ACPI_SIG_FADT, all_versions, 0, PPC},
-	{"ORACLE", "X4-2B   ", 0, ACPI_SIG_FADT, all_versions, 0, PPC},
-	{"ORACLE", "X3-2    ", 0, ACPI_SIG_FADT, all_versions, 0, PPC},
-	{"ORACLE", "X3-2L   ", 0, ACPI_SIG_FADT, all_versions, 0, PPC},
-	{"ORACLE", "X3-2B   ", 0, ACPI_SIG_FADT, all_versions, 0, PPC},
-	{"ORACLE", "X4470M2 ", 0, ACPI_SIG_FADT, all_versions, 0, PPC},
-	{"ORACLE", "X4270M3 ", 0, ACPI_SIG_FADT, all_versions, 0, PPC},
-	{"ORACLE", "X4270M2 ", 0, ACPI_SIG_FADT, all_versions, 0, PPC},
-	{"ORACLE", "X4170M2 ", 0, ACPI_SIG_FADT, all_versions, 0, PPC},
-	{"ORACLE", "X4170 M3", 0, ACPI_SIG_FADT, all_versions, 0, PPC},
-	{"ORACLE", "X4275 M3", 0, ACPI_SIG_FADT, all_versions, 0, PPC},
-	{"ORACLE", "X6-2    ", 0, ACPI_SIG_FADT, all_versions, 0, PPC},
-	{"ORACLE", "Sudbury ", 0, ACPI_SIG_FADT, all_versions, 0, PPC},
+	{"HP    ", "ProLiant", 0, ACPI_SIG_FADT, all_versions, NULL, PSS},
+	{"ORACLE", "X4-2    ", 0, ACPI_SIG_FADT, all_versions, NULL, PPC},
+	{"ORACLE", "X4-2L   ", 0, ACPI_SIG_FADT, all_versions, NULL, PPC},
+	{"ORACLE", "X4-2B   ", 0, ACPI_SIG_FADT, all_versions, NULL, PPC},
+	{"ORACLE", "X3-2    ", 0, ACPI_SIG_FADT, all_versions, NULL, PPC},
+	{"ORACLE", "X3-2L   ", 0, ACPI_SIG_FADT, all_versions, NULL, PPC},
+	{"ORACLE", "X3-2B   ", 0, ACPI_SIG_FADT, all_versions, NULL, PPC},
+	{"ORACLE", "X4470M2 ", 0, ACPI_SIG_FADT, all_versions, NULL, PPC},
+	{"ORACLE", "X4270M3 ", 0, ACPI_SIG_FADT, all_versions, NULL, PPC},
+	{"ORACLE", "X4270M2 ", 0, ACPI_SIG_FADT, all_versions, NULL, PPC},
+	{"ORACLE", "X4170M2 ", 0, ACPI_SIG_FADT, all_versions, NULL, PPC},
+	{"ORACLE", "X4170 M3", 0, ACPI_SIG_FADT, all_versions, NULL, PPC},
+	{"ORACLE", "X4275 M3", 0, ACPI_SIG_FADT, all_versions, NULL, PPC},
+	{"ORACLE", "X6-2    ", 0, ACPI_SIG_FADT, all_versions, NULL, PPC},
+	{"ORACLE", "Sudbury ", 0, ACPI_SIG_FADT, all_versions, NULL, PPC},
 	{ } /* End */
 };
 
-- 
2.17.1

