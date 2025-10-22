Return-Path: <linux-pm+bounces-36639-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id BDA02BFB5E6
	for <lists+linux-pm@lfdr.de>; Wed, 22 Oct 2025 12:19:45 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 46B373AC116
	for <lists+linux-pm@lfdr.de>; Wed, 22 Oct 2025 10:19:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 33010318136;
	Wed, 22 Oct 2025 10:19:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="Tj97Qx82"
X-Original-To: linux-pm@vger.kernel.org
Received: from mail-pl1-f174.google.com (mail-pl1-f174.google.com [209.85.214.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 04B713101B8
	for <linux-pm@vger.kernel.org>; Wed, 22 Oct 2025 10:19:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761128382; cv=none; b=pWidBn7BXa3BMvLmU5PM7mku2b4BI+c7K3BCC+wzsPnL3vzzjRuKHlV8qNDXiibRWAYfzhT3vRwpDZ4W/kFkeV42h5elMPOsSAG7NGDM+dcM7dw3MMYrLZwIJ/YznfE6DnQE3/ILS8ZA1V9ZVcW77VppWmjBirnX8NpNhlh6Kc4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761128382; c=relaxed/simple;
	bh=g8bP09neRyVPGqXRxBX6g+Ff+6R9dt/dDpUQoT4LEQ4=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=aLIFJyM7wcX0/3ZNkrWhWB18jsh+nF37Scac+qLNT5leoKwu9UteCgUsw2mDAIwo/WRPNWKeLMmqwnHI+5ifcL56EYTt94gbQx5LR9vJ8iZMign4PVdtEhSrr99huB+ZJ5C6UUfogyD/h3qJXyVh9zZPRfOzeiqmmeKO4mTnm1k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=Tj97Qx82; arc=none smtp.client-ip=209.85.214.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-pl1-f174.google.com with SMTP id d9443c01a7336-27d3540a43fso69944225ad.3
        for <linux-pm@vger.kernel.org>; Wed, 22 Oct 2025 03:19:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1761128379; x=1761733179; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=iTVxccybkJLov4088ciV6Z5wdYGri//1KH5iySoOtL4=;
        b=Tj97Qx8252g3V2Bp8H4kDgnRjPL1Uf5YYXDw0RSBto+gbVOTowRRmpjs2bbEU6ItFO
         F0tHZdRHOTdssOsCtQmQHsgAftEwuU31OKwmFz5GW8QbR5aNXp2DjXZYByIusaCmMy6f
         D8ga4uEWqK/nxTKteZLnrUKdi175d8sVv3RIlplIKX79pEFcU2RhMElIFa+rd86UPPOq
         xw65pSiLoDbvds5y/PRbpE/hYrVIlmzQ7k84oIX9PCTNs0VKaCb8oOOkUBzw4lms6ON7
         86tl/dJr1rox9pbsLcZnA159/7hG+kf18OUQd5Xw7vj0IcDI05T9DLB2yD3RoB1jcvqG
         hD1Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1761128379; x=1761733179;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=iTVxccybkJLov4088ciV6Z5wdYGri//1KH5iySoOtL4=;
        b=A9bGWH60UV5h4U2Ww8jyBPtCeFpr3Zoe6q6tr9IWiND+OMg82CG4rx+7PiAFPNuJom
         FnV2wy3VmseEoZ0141/SMXHkIcYKck8swIFSAxpFMscS8iOsjaVvI3I48d9+bSAffDXt
         0pb+WEOqfs48Gt0PH5GoaAwyixXaw1CogaXev21lu3R5hZPyEwhJQmthvGiyNqlTQwac
         SBncVzFsltJW0HE0Y2BHlNa8PvXeBtYWMAo3ww5qw8gvTTwFtnYzAHailEbqO1cE20Pe
         9zoRFDfl7XOWv1nfQ2zRR4im1nlBsmcseyquQ3jADq1N65YOudHeLN2CVqpdz0uNmGPC
         1KrQ==
X-Forwarded-Encrypted: i=1; AJvYcCXwY9meCGDQmDxPlGeYUwQ/RYnG7rQ9oggvI1vJpoo9zsGjgyjOLwDu2c6zXEpfT8kLCiYrNEONMQ==@vger.kernel.org
X-Gm-Message-State: AOJu0YzxbZAzMvIqq7Z+9FJxtTWMfTOwr8fS44gme2OONXDUm8J3dUjI
	c+8qm3tMDzkC7n44xSyZW/yO0Gf9yuM2i5xoo3rdmM7E5GEkZNYx6Z4UVmX8r0KJ1xQ=
X-Gm-Gg: ASbGncu5zMkoGcw/zhVob2MXSi+xV/J/rTHXG/Ebd8Nfloduz3YLCX87bSSxX6fEvuA
	3Y2TGRtHa88PA8dlQZVKLMqH3cOvyvizcF8RFqbtIovIClZjCw9b99HYBlvAqNZaNSQJgqBaeel
	RMySAaFrDpIPxXwVVvDyzsAPZMucTMqPszHUDTqSLcuSuwhPiwoNb9eRG1B7yM+5Vmo4hXyi14k
	mAxNaHELEBsAv94owhv8Ky5YtC/AiGe9V8CTtR+nXWysKVbAhv3Y0qH7vZDBBDzeq3wdpEDta9T
	UjWtpG0WLUnRsjXUJXkEiML0A/YCx1eFT/2vhFHLTKYQXXbpIrFYA6gW8lAHtjp700t+kNSQCvV
	y0OeHCchl+o1uVuMotSMCNkiaxhifLdBkt0f0/yxgD4VGo3boow/Ik5vPU31MoHLo6lhoYdv3gv
	eOzQ==
X-Google-Smtp-Source: AGHT+IGysVzDTFuCDdgwjdFeSdHAdM3j35uKumKgjn13XG82BVcgu8Td80SkoY1oYqyBIWu6KbCPkA==
X-Received: by 2002:a17:903:1a4c:b0:267:9aa5:f6a6 with SMTP id d9443c01a7336-290c9cbbf23mr131832765ad.19.1761128378951;
        Wed, 22 Oct 2025 03:19:38 -0700 (PDT)
Received: from localhost ([122.172.87.183])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-292471d5beasm135507605ad.76.2025.10.22.03.19.37
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 22 Oct 2025 03:19:38 -0700 (PDT)
From: Viresh Kumar <viresh.kumar@linaro.org>
To: "Rafael J. Wysocki" <rafael@kernel.org>,
	Viresh Kumar <vireshk@kernel.org>,
	Nishanth Menon <nm@ti.com>,
	Stephen Boyd <sboyd@kernel.org>
Cc: Viresh Kumar <viresh.kumar@linaro.org>,
	linux-pm@vger.kernel.org,
	Vincent Guittot <vincent.guittot@linaro.org>,
	Joe Perches <joe@perches.com>,
	Dan Carpenter <dan.carpenter@linaro.org>,
	linux-kernel@vger.kernel.org
Subject: [PATCH] OPP: Initialize scope-based pointers inline
Date: Wed, 22 Oct 2025 15:49:21 +0530
Message-Id: <45a64ff434a027c296d1d5c35f442e51378c9425.1761128347.git.viresh.kumar@linaro.org>
X-Mailer: git-send-email 2.31.1.272.g89b43f80a514
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Uninitialized pointers with `__free` attribute can cause undefined
behaviour as the memory allocated to the pointer is freed automatically
when the pointer goes out of scope.

The OPP core doesn't have any bugs related to this as of now, but it is
better to initialize pointers marked with `__free` attribute at
declaration to simplify the code and ensure proper scope-based cleanup.

Reported-by: Joe Perches <joe@perches.com>
Reported-by: Dan Carpenter <dan.carpenter@linaro.org>
Signed-off-by: Viresh Kumar <viresh.kumar@linaro.org>
---
 drivers/opp/core.c | 68 +++++++++++++++------------------
 drivers/opp/cpu.c  | 13 +++----
 drivers/opp/of.c   | 95 ++++++++++++++++++++++------------------------
 3 files changed, 82 insertions(+), 94 deletions(-)

diff --git a/drivers/opp/core.c b/drivers/opp/core.c
index bba4f7daff8c..322ce532c683 100644
--- a/drivers/opp/core.c
+++ b/drivers/opp/core.c
@@ -309,9 +309,8 @@ EXPORT_SYMBOL_GPL(dev_pm_opp_is_turbo);
  */
 unsigned long dev_pm_opp_get_max_clock_latency(struct device *dev)
 {
-	struct opp_table *opp_table __free(put_opp_table);
-
-	opp_table = _find_opp_table(dev);
+	struct opp_table *opp_table __free(put_opp_table) =
+		_find_opp_table(dev);
 	if (IS_ERR(opp_table))
 		return 0;
 
@@ -327,7 +326,6 @@ EXPORT_SYMBOL_GPL(dev_pm_opp_get_max_clock_latency);
  */
 unsigned long dev_pm_opp_get_max_volt_latency(struct device *dev)
 {
-	struct opp_table *opp_table __free(put_opp_table);
 	struct dev_pm_opp *opp;
 	struct regulator *reg;
 	unsigned long latency_ns = 0;
@@ -337,7 +335,8 @@ unsigned long dev_pm_opp_get_max_volt_latency(struct device *dev)
 		unsigned long max;
 	} *uV;
 
-	opp_table = _find_opp_table(dev);
+	struct opp_table *opp_table __free(put_opp_table) =
+		_find_opp_table(dev);
 	if (IS_ERR(opp_table))
 		return 0;
 
@@ -409,10 +408,10 @@ EXPORT_SYMBOL_GPL(dev_pm_opp_get_max_transition_latency);
  */
 unsigned long dev_pm_opp_get_suspend_opp_freq(struct device *dev)
 {
-	struct opp_table *opp_table __free(put_opp_table);
 	unsigned long freq = 0;
 
-	opp_table = _find_opp_table(dev);
+	struct opp_table *opp_table __free(put_opp_table) =
+		_find_opp_table(dev);
 	if (IS_ERR(opp_table))
 		return 0;
 
@@ -447,9 +446,8 @@ int _get_opp_count(struct opp_table *opp_table)
  */
 int dev_pm_opp_get_opp_count(struct device *dev)
 {
-	struct opp_table *opp_table __free(put_opp_table);
-
-	opp_table = _find_opp_table(dev);
+	struct opp_table *opp_table __free(put_opp_table) =
+		_find_opp_table(dev);
 	if (IS_ERR(opp_table)) {
 		dev_dbg(dev, "%s: OPP table not found (%ld)\n",
 			__func__, PTR_ERR(opp_table));
@@ -605,9 +603,8 @@ _find_key(struct device *dev, unsigned long *key, int index, bool available,
 			  unsigned long opp_key, unsigned long key),
 	  bool (*assert)(struct opp_table *opp_table, unsigned int index))
 {
-	struct opp_table *opp_table __free(put_opp_table);
-
-	opp_table = _find_opp_table(dev);
+	struct opp_table *opp_table __free(put_opp_table) =
+		_find_opp_table(dev);
 	if (IS_ERR(opp_table)) {
 		dev_err(dev, "%s: OPP table not found (%ld)\n", __func__,
 			PTR_ERR(opp_table));
@@ -1410,12 +1407,12 @@ static int _set_opp(struct device *dev, struct opp_table *opp_table,
  */
 int dev_pm_opp_set_rate(struct device *dev, unsigned long target_freq)
 {
-	struct opp_table *opp_table __free(put_opp_table);
 	struct dev_pm_opp *opp __free(put_opp) = NULL;
 	unsigned long freq = 0, temp_freq;
 	bool forced = false;
 
-	opp_table = _find_opp_table(dev);
+	struct opp_table *opp_table __free(put_opp_table) =
+		_find_opp_table(dev);
 	if (IS_ERR(opp_table)) {
 		dev_err(dev, "%s: device's opp table doesn't exist\n", __func__);
 		return PTR_ERR(opp_table);
@@ -1477,9 +1474,8 @@ EXPORT_SYMBOL_GPL(dev_pm_opp_set_rate);
  */
 int dev_pm_opp_set_opp(struct device *dev, struct dev_pm_opp *opp)
 {
-	struct opp_table *opp_table __free(put_opp_table);
-
-	opp_table = _find_opp_table(dev);
+	struct opp_table *opp_table __free(put_opp_table) =
+		_find_opp_table(dev);
 	if (IS_ERR(opp_table)) {
 		dev_err(dev, "%s: device opp doesn't exist\n", __func__);
 		return PTR_ERR(opp_table);
@@ -1794,10 +1790,10 @@ EXPORT_SYMBOL_GPL(dev_pm_opp_put);
  */
 void dev_pm_opp_remove(struct device *dev, unsigned long freq)
 {
-	struct opp_table *opp_table __free(put_opp_table);
 	struct dev_pm_opp *opp = NULL, *iter;
 
-	opp_table = _find_opp_table(dev);
+	struct opp_table *opp_table __free(put_opp_table) =
+		_find_opp_table(dev);
 	if (IS_ERR(opp_table))
 		return;
 
@@ -1885,9 +1881,8 @@ bool _opp_remove_all_static(struct opp_table *opp_table)
  */
 void dev_pm_opp_remove_all_dynamic(struct device *dev)
 {
-	struct opp_table *opp_table __free(put_opp_table);
-
-	opp_table = _find_opp_table(dev);
+	struct opp_table *opp_table __free(put_opp_table) =
+		_find_opp_table(dev);
 	if (IS_ERR(opp_table))
 		return;
 
@@ -2871,10 +2866,10 @@ static int _opp_set_availability(struct device *dev, unsigned long freq,
 				 bool availability_req)
 {
 	struct dev_pm_opp *opp __free(put_opp) = ERR_PTR(-ENODEV), *tmp_opp;
-	struct opp_table *opp_table __free(put_opp_table);
 
 	/* Find the opp_table */
-	opp_table = _find_opp_table(dev);
+	struct opp_table *opp_table __free(put_opp_table) =
+		_find_opp_table(dev);
 	if (IS_ERR(opp_table)) {
 		dev_warn(dev, "%s: Device OPP not found (%ld)\n", __func__,
 			 PTR_ERR(opp_table));
@@ -2932,11 +2927,11 @@ int dev_pm_opp_adjust_voltage(struct device *dev, unsigned long freq,
 
 {
 	struct dev_pm_opp *opp __free(put_opp) = ERR_PTR(-ENODEV), *tmp_opp;
-	struct opp_table *opp_table __free(put_opp_table);
 	int r;
 
 	/* Find the opp_table */
-	opp_table = _find_opp_table(dev);
+	struct opp_table *opp_table __free(put_opp_table) =
+		_find_opp_table(dev);
 	if (IS_ERR(opp_table)) {
 		r = PTR_ERR(opp_table);
 		dev_warn(dev, "%s: Device OPP not found (%d)\n", __func__, r);
@@ -2986,12 +2981,12 @@ EXPORT_SYMBOL_GPL(dev_pm_opp_adjust_voltage);
  */
 int dev_pm_opp_sync_regulators(struct device *dev)
 {
-	struct opp_table *opp_table __free(put_opp_table);
 	struct regulator *reg;
 	int ret, i;
 
 	/* Device may not have OPP table */
-	opp_table = _find_opp_table(dev);
+	struct opp_table *opp_table __free(put_opp_table) =
+		_find_opp_table(dev);
 	if (IS_ERR(opp_table))
 		return 0;
 
@@ -3062,9 +3057,8 @@ EXPORT_SYMBOL_GPL(dev_pm_opp_disable);
  */
 int dev_pm_opp_register_notifier(struct device *dev, struct notifier_block *nb)
 {
-	struct opp_table *opp_table __free(put_opp_table);
-
-	opp_table = _find_opp_table(dev);
+	struct opp_table *opp_table __free(put_opp_table) =
+		_find_opp_table(dev);
 	if (IS_ERR(opp_table))
 		return PTR_ERR(opp_table);
 
@@ -3082,9 +3076,8 @@ EXPORT_SYMBOL(dev_pm_opp_register_notifier);
 int dev_pm_opp_unregister_notifier(struct device *dev,
 				   struct notifier_block *nb)
 {
-	struct opp_table *opp_table __free(put_opp_table);
-
-	opp_table = _find_opp_table(dev);
+	struct opp_table *opp_table __free(put_opp_table) =
+		_find_opp_table(dev);
 	if (IS_ERR(opp_table))
 		return PTR_ERR(opp_table);
 
@@ -3101,10 +3094,9 @@ EXPORT_SYMBOL(dev_pm_opp_unregister_notifier);
  */
 void dev_pm_opp_remove_table(struct device *dev)
 {
-	struct opp_table *opp_table __free(put_opp_table);
-
 	/* Check for existing table for 'dev' */
-	opp_table = _find_opp_table(dev);
+	struct opp_table *opp_table __free(put_opp_table) =
+		_find_opp_table(dev);
 	if (IS_ERR(opp_table)) {
 		int error = PTR_ERR(opp_table);
 
diff --git a/drivers/opp/cpu.c b/drivers/opp/cpu.c
index 97989d4fe336..915be69dbefd 100644
--- a/drivers/opp/cpu.c
+++ b/drivers/opp/cpu.c
@@ -56,10 +56,9 @@ int dev_pm_opp_init_cpufreq_table(struct device *dev,
 		return -ENOMEM;
 
 	for (i = 0, rate = 0; i < max_opps; i++, rate++) {
-		struct dev_pm_opp *opp __free(put_opp);
-
 		/* find next rate */
-		opp = dev_pm_opp_find_freq_ceil(dev, &rate);
+		struct dev_pm_opp *opp __free(put_opp) =
+			dev_pm_opp_find_freq_ceil(dev, &rate);
 		if (IS_ERR(opp)) {
 			ret = PTR_ERR(opp);
 			goto out;
@@ -154,12 +153,12 @@ EXPORT_SYMBOL_GPL(dev_pm_opp_cpumask_remove_table);
 int dev_pm_opp_set_sharing_cpus(struct device *cpu_dev,
 				const struct cpumask *cpumask)
 {
-	struct opp_table *opp_table __free(put_opp_table);
 	struct opp_device *opp_dev;
 	struct device *dev;
 	int cpu;
 
-	opp_table = _find_opp_table(cpu_dev);
+	struct opp_table *opp_table __free(put_opp_table) =
+		_find_opp_table(cpu_dev);
 	if (IS_ERR(opp_table))
 		return PTR_ERR(opp_table);
 
@@ -201,10 +200,10 @@ EXPORT_SYMBOL_GPL(dev_pm_opp_set_sharing_cpus);
  */
 int dev_pm_opp_get_sharing_cpus(struct device *cpu_dev, struct cpumask *cpumask)
 {
-	struct opp_table *opp_table __free(put_opp_table);
 	struct opp_device *opp_dev;
 
-	opp_table = _find_opp_table(cpu_dev);
+	struct opp_table *opp_table __free(put_opp_table) =
+		_find_opp_table(cpu_dev);
 	if (IS_ERR(opp_table))
 		return PTR_ERR(opp_table);
 
diff --git a/drivers/opp/of.c b/drivers/opp/of.c
index 505d79821584..973fad05f94f 100644
--- a/drivers/opp/of.c
+++ b/drivers/opp/of.c
@@ -45,9 +45,9 @@ EXPORT_SYMBOL_GPL(dev_pm_opp_of_get_opp_desc_node);
 struct opp_table *_managed_opp(struct device *dev, int index)
 {
 	struct opp_table *opp_table, *managed_table = NULL;
-	struct device_node *np __free(device_node);
 
-	np = _opp_of_get_opp_desc_node(dev->of_node, index);
+	struct device_node *np __free(device_node) =
+		_opp_of_get_opp_desc_node(dev->of_node, index);
 	if (!np)
 		return NULL;
 
@@ -95,10 +95,10 @@ static struct device_node *of_parse_required_opp(struct device_node *np,
 /* The caller must call dev_pm_opp_put_opp_table() after the table is used */
 static struct opp_table *_find_table_of_opp_np(struct device_node *opp_np)
 {
-	struct device_node *opp_table_np __free(device_node);
 	struct opp_table *opp_table;
 
-	opp_table_np = of_get_parent(opp_np);
+	struct device_node *opp_table_np __free(device_node) =
+		of_get_parent(opp_np);
 	if (!opp_table_np)
 		return ERR_PTR(-ENODEV);
 
@@ -146,12 +146,12 @@ static void _opp_table_alloc_required_tables(struct opp_table *opp_table,
 					     struct device_node *opp_np)
 {
 	struct opp_table **required_opp_tables;
-	struct device_node *np __free(device_node);
 	bool lazy = false;
 	int count, i, size;
 
 	/* Traversing the first OPP node is all we need */
-	np = of_get_next_available_child(opp_np, NULL);
+	struct device_node *np __free(device_node) =
+		of_get_next_available_child(opp_np, NULL);
 	if (!np) {
 		dev_warn(dev, "Empty OPP table\n");
 		return;
@@ -171,9 +171,8 @@ static void _opp_table_alloc_required_tables(struct opp_table *opp_table,
 	opp_table->required_opp_count = count;
 
 	for (i = 0; i < count; i++) {
-		struct device_node *required_np __free(device_node);
-
-		required_np = of_parse_required_opp(np, i);
+		struct device_node *required_np __free(device_node) =
+			of_parse_required_opp(np, i);
 		if (!required_np) {
 			_opp_table_free_required_tables(opp_table);
 			return;
@@ -199,14 +198,14 @@ static void _opp_table_alloc_required_tables(struct opp_table *opp_table,
 void _of_init_opp_table(struct opp_table *opp_table, struct device *dev,
 			int index)
 {
-	struct device_node *np __free(device_node), *opp_np;
+	struct device_node *opp_np;
 	u32 val;
 
 	/*
 	 * Only required for backward compatibility with v1 bindings, but isn't
 	 * harmful for other cases. And so we do it unconditionally.
 	 */
-	np = of_node_get(dev->of_node);
+	struct device_node *np __free(device_node) = of_node_get(dev->of_node);
 	if (!np)
 		return;
 
@@ -273,9 +272,8 @@ void _of_clear_opp(struct opp_table *opp_table, struct dev_pm_opp *opp)
 static int _link_required_opps(struct dev_pm_opp *opp,
 			       struct opp_table *required_table, int index)
 {
-	struct device_node *np __free(device_node);
-
-	np = of_parse_required_opp(opp->np, index);
+	struct device_node *np __free(device_node) =
+		of_parse_required_opp(opp->np, index);
 	if (unlikely(!np))
 		return -ENODEV;
 
@@ -349,16 +347,13 @@ static void lazy_link_required_opp_table(struct opp_table *new_table)
 	guard(mutex)(&opp_table_lock);
 
 	list_for_each_entry_safe(opp_table, temp, &lazy_opp_tables, lazy) {
-		struct device_node *opp_np __free(device_node);
 		bool lazy = false;
 
 		/* opp_np can't be invalid here */
-		opp_np = of_get_next_available_child(opp_table->np, NULL);
+		struct device_node *opp_np __free(device_node) =
+			of_get_next_available_child(opp_table->np, NULL);
 
 		for (i = 0; i < opp_table->required_opp_count; i++) {
-			struct device_node *required_np __free(device_node) = NULL;
-			struct device_node *required_table_np __free(device_node) = NULL;
-
 			required_opp_tables = opp_table->required_opp_tables;
 
 			/* Required opp-table is already parsed */
@@ -366,8 +361,10 @@ static void lazy_link_required_opp_table(struct opp_table *new_table)
 				continue;
 
 			/* required_np can't be invalid here */
-			required_np = of_parse_required_opp(opp_np, i);
-			required_table_np = of_get_parent(required_np);
+			struct device_node *required_np __free(device_node) =
+				of_parse_required_opp(opp_np, i);
+			struct device_node *required_table_np __free(device_node) =
+				of_get_parent(required_np);
 
 			/*
 			 * Newly added table isn't the required opp-table for
@@ -402,7 +399,6 @@ static void lazy_link_required_opp_table(struct opp_table *new_table)
 static int _bandwidth_supported(struct device *dev, struct opp_table *opp_table)
 {
 	struct device_node *opp_np __free(device_node) = NULL;
-	struct device_node *np __free(device_node) = NULL;
 	struct property *prop;
 
 	if (!opp_table) {
@@ -422,7 +418,8 @@ static int _bandwidth_supported(struct device *dev, struct opp_table *opp_table)
 		return 0;
 
 	/* Checking only first OPP is sufficient */
-	np = of_get_next_available_child(opp_np, NULL);
+	struct device_node *np __free(device_node) =
+		of_get_next_available_child(opp_np, NULL);
 	if (!np) {
 		dev_err(dev, "OPP table empty\n");
 		return -EINVAL;
@@ -1269,11 +1266,11 @@ EXPORT_SYMBOL_GPL(dev_pm_opp_of_cpumask_add_table);
 int dev_pm_opp_of_get_sharing_cpus(struct device *cpu_dev,
 				   struct cpumask *cpumask)
 {
-	struct device_node *np __free(device_node);
 	int cpu;
 
 	/* Get OPP descriptor node */
-	np = dev_pm_opp_of_get_opp_desc_node(cpu_dev);
+	struct device_node *np __free(device_node) =
+		dev_pm_opp_of_get_opp_desc_node(cpu_dev);
 	if (!np) {
 		dev_dbg(cpu_dev, "%s: Couldn't find opp node.\n", __func__);
 		return -ENOENT;
@@ -1286,13 +1283,11 @@ int dev_pm_opp_of_get_sharing_cpus(struct device *cpu_dev,
 		return 0;
 
 	for_each_possible_cpu(cpu) {
-		struct device_node *cpu_np __free(device_node) = NULL;
-		struct device_node *tmp_np __free(device_node) = NULL;
-
 		if (cpu == cpu_dev->id)
 			continue;
 
-		cpu_np = of_cpu_device_node_get(cpu);
+		struct device_node *cpu_np __free(device_node) =
+			of_cpu_device_node_get(cpu);
 		if (!cpu_np) {
 			dev_err(cpu_dev, "%s: failed to get cpu%d node\n",
 				__func__, cpu);
@@ -1300,7 +1295,8 @@ int dev_pm_opp_of_get_sharing_cpus(struct device *cpu_dev,
 		}
 
 		/* Get OPP descriptor node */
-		tmp_np = _opp_of_get_opp_desc_node(cpu_np, 0);
+		struct device_node *tmp_np __free(device_node) =
+			_opp_of_get_opp_desc_node(cpu_np, 0);
 		if (!tmp_np) {
 			pr_err("%pOF: Couldn't find opp node\n", cpu_np);
 			return -ENOENT;
@@ -1328,16 +1324,15 @@ EXPORT_SYMBOL_GPL(dev_pm_opp_of_get_sharing_cpus);
  */
 int of_get_required_opp_performance_state(struct device_node *np, int index)
 {
-	struct device_node *required_np __free(device_node);
-	struct opp_table *opp_table __free(put_opp_table) = NULL;
-	struct dev_pm_opp *opp __free(put_opp) = NULL;
 	int pstate = -EINVAL;
 
-	required_np = of_parse_required_opp(np, index);
+	struct device_node *required_np __free(device_node)
+		= of_parse_required_opp(np, index);
 	if (!required_np)
 		return -ENODEV;
 
-	opp_table = _find_table_of_opp_np(required_np);
+	struct opp_table *opp_table __free(put_opp_table) =
+		_find_table_of_opp_np(required_np);
 	if (IS_ERR(opp_table)) {
 		pr_err("%s: Failed to find required OPP table %pOF: %ld\n",
 		       __func__, np, PTR_ERR(opp_table));
@@ -1350,7 +1345,8 @@ int of_get_required_opp_performance_state(struct device_node *np, int index)
 		return -EINVAL;
 	}
 
-	opp = _find_opp_of_np(opp_table, required_np);
+	struct dev_pm_opp *opp __free(put_opp) =
+		_find_opp_of_np(opp_table, required_np);
 	if (opp) {
 		if (opp->level == OPP_LEVEL_UNSET) {
 			pr_err("%s: OPP levels aren't available for %pOF\n",
@@ -1376,14 +1372,15 @@ EXPORT_SYMBOL_GPL(of_get_required_opp_performance_state);
  */
 bool dev_pm_opp_of_has_required_opp(struct device *dev)
 {
-	struct device_node *np __free(device_node) = NULL, *opp_np __free(device_node);
 	int count;
 
-	opp_np = _opp_of_get_opp_desc_node(dev->of_node, 0);
+	struct device_node *opp_np __free(device_node) =
+		_opp_of_get_opp_desc_node(dev->of_node, 0);
 	if (!opp_np)
 		return false;
 
-	np = of_get_next_available_child(opp_np, NULL);
+	struct device_node *np __free(device_node) =
+		of_get_next_available_child(opp_np, NULL);
 	if (!np) {
 		dev_warn(dev, "Empty OPP table\n");
 		return false;
@@ -1425,12 +1422,13 @@ EXPORT_SYMBOL_GPL(dev_pm_opp_get_of_node);
 static int __maybe_unused
 _get_dt_power(struct device *dev, unsigned long *uW, unsigned long *kHz)
 {
-	struct dev_pm_opp *opp __free(put_opp);
 	unsigned long opp_freq, opp_power;
 
 	/* Find the right frequency and related OPP */
 	opp_freq = *kHz * 1000;
-	opp = dev_pm_opp_find_freq_ceil(dev, &opp_freq);
+
+	struct dev_pm_opp *opp __free(put_opp) =
+		dev_pm_opp_find_freq_ceil(dev, &opp_freq);
 	if (IS_ERR(opp))
 		return -EINVAL;
 
@@ -1465,14 +1463,12 @@ _get_dt_power(struct device *dev, unsigned long *uW, unsigned long *kHz)
 int dev_pm_opp_calc_power(struct device *dev, unsigned long *uW,
 			  unsigned long *kHz)
 {
-	struct dev_pm_opp *opp __free(put_opp) = NULL;
-	struct device_node *np __free(device_node);
 	unsigned long mV, Hz;
 	u32 cap;
 	u64 tmp;
 	int ret;
 
-	np = of_node_get(dev->of_node);
+	struct device_node *np __free(device_node) = of_node_get(dev->of_node);
 	if (!np)
 		return -EINVAL;
 
@@ -1481,7 +1477,9 @@ int dev_pm_opp_calc_power(struct device *dev, unsigned long *uW,
 		return -EINVAL;
 
 	Hz = *kHz * 1000;
-	opp = dev_pm_opp_find_freq_ceil(dev, &Hz);
+
+	struct dev_pm_opp *opp __free(put_opp) =
+		dev_pm_opp_find_freq_ceil(dev, &Hz);
 	if (IS_ERR(opp))
 		return -EINVAL;
 
@@ -1502,11 +1500,11 @@ EXPORT_SYMBOL_GPL(dev_pm_opp_calc_power);
 
 static bool _of_has_opp_microwatt_property(struct device *dev)
 {
-	struct dev_pm_opp *opp __free(put_opp);
 	unsigned long freq = 0;
 
 	/* Check if at least one OPP has needed property */
-	opp = dev_pm_opp_find_freq_ceil(dev, &freq);
+	struct dev_pm_opp *opp __free(put_opp) =
+		dev_pm_opp_find_freq_ceil(dev, &freq);
 	if (IS_ERR(opp))
 		return false;
 
@@ -1526,7 +1524,6 @@ static bool _of_has_opp_microwatt_property(struct device *dev)
  */
 int dev_pm_opp_of_register_em(struct device *dev, struct cpumask *cpus)
 {
-	struct device_node *np __free(device_node) = NULL;
 	struct em_data_callback em_cb;
 	int ret, nr_opp;
 	u32 cap;
@@ -1548,7 +1545,7 @@ int dev_pm_opp_of_register_em(struct device *dev, struct cpumask *cpus)
 		goto register_em;
 	}
 
-	np = of_node_get(dev->of_node);
+	struct device_node *np __free(device_node) = of_node_get(dev->of_node);
 	if (!np) {
 		ret = -EINVAL;
 		goto failed;
-- 
2.31.1.272.g89b43f80a514


