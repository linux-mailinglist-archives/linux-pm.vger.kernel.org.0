Return-Path: <linux-pm+bounces-11483-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id D90BC93E08A
	for <lists+linux-pm@lfdr.de>; Sat, 27 Jul 2024 20:27:15 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 4BE50B213F3
	for <lists+linux-pm@lfdr.de>; Sat, 27 Jul 2024 18:27:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C940F18756A;
	Sat, 27 Jul 2024 18:27:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Q4pZ3xnH"
X-Original-To: linux-pm@vger.kernel.org
Received: from mail-ot1-f49.google.com (mail-ot1-f49.google.com [209.85.210.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 06104187561
	for <linux-pm@vger.kernel.org>; Sat, 27 Jul 2024 18:26:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722104820; cv=none; b=u7PaKPIIJ7MWnwLQKFLAhLaEK7fowBLYmUIPwsb62vkbaFdWdeOUSakdBwl4lLW4lB5rGXz8Dl3o5pP27zLRfiZm/zcQ7jbYmqhRR5ro9auCpnhaaiyIYu4XhmiMtsevRwzdPopWoJcjf/H/vblrIsZ70QtkCv8Mf0tz08jHPXU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722104820; c=relaxed/simple;
	bh=TKRoCEtGlGJUAAC5wwo1VZhxRAnnmARNGgUjCiNCwTI=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=f+QizZaoiyV7V+1aXbw+1p/k9bdK2kQnh1dA/2z6S03zJWW+ADyDtMw6KlYM6ei5KDXjzo7u1+Jsk3Iy7EHSGZ3EIHtVXcSwNneoHS2vgLlsKK7i94x1OVxTmstOyXkIuKdRYdMBmkmet/EtYMER8mCNv7qrd99if/VrdD+njwk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Q4pZ3xnH; arc=none smtp.client-ip=209.85.210.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ot1-f49.google.com with SMTP id 46e09a7af769-70936061d0dso1411236a34.2
        for <linux-pm@vger.kernel.org>; Sat, 27 Jul 2024 11:26:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1722104818; x=1722709618; darn=vger.kernel.org;
        h=content-transfer-encoding:organization:reply-to:mime-version
         :references:in-reply-to:message-id:date:subject:cc:to:from:sender
         :from:to:cc:subject:date:message-id:reply-to;
        bh=u+ay82VlDGaGHrH2ZyZnOA0EzkKsqXYNwoRIghwdoZs=;
        b=Q4pZ3xnHhsFo8UbC0AXkF3PhTcSKZZXrr3My+99BjIxNFWxZ6fHNiN3tV00j2EVeHl
         v1BquAsDzs/HgJ5ncSeD8/6PZzKIKZkkv754N+JUYh4rxeEqv0qav9WK5du3BXf5AnLy
         JrCv88OqO1EngxfnGzDCMdtvQ2T3b3SvUw20TxNzbqxoZCqhPULKuAKdETcm8632q00n
         7TOh/xtqihxyLeM9iR1rwZLxcfemVJdnRRV7tSVmlU0MV5hdHXj/zd5QiFwl076TScjS
         HkrOya/+HSadirvh/5EhBnTBUbgRXq/R1DTDT5xr0dbYpqtGfuT0BRtq40YawjF/qb0w
         OG0g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1722104818; x=1722709618;
        h=content-transfer-encoding:organization:reply-to:mime-version
         :references:in-reply-to:message-id:date:subject:cc:to:from:sender
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=u+ay82VlDGaGHrH2ZyZnOA0EzkKsqXYNwoRIghwdoZs=;
        b=rPeRXKHgoumXEM49fcGtfT17shrButsQhkamCLjpcEuw8GDLClTjyLp10uSqS2K4Dt
         X7tQors2aNAyRS41c0FBjGA21ALLF1/11RL0F8IlY2KXt2GBtZBdXU+vcLMCYqGkDCsG
         6uKaFOU4I7tQHOyXWdz5Sg59itC76aNROY0OXqyZ8DRmD5w59Up1yC8Spc8ttJCeq6wu
         oEDf2rxMGf//+22hbbtkDoHXgvLDReeol7qp6AEQSrifS3dYAf2T79s70MtQL3sU8pc8
         psuz7sdkmvpkEIjmmcVFqtlqPnfIhYpvvvRCQ7bCFuvRgJJ+VOIvajDVMXmBdBmdvAXL
         ln7A==
X-Gm-Message-State: AOJu0YyU2b138tfxbthHWYx5mQvWI83JjsNbvY+BpvlJCOwxSulDj500
	jkdv8yXP1bYD397gHTEalBfFm3HBMO/5gMzl2h5cELnFG3rY89rK4jTUgw==
X-Google-Smtp-Source: AGHT+IECzUGTbWfGgsv/YbMNaqgo3r/repcRYUAWASkkEw/mhwMo2TpoYInEueV0OFrglR+bkQf9QQ==
X-Received: by 2002:a05:6830:f93:b0:708:b100:3a35 with SMTP id 46e09a7af769-70940c513a4mr3882007a34.21.1722104817954;
        Sat, 27 Jul 2024 11:26:57 -0700 (PDT)
Received: from lenb-intel-nuc8i7hvkva.. (h75-100-80-185.cntcnh.broadband.dynamic.tds.net. [75.100.80.185])
        by smtp.gmail.com with ESMTPSA id 46e09a7af769-7093050a35fsm1314136a34.6.2024.07.27.11.26.57
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 27 Jul 2024 11:26:57 -0700 (PDT)
Sender: Len Brown <lenb417@gmail.com>
From: Len Brown <lenb@kernel.org>
To: linux-pm@vger.kernel.org
Cc: Patryk Wlazlyn <patryk.wlazlyn@linux.intel.com>,
	Len Brown <len.brown@intel.com>
Subject: [PATCH 13/18] tools/power turbostat: Add selftests for added perf counters
Date: Sat, 27 Jul 2024 14:23:39 -0400
Message-ID: <f3065f9c3917fa9279992623a2f3282f1fd43515.1722019621.git.len.brown@intel.com>
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

Test adds several perf counters from msr, cstate_core and cstate_pkg
groups and checks if the columns for those counters show up.
The test skips the counters that are not present. It is not an error,
but the test may not be as exhaustive.

Signed-off-by: Patryk Wlazlyn <patryk.wlazlyn@linux.intel.com>
Signed-off-by: Len Brown <len.brown@intel.com>
---
 .../turbostat/added_perf_counters.py          | 178 ++++++++++++++++++
 1 file changed, 178 insertions(+)
 create mode 100755 tools/testing/selftests/turbostat/added_perf_counters.py

diff --git a/tools/testing/selftests/turbostat/added_perf_counters.py b/tools/testing/selftests/turbostat/added_perf_counters.py
new file mode 100755
index 000000000000..9ab4aaf45fb8
--- /dev/null
+++ b/tools/testing/selftests/turbostat/added_perf_counters.py
@@ -0,0 +1,178 @@
+#!/bin/env python3
+# SPDX-License-Identifier: GPL-2.0
+
+import subprocess
+from shutil import which
+from os import pread
+
+class PerfCounterInfo:
+	def __init__(self, subsys, event):
+		self.subsys = subsys
+		self.event = event
+
+	def get_perf_event_name(self):
+		return f'{self.subsys}/{self.event}/'
+
+	def get_turbostat_perf_id(self, counter_scope, counter_type, column_name):
+		return f'perf/{self.subsys}/{self.event},{counter_scope},{counter_type},{column_name}'
+
+PERF_COUNTERS_CANDIDATES = [
+	PerfCounterInfo('msr', 'mperf'),
+	PerfCounterInfo('msr', 'aperf'),
+	PerfCounterInfo('msr', 'tsc'),
+	PerfCounterInfo('cstate_core', 'c1-residency'),
+	PerfCounterInfo('cstate_core', 'c6-residency'),
+	PerfCounterInfo('cstate_core', 'c7-residency'),
+	PerfCounterInfo('cstate_pkg', 'c2-residency'),
+	PerfCounterInfo('cstate_pkg', 'c3-residency'),
+	PerfCounterInfo('cstate_pkg', 'c6-residency'),
+	PerfCounterInfo('cstate_pkg', 'c7-residency'),
+	PerfCounterInfo('cstate_pkg', 'c8-residency'),
+	PerfCounterInfo('cstate_pkg', 'c9-residency'),
+	PerfCounterInfo('cstate_pkg', 'c10-residency'),
+]
+present_perf_counters = []
+
+def check_perf_access():
+	perf = which('perf')
+	if perf is None:
+		print('SKIP: Could not find perf binary, thus could not determine perf access.')
+		return False
+
+	def has_perf_counter_access(counter_name):
+		proc_perf = subprocess.run([perf, 'stat', '-e', counter_name, '--timeout', '10'],
+							 capture_output = True)
+
+		if proc_perf.returncode != 0:
+			print(f'SKIP: Could not read {counter_name} perf counter.')
+			return False
+
+		if b'<not supported>' in proc_perf.stderr:
+			print(f'SKIP: Could not read {counter_name} perf counter.')
+			return False
+
+		return True
+
+	for counter in PERF_COUNTERS_CANDIDATES:
+		if has_perf_counter_access(counter.get_perf_event_name()):
+			present_perf_counters.append(counter)
+
+	if len(present_perf_counters) == 0:
+		print('SKIP: Could not read any perf counter.')
+		return False
+
+	if len(present_perf_counters) != len(PERF_COUNTERS_CANDIDATES):
+		print(f'WARN: Could not access all of the counters - some will be left untested')
+
+	return True
+
+if not check_perf_access():
+	exit(0)
+
+turbostat_counter_source_opts = ['']
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
+EXPECTED_COLUMNS_DEBUG_DEFAULT = [b'usec', b'Time_Of_Day_Seconds', b'APIC', b'X2APIC']
+
+expected_columns = [b'CPU']
+counters_argv = []
+for counter in present_perf_counters:
+	if counter.subsys == 'cstate_core':
+		counter_scope = 'core'
+	elif counter.subsys == 'cstate_pkg':
+		counter_scope = 'package'
+	else:
+		counter_scope = 'cpu'
+
+	counter_type = 'delta'
+	column_name = counter.event
+
+	cparams = counter.get_turbostat_perf_id(
+		counter_scope = counter_scope,
+		counter_type = counter_type,
+		column_name = column_name
+	)
+	expected_columns.append(column_name.encode())
+	counters_argv.extend(['--add', cparams])
+
+expected_columns_debug = EXPECTED_COLUMNS_DEBUG_DEFAULT + expected_columns
+
+def gen_user_friendly_cmdline(argv_):
+	argv = argv_[:]
+	ret = ''
+
+	while len(argv) != 0:
+		arg = argv.pop(0)
+		arg_next = ''
+
+		if arg in ('-i', '--show', '--add'):
+			arg_next = argv.pop(0) if len(argv) > 0 else ''
+
+		ret += f'{arg} {arg_next} \\\n\t'
+
+	# Remove the last separator and return
+	return ret[:-4]
+
+#
+# Run turbostat for some time and send SIGINT
+#
+timeout_argv = [timeout, '--preserve-status', '-s', 'SIGINT', '-k', '3', '0.2s']
+turbostat_argv = [turbostat, '-i', '0.50', '--show', 'CPU'] + counters_argv
+
+def check_columns_or_fail(expected_columns: list, actual_columns: list):
+	if len(actual_columns) != len(expected_columns):
+		print(f'turbostat column check failed\n{expected_columns=}\n{actual_columns=}')
+		exit(1)
+
+	failed = False
+	for expected_column in expected_columns:
+		if expected_column not in actual_columns:
+			print(f'turbostat column check failed: missing column {expected_column.decode()}')
+			failed = True
+
+	if failed:
+		exit(1)
+
+cmdline = gen_user_friendly_cmdline(turbostat_argv)
+print(f'Running turbostat with:\n\t{cmdline}\n... ', end = '', flush = True)
+proc_turbostat = subprocess.run(timeout_argv + turbostat_argv, capture_output = True)
+if proc_turbostat.returncode != 0:
+	print(f'turbostat failed with {proc_turbostat.returncode}')
+	exit(1)
+
+actual_columns = proc_turbostat.stdout.split(b'\n')[0].split(b'\t')
+check_columns_or_fail(expected_columns, actual_columns)
+print('OK')
+
+#
+# Same, but with --debug
+#
+# We explicitly specify '--show CPU' to make sure turbostat
+# don't show a bunch of default counters instead.
+#
+turbostat_argv.append('--debug')
+
+cmdline = gen_user_friendly_cmdline(turbostat_argv)
+print(f'Running turbostat (in debug mode) with:\n\t{cmdline}\n... ', end = '', flush = True)
+proc_turbostat = subprocess.run(timeout_argv + turbostat_argv, capture_output = True)
+if proc_turbostat.returncode != 0:
+	print(f'turbostat failed with {proc_turbostat.returncode}')
+	exit(1)
+
+actual_columns = proc_turbostat.stdout.split(b'\n')[0].split(b'\t')
+check_columns_or_fail(expected_columns_debug, actual_columns)
+print('OK')
-- 
2.43.0


