Return-Path: <linux-pm+bounces-27568-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 56A95AC2440
	for <lists+linux-pm@lfdr.de>; Fri, 23 May 2025 15:42:24 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 29ADC189F953
	for <lists+linux-pm@lfdr.de>; Fri, 23 May 2025 13:42:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A16E629552F;
	Fri, 23 May 2025 13:40:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="whCClBMY"
X-Original-To: linux-pm@vger.kernel.org
Received: from mail-lf1-f50.google.com (mail-lf1-f50.google.com [209.85.167.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A7D7B29550D
	for <linux-pm@vger.kernel.org>; Fri, 23 May 2025 13:40:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1748007654; cv=none; b=E4X0rJ7J6wgYUOKucKR15aU4x5csPr2LkU1xYfpikdTlhOQ/J+T5/nAvFGdrgptbQolpiFLAOZalltoOo42Zh4h6KaH5I8prbze04vJSBUlqmQXV4Qv2qnsTnRSMBKc/7nWDMybvisPY37wD3BairqVrdoCU+C+iov2ycxQmQNM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1748007654; c=relaxed/simple;
	bh=KKNT1JhbaPmauJ6i6M1lbqlI91jHIa2Cm6I3t2dDms0=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=JJsdG0rmsriupVnOJGDktoZE0uu6DEfE7NzqpqDW66q8jxq2X2J8FOx/mStLJK2D46ewm1h99cFeY/FQnbVR+N0KfC4G7V/bYEpcC2k1JuVzbEvCCXzkGqHOCUGcQbvcw3OU5olGWcjHY/xnkoO8SRg2/lh7eGtVo0ao6X8OVoQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=whCClBMY; arc=none smtp.client-ip=209.85.167.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-lf1-f50.google.com with SMTP id 2adb3069b0e04-551fe46934eso1062818e87.1
        for <linux-pm@vger.kernel.org>; Fri, 23 May 2025 06:40:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1748007651; x=1748612451; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=JhgdoK3MpeYw+rOuxZhcYLfRQHzQPd8VTaoRAeP4HH8=;
        b=whCClBMYkRzNHXcdd4O0EvWWXePnsFuJMk2+j3lxEPIm7wFpzwh11hZiYn/xK6Rq+H
         u4EEDdMrOOAaj4Ygz9/C2Bp39pBOKM1IDpKOeHmthGxmntiYVNo9gbdm6WviVwjy3CSS
         Un57mbalkvh+VNocTjtlgt6Ft1nzSq2GG6pj1jytqDXQ5Tpc2VF08ZzKh/bWhx5qamd0
         XABfgCQcYQ6M1hGh5lXOysNE3dhdRasPX5vFiTzlKD3Bg+cGDtN2FNruSPADkcFJm9kS
         7/aEMBd5mP1HRe1OBW6zRH0WE66eeMCDadapmXwIlg769o4AH7MUFV/SoVtpnPll1Hzo
         zJXg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1748007651; x=1748612451;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=JhgdoK3MpeYw+rOuxZhcYLfRQHzQPd8VTaoRAeP4HH8=;
        b=jUuGkG4bVuAqaAYPGn85OQNn5RUs9dbZVpz4nmc3xC+Tqh8hV3Fu9SUS/mwEXtYjQA
         /QG54ZZS5DFbwIzyME1JAiG6qAb6ZcJwvnV6rl5fiF9ncbFP+sYzRuVL8163iDoWqvxj
         2qHXGf2c63uQyiO8g76GqHE3gQQFZr0UYh8eLy3pqQ/kgbN3MQsQ3xnpaRxVCfJ19NNx
         0QFRT3T+JtMt0n7yyKlscurkw9nTh7C8V805EPAenteGp2zFLqFHOUGpp7JPyuRKrAg1
         59aOfYhrmKi6GHBhcY2W+XI5cthy1pZzrc9taeSaf7SbRLyRS78B1O1wawEQUU2Cr4X3
         E7uw==
X-Forwarded-Encrypted: i=1; AJvYcCX4vrswBRfbXnm8cdfVwQuWCXiZxlnJogd0lhe55LjoGZ0K7qwRs/liewMbRYLYFFzTOGbBk4JaEg==@vger.kernel.org
X-Gm-Message-State: AOJu0Yx3CCdolzUPY42NYkByiQjsrHgf6r/wQtLi0Fug5iM1CgPvwBf6
	OguRO74b4idp/0gucpJ+TNTqDNZGe2AYzcVSGSylqU91iMmnpCjY5q/PUIxL5QbBadE=
X-Gm-Gg: ASbGncs1oHf/YVJg8aNc1MQKFpOKccsFU4dAeDQhoFUdFi5fMsG/FMpp15jleVH/gmw
	BfvtSKb0ReKPMroxkn9Ap+U29dqV89O596w8O9lNPZiIpdIQpFi7iSnFn1fEb9uU6LILISdoHwt
	IlFDDFW7Mpydd1P7rJRv8OEZ74JXYh7V9ABUJhY5iswsVlLT8FkCUutDulw17zJOPIZNqwUaz9B
	pwnDzeXKDwbRBRTzNnGQv5COtjLZjfktDmdygxi5L/4CiPQP0sQWK5FURwwjMo/ZU/04LAwIXwt
	hA92HwjLS4Izdb2QyeqAWvBUhFK3bl/Pp9Ob8sAlvo3yCLDPkNID2TMPnKddCQHloxATgjRFr4M
	4ni1g8uWyxoUwq1Iw8tmgbu3/Lg==
X-Google-Smtp-Source: AGHT+IGxKZRIYcmGHvMkuMsGKvsKXAq1cHpyxb57jcrvbj7O4xdTx/mj+TIt0JjLrEZhlxZqFEhQ/g==
X-Received: by 2002:a05:6512:3b8c:b0:545:a70:74c5 with SMTP id 2adb3069b0e04-552156b0fa0mr1317620e87.13.1748007650658;
        Fri, 23 May 2025 06:40:50 -0700 (PDT)
Received: from uffe-tuxpro14.. (h-178-174-189-39.A498.priv.bahnhof.se. [178.174.189.39])
        by smtp.gmail.com with ESMTPSA id 2adb3069b0e04-551fc0d473bsm1950609e87.244.2025.05.23.06.40.48
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 23 May 2025 06:40:49 -0700 (PDT)
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
Subject: [PATCH v2 07/21] cpuidle: psci: Opt-out from genpd's common ->sync_state() support
Date: Fri, 23 May 2025 15:40:04 +0200
Message-ID: <20250523134025.75130-8-ulf.hansson@linaro.org>
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

The cpuidle-psci-domain implements its own specific ->sync_state()
callback. Let's set the GENPD_FLAG_NO_SYNC_STATE to inform genpd about it.

Moreover, let's call of_genpd_sync_state() to make sure genpd tries to
power off unused PM domains.

Signed-off-by: Ulf Hansson <ulf.hansson@linaro.org>
---
 drivers/cpuidle/cpuidle-psci-domain.c | 8 +++++++-
 1 file changed, 7 insertions(+), 1 deletion(-)

diff --git a/drivers/cpuidle/cpuidle-psci-domain.c b/drivers/cpuidle/cpuidle-psci-domain.c
index 2041f59116ce..b880ce2df8b5 100644
--- a/drivers/cpuidle/cpuidle-psci-domain.c
+++ b/drivers/cpuidle/cpuidle-psci-domain.c
@@ -63,7 +63,8 @@ static int psci_pd_init(struct device_node *np, bool use_osi)
 	if (!pd_provider)
 		goto free_pd;
 
-	pd->flags |= GENPD_FLAG_IRQ_SAFE | GENPD_FLAG_CPU_DOMAIN;
+	pd->flags |= GENPD_FLAG_IRQ_SAFE | GENPD_FLAG_CPU_DOMAIN |
+		     GENPD_FLAG_NO_SYNC_STATE;
 
 	/*
 	 * Allow power off when OSI has been successfully enabled.
@@ -128,11 +129,16 @@ static void psci_pd_remove(void)
 
 static void psci_cpuidle_domain_sync_state(struct device *dev)
 {
+	struct psci_pd_provider *pd_provider;
+
 	/*
 	 * All devices have now been attached/probed to the PM domain topology,
 	 * hence it's fine to allow domain states to be picked.
 	 */
 	psci_pd_allow_domain_state = true;
+
+	list_for_each_entry(pd_provider, &psci_pd_providers, link)
+		of_genpd_sync_state(pd_provider->node);
 }
 
 static const struct of_device_id psci_of_match[] = {
-- 
2.43.0


