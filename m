Return-Path: <linux-pm+bounces-42789-lists+linux-pm=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-pm@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id mITOKKa8lGm4HQIAu9opvQ
	(envelope-from <linux-pm+bounces-42789-lists+linux-pm=lfdr.de@vger.kernel.org>)
	for <lists+linux-pm@lfdr.de>; Tue, 17 Feb 2026 20:08:22 +0100
X-Original-To: lists+linux-pm@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [IPv6:2600:3c09:e001:a7::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 63E4914F7D1
	for <lists+linux-pm@lfdr.de>; Tue, 17 Feb 2026 20:08:22 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id C58AF3013261
	for <lists+linux-pm@lfdr.de>; Tue, 17 Feb 2026 19:08:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 69F6737473B;
	Tue, 17 Feb 2026 19:08:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="R+cVx3vs"
X-Original-To: linux-pm@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 474F6285406
	for <linux-pm@vger.kernel.org>; Tue, 17 Feb 2026 19:08:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1771355301; cv=none; b=dRoWrV9y10HTOlXAX1+Ero/VCnfx52ZeM3TXiLkyTWFVLR/HMLY+gAygWGTTny9RZr2/GjiwXH9fsbToMLpdu180L+41zCo86p/hANIOrrszUplt7D1M65vzNGoJYBe0sc9SuSJd4J6gG6v4cyaVVkkqlDfLZHKsIJbM5t+DjOc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1771355301; c=relaxed/simple;
	bh=iGsc5AKk3wzHDbMRhdhJlgOytSsh4BVOhNFnB0TEz5o=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=LDImL3TjbOMupUV7k6TXn7bGMoAa4Q9jWeA3NyCmINE8Ko1Mjx3kCPKDXuLlbz5xRVFmJeiyh4IsxLrrMVUsgNJSBU7h51alJYX/OT99cs2lqeRZU9nG1fhsLSYBw9XQsqPnzI7HlaA1LSFZZl6nrzkjTV+J0ZeDSIHWJFSs2UI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=R+cVx3vs; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id AEC1DC19421;
	Tue, 17 Feb 2026 19:08:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1771355300;
	bh=iGsc5AKk3wzHDbMRhdhJlgOytSsh4BVOhNFnB0TEz5o=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:Reply-To:From;
	b=R+cVx3vsZAyzweqt0F4O/uTFH5AhJBGuSlI0haXPuPTzI8Gkj05mOyUP+BoJSA8Vm
	 Wz/LnFLd62ACrLc9EW5iiedejGxwC/LJXap3NW1/x694+uISszs8I/tKp0U32mA/s8
	 qO2YrNCB9qnXNroyPOIC+4R8CGRW0gTv6Q4XsDd/hEthAaygofqBnUrnNdffW9rCgO
	 k5EUcsUwc3q8gyPgYJILcpLEQt1YBzD5dwMQJEGYnVzJ1BItyZG1zJyQKDxcgFdqTG
	 a9BLg+uXcQ9DaUEmTLz+HpAnW2fdyQLHrrag8qVRCUXl17BUBQF8MgS2EVupqAGRoY
	 FEKNQQBD9ZPWw==
From: Len Brown <lenb@kernel.org>
To: linux-pm@vger.kernel.org
Cc: Kaushlendra Kumar <kaushlendra.kumar@intel.com>,
	Len Brown <len.brown@intel.com>
Subject: [PATCH 21/23] tools/power turbostat: Use strtoul() for iteration parsing
Date: Tue, 17 Feb 2026 13:04:12 -0600
Message-ID: <8e5c0cc326f2e95a71bb6e6063e65caa60c8f951.1771354333.git.len.brown@intel.com>
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
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c09:e001:a7::/64:c];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	TAGGED_FROM(0.00)[bounces-42789-lists,linux-pm=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	HAS_ORG_HEADER(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	TO_DN_SOME(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	RCPT_COUNT_THREE(0.00)[3];
	HAS_REPLYTO(0.00)[lenb@kernel.org];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[lenb@kernel.org,linux-pm@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[kernel.org:+];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sto.lore.kernel.org:helo,sto.lore.kernel.org:rdns,intel.com:mid,intel.com:email];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[linux-pm];
	ASN(0.00)[asn:63949, ipnet:2600:3c09::/32, country:SG];
	REPLYTO_EQ_FROM(0.00)[]
X-Rspamd-Queue-Id: 63E4914F7D1
X-Rspamd-Action: no action

From: Kaushlendra Kumar <kaushlendra.kumar@intel.com>

Replace strtod() with strtoul() and check errno for -n/-N options, since
num_iterations and header_iterations are unsigned long counters. Reject
zero and conversion errors; negative inputs wrap to large positive values
per standard unsigned semantics.

Signed-off-by: Kaushlendra Kumar <kaushlendra.kumar@intel.com>
Signed-off-by: Len Brown <len.brown@intel.com>
---
 tools/power/x86/turbostat/turbostat.c | 14 ++++++++------
 1 file changed, 8 insertions(+), 6 deletions(-)

diff --git a/tools/power/x86/turbostat/turbostat.c b/tools/power/x86/turbostat/turbostat.c
index 5239fd971b66..b8cbbff95e84 100644
--- a/tools/power/x86/turbostat/turbostat.c
+++ b/tools/power/x86/turbostat/turbostat.c
@@ -11536,18 +11536,20 @@ void cmdline(int argc, char **argv)
 			/* Parsed earlier */
 			break;
 		case 'n':
-			num_iterations = strtod(optarg, NULL);
+			num_iterations = strtoul(optarg, NULL, 0);
+			errno = 0;
 
-			if (num_iterations <= 0) {
-				fprintf(outf, "iterations %d should be positive number\n", num_iterations);
+			if (errno || num_iterations == 0) {
+				fprintf(outf, "invalid iteration count: %s\n", optarg);
 				exit(2);
 			}
 			break;
 		case 'N':
-			header_iterations = strtod(optarg, NULL);
+			header_iterations = strtoul(optarg, NULL, 0);
+			errno = 0;
 
-			if (header_iterations <= 0) {
-				fprintf(outf, "iterations %d should be positive number\n", header_iterations);
+			if (errno || header_iterations == 0) {
+				fprintf(outf, "invalid header iteration count: %s\n", optarg);
 				exit(2);
 			}
 			break;
-- 
2.45.2


