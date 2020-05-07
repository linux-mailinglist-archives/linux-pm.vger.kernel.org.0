Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0EA501C98F4
	for <lists+linux-pm@lfdr.de>; Thu,  7 May 2020 20:11:22 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728229AbgEGSKw (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Thu, 7 May 2020 14:10:52 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55658 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-FAIL-OK-FAIL)
        by vger.kernel.org with ESMTP id S1728487AbgEGSKr (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Thu, 7 May 2020 14:10:47 -0400
Received: from mail-qv1-xf4a.google.com (mail-qv1-xf4a.google.com [IPv6:2607:f8b0:4864:20::f4a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 18C53C05BD09
        for <linux-pm@vger.kernel.org>; Thu,  7 May 2020 11:10:46 -0700 (PDT)
Received: by mail-qv1-xf4a.google.com with SMTP id d4so6641747qva.16
        for <linux-pm@vger.kernel.org>; Thu, 07 May 2020 11:10:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:in-reply-to:message-id:mime-version:references:subject:from:to
         :cc;
        bh=tQJRWNXZ73jupkckFeVqSyiJPuHFNUXk3losPzo+jg0=;
        b=OJ5DdgiCF2sqkpLYesteMXNORwEGKDR0Y0KA0Y5rnVPYA7hNXSv1oL/MShKoOyUxtV
         ry7nKG2JXxTPRL9bLbxFdeT9Y2YqTlL4Fei31TaPiPOjMOkdUPfTils+SnDcvYFhfDJQ
         jjCzkIM36yfW/s841TyY6iK9sscitEH4sJ4DlMMBcV5YAQU5KOKQLO1T6Aa31KbeLycu
         LgOLgeWtLfvKc7O1SaUqq8AjMtDmYgxHFLOcjWdmib1seFPbUx4qpqmtUeU2/m1tBGXO
         m3ec7zNB0QRGtS6NtlA9VDThwYF7JCq4VENLUDeG20hKDR8IlSt+VL8f+ePs8xq03gJ3
         LoJg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:in-reply-to:message-id:mime-version
         :references:subject:from:to:cc;
        bh=tQJRWNXZ73jupkckFeVqSyiJPuHFNUXk3losPzo+jg0=;
        b=QhXUSHTfdMBm7Sf516YbyA/EEgbtfVbot0aoujQQgPq7tkvPwDYnMpuLY1ZIe/SclK
         YEuqzs+ZCJH/gWIIQVH03Pq6Ge2+5FvlUOMIHFlYnLhFBBeP/B8OhRjNBH8gn7H+314i
         2oBaJ1YVRIGAbpuhmPxZqfB1J3K7vCkWucbUYU8/bq6v9/KBhnYbkhwuIK3kxNDDEPQb
         2VQOiSuBd7DfngtRQ4qzILVxxcark97GEaoJlDccR99HNoMfzCK+I+9cyfW2seeN87MV
         +G2ao43iuaBTdkTy3USFK3M8xB4fVmU7QPZ0Fe7B9JCrsA9N+eCCkt28C+Xa2F3jvZG3
         f/mA==
X-Gm-Message-State: AGi0PuaXbwF6r35NN4AVxQx9KzX+OLWwqQ1lQZtBcmZESpGwx53RrzG0
        ITi3tfBbp5rORJYcw8hynuuIhx9712jz
X-Google-Smtp-Source: APiQypLWF74i2ubQ61UdlGU8XHa46X4VRO8h//dR1bpYaMIS2zPs03r4Fxjeh4NMjh22GrvVAsE+nhm84qFL
X-Received: by 2002:ad4:58eb:: with SMTP id di11mr14503909qvb.39.1588875045240;
 Thu, 07 May 2020 11:10:45 -0700 (PDT)
Date:   Thu,  7 May 2020 19:10:12 +0100
In-Reply-To: <20200507181012.29791-1-qperret@google.com>
Message-Id: <20200507181012.29791-15-qperret@google.com>
Mime-Version: 1.0
References: <20200507181012.29791-1-qperret@google.com>
X-Mailer: git-send-email 2.26.2.526.g744177e7f7-goog
Subject: [PATCH 14/14] sched: cpufreq: Modularize schedutil
From:   Quentin Perret <qperret@google.com>
To:     linux-kernel@vger.kernel.org, linux-pm@vger.kernel.org
Cc:     tglx@linutronix.de, mingo@redhat.com, bp@alien8.de, x86@kernel.org,
        hpa@zytor.com, sudeep.holla@arm.com, gregkh@linuxfoundation.org,
        rafael@kernel.org, viresh.kumar@linaro.org, peterz@infradead.org,
        juri.lelli@redhat.com, vincent.guittot@linaro.org,
        dietmar.eggemann@arm.com, rostedt@goodmis.org, bsegall@google.com,
        mgorman@suse.de, mcgrof@kernel.org, keescook@chromium.org,
        yzaikin@google.com, fweisbec@gmail.com, tkjos@google.com,
        kernel-team@android.com, qperret@google.com
Content-Type: text/plain; charset="UTF-8"
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

Now that all requirements to modularize schedutil are met, make the
Kconfig option tristate and add the missing MODULE_*() declarations in
cpufreq_schedutil.c.

Signed-off-by: Quentin Perret <qperret@google.com>
---
 drivers/cpufreq/Kconfig          |  2 +-
 kernel/sched/cpufreq_schedutil.c | 15 ++++++++++-----
 2 files changed, 11 insertions(+), 6 deletions(-)

diff --git a/drivers/cpufreq/Kconfig b/drivers/cpufreq/Kconfig
index c3e6bd59e920..49942f422a57 100644
--- a/drivers/cpufreq/Kconfig
+++ b/drivers/cpufreq/Kconfig
@@ -185,7 +185,7 @@ config CPU_FREQ_GOV_CONSERVATIVE
 	  If in doubt, say N.
 
 config CPU_FREQ_GOV_SCHEDUTIL
-	bool "'schedutil' cpufreq policy governor"
+	tristate "'schedutil' cpufreq policy governor"
 	depends on CPU_FREQ && SMP
 	select CPU_FREQ_GOV_ATTR_SET
 	select IRQ_WORK
diff --git a/kernel/sched/cpufreq_schedutil.c b/kernel/sched/cpufreq_schedutil.c
index aeb04cc5b740..ea2778422efd 100644
--- a/kernel/sched/cpufreq_schedutil.c
+++ b/kernel/sched/cpufreq_schedutil.c
@@ -786,15 +786,20 @@ struct cpufreq_governor schedutil_gov = {
 #endif /* CONFIG_ENERGY_MODEL */
 };
 
+static int __init sugov_register(void)
+{
+	return cpufreq_register_governor(&schedutil_gov);
+}
+
 #ifdef CONFIG_CPU_FREQ_DEFAULT_GOV_SCHEDUTIL
 struct cpufreq_governor *cpufreq_default_governor(void)
 {
 	return &schedutil_gov;
 }
+core_initcall(sugov_register);
+#else
+module_init(sugov_register);
 #endif
 
-static int __init sugov_register(void)
-{
-	return cpufreq_register_governor(&schedutil_gov);
-}
-core_initcall(sugov_register);
+MODULE_LICENSE("GPL v2");
+MODULE_DESCRIPTION("Schedutil CPUFreq Governor");
-- 
2.26.2.526.g744177e7f7-goog

