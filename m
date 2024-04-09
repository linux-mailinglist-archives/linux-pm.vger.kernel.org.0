Return-Path: <linux-pm+bounces-6083-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id C977F89CF66
	for <lists+linux-pm@lfdr.de>; Tue,  9 Apr 2024 02:32:08 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 439261F24906
	for <lists+linux-pm@lfdr.de>; Tue,  9 Apr 2024 00:32:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0FE196AD6;
	Tue,  9 Apr 2024 00:31:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="g8QGYBR8"
X-Original-To: linux-pm@vger.kernel.org
Received: from mail-yb1-f174.google.com (mail-yb1-f174.google.com [209.85.219.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 418DA4A3C
	for <linux-pm@vger.kernel.org>; Tue,  9 Apr 2024 00:31:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712622714; cv=none; b=PSH7CoxdCz6dV6DIpMGYsIFDDSiG+65irxJc/DG6mJCC/wbgYF6aWAuxG8DHUcssqsCg2lk021BDWunFOPLXqE4Q6DCeUzBIkOVZ+jRWpTBQMG6X1Q8Kmmr8L+s4K1ELlkJhHcP0PEwiiFZ2XmqoiQ17Q8/jjUeAgFS5C7fNrSc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712622714; c=relaxed/simple;
	bh=kx+U6LUnlXOaxpol5HvY7DGtD3bkqOPOwsvXuiIccOQ=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=gvnH5x3lwJ1MC9MWqdpmeje13GZEJAY4Q12PDLUFbYavMwK69MoCT07hFlpTLLHmNkAN7xw6SeBGHu+HKIOcbEZkNWzzRAdOUFB4gf6S0z0W8hY2iiFX32sg5sjsvKKDI7it7w0ZXUf4GJzQUjjLuk3B8FpNBieapSuDMgNhCys=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=g8QGYBR8; arc=none smtp.client-ip=209.85.219.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-yb1-f174.google.com with SMTP id 3f1490d57ef6-d9b9adaf291so5134420276.1
        for <linux-pm@vger.kernel.org>; Mon, 08 Apr 2024 17:31:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1712622712; x=1713227512; darn=vger.kernel.org;
        h=content-transfer-encoding:organization:reply-to:mime-version
         :references:in-reply-to:message-id:date:subject:cc:to:from:sender
         :from:to:cc:subject:date:message-id:reply-to;
        bh=M3a0HNHjN8OaoCF5rdT1Wwht3YfhWiR9mlyCcennP5s=;
        b=g8QGYBR8/tE5ZDcwfD8FwaGFG8aRyU6/BIyhsyR+AChAFIxIA7sfd2uB6pTAIjRm0m
         JCM/A+IQGVig2PSLeCFjM3k8tWXvX/l4pvxvEr8xSuhcmWzffHZsxP99MzcON7TmpLL+
         Uus3EXhdzANxJ0zN1atW2/SmWkzvs9/PXyOV/Absa1iuKqgrKTiIYgPVzqDJ28WPi6rE
         mwqX1QwaTbpk3Kw/ObwHIknHrLa8YyqotQlRuMnKWAPiSjRrYXKuub+QNnIZg7TTAgY6
         rx3FOSeG2yDJqcMMdN/MyxD5ThXr0PQGdBnOR+2ThRXXx/7Z/fEu5DaLZlZBw1LdzAuM
         XROQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1712622712; x=1713227512;
        h=content-transfer-encoding:organization:reply-to:mime-version
         :references:in-reply-to:message-id:date:subject:cc:to:from:sender
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=M3a0HNHjN8OaoCF5rdT1Wwht3YfhWiR9mlyCcennP5s=;
        b=nyOwcYmSWRFF7tn7R2gik746NmeJLH6ec2NgOIXKPJwnYgxgyL2+vKkGRuEknZedMW
         4nJLZKli+xK5hYrZVF/MOSNz+rW9tFMGhp0MeEcYVgjcmzWCmDihelYc2bspGyonUV11
         nWRJXYOAbUqcXN+qQXr3f5cLKf4ZLVr8wTMnfzkdbMOSzvbai/yfIa7Jg3uOB96maEx1
         xFcVelz5041EX/AF48qO/Dq+hfHw3Ee3xqvbxAI7tUKE+AL5QK9JOsgkZJg7QiXQRAn5
         ihQka/4wh4+4psXO9ebQnlDuN5A0Bsvi2UohyVUMdj9zykstF0ge+S46q+TpJEmSHthW
         7OPg==
X-Gm-Message-State: AOJu0YxeuH8CKYViQ0k7Thib8K42EeTuOCXHd4SH58AAQ1paR8ISGBLb
	gKXnlSWZTeo1/NoSQN0St7KBhdQPzeO9TnFlqBvl1Ma2xsqbTBlkiGHHSycw
X-Google-Smtp-Source: AGHT+IEOpaUBDZeuKXtQf9YB5hXhmzYYW7h/SOTMB+1gk2bR7dkejhu6LAJwp230ISwHNk9kH1i+RA==
X-Received: by 2002:a25:ef04:0:b0:dd1:48cf:5c8 with SMTP id g4-20020a25ef04000000b00dd148cf05c8mr7409473ybd.2.1712622712070;
        Mon, 08 Apr 2024 17:31:52 -0700 (PDT)
Received: from lenb-Intel-NUC8i7HVKVA.search.charter.net (2603-9000-9f01-67cf-100c-5508-c194-b194.inf6.spectrum.com. [2603:9000:9f01:67cf:100c:5508:c194:b194])
        by smtp.gmail.com with ESMTPSA id h6-20020a25e206000000b00dc74ac54f5fsm1531949ybe.63.2024.04.08.17.31.51
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 08 Apr 2024 17:31:51 -0700 (PDT)
Sender: Len Brown <lenb417@gmail.com>
From: Len Brown <lenb@kernel.org>
To: linux-pm@vger.kernel.org
Cc: Patryk Wlazlyn <patryk.wlazlyn@linux.intel.com>,
	Len Brown <len.brown@intel.com>
Subject: [PATCH 11/26] tools/power turbostat: Add --no-perf option
Date: Mon,  8 Apr 2024 20:31:05 -0400
Message-Id: <a0e86c90b83c118985260e36490583b5a38d4359.1712621427.git.len.brown@intel.com>
X-Mailer: git-send-email 2.40.1
In-Reply-To: <e5f4e68eed85fa8495d78cd966eecc2b27bb9e53.1712621427.git.len.brown@intel.com>
References: <e5f4e68eed85fa8495d78cd966eecc2b27bb9e53.1712621427.git.len.brown@intel.com>
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Reply-To: Len Brown <lenb@kernel.org>
Organization: Intel Open Source Technology Center
Content-Transfer-Encoding: 8bit

From: Patryk Wlazlyn <patryk.wlazlyn@linux.intel.com>

Add the --no-perf option to allow users to run turbostat without
accessing perf.

Signed-off-by: Patryk Wlazlyn <patryk.wlazlyn@linux.intel.com>
Reviewed-by: Len Brown <len.brown@intel.com>
Signed-off-by: Len Brown <len.brown@intel.com>
---
 tools/power/x86/turbostat/turbostat.8 |  2 ++
 tools/power/x86/turbostat/turbostat.c | 25 ++++++++++++++++++++++---
 2 files changed, 24 insertions(+), 3 deletions(-)

diff --git a/tools/power/x86/turbostat/turbostat.8 b/tools/power/x86/turbostat/turbostat.8
index 28be452fbfe2..567327b004e6 100644
--- a/tools/power/x86/turbostat/turbostat.8
+++ b/tools/power/x86/turbostat/turbostat.8
@@ -69,6 +69,8 @@ The column name "all" can be used to enable all disabled-by-default built-in cou
 .PP
 +\fB--no-msr\fP Disable all the uses of the MSR driver.
 +.PP
++\fB--no-perf\fP Disable all the uses of the perf API.
++.PP
 \fB--interval seconds\fP overrides the default 5.0 second measurement interval.
 .PP
 \fB--num_iterations num\fP number of the measurement iterations.
diff --git a/tools/power/x86/turbostat/turbostat.c b/tools/power/x86/turbostat/turbostat.c
index 4d5437a9725b..bad2fec7f342 100644
--- a/tools/power/x86/turbostat/turbostat.c
+++ b/tools/power/x86/turbostat/turbostat.c
@@ -267,6 +267,7 @@ unsigned int has_hwp_pkg;	/* IA32_HWP_REQUEST_PKG */
 unsigned int first_counter_read = 1;
 int ignore_stdin;
 bool no_msr;
+bool no_perf;
 
 int get_msr(int cpu, off_t offset, unsigned long long *msr);
 
@@ -1314,8 +1315,17 @@ static void bic_disable_msr_access(void)
 	bic_enabled &= ~bic_msrs;
 }
 
+static void bic_disable_perf_access(void)
+{
+	const unsigned long bic_perf = BIC_IPC;
+
+	bic_enabled &= ~bic_perf;
+}
+
 static long perf_event_open(struct perf_event_attr *hw_event, pid_t pid, int cpu, int group_fd, unsigned long flags)
 {
+	assert(!no_perf);
+
 	return syscall(__NR_perf_event_open, hw_event, pid, cpu, group_fd, flags);
 }
 
@@ -1332,8 +1342,8 @@ static int perf_instr_count_open(int cpu_num)
 	/* counter for cpu_num, including user + kernel and all processes */
 	fd = perf_event_open(&pea, -1, cpu_num, -1, 0);
 	if (fd == -1) {
-		warnx("capget(CAP_PERFMON) failed, try \"# setcap cap_sys_admin=ep %s\"", progname);
-		BIC_NOT_PRESENT(BIC_IPC);
+		warnx("capget(CAP_PERFMON) failed, try \"# setcap cap_sys_admin=ep %s\" or use --no-perf", progname);
+		bic_disable_perf_access();
 	}
 
 	return fd;
@@ -1399,6 +1409,7 @@ void help(void)
 		"  -J, --Joules	displays energy in Joules instead of Watts\n"
 		"  -l, --list	list column headers only\n"
 		"  -M, --no-msr Disable all uses of the MSR driver\n"
+		"  -P, --no-perf Disable all uses of the perf API\n"
 		"  -n, --num_iterations num\n"
 		"		number of the measurement iterations\n"
 		"  -N, --header_iterations num\n"
@@ -6745,6 +6756,7 @@ void cmdline(int argc, char **argv)
 		{ "out", required_argument, 0, 'o' },
 		{ "quiet", no_argument, 0, 'q' },
 		{ "no-msr", no_argument, 0, 'M' },
+		{ "no-perf", no_argument, 0, 'P' },
 		{ "show", required_argument, 0, 's' },
 		{ "Summary", no_argument, 0, 'S' },
 		{ "TCC", required_argument, 0, 'T' },
@@ -6758,11 +6770,14 @@ void cmdline(int argc, char **argv)
 	 * Parse some options early, because they may make other options invalid,
 	 * like adding the MSR counter with --add and at the same time using --no-msr.
 	 */
-	while ((opt = getopt_long_only(argc, argv, "M", long_options, &option_index)) != -1) {
+	while ((opt = getopt_long_only(argc, argv, "MP", long_options, &option_index)) != -1) {
 		switch (opt) {
 		case 'M':
 			no_msr = 1;
 			break;
+		case 'P':
+			no_perf = 1;
+			break;
 		default:
 			break;
 		}
@@ -6828,6 +6843,7 @@ void cmdline(int argc, char **argv)
 			quiet = 1;
 			break;
 		case 'M':
+		case 'P':
 			/* Parsed earlier */
 			break;
 		case 'n':
@@ -6909,6 +6925,9 @@ int main(int argc, char **argv)
 	if (no_msr)
 		bic_disable_msr_access();
 
+	if (no_perf)
+		bic_disable_perf_access();
+
 	if (!quiet) {
 		print_version();
 		print_bootcmd();
-- 
2.40.1


