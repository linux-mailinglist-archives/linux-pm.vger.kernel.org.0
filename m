Return-Path: <linux-pm+bounces-39624-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 4EAC9CC1854
	for <lists+linux-pm@lfdr.de>; Tue, 16 Dec 2025 09:24:01 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id A39EC3022F2D
	for <lists+linux-pm@lfdr.de>; Tue, 16 Dec 2025 08:23:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 52DB634A783;
	Tue, 16 Dec 2025 08:04:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="UoxQnMi1"
X-Original-To: linux-pm@vger.kernel.org
Received: from mail-lf1-f53.google.com (mail-lf1-f53.google.com [209.85.167.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3D42834A77A
	for <linux-pm@vger.kernel.org>; Tue, 16 Dec 2025 08:04:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1765872265; cv=none; b=jlJDR2fkOJ+WmeP02aF2h4P+t+ievj6PgMLYcjaRCTxwcVichuHg2lAhfX8c63O407v2jfGPhGjCJLwRwZOL5q/izqOtumyGzy6Niy4hp4T0Q8YZFYM14eSEv6XeJcpKrwJUOlxLlPFs8DPGG744aWH9mgDE6sMKKEoP4b/ELK8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1765872265; c=relaxed/simple;
	bh=mPv+dJMSBQoH765johoVOYTPtAtoiRUoQz70DkcM/+s=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=qumuINP7x8qUSrBg9DcsGphhDtLMaPr+S+SvkB8hfyBoGVLz9HLcMVj0uFT6V3K3KSSiMqumTNpEl51fEaitIUedoGTp3E3POabb6KjDtgaF/sSrF6MXYkZamFA+vpNUY2Cm6CJmN8RszDcmnQeyPk19jaXMQyLHDYqargZW5zU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=UoxQnMi1; arc=none smtp.client-ip=209.85.167.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-lf1-f53.google.com with SMTP id 2adb3069b0e04-5959187c5a9so4058941e87.1
        for <linux-pm@vger.kernel.org>; Tue, 16 Dec 2025 00:04:22 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1765872261; x=1766477061; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=4msAYV+BBZRzMDSu+2VCx4d9XW8Knje8SPNcp80Bx4Y=;
        b=UoxQnMi1M3wiZkqVos28W7g8UgobdyVjelge3LamxJgpAJsJo8x8blGOCYV5Lp2CiH
         VyLWqxlW5CGEyPr/D/dA+1KSpgCZU4Vv5aSdgFZlEr5mMKH3cg2YWHjEXybZP75S302Z
         YzQq9m2NPRkW802xCQ5EXOkGRTEiEqQcswwmzbkx/413JHHz3uTE/Ofcj6Lh2vSchTBu
         ZOdVjEUwxK+/txUdbFRyH/LwtAZrjAwhwF1vfcE4q9fLmWEJWFnUk88//KCQBQGSNO0P
         /ZDK7gwCgfGU3b4vymuP0h6lvAbWF+qVtnODx5QUUjmTHMjlByINfVWRz1xRXRzhXIB5
         5hyA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1765872261; x=1766477061;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=4msAYV+BBZRzMDSu+2VCx4d9XW8Knje8SPNcp80Bx4Y=;
        b=I3jWQ17cjjQZGqmpq0WKd1/w5Xm10AsHgLOeafAI9jRStTvYZv060PemEgJb4ueL/Z
         gjTwTLDwFFaH6dpDLKUYFyqDst3+MyKGGiiEyu1i8tGrvzW3VWJorzpOEpp6F6Vh67uR
         ApByQ1l+5DZJjNah8QWIFNaMxnKlyNAV+CKr1Jykeh4m+JTo3oyCSOZIykBx6cJIuD2J
         ga5iTac4BjqgmWXN/pKkZLPo/ZMWRAcLkofKEBWYl7hRGpOvAkmF5pC5DDBP2JAhVP5i
         u9g08NPr1B86j6Es8Ib/8et/BI7iVTlpnnwHxoN/V4Gcvmq47tYFoOqyAMrKwYJclt2V
         nFXA==
X-Gm-Message-State: AOJu0YyWQGci0tPFxXcrtuCwznDFnCEWJZAvzz9dBWOUa9t68/WT852P
	Wu4EH8UawIw/8h7YFz68vIt/ZUlQr1/NKGgB+wlxfR6WSeXh/2VlOGSYKyCEFBWEGQ8=
X-Gm-Gg: AY/fxX6Q1Fz3cuc+AdDZb+h2XyGNj3+ec1On4diKdWGNzdMUAG2K9TsQFrCuzK9fDEl
	F+K/czk9bxURh47nprY3DsBtQ9OOX6VnqYwg/NPhi9nkBhqObNOR14Yn/KlRad8TBTi4Dthn+n0
	qvj9g7CN7alt68Uc6qqSNs6iERyLrbL3oYbJcYWusZJGDsW8p/ZFGlJ2ih9RyoxYeilaK4sn5iC
	Vtsu3X8VRhnUYlvkwTspG176pu1/3FAohnLlGcKvfffsXhV8gOw8KhjrngwHgfPIg77iG4szysV
	I4FXK0kRDN8ul0tW+BFqEE8LDJzdtG3jQE0Fkv39pLgHwk/yb+ycZTD3FfNTb6f8XMtIfIQcr5S
	cZvDbrvfMVuPeiSWBXNGnAEVbewtZE9/wrIymiosUcA67PKxIDDmtjkozb4mGzp6NPbqW2howpK
	4wk9/JrOwaDaRQK6M07nMBAVgBdRZhyzHZotYvyDVobBk4ZzwNinx1AzidBrj8ZAQ5kqqvgPEpJ
	hvp1QegodjmjWyv5A==
X-Google-Smtp-Source: AGHT+IHcbqeqjTsedHNWA1IHwnJs97mhCJMpFW3vcraU961XIMqKnqq6M86pOqAN8fADtz4sd9cGXA==
X-Received: by 2002:a05:6512:1390:b0:594:490b:4493 with SMTP id 2adb3069b0e04-598faa83effmr4632460e87.41.1765872261062;
        Tue, 16 Dec 2025 00:04:21 -0800 (PST)
Received: from abityuts-desk (2001-14bb-ab-c176-62a0-4b37-648c-102.rev.dnainternet.fi. [2001:14bb:ab:c176:62a0:4b37:648c:102])
        by smtp.gmail.com with ESMTPSA id 2adb3069b0e04-5990da5dc09sm657426e87.75.2025.12.16.00.04.20
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 16 Dec 2025 00:04:20 -0800 (PST)
From: Artem Bityutskiy <dedekind1@gmail.com>
To: "Rafael J. Wysocki" <rafael@kernel.org>
Cc: Linux PM Mailing List <linux-pm@vger.kernel.org>
Subject: [PATCH 2/3] intel_idle: Add cmdline option to adjust C-states table
Date: Tue, 16 Dec 2025 10:04:01 +0200
Message-ID: <20251216080402.156988-3-dedekind1@gmail.com>
X-Mailer: git-send-email 2.52.0
In-Reply-To: <20251216080402.156988-1-dedekind1@gmail.com>
References: <20251216080402.156988-1-dedekind1@gmail.com>
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Artem Bityutskiy <artem.bityutskiy@linux.intel.com>

Add a new module parameter that allows adjusting the C-states table used by
the driver.

Currently, the C-states table is hardcoded in the driver based on the CPU
model. The goal is to have good enough defaults for most users.

However, C-state characteristics, such as exit latency and residency, can
vary between different variants of the same CPU model and BIOS settings.
Moreover, different platform usage models and user preferences may benefit
from different C-state target_residency values.

Provide a way for users to adjust the C-states table via a module parameter
"table". The general format is:
"state1:latency1:target_residency1,state2:latency2:target_residency2,..."

In other words, represent each C-state by its name, exit latency (in
microseconds), and target residency (in microseconds), separated by colons.
Separate multiple C-states by commas.

For example, suppose a CPU has 3 C-states with the following
characteristics:
  C1:  exit_latency=1, target_residency=2
  C1E: exit_latency=10, target_residency=10
  C6:  exit_latency=100, target_residency=500

Users can specify a custom C-states table as follows:

1. intel_idle.table="C1:2:2,C1E:5:20,C6:150:600"
   Result: C1:  exit_latency=2, target_residency=2
           C1E: exit_latency=5, target_residency=20
           C6:  exit_latency=150, target_residency=600
2. intel_idle.table="C6::400"
   Result: C1:  exit_latency=1, target_residency=2 (unchanged)
           C1E: exit_latency=10, target_residency=10 (unchanged)
           C6:  exit_latency=100, target_residency=400
                (only target_residency changed)

Signed-off-by: Artem Bityutskiy <artem.bityutskiy@linux.intel.com>
---
 drivers/idle/intel_idle.c | 169 ++++++++++++++++++++++++++++++++++++++
 1 file changed, 169 insertions(+)

diff --git a/drivers/idle/intel_idle.c b/drivers/idle/intel_idle.c
index 45903685fe680..f5e301faa4761 100644
--- a/drivers/idle/intel_idle.c
+++ b/drivers/idle/intel_idle.c
@@ -76,6 +76,10 @@ static unsigned int preferred_states_mask __read_mostly;
 static bool force_irq_on __read_mostly;
 static bool ibrs_off __read_mostly;
 
+/* The maximum allowed length for the 'table' module parameter  */
+#define MAX_CMDLINE_TABLE_LEN 256
+static char cmdline_table_str[MAX_CMDLINE_TABLE_LEN] __read_mostly;
+
 static struct cpuidle_device __percpu *intel_idle_cpuidle_devices;
 
 static unsigned long auto_demotion_disable_flags;
@@ -107,6 +111,9 @@ static struct device *sysfs_root __initdata;
 static const struct idle_cpu *icpu __initdata;
 static struct cpuidle_state *cpuidle_state_table __initdata;
 
+/* C-states data from the 'intel_idle.table' cmdline parameter */
+static struct cpuidle_state cmdline_states[CPUIDLE_STATE_MAX] __initdata;
+
 static unsigned int mwait_substates __initdata;
 
 /*
@@ -2420,6 +2427,149 @@ static void __init intel_idle_sysfs_uninit(void)
 	put_device(sysfs_root);
 }
 
+ /**
+  * get_cmdline_field - Get the current field from a cmdline string.
+  * @args: The cmdline string to get the current field from.
+  * @field: Pointer to the current field upon return.
+  * @sep: The fields separator character.
+  *
+  * Examples:
+  *   Input: args="C1:1:1,C1E:2:10", sep=':'
+  *   Output: field="C1", return "1:1,C1E:2:10"
+  *   Input: args="C1:1:1,C1E:2:10", sep=','
+  *   Output: field="C1:1:1", return "C1E:2:10"
+  *   Ipnut: args="::", sep=':'
+  *   Output: field="", return ":"
+  *
+  * Return: The continuation of the cmdline string after the field or NULL.
+  */
+static char *get_cmdline_field(char *args, char **field, char sep)
+{
+	unsigned int i;
+
+	for (i = 0; args[i] && !isspace(args[i]); i++) {
+		if (args[i] == sep)
+			break;
+	}
+
+	*field = args;
+
+	if (args[i] != sep)
+		return NULL;
+
+	args[i] = '\0';
+	return args + i + 1;
+}
+
+/**
+ * cmdline_table_adjust - Adjust the C-states table with data from cmdline.
+ * @drv: cpuidle driver (assumed to point to intel_idle_driver).
+ *
+ * Adjust the C-states table with data from the 'intel_idle.table' module
+ * parameter (if specified).
+ */
+static void __init cmdline_table_adjust(struct cpuidle_driver *drv)
+{
+	char *args = cmdline_table_str;
+	struct cpuidle_state *state;
+	int i;
+
+	if (args[0] == '\0')
+		/* The 'intel_idle.table' module parameter was not specified */
+		return;
+
+	/* Create a copy of the C-states table */
+	for (i = 0; i < drv->state_count; i++)
+		cmdline_states[i] = drv->states[i];
+
+	/*
+	 * Adjust the C-states table copy with data from the 'intel_idle.table'
+	 * module parameter.
+	 */
+	while (args) {
+		char *fields, *name, *val;
+
+		/*
+		 * Get the next C-state definition, which is expected to be
+		 * '<name>:<latency_us>:<target_residency_us>'. Treat "empty"
+		 * fields as unchanged. For example,
+		 * '<name>::<target_residency_us>' leaves the latency unchanged.
+		 */
+		args = get_cmdline_field(args, &fields, ',');
+
+		/* name */
+		fields = get_cmdline_field(fields, &name, ':');
+		if (!fields)
+			goto error;
+
+		if (!strcmp(name, "POLL")) {
+			pr_err("Cannot adjust POLL\n");
+			continue;
+		}
+
+		/* Find the C-state by its name */
+		state = NULL;
+		for (i = 0; i < drv->state_count; i++) {
+			if (!strcmp(name, drv->states[i].name)) {
+				state = &cmdline_states[i];
+				break;
+			}
+		}
+
+		if (!state) {
+			pr_err("C-state '%s' was not found\n", name);
+			continue;
+		}
+
+		/* Latency */
+		fields = get_cmdline_field(fields, &val, ':');
+		if (!fields)
+			goto error;
+
+		if (*val) {
+			if (kstrtouint(val, 0, &state->exit_latency))
+				goto error;
+		}
+
+		/* Target residency */
+		fields = get_cmdline_field(fields, &val, ':');
+
+		if (*val) {
+			if (kstrtouint(val, 0, &state->target_residency))
+				goto error;
+		}
+
+		/*
+		 * Allow for 3 more fields, but ignore them. Helps to make
+		 * possible future extensions of the cmdline format backward
+		 * compatible.
+		 */
+		for (i = 0; fields && i < 3; i++) {
+			fields = get_cmdline_field(fields, &val, ':');
+			if (!fields)
+				break;
+		}
+
+		if (fields) {
+			pr_err("Too many fields for C-state '%s'\n", state->name);
+			goto error;
+		}
+
+		pr_info("C-state from cmdline: name=%s, latency=%u, residency=%u\n",
+			state->name, state->exit_latency, state->target_residency);
+	}
+
+	/* Copy the adjusted C-states table back */
+	for (i = 1; i < drv->state_count; i++)
+		drv->states[i] = cmdline_states[i];
+
+	pr_info("Adjusted C-states with data from 'intel_idle.table'\n");
+	return;
+
+error:
+	pr_info("Failed to adjust C-states with data from 'intel_idle.table'\n");
+}
+
 static int __init intel_idle_init(void)
 {
 	const struct x86_cpu_id *id;
@@ -2486,6 +2636,7 @@ static int __init intel_idle_init(void)
 		return -ENOMEM;
 
 	intel_idle_cpuidle_driver_init(&intel_idle_driver);
+	cmdline_table_adjust(&intel_idle_driver);
 
 	retval = intel_idle_sysfs_init();
 	if (retval)
@@ -2560,3 +2711,21 @@ module_param(force_irq_on, bool, 0444);
  */
 module_param(ibrs_off, bool, 0444);
 MODULE_PARM_DESC(ibrs_off, "Disable IBRS when idle");
+
+/*
+ * Define the C-states table from a user input string. Expected format is
+ * 'name:latency:residency', where:
+ * - name: The C-state name.
+ * - latency: The C-state exit latency in us.
+ * - residency: The C-state target residency in us.
+ *
+ * Multiple C-states can be defined by separating them with commas:
+ * 'name1:latency1:residency1,name2:latency2:residency2'
+ *
+ * Example: intel_idle.table=C1:1:1,C1E:5:10,C6:100:600
+ *
+ * To leave latency or residency unchanged, use an empty field, for example:
+ * 'C1:1:1,C1E::10' - leaves C1E latency unchanged.
+ */
+module_param_string(table, cmdline_table_str, MAX_CMDLINE_TABLE_LEN, 0444);
+MODULE_PARM_DESC(table, "Build the C-states table from a user input string");
-- 
2.52.0


