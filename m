Return-Path: <linux-pm+bounces-36691-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id F3455BFF5B0
	for <lists+linux-pm@lfdr.de>; Thu, 23 Oct 2025 08:34:44 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 9F27B3A843F
	for <lists+linux-pm@lfdr.de>; Thu, 23 Oct 2025 06:34:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6CEB42749CA;
	Thu, 23 Oct 2025 06:34:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="Iz9KGvIH"
X-Original-To: linux-pm@vger.kernel.org
Received: from mail-pj1-f42.google.com (mail-pj1-f42.google.com [209.85.216.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2012B25E44D
	for <linux-pm@vger.kernel.org>; Thu, 23 Oct 2025 06:34:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761201280; cv=none; b=OLQAKxoiJx3xBJHT9NfhV0b7L1z5lwkCQ77DxREgaVZE5eq8KrDBS1uJVjWGQobMRfHvxlIbNsYNwWvHX6n/VDJOPY13JmLUENVU9ryW/jXRI4fjSrbqETgeROr9XOEM6PknzqjG+I9h3KL9J2c9ZGK6ojZypsmiYu4tBcnisjo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761201280; c=relaxed/simple;
	bh=4+CM0eifem9/bPp9u9v8GymoEbLYHYiGllgUxf6Ry6A=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=l+qD65s7F6tQKYAXp90J4qmj3+mexvEMcu+BdEXINggCjBEsxib5AQsNXvCvM/Hqy9YFz1eKiuB5R98tt2j5TCz5wfUUtRqRfuwDQLGugmwcVg4be4tUJWOJEFcAFuIhXezu2A6oWo8wui2miOwnmQaBg+54ii+IFMYahwfSQF0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=Iz9KGvIH; arc=none smtp.client-ip=209.85.216.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-pj1-f42.google.com with SMTP id 98e67ed59e1d1-339d7c403b6so512893a91.2
        for <linux-pm@vger.kernel.org>; Wed, 22 Oct 2025 23:34:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1761201276; x=1761806076; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=zLKbtCZN5GcjqVsKXJTaq/b96RWwGHFYjipZyD0gbwk=;
        b=Iz9KGvIHNfhezPrgWqfiOOhvy1nh+LaRKEKimCO6kChPcsyFyjlaWUm2u5bIgmQDcl
         cG1gtLVEjYSRiQVz5PV79A0GwNFTgR8US91yZPXYJgBdZb06b0N4gkAwqnGJz99/3JrY
         nA6jkiqqzBmKOZOOgeR+/L8ix1toEK5/2lqa+y+DlGMYsliXgNvabnVR9BsSigFGyqL+
         5C0gDQQrVHSHLIesFnYSe9QW85xavHPbtX73JtUy4wV9eNVzUGe8CI/wYZsX/k7pPQna
         /T0ZuwkoCZippd4JK2rJ/OgjxGTk0GassrreJv+DfsffV3Y0nLX8H7opAaiOwJDVyqzq
         +tng==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1761201276; x=1761806076;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=zLKbtCZN5GcjqVsKXJTaq/b96RWwGHFYjipZyD0gbwk=;
        b=JX+SDjw8XIc0s4S5/ymmvJFOblxHPSDN4usmRemh+BbJIYq3P9+RGlysiN9O9zpjI3
         6leBcKl/pqBDFSgPu9Lwy/Z21DfeHhj82r8PQe0Nqho8HI9qeBH5es8fvcGjhbREVeru
         vM0SsaupIP320TtpXPtsL+kOHHneXQ4t5W+w/+c6xYdVXL6tO3pLpU3nROJGM8yOKL5s
         Kwxwb7krQjxbmH1SmPyFTOpwwONR81RC5koOvU3trMXvYzDqwzFItSuVXI+Z/2XVZs2c
         ZZdR1cP1zQP8+SyzM/UWExodjvvC/YfmlMT/niH2ETb2bFTVwQOzbJQ3Ic6Vfo8aYesC
         hUgQ==
X-Forwarded-Encrypted: i=1; AJvYcCVLhP+06jCe328W44IQDG+qRaEknycIDNdSpe+NNmyCxeetE4RnoCZMErjZogoG8sk7/bFqTvSsIg==@vger.kernel.org
X-Gm-Message-State: AOJu0YyoKzIbcuDDzQf1teP8PKUY/XQWG+cHn8J7npY+UCvXTxwm5AOD
	vonNerVawmSPRYX9mk7jKH55d08g6nt1P847q+3jsb3vcOu6Jp+A7tAJh2dyATGzPcO/kL1p1f2
	kf6T1
X-Gm-Gg: ASbGnctt1nyMSVFslopwgbtEVRUHR+cWyEjLCQPCHmEivcZ4hc4+BSCdkUXC8NHqHQb
	kPGtGsJSBxTaHmCshHBKBqBE4sMn8BrnmaqGfDgCREjsI+q+RIHggHoOJtsQ4j5Oq7hvfqhukaD
	jhQemyFq6SeViCzX4VaCBInSsfoxhv+BzSupy27OC3FLZOf2ysFIW4iVIzl9adIU7nNL+2INbKF
	aqbZpanXcqJdiWANsKyq9+YP3kXeSvQS0uf+s+OJuqNBI5aEUmjpomTj+sSe+RlTdy9QmrasrET
	D/ltjA06vWinbsHrNDR8UN8YJD4Kqa8TsiFqXRfze2ekZzm09vkXdllFH5+msKY+pXW4BVZD5C9
	KKigZ8N/CHud+88C4kMEmbWXXayVIAAR9fZ8JG5RHV7gFG1Ee/qHBmWjEHGrKMv1ooIua08JXIh
	F0gbPCqAKj2tG7
X-Google-Smtp-Source: AGHT+IF/Pj/dA9Uy6ATET7eqz324RUB1crJJB0RMmX8/rBg0CadHqN7oHKd1QnpztJdLoQ8hZfkJ2w==
X-Received: by 2002:a17:902:d2ca:b0:290:ab25:2986 with SMTP id d9443c01a7336-290cb27d770mr317671725ad.48.1761201275938;
        Wed, 22 Oct 2025 23:34:35 -0700 (PDT)
Received: from localhost ([122.172.87.183])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-33fb014463esm1270511a91.7.2025.10.22.23.34.34
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 22 Oct 2025 23:34:35 -0700 (PDT)
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
Subject: [PATCH V2] OPP: Initialize scope-based pointers inline
Date: Thu, 23 Oct 2025 12:04:24 +0530
Message-Id: <173e02d674946ff3ef8da7f44a9d5b820b9af21c.1761200897.git.viresh.kumar@linaro.org>
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
V2:
- Added blank line after definitions (Joe).
- Fixed a build error in dev_pm_opp_of_register_em():

  note: jump bypasses initialization of variable with __attribute__((cleanup))

 drivers/opp/core.c |  69 ++++++++++++++-----------
 drivers/opp/cpu.c  |  16 +++---
 drivers/opp/of.c   | 125 +++++++++++++++++++++++++--------------------
 3 files changed, 117 insertions(+), 93 deletions(-)

diff --git a/drivers/opp/core.c b/drivers/opp/core.c
index bba4f7daff8c..dbebb8c829bc 100644
--- a/drivers/opp/core.c
+++ b/drivers/opp/core.c
@@ -309,9 +309,9 @@ EXPORT_SYMBOL_GPL(dev_pm_opp_is_turbo);
  */
 unsigned long dev_pm_opp_get_max_clock_latency(struct device *dev)
 {
-	struct opp_table *opp_table __free(put_opp_table);
+	struct opp_table *opp_table __free(put_opp_table) =
+		_find_opp_table(dev);
 
-	opp_table = _find_opp_table(dev);
 	if (IS_ERR(opp_table))
 		return 0;
 
@@ -327,7 +327,6 @@ EXPORT_SYMBOL_GPL(dev_pm_opp_get_max_clock_latency);
  */
 unsigned long dev_pm_opp_get_max_volt_latency(struct device *dev)
 {
-	struct opp_table *opp_table __free(put_opp_table);
 	struct dev_pm_opp *opp;
 	struct regulator *reg;
 	unsigned long latency_ns = 0;
@@ -337,7 +336,9 @@ unsigned long dev_pm_opp_get_max_volt_latency(struct device *dev)
 		unsigned long max;
 	} *uV;
 
-	opp_table = _find_opp_table(dev);
+	struct opp_table *opp_table __free(put_opp_table) =
+		_find_opp_table(dev);
+
 	if (IS_ERR(opp_table))
 		return 0;
 
@@ -409,10 +410,11 @@ EXPORT_SYMBOL_GPL(dev_pm_opp_get_max_transition_latency);
  */
 unsigned long dev_pm_opp_get_suspend_opp_freq(struct device *dev)
 {
-	struct opp_table *opp_table __free(put_opp_table);
 	unsigned long freq = 0;
 
-	opp_table = _find_opp_table(dev);
+	struct opp_table *opp_table __free(put_opp_table) =
+		_find_opp_table(dev);
+
 	if (IS_ERR(opp_table))
 		return 0;
 
@@ -447,9 +449,9 @@ int _get_opp_count(struct opp_table *opp_table)
  */
 int dev_pm_opp_get_opp_count(struct device *dev)
 {
-	struct opp_table *opp_table __free(put_opp_table);
+	struct opp_table *opp_table __free(put_opp_table) =
+		_find_opp_table(dev);
 
-	opp_table = _find_opp_table(dev);
 	if (IS_ERR(opp_table)) {
 		dev_dbg(dev, "%s: OPP table not found (%ld)\n",
 			__func__, PTR_ERR(opp_table));
@@ -605,9 +607,9 @@ _find_key(struct device *dev, unsigned long *key, int index, bool available,
 			  unsigned long opp_key, unsigned long key),
 	  bool (*assert)(struct opp_table *opp_table, unsigned int index))
 {
-	struct opp_table *opp_table __free(put_opp_table);
+	struct opp_table *opp_table __free(put_opp_table) =
+		_find_opp_table(dev);
 
-	opp_table = _find_opp_table(dev);
 	if (IS_ERR(opp_table)) {
 		dev_err(dev, "%s: OPP table not found (%ld)\n", __func__,
 			PTR_ERR(opp_table));
@@ -1410,12 +1412,13 @@ static int _set_opp(struct device *dev, struct opp_table *opp_table,
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
+
 	if (IS_ERR(opp_table)) {
 		dev_err(dev, "%s: device's opp table doesn't exist\n", __func__);
 		return PTR_ERR(opp_table);
@@ -1477,9 +1480,9 @@ EXPORT_SYMBOL_GPL(dev_pm_opp_set_rate);
  */
 int dev_pm_opp_set_opp(struct device *dev, struct dev_pm_opp *opp)
 {
-	struct opp_table *opp_table __free(put_opp_table);
+	struct opp_table *opp_table __free(put_opp_table) =
+		_find_opp_table(dev);
 
-	opp_table = _find_opp_table(dev);
 	if (IS_ERR(opp_table)) {
 		dev_err(dev, "%s: device opp doesn't exist\n", __func__);
 		return PTR_ERR(opp_table);
@@ -1794,10 +1797,11 @@ EXPORT_SYMBOL_GPL(dev_pm_opp_put);
  */
 void dev_pm_opp_remove(struct device *dev, unsigned long freq)
 {
-	struct opp_table *opp_table __free(put_opp_table);
 	struct dev_pm_opp *opp = NULL, *iter;
 
-	opp_table = _find_opp_table(dev);
+	struct opp_table *opp_table __free(put_opp_table) =
+		_find_opp_table(dev);
+
 	if (IS_ERR(opp_table))
 		return;
 
@@ -1885,9 +1889,9 @@ bool _opp_remove_all_static(struct opp_table *opp_table)
  */
 void dev_pm_opp_remove_all_dynamic(struct device *dev)
 {
-	struct opp_table *opp_table __free(put_opp_table);
+	struct opp_table *opp_table __free(put_opp_table) =
+		_find_opp_table(dev);
 
-	opp_table = _find_opp_table(dev);
 	if (IS_ERR(opp_table))
 		return;
 
@@ -2871,10 +2875,11 @@ static int _opp_set_availability(struct device *dev, unsigned long freq,
 				 bool availability_req)
 {
 	struct dev_pm_opp *opp __free(put_opp) = ERR_PTR(-ENODEV), *tmp_opp;
-	struct opp_table *opp_table __free(put_opp_table);
 
 	/* Find the opp_table */
-	opp_table = _find_opp_table(dev);
+	struct opp_table *opp_table __free(put_opp_table) =
+		_find_opp_table(dev);
+
 	if (IS_ERR(opp_table)) {
 		dev_warn(dev, "%s: Device OPP not found (%ld)\n", __func__,
 			 PTR_ERR(opp_table));
@@ -2932,11 +2937,12 @@ int dev_pm_opp_adjust_voltage(struct device *dev, unsigned long freq,
 
 {
 	struct dev_pm_opp *opp __free(put_opp) = ERR_PTR(-ENODEV), *tmp_opp;
-	struct opp_table *opp_table __free(put_opp_table);
 	int r;
 
 	/* Find the opp_table */
-	opp_table = _find_opp_table(dev);
+	struct opp_table *opp_table __free(put_opp_table) =
+		_find_opp_table(dev);
+
 	if (IS_ERR(opp_table)) {
 		r = PTR_ERR(opp_table);
 		dev_warn(dev, "%s: Device OPP not found (%d)\n", __func__, r);
@@ -2986,12 +2992,13 @@ EXPORT_SYMBOL_GPL(dev_pm_opp_adjust_voltage);
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
+
 	if (IS_ERR(opp_table))
 		return 0;
 
@@ -3062,9 +3069,9 @@ EXPORT_SYMBOL_GPL(dev_pm_opp_disable);
  */
 int dev_pm_opp_register_notifier(struct device *dev, struct notifier_block *nb)
 {
-	struct opp_table *opp_table __free(put_opp_table);
+	struct opp_table *opp_table __free(put_opp_table) =
+		_find_opp_table(dev);
 
-	opp_table = _find_opp_table(dev);
 	if (IS_ERR(opp_table))
 		return PTR_ERR(opp_table);
 
@@ -3082,9 +3089,9 @@ EXPORT_SYMBOL(dev_pm_opp_register_notifier);
 int dev_pm_opp_unregister_notifier(struct device *dev,
 				   struct notifier_block *nb)
 {
-	struct opp_table *opp_table __free(put_opp_table);
+	struct opp_table *opp_table __free(put_opp_table) =
+		_find_opp_table(dev);
 
-	opp_table = _find_opp_table(dev);
 	if (IS_ERR(opp_table))
 		return PTR_ERR(opp_table);
 
@@ -3101,10 +3108,10 @@ EXPORT_SYMBOL(dev_pm_opp_unregister_notifier);
  */
 void dev_pm_opp_remove_table(struct device *dev)
 {
-	struct opp_table *opp_table __free(put_opp_table);
-
 	/* Check for existing table for 'dev' */
-	opp_table = _find_opp_table(dev);
+	struct opp_table *opp_table __free(put_opp_table) =
+		_find_opp_table(dev);
+
 	if (IS_ERR(opp_table)) {
 		int error = PTR_ERR(opp_table);
 
diff --git a/drivers/opp/cpu.c b/drivers/opp/cpu.c
index 97989d4fe336..a6da7ee3ec76 100644
--- a/drivers/opp/cpu.c
+++ b/drivers/opp/cpu.c
@@ -56,10 +56,10 @@ int dev_pm_opp_init_cpufreq_table(struct device *dev,
 		return -ENOMEM;
 
 	for (i = 0, rate = 0; i < max_opps; i++, rate++) {
-		struct dev_pm_opp *opp __free(put_opp);
-
 		/* find next rate */
-		opp = dev_pm_opp_find_freq_ceil(dev, &rate);
+		struct dev_pm_opp *opp __free(put_opp) =
+			dev_pm_opp_find_freq_ceil(dev, &rate);
+
 		if (IS_ERR(opp)) {
 			ret = PTR_ERR(opp);
 			goto out;
@@ -154,12 +154,13 @@ EXPORT_SYMBOL_GPL(dev_pm_opp_cpumask_remove_table);
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
+
 	if (IS_ERR(opp_table))
 		return PTR_ERR(opp_table);
 
@@ -201,10 +202,11 @@ EXPORT_SYMBOL_GPL(dev_pm_opp_set_sharing_cpus);
  */
 int dev_pm_opp_get_sharing_cpus(struct device *cpu_dev, struct cpumask *cpumask)
 {
-	struct opp_table *opp_table __free(put_opp_table);
 	struct opp_device *opp_dev;
 
-	opp_table = _find_opp_table(cpu_dev);
+	struct opp_table *opp_table __free(put_opp_table) =
+		_find_opp_table(cpu_dev);
+
 	if (IS_ERR(opp_table))
 		return PTR_ERR(opp_table);
 
diff --git a/drivers/opp/of.c b/drivers/opp/of.c
index 505d79821584..1e0d0adb18e1 100644
--- a/drivers/opp/of.c
+++ b/drivers/opp/of.c
@@ -45,9 +45,10 @@ EXPORT_SYMBOL_GPL(dev_pm_opp_of_get_opp_desc_node);
 struct opp_table *_managed_opp(struct device *dev, int index)
 {
 	struct opp_table *opp_table, *managed_table = NULL;
-	struct device_node *np __free(device_node);
 
-	np = _opp_of_get_opp_desc_node(dev->of_node, index);
+	struct device_node *np __free(device_node) =
+		_opp_of_get_opp_desc_node(dev->of_node, index);
+
 	if (!np)
 		return NULL;
 
@@ -95,10 +96,11 @@ static struct device_node *of_parse_required_opp(struct device_node *np,
 /* The caller must call dev_pm_opp_put_opp_table() after the table is used */
 static struct opp_table *_find_table_of_opp_np(struct device_node *opp_np)
 {
-	struct device_node *opp_table_np __free(device_node);
 	struct opp_table *opp_table;
 
-	opp_table_np = of_get_parent(opp_np);
+	struct device_node *opp_table_np __free(device_node) =
+		of_get_parent(opp_np);
+
 	if (!opp_table_np)
 		return ERR_PTR(-ENODEV);
 
@@ -146,12 +148,13 @@ static void _opp_table_alloc_required_tables(struct opp_table *opp_table,
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
+
 	if (!np) {
 		dev_warn(dev, "Empty OPP table\n");
 		return;
@@ -171,9 +174,9 @@ static void _opp_table_alloc_required_tables(struct opp_table *opp_table,
 	opp_table->required_opp_count = count;
 
 	for (i = 0; i < count; i++) {
-		struct device_node *required_np __free(device_node);
+		struct device_node *required_np __free(device_node) =
+			of_parse_required_opp(np, i);
 
-		required_np = of_parse_required_opp(np, i);
 		if (!required_np) {
 			_opp_table_free_required_tables(opp_table);
 			return;
@@ -199,14 +202,15 @@ static void _opp_table_alloc_required_tables(struct opp_table *opp_table,
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
+
 	if (!np)
 		return;
 
@@ -273,9 +277,9 @@ void _of_clear_opp(struct opp_table *opp_table, struct dev_pm_opp *opp)
 static int _link_required_opps(struct dev_pm_opp *opp,
 			       struct opp_table *required_table, int index)
 {
-	struct device_node *np __free(device_node);
+	struct device_node *np __free(device_node) =
+		of_parse_required_opp(opp->np, index);
 
-	np = of_parse_required_opp(opp->np, index);
 	if (unlikely(!np))
 		return -ENODEV;
 
@@ -349,16 +353,13 @@ static void lazy_link_required_opp_table(struct opp_table *new_table)
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
@@ -366,8 +367,10 @@ static void lazy_link_required_opp_table(struct opp_table *new_table)
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
@@ -402,13 +405,12 @@ static void lazy_link_required_opp_table(struct opp_table *new_table)
 static int _bandwidth_supported(struct device *dev, struct opp_table *opp_table)
 {
 	struct device_node *opp_np __free(device_node) = NULL;
-	struct device_node *np __free(device_node) = NULL;
 	struct property *prop;
 
 	if (!opp_table) {
-		struct device_node *np __free(device_node);
+		struct device_node *np __free(device_node) =
+			of_node_get(dev->of_node);
 
-		np = of_node_get(dev->of_node);
 		if (!np)
 			return -ENODEV;
 
@@ -422,7 +424,9 @@ static int _bandwidth_supported(struct device *dev, struct opp_table *opp_table)
 		return 0;
 
 	/* Checking only first OPP is sufficient */
-	np = of_get_next_available_child(opp_np, NULL);
+	struct device_node *np __free(device_node) =
+		of_get_next_available_child(opp_np, NULL);
+
 	if (!np) {
 		dev_err(dev, "OPP table empty\n");
 		return -EINVAL;
@@ -1269,11 +1273,12 @@ EXPORT_SYMBOL_GPL(dev_pm_opp_of_cpumask_add_table);
 int dev_pm_opp_of_get_sharing_cpus(struct device *cpu_dev,
 				   struct cpumask *cpumask)
 {
-	struct device_node *np __free(device_node);
 	int cpu;
 
 	/* Get OPP descriptor node */
-	np = dev_pm_opp_of_get_opp_desc_node(cpu_dev);
+	struct device_node *np __free(device_node) =
+		dev_pm_opp_of_get_opp_desc_node(cpu_dev);
+
 	if (!np) {
 		dev_dbg(cpu_dev, "%s: Couldn't find opp node.\n", __func__);
 		return -ENOENT;
@@ -1286,13 +1291,12 @@ int dev_pm_opp_of_get_sharing_cpus(struct device *cpu_dev,
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
+
 		if (!cpu_np) {
 			dev_err(cpu_dev, "%s: failed to get cpu%d node\n",
 				__func__, cpu);
@@ -1300,7 +1304,9 @@ int dev_pm_opp_of_get_sharing_cpus(struct device *cpu_dev,
 		}
 
 		/* Get OPP descriptor node */
-		tmp_np = _opp_of_get_opp_desc_node(cpu_np, 0);
+		struct device_node *tmp_np __free(device_node) =
+			_opp_of_get_opp_desc_node(cpu_np, 0);
+
 		if (!tmp_np) {
 			pr_err("%pOF: Couldn't find opp node\n", cpu_np);
 			return -ENOENT;
@@ -1328,16 +1334,17 @@ EXPORT_SYMBOL_GPL(dev_pm_opp_of_get_sharing_cpus);
  */
 int of_get_required_opp_performance_state(struct device_node *np, int index)
 {
-	struct device_node *required_np __free(device_node);
-	struct opp_table *opp_table __free(put_opp_table) = NULL;
-	struct dev_pm_opp *opp __free(put_opp) = NULL;
 	int pstate = -EINVAL;
 
-	required_np = of_parse_required_opp(np, index);
+	struct device_node *required_np __free(device_node) =
+		of_parse_required_opp(np, index);
+
 	if (!required_np)
 		return -ENODEV;
 
-	opp_table = _find_table_of_opp_np(required_np);
+	struct opp_table *opp_table __free(put_opp_table) =
+		_find_table_of_opp_np(required_np);
+
 	if (IS_ERR(opp_table)) {
 		pr_err("%s: Failed to find required OPP table %pOF: %ld\n",
 		       __func__, np, PTR_ERR(opp_table));
@@ -1350,7 +1357,9 @@ int of_get_required_opp_performance_state(struct device_node *np, int index)
 		return -EINVAL;
 	}
 
-	opp = _find_opp_of_np(opp_table, required_np);
+	struct dev_pm_opp *opp __free(put_opp) =
+		_find_opp_of_np(opp_table, required_np);
+
 	if (opp) {
 		if (opp->level == OPP_LEVEL_UNSET) {
 			pr_err("%s: OPP levels aren't available for %pOF\n",
@@ -1376,14 +1385,17 @@ EXPORT_SYMBOL_GPL(of_get_required_opp_performance_state);
  */
 bool dev_pm_opp_of_has_required_opp(struct device *dev)
 {
-	struct device_node *np __free(device_node) = NULL, *opp_np __free(device_node);
 	int count;
 
-	opp_np = _opp_of_get_opp_desc_node(dev->of_node, 0);
+	struct device_node *opp_np __free(device_node) =
+		_opp_of_get_opp_desc_node(dev->of_node, 0);
+
 	if (!opp_np)
 		return false;
 
-	np = of_get_next_available_child(opp_np, NULL);
+	struct device_node *np __free(device_node) =
+		of_get_next_available_child(opp_np, NULL);
+
 	if (!np) {
 		dev_warn(dev, "Empty OPP table\n");
 		return false;
@@ -1425,12 +1437,14 @@ EXPORT_SYMBOL_GPL(dev_pm_opp_get_of_node);
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
+
 	if (IS_ERR(opp))
 		return -EINVAL;
 
@@ -1465,14 +1479,13 @@ _get_dt_power(struct device *dev, unsigned long *uW, unsigned long *kHz)
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
+
 	if (!np)
 		return -EINVAL;
 
@@ -1481,7 +1494,10 @@ int dev_pm_opp_calc_power(struct device *dev, unsigned long *uW,
 		return -EINVAL;
 
 	Hz = *kHz * 1000;
-	opp = dev_pm_opp_find_freq_ceil(dev, &Hz);
+
+	struct dev_pm_opp *opp __free(put_opp) =
+		dev_pm_opp_find_freq_ceil(dev, &Hz);
+
 	if (IS_ERR(opp))
 		return -EINVAL;
 
@@ -1502,11 +1518,12 @@ EXPORT_SYMBOL_GPL(dev_pm_opp_calc_power);
 
 static bool _of_has_opp_microwatt_property(struct device *dev)
 {
-	struct dev_pm_opp *opp __free(put_opp);
 	unsigned long freq = 0;
 
 	/* Check if at least one OPP has needed property */
-	opp = dev_pm_opp_find_freq_ceil(dev, &freq);
+	struct dev_pm_opp *opp __free(put_opp) =
+		dev_pm_opp_find_freq_ceil(dev, &freq);
+
 	if (IS_ERR(opp))
 		return false;
 
@@ -1526,12 +1543,16 @@ static bool _of_has_opp_microwatt_property(struct device *dev)
  */
 int dev_pm_opp_of_register_em(struct device *dev, struct cpumask *cpus)
 {
-	struct device_node *np __free(device_node) = NULL;
 	struct em_data_callback em_cb;
 	int ret, nr_opp;
 	u32 cap;
 
-	if (IS_ERR_OR_NULL(dev)) {
+	if (IS_ERR_OR_NULL(dev))
+		return -EINVAL;
+
+	struct device_node *np __free(device_node) = of_node_get(dev->of_node);
+
+	if (!np) {
 		ret = -EINVAL;
 		goto failed;
 	}
@@ -1548,12 +1569,6 @@ int dev_pm_opp_of_register_em(struct device *dev, struct cpumask *cpus)
 		goto register_em;
 	}
 
-	np = of_node_get(dev->of_node);
-	if (!np) {
-		ret = -EINVAL;
-		goto failed;
-	}
-
 	/*
 	 * Register an EM only if the 'dynamic-power-coefficient' property is
 	 * set in devicetree. It is assumed the voltage values are known if that
-- 
2.31.1.272.g89b43f80a514


