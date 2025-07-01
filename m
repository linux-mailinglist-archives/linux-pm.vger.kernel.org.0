Return-Path: <linux-pm+bounces-29902-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 16658AEF728
	for <lists+linux-pm@lfdr.de>; Tue,  1 Jul 2025 13:50:40 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 4AFD81C02490
	for <lists+linux-pm@lfdr.de>; Tue,  1 Jul 2025 11:50:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EDEFA275874;
	Tue,  1 Jul 2025 11:48:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="MUXkjb21"
X-Original-To: linux-pm@vger.kernel.org
Received: from mail-lf1-f50.google.com (mail-lf1-f50.google.com [209.85.167.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7A9312750F1
	for <linux-pm@vger.kernel.org>; Tue,  1 Jul 2025 11:48:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751370484; cv=none; b=oVvdiV/Hpxna2YSrX2BwcKuPkCC81fuvs/osfQKm1Yp7ZrdBJ3R2UEcY4whfk9V2MQOodsAhOWhKuV8/rqMZykGf983u87baOsUhqXCHof/GcPVUH0gK67540FMWG9jR7kUAIPg+Nv3mKwKKVIaMK/AeuTsJAhdkAPUq6KLGD5M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751370484; c=relaxed/simple;
	bh=zqunWuTIk0F22Bp+dZdTJTGInTtAtuZHfsLC6vmHBZI=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=FuBsMZspntnarPzB/4hRhzGkcT2gDsotIljtzLLCsV7t8xjm1i/7ffnuH/gbcM+orn1miAc1ib3NC6QeHQAg/YwubFdXyUgObXxjPxTThEQ551ShalNlO9Xoiw+t2Ehlvea1D/IcjBkPSn3Cq7vtv6bUWFlGg3JiNMMwN/CKA6A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=MUXkjb21; arc=none smtp.client-ip=209.85.167.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-lf1-f50.google.com with SMTP id 2adb3069b0e04-553dceb342fso5049642e87.0
        for <linux-pm@vger.kernel.org>; Tue, 01 Jul 2025 04:48:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1751370481; x=1751975281; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=EjmnP04SfQHk+b63Z9FzMRfEl1AAdadnOvsZgedn7VI=;
        b=MUXkjb21YoVm1oOrrz7vAXGREDbDg56Y+tqrIxoSjLj/7hFWcQxTytCEbDkcy1L7Iv
         MyrONgv7J+/dUuuIfLgnMGyN6PfAt8Xt8DND8i3FJZ1xjPPkMkRhmibyOxJ5L1qZr6Py
         TTx5pZ0DbrozPFNNEIoUIHhlDMQ//zCgSKLtZ54nPskETvvRadplJhAeObiDoR16z1eG
         6qFGfkU0O2zyAOwBFGazt62ZciHmSlsYYycGxgaFH5E1NSaxvCPLgkZFh4/h4vsMSeWY
         97z7Ybkms3Ulan594dXzX3+SFPWmL3OrX5/B66x+WFWsbGjQnGNj9B8ZXAXXKXqgUTVB
         gZGQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1751370481; x=1751975281;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=EjmnP04SfQHk+b63Z9FzMRfEl1AAdadnOvsZgedn7VI=;
        b=hjMQONuR7KfQYUDZdnSAEGPiK2d70fC7GcWNeXd4xDpAByFdcw0+E0kwHLyTl3dsJE
         v9JW/qMIVA1Eiz65K0L01wJVK9FdFy4ih++pM4YT125JFxglIOa7WIBpNd/mdaeksg1u
         kk1ev/yo8L10ipwTUDrK06l15rR/IQejV0SCiCiKXbZ5yvDmP83j5eW3IiatBB3PfNEC
         kpvjXdPeaDZlrveIL9Qvfw9E9EZH673fp9acO10dQFKfVlZrpQWyBif445FM4x/LN6Tt
         mM8PY38Rbjs2oyufreW+ktaut8uwU6cEif1qaOKb74XVjlggAhfIjVfw8ahruAEGODLx
         yLHg==
X-Forwarded-Encrypted: i=1; AJvYcCXld1Ku9M+NwwxdxjEgJRhyBePxL3lR+FIT+YvPjb/yLdk+Lwb/6Ku9oWUQ3mOwIS5EgsXUEkY+5Q==@vger.kernel.org
X-Gm-Message-State: AOJu0YxrGKI3p76KZVanaQuQdgFftKExwUzXGujF54JB0Z0S6yAE/qt9
	J7GnF3cevVsNHBQqeczKsWY+cibaSJMxgpCvw9uwOjxjeILWd2gE5GU6sSykitYT1nA=
X-Gm-Gg: ASbGncvHF+olFuKQPvFXnlYQ6vil7zX43qP1p9OFiXxtULTEx4SN75iSzBuvdjJXriq
	Or/RU6OC3YCzbEzIejOoFsMhxpdT3P8FPpK2ynHftp0kfpazfN2ckMLQWZG955eqTbapgrFOWfo
	Dt1lhIBoVVeQ1fKMxNDOqwb0/hcSnr/EcTlWmY7toRJDNGlRwByIebCHohTJo/+T+ozPGTQjTbk
	gf6RB3BAr5ZWR45bMwQcMtPgifDlKNm9OB4GHqwPGSynowaWowRzQ+FtICQlEBagrjdqmGN0soy
	34BecFREpgdxet8bubWRg/8PwHa1AO8mp+f+VqvVMt9Rh3W2QeGoZl4MAYBW6cRmitTIOcAGZii
	42+eV9V5Ybi+PTF3RJ2DnN80fL0lm3BuhGnJ06fxaVSM+47E=
X-Google-Smtp-Source: AGHT+IGgBYI5CrDlNYn12cn6Hu+izxnojI0IJ5BqsjI5oNKcH7trnNHO9mFo0wcOyH2jWbqlzkJ5TQ==
X-Received: by 2002:a05:6512:68e:b0:553:addb:ef5c with SMTP id 2adb3069b0e04-5550b9e4441mr5040371e87.54.1751370480552;
        Tue, 01 Jul 2025 04:48:00 -0700 (PDT)
Received: from uffe-tuxpro14.. (h-178-174-189-39.A498.priv.bahnhof.se. [178.174.189.39])
        by smtp.gmail.com with ESMTPSA id 2adb3069b0e04-5550b2f162dsm1800592e87.248.2025.07.01.04.47.59
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 01 Jul 2025 04:48:00 -0700 (PDT)
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
	Hiago De Franco <hiago.franco@toradex.com>,
	Geert Uytterhoeven <geert@linux-m68k.org>,
	Ulf Hansson <ulf.hansson@linaro.org>,
	linux-arm-kernel@lists.infradead.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH v3 12/24] pmdomain: qcom: rpmpd: Use of_genpd_sync_state()
Date: Tue,  1 Jul 2025 13:47:14 +0200
Message-ID: <20250701114733.636510-13-ulf.hansson@linaro.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20250701114733.636510-1-ulf.hansson@linaro.org>
References: <20250701114733.636510-1-ulf.hansson@linaro.org>
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

To make sure genpd tries to power off unused PM domains, let's call
of_genpd_sync_state() from our own ->sync_state() callback.

Cc: Bjorn Andersson <andersson@kernel.org>
Cc: Konrad Dybcio <konradybcio@kernel.org>
Tested-by: Hiago De Franco <hiago.franco@toradex.com> # Colibri iMX8X
Tested-by: Tomi Valkeinen <tomi.valkeinen@ideasonboard.com> # TI AM62A,Xilinx ZynqMP ZCU106
Signed-off-by: Ulf Hansson <ulf.hansson@linaro.org>
---

Changes in v3:
	- Fixup the prefix in the commit-message-header.

---
 drivers/pmdomain/qcom/rpmpd.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/drivers/pmdomain/qcom/rpmpd.c b/drivers/pmdomain/qcom/rpmpd.c
index 0be6b3026e3a..833c46944600 100644
--- a/drivers/pmdomain/qcom/rpmpd.c
+++ b/drivers/pmdomain/qcom/rpmpd.c
@@ -1144,6 +1144,8 @@ static void rpmpd_sync_state(struct device *dev)
 	unsigned int i;
 	int ret;
 
+	of_genpd_sync_state(dev->of_node);
+
 	mutex_lock(&rpmpd_lock);
 	for (i = 0; i < desc->num_pds; i++) {
 		pd = rpmpds[i];
-- 
2.43.0


