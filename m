Return-Path: <linux-pm+bounces-33734-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 54CE5B42427
	for <lists+linux-pm@lfdr.de>; Wed,  3 Sep 2025 16:56:23 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 926655E46DB
	for <lists+linux-pm@lfdr.de>; Wed,  3 Sep 2025 14:56:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0530B2FE058;
	Wed,  3 Sep 2025 14:56:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="CR0Exwn5"
X-Original-To: linux-pm@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D1CE4213E6D;
	Wed,  3 Sep 2025 14:56:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756911369; cv=none; b=baDV3tSxsYKBmJmFv+OHEsquTKhL7Xjxhi1fIZDaXithV1uRyT6fivNjQu0iPEmRPsYtawh/UnjKjkExAohJCcOpWi4rl7397uJzRMMK+pKi9+e3Ejn5y35i/l19+aUi2F4qIkksgImzj+N+/1yeFNM2cJPYispQgUKH0RtWYe8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756911369; c=relaxed/simple;
	bh=fyT8F1OdM5Im8IxoGeyk6V0vUNEhI+uFQ3mu15FZr98=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version:Content-Type; b=E68BReJC+S+GZ4y+ldofGTf/ZnKFAvNGEVa021N30JtDVsytNeZryF7w8dT331paTev0VCjFbeW+/S1Melmf5W4+qiOAnKpLB25/W8MJThCjTdHn1HBDR0+jLbVfKWyTo9rflT5C0swueZIPRpD3aVkiPH0BTrIzMzs/xWHhAkc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=CR0Exwn5; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B0C1EC4CEE7;
	Wed,  3 Sep 2025 14:56:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1756911369;
	bh=fyT8F1OdM5Im8IxoGeyk6V0vUNEhI+uFQ3mu15FZr98=;
	h=From:To:Cc:Subject:Date:From;
	b=CR0Exwn5abVZ3SLaiL1Fks0DMyZweqUobY4ouS1FKSSqB1jsQSxNyZS+LiGgrbIQE
	 vILuGfJfU/DhvdDecvSbn2sUUZo/DYFhom35YB5S+C+lopGVN72S9oXLn28zNIO1Fx
	 +PtBTBylyZ9fGmXs3pzIbxYBzGfl73oD92aWgynpdK5TNdnmkwr49FXL8bFstDOL9v
	 WvLfgmTmROOmPWr33Cx6i4gSy6F6bAvqD4y+P5tiTsiVRMDJLRoH28b8vbrsYFYC22
	 KNtloPgcimwzVNC7PWrzSeH2S8i3w0+D9XJs0DRZ4wbjUhxVq0s3lAh/tmw0RpGbGR
	 K32bYfiuf2hkA==
From: "Rafael J. Wysocki" <rafael@kernel.org>
To: Linux PM <linux-pm@vger.kernel.org>
Cc: LKML <linux-kernel@vger.kernel.org>,
 Viresh Kumar <viresh.kumar@linaro.org>,
 Krzysztof Kozlowski <krzk@kernel.org>, Zihuan Zhang <zhangzihuan@kylinos.cn>
Subject:
 [PATCH v1] cpufreq: core: Rearrange variable declarations involving __free()
Date: Wed, 03 Sep 2025 16:56:04 +0200
Message-ID: <4691667.LvFx2qVVIh@rafael.j.wysocki>
Organization: Linux Kernel Development
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 7Bit
Content-Type: text/plain; charset="UTF-8"

From: Rafael J. Wysocki <rafael.j.wysocki@intel.com>

Follow cleanup.h recommendations and always define and assign variables
in one statement when __free() is used.

No intentional functional impact.

Signed-off-by: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
---
 drivers/cpufreq/cpufreq.c |   27 +++++++--------------------
 1 file changed, 7 insertions(+), 20 deletions(-)

--- a/drivers/cpufreq/cpufreq.c
+++ b/drivers/cpufreq/cpufreq.c
@@ -1845,7 +1845,6 @@ static unsigned int cpufreq_verify_curre
  */
 unsigned int cpufreq_quick_get(unsigned int cpu)
 {
-	struct cpufreq_policy *policy __free(put_cpufreq_policy) = NULL;
 	unsigned long flags;
 
 	read_lock_irqsave(&cpufreq_driver_lock, flags);
@@ -1860,7 +1859,7 @@ unsigned int cpufreq_quick_get(unsigned
 
 	read_unlock_irqrestore(&cpufreq_driver_lock, flags);
 
-	policy = cpufreq_cpu_get(cpu);
+	struct cpufreq_policy *policy __free(put_cpufreq_policy) = cpufreq_cpu_get(cpu);
 	if (policy)
 		return policy->cur;
 
@@ -1876,9 +1875,7 @@ EXPORT_SYMBOL(cpufreq_quick_get);
  */
 unsigned int cpufreq_quick_get_max(unsigned int cpu)
 {
-	struct cpufreq_policy *policy __free(put_cpufreq_policy);
-
-	policy = cpufreq_cpu_get(cpu);
+	struct cpufreq_policy *policy __free(put_cpufreq_policy) = cpufreq_cpu_get(cpu);
 	if (policy)
 		return policy->max;
 
@@ -1894,9 +1891,7 @@ EXPORT_SYMBOL(cpufreq_quick_get_max);
  */
 __weak unsigned int cpufreq_get_hw_max_freq(unsigned int cpu)
 {
-	struct cpufreq_policy *policy __free(put_cpufreq_policy);
-
-	policy = cpufreq_cpu_get(cpu);
+	struct cpufreq_policy *policy __free(put_cpufreq_policy) = cpufreq_cpu_get(cpu);
 	if (policy)
 		return policy->cpuinfo.max_freq;
 
@@ -1920,9 +1915,7 @@ static unsigned int __cpufreq_get(struct
  */
 unsigned int cpufreq_get(unsigned int cpu)
 {
-	struct cpufreq_policy *policy __free(put_cpufreq_policy);
-
-	policy = cpufreq_cpu_get(cpu);
+	struct cpufreq_policy *policy __free(put_cpufreq_policy) = cpufreq_cpu_get(cpu);
 	if (!policy)
 		return 0;
 
@@ -2751,9 +2744,7 @@ static void cpufreq_policy_refresh(struc
  */
 void cpufreq_update_policy(unsigned int cpu)
 {
-	struct cpufreq_policy *policy __free(put_cpufreq_policy);
-
-	policy = cpufreq_cpu_get(cpu);
+	struct cpufreq_policy *policy __free(put_cpufreq_policy) = cpufreq_cpu_get(cpu);
 	if (!policy)
 		return;
 
@@ -2770,9 +2761,7 @@ EXPORT_SYMBOL(cpufreq_update_policy);
  */
 void cpufreq_update_limits(unsigned int cpu)
 {
-	struct cpufreq_policy *policy __free(put_cpufreq_policy);
-
-	policy = cpufreq_cpu_get(cpu);
+	struct cpufreq_policy *policy __free(put_cpufreq_policy) = cpufreq_cpu_get(cpu);
 	if (!policy)
 		return;
 
@@ -3054,9 +3043,7 @@ static int __init cpufreq_core_init(void
 
 static bool cpufreq_policy_is_good_for_eas(unsigned int cpu)
 {
-	struct cpufreq_policy *policy __free(put_cpufreq_policy);
-
-	policy = cpufreq_cpu_get(cpu);
+	struct cpufreq_policy *policy __free(put_cpufreq_policy) = cpufreq_cpu_get(cpu);
 	if (!policy) {
 		pr_debug("cpufreq policy not set for CPU: %d\n", cpu);
 		return false;




