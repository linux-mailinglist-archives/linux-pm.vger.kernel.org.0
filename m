Return-Path: <linux-pm+bounces-23520-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 2742CA50D14
	for <lists+linux-pm@lfdr.de>; Wed,  5 Mar 2025 22:09:34 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 5F48E3AE247
	for <lists+linux-pm@lfdr.de>; Wed,  5 Mar 2025 21:09:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D634C1F8677;
	Wed,  5 Mar 2025 21:09:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="FDk/aM1a"
X-Original-To: linux-pm@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EF9E0255E54
	for <linux-pm@vger.kernel.org>; Wed,  5 Mar 2025 21:09:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741208961; cv=none; b=sckc/doYvi6rmYNcsMhZA070O+cJpCb9DvZoWx5L8E9blDFOITsGnd9m1XyCp0whZxUrUKI6qLYEEeu6vWNVata1cAjMYszv8ZQteA7y4LuAWQJaMrr8usfMp3LA2UtN4p2JhM2+e2QtJHP+TOO0Rs6PytuxztBXRam0b39lxFk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741208961; c=relaxed/simple;
	bh=5MzVbm/LAs+F+H+zTiCF4O9dBTGD8VIrr8mu5CUmgEI=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=UARd2qwof1gSAD3yGzHSRQZmkXGCpVy7pKo9wMxxHSQ21HRVao3eqVC9Wp6MskJeY62Q7C+5GxJvFP9HZrhuGz+hOrMxYm/GNjFG2gXqnzmvOkt89QXSmXny/zl6/RcqOPTAbKhsLXw6bSQcXJXr2UkPY2aCZ/8HSM/kN5pZJ2M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=FDk/aM1a; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1741208957;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding;
	bh=KHKt2zEc/QTV6k6F5DybCuz0karApHeXVJ670H4cwRE=;
	b=FDk/aM1alh33sTwDAxp9cNw4+IBIrhq/JCLm8em98AOuct3YPvR+oze0B7rwmpqVlEO0Gh
	PxPDHTlKBcKw93IhwWo4fKRQd7rZREq1A0CGhKAVam2x/6Xxm5dKsFsNizy4fuoqQVy0QN
	3asW/jKY6qteIFmQLNV8YPELHXlFiqA=
Received: from mail-qk1-f197.google.com (mail-qk1-f197.google.com
 [209.85.222.197]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-542-C8J4QZJIN0q-dSgkpNQ_Hg-1; Wed, 05 Mar 2025 16:09:11 -0500
X-MC-Unique: C8J4QZJIN0q-dSgkpNQ_Hg-1
X-Mimecast-MFC-AGG-ID: C8J4QZJIN0q-dSgkpNQ_Hg_1741208951
Received: by mail-qk1-f197.google.com with SMTP id af79cd13be357-7c0c1025adbso1802097085a.1
        for <linux-pm@vger.kernel.org>; Wed, 05 Mar 2025 13:09:11 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1741208951; x=1741813751;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=KHKt2zEc/QTV6k6F5DybCuz0karApHeXVJ670H4cwRE=;
        b=lT4hAxOZgJjLa8K/zSnd8Au735BfcBq046dVxWD0btzj2jMNuOI/SCiH1XpLv595z7
         hiJbJHwndjwNw/dEh1Bsnvbh0Vi32BEsnqdl1LtDdQ1WzPOh1POGuZ6rp6hyqnIAL9B1
         TONG+q9TT9BQmuDss6QaFTtldV0bo8eGwADzM//iXOL02u+4SCeVI6jd/LuvukSwTkWE
         hNBtZK0Jq/mQY7G1VDoawV47VPyFNuI5w6Z2vqpycu2PQZPhS0VMcxUzPzOdrnSGVZwT
         WIfjA1PWcFyTCczfvk+0WuqmgVKexJEkqDe+i1Ar4hlU5ULkvvNXnOnhbLAjrxuzYVVb
         n05g==
X-Forwarded-Encrypted: i=1; AJvYcCWGTLeaUAUwUduduWKT09nDZWaSvDFakhArIE6O+05Elcsjx66LIiN6Zimxj9hF+JrqA0MbW5H2tw==@vger.kernel.org
X-Gm-Message-State: AOJu0YxUHkWvPc8I02ACLs0veIZ0ymFGC/TJiT51P0O2nFa1h1yh5a2A
	HFNIrEvsmQnJnM/9k1gzbhmwYhdJZEs0NPJq7pXoVNdPNgffgcu9U2Vd+YbjL0xgBBdRsydta+N
	F/rb3w4khWIlSESzdtmX+01IPZIAF4pZFfhvixhExuvStUlcRz7NgZaAd
X-Gm-Gg: ASbGncsHJFkECxrf+gVbNwo3uJz9DY41w9EknC/RRR6CSNxQVZ8gt0Se+387g8CYqbI
	R68kCej4g+4fTomP0+AIaLgCyqycOeRu5nD2MtbAWta5iKjLxsJ9QVfd63EHQrazkLRkBun3jOm
	KMJ95HFV89JN6EwuNdhp8EGXu53E/DsGQB/et2CJf7Yv5hV4r/N9VvMHvJQ+x6nzUJbAXC5g6GZ
	TYiKCLIC68w0SiWzHs1APG3YII3KY09yq37L5lhg0OchUx7cFQ6naRhJHpd1WZ4PeWBC0OPzn9B
	cvkAdfRpqScMCgPQSoQalhovDw==
X-Received: by 2002:a05:620a:600a:b0:7c3:c0ba:1774 with SMTP id af79cd13be357-7c3d8e60945mr611979585a.26.1741208950931;
        Wed, 05 Mar 2025 13:09:10 -0800 (PST)
X-Google-Smtp-Source: AGHT+IGyMFtn/n214bpFuEQ+36CWAhQsMYLMHYXkXKm2ZX2CJdRQZDCOBv7Dcf40n39WDjiuw5LzxA==
X-Received: by 2002:a05:620a:600a:b0:7c3:c0ba:1774 with SMTP id af79cd13be357-7c3d8e60945mr611975385a.26.1741208950506;
        Wed, 05 Mar 2025 13:09:10 -0800 (PST)
Received: from thinkpad2024.redhat.com ([71.217.65.43])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-7c3de6a993csm89635585a.95.2025.03.05.13.09.09
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 05 Mar 2025 13:09:10 -0800 (PST)
From: "John B. Wyatt IV" <jwyatt@redhat.com>
To: Shuah Khan <skhan@linuxfoundation.org>,
	Thomas Renninger <trenn@suse.com>
Cc: "John B. Wyatt IV" <jwyatt@redhat.com>,
	linux-pm@vger.kernel.org,
	Shuah Khan <shuah@kernel.org>,
	"Rafael J. Wysocki" <rafael@kernel.org>,
	linux-kernel@vger.kernel.org,
	John Kacur <jkacur@redhat.com>,
	"John B. Wyatt IV" <sageofredondo@gmail.com>
Subject: [PATCH] cpupower: Implement CPU physical core querying
Date: Wed,  5 Mar 2025 16:08:59 -0500
Message-ID: <20250305210901.24177-1-jwyatt@redhat.com>
X-Mailer: git-send-email 2.48.1
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

This patch is also an issue report. get_cpu_topology will always save
into cpupower_topology a cores size of 0. The code to handle this looks
like it was commented out, and what is commented out is missing a curly
bracket.

https://elixir.bootlin.com/linux/v6.13.5/source/tools/power/cpupower/lib/cpupower.c#L206-L212

Inspiration was taken from psutil to implement this by querying
core_cpu_list. Instead of using a hashmap, I used a sorted array, and
counted the number of valid unique strings. The counting of this takes
place before the qsort for .pkg as the following code says it is
dependent on the order of that sort.

The previous code claimed Intel CPUs are not numbered correctly. I was
not able to reproduce that issue and removed that comment and the code.

This commit was tested with the libcpupower SWIG Python bindings and
performed correctly on 4 different setups. The most notable is the
Framework Intel laptop; a hybrid system of 4 P cores (8 threads) and 8 E
cores (8 threads).

The 4 setups: A 4 core virt-manager VM running Fedora 41 4c/4t (specs not
listed) was tested as a sanity test for VMs. A Lenovo Ryzen 7 Pro 7840HS
8c/16t. A Supermico Intel(R) Xeon(R) Gold 6330 CPU w/ 56c/112t with 2 CPU
sockets. A Framework 12th Gen Intel(R) Core(TM) i5-1240P with hybrid
cores.

CPU(s):                   16
  On-line CPU(s) list:    0-15
Vendor ID:                AuthenticAMD
  Model name:             AMD Ryzen 7 PRO 7840HS w/ Radeon 780M Graphics
    CPU family:           25
    Model:                116
    Thread(s) per core:   2
    Core(s) per socket:   8
    Socket(s):            1
    Stepping:             1

CPU(s):                   112
  On-line CPU(s) list:    0-111
Vendor ID:                GenuineIntel
  BIOS Vendor ID:         Intel(R) Corporation
  Model name:             Intel(R) Xeon(R) Gold 6330 CPU @ 2.00GHz
    BIOS Model name:      Intel(R) Xeon(R) Gold 6330 CPU @ 2.00GHz  CPU @ 2.0GHz
    BIOS CPU family:      179
    CPU family:           6
    Model:                106
    Thread(s) per core:   2
    Core(s) per socket:   28
    Socket(s):            2
    Stepping:             6

CPU(s):                   16
  On-line CPU(s) list:    0-15
Vendor ID:                GenuineIntel
  Model name:             12th Gen Intel(R) Core(TM) i5-1240P
    CPU family:           6
    Model:                154
    Thread(s) per core:   2
    Core(s) per socket:   12
    Socket(s):            1
    Stepping:             3

Signed-off-by: "John B. Wyatt IV" <jwyatt@redhat.com>
Signed-off-by: "John B. Wyatt IV" <sageofredondo@gmail.com>
---
 tools/power/cpupower/lib/cpupower.c | 48 ++++++++++++++++++++++++-----
 tools/power/cpupower/lib/cpupower.h |  3 ++
 2 files changed, 43 insertions(+), 8 deletions(-)

diff --git a/tools/power/cpupower/lib/cpupower.c b/tools/power/cpupower/lib/cpupower.c
index 7a2ef691b20e..ce8dfb8e46ab 100644
--- a/tools/power/cpupower/lib/cpupower.c
+++ b/tools/power/cpupower/lib/cpupower.c
@@ -10,6 +10,7 @@
 #include <stdio.h>
 #include <errno.h>
 #include <stdlib.h>
+#include <string.h>
 
 #include "cpupower.h"
 #include "cpupower_intern.h"
@@ -150,15 +151,25 @@ static int __compare(const void *t1, const void *t2)
 		return 0;
 }
 
+static int __compare_core_cpu_list(const void *t1, const void *t2)
+{
+	struct cpuid_core_info *top1 = (struct cpuid_core_info *)t1;
+	struct cpuid_core_info *top2 = (struct cpuid_core_info *)t2;
+
+	return strcmp(top1->core_cpu_list, top2->core_cpu_list);
+}
+
 /*
  * Returns amount of cpus, negative on error, cpu_top must be
  * passed to cpu_topology_release to free resources
  *
- * Array is sorted after ->pkg, ->core, then ->cpu
+ * Array is sorted after ->cpu_smt_list ->pkg, ->core
  */
 int get_cpu_topology(struct cpupower_topology *cpu_top)
 {
 	int cpu, last_pkg, cpus = sysconf(_SC_NPROCESSORS_CONF);
+	char path[SYSFS_PATH_MAX];
+	char *last_cpu_list;
 
 	cpu_top->core_info = malloc(sizeof(struct cpuid_core_info) * cpus);
 	if (cpu_top->core_info == NULL)
@@ -183,6 +194,34 @@ int get_cpu_topology(struct cpupower_topology *cpu_top)
 			cpu_top->core_info[cpu].core = -1;
 			continue;
 		}
+		if (cpu_top->core_info[cpu].core == -1) {
+			strncpy(cpu_top->core_info[cpu].core_cpu_list, "-1", CPULIST_BUFFER);
+			continue;
+		}
+		snprintf(path, sizeof(path), PATH_TO_CPU "cpu%u/topology/%s",
+			 cpu, "core_cpus_list");
+		if (cpupower_read_sysfs(
+			path,
+			cpu_top->core_info[cpu].core_cpu_list,
+			CPULIST_BUFFER) < 1) {
+			printf("Warning CPU%u has a 0 size core_cpus_list string", cpu);
+		}
+	}
+
+	/* Count the number of distinct cpu lists to get the physical core
+	 * count.
+	 */
+	qsort(cpu_top->core_info, cpus, sizeof(struct cpuid_core_info),
+	      __compare_core_cpu_list);
+
+	last_cpu_list = cpu_top->core_info[0].core_cpu_list;
+	cpu_top->cores = 1;
+	for (cpu = 1; cpu < cpus; cpu++) {
+		if (strcmp(cpu_top->core_info[cpu].core_cpu_list, last_cpu_list) != 0 &&
+		    cpu_top->core_info[cpu].pkg != -1) {
+			last_cpu_list = cpu_top->core_info[cpu].core_cpu_list;
+			cpu_top->cores++;
+		}
 	}
 
 	qsort(cpu_top->core_info, cpus, sizeof(struct cpuid_core_info),
@@ -203,13 +242,6 @@ int get_cpu_topology(struct cpupower_topology *cpu_top)
 	if (!(cpu_top->core_info[0].pkg == -1))
 		cpu_top->pkgs++;
 
-	/* Intel's cores count is not consecutively numbered, there may
-	 * be a core_id of 3, but none of 2. Assume there always is 0
-	 * Get amount of cores by counting duplicates in a package
-	for (cpu = 0; cpu_top->core_info[cpu].pkg = 0 && cpu < cpus; cpu++) {
-		if (cpu_top->core_info[cpu].core == 0)
-	cpu_top->cores++;
-	*/
 	return cpus;
 }
 
diff --git a/tools/power/cpupower/lib/cpupower.h b/tools/power/cpupower/lib/cpupower.h
index e4e4292eacec..2e67a080f203 100644
--- a/tools/power/cpupower/lib/cpupower.h
+++ b/tools/power/cpupower/lib/cpupower.h
@@ -2,6 +2,8 @@
 #ifndef __CPUPOWER_CPUPOWER_H__
 #define __CPUPOWER_CPUPOWER_H__
 
+#define CPULIST_BUFFER 5
+
 struct cpupower_topology {
 	/* Amount of CPU cores, packages and threads per core in the system */
 	unsigned int cores;
@@ -16,6 +18,7 @@ struct cpuid_core_info {
 	int pkg;
 	int core;
 	int cpu;
+	char core_cpu_list[CPULIST_BUFFER];
 
 	/* flags */
 	unsigned int is_online:1;
-- 
2.48.1


