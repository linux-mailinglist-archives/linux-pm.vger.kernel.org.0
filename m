Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 22227447A74
	for <lists+linux-pm@lfdr.de>; Mon,  8 Nov 2021 07:24:27 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234628AbhKHG1G (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Mon, 8 Nov 2021 01:27:06 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43836 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229807AbhKHG1E (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Mon, 8 Nov 2021 01:27:04 -0500
Received: from mail-wm1-x32f.google.com (mail-wm1-x32f.google.com [IPv6:2a00:1450:4864:20::32f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2CC57C061570
        for <linux-pm@vger.kernel.org>; Sun,  7 Nov 2021 22:24:20 -0800 (PST)
Received: by mail-wm1-x32f.google.com with SMTP id a20-20020a1c7f14000000b003231d13ee3cso14202828wmd.3
        for <linux-pm@vger.kernel.org>; Sun, 07 Nov 2021 22:24:20 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=/mFKB/mv5bkffIro5ePpzmGU5HrIWesOrIj6Lllyq7I=;
        b=p/lLfn4VmkUyjqCblUK1UM1icSZ7HB9xWt2EY7m40k3TKA/MJt9GjwvG4Tnp5i7O9V
         Su9/YgvQA/TBGurjWxI0NIkwjXpX89DmV4EU9xC33E0fUw7qIDMk7CKdaKGgU+T2yYFX
         V2W/cxAvnO+xMRCkZ0FsrSXbAw1cDUf7acfRDwYVqgsotz5jjZf7gqspzVuC2gqINiYk
         bK1cZwMQ3RFVhXqpxoEu1nMdjrI4x14Rn7gq+c0dzbHeINlIh9oisLcuEyzwNPhqRqr1
         wLrbWz428RoLr1L0oME1c/midNXV96C8qNTHycRXZctU9B6xIoK5PceRe2mVu1YrVLkz
         kPyA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=/mFKB/mv5bkffIro5ePpzmGU5HrIWesOrIj6Lllyq7I=;
        b=THKrtqej3RX4K26KI30btL5zy2CkR7xL3Fol7Yl6hmCJneCSB4qXVxcIrF6lMoRUfo
         wJp4k61djhvomd6bhmiu8eg1mNB0qA/wqKgkud4nwNiVWffGfxEdNftLYf7HA4uewT/U
         Z3IO8ZosUU0FL0zAasgt7WLKyEJCJkjA+fOLRdfsyxkHA4/9eLUknFm8VX1pNBZHavfm
         ul3IgmDr1XorivOG5XCICZvXmZiM1rlVsWLlH856qdndjmrhZzO8xt6IgbhtG0Odyryy
         /FINBCuajAMhN9NOcl3JC5buZGIq/JW2us2yGoByD5w7zMTcmMYVrkewmjYmKEHe9685
         w1aA==
X-Gm-Message-State: AOAM5319qlmy5Db6Wm68V+mSquSs4nWVvCEjIWb4jajhMrzSWR2tsdV5
        YQuoYvgxJmovWwaND/x4atfz/g==
X-Google-Smtp-Source: ABdhPJz5KWW7bCr0dWiMF4ncOh508Su+Z121toq+/l+BBNaBxIps2Q0/RNTAeENjv/6E2iW3PVdDpA==
X-Received: by 2002:a05:600c:2dc1:: with SMTP id e1mr49881694wmh.170.1636352658107;
        Sun, 07 Nov 2021 22:24:18 -0800 (PST)
Received: from localhost.localdomain ([2a01:e34:ed2f:f020:b284:9762:3896:6957])
        by smtp.gmail.com with ESMTPSA id j19sm15632779wra.5.2021.11.07.22.24.16
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 07 Nov 2021 22:24:17 -0800 (PST)
From:   Daniel Lezcano <daniel.lezcano@linaro.org>
To:     rafael@kernel.org
Cc:     linux-pm@vger.kernel.org, daniel.lezcano@linaro.org,
        "Kenneth R . Crudup" <kenny@panix.com>,
        kernel test robot <oliver.sang@intel.com>, lkp@lists.01.org,
        lkp@intel.com, Daniel Lezcano <daniel.lezcano@kernel.org>,
        linux-kernel@vger.kernel.org (open list)
Subject: [PATCH] powercap/drivers/dtpm_cpu: Fix suspend failure and kernel warning
Date:   Mon,  8 Nov 2021 07:23:44 +0100
Message-Id: <20211108062345.273855-1-daniel.lezcano@linaro.org>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20211107095001.GC11442@xsang-OptiPlex-9020>
References: <20211107095001.GC11442@xsang-OptiPlex-9020>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

When the ENERGY_MODEL and DTPM_CPU are enabled but actually without
any energy model, at cpu hotplug time, the dead cpuhp callback fails
leading to the warning.

Actually, the check could be simplified and we only do an action if
the dtpm cpu is enabled, otherwise we bail out without error.

Fixes: 7a89d7eacf8e ("powercap/drivers/dtpm: Simplify the dtpm table")
Reported-by: Kenneth R. Crudup <kenny@panix.com>
Tested-by: Kenneth R. Crudup <kenny@panix.com>
Reported-by: kernel test robot <oliver.sang@intel.com>
Cc: lkp@lists.01.org
Cc: lkp@intel.com
Signed-off-by: Daniel Lezcano <daniel.lezcano@linaro.org>
---
 drivers/powercap/dtpm_cpu.c | 9 +++------
 1 file changed, 3 insertions(+), 6 deletions(-)

diff --git a/drivers/powercap/dtpm_cpu.c b/drivers/powercap/dtpm_cpu.c
index 69eb5101b5c7..477042199d90 100644
--- a/drivers/powercap/dtpm_cpu.c
+++ b/drivers/powercap/dtpm_cpu.c
@@ -166,16 +166,13 @@ static struct dtpm_ops dtpm_ops = {
 
 static int cpuhp_dtpm_cpu_offline(unsigned int cpu)
 {
-	struct em_perf_domain *pd;
 	struct dtpm_cpu *dtpm_cpu;
 
-	pd = em_cpu_get(cpu);
-	if (!pd)
-		return -EINVAL;
-
 	dtpm_cpu = per_cpu(dtpm_per_cpu, cpu);
+	if (dtpm_cpu)
+		dtpm_update_power(&dtpm_cpu->dtpm);
 
-	return dtpm_update_power(&dtpm_cpu->dtpm);
+	return 0;
 }
 
 static int cpuhp_dtpm_cpu_online(unsigned int cpu)
-- 
2.25.1

