Return-Path: <linux-pm+bounces-42770-lists+linux-pm=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-pm@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id iMlAE4q8lGm4HQIAu9opvQ
	(envelope-from <linux-pm+bounces-42770-lists+linux-pm=lfdr.de@vger.kernel.org>)
	for <lists+linux-pm@lfdr.de>; Tue, 17 Feb 2026 20:07:54 +0100
X-Original-To: lists+linux-pm@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [172.232.135.74])
	by mail.lfdr.de (Postfix) with ESMTPS id DBA5D14F761
	for <lists+linux-pm@lfdr.de>; Tue, 17 Feb 2026 20:07:53 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id 1FC04300B592
	for <lists+linux-pm@lfdr.de>; Tue, 17 Feb 2026 19:07:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1845836EAA9;
	Tue, 17 Feb 2026 19:07:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Bsz8g/Ce"
X-Original-To: linux-pm@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EA2C1285406
	for <linux-pm@vger.kernel.org>; Tue, 17 Feb 2026 19:07:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1771355271; cv=none; b=HF5NLlazXn+eaIN0fZftBlAkull8QIagHr0hc7ZApp3+OKcXYkdY0zrCNl6TyJLfKQcJclL2vT40OlY8U3yny4rY88J8WyUNIIZKtcX9/ooTXNdojMBEvrqBzyujgwS8tvAAYIHWh3dt0wuUe1+HgJnckMZPkslV/4uiDPzi68c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1771355271; c=relaxed/simple;
	bh=MEna5AXf/pd2WjrlegmQJEO9bmqUbV+dsEDaL72IC/s=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=dz5sIMbXle5N7jL/5gEoLSJfvGlGNMYzNiF/0D/z5ECZw58usLwClJdc9nrZJ0bErEY8UhM8Zh1/6+8FlEraHU5cLZI67hr63IYdi9ukbOkbs8DmMf/DQiS8YHJIKMyJLj9Xi04ef4tiqmcugeIEofBDwlSKRBdzJuciXOTmr2c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Bsz8g/Ce; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 72BC6C4CEF7;
	Tue, 17 Feb 2026 19:07:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1771355270;
	bh=MEna5AXf/pd2WjrlegmQJEO9bmqUbV+dsEDaL72IC/s=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:Reply-To:From;
	b=Bsz8g/CeHuRHC2L1zIaQK+fG68KZWaixTxyXsydS4EXDPlvlqagxVYibjr3JOsPVg
	 /pDBe6DV78jymAxghd1emutJqxpVJcCzyfoNv3Llm4nNo9kW1xVb/khgq0y6sZS2qE
	 d4kD4SH/1CSMCPjPRBUpeq5wjJ3T+U8r+0PYP3utYHFDRgXWmjXNjX9NerTrMV0l8M
	 9JJo+cY+XCO3v3DSeEDn12AO0YfRapZ/KsjT9KrJ8U6pqx98PcLlXzQ3girM2vxYif
	 14KWTsdKLRizafZHmdSBLef1eharsSdNfiNBu0idDr0ixhkAbtJ2+5dw7n4XZyhW2S
	 gERBcSSalEm4g==
From: Len Brown <lenb@kernel.org>
To: linux-pm@vger.kernel.org
Cc: Len Brown <len.brown@intel.com>
Subject: [PATCH 02/23] tools/power turbostat: Dump CPUID(1) consistently with CPUID(6)
Date: Tue, 17 Feb 2026 13:03:53 -0600
Message-ID: <bd1b6608d7640aa8b1f1afa831331df7c13184ad.1771354332.git.len.brown@intel.com>
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
	R_SPF_ALLOW(-0.20)[+ip4:172.232.135.74:c];
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
	TAGGED_FROM(0.00)[bounces-42770-lists,linux-pm=lfdr.de];
	MIME_TRACE(0.00)[0:+];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	HAS_REPLYTO(0.00)[lenb@kernel.org];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[lenb@kernel.org,linux-pm@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[kernel.org:+];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sto.lore.kernel.org:helo,sto.lore.kernel.org:rdns,intel.com:mid,intel.com:email];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[linux-pm];
	ASN(0.00)[asn:63949, ipnet:172.232.128.0/19, country:SG];
	REPLYTO_EQ_FROM(0.00)[]
X-Rspamd-Queue-Id: DBA5D14F761
X-Rspamd-Action: no action

From: Len Brown <len.brown@intel.com>

We dumped selected CPUID(1) features using a format that showed '-'
for a missing feature.  Not so friendly to parse a bunch of dashes
when features are missing...

For CPUID(1) adopt the format we used for CPUID(6): 'No-FEATURE'
means that 'FEATURE' is not present.

Signed-off-by: Len Brown <len.brown@intel.com>
---
 tools/power/x86/turbostat/turbostat.c | 18 +++++++++---------
 1 file changed, 9 insertions(+), 9 deletions(-)

diff --git a/tools/power/x86/turbostat/turbostat.c b/tools/power/x86/turbostat/turbostat.c
index c4c8b6315fd2..a209c5d87ff7 100644
--- a/tools/power/x86/turbostat/turbostat.c
+++ b/tools/power/x86/turbostat/turbostat.c
@@ -8826,15 +8826,15 @@ void process_cpuid()
 		fputc('\n', outf);
 
 		fprintf(outf, "CPUID(0x80000000): max_extended_levels: 0x%x\n", max_extended_level);
-		fprintf(outf, "CPUID(1): %s %s %s %s %s %s %s %s %s %s\n",
-			ecx_flags & (1 << 0) ? "SSE3" : "-",
-			ecx_flags & (1 << 3) ? "MONITOR" : "-",
-			ecx_flags & (1 << 6) ? "SMX" : "-",
-			ecx_flags & (1 << 7) ? "EIST" : "-",
-			ecx_flags & (1 << 8) ? "TM2" : "-",
-			edx_flags & (1 << 4) ? "TSC" : "-",
-			edx_flags & (1 << 5) ? "MSR" : "-",
-			edx_flags & (1 << 22) ? "ACPI-TM" : "-", edx_flags & (1 << 28) ? "HT" : "-", edx_flags & (1 << 29) ? "TM" : "-");
+		fprintf(outf, "CPUID(1): %sSSE3 %sMONITOR %sSMX %sEIST %sTM2 %sTSC %sMSR %sACPI-TM %sHT %sTM\n",
+			ecx_flags & (1 << 0) ? "" : "No-",
+			ecx_flags & (1 << 3) ? "" : "No-",
+			ecx_flags & (1 << 6) ? "" : "No-",
+			ecx_flags & (1 << 7) ? "" : "No-",
+			ecx_flags & (1 << 8) ? "" : "No-",
+			edx_flags & (1 << 4) ? "" : "No-",
+			edx_flags & (1 << 5) ? "" : "No-",
+			edx_flags & (1 << 22) ? "" : "No-", edx_flags & (1 << 28) ? "" : "No-", edx_flags & (1 << 29) ? "" : "No-");
 	}
 
 	probe_platform_features(family, model);
-- 
2.45.2


