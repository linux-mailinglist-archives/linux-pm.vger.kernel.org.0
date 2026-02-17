Return-Path: <linux-pm+bounces-42774-lists+linux-pm=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-pm@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id aGQABqK8lGm4HQIAu9opvQ
	(envelope-from <linux-pm+bounces-42774-lists+linux-pm=lfdr.de@vger.kernel.org>)
	for <lists+linux-pm@lfdr.de>; Tue, 17 Feb 2026 20:08:18 +0100
X-Original-To: lists+linux-pm@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 6F51E14F7B3
	for <lists+linux-pm@lfdr.de>; Tue, 17 Feb 2026 20:08:17 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 4F65930490C9
	for <lists+linux-pm@lfdr.de>; Tue, 17 Feb 2026 19:07:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F10FA37472A;
	Tue, 17 Feb 2026 19:07:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="twggVKBv"
X-Original-To: linux-pm@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CE377372B44
	for <linux-pm@vger.kernel.org>; Tue, 17 Feb 2026 19:07:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1771355277; cv=none; b=adyCeoJ2m6JYr238UI5BAgv4ArmhRx+5WVPTvK9lbTUtUR59/XemPKLMeOm4Qqqaf/AsZsv0cJBVbBAptg7t11zq8h4LAXdrTHK+6vSHmwEOFKwf4xGC/HxzzwSv4IpimEbwbbVPKYXfZSEAVw1+wqrO0f4U5iz3OFgeldhcz3w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1771355277; c=relaxed/simple;
	bh=CRCXroUSuLo0OR6959rltuB75+mVVzNsDkf6Q/EZu2U=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=AWtV9fntgMpqOFXulCrc6kRWIe1ZEJfbQ4wLmsA81sHzcOQSX9pmoSlI6kLJfYzmciZNmB9iVAkkRLX0Bykx5RF5FwUcnIj5CoKTkopv8Aci+GIhp4+Y3rafUwMIV552paxouVWfySZ1q1lMvO9A5gCSQIqlUg00YzSyihSbdiY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=twggVKBv; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 34E71C4CEF7;
	Tue, 17 Feb 2026 19:07:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1771355277;
	bh=CRCXroUSuLo0OR6959rltuB75+mVVzNsDkf6Q/EZu2U=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:Reply-To:From;
	b=twggVKBvBW/Rw772Aj89nrXWoCXf6LEspinSS1CCaH2Uhq8udJ+PL/O4feR9ROxCW
	 tQ3co6GbdenkOcElIo9Y1ReZ/VRaoZLFhKdeyBbBkxySARSdDCrfkgCDscBK9zEfsC
	 NCmPKdJtJ2tM2llAd1m2K9NKomz3rXhJwZdxkntMlIntApRmCc07yw+4Q/sTNkWCPC
	 5mOM+hQUey5SBmrHgsTtHyqSrXuyAMb7HvLP0yNaK7mA1IOzlNKeDLjQ13HJzSL/nl
	 jsMU2HM323rb7JjrREvm5TFWEqxn1Z/7U+x2VgelqfqJqe14sZgd33gmIFrUgt6aRv
	 D5/7DeFJRUOiA==
From: Len Brown <lenb@kernel.org>
To: linux-pm@vger.kernel.org
Cc: Len Brown <len.brown@intel.com>
Subject: [PATCH 06/23] tools/power turbostat.8: Document the "--force" option
Date: Tue, 17 Feb 2026 13:03:57 -0600
Message-ID: <785953cf6e63aa5a9fcdfa9577b1411e0281c4bc.1771354332.git.len.brown@intel.com>
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
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
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
	TAGGED_FROM(0.00)[bounces-42774-lists,linux-pm=lfdr.de];
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
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	REPLYTO_EQ_FROM(0.00)[]
X-Rspamd-Queue-Id: 6F51E14F7B3
X-Rspamd-Action: no action

From: Len Brown <len.brown@intel.com>

Starting in turbostat v2025.01.14, turbostat refused to run
on unsupported hardware, pointing to "RUN THE LATEST VERSION"
on turbostat(8).

At that time, turbostat supported and advertised the "--force"
parameter to run anyway (with unsupported results).

Also document "--force" on turbostat.8.

Signed-off-by: Len Brown <len.brown@intel.com>
---
 tools/power/x86/turbostat/turbostat.8 | 10 +++++++---
 1 file changed, 7 insertions(+), 3 deletions(-)

diff --git a/tools/power/x86/turbostat/turbostat.8 b/tools/power/x86/turbostat/turbostat.8
index 1551fcdbfd8a..cb3fd8576146 100644
--- a/tools/power/x86/turbostat/turbostat.8
+++ b/tools/power/x86/turbostat/turbostat.8
@@ -111,6 +111,8 @@ The column name "all" can be used to enable all disabled-by-default built-in cou
 .PP
 \fB--no-perf\fP Disable all the uses of the perf API.
 .PP
+\fB--force\fPForce turbostat to run on an unsupported platform (minimal defaults).
+.PP
 \fB--interval seconds\fP overrides the default 5.0 second measurement interval.
 .PP
 \fB--num_iterations num\fP number of the measurement iterations.
@@ -165,9 +167,9 @@ The system configuration dump (if --quiet is not used) is followed by statistics
 .PP
 \fBC1, C2, C3...\fP The number times Linux requested the C1, C2, C3 idle state during the measurement interval.  The system summary line shows the sum for all CPUs.  These are C-state names as exported in /sys/devices/system/cpu/cpu*/cpuidle/state*/name.  While their names are generic, their attributes are processor specific. They the system description section of output shows what MWAIT sub-states they are mapped to on each system.  These counters are in the "cpuidle" group, which is disabled, by default.
 .PP
-\fBC1+, C2+, C3+...\fP The idle governor idle state misprediction statistics. Inidcates the number times Linux requested the C1, C2, C3 idle state during the measurement interval, but should have requested a deeper idle state (if it exists and enabled). These statistics come from the /sys/devices/system/cpu/cpu*/cpuidle/state*/below file.  These counters are in the "cpuidle" group, which is disabled, by default.
+\fBC1+, C2+, C3+...\fP The idle governor idle state misprediction statistics. Indicates the number times Linux requested the C1, C2, C3 idle state during the measurement interval, but should have requested a deeper idle state (if it exists and enabled). These statistics come from the /sys/devices/system/cpu/cpu*/cpuidle/state*/below file.  These counters are in the "cpuidle" group, which is disabled, by default.
 .PP
-\fBC1-, C2-, C3-...\fP The idle governor idle state misprediction statistics. Inidcates the number times Linux requested the C1, C2, C3 idle state during the measurement interval, but should have requested a shallower idle state (if it exists and enabled). These statistics come from the /sys/devices/system/cpu/cpu*/cpuidle/state*/above file.  These counters are in the "cpuidle" group, which is disabled, by default.
+\fBC1-, C2-, C3-...\fP The idle governor idle state misprediction statistics. Indicates the number times Linux requested the C1, C2, C3 idle state during the measurement interval, but should have requested a shallower idle state (if it exists and enabled). These statistics come from the /sys/devices/system/cpu/cpu*/cpuidle/state*/above file.  These counters are in the "cpuidle" group, which is disabled, by default.
 .PP
 \fBC1%, C2%, C3%\fP The residency percentage that Linux requested C1, C2, C3....  The system summary is the average of all CPUs in the system.  Note that these are software, reflecting what was requested.  The hardware counters reflect what was actually achieved.  These counters are in the "pct_idle" group, which is enabled by default.
 .PP
@@ -197,7 +199,7 @@ The system configuration dump (if --quiet is not used) is followed by statistics
 .PP
 \fBGFX%C0\fP Percentage of time that at least one GFX compute engine is busy.
 .PP
-\fBCPUGFX%\fP Percentage of time that at least one CPU is busy at the same time as at least one Graphics compute enginer is busy.
+\fBCPUGFX%\fP Percentage of time that at least one CPU is busy at the same time as at least one Graphics compute engine is busy.
 .PP
 \fBPkg%pc2, Pkg%pc3, Pkg%pc6, Pkg%pc7\fP percentage residency in hardware package idle states.  These numbers are from hardware residency counters.
 .PP
@@ -559,6 +561,8 @@ If the upstream version isn't new enough, the development tree can be found here
 If the development tree doesn't work, please contact the author via chat,
 or via email with the word "turbostat" on the Subject line.
 
+An old turbostat binary may run on unknown hardware by using "--force",
+but results are unsupported.
 .SH FILES
 .ta
 .nf
-- 
2.45.2


