Return-Path: <linux-pm+bounces-35435-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id BCB72BA2443
	for <lists+linux-pm@lfdr.de>; Fri, 26 Sep 2025 04:54:55 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 162F61C28093
	for <lists+linux-pm@lfdr.de>; Fri, 26 Sep 2025 02:55:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 76E25266B40;
	Fri, 26 Sep 2025 02:54:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="FJSzKQLa"
X-Original-To: linux-pm@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 513D3265621
	for <linux-pm@vger.kernel.org>; Fri, 26 Sep 2025 02:54:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758855271; cv=none; b=vDyze6ZH8awnQIMgMu5uJibjdgpevEbMFdXrCw+3ZcmpZaxz4lebFxkccsNserAIPvT3zZjAfLR+Z3tY5ReWqDWMr3bGJKMQ3+fY4mNaNOhpFZguLMyHg/KJq8zBAelKplu+l8iCoWfQIU9WwapQQp549kgNuP536o4Cro+KG5w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758855271; c=relaxed/simple;
	bh=lZBYbthi69gGHls+CV4OysSnZe128kOVH/Wpc1u5CdI=;
	h=From:To:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Z6KXHyklbag5e3b4zNbQc9Xd7mf5z5n1VleUGL0rc2vz/tvTYkG1nvJKJr6vJGBjXZLix7+4ynvAlgDAv4j7u3uF2SjWetPSCCqteygb3rd1UqxZp+9fCKlLyEs7btQFmfdvwy4wh//ehnDcNaa6WKJR1fphTnjkbxCmtWaE9aU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=FJSzKQLa; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id AD1A0C4CEF0
	for <linux-pm@vger.kernel.org>; Fri, 26 Sep 2025 02:54:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1758855269;
	bh=lZBYbthi69gGHls+CV4OysSnZe128kOVH/Wpc1u5CdI=;
	h=From:To:Subject:Date:In-Reply-To:References:Reply-To:From;
	b=FJSzKQLa7VjlkgW+SMD9P/a0zO4L1wAfqSdlmtdgn22ihymS0C6ebzvsC1ynj0Wc1
	 PlCC9ptcE638V0haCEkhAGZOUWYjM+EXjUYYOUZAKmYGKcnUl1COvEn4ACvUQ/cpqI
	 /2EsatCmKWxQYDkT+pgc2OPYfr4uj792Vq0hQXjsKrRO5eFlBquSi+d6ohP80KONfH
	 h6dcPmgjv0UGpfBSuDhXxmgZRpxohoZOLvkWnQ3fu7KOJP0vGZpzCQILeZzKWidciN
	 DlwtG1Es4lN1T4MWyrqAKhaum7fI0sYqUav9QBDJper+kndoWZMu02SLGtuOUiVIXI
	 ONkqp3S8Si2rw==
From: Len Brown <lenb@kernel.org>
To: linux-pm@vger.kernel.org
Subject: [PATCH 7/7] tools/power x86_energy_perf_policy.8: Emphasize preference for SW interfaces
Date: Thu, 25 Sep 2025 22:51:09 -0400
Message-ID: <52388e341b04d67b1a1858ada14c19cc464aa4bb.1758855052.git.len.brown@intel.com>
X-Mailer: git-send-email 2.45.2
In-Reply-To: <4902665808e17a711200c46558803f526cbb154a.1758855052.git.len.brown@intel.com>
References: <4902665808e17a711200c46558803f526cbb154a.1758855052.git.len.brown@intel.com>
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

This tool was originally written when Linux had no standard
interface for EPB, or HWP support.

Retain the capability to manage a system w/o any kernel PM support,
but prefer the standard kernel interfaces, when avaialble.

(not doing so led to a confusing conflict between a p-state limit
 request made via cpufreq and modified by the intel-pstate driver,
 versus the raw MSR write made by this utility)

Signed-off-by: Len Brown <len.brown@intel.com>
---
 .../x86_energy_perf_policy.8                      | 15 +++++++++++----
 1 file changed, 11 insertions(+), 4 deletions(-)

diff --git a/tools/power/x86/x86_energy_perf_policy/x86_energy_perf_policy.8 b/tools/power/x86/x86_energy_perf_policy/x86_energy_perf_policy.8
index 78c6361898b1..0aa981c18e56 100644
--- a/tools/power/x86/x86_energy_perf_policy/x86_energy_perf_policy.8
+++ b/tools/power/x86/x86_energy_perf_policy/x86_energy_perf_policy.8
@@ -2,7 +2,7 @@
 .\"  Distributed under the GPL, Copyleft 1994.
 .TH X86_ENERGY_PERF_POLICY 8
 .SH NAME
-x86_energy_perf_policy \- Manage Energy vs. Performance Policy via x86 Model Specific Registers
+x86_energy_perf_policy \- Manage Energy vs. Performance Policy
 .SH SYNOPSIS
 .B x86_energy_perf_policy
 .RB "[ options ] [ scope ] [field \ value]"
@@ -19,9 +19,14 @@ x86_energy_perf_policy \- Manage Energy vs. Performance Policy via x86 Model Spe
 .SH DESCRIPTION
 \fBx86_energy_perf_policy\fP
 displays and updates energy-performance policy settings specific to
-Intel Architecture Processors.  Settings are accessed via Model Specific Register (MSR)
-updates, no matter if the Linux cpufreq sub-system is enabled or not.
+Intel Architecture Processors.  It summarizes settings available
+in standard Linux interfaces (eg. cpufreq),
+and also decodes underlying Model Specific Register (MSRs).
+While \fBx86_energy_perf_policy\fP can manage energy-performance policy
+using only MSR access, it prefers standard
+Linux kernel interfaces, when they are available.
 
+.SH BACKGROUND
 Policy in MSR_IA32_ENERGY_PERF_BIAS (EPB)
 may affect a wide range of hardware decisions,
 such as how aggressively the hardware enters and exits CPU idle states (C-states)
@@ -200,7 +205,9 @@ runs only as root.
 .SH FILES
 .ta
 .nf
-/dev/cpu/*/msr
+EPB: /sys/devices/system/cpu/cpu*/power/energy_perf_bias
+EPP: /sys/devices/system/cpu/cpu*/cpufreq/energy_performance_preference
+MSR: /dev/cpu/*/msr
 .fi
 .SH "SEE ALSO"
 .nf
-- 
2.45.2


