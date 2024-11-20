Return-Path: <linux-pm+bounces-17825-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 552B79D3F69
	for <lists+linux-pm@lfdr.de>; Wed, 20 Nov 2024 16:53:56 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id B55CC1F23D12
	for <lists+linux-pm@lfdr.de>; Wed, 20 Nov 2024 15:53:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8F94014601C;
	Wed, 20 Nov 2024 15:53:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="RD609PJX"
X-Original-To: linux-pm@vger.kernel.org
Received: from mail-wm1-f47.google.com (mail-wm1-f47.google.com [209.85.128.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4ECCA145B2E
	for <linux-pm@vger.kernel.org>; Wed, 20 Nov 2024 15:52:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732117981; cv=none; b=DfqF/pHoZPyI1hT/901VFFHgHqM+PGgcYX7YRtwBa1xMYli82eEURehn5uaLG3OXpB1poucoMzr6QybQMPKrkRY9bsgy+V9+uWCDS8hGKRrxoQcyDsy1Rf3eIEMf+l2H7tguZnVK0oQITr96rSGbbgbJdvnAsWUOYne1pMbBDO4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732117981; c=relaxed/simple;
	bh=FNnesGMMQb0tc5nboo/+ESd9TicpF8S6NBEpr9cslng=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=GG3jlLntf5gOwXU7h/3wLcJ42ZiH5Qtd5vOz0bWbRwiisyZVarXC0romPJmWro6Fj82Eis8BfJNnWn7i6LoPkc+aCba2w1rxxM56jFbNZF1JLgN3j8PDQUxRjD4PEga2rqJsNuVgfv/KL3x92J62cbXtgGPSJom62vZWj7JSg+Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=RD609PJX; arc=none smtp.client-ip=209.85.128.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-wm1-f47.google.com with SMTP id 5b1f17b1804b1-4315eac969aso6442135e9.1
        for <linux-pm@vger.kernel.org>; Wed, 20 Nov 2024 07:52:57 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1732117976; x=1732722776; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=XMfKOSolIPFtP/2jfvl4rNgPPHayVOA0ad+l75+iyAA=;
        b=RD609PJX+Xs6mJGl8kegjGKG+BFojn4JDwVX6LScHcJnn12yC4Ls58B3xB8mrM3Ww3
         qbY4Luta8hcUm019ZHoPjZIpll5PennoC0fl+VdJEmayq9BzuHjy+uzgmfrqIaAV3XwF
         C3uKgr50HjQ8luXSNNditMB9MR8xLOVVUJ+xjGQirSZ5q9I9w34+PVabCmf3ewSan8T/
         5GWxYRAxUAz4EzSoAXr/ORg8/GG054R/Yz0uhKzuay55HYT0ubT5PXdfO43aebQ8jp9E
         X97+G3jBT9d4hTE0XFsXIvjAgOOf9w2+G1Myi30kLIyHSsQuu297WUg9IkS8KiDji4uW
         Mk8A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1732117976; x=1732722776;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=XMfKOSolIPFtP/2jfvl4rNgPPHayVOA0ad+l75+iyAA=;
        b=VxOugi9IMrrRKw8wHgC4RjubEotBY5d+gtdN/cSQn45UJdb1fHmXPIYi0+aBQJ7KOv
         h2pciFRmbnvhDT6bziv/McCjPVZeVQpi8EXslYaOhXonjkeo71mIrx7T8st04eH9xXo7
         0zbZ3zzXGyYVxV1r9eyZP5FGzD5ZliF2Rc9r3/A2wYaSDYPiY7Q3MRS+WWH3QoqnB3Qp
         seoCeRA9L0pd7zpFl/UOEsxskacepCnMvqVROERFytCc2AwTezvQYI7Vntx2mOFi3OA8
         qqldqAWYlqn6S8YhxvO+5xkYoWIQ7s3bQPS+zuLkM5YRCoWykn1lexK2Cntev2WdV82R
         6Yzg==
X-Forwarded-Encrypted: i=1; AJvYcCXUzp7w/kdnmGQ78VWO+J3JnyiuzN3T7+2Ug/Hm1WzLAvSylgxPwkSBUaipOIagiG6dTVh5cPgZ7Q==@vger.kernel.org
X-Gm-Message-State: AOJu0YxVhrMaVUNbxAHObeNveE2P3ztsZTPinhanqFDRUlN1Hzs2zJen
	F2n/9tPtEOtm37LQJcj+s2op9QWW8gW/WNkiGU2lfZVIaUrkCGBAynZX5YMG78U=
X-Google-Smtp-Source: AGHT+IF6ZscXg785uja2z2GelqYihpqipd+9E958AyI6nC7aqnt0aCtC7W/Lq6VbG5hoq7cuwr6VFg==
X-Received: by 2002:a05:600c:510d:b0:42c:b603:422 with SMTP id 5b1f17b1804b1-4334762187emr27995855e9.8.1732117976375;
        Wed, 20 Nov 2024 07:52:56 -0800 (PST)
Received: from mai.. (146725694.box.freepro.com. [130.180.211.218])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-433b45d4c68sm22990385e9.22.2024.11.20.07.52.55
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 20 Nov 2024 07:52:55 -0800 (PST)
From: Daniel Lezcano <daniel.lezcano@linaro.org>
To: rafael@kernel.org
Cc: saravanak@google.com,
	arnd@kernel.org,
	linux-pm@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	quic_manafm@quicinc.com
Subject: [RFC 2/2] selftests: Add perf_qos selftests
Date: Wed, 20 Nov 2024 16:52:45 +0100
Message-ID: <20241120155245.1710666-2-daniel.lezcano@linaro.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20241120155245.1710666-1-daniel.lezcano@linaro.org>
References: <20241120155245.1710666-1-daniel.lezcano@linaro.org>
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The performance QoS is a framework to allow the userspace to set the
performance limits of a device which is exported as a char device in
/dev. The performance constraints are set from userspace and their
life cycle is tied with the opened file descriptor and other processes
requesting the same constraint via another instance of the file
descriptor. This kind of non trivial behavior, involving constraint
limits to be enqueued in a sorted list and depending on the process
holding a file descriptor, deserves a set of testing programs.

This patch provides somes tests which depend on a kernel module
creating a dummy performance QoS device. More tests will be added
later.

Signed-off-by: Daniel Lezcano <daniel.lezcano@linaro.org>
---
 lib/Kconfig.debug                             |   9 ++
 lib/Makefile                                  |   1 +
 lib/test_perf_qos.c                           |  69 ++++++++
 tools/include/uapi/linux/perf_qos_ioctl.h     |  47 ++++++
 tools/testing/selftests/Makefile              |   1 +
 tools/testing/selftests/perf_qos/Makefile     |  16 ++
 tools/testing/selftests/perf_qos/get_limits.c |  61 +++++++
 .../testing/selftests/perf_qos/get_set_max.c  |  95 +++++++++++
 .../selftests/perf_qos/get_set_max_forked.c   | 150 ++++++++++++++++++
 .../testing/selftests/perf_qos/get_set_min.c  |  95 +++++++++++
 .../selftests/perf_qos/get_set_min_forked.c   | 150 ++++++++++++++++++
 tools/testing/selftests/perf_qos/get_unit.c   |  46 ++++++
 .../selftests/perf_qos/set_max_forked.c       | 147 +++++++++++++++++
 .../selftests/perf_qos/set_min_forked.c       | 147 +++++++++++++++++
 .../selftests/perf_qos/set_multiple_maxs.c    |  93 +++++++++++
 .../selftests/perf_qos/set_multiple_mins.c    |  87 ++++++++++
 .../perf_qos/set_same_multiple_maxs.c         |  84 ++++++++++
 .../perf_qos/set_same_multiple_mins.c         |  84 ++++++++++
 18 files changed, 1382 insertions(+)
 create mode 100644 lib/test_perf_qos.c
 create mode 100644 tools/include/uapi/linux/perf_qos_ioctl.h
 create mode 100644 tools/testing/selftests/perf_qos/Makefile
 create mode 100644 tools/testing/selftests/perf_qos/get_limits.c
 create mode 100644 tools/testing/selftests/perf_qos/get_set_max.c
 create mode 100644 tools/testing/selftests/perf_qos/get_set_max_forked.c
 create mode 100644 tools/testing/selftests/perf_qos/get_set_min.c
 create mode 100644 tools/testing/selftests/perf_qos/get_set_min_forked.c
 create mode 100644 tools/testing/selftests/perf_qos/get_unit.c
 create mode 100644 tools/testing/selftests/perf_qos/set_max_forked.c
 create mode 100644 tools/testing/selftests/perf_qos/set_min_forked.c
 create mode 100644 tools/testing/selftests/perf_qos/set_multiple_maxs.c
 create mode 100644 tools/testing/selftests/perf_qos/set_multiple_mins.c
 create mode 100644 tools/testing/selftests/perf_qos/set_same_multiple_maxs.c
 create mode 100644 tools/testing/selftests/perf_qos/set_same_multiple_mins.c

diff --git a/lib/Kconfig.debug b/lib/Kconfig.debug
index 7312ae7c3cc5..5b66089d6103 100644
--- a/lib/Kconfig.debug
+++ b/lib/Kconfig.debug
@@ -2585,6 +2585,15 @@ config TEST_FIRMWARE
 
 	  If unsure, say N.
 
+config TEST_PERF_QOS
+	tristate "Create a dummy device for the performance QoS testing"
+	help
+	  This builds the "test_perf_qos" module which creates an
+	  userspace interface for testing the performance QoS API. It
+	  is needed for the performance QoS selftests.
+
+	  If unsure, say N.
+
 config TEST_SYSCTL
 	tristate "sysctl test driver"
 	depends on PROC_SYSCTL
diff --git a/lib/Makefile b/lib/Makefile
index 773adf88af41..72d345071725 100644
--- a/lib/Makefile
+++ b/lib/Makefile
@@ -61,6 +61,7 @@ obj-$(CONFIG_TEST_BPF) += test_bpf.o
 test_dhry-objs := dhry_1.o dhry_2.o dhry_run.o
 obj-$(CONFIG_TEST_DHRY) += test_dhry.o
 obj-$(CONFIG_TEST_FIRMWARE) += test_firmware.o
+obj-$(CONFIG_TEST_PERF_QOS) += test_perf_qos.o
 obj-$(CONFIG_TEST_BITOPS) += test_bitops.o
 CFLAGS_test_bitops.o += -Werror
 obj-$(CONFIG_CPUMASK_KUNIT_TEST) += cpumask_kunit.o
diff --git a/lib/test_perf_qos.c b/lib/test_perf_qos.c
new file mode 100644
index 000000000000..7d1c21f4170d
--- /dev/null
+++ b/lib/test_perf_qos.c
@@ -0,0 +1,69 @@
+// SPDX-License-Identifier: GPL-2.0-only
+/*
+ * Kernel module for testing performance QoS
+ *
+ * Copyright (2024) Linaro Ltd
+ *
+ * Author: Daniel Lezcano <daniel.lezcano@kernel.org>
+ *
+ */
+#include <linux/module.h>
+#include <linux/perf_qos.h>
+
+static struct perf_qos *pq;
+
+static int test_set_perf_limit_min(int limit)
+{
+	static int prev_limit = -1;
+
+	pr_info("Performance minimal limit set to %d->%d\n",
+		prev_limit, limit);
+
+	WARN_ON_ONCE(prev_limit == limit);
+	
+	return 0;
+}
+
+static int test_set_perf_limit_max(int limit)
+{
+	static int prev_limit = -1;
+
+	pr_info("Performance maximal limit set to %d->%d\n",
+		prev_limit, limit);
+
+	WARN_ON_ONCE(prev_limit == limit);
+
+	return 0;
+}
+
+static int __init test_perf_qos_init(void)
+{
+	struct perf_qos_ops ops = {
+		.set_perf_limit_max = test_set_perf_limit_max,
+		.set_perf_limit_min = test_set_perf_limit_min,
+	};
+
+	struct perf_qos_value_descr descr = {
+		.unit = PERF_QOS_UNIT_NORMAL,
+		.limit_min = 0,
+		.limit_max = 1024,
+	};
+	
+	pq = perf_qos_device_create("dummy", &ops, &descr);
+	if (IS_ERR(pq))
+		return PTR_ERR(pq);
+
+	return 0;
+}
+
+static void __exit test_perf_qos_exit(void)
+{
+	perf_qos_device_destroy(pq);
+}
+
+module_init(test_perf_qos_init);
+module_exit(test_perf_qos_exit);
+
+MODULE_AUTHOR("Daniel Lezcano <daniel.lezcano@kernel.org>");
+MODULE_DESCRIPTION("Kernel module for testing the performance QoS");
+MODULE_LICENSE("GPL");
diff --git a/tools/include/uapi/linux/perf_qos_ioctl.h b/tools/include/uapi/linux/perf_qos_ioctl.h
new file mode 100644
index 000000000000..a9fb8940c175
--- /dev/null
+++ b/tools/include/uapi/linux/perf_qos_ioctl.h
@@ -0,0 +1,47 @@
+/* SPDX-License-Identifier: LGPL-2.0+ WITH Linux-syscall-note */
+/*
+ * Performance QoS device abstraction
+ *
+ * Copyright (2024) Linaro Ltd
+ *
+ * Author: Daniel Lezcano <daniel.lezcano@linaro.org>
+ *
+ */
+#ifndef __PERF_QOS_IOCTL_H
+#define __PERF_QOS_IOCTL_H
+
+#include <linux/types.h>
+
+enum {
+	PERF_QOS_IOC_SET_MIN_CMD,
+	PERF_QOS_IOC_GET_MIN_CMD,
+	PERF_QOS_IOC_SET_MAX_CMD,
+	PERF_QOS_IOC_GET_MAX_CMD,
+	PERF_QOS_IOC_GET_UNIT_CMD,
+	PERF_QOS_IOC_GET_LIMITS_CMD,
+	PERF_QOS_IOC_MAX_CMD,
+};
+
+typedef enum {
+	PERF_QOS_UNIT_NORMAL,
+	PERF_QOS_UNIT_KBPS,
+	PERF_QOS_UNIT_MAX
+} perf_qos_unit_t;
+
+struct perf_qos_ioctl_arg {
+	int value;
+	int limit_min;
+	int limit_max;
+	perf_qos_unit_t unit;
+};
+
+#define PERF_QOS_IOCTL_TYPE 'P'
+
+#define PERF_QOS_IOC_SET_MIN	_IOW(PERF_QOS_IOCTL_TYPE, PERF_QOS_IOC_SET_MIN_CMD,	struct perf_qos_ioctl_arg *)
+#define PERF_QOS_IOC_GET_MIN	_IOR(PERF_QOS_IOCTL_TYPE, PERF_QOS_IOC_GET_MIN_CMD,	struct perf_qos_ioctl_arg *)
+#define PERF_QOS_IOC_SET_MAX	_IOW(PERF_QOS_IOCTL_TYPE, PERF_QOS_IOC_SET_MAX_CMD,	struct perf_qos_ioctl_arg *)
+#define PERF_QOS_IOC_GET_MAX	_IOR(PERF_QOS_IOCTL_TYPE, PERF_QOS_IOC_GET_MAX_CMD,	struct perf_qos_ioctl_arg *)
+#define PERF_QOS_IOC_GET_UNIT	_IOR(PERF_QOS_IOCTL_TYPE, PERF_QOS_IOC_GET_UNIT_CMD,	struct perf_qos_ioctl_arg *)
+#define PERF_QOS_IOC_GET_LIMITS	_IOR(PERF_QOS_IOCTL_TYPE, PERF_QOS_IOC_GET_LIMITS_CMD,	struct perf_qos_ioctl_arg *)
+
+#endif
diff --git a/tools/testing/selftests/Makefile b/tools/testing/selftests/Makefile
index 363d031a16f7..d6f3706443c6 100644
--- a/tools/testing/selftests/Makefile
+++ b/tools/testing/selftests/Makefile
@@ -73,6 +73,7 @@ TARGETS += net/rds
 TARGETS += net/tcp_ao
 TARGETS += nsfs
 TARGETS += perf_events
+TARGETS += perf_qos
 TARGETS += pidfd
 TARGETS += pid_namespace
 TARGETS += power_supply
diff --git a/tools/testing/selftests/perf_qos/Makefile b/tools/testing/selftests/perf_qos/Makefile
new file mode 100644
index 000000000000..279a2bce1b82
--- /dev/null
+++ b/tools/testing/selftests/perf_qos/Makefile
@@ -0,0 +1,16 @@
+# SPDX-License-Identifier: GPL-2.0
+
+TEST_GEN_PROGS = get_unit get_limits
+TEST_GEN_PROGS += get_set_min get_set_max
+TEST_GEN_PROGS += get_set_min_forked get_set_max_forked
+TEST_GEN_PROGS += set_min_forked set_max_forked
+TEST_GEN_PROGS += set_multiple_mins set_multiple_maxs
+TEST_GEN_PROGS += set_same_multiple_mins set_same_multiple_maxs
+
+include ../lib.mk
+
+TOOLSDIR := $(top_srcdir)/tools
+TOOLSINCDIR := $(TOOLSDIR)/include
+APIDIR := $(TOOLSINCDIR)/uapi
+
+CFLAGS += -Wall -O2 -I$(APIDIR)
diff --git a/tools/testing/selftests/perf_qos/get_limits.c b/tools/testing/selftests/perf_qos/get_limits.c
new file mode 100644
index 000000000000..e7559481a9a3
--- /dev/null
+++ b/tools/testing/selftests/perf_qos/get_limits.c
@@ -0,0 +1,61 @@
+// SPDX-License-Identifier: GPL-2.0-only
+/*
+ * Performance Quality of Service (Perf QoS) support base.
+ *
+ * Copyright (C) 2024 Linaro Ltd
+ *
+ * Author: Daniel Lezcano <daniel.lezcano@linaro.org>
+ *
+ */
+#include <errno.h>
+#include <fcntl.h>
+#include <signal.h>
+#include <stdarg.h>
+#include <stdio.h>
+#include <stdlib.h>
+#include <string.h>
+#include <sys/ioctl.h>
+#include <sys/poll.h>
+#include <sys/types.h>
+#include <sys/wait.h>
+#include <unistd.h>
+
+#include <linux/perf_qos_ioctl.h>
+
+int main(int argc, char *argv[])
+{
+	struct perf_qos_ioctl_arg arg = {};
+	const char *path = "/dev/perf_qos/dummy";
+	int fd;
+	
+	if (argc == 2)
+		path = argv[1];
+
+	fd = open(path, 0, O_RDWR);
+	if (fd < 0) {
+		fprintf(stderr, "Failed to open '%s': %m\n", path);
+		return 1;
+	}
+
+	if (ioctl(fd, PERF_QOS_IOC_GET_LIMITS, &arg)) {
+		fprintf(stderr, "Failed to ioctl: %m\n");
+		return 1;
+	}
+
+	if (arg.unit != PERF_QOS_UNIT_NORMAL) {
+		fprintf(stderr, "Invalid unit, expected 'PERF_QOS_UNIT_NORMAL'\n");
+		return 1;
+	}
+
+	if (arg.limit_min != 0) {
+		fprintf(stderr, "Invalid minimum unit %d != 0\n", arg.limit_min);
+		return 1;
+	}
+
+	if (arg.limit_max != 1024) {
+		fprintf(stderr, "Invalid maximum unit %d != 1024\n", arg.limit_max);
+		return 1;
+	}
+
+	return 0;
+}
diff --git a/tools/testing/selftests/perf_qos/get_set_max.c b/tools/testing/selftests/perf_qos/get_set_max.c
new file mode 100644
index 000000000000..87bf5c26acf7
--- /dev/null
+++ b/tools/testing/selftests/perf_qos/get_set_max.c
@@ -0,0 +1,95 @@
+// SPDX-License-Identifier: GPL-2.0-only
+/*
+ * Performance Quality of Service (Perf QoS) support base.
+ *
+ * Copyright (C) 2024 Linaro Ltd
+ *
+ * Author: Daniel Lezcano <daniel.lezcano@linaro.org>
+ *
+ */
+#include <errno.h>
+#include <fcntl.h>
+#include <signal.h>
+#include <stdarg.h>
+#include <stdio.h>
+#include <stdlib.h>
+#include <string.h>
+#include <sys/ioctl.h>
+#include <sys/poll.h>
+#include <sys/types.h>
+#include <sys/wait.h>
+#include <unistd.h>
+
+#include <linux/perf_qos_ioctl.h>
+
+int main(int argc, char *argv[])
+{
+	struct perf_qos_ioctl_arg arg = { .value = 512 };
+	const char *path = "/dev/perf_qos/dummy";
+	int fd;
+	
+	if (argc == 2)
+		path = argv[1];
+
+	fd = open(path, 0, O_RDWR);
+	if (fd < 0) {
+		fprintf(stderr, "Failed to open '%s': %m\n", path);
+		return 1;
+	}
+
+	/*
+	 * Test 1: Check the value is set
+	 */
+	if (ioctl(fd, PERF_QOS_IOC_SET_MAX, &arg)) {
+		fprintf(stderr, "Failed to ioctl: %m\n");
+		return 1;
+	}
+
+	arg.value = 0;
+	
+	if (ioctl(fd, PERF_QOS_IOC_GET_MAX, &arg)) {
+		fprintf(stderr, "Failed to ioctl: %m\n");
+		return 1;
+	}
+
+	if (arg.value != 512) {
+		fprintf(stderr, "max value differs with set/get (arg=%d)\n",
+			arg.value);
+		return 1;
+	}
+
+	/*
+	 * Test 2: Check we can not set the same constraint
+	 */
+	if (ioctl(fd, PERF_QOS_IOC_SET_MAX, &arg) == 0) {
+		fprintf(stderr, "ioctl should have failed\n");
+		return 1;
+	}
+	
+	/*
+	 * Test 3: Check the constraint is removed
+	 */
+	if (ioctl(fd, PERF_QOS_IOC_GET_LIMITS, &arg)) {
+		fprintf(stderr, "Failed to ioctl: %m\n");
+		return 1;
+	}
+
+	arg.value = arg.limit_max;
+	
+	if (ioctl(fd, PERF_QOS_IOC_SET_MAX, &arg)) {
+		fprintf(stderr, "Failed to ioctl: %m\n");
+		return 1;
+	}
+	
+	if (!ioctl(fd, PERF_QOS_IOC_GET_MAX, &arg)) {
+		fprintf(stderr, "ioctl should have failed\n");
+		return 1;
+	}
+
+	if (errno != ENODATA) {
+		fprintf(stderr, "errno should have been ENODATA\n");
+		return 1;
+	}
+
+	return 0;
+}
diff --git a/tools/testing/selftests/perf_qos/get_set_max_forked.c b/tools/testing/selftests/perf_qos/get_set_max_forked.c
new file mode 100644
index 000000000000..1bffddd684c8
--- /dev/null
+++ b/tools/testing/selftests/perf_qos/get_set_max_forked.c
@@ -0,0 +1,150 @@
+// SPDX-License-Identifier: GPL-2.0-only
+/*
+ * Performance Quality of Service (Perf QoS) support base.
+ *
+ * Copyright (C) 2024 Linaro Ltd
+ *
+ * Author: Daniel Lezcano <daniel.lezcano@linaro.org>
+ *
+ */
+#include <errno.h>
+#include <fcntl.h>
+#include <signal.h>
+#include <stdarg.h>
+#include <stdio.h>
+#include <stdlib.h>
+#include <string.h>
+#include <sys/ioctl.h>
+#include <sys/poll.h>
+#include <sys/types.h>
+#include <sys/wait.h>
+#include <unistd.h>
+
+#include <linux/perf_qos_ioctl.h>
+
+static int test_forked_get_set_max(int fd, const char *path)
+{
+	pid_t pid;
+	int fds[2];
+	int result;
+	const int init_value = 256;
+	struct perf_qos_ioctl_arg arg = { .value = init_value };
+
+	if (ioctl(fd, PERF_QOS_IOC_SET_MAX, &arg)) {
+		fprintf(stderr, "Failed to ioctl: %m\n");
+		return 1;
+	}
+
+	if (pipe(fds)) {
+		fprintf(stderr, "Failed to pipe: %m\n");
+		return 1;
+	}
+		
+	pid = fork();
+	if (pid < 0) {
+		fprintf(stderr, "Failed to fork: %m\n");
+		return 1;
+	}
+
+	if (!pid) {
+		close(fd);
+		close(fds[0]);
+
+		fd = open(path, 0, O_RDWR);
+		if (fd < 0) {
+			fprintf(stderr, "Failed to open '%s': %m\n", path);
+			return 1;
+		}
+
+		arg.value = 0;
+
+		/*
+		 * At this point, we must have a 'init_value'
+		 * constraint created by the parent process
+		 */
+		if (ioctl(fd, PERF_QOS_IOC_GET_MAX, &arg)) {
+			fprintf(stderr, "Failed to ioctl: %m\n");
+			return 1;
+		}
+
+		result = arg.value;
+
+		if (write(fds[1], &result, sizeof(result)) < 0) {
+			fprintf(stderr, "Failed to write result to pipe: %m\n");
+			exit(1);
+		}
+
+		exit(0);
+	}
+
+	close(fds[1]);
+
+	if (read(fds[0], &result, sizeof(result)) < 0) {
+		fprintf(stderr, "Failed to read pipe: %m\n");
+		return 1;
+	}
+
+	if (result != init_value) {
+		fprintf(stderr, "Child test failed: %d\n", result);
+		return 1;
+	}
+
+	if (waitpid(pid, NULL, 0) < 0) {
+		fprintf(stderr, "Failed to wait child pid: %m\n");
+		return 1;
+	}
+
+	arg.value = 0;
+
+	if (ioctl(fd, PERF_QOS_IOC_GET_MAX, &arg)) {
+		fprintf(stderr, "Failed to ioctl: %m\n");
+		return 1;
+	}
+
+	if (arg.value != init_value) {
+		fprintf(stderr, "Perf constraints differ %d <> %d\n",
+			arg.value, init_value);
+		return 1;
+	}
+
+	if (ioctl(fd, PERF_QOS_IOC_GET_LIMITS, &arg)) {
+		fprintf(stderr, "Failed to ioctl: %m\n");
+		return 1;
+	}
+
+	arg.value = arg.limit_max;
+
+	if (ioctl(fd, PERF_QOS_IOC_SET_MAX, &arg)) {
+		fprintf(stderr, "Failed to ioctl: %m\n");
+		return 1;
+	}
+
+	if (!ioctl(fd, PERF_QOS_IOC_GET_MAX, &arg)) {
+		fprintf(stderr, "ioctl should have failed\n");
+		return 1;
+	}
+
+	if (errno != ENODATA) {
+		fprintf(stderr, "errno should have been ENODATA\n");
+		return 1;
+	}
+
+	return 0;
+}
+
+int main(int argc, char *argv[])
+{
+	const char *path = "/dev/perf_qos/dummy";
+	int fd;
+	
+	if (argc == 2)
+		path = argv[1];
+
+	fd = open(path, 0, O_RDWR);
+	if (fd < 0) {
+		fprintf(stderr, "Failed to open '%s': %m\n", path);
+		return 1;
+	}
+
+	return test_forked_get_set_max(fd, path);
+}
diff --git a/tools/testing/selftests/perf_qos/get_set_min.c b/tools/testing/selftests/perf_qos/get_set_min.c
new file mode 100644
index 000000000000..89c0a6f9f106
--- /dev/null
+++ b/tools/testing/selftests/perf_qos/get_set_min.c
@@ -0,0 +1,95 @@
+// SPDX-License-Identifier: GPL-2.0-only
+/*
+ * Performance Quality of Service (Perf QoS) support base.
+ *
+ * Copyright (C) 2024 Linaro Ltd
+ *
+ * Author: Daniel Lezcano <daniel.lezcano@linaro.org>
+ *
+ */
+#include <errno.h>
+#include <fcntl.h>
+#include <signal.h>
+#include <stdarg.h>
+#include <stdio.h>
+#include <stdlib.h>
+#include <string.h>
+#include <sys/ioctl.h>
+#include <sys/poll.h>
+#include <sys/types.h>
+#include <sys/wait.h>
+#include <unistd.h>
+
+#include <linux/perf_qos_ioctl.h>
+
+int main(int argc, char *argv[])
+{
+	struct perf_qos_ioctl_arg arg = { .value = 512 };
+	const char *path = "/dev/perf_qos/dummy";
+	int fd;
+	
+	if (argc == 2)
+		path = argv[1];
+
+	fd = open(path, 0, O_RDWR);
+	if (fd < 0) {
+		fprintf(stderr, "Failed to open '%s': %m\n", path);
+		return 1;
+	}
+
+	/*
+	 * Test 1: Check the value is set
+	 */
+	if (ioctl(fd, PERF_QOS_IOC_SET_MIN, &arg)) {
+		fprintf(stderr, "Failed to ioctl: %m\n");
+		return 1;
+	}
+
+	arg.value = 0;
+	
+	if (ioctl(fd, PERF_QOS_IOC_GET_MIN, &arg)) {
+		fprintf(stderr, "Failed to ioctl: %m\n");
+		return 1;
+	}
+
+	if (arg.value != 512) {
+		fprintf(stderr, "min value differs with set/get (arg=%d)\n",
+			arg.value);
+		return 1;
+	}
+
+	/*
+	 * Test 2: Check we can not set the same constraint
+	 */
+	if (ioctl(fd, PERF_QOS_IOC_SET_MIN, &arg) == 0) {
+		fprintf(stderr, "ioctl should have failed\n");
+		return 1;
+	}
+	
+	/*
+	 * Test 3: Check the constraint is removed
+	 */
+	if (ioctl(fd, PERF_QOS_IOC_GET_LIMITS, &arg)) {
+		fprintf(stderr, "Failed to ioctl: %m\n");
+		return 1;
+	}
+
+	arg.value = arg.limit_min;
+	
+	if (ioctl(fd, PERF_QOS_IOC_SET_MIN, &arg)) {
+		fprintf(stderr, "Failed to ioctl: %m\n");
+		return 1;
+	}
+	
+	if (!ioctl(fd, PERF_QOS_IOC_GET_MIN, &arg)) {
+		fprintf(stderr, "ioctl should have failed\n");
+		return 1;
+	}
+
+	if (errno != ENODATA) {
+		fprintf(stderr, "errno should have been ENODATA\n");
+		return 1;
+	}
+
+	return 0;
+}
diff --git a/tools/testing/selftests/perf_qos/get_set_min_forked.c b/tools/testing/selftests/perf_qos/get_set_min_forked.c
new file mode 100644
index 000000000000..36971da265a5
--- /dev/null
+++ b/tools/testing/selftests/perf_qos/get_set_min_forked.c
@@ -0,0 +1,150 @@
+// SPDX-License-Identifier: GPL-2.0-only
+/*
+ * Performance Quality of Service (Perf QoS) support base.
+ *
+ * Copyright (C) 2024 Linaro Ltd
+ *
+ * Author: Daniel Lezcano <daniel.lezcano@linaro.org>
+ *
+ */
+#include <errno.h>
+#include <fcntl.h>
+#include <signal.h>
+#include <stdarg.h>
+#include <stdio.h>
+#include <stdlib.h>
+#include <string.h>
+#include <sys/ioctl.h>
+#include <sys/poll.h>
+#include <sys/types.h>
+#include <sys/wait.h>
+#include <unistd.h>
+
+#include <linux/perf_qos_ioctl.h>
+
+static int test_forked_get_set_min(int fd, const char *path)
+{
+	pid_t pid;
+	int fds[2];
+	int result;
+	const int init_value = 256;
+	struct perf_qos_ioctl_arg arg = { .value = init_value };
+
+	if (ioctl(fd, PERF_QOS_IOC_SET_MIN, &arg)) {
+		fprintf(stderr, "Failed to ioctl: %m\n");
+		return 1;
+	}
+
+	if (pipe(fds)) {
+		fprintf(stderr, "Failed to pipe: %m\n");
+		return 1;
+	}
+		
+	pid = fork();
+	if (pid < 0) {
+		fprintf(stderr, "Failed to fork: %m\n");
+		return 1;
+	}
+
+	if (!pid) {
+		close(fd);
+		close(fds[0]);
+
+		fd = open(path, 0, O_RDWR);
+		if (fd < 0) {
+			fprintf(stderr, "Failed to open '%s': %m\n", path);
+			return 1;
+		}
+
+		arg.value = 0;
+
+		/*
+		 * At this point, we must have a 'init_value'
+		 * constraint created by the parent process
+		 */
+		if (ioctl(fd, PERF_QOS_IOC_GET_MIN, &arg)) {
+			fprintf(stderr, "Failed to ioctl: %m\n");
+			return 1;
+		}
+
+		result = arg.value;
+
+		if (write(fds[1], &result, sizeof(result)) < 0) {
+			fprintf(stderr, "Failed to write result to pipe: %m\n");
+			exit(1);
+		}
+
+		exit(0);
+	}
+
+	close(fds[1]);
+
+	if (read(fds[0], &result, sizeof(result)) < 0) {
+		fprintf(stderr, "Failed to read pipe: %m\n");
+		return 1;
+	}
+
+	if (result != init_value) {
+		fprintf(stderr, "Child test failed: %d\n", result);
+		return 1;
+	}
+
+	if (waitpid(pid, NULL, 0) < 0) {
+		fprintf(stderr, "Failed to wait child pid: %m\n");
+		return 1;
+	}
+
+	arg.value = 0;
+
+	if (ioctl(fd, PERF_QOS_IOC_GET_MIN, &arg)) {
+		fprintf(stderr, "Failed to ioctl: %m\n");
+		return 1;
+	}
+
+	if (arg.value != init_value) {
+		fprintf(stderr, "Perf constraints differ %d <> %d\n",
+			arg.value, init_value);
+		return 1;
+	}
+
+	if (ioctl(fd, PERF_QOS_IOC_GET_LIMITS, &arg)) {
+		fprintf(stderr, "Failed to ioctl: %m\n");
+		return 1;
+	}
+
+	arg.value = arg.limit_min;
+
+	if (ioctl(fd, PERF_QOS_IOC_SET_MIN, &arg)) {
+		fprintf(stderr, "Failed to ioctl: %m\n");
+		return 1;
+	}
+
+	if (!ioctl(fd, PERF_QOS_IOC_GET_MIN, &arg)) {
+		fprintf(stderr, "ioctl should have failed\n");
+		return 1;
+	}
+
+	if (errno != ENODATA) {
+		fprintf(stderr, "errno should have been ENODATA\n");
+		return 1;
+	}
+
+	return 0;
+}
+
+int main(int argc, char *argv[])
+{
+	const char *path = "/dev/perf_qos/dummy";
+	int fd;
+	
+	if (argc == 2)
+		path = argv[1];
+
+	fd = open(path, 0, O_RDWR);
+	if (fd < 0) {
+		fprintf(stderr, "Failed to open '%s': %m\n", path);
+		return 1;
+	}
+
+	return test_forked_get_set_min(fd, path);
+}
diff --git a/tools/testing/selftests/perf_qos/get_unit.c b/tools/testing/selftests/perf_qos/get_unit.c
new file mode 100644
index 000000000000..938322d78599
--- /dev/null
+++ b/tools/testing/selftests/perf_qos/get_unit.c
@@ -0,0 +1,46 @@
+// SPDX-License-Identifier: GPL-2.0-only
+/*
+ * Performance Quality of Service (Perf QoS) support base.
+ *
+ * Copyright (C) 2024 Linaro Ltd
+ *
+ * Author: Daniel Lezcano <daniel.lezcano@linaro.org>
+ *
+ */
+#include <errno.h>
+#include <fcntl.h>
+#include <signal.h>
+#include <stdarg.h>
+#include <stdio.h>
+#include <stdlib.h>
+#include <string.h>
+#include <sys/ioctl.h>
+#include <sys/poll.h>
+#include <sys/types.h>
+#include <sys/wait.h>
+#include <unistd.h>
+
+#include <linux/perf_qos_ioctl.h>
+
+int main(int argc, char *argv[])
+{
+	struct perf_qos_ioctl_arg arg = {};
+	const char *path = "/dev/perf_qos/dummy";
+	int fd;
+	
+	if (argc == 2)
+		path = argv[1];
+
+	fd = open(path, 0, O_RDWR);
+	if (fd < 0) {
+		fprintf(stderr, "Failed to open '%s': %m\n", path);
+		return 1;
+	}
+
+	if (ioctl(fd, PERF_QOS_IOC_GET_UNIT, &arg)) {
+		fprintf(stderr, "Failed to ioctl: %m\n");
+		return 1;
+	}
+
+	return 0;
+}
diff --git a/tools/testing/selftests/perf_qos/set_max_forked.c b/tools/testing/selftests/perf_qos/set_max_forked.c
new file mode 100644
index 000000000000..cff06364ba81
--- /dev/null
+++ b/tools/testing/selftests/perf_qos/set_max_forked.c
@@ -0,0 +1,147 @@
+// SPDX-License-Identifier: GPL-2.0-only
+/*
+ * Performance Quality of Service (Perf QoS) support base.
+ *
+ * Copyright (C) 2024 Linaro Ltd
+ *
+ * Author: Daniel Lezcano <daniel.lezcano@linaro.org>
+ *
+ */
+#include <errno.h>
+#include <fcntl.h>
+#include <signal.h>
+#include <stdarg.h>
+#include <stdio.h>
+#include <stdlib.h>
+#include <string.h>
+#include <sys/ioctl.h>
+#include <sys/poll.h>
+#include <sys/types.h>
+#include <sys/wait.h>
+#include <unistd.h>
+
+#include <linux/perf_qos_ioctl.h>
+
+static int integer_cmp(const void *a, const void *b)
+{
+	int *ia = (typeof(ia))(a);
+	int *ib = (typeof(ib))(b);
+
+	return (*ia) - (*ib);
+}
+
+static int test_forked_set_max(int fd, const char *path)
+{
+	struct perf_qos_ioctl_arg arg;
+
+	int i;
+	int nr_pids = 100;
+	pid_t pids[nr_pids];
+	int value, values[nr_pids];
+	int fds[nr_pids][2];
+	int ret = 1;
+	
+	memset(pids, 0, sizeof(pid_t) * nr_pids);
+
+	/*
+	 * Random values in the interval 0-1024, to be set by each
+	 * child process. The underlying framework will sort them out
+	 * so when reading them, they should be ordered and while the
+	 * child process exits, the new maximal will be set each time.
+	 */
+	for (i = 0; i < nr_pids; i++) {
+		value = rand() % 1023;
+
+		if (pipe(fds[i])) {
+			fprintf(stderr, "Failed to pipe: %m\n");
+			goto out;
+		}
+		
+		pids[i] = fork();
+		if (pids[i] < 0) {
+			fprintf(stderr, "Failed to fork: %m\n");
+			goto out;
+		}
+
+		if (!pids[i]) {
+
+			arg.value = value;
+
+			close(fd);
+			close(fds[i][0]);
+
+			fd = open(path, 0, O_RDWR);
+			if (fd < 0) {
+				fprintf(stderr, "Failed to open '%s': %m\n", path);
+				goto out;
+			}
+
+			if (ioctl(fd, PERF_QOS_IOC_SET_MAX, &arg)) {
+				fprintf(stderr, "Failed to ioctl: %m\n");
+				goto out;
+			}
+
+			if (write(fds[i][1], &value, sizeof(value)) < 0) {
+				fprintf(stderr, "Failed to write in the pipe: %m\n");
+				goto out;
+			}
+
+			poll(0, 0, -1);
+			
+			exit(0);
+		}
+
+		close(fds[i][1]);
+		values[i] = value;
+	}
+
+	/*
+	 * Wait for all the children to set the constraint and write
+	 * to the pipe
+	 */
+	for (i = 0; i < nr_pids; i++) {
+		if (read(fds[i][0], &value, sizeof(value)) < 0) {
+			fprintf(stderr, "Failed to read pipe: %m\n");
+			goto out;
+		}
+	}
+
+	qsort(values, nr_pids, sizeof(values[0]), integer_cmp);
+
+	if (ioctl(fd, PERF_QOS_IOC_GET_MAX, &arg)) {
+		fprintf(stderr, "Failed to ioctl: %m\n");
+		goto out;
+	}
+
+	if (arg.value != values[0]) {
+		fprintf(stderr, "Unexcepted value order %d <> %d\n",
+			arg.value, values[0]);
+		goto out;
+	}
+
+	ret = 0;
+out:
+	for (i = 0; i < nr_pids; i++) {
+		kill(pids[i], SIGTERM);
+		waitpid(pids[i], NULL, 0);
+	}
+
+	return ret;
+}
+
+int main(int argc, char *argv[])
+{
+	const char *path = "/dev/perf_qos/dummy";
+	int fd;
+	
+	if (argc == 2)
+		path = argv[1];
+
+	fd = open(path, 0, O_RDWR);
+	if (fd < 0) {
+		fprintf(stderr, "Failed to open '%s': %m\n", path);
+		return 1;
+	}
+
+	return test_forked_set_max(fd, path);
+}
diff --git a/tools/testing/selftests/perf_qos/set_min_forked.c b/tools/testing/selftests/perf_qos/set_min_forked.c
new file mode 100644
index 000000000000..beda48c251f6
--- /dev/null
+++ b/tools/testing/selftests/perf_qos/set_min_forked.c
@@ -0,0 +1,147 @@
+// SPDX-License-Identifier: GPL-2.0-only
+/*
+ * Performance Quality of Service (Perf QoS) support base.
+ *
+ * Copyright (C) 2024 Linaro Ltd
+ *
+ * Author: Daniel Lezcano <daniel.lezcano@linaro.org>
+ *
+ */
+#include <errno.h>
+#include <fcntl.h>
+#include <signal.h>
+#include <stdarg.h>
+#include <stdio.h>
+#include <stdlib.h>
+#include <string.h>
+#include <sys/ioctl.h>
+#include <sys/poll.h>
+#include <sys/types.h>
+#include <sys/wait.h>
+#include <unistd.h>
+
+#include <linux/perf_qos_ioctl.h>
+
+static int integer_cmp(const void *a, const void *b)
+{
+	int *ia = (typeof(ia))(a);
+	int *ib = (typeof(ib))(b);
+
+	return (*ib) - (*ia);
+}
+
+static int test_forked_set_min(int fd, const char *path)
+{
+	struct perf_qos_ioctl_arg arg;
+
+	int i;
+	int nr_pids = 100;
+	pid_t pids[nr_pids];
+	int value, values[nr_pids];
+	int fds[nr_pids][2];
+	int ret = 1;
+	
+	memset(pids, 0, sizeof(pid_t) * nr_pids);
+
+	/*
+	 * Random values in the interval 0-1024, to be set by each
+	 * child process. The underlying framework will sort them out
+	 * so when reading them, they should be ordered and while the
+	 * child process exits, the new minimal will be set each time.
+	 */
+	for (i = 0; i < nr_pids; i++) {
+		value = rand() % 1023;
+
+		if (pipe(fds[i])) {
+			fprintf(stderr, "Failed to pipe: %m\n");
+			goto out;
+		}
+		
+		pids[i] = fork();
+		if (pids[i] < 0) {
+			fprintf(stderr, "Failed to fork: %m\n");
+			goto out;
+		}
+
+		if (!pids[i]) {
+
+			arg.value = value;
+
+			close(fd);
+			close(fds[i][0]);
+
+			fd = open(path, 0, O_RDWR);
+			if (fd < 0) {
+				fprintf(stderr, "Failed to open '%s': %m\n", path);
+				goto out;
+			}
+
+			if (ioctl(fd, PERF_QOS_IOC_SET_MIN, &arg)) {
+				fprintf(stderr, "Failed to ioctl: %m\n");
+				goto out;
+			}
+
+			if (write(fds[i][1], &value, sizeof(value)) < 0) {
+				fprintf(stderr, "Failed to write in the pipe: %m\n");
+				goto out;
+			}
+
+			poll(0, 0, -1);
+			
+			exit(0);
+		}
+
+		close(fds[i][1]);
+		values[i] = value;
+	}
+
+	/*
+	 * Wait for all the children to set the constraint and write
+	 * to the pipe
+	 */
+	for (i = 0; i < nr_pids; i++) {
+		if (read(fds[i][0], &value, sizeof(value)) < 0) {
+			fprintf(stderr, "Failed to read pipe: %m\n");
+			goto out;
+		}
+	}
+
+	qsort(values, nr_pids, sizeof(values[0]), integer_cmp);
+
+	if (ioctl(fd, PERF_QOS_IOC_GET_MIN, &arg)) {
+		fprintf(stderr, "Failed to ioctl: %m\n");
+		goto out;
+	}
+
+	if (arg.value != values[0]) {
+		fprintf(stderr, "Unexcepted value order %d <> %d\n",
+			arg.value, values[0]);
+		goto out;
+	}
+
+	ret = 0;
+out:
+	for (i = 0; i < nr_pids; i++) {
+		kill(pids[i], SIGTERM);
+		waitpid(pids[i], NULL, 0);
+	}
+
+	return ret;
+}
+
+int main(int argc, char *argv[])
+{
+	const char *path = "/dev/perf_qos/dummy";
+	int fd;
+	
+	if (argc == 2)
+		path = argv[1];
+
+	fd = open(path, 0, O_RDWR);
+	if (fd < 0) {
+		fprintf(stderr, "Failed to open '%s': %m\n", path);
+		return 1;
+	}
+
+	return test_forked_set_min(fd, path);
+}
diff --git a/tools/testing/selftests/perf_qos/set_multiple_maxs.c b/tools/testing/selftests/perf_qos/set_multiple_maxs.c
new file mode 100644
index 000000000000..e30a81043283
--- /dev/null
+++ b/tools/testing/selftests/perf_qos/set_multiple_maxs.c
@@ -0,0 +1,93 @@
+// SPDX-License-Identifier: GPL-2.0-only
+/*
+ * Performance Quality of Service (Perf QoS) support base.
+ *
+ * Copyright (C) 2024 Linaro Ltd
+ *
+ * Author: Daniel Lezcano <daniel.lezcano@linaro.org>
+ *
+ */
+#include <errno.h>
+#include <fcntl.h>
+#include <signal.h>
+#include <stdarg.h>
+#include <stdio.h>
+#include <stdlib.h>
+#include <string.h>
+#include <sys/ioctl.h>
+#include <sys/poll.h>
+#include <sys/types.h>
+#include <sys/wait.h>
+#include <unistd.h>
+
+#include <linux/perf_qos_ioctl.h>
+
+int main(int argc, char *argv[])
+{
+	struct perf_qos_ioctl_arg arg;
+	const char *path = "/dev/perf_qos/dummy";
+	const int nr_fds = 256;
+	int i, fd[nr_fds];
+
+	if (argc == 2)
+		path = argv[1];
+
+	for (i = 0; i < nr_fds; i++) {
+
+		fd[i] = open(path, 0, O_RDWR);
+		if (fd[i] < 0) {
+			fprintf(stderr, "Failed to open '%s': %m\n", path);
+			return 1;
+		}
+
+		/*
+		 * We want a value increasing so the value we set is
+		 * always the first entry in the list of constraints
+		 * and when we get the max, we get the last value we
+		 * set.
+		 */
+		arg.value = nr_fds - i;
+
+		if (ioctl(fd[i], PERF_QOS_IOC_SET_MAX, &arg)) {
+			fprintf(stderr, "Failed to ioctl: %m\n");
+			return 1;
+		}
+
+		arg.value = 0;
+		
+		if (ioctl(fd[i], PERF_QOS_IOC_GET_MAX, &arg)) {
+			fprintf(stderr, "Failed to ioctl: %m\n");
+			return 1;
+		}
+
+		if (arg.value != (nr_fds - i)) {
+			fprintf(stderr, "max value differs with set/get (arg=%d <> %d)\n",
+				arg.value, nr_fds - i);
+			return 1;
+		}
+	}
+
+	for (i = 0; i < nr_fds; i++)
+		close(fd[i]);
+
+	fd[0] = open(path, 0, O_RDWR);
+	if (fd[0] < 0) {
+		fprintf(stderr, "Failed to open '%s': %m\n", path);
+		return 1;
+	}
+
+	/*
+	 * Test: Check the constraint is removed
+	 */
+	if (!ioctl(fd[0], PERF_QOS_IOC_GET_MAX, &arg)) {
+		fprintf(stderr, "ioctl should have failed\n");
+		return 1;
+	}
+
+	if (errno != ENODATA) {
+		fprintf(stderr, "errno should have been ENODATA\n");
+		return 1;
+	}
+
+	return 0;
+}
diff --git a/tools/testing/selftests/perf_qos/set_multiple_mins.c b/tools/testing/selftests/perf_qos/set_multiple_mins.c
new file mode 100644
index 000000000000..e6412a592c3a
--- /dev/null
+++ b/tools/testing/selftests/perf_qos/set_multiple_mins.c
@@ -0,0 +1,87 @@
+// SPDX-License-Identifier: GPL-2.0-only
+/*
+ * Performance Quality of Service (Perf QoS) support base.
+ *
+ * Copyright (C) 2024 Linaro Ltd
+ *
+ * Author: Daniel Lezcano <daniel.lezcano@linaro.org>
+ *
+ */
+#include <errno.h>
+#include <fcntl.h>
+#include <signal.h>
+#include <stdarg.h>
+#include <stdio.h>
+#include <stdlib.h>
+#include <string.h>
+#include <sys/ioctl.h>
+#include <sys/poll.h>
+#include <sys/types.h>
+#include <sys/wait.h>
+#include <unistd.h>
+
+#include <linux/perf_qos_ioctl.h>
+
+int main(int argc, char *argv[])
+{
+	struct perf_qos_ioctl_arg arg;
+	const char *path = "/dev/perf_qos/dummy";
+	const int nr_fds = 256;
+	int i, fd[nr_fds];
+
+	if (argc == 2)
+		path = argv[1];
+
+	for (i = 0; i < nr_fds; i++) {
+
+		fd[i] = open(path, 0, O_RDWR);
+		if (fd[i] < 0) {
+			fprintf(stderr, "Failed to open '%s': %m\n", path);
+			return 1;
+		}
+
+		arg.value = i + 1;
+
+		if (ioctl(fd[i], PERF_QOS_IOC_SET_MIN, &arg)) {
+			fprintf(stderr, "Failed to ioctl: %m\n");
+			return 1;
+		}
+
+		arg.value = 0;
+		
+		if (ioctl(fd[i], PERF_QOS_IOC_GET_MIN, &arg)) {
+			fprintf(stderr, "Failed to ioctl: %m\n");
+			return 1;
+		}
+
+		if (arg.value != i + 1) {
+			fprintf(stderr, "min value differs with set/get (arg=%d <> %d)\n",
+				arg.value, nr_fds + 1);
+			return 1;
+		}
+	}
+
+	for (i = 0; i < nr_fds; i++)
+		close(fd[i]);
+
+	fd[0] = open(path, 0, O_RDWR);
+	if (fd[0] < 0) {
+		fprintf(stderr, "Failed to open '%s': %m\n", path);
+		return 1;
+	}
+
+	/*
+	 * Test: Check the constraint is removed
+	 */
+	if (!ioctl(fd[0], PERF_QOS_IOC_GET_MIN, &arg)) {
+		fprintf(stderr, "ioctl should have failed\n");
+		return 1;
+	}
+
+	if (errno != ENODATA) {
+		fprintf(stderr, "errno should have been ENODATA\n");
+		return 1;
+	}
+
+	return 0;
+}
diff --git a/tools/testing/selftests/perf_qos/set_same_multiple_maxs.c b/tools/testing/selftests/perf_qos/set_same_multiple_maxs.c
new file mode 100644
index 000000000000..ce36b28794fd
--- /dev/null
+++ b/tools/testing/selftests/perf_qos/set_same_multiple_maxs.c
@@ -0,0 +1,84 @@
+// SPDX-License-Identifier: GPL-2.0-only
+/*
+ * Performance Quality of Service (Perf QoS) support base.
+ *
+ * Copyright (C) 2024 Linaro Ltd
+ *
+ * Author: Daniel Lezcano <daniel.lezcano@linaro.org>
+ *
+ */
+#include <errno.h>
+#include <fcntl.h>
+#include <signal.h>
+#include <stdarg.h>
+#include <stdio.h>
+#include <stdlib.h>
+#include <string.h>
+#include <sys/ioctl.h>
+#include <sys/poll.h>
+#include <sys/types.h>
+#include <sys/wait.h>
+#include <unistd.h>
+
+#include <linux/perf_qos_ioctl.h>
+
+int main(int argc, char *argv[])
+{
+	struct perf_qos_ioctl_arg arg = { .value = 512 };
+	const char *path = "/dev/perf_qos/dummy";
+	const int nr_fds = 256;
+	int i, fd[nr_fds];
+
+	if (argc == 2)
+		path = argv[1];
+
+	for (i = 0; i < nr_fds; i++) {
+		fd[i] = open(path, 0, O_RDWR);
+		if (fd[i] < 0) {
+			fprintf(stderr, "Failed to open '%s': %m\n", path);
+			return 1;
+		}
+
+		if (ioctl(fd[i], PERF_QOS_IOC_SET_MAX, &arg)) {
+			fprintf(stderr, "Failed to ioctl: %m\n");
+			return 1;
+		}
+
+		arg.value = 0;
+		
+		if (ioctl(fd[i], PERF_QOS_IOC_GET_MAX, &arg)) {
+			fprintf(stderr, "Failed to ioctl: %m\n");
+			return 1;
+		}
+
+		if (arg.value != 512) {
+			fprintf(stderr, "max value differs with set/get (arg=%d)\n",
+				arg.value);
+			return 1;
+		}
+	}
+
+	for (i = 0; i < nr_fds; i++)
+		close(fd[i]);
+
+	fd[0] = open(path, 0, O_RDWR);
+	if (fd[0] < 0) {
+		fprintf(stderr, "Failed to open '%s': %m\n", path);
+		return 1;
+	}
+
+	/*
+	 * Test: Check the constraint is removed
+	 */
+	if (!ioctl(fd[0], PERF_QOS_IOC_GET_MAX, &arg)) {
+		fprintf(stderr, "ioctl should have failed\n");
+		return 1;
+	}
+
+	if (errno != ENODATA) {
+		fprintf(stderr, "errno should have been ENODATA\n");
+		return 1;
+	}
+
+	return 0;
+}
diff --git a/tools/testing/selftests/perf_qos/set_same_multiple_mins.c b/tools/testing/selftests/perf_qos/set_same_multiple_mins.c
new file mode 100644
index 000000000000..90fd47be50f6
--- /dev/null
+++ b/tools/testing/selftests/perf_qos/set_same_multiple_mins.c
@@ -0,0 +1,84 @@
+// SPDX-License-Identifier: GPL-2.0-only
+/*
+ * Performance Quality of Service (Perf QoS) support base.
+ *
+ * Copyright (C) 2024 Linaro Ltd
+ *
+ * Author: Daniel Lezcano <daniel.lezcano@linaro.org>
+ *
+ */
+#include <errno.h>
+#include <fcntl.h>
+#include <signal.h>
+#include <stdarg.h>
+#include <stdio.h>
+#include <stdlib.h>
+#include <string.h>
+#include <sys/ioctl.h>
+#include <sys/poll.h>
+#include <sys/types.h>
+#include <sys/wait.h>
+#include <unistd.h>
+
+#include <linux/perf_qos_ioctl.h>
+
+int main(int argc, char *argv[])
+{
+	struct perf_qos_ioctl_arg arg = { .value = 512 };
+	const char *path = "/dev/perf_qos/dummy";
+	const int nr_fds = 256;
+	int i, fd[nr_fds];
+
+	if (argc == 2)
+		path = argv[1];
+
+	for (i = 0; i < nr_fds; i++) {
+		fd[i] = open(path, 0, O_RDWR);
+		if (fd[i] < 0) {
+			fprintf(stderr, "Failed to open '%s': %m\n", path);
+			return 1;
+		}
+
+		if (ioctl(fd[i], PERF_QOS_IOC_SET_MIN, &arg)) {
+			fprintf(stderr, "Failed to ioctl: %m\n");
+			return 1;
+		}
+
+		arg.value = 0;
+		
+		if (ioctl(fd[i], PERF_QOS_IOC_GET_MIN, &arg)) {
+			fprintf(stderr, "Failed to ioctl: %m\n");
+			return 1;
+		}
+
+		if (arg.value != 512) {
+			fprintf(stderr, "min value differs with set/get (arg=%d)\n",
+				arg.value);
+			return 1;
+		}
+	}
+
+	for (i = 0; i < nr_fds; i++)
+		close(fd[i]);
+
+	fd[0] = open(path, 0, O_RDWR);
+	if (fd[0] < 0) {
+		fprintf(stderr, "Failed to open '%s': %m\n", path);
+		return 1;
+	}
+
+	/*
+	 * Test: Check the constraint is removed
+	 */
+	if (!ioctl(fd[0], PERF_QOS_IOC_GET_MIN, &arg)) {
+		fprintf(stderr, "ioctl should have failed\n");
+		return 1;
+	}
+
+	if (errno != ENODATA) {
+		fprintf(stderr, "errno should have been ENODATA\n");
+		return 1;
+	}
+
+	return 0;
+}
-- 
2.43.0


