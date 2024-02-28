Return-Path: <linux-pm+bounces-4512-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 9E5F886B2D1
	for <lists+linux-pm@lfdr.de>; Wed, 28 Feb 2024 16:11:56 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id F050CB292D5
	for <lists+linux-pm@lfdr.de>; Wed, 28 Feb 2024 15:11:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C759515B98B;
	Wed, 28 Feb 2024 15:11:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="xV4slubV"
X-Original-To: linux-pm@vger.kernel.org
Received: from mail-lj1-f172.google.com (mail-lj1-f172.google.com [209.85.208.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9821415B97E
	for <linux-pm@vger.kernel.org>; Wed, 28 Feb 2024 15:11:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709133107; cv=none; b=jtDdnRR+YuhvP1amKEVVf4oWsCBIWXEKnaI5jG1k6q9A9Uo/o5lIEuzwNcS3IYu6I4bG8Oi91CdYeIfln8w+BOHUPI9JCHNhjOOzUXsr4Bh5tE+iAggLVWJGspqRu4YaWxauJCafRMErVenP95KhX2zLncVPPJlUG/7WuyXLSgM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709133107; c=relaxed/simple;
	bh=t8C6Kf4/GjWuIxApgLQFxQKbi5II3ReLIV37q1i/a5Y=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=drDPblb8lRD2SCubKbUOBE/4dhgP20eSwT9r7zH8v16Sj2A4cRqkmxwx370iy6TMBfVbC/LNHQ/ifuoF0qY5BvBlPYxU6u3L43Pbhf4E366fdTraSprcC5e9WtuSXdD1sJS3oUVIj8k4YgxmeVJaA8oeAUoWPANAHaZxJgXkYHg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=xV4slubV; arc=none smtp.client-ip=209.85.208.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-lj1-f172.google.com with SMTP id 38308e7fff4ca-2d220e39907so86830121fa.1
        for <linux-pm@vger.kernel.org>; Wed, 28 Feb 2024 07:11:45 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1709133103; x=1709737903; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=LtE+UgD0QskHrQJXqL71ZDAEvdhVjPCJCqkXaGVdmTI=;
        b=xV4slubVVz/OnMJkujQp57v1AoJbTKWPtupzi9To1nLhIH/iRTQm7bzpJznNE0nvkP
         11q/gZbdf7PTnEBbEBG2KNdoctxxY+0i8qYylVwJ6iH6NirinmiZdACh+CEYd0EBP28r
         6VOVGdPazerN+f/s1tZuQ8j5sdRFC2ngQSyA8XeiI4pBIhpZRem6DLukK9Ck0e8/8YlP
         xZEZ+Oc1wRqkFTZBU2MzKK8ua98VtNNV95LzQjmjnvAhZAuiDObJ1vduyPmdj65unV9O
         QhshzbDCaCel9NjigShda2J7HENUpjuaNRRxkrzYNa8gtDlfomWcNkuGQcH9GttvQTy0
         t8Sg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1709133103; x=1709737903;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=LtE+UgD0QskHrQJXqL71ZDAEvdhVjPCJCqkXaGVdmTI=;
        b=jFhWov5avp7Cp2d/2U9ywCGFOAaPjG2jI3XyHhd/y81pKH/zy+VAbc1Sk2b52v2eup
         5vMXdxhnRfXNNAxg94H1Tfb/O7RSqFwak+VFtxtdWA/lA7YJlkmPKWQI9eY8LUnWw8cs
         YARGyrQqe6gigR4DFQiew4zrp9LTpz8SOQ1D3q8NBexm2gGjv8P+0FUr9+97juFMaKqL
         6J/uyu/5TFPAaUcFbdrTZF4yxuoN74U1LEaPnX+SdpXcaz5Zfx76LXS3HDOu4RwGmr0t
         dMT0DqWFP0nPyS1egCySYwQNeGHPbz6d0u0SrgKlYi1jD2G8egOcWfPhAlBoFHll7JeE
         1IeQ==
X-Forwarded-Encrypted: i=1; AJvYcCVcpMQgGaTxMUU0T+IVM6jzyT5Ao6NdmxGEFsgGUv5+MpT5FtyIZeomUGO3ZJdNEwe4qgfr1hcMx55Z71eTltmORdjYRdW/m2U=
X-Gm-Message-State: AOJu0Yyc63yVwX9Z9gTWMkDh2fgAYXfHOzcgTPafXKWNETDXvz8KxtkN
	1U5Ip87OXgb8hmF13aE2364uhU3S46qYycE1SaA3z2PBp4CfJWCWuzLta68EKkQ=
X-Google-Smtp-Source: AGHT+IFjY2DdxE3YaQu9B/2dyU4BKjLYmqLA9+zox9Fix3aI+88/D2kZyxgGrpvERvBgjO5Eq0TSHw==
X-Received: by 2002:a2e:84d5:0:b0:2d2:2ce1:1196 with SMTP id q21-20020a2e84d5000000b002d22ce11196mr8197892ljh.53.1709133103567;
        Wed, 28 Feb 2024 07:11:43 -0800 (PST)
Received: from uffe-tuxpro14.. (h-178-174-189-39.A498.priv.bahnhof.se. [178.174.189.39])
        by smtp.gmail.com with ESMTPSA id k2-20020a2ea282000000b002d10daeb6dasm1652560lja.126.2024.02.28.07.11.42
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 28 Feb 2024 07:11:43 -0800 (PST)
From: Ulf Hansson <ulf.hansson@linaro.org>
To: "Rafael J . Wysocki" <rafael@kernel.org>,
	Sudeep Holla <sudeep.holla@arm.com>,
	linux-pm@vger.kernel.org
Cc: Lorenzo Pieralisi <lpieralisi@kernel.org>,
	Daniel Lezcano <daniel.lezcano@linaro.org>,
	Maulik Shah <quic_mkshah@quicinc.com>,
	Ulf Hansson <ulf.hansson@linaro.org>,
	linux-arm-kernel@lists.infradead.org
Subject: [PATCH] cpuidle: psci: Drop superfluous wrappers psci_dt_attach|detach_cpu()
Date: Wed, 28 Feb 2024 16:11:39 +0100
Message-Id: <20240228151139.2650258-1-ulf.hansson@linaro.org>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

To simplify the code, let's drop psci_dt_attach|detach_cpu() and use the
common dt_idle_attach|detach_cpu() directly instead.

Signed-off-by: Ulf Hansson <ulf.hansson@linaro.org>
---
 drivers/cpuidle/cpuidle-psci-domain.c |  1 +
 drivers/cpuidle/cpuidle-psci.c        |  5 +++--
 drivers/cpuidle/cpuidle-psci.h        | 20 --------------------
 3 files changed, 4 insertions(+), 22 deletions(-)

diff --git a/drivers/cpuidle/cpuidle-psci-domain.c b/drivers/cpuidle/cpuidle-psci-domain.c
index b88af1262f1a..2b47811d986f 100644
--- a/drivers/cpuidle/cpuidle-psci-domain.c
+++ b/drivers/cpuidle/cpuidle-psci-domain.c
@@ -20,6 +20,7 @@
 #include <linux/string.h>
 
 #include "cpuidle-psci.h"
+#include "dt_idle_genpd.h"
 
 struct psci_pd_provider {
 	struct list_head link;
diff --git a/drivers/cpuidle/cpuidle-psci.c b/drivers/cpuidle/cpuidle-psci.c
index bf68920d038a..782030a27703 100644
--- a/drivers/cpuidle/cpuidle-psci.c
+++ b/drivers/cpuidle/cpuidle-psci.c
@@ -28,6 +28,7 @@
 
 #include "cpuidle-psci.h"
 #include "dt_idle_states.h"
+#include "dt_idle_genpd.h"
 
 struct psci_cpuidle_data {
 	u32 *psci_states;
@@ -224,7 +225,7 @@ static int psci_dt_cpu_init_topology(struct cpuidle_driver *drv,
 	if (IS_ENABLED(CONFIG_PREEMPT_RT))
 		return 0;
 
-	data->dev = psci_dt_attach_cpu(cpu);
+	data->dev = dt_idle_attach_cpu(cpu, "psci");
 	if (IS_ERR_OR_NULL(data->dev))
 		return PTR_ERR_OR_ZERO(data->dev);
 
@@ -311,7 +312,7 @@ static void psci_cpu_deinit_idle(int cpu)
 {
 	struct psci_cpuidle_data *data = per_cpu_ptr(&psci_cpuidle_data, cpu);
 
-	psci_dt_detach_cpu(data->dev);
+	dt_idle_detach_cpu(data->dev);
 	psci_cpuidle_use_cpuhp = false;
 }
 
diff --git a/drivers/cpuidle/cpuidle-psci.h b/drivers/cpuidle/cpuidle-psci.h
index 4e132640ed64..ef004ec7a7c5 100644
--- a/drivers/cpuidle/cpuidle-psci.h
+++ b/drivers/cpuidle/cpuidle-psci.h
@@ -3,29 +3,9 @@
 #ifndef __CPUIDLE_PSCI_H
 #define __CPUIDLE_PSCI_H
 
-struct device;
 struct device_node;
 
 void psci_set_domain_state(u32 state);
 int psci_dt_parse_state_node(struct device_node *np, u32 *state);
 
-#ifdef CONFIG_ARM_PSCI_CPUIDLE_DOMAIN
-
-#include "dt_idle_genpd.h"
-
-static inline struct device *psci_dt_attach_cpu(int cpu)
-{
-	return dt_idle_attach_cpu(cpu, "psci");
-}
-
-static inline void psci_dt_detach_cpu(struct device *dev)
-{
-	dt_idle_detach_cpu(dev);
-}
-
-#else
-static inline struct device *psci_dt_attach_cpu(int cpu) { return NULL; }
-static inline void psci_dt_detach_cpu(struct device *dev) { }
-#endif
-
 #endif /* __CPUIDLE_PSCI_H */
-- 
2.34.1


