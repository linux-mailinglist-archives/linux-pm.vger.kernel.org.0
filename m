Return-Path: <linux-pm+bounces-21493-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id B60A8A2ADFC
	for <lists+linux-pm@lfdr.de>; Thu,  6 Feb 2025 17:40:47 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id CCB4A7A1C28
	for <lists+linux-pm@lfdr.de>; Thu,  6 Feb 2025 16:39:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AA682235361;
	Thu,  6 Feb 2025 16:40:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="eDnB+8pm"
X-Original-To: linux-pm@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E8CC61624ED
	for <linux-pm@vger.kernel.org>; Thu,  6 Feb 2025 16:40:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1738860035; cv=none; b=kFOSHTmeLHJ9pybYPreGCwihv3JgqXdhzDiTmQXxlv8n/anCg9qjOLTIXVhvSbOnvGf7EQ3tvtGx8qjFOOvr2OD/N+4yk02PnqrxD5nURT0cL2YTHZ2P57IoA9iyRMzNAwnHaJ2mX0YmJPIvKm4mgjz72DH5DKUudMovOmlXNng=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1738860035; c=relaxed/simple;
	bh=YSenI0dFBxlahuLj06tCyKMc1TwqjbLp00+pK/SxmRU=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=J2d0LjkKGGcF3jpniu19/ZEgpYXfdeyDaDA1+B8Mf7lbtmY9A3exeIaGEXW14tpxU56quDd8qTsZCvOyIjqpoi8aiYAyR3DXm4BXZMvLvWW8Yf/sZdaml7IDX8ZNxWFREEvXj0WzrTQb4oiQae/PDuIcCT8Dx6geMoHSeALPPeY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=eDnB+8pm; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1738860032;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=nojvbQSsLpg1qz6+VMqqdHm2nUvx5Sx9GqRia20D7TI=;
	b=eDnB+8pmGD/m6eZB8Gz/LIEWAQNpJKJANHXgy9Aav5XXnhdLKcfyheKDHVoP4AJ0VUBRyk
	K56Rbpbzla0/84e5rzx69zTeOi2cu2KrAe+0RBjVuAxHj7bnANih22EdUf3g4ZlFrZGi+X
	jJzJsBZCXNGyzKf2sN0wkItRgBsyCbE=
Received: from mx-prod-mc-08.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-138-upHk_FvxN56Sepzk_8c_Lw-1; Thu,
 06 Feb 2025 11:40:29 -0500
X-MC-Unique: upHk_FvxN56Sepzk_8c_Lw-1
X-Mimecast-MFC-AGG-ID: upHk_FvxN56Sepzk_8c_Lw
Received: from mx-prod-int-04.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-04.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.40])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-08.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 7B344180087E;
	Thu,  6 Feb 2025 16:40:27 +0000 (UTC)
Received: from dba-icx.bos.redhat.com (prarit2023-dbaguest.khw.eng.bos2.dc.redhat.com [10.26.1.94])
	by mx-prod-int-04.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP id D91EF19560AB;
	Thu,  6 Feb 2025 16:40:25 +0000 (UTC)
From: David Arcari <darcari@redhat.com>
To: linux-pm@vger.kernel.org
Cc: David Arcari <darcari@redhat.com>,
	Jonathan Corbet <corbet@lwn.net>,
	Jacob Pan <jacob.jun.pan@linux.intel.com>,
	Len Brown <lenb@kernel.org>,
	Prarit Bhargava <prarit@redhat.com>,
	linux-doc@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH v2] intel_idle: introduce 'no_native' module parameter
Date: Thu,  6 Feb 2025 11:40:09 -0500
Message-ID: <20250206164009.816232-1-darcari@redhat.com>
In-Reply-To: <20250128141139.2033088-1-darcari@redhat.com>
References: <20250128141139.2033088-1-darcari@redhat.com>
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.40

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
Cc: Prarit Bhargava <prarit@redhat.com>
Cc: linux-doc@vger.kernel.org
Cc: linux-kernel@vger.kernel.org
Signed-off-by: David Arcari <darcari@redhat.com>
---
v2: renamed parameter, cleaned up documentation

 Documentation/admin-guide/pm/intel_idle.rst | 17 ++++++++++++-----
 drivers/idle/intel_idle.c                   | 11 +++++++++++
 2 files changed, 23 insertions(+), 5 deletions(-)

diff --git a/Documentation/admin-guide/pm/intel_idle.rst b/Documentation/admin-guide/pm/intel_idle.rst
index 39bd6ecce7de..1f02a880836c 100644
--- a/Documentation/admin-guide/pm/intel_idle.rst
+++ b/Documentation/admin-guide/pm/intel_idle.rst
@@ -192,11 +192,18 @@ even if they have been enumerated (see :ref:`cpu-pm-qos` in
 Documentation/admin-guide/pm/cpuidle.rst).
 Setting ``max_cstate`` to 0 causes the ``intel_idle`` initialization to fail.
 
-The ``no_acpi`` and ``use_acpi`` module parameters (recognized by ``intel_idle``
-if the kernel has been configured with ACPI support) can be set to make the
-driver ignore the system's ACPI tables entirely or use them for all of the
-recognized processor models, respectively (they both are unset by default and
-``use_acpi`` has no effect if ``no_acpi`` is set).
+The ``no_acpi``, ``use_acpi`` and ``no_native`` module parameters are
+recognized by ``intel_idle`` if the kernel has been configured with ACPI
+support).
+
+``no_acpi`` - Do not use ACPI at all.  Only native mode is available, no
+ACPI mode.
+
+``use_acpi`` - No-op in ACPI mode; however, the driver will consult ACPI
+tables for C-states on/off status in native mode.
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


