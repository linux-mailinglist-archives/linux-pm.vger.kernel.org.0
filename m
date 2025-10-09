Return-Path: <linux-pm+bounces-35867-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id E7880BCA261
	for <lists+linux-pm@lfdr.de>; Thu, 09 Oct 2025 18:22:42 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 1A2B71889021
	for <lists+linux-pm@lfdr.de>; Thu,  9 Oct 2025 16:18:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B2873220F3E;
	Thu,  9 Oct 2025 16:18:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="FZjl+6gD"
X-Original-To: linux-pm@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8AB1C21D5B0;
	Thu,  9 Oct 2025 16:18:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760026686; cv=none; b=miE0VnQOGgcFGOV9zom1mi5PH2cjkGqJTQWMvaadNXTr7tayk1tx5Pllxpzsg8yW8dOW+0YaDVZGaCuWF8u1enZAaRWhWwzOugFZbgXpGOPqe2uHUrJCPKKM6ubHc3TJcoOObKWWVuELYHO7JQGz8rPXv0eu2OdGU1evFVeAHzg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760026686; c=relaxed/simple;
	bh=qtGTM4ocQv+yktymuvzDr9klOqnGIF1RjjjPQWx2JWU=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=ndspTpMdn/KAnWF4jVYkTIC/YTDjrixoQdkzwJEQne6Qy1ZOC40D0a1Zf1icERNacjejt4bMIaJIZiPfduBjc851PDYgDsdGHGeEr5iXZQtD3GBquOFaAnOC7V4fan3UDrGYrj8LDoBNwGASHvd8E9Atkv1U+1KWLrd9TTOval4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=FZjl+6gD; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 82C6BC4CEF8;
	Thu,  9 Oct 2025 16:18:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1760026686;
	bh=qtGTM4ocQv+yktymuvzDr9klOqnGIF1RjjjPQWx2JWU=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=FZjl+6gDMbXmfD7huwmwfCA0AZWlfvKV9kzXSgeHMXvOCNlZ6S/Lv30xC2nLcfJy5
	 5LuTlW13jkodgoqGUipTZmRRssXukozRlQBN7q3KsanNRZrECxwXiOTZx2kYKSnsVB
	 AHKToqNd0MCkUw7Jx4EakQj8eE0lFPh++L3H9g/8tbbFjFnGtgpGxI42x44dKe6OJX
	 AY7PhqD1QE6t2ts6qx8XZmHX+QrDC42uiAhsLBitoeo6ISwFfZZ1XkwIBXCA3C0jtY
	 gZjMlvCx4VIR61xkoxoteJfdHV7biCyJX8sxxLXVyI7L/P28DE9W+byKAWh9xoxKKV
	 2jd0AMRloum9w==
From: "Mario Limonciello (AMD)" <superm1@kernel.org>
To: "Gautham R . Shenoy" <gautham.shenoy@amd.com>
Cc: Perry Yuan <perry.yuan@amd.com>,
	linux-kernel@vger.kernel.org (open list:X86 ARCHITECTURE (32-BIT AND 64-BIT)),
	linux-pm@vger.kernel.org (open list:CPU FREQUENCY SCALING FRAMEWORK),
	"Mario Limonciello (AMD)" <superm1@kernel.org>
Subject: [PATCH v2 2/6] cpufreq/amd-pstate: Drop NULL value from amd_pstate_mode_string
Date: Thu,  9 Oct 2025 11:17:52 -0500
Message-ID: <20251009161756.2728199-3-superm1@kernel.org>
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

None of the users actually look for the NULL value.  To avoid risk
of regression introducing a new value but forgetting to add a string
add a static assert to test AMD_PSTATE_MAX matches the array size.

Signed-off-by: Mario Limonciello (AMD) <superm1@kernel.org>
---
 drivers/cpufreq/amd-pstate.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/cpufreq/amd-pstate.c b/drivers/cpufreq/amd-pstate.c
index 0bc5013448873..a5b9e5baf4234 100644
--- a/drivers/cpufreq/amd-pstate.c
+++ b/drivers/cpufreq/amd-pstate.c
@@ -65,8 +65,8 @@ static const char * const amd_pstate_mode_string[] = {
 	[AMD_PSTATE_PASSIVE]     = "passive",
 	[AMD_PSTATE_ACTIVE]      = "active",
 	[AMD_PSTATE_GUIDED]      = "guided",
-	NULL,
 };
+static_assert(ARRAY_SIZE(amd_pstate_mode_string) == AMD_PSTATE_MAX);
 
 const char *amd_pstate_get_mode_string(enum amd_pstate_mode mode)
 {
-- 
2.43.0


