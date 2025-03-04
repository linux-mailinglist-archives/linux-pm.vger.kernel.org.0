Return-Path: <linux-pm+bounces-23405-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 9DEB6A4E4C9
	for <lists+linux-pm@lfdr.de>; Tue,  4 Mar 2025 17:03:34 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id ED8188859A0
	for <lists+linux-pm@lfdr.de>; Tue,  4 Mar 2025 15:35:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 70993283C8D;
	Tue,  4 Mar 2025 15:23:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="QWKAzK76"
X-Original-To: linux-pm@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 44F0A283C88;
	Tue,  4 Mar 2025 15:23:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741101816; cv=none; b=fvQeqU4+Un0Odqd0iDyQP8fG/ZsrRKIZqGyRSwZZFTQgaCpYz7J3IepvLQppgdaqFNLqLUXaLvDebesrxUDfNueNDSJTYGVzPZOFSHpWud8OTPw8N/zF95AVSqfAEAa5slQ7IZfnaj0NKIRiNn1dtWuEQMIDx+ef26nJiewMQRQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741101816; c=relaxed/simple;
	bh=Zt8s0sZnRT0alZvhBnavi0Mqi2vvqBU/hSN8SdClXuU=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=ThI6R6mS2MDbEE/v+gBbVG1WzE+IU+eKaG88BS1BLLBp74uEoKV+KLarE3zeIV/+Gl+m6jX9SIEUITOUs9jgOqZHWtaHiYxtFlFhPRC1/wonf04PAK7NBSYDT9/dBt0RWnGgSRTLLqyo4MMnPm7QA0N79WPpMasispDFaFNYweU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=QWKAzK76; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3C6DDC4CEEB;
	Tue,  4 Mar 2025 15:23:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1741101815;
	bh=Zt8s0sZnRT0alZvhBnavi0Mqi2vvqBU/hSN8SdClXuU=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=QWKAzK76v62dTwL2jH9yU0yoErPoEFPm37aWn5WmXP+biS+a7HbN+Svo0mvN3fuiQ
	 DvSFjFrc/LRSanhHBoqoX/BxBZVZ7zu+4YFvztPpGJNhZN4Yg8wIC0H4vfEr0kGEkk
	 z36yuG9K1gQjJXnW6Knq0MQlXohqPMvUWwd2FgBF0yXh6ldk1nDFN5kEKcfLTfOudF
	 GRVQ0jtmesqyrVn5qCJLA/zREuRG4vEhnKVYXu0pi1GisVDUOx+RNF3A4Ct8BIo+dk
	 Rz+kDKpQGwaPeS9XpQ/vuZP1ybL0b0UXk66RgCm7ZmL7neKzIcRvIOLomMpqtd7IMN
	 qjIpgpEY18GXw==
From: Mario Limonciello <superm1@kernel.org>
To: "Gautham R . Shenoy" <gautham.shenoy@amd.com>,
	Perry Yuan <perry.yuan@amd.com>
Cc: Dhananjay Ugwekar <Dhananjay.Ugwekar@amd.com>,
	linux-kernel@vger.kernel.org (open list:X86 ARCHITECTURE (32-BIT AND 64-BIT)),
	linux-pm@vger.kernel.org (open list:CPU FREQUENCY SCALING FRAMEWORK),
	Mario Limonciello <mario.limonciello@amd.com>
Subject: [PATCH v2 2/5] cpufreq/amd-pstate: add kernel command line to override dynamic epp
Date: Tue,  4 Mar 2025 09:23:24 -0600
Message-ID: <20250304152327.1561017-3-superm1@kernel.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20250304152327.1561017-1-superm1@kernel.org>
References: <20250304152327.1561017-1-superm1@kernel.org>
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
index f00fb4ba9f26e..9911808fe0bcf 100644
--- a/drivers/cpufreq/amd-pstate.c
+++ b/drivers/cpufreq/amd-pstate.c
@@ -1928,8 +1928,19 @@ static int __init amd_prefcore_param(char *str)
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


