Return-Path: <linux-pm+bounces-24356-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 79F56A6B2F5
	for <lists+linux-pm@lfdr.de>; Fri, 21 Mar 2025 03:30:57 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id AA8D617DF4B
	for <lists+linux-pm@lfdr.de>; Fri, 21 Mar 2025 02:29:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 03FEF1E3793;
	Fri, 21 Mar 2025 02:29:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="HoH5a8v/"
X-Original-To: linux-pm@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CD0851E2614;
	Fri, 21 Mar 2025 02:29:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742524157; cv=none; b=FrOU9aUcg8sdyjNhI9CXzqWfhOK447b57sJvpxRuhOj/DbD7WIJN2WhQiOv7NDCqqMpcMFmS6hy2GWSu9hs6NDnXTwhZTjOYm+p514/lmlGHryYKW/4SLrJjfqX62ajxqaoazTEgQq7Vq6814qbZGTlmYdjPjxGg9qpp59FZn54=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742524157; c=relaxed/simple;
	bh=w5WBIg1nxco7eZ7mMRXzeI6P7lXz/+UJQahBIXYvr7g=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=eLR1vIz0XFJCV6KNkqsr/BxJvOm5CmI+JYYq6DFLZB96Ewnf1WdbqyfY2m2cqjyf6bJI1z2DSR9XCU/DlbcmkfiHUAmajDmjAvb2BDQY4bkh5TH0tLPutj0qof7KyR6jHILcTlAapnecBWegyy3y2sk6vM9l0iGhNMH9lfej9uY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=HoH5a8v/; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0F441C4CEE7;
	Fri, 21 Mar 2025 02:29:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1742524157;
	bh=w5WBIg1nxco7eZ7mMRXzeI6P7lXz/+UJQahBIXYvr7g=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=HoH5a8v/JI/XcyAcuYZHcEH1fi0LUnx7sO4Yae9X8x2t+AtxDM8BWPHszA3mnzKUZ
	 jw8fJSjby4B8TkANzJLrKPLtJ3JVyEePDH2bmrz7KBri7GItu/dgrZJap1eG+pf70K
	 Get7SkNktKGaQPVuV1K225qEjSOErTDGA/vvxMF6SKOOb2GAir5aYr/QFqjuP199Pf
	 fMFSO1N+0pfB+d8baxCuMIwChUF2R8diSmQYBNF8OEklFC4+PGV2zAomEi5/XBeRuy
	 dAh5Y2Z6PNZ6CIVFboK1Fxj5tIKiYKV2Y/cYkaA/b6J4F8+4xas8eEaXelktQFihGn
	 OB2pMjp4nq9RQ==
From: Mario Limonciello <superm1@kernel.org>
To: "Gautham R . Shenoy" <gautham.shenoy@amd.com>,
	Perry Yuan <perry.yuan@amd.com>
Cc: Dhananjay Ugwekar <Dhananjay.Ugwekar@amd.com>,
	linux-kernel@vger.kernel.org (open list:X86 ARCHITECTURE (32-BIT AND 64-BIT)),
	linux-pm@vger.kernel.org (open list:CPU FREQUENCY SCALING FRAMEWORK),
	Mario Limonciello <mario.limonciello@amd.com>
Subject: [PATCH v4 2/5] cpufreq/amd-pstate: add kernel command line to override dynamic epp
Date: Thu, 20 Mar 2025 21:28:55 -0500
Message-ID: <20250321022858.1538173-3-superm1@kernel.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20250321022858.1538173-1-superm1@kernel.org>
References: <20250321022858.1538173-1-superm1@kernel.org>
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
index fb8752b42ec85..1afe6d8ab09bb 100644
--- a/Documentation/admin-guide/kernel-parameters.txt
+++ b/Documentation/admin-guide/kernel-parameters.txt
@@ -392,6 +392,13 @@
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
index 2e076650dc77c..8424e7119dd7e 100644
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
index 7f203495f60e3..8172bd4b5952f 100644
--- a/drivers/cpufreq/amd-pstate.c
+++ b/drivers/cpufreq/amd-pstate.c
@@ -1934,8 +1934,19 @@ static int __init amd_prefcore_param(char *str)
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


