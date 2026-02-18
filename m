Return-Path: <linux-pm+bounces-42797-lists+linux-pm=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-pm@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id KGGiBkMslWlkMgIAu9opvQ
	(envelope-from <linux-pm+bounces-42797-lists+linux-pm=lfdr.de@vger.kernel.org>)
	for <lists+linux-pm@lfdr.de>; Wed, 18 Feb 2026 04:04:35 +0100
X-Original-To: lists+linux-pm@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 74799152C86
	for <lists+linux-pm@lfdr.de>; Wed, 18 Feb 2026 04:04:34 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 08E2A30500FD
	for <lists+linux-pm@lfdr.de>; Wed, 18 Feb 2026 03:04:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 33ADE2EACF9;
	Wed, 18 Feb 2026 03:04:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="KfOl0tjt"
X-Original-To: linux-pm@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0F1A12EAB71;
	Wed, 18 Feb 2026 03:04:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1771383850; cv=none; b=EF+8krHxlOwCbjI2p/epCrQJcQ8qa/U+jEfyh32WES4RS2TW/+sA6zBC6XSleGHdy1lHKjUMOV7vSUNrA51tpiUjk33R3LdIpuu86Yyep80/8Z5BbKWrdgBd4Y6I1whWeNCGoTNWg8MkZGfTKbIA4gfXkzJJCJSBKFvsOwHwQeE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1771383850; c=relaxed/simple;
	bh=o0+QiTejn6k3fu90Xt8/p7feziwL1cwx8n3N62q/etc=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=qS+DxuPnOzbbs33m8BhUVYwbw6yXPhLJI+j/qyHQClAe4MD/WbDBl//lQZz5JEgUI1N1BsZdxjTEOIlsToewsDjeyv5kT8OxqgOAwcNxLWzMCD1p+O6yxSRKKsACnotHj6ZApk+mfgrOAXnrDpoThN/EPFxOmKrPL2dEvICwEmM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=KfOl0tjt; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1E77FC4CEF7;
	Wed, 18 Feb 2026 03:04:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1771383849;
	bh=o0+QiTejn6k3fu90Xt8/p7feziwL1cwx8n3N62q/etc=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:Reply-To:From;
	b=KfOl0tjtoJ564TahKnkK+V43Mc35Flo0CsZuH1pr7MdkfaRiNUnzcQMLOPw0sh4K5
	 Uh25ShR+W1l0z8vCfv+wX7w+Hr0jgnuZFBJ/NS0kLPxpfqh2sWBB43kLVLEIx3wv4Y
	 GHg6zVMqbfYqcEfrgU7FLarR4QW+Cze0nqdC2MfrouyShtDdPNPaMEcu0qYZfkEdds
	 woO0dQPkm/1kYWKMP4t5hK/E0qElrqR0eUzlGZzgvbbvUCnJppT68eYEXNm/A94Oyj
	 S96cHXF4mJ91UBwX+QGKfO7cRkr7nqDH+a2YjoKS0U2HH737cbYdm3MiRiQuvdeRaf
	 dU6OkN3br0CPQ==
From: Len Brown <lenb@kernel.org>
To: torvalds@linux-foundation.org
Cc: linux-pm@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Len Brown <len.brown@intel.com>
Subject: [PATCH 1/1] tools/power turbostat: Fix AMD RAPL regression
Date: Tue, 17 Feb 2026 21:02:04 -0600
Message-ID: <cfd5ff044914fd5f7fae2403675b68593f986055.1771383514.git.len.brown@intel.com>
X-Mailer: git-send-email 2.45.2
In-Reply-To: <20260218030402.694540-1-lenb@kernel.org>
References: <20260218030402.694540-1-lenb@kernel.org>
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
	TAGGED_FROM(0.00)[bounces-42797-lists,linux-pm=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	HAS_ORG_HEADER(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	TO_DN_SOME(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	RCPT_COUNT_THREE(0.00)[4];
	HAS_REPLYTO(0.00)[lenb@kernel.org];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[lenb@kernel.org,linux-pm@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[kernel.org:+];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,intel.com:mid,intel.com:email,linux-foundation.org:email];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[linux-pm];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	REPLYTO_EQ_FROM(0.00)[]
X-Rspamd-Queue-Id: 74799152C86
X-Rspamd-Action: no action

From: Len Brown <len.brown@intel.com>

turbostat.c:8688: rapl_perf_init: Assertion `next_domain < num_domains' failed.

Revert a hunk from a cleanup patch that was not supposed to change anything...
And once again, AMD RAPL is "special".

Fixes: ddf60e38ca04 ("tools/power turbostat: Simplify global core_id calculation")
Reported-by: Linus Torvalds <torvalds@linux-foundation.org>
Signed-off-by: Len Brown <len.brown@intel.com>
---
 tools/power/x86/turbostat/turbostat.c | 9 ++++++++-
 1 file changed, 8 insertions(+), 1 deletion(-)

diff --git a/tools/power/x86/turbostat/turbostat.c b/tools/power/x86/turbostat/turbostat.c
index 1aace9b3269e..606f3dead084 100644
--- a/tools/power/x86/turbostat/turbostat.c
+++ b/tools/power/x86/turbostat/turbostat.c
@@ -5161,10 +5161,17 @@ static inline int get_rapl_num_domains(void)
 
 static inline int get_rapl_domain_id(int cpu)
 {
+	int nr_cores_per_package = topo.max_core_id + 1;
+	int rapl_core_id;
+
 	if (!platform->has_per_core_rapl)
 		return cpus[cpu].package_id;
 
-	return GLOBAL_CORE_ID(cpu, cpus[cpu].package_id);
+	/* Compute the system-wide unique core-id for @cpu */
+	rapl_core_id = cpus[cpu].core_id;
+	rapl_core_id += cpus[cpu].package_id * nr_cores_per_package;
+
+	return rapl_core_id;
 }
 
 /*
-- 
2.45.2


