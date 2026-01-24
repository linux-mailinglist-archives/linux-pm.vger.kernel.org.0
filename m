Return-Path: <linux-pm+bounces-41400-lists+linux-pm=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-pm@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id iL+EAcsedGk32QAAu9opvQ
	(envelope-from <linux-pm+bounces-41400-lists+linux-pm=lfdr.de@vger.kernel.org>)
	for <lists+linux-pm@lfdr.de>; Sat, 24 Jan 2026 02:22:19 +0100
X-Original-To: lists+linux-pm@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [104.64.211.4])
	by mail.lfdr.de (Postfix) with ESMTPS id 66F617BED7
	for <lists+linux-pm@lfdr.de>; Sat, 24 Jan 2026 02:22:18 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id 12DF83003BC7
	for <lists+linux-pm@lfdr.de>; Sat, 24 Jan 2026 01:22:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BF0751F3B8A;
	Sat, 24 Jan 2026 01:22:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="gJtd0h4X"
X-Original-To: linux-pm@vger.kernel.org
Received: from mail-dl1-f74.google.com (mail-dl1-f74.google.com [74.125.82.74])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0162D1EF091
	for <linux-pm@vger.kernel.org>; Sat, 24 Jan 2026 01:22:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.82.74
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769217734; cv=none; b=mHSZHfC/S9SX2KBWjH/Ft5qOizlblR2tfbZdQW5+tiqk8ColHBFJzt1Y5lUTT+us7fxNsXi0ZJJC29ryrWkXPASOVakNjj/Vm6EW/s0un9j4Y1Y9FADjIBkVKq9MVkPIX7S4cYSTwaVuoQD8Z2yjcsqrvjplQVRnCmsAYZHHRoU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769217734; c=relaxed/simple;
	bh=5nx1vabACddP8X8rCz/BHrB3L4m/zjtvvtqkMM/A9Q4=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=NA26wakDvPcP7dOV1/aIBjZ8VcrueXBbUbIsD9NRUoRSSo7GVxrNPMp6xLK6rXLRvg/wbJLdWdbfR5Dx4b8vEpvUimUl/9or+Fust4VhtMIfLOoYwHMfp4kGJiFC/tNGp0HUoRz5kIoTqOBjPfsPjpv+GRyiaaJEd7mhhHllyLU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--wusamuel.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=gJtd0h4X; arc=none smtp.client-ip=74.125.82.74
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--wusamuel.bounces.google.com
Received: by mail-dl1-f74.google.com with SMTP id a92af1059eb24-123840bf029so18684344c88.1
        for <linux-pm@vger.kernel.org>; Fri, 23 Jan 2026 17:22:12 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1769217732; x=1769822532; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=HgDNIVQUbJ1g8aqYaibRfwYHVmGqmY8Tq8troMul2uo=;
        b=gJtd0h4XuOp73H/yOFrI+hO7U0RIPD1d1bi++rmurxYl387AZ1TJ2EFS3Ia5b/Ord3
         W4ixyn1rK3/aulX28IrT/6joNuUgEx83ho8DTSQlIBMgL6d0g7sRlvpV87+opyusczZ/
         61tGxxJ1Myg6Jtp0XEL3PYMWCACgOQkVwgkECtBXBRmdmFyZvK1g0h3Fs7Hjnw8vpuZ5
         db76T4AB6Gl4iiRDWFJhzfdfcHTqiVaSch9+mYdDXimRKGXBoK07R6ags+h4+RBTumgL
         PUWICvxeKE5xze44+ceRzJIeLNmlNHOcDHKUZrnSUV6VX8oGQCRxLbN4AgNJV1xX6swx
         +5BQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1769217732; x=1769822532;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=HgDNIVQUbJ1g8aqYaibRfwYHVmGqmY8Tq8troMul2uo=;
        b=KHVnPjA40ROCCgmu6I28s/ZWyy5IvGTMJIKwsF3i7Epg5VDWO58JqtpMKurOiYwzhY
         KDnbGqHcnp48QaJqvYi0kh3H00mqf7GNokpbfL4PvBbtroMuUJ5dh67SIXMmPz2ubhif
         ocKYSUq8QDlxYqfwxvqdfbnFkymEwxKr6yx/Cf/aR3EKAumFjuVIBNmaywBTn9B7T5iW
         XdljAg7qi58ztuQmWuw17X0hY5aMBAlcVwU7Z0DeXj8uYA6DcojT+T4Em0StINp6y/2l
         EerOCymE4zhj0TCPHO+HEMZnXm1Z9eEQoMiPAPYioyLtcFtjYYKA3mZBl4ZplgE97/DP
         aVfQ==
X-Forwarded-Encrypted: i=1; AJvYcCXDI5xGG0+7WYkdSWdcRdznJ94tm/Eq7atzWCDzXh+sEHRzbjpfq4k1dWweeVGfSt/vKSQe0XkzJg==@vger.kernel.org
X-Gm-Message-State: AOJu0YyHM+RvQDMHptQjr1uJ920XDkaLLe8SnBiBf9tFbZtHAmsXRr+T
	yfninfnCN+IPhSKbRixjcKArajIPqywasF/Bh6rEyCSPP6mAVF/gvvU8Rs7gt+Blgq3amswddIF
	OHM1o+mBc1cxYRA==
X-Received: from dlbrf17.prod.google.com ([2002:a05:7022:f211:b0:11b:f588:7cbc])
 (user=wusamuel job=prod-delivery.src-stubby-dispatcher) by
 2002:a05:7022:4587:b0:11d:f464:5c97 with SMTP id a92af1059eb24-12481a46bf3mr1805783c88.39.1769217731989;
 Fri, 23 Jan 2026 17:22:11 -0800 (PST)
Date: Fri, 23 Jan 2026 17:21:31 -0800
In-Reply-To: <20260124012133.2451708-1-wusamuel@google.com>
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20260124012133.2451708-1-wusamuel@google.com>
X-Mailer: git-send-email 2.52.0.457.g6b5491de43-goog
Message-ID: <20260124012133.2451708-4-wusamuel@google.com>
Subject: [PATCH bpf-next v3 3/3] selftests/bpf: Add tests for wakeup_sources
From: Samuel Wu <wusamuel@google.com>
To: "Rafael J. Wysocki" <rafael@kernel.org>, Len Brown <lenb@kernel.org>, Pavel Machek <pavel@kernel.org>, 
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Danilo Krummrich <dakr@kernel.org>, 
	Alexei Starovoitov <ast@kernel.org>, Daniel Borkmann <daniel@iogearbox.net>, 
	Andrii Nakryiko <andrii@kernel.org>, Martin KaFai Lau <martin.lau@linux.dev>, 
	Eduard Zingerman <eddyz87@gmail.com>, Song Liu <song@kernel.org>, 
	Yonghong Song <yonghong.song@linux.dev>, John Fastabend <john.fastabend@gmail.com>, 
	KP Singh <kpsingh@kernel.org>, Stanislav Fomichev <sdf@fomichev.me>, Hao Luo <haoluo@google.com>, 
	Jiri Olsa <jolsa@kernel.org>, Shuah Khan <shuah@kernel.org>
Cc: Samuel Wu <wusamuel@google.com>, kernel-team@android.com, 
	linux-kernel@vger.kernel.org, linux-pm@vger.kernel.org, bpf@vger.kernel.org, 
	linux-kselftest@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [0.84 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	MID_CONTAINS_FROM(1.00)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[google.com,reject];
	MV_CASE(0.50)[];
	R_SPF_ALLOW(-0.20)[+ip4:104.64.211.4:c];
	R_DKIM_ALLOW(-0.20)[google.com:s=20230601];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	FROM_HAS_DN(0.00)[];
	FREEMAIL_TO(0.00)[kernel.org,linuxfoundation.org,iogearbox.net,linux.dev,gmail.com,fomichev.me,google.com];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	RCPT_COUNT_TWELVE(0.00)[24];
	MIME_TRACE(0.00)[0:+];
	TAGGED_FROM(0.00)[bounces-41400-lists,linux-pm=lfdr.de];
	DKIM_TRACE(0.00)[google.com:+];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[wusamuel@google.com,linux-pm@vger.kernel.org];
	TO_DN_SOME(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	ASN(0.00)[asn:63949, ipnet:104.64.192.0/19, country:SG];
	TAGGED_RCPT(0.00)[linux-pm];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sin.lore.kernel.org:helo,sin.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: 66F617BED7
X-Rspamd-Action: no action

Sets up the framework to test wakeup_sources iterators using BPF, and
adds a few basic tests.

Adds several helper functions that for grabbing and releasing a
wakelock, abstracting out key functions to setup a framework for testing
wakeup_sources.

Additionally, adds 3 tests:
1. check_active_count: Checks that stats related to active_count are
   properly set after several lock/unlock cycles
2. check_sleep_times: Checks that time accounting related to sleep are
   properly calculated
3. check_no_infinite_reads: Checks that the iterator traversal returns
   NULL at the end

Signed-off-by: Samuel Wu <wusamuel@google.com>
---
 tools/testing/selftests/bpf/config            |   1 +
 .../bpf/prog_tests/wakeup_source_iter.c       | 281 ++++++++++++++++++
 .../selftests/bpf/progs/wakeup_source_iter.c  |  60 ++++
 3 files changed, 342 insertions(+)
 create mode 100644 tools/testing/selftests/bpf/prog_tests/wakeup_source_iter.c
 create mode 100644 tools/testing/selftests/bpf/progs/wakeup_source_iter.c

diff --git a/tools/testing/selftests/bpf/config b/tools/testing/selftests/bpf/config
index 558839e3c185..c12c5e04b81f 100644
--- a/tools/testing/selftests/bpf/config
+++ b/tools/testing/selftests/bpf/config
@@ -111,6 +111,7 @@ CONFIG_IP6_NF_IPTABLES=y
 CONFIG_IP6_NF_FILTER=y
 CONFIG_NF_NAT=y
 CONFIG_PACKET=y
+CONFIG_PM_WAKELOCKS=y
 CONFIG_RC_CORE=y
 CONFIG_SAMPLES=y
 CONFIG_SAMPLE_LIVEPATCH=m
diff --git a/tools/testing/selftests/bpf/prog_tests/wakeup_source_iter.c b/tools/testing/selftests/bpf/prog_tests/wakeup_source_iter.c
new file mode 100644
index 000000000000..c8a38717e284
--- /dev/null
+++ b/tools/testing/selftests/bpf/prog_tests/wakeup_source_iter.c
@@ -0,0 +1,281 @@
+// SPDX-License-Identifier: GPL-2.0
+/* Copyright (c) 2026 Google LLC */
+
+#include <test_progs.h>
+#include <bpf/libbpf.h>
+#include "wakeup_source_iter.skel.h"
+
+#include <fcntl.h>
+#include <stdbool.h>
+#include <stdio.h>
+#include <stdlib.h>
+#include <string.h>
+#include <unistd.h>
+
+
+/* Sleep for 10ms to ensure active time is > 0 after converting ns to ms*/
+#define TEST_SLEEP_US 10000
+#define TEST_SLEEP_MS (TEST_SLEEP_US / 1000)
+#define WAKEUP_SOURCE_NAME_LEN 32
+
+static const char test_ws_name[] = "bpf_selftest_ws";
+static bool test_ws_created;
+
+/*
+ * Creates a new wakeup source by writing to /sys/power/wake_lock.
+ * This lock persists until explicitly unlocked.
+ */
+static int lock_ws(const char *name)
+{
+	int fd;
+	ssize_t bytes;
+
+	fd = open("/sys/power/wake_lock", O_WRONLY);
+	if (!ASSERT_OK_FD(fd, "open /sys/power/wake_lock"))
+		return -1;
+
+	bytes = write(fd, name, strlen(name));
+	close(fd);
+	if (!ASSERT_EQ(bytes, strlen(name), "write to wake_lock"))
+		return -1;
+
+	return 0;
+}
+
+/*
+ * Destroys the ws by writing the same name to /sys/power/wake_unlock.
+ */
+static void unlock_ws(const char *name)
+{
+	int fd;
+
+	fd = open("/sys/power/wake_unlock", O_WRONLY);
+	if (!ASSERT_OK_FD(fd, "open /sys/power/wake_unlock"))
+		goto cleanup;
+
+	write(fd, name, strlen(name));
+
+cleanup:
+	if (fd)
+		close(fd);
+}
+
+/*
+ * Setups for testing ws iterators. Will run once prior to suite of tests.
+ */
+static int setup_test_ws(void)
+{
+	if (lock_ws(test_ws_name))
+		return -1;
+	test_ws_created = true;
+
+	return 0;
+}
+
+/*
+ * Tears down and cleanups testing ws iterators. WIll run once after the suite
+ * of tests.
+ */
+static void teardown_test_ws(void)
+{
+	if (!test_ws_created)
+		return;
+	unlock_ws(test_ws_name);
+	test_ws_created = false;
+}
+
+struct WakeupSourceInfo {
+	char name[WAKEUP_SOURCE_NAME_LEN];
+	unsigned long active_count;
+	long active_time_ms;
+	unsigned long event_count;
+	unsigned long expire_count;
+	long last_change_ms;
+	long max_time_ms;
+	long prevent_sleep_time_ms;
+	long total_time_ms;
+	unsigned long wakeup_count;
+};
+
+/*
+ * Reads and parses one wakeup_source record from the iterator file.
+ * A record is a single space-delimited line.
+ * Returns true on success, false on EOF. Asserts internally on errors.
+ */
+static bool read_ws_info(FILE *iter_file, struct WakeupSourceInfo *ws_info,
+			 char **line)
+{
+	size_t linesize;
+	int items;
+
+	if (getline(line, &linesize, iter_file) == -1)
+		return false;
+
+	(*line)[strcspn(*line, "\n")] = 0;
+
+	items = sscanf(*line, "%s %lu %ld %lu %lu %ld %ld %ld %ld %lu",
+		       ws_info->name, &ws_info->active_count,
+		       &ws_info->active_time_ms, &ws_info->event_count,
+		       &ws_info->expire_count, &ws_info->last_change_ms,
+		       &ws_info->max_time_ms, &ws_info->prevent_sleep_time_ms,
+		       &ws_info->total_time_ms, &ws_info->wakeup_count);
+
+	if (!ASSERT_EQ(items, 10, "read wakeup source info"))
+		return false;
+
+	if (!ASSERT_LT(strlen(ws_info->name), WAKEUP_SOURCE_NAME_LEN,
+		       "name length"))
+		return false;
+
+	return true;
+}
+
+static int get_ws_iter_stream(struct wakeup_source_iter *skel, int *iter_fd,
+			      FILE **iter_file)
+{
+	*iter_fd = bpf_iter_create(
+			bpf_link__fd(skel->links.wakeup_source_collector));
+	if (!ASSERT_OK_FD(*iter_fd, "iter_create"))
+		return -1;
+
+	*iter_file = fdopen(*iter_fd, "r");
+	if (!ASSERT_OK_PTR(*iter_file, "fdopen"))
+		return -1;
+
+	return 0;
+}
+
+static void subtest_ws_iter_check_active_count(struct wakeup_source_iter *skel)
+{
+	static const char subtest_ws_name[] = "bpf_selftest_ws_active_count";
+	const int lock_unlock_cycles = 5;
+	struct WakeupSourceInfo ws_info;
+	char *line = NULL;
+	bool found_ws = false;
+	FILE *iter_file = NULL;
+	int iter_fd = -1;
+	int i;
+
+	for (i = 0; i < lock_unlock_cycles; i++) {
+		if (!ASSERT_OK(lock_ws(subtest_ws_name), "lock_ws"))
+			goto cleanup;
+		unlock_ws(subtest_ws_name);
+	}
+
+	if (get_ws_iter_stream(skel, &iter_fd, &iter_file))
+		goto cleanup;
+
+	while (read_ws_info(iter_file, &ws_info, &line)) {
+		if (strcmp(ws_info.name, subtest_ws_name) == 0) {
+			found_ws = true;
+			ASSERT_EQ(ws_info.active_count, lock_unlock_cycles,
+				  "active_count check");
+			ASSERT_EQ(ws_info.event_count, lock_unlock_cycles,
+				  "event_count check");
+			break;
+		}
+	}
+
+	ASSERT_TRUE(found_ws, "found active_count test ws");
+
+	free(line);
+cleanup:
+	if (iter_file)
+		fclose(iter_file);
+	else if (iter_fd >= 0)
+		close(iter_fd);
+}
+
+static void subtest_ws_iter_check_sleep_times(struct wakeup_source_iter *skel)
+{
+	bool found_test_ws = false;
+	struct WakeupSourceInfo ws_info;
+	char *line = NULL;
+	FILE *iter_file;
+	int iter_fd;
+
+	if (get_ws_iter_stream(skel, &iter_fd, &iter_file))
+		goto cleanup;
+
+	while (read_ws_info(iter_file, &ws_info, &line)) {
+		if (strcmp(ws_info.name, test_ws_name) == 0) {
+			found_test_ws = true;
+			ASSERT_GT(ws_info.last_change_ms, 0,
+				  "Expected non-zero last change");
+			ASSERT_GE(ws_info.active_time_ms, TEST_SLEEP_MS,
+				  "Expected active time >= TEST_SLEEP_MS");
+			ASSERT_GE(ws_info.max_time_ms, TEST_SLEEP_MS,
+				  "Expected max time >= TEST_SLEEP_MS");
+			ASSERT_GE(ws_info.total_time_ms, TEST_SLEEP_MS,
+				  "Expected total time >= TEST_SLEEP_MS");
+			break;
+		}
+	}
+
+	ASSERT_TRUE(found_test_ws, "found_test_ws");
+
+	free(line);
+cleanup:
+	if (iter_file)
+		fclose(iter_file);
+	else if (iter_fd >= 0)
+		close(iter_fd);
+}
+
+static void subtest_ws_iter_check_no_infinite_reads(
+		struct wakeup_source_iter *skel)
+{
+	int iter_fd;
+	char buf[256];
+
+	iter_fd = bpf_iter_create(bpf_link__fd(skel->links.wakeup_source_collector));
+	if (!ASSERT_OK_FD(iter_fd, "iter_create"))
+		return;
+
+	while (read(iter_fd, buf, sizeof(buf)) > 0)
+		;
+
+	/* Final read should return 0 */
+	ASSERT_EQ(read(iter_fd, buf, sizeof(buf)), 0, "read");
+
+	close(iter_fd);
+}
+
+void test_wakeup_source_iter(void)
+{
+	struct wakeup_source_iter *skel = NULL;
+
+	if (geteuid() != 0) {
+		fprintf(stderr,
+			"Skipping wakeup_source_iter test, requires root\n");
+		test__skip();
+		return;
+	}
+
+	skel = wakeup_source_iter__open_and_load();
+	if (!ASSERT_OK_PTR(skel, "wakeup_source_iter__open_and_load"))
+		return;
+
+	if (!ASSERT_OK(setup_test_ws(), "setup_test_ws"))
+		goto destroy;
+
+	if (!ASSERT_OK(wakeup_source_iter__attach(skel), "skel_attach"))
+		goto destroy;
+
+	/*
+	 * Sleep on O(ms) to ensure that time stats' resolution isn't lost when
+	 * converting from ns to ms
+	 */
+	usleep(TEST_SLEEP_US);
+
+	if (test__start_subtest("active_count"))
+		subtest_ws_iter_check_active_count(skel);
+	if (test__start_subtest("sleep_times"))
+		subtest_ws_iter_check_sleep_times(skel);
+	if (test__start_subtest("no_infinite_reads"))
+		subtest_ws_iter_check_no_infinite_reads(skel);
+
+destroy:
+	teardown_test_ws();
+	wakeup_source_iter__destroy(skel);
+}
diff --git a/tools/testing/selftests/bpf/progs/wakeup_source_iter.c b/tools/testing/selftests/bpf/progs/wakeup_source_iter.c
new file mode 100644
index 000000000000..eb19569e4424
--- /dev/null
+++ b/tools/testing/selftests/bpf/progs/wakeup_source_iter.c
@@ -0,0 +1,60 @@
+// SPDX-License-Identifier: GPL-2.0
+/* Copyright (c) 2026 Google LLC */
+#include <vmlinux.h>
+#include <bpf/bpf_core_read.h>
+#include <bpf/bpf_helpers.h>
+
+#define NSEC_PER_MS 1000000UL
+#define WAKEUP_SOURCE_NAME_LEN 32
+
+char _license[] SEC("license") = "GPL";
+
+SEC("iter/wakeup_source")
+int wakeup_source_collector(struct bpf_iter__wakeup_source *ctx)
+{
+	const struct wakeup_source *ws = ctx->wakeup_source;
+	struct seq_file *seq = ctx->meta->seq;
+	char name[WAKEUP_SOURCE_NAME_LEN] = {'\0'};
+	const char *pname;
+	bool active, autosleep_enable;
+	s64 active_time, curr_time, max_time, prevent_sleep_time, total_time;
+
+	if (!ws)
+		return 0;
+
+	active = BPF_CORE_READ_BITFIELD_PROBED(ws, active);
+	autosleep_enable = BPF_CORE_READ_BITFIELD_PROBED(ws, autosleep_enabled);
+	if (bpf_core_read(&pname, sizeof(pname), &ws->name) ||
+	    bpf_probe_read_kernel_str(name, sizeof(name), pname) < 0)
+		return 0;
+
+	active_time = 0;
+	curr_time = bpf_ktime_get_ns();
+	max_time = ws->max_time;
+	prevent_sleep_time = ws->prevent_sleep_time;
+	total_time = ws->total_time;
+
+	if (active) {
+		active_time = curr_time - ws->last_time;
+		total_time += active_time;
+		if (active_time > max_time)
+			max_time = active_time;
+		if (autosleep_enable)
+			prevent_sleep_time +=
+				curr_time - ws->start_prevent_time;
+	}
+
+	BPF_SEQ_PRINTF(seq,
+		       "%s %lu %ld %lu %lu %ld %ld %ld %ld %lu\n",
+		       name,
+		       ws->active_count,
+		       active_time / NSEC_PER_MS,
+		       ws->event_count,
+		       ws->expire_count,
+		       ws->last_time / NSEC_PER_MS,
+		       max_time / NSEC_PER_MS,
+		       prevent_sleep_time / NSEC_PER_MS,
+		       total_time / NSEC_PER_MS,
+		       ws->wakeup_count);
+	return 0;
+}
-- 
2.52.0.457.g6b5491de43-goog


