Return-Path: <linux-pm+bounces-28420-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 4171BAD45CB
	for <lists+linux-pm@lfdr.de>; Wed, 11 Jun 2025 00:18:29 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 631AF3A6977
	for <lists+linux-pm@lfdr.de>; Tue, 10 Jun 2025 22:18:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EEA86289E3A;
	Tue, 10 Jun 2025 22:18:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="RIWI1z7V"
X-Original-To: linux-pm@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CA9A9284B42
	for <linux-pm@vger.kernel.org>; Tue, 10 Jun 2025 22:18:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1749593904; cv=none; b=craRhRvngrjY7JUikko/tsbhZAZ+dLvN5Ur7nfrePB1mLvppknjFpRP4kIOMtOd7SeeKYYZOCODMsOufGJ7w8z5xeYucGXv/3Th3gM5jjhRmPNlW+I9q9ySdPPVjWaivd1nNELD7+icjQPwhqh6r90b1mjLmyzIZ3Ne3mNUBsPs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1749593904; c=relaxed/simple;
	bh=SA6o1XmiEh8TFycFSaRMIPEj//NX2wBdF9S09wpXoAc=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=GlENvcCxngjUxVlT5MqPWXXV7kXECeuxr1YzzxZ7NlrsfAFc25m9wbkQ/WTPiNrbcScMySGS1wyLLPzdc5qZ0XUGstQDjkCaUwI4YXOmgZPqsFgMlL9Lx9WIkw1bEO2EYjcBB6tHfJdn0b5/Tdy5c+4F6cMhkKs95xpqOqE0EUc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=RIWI1z7V; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 06060C4CEED;
	Tue, 10 Jun 2025 22:18:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1749593904;
	bh=SA6o1XmiEh8TFycFSaRMIPEj//NX2wBdF9S09wpXoAc=;
	h=From:To:Cc:Subject:Date:Reply-To:From;
	b=RIWI1z7VnzALZM4h5f3NLg4AuJaP3k/7Wrw1nGRFEg33nIiwCAAh2hOJf1Z5Wivf7
	 6VhoqDFEY2UJ7mtt0SesGLaMgntroWS6q7MkAAE/m2iVV29o3qb/awyaej3SzAuzCy
	 /d+GrbiYcwGvQVcsz1ga9Dk8PWxCQNbuD3Dnkr3OY8YrRgA5VEzr3KnrWLr2YGXKeG
	 8vyDQmbm6oaOgfXXPIyCeMZwlVRaUhxhks2U+s4z4oyyo27v+O3YamH3Rc/Q940BCQ
	 6NGZmFCSsclmgDYidnRqT4zmb6zu4gBOBAibowvJhYQCGHu6o9QsQPd7if/VUrFQAV
	 3sG7+l6zSvFVQ==
From: Len Brown <lenb@kernel.org>
To: linux-pm@vger.kernel.org
Cc: Len Brown <len.brown@intel.com>,
	Zhang Rui <rui.zhang@intel.com>
Subject: [PATCH 1/2] tools/power turbostat: regression fix: --show C1E%
Date: Tue, 10 Jun 2025 18:18:12 -0400
Message-ID: <5d939fbdd480cdf276eccc01eda3ed41e37d3f8a.1749593891.git.len.brown@intel.com>
X-Mailer: git-send-email 2.45.2
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Reply-To: Len Brown <lenb@kernel.org>
Organization: Intel Open Source Technology Center
Content-Transfer-Encoding: 8bit

From: Len Brown <len.brown@intel.com>

The new default idle counter groupings broke "--show C1E%" (or any other C-state %)

Also delete a stray debug printf from the same offending commit.

Reported-by: Zhang Rui <rui.zhang@intel.com>
Fixes: ec4acd3166d8 ("tools/power turbostat: disable "cpuidle" invocation counters, by default")
Signed-off-by: Len Brown <len.brown@intel.com>
---
 tools/power/x86/turbostat/turbostat.c | 4 ----
 1 file changed, 4 deletions(-)

diff --git a/tools/power/x86/turbostat/turbostat.c b/tools/power/x86/turbostat/turbostat.c
index 5230e072e414..33a54a9e0781 100644
--- a/tools/power/x86/turbostat/turbostat.c
+++ b/tools/power/x86/turbostat/turbostat.c
@@ -2429,7 +2429,6 @@ unsigned long long bic_lookup(char *name_list, enum show_hide_mode mode)
 
 		}
 		if (i == MAX_BIC) {
-			fprintf(stderr, "deferred %s\n", name_list);
 			if (mode == SHOW_LIST) {
 				deferred_add_names[deferred_add_index++] = name_list;
 				if (deferred_add_index >= MAX_DEFERRED) {
@@ -10537,9 +10536,6 @@ void probe_cpuidle_residency(void)
 	int min_state = 1024, max_state = 0;
 	char *sp;
 
-	if (!DO_BIC(BIC_pct_idle))
-		return;
-
 	for (state = 10; state >= 0; --state) {
 
 		sprintf(path, "/sys/devices/system/cpu/cpu%d/cpuidle/state%d/name", base_cpu, state);
-- 
2.45.2


