Return-Path: <linux-pm+bounces-39625-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id B4233CC185E
	for <lists+linux-pm@lfdr.de>; Tue, 16 Dec 2025 09:24:43 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 48794304ACB9
	for <lists+linux-pm@lfdr.de>; Tue, 16 Dec 2025 08:23:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D22BE34A77A;
	Tue, 16 Dec 2025 08:04:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="NLQDLrPB"
X-Original-To: linux-pm@vger.kernel.org
Received: from mail-lf1-f45.google.com (mail-lf1-f45.google.com [209.85.167.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 09C08337113
	for <linux-pm@vger.kernel.org>; Tue, 16 Dec 2025 08:04:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1765872267; cv=none; b=s5KgaHrh629iBrI7F1N9btPA/534JitdbsxSNw+1vQG3M5d3UJW2xhBPPtzRBq7VnifIpktwPeEZ+nV/eFDQi00bUT7KjyLMlArc4fIKZjsrUxIWzGaZzMea/b214yb5Sn80DxxY7z0cJDK6S6TVaS63LE2Gu1D+HoThKSYc5tI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1765872267; c=relaxed/simple;
	bh=VQjU+xkcw3Me4jEV79ZomDXUWCn8v2iBVO31gl/pfhk=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=QNKpogPm5VWVUI1UwmPF8y6VKNNAAyCU7Clb/n6pWaoCE89LA264Zq1ORiSThbEVpbXyTTA2nUnUFT9YumeTET1BOvHFmr27iNVvj6on0lCjp+raJW/hhQD3k46gX7z5aSXTClu+bjRdz/7tWj4x1gkA+3JWZCxWtzHrRQ2U/hU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=NLQDLrPB; arc=none smtp.client-ip=209.85.167.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-lf1-f45.google.com with SMTP id 2adb3069b0e04-598f59996aaso5190437e87.1
        for <linux-pm@vger.kernel.org>; Tue, 16 Dec 2025 00:04:25 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1765872264; x=1766477064; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=5XEdhKeOO7vL8ewr6cROCX7jn2v1olUZIDPwj92zJNU=;
        b=NLQDLrPBL8n265x/57J/A7v+nt8Wut4LxJLU1Es0/FzEe39XKWiST1dIogs8yCCpYb
         iBUZJpKqWK0j4W5keP2nvsI806tcwkcX+q9LOYBcEAI63QKIFt7kJHx5mpW/cjABoxQY
         gqUozb4lw06gSoHL84Ndpjd6KxCWH1Kqe3fUJdnJmDSVfk5bQz/sAERXo4ZR9kzZWzxV
         3wY0PvoIEticy5XLwN6s52ZuNsAOkejmP4B5QjuqWhQFk5+w0tN4SLW2gKg6+js6odQc
         9Zo1PSzYido9aAsfVZll4PCCF9Ye9fs+NfTncHsXba+Kc4JAo4grpLbyNCeGygHRMBl3
         gGLQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1765872264; x=1766477064;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=5XEdhKeOO7vL8ewr6cROCX7jn2v1olUZIDPwj92zJNU=;
        b=u/wqs7/dcZG53kOt9ZjXbIlvfz2hGP/51pda4rmLwn+bk5XuB+8o/4hDH//RinbFSD
         Iz8jDH5sbYF4UvMxXeCTY4XJxmphYYvDXAP4q3NlXWOrMS3gXvnArcFvAXVUpti0jGqU
         LvRT4BT1djrlm5U2XcCFJmKZ0y6riNs8z6CeSvJCB4TrEmLE7gUxsmKLzjqwZlOwHKFG
         cVvXW2v5TjGxSNXEg/pBEZTfUcM6WGeD2XDxR+P7zcSP4YDLdCTcaXEhbYFW2E6bu/tX
         EV/14hU8zuRq63B/9csV/IYYutXPT4mVRwefKvQEnQhbrNLUMtTpLTiy8AsIbd5VpGaJ
         b3Zw==
X-Gm-Message-State: AOJu0Ywf7/x/lRqgoKZsU2y6AH3Zd2QXv4RDMsCZClA03mHO7LXgJub1
	NgyAKcWA05d3nq1k1+y6yCmPpkqh5CWA3BEAzQGy2thag14S+v45RXcRSJSq9QLStrs=
X-Gm-Gg: AY/fxX4x57ew0UO8rZ92mvewdgm2CZOnWycIseUy6znoXkOz4kY88EaJz7qkK9eGSbO
	GsqnYyRHH01GEDxMOf3/QFjMxz2OnYTeeNZ2ZrgLltGeZ7myjh2WixJ2l6duT6ZV0hBLcA2Wjqa
	SnmM9H4RZDL/h5x5c4Ic65NoYAhGH+t2huxOa27jVLkkLjxb9RXAtUqGBBMw5HhIpU12L3tPyJO
	n6yoh50j+QDSS0j8O+kfdbulQDkqvoBTlRQSWgSvv2SMufs1ZE9ucvo0XfeBx/QgxmcD6IM3wpP
	jT33Vo85OI5MUbfhz6HZoRfcfoFJCu4J5XY9NJ465Kd9JiiWTU3nznatdstoCpki06rBKWv2UIM
	YPbLi40v3Yw4rRqmvQdt3/EALkUls0s3mlqOeIBfJUpBetzRalXYwqqgvpMkv7cBALGxZkMqyG5
	yHuuqcR1mWZsNU0QzdDbHZUQR7RmLpzC7anfUHaMWrp0T+nPMe2iJ3hxXapr8TACkc3jsPsDAuh
	14n1CA=
X-Google-Smtp-Source: AGHT+IHw5pF0h771nvNb/lRdd+rKoHYtYjxzJug94ZTJks0ydZ6ehfZiqTzlMYrC8NQeQvcyT+FyNQ==
X-Received: by 2002:a05:6512:b8c:b0:595:9152:b920 with SMTP id 2adb3069b0e04-598faa7b404mr4764994e87.39.1765872263810;
        Tue, 16 Dec 2025 00:04:23 -0800 (PST)
Received: from abityuts-desk (2001-14bb-ab-c176-62a0-4b37-648c-102.rev.dnainternet.fi. [2001:14bb:ab:c176:62a0:4b37:648c:102])
        by smtp.gmail.com with ESMTPSA id 2adb3069b0e04-5990da5dc09sm657426e87.75.2025.12.16.00.04.23
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 16 Dec 2025 00:04:23 -0800 (PST)
From: Artem Bityutskiy <dedekind1@gmail.com>
To: "Rafael J. Wysocki" <rafael@kernel.org>
Cc: Linux PM Mailing List <linux-pm@vger.kernel.org>
Subject: [PATCH 3/3] intel_idle: Add C-states validation
Date: Tue, 16 Dec 2025 10:04:02 +0200
Message-ID: <20251216080402.156988-4-dedekind1@gmail.com>
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

Add validation for C-states specified via the "table=" module parameter.
Treat this module parameter as untrusted input and validate it thoroughly.

Signed-off-by: Artem Bityutskiy <artem.bityutskiy@linux.intel.com>
---
 drivers/idle/intel_idle.c | 54 +++++++++++++++++++++++++++++++++++++++
 1 file changed, 54 insertions(+)

diff --git a/drivers/idle/intel_idle.c b/drivers/idle/intel_idle.c
index f5e301faa4761..e86ebbb89e65e 100644
--- a/drivers/idle/intel_idle.c
+++ b/drivers/idle/intel_idle.c
@@ -45,6 +45,7 @@
 #include <linux/kernel.h>
 #include <linux/cpuidle.h>
 #include <linux/tick.h>
+#include <linux/time64.h>
 #include <trace/events/power.h>
 #include <linux/sched.h>
 #include <linux/sched/smt.h>
@@ -78,6 +79,11 @@ static bool ibrs_off __read_mostly;
 
 /* The maximum allowed length for the 'table' module parameter  */
 #define MAX_CMDLINE_TABLE_LEN 256
+/* Maximum allowed C-state latency */
+#define MAX_CMDLINE_LATENCY_US (5 * USEC_PER_MSEC)
+/* Maximum allowed C-state target residency */
+#define MAX_CMDLINE_RESIDENCY_US (100 * USEC_PER_MSEC)
+
 static char cmdline_table_str[MAX_CMDLINE_TABLE_LEN] __read_mostly;
 
 static struct cpuidle_device __percpu *intel_idle_cpuidle_devices;
@@ -2461,6 +2467,41 @@ static char *get_cmdline_field(char *args, char **field, char sep)
 	return args + i + 1;
 }
 
+/**
+ * validate_cmdline_cstate - Validate a C-state from cmdline.
+ * @state: The C-state to validate.
+ * @prev_state: The previous C-state in the table or NULL.
+ *
+ * Return: 0 if the C-state is valid or -EINVAL otherwise.
+ */
+static int validate_cmdline_cstate(struct cpuidle_state *state,
+				   struct cpuidle_state *prev_state)
+{
+	if (state->exit_latency == 0)
+		/* Exit latency 0 can only be used for the POLL state */
+		return -EINVAL;
+
+	if (state->exit_latency > MAX_CMDLINE_LATENCY_US)
+		return -EINVAL;
+
+	if (state->target_residency > MAX_CMDLINE_RESIDENCY_US)
+		return -EINVAL;
+
+	if (state->target_residency < state->exit_latency)
+		return -EINVAL;
+
+	if (!prev_state)
+		return 0;
+
+	if (state->exit_latency <= prev_state->exit_latency)
+		return -EINVAL;
+
+	if (state->target_residency <= prev_state->target_residency)
+		return -EINVAL;
+
+	return 0;
+}
+
 /**
  * cmdline_table_adjust - Adjust the C-states table with data from cmdline.
  * @drv: cpuidle driver (assumed to point to intel_idle_driver).
@@ -2559,6 +2600,19 @@ static void __init cmdline_table_adjust(struct cpuidle_driver *drv)
 			state->name, state->exit_latency, state->target_residency);
 	}
 
+	/* Validate the adjusted C-states, start with index 1 to skip POLL */
+	for (i = 1; i < drv->state_count; i++) {
+		struct cpuidle_state *prev_state;
+
+		state = &cmdline_states[i];
+		prev_state = &cmdline_states[i - 1];
+
+		if (validate_cmdline_cstate(state, prev_state)) {
+			pr_err("C-state '%s' validation failed\n", state->name);
+			goto error;
+		}
+	}
+
 	/* Copy the adjusted C-states table back */
 	for (i = 1; i < drv->state_count; i++)
 		drv->states[i] = cmdline_states[i];
-- 
2.52.0


