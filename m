Return-Path: <linux-pm+bounces-6076-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 65C5789CF5F
	for <lists+linux-pm@lfdr.de>; Tue,  9 Apr 2024 02:31:57 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id D34161F248D2
	for <lists+linux-pm@lfdr.de>; Tue,  9 Apr 2024 00:31:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 929DF3C24;
	Tue,  9 Apr 2024 00:31:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="WSwC/ZMA"
X-Original-To: linux-pm@vger.kernel.org
Received: from mail-yb1-f172.google.com (mail-yb1-f172.google.com [209.85.219.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D11F417D2
	for <linux-pm@vger.kernel.org>; Tue,  9 Apr 2024 00:31:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712622709; cv=none; b=WSI/imOobycEBlgjE/xuoDcLB5lotJw2xZLjO6WkN20sfT9eK/4pSlHu8JRCU6l25K30BrgssRVUafUsvXCraeNKsZd0yFEcfdxaBOTGOodpdy15MqG5PCDiq1rksM8hOPHmBSkZ16IwUbF1N41VAr36vYfUVsQr8fv3WYa/kNo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712622709; c=relaxed/simple;
	bh=Qrec6LdBa8lKApv6AUWq12pEOZLy/9qWUW7S+j7BiT0=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=qJk603NSWz00QSnEuQIPTje4Deb+5HuSOvgFbvqaw+GcIQK5C3fpaem+n0Ycrjz35wHEfGKdtuWqUMZmeRl+di0ugRjvMOzNuZzn71aND19cNLdmlJxyT7Pra6MiXLgzJ22wYyPOrxtLmLJeypwbkcVJr++3g5zx7mPEiIR5fDc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=WSwC/ZMA; arc=none smtp.client-ip=209.85.219.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-yb1-f172.google.com with SMTP id 3f1490d57ef6-dcc80d6006aso4934494276.0
        for <linux-pm@vger.kernel.org>; Mon, 08 Apr 2024 17:31:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1712622706; x=1713227506; darn=vger.kernel.org;
        h=content-transfer-encoding:organization:reply-to:mime-version
         :references:in-reply-to:message-id:date:subject:cc:to:from:sender
         :from:to:cc:subject:date:message-id:reply-to;
        bh=mtSu0tPNXIoKlH63yvobUtWDht4hPMvy7tqne4fVRlk=;
        b=WSwC/ZMAzoeywl0HaVGc4c3qOMcXeJlvwvphcralcxHyjtKZASUyldFpYsFDSyLaf/
         07UmCTvq/KYCS0VlQHV+jOvHFCHj8GvJ3d25IYD8dX9C7FFf00F0b13J53I6goh/b8pq
         TO77C/Hb+aK9SRBvHPhRRF7IwCovaAQ6ERsWwM5S40vj3oT2kyu83h6lFfGFsmbz16u8
         q+9ZVNEmMEoWnSwVEMzUXlvYv2WlsvidDJsWhJhQ1xyBFYKJJbFq4c45ONkZapKDFR7i
         BHOizB4rFCOCK4Mu6IpdxzSY87bBUJBv2hzcDiORM1IG2akUqhbztjv3trnRjhdGzf6t
         aLWA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1712622706; x=1713227506;
        h=content-transfer-encoding:organization:reply-to:mime-version
         :references:in-reply-to:message-id:date:subject:cc:to:from:sender
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=mtSu0tPNXIoKlH63yvobUtWDht4hPMvy7tqne4fVRlk=;
        b=pU3FQsbcfdi7RN+zZodyzM4IN3ZDn0eyMKpIgyn3floNbaWnMrWgktyoo2od1tfCSU
         eoDUCctVhQD11OWbNhF3h5ePBGfNSQWjkg+qNnbjZZ5utpIZSiaDluYJr2xJzpkjZicv
         FIGvGi3Ui/i3UdrWW0W7UhGWghMDB9npgZBhLBp8nuRv7AjNTxUYP8ubsa6fgV7fGCEx
         iRXhHNBAyBN0p1vcoFmXIlrUUkFC041ks/2b2r6DuBUUiXwLfsf8lHS4L/wzgC7vf6FX
         vSxKtbcYznrQcoPA8Eko9vOlDCzZ0rw4766ngvXhFr3NHkNj1t2+rdpDn00DF6DTfroy
         sykw==
X-Gm-Message-State: AOJu0YyzGNzTbQa7V0MOVNGkMmqSqe3eghIoOFwqAcWv120VLDP9sG9b
	hkBJFadOfmBC9/Cpm/wYYj5720JM0UtPo1rnTEYVlnMgGZKG1FBWoI3CrdZ/
X-Google-Smtp-Source: AGHT+IE/C7KfMf8CRrZlsr3oj/lL/cIOeWwad1ZMieA/IskhkOVZq39pPlAqovOU3o9vAy8UtZvSow==
X-Received: by 2002:a25:8442:0:b0:dcc:8aaa:3ed3 with SMTP id r2-20020a258442000000b00dcc8aaa3ed3mr7927925ybm.16.1712622706630;
        Mon, 08 Apr 2024 17:31:46 -0700 (PDT)
Received: from lenb-Intel-NUC8i7HVKVA.search.charter.net (2603-9000-9f01-67cf-100c-5508-c194-b194.inf6.spectrum.com. [2603:9000:9f01:67cf:100c:5508:c194:b194])
        by smtp.gmail.com with ESMTPSA id h6-20020a25e206000000b00dc74ac54f5fsm1531949ybe.63.2024.04.08.17.31.45
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 08 Apr 2024 17:31:46 -0700 (PDT)
Sender: Len Brown <lenb417@gmail.com>
From: Len Brown <lenb@kernel.org>
To: linux-pm@vger.kernel.org
Cc: Chen Yu <yu.c.chen@intel.com>,
	Todd Brandt <todd.e.brandt@intel.com>,
	Len Brown <len.brown@intel.com>
Subject: [PATCH 04/26] tools/power turbostat: Do not print negative LPI residency
Date: Mon,  8 Apr 2024 20:30:58 -0400
Message-Id: <227ed18f456a68bbb69807294a9089208663a6d3.1712621427.git.len.brown@intel.com>
X-Mailer: git-send-email 2.40.1
In-Reply-To: <e5f4e68eed85fa8495d78cd966eecc2b27bb9e53.1712621427.git.len.brown@intel.com>
References: <e5f4e68eed85fa8495d78cd966eecc2b27bb9e53.1712621427.git.len.brown@intel.com>
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Reply-To: Len Brown <lenb@kernel.org>
Organization: Intel Open Source Technology Center
Content-Transfer-Encoding: 8bit

From: Chen Yu <yu.c.chen@intel.com>

turbostat prints the abnormal SYS%LPI across suspend-to-idle:
SYS%LPI = 114479815993277.50

This is reproduced by:
Run a freeze cycle, e.g. "sleepgraph -m freeze -rtcwake 15".
Then do a reboot. After boot up, launch the suspend-idle-idle
and check the SYS%LPI field.

The slp_so residence counter is in LPIT table, and BIOS does not
clears this register across reset. The PMC expects the OS to calculate
the LPI residency based on the delta. However, there is an firmware
issue that the LPIT gets cleared to 0 during the second suspend
to idle after the reboot, which brings negative delta value.

[lenb: updated to print "neg" upon this BIOS failure]

Reported-by: Todd Brandt <todd.e.brandt@intel.com>
Signed-off-by: Chen Yu <yu.c.chen@intel.com>
Signed-off-by: Len Brown <len.brown@intel.com>
---
 tools/power/x86/turbostat/turbostat.c | 30 +++++++++++++++++++--------
 1 file changed, 21 insertions(+), 9 deletions(-)

diff --git a/tools/power/x86/turbostat/turbostat.c b/tools/power/x86/turbostat/turbostat.c
index 2550a0e35914..c23703dd54aa 100644
--- a/tools/power/x86/turbostat/turbostat.c
+++ b/tools/power/x86/turbostat/turbostat.c
@@ -991,8 +991,8 @@ struct pkg_data {
 	unsigned long long pc8;
 	unsigned long long pc9;
 	unsigned long long pc10;
-	unsigned long long cpu_lpi;
-	unsigned long long sys_lpi;
+	long long cpu_lpi;
+	long long sys_lpi;
 	unsigned long long pkg_wtd_core_c0;
 	unsigned long long pkg_any_core_c0;
 	unsigned long long pkg_any_gfxe_c0;
@@ -1978,12 +1978,22 @@ int format_counters(struct thread_data *t, struct core_data *c, struct pkg_data
 	if (DO_BIC(BIC_Pkgpc10))
 		outp += sprintf(outp, "%s%.2f", (printed++ ? delim : ""), 100.0 * p->pc10 / tsc);
 
-	if (DO_BIC(BIC_CPU_LPI))
-		outp +=
-		    sprintf(outp, "%s%.2f", (printed++ ? delim : ""), 100.0 * p->cpu_lpi / 1000000.0 / interval_float);
-	if (DO_BIC(BIC_SYS_LPI))
-		outp +=
-		    sprintf(outp, "%s%.2f", (printed++ ? delim : ""), 100.0 * p->sys_lpi / 1000000.0 / interval_float);
+	if (DO_BIC(BIC_CPU_LPI)) {
+		if (p->cpu_lpi >= 0)
+			outp +=
+			    sprintf(outp, "%s%.2f", (printed++ ? delim : ""),
+				    100.0 * p->cpu_lpi / 1000000.0 / interval_float);
+		else
+			outp += sprintf(outp, "%s(neg)", (printed++ ? delim : ""));
+	}
+	if (DO_BIC(BIC_SYS_LPI)) {
+		if (p->sys_lpi >= 0)
+			outp +=
+			    sprintf(outp, "%s%.2f", (printed++ ? delim : ""),
+				    100.0 * p->sys_lpi / 1000000.0 / interval_float);
+		else
+			outp += sprintf(outp, "%s(neg)", (printed++ ? delim : ""));
+	}
 
 	if (DO_BIC(BIC_PkgWatt))
 		outp +=
@@ -3832,7 +3842,8 @@ void re_initialize(void)
 {
 	free_all_buffers();
 	setup_all_buffers(false);
-	fprintf(outf, "turbostat: re-initialized with num_cpus %d, allowed_cpus %d\n", topo.num_cpus, topo.allowed_cpus);
+	fprintf(outf, "turbostat: re-initialized with num_cpus %d, allowed_cpus %d\n", topo.num_cpus,
+		topo.allowed_cpus);
 }
 
 void set_max_cpu_num(void)
@@ -6145,6 +6156,7 @@ void topology_update(void)
 	topo.allowed_packages = 0;
 	for_all_cpus(update_topo, ODD_COUNTERS);
 }
+
 void setup_all_buffers(bool startup)
 {
 	topology_probe(startup);
-- 
2.40.1


