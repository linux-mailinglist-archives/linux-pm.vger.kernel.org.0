Return-Path: <linux-pm+bounces-18084-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 47E3E9D8971
	for <lists+linux-pm@lfdr.de>; Mon, 25 Nov 2024 16:36:43 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 78B3EB29343
	for <lists+linux-pm@lfdr.de>; Mon, 25 Nov 2024 15:02:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F28371B0F11;
	Mon, 25 Nov 2024 15:02:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="bjh4HEUD"
X-Original-To: linux-pm@vger.kernel.org
Received: from mail-wm1-f54.google.com (mail-wm1-f54.google.com [209.85.128.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2771E14287;
	Mon, 25 Nov 2024 15:02:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732546955; cv=none; b=A41PlLzY6ay3gOUGWtbubTL53OtFfAn6l0i974KypB46GIL0UkZgQ8GCrmUyqlGEaZyKgKunRp97o279vmyne4txxKc4WnRNgo3FrYY4QkIeliVHwfCUPaIXG4gW1mw/DOHHhgqA4sWX5e/ao3xsRldkFAl1O1AGyz/z4ADAul0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732546955; c=relaxed/simple;
	bh=MnjGRpx8FxBhjgl32LYRi0TvQy40xQWy1JdDnv+E7gM=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=WC3BTycRprygLwx/PUhPc06p51648qbwQSN8OtxtToei1Q0VlZ4Mt7qN5rb7/MfphmzVaNkB6z4+hnTROrVH0/jRRWL4kr9MMNtAK7Jly0Xdxhj0Mvm+tR4744i3PJIDLtgwGd5xrLjlvL/c17lAeiHXFd8XaafVNkC1fy6d+dM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=bjh4HEUD; arc=none smtp.client-ip=209.85.128.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f54.google.com with SMTP id 5b1f17b1804b1-4349fb56260so8780735e9.3;
        Mon, 25 Nov 2024 07:02:33 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1732546952; x=1733151752; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=fBjnAAKOnPVEcbgfRGCTKD0kvAkCekOYy37Z9H/L7YI=;
        b=bjh4HEUDd871JccR1tWyvRHLUtQX4zxKgofJe4lzcTial9Gc5WMKaBjAHiykVIBCop
         EfbHz1kzeeM10MyOl4nos1mrV/UW1QZtm0cK7T73RDBdpZRiywc5PmaisEPhHTnFUyPQ
         7Z7bzbCH8MQ5sWNQf8F76pwNNfszb18bdcBjm7ccJxaI8iunzRp509noOSbdJcg4NrS6
         UDo8WHvQ5Z6WfXlQWz6pCSuYuhbmPExpi9q25lUoskxvvSLXdRAq2Yh4JgGPlEmaRS7q
         qWgnugxps6NDT1RfvG28TKK8vkiF0Njjv583v7y5VCmmt+kxf+oWIScN3PXTUGpKY7ty
         CynA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1732546952; x=1733151752;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=fBjnAAKOnPVEcbgfRGCTKD0kvAkCekOYy37Z9H/L7YI=;
        b=VczxU863yOV8uEB48RdIPWefsI/K2SzgCigf+ZP/w0Pic6NCx/v4yDI1QWeVnLnnuO
         xH4sGgww/FcJkVO/zx6K6CXIuFwCFYYLkZYCxy9hZrklDSvSW9hNzPHThLZHw1DWPH/b
         iX2CGe6PYWebyl/fLSQbCNAGtr6se2CIgpT2pHYJ3JtOjMwkch5GinRvDf4jFGycQNb0
         WgCaK5RfiKsRFrqNSEVdUzZfJwMKz0Dlbahns89uPSiqSbMsj31gNXO+d+6hBImZw5Oo
         YyMfbj4E6PGBDmHAroeS0MyWzs8QkBj1Zno2DgAmlNk8LI9MV1OAtjAkMrM7CtQN+zMV
         3eNQ==
X-Forwarded-Encrypted: i=1; AJvYcCVbpf0D0UV1O1DsZgg/Kd94dCVZhltw2Lp3GHnMxrFpoUW6EMjdJQhNldl6lBoewXBZgg2tVWEmgmY269U=@vger.kernel.org, AJvYcCVqd8QWYKTcu02qowq2ehW+OjTkSxrro5OoLY8ebDQ7yz4I8vEvhMFY4ooBmdZsxi7yhXqOCtXz7DI=@vger.kernel.org
X-Gm-Message-State: AOJu0YwPWAJHrwuty7PGpE8JGrEk1crDwyga6w8DiOhqSb9A6fHIG5V3
	wv/JiN7RriLpkl3P8GrfypthYwEGZZEPeGrDf5UzSYnRNhIWjdyrQQbwpg==
X-Gm-Gg: ASbGncvw+J2WN4l7OipowETFZ/FBiSuN55Uhv7pgz5ZA/+gCuxaHix5KLYY58j/kw7W
	Nq9XMCsH+RhWE3zJLrnubu76JTBWKvPfm5yvT7G8wcmaD5tCZs5g1mwgJvcPX/RVvzXl7LMZ5nw
	pcDNRSd/FejxKhXHzT/bMFejkUhpnOqpTEKwqFQuEnUD94MnTpty3dlaRMXqcjoeLPrMstKgct8
	Gn3H2Dp4gYBXdwkMuZ7VoJS5h4pOw7I2j3GX+AfRfMzbvN7pj5BvbKw+AmOff5uRShQAGKl/Jth
	8zj53B1OTBMu+mcbtoU=
X-Google-Smtp-Source: AGHT+IHNMhgxW0JgKvldg61TQqerCb2ctxjxGgb6t69VPnLsTzlEJ1BY8OeRiqp2gBNdF7DIDao/bQ==
X-Received: by 2002:a05:6000:1449:b0:378:89d8:8242 with SMTP id ffacd0b85a97d-38260b763c5mr12134930f8f.26.1732546950282;
        Mon, 25 Nov 2024 07:02:30 -0800 (PST)
Received: from localhost.localdomain (93-34-91-161.ip49.fastwebnet.it. [93.34.91.161])
        by smtp.googlemail.com with ESMTPSA id 5b1f17b1804b1-43494a0ad65sm77776405e9.26.2024.11.25.07.02.29
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 25 Nov 2024 07:02:29 -0800 (PST)
From: Christian Marangi <ansuelsmth@gmail.com>
To: "Rafael J. Wysocki" <rafael@kernel.org>,
	Viresh Kumar <viresh.kumar@linaro.org>,
	linux-kernel@vger.kernel.org,
	linux-pm@vger.kernel.org,
	upstream@airoha.com
Cc: Christian Marangi <ansuelsmth@gmail.com>
Subject: [PATCH v3 1/2] cpufreq: dt: permit defining custom .get and .target_index
Date: Mon, 25 Nov 2024 16:01:11 +0100
Message-ID: <20241125150200.714-1-ansuelsmth@gmail.com>
X-Mailer: git-send-email 2.45.2
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Some modern device might have CPU frequency control totally detached
from the system and entirely handled by ATF or Secure World. Such device
also tune the CPU frequency indirectly with special call, like SMCCC
calls.

In such condition, creating a special clock for the task might introduce
lots of unneeded overhead to permit usage of the generic "cpufreq-dt"
driver.

To handle this scenario, expand the "cpufreq-dt" driver to also permit
defining custom .get and .target_index function. This is already
supported for the .suspend, .resume and the .get_intermediate OPs.

With this, custom CPU Freq driver can now define custom .get and
.target_index and directly make SMCCC calls to tune the CPU frequency
while keeping full support of all the property and initialization of
"cpufreq-dt".

It's also needed to introduce a bool to permit skipping CPU clock
parsing (no_cpu_clk). This bool is applied only if a custom .get is
defined and is needed to handle case when the CPU node doesn't have a
clock defined as it's entirely handled indirectly and not exposed to the
system. This permits full init of cpufreq-dt with custom .get() and
.target_index().

Signed-off-by: Christian Marangi <ansuelsmth@gmail.com>
---
Changes v3:
- Add this patch

 drivers/cpufreq/cpufreq-dt.c | 19 +++++++++++++++++--
 drivers/cpufreq/cpufreq-dt.h |  4 ++++
 2 files changed, 21 insertions(+), 2 deletions(-)

diff --git a/drivers/cpufreq/cpufreq-dt.c b/drivers/cpufreq/cpufreq-dt.c
index 983443396f8f..ecbac6502b57 100644
--- a/drivers/cpufreq/cpufreq-dt.c
+++ b/drivers/cpufreq/cpufreq-dt.c
@@ -31,6 +31,7 @@ struct private_data {
 	struct device *cpu_dev;
 	struct cpufreq_frequency_table *freq_table;
 	bool have_static_opps;
+	bool no_cpu_clk;
 	int opp_token;
 };
 
@@ -90,7 +91,7 @@ static int cpufreq_init(struct cpufreq_policy *policy)
 {
 	struct private_data *priv;
 	struct device *cpu_dev;
-	struct clk *cpu_clk;
+	struct clk *cpu_clk = NULL;
 	unsigned int transition_latency;
 	int ret;
 
@@ -101,7 +102,13 @@ static int cpufreq_init(struct cpufreq_policy *policy)
 	}
 	cpu_dev = priv->cpu_dev;
 
-	cpu_clk = clk_get(cpu_dev, NULL);
+	/*
+	 * CPU might have special clock handling (example handled by ATF with
+	 * SMCCC calls). If instructed, skip checking for a CPU clock as it's
+	 * handled by custom .get.
+	 */
+	if (!priv->no_cpu_clk)
+		cpu_clk = clk_get(cpu_dev, NULL);
 	if (IS_ERR(cpu_clk)) {
 		ret = PTR_ERR(cpu_clk);
 		dev_err(cpu_dev, "%s: failed to get clk: %d\n", __func__, ret);
@@ -175,6 +182,7 @@ static struct cpufreq_driver dt_cpufreq_driver = {
 
 static int dt_cpufreq_early_init(struct device *dev, int cpu)
 {
+	struct cpufreq_dt_platform_data *data = dev_get_platdata(dev);
 	struct private_data *priv;
 	struct device *cpu_dev;
 	bool fallback = false;
@@ -198,6 +206,9 @@ static int dt_cpufreq_early_init(struct device *dev, int cpu)
 
 	cpumask_set_cpu(cpu, priv->cpus);
 	priv->cpu_dev = cpu_dev;
+	/* Permit CPU with no clock, if custom .get is defined */
+	if (data->get)
+		priv->no_cpu_clk = data->no_cpu_clk;
 
 	/*
 	 * OPP layer will be taking care of regulators now, but it needs to know
@@ -313,6 +324,10 @@ static int dt_cpufreq_probe(struct platform_device *pdev)
 		if (data->have_governor_per_policy)
 			dt_cpufreq_driver.flags |= CPUFREQ_HAVE_GOVERNOR_PER_POLICY;
 
+		if (data->get)
+			dt_cpufreq_driver.get = data->get;
+		if (data->target_index)
+			dt_cpufreq_driver.target_index = data->target_index;
 		dt_cpufreq_driver.resume = data->resume;
 		if (data->suspend)
 			dt_cpufreq_driver.suspend = data->suspend;
diff --git a/drivers/cpufreq/cpufreq-dt.h b/drivers/cpufreq/cpufreq-dt.h
index 28c8af7ec5ef..ba0385d75bdb 100644
--- a/drivers/cpufreq/cpufreq-dt.h
+++ b/drivers/cpufreq/cpufreq-dt.h
@@ -13,7 +13,11 @@ struct cpufreq_policy;
 
 struct cpufreq_dt_platform_data {
 	bool have_governor_per_policy;
+	bool no_cpu_clk;
 
+	unsigned int	(*get)(unsigned int cpu);
+	int		(*target_index)(struct cpufreq_policy *policy,
+					unsigned int index);
 	unsigned int	(*get_intermediate)(struct cpufreq_policy *policy,
 					    unsigned int index);
 	int		(*target_intermediate)(struct cpufreq_policy *policy,
-- 
2.45.2


