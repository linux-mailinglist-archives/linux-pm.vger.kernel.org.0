Return-Path: <linux-pm+bounces-41131-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [IPv6:2600:3c09:e001:a7::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 23284D3B35B
	for <lists+linux-pm@lfdr.de>; Mon, 19 Jan 2026 18:09:22 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id BCCC8300EE5F
	for <lists+linux-pm@lfdr.de>; Mon, 19 Jan 2026 17:08:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8086232ABEC;
	Mon, 19 Jan 2026 17:08:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="WyeANskO";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="KEVzqgzL"
X-Original-To: linux-pm@vger.kernel.org
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9070B31B800
	for <linux-pm@vger.kernel.org>; Mon, 19 Jan 2026 17:08:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768842491; cv=none; b=KhWzeCh9+RtbIQLIwxlS8pZMiIIAAnFcgf70pb8nnTADRSyDii/DTLdYk5VKZBXnY06Ffwky1MpcHGBNdenlGGJ5bRY0VEDVgNoivmx3IQMneWUN02Zw5pz2pgw9ZvwUecTyrwPFzv/eNHO/DUp2spil5l3/1udcuyJzwDmI9H0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768842491; c=relaxed/simple;
	bh=TngkZuAbDr5UJBjPXFExRZzr3EmJY7tCHVrw/IzceiU=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=k6KcVMIqZuKkd5O2RRCaawUgJGXbri07KaiIfC5Qf2ooqWfaZsUreExMLaH2JzTN3Nx6o2obWff4Zs0JTYuMB3hC/kminka38ScE0ivk/ohgkSMA255QCf5+6bzTmfp3VnA8zjExp3rc6zbc+a29Gb+T1NPMrjdTFJC/Wus7whg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=WyeANskO; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=KEVzqgzL; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279863.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 60JGYZX81044121
	for <linux-pm@vger.kernel.org>; Mon, 19 Jan 2026 17:08:09 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	z+CtHSvBIXD+GWDzkmgHnLc3U/47Ulr6j8JFJ4c1VOM=; b=WyeANskOrzN9I+2i
	7ysU0LR9udeXIWGbRTBitfi7PLzYIecTUx3JChBch+8KHRB4GmVImtKFnw1g8z/F
	JAwNFzJ2j5waNY45gdiBII5pP5zOzF+2oslIXhJzaDqVI9e2o18eLOGAnj/6sosO
	wuQ59XlrO2c1oV2H7v475JNzwdT5IkDXcyolcbVbL7/tZsvwkjzMuX1wRfuHMF47
	KdH7SjpcwJXrWUKarDkqmyhKaej6D3dsdjJcKQdr6Es+B8rlWTwPRFEdgWB6sVyM
	PoPJF3lF0TaUacpkXn806U48Be314BEj+d8sSgGUSUld+psWNVATi4r289XIFm8P
	sh9J2A==
Received: from mail-qk1-f197.google.com (mail-qk1-f197.google.com [209.85.222.197])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4bs79ejvkh-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-pm@vger.kernel.org>; Mon, 19 Jan 2026 17:08:08 +0000 (GMT)
Received: by mail-qk1-f197.google.com with SMTP id af79cd13be357-8c6a341ac9fso777161685a.3
        for <linux-pm@vger.kernel.org>; Mon, 19 Jan 2026 09:08:08 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1768842488; x=1769447288; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=z+CtHSvBIXD+GWDzkmgHnLc3U/47Ulr6j8JFJ4c1VOM=;
        b=KEVzqgzLzGWrqzytyMgtSb/KVF7SjQXUW+wkPQCO6uO9qCKQBXed9g/K650Y/mgPjl
         1oOuJ2IT9f4jetg8smVoUg+JXeuSrAge05EzEM6zM8ITeSCJz9OugB6bk86grHcPlDPk
         t02GB0UObnqbCCTzXXdb836JZm7ICr2VWGtk8dVrCs4QPyVOXLZ2nbYGNvZ4wAJZP57O
         COkhwhPc+de2ZkDtIwPxCmYWUpjzTTnlwHleTXzW+RaxlSjo0Em/xp/fje2XlZGlKh6z
         WqOggOPm12x5LY5MJ6uG+cWvtCzywAvw8tdFzDR39Kboe1uo5jEzpiTBHVbwzsCLtAwY
         O4Bw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1768842488; x=1769447288;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-gg:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=z+CtHSvBIXD+GWDzkmgHnLc3U/47Ulr6j8JFJ4c1VOM=;
        b=kjzIPYdAMPPct+64cbDr8Xd3H5Y3lii+bPxVkNErRwimZnFZqMesHsvH//0qScDeWZ
         Kc4uvIijfhL+taKlQM7HPAWJfyRxUqZpgUDQHvlU7fdmM0Z+cVTBTB1ya1NFtZNcXZQ6
         5z05NGr/qo0g7F3xFY0hkQhzcz3yO+dKinimrWSe5okohlEDox6ejhv9wRB7qTReTurJ
         AMPnI24xTQZSgb2UJ9F9zSU9AjRoCYF2sgaH6QlpYamWX66146iqNU9I3oB1fi2CnMCK
         y4Xb8VsMsGceBIEeeumqb/iucytPiPjFGx9O5oTGUbcn1ku7LI54WLI7EX5ShR+W6Z5v
         SyFg==
X-Forwarded-Encrypted: i=1; AJvYcCV3DxA4rCqZe21x8ak2qO5cGWas4GZN6p2zGElHYiD8d1qmdf4jYTAwfHfRW7JRUsbZLSY/biPXPw==@vger.kernel.org
X-Gm-Message-State: AOJu0YwUM6bCVr6kDuBiNlmVBDCPLR0wPZHpagR11DB+zeOcMyLiSR5T
	UwU1OXUhF71uFXQ55Ch6pljzu0eVCg3tzZm97ztteV661jFgGrX0atFNhKRoHlEWw02uTay7GvU
	BrR/Muhfpvq4dy5Zg/CEvnayg7cxvNI06Y7ms5VCetbMiBsCd1yPl0JybRKu7JA==
X-Gm-Gg: AY/fxX6uR0as6Xw9JSMxS1TeV/lX+/uqeE9mgx0C+ONcWawEoroI1Qb3KcU+1SB09b6
	rR2G3E3O4AxoiKlBluSspRQu58Jihs5O/tima1SAses5f9yq0OPyGkYZbQFwrAvTy6+N9VZ1sBL
	/0apVGCw3ErJXdHj5E2/QYJNlNCbSvaK9gGdpNuZsMQkMuip9DaDzphx2PiWYtIOS0jgggPZkTA
	HUbI2bPP/1IW9t/jj3TK+ubE75aqt9ujW2ZQiVPeekJuFcatTIZvuDI165UUqMb0pgnDWOzUpq7
	Q+zmLfsfzXm0Q/rAnUENAGMR9kjQXps7PeUC9Mn3yNDx8t2VcbLs49lpsMxJxo/zTGSSMDBotEK
	dw78wXMJxSNMBsZCALOsZ6TezBbLqX3dvv83yiMhNgCNPcNriCztufJaDr3TCjNeIh57pi+hx/1
	3UwSKyKbN18MXOEddT6i0IIPE=
X-Received: by 2002:a05:620a:1911:b0:8c5:2032:3766 with SMTP id af79cd13be357-8c6a67099a9mr1629399685a.35.1768842487639;
        Mon, 19 Jan 2026 09:08:07 -0800 (PST)
X-Received: by 2002:a05:620a:1911:b0:8c5:2032:3766 with SMTP id af79cd13be357-8c6a67099a9mr1629394585a.35.1768842487011;
        Mon, 19 Jan 2026 09:08:07 -0800 (PST)
Received: from umbar.lan (2001-14ba-a073-af00-264b-feff-fe8b-be8a.rev.dnainternet.fi. [2001:14ba:a073:af00:264b:feff:fe8b:be8a])
        by smtp.gmail.com with ESMTPSA id 38308e7fff4ca-38384e790a9sm32661211fa.26.2026.01.19.09.08.04
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 19 Jan 2026 09:08:04 -0800 (PST)
From: Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>
Date: Mon, 19 Jan 2026 19:07:57 +0200
Subject: [PATCH v3 3/8] wifi: ath10k: snoc: support powering on the device
 via pwrseq
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260119-wcn3990-pwrctl-v3-3-948df19f5ec2@oss.qualcomm.com>
References: <20260119-wcn3990-pwrctl-v3-0-948df19f5ec2@oss.qualcomm.com>
In-Reply-To: <20260119-wcn3990-pwrctl-v3-0-948df19f5ec2@oss.qualcomm.com>
To: Liam Girdwood <lgirdwood@gmail.com>, Mark Brown <broonie@kernel.org>,
        Rob Herring <robh@kernel.org>,
        Krzysztof Kozlowski <krzk+dt@kernel.org>,
        Conor Dooley <conor+dt@kernel.org>,
        Bartosz Golaszewski <brgl@kernel.org>,
        Marcel Holtmann <marcel@holtmann.org>,
        Luiz Augusto von Dentz <luiz.dentz@gmail.com>,
        Jeff Johnson <jjohnson@kernel.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Konrad Dybcio <konradybcio@kernel.org>,
        Manivannan Sadhasivam <mani@kernel.org>, Vinod Koul <vkoul@kernel.org>,
        Balakrishna Godavarthi <quic_bgodavar@quicinc.com>,
        Matthias Kaehlcke <mka@chromium.org>
Cc: linux-arm-msm@vger.kernel.org, linux-kernel@vger.kernel.org,
        devicetree@vger.kernel.org, linux-bluetooth@vger.kernel.org,
        linux-wireless@vger.kernel.org, ath10k@lists.infradead.org,
        linux-pm@vger.kernel.org, Krzysztof Kozlowski <krzk@kernel.org>,
        Bartosz Golaszewski <bartosz.golaszewski@oss.qualcomm.com>
X-Mailer: b4 0.14.3
X-Developer-Signature: v=1; a=openpgp-sha256; l=4976;
 i=dmitry.baryshkov@oss.qualcomm.com; h=from:subject:message-id;
 bh=TngkZuAbDr5UJBjPXFExRZzr3EmJY7tCHVrw/IzceiU=;
 b=owEBbQGS/pANAwAKAYs8ij4CKSjVAcsmYgBpbmTtAas0TfVBZ0zgaGJXwyQrA0uQ6KpWcbxdI
 h2osmaT/XeJATMEAAEKAB0WIQRMcISVXLJjVvC4lX+LPIo+Aiko1QUCaW5k7QAKCRCLPIo+Aiko
 1ebQB/4o64wgCHd8jSj7Bz3CZ/+62x6a30IZawuIkYO3PivfZEHDbHoczj5oViXOUvo0FK9gpY+
 hykUvnNIU6bNL0iGUB4dDT+U3ZSIsqeNWAy9y3unwzTnNE1liGuOIlDPe2YMe3XPOPjJA8anID5
 JiLUCh+Vh7aQqH2I3JX7iezuUVscpFtGpDkQlxw9c5WofpRfrOFXlcITsLdaLimxyuGFOJC0W+3
 PAhC+dCvGuwkyD3zWsELpogZHWBhSlYHrwMgna5IoUK6nvyudXybtW7Q5/AgckAfHeYTCKpgLdM
 Cnvy2tBNGwS0HxWSaYMQSJbvTeW6EaFkBCb4KOnpwGwGh1XV
X-Developer-Key: i=dmitry.baryshkov@oss.qualcomm.com; a=openpgp;
 fpr=8F88381DD5C873E4AE487DA5199BF1243632046A
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwMTE5MDE0MyBTYWx0ZWRfX1MxkVvdw3aUw
 Ph9A0dHXc9AsM58CZLKZvfKz/xebzBzKBLuFKACrZswLsCZiGN2W6V0K7+L2MJs4JGHJjch5vmu
 MprK2UliYpxPKZ/UXtbLWUhIm3x1ZjUJMHwR3ttUUNjvqL0qyICa+Yd3V4kjr6Nm26xa/HG7fe1
 QNTxV0Brnczeaw/kzAHXfYwCJMSuloMqoV+3RJkMvlEGR0gZ/kvo5a5hBSPPSGyATy/gPtE0M53
 pmAgHyWrfMUKdRTSnCAw5jzr31pHPCeXygeFSTReMtOhUHlR7Yqa/2Rs+/bsHLw8xnvIOCxA5gs
 dVA06uq+XegNPgqiN+1ddBaGOqsddJ2drhM7F+WTLTV9YulN7zfaPm0/kA9UBntJXZ2IYRZTKlK
 0ueXFTA3aafyvbW1azYvyL6wYG29fVjJTVIwwYXwWs6TAcH0hfBqlPXUkynNtKIJIcEM7rwmulG
 eqZyuYSdU1SYNJ/G51Q==
X-Authority-Analysis: v=2.4 cv=NY3rFmD4 c=1 sm=1 tr=0 ts=696e64f8 cx=c_pps
 a=50t2pK5VMbmlHzFWWp8p/g==:117 a=xqWC_Br6kY4A:10 a=IkcTkHD0fZMA:10
 a=vUbySO9Y5rIA:10 a=s4-Qcg_JpJYA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=EUspDBNiAAAA:8 a=s7CvTC462Z5CboN7hzoA:9 a=QEXdDO2ut3YA:10
 a=IoWCM6iH3mJn3m4BftBB:22
X-Proofpoint-ORIG-GUID: U3ua8_GOqpvXizdybh0FyVdFYw7aUMU6
X-Proofpoint-GUID: U3ua8_GOqpvXizdybh0FyVdFYw7aUMU6
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.9,FMLib:17.12.100.49
 definitions=2026-01-19_04,2026-01-19_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 priorityscore=1501 malwarescore=0 impostorscore=0 suspectscore=0
 lowpriorityscore=0 adultscore=0 phishscore=0 bulkscore=0 clxscore=1015
 spamscore=0 classifier=typeunknown authscore=0 authtc= authcc= route=outbound
 adjust=0 reason=mlx scancount=1 engine=8.22.0-2601150000
 definitions=main-2601190143

The WCN39xx family of WiFi/BT chips incorporates a simple PMU, spreading
voltages over internal rails. Implement support for using powersequencer
for this family of ATH10k devices in addition to using regulators.

Reviewed-by: Bartosz Golaszewski <bartosz.golaszewski@oss.qualcomm.com>
Signed-off-by: Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>
---
 drivers/net/wireless/ath/ath10k/snoc.c | 53 ++++++++++++++++++++++++++++++++--
 drivers/net/wireless/ath/ath10k/snoc.h |  3 ++
 2 files changed, 53 insertions(+), 3 deletions(-)

diff --git a/drivers/net/wireless/ath/ath10k/snoc.c b/drivers/net/wireless/ath/ath10k/snoc.c
index b3f6424c17d3..f72f236fb9eb 100644
--- a/drivers/net/wireless/ath/ath10k/snoc.c
+++ b/drivers/net/wireless/ath/ath10k/snoc.c
@@ -1,6 +1,7 @@
 // SPDX-License-Identifier: ISC
 /*
  * Copyright (c) 2018 The Linux Foundation. All rights reserved.
+ * Copyright (c) Qualcomm Technologies, Inc. and/or its subsidiaries.
  */
 
 #include <linux/bits.h>
@@ -11,6 +12,7 @@
 #include <linux/of_device.h>
 #include <linux/platform_device.h>
 #include <linux/property.h>
+#include <linux/pwrseq/consumer.h>
 #include <linux/regulator/consumer.h>
 #include <linux/remoteproc/qcom_rproc.h>
 #include <linux/of_reserved_mem.h>
@@ -1023,10 +1025,14 @@ static int ath10k_hw_power_on(struct ath10k *ar)
 
 	ath10k_dbg(ar, ATH10K_DBG_SNOC, "soc power on\n");
 
-	ret = regulator_bulk_enable(ar_snoc->num_vregs, ar_snoc->vregs);
+	ret = pwrseq_power_on(ar_snoc->pwrseq);
 	if (ret)
 		return ret;
 
+	ret = regulator_bulk_enable(ar_snoc->num_vregs, ar_snoc->vregs);
+	if (ret)
+		goto pwrseq_off;
+
 	ret = clk_bulk_prepare_enable(ar_snoc->num_clks, ar_snoc->clks);
 	if (ret)
 		goto vreg_off;
@@ -1035,18 +1041,28 @@ static int ath10k_hw_power_on(struct ath10k *ar)
 
 vreg_off:
 	regulator_bulk_disable(ar_snoc->num_vregs, ar_snoc->vregs);
+pwrseq_off:
+	pwrseq_power_off(ar_snoc->pwrseq);
+
 	return ret;
 }
 
 static int ath10k_hw_power_off(struct ath10k *ar)
 {
 	struct ath10k_snoc *ar_snoc = ath10k_snoc_priv(ar);
+	int ret_seq = 0;
+	int ret_vreg;
 
 	ath10k_dbg(ar, ATH10K_DBG_SNOC, "soc power off\n");
 
 	clk_bulk_disable_unprepare(ar_snoc->num_clks, ar_snoc->clks);
 
-	return regulator_bulk_disable(ar_snoc->num_vregs, ar_snoc->vregs);
+	ret_vreg = regulator_bulk_disable(ar_snoc->num_vregs, ar_snoc->vregs);
+
+	if (ar_snoc->pwrseq)
+		ret_seq = pwrseq_power_off(ar_snoc->pwrseq);
+
+	return ret_vreg ? : ret_seq;
 }
 
 static void ath10k_snoc_wlan_disable(struct ath10k *ar)
@@ -1762,7 +1778,38 @@ static int ath10k_snoc_probe(struct platform_device *pdev)
 		goto err_release_resource;
 	}
 
-	ar_snoc->num_vregs = ARRAY_SIZE(ath10k_regulators);
+	/*
+	 * devm_pwrseq_get() can return -EPROBE_DEFER in two cases:
+	 * - it is not supposed to be used
+	 * - it is supposed to be used, but the driver hasn't probed yet.
+	 *
+	 * There is no simple way to distinguish between these two cases, but:
+	 * - if it is not supposed to be used, then regulator_bulk_get() will
+	 *   return all regulators as expected, continuing the probe
+	 * - if it is supposed to be used, but wasn't probed yet, we will get
+	 *   -EPROBE_DEFER from regulator_bulk_get() too.
+	 *
+	 * For backwards compatibility with DTs specifying regulators directly
+	 * rather than using the PMU device, ignore the defer error from
+	 * pwrseq.
+	 */
+	ar_snoc->pwrseq = devm_pwrseq_get(&pdev->dev, "wlan");
+	if (IS_ERR(ar_snoc->pwrseq)) {
+		ret = PTR_ERR(ar_snoc->pwrseq);
+		ar_snoc->pwrseq = NULL;
+		if (ret != -EPROBE_DEFER)
+			goto err_free_irq;
+
+		ar_snoc->num_vregs = ARRAY_SIZE(ath10k_regulators);
+	} else {
+		/*
+		 * The first regulator (vdd-0.8-cx-mx) is used to power on part
+		 * of the SoC rather than the PMU on WCN399x, the rest are
+		 * handled via pwrseq.
+		 */
+		ar_snoc->num_vregs = 1;
+	}
+
 	ar_snoc->vregs = devm_kcalloc(&pdev->dev, ar_snoc->num_vregs,
 				      sizeof(*ar_snoc->vregs), GFP_KERNEL);
 	if (!ar_snoc->vregs) {
diff --git a/drivers/net/wireless/ath/ath10k/snoc.h b/drivers/net/wireless/ath/ath10k/snoc.h
index d4bce1707696..1ecae34687c2 100644
--- a/drivers/net/wireless/ath/ath10k/snoc.h
+++ b/drivers/net/wireless/ath/ath10k/snoc.h
@@ -1,6 +1,7 @@
 /* SPDX-License-Identifier: ISC */
 /*
  * Copyright (c) 2018 The Linux Foundation. All rights reserved.
+ * Copyright (c) Qualcomm Technologies, Inc. and/or its subsidiaries.
  */
 
 #ifndef _SNOC_H_
@@ -53,6 +54,7 @@ enum ath10k_snoc_flags {
 };
 
 struct clk_bulk_data;
+struct pwrseq_desc;
 struct regulator_bulk_data;
 
 struct ath10k_snoc {
@@ -73,6 +75,7 @@ struct ath10k_snoc {
 	struct ath10k_snoc_ce_irq ce_irqs[CE_COUNT_MAX];
 	struct ath10k_ce ce;
 	struct timer_list rx_post_retry;
+	struct pwrseq_desc *pwrseq;
 	struct regulator_bulk_data *vregs;
 	size_t num_vregs;
 	struct clk_bulk_data *clks;

-- 
2.47.3


