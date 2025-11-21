Return-Path: <linux-pm+bounces-38344-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id DE948C7863C
	for <lists+linux-pm@lfdr.de>; Fri, 21 Nov 2025 11:13:27 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 8BACB4ECE6D
	for <lists+linux-pm@lfdr.de>; Fri, 21 Nov 2025 10:08:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 87BE6344058;
	Fri, 21 Nov 2025 10:03:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="Ygk8prVb"
X-Original-To: linux-pm@vger.kernel.org
Received: from mail-lj1-f182.google.com (mail-lj1-f182.google.com [209.85.208.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8D4353446AB
	for <linux-pm@vger.kernel.org>; Fri, 21 Nov 2025 10:03:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763719423; cv=none; b=mtqvvtLZJCJp8G9Aj0DTIErSIJWTOp0YtD1PDOq556IU2BEdNEtQzSB4FZf5lzU7s+Kpvy4lPnWSPx/dXo5EWCllHvI/wDs570fDDF3hsIZQWV+0J4DTDct0DpIk43DaDmsEUfT2Er5V/DhG9HhZxaYimySdai6VIT4n+oUsMh0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763719423; c=relaxed/simple;
	bh=GRcyPx6pS8Mo2Z6rJM/Yng60btmO1CA3xmrlBHaPA9U=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=E9RAXN6Vcu9HK1tbIchG/Rx7DkErwkkXm9G2FS/ZViRfg/vzMB+XCaYwj9dlv162bcoUniNaMXDwF1d2BMQjds/7A8Mfgxmsom93PxhKuj+t66E2hJ/Wl7WmCcwtsTQdWaK8gvtNl+rJlUY8M+yCTWbc5Kx5437Xx+l+gC61hmQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=Ygk8prVb; arc=none smtp.client-ip=209.85.208.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-lj1-f182.google.com with SMTP id 38308e7fff4ca-37b9d8122fdso14273491fa.3
        for <linux-pm@vger.kernel.org>; Fri, 21 Nov 2025 02:03:40 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1763719418; x=1764324218; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=1r4XBHNsj/0gz9zuqPrs6Ple3BrfMasT4Ktn9PEtMI8=;
        b=Ygk8prVbRid8bb2LA0izUa5Ust40C2inmPMvjyNY6nijV5vOlcqNkwS16csicUwpor
         Kwonh63APJqy6ibvkFIQEeqWTXmsCB8+4ofbWmsdlh+b+WYXmYXziyRfVNCu+qfVAOWL
         1gcszf26VlAGC78sd4R/WrHOkWZru1VZqLMODQOVfd6kYaWLYr2thcEWgQi0yg9ko209
         Bzk17dykuamwmZdGDcnNszoTrthzVifjuPe/tsSuZ7AKkw+t8UfkO/otQ7Kj0EFmOt+s
         w74Gtr7aiYgSuRWNz0LFCuC4Avb2I3wCWIWPWnkHLmUJ5Bc9UBzQpMrVUBoORRmtVui9
         faeA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1763719418; x=1764324218;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=1r4XBHNsj/0gz9zuqPrs6Ple3BrfMasT4Ktn9PEtMI8=;
        b=qcoqcHZC2pNyyuOFlIMrBbTPMZvXMqZV74VMy/TCSXm33ODMkSyQfhbMsPxZHG0twn
         zdNKysTAqv18yaNiSYJ5t4dMF6gFlYXpMSTY/pURW2tlQxtt6OHW/ksUlLlGh0qeaAvO
         ilALuXGfztFxfRZu7sxJl4nhlNMgORjStaTKvVqMi4q6rcI0jKeSVxYrTQ9dNmlh5GXi
         75qXNb4jvKp0ZHjGRSIf+IYoxuZME9dCZseRTup1Cl0KEK7/V+ktH+cG5P83BmbpfI5e
         0mJzN5Y6CA2jNU+vfQExOLFhUf8yDjUBDIvbeMNhYrf6g/PPh9pjC7UF5I3TaFfbT9dZ
         bVfA==
X-Forwarded-Encrypted: i=1; AJvYcCVfx0FJupRYu8QxIG9a91Tqr1BESu6EOd3cAG1ZYQ7gZ69wmprdu2b+gHN7HzRfu+cNgl7U6F8dAw==@vger.kernel.org
X-Gm-Message-State: AOJu0Yxa2tflNpmgyYjWvZakRYWKHFdx0kb8IAueIKYcvsNoz31a+z+B
	WxFu8ww44ub3tnSUzORnOocPs74+RRTIG+2uBRXZ6gFz0K1JybXPOCSNCEKd0k32F2A=
X-Gm-Gg: ASbGncvNzYj2S3heu3jUZQ+BCJa12EofbKGEUTAC/7d29AKXVk7/HTVqNclvJBa9sPX
	z67j0Og7fZMgsF5UZnPwG247xXPRGSvbbpxbcZsExF21B7c9rIcnrDXI2hfB+tmcr+d3jeXlTGy
	fe7cfnLQ9jnIDA1nT42Uhhg1UrphuYhRIoRhhVy1fZ7wZM8R82bnCF4S5GTE4DJJXx7s4Qy3ykh
	kO8H1AR9FoU2QgdbV9bjAhk6jlcPnntJ7RvaJpzZVZ4N03nUs2INSS7NoLdHN/gJW0wNeSfNgoD
	WRQ3g1Xq+0t5gTkb/H9mQq6J3JdzsK3H+YaPQ6QTu+qsoN+CnT0DW3R1Tk0C/fn8WtS+m/AjRoD
	/lc1U9q2abLRrYjhbo8zSYz0V010HTAv8nmcRA3prEKu1flxZ9snT8SfVIy2lwPYHx8odsDEoe7
	dpDRYYmkd63rUqApIigbfy/mJRyHhTwk1pZ5iiAVWJ36fj1tuRTNvomPjbgl6H
X-Google-Smtp-Source: AGHT+IFbZZlXsiqOlBDMPpDiOi/DBvwW1/TF85Ozxcxz75C1hy7utq5/v9TflE/lo+Wt4oJLXdanFA==
X-Received: by 2002:a05:651c:1448:b0:37b:9977:7e62 with SMTP id 38308e7fff4ca-37cd9262cecmr4943401fa.31.1763719418410;
        Fri, 21 Nov 2025 02:03:38 -0800 (PST)
Received: from uffe-tuxpro14.. (h-178-174-189-39.A498.priv.bahnhof.se. [178.174.189.39])
        by smtp.gmail.com with ESMTPSA id 38308e7fff4ca-37cc6b597b2sm11056181fa.12.2025.11.21.02.03.37
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 21 Nov 2025 02:03:37 -0800 (PST)
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
Subject: [PATCH v3 1/6] PM: QoS: Introduce a CPU system wakeup QoS limit
Date: Fri, 21 Nov 2025 11:03:07 +0100
Message-ID: <20251121100315.316300-2-ulf.hansson@linaro.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20251121100315.316300-1-ulf.hansson@linaro.org>
References: <20251121100315.316300-1-ulf.hansson@linaro.org>
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

Signed-off-by: Ulf Hansson <ulf.hansson@linaro.org>
---

Changes in v3:
	- Add Kconfig for the new interface (Rafael).
	- Updated commit message.

Changes in v2:
	- Renamings to reflect the QoS are limited to CPUs.
	- Move code inside "CONFIG_CPU_IDLE".
---
 include/linux/pm_qos.h |   9 ++++
 kernel/power/Kconfig   |   4 ++
 kernel/power/qos.c     | 106 +++++++++++++++++++++++++++++++++++++++++
 3 files changed, 119 insertions(+)

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
index 54a623680019..839e2dbb889e 100644
--- a/kernel/power/Kconfig
+++ b/kernel/power/Kconfig
@@ -202,6 +202,10 @@ config PM_WAKELOCKS_GC
 	depends on PM_WAKELOCKS
 	default y
 
+config PM_QOS_CPU_SYSTEM_WAKEUP
+	bool "User space interface for CPU system wakeup QoS"
+	depends on CPU_IDLE
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


