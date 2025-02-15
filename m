Return-Path: <linux-pm+bounces-22142-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 5F250A36A57
	for <lists+linux-pm@lfdr.de>; Sat, 15 Feb 2025 01:59:11 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 5FCD41893DC3
	for <lists+linux-pm@lfdr.de>; Sat, 15 Feb 2025 00:58:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 10FBC188CA9;
	Sat, 15 Feb 2025 00:55:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="YddGIKYE"
X-Original-To: linux-pm@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CFCD717799F;
	Sat, 15 Feb 2025 00:55:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739580900; cv=none; b=cPylU+dxqP+ghSX3tl+uoKIEpDPqafPFgCW6NnnU/2JYH+ijClEe7KGviaByb4PyqlpYoHeuByyd+zELS176OY8IhG53b8cnPjmiCBHHVAHx+slyedOQK/JjD4wr+FZ289Lg/ERznfXfwsUCHvioyemKkbYsPhPSJCLRMLtxCAk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739580900; c=relaxed/simple;
	bh=1fpLNpbPgcGKVyKFjXfajuXkpkQU1RnDwuoelu2h1hA=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=cyHLweeoWehOqDkpDUGSHSGw83I6tON/3v0KKongbmvMCDiIfpa72vBb4TNNtbfn1h7cD61R26nnNmPRJgPJ1R1IjQUr0ONsMwG94dV7eQMqbetP0MZwFPfhEUC82QjtYLlnMjeGhDnZ7uw7l52OzKX0xyp6wI4qqVQnwmcmnfs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=YddGIKYE; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A8E75C4CEE6;
	Sat, 15 Feb 2025 00:54:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1739580900;
	bh=1fpLNpbPgcGKVyKFjXfajuXkpkQU1RnDwuoelu2h1hA=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=YddGIKYErMpOWrvP7ibByOQSoPHmSapgD5CnvVBt9qSJmTN8L3xR1HxWfR0EhAak3
	 7WhzzEbPx404wYLtmD4Diwb3HXJm7k7qSx8/QF9a7A/MdQ7/sRBSrvDowdGdlMcp4H
	 zcVOoWoxIwQH1WbM37idOMrZiVSHFPd4vvn7aKrW7a+cq4hkRuQO5MzlPZg3LXXfzh
	 c3Ic3HwVObsCpDI9vNBz+71dRo0JUVKI9L0P19dYSFTCPXuU3bvA4B12R+miVZ/zCk
	 greQQs61lfTpKD547J3q5IwEZ/PXGwWrLfdCpRyFxW9BSMgerZ6QwmIQ5Xy0SDcwrG
	 wSIULkBI9LKqw==
From: Mario Limonciello <superm1@kernel.org>
To: "Gautham R . Shenoy" <gautham.shenoy@amd.com>,
	Perry Yuan <perry.yuan@amd.com>
Cc: Dhananjay Ugwekar <Dhananjay.Ugwekar@amd.com>,
	linux-kernel@vger.kernel.org (open list:X86 ARCHITECTURE (32-BIT AND 64-BIT)),
	linux-pm@vger.kernel.org (open list:CPU FREQUENCY SCALING FRAMEWORK),
	Mario Limonciello <mario.limonciello@amd.com>
Subject: [PATCH 2/5] cpufreq/amd-pstate: add kernel command line to override dynamic epp
Date: Fri, 14 Feb 2025 18:54:45 -0600
Message-ID: <20250215005448.1216646-3-superm1@kernel.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20250215005448.1216646-1-superm1@kernel.org>
References: <20250215005448.1216646-1-superm1@kernel.org>
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
index 95cf8ac29b08c..f72f385f9f92e 100644
--- a/drivers/cpufreq/amd-pstate.c
+++ b/drivers/cpufreq/amd-pstate.c
@@ -1969,8 +1969,19 @@ static int __init amd_prefcore_param(char *str)
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


