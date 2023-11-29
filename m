Return-Path: <linux-pm+bounces-506-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C6B177FDA2D
	for <lists+linux-pm@lfdr.de>; Wed, 29 Nov 2023 15:45:12 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 8179F2832A9
	for <lists+linux-pm@lfdr.de>; Wed, 29 Nov 2023 14:45:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 040B132C82;
	Wed, 29 Nov 2023 14:45:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="Ah8Y1Wuk"
X-Original-To: linux-pm@vger.kernel.org
Received: from mail-lf1-x130.google.com (mail-lf1-x130.google.com [IPv6:2a00:1450:4864:20::130])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 38CDA1BFD
	for <linux-pm@vger.kernel.org>; Wed, 29 Nov 2023 06:44:51 -0800 (PST)
Received: by mail-lf1-x130.google.com with SMTP id 2adb3069b0e04-50bc21821a1so1858988e87.0
        for <linux-pm@vger.kernel.org>; Wed, 29 Nov 2023 06:44:50 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1701269089; x=1701873889; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=x8Ud0RYAeHgIKaviw6GV2Mnmt4ajtcz1/Tj2KEhmPX4=;
        b=Ah8Y1Wukt/LycFNroLV/nSYq+WvN66ryyBa7JSL8iNXt02Tur415zCsyU4+f48ouMf
         HkgZehfp5uh3TmbqHcNFlCmYVlDjSF8cn4A0nIC5pzFeLL+WxLXaGy4B9dz/lHqrn5lx
         pbI/Mw6bPTKwsHwmepeVKg//IzRZi1cIRXZZImVTinxPC4LZUgGYoe0zO72lgkvgfwp6
         Cg7/Tg4MApQiQRx+p+OR+IsHcltGzn55+5zq83ljCABioSgItAHIKSyWMI37151+5GZu
         O/68DJ3dLspF2YwmheQmXW+bGs2lCfTVg7TiEt9KTmcRZVCLDBllz1Dp/xJwvh0yfbel
         9f0w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1701269089; x=1701873889;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=x8Ud0RYAeHgIKaviw6GV2Mnmt4ajtcz1/Tj2KEhmPX4=;
        b=UwUqH0nhRIH664uf6TpUUEZTU4bFZf5+tUUPNvLdPkTTjedYyKtCy5s61V/h6+MMyZ
         KxvTQ46b8FP9eQP91xi5UI6Hz5oDVDshNHMk9d46TtT/buNj1Xhgv0XjV7eq0W5ipsnr
         eUL+NI3Ti6rvlpM9WVB+/7AgMtTwnEd/tyabkRR4vTDcsPnAsw6+PNOqhkhRLo+/EH9P
         vuKlA2ohdJKxsJ8Ipl2uuKP9FeYxqZljo1GjYzmO1l3H3i3IDcgqmxY/SSA+KbjPdtPs
         C1ANXOozw+Wad4/jpVeG/dwhKJ5SrlJ1Qu+ybvk2zVcQi36/lpA66C9Cnsc+sPFtSqby
         gVNg==
X-Gm-Message-State: AOJu0YxuA1EanDQHdDMX/nNssGuslFXtC9iMcJt7siHoWMk2tJDbwcrf
	8cMrv6664JZo+jf/G5xULXL44A==
X-Google-Smtp-Source: AGHT+IEucXvhP6CZlLyjmhm2eErpw/rjkI+AVAy2NrjVrl9sMS9FNrRYfvXWv/KyNqVzhsUfV8Y3cw==
X-Received: by 2002:a05:6512:11eb:b0:50a:a6b4:de4f with SMTP id p11-20020a05651211eb00b0050aa6b4de4fmr10377057lfs.36.1701269089155;
        Wed, 29 Nov 2023 06:44:49 -0800 (PST)
Received: from [10.167.154.1] (178235187166.dynamic-4-waw-k-2-3-0.vectranet.pl. [178.235.187.166])
        by smtp.gmail.com with ESMTPSA id e27-20020a1709062c1b00b009fda627abd9sm7913738ejh.79.2023.11.29.06.44.45
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 29 Nov 2023 06:44:48 -0800 (PST)
From: Konrad Dybcio <konrad.dybcio@linaro.org>
Date: Wed, 29 Nov 2023 15:44:09 +0100
Subject: [PATCH v3 12/12] arm64: dts: qcom: qrb2210-rb1: add wifi variant
 property
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20231125-topic-rb1_feat-v3-12-4cbb567743bb@linaro.org>
References: <20231125-topic-rb1_feat-v3-0-4cbb567743bb@linaro.org>
In-Reply-To: <20231125-topic-rb1_feat-v3-0-4cbb567743bb@linaro.org>
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
X-Developer-Signature: v=1; a=ed25519-sha256; t=1701269042; l=1902;
 i=konrad.dybcio@linaro.org; s=20230215; h=from:subject:message-id;
 bh=1sgurZzJDT6Mn40jAYTNDegr3ChD6TId8sRBg0GBQe8=;
 b=cvzdQPMDO1F9MJyUcHFhovdEgAZaKe0knG3gwp2ASXtsecxDnq1fzPtkf1NxnntN9lGnvr+4o
 HRe4f+YzatxCdTcA3W9nOqNu8vqMZKGisf58bgSH/Wc7Zvb5uMJJ/lr
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
Signed-off-by: Konrad Dybcio <konrad.dybcio@linaro.org>
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


