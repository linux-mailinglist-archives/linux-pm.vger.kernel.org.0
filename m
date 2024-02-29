Return-Path: <linux-pm+bounces-4534-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 4175486C0EA
	for <lists+linux-pm@lfdr.de>; Thu, 29 Feb 2024 07:41:05 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 8A9C3281EFD
	for <lists+linux-pm@lfdr.de>; Thu, 29 Feb 2024 06:41:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F18A54439F;
	Thu, 29 Feb 2024 06:39:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="WGqpO2vF"
X-Original-To: linux-pm@vger.kernel.org
Received: from mail-lj1-f172.google.com (mail-lj1-f172.google.com [209.85.208.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 25F594437C
	for <linux-pm@vger.kernel.org>; Thu, 29 Feb 2024 06:39:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709188763; cv=none; b=arGFU85qK8ZoAUC0Id//jAhcN5hCuSZaX0t0w53BJ8cn2ph2n0YBpnT1J8CvFlGt2FiO7B+gDr0GZ4je0BeG9nbNDRhadkit1XNEdYfTr3lywgwpTy5wJdawAUfE78x5ri7aBCxxYdRmE3ZQ546tZyT9da4c0H8oKAd7GFA3k14=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709188763; c=relaxed/simple;
	bh=OM/s904yc29HtImh1rNRjz12mWecBv07XSIaCWcYSEE=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=BiaC/KM6AQ882pACBpDQC7iaWE/vg+/TweKzX+BjLHUJfW2mvaALDye1ct6iwDpjtLluQj/KZ5Pk3Xf2b7o8LBOaOzlHI1+/tUf8FoN1qpgNARIPKjBYah4L379CSUh44zQnIfYJaBHoCihBBbyaHtDG/bBHoqBjnixHBrltpW0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=WGqpO2vF; arc=none smtp.client-ip=209.85.208.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-lj1-f172.google.com with SMTP id 38308e7fff4ca-2d269b2ff48so5562611fa.3
        for <linux-pm@vger.kernel.org>; Wed, 28 Feb 2024 22:39:21 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1709188760; x=1709793560; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=jHMm4UdW0d89mI3h3z5wKSWAYwxrpZ0h0BhS5GnBb/I=;
        b=WGqpO2vF6Ojd0DcvZg9JzCrGRzwXMrFJaP/2U3JYVQJr90q652b2bDbShp+HKMz/bm
         7NZR2DDl4mF4Zk1HMseHGkhHrETnmzndR0meKj8p9I7Yzzx6fuY2lEPHP5xrcJTXs0Of
         efn2gWE70RHQgBcvR/w8jqGenbttFRgcQJDOeTZDVsWXaPX9y8mkk13bBSXSLcnrMxoy
         23vFaJzkbrRS+n0Pp3/xC4Zc/buy0D61hnjZM4HD++gFncgxJ/RQ1LIIw4mcJx4SOVFh
         YAohkhqRyw7SX6w40SohkUQrNmQm6NjCe++PxI4VQSMZ7RkaRo50ipZTgL258qrM23Vt
         rNTA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1709188760; x=1709793560;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=jHMm4UdW0d89mI3h3z5wKSWAYwxrpZ0h0BhS5GnBb/I=;
        b=WAHwVdHHWH6CGW7wmMf9fTf+3U1MMKLW4KCr8QxNjnloG5ODA+u/mBjQVsC97LTL1L
         0YQdtaVPfDAvISeyCz4Bg0L1tbq+i8TvjM8ecAMDzAei+oiycrL3FEOscxbCQT1ajI9I
         c3/mC/GLsd8hUx+QM1JiwlwT3Dbq4P/4nBZjLMLQg+mLndLsYN+7zxrGrbuI7gmz//BK
         Wg3saLCivTnZ+TUGiJy53X5ncxSca7pKbzovWt3Krzjudx5XtMSV/54kojJUqOj77p64
         yDUVFV04E20zJ1pFDRHVX9RxHa0YjzPHItMBMDNGWmYU8goaSEROJzEtdYR8URH7lDnH
         UDag==
X-Forwarded-Encrypted: i=1; AJvYcCVhaTZxaPaZrV3IIUc9TpEFvOCzyKVBebezvUkeVws361bgZRTBHWmaUMPM7LQhswH1641r8HzvP9aDXKsFPaEmXaks6fY90ys=
X-Gm-Message-State: AOJu0Yzt5Jli8m0v5LpW5ysIDFYABgly3DzzMrHDFu5gK0ZK/U1uj89N
	BVjlfuJAZs5jmJvW4s69Wwb4WDIzEtluw8fQK1mCZeHIHiYdMYKL
X-Google-Smtp-Source: AGHT+IHIU5I7mObYF53Xb25ZokNRk93jDajC5ODl+dttj+yKI7Eug9elGGWiStKFu7xas0tsV/mlfw==
X-Received: by 2002:a2e:91cd:0:b0:2d2:2fe9:2896 with SMTP id u13-20020a2e91cd000000b002d22fe92896mr609041ljg.42.1709188759907;
        Wed, 28 Feb 2024 22:39:19 -0800 (PST)
Received: from tpt440p.steeds.sam ([69.63.64.50])
        by smtp.gmail.com with ESMTPSA id x2-20020a2e8382000000b002d0b6eafa8csm110740ljg.39.2024.02.28.22.39.17
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 28 Feb 2024 22:39:19 -0800 (PST)
From: "Sicelo A. Mhlongo" <absicsz@gmail.com>
To: Sebastian Reichel <sebastian.reichel@collabora.com>,
	linux-pm@vger.kernel.org
Cc: maemo-leste@lists.dyne.org,
	pali@kernel.org,
	"Sicelo A. Mhlongo" <absicsz@gmail.com>
Subject: [PATCH v3] power: supply: bq2415x_charger: report online status
Date: Thu, 29 Feb 2024 08:37:21 +0200
Message-ID: <20240229063721.2592069-2-absicsz@gmail.com>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Provide the Online property. This chip does not have specific flags to
indicate the presence of an input voltage, but this is implied by all valid
charging states. Fault states also only occur when VBUS is present, so set
Online true for those as well.

Signed-off-by: Sicelo A. Mhlongo <absicsz@gmail.com>
---
 drivers/power/supply/bq2415x_charger.c | 11 +++++++++++
 1 file changed, 11 insertions(+)

diff --git a/drivers/power/supply/bq2415x_charger.c b/drivers/power/supply/bq2415x_charger.c
index 6a4798a62588..7b93ba20348a 100644
--- a/drivers/power/supply/bq2415x_charger.c
+++ b/drivers/power/supply/bq2415x_charger.c
@@ -991,6 +991,7 @@ static enum power_supply_property bq2415x_power_supply_props[] = {
 	/* TODO: maybe add more power supply properties */
 	POWER_SUPPLY_PROP_STATUS,
 	POWER_SUPPLY_PROP_MODEL_NAME,
+	POWER_SUPPLY_PROP_ONLINE,
 };
 
 static int bq2415x_power_supply_get_property(struct power_supply *psy,
@@ -1017,6 +1018,16 @@ static int bq2415x_power_supply_get_property(struct power_supply *psy,
 	case POWER_SUPPLY_PROP_MODEL_NAME:
 		val->strval = bq->model;
 		break;
+	case POWER_SUPPLY_PROP_ONLINE:
+		/* VBUS is present for all charging and fault states,
+		 * except the 'Ready' state.
+		 */
+		ret = bq2415x_exec_command(bq, BQ2415X_CHARGE_STATUS);
+		if (ret < 0)
+			return ret;
+		else
+			val->intval = ret > 0;
+		break;
 	default:
 		return -EINVAL;
 	}
-- 
2.43.0


