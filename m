Return-Path: <linux-pm+bounces-27580-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id BE4F0AC2455
	for <lists+linux-pm@lfdr.de>; Fri, 23 May 2025 15:44:57 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 91BB3A483E3
	for <lists+linux-pm@lfdr.de>; Fri, 23 May 2025 13:43:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4D979297A6E;
	Fri, 23 May 2025 13:41:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="k0WKNeD2"
X-Original-To: linux-pm@vger.kernel.org
Received: from mail-lf1-f46.google.com (mail-lf1-f46.google.com [209.85.167.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 55A0B297136
	for <linux-pm@vger.kernel.org>; Fri, 23 May 2025 13:41:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1748007675; cv=none; b=SFWb2pMQ2W20pIrMf422uW/oZ9bhP11lnAlYd7V9m37YrWSuFjsmzBtlRknk7wCrfURjBVqfiksSEScRrMBmuZT+7ABESbAXZ4dj0xvbQvQwNHTIM663lcXH9nNBdsql8rz1MUwGAWQ74nxDKAggg6jqq4hfJD1iXFZKBq9dZ/8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1748007675; c=relaxed/simple;
	bh=eMWGIDGG2xlLJR/Z5iDFdeDcOa6riWNWL1MAhPqMtR0=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=SsrTCPPVgbahm6Lf0HjVXKVhW+3HS0ynGGI/rHTW5xv1mKBvm3MkLDV5Mm/M/GM5Duk2aMr5G53hMTt4tD04zffMTapJHJACSH5n7psLXKwJz4E23iuOoPgOOAHeW9KvnceCKkzNbNUZzxGhGSQMjDiuc6MS6tSpDzAcrwfnOf4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=k0WKNeD2; arc=none smtp.client-ip=209.85.167.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-lf1-f46.google.com with SMTP id 2adb3069b0e04-551f00720cfso7706383e87.0
        for <linux-pm@vger.kernel.org>; Fri, 23 May 2025 06:41:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1748007671; x=1748612471; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=hOoCE0j0+Nf7/A2FNrnJbBGarUG82qfn+WjoD3EiQd8=;
        b=k0WKNeD21YN74k0exTzTpTbMPhRc10L7moFPRP50QQsYfOYFQ77tOAzP7HbGCXGVBC
         kwnPCp7iYG6sDIghCtdPQD1ZrtFsj1BQboLgvP8U/hStz1NmfL9EkoWGg5vhgQAjC3da
         uOn6aCOpytU1y0SyPGocTk/RDLBlw/daMpMeiWKd+c/TMR4llZM+LF/+p7U+FbvCn7OI
         lnnq171366JCIbW3BSy+JQl5P9g8ig0T4g0ah6o2ebKks1++uCq4a/ev3uns/OAHmuxl
         DeC4kNqpZRTvzCRt2PyACkL8TPK8A1/r+rr0Kl0G/vyYiqoGnvSfCsRzxW8vgvfnzsfk
         3rLQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1748007671; x=1748612471;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=hOoCE0j0+Nf7/A2FNrnJbBGarUG82qfn+WjoD3EiQd8=;
        b=DqjcZivniE1vyrd/kAOJYUPCte8v4e7QGnqL/MYjdrMSEprzDIiW21qRvocmEjn93B
         xalx/Fd7s1wc3nv/i+Q5pAOjKySi9RLYJJZIhwkGE5mbfGAfA/bBGSpZFgxZ7DRXPmuS
         zpiXKWptWKsEb0hqlCrCioTo2LauJD5Hy8x5+Dui+LAYOK0b8+QbBa0U7FvMt/62tdku
         FJQ8Lvw4jxeJZcOesFnnGLEbhyr1RXHoGYIybkB0F1lvxlL50ncLYRz4KK0s80Yz3OVc
         tDINjHdZDcQE+WklQwe9AKfWNMXwFxQUJ9ktagB/s1RKTZ7VBgz6MWPcBK251TLEAar9
         8S6g==
X-Forwarded-Encrypted: i=1; AJvYcCVUjjlId57XFpAI9g8pG8JCjnlnCZGn6iAIp7kVpg9hY/Yn7jpqhvap2Z8ARNvkb0GyJjVZ4LLJzQ==@vger.kernel.org
X-Gm-Message-State: AOJu0YySDiiw+D4uF2RkvElu90JXqV8A6u/weKWruP4tJjklIidYz9f0
	POEPRUB8Lz54AoS/0kq2rGXWTtKGfIuTsnFKAoqhnCaUYpU/MmbSIp3UeGzVJI76E3M=
X-Gm-Gg: ASbGncvbxuLdlqOpolp0TuWvEnL5KnG5v/Uk7gadCMHv6TS/NrGeOxT1sWuULfySEPa
	rBnWAjLFKmL3Kf8fzl3S0EwwfELz35fzEF0sXb4p+R836WmE6czciPjWrfGGkyx8PCR42IPWIP4
	7dvbm7vySZvLd7QcjWWcPtbmUui5xmpY+1Z9b3uIuRP//Fs7el1WD1/5i72sabR5Sg/LCIafGyS
	p2uJKXW8de6ozjoBsEWuJ4iq6WB7//OVUC3nJd+hQ1TcqmYIrRy0qQgM9zYVQTo95J1qeCO8CCD
	lJuqxqDOIVXP1WLy5aJAJ7diguD2B20ejWUl+o8KjfIdGMkwHePi9tFEe/zSAT6iTk5RBA+jrDt
	tRgkzjAvxeFWtBVxZUZ8kOF7gGw==
X-Google-Smtp-Source: AGHT+IEVVVIanD+SM8PaeTS5BPNrUZEt3qImxQaWobI9SebxfHyiMxLEusYRHx51DE+mAPmIootadg==
X-Received: by 2002:a05:6512:438c:b0:54e:a23f:82d9 with SMTP id 2adb3069b0e04-550e71d1472mr7232899e87.25.1748007671215;
        Fri, 23 May 2025 06:41:11 -0700 (PDT)
Received: from uffe-tuxpro14.. (h-178-174-189-39.A498.priv.bahnhof.se. [178.174.189.39])
        by smtp.gmail.com with ESMTPSA id 2adb3069b0e04-551fc0d473bsm1950609e87.244.2025.05.23.06.41.10
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 23 May 2025 06:41:10 -0700 (PDT)
From: Ulf Hansson <ulf.hansson@linaro.org>
To: Saravana Kannan <saravanak@google.com>,
	Stephen Boyd <sboyd@kernel.org>,
	linux-pm@vger.kernel.org
Cc: "Rafael J . Wysocki" <rafael@kernel.org>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Michael Grzeschik <m.grzeschik@pengutronix.de>,
	Bjorn Andersson <andersson@kernel.org>,
	Abel Vesa <abel.vesa@linaro.org>,
	Peng Fan <peng.fan@oss.nxp.com>,
	Tomi Valkeinen <tomi.valkeinen@ideasonboard.com>,
	Johan Hovold <johan@kernel.org>,
	Maulik Shah <maulik.shah@oss.qualcomm.com>,
	Michal Simek <michal.simek@amd.com>,
	Konrad Dybcio <konradybcio@kernel.org>,
	Thierry Reding <thierry.reding@gmail.com>,
	Jonathan Hunter <jonathanh@nvidia.com>,
	Ulf Hansson <ulf.hansson@linaro.org>,
	linux-arm-kernel@lists.infradead.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH v2 20/21] cpuidle: psci: Drop redundant sync_state support
Date: Fri, 23 May 2025 15:40:17 +0200
Message-ID: <20250523134025.75130-21-ulf.hansson@linaro.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20250523134025.75130-1-ulf.hansson@linaro.org>
References: <20250523134025.75130-1-ulf.hansson@linaro.org>
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The recent updates to the genpd core, can entirely manage the sync_state
support for the cpuidle-psci-domain. More precisely, genpd prevents our
->power_off() callback from being invoked, until all of our consumers are
ready for it.

Let's therefore drop the sync_state support for the cpuidle-psci-domain as
it has become redundant.

Signed-off-by: Ulf Hansson <ulf.hansson@linaro.org>
---
 drivers/cpuidle/cpuidle-psci-domain.c | 22 +---------------------
 1 file changed, 1 insertion(+), 21 deletions(-)

diff --git a/drivers/cpuidle/cpuidle-psci-domain.c b/drivers/cpuidle/cpuidle-psci-domain.c
index b880ce2df8b5..37c41209eaf9 100644
--- a/drivers/cpuidle/cpuidle-psci-domain.c
+++ b/drivers/cpuidle/cpuidle-psci-domain.c
@@ -28,7 +28,6 @@ struct psci_pd_provider {
 };
 
 static LIST_HEAD(psci_pd_providers);
-static bool psci_pd_allow_domain_state;
 
 static int psci_pd_power_off(struct generic_pm_domain *pd)
 {
@@ -38,9 +37,6 @@ static int psci_pd_power_off(struct generic_pm_domain *pd)
 	if (!state->data)
 		return 0;
 
-	if (!psci_pd_allow_domain_state)
-		return -EBUSY;
-
 	/* OSI mode is enabled, set the corresponding domain state. */
 	pd_state = state->data;
 	psci_set_domain_state(pd, pd->state_idx, *pd_state);
@@ -63,8 +59,7 @@ static int psci_pd_init(struct device_node *np, bool use_osi)
 	if (!pd_provider)
 		goto free_pd;
 
-	pd->flags |= GENPD_FLAG_IRQ_SAFE | GENPD_FLAG_CPU_DOMAIN |
-		     GENPD_FLAG_NO_SYNC_STATE;
+	pd->flags |= GENPD_FLAG_IRQ_SAFE | GENPD_FLAG_CPU_DOMAIN;
 
 	/*
 	 * Allow power off when OSI has been successfully enabled.
@@ -127,20 +122,6 @@ static void psci_pd_remove(void)
 	}
 }
 
-static void psci_cpuidle_domain_sync_state(struct device *dev)
-{
-	struct psci_pd_provider *pd_provider;
-
-	/*
-	 * All devices have now been attached/probed to the PM domain topology,
-	 * hence it's fine to allow domain states to be picked.
-	 */
-	psci_pd_allow_domain_state = true;
-
-	list_for_each_entry(pd_provider, &psci_pd_providers, link)
-		of_genpd_sync_state(pd_provider->node);
-}
-
 static const struct of_device_id psci_of_match[] = {
 	{ .compatible = "arm,psci-1.0" },
 	{}
@@ -201,7 +182,6 @@ static struct platform_driver psci_cpuidle_domain_driver = {
 	.driver = {
 		.name = "psci-cpuidle-domain",
 		.of_match_table = psci_of_match,
-		.sync_state = psci_cpuidle_domain_sync_state,
 	},
 };
 
-- 
2.43.0


