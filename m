Return-Path: <linux-pm+bounces-29086-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id B6ACEAE097E
	for <lists+linux-pm@lfdr.de>; Thu, 19 Jun 2025 17:00:02 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 1C9C83A8B8F
	for <lists+linux-pm@lfdr.de>; Thu, 19 Jun 2025 14:56:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4456D28D85D;
	Thu, 19 Jun 2025 14:55:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="MKQwnBo5"
X-Original-To: linux-pm@vger.kernel.org
Received: from mail-wm1-f47.google.com (mail-wm1-f47.google.com [209.85.128.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E8F8A28C5DF
	for <linux-pm@vger.kernel.org>; Thu, 19 Jun 2025 14:55:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750344930; cv=none; b=hfVLIZRt0PQqEAo7+2lKodD2oViEC4r7miYNgpG4ScwePBe+a52SbiEUJRr/JZ/mpnhy2O+laohsiRIeTYGi360DH4uSWR7DydQjC0qCNSNkFdN9wU9PG75XwSlqTXRsVXp2G/42R/uDS11iJeNDnhNbPeq8JqxdZpSjnxGPp6g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750344930; c=relaxed/simple;
	bh=JemuwVrf8yUubUQ04X5WC7YM6uXAXUdph7sXz3IArE8=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=EeTtJpZeevkugCj1lW/vbSqrqp1ND8EQtnMsiFWa0KGxu8e0lll/MoVZB4TeYRJ/qR5fyDHM19xHCf4uHX0qkfp8v+mWn/f6e1hd2McVNPLcocNRwnyZ1GHwdfO6Gvf1vtuSLy+WtspcgWz1N1ErFfscRhYkv3ajZJHrm/gnFa4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=MKQwnBo5; arc=none smtp.client-ip=209.85.128.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-wm1-f47.google.com with SMTP id 5b1f17b1804b1-441ab63a415so10622825e9.3
        for <linux-pm@vger.kernel.org>; Thu, 19 Jun 2025 07:55:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1750344925; x=1750949725; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=V5fVBNslUv5VUBRyFZmw0sYPamOw5qzhbaF7o6iXTDM=;
        b=MKQwnBo5ycoQ/UXxhYlQBsU9BNuXvxuvbtIza5uFsskVzgo/g5NUZTb0wFpwjL/vrr
         DBbsTtYB22W29rDm8yoJXhTw4sP+yXQz1037p97ZYXPEfWLKxrBYItKDWzIekuc5Xtcr
         Y1oidYG4RHkF3h79svdqoDjtr50NeDG1yUGq+vhWUptFOIXU8dvTiarbQcm6Yu9vOoVz
         QHufH5OrcdelBqgsl6/p7Tql2VhUPqm9S5UTxDuJTgokZJ3Cw4sJtfpBU+RF6BXrCZJW
         ieF9j1Aty6+dFx28iZHz4BRhRhhdDSIE20bDrl4vC6727fvafqX8XtNr9P5obdOcVydP
         np8w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1750344925; x=1750949725;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=V5fVBNslUv5VUBRyFZmw0sYPamOw5qzhbaF7o6iXTDM=;
        b=wwgKegbia4pnDmxWFBrHQdNY0zoy/W1JUnzHRj5WcV+XpEIpGHlgEqDKdSrKm9xjfA
         D8QQ0zYdu9ElIuFOylWhnA+i/+aiAYgYWDEhGDGynK8Szrpvd8HO0d51Z2Tb7kEqGMf9
         kS+X4j9KFMJDzozsYb+VQ15sOXmCU8VEfT8JiIHkdd9aE0CAKoYU6k2D0TTyZC1ZmEDS
         IjrcaAUPCxAn+pa90hstC92V4wpMp+fA4xHbynxcbbaX3X05UMpNLWJDlPfUqxqWjeAh
         q4dBqIKN8WVBjTlGt35wXkMnMdIsP7jmKtMWa+5AJ1UnAbiEylCQ8GihB0hWOOKjEGGw
         xuWA==
X-Forwarded-Encrypted: i=1; AJvYcCVFvEMoYHiX5Fdc/VYF7DchmTlk5x7zLT/3670IRFoe6I1vbaQMaBTei9Wi+OHfsm2W0hC10qQjGg==@vger.kernel.org
X-Gm-Message-State: AOJu0Yx5danj7VN+2/3eyUlmv+BP0F99hpEhW9LCkv0qy8VH3hM4cEOD
	N/Nm6zNERVUmNELszvm/7kRQ1WYtGgcjGyGyosz+ggy27LZP2AVo7kgERC2lqBOrO6Y=
X-Gm-Gg: ASbGncvJmw3SUDRdzm6gctL0Ny3SPC/14f5S2Fu33OW37U+R/3Dcbvg/84LnwX3h0Ww
	xSVM1/qnXG5yWbZBAlemmmQ+Nd5t9WXdyKL5Z9filoa/ViztPoRnHFC9+Z0AN1tJbbZZEYaiHUW
	RAMiQuBKP+U/8K8kQuBozs69X4cj3+4yvVYzm/mzNwZ6ryADfZGiDInV1sMbocJT1opVtowNnlK
	W6AxQpxeGvr40fKAVrPLsaY48ijIPUQJaEdd0XSiZulNQ4xA/g7MDcL90YeYJzy/oVGsonDpMe6
	qhV9HwPmz+3nRq3tAQXZtubA59JmfTNcQVmd70PWVP0ADVrBvYVtgfmCAlXBiI7voSkpBWFmG1n
	GeQ+Q1yyTQx9cEbdEwY31GA==
X-Google-Smtp-Source: AGHT+IGtKHGGVTcveyhymsAylUd1eIhqDyS+/H63/Vk/2Z2lAu24ERgJx0a95RwSPxwt7eNSWAKzyg==
X-Received: by 2002:a05:600c:8b65:b0:44b:eb56:1d45 with SMTP id 5b1f17b1804b1-4533ca6e6a8mr234107125e9.15.1750344925237;
        Thu, 19 Jun 2025 07:55:25 -0700 (PDT)
Received: from toyger.tail248178.ts.net ([2a0e:c5c1:0:100:b058:b8f5:b561:423c])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4535ebced8asm31343715e9.40.2025.06.19.07.55.23
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 19 Jun 2025 07:55:24 -0700 (PDT)
From: Casey Connolly <casey.connolly@linaro.org>
Date: Thu, 19 Jun 2025 16:55:14 +0200
Subject: [PATCH 06/11] power: supply: qcom_smbx: respect battery
 charge-term-current-microamp
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250619-smb2-smb5-support-v1-6-ac5dec51b6e1@linaro.org>
References: <20250619-smb2-smb5-support-v1-0-ac5dec51b6e1@linaro.org>
In-Reply-To: <20250619-smb2-smb5-support-v1-0-ac5dec51b6e1@linaro.org>
To: Sebastian Reichel <sre@kernel.org>, Rob Herring <robh@kernel.org>, 
 Krzysztof Kozlowski <krzk+dt@kernel.org>, 
 Conor Dooley <conor+dt@kernel.org>, Bjorn Andersson <andersson@kernel.org>, 
 Konrad Dybcio <konradybcio@kernel.org>, Kees Cook <kees@kernel.org>, 
 "Gustavo A. R. Silva" <gustavoars@kernel.org>
Cc: linux-arm-msm@vger.kernel.org, linux-pm@vger.kernel.org, 
 devicetree@vger.kernel.org, linux-kernel@vger.kernel.org, 
 Sebastian Reichel <sebastian.reichel@collabora.com>, 
 linux-hardening@vger.kernel.org, Casey Connolly <casey.connolly@linaro.org>
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=openpgp-sha256; l=1515;
 i=casey.connolly@linaro.org; h=from:subject:message-id;
 bh=JemuwVrf8yUubUQ04X5WC7YM6uXAXUdph7sXz3IArE8=;
 b=owEBbQKS/ZANAwAKAQWDMSsZX2S2AcsmYgBoVCTRT9U4Qg9OJkb0pSzAf9sdjAQKdeIlP+DEF
 qNb2vf0iUSJAjMEAAEKAB0WIQS2UaFGPGq+0GkMVc0FgzErGV9ktgUCaFQk0QAKCRAFgzErGV9k
 trkoD/9uMDtivCbMTOrgggGTlyDa6eGLdCUlIPlMr/C7iumj9T0+pX9tt94ykFnWvge1K153/Ic
 TFvf4k+NVmqWQqnDGZw8RvUT1B1uv58Av1/6G7HsTOxkWERwnOosXXYUk+OznOcVeAI8zFd0cg4
 K9on/a6vvkYan6qqINynhXA/Gth3JlCwe/iImk2cx0xqioduRDFfzxcMYhQbUPqAHyvRWS9MHpM
 Imr/3fhnenlaX13mjqfddKkhAQUeM1dE6Lq3Kc8yNXed6rBRSPnJXj82zh3ZYg8/dkzue0TLt0T
 8E5ydS/cMnzR0bIwT3tsuczQmDi2+E381QgV58rsVTu1joDTuVwgD6sVykud5TTOpgOJBGXjTE4
 XlmtoBs1m5k5YkqqsLySsxPuNhm2wPq0BVj7xkUsqn8zErx73u1pPo1pCS6TEfphB8i9jJ2BKwh
 kQ6SAoZsLK7GkQH+A/peNERM42glBRPQiFtzALsI9lumBkZ2IOcgZ9mTD3mHThukOw8yn3bTLFy
 zc40iGbihYhOlY4NxbaCx1YF82AQjKAXO+m66co3u1cyy6E35kfuRuL/DrtIk/TUFoOl3r50LgK
 iHWqEcym98u6mv7isjQHGUN6L8hZKRkVm/mqPOAh/wyT3HvG7coz33+0qPiYK1IZKiGCxsu+Z4F
 lS5agEn1VU+xBsQ==
X-Developer-Key: i=casey.connolly@linaro.org; a=openpgp;
 fpr=83B24DA7FE145076BC38BB250CD904EB673A7C47

Respect the max current limit set on the battery node, one some devices
this is set conservatively to avoid overheating since they only have a
single charger IC (instead of two in parallel).

Signed-off-by: Casey Connolly <casey.connolly@linaro.org>
---
 drivers/power/supply/qcom_smbx.c | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/drivers/power/supply/qcom_smbx.c b/drivers/power/supply/qcom_smbx.c
index fc2a8e20435639a9da4d966c43271beaeb57a03f..7fc232fa7260a7422ac12a48686cd7d396edd9a4 100644
--- a/drivers/power/supply/qcom_smbx.c
+++ b/drivers/power/supply/qcom_smbx.c
@@ -583,9 +583,9 @@ static void smb_status_change_work(struct work_struct *work)
 	case POWER_SUPPLY_USB_TYPE_CDP:
 		current_ua = CDP_CURRENT_UA;
 		break;
 	case POWER_SUPPLY_USB_TYPE_DCP:
-		current_ua = DCP_CURRENT_UA;
+		current_ua = chip->batt_info->constant_charge_current_max_ua;
 		break;
 	case POWER_SUPPLY_USB_TYPE_SDP:
 	default:
 		current_ua = SDP_CURRENT_UA;
@@ -989,8 +989,10 @@ static int smb_probe(struct platform_device *pdev)
 	rc = power_supply_get_battery_info(chip->chg_psy, &chip->batt_info);
 	if (rc)
 		return dev_err_probe(chip->dev, rc,
 				     "Failed to get battery info\n");
+	if (chip->batt_info->constant_charge_current_max_ua == -EINVAL)
+		chip->batt_info->constant_charge_current_max_ua = DCP_CURRENT_UA;
 
 	rc = devm_delayed_work_autocancel(chip->dev, &chip->status_change_work,
 					  smb_status_change_work);
 	if (rc)

-- 
2.49.0


