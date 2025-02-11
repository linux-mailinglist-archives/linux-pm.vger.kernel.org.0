Return-Path: <linux-pm+bounces-21834-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 6BD72A30CCD
	for <lists+linux-pm@lfdr.de>; Tue, 11 Feb 2025 14:28:09 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id DC64C16710A
	for <lists+linux-pm@lfdr.de>; Tue, 11 Feb 2025 13:28:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0EFD12206A3;
	Tue, 11 Feb 2025 13:27:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="WspafF0p"
X-Original-To: linux-pm@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5338222068A
	for <linux-pm@vger.kernel.org>; Tue, 11 Feb 2025 13:27:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739280473; cv=none; b=d8ozmVuyKD1jtM4DwtEl9d6PIukARNKRByOoOhGXx+KbArU+fk0mNafEEL/QeellRfIyyJv42PpS+iP7hBAyf6Lc+Gsksfr5t9X/2lpLx1sr3Kw3nq8D/fisyxnqR9Pl7mDktTNN3QGMbzTUySf3mbdI3BIud8SJ2Vu+Xgez7aM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739280473; c=relaxed/simple;
	bh=h0XNBmVH2rHwVIITZ3DF77VI90Renxjcse+0sCUHwtI=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=F7hdOu/8vq8fjPu1msfLXXnJbUCtrPdAGr8c4TEapS1k30dmkf+90z4WoNmQkHNiOxPPJ0YL961+V71OMTxJmcvFUkcJP3ayK8VEuZli38GoAFn8fqdFwQWIfHtmVkG4Tk7Mw5g9B7Ta0jmpWD6sL0HJWv/HorLlMXYvgR18kHs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=WspafF0p; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1739280471;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=W1JGkLkiIgxxNo1EA100iKTsesiDt4ye61qOWQSK5+M=;
	b=WspafF0pFMU3LzfRvcb8FHUgOrinaQCTDqeFlwnhrm5vi0U4qZsFsj3FX8W7NGe7huSoBn
	M99NRu3r6am7sYn96KdLW4lkBfqQWiMe9RzLYu742LPfXBOsuXfQnAIo1/haRKE0t7wzil
	Zp17nEQ3YWkx1+8QL/5p+i9LtVCjeSE=
Received: from mx-prod-mc-05.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-451-Fzof6YcaMhy-Y78tjIdcLg-1; Tue,
 11 Feb 2025 08:27:48 -0500
X-MC-Unique: Fzof6YcaMhy-Y78tjIdcLg-1
X-Mimecast-MFC-AGG-ID: Fzof6YcaMhy-Y78tjIdcLg
Received: from mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.4])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-05.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id D015119560A6;
	Tue, 11 Feb 2025 13:27:46 +0000 (UTC)
Received: from dba-icx.bos.redhat.com (prarit2023-dbaguest.khw.eng.bos2.dc.redhat.com [10.26.1.94])
	by mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP id 188D530001AB;
	Tue, 11 Feb 2025 13:27:44 +0000 (UTC)
From: David Arcari <darcari@redhat.com>
To: linux-pm@vger.kernel.org
Cc: David Arcari <darcari@redhat.com>,
	Jonathan Corbet <corbet@lwn.net>,
	Jacob Pan <jacob.jun.pan@linux.intel.com>,
	Len Brown <lenb@kernel.org>,
	Artem Bityutskiy <dedekind1@gmail.com>,
	Prarit Bhargava <prarit@redhat.com>,
	linux-doc@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH v3] intel_idle: introduce 'no_native' module parameter
Date: Tue, 11 Feb 2025 08:27:41 -0500
Message-ID: <20250211132741.99944-1-darcari@redhat.com>
In-Reply-To: <20250128141139.2033088-1-darcari@redhat.com>
References: <20250128141139.2033088-1-darcari@redhat.com>
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.4

Since commit 18734958e9bf ("intel_idle: Use ACPI _CST for processor models
without C-state tables") the intel_idle driver has had the ability to use
the ACPI _CST to populate C-states when the processor model is not
recognized. However, even when the processor model is recognized (native
mode) there are cases where it is useful to make the driver ignore the per
cpu idle states in lieu of ACPI C-states (such as specific application
performance). Add the 'no_native' module parameter to provide this
functionality.

Cc: Jonathan Corbet <corbet@lwn.net>
Cc: Jacob Pan <jacob.jun.pan@linux.intel.com>
Cc: Len Brown <lenb@kernel.org>
Cc: David Arcari <darcari@redhat.com>
Cc: Artem Bityutskiy <dedekind1@gmail.com>
Cc: Prarit Bhargava <prarit@redhat.com>
Cc: linux-doc@vger.kernel.org
Cc: linux-kernel@vger.kernel.org
Signed-off-by: David Arcari <darcari@redhat.com>
---
v3: more documentation cleanup
v2: renamed parameter, cleaned up documentation

 Documentation/admin-guide/pm/intel_idle.rst | 18 +++++++++++++-----
 drivers/idle/intel_idle.c                   | 11 +++++++++++
 2 files changed, 24 insertions(+), 5 deletions(-)

diff --git a/Documentation/admin-guide/pm/intel_idle.rst b/Documentation/admin-guide/pm/intel_idle.rst
index 39bd6ecce7de..5940528146eb 100644
--- a/Documentation/admin-guide/pm/intel_idle.rst
+++ b/Documentation/admin-guide/pm/intel_idle.rst
@@ -192,11 +192,19 @@ even if they have been enumerated (see :ref:`cpu-pm-qos` in
 Documentation/admin-guide/pm/cpuidle.rst).
 Setting ``max_cstate`` to 0 causes the ``intel_idle`` initialization to fail.
 
-The ``no_acpi`` and ``use_acpi`` module parameters (recognized by ``intel_idle``
-if the kernel has been configured with ACPI support) can be set to make the
-driver ignore the system's ACPI tables entirely or use them for all of the
-recognized processor models, respectively (they both are unset by default and
-``use_acpi`` has no effect if ``no_acpi`` is set).
+The ``no_acpi``, ``use_acpi`` and ``no_native`` module parameters are
+recognized by ``intel_idle`` if the kernel has been configured with ACPI
+support.  In the case that ACPI is not configured these flags have no impact
+on functionality.
+
+``no_acpi`` - Do not use ACPI at all.  Only native mode is available, no
+ACPI mode.
+
+``use_acpi`` - No-op in ACPI mode, the driver will consult ACPI tables for
+C-states on/off status in native mode.
+
+``no_native`` - Work only in ACPI mode, no native mode available (ignore
+all custom tables).
 
 The value of the ``states_off`` module parameter (0 by default) represents a
 list of idle states to be disabled by default in the form of a bitmask.
diff --git a/drivers/idle/intel_idle.c b/drivers/idle/intel_idle.c
index 118fe1d37c22..5e5bd3fd3064 100644
--- a/drivers/idle/intel_idle.c
+++ b/drivers/idle/intel_idle.c
@@ -1695,6 +1695,10 @@ static bool force_use_acpi __read_mostly; /* No effect if no_acpi is set. */
 module_param_named(use_acpi, force_use_acpi, bool, 0444);
 MODULE_PARM_DESC(use_acpi, "Use ACPI _CST for building the idle states list");
 
+static bool no_native __read_mostly; /* No effect if no_acpi is set. */
+module_param_named(no_native, no_native, bool, 0444);
+MODULE_PARM_DESC(no_native, "Ignore cpu specific (native) idle states in lieu of ACPI idle states");
+
 static struct acpi_processor_power acpi_state_table __initdata;
 
 /**
@@ -1836,6 +1840,7 @@ static bool __init intel_idle_off_by_default(unsigned int flags, u32 mwait_hint)
 }
 #else /* !CONFIG_ACPI_PROCESSOR_CSTATE */
 #define force_use_acpi	(false)
+#define no_native	(false)
 
 static inline bool intel_idle_acpi_cst_extract(void) { return false; }
 static inline void intel_idle_init_cstates_acpi(struct cpuidle_driver *drv) { }
@@ -2328,6 +2333,12 @@ static int __init intel_idle_init(void)
 	pr_debug("MWAIT substates: 0x%x\n", mwait_substates);
 
 	icpu = (const struct idle_cpu *)id->driver_data;
+	if (no_native && !no_acpi) {
+		if (icpu) {
+			pr_debug("ignoring native cpu idle states\n");
+			icpu = NULL;
+		}
+	}
 	if (icpu) {
 		if (icpu->state_table)
 			cpuidle_state_table = icpu->state_table;
-- 
2.48.1


