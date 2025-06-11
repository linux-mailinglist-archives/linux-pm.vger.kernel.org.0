Return-Path: <linux-pm+bounces-28428-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 45854AD493A
	for <lists+linux-pm@lfdr.de>; Wed, 11 Jun 2025 05:11:05 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 684D518990FC
	for <lists+linux-pm@lfdr.de>; Wed, 11 Jun 2025 03:11:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DAB3E226D14;
	Wed, 11 Jun 2025 03:10:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=sifive.com header.i=@sifive.com header.b="W2XyUIum"
X-Original-To: linux-pm@vger.kernel.org
Received: from mail-pl1-f169.google.com (mail-pl1-f169.google.com [209.85.214.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 43597226CE1
	for <linux-pm@vger.kernel.org>; Wed, 11 Jun 2025 03:10:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.169
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1749611448; cv=none; b=QxmT+yRpeZx0DkxTSEw9jkotIL1FR5hwQuVIFhnf6v7yCCO5A3PDiodeRL8qaEg52mrndL8ThnDCjh5WbW4HTlxyNoEbWLAh17K+U5BRS2jNv4iifyAXgha6WonlkNtmynwIx15pG19zyIchcVgHAUWa+iUTosyvA/wOXWFF+Xo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1749611448; c=relaxed/simple;
	bh=KrEgTlTKNYpqIt4xZ0P452kHDiRYhHzjwpzLwEUokjE=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References; b=DwBGXr/RscY9AjUDqKkSB7MplIeAJO4QK8hQY3KKWP5nDTRZJ+gOKjQWowjXHMlrdC9pHYwiHs3YP0lbEKWoZlyOuZ3pr5v4AbLbFxpkwUWXc9I6ZviWrRcDNghtaZAZDlcjkk8yRZGOBLorW+EbZ1UFGNkzlvWmaKeU3RPr9+k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=sifive.com; spf=pass smtp.mailfrom=sifive.com; dkim=pass (2048-bit key) header.d=sifive.com header.i=@sifive.com header.b=W2XyUIum; arc=none smtp.client-ip=209.85.214.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=sifive.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=sifive.com
Received: by mail-pl1-f169.google.com with SMTP id d9443c01a7336-23526264386so53486485ad.2
        for <linux-pm@vger.kernel.org>; Tue, 10 Jun 2025 20:10:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=sifive.com; s=google; t=1749611446; x=1750216246; darn=vger.kernel.org;
        h=references:in-reply-to:message-id:date:subject:cc:to:from:from:to
         :cc:subject:date:message-id:reply-to;
        bh=d1JqEGYxVH+Ie0t+M4xdy6Q//NYQPkO37iVKF4LgSqk=;
        b=W2XyUIumYJ8WJWVO2hcxqnqFsixtTnsU0aQp6EhJc0OckOY4i6posrezgi9cP4RSrg
         2Ibv++myFxCL6ZCBHsrH3kJyhmyaqtWnWVIjLHNE3S4zv1TxG2bU/0mbmV8m3gQ6aTMP
         RUcMuMCeDgYse/WS61FdiNfWrYtYM1L7xrW3kkimM9LQoFPHyF5XspLFwZTcjznsW7Ul
         SdgfZ4GXGcGxAUsvuj4g9+uorgRURymfSJmHaVVEksOPdNO42wfqdeGM5uXv0tcCC46i
         JtVKmAc4TrjCcMGMh2uR8JxbgGlAwRwKxyEo7kBWgVxA7nAsdnrjO6peyUOVyi01jRtU
         mFmw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1749611446; x=1750216246;
        h=references:in-reply-to:message-id:date:subject:cc:to:from
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=d1JqEGYxVH+Ie0t+M4xdy6Q//NYQPkO37iVKF4LgSqk=;
        b=VBnmpquaD7AcpFVfSEpKsLzzG1tLLLacR3SzgLlAIt/x4lfO8E98fuWuRY8m5laXxF
         fXtLC+g6CZnqfq3O7qwLvUqJZMHT3aWFsMV/1rBa3KR3aoCJ+pu2m+FnVYlp+sSCEY9A
         tW8jDdkxeOyME8JyeG6Aoct0e1CWYHuPJCvDiIuQ9n1lLr0xtxRLiUzVz03rKNbPHDtG
         7QXy7AW5Fdwj4kPk3oKJeosD7Obx/FRFVzYPcERxNB5NSGe6o0t0tnrGx8X3VAQS/f77
         2HMhV8A3SmDkAmDVAavgGFaHYBOha7N1odpPUS6HrwcamRfk/YAOcz9k9fyHY/lmrrm6
         WH+A==
X-Forwarded-Encrypted: i=1; AJvYcCWrMXG3HGyBESZP1waXePY7d4RPm0aTkO+2VNWtaeKW15B0fEXoSv0M5ca2OEMz6fN+66yShJlRqw==@vger.kernel.org
X-Gm-Message-State: AOJu0Yz44dLN7Yiu+Uo/1/blBL/+UYYjA+/nrXR5lLjcVKlNMNAQ5r5S
	L1nOrVVgBbE5lV/2/+zJtQPYvLMf/EpO4or1pZPUVViazShAfBpnUEYD/e77o4dOMKY=
X-Gm-Gg: ASbGncv+Y7Ljz2mXWCMud2B0e8U/aro8iczPBvJ5fNSgMx+cwYM9Cut5M6UHEYi2hxw
	QcgU5VoRCDIzcvGC45NfoUusUcA75/60vnkTtCNN6J/YxytQxGvSH0ABSIpDJ9MIaOpxEAgBRRt
	zc58AvABMRYraW+zvRH2PZBsH5uAj8wixrD7/YpUcN3xEUDc3upLVVTDd6b0H3ED23Ytq5ENsAE
	BcaIVwlryP7zRlRgmQ0NRYSNsfSX822/HHfygMSP4R7jmgm6s2aHAR2V6agmcAI+9sjvSbHTfms
	+1KJdNftIpsXLiFyU5Ur+Y0bIYex4sV2b9m6HCjbIO2OnrVi+hrWTEsn8LrU4cNPV9Pku3dVywH
	oxWYGs3+tvuD11FMyXzk=
X-Google-Smtp-Source: AGHT+IG0HUndhOWNBFfl4fKV1QgjHGpPPezok587Gqjk8idox7vCs0ZKIJPZwB64MsRnAjYqekYvnA==
X-Received: by 2002:a17:903:2390:b0:234:e7aa:5d9b with SMTP id d9443c01a7336-23641ab511amr21843485ad.23.1749611446469;
        Tue, 10 Jun 2025 20:10:46 -0700 (PDT)
Received: from hsinchu26.internal.sifive.com ([210.176.154.34])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-236030789c2sm77669035ad.29.2025.06.10.20.10.44
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 10 Jun 2025 20:10:46 -0700 (PDT)
From: Nick Hu <nick.hu@sifive.com>
To: conor+dt@kernel.org,
	krzk+dt@kernel.org,
	Alexandre Ghiti <alex@ghiti.fr>,
	linux-kernel@vger.kernel.org,
	linux-pm@vger.kernel.org,
	linux-riscv@lists.infradead.org
Cc: Nick Hu <nick.hu@sifive.com>,
	Samuel Holland <samuel.holland@sifive.com>,
	Anup Patel <anup@brainfault.org>,
	"Rafael J. Wysocki" <rafael@kernel.org>,
	Daniel Lezcano <daniel.lezcano@linaro.org>,
	Paul Walmsley <paul.walmsley@sifive.com>,
	Palmer Dabbelt <palmer@dabbelt.com>,
	Albert Ou <aou@eecs.berkeley.edu>
Subject: [PATCH v2 2/3] cpuidle: riscv-sbi: Work with the external pmdomain driver
Date: Wed, 11 Jun 2025 11:10:21 +0800
Message-Id: <20250611031023.28769-3-nick.hu@sifive.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20250611031023.28769-1-nick.hu@sifive.com>
References: <20250611031023.28769-1-nick.hu@sifive.com>
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>

To work with the external pmdomain driver, exposing the
`sbi_cpuidle_pd_power_off` and `sbi_dt_parse_state_node` so the external
pmdomain driver can parse the riscv idle state data and set the domain
idle state where powering off. In addition, defer the driver without
error message when the parent domain is not ready.

Co-developed-by: Samuel Holland <samuel.holland@sifive.com>
Signed-off-by: Samuel Holland <samuel.holland@sifive.com>
Signed-off-by: Nick Hu <nick.hu@sifive.com>
---
 drivers/cpuidle/cpuidle-riscv-sbi.c | 17 +++++++++++------
 drivers/cpuidle/cpuidle-riscv-sbi.h | 20 ++++++++++++++++++++
 2 files changed, 31 insertions(+), 6 deletions(-)
 create mode 100644 drivers/cpuidle/cpuidle-riscv-sbi.h

diff --git a/drivers/cpuidle/cpuidle-riscv-sbi.c b/drivers/cpuidle/cpuidle-riscv-sbi.c
index 0fe1ece9fbdc..d53254601522 100644
--- a/drivers/cpuidle/cpuidle-riscv-sbi.c
+++ b/drivers/cpuidle/cpuidle-riscv-sbi.c
@@ -27,6 +27,7 @@
 #include <asm/suspend.h>
 
 #include "cpuidle.h"
+#include "cpuidle-riscv-sbi.h"
 #include "dt_idle_states.h"
 #include "dt_idle_genpd.h"
 
@@ -188,7 +189,7 @@ static const struct of_device_id sbi_cpuidle_state_match[] = {
 	{ },
 };
 
-static int sbi_dt_parse_state_node(struct device_node *np, u32 *state)
+int sbi_dt_parse_state_node(struct device_node *np, u32 *state)
 {
 	int err = of_property_read_u32(np, "riscv,sbi-suspend-param", state);
 
@@ -325,8 +326,9 @@ static int sbi_cpuidle_init_cpu(struct device *dev, int cpu)
 	/* Initialize idle states from DT. */
 	ret = sbi_cpuidle_dt_init_states(dev, drv, cpu, state_count);
 	if (ret) {
-		pr_err("HART%ld: failed to init idle states\n",
-		       cpuid_to_hartid_map(cpu));
+		if (ret != -EPROBE_DEFER)
+			pr_err("HART%ld: failed to init idle states\n",
+			       cpuid_to_hartid_map(cpu));
 		return ret;
 	}
 
@@ -356,7 +358,7 @@ static void sbi_cpuidle_domain_sync_state(struct device *dev)
 
 #ifdef CONFIG_DT_IDLE_GENPD
 
-static int sbi_cpuidle_pd_power_off(struct generic_pm_domain *pd)
+int sbi_cpuidle_pd_power_off(struct generic_pm_domain *pd)
 {
 	struct genpd_power_state *state = &pd->states[pd->state_idx];
 	u32 *pd_state;
@@ -533,8 +535,11 @@ static int sbi_cpuidle_probe(struct platform_device *pdev)
 	for_each_present_cpu(cpu) {
 		ret = sbi_cpuidle_init_cpu(&pdev->dev, cpu);
 		if (ret) {
-			pr_debug("HART%ld: idle driver init failed\n",
-				 cpuid_to_hartid_map(cpu));
+			if (ret == -EPROBE_DEFER)
+				pr_debug("idle driver probe deferred\n");
+			else
+				pr_debug("HART%ld: idle driver init failed\n",
+					 cpuid_to_hartid_map(cpu));
 			goto out_fail;
 		}
 	}
diff --git a/drivers/cpuidle/cpuidle-riscv-sbi.h b/drivers/cpuidle/cpuidle-riscv-sbi.h
new file mode 100644
index 000000000000..f39186b65a10
--- /dev/null
+++ b/drivers/cpuidle/cpuidle-riscv-sbi.h
@@ -0,0 +1,20 @@
+/* SPDX-License-Identifier: GPL-2.0 */
+#ifndef __CPUIDLE_RISCV_SBI
+#define __CPUIDLE_RISCV_SBI
+
+#ifdef CONFIG_DT_IDLE_GENPD
+
+int sbi_cpuidle_pd_power_off(struct generic_pm_domain *pd);
+
+#else
+
+static inline int sbi_cpuidle_pd_power_off(struct generic_pm_domain *pd)
+{
+	return 0;
+}
+
+#endif
+
+int sbi_dt_parse_state_node(struct device_node *np, u32 *state);
+
+#endif
-- 
2.17.1


