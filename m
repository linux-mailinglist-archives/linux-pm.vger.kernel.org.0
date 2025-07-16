Return-Path: <linux-pm+bounces-30903-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id D99E5B075C6
	for <lists+linux-pm@lfdr.de>; Wed, 16 Jul 2025 14:36:00 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id D58371C26EF8
	for <lists+linux-pm@lfdr.de>; Wed, 16 Jul 2025 12:35:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 38AAB2F5C52;
	Wed, 16 Jul 2025 12:33:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="jBs68Z56"
X-Original-To: linux-pm@vger.kernel.org
Received: from mail-lj1-f172.google.com (mail-lj1-f172.google.com [209.85.208.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 354B41E4AE
	for <linux-pm@vger.kernel.org>; Wed, 16 Jul 2025 12:33:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752669230; cv=none; b=putP5clnhN8gR7YzwN2t8KtBwIFMH8Wq8OPAC4dH3nIVYSt4afj7Dn10UHiUbMYNm+ytkuG05gKeYDu1vh/cGrGPy72pSdCrsbrbbiqXR0Pk3WOOpeykVvJHlTZRjfZGxaVdJRGBBtrCwLOqsPPfizdgyLJkMDkAnHmOGj7d6ng=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752669230; c=relaxed/simple;
	bh=eAEoFvEDTvqGKJe3E3TphilXxDtGezqIPzxZRf+E1m4=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=rjwH9GsntkH2SXM7+slgXHnSSXfLfeATzWPNNDmGfrX6lo87yW5a55owEGG2s5hpAzS5WFHhVSMNaQDK8WMfv6Fvoe4aIT624Ohd0kKYDHX2qt2xRsJFeesg//YVspWxBElEqspX9Jf9FbiJldj68M64I9N/M1HJipwYq3ez/10=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=jBs68Z56; arc=none smtp.client-ip=209.85.208.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-lj1-f172.google.com with SMTP id 38308e7fff4ca-32b78b5aa39so57732501fa.1
        for <linux-pm@vger.kernel.org>; Wed, 16 Jul 2025 05:33:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1752669225; x=1753274025; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=OkDwg9Z86buzPjpSBkyXeXCd7fLEh0X0HNEXKRkal4k=;
        b=jBs68Z561BG62iY3C8TnykuSarqyjszuMarj8O/SuKAwElr6D69q7KFGCsZZAicWZP
         iiq0NSJMvOsc+cjng7ox78yY/nbtdCAG2A2eWkA5AEd06b8qNzNqYWejxRogJCDDx/Ud
         5TPXuD+q1qnlECD4aMmjJl9md3gW2R+6SpSFR/YXNHTyib3l/TIz8nIXYM67FlvVPQgU
         +xiyAMuzkj6gzxe4Q4vVuaAoben3Nu1lxlH41uAfFEBQIGqAyUt58pbdJT1O0alRRCW7
         syz0wNrObHMV3InbSlJQzPif6ndbVFzh4nwF8OS56R2pxpwstbWMm5kDgu99rm+u+lTh
         xMaQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1752669225; x=1753274025;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=OkDwg9Z86buzPjpSBkyXeXCd7fLEh0X0HNEXKRkal4k=;
        b=ed4SAtJJmtj+eVQelKp4X0qcfKykNcfNOanJGRIbC8NGt07Xpy9Rj85XH0KOyK3zwK
         cLO0nWVkj0XhvKc6j0os0xsv/NAyRVtPNJIXg9sGzutWeVGh1AvaI3u4lufbXknAufzw
         oX1jlNQ/wt3cvClYPKCfJxwEMxAhYGfIaOHrxiA81LGnbNTpylTVGl1+iiYsSm2ONtix
         DBp7bOTUqJZ9bq98XF7bzxzaG+eZ6TOotsLQKShsGfCXT3KcuqLNTULzd80OtS7sNGNl
         Uvdr/3tUkOyceRRCckT/HLeti/JOovQ+CRno0uAlrBsYC98cprDs9Rju0UYmdFYzktHT
         6qig==
X-Forwarded-Encrypted: i=1; AJvYcCW++QaewaetTh6bJbCdqFcu0YlPOo3ZMmVdN8Wjn5Umz34YAMosNjpTV0SJudQRJH+/t8SewmZGUA==@vger.kernel.org
X-Gm-Message-State: AOJu0Ywq+ni8E+L1uNpDkJX2nD8KG/s3g6JfO4UKjDGeGNR00vJsXqm+
	kmSZqPL5Gyh+j3F9dw1UUUEqzETSMu39MUxukaiIGhEK/1N9Ps4ridp0rJYQchFX/m8=
X-Gm-Gg: ASbGncsdMUfZSjOUzY9O2XmsKzMm9cG68Fa8qIEx8rU1wY/wamdoeiZOBJiay4vpMEf
	0ae6QwgAov3w1zdLMnw4cKms2GpMcaPJdL0D8+O192sxqL9ri2lTPV4pHYoKYL4oXk45pWw0HUh
	u94EZJ835ymfPZWpcaNRh7014J1mL3/2dPcV9A5fGAr5EDqwnVfbwJayjmcjKl4HvciY7bMFmKt
	U9x3Fhn+73yQ9f5Da3AWrojlRTDGLjTZZDihNYdbuKCtcdUEKiuW/1FXznPbeOYcyyfjX449eOV
	PAB4O7z7M0/mMuRqyl4nQGQGEtzdwaYlS1b2VZghaktaWVqJ6nNLrAEOqSd9TYS9yI3YtU1up7s
	riILLT7ZxgAcShFgBICv7Y9s2sm/6BaDhWNxlVsOab/3gKjjDqywj9uW4s5p5w6DLsk455foA
X-Google-Smtp-Source: AGHT+IHG98mZtuvNkqZvzA4vLTR1noVqA1xBF65Lev95RChrA7kTMsUpnxtT4HT7cd/pUSOzNKtHRQ==
X-Received: by 2002:a2e:a7c1:0:b0:32c:a771:9899 with SMTP id 38308e7fff4ca-3308f4b79afmr8286091fa.9.1752669225074;
        Wed, 16 Jul 2025 05:33:45 -0700 (PDT)
Received: from uffe-tuxpro14.. (h-178-174-189-39.A498.priv.bahnhof.se. [178.174.189.39])
        by smtp.gmail.com with ESMTPSA id 38308e7fff4ca-32fa29134d4sm21136211fa.22.2025.07.16.05.33.44
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 16 Jul 2025 05:33:44 -0700 (PDT)
From: Ulf Hansson <ulf.hansson@linaro.org>
To: "Rafael J . Wysocki" <rafael@kernel.org>,
	linux-pm@vger.kernel.org
Cc: Kevin Hilman <khilman@baylibre.com>,
	Pavel Machek <pavel@kernel.org>,
	Len Brown <len.brown@intel.com>,
	Daniel Lezcano <daniel.lezcano@linaro.org>,
	Saravana Kannan <saravanak@google.com>,
	Maulik Shah <quic_mkshah@quicinc.com>,
	Prasad Sodagudi <psodagud@quicinc.com>,
	Ulf Hansson <ulf.hansson@linaro.org>,
	linux-kernel@vger.kernel.org
Subject: [RFC/PATCH 1/3] PM: QoS: Introduce a system-wakeup QoS limit
Date: Wed, 16 Jul 2025 14:33:17 +0200
Message-ID: <20250716123323.65441-2-ulf.hansson@linaro.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20250716123323.65441-1-ulf.hansson@linaro.org>
References: <20250716123323.65441-1-ulf.hansson@linaro.org>
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Some platforms and devices supports multiple low-power-states than can be
used for system-wide suspend. Today these states are selected on per
subsystem basis and in most cases it's the deepest possible state that
becomes selected.

For some use-cases this is a problem as it isn't suitable or even breaks
the system-wakeup latency constraint, when we decide to enter these deeper
states during system-wide suspend.

Therefore, let's introduce an interface for user-space, allowing us to
specify the system-wakeup QoS limit. Subsequent changes will start taking
into account the QoS limit.

Signed-off-by: Ulf Hansson <ulf.hansson@linaro.org>
---
 include/linux/pm_qos.h |   9 ++++
 kernel/power/qos.c     | 114 +++++++++++++++++++++++++++++++++++++++++
 2 files changed, 123 insertions(+)

diff --git a/include/linux/pm_qos.h b/include/linux/pm_qos.h
index 4a69d4af3ff8..5f84084f19c8 100644
--- a/include/linux/pm_qos.h
+++ b/include/linux/pm_qos.h
@@ -143,6 +143,15 @@ bool pm_qos_update_flags(struct pm_qos_flags *pqf,
 			 struct pm_qos_flags_request *req,
 			 enum pm_qos_req_action action, s32 val);
 
+#ifdef CONFIG_PM_SLEEP
+s32 system_wakeup_latency_qos_limit(void);
+#else
+static inline s32 system_wakeup_latency_qos_limit(void)
+{
+	return PM_QOS_RESUME_LATENCY_NO_CONSTRAINT;
+}
+#endif
+
 #ifdef CONFIG_CPU_IDLE
 s32 cpu_latency_qos_limit(void);
 bool cpu_latency_qos_request_active(struct pm_qos_request *req);
diff --git a/kernel/power/qos.c b/kernel/power/qos.c
index 4244b069442e..fb496c220ffe 100644
--- a/kernel/power/qos.c
+++ b/kernel/power/qos.c
@@ -209,6 +209,120 @@ bool pm_qos_update_flags(struct pm_qos_flags *pqf,
 	return prev_value != curr_value;
 }
 
+#ifdef CONFIG_PM_SLEEP
+static struct pm_qos_constraints system_wakeup_latency_constraints = {
+	.list = PLIST_HEAD_INIT(system_wakeup_latency_constraints.list),
+	.target_value = PM_QOS_RESUME_LATENCY_NO_CONSTRAINT,
+	.default_value = PM_QOS_RESUME_LATENCY_NO_CONSTRAINT,
+	.no_constraint_value = PM_QOS_RESUME_LATENCY_NO_CONSTRAINT,
+	.type = PM_QOS_MIN,
+};
+
+/**
+ * system_wakeup_latency_qos_limit - Current system wakeup latency QoS limit.
+ *
+ * Returns the current system wakeup latency QoS limit that may have been
+ * requested by user-space.
+ */
+s32 system_wakeup_latency_qos_limit(void)
+{
+	return pm_qos_read_value(&system_wakeup_latency_constraints);
+}
+
+static int system_wakeup_latency_qos_open(struct inode *inode,
+					  struct file *filp)
+{
+	struct pm_qos_request *req;
+
+	req = kzalloc(sizeof(*req), GFP_KERNEL);
+	if (!req)
+		return -ENOMEM;
+
+	req->qos = &system_wakeup_latency_constraints;
+	pm_qos_update_target(req->qos, &req->node, PM_QOS_ADD_REQ,
+			     PM_QOS_RESUME_LATENCY_NO_CONSTRAINT);
+	filp->private_data = req;
+
+	return 0;
+}
+
+static int system_wakeup_latency_qos_release(struct inode *inode,
+					     struct file *filp)
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
+static ssize_t system_wakeup_latency_qos_read(struct file *filp,
+					      char __user *buf,
+					      size_t count,
+					      loff_t *f_pos)
+{
+	s32 value = pm_qos_read_value(&system_wakeup_latency_constraints);
+
+	return simple_read_from_buffer(buf, count, f_pos, &value, sizeof(s32));
+}
+
+static ssize_t system_wakeup_latency_qos_write(struct file *filp,
+					       const char __user *buf,
+					       size_t count, loff_t *f_pos)
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
+static const struct file_operations system_wakeup_latency_qos_fops = {
+	.open = system_wakeup_latency_qos_open,
+	.release = system_wakeup_latency_qos_release,
+	.read = system_wakeup_latency_qos_read,
+	.write = system_wakeup_latency_qos_write,
+	.llseek = noop_llseek,
+};
+
+static struct miscdevice system_wakeup_latency_qos_miscdev = {
+	.minor = MISC_DYNAMIC_MINOR,
+	.name = "system_wakeup_latency",
+	.fops = &system_wakeup_latency_qos_fops,
+};
+
+static int __init system_wakeup_latency_qos_init(void)
+{
+	int ret;
+
+	ret = misc_register(&system_wakeup_latency_qos_miscdev);
+	if (ret < 0)
+		pr_err("%s: %s setup failed\n", __func__,
+		       system_wakeup_latency_qos_miscdev.name);
+
+	return ret;
+}
+late_initcall(system_wakeup_latency_qos_init);
+#endif /* CONFIG_PM_SLEEP */
+
 #ifdef CONFIG_CPU_IDLE
 /* Definitions related to the CPU latency QoS. */
 
-- 
2.43.0


