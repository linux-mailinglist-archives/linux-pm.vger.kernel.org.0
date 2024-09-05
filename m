Return-Path: <linux-pm+bounces-13643-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 5A63A96CC8A
	for <lists+linux-pm@lfdr.de>; Thu,  5 Sep 2024 04:19:59 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 7E40E1C22AC1
	for <lists+linux-pm@lfdr.de>; Thu,  5 Sep 2024 02:19:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2306913D291;
	Thu,  5 Sep 2024 02:19:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="Q5TSXbqB"
X-Original-To: linux-pm@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 08DAF12E1C2
	for <linux-pm@vger.kernel.org>; Thu,  5 Sep 2024 02:19:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725502782; cv=none; b=avU9QGPqGXxIG5UziPzkG1JjreXSMrYIvMu7THvDjaswt4ZmgsdWtIkazXDh+T0Hv+ZLbRmOPVHyDgq1x2lDPk0MgcDtMnhcpeBJ5Iv3INP6tWKcGTtCUDE5OVaqQGRWAZa24UHWyQ2ij3bTw7WFs9kBs+GgeFrx/13pbnmKhIU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725502782; c=relaxed/simple;
	bh=avXZqBGyl0PBfWGutpoedY96JbpOoQ4Nv23V120eKtg=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=krsEoVittkkQ8QxWvFmRm0favKZgpfVex4ZDVt7hHcIdmAlgNeD2OjSqzl4UHcEm9dTVey9Mc5B7HPTTIUWQVWctkK84vjA5Evv7wvKlZScqxP8FGfF9iq/kLbL6awA0wSXkkNH5uDE1z1uzZ7N3bwX25m3wJS/dL2qEyvEUMGE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=Q5TSXbqB; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1725502779;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=SI2r+N1hUOAE/HA0o+vLkapp6H/3ME0ZRjnOEiTRE+E=;
	b=Q5TSXbqBBUkkQWC+DApIpXRgo+qBQTxzkOEu+DQ4m5a8eU/V4tVjKqxktNwh4da+p+jlAI
	m0JgsATaa2yDz/OFLie558IupcwcHJHGN9cgnPTqt0nCBp+sPfRZQnpup3/0m5axYPMzlb
	TSYJ/EbMGzb319prL3iV6FjQjP7MWvk=
Received: from mail-qt1-f200.google.com (mail-qt1-f200.google.com
 [209.85.160.200]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-692-ZILnwRFeNZqHV017zdjD3A-1; Wed, 04 Sep 2024 22:19:37 -0400
X-MC-Unique: ZILnwRFeNZqHV017zdjD3A-1
Received: by mail-qt1-f200.google.com with SMTP id d75a77b69052e-4567ede92efso3884591cf.1
        for <linux-pm@vger.kernel.org>; Wed, 04 Sep 2024 19:19:37 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1725502777; x=1726107577;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=SI2r+N1hUOAE/HA0o+vLkapp6H/3ME0ZRjnOEiTRE+E=;
        b=u0JFZhjz5vHE2EklcGA4rThID2By/Fl1IMNtFQa8i4wakJmADuGp1/0RY6vymvZlNY
         yOaY4UJJtd86+Iffiejri8mGfJRV3w8v1OjDGoJdcoxoD6K19pkO+7iQAOkjk0w+OhdY
         SmQmandYUz4ySumd9a96l87hvkLpa2TFpKSn2Tvdz4Nx04auVmz1BYudIQuO5wJZQ2mA
         umsbokkW1lBzP/dsAPUFnqqkuSLDGnUoBO5/hIphP8+u4BJTOZdpUyJ4g8uE652jkau+
         mMxtBRDS1No38oVdzW+HVNZjPLda3qr1KojAWJwwUNvMQFXKL5r70zMKnGWv4DSjHrd2
         jYPA==
X-Forwarded-Encrypted: i=1; AJvYcCVrDmQy/o4qYkLsJetUztjso6FLK16ZVu9Ky5B7utFkifAYg+zz1vaTkpuTgwot3wyffgb0ZWL9TA==@vger.kernel.org
X-Gm-Message-State: AOJu0Ywi3k1bGC+yWzargyRlZVjXLEJy8GrSl3K42mqP13CFdlbmmOEZ
	uEPyKVZftoZTMMzWhlEnKR1aIMwtGPSVMm42Xa1qMNVY8ILKh/I6BurxwPhnVH9EZfHucoQlX6P
	S8foUw7DYVpY7iGMjZahEAmpDtuMjVscClN2fUTEmYcpdrVQ++qPuPhGI
X-Received: by 2002:a05:622a:4108:b0:454:f62b:837b with SMTP id d75a77b69052e-456f1699f05mr143814411cf.13.1725502777212;
        Wed, 04 Sep 2024 19:19:37 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IGZ6lAV1LrCns7mFWbxTbd0zdU4WtLzAxHlEgyJSuS4YrbWAi9sHPaZ+muXWrLAZrzs88TWTg==
X-Received: by 2002:a05:622a:4108:b0:454:f62b:837b with SMTP id d75a77b69052e-456f1699f05mr143814241cf.13.1725502776780;
        Wed, 04 Sep 2024 19:19:36 -0700 (PDT)
Received: from rhfedora.redhat.com ([71.217.47.229])
        by smtp.gmail.com with ESMTPSA id d75a77b69052e-45801db22b5sm3531181cf.72.2024.09.04.19.19.36
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 04 Sep 2024 19:19:36 -0700 (PDT)
From: "John B. Wyatt IV" <jwyatt@redhat.com>
To: Shuah Khan <skhan@linuxfoundation.org>
Cc: "John B. Wyatt IV" <jwyatt@redhat.com>,
	linux-pm@vger.kernel.org,
	Thomas Renninger <trenn@suse.com>,
	Shuah Khan <shuah@kernel.org>,
	"Rafael J. Wysocki" <rafael@kernel.org>,
	Linus Torvalds <torvalds@linux-foundation.org>,
	linux-kernel@vger.kernel.org,
	John Kacur <jkacur@redhat.com>,
	Tomas Glozar <tglozar@redhat.com>,
	Arnaldo Melo <acme@redhat.com>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	"John B. Wyatt IV" <sageofredondo@gmail.com>
Subject: [PATCH v3 2/4] pm:cpupower: Add SWIG bindings files for libcpupower
Date: Wed,  4 Sep 2024 22:19:09 -0400
Message-ID: <20240905021916.15938-3-jwyatt@redhat.com>
X-Mailer: git-send-email 2.46.0
In-Reply-To: <20240905021916.15938-1-jwyatt@redhat.com>
References: <20240905021916.15938-1-jwyatt@redhat.com>
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

SWIG is a tool packaged in Fedora and other distros that can generate
bindings from C and C++ code for several languages including Python,
Perl, and Go.

These bindings allows users to easily write scripts that use and extend
libcpupower's functionality. Currently, only Python is provided in the
makefile, but additional languages may be added if there is demand.

Added suggestions from Shuah Khan for the README and license discussion.

Note that while SWIG itself is GPL v3+ licensed; the resulting output,
the bindings code, is permissively licensed + the license of the .o
files. Please see
https://swig.org/legal.html and [1] for more details.

[1]
https://lore.kernel.org/linux-pm/Zqv9BOjxLAgyNP5B@hatbackup/

Suggested-by: Shuah Khan <skhan@linuxfoundation.org>
Signed-off-by: John B. Wyatt IV <jwyatt@redhat.com>
Signed-off-by: John B. Wyatt IV <sageofredondo@gmail.com>
---

Changes in v3:
	- Reordered patch series for cpupower stub implementation to be
	  first.
	- Added pm:cpupower prefix to header and Rafael to Cc.

Changes in v2:
	- Implemented the function so SWIG will accept the header
	  definition
---
 .../power/cpupower/bindings/python/.gitignore |   8 +
 tools/power/cpupower/bindings/python/Makefile |  31 +++
 tools/power/cpupower/bindings/python/README   |  59 +++++
 .../bindings/python/raw_pylibcpupower.i       | 247 ++++++++++++++++++
 4 files changed, 345 insertions(+)
 create mode 100644 tools/power/cpupower/bindings/python/.gitignore
 create mode 100644 tools/power/cpupower/bindings/python/Makefile
 create mode 100644 tools/power/cpupower/bindings/python/README
 create mode 100644 tools/power/cpupower/bindings/python/raw_pylibcpupower.i

diff --git a/tools/power/cpupower/bindings/python/.gitignore b/tools/power/cpupower/bindings/python/.gitignore
new file mode 100644
index 000000000000..5c9a1f0212dd
--- /dev/null
+++ b/tools/power/cpupower/bindings/python/.gitignore
@@ -0,0 +1,8 @@
+__pycache__/
+raw_pylibcpupower_wrap.c
+*.o
+*.so
+*.py
+!test_raw_pylibcpupower.py
+# git keeps ignoring this file, use git add -f raw_libcpupower.i
+!raw_pylibcpupower.i
diff --git a/tools/power/cpupower/bindings/python/Makefile b/tools/power/cpupower/bindings/python/Makefile
new file mode 100644
index 000000000000..d0418f902795
--- /dev/null
+++ b/tools/power/cpupower/bindings/python/Makefile
@@ -0,0 +1,31 @@
+# SPDX-License-Identifier: GPL-2.0-only
+# Makefile for libcpupower's Python bindings
+#
+# This Makefile expects you have already run the makefile for cpupower to build
+# the .o files in the lib directory for the bindings to be created.
+
+CC=gcc
+
+LIB_DIR = ../../lib
+BIND_DIR = .
+PY_INCLUDE := $(firstword $(shell python-config --includes))
+#PY_INCLUDE = $(shell python-config --includes | awk '{ print $1 }')
+
+OBJECTS_LIB = $(wildcard $(LIB_DIR)/*.o)
+OBJECTS_BIND = $(wildcard $(BIND_DIR)/*.o)
+
+all: _raw_pylibcpupower.so
+
+_raw_pylibcpupower.so: raw_pylibcpupower_wrap.o
+	$(CC) -shared $(OBJECTS_LIB) raw_pylibcpupower_wrap.o -o _raw_pylibcpupower.so # raw_pylibcpupower_wrap.o
+#	$(CC) -shared $(OBJECTS_BIND) $(OBJECTS_LIB) -o _raw_pylibcpupower.so # raw_pylibcpupower_wrap.o
+
+raw_pylibcpupower_wrap.o: raw_pylibcpupower_wrap.c
+	$(CC) -fPIC -c raw_pylibcpupower_wrap.c $(PY_INCLUDE)
+
+raw_pylibcpupower_wrap.c: raw_pylibcpupower.i
+	swig -python raw_pylibcpupower.i
+
+# Will only clean the bindings folder; will not clean the actual cpupower folder
+clean:
+	rm -f raw_pylibcpupower.py raw_pylibcpupower_wrap.c raw_pylibcpupower_wrap.o _raw_pylibcpupower.so
diff --git a/tools/power/cpupower/bindings/python/README b/tools/power/cpupower/bindings/python/README
new file mode 100644
index 000000000000..0a4bb2581e8a
--- /dev/null
+++ b/tools/power/cpupower/bindings/python/README
@@ -0,0 +1,59 @@
+This folder contains the necessary files to build the Python bindings for
+libcpupower (aside from the libcpupower object files).
+
+
+requirements
+------------
+
+* You need the object files in the libcpupower directory compiled by
+cpupower's makefile.
+* The SWIG program must be installed.
+* The Python's development libraries installed.
+
+Please check that your version of SWIG is compatible with the version of Python
+installed on your machine by checking the SWIG changelog on their website.
+https://swig.org/
+
+Note that while SWIG itself is GPL v3+ licensed; the resulting output,
+the bindings code: is permissively licensed + the license of libcpupower's .o
+files. For these bindings that means GPL v2.
+
+Please see https://swig.org/legal.html and the discussion [1] for more details.
+
+[1]
+https://lore.kernel.org/linux-pm/Zqv9BOjxLAgyNP5B@hatbackup/
+
+
+build
+-----
+
+Install SWIG and the Python development files provided by your distribution.
+
+Build the object files for libcpupower by running make in the cpupower
+directory.
+
+Return to the directory this README is in to run:
+
+$ make
+
+
+testing
+-------
+
+Please verify the _raw_pylibcpupower.so and raw_pylibcpupower.py files have
+been created.
+
+To run the test script:
+
+$ python test_raw_pylibcpupower.py
+
+
+credits
+-------
+
+Original Bindings Author:
+John B. Wyatt IV
+jwyatt@redhat.com
+sageofredondo@gmail.com
+
+Copyright (C) 2024 Red Hat
diff --git a/tools/power/cpupower/bindings/python/raw_pylibcpupower.i b/tools/power/cpupower/bindings/python/raw_pylibcpupower.i
new file mode 100644
index 000000000000..96556d87a745
--- /dev/null
+++ b/tools/power/cpupower/bindings/python/raw_pylibcpupower.i
@@ -0,0 +1,247 @@
+/* SPDX-License-Identifier: GPL-2.0-only */
+
+%module raw_pylibcpupower
+%{
+#include "../../lib/cpupower_intern.h"
+#include "../../lib/acpi_cppc.h"
+#include "../../lib/cpufreq.h"
+#include "../../lib/cpuidle.h"
+#include "../../lib/cpupower.h"
+#include "../../lib/powercap.h"
+%}
+
+/*
+ * cpupower_intern.h
+ */
+
+#define PATH_TO_CPU "/sys/devices/system/cpu/"
+#define MAX_LINE_LEN 4096
+#define SYSFS_PATH_MAX 255
+
+int is_valid_path(const char *path);
+
+unsigned int cpupower_read_sysfs(const char *path, char *buf, size_t buflen);
+
+unsigned int cpupower_write_sysfs(const char *path, char *buf, size_t buflen);
+
+/*
+ * acpi_cppc.h
+ */
+
+enum acpi_cppc_value {
+	HIGHEST_PERF,
+	LOWEST_PERF,
+	NOMINAL_PERF,
+	LOWEST_NONLINEAR_PERF,
+	LOWEST_FREQ,
+	NOMINAL_FREQ,
+	REFERENCE_PERF,
+	WRAPAROUND_TIME,
+	MAX_CPPC_VALUE_FILES
+};
+
+unsigned long acpi_cppc_get_data(unsigned int cpu,
+				 enum acpi_cppc_value which);
+
+/*
+ * cpufreq.h
+ */
+
+struct cpufreq_policy {
+	unsigned long min;
+	unsigned long max;
+	char *governor;
+};
+
+struct cpufreq_available_governors {
+	char *governor;
+	struct cpufreq_available_governors *next;
+	struct cpufreq_available_governors *first;
+};
+
+struct cpufreq_available_frequencies {
+	unsigned long frequency;
+	struct cpufreq_available_frequencies *next;
+	struct cpufreq_available_frequencies *first;
+};
+
+
+struct cpufreq_affected_cpus {
+	unsigned int cpu;
+	struct cpufreq_affected_cpus *next;
+	struct cpufreq_affected_cpus *first;
+};
+
+struct cpufreq_stats {
+	unsigned long frequency;
+	unsigned long long time_in_state;
+	struct cpufreq_stats *next;
+	struct cpufreq_stats *first;
+};
+
+unsigned long cpufreq_get_freq_kernel(unsigned int cpu);
+
+unsigned long cpufreq_get_freq_hardware(unsigned int cpu);
+
+#define cpufreq_get(cpu) cpufreq_get_freq_kernel(cpu);
+
+unsigned long cpufreq_get_transition_latency(unsigned int cpu);
+
+int cpufreq_get_hardware_limits(unsigned int cpu,
+				unsigned long *min,
+				unsigned long *max);
+
+char *cpufreq_get_driver(unsigned int cpu);
+
+void cpufreq_put_driver(char *ptr);
+
+struct cpufreq_policy *cpufreq_get_policy(unsigned int cpu);
+
+void cpufreq_put_policy(struct cpufreq_policy *policy);
+
+struct cpufreq_available_governors
+*cpufreq_get_available_governors(unsigned int cpu);
+
+void cpufreq_put_available_governors(
+	struct cpufreq_available_governors *first);
+
+struct cpufreq_available_frequencies
+*cpufreq_get_available_frequencies(unsigned int cpu);
+
+void cpufreq_put_available_frequencies(
+		struct cpufreq_available_frequencies *first);
+
+struct cpufreq_available_frequencies
+*cpufreq_get_boost_frequencies(unsigned int cpu);
+
+void cpufreq_put_boost_frequencies(
+		struct cpufreq_available_frequencies *first);
+
+struct cpufreq_affected_cpus *cpufreq_get_affected_cpus(unsigned
+							int cpu);
+
+void cpufreq_put_affected_cpus(struct cpufreq_affected_cpus *first);
+
+struct cpufreq_affected_cpus *cpufreq_get_related_cpus(unsigned
+							int cpu);
+
+void cpufreq_put_related_cpus(struct cpufreq_affected_cpus *first);
+
+struct cpufreq_stats *cpufreq_get_stats(unsigned int cpu,
+					unsigned long long *total_time);
+
+void cpufreq_put_stats(struct cpufreq_stats *stats);
+
+unsigned long cpufreq_get_transitions(unsigned int cpu);
+
+int cpufreq_set_policy(unsigned int cpu, struct cpufreq_policy *policy);
+
+int cpufreq_modify_policy_min(unsigned int cpu, unsigned long min_freq);
+
+int cpufreq_modify_policy_max(unsigned int cpu, unsigned long max_freq);
+
+int cpufreq_modify_policy_governor(unsigned int cpu, char *governor);
+
+int cpufreq_set_frequency(unsigned int cpu,
+				unsigned long target_frequency);
+
+unsigned long cpufreq_get_sysfs_value_from_table(unsigned int cpu,
+						 const char **table,
+						 unsigned int index,
+						 unsigned int size);
+
+/*
+ * cpuidle.h
+ */
+
+int cpuidle_is_state_disabled(unsigned int cpu,
+				       unsigned int idlestate);
+int cpuidle_state_disable(unsigned int cpu, unsigned int idlestate,
+				   unsigned int disable);
+unsigned long cpuidle_state_latency(unsigned int cpu,
+						unsigned int idlestate);
+unsigned long cpuidle_state_usage(unsigned int cpu,
+					unsigned int idlestate);
+unsigned long long cpuidle_state_time(unsigned int cpu,
+						unsigned int idlestate);
+char *cpuidle_state_name(unsigned int cpu,
+				unsigned int idlestate);
+char *cpuidle_state_desc(unsigned int cpu,
+				unsigned int idlestate);
+unsigned int cpuidle_state_count(unsigned int cpu);
+
+char *cpuidle_get_governor(void);
+
+char *cpuidle_get_driver(void);
+
+/*
+ * cpupower.h
+ */
+
+struct cpupower_topology {
+	/* Amount of CPU cores, packages and threads per core in the system */
+	unsigned int cores;
+	unsigned int pkgs;
+	unsigned int threads; /* per core */
+
+	/* Array gets mallocated with cores entries, holding per core info */
+	struct cpuid_core_info *core_info;
+};
+
+struct cpuid_core_info {
+	int pkg;
+	int core;
+	int cpu;
+
+	/* flags */
+	unsigned int is_online:1;
+};
+
+int get_cpu_topology(struct cpupower_topology *cpu_top);
+
+void cpu_topology_release(struct cpupower_topology cpu_top);
+
+int cpupower_is_cpu_online(unsigned int cpu);
+
+/*
+ * powercap.h
+ */
+
+struct powercap_zone {
+	char name[MAX_LINE_LEN];
+	/*
+	 * sys_name relative to PATH_TO_POWERCAP,
+	 * do not forget the / in between
+	 */
+	char sys_name[SYSFS_PATH_MAX];
+	int tree_depth;
+	struct powercap_zone *parent;
+	struct powercap_zone *children[POWERCAP_MAX_CHILD_ZONES];
+	/* More possible caps or attributes to be added? */
+	uint32_t has_power_uw:1,
+		 has_energy_uj:1;
+
+};
+
+int powercap_walk_zones(struct powercap_zone *zone,
+			int (*f)(struct powercap_zone *zone));
+
+struct powercap_zone *powercap_init_zones(void);
+
+int powercap_get_enabled(int *mode);
+
+int powercap_set_enabled(int mode);
+
+int powercap_get_driver(char *driver, int buflen);
+
+int powercap_get_max_energy_range_uj(struct powercap_zone *zone, uint64_t *val);
+
+int powercap_get_energy_uj(struct powercap_zone *zone, uint64_t *val);
+
+int powercap_get_max_power_range_uw(struct powercap_zone *zone, uint64_t *val);
+
+int powercap_get_power_uw(struct powercap_zone *zone, uint64_t *val);
+
+int powercap_zone_get_enabled(struct powercap_zone *zone, int *mode);
+
+int powercap_zone_set_enabled(struct powercap_zone *zone, int mode);
-- 
2.46.0


