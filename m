Return-Path: <linux-pm+bounces-42776-lists+linux-pm=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-pm@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id 4EL1I7K8lGm4HQIAu9opvQ
	(envelope-from <linux-pm+bounces-42776-lists+linux-pm=lfdr.de@vger.kernel.org>)
	for <lists+linux-pm@lfdr.de>; Tue, 17 Feb 2026 20:08:34 +0100
X-Original-To: lists+linux-pm@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id E3D2114F7EE
	for <lists+linux-pm@lfdr.de>; Tue, 17 Feb 2026 20:08:33 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 9E509301BCD3
	for <lists+linux-pm@lfdr.de>; Tue, 17 Feb 2026 19:08:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9A41B36F402;
	Tue, 17 Feb 2026 19:08:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Lb8bcyOn"
X-Original-To: linux-pm@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 782E1285406
	for <linux-pm@vger.kernel.org>; Tue, 17 Feb 2026 19:08:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1771355281; cv=none; b=k0H6Me8yWgRyOHKI2KlMbqUV70Yn2mpANvAQS2eLyI3j2qoQiq5daAzSSDQE55y3YmRg3qEwygInKGKCF7ag024f5nGQOZfkgZNbdjciViOVG/Ppw+WLCjhMIAdGkaGD275pTCX5/0E42h43sxttdgowa6NMaF4wXUZvODyYuzo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1771355281; c=relaxed/simple;
	bh=qE/jAI8JyFUsY1PJi+iuNLR2nZFupFru7IfMxp2Q/qo=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=C/zTAHdXInVpq7VJjVKOtccS6uzIyl403JxtJLWng27SppyyXclG9gKul18RILG6EhZzUEP0+sD+PQlACN6dB4ToALoHxb/J9TZdy+CxZ2AfoNuqC0tPBXua1Oawixfhoc/jcJb/6MiIIsgdG7mVCzc7c2Z7Sqd1NVzN3JaLWeE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Lb8bcyOn; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 15796C4CEF7;
	Tue, 17 Feb 2026 19:07:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1771355281;
	bh=qE/jAI8JyFUsY1PJi+iuNLR2nZFupFru7IfMxp2Q/qo=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:Reply-To:From;
	b=Lb8bcyOnnVRI2hLEEM2MOEyUhB4GjpFcMwFpv6gaxmPOM6qgDtUxqssNi0wY/nC3Z
	 b6dAT49LCPpds3axG+zYNl8qrE7/ayiggIYrTlfvu1j2ufL5oFkMc8mRi8508xHjK/
	 Uj6tJoBatDiy1pZ08qwL5f48n5vddHHloc2uhDaYZbaB6wSM+S+YxUDC/RvFm4D+5c
	 YNYUDYLGPQOYwu7UKagci+nsYWaTksHkMHj5Yx98CjgY3FLdAaqA4KLMMqopt3fSYX
	 PbpvGbNEMSRa9UB6N//SLcmpZpSpwTIRoV6ABdalnWZlSOWGGMgC19+o3lOU15eHJQ
	 r6f5i0NARKTDw==
From: Len Brown <lenb@kernel.org>
To: linux-pm@vger.kernel.org
Cc: Len Brown <len.brown@intel.com>
Subject: [PATCH 08/23] tools/power turbostat: Allow more use of is_hybrid flag
Date: Tue, 17 Feb 2026 13:03:59 -0600
Message-ID: <b991074a5144d740ae3812a54e138aaaaf12dc7a.1771354332.git.len.brown@intel.com>
X-Mailer: git-send-email 2.45.2
In-Reply-To: <16cc8f249c702b7cbb4c2c2be7cd8f4fdd5d1d0c.1771354332.git.len.brown@intel.com>
References: <16cc8f249c702b7cbb4c2c2be7cd8f4fdd5d1d0c.1771354332.git.len.brown@intel.com>
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Reply-To: Len Brown <lenb@kernel.org>
Organization: Intel Open Source Technology Center
Content-Transfer-Encoding: 8bit
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-1.66 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	R_MISSING_CHARSET(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	HAS_ORG_HEADER(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	RCPT_COUNT_TWO(0.00)[2];
	TO_DN_SOME(0.00)[];
	TAGGED_FROM(0.00)[bounces-42776-lists,linux-pm=lfdr.de];
	MIME_TRACE(0.00)[0:+];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	HAS_REPLYTO(0.00)[lenb@kernel.org];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[lenb@kernel.org,linux-pm@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[kernel.org:+];
	DBL_BLOCKED_OPENRESOLVER(0.00)[intel.com:mid,intel.com:email,sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[linux-pm];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	REPLYTO_EQ_FROM(0.00)[]
X-Rspamd-Queue-Id: E3D2114F7EE
X-Rspamd-Action: no action

From: Len Brown <len.brown@intel.com>

The "is_hybrid" is set and used only in !quiet mode.

Make it valid in both quiet and !quiet mode to allow more uses.

Signed-off-by: Len Brown <len.brown@intel.com>
---
 tools/power/x86/turbostat/turbostat.c | 10 +++++++---
 1 file changed, 7 insertions(+), 3 deletions(-)

diff --git a/tools/power/x86/turbostat/turbostat.c b/tools/power/x86/turbostat/turbostat.c
index 2dfc110ae483..75c865120656 100644
--- a/tools/power/x86/turbostat/turbostat.c
+++ b/tools/power/x86/turbostat/turbostat.c
@@ -8157,6 +8157,9 @@ void decode_feature_control_msr(void)
 	if (no_msr)
 		return;
 
+	if (quiet)
+		return;
+
 	if (!get_msr(base_cpu, MSR_IA32_FEAT_CTL, &msr))
 		fprintf(outf, "cpu%d: MSR_IA32_FEATURE_CONTROL: 0x%08llx (%sLocked %s)\n",
 			base_cpu, msr, msr & FEAT_CTL_LOCKED ? "" : "UN-", msr & (1 << 18) ? "SGX" : "");
@@ -8921,7 +8924,7 @@ void process_cpuid()
 	if (!quiet)
 		decode_misc_enable_msr();
 
-	if (max_level >= 0x7 && !quiet) {
+	if (max_level >= 0x7) {
 		int has_sgx;
 
 		ecx = 0;
@@ -8930,9 +8933,10 @@ void process_cpuid()
 
 		has_sgx = ebx & (1 << 2);
 
-		is_hybrid = edx & (1 << 15);
+		is_hybrid = !!(edx & (1 << 15));
 
-		fprintf(outf, "CPUID(7): %sSGX %sHybrid\n", has_sgx ? "" : "No-", is_hybrid ? "" : "No-");
+		if (!quiet)
+			fprintf(outf, "CPUID(7): %sSGX %sHybrid\n", has_sgx ? "" : "No-", is_hybrid ? "" : "No-");
 
 		if (has_sgx)
 			decode_feature_control_msr();
-- 
2.45.2


