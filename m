Return-Path: <linux-pm+bounces-11377-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 6DBA093B913
	for <lists+linux-pm@lfdr.de>; Thu, 25 Jul 2024 00:14:20 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 19D92284318
	for <lists+linux-pm@lfdr.de>; Wed, 24 Jul 2024 22:14:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3174A13E881;
	Wed, 24 Jul 2024 22:14:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="TqQf+X1g"
X-Original-To: linux-pm@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6262013B5AE
	for <linux-pm@vger.kernel.org>; Wed, 24 Jul 2024 22:14:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721859242; cv=none; b=pl6dUb8+6LZshxHTqjVQ8hqQXyvK43weZCPmw3NIlqtuK0qT3PgY6YK6SoNuptexI4crq/OW8hCDcsdl86D9J2JUHUykCrWGh39ZwbPVbgIzcBofCD+TFGotUvK60A8ioaKZlkcwgcMoBTWNGDm+znwoTOGjCn4Uri1eL+rntBc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721859242; c=relaxed/simple;
	bh=rdxqSma22UUNhO8GRP1xfHjICj9ttsvc4m76NncJc0k=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Q1WZhzOKOkJzV39dv6NFfhmPHkWwfyryGdB8X0Y/keqnk32sDkLB0iwukLaKAOgR4SKZl/3KL2ezVAZDAh6/wbDRQBWZgGldxsJw9GePIxhMhI8aS0Vyl6G4VY708dAkAkKurDgws6zzyn+YNkYw0Cf3VxEbABP/C7CyvmXOk4c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=TqQf+X1g; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1721859239;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=ZZDN0EpYdGH4QTVcef68WhZG9zzbZoHSE92tNxLJUpI=;
	b=TqQf+X1gB9zzACYY4/yWHQPii474gf+wFX9zCu6ywtXvmksoUgE5fbNEOmvt79isV67JWm
	UUZjpO3Rz4+7YaD9Xhvv1HMa/EGUVyaCCpHDyN87hn4lCKMWs5o2kWrVegHvH70oDM/YXA
	pkOo0029JDe50+iMsy9doxXPVAOSYDw=
Received: from mail-vs1-f70.google.com (mail-vs1-f70.google.com
 [209.85.217.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-376-bx1wUlTUPWmuYHuLJDn4AA-1; Wed, 24 Jul 2024 18:13:58 -0400
X-MC-Unique: bx1wUlTUPWmuYHuLJDn4AA-1
Received: by mail-vs1-f70.google.com with SMTP id ada2fe7eead31-4929b9c17feso113626137.3
        for <linux-pm@vger.kernel.org>; Wed, 24 Jul 2024 15:13:55 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1721859234; x=1722464034;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=ZZDN0EpYdGH4QTVcef68WhZG9zzbZoHSE92tNxLJUpI=;
        b=ZoeWF2y0sJd7t967iNfM/EQmgEoTsIMPqcB4XenCNz16c7IefylgfrXAgLnptG3Q25
         yrEhzuZJBCRT+2k17HzcSnXPrSj52a4laEmZtZIcTNTmsYTy9Ya425qhsGUOV+fvoeGF
         OtSVK3tL2VCm+ujocGNxJL4zY8ezgOZ5tpZYOuTF+91PdTHhJBJRsOkTWP3u5aSLmUaT
         WTnksQJhfmfQxLT6QnWo2q9h/+3GHNS7t0i+8x4QWv8s2inylsIVPYXJfNCPid4U6u/r
         5c/lV4ric4kuYKjnwt6EeQpXk083qe0rSKdCch5ew8cF05q+TJArgyPjP7rQjIXnWAkX
         g9SQ==
X-Gm-Message-State: AOJu0YzM3b6Ocy61AtPviVgrPkj17ogyX9fFt3AXg2LDq49T85YzoF2I
	rz9lbHtPZqsTZbKrYAoHuJNDl/7/G0urZX8P/TB+DMvPrWF6ujpL9sJ4i+oU+ww5Cs8rCMhaOYd
	0yWX0jVe0Ptnrr6t7vh9hCO5o1f/iwEezoqzGYgLfe1CqaIcCoJqWWeQvvuDIfQKxswOG4GroLx
	pNXJWqljBWkTePS+O2sHshyqBmMzoKz+zYF3xOZeLP
X-Received: by 2002:a05:6102:2c86:b0:492:8dbc:c1c with SMTP id ada2fe7eead31-493d9aceda8mr167990137.16.1721859233698;
        Wed, 24 Jul 2024 15:13:53 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IFcd3gUwhhsm4W+Vb5EQ8SWvV970VSd0d0iC1pmnTuNlKfecuyjyVo3PW17Zk2UTrUJmcQwlg==
X-Received: by 2002:a05:6102:2c86:b0:492:8dbc:c1c with SMTP id ada2fe7eead31-493d9aceda8mr167960137.16.1721859233335;
        Wed, 24 Jul 2024 15:13:53 -0700 (PDT)
Received: from hatbackup.redhat.com ([71.217.44.209])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-7a1d7435227sm7542685a.82.2024.07.24.15.13.52
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 24 Jul 2024 15:13:53 -0700 (PDT)
From: "John B. Wyatt IV" <jwyatt@redhat.com>
To: linux-pm@vger.kernel.org,
	"Thomas Renninger" <trenn@suse.com>,
	"Shuah Khan" <shuah@kernel.org>,
	"Shuah Khan" <skhan@linuxfoundation.org>
Cc: "John B. Wyatt IV" <jwyatt@redhat.com>,
	linux-kernel@vger.kernel.org,
	"John Kacur" <jkacur@redhat.com>,
	"Tomas Glozar" <tglozar@redhat.com>,
	"John B. Wyatt IV" <sageofredondo@gmail.com>
Subject: [PATCH 1/2] Add SWIG bindings files for libcpupower
Date: Wed, 24 Jul 2024 18:11:19 -0400
Message-ID: <20240724221122.54601-2-jwyatt@redhat.com>
X-Mailer: git-send-email 2.45.2
In-Reply-To: <20240724221122.54601-1-jwyatt@redhat.com>
References: <20240724221122.54601-1-jwyatt@redhat.com>
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

A latter commit will demonstrate taking a SWIG .i file and
the libcpupower object files to generate the bindings.

Note that while SWIG itself is GPL v3+ licensed; the resulting output,
the bindings code, is permissively licensed. Please see
https://swig.org/legal.html for more details.

Signed-off-by: John B. Wyatt IV <jwyatt@redhat.com>
Signed-off-by: John B. Wyatt IV <sageofredondo@gmail.com>
---
 .../power/cpupower/bindings/python/.gitignore |  8 ++++
 tools/power/cpupower/bindings/python/Makefile | 31 +++++++++++++
 tools/power/cpupower/bindings/python/README   | 33 ++++++++++++++
 .../bindings/python/raw_pylibcpupower.i       | 45 +++++++++++++++++++
 4 files changed, 117 insertions(+)
 create mode 100644 tools/power/cpupower/bindings/python/.gitignore
 create mode 100644 tools/power/cpupower/bindings/python/Makefile
 create mode 100644 tools/power/cpupower/bindings/python/README
 create mode 100644 tools/power/cpupower/bindings/python/raw_pylibcpupower.i

diff --git a/tools/power/cpupower/bindings/python/.gitignore b/tools/power/cpupower/bindings/python/.gitignore
new file mode 100644
index 000000000000..b83e0f5e26a0
--- /dev/null
+++ b/tools/power/cpupower/bindings/python/.gitignore
@@ -0,0 +1,8 @@
+# SPDX-License-Identifier: GPL-2.0-only
+__pycache__/
+*.c
+*.o
+*.so
+*.py
+!test_raw_pylibcpupower.py
+!raw_pylibcpupower.i # git keeps ignoring this file
diff --git a/tools/power/cpupower/bindings/python/Makefile b/tools/power/cpupower/bindings/python/Makefile
new file mode 100644
index 000000000000..a6c779333f8d
--- /dev/null
+++ b/tools/power/cpupower/bindings/python/Makefile
@@ -0,0 +1,31 @@
+# SPDX-License-Identifier: GPL-2.0-only
+# Makefile for libcpupower Python bindings
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
index 000000000000..a2663a2d23d1
--- /dev/null
+++ b/tools/power/cpupower/bindings/python/README
@@ -0,0 +1,33 @@
+
+This folder contains the necessary files to build Python bindings for libcpupower.
+
+To begin, first build the object files for libcpupower by running make in
+the cpupower directory.
+
+Next you will need to install SWIG. Using Fedora:
+
+sudo dnf install swig
+
+Please check that your version of SWIG is compatible with the version of
+Python installed on your machine by checking the SWIG changelog on their
+website. https://swig.org/
+
+Then return to the directory this README is in to run:
+
+make
+
+To run the test script:
+
+python test_raw_pylibcpupower.py
+
+Note that while SWIG itself is GPL v3+ licensed; the resulting output,
+the bindings code, is permissively licensed. Please see
+https://swig.org/legal.html for more details.
+
+Original Bindings Author:
+John B. Wyatt IV
+jwyatt@redhat.com
+sageofredondo@gmail.com
+
+Copyright (C) 2024 Red Hat
+
diff --git a/tools/power/cpupower/bindings/python/raw_pylibcpupower.i b/tools/power/cpupower/bindings/python/raw_pylibcpupower.i
new file mode 100644
index 000000000000..9a920ecf1f47
--- /dev/null
+++ b/tools/power/cpupower/bindings/python/raw_pylibcpupower.i
@@ -0,0 +1,45 @@
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
+ * cpuidle.h
+ */
+
+unsigned int cpuidle_state_count(unsigned int cpu);
+int cpuidle_state_disable(unsigned int cpu, unsigned int idlestate, unsigned int disable);
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
+void cpu_topology_release(struct cpupower_topology cpu_top);
+int cpupower_is_cpu_online(unsigned int cpu);
-- 
2.45.2


