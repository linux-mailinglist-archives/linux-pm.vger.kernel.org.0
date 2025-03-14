Return-Path: <linux-pm+bounces-24013-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 9EC2FA60E17
	for <lists+linux-pm@lfdr.de>; Fri, 14 Mar 2025 11:01:42 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 4CAA4188FC94
	for <lists+linux-pm@lfdr.de>; Fri, 14 Mar 2025 10:01:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3F5791F3D54;
	Fri, 14 Mar 2025 10:01:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="pXHZ3iY8"
X-Original-To: linux-pm@vger.kernel.org
Received: from mail-lj1-f172.google.com (mail-lj1-f172.google.com [209.85.208.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 44F951F37DA
	for <linux-pm@vger.kernel.org>; Fri, 14 Mar 2025 10:01:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741946484; cv=none; b=LluPf0nI7A9tqpXKIht9nVY+BUp/fwmXGRyz7E3Nu5h6AA348ATg685d+ROVhxF9mW5TioUC7CztcVJlLz+r2fvgMQZd9JCpmrtUJGql/ZOIOmxnMNV/pItTXLqaDbwWRoqyoAu0cPVWSmX8dzF96yzINkw9aRdPFA1tRJ/qdY8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741946484; c=relaxed/simple;
	bh=jpL7H2rEOd8mfJnn5VtdO8SHZXRMgJyBIOewncmh6Uw=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Q/e1IXGIfIVMDhCaK+yVSZmfJq1cyiPY7PPWd/wHu4kfx36MUO4K9yTZBYiKx0+4DvfWulmIhFza1dYW8kxs//KzVakzeLSrYk7d4K98hq3SyPCfffjNdMV6ahS5Njl6w++uSmwdW0Uhdv85DYtaga7BaWirT5lltfIso6T4s90=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=pXHZ3iY8; arc=none smtp.client-ip=209.85.208.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-lj1-f172.google.com with SMTP id 38308e7fff4ca-30bf3f3539dso19089141fa.1
        for <linux-pm@vger.kernel.org>; Fri, 14 Mar 2025 03:01:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1741946480; x=1742551280; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=JE+q5aCnF90doB2QrACuAQ2CKvBByABqrTNx0sOx31w=;
        b=pXHZ3iY8GcRPvLmwRq4JB+agxDOVFPP3/utpOvNsggUPT/v6kbLQK/RjdBLZgahXI4
         at0BneNBqqgiri0wlYXE35ghozJP2uD6hnERhHIzbEhttpI+M/dLudepknf2cBmfN8Bm
         qvXppwSraIMP3BAaT2iY2dY+D/bmyP1iAGJaga4Ib76qzHgSpJxgyyvM/RRuelcWSQyR
         uy6/E6BvYCiYtUKKORDihai43jI2hblVJIsNKQ3kPjJe65sr+kWOV6JceEy5XaNL37wa
         G7J3NEPFt7Qt96FEVeLKiSvz/GtV2ltLyqABObL6Sl3CPmqbiSA58syXrdr0CjNGp66Q
         usDg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1741946480; x=1742551280;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=JE+q5aCnF90doB2QrACuAQ2CKvBByABqrTNx0sOx31w=;
        b=bVg7lPt/sYHfdUlKR8acSVtdIUYbyYdr8a9SCuJZRRXZt58v3lAeNgc8Ut/3STzH0P
         i4IRLc8uVTYSGWsw8vVFNt+shOXyg9hNavS1g4jdQVkMyW9vVuGTbPKDh2jvZr0husCj
         mrAMpkUimcmD6gtj2yP9H7r40ZgHzJLim+PEyvYamt4/5RQMaiV4b1z3V+2ZY856d+62
         v90K/4TrhOe4FNDfcdXLVmd/rzJv02Dpee7o0TbEk6c3NuEB8dgho10wBx0ZOu9ARhCE
         xEcR2NHzvEx0T3X9qqnac1jCZ6sWLAOZWG74/YiiT/XjIU8Kmajxo/nvxDn2Mi35VBUJ
         D9oA==
X-Forwarded-Encrypted: i=1; AJvYcCWKUTho6pSFO2nreXS2tYMIRUtRLBgbz8TaW6ywihdso9Uxzrrq0dJEunr7xnJrXIn7nBqN7k3NOw==@vger.kernel.org
X-Gm-Message-State: AOJu0YzEBXgaTfgKYawxAa+HKwuH5yFEPqq/GA3AlGGZd2PLZn5V9Pyq
	X4LVXbIpFeVFI3XHxR+7t1J3ObwCoGJgF60LqSfq+XLvH8K/dWi4omPkk5/O3vg=
X-Gm-Gg: ASbGnctJS7qpbCsQIJtmoWfRPZ1Pi2m0zxRF5bVmG/pTYiaaPz4n97dZTsvZ4/ATJ1k
	nKTMmat+VuuHxo3e+5vwMDFbcuKW0OJUnpEjfcy3SUE6ftylHtAQpqeHFoDdFMl0NUYrX6LLbIc
	vYT3uit/PaG2kHORZjrAAz5RPXHXqPN27FWxOcsnFEFckTr2A+TkpuMEqg7d7QGcsWsZF3q8vs/
	BeeFtBO8zbNeOCFhMIPC5oFmpYd8EEMK+7HB7pH6fxsHqzjpAccqKgISuqU4dIGAjo9I9J6EZiW
	VgrIBjuxYdCydn6KzSvN6i9awuf9blOL7otnP8fptqa1RiidX+X7Tz/ToZUurCJMYursmqtv4s0
	FtCBJfH2/LI02VpZfnkHmq0NUFxq1gQ==
X-Google-Smtp-Source: AGHT+IGhYmFMbUeatQB/z6JS0kcTyMcIT1IzBAPuh4fApk2bCc0yDwcZPgTrJD62ufz1WRxkinRL3Q==
X-Received: by 2002:a05:651c:1501:b0:30b:c36c:ba96 with SMTP id 38308e7fff4ca-30c4aa7711fmr7127431fa.1.1741946480268;
        Fri, 14 Mar 2025 03:01:20 -0700 (PDT)
Received: from uffe-tuxpro14.. (h-178-174-189-39.A498.priv.bahnhof.se. [178.174.189.39])
        by smtp.gmail.com with ESMTPSA id 38308e7fff4ca-30c3f0ea468sm5168221fa.41.2025.03.14.03.01.19
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 14 Mar 2025 03:01:19 -0700 (PDT)
From: Ulf Hansson <ulf.hansson@linaro.org>
To: "Rafael J . Wysocki" <rafael@kernel.org>,
	Sudeep Holla <sudeep.holla@arm.com>,
	linux-pm@vger.kernel.org
Cc: Lorenzo Pieralisi <lpieralisi@kernel.org>,
	Daniel Lezcano <daniel.lezcano@linaro.org>,
	Anup Patel <anup@brainfault.org>,
	Ulf Hansson <ulf.hansson@linaro.org>,
	linux-arm-kernel@lists.infradead.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH 2/4] cpuidle: psci: Move the per CPU variable domain_state to a struct
Date: Fri, 14 Mar 2025 11:00:56 +0100
Message-ID: <20250314100103.1294715-3-ulf.hansson@linaro.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20250314100103.1294715-1-ulf.hansson@linaro.org>
References: <20250314100103.1294715-1-ulf.hansson@linaro.org>
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

To prepare to extend the per CPU variable domain_state to include more
data, let's move it into a struct. A subsequent change will add the new
data. This change have no intended functional impact.

Signed-off-by: Ulf Hansson <ulf.hansson@linaro.org>
---
 drivers/cpuidle/cpuidle-psci.c | 21 +++++++++++++++------
 1 file changed, 15 insertions(+), 6 deletions(-)

diff --git a/drivers/cpuidle/cpuidle-psci.c b/drivers/cpuidle/cpuidle-psci.c
index dd8d776d6e39..1aff1ec555d5 100644
--- a/drivers/cpuidle/cpuidle-psci.c
+++ b/drivers/cpuidle/cpuidle-psci.c
@@ -36,19 +36,28 @@ struct psci_cpuidle_data {
 	struct device *dev;
 };
 
+struct psci_cpuidle_domain_state {
+	u32 state;
+};
+
 static DEFINE_PER_CPU_READ_MOSTLY(struct psci_cpuidle_data, psci_cpuidle_data);
-static DEFINE_PER_CPU(u32, domain_state);
+static DEFINE_PER_CPU(struct psci_cpuidle_domain_state, psci_domain_state);
 static bool psci_cpuidle_use_syscore;
 static bool psci_cpuidle_use_cpuhp;
 
 void psci_set_domain_state(u32 state)
 {
-	__this_cpu_write(domain_state, state);
+	__this_cpu_write(psci_domain_state.state, state);
 }
 
 static inline u32 psci_get_domain_state(void)
 {
-	return __this_cpu_read(domain_state);
+	return __this_cpu_read(psci_domain_state.state);
+}
+
+static inline void psci_clear_domain_state(void)
+{
+	__this_cpu_write(psci_domain_state.state, 0);
 }
 
 static __cpuidle int __psci_enter_domain_idle_state(struct cpuidle_device *dev,
@@ -87,7 +96,7 @@ static __cpuidle int __psci_enter_domain_idle_state(struct cpuidle_device *dev,
 	cpu_pm_exit();
 
 	/* Clear the domain state to start fresh when back from idle. */
-	psci_set_domain_state(0);
+	psci_clear_domain_state();
 	return ret;
 }
 
@@ -121,7 +130,7 @@ static int psci_idle_cpuhp_down(unsigned int cpu)
 	if (pd_dev) {
 		pm_runtime_put_sync(pd_dev);
 		/* Clear domain state to start fresh at next online. */
-		psci_set_domain_state(0);
+		psci_clear_domain_state();
 	}
 
 	return 0;
@@ -147,7 +156,7 @@ static void psci_idle_syscore_switch(bool suspend)
 
 			/* Clear domain state to re-start fresh. */
 			if (!cleared) {
-				psci_set_domain_state(0);
+				psci_clear_domain_state();
 				cleared = true;
 			}
 		}
-- 
2.43.0


