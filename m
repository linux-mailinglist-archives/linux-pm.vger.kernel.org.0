Return-Path: <linux-pm+bounces-40258-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 1823ECF6C06
	for <lists+linux-pm@lfdr.de>; Tue, 06 Jan 2026 06:15:37 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 25F8A3043F60
	for <lists+linux-pm@lfdr.de>; Tue,  6 Jan 2026 05:15:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 081C62F745B;
	Tue,  6 Jan 2026 05:15:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="pJZYzgFU"
X-Original-To: linux-pm@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D45FA2F6931;
	Tue,  6 Jan 2026 05:15:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1767676513; cv=none; b=eAzql24wqhaqXW0ACYwCmxfxXd7PkjZcKE6wCMa2ZzUCO7OFtmSHRhHCKKbAPIrPeXPgM5xasx38onrRDTIkEJhrozYB6We/8oIhNtp1FLq4oJTh5Yyqz6QcnSrJ+E2mHHJWp86V+4SW/Q3AqcSPEeDGMjtl4f/hk3MvJoicQkU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1767676513; c=relaxed/simple;
	bh=Y/AjsLq+32sMPVqzYF2M2p7J3XWlM6ewKZ1fE+wvH+c=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=AAWmN5A/6ig9Gm4VAjzM1eDpk+e4/P14Q+g23gEZlEBjWTXI6MtjF8tONEruD2HUb0tZHKx0CyCcQoh5f/VQlOE1Moux55o2jeR37ym9J8mL8WZ3v/jvFlasJJPXnWiVxxFzytcVTTafoBJb+gohpUO5GOREAmSTWPXYCy0Kv5A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=pJZYzgFU; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 182C9C19421;
	Tue,  6 Jan 2026 05:15:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1767676513;
	bh=Y/AjsLq+32sMPVqzYF2M2p7J3XWlM6ewKZ1fE+wvH+c=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=pJZYzgFUiuPvcqZMuNcZ+A3g1lrahCaBKRupvomINRifLNUjDCKvD/PlTfz/Y3y3w
	 TriTGybexEhBXm+vaA32x7fRxoBqpDAaFpXefwgFpr/ZS2CymLgcspqT2iElH88hnP
	 s34RAHO6F8cL8kmlJcJ+CntwrsAkxgNDjdzY2BSFoShRMd+WpY5iJLrelDb5GaWoiK
	 02vS+3AFIq5F8ujrie9aHsGLL6ZdWmsxo7i7eezqMcJRqKC9NH+n2CM17IyU3ICdOy
	 Vt8HIdgCW+M7X+nBLiqS2pp0hNN8NWa0BRfqxA2mFAtk3cAkF6bMy0QMT27isg6KX6
	 7MyuRumN/jh0Q==
From: "Mario Limonciello (AMD)" <superm1@kernel.org>
To: "Gautham R . Shenoy" <gautham.shenoy@amd.com>
Cc: Perry Yuan <perry.yuan@amd.com>,
	linux-kernel@vger.kernel.org (open list:X86 ARCHITECTURE (32-BIT AND 64-BIT)),
	linux-pm@vger.kernel.org (open list:CPU FREQUENCY SCALING FRAMEWORK),
	Mario Limonciello <mario.limonciello@amd.com>
Subject: [PATCH v5 2/5] cpufreq/amd-pstate: add kernel command line to override dynamic epp
Date: Mon,  5 Jan 2026 23:14:38 -0600
Message-ID: <20260106051441.60093-3-superm1@kernel.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260106051441.60093-1-superm1@kernel.org>
References: <20260106051441.60093-1-superm1@kernel.org>
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Mario Limonciello <mario.limonciello@amd.com>

Add `amd_dynamic_epp=enable` and `amd_dynamic_epp=disable` to override
the kernel configuration option `CONFIG_X86_AMD_PSTATE_DYNAMIC_EPP`
locally.

Signed-off-by: Mario Limonciello <mario.limonciello@amd.com>
---
 Documentation/admin-guide/kernel-parameters.txt |  7 +++++++
 Documentation/admin-guide/pm/amd-pstate.rst     |  7 +++++++
 drivers/cpufreq/amd-pstate.c                    | 11 +++++++++++
 3 files changed, 25 insertions(+)

diff --git a/Documentation/admin-guide/kernel-parameters.txt b/Documentation/admin-guide/kernel-parameters.txt
index a8d0afde7f85a..d7d547bbda430 100644
--- a/Documentation/admin-guide/kernel-parameters.txt
+++ b/Documentation/admin-guide/kernel-parameters.txt
@@ -490,6 +490,13 @@ Kernel parameters
 			disable
 			  Disable amd-pstate preferred core.
 
+	amd_dynamic_epp=
+			[X86]
+			disable
+			  Disable amd-pstate dynamic EPP.
+			enable
+			  Enable amd-pstate dynamic EPP.
+
 	amijoy.map=	[HW,JOY] Amiga joystick support
 			Map of devices attached to JOY0DAT and JOY1DAT
 			Format: <a>,<b>
diff --git a/Documentation/admin-guide/pm/amd-pstate.rst b/Documentation/admin-guide/pm/amd-pstate.rst
index 5aa9fb77a078c..df4607b6a5f62 100644
--- a/Documentation/admin-guide/pm/amd-pstate.rst
+++ b/Documentation/admin-guide/pm/amd-pstate.rst
@@ -438,6 +438,13 @@ For systems that support ``amd-pstate`` preferred core, the core rankings will
 always be advertised by the platform. But OS can choose to ignore that via the
 kernel parameter ``amd_prefcore=disable``.
 
+``amd_dynamic_epp``
+
+When AMD pstate is in auto mode, dynamic EPP will control whether the kernel
+autonomously changes the EPP mode. The default is configured by
+``CONFIG_X86_AMD_PSTATE_DYNAMIC_EPP`` but can be explicitly enabled with
+``amd_pstate_epp=enable`` or disabled with ``amd_pstate_epp=disable``.
+
 User Space Interface in ``sysfs`` - General
 ===========================================
 
diff --git a/drivers/cpufreq/amd-pstate.c b/drivers/cpufreq/amd-pstate.c
index 26a8552581c57..7dd50b5825d78 100644
--- a/drivers/cpufreq/amd-pstate.c
+++ b/drivers/cpufreq/amd-pstate.c
@@ -1992,8 +1992,19 @@ static int __init amd_prefcore_param(char *str)
 	return 0;
 }
 
+static int __init amd_dynamic_epp_param(char *str)
+{
+	if (!strcmp(str, "disable"))
+		dynamic_epp = false;
+	if (!strcmp(str, "enable"))
+		dynamic_epp = true;
+
+	return 0;
+}
+
 early_param("amd_pstate", amd_pstate_param);
 early_param("amd_prefcore", amd_prefcore_param);
+early_param("amd_dynamic_epp", amd_dynamic_epp_param);
 
 MODULE_AUTHOR("Huang Rui <ray.huang@amd.com>");
 MODULE_DESCRIPTION("AMD Processor P-state Frequency Driver");
-- 
2.43.0


