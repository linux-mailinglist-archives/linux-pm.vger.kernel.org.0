Return-Path: <linux-pm+bounces-292-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id A347A7FA4B6
	for <lists+linux-pm@lfdr.de>; Mon, 27 Nov 2023 16:29:55 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 59C35281A38
	for <lists+linux-pm@lfdr.de>; Mon, 27 Nov 2023 15:29:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 912C532C68;
	Mon, 27 Nov 2023 15:29:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="n9UejEQ1"
X-Original-To: linux-pm@vger.kernel.org
Received: from mail-ed1-x529.google.com (mail-ed1-x529.google.com [IPv6:2a00:1450:4864:20::529])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 66EF710D8
	for <linux-pm@vger.kernel.org>; Mon, 27 Nov 2023 07:29:33 -0800 (PST)
Received: by mail-ed1-x529.google.com with SMTP id 4fb4d7f45d1cf-54afd43c83cso4020022a12.0
        for <linux-pm@vger.kernel.org>; Mon, 27 Nov 2023 07:29:33 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1701098972; x=1701703772; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=6AuHxZr8x/Uk1Y12/gMeKhnjQeN0t/qZ6GCe7PtBack=;
        b=n9UejEQ12RcJS6EOwUkVD9IE4V2/Ax/KY/sFWYINrIEji+JRelZdBxGAAhKGQXljGU
         PpnwzX61v4UBxNQ7uaBVThcSBg55ZPlykvhrHVc42D/c95ipz0Dn5Fuc6UExFeMfBHQi
         71bdxk9tFBNPlzRTEf+Tz8CbHfb+A16OcM0p3sH7avK81LGmoL8MtpYUoQegoP+Km1RU
         T8YL139Si74MOTjwU3JyAGAA6wGFRWJSMj12NJFjElOCwqOFmLfx53B00I4QrHKzF589
         sou1WIkASZhK3lrd8iCWKWJHNxDjAAClZyQuaUqSwYl3ZOKJdSlwixjGipNlTGYh1OK/
         Bc5A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1701098972; x=1701703772;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=6AuHxZr8x/Uk1Y12/gMeKhnjQeN0t/qZ6GCe7PtBack=;
        b=HyrrCDjNeWQg7aoCH9RlV2ETJ7MizqCtTfaP/dD13BK3ig+0Z2jZ/yE6evFlNKG3/G
         Jt4kBCalMuUrx5azljIlmXUDiJEC4Wnlxtme6Hu7Rk+rx+UfbrJzfBWZ4DEOI42Ymhig
         winKvqUYHP/voJdlUVTp/4eIjhhopiTgKwNHeOUGAuoA1Qebfb/ZWBOmBfjw+FwZC+ft
         xmXYD7BL8ucF01Q1cBsn0G+NJH5xWrNihvKgDD+bsuisaC0GYXOun83sfZzSpQKLagp5
         9dV05pvLdMG16Po3/8pYzgcmB2milR9aRbxYCne0TOSxvdENKrF58F5ef0tEeqdy/wcc
         hijg==
X-Gm-Message-State: AOJu0YyzRGlS94mNaTDTzeCzZB/Kns1D4qSUoXG0FKJcnL/VEZhfVSOU
	uL/Pm+2QYYHPAQZRUuwae0uuGw==
X-Google-Smtp-Source: AGHT+IEjg8fNoQ7pGDMxE5+HZKEN6r9zGLEH/tW3tKBdtUVnvRcZMMfRiedeZ6EJ8qo8zRPeowbcFw==
X-Received: by 2002:a50:bb63:0:b0:548:55f0:b5f2 with SMTP id y90-20020a50bb63000000b0054855f0b5f2mr8631879ede.6.1701098971847;
        Mon, 27 Nov 2023 07:29:31 -0800 (PST)
Received: from [10.167.154.1] (178235187180.dynamic-4-waw-k-2-3-0.vectranet.pl. [178.235.187.180])
        by smtp.gmail.com with ESMTPSA id e7-20020a056402104700b00542db304680sm5321002edu.63.2023.11.27.07.29.28
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 27 Nov 2023 07:29:31 -0800 (PST)
From: Konrad Dybcio <konrad.dybcio@linaro.org>
Date: Mon, 27 Nov 2023 16:28:52 +0100
Subject: [PATCH v2 12/12] arm64: dts: qcom: qrb2210-rb1: add wifi variant
 property
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20231125-topic-rb1_feat-v2-12-979b28f35e4a@linaro.org>
References: <20231125-topic-rb1_feat-v2-0-979b28f35e4a@linaro.org>
In-Reply-To: <20231125-topic-rb1_feat-v2-0-979b28f35e4a@linaro.org>
To: Rob Clark <robdclark@gmail.com>, 
 Abhinav Kumar <quic_abhinavk@quicinc.com>, 
 Dmitry Baryshkov <dmitry.baryshkov@linaro.org>, Sean Paul <sean@poorly.run>, 
 David Airlie <airlied@gmail.com>, Daniel Vetter <daniel@ffwll.ch>, 
 Maarten Lankhorst <maarten.lankhorst@linux.intel.com>, 
 Maxime Ripard <mripard@kernel.org>, Thomas Zimmermann <tzimmermann@suse.de>, 
 Rob Herring <robh+dt@kernel.org>, 
 Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>, 
 Conor Dooley <conor+dt@kernel.org>, Loic Poulain <loic.poulain@linaro.org>, 
 Bryan O'Donoghue <bryan.odonoghue@linaro.org>, 
 Andy Gross <agross@kernel.org>, Bjorn Andersson <andersson@kernel.org>, 
 Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>, 
 Georgi Djakov <djakov@kernel.org>, Will Deacon <will@kernel.org>, 
 Robin Murphy <robin.murphy@arm.com>, Joerg Roedel <joro@8bytes.org>, 
 Krishna Manikandan <quic_mkrishn@quicinc.com>, 
 Robert Marko <robimarko@gmail.com>, Das Srinagesh <quic_gurus@quicinc.com>, 
 cros-qcom-dts-watchers@chromium.org
Cc: Marijn Suijten <marijn.suijten@somainline.org>, 
 Rob Herring <robh@kernel.org>, linux-arm-msm@vger.kernel.org, 
 dri-devel@lists.freedesktop.org, freedreno@lists.freedesktop.org, 
 devicetree@vger.kernel.org, linux-kernel@vger.kernel.org, 
 linux-pm@vger.kernel.org, linux-arm-kernel@lists.infradead.org, 
 iommu@lists.linux.dev, Konrad Dybcio <konrad.dybcio@linaro.org>
X-Mailer: b4 0.12.2
X-Developer-Signature: v=1; a=ed25519-sha256; t=1701098925; l=1845;
 i=konrad.dybcio@linaro.org; s=20230215; h=from:subject:message-id;
 bh=F+2+KPEjbmpD3TQ3tmcuJpeM3OLd440fgCNNO64cW48=;
 b=bLy6ijre+9R3R+FKK/1GG7JMsEi9kVICNx6m8/ep2irrVHKiERIRYGcphHFdybjbbOBmXg5y7
 ne+m1DehqnJCCueb5BUTJg2eKDJXfBoj0gZYp5ymD7+HN2P2QtRbnl4
X-Developer-Key: i=konrad.dybcio@linaro.org; a=ed25519;
 pk=iclgkYvtl2w05SSXO5EjjSYlhFKsJ+5OSZBjOkQuEms=

From: Dmitry Baryshkov <dmitry.baryshkov@linaro.org>

The RB1 platform doesn't have board-specific board-id programmed, it uses
generic 0xff. Thus add the property with the 'variant' of the
calibration data.

Note: the driver will check for the calibration data for the following
IDs, so existing board-2.bin files will continue to work.

- 'bus=snoc,qmi-board-id=ff,qmi-chip-id=120,variant=Thundercomm_RB1'
- 'bus=snoc,qmi-board-id=ff,qmi-chip-id=120'
- 'bus=snoc,qmi-board-id=ff'

For the reference, the board is identified by the driver in the
following way:

ath10k_snoc c800000.wifi: qmi chip_id 0x120 chip_family 0x4007 board_id 0xff soc_id 0x40670000
ath10k_snoc c800000.wifi: qmi fw_version 0x337302d3 fw_build_timestamp 2023-01-06 01:50 fw_build_id QC_IMAGE_VERSION_STRING=WLAN.HL.3.3.7.c2-00723-QCAHLSWMTPLZ-1
ath10k_snoc c800000.wifi: wcn3990 hw1.0 target 0x00000008 chip_id 0x00000000 sub 0000:0000
ath10k_snoc c800000.wifi: kconfig debug 0 debugfs 0 tracing 0 dfs 0 testmode 0
ath10k_snoc c800000.wifi: firmware ver  api 5 features wowlan,mgmt-tx-by-reference,non-bmi crc32 b3d4b790
ath10k_snoc c800000.wifi: htt-ver 3.114 wmi-op 4 htt-op 3 cal file max-sta 32 raw 0 hwcrypto 1

Signed-off-by: Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
Reviewed-by: Konrad Dybcio <konrad.dybcio@linaro.org>
---
 arch/arm64/boot/dts/qcom/qrb2210-rb1.dts | 1 +
 1 file changed, 1 insertion(+)

diff --git a/arch/arm64/boot/dts/qcom/qrb2210-rb1.dts b/arch/arm64/boot/dts/qcom/qrb2210-rb1.dts
index ac597eb3fe9d..bd7bcf803654 100644
--- a/arch/arm64/boot/dts/qcom/qrb2210-rb1.dts
+++ b/arch/arm64/boot/dts/qcom/qrb2210-rb1.dts
@@ -535,6 +535,7 @@ &wifi {
 	vdd-1.8-xo-supply = <&pm2250_l13>;
 	vdd-1.3-rfa-supply = <&pm2250_l10>;
 	vdd-3.3-ch0-supply = <&pm2250_l22>;
+	qcom,ath10k-calibration-variant = "Thundercomm_RB1";
 	status = "okay";
 };
 

-- 
2.43.0


