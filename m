Return-Path: <linux-pm+bounces-40063-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id 266FACEAE04
	for <lists+linux-pm@lfdr.de>; Wed, 31 Dec 2025 00:36:41 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 28FB33015026
	for <lists+linux-pm@lfdr.de>; Tue, 30 Dec 2025 23:36:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0024F2FCBE5;
	Tue, 30 Dec 2025 23:36:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="RGv1zx62";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="JA1u50St"
X-Original-To: linux-pm@vger.kernel.org
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 35D272E06D2
	for <linux-pm@vger.kernel.org>; Tue, 30 Dec 2025 23:36:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1767137779; cv=none; b=qTUzlcdKtBukVQkJmAmGJTSLg6lc1JArlpzqsgITi/dWkkSA8KH7g+H0fzra0+Vb6ggKCqVQ/I4YkeinEGZv9K2IXtuhfJdjJ0IHA8FOVffg7Q6GL40gzjAsRjBfB0IGv9Q6+tlG4C8JcIfGRFuI0bMgh8JnnUgLr+QejyNEgso=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1767137779; c=relaxed/simple;
	bh=jfQ+/qPGweFSmUYX5ResG9wJ7q+g2knAiJRbFI0KjZs=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=ZYN6u35940+XF7SQ+VcrEt2CGFDrGDL+mh5O96+M2eiEr17hm1KynHM5xB8n7ebdmzTExYz3lw8ak9Cyqfoi64V1QU/oVcyOMNlrtRcSpnZF/2rI0ztyK5mBsIfirXwvxHqNriOKgBvCPc7ZeMrE77dXJqiqfBUWt1e5KXWqmLo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=RGv1zx62; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=JA1u50St; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279873.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 5BU9umOa1751668
	for <linux-pm@vger.kernel.org>; Tue, 30 Dec 2025 23:36:09 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	2VC9sljONxXySxZ5faFBLsjMd99t8lT05SJh169vrPI=; b=RGv1zx62vhDXAxbK
	HyZp6ZQ/yYusA2BBaz1JYdIYGN6G02a/zx5BDhtpC7mwOoHflT6KB8ZKAbHXsmAe
	MuecGDOOs/aUlA82l8mL7tle68UiZcDenQMyY1H+fz+nJaEeh7RDLaJbKS2ez2Ix
	LtwBpYuMyTS53fyODFn0jU8R5gaqZWG1YfMKO3UYHj6JBHkpa3tD4Sk4z+LMCeiD
	QEVVDbPMZCHj2MkTLn7vC7FQ0zkqxeYMwGL0qnondUw32tJaDkxfVjuET/95FePK
	h6ff/z1CSIFoirlhj7mkDVEjTlSAcyrl/pCy55KAYY/NWQphD4x/OO1IUrF3Ry9V
	sMNwzA==
Received: from mail-qv1-f72.google.com (mail-qv1-f72.google.com [209.85.219.72])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4bc0sgu2au-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-pm@vger.kernel.org>; Tue, 30 Dec 2025 23:36:09 +0000 (GMT)
Received: by mail-qv1-f72.google.com with SMTP id 6a1803df08f44-88a3356a310so290014396d6.3
        for <linux-pm@vger.kernel.org>; Tue, 30 Dec 2025 15:36:09 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1767137769; x=1767742569; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=2VC9sljONxXySxZ5faFBLsjMd99t8lT05SJh169vrPI=;
        b=JA1u50StNnXpmHmEEjZUg5RcF16ogq3Fo6xcwiHiH4h74DFDvEcWivdgIEHau8NIcl
         d7rSbUYRrQZPWdgk78J7P+w5xQM7g80EG6379MXiz/r/SKwVukg8edidax7zaqmsIBgk
         g+2hE5ve9ut1J6cG2iNhUSjktKuvheCUZ4PvGZoVcKlCMIDC5NFBdq8coXav6DLs5LtO
         vF6NJIzejyHc3SfwamEWKBeAozboX3xDcrYLQpTbCfPgGqBSsrGVVKrG3DEefi8ol5th
         onD9vN1O/qOMcG0Xf6Y6mLobbbd3ADrgpEtk/w7I9qOQbhyfPqg+t8LE8OBPrALKnjKk
         OF2w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1767137769; x=1767742569;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-gg:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=2VC9sljONxXySxZ5faFBLsjMd99t8lT05SJh169vrPI=;
        b=gJ0I5ZLN3PUsxefpqiON3ctafQV6vsCsgs17k1hjcrUWaGLHjc2N5/Jg2BHaKY7ZYL
         E7hViHItTaXKAVOJTSj3ZVC64pPKXWZvrcNhlMjt5sE3ynQ40XsGZlq/TLpGdjO0bMQk
         VlR82A32Wc6PSFLgOr+hBAzJMT3wq8jXS0svg8bsu/e2/suxmTSywWjA/l3SIfcxBrh6
         JartboLJVCzWkLIWO3GvIbZtLBDZr0h0qnEdDDv5+ys90mu9KtBvfNOlqvqlC0TVu8Es
         6f4BQqYQT9kiSQz8DKwzTk4GOvWc+5J9NQARnM1+x+3989bEzRlwN6AvSkFMoMQ6UQ0C
         Dnpg==
X-Forwarded-Encrypted: i=1; AJvYcCVutUoyxV4GFueXo159pKp1xyjJJbYV2UnFj/KO949KCzp/o3W04rN6Lna7ZjJtOaWn4dlBma0+4A==@vger.kernel.org
X-Gm-Message-State: AOJu0YxQhQoImYqCHHRBHRCVb2DGB/e387+mB4h2DOjPIejOrvWGu3AE
	C32vVArITwvCNwpJw2bcCLs0acAWcW4i/C6aMA2ioXxb+fh7Ox1JBnHCkrrKtgLBAbGJZ9jN/kg
	oI+9aX4VC8byqBLEQM0p5NAXzRiLqF2pvPwuJj/bfAl0f2SonwabhJh4eCBcdsg==
X-Gm-Gg: AY/fxX6rfXgH3G2oyOa5YwSsWlus7UfGMEWuqqQ1eBIren0mbcN0SxPjZefzLrtZbOB
	G/hRYs2gc8+RxPsItCTxWdrdPYhb95LgH19ljYIrnhPjs9KjvSvMem/HYG51xWv9w8y5nTERTVj
	6OXRasKpTlU1Rp4IbcXWzzKZ0vpkyNKzuaGGo5509QJ3fvkMtuPQEHCv1E+y0rAq8DlzB5+9K8Y
	DR3X1RmEYrWim7x7sJrI1R4esUP8cfqWbWWmpg34rGw4+X4jnXCKrb1nKXTaVJbXEOoV+NSj3mY
	VzLJ1GjSNpN/hmZsCVYIKk01s6i7jRqs/Jj1/bybvfgF8mA2snnN0AOvCRtQKlAMHkpcqfNzqUB
	PeJHiVK9h3RmLc8RlG17U//rASN3e7Os3dmVFTgts0LitQvIWhfcu2a2LbS/Xr0baPA7vYHztjt
	cfhQ0hiMVczmxzKlAaPFkoxr0=
X-Received: by 2002:a05:622a:7506:b0:4f4:ee07:91b9 with SMTP id d75a77b69052e-4f4ee07921emr180398011cf.47.1767137768817;
        Tue, 30 Dec 2025 15:36:08 -0800 (PST)
X-Google-Smtp-Source: AGHT+IFlBVfMEzLDzQI3LEOKbITeufy2b4hcGo237iBWEci59bAC4PLtF8ByBtf6K2+ozbQJPRmFew==
X-Received: by 2002:a05:622a:7506:b0:4f4:ee07:91b9 with SMTP id d75a77b69052e-4f4ee07921emr180397771cf.47.1767137768382;
        Tue, 30 Dec 2025 15:36:08 -0800 (PST)
Received: from umbar.lan (2001-14ba-a073-af00-264b-feff-fe8b-be8a.rev.dnainternet.fi. [2001:14ba:a073:af00:264b:feff:fe8b:be8a])
        by smtp.gmail.com with ESMTPSA id 2adb3069b0e04-59a18620337sm10349574e87.86.2025.12.30.15.36.07
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 30 Dec 2025 15:36:07 -0800 (PST)
From: Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>
Date: Wed, 31 Dec 2025 01:35:51 +0200
Subject: [PATCH 01/14] regulator: dt-bindings: qcom,qca6390-pmu: describe
 PMUs on WCN39xx
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20251231-wcn3990-pwrctl-v1-1-1ff4d6028ad5@oss.qualcomm.com>
References: <20251231-wcn3990-pwrctl-v1-0-1ff4d6028ad5@oss.qualcomm.com>
In-Reply-To: <20251231-wcn3990-pwrctl-v1-0-1ff4d6028ad5@oss.qualcomm.com>
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
        linux-pm@vger.kernel.org, Krzysztof Kozlowski <krzk@kernel.org>
X-Mailer: b4 0.14.3
X-Developer-Signature: v=1; a=openpgp-sha256; l=2272;
 i=dmitry.baryshkov@oss.qualcomm.com; h=from:subject:message-id;
 bh=jfQ+/qPGweFSmUYX5ResG9wJ7q+g2knAiJRbFI0KjZs=;
 b=owEBbQGS/pANAwAKAYs8ij4CKSjVAcsmYgBpVGHj1fMH3UB6gpXfhbLP8H2wwG2BrpPCWb2KN
 W14PxzmW4KJATMEAAEKAB0WIQRMcISVXLJjVvC4lX+LPIo+Aiko1QUCaVRh4wAKCRCLPIo+Aiko
 1aS6B/0WaxFzceLPR9rYkNcOBfiwsm3KXXTCqJFMZCoo7hzgtl31MTKK1YmnJmrglbnTplPzDaq
 Pyu0OtP8hln83ySBB0iANbOdhH/AgCV0aO1b+W1sp5lBpmrylJ6Oh8ruEnJen0A/eTE1NIDDPBH
 hISbmUKX7ppK83kFZFin4NwSrcY3w0WXP37WsgQsh585d77vqaYfjmXOwuX5Lf2gUSThmG3hPRa
 fey+VdGjt/g1yKHvVHt4Q2gfJ2dwTE8eSyTDuER8B8tNqyGkMMwaqf1JDVOVJBzUqXDKDVNNtGC
 IiakNaP++kNmYQifz0jHznau96e65Bq4orSg7400+Knic4Z2
X-Developer-Key: i=dmitry.baryshkov@oss.qualcomm.com; a=openpgp;
 fpr=8F88381DD5C873E4AE487DA5199BF1243632046A
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUxMjMwMDIxMSBTYWx0ZWRfX6r7RRUX/g/2o
 kRGUiO58tVn2w7qtFs6BEPIGV1aKsZ8qhHNB9AvweRKVjszRvUMmSJyKubyXPXp+OTXxDtJ1F9Z
 6nofOUWrlEXJ67dWL/HpdcfHZaojMmrRwR0nIrv3dfKCxKRqdM4/47Qu8XXdC91iVGel6Zk6hBo
 ntHKZ92xvUqvViOoBdP97iz+NMqMi8y6Z5hhS9GeY6v6B9yTcf1f25ipI3vMYwMi29WfroHS6M2
 MJg2rRWQEjGQJQvl4rICgqQU/wuBz+HD3iTIkren4CNCmu0bgMyyT3S6TDaj4fMXIGcwXinHwLx
 avETz6D4KhYoZ1XjQ4WglMFTCqyAdvaoAA2aKlP2+Kw6jDNXKuYRAwPwLI4Opd2tz2Je8qqBt98
 7zQI0b2/VCA3q6QIGSRwHpuXWBbp2pdDqZoGLL50U0fl8jzk9ypAqYPDdd7feZ9v1TOUblbuJZ1
 SvGdjAbK4U/FuhfDKbw==
X-Proofpoint-GUID: V9gZsVDRAqfk9re_gmtGEq_ZMaNF85ft
X-Proofpoint-ORIG-GUID: V9gZsVDRAqfk9re_gmtGEq_ZMaNF85ft
X-Authority-Analysis: v=2.4 cv=foHRpV4f c=1 sm=1 tr=0 ts=695461e9 cx=c_pps
 a=7E5Bxpl4vBhpaufnMqZlrw==:117 a=xqWC_Br6kY4A:10 a=IkcTkHD0fZMA:10
 a=wP3pNCr1ah4A:10 a=s4-Qcg_JpJYA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=EUspDBNiAAAA:8 a=FaKla9bQ5TyOH8GUl7IA:9 a=QEXdDO2ut3YA:10
 a=pJ04lnu7RYOZP9TFuWaZ:22
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.9,FMLib:17.12.100.49
 definitions=2025-12-30_04,2025-12-30_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 adultscore=0 clxscore=1015 malwarescore=0 suspectscore=0 phishscore=0
 impostorscore=0 bulkscore=0 lowpriorityscore=0 priorityscore=1501 spamscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2512120000 definitions=main-2512300211

WCN3990 and other similar WiFi/BT chips incorporate a simple on-chip PMU
(clearly described as such in the documentation). Extend DT schema
covering other Qualcomm WiFi/BT chips to cover these devices too.

Signed-off-by: Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>
---
 .../bindings/regulator/qcom,qca6390-pmu.yaml       | 36 ++++++++++++++++++++++
 1 file changed, 36 insertions(+)

diff --git a/Documentation/devicetree/bindings/regulator/qcom,qca6390-pmu.yaml b/Documentation/devicetree/bindings/regulator/qcom,qca6390-pmu.yaml
index 47c425c9fff1..dc88523f46f8 100644
--- a/Documentation/devicetree/bindings/regulator/qcom,qca6390-pmu.yaml
+++ b/Documentation/devicetree/bindings/regulator/qcom,qca6390-pmu.yaml
@@ -18,6 +18,11 @@ properties:
   compatible:
     enum:
       - qcom,qca6390-pmu
+      - qcom,wcn3950-pmu
+      - qcom,wcn3988-pmu
+      - qcom,wcn3990-pmu
+      - qcom,wcn3991-pmu
+      - qcom,wcn3998-pmu
       - qcom,wcn6750-pmu
       - qcom,wcn6855-pmu
       - qcom,wcn7850-pmu
@@ -76,9 +81,18 @@ properties:
   vddpcie1p9-supply:
     description: VDD_PCIE_1P9 supply regulator handle
 
+  vddch0-supply:
+    description: chain 0 supply regulator handle
+
+  vddch1-supply:
+    description: chain 1 supply regulator handle
+
   vddio-supply:
     description: VDD_IO supply regulator handle
 
+  vddxo-supply:
+    description: VDD_XTAL supply regulator handle
+
   wlan-enable-gpios:
     maxItems: 1
     description: GPIO line enabling the ATH11K WLAN module supplied by the PMU
@@ -132,6 +146,28 @@ allOf:
         - vddpcie1p3-supply
         - vddpcie1p9-supply
         - vddio-supply
+
+  - if:
+      properties:
+        compatible:
+          contains:
+            enum:
+              - qcom,wcn3950-pmu
+              - qcom,wcn3988-pmu
+              - qcom,wcn3990-pmu
+              - qcom,wcn3991-pmu
+              - qcom,wcn3998-pmu
+    then:
+      properties:
+        wlan-enable-gpios: false
+        bt-enable-gpios: false
+      required:
+        - vddio-supply
+        - vddxo-supply
+        - vddrfa1p3-supply
+        - vddch0-supply
+        - vddch1-supply
+
   - if:
       properties:
         compatible:

-- 
2.47.3


