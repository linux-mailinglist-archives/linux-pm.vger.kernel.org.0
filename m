Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id DAEB817DA88
	for <lists+linux-pm@lfdr.de>; Mon,  9 Mar 2020 09:19:15 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726491AbgCIITN (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Mon, 9 Mar 2020 04:19:13 -0400
Received: from mail-pf1-f194.google.com ([209.85.210.194]:38889 "EHLO
        mail-pf1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726426AbgCIITL (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Mon, 9 Mar 2020 04:19:11 -0400
Received: by mail-pf1-f194.google.com with SMTP id g21so4487380pfb.5;
        Mon, 09 Mar 2020 01:19:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :in-reply-to:references;
        bh=97j+BQwnuA+j+MznOuDwPM3YlR+ybya1ELeecHUKr6c=;
        b=o6vHURStjOFlNogoA+m7kXFMgXCSI0+B+vjpdzWletwOAIa2x1gDX0Q34D1j0yukop
         P3zmTBbmzPH926MQHFxaRaJGmZXDJX0bDszVqvhVL7/55FJFkbGE6MH0Nv0qbcgAoKQI
         EPYoClOa1NqGfOtRwClOqKARB2xoLGh3jrPwoo3NGeefvpvI9JaSju5qwd6X9DaUzofv
         jaMpwT7TNYO5LUX/X514o7xAOBpLHSMqM8v5VPYbVDqRIjXNetmNEZF2EG6Uq1mo9wmC
         o4oN20ln9Bm9z8KUj7imNLliyDxiV1Xjj5Tijnihgsf5OHAgwWwrPy9tHMeOZIkLRZb1
         WwxA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:in-reply-to:references;
        bh=97j+BQwnuA+j+MznOuDwPM3YlR+ybya1ELeecHUKr6c=;
        b=mNOG9aLQZYsZpp1AlD4fA+RqHcoBPWKIDSxf80R8iCOYP4XMaMdDccVc/oQuckRjbO
         pw2MUq8fVDxaTaee89MhyvTc9wbWJXij1JoJe2f7gko6YHVKAn//Aen5aUOkeOrBGnDN
         J1pVF9X3wQLYm/vGogTmIe7YTU08CrvjymkuKmjKkG1hALRBxwV3aztPvR5SjvXlMO63
         JwX5b3R0nnaqIAETd/U+NaNR541o+16f4dq4+fIakoLh4mybBrnM7bV66iHeGD7NFIfq
         HP2k52wGcfhA+06LwFZMr2lUz06a8aWIdzmsFMI3ljV8TIbGkFAkSQsp2eUpONCnLaKh
         jQVw==
X-Gm-Message-State: ANhLgQ065CoM0lPgZl4D2LxIuOVuIAOxYbigq4XsVCVdKYMr4ZzrOnT9
        EnDRcSMdjzJSKTlktSnDswCMx3MA
X-Google-Smtp-Source: ADFU+vtU4P6HR9nKkXyeLE033oBehzmN7R1hjg1TrbrGg4P3tRbrlzMuwhtFFR2mE3ITk+V2AdKkaA==
X-Received: by 2002:a63:67c5:: with SMTP id b188mr15193467pgc.111.1583741950320;
        Mon, 09 Mar 2020 01:19:10 -0700 (PDT)
Received: from sh03840pcu.spreadtrum.com ([117.18.48.82])
        by smtp.gmail.com with ESMTPSA id 193sm21862277pfu.181.2020.03.09.01.19.08
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Mon, 09 Mar 2020 01:19:09 -0700 (PDT)
From:   Baolin Wang <baolin.wang7@gmail.com>
To:     sre@kernel.org
Cc:     baolin.wang7@gmail.com, orsonzhai@gmail.com, zhang.lyra@gmail.com,
        kernel-team@android.com, linux-pm@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH 2/3] power: reset: sc27xx: Change to use cpu_down()
Date:   Mon,  9 Mar 2020 16:18:45 +0800
Message-Id: <fadd883957d4283d3149f00ade8e7a7d3fc912b6.1583740881.git.baolin.wang7@gmail.com>
X-Mailer: git-send-email 1.9.1
In-Reply-To: <cover.1583740881.git.baolin.wang7@gmail.com>
References: <cover.1583740881.git.baolin.wang7@gmail.com>
In-Reply-To: <cover.1583740881.git.baolin.wang7@gmail.com>
References: <cover.1583740881.git.baolin.wang7@gmail.com>
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

To allow the SC27XX driver can be built as a module, and the
freeze_secondary_cpus() symbol is not exported, thus we can change
to use the exported cpu_down() API to shut down other cpus to avoid
racing, which is same as the freeze_secondary_cpus().

Signed-off-by: Baolin Wang <baolin.wang7@gmail.com>
---
 drivers/power/reset/sc27xx-poweroff.c | 9 ++++++---
 1 file changed, 6 insertions(+), 3 deletions(-)

diff --git a/drivers/power/reset/sc27xx-poweroff.c b/drivers/power/reset/sc27xx-poweroff.c
index 2bedd4c..91b5ece 100644
--- a/drivers/power/reset/sc27xx-poweroff.c
+++ b/drivers/power/reset/sc27xx-poweroff.c
@@ -29,10 +29,13 @@
  */
 static void sc27xx_poweroff_shutdown(void)
 {
-#ifdef CONFIG_PM_SLEEP_SMP
-	int cpu = smp_processor_id();
+#ifdef CONFIG_HOTPLUG_CPU
+	int cpu;
 
-	freeze_secondary_cpus(cpu);
+	for_each_online_cpu(cpu) {
+		if (cpu != smp_processor_id())
+			cpu_down(cpu);
+	}
 #endif
 }
 
-- 
1.9.1

