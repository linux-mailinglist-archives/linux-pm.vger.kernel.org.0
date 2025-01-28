Return-Path: <linux-pm+bounces-21018-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id AB0EBA20BC8
	for <lists+linux-pm@lfdr.de>; Tue, 28 Jan 2025 15:12:04 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id E969C3A3FC7
	for <lists+linux-pm@lfdr.de>; Tue, 28 Jan 2025 14:11:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BD2A81A9B52;
	Tue, 28 Jan 2025 14:11:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="BkQI/YJQ"
X-Original-To: linux-pm@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 11CCE1A8F79
	for <linux-pm@vger.kernel.org>; Tue, 28 Jan 2025 14:11:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1738073517; cv=none; b=P3bkx7WI2lAR7vXCA48hDKxltFVhewZx68dr6YnUDcQY5oUWZlG3FWdnKlMivHo84Mx0Ju5iTtpxpGYFbYcJo0xCTp5nCWCKac8pMYui86BHlNXTSwiortsK58/ZVsAgYIZfaaM02ipm8Yp846ElBx/5p4lN1rcDEuXGd7O2fW4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1738073517; c=relaxed/simple;
	bh=4QAS8Yya/YglxdPrX7EdoErmPK5DoXGXlvU07eCU7to=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=XPe38BIQCaAcrj2zhaWq5hnDToGWAmfcgGAqB+djBuKRm5SzsFu6NAbRJyAO4Bxg90eV62fOcCXabgolK/A58/w4WzBPPXXtgcyiOcKbeVxBhs309vGqY0CHdYcV+GNWF/xE9sJ/MJwKTavt1HcZz10EZVTEsMn2J7b4lPKsbAw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=BkQI/YJQ; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1738073515;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding;
	bh=ggFKz2J7jLR0vcLpN1vbxhgEE+/3A/H4er4tPstc3/w=;
	b=BkQI/YJQZi+eKcg1r6lMDOdlcpY64Uevf0p4YeQptM5JOIktaFDgQXEk45kNX5lpzjVJj6
	uLfMK6OKEZPs3I8CTCz1IG7gmGR2Av5jg7aasU303K3NsELqp7IJZ7DpRVdl7FF84ZpMI2
	V40Nit8PIhj41+CsyfN7Taf2aBvR6Qg=
Received: from mx-prod-mc-08.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-383-YyY4FFj4NC-wKg6XiZJ4cg-1; Tue,
 28 Jan 2025 09:11:50 -0500
X-MC-Unique: YyY4FFj4NC-wKg6XiZJ4cg-1
X-Mimecast-MFC-AGG-ID: YyY4FFj4NC-wKg6XiZJ4cg
Received: from mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.93])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-08.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 496491801F21;
	Tue, 28 Jan 2025 14:11:49 +0000 (UTC)
Received: from dba-icx.bos.redhat.com (prarit2023-dbaguest.khw.eng.bos2.dc.redhat.com [10.26.1.94])
	by mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP id 7F7081800268;
	Tue, 28 Jan 2025 14:11:47 +0000 (UTC)
From: David Arcari <darcari@redhat.com>
To: linux-pm@vger.kernel.org
Cc: David Arcari <darcari@redhat.com>,
	Jonathan Corbet <corbet@lwn.net>,
	Jacob Pan <jacob.jun.pan@linux.intel.com>,
	Len Brown <lenb@kernel.org>,
	Prarit Bhargava <prarit@redhat.com>,
	linux-doc@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH] intel_idle: introduce 'use_acpi_cst' module parameter
Date: Tue, 28 Jan 2025 09:11:39 -0500
Message-ID: <20250128141139.2033088-1-darcari@redhat.com>
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.93

Since commit 18734958e9bf ("intel_idle: Use ACPI _CST for processor models
without C-state tables")the intel_idle driver has had the ability to use
the ACPI _CST to populate C-states when the processor model is not
recognized. However, even when the processor model is recognized there are
cases where it is useful to make the driver ignore the per cpu idle states
in lieu of ACPI C-states (such as specific application performance). Add
the 'use_acpi_cst' module parameter to provide this functionality (not to
be confused with the 'use_acpi' module parameter which has a different
function).

Cc: Jonathan Corbet <corbet@lwn.net>
Cc: Jacob Pan <jacob.jun.pan@linux.intel.com>
Cc: Len Brown <lenb@kernel.org>
Cc: David Arcari <darcari@redhat.com>
Cc: Prarit Bhargava <prarit@redhat.com>
Cc: linux-doc@vger.kernel.org
Cc: linux-kernel@vger.kernel.org
Signed-off-by: David Arcari <darcari@redhat.com>
---
 Documentation/admin-guide/pm/intel_idle.rst |  5 +++++
 drivers/idle/intel_idle.c                   | 11 +++++++++++
 2 files changed, 16 insertions(+)

diff --git a/Documentation/admin-guide/pm/intel_idle.rst b/Documentation/admin-guide/pm/intel_idle.rst
index 39bd6ecce7de..a87238bcf33d 100644
--- a/Documentation/admin-guide/pm/intel_idle.rst
+++ b/Documentation/admin-guide/pm/intel_idle.rst
@@ -198,6 +198,11 @@ driver ignore the system's ACPI tables entirely or use them for all of the
 recognized processor models, respectively (they both are unset by default and
 ``use_acpi`` has no effect if ``no_acpi`` is set).
 
+The ``use_acpi_cst`` module parameter (recognized by ``intel_idle`` if the
+kernel has been configured with ACPI support) can be set to make the driver
+ignore the per cpu idle states in lieu of ACPI idle states. ``use_acpi_cst``
+has no effect if ``no_acpi`` is set).
+
 The value of the ``states_off`` module parameter (0 by default) represents a
 list of idle states to be disabled by default in the form of a bitmask.
 
diff --git a/drivers/idle/intel_idle.c b/drivers/idle/intel_idle.c
index 118fe1d37c22..b8a536b930e7 100644
--- a/drivers/idle/intel_idle.c
+++ b/drivers/idle/intel_idle.c
@@ -1695,6 +1695,10 @@ static bool force_use_acpi __read_mostly; /* No effect if no_acpi is set. */
 module_param_named(use_acpi, force_use_acpi, bool, 0444);
 MODULE_PARM_DESC(use_acpi, "Use ACPI _CST for building the idle states list");
 
+static bool use_acpi_cst __read_mostly; /* No effect if no_acpi is set. */
+module_param_named(use_acpi_cst, use_acpi_cst, bool, 0444);
+MODULE_PARM_DESC(use_acpi_cst, "Ignore cpu specific idle states in lieu of ACPI idle states");
+
 static struct acpi_processor_power acpi_state_table __initdata;
 
 /**
@@ -1836,6 +1840,7 @@ static bool __init intel_idle_off_by_default(unsigned int flags, u32 mwait_hint)
 }
 #else /* !CONFIG_ACPI_PROCESSOR_CSTATE */
 #define force_use_acpi	(false)
+#define use_acpi_cst	(false)
 
 static inline bool intel_idle_acpi_cst_extract(void) { return false; }
 static inline void intel_idle_init_cstates_acpi(struct cpuidle_driver *drv) { }
@@ -2328,6 +2333,12 @@ static int __init intel_idle_init(void)
 	pr_debug("MWAIT substates: 0x%x\n", mwait_substates);
 
 	icpu = (const struct idle_cpu *)id->driver_data;
+	if (use_acpi_cst && !no_acpi) {
+		if (icpu) {
+			pr_debug("ignoring cpu idle states\n");
+			icpu = NULL;
+		}
+	}
 	if (icpu) {
 		if (icpu->state_table)
 			cpuidle_state_table = icpu->state_table;
-- 
2.47.0


