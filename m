Return-Path: <linux-pm+bounces-20860-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id E32D1A1A35A
	for <lists+linux-pm@lfdr.de>; Thu, 23 Jan 2025 12:43:39 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id D02481882A21
	for <lists+linux-pm@lfdr.de>; Thu, 23 Jan 2025 11:43:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 80E352165E9;
	Thu, 23 Jan 2025 11:39:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="Nu2AC3Ua"
X-Original-To: linux-pm@vger.kernel.org
Received: from mail-pl1-f182.google.com (mail-pl1-f182.google.com [209.85.214.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0008B216603
	for <linux-pm@vger.kernel.org>; Thu, 23 Jan 2025 11:39:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1737632364; cv=none; b=htxL3+hurDA0XpsQASX8UdswE7rbkgT1qDxbeNbMFEsXKBdP0KXuo/zzxCrWS7RFZ/csld4IGrTQ6Fp6vm6nlF2fWRTgQFVKzTggdMq2DDiQGQleCf/7d1+cQGVBbRIVU5FyLLYxU8qSyoXucdqIBnD2ApIeCwpiBD09/pS1e3E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1737632364; c=relaxed/simple;
	bh=VXzi3vQGoGrFGGoCyXxs3yzYdKXJIY2PFnz+CzvQS0U=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=K01PlQ7LDyKP/hY2zVsrAxgJOetJKaBpTjhzl4UJRytL/WADk1F4jRAjnzI4mCwTUQ9iBf7qscMlDyHV6vyoSoztA87b3BmAEtb9Qf5JXz5wajqvKDUvGDmIsNCKUctbbhClWS4e6Zak902qCXLyme9Ho+wDnbmMrva3ZHS/0vE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=Nu2AC3Ua; arc=none smtp.client-ip=209.85.214.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-pl1-f182.google.com with SMTP id d9443c01a7336-21661be2c2dso12528175ad.1
        for <linux-pm@vger.kernel.org>; Thu, 23 Jan 2025 03:39:22 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1737632362; x=1738237162; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=MdX1SYlxV+BuSD5MpIWAGjJb4j3+Z4eC30JBUmG9pbw=;
        b=Nu2AC3UayPXF+ScZ+VlLYNfUBBO1RN50K0T2I5+aSVZMpCfbI+9lSr2d5lYzxkJhYi
         uz7xWyIvI5q5QLIJG0SOyv32gKNXIuJJEDXcifVnYz3WIPgi7lYVw41MOBU9bzG5I94c
         LZosnuaNZyXtAQkbz8ROQofDL21zaGOA84+dOvmNnefl0QnGlQGiVlRzBN+YGuK+XVwA
         jbKQ5YDSZe1cBYj6Xu/WhTu7QVfRwxHNIUItJzw5HrncHYTtNGJWBzLZnLhz/WN4bBNY
         Q1u0O71Bzrdd3WUIGwK0mxrSEYTcZ5Nd6AbDkzFiE5Gp7n4jSHF52ayriql18lehgpFt
         Lbng==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1737632362; x=1738237162;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=MdX1SYlxV+BuSD5MpIWAGjJb4j3+Z4eC30JBUmG9pbw=;
        b=Yr8hpZm/Hbv3EgZQ7SoV2fwlIBQamQEPAcDUtdnft0Dqe2bIFj6dlBJWOEjgU/d9j1
         lF0LW+yiMOWOUAYOzSuv5iplMAa+lcmRaWzGLSVwT3mnYIGRV1SMvV1YKcRtZ4OMRHNW
         iW+38H2dEcv4vyS3H3S1j1qfpA+ipd1bJX4fHOVDtz/JXdhuUeCmn3g+TaulJ2Q9oIkG
         dLvaE+SheIao+7d9GhGG4MwWmktTGpR9nXsNsXJFdqZpMAGwhXwxbZwaVNQXZQZhyWFl
         S0BF5K55Te5SbFoyOH+WlSSNm//z4+exjJ04ZVCvsMa88cpSdZ41OhtJ/SD2Q8vhD7Ox
         6GYg==
X-Gm-Message-State: AOJu0YyHLTTg1Qxz5AClbF9oW45lzYrwV/fJY/FNodDRaAOv1ON/tI94
	0vSkwtZuTXJithWrBZc4U5nm7EVJ2XLqN0Xwa0U+Z+8b6BSfBu2Pu/NuZhr52O5ZxXeM/bviKFN
	A
X-Gm-Gg: ASbGncvtsgLkVch+/NAMbJhVdL0I0egvc68+E40OYrTQI0qeKofWXwnI6LlkeWuf/5S
	ffP3l9Ld7lNtCAEqjzLIMOtRwqtlC6BpsEi9VAef/gPgbkfaDX7f88IB3Q55DulDuLzgJRrNzrk
	oTFKxjXWZSvoRhN25wPh5QZ+QS2guU3pQLFmCK0np/ewLS1X9WUWwDWcjjR2WYIplMX1YR8Kbp8
	Y237g0E/Axbz9q7aFlb76FOANagtlAc+ZMGPVj5bIU8kgvZeo8TGYVYquQ/+9D9Heo7tnDTe9gP
	3ZEI0i5VBWSk773Dww==
X-Google-Smtp-Source: AGHT+IGErAbE+NwTrY1AINeQ3Si6MPxs7fVewd1+h1jBQl/h9wJNR/mCHaoI/Y7H43GtjmK7onqLBg==
X-Received: by 2002:a05:6a20:2589:b0:1e0:d0c8:7100 with SMTP id adf61e73a8af0-1eb214701c4mr46281215637.7.1737632362526;
        Thu, 23 Jan 2025 03:39:22 -0800 (PST)
Received: from localhost ([122.172.84.139])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-72dab7f2a38sm12882604b3a.21.2025.01.23.03.39.21
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 23 Jan 2025 03:39:22 -0800 (PST)
From: Viresh Kumar <viresh.kumar@linaro.org>
To: "Rafael J. Wysocki" <rafael@kernel.org>,
	Sudeep Holla <sudeep.holla@arm.com>,
	Cristian Marussi <cristian.marussi@arm.com>,
	Viresh Kumar <viresh.kumar@linaro.org>
Cc: linux-pm@vger.kernel.org,
	Vincent Guittot <vincent.guittot@linaro.org>,
	arm-scmi@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH 24/33] cpufreq: scmi: Stop setting cpufreq_driver->attr field
Date: Thu, 23 Jan 2025 17:06:00 +0530
Message-Id: <d4893396c4bacdd995d03a296b9d3ff44e71d072.1737631669.git.viresh.kumar@linaro.org>
X-Mailer: git-send-email 2.31.1.272.g89b43f80a514
In-Reply-To: <cover.1737631669.git.viresh.kumar@linaro.org>
References: <cover.1737631669.git.viresh.kumar@linaro.org>
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The cpufreq core handles this for basic attributes now, the driver can skip
setting them.

Signed-off-by: Viresh Kumar <viresh.kumar@linaro.org>
---
 drivers/cpufreq/scmi-cpufreq.c | 8 --------
 1 file changed, 8 deletions(-)

diff --git a/drivers/cpufreq/scmi-cpufreq.c b/drivers/cpufreq/scmi-cpufreq.c
index b8fe758aeb01..4a3ee59cb771 100644
--- a/drivers/cpufreq/scmi-cpufreq.c
+++ b/drivers/cpufreq/scmi-cpufreq.c
@@ -171,12 +171,6 @@ scmi_get_rate_limit(u32 domain, bool has_fast_switch)
 	return rate_limit;
 }
 
-static struct freq_attr *scmi_cpufreq_hw_attr[] = {
-	&cpufreq_freq_attr_scaling_available_freqs,
-	NULL,
-	NULL,
-};
-
 static int scmi_limit_notify_cb(struct notifier_block *nb, unsigned long event, void *data)
 {
 	struct scmi_data *priv = container_of(nb, struct scmi_data, limit_notify_nb);
@@ -309,7 +303,6 @@ static int scmi_cpufreq_init(struct cpufreq_policy *policy)
 			dev_warn(cpu_dev, "failed to enable boost: %d\n", ret);
 			goto out_free_table;
 		} else {
-			scmi_cpufreq_hw_attr[1] = &cpufreq_freq_attr_scaling_boost_freqs;
 			scmi_cpufreq_driver.boost_enabled = true;
 		}
 	}
@@ -395,7 +388,6 @@ static struct cpufreq_driver scmi_cpufreq_driver = {
 		  CPUFREQ_NEED_INITIAL_FREQ_CHECK |
 		  CPUFREQ_IS_COOLING_DEV,
 	.verify	= cpufreq_generic_frequency_table_verify,
-	.attr	= scmi_cpufreq_hw_attr,
 	.target_index	= scmi_cpufreq_set_target,
 	.fast_switch	= scmi_cpufreq_fast_switch,
 	.get	= scmi_cpufreq_get_rate,
-- 
2.31.1.272.g89b43f80a514


