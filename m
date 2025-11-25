Return-Path: <linux-pm+bounces-38563-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [213.196.21.55])
	by mail.lfdr.de (Postfix) with ESMTPS id 3B15EC84B99
	for <lists+linux-pm@lfdr.de>; Tue, 25 Nov 2025 12:27:11 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id 80C7F34FCA7
	for <lists+linux-pm@lfdr.de>; Tue, 25 Nov 2025 11:27:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 496D9315D2A;
	Tue, 25 Nov 2025 11:27:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="xxSqO1hu"
X-Original-To: linux-pm@vger.kernel.org
Received: from mail-lf1-f52.google.com (mail-lf1-f52.google.com [209.85.167.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 319713148D7
	for <linux-pm@vger.kernel.org>; Tue, 25 Nov 2025 11:26:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1764070020; cv=none; b=b3H8F4ZNKYCxcIMvYJym/nOiScw7cj+UlCLZ/3PXeuby6WBDAhVr9xqm7j2INAu/FWaNgM2ZQfILo4CfPOT+YZj8KA7XqWpZbmDanZbQBm1mGrl0h/Xm2n0+vibE4b06ZvDnsD7wsSGO5cvjDsSp7foiI7CB2fEdkz9YKh3qAmw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1764070020; c=relaxed/simple;
	bh=36iGndTEM/3YoIZN6fKWhfnsw6ftPmJLUkt15edtXOk=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=LFBfwzYGTl0kylgkfAP1H1J3LGepMrR1d0c3A1Si3SEGvJhPT3QRGbbj1paWJPwVK1iKj8UEUFqSz3LWY5UAGBX/LMGkPkvCUw/wtK3Kq0WGchtAPZEcORUirLKlZ6IFIMDb9V69DCtHV9nAM1Bf6yziWNfhevqqtCyzqCGzRqM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=xxSqO1hu; arc=none smtp.client-ip=209.85.167.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-lf1-f52.google.com with SMTP id 2adb3069b0e04-5943b62c47dso5262257e87.1
        for <linux-pm@vger.kernel.org>; Tue, 25 Nov 2025 03:26:57 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1764070016; x=1764674816; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=FE45t6R4BBEDJliCvwSFl/kztT91PBe4qbzvkRlOVSY=;
        b=xxSqO1huq9U/U3KwH9GZJriZslv/CLFzWu7f8rUgkAx4FCXIzAbt2Fk+2D9HsSQfHy
         8geAfVK2rjlXuGvNA5RJt/2dok1+fyP8AyR0f7FGgMBv5HmUqWnB5dWPRQHPoo3in3Te
         F6/LrjBZQDi4Vrehw7lFzqtXZ8LKQlXzL5fd0MP3f0zmJ8z4S2o3DH8zAk82OSqBfMjB
         vjVftziOtvVaF5pL8jq2tcP3RpIhkY3luXCF0c/nqmyNmRX2OOIozfx4Pa6a4vnBDJ4C
         oMNYop8nKe5QoaNItObZtnhBxVWNc7ragvr+z6g0ee2MKFDhhAQPB5Er84hd+AKiLDzl
         BeEQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1764070016; x=1764674816;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=FE45t6R4BBEDJliCvwSFl/kztT91PBe4qbzvkRlOVSY=;
        b=qhxaarl0qAd7jKov7c/FT3n2K8wnL1WtBHjepUtPtijaxBj84NLPGNjS0wC2Ee9C9f
         vmGysYBbhw+3703txtBqa+YgT4OWSIDqt5omvwLqlffjg0Df0CgBbnKr4Pt2JQyi+pPD
         SRIED8f2xa0Yd/L9lgCppvnDmvWe+vRF58kQcneYOSmPCKgc/7ziOU2Thz87Zgf82p/D
         9zTp6uWT1H1Zb6X7GiUVOGkEmpK87H0vSP80eX8HMR+XKKYdHpHh4Wm98h2VJiEwxxRn
         Z1NxcOAd8oYYLo0kSXRXoPnB6agUaPFUYrozaIqDe0WiPDahX4uRwMICK8sSLwXySaOn
         G1bQ==
X-Forwarded-Encrypted: i=1; AJvYcCUA1KqBuq8dw0aDXoH71tTsNG2MtOOMfAQVJ/3v//ReypXt0Gu79Wx5c8EdzpOtVyJqFS2Moc5MvQ==@vger.kernel.org
X-Gm-Message-State: AOJu0Yyh9k106I5f3O3KsN7A/noCDr6BK9OnZOxDpAbsTEbA5w7F8XkJ
	BAT+LdfxRc3GQ4VLTJHGLvdCsEnZNLMAuzvoyaPer7KQ6625jRyg/wseR/fcNqAEhbI=
X-Gm-Gg: ASbGncvfjPvPmyjHed/X2wqulWKh/Y9Ae3phkM4Gugo/GrxbRf/IAt76livRXy2iZP0
	5tyFva0x3LMST7lmDkYeg+vAoter3ZokwKPiOIHZ4nJ7L4K5xh/g5sl+tLpK65wabqpxXjPLiph
	qNnyLaqdX83UD9q81Hz/S82aJBaxlwZqP3O4pTcdegjKlsWKcstBYDDkzXzHR5kyxs7ojYmr42K
	uI/ZXJLKbYvat03RC1B9JWOJJeNcFyxKLOP4xUOGkZGlQ+CeHTdI3fZDJnhbzDPUInFz+B3DT0S
	dk6tKwx98bWjsbrqlBB+Ef9fPOnlJhxuDpwvuSK8LuqdWTrZMA75bh2UYo5ZLtCVPRX7bkV0f7E
	iqheyNdkJyE8RvzV4FkQVaMGC+Vp8zGLSyvQiOCH6nVlhFPeQN2cxgXTR5Gr5kfMPCU7NW+jDgO
	ib10bItnfmr0Bwa5sgW1LgNsVLJxjsLA+Fl/mstADXR/391Edp98dBjeybMNA2
X-Google-Smtp-Source: AGHT+IHQFhuvGIxrbLvzBOY3ImdRr5h5AdplkQMA/mpy30IgWDqDJmZVd9KXsBer5wdbinI8H9eOhQ==
X-Received: by 2002:a05:6512:3341:b0:594:27dd:2700 with SMTP id 2adb3069b0e04-596a3ee51f6mr4340223e87.47.1764070016099;
        Tue, 25 Nov 2025 03:26:56 -0800 (PST)
Received: from uffe-tuxpro14.. (h-178-174-189-39.A498.priv.bahnhof.se. [178.174.189.39])
        by smtp.gmail.com with ESMTPSA id 2adb3069b0e04-5969db7563fsm4993526e87.2.2025.11.25.03.26.54
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 25 Nov 2025 03:26:55 -0800 (PST)
From: Ulf Hansson <ulf.hansson@linaro.org>
To: "Rafael J . Wysocki" <rafael@kernel.org>,
	linux-pm@vger.kernel.org
Cc: Vincent Guittot <vincent.guittot@linaro.org>,
	Peter Zijlstra <peterz@infradead.org>,
	Kevin Hilman <khilman@baylibre.com>,
	Pavel Machek <pavel@kernel.org>,
	Len Brown <len.brown@intel.com>,
	Daniel Lezcano <daniel.lezcano@linaro.org>,
	Maulik Shah <quic_mkshah@quicinc.com>,
	Prasad Sodagudi <psodagud@quicinc.com>,
	Dhruva Gole <d-gole@ti.com>,
	Deepti Jaggi <quic_djaggi@quicinc.com>,
	Ulf Hansson <ulf.hansson@linaro.org>,
	linux-kernel@vger.kernel.org
Subject: [PATCH v4 1/6] PM: QoS: Introduce a CPU system wakeup QoS limit
Date: Tue, 25 Nov 2025 12:26:42 +0100
Message-ID: <20251125112650.329269-2-ulf.hansson@linaro.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20251125112650.329269-1-ulf.hansson@linaro.org>
References: <20251125112650.329269-1-ulf.hansson@linaro.org>
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Some platforms supports multiple low power states for CPUs that can be used
when entering system-wide suspend. Currently we are always selecting the
deepest possible state for the CPUs, which can break the system wakeup
latency constraint that may be required for a use case.

Let's take the first step towards addressing this problem, by introducing
an interface for user space, that allows us to specify the CPU system
wakeup QoS limit. Subsequent changes will start taking into account the new
QoS limit.

Reviewed-by: Dhruva Gole <d-gole@ti.com>
Reviewed-by: Kevin Hilman (TI) <khilman@baylibre.com>
Tested-by: Kevin Hilman (TI) <khilman@baylibre.com>
Signed-off-by: Ulf Hansson <ulf.hansson@linaro.org>
---

Changes in v4:
	- Added Kconfig help (Dhruva).
	- Added tags.

Changes in v3:
	- Add Kconfig for the new interface (Rafael).
	- Updated commit message.

Changes in v2:
	- Renamings to reflect the QoS are limited to CPUs.
	- Move code inside "CONFIG_CPU_IDLE".
---
 include/linux/pm_qos.h |   9 ++++
 kernel/power/Kconfig   |  11 +++++
 kernel/power/qos.c     | 106 +++++++++++++++++++++++++++++++++++++++++
 3 files changed, 126 insertions(+)

diff --git a/include/linux/pm_qos.h b/include/linux/pm_qos.h
index 4a69d4af3ff8..6cea4455f867 100644
--- a/include/linux/pm_qos.h
+++ b/include/linux/pm_qos.h
@@ -162,6 +162,15 @@ static inline void cpu_latency_qos_update_request(struct pm_qos_request *req,
 static inline void cpu_latency_qos_remove_request(struct pm_qos_request *req) {}
 #endif
 
+#ifdef CONFIG_PM_QOS_CPU_SYSTEM_WAKEUP
+s32 cpu_wakeup_latency_qos_limit(void);
+#else
+static inline s32 cpu_wakeup_latency_qos_limit(void)
+{
+	return PM_QOS_RESUME_LATENCY_NO_CONSTRAINT;
+}
+#endif
+
 #ifdef CONFIG_PM
 enum pm_qos_flags_status __dev_pm_qos_flags(struct device *dev, s32 mask);
 enum pm_qos_flags_status dev_pm_qos_flags(struct device *dev, s32 mask);
diff --git a/kernel/power/Kconfig b/kernel/power/Kconfig
index 54a623680019..05337f437cca 100644
--- a/kernel/power/Kconfig
+++ b/kernel/power/Kconfig
@@ -202,6 +202,17 @@ config PM_WAKELOCKS_GC
 	depends on PM_WAKELOCKS
 	default y
 
+config PM_QOS_CPU_SYSTEM_WAKEUP
+	bool "User space interface for CPU system wakeup QoS"
+	depends on CPU_IDLE
+	help
+	  Enable this to allow user space via the cpu_wakeup_latency file to
+	  specify a CPU system wakeup latency limit.
+
+	  This may be particularly useful for platforms supporting multiple low
+	  power states for CPUs during system-wide suspend and s2idle in
+	  particular.
+
 config PM
 	bool "Device power management core functionality"
 	help
diff --git a/kernel/power/qos.c b/kernel/power/qos.c
index 4244b069442e..f7d8064e9adc 100644
--- a/kernel/power/qos.c
+++ b/kernel/power/qos.c
@@ -415,6 +415,105 @@ static struct miscdevice cpu_latency_qos_miscdev = {
 	.fops = &cpu_latency_qos_fops,
 };
 
+#ifdef CONFIG_PM_QOS_CPU_SYSTEM_WAKEUP
+/* The CPU system wakeup latency QoS. */
+static struct pm_qos_constraints cpu_wakeup_latency_constraints = {
+	.list = PLIST_HEAD_INIT(cpu_wakeup_latency_constraints.list),
+	.target_value = PM_QOS_RESUME_LATENCY_NO_CONSTRAINT,
+	.default_value = PM_QOS_RESUME_LATENCY_NO_CONSTRAINT,
+	.no_constraint_value = PM_QOS_RESUME_LATENCY_NO_CONSTRAINT,
+	.type = PM_QOS_MIN,
+};
+
+/**
+ * cpu_wakeup_latency_qos_limit - Current CPU system wakeup latency QoS limit.
+ *
+ * Returns the current CPU system wakeup latency QoS limit that may have been
+ * requested by user space.
+ */
+s32 cpu_wakeup_latency_qos_limit(void)
+{
+	return pm_qos_read_value(&cpu_wakeup_latency_constraints);
+}
+
+static int cpu_wakeup_latency_qos_open(struct inode *inode, struct file *filp)
+{
+	struct pm_qos_request *req;
+
+	req = kzalloc(sizeof(*req), GFP_KERNEL);
+	if (!req)
+		return -ENOMEM;
+
+	req->qos = &cpu_wakeup_latency_constraints;
+	pm_qos_update_target(req->qos, &req->node, PM_QOS_ADD_REQ,
+			     PM_QOS_RESUME_LATENCY_NO_CONSTRAINT);
+	filp->private_data = req;
+
+	return 0;
+}
+
+static int cpu_wakeup_latency_qos_release(struct inode *inode,
+					  struct file *filp)
+{
+	struct pm_qos_request *req = filp->private_data;
+
+	filp->private_data = NULL;
+	pm_qos_update_target(req->qos, &req->node, PM_QOS_REMOVE_REQ,
+			     PM_QOS_RESUME_LATENCY_NO_CONSTRAINT);
+	kfree(req);
+
+	return 0;
+}
+
+static ssize_t cpu_wakeup_latency_qos_read(struct file *filp, char __user *buf,
+					   size_t count, loff_t *f_pos)
+{
+	s32 value = pm_qos_read_value(&cpu_wakeup_latency_constraints);
+
+	return simple_read_from_buffer(buf, count, f_pos, &value, sizeof(s32));
+}
+
+static ssize_t cpu_wakeup_latency_qos_write(struct file *filp,
+					    const char __user *buf,
+					    size_t count, loff_t *f_pos)
+{
+	struct pm_qos_request *req = filp->private_data;
+	s32 value;
+
+	if (count == sizeof(s32)) {
+		if (copy_from_user(&value, buf, sizeof(s32)))
+			return -EFAULT;
+	} else {
+		int ret;
+
+		ret = kstrtos32_from_user(buf, count, 16, &value);
+		if (ret)
+			return ret;
+	}
+
+	if (value < 0)
+		return -EINVAL;
+
+	pm_qos_update_target(req->qos, &req->node, PM_QOS_UPDATE_REQ, value);
+
+	return count;
+}
+
+static const struct file_operations cpu_wakeup_latency_qos_fops = {
+	.open = cpu_wakeup_latency_qos_open,
+	.release = cpu_wakeup_latency_qos_release,
+	.read = cpu_wakeup_latency_qos_read,
+	.write = cpu_wakeup_latency_qos_write,
+	.llseek = noop_llseek,
+};
+
+static struct miscdevice cpu_wakeup_latency_qos_miscdev = {
+	.minor = MISC_DYNAMIC_MINOR,
+	.name = "cpu_wakeup_latency",
+	.fops = &cpu_wakeup_latency_qos_fops,
+};
+#endif /* CONFIG_PM_QOS_CPU_SYSTEM_WAKEUP */
+
 static int __init cpu_latency_qos_init(void)
 {
 	int ret;
@@ -424,6 +523,13 @@ static int __init cpu_latency_qos_init(void)
 		pr_err("%s: %s setup failed\n", __func__,
 		       cpu_latency_qos_miscdev.name);
 
+#ifdef CONFIG_PM_QOS_CPU_SYSTEM_WAKEUP
+	ret = misc_register(&cpu_wakeup_latency_qos_miscdev);
+	if (ret < 0)
+		pr_err("%s: %s setup failed\n", __func__,
+		       cpu_wakeup_latency_qos_miscdev.name);
+#endif
+
 	return ret;
 }
 late_initcall(cpu_latency_qos_init);
-- 
2.43.0


