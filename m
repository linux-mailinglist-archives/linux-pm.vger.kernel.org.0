Return-Path: <linux-pm+bounces-42161-lists+linux-pm=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-pm@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id uHEvH3fAhGnG4wMAu9opvQ
	(envelope-from <linux-pm+bounces-42161-lists+linux-pm=lfdr.de@vger.kernel.org>)
	for <lists+linux-pm@lfdr.de>; Thu, 05 Feb 2026 17:08:23 +0100
X-Original-To: lists+linux-pm@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id DF740F4FA0
	for <lists+linux-pm@lfdr.de>; Thu, 05 Feb 2026 17:08:22 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 0596E308AD41
	for <lists+linux-pm@lfdr.de>; Thu,  5 Feb 2026 16:01:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6BBAB42EED9;
	Thu,  5 Feb 2026 16:01:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=yandex-team.ru header.i=@yandex-team.ru header.b="GLbTAMDr"
X-Original-To: linux-pm@vger.kernel.org
Received: from forwardcorp1a.mail.yandex.net (forwardcorp1a.mail.yandex.net [178.154.239.72])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A7A5442EED3;
	Thu,  5 Feb 2026 16:01:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=178.154.239.72
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770307279; cv=none; b=D3/t7iPTxQr72HWDd3mUjwbRB5HSJ4Rt/BjwCJt+pBa/gikluPF6krx3K7TmABMmtFPKRraiZ5gprgWl309S3ZrPNeAvBq2Llf1iJbj6fAo4i8xlrf+j1/esYYyUzGOi+f/tMHSYMsK6H9JXq10PNFXAr2rQH0uff0j4IgN2T6s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770307279; c=relaxed/simple;
	bh=1aExNJ4dg3bFCao+qWzBlH0ctl1Qbnoom4aGVW8TiUQ=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=IrpxGq8jGGpEZwyOssYr6cBBC80j7nrbtK9UHyxAB8GwIVwEL1/sjrUkBZU0h1s9/taNoBJt1x5ubG21E3kwDZlJ1c+SVTikPGdr1olKlc9n4fJrotPIDoiGl6IhEBd0Kqz7IzmX9YjO7k+8yZXCwwD8Zzp78lF57cNA5a5dqOo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=yandex-team.ru; spf=pass smtp.mailfrom=yandex-team.ru; dkim=pass (1024-bit key) header.d=yandex-team.ru header.i=@yandex-team.ru header.b=GLbTAMDr; arc=none smtp.client-ip=178.154.239.72
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=yandex-team.ru
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=yandex-team.ru
Received: from mail-nwsmtp-smtp-corp-main-83.vla.yp-c.yandex.net (mail-nwsmtp-smtp-corp-main-83.vla.yp-c.yandex.net [IPv6:2a02:6b8:c2d:3530:0:640:eca4:0])
	by forwardcorp1a.mail.yandex.net (Yandex) with ESMTPS id 3A5E9C0158;
	Thu, 05 Feb 2026 18:59:49 +0300 (MSK)
Received: from kniv-nix.yandex-team.ru (unknown [2a02:6bf:8080:520::1:23])
	by mail-nwsmtp-smtp-corp-main-83.vla.yp-c.yandex.net (smtpcorp/Yandex) with ESMTPSA id Vxsat90A1iE0-IoQhRHPR;
	Thu, 05 Feb 2026 18:59:48 +0300
X-Yandex-Fwd: 1
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yandex-team.ru;
	s=default; t=1770307188;
	bh=jlNYN1+0n1QnHoL24dFOgHU9nQnN7JrjdVpiB/9jeB4=;
	h=Message-Id:Date:Cc:Subject:To:From;
	b=GLbTAMDrH/pmwX5erJhvd/VKUF7N9rUOibnb7apcqIsH9hhMiKiodn0Qvn9EXb/Z5
	 MJz/LGPg8PCUZYWwNFd5xsf963NWdSo6I3IzyAtIJbYMcAO7JPdYPRg0N+QvtWG221
	 ig/8s3TaxGVynYxOFSN8BmS5WNXxEhcCKuPKjFZ8=
Authentication-Results: mail-nwsmtp-smtp-corp-main-83.vla.yp-c.yandex.net; dkim=pass header.i=@yandex-team.ru
From: Nikolay Kuratov <kniv@yandex-team.ru>
To: stable@vger.kernel.org
Cc: linux-kernel@vger.kernel.org,
	linux-pm@vger.kernel.org,
	Patryk Wlazlyn <patryk.wlazlyn@linux.intel.com>,
	Len Brown <lenb@kernel.org>,
	Nikolay Kuratov <kniv@yandex-team.ru>
Subject: [PATCH 6.12] tools/power turbostat: Fix compilation on older compilers
Date: Thu,  5 Feb 2026 18:59:07 +0300
Message-Id: <20260205155907.1361830-1-kniv@yandex-team.ru>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-7.66 / 15.00];
	WHITELIST_DMARC(-7.00)[yandex-team.ru:D:+];
	MID_CONTAINS_FROM(1.00)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[yandex-team.ru,none];
	R_MISSING_CHARSET(0.50)[];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	R_DKIM_ALLOW(-0.20)[yandex-team.ru:s=default];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-42161-lists,linux-pm=lfdr.de];
	FORGED_SENDER_MAILLIST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FROM_HAS_DN(0.00)[];
	TO_DN_SOME(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[kniv@yandex-team.ru,linux-pm@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	TAGGED_RCPT(0.00)[linux-pm];
	NEURAL_HAM(-0.00)[-1.000];
	DKIM_TRACE(0.00)[yandex-team.ru:+];
	PRECEDENCE_BULK(0.00)[];
	RCPT_COUNT_FIVE(0.00)[6];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,yandex-team.ru:email,yandex-team.ru:dkim,yandex-team.ru:mid]
X-Rspamd-Queue-Id: DF740F4FA0
X-Rspamd-Action: no action

Currently turbostat.c can't be built on pre-gcc-11 compilers
due to error: a label can only be part of a statement and a declaration
is not a statement.

Fix this by adding braces around case labels.

Fixes: 640540beb883 ("tools/power turbostat: Add MTL's PMT DC6 builtin counter")
Signed-off-by: Nikolay Kuratov <kniv@yandex-team.ru>
---
 tools/power/x86/turbostat/turbostat.c | 24 ++++++++++++------------
 1 file changed, 12 insertions(+), 12 deletions(-)

diff --git a/tools/power/x86/turbostat/turbostat.c b/tools/power/x86/turbostat/turbostat.c
index b663a76d31f1..85d40d3c6384 100644
--- a/tools/power/x86/turbostat/turbostat.c
+++ b/tools/power/x86/turbostat/turbostat.c
@@ -2799,7 +2799,7 @@ int format_counters(struct thread_data *t, struct core_data *c, struct pkg_data
 
 	for (i = 0, ppmt = sys.pmt_tp; ppmt; i++, ppmt = ppmt->next) {
 		switch (ppmt->type) {
-		case PMT_TYPE_RAW:
+		case PMT_TYPE_RAW: {
 			if (pmt_counter_get_width(ppmt) <= 32)
 				outp += sprintf(outp, "%s0x%08x", (printed++ ? delim : ""),
 						(unsigned int)t->pmt_counter[i]);
@@ -2807,14 +2807,14 @@ int format_counters(struct thread_data *t, struct core_data *c, struct pkg_data
 				outp += sprintf(outp, "%s0x%016llx", (printed++ ? delim : ""), t->pmt_counter[i]);
 
 			break;
-
-		case PMT_TYPE_XTAL_TIME:
+		}
+		case PMT_TYPE_XTAL_TIME: {
 			const unsigned long value_raw = t->pmt_counter[i];
 			const double value_converted = 100.0 * value_raw / crystal_hz / interval_float;
 
 			outp += sprintf(outp, "%s%.2f", (printed++ ? delim : ""), value_converted);
 			break;
-		}
+		}}
 	}
 
 	/* C1 */
@@ -2880,7 +2880,7 @@ int format_counters(struct thread_data *t, struct core_data *c, struct pkg_data
 
 	for (i = 0, ppmt = sys.pmt_cp; ppmt; i++, ppmt = ppmt->next) {
 		switch (ppmt->type) {
-		case PMT_TYPE_RAW:
+		case PMT_TYPE_RAW: {
 			if (pmt_counter_get_width(ppmt) <= 32)
 				outp += sprintf(outp, "%s0x%08x", (printed++ ? delim : ""),
 						(unsigned int)c->pmt_counter[i]);
@@ -2888,14 +2888,14 @@ int format_counters(struct thread_data *t, struct core_data *c, struct pkg_data
 				outp += sprintf(outp, "%s0x%016llx", (printed++ ? delim : ""), c->pmt_counter[i]);
 
 			break;
-
-		case PMT_TYPE_XTAL_TIME:
+		}
+		case PMT_TYPE_XTAL_TIME: {
 			const unsigned long value_raw = c->pmt_counter[i];
 			const double value_converted = 100.0 * value_raw / crystal_hz / interval_float;
 
 			outp += sprintf(outp, "%s%.2f", (printed++ ? delim : ""), value_converted);
 			break;
-		}
+		}}
 	}
 
 	fmt8 = "%s%.2f";
@@ -3079,7 +3079,7 @@ int format_counters(struct thread_data *t, struct core_data *c, struct pkg_data
 
 	for (i = 0, ppmt = sys.pmt_pp; ppmt; i++, ppmt = ppmt->next) {
 		switch (ppmt->type) {
-		case PMT_TYPE_RAW:
+		case PMT_TYPE_RAW: {
 			if (pmt_counter_get_width(ppmt) <= 32)
 				outp += sprintf(outp, "%s0x%08x", (printed++ ? delim : ""),
 						(unsigned int)p->pmt_counter[i]);
@@ -3087,14 +3087,14 @@ int format_counters(struct thread_data *t, struct core_data *c, struct pkg_data
 				outp += sprintf(outp, "%s0x%016llx", (printed++ ? delim : ""), p->pmt_counter[i]);
 
 			break;
-
-		case PMT_TYPE_XTAL_TIME:
+		}
+		case PMT_TYPE_XTAL_TIME: {
 			const unsigned long value_raw = p->pmt_counter[i];
 			const double value_converted = 100.0 * value_raw / crystal_hz / interval_float;
 
 			outp += sprintf(outp, "%s%.2f", (printed++ ? delim : ""), value_converted);
 			break;
-		}
+		}}
 	}
 
 done:
-- 
2.34.1


