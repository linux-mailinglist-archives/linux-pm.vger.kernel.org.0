Return-Path: <linux-pm+bounces-29088-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id C6177AE0972
	for <lists+linux-pm@lfdr.de>; Thu, 19 Jun 2025 16:59:25 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 61D761C20E2F
	for <lists+linux-pm@lfdr.de>; Thu, 19 Jun 2025 14:57:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A462E28DF48;
	Thu, 19 Jun 2025 14:55:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="IOUf57Mu"
X-Original-To: linux-pm@vger.kernel.org
Received: from mail-wr1-f43.google.com (mail-wr1-f43.google.com [209.85.221.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6140328D8CE
	for <linux-pm@vger.kernel.org>; Thu, 19 Jun 2025 14:55:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750344933; cv=none; b=glKRU+lAK1oiuHvAIl62VjIWCGLaMp+Sw/GFw1sTw6AS91dSWwRN/1MtxkzLDWop6VYahMI5n4dwy6oZ2rqt7l4GmwxAgoksA0fSYUSNukoZVTgJTtUzGoGcT+kYipWz1Db5Q40jQSQ8yu2Ot4lDdEYPjRuetyVDppxv2xb8SIo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750344933; c=relaxed/simple;
	bh=hfxv1DtZdlwRviIOgnak2gccDnkJhuul0zWJ5mSgHQI=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=GUXFsxDnsg1JXh7Msj6A7j4w4itoPf4rbTG1VVVbLuyHytj10ka/BXYpSExqLnIJTgaQ4Bo0/D5DGRuSbjZGjOEcpgx1o2tKayDAI/zPs6h/WQi74M2WmT5SEM2sA2vuPfmTYMymGT+W3SvfN3/I0SLWTfKtUa8+FhbWadGHgdw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=IOUf57Mu; arc=none smtp.client-ip=209.85.221.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-wr1-f43.google.com with SMTP id ffacd0b85a97d-3a522224582so436758f8f.3
        for <linux-pm@vger.kernel.org>; Thu, 19 Jun 2025 07:55:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1750344928; x=1750949728; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=h2x2H08jDXRaXR0Yr7xxE830BP4sQoxluaMapVfIpIs=;
        b=IOUf57MuLLkbTBdHh+DATkmjB7sMrl68nrL4Q8XlEaloRPyxQXQnGYNFxf67HTq+xx
         zbj9E5cVlRqMKhqVmJJNNuaRkvhT3s2A9Uodvhx+13aDxtFUjYXwe662hl05VCuH2LBk
         vCOHHsFeL336DPw+XRWRzqt8+rdkI7KUXqM+xSlWYvLIIdFsJBh4Bk19yW/LHNWZqEmT
         fv+TrFrTPzBXygBjvHTYrnneidlgb3hRVPxcg679RX1Z7tTNG/ksb/yPApiJ07WEMHok
         gghI7ltV0kIQ5pV7HcoM1X2M0BuXDLUFP+hVuBOGcgehyFDdPgtz0FJc5I12XM0CWHTz
         /g8w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1750344928; x=1750949728;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=h2x2H08jDXRaXR0Yr7xxE830BP4sQoxluaMapVfIpIs=;
        b=maxS84S5R+BDvsoH9aMTqSABbb5KE0wy6t4dfLN4SA7y5Mb9CxFwTcEr+9nAcWpeUR
         kZEt0auiP2lbNl6AozoK8sMW0vHzIVv2mdZkMhRga3byyPs30D2kFyKTIh7QWAgiTwv2
         HuHBF/SIK1/INBsj4chS9cmzyC/2MuPwCUq+lY4RM+Hbqc6hgeOw5s2OlA008H/qLPLP
         PCknDVi4NBj9Qtr+13wyr+zG1cB92lZDFMjiJiUjqnglbup1udmpSi9JeW3kp+awCVCU
         DIBUlb1WWpWg+4JHLBvmNrW0cYwhIPIex0usm2xvLRLxjF3SE67vFbPGiP7jnz+WyDU0
         0Mhw==
X-Forwarded-Encrypted: i=1; AJvYcCXB6sRjvmNHXJ3QIM99cB+k5Kfqba+wbvwN2ojzr63m6zN9Oglrqq+n7uMnZXv1/j4i7ZZfLPvjVQ==@vger.kernel.org
X-Gm-Message-State: AOJu0YwTbyNvLJzJ8iGzFdyPSi3tFWjRYhFxOk+FOYuFweHd1V8L6i5o
	4+gigd/i6a3pWohw90yAI/uN3iq8zAhR2HJSVyj9Pws7I8SzoxVsCj7nH9PTD30H1r4=
X-Gm-Gg: ASbGnctIzZQy+k/FM58gblmWII4D8W0Km/FV4eNnlI32fxJdKl4zdBvUXQXTfthFVA2
	7lv/ZRnf2g3tt0N+e3JMSq8JD3de/M+UnTimoLhCXMZGS3Tvt41n3RW/iD3xIPrqhSoYtgNxbdu
	Z/56Tsh/B5FCRjjAx0cSngsXdVoQPumzmU1D8pO2zarAo56lH2Cj6tC25iIbSsUQtlC289aYuc2
	bw+9w3uwnUAR8cRXhdWNi2tpqdlYdOeZtIyquKgul74puP1cZGsTWBkNH7ebFqa4+amcEYJ71tP
	ETsn0vEhFOm1O5F/SRBUYezA1yD63it8FcCnZ4XbnPAFyiWHCOyanULtH4ykJqrf/J1j82oMF9e
	H7o55muRIiB27S5wH0Z2Gig==
X-Google-Smtp-Source: AGHT+IG0Myiu1GtIhNeuFtAB8WQQ1lcfVyrvJFwgX2fNT6Rbat1lEOhnWuxbqqqsxLOWIwDEmETQhw==
X-Received: by 2002:a05:6000:65b:b0:3a5:88e9:a543 with SMTP id ffacd0b85a97d-3a588e9ab75mr8835780f8f.58.1750344928183;
        Thu, 19 Jun 2025 07:55:28 -0700 (PDT)
Received: from toyger.tail248178.ts.net ([2a0e:c5c1:0:100:b058:b8f5:b561:423c])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4535ebced8asm31343715e9.40.2025.06.19.07.55.26
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 19 Jun 2025 07:55:27 -0700 (PDT)
From: Casey Connolly <casey.connolly@linaro.org>
Date: Thu, 19 Jun 2025 16:55:16 +0200
Subject: [PATCH 08/11] power: supply: qcom_smbx: remove unused registers
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250619-smb2-smb5-support-v1-8-ac5dec51b6e1@linaro.org>
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
X-Developer-Signature: v=1; a=openpgp-sha256; l=12313;
 i=casey.connolly@linaro.org; h=from:subject:message-id;
 bh=hfxv1DtZdlwRviIOgnak2gccDnkJhuul0zWJ5mSgHQI=;
 b=owEBbQKS/ZANAwAKAQWDMSsZX2S2AcsmYgBoVCTSkrP4staRfrVo6Lmof5bKK4TE5DAIiIpII
 PNaPKc6RiOJAjMEAAEKAB0WIQS2UaFGPGq+0GkMVc0FgzErGV9ktgUCaFQk0gAKCRAFgzErGV9k
 tsnjD/4uQm9oG6R8NCMu9BFl0L/iRCn21g/iNjbnnJNqzA+cCJ/56ZroylewWKVnP4PJ8Kk/HMz
 7Pv3h22pucBcDw7H4I06JNy71pEkkY2L40oJy2+JVkm8al27IL8mR0NXhP2OCI9pS5qwerJr/AV
 Ya11eVP5MH7O4z3LZJKZVkvGRuYMCdatHGI314SlOOtUV8w6r0bR7XlLwgp/yNoYWRcECzRewAt
 g0IpbZrABtDzGIU2qpkjdylF3jv3cv+y0khWkd0QXD+peLgGFA51/Q6LnVxUI+Y4cQFBplmXFYu
 52Hm8TWOi+TcGWRojs7+lItfb2DDxJ4xw8bf+Ga+l9HfTl6vQHJCiLyCH948oI7ayy9dP/fh9Yb
 J08m4a2VeO2YgnuEp8dSLiYhUIXoA2q2jGeE2RCKQpQ4e6w/GxIw3heztj408ITwqiC5hnuJbcV
 B9bv/fO37tx0ooWxJlxCGaMH7V7Ceklr05w83JNofgx3apL2VBXBqESzUSjprceOG0EHgi3lhEa
 6KPmta5djWAe3eRAa7qLAXy0m4zzQ5JaYpQUTjUQ5F7XvhVnus2GIErKNDjOuDe+X/FvMKZ+rbl
 QGGG2kJZ1rOQPPnQHqclN9oA07f6nE0jTpoIgRXXU39EmB9MInf5A9faytx+9oz6myBbT2TDvjm
 GxK9XUDsfWxt7fw==
X-Developer-Key: i=casey.connolly@linaro.org; a=openpgp;
 fpr=83B24DA7FE145076BC38BB250CD904EB673A7C47

Remove registers and bits that aren't used to make things a bit more
readable.

Signed-off-by: Casey Connolly <casey.connolly@linaro.org>
---
 drivers/power/supply/qcom_smbx.c | 211 +--------------------------------------
 1 file changed, 4 insertions(+), 207 deletions(-)

diff --git a/drivers/power/supply/qcom_smbx.c b/drivers/power/supply/qcom_smbx.c
index d1607674d291d6ef5762d35acd3330e2116f41a3..10ddd33a09599decb23c0f1ccd02fa9b56602543 100644
--- a/drivers/power/supply/qcom_smbx.c
+++ b/drivers/power/supply/qcom_smbx.c
@@ -24,39 +24,17 @@
 #include <linux/workqueue.h>
 
 /* clang-format off */
 #define BATTERY_CHARGER_STATUS_1			0x06
-#define BVR_INITIAL_RAMP_BIT				BIT(7)
-#define CC_SOFT_TERMINATE_BIT				BIT(6)
-#define STEP_CHARGING_STATUS_SHIFT			3
-#define STEP_CHARGING_STATUS_MASK			GENMASK(5, 3)
 #define BATTERY_CHARGER_STATUS_MASK			GENMASK(2, 0)
 
 #define BATTERY_CHARGER_STATUS_2			0x07
-#define INPUT_CURRENT_LIMITED_BIT			BIT(7)
-#define CHARGER_ERROR_STATUS_SFT_EXPIRE_BIT		BIT(6)
 #define CHARGER_ERROR_STATUS_BAT_OV_BIT			BIT(5)
-#define CHARGER_ERROR_STATUS_BAT_TERM_MISSING_BIT	BIT(4)
-#define BAT_TEMP_STATUS_MASK				GENMASK(3, 0)
-#define BAT_TEMP_STATUS_SOFT_LIMIT_MASK			GENMASK(3, 2)
 #define BAT_TEMP_STATUS_HOT_SOFT_LIMIT_BIT		BIT(3)
 #define BAT_TEMP_STATUS_COLD_SOFT_LIMIT_BIT		BIT(2)
 #define BAT_TEMP_STATUS_TOO_HOT_BIT			BIT(1)
 #define BAT_TEMP_STATUS_TOO_COLD_BIT			BIT(0)
 
-#define BATTERY_CHARGER_STATUS_4			0x0A
-#define CHARGE_CURRENT_POST_JEITA_MASK			GENMASK(7, 0)
-
-#define BATTERY_CHARGER_STATUS_7			0x0D
-#define ENABLE_TRICKLE_BIT				BIT(7)
-#define ENABLE_PRE_CHARGING_BIT				BIT(6)
-#define ENABLE_FAST_CHARGING_BIT			BIT(5)
-#define ENABLE_FULLON_MODE_BIT				BIT(4)
-#define TOO_COLD_ADC_BIT				BIT(3)
-#define TOO_HOT_ADC_BIT					BIT(2)
-#define HOT_SL_ADC_BIT					BIT(1)
-#define COLD_SL_ADC_BIT					BIT(0)
-
 #define CHARGING_ENABLE_CMD				0x42
 #define CHARGING_ENABLE_CMD_BIT				BIT(0)
 
 #define CHGR_CFG2					0x51
@@ -78,270 +56,89 @@
 #define FLOAT_VOLTAGE_CFG				0x70
 #define FLOAT_VOLTAGE_SETTING_MASK			GENMASK(7, 0)
 
 #define FG_UPDATE_CFG_2_SEL				0x7D
-#define SOC_LT_OTG_THRESH_SEL_BIT			BIT(3)
 #define SOC_LT_CHG_RECHARGE_THRESH_SEL_BIT		BIT(2)
 #define VBT_LT_CHG_RECHARGE_THRESH_SEL_BIT		BIT(1)
-#define IBT_LT_CHG_TERM_THRESH_SEL_BIT			BIT(0)
-
-#define JEITA_EN_CFG					0x90
-#define JEITA_EN_HARDLIMIT_BIT				BIT(4)
-#define JEITA_EN_HOT_SL_FCV_BIT				BIT(3)
-#define JEITA_EN_COLD_SL_FCV_BIT			BIT(2)
-#define JEITA_EN_HOT_SL_CCC_BIT				BIT(1)
-#define JEITA_EN_COLD_SL_CCC_BIT			BIT(0)
-
-#define INT_RT_STS					0x310
-#define TYPE_C_CHANGE_RT_STS_BIT			BIT(7)
-#define USBIN_ICL_CHANGE_RT_STS_BIT			BIT(6)
-#define USBIN_SOURCE_CHANGE_RT_STS_BIT			BIT(5)
-#define USBIN_PLUGIN_RT_STS_BIT				BIT(4)
-#define USBIN_OV_RT_STS_BIT				BIT(3)
-#define USBIN_UV_RT_STS_BIT				BIT(2)
-#define USBIN_LT_3P6V_RT_STS_BIT			BIT(1)
-#define USBIN_COLLAPSE_RT_STS_BIT			BIT(0)
 
 #define OTG_CFG						0x153
-#define OTG_RESERVED_MASK				GENMASK(7, 6)
-#define DIS_OTG_ON_TLIM_BIT				BIT(5)
-#define QUICKSTART_OTG_FASTROLESWAP_BIT			BIT(4)
-#define INCREASE_DFP_TIME_BIT				BIT(3)
-#define ENABLE_OTG_IN_DEBUG_MODE_BIT			BIT(2)
 #define OTG_EN_SRC_CFG_BIT				BIT(1)
-#define CONCURRENT_MODE_CFG_BIT				BIT(0)
-
-#define OTG_ENG_OTG_CFG					0x1C0
-#define ENG_BUCKBOOST_HALT1_8_MODE_BIT			BIT(0)
 
 #define APSD_STATUS					0x307
-#define APSD_STATUS_7_BIT				BIT(7)
-#define HVDCP_CHECK_TIMEOUT_BIT				BIT(6)
-#define SLOW_PLUGIN_TIMEOUT_BIT				BIT(5)
-#define ENUMERATION_DONE_BIT				BIT(4)
-#define VADP_CHANGE_DONE_AFTER_AUTH_BIT			BIT(3)
-#define QC_AUTH_DONE_STATUS_BIT				BIT(2)
-#define QC_CHARGER_BIT					BIT(1)
 #define APSD_DTC_STATUS_DONE_BIT			BIT(0)
 
 #define APSD_RESULT_STATUS				0x308
-#define ICL_OVERRIDE_LATCH_BIT				BIT(7)
 #define APSD_RESULT_STATUS_MASK				GENMASK(6, 0)
-#define QC_3P0_BIT					BIT(6)
-#define QC_2P0_BIT					BIT(5)
 #define FLOAT_CHARGER_BIT				BIT(4)
 #define DCP_CHARGER_BIT					BIT(3)
 #define CDP_CHARGER_BIT					BIT(2)
 #define OCP_CHARGER_BIT					BIT(1)
 #define SDP_CHARGER_BIT					BIT(0)
 
-#define TYPE_C_STATUS_1					0x30B
-#define UFP_TYPEC_MASK					GENMASK(7, 5)
-#define UFP_TYPEC_RDSTD_BIT				BIT(7)
-#define UFP_TYPEC_RD1P5_BIT				BIT(6)
-#define UFP_TYPEC_RD3P0_BIT				BIT(5)
-#define UFP_TYPEC_FMB_255K_BIT				BIT(4)
-#define UFP_TYPEC_FMB_301K_BIT				BIT(3)
-#define UFP_TYPEC_FMB_523K_BIT				BIT(2)
-#define UFP_TYPEC_FMB_619K_BIT				BIT(1)
-#define UFP_TYPEC_OPEN_OPEN_BIT				BIT(0)
-
-#define TYPE_C_STATUS_2					0x30C
-#define DFP_RA_OPEN_BIT					BIT(7)
-#define TIMER_STAGE_BIT					BIT(6)
-#define EXIT_UFP_MODE_BIT				BIT(5)
-#define EXIT_DFP_MODE_BIT				BIT(4)
-#define DFP_TYPEC_MASK					GENMASK(3, 0)
-#define DFP_RD_OPEN_BIT					BIT(3)
-#define DFP_RD_RA_VCONN_BIT				BIT(2)
-#define DFP_RD_RD_BIT					BIT(1)
-#define DFP_RA_RA_BIT					BIT(0)
-
-#define TYPE_C_STATUS_3					0x30D
-#define ENABLE_BANDGAP_BIT				BIT(7)
-#define U_USB_GND_NOVBUS_BIT				BIT(6)
-#define U_USB_FLOAT_NOVBUS_BIT				BIT(5)
-#define U_USB_GND_BIT					BIT(4)
-#define U_USB_FMB1_BIT					BIT(3)
-#define U_USB_FLOAT1_BIT				BIT(2)
-#define U_USB_FMB2_BIT					BIT(1)
-#define U_USB_FLOAT2_BIT				BIT(0)
-
-#define TYPE_C_STATUS_4					0x30E
-#define UFP_DFP_MODE_STATUS_BIT				BIT(7)
-#define TYPEC_VBUS_STATUS_BIT				BIT(6)
-#define TYPEC_VBUS_ERROR_STATUS_BIT			BIT(5)
-#define TYPEC_DEBOUNCE_DONE_STATUS_BIT			BIT(4)
-#define TYPEC_UFP_AUDIO_ADAPT_STATUS_BIT		BIT(3)
-#define TYPEC_VCONN_OVERCURR_STATUS_BIT			BIT(2)
-#define CC_ORIENTATION_BIT				BIT(1)
-#define CC_ATTACHED_BIT					BIT(0)
-
-#define TYPE_C_STATUS_5					0x30F
-#define TRY_SOURCE_FAILED_BIT				BIT(6)
-#define TRY_SINK_FAILED_BIT				BIT(5)
-#define TIMER_STAGE_2_BIT				BIT(4)
-#define TYPEC_LEGACY_CABLE_STATUS_BIT			BIT(3)
-#define TYPEC_NONCOMP_LEGACY_CABLE_STATUS_BIT		BIT(2)
-#define TYPEC_TRYSOURCE_DETECT_STATUS_BIT		BIT(1)
-#define TYPEC_TRYSINK_DETECT_STATUS_BIT			BIT(0)
-
 #define CMD_APSD					0x341
-#define ICL_OVERRIDE_BIT				BIT(1)
 #define APSD_RERUN_BIT					BIT(0)
 
 #define TYPE_C_CFG					0x358
-#define APSD_START_ON_CC_BIT				BIT(7)
-#define WAIT_FOR_APSD_BIT				BIT(6)
 #define FACTORY_MODE_DETECTION_EN_BIT			BIT(5)
-#define FACTORY_MODE_ICL_3A_4A_BIT			BIT(4)
-#define FACTORY_MODE_DIS_CHGING_CFG_BIT			BIT(3)
-#define SUSPEND_NON_COMPLIANT_CFG_BIT			BIT(2)
 #define VCONN_OC_CFG_BIT				BIT(1)
-#define TYPE_C_OR_U_USB_BIT				BIT(0)
-
-#define TYPE_C_CFG_2					0x359
-#define TYPE_C_DFP_CURRSRC_MODE_BIT			BIT(7)
-#define DFP_CC_1P4V_OR_1P6V_BIT				BIT(6)
-#define VCONN_SOFTSTART_CFG_MASK			GENMASK(5, 4)
-#define EN_TRY_SOURCE_MODE_BIT				BIT(3)
-#define USB_FACTORY_MODE_ENABLE_BIT			BIT(2)
-#define TYPE_C_UFP_MODE_BIT				BIT(1)
-#define EN_80UA_180UA_CUR_SOURCE_BIT			BIT(0)
-
-#define TYPE_C_CFG_3					0x35A
-#define TVBUS_DEBOUNCE_BIT				BIT(7)
-#define TYPEC_LEGACY_CABLE_INT_EN_BIT			BIT(6)
-#define TYPEC_NONCOMPLIANT_LEGACY_CABLE_INT_EN_B	BIT(5)
-#define TYPEC_TRYSOURCE_DETECT_INT_EN_BIT		BIT(4)
-#define TYPEC_TRYSINK_DETECT_INT_EN_BIT			BIT(3)
-#define EN_TRYSINK_MODE_BIT				BIT(2)
-#define EN_LEGACY_CABLE_DETECTION_BIT			BIT(1)
-#define ALLOW_PD_DRING_UFP_TCCDB_BIT			BIT(0)
 
 #define USBIN_OPTIONS_1_CFG				0x362
-#define CABLE_R_SEL_BIT					BIT(7)
-#define HVDCP_AUTH_ALG_EN_CFG_BIT			BIT(6)
-#define HVDCP_AUTONOMOUS_MODE_EN_CFG_BIT		BIT(5)
-#define INPUT_PRIORITY_BIT				BIT(4)
-#define AUTO_SRC_DETECT_BIT				BIT(3)
 #define HVDCP_EN_BIT					BIT(2)
-#define VADP_INCREMENT_VOLTAGE_LIMIT_BIT		BIT(1)
-#define VADP_TAPER_TIMER_EN_BIT				BIT(0)
-
-#define USBIN_OPTIONS_2_CFG				0x363
-#define WIPWR_RST_EUD_CFG_BIT				BIT(7)
-#define SWITCHER_START_CFG_BIT				BIT(6)
-#define DCD_TIMEOUT_SEL_BIT				BIT(5)
-#define OCD_CURRENT_SEL_BIT				BIT(4)
-#define SLOW_PLUGIN_TIMER_EN_CFG_BIT			BIT(3)
-#define FLOAT_OPTIONS_MASK				GENMASK(2, 0)
-#define FLOAT_DIS_CHGING_CFG_BIT			BIT(2)
-#define SUSPEND_FLOAT_CFG_BIT				BIT(1)
-#define FORCE_FLOAT_SDP_CFG_BIT				BIT(0)
-
-#define TAPER_TIMER_SEL_CFG				0x364
-#define TYPEC_SPARE_CFG_BIT				BIT(7)
-#define TYPEC_DRP_DFP_TIME_CFG_BIT			BIT(5)
-#define TAPER_TIMER_SEL_MASK				GENMASK(1, 0)
-
-#define USBIN_LOAD_CFG					0x365
-#define USBIN_OV_CH_LOAD_OPTION_BIT			BIT(7)
-#define ICL_OVERRIDE_AFTER_APSD_BIT			BIT(4)
 
 #define USBIN_ICL_OPTIONS				0x366
-#define CFG_USB3P0_SEL_BIT				BIT(2)
 #define USB51_MODE_BIT					BIT(1)
 #define USBIN_MODE_CHG_BIT				BIT(0)
 
+/* PMI8998 only */
 #define TYPE_C_INTRPT_ENB_SOFTWARE_CTRL			0x368
-#define EXIT_SNK_BASED_ON_CC_BIT			BIT(7)
-#define VCONN_EN_ORIENTATION_BIT			BIT(6)
-#define TYPEC_VCONN_OVERCURR_INT_EN_BIT			BIT(5)
 #define VCONN_EN_SRC_BIT				BIT(4)
 #define VCONN_EN_VALUE_BIT				BIT(3)
 #define TYPEC_POWER_ROLE_CMD_MASK			GENMASK(2, 0)
 #define UFP_EN_CMD_BIT					BIT(2)
 #define DFP_EN_CMD_BIT					BIT(1)
 #define TYPEC_DISABLE_CMD_BIT				BIT(0)
 
 #define USBIN_CURRENT_LIMIT_CFG				0x370
-#define USBIN_CURRENT_LIMIT_MASK			GENMASK(7, 0)
 
 #define USBIN_AICL_OPTIONS_CFG				0x380
 #define SUSPEND_ON_COLLAPSE_USBIN_BIT			BIT(7)
-#define USBIN_AICL_HDC_EN_BIT				BIT(6)
 #define USBIN_AICL_START_AT_MAX_BIT			BIT(5)
-#define USBIN_AICL_RERUN_EN_BIT				BIT(4)
 #define USBIN_AICL_ADC_EN_BIT				BIT(3)
 #define USBIN_AICL_EN_BIT				BIT(2)
 #define USBIN_HV_COLLAPSE_RESPONSE_BIT			BIT(1)
 #define USBIN_LV_COLLAPSE_RESPONSE_BIT			BIT(0)
 
+// FIXME: drop these and their programming, no need to set min to 4.3v
 #define USBIN_5V_AICL_THRESHOLD_CFG			0x381
 #define USBIN_5V_AICL_THRESHOLD_CFG_MASK		GENMASK(2, 0)
 
 #define USBIN_CONT_AICL_THRESHOLD_CFG			0x384
 #define USBIN_CONT_AICL_THRESHOLD_CFG_MASK		GENMASK(5, 0)
 
-#define DC_ENG_SSUPPLY_CFG2				0x4C1
-#define ENG_SSUPPLY_IVREF_OTG_SS_MASK			GENMASK(2, 0)
-#define OTG_SS_SLOW					0x3
-
-#define DCIN_AICL_REF_SEL_CFG				0x481
-#define DCIN_CONT_AICL_THRESHOLD_CFG_MASK		GENMASK(5, 0)
-
-#define WI_PWR_OPTIONS					0x495
-#define CHG_OK_BIT					BIT(7)
-#define WIPWR_UVLO_IRQ_OPT_BIT				BIT(6)
-#define BUCK_HOLDOFF_ENABLE_BIT				BIT(5)
-#define CHG_OK_HW_SW_SELECT_BIT				BIT(4)
-#define WIPWR_RST_ENABLE_BIT				BIT(3)
-#define DCIN_WIPWR_IRQ_SELECT_BIT			BIT(2)
-#define AICL_SWITCH_ENABLE_BIT				BIT(1)
-#define ZIN_ICL_ENABLE_BIT				BIT(0)
-
 #define ICL_STATUS					0x607
 #define INPUT_CURRENT_LIMIT_MASK			GENMASK(7, 0)
 
 #define POWER_PATH_STATUS				0x60B
-#define P_PATH_INPUT_SS_DONE_BIT			BIT(7)
-#define P_PATH_USBIN_SUSPEND_STS_BIT			BIT(6)
-#define P_PATH_DCIN_SUSPEND_STS_BIT			BIT(5)
 #define P_PATH_USE_USBIN_BIT				BIT(4)
-#define P_PATH_USE_DCIN_BIT				BIT(3)
-#define P_PATH_POWER_PATH_MASK				GENMASK(2, 1)
 #define P_PATH_VALID_INPUT_POWER_SOURCE_STS_BIT		BIT(0)
 
 #define BARK_BITE_WDOG_PET				0x643
 #define BARK_BITE_WDOG_PET_BIT				BIT(0)
 
 #define WD_CFG						0x651
 #define WATCHDOG_TRIGGER_AFP_EN_BIT			BIT(7)
 #define BARK_WDOG_INT_EN_BIT				BIT(6)
-#define BITE_WDOG_INT_EN_BIT				BIT(5)
-#define SFT_AFTER_WDOG_IRQ_MASK				GENMASK(4, 3)
-#define WDOG_IRQ_SFT_BIT				BIT(2)
 #define WDOG_TIMER_EN_ON_PLUGIN_BIT			BIT(1)
-#define WDOG_TIMER_EN_BIT				BIT(0)
 
 #define SNARL_BARK_BITE_WD_CFG				0x653
-#define BITE_WDOG_DISABLE_CHARGING_CFG_BIT		BIT(7)
-#define SNARL_WDOG_TIMEOUT_MASK				GENMASK(6, 4)
-#define BARK_WDOG_TIMEOUT_MASK				GENMASK(3, 2)
-#define BITE_WDOG_TIMEOUT_MASK				GENMASK(1, 0)
 
 #define AICL_RERUN_TIME_CFG				0x661
 #define AICL_RERUN_TIME_MASK				GENMASK(1, 0)
+#define AIC_RERUN_TIME_3_SECS				0x0
 
+/* FIXME: probably remove this so we get parallel charging? */
 #define STAT_CFG					0x690
-#define STAT_SW_OVERRIDE_VALUE_BIT			BIT(7)
 #define STAT_SW_OVERRIDE_CFG_BIT			BIT(6)
-#define STAT_PARALLEL_OFF_DG_CFG_MASK			GENMASK(5, 4)
-#define STAT_POLARITY_CFG_BIT				BIT(3)
-#define STAT_PARALLEL_CFG_BIT				BIT(2)
-#define STAT_FUNCTION_CFG_BIT				BIT(1)
-#define STAT_IRQ_PULSING_EN_BIT				BIT(0)
 
 #define SDP_CURRENT_UA					500000
 #define CDP_CURRENT_UA					1500000
 #define DCP_CURRENT_UA					1500000

-- 
2.49.0


