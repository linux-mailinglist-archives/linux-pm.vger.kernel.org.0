Return-Path: <linux-pm+bounces-28421-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id DD954AD45CC
	for <lists+linux-pm@lfdr.de>; Wed, 11 Jun 2025 00:18:35 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id B48251754FD
	for <lists+linux-pm@lfdr.de>; Tue, 10 Jun 2025 22:18:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7860128AB11;
	Tue, 10 Jun 2025 22:18:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="uViTfxG9"
X-Original-To: linux-pm@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5320C28AB07
	for <linux-pm@vger.kernel.org>; Tue, 10 Jun 2025 22:18:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1749593905; cv=none; b=my57faZhLssDKepq/KB1fozyRH892tllV8InrC/vsSfnbECU9NXApJ0FPVUfzEZq+3tPP6JOrnjGo/1FKd3fBW1CCEepi/6ZhP3wPtKEe02zcQZ12ZLhf8tKn/O0Ep02brjNa44HCKkry0iNGs6j+lnv9UlpCJWbZmSRYz8LuQQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1749593905; c=relaxed/simple;
	bh=zDg7Z12C81rF6nSyW/g/D+4qk/Fq4mtzMDxDWBYNhpQ=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=UTDFaeWFEmXnROyEXH7EzEzFHp26KcCclSly+WKczgxBWq4P+BHcoINg5TtR0pQ18cy8PY4uw6TKH4M8vbgQ4yKICjSNIgq/uXRnMcKN2BW8W5hKuqY3typrBEq+IyBj3fFr+rZ9jGblv85SVMKcBA16tGjFHrpsHJCjCHHsBNo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=uViTfxG9; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 977A7C4CEEF;
	Tue, 10 Jun 2025 22:18:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1749593904;
	bh=zDg7Z12C81rF6nSyW/g/D+4qk/Fq4mtzMDxDWBYNhpQ=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:Reply-To:From;
	b=uViTfxG9/JM4WSEfUPxHAIJ0F5Yx/pdI8aAxYOC7mZGzyAm83roTGfRVV7zjBkRuV
	 419YqK8moEGyirwxUo2wahg3p5SbfwLYJPjKgJYfGa9K3l+d+yNG3Vmq/cRcBt9q5l
	 BptjMHoscW6WxtccNsUZtL4XwT/eTBUmgZozf/K/N2P+GOXOaPV9SuyJlQy8yAlEVH
	 idX+A9GNmqntx3N/hM6Jphi9xGqkrNvhA7QUbuiGPjT/p/ceLmdCLF8wxPuOh0mG+6
	 tkvGvRYipNqYDw9DrvsTrjl3tif+y//Rvp1jdhf6R/GSYNysCnX4+jQP9+GK9DZZEP
	 7uASMcFiFXQsA==
From: Len Brown <lenb@kernel.org>
To: linux-pm@vger.kernel.org
Cc: Len Brown <len.brown@intel.com>
Subject: [PATCH 2/2] tools/power turbostat: verify arguments to params --show and --hide
Date: Tue, 10 Jun 2025 18:18:13 -0400
Message-ID: <c07ce1369b8972c60993b86bfacaa77ceee3af3a.1749593891.git.len.brown@intel.com>
X-Mailer: git-send-email 2.45.2
In-Reply-To: <5d939fbdd480cdf276eccc01eda3ed41e37d3f8a.1749593891.git.len.brown@intel.com>
References: <5d939fbdd480cdf276eccc01eda3ed41e37d3f8a.1749593891.git.len.brown@intel.com>
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

$ sudo turbostat --quiet --show junk
turbostat: Counter 'junk' can not be added.

Previously, invalid argumetns to --show and --hide were silently ignored

Signed-off-by: Len Brown <len.brown@intel.com>
---
 tools/power/x86/turbostat/turbostat.c | 33 +++++++++++++++++++++++++--
 1 file changed, 31 insertions(+), 2 deletions(-)

diff --git a/tools/power/x86/turbostat/turbostat.c b/tools/power/x86/turbostat/turbostat.c
index 33a54a9e0781..4056b7e26a0f 100644
--- a/tools/power/x86/turbostat/turbostat.c
+++ b/tools/power/x86/turbostat/turbostat.c
@@ -2310,6 +2310,8 @@ char *deferred_add_names[MAX_DEFERRED];
 char *deferred_skip_names[MAX_DEFERRED];
 int deferred_add_index;
 int deferred_skip_index;
+unsigned int deferred_add_consumed;
+unsigned int deferred_skip_consumed;
 
 /*
  * HIDE_LIST - hide this list of counters, show the rest [default]
@@ -10512,8 +10514,10 @@ int is_deferred_add(char *name)
 	int i;
 
 	for (i = 0; i < deferred_add_index; ++i)
-		if (!strcmp(name, deferred_add_names[i]))
+		if (!strcmp(name, deferred_add_names[i])) {
+			deferred_add_consumed |= (1 << i);
 			return 1;
+		}
 	return 0;
 }
 
@@ -10522,11 +10526,34 @@ int is_deferred_skip(char *name)
 	int i;
 
 	for (i = 0; i < deferred_skip_index; ++i)
-		if (!strcmp(name, deferred_skip_names[i]))
+		if (!strcmp(name, deferred_skip_names[i])) {
+			deferred_skip_consumed |= (1 << i);
 			return 1;
+		}
 	return 0;
 }
 
+void verify_deferred_consumed(void)
+{
+	int i;
+	int fail = 0;
+
+	for (i = 0; i < deferred_add_index; ++i) {
+		if (!(deferred_add_consumed & (1 << i))) {
+			warnx("Counter '%s' can not be added.", deferred_add_names[i]);
+			fail++;
+		}
+	}
+	for (i = 0; i < deferred_skip_index; ++i) {
+		if (!(deferred_skip_consumed & (1 << i))) {
+			warnx("Counter '%s' can not be skipped.", deferred_skip_names[i]);
+			fail++;
+		}
+	}
+	if (fail)
+		exit(-EINVAL);
+}
+
 void probe_cpuidle_residency(void)
 {
 	char path[64];
@@ -10885,6 +10912,8 @@ int main(int argc, char **argv)
 	probe_cpuidle_residency();
 	probe_cpuidle_counts();
 
+	verify_deferred_consumed();
+
 	if (!getuid())
 		set_rlimit();
 
-- 
2.45.2


