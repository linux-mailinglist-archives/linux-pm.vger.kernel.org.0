Return-Path: <linux-pm+bounces-42772-lists+linux-pm=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-pm@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id OGeNAJC8lGm4HQIAu9opvQ
	(envelope-from <linux-pm+bounces-42772-lists+linux-pm=lfdr.de@vger.kernel.org>)
	for <lists+linux-pm@lfdr.de>; Tue, 17 Feb 2026 20:08:00 +0100
X-Original-To: lists+linux-pm@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 9427C14F777
	for <lists+linux-pm@lfdr.de>; Tue, 17 Feb 2026 20:07:59 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 617B7300F52D
	for <lists+linux-pm@lfdr.de>; Tue, 17 Feb 2026 19:07:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 66B8036EABF;
	Tue, 17 Feb 2026 19:07:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="f1zDOJH7"
X-Original-To: linux-pm@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 43E95285406
	for <linux-pm@vger.kernel.org>; Tue, 17 Feb 2026 19:07:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1771355274; cv=none; b=OYIUJUzOR2zEnk5o3XVoWjKV5rUNRlTwOSqGrrl0ZRIG4KwNNo3wsUxpRFK0VMVNJ6RsNxcwyw5dxCEXdLdVfY04juBBQAf/WrDka8LUi8Y0jVuY+tShroKOdgb2JPvNw6dnUDxvdCJFa0QYGtoDhjx+ZGemVIQbfm1jA3kSipc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1771355274; c=relaxed/simple;
	bh=3XfOpQyeGRCtaBrG0FJ7EoDzLsJY9yQBSAqeFaJmWkY=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=JS3rJYbFbfgvJcwieRXB4Bo9H1z0htsuvYaCEa6kebDc5UzcEKWfLGE0SGmU+gDElLjn652P9qL3BMcPY4etA+uLsf0HyzzSys86TnM2Etwz34Vl5EG1oRVoU4ElVxvxOQqYOX0qfv9cP6Gzta1iroNbDNOrZMjb4l4EFYBkkas=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=f1zDOJH7; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id DABACC4CEF7;
	Tue, 17 Feb 2026 19:07:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1771355273;
	bh=3XfOpQyeGRCtaBrG0FJ7EoDzLsJY9yQBSAqeFaJmWkY=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:Reply-To:From;
	b=f1zDOJH7Y2ePISTlwdT0xXj28AO+Dw+UugFOd/pmXQDNr5US9wJwuBgVMpnozVIkE
	 HFSxMPWM2UCVgEeUiwDlsQjVA93y0OcZaMaUMTyIi2HKcC9K2+lYvWGiutRnNRmH3P
	 WyOehYOY+t8kY4kekOfGpcHX6C4Yg6eC2FNgm52TVdYP3HNjr9UKZDvTc0PlsBOYsW
	 U5wWJdzBkKhxmHjDoZF6kyf1P8aG6Fgh4qufCDce+ouI+mf8aOD6G9c2ysEEPalQcA
	 +DytoQDsuLXOzmtCfVDDOsWPx2drKbb1IbIwFGF+hjsDZgF2x+YQZ2UZ5V2/1rMN1h
	 KmwudG/9KoMfA==
From: Len Brown <lenb@kernel.org>
To: linux-pm@vger.kernel.org
Cc: Len Brown <len.brown@intel.com>
Subject: [PATCH 04/23] tools/power turbostat: Dump hypervisor name
Date: Tue, 17 Feb 2026 13:03:55 -0600
Message-ID: <61764831d5b148a9f3afe7ac35089e5908c92a81.1771354332.git.len.brown@intel.com>
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
	TAGGED_FROM(0.00)[bounces-42772-lists,linux-pm=lfdr.de];
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
X-Rspamd-Queue-Id: 9427C14F777
X-Rspamd-Action: no action

From: Len Brown <len.brown@intel.com>

Sometimes useful to know which hypervisor is running beneath us...

Signed-off-by: Len Brown <len.brown@intel.com>
---
 tools/power/x86/turbostat/turbostat.c | 23 +++++++++++++++++++++++
 1 file changed, 23 insertions(+)

diff --git a/tools/power/x86/turbostat/turbostat.c b/tools/power/x86/turbostat/turbostat.c
index 0ef36f0330a9..97cd9c5a0092 100644
--- a/tools/power/x86/turbostat/turbostat.c
+++ b/tools/power/x86/turbostat/turbostat.c
@@ -8772,6 +8772,27 @@ void probe_pstates(void)
 	for_all_cpus(print_epb, ODD_COUNTERS);
 	for_all_cpus(print_perf_limit, ODD_COUNTERS);
 }
+void dump_word_chars(unsigned int word)
+{
+	int i;
+
+	for (i = 0; i < 4; ++i)
+		fprintf(outf, "%c", (word >> (i * 8)) & 0xFF);
+}
+void dump_cpuid_hypervisor(void)
+{
+	unsigned int ebx = 0;
+	unsigned int ecx = 0;
+	unsigned int edx = 0;
+
+	__cpuid(0x40000000, max_extended_level, ebx, ecx, edx);
+
+	fprintf(outf, "Hypervisor: ");
+	dump_word_chars(ebx);
+	dump_word_chars(ecx);
+	dump_word_chars(edx);
+	fprintf(outf, "\n");
+}
 
 void process_cpuid()
 {
@@ -8839,6 +8860,8 @@ void process_cpuid()
 			edx_flags & (1 << 5) ? "" : "No-",
 			edx_flags & (1 << 22) ? "" : "No-", edx_flags & (1 << 28) ? "" : "No-", edx_flags & (1 << 29) ? "" : "No-");
 	}
+	if (!quiet && cpuid_has_hv)
+		dump_cpuid_hypervisor();
 
 	probe_platform_features(family, model);
 
-- 
2.45.2


