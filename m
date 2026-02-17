Return-Path: <linux-pm+bounces-42790-lists+linux-pm=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-pm@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id kAnqIae8lGm4HQIAu9opvQ
	(envelope-from <linux-pm+bounces-42790-lists+linux-pm=lfdr.de@vger.kernel.org>)
	for <lists+linux-pm@lfdr.de>; Tue, 17 Feb 2026 20:08:23 +0100
X-Original-To: lists+linux-pm@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [172.232.135.74])
	by mail.lfdr.de (Postfix) with ESMTPS id 736AE14F7D8
	for <lists+linux-pm@lfdr.de>; Tue, 17 Feb 2026 20:08:23 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id D1AB13015136
	for <lists+linux-pm@lfdr.de>; Tue, 17 Feb 2026 19:08:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 79AA437473C;
	Tue, 17 Feb 2026 19:08:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="BgS0DyYI"
X-Original-To: linux-pm@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5663B285406
	for <linux-pm@vger.kernel.org>; Tue, 17 Feb 2026 19:08:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1771355302; cv=none; b=lQ2v7x14RMX1EWxDIYx+duVfPsSfqveIV5oL9Rsa/9e+jC2sEKs4E2WlMXW+zPAPR+lHgxfN3uQcwh15XovwuKpgTOtsBwM8roJB9c88VElIi5SL12Tpvra3/zxN2Oui7woYqbqO9fT+EoXh9hqZ8+eU8lF9DeFTsAc68ALJCxM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1771355302; c=relaxed/simple;
	bh=7kic+2xnC3iWErN8khR0DWXNvbw3phg1IvjcM2zqRok=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=tHNlB++thdKGqcjEh5joF+SpwdND3uwm784Hd/PmQO0n4YHOQfPLtycUEEf4CG8rMq1/+L0A61k9ZJ3SLrCXtOo/EKXLz7bZkxQ/6qUXcf8ll//29QO0hEn+zc48mzSJH5vgJnlA/tPc9AG+V6qudF98pH089YY3Zja6R1jokew=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=BgS0DyYI; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 78D0FC4CEF7;
	Tue, 17 Feb 2026 19:08:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1771355302;
	bh=7kic+2xnC3iWErN8khR0DWXNvbw3phg1IvjcM2zqRok=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:Reply-To:From;
	b=BgS0DyYIfeS4ZA0hAOKQpFAIrQ9o5wT0ohNzbueNxbx/AVB5cWzgUHCuMQi3TzR+p
	 OStUd4lXry6pQEB+jRUx0ZYmbFtnsZts/CftB6rsUC2jqSIFhCnxgW3v3NeCGEkgk5
	 i3c/QVLTov6eDVPTylO9I7lc60s98uZRjVBeF+NOMHAdX8a1hJujaxNvyz/S2WrY59
	 J/ZMbJ8YpY+M0xaPbWYYi+qNttf8Y06oPN+hzuRCT6edUHMjnkepnSZ7D1kqf+WRP/
	 kbZ4S4J+syiL89rHEBoY2Beum8TkMyGuHiJjyDn03j6lvOFNNQY0Zmj9EKcvHJOFiK
	 gej87v6mA8Efw==
From: Len Brown <lenb@kernel.org>
To: linux-pm@vger.kernel.org
Cc: Len Brown <len.brown@intel.com>
Subject: [PATCH 22/23] tools/power turbostat: Fix and document --header_iterations
Date: Tue, 17 Feb 2026 13:04:13 -0600
Message-ID: <96718ad296af4a6d984b3a09276b165ab6a3b0c8.1771354333.git.len.brown@intel.com>
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
	TAGGED_FROM(0.00)[bounces-42790-lists,linux-pm=lfdr.de];
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
X-Rspamd-Queue-Id: 736AE14F7D8
X-Rspamd-Action: no action

From: Len Brown <len.brown@intel.com>

The "header_iterations" option is commonly used to de-clutter
the screen of redundant header label rows in an interactive session:
Eg. every 10 rows:

$ sudo turbostat --header_iterations 10 -S -q -i 1

But --header_iterations was missing from turbostat.8

Also turbostat help advertised the "-N" short option
that did not actually work:

$ turbostat --help
  -N, --header_iterations num
		print header every num iterations

Repair "-N"
Document "--header_iterations" on turbostat.8

Signed-off-by: Len Brown <len.brown@intel.com>
---
 tools/power/x86/turbostat/turbostat.8 |  4 +++-
 tools/power/x86/turbostat/turbostat.c | 20 +++++++++-----------
 2 files changed, 12 insertions(+), 12 deletions(-)

diff --git a/tools/power/x86/turbostat/turbostat.8 b/tools/power/x86/turbostat/turbostat.8
index b4ef04200219..344ede2f8546 100644
--- a/tools/power/x86/turbostat/turbostat.8
+++ b/tools/power/x86/turbostat/turbostat.8
@@ -111,12 +111,14 @@ The column name "all" can be used to enable all disabled-by-default built-in cou
 .PP
 \fB--no-perf\fP Disable all the uses of the perf API.
 .PP
-\fB--force\fPForce turbostat to run on an unsupported platform (minimal defaults).
+\fB--force\fP Force turbostat to run on an unsupported platform (minimal defaults).
 .PP
 \fB--interval seconds\fP overrides the default 5.0 second measurement interval.
 .PP
 \fB--num_iterations num\fP number of the measurement iterations.
 .PP
+\fB--header_iterations num\fP print header every num iterations.
+.PP
 \fB--out output_file\fP turbostat output is written to the specified output_file.
 The file is truncated if it already exists, and it is created if it does not exist.
 .PP
diff --git a/tools/power/x86/turbostat/turbostat.c b/tools/power/x86/turbostat/turbostat.c
index b8cbbff95e84..1ce175841583 100644
--- a/tools/power/x86/turbostat/turbostat.c
+++ b/tools/power/x86/turbostat/turbostat.c
@@ -11443,7 +11443,7 @@ void cmdline(int argc, char **argv)
 	 * Parse some options early, because they may make other options invalid,
 	 * like adding the MSR counter with --add and at the same time using --no-msr.
 	 */
-	while ((opt = getopt_long_only(argc, argv, "+MPn:", long_options, &option_index)) != -1) {
+	while ((opt = getopt_long_only(argc, argv, "+:MP", long_options, &option_index)) != -1) {
 		switch (opt) {
 		case 'M':
 			no_msr = 1;
@@ -11457,7 +11457,7 @@ void cmdline(int argc, char **argv)
 	}
 	optind = 0;
 
-	while ((opt = getopt_long_only(argc, argv, "+C:c:Dde:hi:Jn:o:qMST:v", long_options, &option_index)) != -1) {
+	while ((opt = getopt_long_only(argc, argv, "+C:c:Dde:hi:Jn:N:o:qMST:v", long_options, &option_index)) != -1) {
 		switch (opt) {
 		case 'a':
 			parse_add_command(optarg);
@@ -11500,7 +11500,6 @@ void cmdline(int argc, char **argv)
 			}
 			break;
 		case 'h':
-		default:
 			help();
 			exit(1);
 		case 'i':
@@ -11539,19 +11538,15 @@ void cmdline(int argc, char **argv)
 			num_iterations = strtoul(optarg, NULL, 0);
 			errno = 0;
 
-			if (errno || num_iterations == 0) {
-				fprintf(outf, "invalid iteration count: %s\n", optarg);
-				exit(2);
-			}
+			if (errno || num_iterations == 0)
+				errx(-1, "invalid iteration count: %s", optarg);
 			break;
 		case 'N':
 			header_iterations = strtoul(optarg, NULL, 0);
 			errno = 0;
 
-			if (errno || header_iterations == 0) {
-				fprintf(outf, "invalid header iteration count: %s\n", optarg);
-				exit(2);
-			}
+			if (errno || header_iterations == 0)
+				errx(-1, "invalid header iteration count: %s", optarg);
 			break;
 		case 's':
 			/*
@@ -11574,6 +11569,9 @@ void cmdline(int argc, char **argv)
 			print_version();
 			exit(0);
 			break;
+		default:
+			help();
+			exit(1);
 		}
 	}
 }
-- 
2.45.2


