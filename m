Return-Path: <linux-pm+bounces-27579-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id A0DE9AC2456
	for <lists+linux-pm@lfdr.de>; Fri, 23 May 2025 15:45:01 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 1ADBC54412D
	for <lists+linux-pm@lfdr.de>; Fri, 23 May 2025 13:44:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0E3B929713D;
	Fri, 23 May 2025 13:41:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="uhCKU3oL"
X-Original-To: linux-pm@vger.kernel.org
Received: from mail-lf1-f54.google.com (mail-lf1-f54.google.com [209.85.167.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D4520297116
	for <linux-pm@vger.kernel.org>; Fri, 23 May 2025 13:41:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1748007673; cv=none; b=RJhGKF4cyh3mNnbLXtoyc6XAS4MiUsoTj1E082+GYr76OZZY5HO0Lc/4NrIfInRxfJ9STKSo5PfXzXZOwgyvYcFz6L1jCH3TOMX1mWfkilRKWr9c8rJuz60L8g7bXerEGBudIj2kSN7Gk3ljWM+c4fIeIZnhGs4qavTlYu4Iy84=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1748007673; c=relaxed/simple;
	bh=SdIrTkzSEt461VDJ4UWso4pVdWU9yzD2AudkucqhnnM=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=keISU0Ztvq2gHxEd4n/QN/vVIvEkEsPNQR6B1UDbF/TG/Emu5I6smeeSRT/1oWdrBdetDrTrELNwwc6a66wq+4k8AKxfvi3aJ9K6YgXN2N4z/9RI74sclSPvuov6WnCrjAVYbytX6QvMguqwg5T63XMhlzQDJvB/X5xAIAXRvQ8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=uhCKU3oL; arc=none smtp.client-ip=209.85.167.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-lf1-f54.google.com with SMTP id 2adb3069b0e04-551ed563740so8327118e87.2
        for <linux-pm@vger.kernel.org>; Fri, 23 May 2025 06:41:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1748007670; x=1748612470; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=D0aKf3r0veUqn1rT4el+1RxCAoZmF17+2VzJGANVxCI=;
        b=uhCKU3oL93S0hs/MEY40FEtREgBMhebkNIMCIjNvEq/9N343BDc1E+LPAPedcTOF/H
         zvlOTxfxD6pdQOxSSmrVzytAG9X2W/GKc+a98WW1hm5cCCNg/j4yUvHcf4KiBX1ssDni
         70hZQUwTqz2AMUTiVTWB/gK2MfXOPZZ89fcM9t0ZV1pE/bVB7Vpsnm0JcfXaweptwVYq
         Ll8+bLaiLT67/aLrOF2o88rjTyrdd3g4yBEGD6wDSGVh9CMXjXGUtSZWacC6wDrPvA0/
         JWrnzja3NIY3pJH8TMLYcp5j6tj+wClg9G2G32Wd1QXvcSSYHN64GmdnOuk33MLGcFU9
         molQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1748007670; x=1748612470;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=D0aKf3r0veUqn1rT4el+1RxCAoZmF17+2VzJGANVxCI=;
        b=dItLXVte8Ul117cbQBTkG1likA4aBiY5TyIGN5WwuQHCEOFOJ8Ny+Q/VddgEecFJQx
         YtP9Yz6AJQVzqQ/6yTSZic1EBQt5NJHh6qk3VFPKPl5LFRqnu6LsdRiuQqHDDHX0CboU
         l6wTaJkD3mkgIfqU/67L6f+uBpi8B+ZZQlAVszSWyn+UeDAOdtItd4kYPjwd9Ktg4em9
         Lw4zrMDYu7kfxQAzPyfMW2ZCidS9he2x8TZzfbcFD24qxOiVNK5q5ER/3IAAVcC8k3Me
         AU+IDRt/UF2FxIduddyCt6fXNK+lG7KttRRrL5FwsSQj+jAhcgZnIBc7z48SXX7Gv7IH
         yxLg==
X-Forwarded-Encrypted: i=1; AJvYcCUjzTEp7HdPMC09HRJOhsL+UUL1ymSMilnibq30ahl6/Z59Mrby7DGAj4AdLmloDcQ81BrEp/x1tQ==@vger.kernel.org
X-Gm-Message-State: AOJu0YzENtI/B84GSvmYfCxza6R3L58wwaoirE3MsKR6JPZP5vAmRwFu
	v6ozMzoZ+nO/+rLtCjgQSoid+dvIOp0Am7YyNdJTPeRHR+vcqBR7X65XP2e7YfvApFE=
X-Gm-Gg: ASbGncvCjbE4dTZ88GA4FidJcOYQ7Q2u0LMAgngSBPehlKITBTC7GN4yOhIS1D9nE+Q
	wVxnjDweT8ZBiE3zN4ofW7Tuuvs0oBoFBDDEO+SoAUogcz7M0uF9X56SdWmiA/LatVwAxrbrnnP
	c+pd86lk1wCLrRLb3I8O81vOjrLT3Uan1y92vo4gr55cJbhMgpS/GoBNC4CEnU+5dRT+0DrWKNm
	HU9StLsK4yoNzwyfxd/QPMgiwhhoAv7Q/HiFKMp+VSKOoUIZjRjDiAunbkjPK91hi0h8q5fqR0C
	yeO1/vjHqQgYuOvk364YilaUi2YiGORZ12wMKEhZJSznxMLxAHuN4bERKJz/1LoOG1yWyWz3yMI
	BRzHuoK2p6C7cFqVTeaPtmUGh+A==
X-Google-Smtp-Source: AGHT+IEajquH8YxvUkbDSaTSmZKiibO3mtnqJl45yxSX8n0PgKqQyv3ngd+5PXGwnfc30g1Js1BKCg==
X-Received: by 2002:a05:6512:3e04:b0:54b:f33:cc16 with SMTP id 2adb3069b0e04-550e71b2359mr11620509e87.16.1748007669877;
        Fri, 23 May 2025 06:41:09 -0700 (PDT)
Received: from uffe-tuxpro14.. (h-178-174-189-39.A498.priv.bahnhof.se. [178.174.189.39])
        by smtp.gmail.com with ESMTPSA id 2adb3069b0e04-551fc0d473bsm1950609e87.244.2025.05.23.06.41.08
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 23 May 2025 06:41:09 -0700 (PDT)
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
Subject: [PATCH v2 19/21] pmdomain: core: Leave powered-on genpds on until sync_state
Date: Fri, 23 May 2025 15:40:16 +0200
Message-ID: <20250523134025.75130-20-ulf.hansson@linaro.org>
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

Powering-off a genpd that was on during boot, before all of its consumer
devices have been probed, is certainly prone to problems.

For OF based platforms we can rely on using the sync_state mechanism that
the fw_devlink provides, to understand when all consumers for a genpd
provider have been probed. Let's therefore prevent these genpds from being
powered-off until the ->sync_state() callback gets called.

Note that, for non-OF based platform we will keep relying on the
late_initcall_sync, which seems to be the best we can do for now.

Suggested-by: Saravana Kannan <saravanak@google.com>
Signed-off-by: Ulf Hansson <ulf.hansson@linaro.org>
---
 drivers/pmdomain/core.c | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/drivers/pmdomain/core.c b/drivers/pmdomain/core.c
index 5d2ed4edffd7..6da25e2c81d2 100644
--- a/drivers/pmdomain/core.c
+++ b/drivers/pmdomain/core.c
@@ -1327,6 +1327,7 @@ static int genpd_runtime_resume(struct device *dev)
 	return ret;
 }
 
+#ifndef CONFIG_PM_GENERIC_DOMAINS_OF
 static bool pd_ignore_unused;
 static int __init pd_ignore_unused_setup(char *__unused)
 {
@@ -1362,6 +1363,7 @@ static int __init genpd_power_off_unused(void)
 	return 0;
 }
 late_initcall_sync(genpd_power_off_unused);
+#endif
 
 #ifdef CONFIG_PM_SLEEP
 
@@ -3471,6 +3473,7 @@ void of_genpd_sync_state(struct device_node *np)
 	list_for_each_entry(genpd, &gpd_list, gpd_list_node) {
 		if (genpd->provider == of_fwnode_handle(np)) {
 			genpd_lock(genpd);
+			genpd->stay_on = false;
 			genpd_power_off(genpd, false, 0);
 			genpd_unlock(genpd);
 		}
@@ -3502,6 +3505,7 @@ static void genpd_provider_sync_state(struct device *dev)
 
 	case GENPD_SYNC_STATE_SIMPLE:
 		genpd_lock(genpd);
+		genpd->stay_on = false;
 		genpd_power_off(genpd, false, 0);
 		genpd_unlock(genpd);
 		break;
-- 
2.43.0


