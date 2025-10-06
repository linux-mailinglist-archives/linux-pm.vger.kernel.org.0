Return-Path: <linux-pm+bounces-35748-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id E8A81BBEB59
	for <lists+linux-pm@lfdr.de>; Mon, 06 Oct 2025 18:44:21 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id A480E18956F3
	for <lists+linux-pm@lfdr.de>; Mon,  6 Oct 2025 16:44:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 774B12DF710;
	Mon,  6 Oct 2025 16:43:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="bDDj6WTE"
X-Original-To: linux-pm@vger.kernel.org
Received: from mail-ej1-f53.google.com (mail-ej1-f53.google.com [209.85.218.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D20B92DEA8C
	for <linux-pm@vger.kernel.org>; Mon,  6 Oct 2025 16:43:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759769017; cv=none; b=tKVH3uQkprPQxTKGytVotAsJP57iVt3SMEOkbxX3pT++0WtuSszKV4fWd21PDnD7bxyuam6AxLkmHLFFeSBhvCDihPlfJ0w8loCDBt4UTZHh0cluOXlqNUdCZW8YudBoxhXvxhCsAVqBO8B8TmSw9Xz/R+4fH+8vcTjIoZVHQTA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759769017; c=relaxed/simple;
	bh=lQFRfvIZm2QIrTnGZIlapJJgk3a/yMVJrj+Qv49vZDg=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=RY6vbVEpcM001OkqJtdtM0xBSONzgyI0N6b7OUxmakWZ6MlcKdVl5neQ3QgZw63rGpo7sqOaMrdksPrrMZAIGG6vFJ2nHtZHeDUa48LlRmMRUDhI7j5uIlqhp7hlRorJp4mbZ6zh+MJX6R6JYyKSSOWzVtaAAA45dfu1akghCLU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=bDDj6WTE; arc=none smtp.client-ip=209.85.218.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-ej1-f53.google.com with SMTP id a640c23a62f3a-b3e9d633b78so707878966b.1
        for <linux-pm@vger.kernel.org>; Mon, 06 Oct 2025 09:43:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1759769012; x=1760373812; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=I0ZdGtbeD0twmfxFXcR2wb4AL4tjk6OMYa00kx/YCo4=;
        b=bDDj6WTEUFAoTklqJxVyDFsSrH4c+YN3JvKDUER3xlvL5UmJaTyfGwZX8NDgkpsiWx
         4327LWkeZOszgVNWFiriEPxcmMp/vPygim+aDK/yxc+IJjy/2B5T068WC6CtcGZWk6Nh
         Wou9zwNO5IFbdkTMzJN47xuKCwM+RXub76teAKKn+SJrvtUud7TRqiJhcFgJaEkvSqQ7
         zKLiVl0jRoNTUuLU7N8MHhrEE0Og6VEDAVAmNY7GifQiFCVVZCMjz4VvCbxqNGwKtj/i
         l2RWah3LIWmC27du6gLgY5I1ttGf0SU1QUtNZg9OTxNllQyehnDER81MWs5kV4Ao5gwU
         T5rQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1759769012; x=1760373812;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=I0ZdGtbeD0twmfxFXcR2wb4AL4tjk6OMYa00kx/YCo4=;
        b=uTQSQztHV9IcJuH3H0MAvj+gLUQAYo3g42tGRDQOLHQaiAFYWvUGkPxcmeVyU2WI0z
         31bdDKRcODFLi6PVYqDq/+53qkCehDa1e/PLjDLJJRQUo5OEFbJzNzMYCjdfhbOr4adQ
         9dSoBuv6ftry1jt2sEYxnHuIiTYatW1DwOpWugeI1GRYSI6C/Xe+tkaOqu9ED7mTbyLA
         Cgcy3we4Ra3gx+wkPm/U7LuefM/MwumZ1Tz6yz1vjwFzGv9YGnUKI4vRf9T4HNdS9fJi
         dGogSfvMsxiQeF14OBNVsnvpEoco0VrPxIqvxITTKEiUud4NBp/JYHFL/wX9XQIGoF2r
         t01g==
X-Forwarded-Encrypted: i=1; AJvYcCWo2/CqVfcjzPpDD3qaYruV2Heb60dC/Uz9+HaPJpvHjITGk68Aj1jZcCg46jthLBycvzT3KPnE8g==@vger.kernel.org
X-Gm-Message-State: AOJu0YzpkRhFE0vE9RgI8PASoiwlQIrl+SS0f4wOYxxSrsBHw3VFYg/h
	FKYRsuBNd0Ea1Of5ovD/NOi13sZOw31HU7tr/g7rrgNE2m1FHom3MP6lDZHfWvmDHc4=
X-Gm-Gg: ASbGncuBR9VzqiHDB9dYwvsH8sClMBNVW8mju6kIIZ+zb5POFtxyWDRFxDZ8RedQYAM
	fBS3s6yY6TuzSfqmWGZ6UrB54ZslddZr7cWtL79Ez5GojwY8PLwzRZHVTBERrvwoEh0UeN+7D5v
	OupkpTLjKaa4PqKVlcu2almYDK+mIoFJuPCmeJBJRwZ+ZAcBa/dbguriJCHl2zqFpF3FArBHWnM
	Pzsda0kryIUW9sDmwzlCFtYp+I35qjakkDXnXvrlAebT/RsEtv3DCpkLHpPlc3qzmgmPhHe4Qmu
	YLuGSQboPIFGeAXIZBMY5Wo/W8nlTtADglisB5lxQ9WW/a9w9j/DbMrWzx3/72MZ2KMsDH4mvO8
	GOiOSTg8VL69A73dwRi5lMZP6z0vb200UImOBZ8yfEphyNUSBc9Bs+KkGRzSl6acAUhdh1d2xgl
	yB91O7wTr+4slAonEPiRN4stpcIwAYXfPkVkbeeUEe9nOaSb/bxd0=
X-Google-Smtp-Source: AGHT+IEYfOZF1TQm9DGlW5kpM0S9/tKDSRvPCFa/7dsa/gaWYvJTuZDOfU68MoruhNwe6zCqc77lsg==
X-Received: by 2002:a17:907:a710:b0:b27:edf1:f638 with SMTP id a640c23a62f3a-b4f43106a07mr28397966b.23.1759769011758;
        Mon, 06 Oct 2025 09:43:31 -0700 (PDT)
Received: from puffmais2.c.googlers.com (224.138.204.35.bc.googleusercontent.com. [35.204.138.224])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-b48652aa01esm1193841866b.2.2025.10.06.09.43.31
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 06 Oct 2025 09:43:31 -0700 (PDT)
From: =?utf-8?q?Andr=C3=A9_Draszik?= <andre.draszik@linaro.org>
Date: Mon, 06 Oct 2025 17:43:33 +0100
Subject: [PATCH 07/10] pmdomain: samsung: selectively handle enforced
 sync_state
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Message-Id: <20251006-gs101-pd-v1-7-f0cb0c01ea7b@linaro.org>
References: <20251006-gs101-pd-v1-0-f0cb0c01ea7b@linaro.org>
In-Reply-To: <20251006-gs101-pd-v1-0-f0cb0c01ea7b@linaro.org>
To: Krzysztof Kozlowski <krzk@kernel.org>, 
 Alim Akhtar <alim.akhtar@samsung.com>, Rob Herring <robh@kernel.org>, 
 Conor Dooley <conor+dt@kernel.org>, 
 Krzysztof Kozlowski <krzk+dt@kernel.org>, 
 Ulf Hansson <ulf.hansson@linaro.org>
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
 drivers/pmdomain/samsung/exynos-pm-domains.c | 5 ++++-
 1 file changed, 4 insertions(+), 1 deletion(-)

diff --git a/drivers/pmdomain/samsung/exynos-pm-domains.c b/drivers/pmdomain/samsung/exynos-pm-domains.c
index 638d286b57f716140b2401092415644a6805870e..5a87802cff394945cb0202d08f2cf6bcbbcc774d 100644
--- a/drivers/pmdomain/samsung/exynos-pm-domains.c
+++ b/drivers/pmdomain/samsung/exynos-pm-domains.c
@@ -20,6 +20,7 @@
 struct exynos_pm_domain_config {
 	/* Value for LOCAL_PWR_CFG and STATUS fields for each domain */
 	u32 local_pwr_cfg;
+	unsigned int need_early_sync_state:1;
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
2.51.0.618.g983fd99d29-goog


