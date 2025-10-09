Return-Path: <linux-pm+bounces-35856-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 58CDDBC9C99
	for <lists+linux-pm@lfdr.de>; Thu, 09 Oct 2025 17:27:47 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id B0E503E0769
	for <lists+linux-pm@lfdr.de>; Thu,  9 Oct 2025 15:26:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D2CA32ED842;
	Thu,  9 Oct 2025 15:25:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="JzbCeriX"
X-Original-To: linux-pm@vger.kernel.org
Received: from mail-ed1-f54.google.com (mail-ed1-f54.google.com [209.85.208.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D6EF5212550
	for <linux-pm@vger.kernel.org>; Thu,  9 Oct 2025 15:25:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760023517; cv=none; b=P6al3UrPWBdTkvLvYx/g1buH7Imv+UC3GkkZNgRbGoy1Rj1+kPBn5AYQ3JBmYov7hmruXHdp99TqZz+M1RDL74v0okxnvISZ9/hzFOXw2hpSyjibGcfJ2kqc4rP3b5ogN5Yd2yGCHulBYqtbRrqaewsSoRIhCmbQ3hvb1s/TCMM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760023517; c=relaxed/simple;
	bh=0A/EkduQWdAahGq43hrLsndr/J8Gpiy72o41hnq8yS4=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=WFQ4RJe/Yxo9a0fzVwMVXyOYBMHEspB67kMFxx10t5DqPSlsmDouArABXSgDlYniX5VVCaQAxsiFbVPXPZwEGyljwEH6M0C2jDVxvky5OcMJG8ze84SDeohgZ7ieBuINCYTBhjE1WEZuWeaeuXF9mQwSHRTMcG0NlvVQkvtsT/w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=JzbCeriX; arc=none smtp.client-ip=209.85.208.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-ed1-f54.google.com with SMTP id 4fb4d7f45d1cf-6349e3578adso2109179a12.1
        for <linux-pm@vger.kernel.org>; Thu, 09 Oct 2025 08:25:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1760023510; x=1760628310; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=L/1/8oovwXsAv5LJCHXYAg1gF9tOSXyOhotyAm6lDms=;
        b=JzbCeriXQ4WU+Wnl7MRj/pT+e0xUruwBfEUSpI+DHtDCL2rd2rPA+U1o0RrRr2eb/i
         z9049y81jS0y1oel34WkbNnUwLdDiZziRHcQUgWwrW48YpxKxvY9kdNEJUnoKt3w8aYI
         HRzlNyjKg/cemMMBj/BNcqbFXuVYaB4LsibCrQcgLOdMLsRU2Hw09QSE8xNBjWuY5RfW
         r27Ggv/1tVCVgFrTIGtTfCJ40cX3afgR2KyWrGe+OKFjCCbFqrBRRjA1BLuzPvuVxOHO
         IPoXRjIug5gird4HqlEBoU8Oc1JhTJdeGm7jemWB48YfhTOIIKRzaSG3L7m03KMb/7do
         ll7Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1760023510; x=1760628310;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=L/1/8oovwXsAv5LJCHXYAg1gF9tOSXyOhotyAm6lDms=;
        b=C/+45l7MYIYNV0b7NuLbBJRhixe4O0F6HMRKqhKBCEO3LS7IL0z1O7M+eMpqMnM1Xj
         1G5VbSYBpv8IkxslRYbGkaqLS/BZu5j3uOuzby2+AwLDNYFZs8RcK3D1dfmRp7EXmJVw
         CZeejmi4pdWn56k9euVYKLNYvH1A8HfiDsXh4Bn+xUDq5mZx63EMxb4aa8/1NgEUhvKp
         GQBlA1yOpXq1vr2wPq4CnyG0bIWM2SwBdfTjIOz//h2d/ZIMpKd9RwZUFr/MEomLB7Iv
         cfVKapwDCSY/ziYkzSG7JAISeWAu4hHnmO5a0u+9k9H/PWuVPBFMapYZsyispoXNvEQU
         Eruw==
X-Forwarded-Encrypted: i=1; AJvYcCUXliwxnhh1RkUJFmBfr6ZFNK1zwR/qX5C9Hdzop1vF2HrxFmi/dulLLgE7FM3/4NI8sofYAmVotw==@vger.kernel.org
X-Gm-Message-State: AOJu0YzZI3DLxtdCSsWysiIvXdLp2YIV2eNZG0Gvvlni8kIFLBKP1s2q
	zwwDMGG0MskcNI1EkqAEv74BRogqyBgxXi/QiVQZEqcer7DKwI5yL110twSWWICe+D8=
X-Gm-Gg: ASbGncvc0uWO2PchFCwibBmei9vqfEbbk0MfYdHHOH1uPxMiAqL8FhBD73g/p6BTkEv
	9RrNpey2lZ4pykBRK/MtirtztmAzGnM15/nZSclCKtIHFQm0fVqauSMNZdzx3eezrvvjklnJ07G
	gTZh6QxLIQhus+HXIj+VIanQzC/Z323I7Yl63YKyG+cfQBhQ79869C1ogDzRL5cUHZOp+8JyPyr
	CSmDDIdF2npveAdr70o7lpxINDLS7jFM6WS5Xbzcdk99EZMQJ7n80tJeQS7fp9Au/TltuA9qnQ0
	EONMcbRlyDxgmVgG48GdJfMA0ZzG/3iGmGxB201+0t/yuShbTRquL3W5traDyvEiv5NyZaHM65V
	CiCKOOTkh/iyoT1n+FoxtMEDXuQKLJ2fQ2GWpVbTrTXIjR44DdYUvTj5RfXoN5eSMYFXArdH7iF
	K/XfAYEr4l5hJ77bRy278ZY1EqIsnm/H8aD9A4h7gr
X-Google-Smtp-Source: AGHT+IGaGkcuokARZTfmmbCwfalPWL2pX6NDBn0pheQXnCrw092W78kTYfWHrm/WqInuH6GM9reI/w==
X-Received: by 2002:a17:906:c149:b0:b41:2209:d35d with SMTP id a640c23a62f3a-b50a9d701b3mr803859766b.1.1760023509699;
        Thu, 09 Oct 2025 08:25:09 -0700 (PDT)
Received: from puffmais2.c.googlers.com (224.138.204.35.bc.googleusercontent.com. [35.204.138.224])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-b486970b36fsm1908967566b.62.2025.10.09.08.25.09
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 09 Oct 2025 08:25:09 -0700 (PDT)
From: =?utf-8?q?Andr=C3=A9_Draszik?= <andre.draszik@linaro.org>
Date: Thu, 09 Oct 2025 16:25:10 +0100
Subject: [PATCH v2 08/10] pmdomain: samsung: selectively handle enforced
 sync_state
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Message-Id: <20251009-gs101-pd-v2-8-3f4a6db2af39@linaro.org>
References: <20251009-gs101-pd-v2-0-3f4a6db2af39@linaro.org>
In-Reply-To: <20251009-gs101-pd-v2-0-3f4a6db2af39@linaro.org>
To: Krzysztof Kozlowski <krzk@kernel.org>, 
 Alim Akhtar <alim.akhtar@samsung.com>, Rob Herring <robh@kernel.org>, 
 Conor Dooley <conor+dt@kernel.org>, 
 Krzysztof Kozlowski <krzk+dt@kernel.org>, 
 Ulf Hansson <ulf.hansson@linaro.org>, 
 Marek Szyprowski <m.szyprowski@samsung.com>
Cc: Peter Griffin <peter.griffin@linaro.org>, 
 Tudor Ambarus <tudor.ambarus@linaro.org>, 
 Will McVicker <willmcvicker@google.com>, kernel-team@android.com, 
 linux-arm-kernel@lists.infradead.org, linux-samsung-soc@vger.kernel.org, 
 devicetree@vger.kernel.org, linux-kernel@vger.kernel.org, 
 linux-pm@vger.kernel.org, 
 =?utf-8?q?Andr=C3=A9_Draszik?= <andre.draszik@linaro.org>
X-Mailer: b4 0.14.2

Unconditionally calling of_genpd_sync_state() causes issues on
platforms with child domains as the parent domain will be turned off
before the child domain was even registered during boot.

This in particular is an issue for the upcoming Google gs101 support -
all operations on child domains registered after the parent domain
misbehave.

Add a flag to the probe data to be able to sync_state conditionally
only, and enable that flag on the two platforms currently supported by
this driver.

Signed-off-by: André Draszik <andre.draszik@linaro.org>

---
v2:
* use bool for need_early_sync_state (Krzysztof)
---
 drivers/pmdomain/samsung/exynos-pm-domains.c | 5 ++++-
 1 file changed, 4 insertions(+), 1 deletion(-)

diff --git a/drivers/pmdomain/samsung/exynos-pm-domains.c b/drivers/pmdomain/samsung/exynos-pm-domains.c
index 638d286b57f716140b2401092415644a6805870e..15a1582aa92103a07335eb681600d9415369fefd 100644
--- a/drivers/pmdomain/samsung/exynos-pm-domains.c
+++ b/drivers/pmdomain/samsung/exynos-pm-domains.c
@@ -20,6 +20,7 @@
 struct exynos_pm_domain_config {
 	/* Value for LOCAL_PWR_CFG and STATUS fields for each domain */
 	u32 local_pwr_cfg;
+	bool need_early_sync_state;
 };
 
 /*
@@ -69,10 +70,12 @@ static int exynos_pd_power_off(struct generic_pm_domain *domain)
 
 static const struct exynos_pm_domain_config exynos4210_cfg = {
 	.local_pwr_cfg		= 0x7,
+	.need_early_sync_state	= true,
 };
 
 static const struct exynos_pm_domain_config exynos5433_cfg = {
 	.local_pwr_cfg		= 0xf,
+	.need_early_sync_state	= true,
 };
 
 static const struct of_device_id exynos_pm_domain_of_match[] = {
@@ -179,7 +182,7 @@ static int exynos_pd_probe(struct platform_device *pdev)
 	 * reset during boot. As a temporary hack to manage this, let's enforce
 	 * a sync_state.
 	 */
-	if (!ret)
+	if (pm_domain_cfg->need_early_sync_state && !ret)
 		of_genpd_sync_state(np);
 
 	pm_runtime_enable(dev);

-- 
2.51.0.710.ga91ca5db03-goog


