Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 0A98AA57B6
	for <lists+linux-pm@lfdr.de>; Mon,  2 Sep 2019 15:35:53 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730629AbfIBNfw (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Mon, 2 Sep 2019 09:35:52 -0400
Received: from mail-wm1-f65.google.com ([209.85.128.65]:50438 "EHLO
        mail-wm1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730626AbfIBNfw (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Mon, 2 Sep 2019 09:35:52 -0400
Received: by mail-wm1-f65.google.com with SMTP id c10so2722580wmc.0;
        Mon, 02 Sep 2019 06:35:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=4IZYZ9SbbmiPIjFQQI3+tSC3aTTev4F8DX/N/W2gHEU=;
        b=WgoZsB17OsI8b1BPxf2haYOv230TxFH5zo/P7pAa6FFCwGCxOCHDi3jZZFjE+kJQRq
         1Bj8+IRGAbpqLrYL3MJdHGgzQySVIeT7b+gSj0wgfopR+sJ4pGvVDj/DhLfQ/fURh5Tb
         WXx90oCHGaYyg7BPNIF4vk3mK8rwvM9Llan4vwVrBdLszjUCoO69N/puRqhwiXQ4sSYO
         m1UUWZrhvgzcakY1vZAqz41vOPSg12J2JKhY+d9R911YteyvdGgaUnKK0Ke/aHMvsrlU
         CUvEbhystl1J0cxR8QN4nWJK/kSI9yQkQp6ny2Akh2lzoIBuoqFoOXhGAvyYZHH7tuR7
         ym5A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=4IZYZ9SbbmiPIjFQQI3+tSC3aTTev4F8DX/N/W2gHEU=;
        b=KzZ3jjUBQmLnhvNDRdTsEpIerVQ0S0oHzcfJeLCYyUj8+EahsW7Ie1rblXqZFbfH+v
         yMFJx5rqa07uP/PnS8816uCjEiM0dcz6wEYp5dY+v0MSMF1lZAlth88s+mq3Cz0t1MmI
         B88lqHtwy5Ie3Xl152s7mJDdPIhCybwqVx9cZnbjoHqMKUZ1oglon9+1o3PLUiqMiIPd
         MTorI5QdZYgH6DaQmz4uBaHpmCMH1KSjjOAo6omS6sDTAvdMLQI+02giXCyCPVIee4mx
         l8nbFOwR5pKrpTnD/sqv/KRj6yI6dlTmozSaPsk8jg0zN1A9y3qCpemAStzibGpOn6Df
         oMtQ==
X-Gm-Message-State: APjAAAWazOjJqdpvsF5GB06Wc2GCEezflRo0vsliNRdqRY67xTGSyi2D
        Vb5n2D95K37Jh/o/FPB92cM=
X-Google-Smtp-Source: APXvYqwzsJg7dJuqKEwIzVF50xAcslHhSLNS1ZuTGK9sjM8Uo68LREuLh2tlKO5iFRAzdobmqPoP9g==
X-Received: by 2002:a7b:cd17:: with SMTP id f23mr36832272wmj.177.1567431349811;
        Mon, 02 Sep 2019 06:35:49 -0700 (PDT)
Received: from localhost.localdomain ([2a01:e34:eecb:7400:8425:c99f:73d7:9637])
        by smtp.gmail.com with ESMTPSA id f75sm21640290wmf.2.2019.09.02.06.35.48
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 02 Sep 2019 06:35:49 -0700 (PDT)
From:   Erwan Velu <erwanaliasr1@gmail.com>
X-Google-Original-From: Erwan Velu <e.velu@criteo.com>
Cc:     Erwan Velu <e.velu@criteo.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
        "H. Peter Anvin" <hpa@zytor.com>, x86@kernel.org,
        Len Brown <lenb@kernel.org>,
        Paolo Bonzini <pbonzini@redhat.com>,
        Luwei Kang <luwei.kang@intel.com>,
        "Peter Zijlstra (Intel)" <peterz@infradead.org>,
        Andi Kleen <ak@linux.intel.com>,
        Chao Peng <chao.p.peng@linux.intel.com>,
        Fenghua Yu <fenghua.yu@intel.com>,
        Tim Chen <tim.c.chen@linux.intel.com>,
        linux-kernel@vger.kernel.org, linux-pm@vger.kernel.org
Subject: [PATCH] tools/power/x86/turbostat: Reporting EPB as per Intel's spec
Date:   Mon,  2 Sep 2019 15:35:07 +0200
Message-Id: <20190902133509.24534-1-e.velu@criteo.com>
X-Mailer: git-send-email 2.21.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
To:     unlisted-recipients:; (no To-header on input)
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

The actual code is reporting the EPB mode by considering a single value,
while Intel's specfication defines ranges.

This patch is about to report the EPB by considering ranges of energy_policy
to actually report the state of the processor.

This avoids reporting a "custom" value while the specification describes
an explicit state of the processor for each value.

0-3  : Maximum performance
4-7  : Balanced Performance
8-11 : Balanced Efficiency
12-15: Powersave

This patch also introduce ENERGY_PERF_BIAS_MIN_POWERSAVE.
The first 3 performance profiles (ENERGY_PERF_BIAS_PERFORMANCE,
ENERGY_PERF_BIAS_BALANCE_PERFORMANCE, ENERGY_PERF_BIAS_BALANCE_POWERSAVE) where defined
by the lowest value of the associate range while ENERGY_PERF_BIAS_POWERSAVE was
defined by the greatest value.

This was a little bit inconsistent and made more difficult to report EPB value per range.

Signed-off-by: Erwan Velu <e.velu@criteo.com>
---
 arch/x86/include/asm/msr-index.h      |  1 +
 tools/power/x86/turbostat/turbostat.c | 23 ++++++++++-------------
 2 files changed, 11 insertions(+), 13 deletions(-)

diff --git a/arch/x86/include/asm/msr-index.h b/arch/x86/include/asm/msr-index.h
index 271d837d69a8..120073dfb195 100644
--- a/arch/x86/include/asm/msr-index.h
+++ b/arch/x86/include/asm/msr-index.h
@@ -596,6 +596,7 @@
 #define ENERGY_PERF_BIAS_BALANCE_PERFORMANCE	4
 #define ENERGY_PERF_BIAS_NORMAL			6
 #define ENERGY_PERF_BIAS_BALANCE_POWERSAVE	8
+#define ENERGY_PERF_BIAS_MIN_POWERSAVE		12
 #define ENERGY_PERF_BIAS_POWERSAVE		15
 
 #define MSR_IA32_PACKAGE_THERM_STATUS		0x000001b1
diff --git a/tools/power/x86/turbostat/turbostat.c b/tools/power/x86/turbostat/turbostat.c
index 75fc4fb9901c..9fa73b468f7e 100644
--- a/tools/power/x86/turbostat/turbostat.c
+++ b/tools/power/x86/turbostat/turbostat.c
@@ -3552,6 +3552,7 @@ dump_sysfs_pstate_config(void)
 int print_epb(struct thread_data *t, struct core_data *c, struct pkg_data *p)
 {
 	unsigned long long msr;
+	unsigned int perf_bias_value;
 	char *epb_string;
 	int cpu;
 
@@ -3572,20 +3573,16 @@ int print_epb(struct thread_data *t, struct core_data *c, struct pkg_data *p)
 	if (get_msr(cpu, MSR_IA32_ENERGY_PERF_BIAS, &msr))
 		return 0;
 
-	switch (msr & 0xF) {
-	case ENERGY_PERF_BIAS_PERFORMANCE:
+	 // Reporting perf_bias_performance as per intel specification
+	perf_bias_value = msr & 0xF;
+	epb_string = "powersave";
+	if (perf_bias_value < ENERGY_PERF_BIAS_BALANCE_PERFORMANCE)
 		epb_string = "performance";
-		break;
-	case ENERGY_PERF_BIAS_NORMAL:
-		epb_string = "balanced";
-		break;
-	case ENERGY_PERF_BIAS_POWERSAVE:
-		epb_string = "powersave";
-		break;
-	default:
-		epb_string = "custom";
-		break;
-	}
+	else if (perf_bias_value < ENERGY_PERF_BIAS_BALANCE_POWERSAVE)
+		epb_string = "balanced performance";
+	else if (perf_bias_value < ENERGY_PERF_BIAS_MIN_POWERSAVE)
+		epb_string = "balanced efficiency";
+
 	fprintf(outf, "cpu%d: MSR_IA32_ENERGY_PERF_BIAS: 0x%08llx (%s)\n", cpu, msr, epb_string);
 
 	return 0;
-- 
2.21.0

