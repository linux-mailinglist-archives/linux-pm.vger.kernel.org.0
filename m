Return-Path: <linux-pm+bounces-42769-lists+linux-pm=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-pm@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id CEzvAom8lGm4HQIAu9opvQ
	(envelope-from <linux-pm+bounces-42769-lists+linux-pm=lfdr.de@vger.kernel.org>)
	for <lists+linux-pm@lfdr.de>; Tue, 17 Feb 2026 20:07:53 +0100
X-Original-To: lists+linux-pm@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 8280514F75A
	for <lists+linux-pm@lfdr.de>; Tue, 17 Feb 2026 20:07:52 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 9C048301C885
	for <lists+linux-pm@lfdr.de>; Tue, 17 Feb 2026 19:07:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6A16C372B3C;
	Tue, 17 Feb 2026 19:07:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="E+16496u"
X-Original-To: linux-pm@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 47429285406
	for <linux-pm@vger.kernel.org>; Tue, 17 Feb 2026 19:07:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1771355269; cv=none; b=kcnEXfWrzPlXgUVONVJXTasVrkjlt2iT09ErQV1acd34YGO7bBaQi0wUhE1a+4DZavbOdx25eA03mmAtaztH/JWdFDUjHF/HI/SEOWistRB9S2x/qM39VgZRuWH192fiFEtTQ66m9wWtQm181dMy1O3XVprv66WH048cttNy+jk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1771355269; c=relaxed/simple;
	bh=Q2kSVDLc75PY+pFIwGmy55VPx7Rq1vhGWx+1D0SjkYA=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=cF7COC+IWd5cYKqVvS66J9barupzP6h29x0o/BWvXK7YbVnNxoDr77nmThhxHkEiaX9DojqPFy5ZZhGoPIFpniIVDUWiz8oDIh9L5bqeSa43EN0r4z3/tpBCsSm4gkuGZM5r3JV3CzAbrGxkdEQ3ORZXnwTp+akExH7IKIgAsNY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=E+16496u; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E05CAC19425;
	Tue, 17 Feb 2026 19:07:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1771355268;
	bh=Q2kSVDLc75PY+pFIwGmy55VPx7Rq1vhGWx+1D0SjkYA=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:Reply-To:From;
	b=E+16496uXFjAguD6dfxRjtvn62tByrOirm0PqxTljH2kDbdAhmZhtapkPbLUqPzFE
	 K/+ncFJHYpZ4PXUduAlv5zghDWghIY+zRgf1QjN7YZGsmdQ8S73fvzji1G0qIj/EG2
	 VImsOtK8aU7FYNS0GJiTxTUSyQzlMA4e5q+ve072Xi3vwj16t6KdJWdQ8YnlLRy0Fc
	 /6meUj5L765denqLkNT6bv9Ch+cm7fBgjnfpvF/Bchzd43xnzRadoHcns7yKhhFbgc
	 Gz8eov82VQaNmVv0R5U7yPj3X/bc8qG5jWA+e3VeCqfvEn96Lt925vA4d5crVfGMoK
	 1/cpvcqWZ+5dg==
From: Len Brown <lenb@kernel.org>
To: linux-pm@vger.kernel.org
Cc: Len Brown <len.brown@intel.com>
Subject: [PATCH 01/23] tools/power turbostat: AMD: msr offset 0x611 read failed: Input/output error
Date: Tue, 17 Feb 2026 13:03:52 -0600
Message-ID: <16cc8f249c702b7cbb4c2c2be7cd8f4fdd5d1d0c.1771354332.git.len.brown@intel.com>
X-Mailer: git-send-email 2.45.2
In-Reply-To: <20260217190740.666230-1-lenb@kernel.org>
References: <20260217190740.666230-1-lenb@kernel.org>
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
	TAGGED_FROM(0.00)[bounces-42769-lists,linux-pm=lfdr.de];
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
X-Rspamd-Queue-Id: 8280514F75A
X-Rspamd-Action: no action

From: Len Brown <len.brown@intel.com>

Turbostat exits during RAPL probe with:

turbostat: cpu0: msr offset 0x611 read failed: Input/output error

A binary with this bug can be used successfully with
the option "--no-msr"

Fix this regression by trusting the static AMD RAPL MSR offset.

Fixes: 19476a592bf2 ("tools/power turbostat: Validate RAPL MSRs for AWS Nitro Hypervisor")
Signed-off-by: Len Brown <len.brown@intel.com>
---
 tools/power/x86/turbostat/turbostat.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/tools/power/x86/turbostat/turbostat.c b/tools/power/x86/turbostat/turbostat.c
index 5ad45c2ac5bd..c4c8b6315fd2 100644
--- a/tools/power/x86/turbostat/turbostat.c
+++ b/tools/power/x86/turbostat/turbostat.c
@@ -2135,7 +2135,7 @@ off_t idx_to_offset(int idx)
 
 	switch (idx) {
 	case IDX_PKG_ENERGY:
-		if (valid_rapl_msrs & RAPL_AMD_F17H)
+		if (platform->plat_rapl_msrs & RAPL_AMD_F17H)
 			offset = MSR_PKG_ENERGY_STAT;
 		else
 			offset = MSR_PKG_ENERGY_STATUS;
-- 
2.45.2


