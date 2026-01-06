Return-Path: <linux-pm+bounces-40241-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id A06BFCF64A4
	for <lists+linux-pm@lfdr.de>; Tue, 06 Jan 2026 02:32:52 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 14F5C309AC28
	for <lists+linux-pm@lfdr.de>; Tue,  6 Jan 2026 01:31:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 969D23128AD;
	Tue,  6 Jan 2026 01:01:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="iJND170N";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="hI1V/Pcu"
X-Original-To: linux-pm@vger.kernel.org
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9C9BF311C11
	for <linux-pm@vger.kernel.org>; Tue,  6 Jan 2026 01:01:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1767661293; cv=none; b=CZszzTOz83DlvxL1xCvTBZxcbrPGOG/0k6tDB9K62YPYjqnrmzSrUeLXth6F2ZVFbXpliV12L+7Y2W4Xd0kDXjtfdc86zK8z3r+/yvgXnO/s4jOHvUPcuSCWzUfI19lIjKx0YvzYADxXatfklkv2uH036QC63jmiqcn/bKKWnHc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1767661293; c=relaxed/simple;
	bh=vGKw+wEv4m8AuXcSbM8ug5QUp/CDr75AFUCT++yOsvs=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=QQf9tJNutlmqQQVsh/JgWpJn4JSa6Xew4FbxiNYCQyMdXPHmrtyE55GogrfLm2MMMRWOqP+S8OHA2oJ9f4dUhoeSOh3UBpTLsKoJ5eGTYCmbixLVAtuiB4zrJDuCGdWzXdFtLfm0I1rt9d+HbdzWxnhhOVNWfZdhU5ISqklhK+Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=iJND170N; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=hI1V/Pcu; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279873.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 6060njVF1844934
	for <linux-pm@vger.kernel.org>; Tue, 6 Jan 2026 01:01:29 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	toWGAj7SgswRPrjJQFNYvHcUGCLQpi1FqKeAVpzqbvU=; b=iJND170NW1tlBMQB
	HYoxumSS2BP8uillqDNEGwEiprL8Z7jNmZVPJApMFMAswdb9bJ5/1fFbcpSsYXM8
	Bqsy3M6n1ZGBsDyKJvrS9X2Kmt5VPPKKfi/6jeViftU15HfJ0cycqXdrXQHTw2k1
	KtTh5+2/44vamyxPnAyfJXVhEMmZabVmzQeAi1AdKzkHWnBfF3dYwlXbP2E1N3AU
	s3iVAyZUUpAD45jQieYRy+3SX6KdHNLSizY6ULzhaaCxQ3JaFittHSPyC3v762Fa
	PMw+Yj2Km5cWQ2XIReRVz9EZraWD5CGdVvxEnM9FUuEpnOoTj1Y62B/VSv1+WkqB
	AOazbQ==
Received: from mail-qk1-f197.google.com (mail-qk1-f197.google.com [209.85.222.197])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4bg6uub52u-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-pm@vger.kernel.org>; Tue, 06 Jan 2026 01:01:29 +0000 (GMT)
Received: by mail-qk1-f197.google.com with SMTP id af79cd13be357-8bb6a7fea4dso111448085a.0
        for <linux-pm@vger.kernel.org>; Mon, 05 Jan 2026 17:01:29 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1767661289; x=1768266089; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=toWGAj7SgswRPrjJQFNYvHcUGCLQpi1FqKeAVpzqbvU=;
        b=hI1V/Pcuney3KEUzHH7oey1/c2QYHF7gZxDAkxlbGx1Y65vx3UkNHuVzkF2i9ZYUoC
         sCN/hjSh75u0nTWPSkmy5qTBpckqewxP+ExuxQAXfvuLa8MtiRCKCwhTgQUPxHuZukwO
         jh74JYlxJB4X8b3VSdru6t0Z2BE/AZq5FwwNGrb4dM0PnXGSL/9sHzgIFvmFeC9gPcPI
         +5JfNc87uAAjdiEE5KZ5QCEXOpXu8fehQvRte2AXRpsz/Zq6uqj75laZe3cD81Pdv55R
         5VTS3Zh9brl0UR/jUt/pp1DurN0KbLattkza8+EBMKxEeQBC9m7bOOxe51yv/MC9NXEo
         T1AQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1767661289; x=1768266089;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-gg:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=toWGAj7SgswRPrjJQFNYvHcUGCLQpi1FqKeAVpzqbvU=;
        b=iAg/d9BveBYF6CKF1rgpVsPBHgz37nB7LJ7UftxEc00pIWIxoVXjTAMNHTyKtMjJgZ
         RLivMzZaT+DFF/Hmw1tPFJRtlvOxtPeOj8u7BHMfQgvI9QBaWEY+DAtItQVw7OnYJt7Z
         wql/d1aK+FtcfKUSksINspEb+XPmcjTRBQrMZ78ZJFVo0Ln2BnJPd6oZtmW+e7IIq3oV
         wP0utcysL9Ad/T/KSdaGRIhJbKZ8zjAi25hYuWmc8VICczQWl5OSw4goeLLYAB3f7D5U
         Z+CbdKXczgwkNYDl+9SXq/+woeiu5yzEL2MarkxgIlmzeSFLARP6bQbriG+xbaLOpLss
         dLDg==
X-Forwarded-Encrypted: i=1; AJvYcCUx8sSzx1VH6mUJ1JmTBKHhv5fikvEReSQ6HLbgaxmxe+ZShcPpjpY6zZviatmIPSD/g4+nFYTW2g==@vger.kernel.org
X-Gm-Message-State: AOJu0YzT1SEA9fmMoBTWytQZPVkikquQvd8Xo+76vcYvCfqaVSe4J8Kn
	nn6W1rfzhCLPuqUjYkhuyrfeGcwbZdY8dDgcRxsw2wR5IHA1Y+eysElypktHKUBmsRlBnYg9oGU
	oHPZB3C/9MN2xdHG2MdN7lD0jBiXKwVOk4pMuqxN32zNdlXVxOm6bl/ZRW7NWLA==
X-Gm-Gg: AY/fxX6dt/ZQmleumJXsoBG+OMS39rK2VWZrfb/NQ9ZIKuqNuZfvHrwWT6Ilra36pgo
	1DeQT+RAlDsAUB8MGUivmMUsuP3miGf1FonFLayr804sig24+e4FMTx8QvQuEmVNAtY3XDaGbfs
	69gGGErPETxXzFP/HwY1DmqE1l3w5gBoDEx6Y+qD8Cv0mHpxNSDjZofN6ldg6Y4MSPQT/Ag0SfP
	q9tsaauv96HjITgohk9u5ja5bjzjOHh2m+bJoQregvoFtWxOFxWdOwXRkAZQm0HhWr4S1dGptdy
	ANHx4y9GyCJlelGQ4/F0g2anpijedMng5qn8amwxGTep4m4O3Ngq7D2PkEK3o6HHMucDTn8Zkgm
	aRRzJ6BFDZx2xRvZQY1tnylMQJ6qz5WObBTymrYrjoIuVa1yfA+GIcN9K9hFODob+XoocOanlir
	gwK+UcXYRs8n6VZezetTXYuso=
X-Received: by 2002:ac8:7d06:0:b0:4ee:24fc:bea3 with SMTP id d75a77b69052e-4ffa770d84fmr20866291cf.35.1767661288622;
        Mon, 05 Jan 2026 17:01:28 -0800 (PST)
X-Google-Smtp-Source: AGHT+IFGRIkm3qB3iAMhjMsr9K7RBdmhsGoeWiJuR1zZQW9HRAWrshi4AJ0+6RJy7rL89ggSBiDVrw==
X-Received: by 2002:ac8:7d06:0:b0:4ee:24fc:bea3 with SMTP id d75a77b69052e-4ffa770d84fmr20865361cf.35.1767661287983;
        Mon, 05 Jan 2026 17:01:27 -0800 (PST)
Received: from umbar.lan (2001-14ba-a073-af00-264b-feff-fe8b-be8a.rev.dnainternet.fi. [2001:14ba:a073:af00:264b:feff:fe8b:be8a])
        by smtp.gmail.com with ESMTPSA id 2adb3069b0e04-59b65cea8b1sm181082e87.6.2026.01.05.17.01.25
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 05 Jan 2026 17:01:25 -0800 (PST)
From: Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>
Date: Tue, 06 Jan 2026 03:01:14 +0200
Subject: [PATCH v2 04/14] wifi: ath10k: snoc: support powering on the
 device via pwrseq
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260106-wcn3990-pwrctl-v2-4-0386204328be@oss.qualcomm.com>
References: <20260106-wcn3990-pwrctl-v2-0-0386204328be@oss.qualcomm.com>
In-Reply-To: <20260106-wcn3990-pwrctl-v2-0-0386204328be@oss.qualcomm.com>
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
X-Developer-Signature: v=1; a=openpgp-sha256; l=4482;
 i=dmitry.baryshkov@oss.qualcomm.com; h=from:subject:message-id;
 bh=vGKw+wEv4m8AuXcSbM8ug5QUp/CDr75AFUCT++yOsvs=;
 b=owEBbQGS/pANAwAKAYs8ij4CKSjVAcsmYgBpXF7Z98G7nWfKXlYg2gNCIQMwgRzHPZzJbxVnJ
 z1q/ZSkHjaJATMEAAEKAB0WIQRMcISVXLJjVvC4lX+LPIo+Aiko1QUCaVxe2QAKCRCLPIo+Aiko
 1fEZB/4tvPMVzx1O9X5hVg4SC8qKvMxE3IAdsH/tCrsqATAl0+wRT2TyB9Hn7GAeWvGOctHu3iH
 Wz1nzZlcEEGfMaeWu5SwWMpltRfuQ30OmP73iSkLDJIyDkaYgNS18F1gFf+O6ny0yTUySKvTrcD
 yyXDgiHMM2btCQT/nwRoSHoTn9L8puSf+qIsWNnwNXcYhQ//We6KROhs35aw/OlL/hwOSrlP/S/
 5HwYUn/Y4mmzJ5Htk1E8M+w9R1szu/pRNZ3IJKY3GuKUB9KSiWfh873JV70NTtpLblRXY42mIM+
 v4EhUqx2idwTvvn1tfM66om+MAtEwG9gtY9dLCdkm/h9l9Pv
X-Developer-Key: i=dmitry.baryshkov@oss.qualcomm.com; a=openpgp;
 fpr=8F88381DD5C873E4AE487DA5199BF1243632046A
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwMTA2MDAwNyBTYWx0ZWRfX6mHJiHeOLU4Y
 aFaam4KBWRkIomgYleuwkDEbPOJWitczvgWdDqYV0Eov59KJJZhXo5A8OlHJNxwu6gjv8B8Fbe3
 Kw8Cbg7G5XkRvBUXAVeKxNccf548pjrVSoF5qoBm4MM+Z2N+ZukqleUiBFCaQFHbgV0FqN52ToK
 pKvcZ2otH5ftjccMSCyU+E6Pf8b80Nl/NmazHUxXESFq2Y0oLvc4pMtN8UUU06mB2Ag0rpUII1i
 YEw7Fw8/VuMt0QKDfMaKy1d+rczIiSO2QT0rj/iONRkSNtkCq7sSkSfm1gnlOXZTi/QHk3G9mml
 neBotp3uHSxG4umoDcWIQszxtcKKf4oxz+f5FMPHPVs9GQtlaT2eAq+2hujbObSuW7JNbGDsup3
 4QT55Uy1fHxVJld4ns3zBgM37Wbn8tieIkH1zeZn+pNEUZm4+v+sKIvsRjaoxarWO+x0bN99Wl/
 SAG/NkjFbQJvWoUFv/Q==
X-Authority-Analysis: v=2.4 cv=eZ8wvrEH c=1 sm=1 tr=0 ts=695c5ee9 cx=c_pps
 a=50t2pK5VMbmlHzFWWp8p/g==:117 a=xqWC_Br6kY4A:10 a=IkcTkHD0fZMA:10
 a=vUbySO9Y5rIA:10 a=s4-Qcg_JpJYA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=EUspDBNiAAAA:8 a=JZG1H6jYz0umZupwJd8A:9 a=QEXdDO2ut3YA:10
 a=IoWCM6iH3mJn3m4BftBB:22
X-Proofpoint-GUID: 0xxNjYlUtFvrNbWzurVkSGKQ7NSfoc0m
X-Proofpoint-ORIG-GUID: 0xxNjYlUtFvrNbWzurVkSGKQ7NSfoc0m
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.9,FMLib:17.12.100.49
 definitions=2026-01-05_02,2026-01-05_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 malwarescore=0 adultscore=0 phishscore=0 clxscore=1015 impostorscore=0
 suspectscore=0 lowpriorityscore=0 priorityscore=1501 spamscore=0 bulkscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2512120000 definitions=main-2601060007

The WCN39xx family of WiFi/BT chips incorporates a simple PMU, spreading
voltages over internal rails. Implement support for using powersequencer
for this family of ATH10k devices in addition to using regulators.

Reviewed-by: Bartosz Golaszewski <bartosz.golaszewski@oss.qualcomm.com>
Signed-off-by: Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>
---
 drivers/net/wireless/ath/ath10k/snoc.c | 54 ++++++++++++++++++++++++++++++++--
 drivers/net/wireless/ath/ath10k/snoc.h |  2 ++
 2 files changed, 53 insertions(+), 3 deletions(-)

diff --git a/drivers/net/wireless/ath/ath10k/snoc.c b/drivers/net/wireless/ath/ath10k/snoc.c
index b3f6424c17d3..3600c8eb19a3 100644
--- a/drivers/net/wireless/ath/ath10k/snoc.c
+++ b/drivers/net/wireless/ath/ath10k/snoc.c
@@ -11,6 +11,7 @@
 #include <linux/of_device.h>
 #include <linux/platform_device.h>
 #include <linux/property.h>
+#include <linux/pwrseq/consumer.h>
 #include <linux/regulator/consumer.h>
 #include <linux/remoteproc/qcom_rproc.h>
 #include <linux/of_reserved_mem.h>
@@ -1023,9 +1024,15 @@ static int ath10k_hw_power_on(struct ath10k *ar)
 
 	ath10k_dbg(ar, ATH10K_DBG_SNOC, "soc power on\n");
 
+	if (ar_snoc->pwrseq) {
+		ret = pwrseq_power_on(ar_snoc->pwrseq);
+		if (ret)
+			return ret;
+	}
+
 	ret = regulator_bulk_enable(ar_snoc->num_vregs, ar_snoc->vregs);
 	if (ret)
-		return ret;
+		goto pwrseq_off;
 
 	ret = clk_bulk_prepare_enable(ar_snoc->num_clks, ar_snoc->clks);
 	if (ret)
@@ -1035,18 +1042,28 @@ static int ath10k_hw_power_on(struct ath10k *ar)
 
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
@@ -1762,7 +1779,38 @@ static int ath10k_snoc_probe(struct platform_device *pdev)
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
index d4bce1707696..eeaa1c009cb0 100644
--- a/drivers/net/wireless/ath/ath10k/snoc.h
+++ b/drivers/net/wireless/ath/ath10k/snoc.h
@@ -53,6 +53,7 @@ enum ath10k_snoc_flags {
 };
 
 struct clk_bulk_data;
+struct pwrseq_desc;
 struct regulator_bulk_data;
 
 struct ath10k_snoc {
@@ -73,6 +74,7 @@ struct ath10k_snoc {
 	struct ath10k_snoc_ce_irq ce_irqs[CE_COUNT_MAX];
 	struct ath10k_ce ce;
 	struct timer_list rx_post_retry;
+	struct pwrseq_desc *pwrseq;
 	struct regulator_bulk_data *vregs;
 	size_t num_vregs;
 	struct clk_bulk_data *clks;

-- 
2.47.3


