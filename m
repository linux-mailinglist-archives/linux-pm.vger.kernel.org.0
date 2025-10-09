Return-Path: <linux-pm+bounces-35871-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 6BE29BCA27F
	for <lists+linux-pm@lfdr.de>; Thu, 09 Oct 2025 18:23:50 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 9CA92189C7A0
	for <lists+linux-pm@lfdr.de>; Thu,  9 Oct 2025 16:19:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1864023B61A;
	Thu,  9 Oct 2025 16:18:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ZKxqnAsa"
X-Original-To: linux-pm@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DF0F423958A;
	Thu,  9 Oct 2025 16:18:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760026689; cv=none; b=r5FsmozFc2DC02kD3Zy656A+AkGNMcPcq/73Lt2Gq+Gv7rV4RzUqwmLPy7wi4AkH4OQLitpqgMgA2KpbgvipvQ9PtW+vlrNkb+IGHGCnOanZdKMeXzKa6dnYU0cmrAGmfG6s5jMN24x18O5JcxIcdumj0kl6h+AHNWimcznojbE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760026689; c=relaxed/simple;
	bh=oGfp+Ic9aXFjfu18qJINok3RloZ50Sy8jmz7OKzlZNU=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=LPEMFlWKw1K3P6LVjnqTxLi0gnXO6yYvi19jgXeOG3XwJt3i+ERMGwfCOtpCFUP1Ra6V4umM7igT+nrjtWnZqQkoq+XmrwfYN9YUNN6pHR5h/n69/UQ8ons9XOuoiDMtko99fbY/CTUWbscsp5ybK88nlrV9iSvtLEPIFtEsg8o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ZKxqnAsa; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E6B54C4CEE7;
	Thu,  9 Oct 2025 16:18:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1760026688;
	bh=oGfp+Ic9aXFjfu18qJINok3RloZ50Sy8jmz7OKzlZNU=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=ZKxqnAsaNgGfmZHe6e563+Ybd495RBfBtaa0Y11b8nJq3opY4x4l6i2VKBLlMwjoC
	 JBOIOcNBfQdXUkFuP2ZGiDp9k1HevxseQa/49pUia0Lhk08ZoCNssWry+6nfGnsv1m
	 /m78EDxE69VVTe23xVYt4allkbU3zUakwl0fgayn9jIBkUlRJAdqx8ST6/RsUXxGDW
	 nGJnVc/vYIwBfNF0iE1sVfRxhw/5wOcc/QUtOi+Xl9YpRwn2xjWRA/91deXZCJWARx
	 NYGwJONhJqETSIoaOe4ySxg4XXRPNMCe1met0cPAFhJB1iSjZMVW8bCKDAjVip/rjo
	 iNi9r8Bb5D33A==
From: "Mario Limonciello (AMD)" <superm1@kernel.org>
To: "Gautham R . Shenoy" <gautham.shenoy@amd.com>
Cc: Perry Yuan <perry.yuan@amd.com>,
	linux-kernel@vger.kernel.org (open list:X86 ARCHITECTURE (32-BIT AND 64-BIT)),
	linux-pm@vger.kernel.org (open list:CPU FREQUENCY SCALING FRAMEWORK),
	"Mario Limonciello (AMD)" <superm1@kernel.org>
Subject: [PATCH v2 5/6] cpufreq/amd-pstate: Fix some whitespace issues
Date: Thu,  9 Oct 2025 11:17:55 -0500
Message-ID: <20251009161756.2728199-6-superm1@kernel.org>
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

Add whitespace around the equals and remove leading space.

Signed-off-by: Mario Limonciello (AMD) <superm1@kernel.org>
---
 drivers/cpufreq/amd-pstate.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/cpufreq/amd-pstate.c b/drivers/cpufreq/amd-pstate.c
index 2d2ef53d12447..a0f21ac1205af 100644
--- a/drivers/cpufreq/amd-pstate.c
+++ b/drivers/cpufreq/amd-pstate.c
@@ -126,7 +126,7 @@ static unsigned int epp_values[] = {
 	[EPP_INDEX_BALANCE_PERFORMANCE] = AMD_CPPC_EPP_BALANCE_PERFORMANCE,
 	[EPP_INDEX_BALANCE_POWERSAVE] = AMD_CPPC_EPP_BALANCE_POWERSAVE,
 	[EPP_INDEX_POWERSAVE] = AMD_CPPC_EPP_POWERSAVE,
- };
+};
 
 typedef int (*cppc_mode_transition_fn)(int);
 
@@ -182,7 +182,7 @@ static inline int get_mode_idx_from_str(const char *str, size_t size)
 {
 	int i;
 
-	for (i=0; i < AMD_PSTATE_MAX; i++) {
+	for (i = 0; i < AMD_PSTATE_MAX; i++) {
 		if (!strncmp(str, amd_pstate_mode_string[i], size))
 			return i;
 	}
-- 
2.43.0


