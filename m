Return-Path: <linux-pm+bounces-35869-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 45559BCA267
	for <lists+linux-pm@lfdr.de>; Thu, 09 Oct 2025 18:23:00 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 07A09189650A
	for <lists+linux-pm@lfdr.de>; Thu,  9 Oct 2025 16:18:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8996C19E967;
	Thu,  9 Oct 2025 16:18:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="t9Xs4NLD"
X-Original-To: linux-pm@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 61C54225403;
	Thu,  9 Oct 2025 16:18:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760026687; cv=none; b=Dd9RKrzgsCKoU8kcA7UnDAS8R7vUfvA8X0ZfX6oERDGj8UZABgsIN3WVDRi0mrrQUUlJtCAng+LifEamVtlvBONZ6OcpmC8vpiVWjBbZMkJ4DsUnrUP8fhiA4xL9XgupRuqrv4SxEuMmjXVXHrUYGPMpCOUOuNR7/tRQNY7hmGM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760026687; c=relaxed/simple;
	bh=btMwNG95kFkM6A4AfAqNPbyfByjtAq5BN5TIgBVnsRM=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Crz7XPRtPQS5D2k0OM9TqB/5wigjdbrR+mXxvfDKyQUofRHSD6aWXTO2F15XijcY0ouxFe7lY31x3P2kRm8fQzqec05IFClpQ0CET92Iczb+ptwPePr5vTT/mwjTKaQMpWg7WquBnH6NFNM3+N2IBr4HUyTPS+cP/8adGGVGsGU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=t9Xs4NLD; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 50F91C4CEE7;
	Thu,  9 Oct 2025 16:18:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1760026686;
	bh=btMwNG95kFkM6A4AfAqNPbyfByjtAq5BN5TIgBVnsRM=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=t9Xs4NLDDyJe+k+ivU9TTfICx/2Ydh7qZIrIoq4+5JTVMfmd7EYcJHYg08yNw1AcQ
	 4+uMXsdXHTOuCU0UvR939NEIs3EGTqwVM+4FDcpCoXqV5QKWB/JtLYxwnvZVscgnsh
	 3grug++NMafBoDNZzOc2OCKxMhcRWOlmr/OuKC9T8cZnXidHxjpjqY0MJP9a2ARpjA
	 4kNOyu9n5g2rHnLsxYK7/fKFXiPA7K4Qev0tQvxYLr85L49fcWIiMROsnke0HB7lGs
	 8N4FJglvvkIbQILcoHr0gs1zxDZ5bk0F6Yk1QbJDdTKOXtlzBtZ4MLfd6BixJW2TqV
	 MP33u7rK6yFeQ==
From: "Mario Limonciello (AMD)" <superm1@kernel.org>
To: "Gautham R . Shenoy" <gautham.shenoy@amd.com>
Cc: Perry Yuan <perry.yuan@amd.com>,
	linux-kernel@vger.kernel.org (open list:X86 ARCHITECTURE (32-BIT AND 64-BIT)),
	linux-pm@vger.kernel.org (open list:CPU FREQUENCY SCALING FRAMEWORK),
	"Mario Limonciello (AMD)" <superm1@kernel.org>
Subject: [PATCH v2 3/6] cpufreq/amd-pstate: Make amd_pstate_get_mode_string() never return NULL
Date: Thu,  9 Oct 2025 11:17:53 -0500
Message-ID: <20251009161756.2728199-4-superm1@kernel.org>
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

amd_pstate_get_mode_string() is only used by amd-pstate-ut.  Set the
failure path to use AMD_PSTATE_UNDEFINED ("undefined") to avoid showing
"(null)" as a string when running test suite.

Signed-off-by: Mario Limonciello (AMD) <superm1@kernel.org>
---
 drivers/cpufreq/amd-pstate.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/cpufreq/amd-pstate.c b/drivers/cpufreq/amd-pstate.c
index a5b9e5baf4234..5feb9f5e3a491 100644
--- a/drivers/cpufreq/amd-pstate.c
+++ b/drivers/cpufreq/amd-pstate.c
@@ -70,8 +70,8 @@ static_assert(ARRAY_SIZE(amd_pstate_mode_string) == AMD_PSTATE_MAX);
 
 const char *amd_pstate_get_mode_string(enum amd_pstate_mode mode)
 {
-	if (mode < 0 || mode >= AMD_PSTATE_MAX)
-		return NULL;
+	if (mode < AMD_PSTATE_UNDEFINED || mode >= AMD_PSTATE_MAX)
+		mode = AMD_PSTATE_UNDEFINED;
 	return amd_pstate_mode_string[mode];
 }
 EXPORT_SYMBOL_GPL(amd_pstate_get_mode_string);
-- 
2.43.0


