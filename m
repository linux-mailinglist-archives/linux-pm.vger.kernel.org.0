Return-Path: <linux-pm+bounces-20977-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 820EFA1D7C0
	for <lists+linux-pm@lfdr.de>; Mon, 27 Jan 2025 15:07:27 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id E2ADA3A572F
	for <lists+linux-pm@lfdr.de>; Mon, 27 Jan 2025 14:07:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EA2311FE475;
	Mon, 27 Jan 2025 14:07:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=rjwysocki.net header.i=@rjwysocki.net header.b="d4o4ybTk"
X-Original-To: linux-pm@vger.kernel.org
Received: from cloudserver094114.home.pl (cloudserver094114.home.pl [79.96.170.134])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6ADDC3FC7;
	Mon, 27 Jan 2025 14:07:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=79.96.170.134
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1737986842; cv=none; b=URM7WO9U2BmlvAd/b/v8+rP/J1cEUEYlMVtylrDSdxmIZsv9bhvTHivIdpcL8eav7ZMVnA0+LcxciC3mEEHvo71dX8YnOMoW/uNnfbLw7FERSALX1bks+EMfgRl8/Ztc5hMls2+LNyipP5LcrYKefc83xE7KZFHLE9rO9zq6GeA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1737986842; c=relaxed/simple;
	bh=0F3FRdFiSGOlt41j8M+xL9TzE32cIa1SGT07wkPJVZw=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version:Content-Type; b=RIUWEJUIO7tXns9wy93pS+6JFXJuIRQZassWmGK0p5ht+HHNQFk3+jgQ2fNE9bBsrMth4T+oAN7/YyfTMF5FUEHoKkWVgmnWKBjetBqPVC+jKB0wMFvEXTMTqKhttRtnMdJYAkf8WHRWwdZMnCRK5iZ6iCb4TAta83rpD+WB8Es=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=rjwysocki.net; spf=pass smtp.mailfrom=rjwysocki.net; dkim=pass (2048-bit key) header.d=rjwysocki.net header.i=@rjwysocki.net header.b=d4o4ybTk; arc=none smtp.client-ip=79.96.170.134
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=rjwysocki.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=rjwysocki.net
Received: from localhost (127.0.0.1) (HELO v370.home.net.pl)
 by /usr/run/smtp (/usr/run/postfix/private/idea_relay_lmtp) via UNIX with SMTP (IdeaSmtpServer 6.2.1)
 id 61a12ffa503a9475; Mon, 27 Jan 2025 14:07:18 +0100
Received: from kreacher.localnet (unknown [195.136.19.94])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by cloudserver094114.home.pl (Postfix) with ESMTPSA id 8608E7524A4;
	Mon, 27 Jan 2025 14:07:17 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=rjwysocki.net;
	s=dkim; t=1737983238;
	bh=0F3FRdFiSGOlt41j8M+xL9TzE32cIa1SGT07wkPJVZw=;
	h=From:Subject:Date;
	b=d4o4ybTkhqQU3fBqSSTIPrIJ1wLGso96/pIspN7oqw6ONovqTl1nyPIKmiMAuzRId
	 yjS6jzDmUM4tTtudqkZl0RkCT+nmTtyimX9t6u0+16SGIYe3ZxO/c7M+XQbFJ8yG2G
	 JUIv7OMt5bbNmmDc3GtLE9GQKjrhrHxBRvcNep5D3Wuj+1LnYlJT2IMgaqGtRLycBP
	 THruDJYfPpmI+6W75nxtHzEdhalBPodhmnEmMIhRLNBMfwvQ6C0mUxLRFZie8+Z5q1
	 8T2dUEB5uMIx/5AfqZDmlv0guThku3y/KUUBqMi2zUhKOpB7gCDuWwd92ZwR7R925v
	 YapfsWhVk90hw==
From: "Rafael J. Wysocki" <rjw@rjwysocki.net>
To: Linux PM <linux-pm@vger.kernel.org>
Cc: LKML <linux-kernel@vger.kernel.org>,
 Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>,
 Zhang Rui <rui.zhang@intel.com>
Subject:
 [PATCH v1] cpufreq: intel_pstate: Make it possible to avoid enabling CAS
Date: Mon, 27 Jan 2025 14:07:12 +0100
Message-ID: <2781262.mvXUDI8C0e@rjwysocki.net>
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 7Bit
Content-Type: text/plain; charset="UTF-8"
X-CLIENT-IP: 195.136.19.94
X-CLIENT-HOSTNAME: 195.136.19.94
X-VADE-SPAMSTATE: clean
X-VADE-SPAMCAUSE: gggruggvucftvghtrhhoucdtuddrgeefuddrudejgedgudefvdegucetufdoteggodetrfdotffvucfrrhhofhhilhgvmecujffqoffgrffnpdggtffipffknecuuegrihhlohhuthemucduhedtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenucfjughrpefhvfevufffkfgggfgtsehtufertddttdejnecuhfhrohhmpedftfgrfhgrvghlucflrdcuhgihshhotghkihdfuceorhhjfiesrhhjfiihshhotghkihdrnhgvtheqnecuggftrfgrthhtvghrnhepffffffekgfehheffleetieevfeefvefhleetjedvvdeijeejledvieehueevueffnecukfhppeduleehrddufeeirdduledrleegnecuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehinhgvthepudelhedrudefiedrudelrdelgedphhgvlhhopehkrhgvrggthhgvrhdrlhhotggrlhhnvghtpdhmrghilhhfrhhomheprhhjfiesrhhjfiihshhotghkihdrnhgvthdpnhgspghrtghpthhtohepgedprhgtphhtthhopehlihhnuhigqdhpmhesvhhgvghrrdhkvghrnhgvlhdrohhrghdprhgtphhtthhopehlihhnuhigqdhkvghrnhgvlhesvhhgvghrrdhkvghrnhgvlhdrohhrghdprhgtphhtthhopehsrhhinhhivhgrshdrphgrnhgurhhuvhgruggrsehlihhnuhigrdhinhhtvghlrdgtohhmpdhrtghpthhtoheprhhuihdriihhrghnghesihhnthgvlhdrtghomh
X-DCC--Metrics: v370.home.net.pl 1024; Body=4 Fuz1=4 Fuz2=4

From: Rafael J. Wysocki <rafael.j.wysocki@intel.com>

Capacity-aware scheduling (CAS) is enabled by default by intel_pstate on
hybrid systems without SMT, but in some usage scenarios it may be more
attractive to place tasks for maximum CPU performance regardless of the
extra cost in terms of energy, which is the case on such systems when
CAS is not enabled, so introduce a command line option to forbid
intel_pstate to enable CAS.

Signed-off-by: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
---
 Documentation/admin-guide/kernel-parameters.txt |    3 +++
 Documentation/admin-guide/pm/intel_pstate.rst   |    3 +++
 drivers/cpufreq/intel_pstate.c                  |    9 +++++++++
 3 files changed, 15 insertions(+)

--- a/Documentation/admin-guide/kernel-parameters.txt
+++ b/Documentation/admin-guide/kernel-parameters.txt
@@ -2295,6 +2295,9 @@
 			per_cpu_perf_limits
 			  Allow per-logical-CPU P-State performance control limits using
 			  cpufreq sysfs interface
+			no_cas
+			  Do not enable capacity-aware scheduling (CAS) on
+			  hybrid systems
 
 	intremap=	[X86-64,Intel-IOMMU,EARLY]
 			on	enable Interrupt Remapping (default)
--- a/Documentation/admin-guide/pm/intel_pstate.rst
+++ b/Documentation/admin-guide/pm/intel_pstate.rst
@@ -696,6 +696,9 @@
 	Use per-logical-CPU P-State limits (see `Coordination of P-state
 	Limits`_ for details).
 
+``no_cas``
+	Do not enable capacity-aware scheduling (CAS) which is enabled by
+	default on hybrid systems.
 
 Diagnostics and Tuning
 ======================
--- a/drivers/cpufreq/intel_pstate.c
+++ b/drivers/cpufreq/intel_pstate.c
@@ -936,6 +936,8 @@
 	NULL,
 };
 
+static bool no_cas __ro_after_init;
+
 static struct cpudata *hybrid_max_perf_cpu __read_mostly;
 /*
  * Protects hybrid_max_perf_cpu, the capacity_perf fields in struct cpudata,
@@ -1041,6 +1043,10 @@
 
 static void hybrid_init_cpu_capacity_scaling(bool refresh)
 {
+	/* Bail out if enabling capacity-aware scheduling is prohibited. */
+	if (no_cas)
+		return;
+
 	/*
 	 * If hybrid_max_perf_cpu is set at this point, the hybrid CPU capacity
 	 * scaling has been enabled already and the driver is just changing the
@@ -3835,6 +3841,9 @@
 	if (!strcmp(str, "no_hwp"))
 		no_hwp = 1;
 
+	if (!strcmp(str, "no_cas"))
+		no_cas = true;
+
 	if (!strcmp(str, "force"))
 		force_load = 1;
 	if (!strcmp(str, "hwp_only"))




