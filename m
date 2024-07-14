Return-Path: <linux-pm+bounces-11075-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 31F8A9309C8
	for <lists+linux-pm@lfdr.de>; Sun, 14 Jul 2024 13:43:29 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id DBC52281A99
	for <lists+linux-pm@lfdr.de>; Sun, 14 Jul 2024 11:43:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 00A697344F;
	Sun, 14 Jul 2024 11:43:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="S68MqULs"
X-Original-To: linux-pm@vger.kernel.org
Received: from mail-lf1-f41.google.com (mail-lf1-f41.google.com [209.85.167.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2D06B49635;
	Sun, 14 Jul 2024 11:43:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720957397; cv=none; b=k37xBD8Uw/77pL7gKZN86oNkSEiC78kJMSt+YRKigD16Tj59Gao7IIuX7crTHDcmOeFDm871qEUJ6apLkmaOgu92YR6vCZfk+NPUMZxIaPSwrVKGLcNQRotHkR01lNt4tzPHXtNi8YsD02W9q2YjpFaP3mY7nTaIzEF+hYPARCU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720957397; c=relaxed/simple;
	bh=vF378iF9/szJSAJWna+ftEYzp+8iuC0Xg1MQKdgKe6k=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=MMtkskv4xcVgkeuI/bQMN4ozOdpn2p2T6l/G7LExSJO6sfQRn3VTxiYrkwivPNVIv6+lxDgYLecEbL5wj6qTjTPtBemDBj8qaRVvnZ+XxNNmU4gdrZnWmyR6hn2njd5FhH6Cug5ksNHx7ph1HaduPxZmX2/U830uhyUuGl+STIk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=S68MqULs; arc=none smtp.client-ip=209.85.167.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-lf1-f41.google.com with SMTP id 2adb3069b0e04-52ea79e6979so3823138e87.2;
        Sun, 14 Jul 2024 04:43:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1720957394; x=1721562194; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=wOp5UqGNK/+aHc+mtLWt/FVtlNV3iPD/WbMrczGg2CE=;
        b=S68MqULsZzjFaHX22+LtECvyX1QlYLh/lxiZoqeaOvJUfKrRu2Wn3XvUFKqR7bGX1V
         SSIAn4sSwPFrPh4HqGRr6J44+N4+1yJOiXuuvupW0hJtrWTeGNIpCdqVSJgckFVJyIx7
         PMLRVCNqaMpynE9txoJbOmOMGPRvtcEBHdgvXheeGbKg2HVSSz7U9zmBUkKQO24UTvga
         oa0DisQrP6eQQqTZMDEW7g2hSnmd5tqySUsXHxp7Rkg2Yk290X24R/OsL3RIm0ia4M7O
         W5i/zpL04v0LwjqydNERHIo2U1MoVOMsToNBFOEen3q9LyXSdkrAfZBWN08tlCYouf2g
         eMbg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1720957394; x=1721562194;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=wOp5UqGNK/+aHc+mtLWt/FVtlNV3iPD/WbMrczGg2CE=;
        b=CHn1NdmP2XuZ80s6CWKTsQY4P2i6Ynrz7D0ALU+abwkuiF/snf8WZAwfWp4+7OX6u9
         OaBaOLbVQ2cXv79Bbeq1AVbc1Xxb+fWzG/WNNM7T0Wi9Ox89IhdSVz/N0UOzxt8zkba2
         pw72zLPnB4eNC6lDiXqptfC2FA+2t8h4zIupH81DKXnGTwwh034LFtSADONFyjvPiLLe
         D32iYF+xU8PXxRD7duC1TxNXHYxXfC3qwQ8cZcreLs925Ep/NK6rx1CYb39s/etUS94R
         6P31KeR+DJIWMI7jVpLgWhCQxsuFG8RSQwGcbbly4HkBpYlhBTbbfnHJGw6KXyisXjzZ
         9QcQ==
X-Forwarded-Encrypted: i=1; AJvYcCW2Yd7mMrpmUsjPoW7mLSRmA0QN3cAQIkOEUNj2Tmph7bb89JZMkh8f2njQHRGgk6GCrLwuSPNh5xR32g1/eNUo6Mma+Dvf+R8TLIoowrYHOhkmMHsXDtcNLPL0vS/J1rn/8A8OCmblKA==
X-Gm-Message-State: AOJu0YxuxgZrfBJ+zt0kAyCqcw7IvGvQNieDBMbrFbfN42JEumbzsbrW
	VVycOkkdKTXrJCIrLgr7q8f5v6TBnR3ejriBezNF+mwc2FVLCUvKntdGTQ==
X-Google-Smtp-Source: AGHT+IGzQSl96QOLEDaGbFjBPAymg5u1VSljhpz6IWeZ7P97LOYVU2MHyNNINrbBaBgAgukwbohIfw==
X-Received: by 2002:a05:6512:39ce:b0:52e:96d7:2f3a with SMTP id 2adb3069b0e04-52eb99da148mr12221457e87.58.1720957393616;
        Sun, 14 Jul 2024 04:43:13 -0700 (PDT)
Received: from localhost ([2001:861:3385:e20:6384:4cf:52c5:3194])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-3680dab3f2esm3650922f8f.18.2024.07.14.04.43.13
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 14 Jul 2024 04:43:13 -0700 (PDT)
From: Raphael Gallais-Pou <rgallaispou@gmail.com>
Date: Sun, 14 Jul 2024 13:42:45 +0200
Subject: [PATCH v3 1/2] thermal: st: switch from CONFIG_PM_SLEEP guards to
 pm_sleep_ptr()
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20240714-thermal-v3-1-88f2489ef7d5@gmail.com>
References: <20240714-thermal-v3-0-88f2489ef7d5@gmail.com>
In-Reply-To: <20240714-thermal-v3-0-88f2489ef7d5@gmail.com>
To: "Rafael J. Wysocki" <rafael@kernel.org>, 
 Daniel Lezcano <daniel.lezcano@linaro.org>, Zhang Rui <rui.zhang@intel.com>, 
 Lukasz Luba <lukasz.luba@arm.com>, 
 Maxime Coquelin <mcoquelin.stm32@gmail.com>, 
 Alexandre Torgue <alexandre.torgue@foss.st.com>, 
 Patrice Chotard <patrice.chotard@foss.st.com>, 
 Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>, 
 Conor Dooley <conor+dt@kernel.org>
Cc: linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org, 
 linux-stm32@st-md-mailman.stormreply.com, 
 linux-arm-kernel@lists.infradead.org, devicetree@vger.kernel.org
X-Mailer: b4 0.14.0

Letting the compiler remove these functions when the kernel is built
without CONFIG_PM_SLEEP support is simpler and less error prone than the
use of #ifdef based kernel configuration guards.

Remove those guards on every ST thermal related drivers.

Reviewed-by: Patrice Chotard <patrice.chotard@foss.st.com>
Signed-off-by: Raphael Gallais-Pou <rgallaispou@gmail.com>
---
 drivers/thermal/st/st_thermal.c        | 4 +---
 drivers/thermal/st/st_thermal_memmap.c | 2 +-
 drivers/thermal/st/stm_thermal.c       | 8 +++-----
 3 files changed, 5 insertions(+), 9 deletions(-)

diff --git a/drivers/thermal/st/st_thermal.c b/drivers/thermal/st/st_thermal.c
index 2a105409864e..5f33543a3a54 100644
--- a/drivers/thermal/st/st_thermal.c
+++ b/drivers/thermal/st/st_thermal.c
@@ -236,7 +236,6 @@ void st_thermal_unregister(struct platform_device *pdev)
 }
 EXPORT_SYMBOL_GPL(st_thermal_unregister);
 
-#ifdef CONFIG_PM_SLEEP
 static int st_thermal_suspend(struct device *dev)
 {
 	struct st_thermal_sensor *sensor = dev_get_drvdata(dev);
@@ -265,9 +264,8 @@ static int st_thermal_resume(struct device *dev)
 
 	return 0;
 }
-#endif
 
-SIMPLE_DEV_PM_OPS(st_thermal_pm_ops, st_thermal_suspend, st_thermal_resume);
+DEFINE_SIMPLE_DEV_PM_OPS(st_thermal_pm_ops, st_thermal_suspend, st_thermal_resume);
 EXPORT_SYMBOL_GPL(st_thermal_pm_ops);
 
 MODULE_AUTHOR("STMicroelectronics (R&D) Limited <ajitpal.singh@st.com>");
diff --git a/drivers/thermal/st/st_thermal_memmap.c b/drivers/thermal/st/st_thermal_memmap.c
index 29c2269b0fb3..28b380013956 100644
--- a/drivers/thermal/st/st_thermal_memmap.c
+++ b/drivers/thermal/st/st_thermal_memmap.c
@@ -180,7 +180,7 @@ static void st_mmap_remove(struct platform_device *pdev)
 static struct platform_driver st_mmap_thermal_driver = {
 	.driver = {
 		.name	= "st_thermal_mmap",
-		.pm     = &st_thermal_pm_ops,
+		.pm     = pm_sleep_ptr(&st_thermal_pm_ops),
 		.of_match_table = st_mmap_thermal_of_match,
 	},
 	.probe		= st_mmap_probe,
diff --git a/drivers/thermal/st/stm_thermal.c b/drivers/thermal/st/stm_thermal.c
index 34785b9276fc..ffd988600ed6 100644
--- a/drivers/thermal/st/stm_thermal.c
+++ b/drivers/thermal/st/stm_thermal.c
@@ -440,7 +440,6 @@ static int stm_thermal_prepare(struct stm_thermal_sensor *sensor)
 	return ret;
 }
 
-#ifdef CONFIG_PM_SLEEP
 static int stm_thermal_suspend(struct device *dev)
 {
 	struct stm_thermal_sensor *sensor = dev_get_drvdata(dev);
@@ -466,10 +465,9 @@ static int stm_thermal_resume(struct device *dev)
 
 	return 0;
 }
-#endif /* CONFIG_PM_SLEEP */
 
-static SIMPLE_DEV_PM_OPS(stm_thermal_pm_ops,
-			 stm_thermal_suspend, stm_thermal_resume);
+static DEFINE_SIMPLE_DEV_PM_OPS(stm_thermal_pm_ops,
+				stm_thermal_suspend, stm_thermal_resume);
 
 static const struct thermal_zone_device_ops stm_tz_ops = {
 	.get_temp	= stm_thermal_get_temp,
@@ -580,7 +578,7 @@ static void stm_thermal_remove(struct platform_device *pdev)
 static struct platform_driver stm_thermal_driver = {
 	.driver = {
 		.name	= "stm_thermal",
-		.pm     = &stm_thermal_pm_ops,
+		.pm     = pm_sleep_ptr(&stm_thermal_pm_ops),
 		.of_match_table = stm_thermal_of_match,
 	},
 	.probe		= stm_thermal_probe,

-- 
2.45.2


