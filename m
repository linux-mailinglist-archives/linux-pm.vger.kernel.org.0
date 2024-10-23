Return-Path: <linux-pm+bounces-16318-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id B90AE9AD443
	for <lists+linux-pm@lfdr.de>; Wed, 23 Oct 2024 20:50:44 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 703FE1F22641
	for <lists+linux-pm@lfdr.de>; Wed, 23 Oct 2024 18:50:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5C24B1D2B11;
	Wed, 23 Oct 2024 18:50:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="C1NZDiPx"
X-Original-To: linux-pm@vger.kernel.org
Received: from mail-oo1-f44.google.com (mail-oo1-f44.google.com [209.85.161.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C6E111D151F
	for <linux-pm@vger.kernel.org>; Wed, 23 Oct 2024 18:50:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.161.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729709428; cv=none; b=alYhHLCYT/mamtnHnqm48SI6bQK/hSp762WNOq8ThSt3EYygAEmRIw+S8RcaX2timgSrmMRnMeu3JC1C42McKu/z1CHWJiCKLyeDAVC4Q5cAY0HAcv/3OIpN54qn1BuYRFBEfR5lyDH6RXFu7qDV3jFpbT38MKcsX+JaI01fnX0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729709428; c=relaxed/simple;
	bh=7DS0X8qhKfEVkLOZopAxlKaoXqfTFKueIGVKh5O9W8s=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Kt9sba6T4wR8x8YzdzvqIfIKl1UJ/ExGQ94HjGEaI46zupJJOr+19MFDJhWgVHeKrxUE3TtrDXV8r7FpA9xPa+vh6Z4MhomLIJqMA1BNXlFfgbPPffCiShThxwnJthz3zUAsxHOGwbeoOdXwEcabGSd0xwV42CJrzRDK3IsiPYw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=C1NZDiPx; arc=none smtp.client-ip=209.85.161.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-oo1-f44.google.com with SMTP id 006d021491bc7-5eba450531eso592069eaf.1
        for <linux-pm@vger.kernel.org>; Wed, 23 Oct 2024 11:50:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1729709426; x=1730314226; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=FXKoPeDo82nTMxnt2Psg/dVsFWr0w1bBH/4wN9F5E34=;
        b=C1NZDiPxzn9omo9SuqKax8rRz9Nvj0v4Lb7LAn97KOFHHQuMN6RYAx9PYIobmpni6I
         s5fi7RmSCBhwMnDkAvXZAmYBGrwSjUn8GtgXXlYVMWUFyybbOaL0z6wcQuT2RdGBd1nP
         vDBozarGvnt0pAUZwYWyYuwpucJYI77/vBmYC207u8F+jx1G1fNy3k8rMGx/pv+et6N+
         8wtOUvDHbJNooXGgd05ZWTe3jbQ5eNalUThcM9h9Zgqq/TgzURngc1+f1Clw95jxEajv
         9R1KtvSgl1rjsfEjYIEVLbhp6Gc7HZD6hcOxWyn8FviEiUfnDYobfqhZYbTqlsNlJ2x/
         TCnA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1729709426; x=1730314226;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=FXKoPeDo82nTMxnt2Psg/dVsFWr0w1bBH/4wN9F5E34=;
        b=LQSUzW+9dfVqpNahhJOa7tstUfqqo1Z0D3bstCGF2iKC8dcUzruC96pkZy4PDAfjSO
         VGEMi5iY7Fae1UNTyHwO/5afvvivHjMY1VdZcFkhaD7/1nDplk6WpnoedvmXNTeUVwwD
         GuSuGY95FUbkzvULHQYzIc6zTs7RdZWUdGKkCjv1rabzCnO0yghvoYEqEnzYHrv8s/Nq
         NzSDtsYLemlGDn8faBM0RnkEjKPFkdCfxYpimpMi5tzeEXj1tlyJppXwaH7Vm4K0m7AC
         RbZUMYELghAgaH5By4Z6kc7mV2mvMRmOWJRhbA9yK8603I7AKzFpD6Rmuw2m+oND2HiA
         KvWg==
X-Gm-Message-State: AOJu0YyLcaIDXxPJQLM4f6RlKCvplRzif3QWFoGshHh4/Sogz7eGPZcM
	s1ViB9+dBO4yStLlQmpPEKYtJGdcSQnMA6iMo/u1GS5A9dM75Bdx6/E2Aw==
X-Google-Smtp-Source: AGHT+IGsqYR4ANWg0g/9koDTocvLpJ4TpBEQuXdoucjL2xRopJh1jCyrklVN4cgX/bb4tyXdInXFRA==
X-Received: by 2002:a05:6870:1704:b0:27c:4853:2b68 with SMTP id 586e51a60fabf-28ccc20b380mr1992640fac.20.1729709425555;
        Wed, 23 Oct 2024 11:50:25 -0700 (PDT)
Received: from localhost.localdomain ([2600:1700:fb0:1bcf::54])
        by smtp.gmail.com with ESMTPSA id 46e09a7af769-7182eb52609sm1860667a34.40.2024.10.23.11.50.25
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 23 Oct 2024 11:50:25 -0700 (PDT)
From: Chris Morgan <macroalpha82@gmail.com>
To: linux-pm@vger.kernel.org
Cc: wens@csie.org,
	sre@kernel.org,
	Chris Morgan <macromorgan@hotmail.com>
Subject: [PATCH 1/2] power: supply: axp20x_usb_power: Use scaled iio_read_channel
Date: Wed, 23 Oct 2024 13:47:59 -0500
Message-ID: <20241023184800.109376-2-macroalpha82@gmail.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20241023184800.109376-1-macroalpha82@gmail.com>
References: <20241023184800.109376-1-macroalpha82@gmail.com>
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Chris Morgan <macromorgan@hotmail.com>

Change iio_read_channel_processed to iio_read_channel_processed_scale
where appropriate.

Signed-off-by: Chris Morgan <macromorgan@hotmail.com>
---
 drivers/power/supply/axp20x_usb_power.c | 33 +++++++++++--------------
 1 file changed, 15 insertions(+), 18 deletions(-)

diff --git a/drivers/power/supply/axp20x_usb_power.c b/drivers/power/supply/axp20x_usb_power.c
index 2766352ab737..9722912268fe 100644
--- a/drivers/power/supply/axp20x_usb_power.c
+++ b/drivers/power/supply/axp20x_usb_power.c
@@ -220,16 +220,15 @@ static int axp20x_usb_power_get_property(struct power_supply *psy,
 		return 0;
 	case POWER_SUPPLY_PROP_VOLTAGE_NOW:
 		if (IS_ENABLED(CONFIG_AXP20X_ADC)) {
-			ret = iio_read_channel_processed(power->vbus_v,
-							 &val->intval);
-			if (ret)
-				return ret;
-
 			/*
 			 * IIO framework gives mV but Power Supply framework
 			 * gives uV.
 			 */
-			val->intval *= 1000;
+			ret = iio_read_channel_processed_scale(power->vbus_v,
+							       &val->intval, 1000);
+			if (ret)
+				return ret;
+
 			return 0;
 		}
 
@@ -253,16 +252,15 @@ static int axp20x_usb_power_get_property(struct power_supply *psy,
 		return 0;
 	case POWER_SUPPLY_PROP_CURRENT_NOW:
 		if (IS_ENABLED(CONFIG_AXP20X_ADC)) {
-			ret = iio_read_channel_processed(power->vbus_i,
-							 &val->intval);
-			if (ret)
-				return ret;
-
 			/*
 			 * IIO framework gives mA but Power Supply framework
 			 * gives uA.
 			 */
-			val->intval *= 1000;
+			ret = iio_read_channel_processed_scale(power->vbus_i,
+							       &val->intval, 1000);
+			if (ret)
+				return ret;
+
 			return 0;
 		}
 
@@ -374,16 +372,15 @@ static int axp717_usb_power_get_property(struct power_supply *psy,
 		break;
 	case POWER_SUPPLY_PROP_VOLTAGE_NOW:
 		if (IS_ENABLED(CONFIG_AXP20X_ADC)) {
-			ret = iio_read_channel_processed(power->vbus_v,
-							 &val->intval);
-			if (ret)
-				return ret;
-
 			/*
 			 * IIO framework gives mV but Power Supply framework
 			 * gives uV.
 			 */
-			val->intval *= 1000;
+			ret = iio_read_channel_processed_scale(power->vbus_v,
+							       &val->intval, 1000);
+			if (ret)
+				return ret;
+
 			return 0;
 		}
 
-- 
2.43.0


