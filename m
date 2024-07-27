Return-Path: <linux-pm+bounces-11482-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id CF26F93E088
	for <lists+linux-pm@lfdr.de>; Sat, 27 Jul 2024 20:27:11 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 85F6A281E34
	for <lists+linux-pm@lfdr.de>; Sat, 27 Jul 2024 18:27:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EDC20187347;
	Sat, 27 Jul 2024 18:26:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="NRSDR2bE"
X-Original-To: linux-pm@vger.kernel.org
Received: from mail-oa1-f43.google.com (mail-oa1-f43.google.com [209.85.160.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3B471187357
	for <linux-pm@vger.kernel.org>; Sat, 27 Jul 2024 18:26:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722104819; cv=none; b=h1W/VYtx8wmK8vLgKZq/yPdGqDybErVVbPl3jqMhCSy2VWziCO+/bUA4lEdhEw+x1fV+dP+Df3x/k1y/TQTV/1CNnofKkT2wFGNZBGjhVqmk4Txgt1CnGh+WbftqqF2MZ5vrVP+gaWNamZG1h14rGBCq9aVToU94qpy939PnF6U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722104819; c=relaxed/simple;
	bh=knORRxGn4Uu+GlcmcJ5/WKXkDJpy/gVzp6p08w0WZUw=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=PP5k7gR/ysm3ozQCm5MeedE/xp/T+SEFce/Y+j/E/gPaEUu/y3psLdjl2vESxUGEOdKg1ARakYIUr+nbw3T3gfMUbHHkZmhosVLQ67k8KVmpWkjL6dk9hCZ5VQcwI/mLIiYeixRC/O05Em33iJmLuXPfPq8E9Buy44WQJ7n2/OY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=NRSDR2bE; arc=none smtp.client-ip=209.85.160.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-oa1-f43.google.com with SMTP id 586e51a60fabf-260f863109cso1345610fac.1
        for <linux-pm@vger.kernel.org>; Sat, 27 Jul 2024 11:26:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1722104817; x=1722709617; darn=vger.kernel.org;
        h=content-transfer-encoding:organization:reply-to:mime-version
         :references:in-reply-to:message-id:date:subject:cc:to:from:sender
         :from:to:cc:subject:date:message-id:reply-to;
        bh=EltPequ97cPuDl4L5jEWw/rxuM1v2Pff0o2dQJ3M0fc=;
        b=NRSDR2bEjBBLpslGRtZe9M05McFT/EEvAhK4GXAfz+BU7YobgAKaD/JkDPcjDyH33H
         vyd3MOh1aVCoSreS9tcmgk97f+MoCpRTFBeCax4pfgYS7gcEIcybEwGKMC+553AXaysY
         Pz/CtVGp91xorFLLXUZ8znvk72jD+2xzb/9Tlp6ivKf8MCJ7eFM4JeGJO9vOqvP1RXtw
         hhNq4uUGxUhXUIryJRlA88+QSOeKN1smrv3WyuUh3b1nXBj0SZcjip3rdPH4VhQw964y
         LdwEzvgC/BnUjal30ismMS2Furgm4gZ0NnP+74BsQuGPXN0E3Adz8DPPcB5OIuKf5jhP
         VC5w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1722104817; x=1722709617;
        h=content-transfer-encoding:organization:reply-to:mime-version
         :references:in-reply-to:message-id:date:subject:cc:to:from:sender
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=EltPequ97cPuDl4L5jEWw/rxuM1v2Pff0o2dQJ3M0fc=;
        b=VdFco7pdE/bEFg/SN4dAj59nVOU3B8La9R6Gnz/1ElH7DIi2O8xdj1j/S2QFkJ5Th6
         Yt7QFvjczHq/aqs8wa71Gd428uGl8RKuiG2leRcIPVbWMw3Q6G0VVb3mDCYzWAxECuYp
         XriN3Dca1k2qBvHVmbAtoLkSr1+2kTIZ2MR3sh8TIwx7OPmnsRHK8xJt1q6aRJe/P8Ln
         Zmth3Ats+f3NNXY7ZOZD68wIY2vtCriw8Ao16hH7hdwpeOSXsIsAn2YO8UyfLFyMrZCs
         nqnbAXCsXpd7+H2vY9ABX0ZsaXGKTIDkC4FvgNY5MEzpzHpdpoFj4WBN4AVjojdpfsc1
         I20w==
X-Gm-Message-State: AOJu0Yy24UmN2bASF5FE4dsH4O+B67oOYxB4CkzLpWXdcQP7EC0davaT
	TKJwPiLPGuhGEpwhN55CjxpjPpkEW9dbU16yyd5upV+LFptXGGldMMvfGw==
X-Google-Smtp-Source: AGHT+IGsHDmPlxZbtzG3v+sk3IsnA0DboQGFuZY5Gj5B2O3SpPGG3O62HkwEw4n1ryPplnzMKte5bA==
X-Received: by 2002:a05:6871:712:b0:261:1339:1cb9 with SMTP id 586e51a60fabf-267d4ef3e75mr3609859fac.35.1722104817102;
        Sat, 27 Jul 2024 11:26:57 -0700 (PDT)
Received: from lenb-intel-nuc8i7hvkva.. (h75-100-80-185.cntcnh.broadband.dynamic.tds.net. [75.100.80.185])
        by smtp.gmail.com with ESMTPSA id 46e09a7af769-7093050a35fsm1314136a34.6.2024.07.27.11.26.56
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 27 Jul 2024 11:26:56 -0700 (PDT)
Sender: Len Brown <lenb417@gmail.com>
From: Len Brown <lenb@kernel.org>
To: linux-pm@vger.kernel.org
Cc: Patryk Wlazlyn <patryk.wlazlyn@linux.intel.com>,
	Len Brown <len.brown@intel.com>
Subject: [PATCH 12/18] tools/power turbostat: Add selftests for SMI, APERF and MPERF counters
Date: Sat, 27 Jul 2024 14:23:38 -0400
Message-ID: <1f8add13e6c86653da2ec599dfc94e7a8865cdcb.1722019621.git.len.brown@intel.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <1b3bf0747d4f1a963e59c26e602868bdce195318.1722019621.git.len.brown@intel.com>
References: <1b3bf0747d4f1a963e59c26e602868bdce195318.1722019621.git.len.brown@intel.com>
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

The test requests BICs that are dependent on SMI, APERF and MPERF
counters and checks if the columns show up in the output and the
turbostat doesn't crash. Read the counters in both --no-msr
and --no-perf mode.

The test skips counters that are not present or user does not have
permissions to read. It is not an error, but the test may not be as
exhaustive.

Signed-off-by: Patryk Wlazlyn <patryk.wlazlyn@linux.intel.com>
Signed-off-by: Len Brown <len.brown@intel.com>
---
 .../selftests/turbostat/smi_aperf_mperf.py    | 157 ++++++++++++++++++
 1 file changed, 157 insertions(+)
 create mode 100755 tools/testing/selftests/turbostat/smi_aperf_mperf.py

diff --git a/tools/testing/selftests/turbostat/smi_aperf_mperf.py b/tools/testing/selftests/turbostat/smi_aperf_mperf.py
new file mode 100755
index 000000000000..6289cc47d5f0
--- /dev/null
+++ b/tools/testing/selftests/turbostat/smi_aperf_mperf.py
@@ -0,0 +1,157 @@
+#!/bin/env python3
+# SPDX-License-Identifier: GPL-2.0
+
+import subprocess
+from shutil import which
+from os import pread
+
+# CDLL calls dlopen underneath.
+# Calling it with None (null), we get handle to the our own image (python interpreter).
+# We hope to find sched_getcpu() inside ;]
+# This is a bit ugly, but helps shipping working software, so..
+try:
+	import ctypes
+
+	this_image = ctypes.CDLL(None)
+	BASE_CPU = this_image.sched_getcpu()
+except:
+	BASE_CPU = 0 # If we fail, set to 0 and pray it's not offline.
+
+MSR_IA32_MPERF = 0x000000e7
+MSR_IA32_APERF = 0x000000e8
+
+def check_perf_access():
+	perf = which('perf')
+	if perf is None:
+		print('SKIP: Could not find perf binary, thus could not determine perf access.')
+		return False
+
+	def has_perf_counter_access(counter_name):
+		proc_perf = subprocess.run([perf, 'stat', '-e', counter_name, '--timeout', '10'],
+					    capture_output = True)
+
+		if proc_perf.returncode != 0:
+			print(f'SKIP: Could not read {counter_name} perf counter, assuming no access.')
+			return False
+
+		if b'<not supported>' in proc_perf.stderr:
+			print(f'SKIP: Could not read {counter_name} perf counter, assuming no access.')
+			return False
+
+		return True
+
+	if not has_perf_counter_access('msr/mperf/'):
+		return False
+	if not has_perf_counter_access('msr/aperf/'):
+		return False
+	if not has_perf_counter_access('msr/smi/'):
+		return False
+
+	return True
+
+def check_msr_access():
+	try:
+		file_msr = open(f'/dev/cpu/{BASE_CPU}/msr', 'rb')
+	except:
+		return False
+
+	if len(pread(file_msr.fileno(), 8, MSR_IA32_MPERF)) != 8:
+		return False
+
+	if len(pread(file_msr.fileno(), 8, MSR_IA32_APERF)) != 8:
+		return False
+
+	return True
+
+has_perf_access = check_perf_access()
+has_msr_access = check_msr_access()
+
+turbostat_counter_source_opts = ['']
+
+if has_msr_access:
+	turbostat_counter_source_opts.append('--no-perf')
+else:
+	print('SKIP: doesn\'t have MSR access, skipping run with --no-perf')
+
+if has_perf_access:
+	turbostat_counter_source_opts.append('--no-msr')
+else:
+	print('SKIP: doesn\'t have perf access, skipping run with --no-msr')
+
+if not has_msr_access and not has_perf_access:
+	print('SKIP: No MSR nor perf access detected. Skipping the tests entirely')
+	exit(0)
+
+turbostat = which('turbostat')
+if turbostat is None:
+	print('Could not find turbostat binary')
+	exit(1)
+
+timeout = which('timeout')
+if timeout is None:
+	print('Could not find timeout binary')
+	exit(1)
+
+proc_turbostat = subprocess.run([turbostat, '--list'], capture_output = True)
+if proc_turbostat.returncode != 0:
+	print(f'turbostat failed with {proc_turbostat.returncode}')
+	exit(1)
+
+EXPECTED_COLUMNS_DEBUG_DEFAULT = b'usec\tTime_Of_Day_Seconds\tAPIC\tX2APIC'
+
+SMI_APERF_MPERF_DEPENDENT_BICS = [
+	'SMI',
+	'Avg_MHz',
+	'Busy%',
+	'Bzy_MHz',
+]
+if has_perf_access:
+	SMI_APERF_MPERF_DEPENDENT_BICS.append('IPC')
+
+for bic in SMI_APERF_MPERF_DEPENDENT_BICS:
+	for counter_source_opt in turbostat_counter_source_opts:
+
+		# Ugly special case, but it is what it is..
+		if counter_source_opt == '--no-perf' and bic == 'IPC':
+			continue
+
+		expected_columns = bic.encode()
+		expected_columns_debug = EXPECTED_COLUMNS_DEBUG_DEFAULT + f'\t{bic}'.encode()
+
+		#
+		# Run turbostat for some time and send SIGINT
+		#
+		timeout_argv = [timeout, '--preserve-status', '-s', 'SIGINT', '-k', '3', '0.2s']
+		turbostat_argv = [turbostat, '-i', '0.50', '--show', bic]
+
+		if counter_source_opt:
+			turbostat_argv.append(counter_source_opt)
+
+		print(f'Running turbostat with {turbostat_argv=}... ', end = '', flush = True)
+		proc_turbostat = subprocess.run(timeout_argv + turbostat_argv, capture_output = True)
+		if proc_turbostat.returncode != 0:
+			print(f'turbostat failed with {proc_turbostat.returncode}')
+			exit(1)
+
+		actual_columns = proc_turbostat.stdout.split(b'\n')[0]
+		if expected_columns != actual_columns:
+			print(f'turbostat column check failed\n{expected_columns=}\n{actual_columns=}')
+			exit(1)
+		print('OK')
+
+		#
+		# Same, but with --debug
+		#
+		turbostat_argv.append('--debug')
+
+		print(f'Running turbostat with {turbostat_argv=}... ', end = '', flush = True)
+		proc_turbostat = subprocess.run(timeout_argv + turbostat_argv, capture_output = True)
+		if proc_turbostat.returncode != 0:
+			print(f'turbostat failed with {proc_turbostat.returncode}')
+			exit(1)
+
+		actual_columns = proc_turbostat.stdout.split(b'\n')[0]
+		if expected_columns_debug != actual_columns:
+			print(f'turbostat column check failed\n{expected_columns_debug=}\n{actual_columns=}')
+			exit(1)
+		print('OK')
-- 
2.43.0


