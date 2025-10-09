Return-Path: <linux-pm+bounces-35870-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 8EE3ABCA276
	for <lists+linux-pm@lfdr.de>; Thu, 09 Oct 2025 18:23:22 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id A20EA1898B0C
	for <lists+linux-pm@lfdr.de>; Thu,  9 Oct 2025 16:19:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 540D6231845;
	Thu,  9 Oct 2025 16:18:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="oEkmWRla"
X-Original-To: linux-pm@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2BCA122F77E;
	Thu,  9 Oct 2025 16:18:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760026688; cv=none; b=qBLcOuEu7zonK63aBOVrt5eW/nV3TQ2uUZ3j4/XjraeQazCNDcTADNGKh/fCcFMh5H/TESE/5/8se6LZ0jqrSzcaII418kVY1SQJe/SjskdzcoIw/pS2/dSaQqm3WSpQPuzpHIA85jtzdnlWuSIf/kVPlwUAGpnXvMY13sF8dT0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760026688; c=relaxed/simple;
	bh=46QjrBY51KkQ/h8L2AvGf466oaYcMm8u//jJges89zs=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=UHFh/atuwZ2Nl5NjcL5T5wNzTxde3rkTTx7KZSJ3+aMC+1dEsMO02AAWPoXGqFrf0KWMI8c36IXAhVdQkqbK30gj2eE1FehmOWjiEGJhWD8oeSQFf+1d3yq0KuDMehyOuvkyNzliXuv4fqJ70SJuxuQFB8cOgAsGDwzrR09rrCE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=oEkmWRla; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 262B1C4AF0B;
	Thu,  9 Oct 2025 16:18:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1760026687;
	bh=46QjrBY51KkQ/h8L2AvGf466oaYcMm8u//jJges89zs=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=oEkmWRlaGX2ru1DvbZVOih8N3lHZfkL0adIznbGnX0h7k46VwY6jo2G++Ouf2bjRi
	 MAvNpBo89KEYLMGfetGIDPh4dfA3xxXtc6pIX60O8ttVZew92AXqNLovLD0IIhDlPe
	 N9frOAJUNH5S2t0uzwB8e2jFPaU63WGF5oWXjaJw6sN67yCBWglHv4iEoS2CtnD9d3
	 Xc0+7/SR7fnOOknfH+JhuZixZwEcIv9cJqU4hKCqJFklyiSMmuxDbZgbXVbgcPHDvB
	 mT2Ea8pu3hogE4Em80V1xi14/kkiv5vXEn7CrPpv4o/4SZvT12i8a2WSW3BOc8AILd
	 oYtXl06JBph3A==
From: "Mario Limonciello (AMD)" <superm1@kernel.org>
To: "Gautham R . Shenoy" <gautham.shenoy@amd.com>
Cc: Perry Yuan <perry.yuan@amd.com>,
	linux-kernel@vger.kernel.org (open list:X86 ARCHITECTURE (32-BIT AND 64-BIT)),
	linux-pm@vger.kernel.org (open list:CPU FREQUENCY SCALING FRAMEWORK),
	"Mario Limonciello (AMD)" <superm1@kernel.org>
Subject: [PATCH v2 4/6] cpufreq/amd-pstate: Adjust return values in amd_pstate_update_status()
Date: Thu,  9 Oct 2025 11:17:54 -0500
Message-ID: <20251009161756.2728199-5-superm1@kernel.org>
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

get_mode_idx_from_str() already checks the upper boundary for a string
sent.  Drop the extra check in amd_pstate_update_status() and pass
the return code if there is a failure.

Signed-off-by: Mario Limonciello (AMD) <superm1@kernel.org>
---
 drivers/cpufreq/amd-pstate.c | 5 ++---
 1 file changed, 2 insertions(+), 3 deletions(-)

diff --git a/drivers/cpufreq/amd-pstate.c b/drivers/cpufreq/amd-pstate.c
index 5feb9f5e3a491..2d2ef53d12447 100644
--- a/drivers/cpufreq/amd-pstate.c
+++ b/drivers/cpufreq/amd-pstate.c
@@ -1346,9 +1346,8 @@ int amd_pstate_update_status(const char *buf, size_t size)
 		return -EINVAL;
 
 	mode_idx = get_mode_idx_from_str(buf, size);
-
-	if (mode_idx < 0 || mode_idx >= AMD_PSTATE_MAX)
-		return -EINVAL;
+	if (mode_idx < 0)
+		return mode_idx;
 
 	if (mode_state_machine[cppc_state][mode_idx]) {
 		guard(mutex)(&amd_pstate_driver_lock);
-- 
2.43.0


