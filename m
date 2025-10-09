Return-Path: <linux-pm+bounces-35872-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 1DAB2BCA2AC
	for <lists+linux-pm@lfdr.de>; Thu, 09 Oct 2025 18:25:51 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 415C24FF125
	for <lists+linux-pm@lfdr.de>; Thu,  9 Oct 2025 16:19:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8CD7523D7DD;
	Thu,  9 Oct 2025 16:18:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="dmkpxN3x"
X-Original-To: linux-pm@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 63F1A23D29A;
	Thu,  9 Oct 2025 16:18:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760026689; cv=none; b=He/Btr5sr2Ndr61xoreQcwn2DayU3DlC4Cu8k04xmyV4mn5X7rR3JRUJ7psdh8ayzgrDN3bpeXpnO1H8dbdq66F7UgXkJN3tPNun3u5KrYPbOcmBx9+uKTPhj0BWFNYfjKJ9tE/6bc0EprJy0txersx9E8A2cwd8Eh18DV6H3H8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760026689; c=relaxed/simple;
	bh=j58A4Hz5lIQl6pHqMa5ejtgHdIt3ANU2L+r+wOOB74I=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=uYlbisY7JvuXDGpEuAElK71JLfo+5weev103D8CCnJzjOsooouRQVrMAaXPxcuk4CjKlvAlVTRC1mLLb2/1tvJs7a5mCppeNwCAphGB2oyrmBai9Z8fQViGN5EKWgcKT0XLk/tZDF2M3GtYw4771OqsN4IujEkAV7rHGPm/f0Ng=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=dmkpxN3x; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B2B76C4CEFE;
	Thu,  9 Oct 2025 16:18:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1760026689;
	bh=j58A4Hz5lIQl6pHqMa5ejtgHdIt3ANU2L+r+wOOB74I=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=dmkpxN3xdkLckMK31ofkFOvv+kVkTp1wdfsSQEDF6xGtuCRBtLABvNsC7Bg9NuGUh
	 dr416Scb2S2URXkYJFeTPr/VnQAu1sZyAPeTIxALFKqDklYOMfk0nm7/oz9NFkKD6k
	 ynsqjiGDVgGNsaT3qhcoeV08L2koGeKcsCwFXKSVmV1s82b2fVJkUTZgJlTNNRpVer
	 ZWLgJ9d0cDds4lN7aqdvQUc8vrjj7vtgVNFMFqnMjqZyAlAH8gP4e57SSCCIvdJn5a
	 jx21Kt9OBO+yVu9j8DbmQwLWnyXSN1roFJ1OezebxrgiFWN2L+P7J2G3vXiXvfK1FH
	 WStXmqt0ND1UQ==
From: "Mario Limonciello (AMD)" <superm1@kernel.org>
To: "Gautham R . Shenoy" <gautham.shenoy@amd.com>
Cc: Perry Yuan <perry.yuan@amd.com>,
	linux-kernel@vger.kernel.org (open list:X86 ARCHITECTURE (32-BIT AND 64-BIT)),
	linux-pm@vger.kernel.org (open list:CPU FREQUENCY SCALING FRAMEWORK),
	"Mario Limonciello (AMD)" <superm1@kernel.org>
Subject: [PATCH v2 6/6] cpufreq/amd-pstate: Add static asserts for EPP indices
Date: Thu,  9 Oct 2025 11:17:56 -0500
Message-ID: <20251009161756.2728199-7-superm1@kernel.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20251009161756.2728199-1-superm1@kernel.org>
References: <20251009161756.2728199-1-superm1@kernel.org>
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

In case a new index is introduced add a static assert to make sure
that strings and values are updated.

Signed-off-by: Mario Limonciello (AMD) <superm1@kernel.org>
---
 drivers/cpufreq/amd-pstate.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/drivers/cpufreq/amd-pstate.c b/drivers/cpufreq/amd-pstate.c
index a0f21ac1205af..b3dad7cde46f0 100644
--- a/drivers/cpufreq/amd-pstate.c
+++ b/drivers/cpufreq/amd-pstate.c
@@ -110,6 +110,7 @@ enum energy_perf_value_index {
 	EPP_INDEX_BALANCE_PERFORMANCE,
 	EPP_INDEX_BALANCE_POWERSAVE,
 	EPP_INDEX_POWERSAVE,
+	EPP_INDEX_MAX,
 };
 
 static const char * const energy_perf_strings[] = {
@@ -119,6 +120,7 @@ static const char * const energy_perf_strings[] = {
 	[EPP_INDEX_BALANCE_POWERSAVE] = "balance_power",
 	[EPP_INDEX_POWERSAVE] = "power",
 };
+static_assert(ARRAY_SIZE(energy_perf_strings) == EPP_INDEX_MAX);
 
 static unsigned int epp_values[] = {
 	[EPP_INDEX_DEFAULT] = 0,
@@ -127,6 +129,7 @@ static unsigned int epp_values[] = {
 	[EPP_INDEX_BALANCE_POWERSAVE] = AMD_CPPC_EPP_BALANCE_POWERSAVE,
 	[EPP_INDEX_POWERSAVE] = AMD_CPPC_EPP_POWERSAVE,
 };
+static_assert(ARRAY_SIZE(epp_values) == EPP_INDEX_MAX);
 
 typedef int (*cppc_mode_transition_fn)(int);
 
-- 
2.43.0


