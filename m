Return-Path: <linux-pm+bounces-40067-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 33EDECEAE55
	for <lists+linux-pm@lfdr.de>; Wed, 31 Dec 2025 00:38:34 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id C32D0305E3C4
	for <lists+linux-pm@lfdr.de>; Tue, 30 Dec 2025 23:36:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EFD653054EB;
	Tue, 30 Dec 2025 23:36:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="W9X7mXlK";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="End/AUXb"
X-Original-To: linux-pm@vger.kernel.org
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 416E52FD689
	for <linux-pm@vger.kernel.org>; Tue, 30 Dec 2025 23:36:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1767137782; cv=none; b=fnzys/oMRstvmR7392D9vj17Nl5cFuHfD5B2b+Ap+fgGk9eQfzVeyBNv6JbbvwwjkRF8kyLZU6I7ih60nLSHKqPESoxLB+hxdynFM8zsxzRfyHtjQ1NOJQfaOdoyDGVPRRlrJIIx7b+x9nxrNBI4ELc55PZsQFHZ64kmDgxisD8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1767137782; c=relaxed/simple;
	bh=6+JOo9+e5YxLPlXZg+ZHcoNUi9rYQcA+G+nvDkHNQjU=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=n1ZwNZt8Avp1ZPwj2iZOkH7vLhM1wis7sDf1efNXCLfyZPYyik/+CPOjLttuQY/T9k3bmdi5reS0/hq7hjFLSK/Eqfc0555hXCnSRtxqpit8n2vnCXprap1KuFSJCiSh3yG4kGfBzxyoitG60FDkO0d79uS74W/hloiDXqHs9Yc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=W9X7mXlK; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=End/AUXb; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279863.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 5BUB91Vl3971677
	for <linux-pm@vger.kernel.org>; Tue, 30 Dec 2025 23:36:18 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	pN0gw9rG5RdzlmEjVfv9qpWVODg21JUBSfOFUltY/P4=; b=W9X7mXlKCro0PCl6
	Rt8t8tiSX3+94XCTyqDiL2yuw1Ndi3nRrViN/hH1usZR5Cdmk2bZvZJbYJOqjYCq
	Q0QImXZz0sJTwu4gwvz5F1soWpby61KDuLZeDH7u3n2R1vtfHWyC8zQoriH37Gde
	xHmU8KoHVjMWEBdrsx3i3N0zorVJzwMh+Z2nu5bie00Z+hqwFzhhF8xqd10Kf2GX
	Riu11Wx7enP/L/d1HbSVvm82+fC2TK7xlOFZAoHmBoW/5i4KxDj433vv3HmAxmcs
	19Tv5DJyRiDkoR01jK4mMvjyVUnBKaRQoWPfZoKH4zmG943adviCKP080j86eEWa
	W09VUg==
Received: from mail-qt1-f198.google.com (mail-qt1-f198.google.com [209.85.160.198])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4bcdky1dg0-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-pm@vger.kernel.org>; Tue, 30 Dec 2025 23:36:18 +0000 (GMT)
Received: by mail-qt1-f198.google.com with SMTP id d75a77b69052e-4f4a5dba954so263782541cf.0
        for <linux-pm@vger.kernel.org>; Tue, 30 Dec 2025 15:36:18 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1767137777; x=1767742577; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=pN0gw9rG5RdzlmEjVfv9qpWVODg21JUBSfOFUltY/P4=;
        b=End/AUXbpr/nYVOblH8037S2VlGgCnT8AaShYYVzU2J82lOasEE3x+gGT19/XTCDmi
         zTJTmakLeaaJ7UAANFUiV7hbyDWVP+/iL5fEM23wGuggRfWv1BiUsPxaWV3WmWJSFrOv
         blEqqHYSvRFqLGTclTy0jZByQXM9uGwXkaD3yIMzopzOH53biCahBirKkZz0sBOBkREw
         9IkvEG8Lm1s7/keofHi6ArP5/poYL8cTba4QAIjBCzByNoPDBsxFxHAw97j59ssGv6B4
         8rpQxsj5yAReHmK+hl3QcizZsBfq1JTHadvLYiCHffrVOShQa06og52ZuJaJjp15R2Wv
         1I2g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1767137777; x=1767742577;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-gg:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=pN0gw9rG5RdzlmEjVfv9qpWVODg21JUBSfOFUltY/P4=;
        b=thD7IPGE4c148nHR5IjgM9PCEMUGMdjyVLZsqkAv+Grs1n2NhwhleBRlvvEdqrGDI4
         rcqRM6BzDOIvDbMHCnEbarJ9zG9asi9LhiRz2K8yz3yFkn5si3JmzCdPPp2gTyU9VpDN
         1HUoQOjn6b1z2ZLmI8aliuUj68iLbhpcdjdDNqhNJKGappGpF20VffBk6QRmLS2uF1qx
         3gIMrYIQnKZP3kv+YFJ+dyVghTQlMAWXD00Rx9MmPOUd9Z94owwX5QYxOZKqlEdptak9
         pLdhHV8mLw0u8iqefmgTgwxhQ1O8UMSKb1VqdQ/rqdFkZ+w1AnS8m6uG6asImJvCzBot
         lZVw==
X-Forwarded-Encrypted: i=1; AJvYcCWyuF0ZQTX4Hb8BB4VjNC0cd/OpogTUwpl7d5FWxaOcxjOGqdXSkJTmAwWk9hi1L8A4i1ND486new==@vger.kernel.org
X-Gm-Message-State: AOJu0Yyym3a651lz0yay+zSwHtRaj7iAAJUxcMd8y68qfquN3VTQg5HC
	cum6w2mkKSRI7jz94U2tIOBbfuzEoO6Fyz55oKAptDtK5f6byIyjwA6zi9AIy7pI0L6gl7drA12
	1TUy32C8p7Q40IEYXiW/sZXZlNhUxy/sKxEQafZoTBJUhtktjmoAc0ZNPai+OMw==
X-Gm-Gg: AY/fxX6Ginrgp9D4+fkFdeCd6qb7HOBC8tmzIDv3iL8r4d716/dboP3BaKaklAe7d3P
	3rXp9pZPLYKz3JsMm/aIzlI+x5xh2jhKVeo3l69n9yr/xJtjSOsemrirgwz8sQRTiBhiT3HVPpd
	hs82wGsKl0FCG3VrjtAF+CzHjxdGFoyrzIug1q9U9RILRMoCXaDQgEQKJEAssxsBbvj1cRytBFy
	kfgUJbbxS0RiMF9IW5Xt7ki1XKl4xyT/wTt8m1G8hytcMRGaTfd9SNW4WNtv+pEJHWZ3z6o++uv
	5bP/CK/kNbRzSWwKJ2DqDlE8galL5Bjc62h6VW7JZYZNZDlzcn31labIqcUAVkC9SYDznyMbf8U
	urwMJuq5OQvbA0RrZNvjO/yboJ3+xfh3K7TGcEFkRMiO+cXYtPTd9MiemFw1G1TPijiYWadFpX8
	1bwn+hAbMWF047BmhSdO4zfBY=
X-Received: by 2002:a05:622a:446:b0:4f1:e2a4:db39 with SMTP id d75a77b69052e-4f4abcd0629mr550480381cf.4.1767137777311;
        Tue, 30 Dec 2025 15:36:17 -0800 (PST)
X-Google-Smtp-Source: AGHT+IGFRv8l3gteOWWtOu6vhj4QMEJMlCDWlZhifBA6SZD+rpP0wesN7wEhHc/spA7fxWlz51/BRw==
X-Received: by 2002:a05:622a:446:b0:4f1:e2a4:db39 with SMTP id d75a77b69052e-4f4abcd0629mr550479991cf.4.1767137776837;
        Tue, 30 Dec 2025 15:36:16 -0800 (PST)
Received: from umbar.lan (2001-14ba-a073-af00-264b-feff-fe8b-be8a.rev.dnainternet.fi. [2001:14ba:a073:af00:264b:feff:fe8b:be8a])
        by smtp.gmail.com with ESMTPSA id 2adb3069b0e04-59a18620337sm10349574e87.86.2025.12.30.15.36.15
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 30 Dec 2025 15:36:15 -0800 (PST)
From: Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>
Date: Wed, 31 Dec 2025 01:35:58 +0200
Subject: [PATCH 08/14] arm64: dts: qcom: sdm845-db845c: specify power for
 WiFi CH1
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20251231-wcn3990-pwrctl-v1-8-1ff4d6028ad5@oss.qualcomm.com>
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
X-Developer-Signature: v=1; a=openpgp-sha256; l=1268;
 i=dmitry.baryshkov@oss.qualcomm.com; h=from:subject:message-id;
 bh=6+JOo9+e5YxLPlXZg+ZHcoNUi9rYQcA+G+nvDkHNQjU=;
 b=owEBbQGS/pANAwAKAYs8ij4CKSjVAcsmYgBpVGHkqHVNQ4DBU7B16+g5tUkbTtk76iHKgCnuc
 k8IHXUM1XCJATMEAAEKAB0WIQRMcISVXLJjVvC4lX+LPIo+Aiko1QUCaVRh5AAKCRCLPIo+Aiko
 1d3PB/9YnZoK+1dQpJIB/EYgZhmQVsNlnqchf5lDyF0QQC0qzYQA7LFWTOi2QmeI8KkfEoOLFrT
 iHX9jXwo91u+cGPXXdLH9x4ZskL/pcNObZFuCxZBl9ecKP+lQI5oZ0UuU26Q0hQDqo7C3MBtd8y
 r9+lQZYxJEDS+D9avz7Hm8rsej+hngqN79FmwHIfoCWErlVNVHWhCkGWEUpNyh4TI4bhUXMMVBl
 /boWOOy8oV3PAzN4+C7E9dsOnhfrJQ/22IQzoPHy3tAfQgAC3DkSWN8/22/22LVjK+u2SxYi6Jh
 flTMV0g6hGZNetYTQANJNDgE0/zq8QX59l9k+HZXsnpsZE/2
X-Developer-Key: i=dmitry.baryshkov@oss.qualcomm.com; a=openpgp;
 fpr=8F88381DD5C873E4AE487DA5199BF1243632046A
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUxMjMwMDIxMSBTYWx0ZWRfX3rW9i9OQgIz4
 irjnl2nh1L35Oq7tsFhhJbz+AIdg1pYddH+BKco7bpp68hH7bzDk+s7WQt1YEbBzsb2oLISvEvy
 zHKuKr6BmhzlKaNEd694Llr6/csbPedYQmCeqOiqrs0AmotZaLJZXH4vgfeeDgWe2MoTb1WgHSh
 I54ax2peatQgp4/NgEzUzzU+RmLmER5f0bfgHFyF7/ZHHCKrAIa/u83b2DTthhAmt1JPux6yat4
 5RhfwIMDpPzUvQwLezQSGiw/1hUij/bh32xivz0acCUjG085T4vWK0P7kH0cmr+3y5SIYL8He3R
 Apy9LmaUS5nnaZSYWrLubqxJL6tffi/S/0pbfbIJipyK7EFkbFnib1+ZzB2X665loPpBfpw1qeC
 NiLDT3PLZHEoWgLHcxiynzSR7JqRiP0+QUEdsU40JND08lYVxcD4za3o6UWv51HXoYcS9B8g7rH
 U25oM3bIvv+3J671UFg==
X-Authority-Analysis: v=2.4 cv=Wskm8Nfv c=1 sm=1 tr=0 ts=695461f2 cx=c_pps
 a=mPf7EqFMSY9/WdsSgAYMbA==:117 a=xqWC_Br6kY4A:10 a=IkcTkHD0fZMA:10
 a=wP3pNCr1ah4A:10 a=s4-Qcg_JpJYA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=EUspDBNiAAAA:8 a=q_35thakA6fvWH9uoQUA:9 a=QEXdDO2ut3YA:10
 a=dawVfQjAaf238kedN5IG:22
X-Proofpoint-GUID: ujyEnIFumUhuQk18q5L0a-HO17pQ3Ldm
X-Proofpoint-ORIG-GUID: ujyEnIFumUhuQk18q5L0a-HO17pQ3Ldm
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.9,FMLib:17.12.100.49
 definitions=2025-12-30_04,2025-12-30_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 malwarescore=0 spamscore=0 lowpriorityscore=0 priorityscore=1501
 impostorscore=0 clxscore=1015 adultscore=0 bulkscore=0 phishscore=0
 suspectscore=0 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2512120000
 definitions=main-2512300211

Specify power supply for the second chain / antenna output of the
onboard WiFi chip.

Fixes: 3f72e2d3e682 ("arm64: dts: qcom: Add Dragonboard 845c")
Signed-off-by: Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>
---
 arch/arm64/boot/dts/qcom/sdm845-db845c.dts | 7 +++++++
 1 file changed, 7 insertions(+)

diff --git a/arch/arm64/boot/dts/qcom/sdm845-db845c.dts b/arch/arm64/boot/dts/qcom/sdm845-db845c.dts
index ad283a79bcdb..5118b776a9bb 100644
--- a/arch/arm64/boot/dts/qcom/sdm845-db845c.dts
+++ b/arch/arm64/boot/dts/qcom/sdm845-db845c.dts
@@ -379,6 +379,12 @@ vreg_l21a_2p95: ldo21 {
 			regulator-initial-mode = <RPMH_REGULATOR_MODE_HPM>;
 		};
 
+		vreg_l23a_3p3: ldo23 {
+			regulator-min-microvolt = <3300000>;
+			regulator-max-microvolt = <3312000>;
+			regulator-initial-mode = <RPMH_REGULATOR_MODE_HPM>;
+		};
+
 		vreg_l24a_3p075: ldo24 {
 			regulator-min-microvolt = <3088000>;
 			regulator-max-microvolt = <3088000>;
@@ -1155,6 +1161,7 @@ &wifi {
 	vdd-1.8-xo-supply = <&vreg_l7a_1p8>;
 	vdd-1.3-rfa-supply = <&vreg_l17a_1p3>;
 	vdd-3.3-ch0-supply = <&vreg_l25a_3p3>;
+	vdd-3.3-ch1-supply = <&vreg_l23a_3p3>;
 
 	qcom,snoc-host-cap-8bit-quirk;
 	qcom,calibration-variant = "Thundercomm_DB845C";

-- 
2.47.3


