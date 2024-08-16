Return-Path: <linux-pm+bounces-12361-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 56D05954D57
	for <lists+linux-pm@lfdr.de>; Fri, 16 Aug 2024 17:09:57 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 146D02864A2
	for <lists+linux-pm@lfdr.de>; Fri, 16 Aug 2024 15:09:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9ADC91BDA85;
	Fri, 16 Aug 2024 15:09:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="eYx180bK"
X-Original-To: linux-pm@vger.kernel.org
Received: from mail-wr1-f51.google.com (mail-wr1-f51.google.com [209.85.221.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8B22E817
	for <linux-pm@vger.kernel.org>; Fri, 16 Aug 2024 15:09:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723820981; cv=none; b=o32fUDAJf1xvJc5sGWfXlR5XsUEuMOn9zKF9Y2Ey+Zl6VD5ZbfVDWIAszKWTG70HFoTLl3XPFu9/c4L13GPfkIGqAMbd8T/cR+yuv5xrysqhX87pM6Dr5fcee1D8ACtVz0najpuA5PKHdeX2bkBJ6FXqo5r1TnnOKO/1hIqWgos=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723820981; c=relaxed/simple;
	bh=DutqlqHE6bdTfzEusV88EvHx97cLnaHqQXNHMGXgdd4=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=OYPEmFm4Er9F83tht2M+3mOSo/jwY+eCNDbeOZXn8FRCFGGNqzN2phkEQaGB3ABhU5e9eQzriZSX13XoFzV92ARBdbE5MVguDXRFOCWJAtQ3ZRL2gHLnstxK9SUvAMwCQOgEZFaWo2CpN3kIwW/aEQPFlN5pefM3TpfR82MDpY0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=eYx180bK; arc=none smtp.client-ip=209.85.221.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-wr1-f51.google.com with SMTP id ffacd0b85a97d-37196681d3bso464113f8f.3
        for <linux-pm@vger.kernel.org>; Fri, 16 Aug 2024 08:09:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1723820977; x=1724425777; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ycsrSNVghYJYo7Kq/sAqp6MnjeFyaL9nJFuFS/dh9Nk=;
        b=eYx180bKiY4F/wON9/KOJ6RD1w+RQZ8Dg2nM/UDNm9Cc39OkfH4ljUt1xp51laaVdv
         Vu92t6YaDvD6KhjHAJk8STCRVHqltjMrPBivk+v4QTFeG3VUlyfMFslJ81UzRzxVVf2D
         jMluB0LRmJUzmsPSFNTLhkgH3ujFaBlyiUcmY/ZeF4t6qM3YSs2zFh8V5V9tnr3rPr4d
         U1Spoy6jTO0nfVkPKxq7RhQuoLOcATOgwku7wufxby+dnDLl6CFQYgIQPMklc2KjIWdn
         Qf1yowwyM/DjKsV+yS375LfzUxy6GINpXaVV+Wyj+zzAymAP8j4eee5fQm7uXng4mBVW
         wK0Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1723820977; x=1724425777;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=ycsrSNVghYJYo7Kq/sAqp6MnjeFyaL9nJFuFS/dh9Nk=;
        b=c1ZhDKGMw7/5X2nJYnxVA+tPM0XxtQZadREgAVlzveZsxmHQaQscMZfTRzgIkEQXQu
         tL5y6NhcYK2ieNkdneGYKcolb89g5vorIKf53W1kG8IHhnCrTjGYXmY0lhQams0pfUOZ
         1pGIXyeXZEde+r/KY6p2tw68QZ8KPSLuuwQQkY5d81Ca6HbKP1cXkA4slJM05CSUQrvT
         Q1Yt7oLtqkHsPCHOAGg7FUBdg8HFILbggk7lQBwKXdU8nPQHZTIm2CWCcvW7QN0/ptn/
         T1Xy9Nap3wxMbYY/BRIrc9D+0RmKOmRq1WqHuGtJtomLcaTN1dmAospRcFydsQzwnTZL
         C4lw==
X-Forwarded-Encrypted: i=1; AJvYcCUYI1ky0d5NJGyrU19sVigLDH6s2Z5ttMW3DMQA+CIRWtAMdQod0qXRHPcUkRsTBmERM9jXV0ka9c0omcVfbP/3aysG8NICqpc=
X-Gm-Message-State: AOJu0YyW6uwjfuXFuggSUaXnlbeENG5eWIfVAlpleFLibAYUZ7PP+dfE
	cDzh54Gp+aDwx7WpJfiZ64g1YgfxxrHKzgpPOOqFDV+FG0LEGORzVepLtELEYC4=
X-Google-Smtp-Source: AGHT+IFDGX+GfHixPCgcFALGkNattnCz9fLq1GjkO92ZX/36nvryecE+9MvCeLg53L+RFEWex0FMuw==
X-Received: by 2002:a5d:5442:0:b0:371:8c79:73c1 with SMTP id ffacd0b85a97d-37194317aa2mr2276336f8f.2.1723820976767;
        Fri, 16 Aug 2024 08:09:36 -0700 (PDT)
Received: from krzk-bin.. ([178.197.215.209])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-3718984993fsm3808758f8f.31.2024.08.16.08.09.35
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 16 Aug 2024 08:09:36 -0700 (PDT)
From: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
To: Ulf Hansson <ulf.hansson@linaro.org>,
	"Rafael J. Wysocki" <rafael@kernel.org>,
	Daniel Lezcano <daniel.lezcano@linaro.org>,
	Anup Patel <anup@brainfault.org>,
	Paul Walmsley <paul.walmsley@sifive.com>,
	Palmer Dabbelt <palmer@dabbelt.com>,
	Albert Ou <aou@eecs.berkeley.edu>,
	linux-pm@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org,
	linux-kernel@vger.kernel.org,
	linux-riscv@lists.infradead.org
Cc: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Subject: [PATCH 2/4] cpuidle: riscv-sbi: Use scoped device node handling to simplify error paths
Date: Fri, 16 Aug 2024 17:09:29 +0200
Message-ID: <20240816150931.142208-2-krzysztof.kozlowski@linaro.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240816150931.142208-1-krzysztof.kozlowski@linaro.org>
References: <20240816150931.142208-1-krzysztof.kozlowski@linaro.org>
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Obtain the device node reference with scoped/cleanup.h to reduce error
handling and make the code a bit simpler.

Signed-off-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
---
 drivers/cpuidle/cpuidle-riscv-sbi.c | 21 +++++++--------------
 1 file changed, 7 insertions(+), 14 deletions(-)

diff --git a/drivers/cpuidle/cpuidle-riscv-sbi.c b/drivers/cpuidle/cpuidle-riscv-sbi.c
index a6e123dfe394..5bb3401220d2 100644
--- a/drivers/cpuidle/cpuidle-riscv-sbi.c
+++ b/drivers/cpuidle/cpuidle-riscv-sbi.c
@@ -8,6 +8,7 @@
 
 #define pr_fmt(fmt) "cpuidle-riscv-sbi: " fmt
 
+#include <linux/cleanup.h>
 #include <linux/cpuhotplug.h>
 #include <linux/cpuidle.h>
 #include <linux/cpumask.h>
@@ -236,19 +237,16 @@ static int sbi_cpuidle_dt_init_states(struct device *dev,
 {
 	struct sbi_cpuidle_data *data = per_cpu_ptr(&sbi_cpuidle_data, cpu);
 	struct device_node *state_node;
-	struct device_node *cpu_node;
 	u32 *states;
 	int i, ret;
 
-	cpu_node = of_cpu_device_node_get(cpu);
+	struct device_node *cpu_node __free(device_node) = of_cpu_device_node_get(cpu);
 	if (!cpu_node)
 		return -ENODEV;
 
 	states = devm_kcalloc(dev, state_count, sizeof(*states), GFP_KERNEL);
-	if (!states) {
-		ret = -ENOMEM;
-		goto fail;
-	}
+	if (!states)
+		return -ENOMEM;
 
 	/* Parse SBI specific details from state DT nodes */
 	for (i = 1; i < state_count; i++) {
@@ -264,10 +262,8 @@ static int sbi_cpuidle_dt_init_states(struct device *dev,
 
 		pr_debug("sbi-state %#x index %d\n", states[i], i);
 	}
-	if (i != state_count) {
-		ret = -ENODEV;
-		goto fail;
-	}
+	if (i != state_count)
+		return -ENODEV;
 
 	/* Initialize optional data, used for the hierarchical topology. */
 	ret = sbi_dt_cpu_init_topology(drv, data, state_count, cpu);
@@ -277,10 +273,7 @@ static int sbi_cpuidle_dt_init_states(struct device *dev,
 	/* Store states in the per-cpu struct. */
 	data->states = states;
 
-fail:
-	of_node_put(cpu_node);
-
-	return ret;
+	return 0;
 }
 
 static void sbi_cpuidle_deinit_cpu(int cpu)
-- 
2.43.0


