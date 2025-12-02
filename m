Return-Path: <linux-pm+bounces-39120-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id D6E21C9D0DD
	for <lists+linux-pm@lfdr.de>; Tue, 02 Dec 2025 22:19:31 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id DC5C54E4E7F
	for <lists+linux-pm@lfdr.de>; Tue,  2 Dec 2025 21:19:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D4B472F83AA;
	Tue,  2 Dec 2025 21:18:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="m+diBAZD"
X-Original-To: linux-pm@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B08352D47E1
	for <linux-pm@vger.kernel.org>; Tue,  2 Dec 2025 21:18:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1764710327; cv=none; b=t/ggkQ4AkaWoNXC6gKyg3gMde8x+v1hyqv3tUoZd5iguB3WFFi+/slqoRCe78ks3PHzY3BR0HFw+456InnaaSWjLzzkcNV2NAtIVuN2iIIORllcjqrXp07Vsqk3C2RbvOVsYboOMqiIrmJWOh7qCEE7xXiJN/9pE5EPbVmYmFCM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1764710327; c=relaxed/simple;
	bh=XgokCzI8uqtMRICqu+mIOuad8lgLw1y11zSFguAUcmo=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=bsym9HFNPb/NuUtVOPRMFo9Fgdar63fpbd1bZeKBdE45B25ZiLMdhy5jmmoYV3P7FfWEzHk8leukUNrnXz9YyN44rIVr36YgSryXWcvRL7N6KJ9z6lCvFVcL2nFYjwWQWyMnEk9S6MHvQR/n6SL9MaFvfBWQ8QQRaS5ZH1ifKgo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=m+diBAZD; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8D83BC113D0;
	Tue,  2 Dec 2025 21:18:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1764710327;
	bh=XgokCzI8uqtMRICqu+mIOuad8lgLw1y11zSFguAUcmo=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:Reply-To:From;
	b=m+diBAZD52BH2ACoV2719t6ddaAjDrGwZw4cv2Yxffd9a3OuwtAnY5m7XaBjcUorz
	 KKX8nuIyvt1IQIcjDnM5RCd+lNGyzKAfNKGuJxDTSaVanZwOLXAQkVr28f2e+2O/kZ
	 LlGPqiDgWwcF8bJHDdIPEonP7Ycyt/wdGALVXAR94ktXbvIZY6Q3YCbewqdC2L7V5+
	 Kkqq3CLc9fHeoHUda4S/QCsKHffdKYeX++KeIiFum2YfW25EI96DyOyQQzPATJQPUO
	 S4EW6FOcWjbR2H53hfu6cDqKnBJ7Kiybs5vVWqRWeEk9P/hxAU6HNfQIHqQvpxBfeH
	 Uh2Dzgrr37E2A==
From: Len Brown <lenb@kernel.org>
To: linux-pm@vger.kernel.org
Cc: Malaya Kumar Rout <mrout@redhat.com>,
	Len Brown <len.brown@intel.com>
Subject: [PATCH 14/21] tools/power x86_energy_perf_policy: Fix potential NULL pointer dereference
Date: Tue,  2 Dec 2025 16:13:32 -0500
Message-ID: <51860d6330b6cda355a7e30b3e09e7a22ec4b6ae.1764710012.git.len.brown@intel.com>
X-Mailer: git-send-email 2.45.2
In-Reply-To: <92664f2e6ab2228a3330734fc72dabeaf8a49ee1.1764710012.git.len.brown@intel.com>
References: <92664f2e6ab2228a3330734fc72dabeaf8a49ee1.1764710012.git.len.brown@intel.com>
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Reply-To: Len Brown <lenb@kernel.org>
Organization: Intel Open Source Technology Center
Content-Transfer-Encoding: 8bit

From: Malaya Kumar Rout <mrout@redhat.com>

In err_on_hypervisor(), strstr() is called to search for "flags" in the
buffer, but the return value is not checked before being used in pointer
arithmetic (flags - buffer). If strstr() returns NULL because "flags" is
not found in /proc/cpuinfo, this will cause undefined behavior and likely
a crash.

Add a NULL check after the strstr() call and handle the error appropriately
by cleaning up resources and reporting a meaningful error message.

Signed-off-by: Malaya Kumar Rout <mrout@redhat.com>
Signed-off-by: Len Brown <len.brown@intel.com>
---
 .../x86/x86_energy_perf_policy/x86_energy_perf_policy.c    | 7 ++++++-
 1 file changed, 6 insertions(+), 1 deletion(-)

diff --git a/tools/power/x86/x86_energy_perf_policy/x86_energy_perf_policy.c b/tools/power/x86/x86_energy_perf_policy/x86_energy_perf_policy.c
index b2125275c69e..ac37132207a4 100644
--- a/tools/power/x86/x86_energy_perf_policy/x86_energy_perf_policy.c
+++ b/tools/power/x86/x86_energy_perf_policy/x86_energy_perf_policy.c
@@ -520,7 +520,7 @@ void for_packages(unsigned long long pkg_set, int (func)(int))
 
 void print_version(void)
 {
-	printf("x86_energy_perf_policy 2025.9.19 Len Brown <lenb@kernel.org>\n");
+	printf("x86_energy_perf_policy 2025.11.22 Len Brown <lenb@kernel.org>\n");
 }
 
 void cmdline(int argc, char **argv)
@@ -662,6 +662,11 @@ void err_on_hypervisor(void)
 	}
 
 	flags = strstr(buffer, "flags");
+	if (!flags) {
+		fclose(cpuinfo);
+		free(buffer);
+		err(1, "Failed to find 'flags' in /proc/cpuinfo");
+	}
 	rewind(cpuinfo);
 	fseek(cpuinfo, flags - buffer, SEEK_SET);
 	if (!fgets(buffer, 4096, cpuinfo)) {
-- 
2.45.2


