Return-Path: <linux-pm+bounces-21229-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 36473A24F1D
	for <lists+linux-pm@lfdr.de>; Sun,  2 Feb 2025 18:13:11 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 1B9217A22C2
	for <lists+linux-pm@lfdr.de>; Sun,  2 Feb 2025 17:12:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E624E1F8917;
	Sun,  2 Feb 2025 17:13:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="jGPkbdJA"
X-Original-To: linux-pm@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C01211FAC46
	for <linux-pm@vger.kernel.org>; Sun,  2 Feb 2025 17:13:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1738516383; cv=none; b=KunObbqQXwDSp9+1BUDJ0fGrHVnoEzQyQep0KyllMiF8FQbe/eDbgGBCtvSvBOaXqTwhp0f+O4gUknem+TjfiroWEKj/qTz2xAXMSu7C/WVIdUg5x72E/S0v4fQuaRjo3sAVrl5pLwxGAPVAHeqrb8EjU4AbolXHjf+k3LaNEDk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1738516383; c=relaxed/simple;
	bh=OiiRBiUnx8PLjsA1qeRwvDTLGNU0zexbOnwr42Jxu2o=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=kHX4C+vQPYSzfdgLoYesaFAD3N+i0mJAnrVsr8vreRTmuY2LKHBSnHV28kkJE+7pddhthRQQSs2d0aks5EkqDNRRKpL9MH3Jbe2BuPf8P/agw5J+JEKJysdSxVdkgjFpe9EW/bA/e5sssoCweJEyjXqAp/rkYGGvh1uQu3U+QRg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=jGPkbdJA; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8E41EC4CEE0;
	Sun,  2 Feb 2025 17:13:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1738516383;
	bh=OiiRBiUnx8PLjsA1qeRwvDTLGNU0zexbOnwr42Jxu2o=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:Reply-To:From;
	b=jGPkbdJALtpufLT8UZMFTFX5mCyyFo+67n3KjPatQKmJNrnMEgOOSWR3UBB47Re5Y
	 BtZ3KDxcx1XJ9OjEflc3i4lhxs7XoUx/KdY9ZVjCu5kB1sgeUaElEJaYwJncOpgICa
	 wzSLkwaZ4abD2CU0Gb3sakycoDLZ+bLaV+EnjGS7uf+neMNSdXepPkz7a5klidxbWS
	 mYwY8BHYqIi4yxgwZNSI0NShDtcgXFg9ZKZS3tMVUesBBCLUu6nFBYWPe0+rzvfH2h
	 A4Dhs2esgzzViYMVqP4TooQlAhIlVGrSGj5QpcD9mDouWKKRf6jt/8yg8jwGpWw/8v
	 00dtaPM/yEKnA==
From: Len Brown <lenb@kernel.org>
To: linux-pm@vger.kernel.org
Cc: Zhang Rui <rui.zhang@intel.com>,
	Len Brown <len.brown@intel.com>
Subject: [PATCH 06/25] tools/power turbostat: Improve --help output
Date: Sun,  2 Feb 2025 11:09:22 -0600
Message-ID: <cc63f89ef9db70f74c563317d36028bb5e6196a1.1738515889.git.len.brown@intel.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <e8a99af68c068865dbac7f3330e97bf8e96edf33.1738515889.git.len.brown@intel.com>
References: <e8a99af68c068865dbac7f3330e97bf8e96edf33.1738515889.git.len.brown@intel.com>
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Reply-To: Len Brown <lenb@kernel.org>
Organization: Intel Open Source Technology Center
Content-Transfer-Encoding: 8bit

From: Zhang Rui <rui.zhang@intel.com>

Improve the `--help` output of turbostat by standardizing the format
and enhancing readability. The following changes are made to ensure
consistency and clarity in the help message:
1. Use a consistent pattern for each parameter's help message:
   - Display the parameter and its input (if any) on the same line,
     separated by a space.
   - Provide the detailed description on a separate line.
2. Ensure that the first character of each description is in lower-case.

These changes make the help output more uniform and easier to read,
helping users quickly understand the available options and their usage.

No functional change.

Signed-off-by: Zhang Rui <rui.zhang@intel.com>
Signed-off-by: Len Brown <len.brown@intel.com>
---
 tools/power/x86/turbostat/turbostat.c | 41 +++++++++++++++++----------
 1 file changed, 26 insertions(+), 15 deletions(-)

diff --git a/tools/power/x86/turbostat/turbostat.c b/tools/power/x86/turbostat/turbostat.c
index cb659b274554..5165450a8187 100644
--- a/tools/power/x86/turbostat/turbostat.c
+++ b/tools/power/x86/turbostat/turbostat.c
@@ -2145,41 +2145,52 @@ void help(void)
 		"when COMMAND completes.\n"
 		"If no COMMAND is specified, turbostat wakes every 5-seconds\n"
 		"to print statistics, until interrupted.\n"
-		"  -a, --add	add a counter\n"
+		"  -a, --add counter\n"
+		"		add a counter\n"
 		"		  eg. --add msr0x10,u64,cpu,delta,MY_TSC\n"
 		"		  eg. --add perf/cstate_pkg/c2-residency,package,delta,percent,perfPC2\n"
 		"		  eg. --add pmt,name=XTAL,type=raw,domain=package0,offset=0,lsb=0,msb=63,guid=0x1a067102\n"
-		"  -c, --cpu	cpu-set	limit output to summary plus cpu-set:\n"
+		"  -c, --cpu cpu-set\n"
+		"		limit output to summary plus cpu-set:\n"
 		"		  {core | package | j,k,l..m,n-p }\n"
-		"  -d, --debug	displays usec, Time_Of_Day_Seconds and more debugging\n"
+		"  -d, --debug\n"
+		"		displays usec, Time_Of_Day_Seconds and more debugging\n"
 		"		debug messages are printed to stderr\n"
-		"  -D, --Dump	displays the raw counter values\n"
-		"  -e, --enable	[all | column]\n"
+		"  -D, --Dump\n"
+		"		displays the raw counter values\n"
+		"  -e, --enable [all | column]\n"
 		"		shows all or the specified disabled column\n"
-		"  -H, --hide [column|column,column,...]\n"
+		"  -H, --hide [column | column,column,...]\n"
 		"		hide the specified column(s)\n"
 		"  -i, --interval sec.subsec\n"
-		"		Override default 5-second measurement interval\n"
-		"  -J, --Joules	displays energy in Joules instead of Watts\n"
-		"  -l, --list	list column headers only\n"
-		"  -M, --no-msr Disable all uses of the MSR driver\n"
-		"  -P, --no-perf Disable all uses of the perf API\n"
+		"		override default 5-second measurement interval\n"
+		"  -J, --Joules\n"
+		"		displays energy in Joules instead of Watts\n"
+		"  -l, --list\n"
+		"		list column headers only\n"
+		"  -M, --no-msr\n"
+		"		disable all uses of the MSR driver\n"
+		"  -P, --no-perf\n"
+		"		disable all uses of the perf API\n"
 		"  -n, --num_iterations num\n"
 		"		number of the measurement iterations\n"
 		"  -N, --header_iterations num\n"
 		"		print header every num iterations\n"
 		"  -o, --out file\n"
 		"		create or truncate \"file\" for all output\n"
-		"  -q, --quiet	skip decoding system configuration header\n"
-		"  -s, --show [column|column,column,...]\n"
+		"  -q, --quiet\n"
+		"		skip decoding system configuration header\n"
+		"  -s, --show [column | column,column,...]\n"
 		"		show only the specified column(s)\n"
 		"  -S, --Summary\n"
 		"		limits output to 1-line system summary per interval\n"
 		"  -T, --TCC temperature\n"
 		"		sets the Thermal Control Circuit temperature in\n"
 		"		  degrees Celsius\n"
-		"  -h, --help	print this help message\n"
-		"  -v, --version	print version information\n" "\n" "For more help, run \"man turbostat\"\n");
+		"  -h, --help\n"
+		"		print this help message\n"
+		"  -v, --version\n"
+		"		print version information\n" "\n" "For more help, run \"man turbostat\"\n");
 }
 
 /*
-- 
2.43.0


