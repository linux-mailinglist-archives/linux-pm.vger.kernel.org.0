Return-Path: <linux-pm+bounces-39995-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 58903CE545A
	for <lists+linux-pm@lfdr.de>; Sun, 28 Dec 2025 18:24:27 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 2D3F5302ABBE
	for <lists+linux-pm@lfdr.de>; Sun, 28 Dec 2025 17:23:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F35912D592F;
	Sun, 28 Dec 2025 17:21:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="nB0WcuIF";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="DuVhTC52"
X-Original-To: linux-pm@vger.kernel.org
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 80F61293C42
	for <linux-pm@vger.kernel.org>; Sun, 28 Dec 2025 17:21:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1766942514; cv=none; b=WOolur7fQewLFpf/xJmexGTkimuzF+/wEyolfypa4GCC6WXCcOjG2gigD77h2FXy3N1M3gyWof6wVkA540AClGySjQlGOd4cS8DT13EClO7CJZ8Lttqci7k5W5lEDzTC4f7+YAtxtpuz2A4KzsSv3AquqOUOmd/dEnZhWDXHAK8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1766942514; c=relaxed/simple;
	bh=0rsUdCdVzH+igD6u68w9uIiPh6ggbgRgiwDr1wBAjm4=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=ItFiRsotGkK+DotEpJVZxIy0JQVotCdayPTZ49S3/wTXVJ7V9noa7wRThBxw4xs9WdpXKMsXj6/MuYoX+4LYPMjTU1sXe/+22TZ4c+aCQ8vrm+N3+r3rCfHPTGPooeo/Iw19OED5ZOfR5OCdzdzxG58bBoPGK1nxYy+QXbfy4x4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=nB0WcuIF; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=DuVhTC52; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279866.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 5BSGt1M02538947
	for <linux-pm@vger.kernel.org>; Sun, 28 Dec 2025 17:21:50 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	kWKchhYmME2TIdgWLH1Giry57SQALMGVaYfhAJiBNzg=; b=nB0WcuIFz485+40d
	dE+ut6bdLLqNe3CQeSbbZjux4HSYxUTifHQuvKnngpSO7N+6O22NhZI6AsJnL7ts
	uDAPujtbFUZ3ePh3UsK4fV7P7yV49Nr+JiH2T0z+cOT+NH1Pw8uhTbKhPXMSPxLm
	Ing5gNZCWM2S+mIPOYlRJX36WtL7nhgnmWH//lwk8m0iorqPcfVoPYSTZzItMUAZ
	zlp4/C2M1etLPepflviO+u7z7KRGjCgmXoVmluodYwti/lzuxQa+U6c52zauCNHI
	iBzK7g6jnmKW3op30hArEZups2AxxGTlZMjCwFtGbKHSkEnakdfqjI5rc/kDs4Y+
	/WON6A==
Received: from mail-pl1-f199.google.com (mail-pl1-f199.google.com [209.85.214.199])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4ba8r6admf-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-pm@vger.kernel.org>; Sun, 28 Dec 2025 17:21:50 +0000 (GMT)
Received: by mail-pl1-f199.google.com with SMTP id d9443c01a7336-29f26fc6476so140990315ad.1
        for <linux-pm@vger.kernel.org>; Sun, 28 Dec 2025 09:21:50 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1766942510; x=1767547310; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=kWKchhYmME2TIdgWLH1Giry57SQALMGVaYfhAJiBNzg=;
        b=DuVhTC52odpeKbYfm0dIJY7LJz1C+TYb/2H/1DnPXelUi6MEhVpqW+wA7HpJEAIgnY
         /ezA6Kk6S6jM+haXHoDW85y6qUeSmlhbgmIO/9F7pYSBEA2qxULpXEicuO1ywrwNq+OS
         XxuVc9Q4hE4OTk11qm2xjF46NP7oRmTBKBylLQnAPHRbkxSl15Iwofefr4wtqyQTkyvT
         8x1briOatYU4SwxfyKW4uIcr9sgzbrpHca0kpwf0sYepvyp/Lwyx1ylopWOJkv0ggTql
         s3koSLneAzGaR39k2qf6IdKxNURDUwPLQHKS0x5DwIj4KfYaD4EWKW/2bumeC+5Fw0hw
         g42g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1766942510; x=1767547310;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-gg:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=kWKchhYmME2TIdgWLH1Giry57SQALMGVaYfhAJiBNzg=;
        b=X8gCTf8hP+cQyh9382spZOzEjtZWKFVpXSaqeioEa+a/aT2WFokUZFmbv+7LkZV6UC
         IvUjqIzN7wrStDL6R5N092r96LCyH62lJCZQrBt4qs1XiyVunk/1GBgthww/qFXAwB+A
         7sHvPvk9nNLGbwTncyE5IDoVzrCyNInUWU3qpnvITiOJBXRlpBMEDFrBo89A7BoEcTK/
         VM56nu9Emz8Fx0k1hd8IpsZTMTLsQ7GGnh0Mx7GX6y0EuWy2Sq1HLhkdwm3zs9aNd6OZ
         PJKEt/CisdkZdmigj/LN/YfvCB4/17HNnohnVph6BRszNPQvBBmfu2S3GhuPXApNTFNc
         SH2g==
X-Forwarded-Encrypted: i=1; AJvYcCWdo2JAGKXutFDDPFFs/8S4LBdavT5JLfCA5qhFQHlUILAEd9n7O8b22+M1nSusTeKovxDl8BxoIg==@vger.kernel.org
X-Gm-Message-State: AOJu0Yyrb+irfOBkyzlu+Ylh+20nv0DCd4il5lq4Raakx9LqB2uYy7fn
	XIFHLZnc0hbAS4/ZenplAFKx0zszKtbvtTJyd1MT2rnuipkFTIcqk52pc2t+KFLSyMbSzhNyNiU
	XjvI7OTyhJRN8DxO0m13xBBbgsDAqt0HK0IRe0TT79IGv9wEVJvYoMJ5fsz29Lw==
X-Gm-Gg: AY/fxX7705n3rU48/ptS+5OoeOKtf6pLxr9UqtHccKTNG/IrhEz2zF2YbEHnFB4DHa1
	93U81eIXvXKr0V/8V4mfK4o2aQwepPrU2HjCQS2wFfL0w9Ijo0j0autxM6/oJ56BgLX/SjTi28y
	t90l3Qo5ZBteRXuH7L8x+ZDOs9jzcjtjIhz0/EE34CKfMHNEr0D+mDw9YJelbZDcNehs5140QmH
	pSNXwfJLVDSyt5k8dOX3gHFzW5Wnchgdc7s4Vl6SV4O/t/aNsuD1Giz3Kmkt5W43JNS1PZKfZYP
	XUo4BeTjZQ1hFUr9f+/ma+MEP61qK2Cy0KX4m+zanh84ddbsm30GMHKSmuitmFa5C1k2BhkbGp3
	2fe+NsqPlrxTcf0s80VD293UGjHFENPHg6aH9iFAInWHlWw==
X-Received: by 2002:a17:903:1207:b0:26c:2e56:ec27 with SMTP id d9443c01a7336-2a2f222b5d3mr297818185ad.19.1766942509933;
        Sun, 28 Dec 2025 09:21:49 -0800 (PST)
X-Google-Smtp-Source: AGHT+IHmBJ+0QhDD76t2QO5vv0elZpbdJjQleOtnh1ZWFEZMsqZX25brOC642q/L2SSYN5VG2XWLTA==
X-Received: by 2002:a17:903:1207:b0:26c:2e56:ec27 with SMTP id d9443c01a7336-2a2f222b5d3mr297817775ad.19.1766942509415;
        Sun, 28 Dec 2025 09:21:49 -0800 (PST)
Received: from hu-spratap-hyd.qualcomm.com ([202.46.22.19])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2a2f3d776ebsm255743965ad.99.2025.12.28.09.21.41
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 28 Dec 2025 09:21:49 -0800 (PST)
From: Shivendra Pratap <shivendra.pratap@oss.qualcomm.com>
Date: Sun, 28 Dec 2025 22:50:28 +0530
Subject: [PATCH v19 10/10] arm64: dts: qcom: talos: Add psci reboot-modes
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20251228-arm-psci-system_reset2-vendor-reboots-v19-10-ebb956053098@oss.qualcomm.com>
References: <20251228-arm-psci-system_reset2-vendor-reboots-v19-0-ebb956053098@oss.qualcomm.com>
In-Reply-To: <20251228-arm-psci-system_reset2-vendor-reboots-v19-0-ebb956053098@oss.qualcomm.com>
To: Lorenzo Pieralisi <lpieralisi@kernel.org>, Arnd Bergmann <arnd@arndb.de>,
        Bjorn Andersson <andersson@kernel.org>,
        Sebastian Reichel <sre@kernel.org>, Rob Herring <robh@kernel.org>,
        Sudeep Holla <sudeep.holla@arm.com>,
        Souvik Chakravarty <Souvik.Chakravarty@arm.com>,
        Krzysztof Kozlowski <krzk+dt@kernel.org>,
        Andy Yan <andy.yan@rock-chips.com>,
        John Stultz <john.stultz@linaro.org>,
        Matthias Brugger <matthias.bgg@gmail.com>,
        Moritz Fischer <moritz.fischer@ettus.com>,
        Mark Rutland <mark.rutland@arm.com>,
        Conor Dooley <conor+dt@kernel.org>,
        Konrad Dybcio <konradybcio@kernel.org>,
        Bartosz Golaszewski <brgl@kernel.org>
Cc: Florian Fainelli <florian.fainelli@broadcom.com>,
        Krzysztof Kozlowski <krzk@kernel.org>,
        Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>,
        Mukesh Ojha <mukesh.ojha@oss.qualcomm.com>,
        Andre Draszik <andre.draszik@linaro.org>,
        Kathiravan Thirumoorthy <kathiravan.thirumoorthy@oss.qualcomm.com>,
        linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-arm-msm@vger.kernel.org,
        devicetree@vger.kernel.org,
        Shivendra Pratap <shivendra.pratap@oss.qualcomm.com>,
        Srinivas Kandagatla <srini@kernel.org>,
        Song Xue <quic_songxue@quicinc.com>
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=ed25519-sha256; t=1766942426; l=1101;
 i=shivendra.pratap@oss.qualcomm.com; s=20250710; h=from:subject:message-id;
 bh=0rsUdCdVzH+igD6u68w9uIiPh6ggbgRgiwDr1wBAjm4=;
 b=9blsmilZ46hLAnaGdTYSnuMNJ45gLWc0rN3wPvJFD9fSMGaWSE1FfJ7iGFzgLHy9rOIioHi1x
 yjslxJDIaGvDyPWOUvESfbSZkSJJaGvjZuAQsxDcSEPdEI1CNqvTSYX
X-Developer-Key: i=shivendra.pratap@oss.qualcomm.com; a=ed25519;
 pk=CpsuL7yZ8NReDPhGgq6Xn/SRoa59mAvzWOW0QZoo4gw=
X-Authority-Analysis: v=2.4 cv=Raidyltv c=1 sm=1 tr=0 ts=6951672e cx=c_pps
 a=JL+w9abYAAE89/QcEU+0QA==:117 a=fChuTYTh2wq5r3m49p7fHw==:17
 a=IkcTkHD0fZMA:10 a=wP3pNCr1ah4A:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=COk6AnOGAAAA:8 a=EUspDBNiAAAA:8
 a=4cuBwC7xTQKafrdxVH8A:9 a=QEXdDO2ut3YA:10 a=324X-CrmTo6CU4MGRt3R:22
 a=TjNXssC_j7lpFel5tvFf:22
X-Proofpoint-ORIG-GUID: 14jSTnCHuSdE6r9V2XGgn9sK01iBs3v4
X-Proofpoint-GUID: 14jSTnCHuSdE6r9V2XGgn9sK01iBs3v4
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUxMjI4MDE1OSBTYWx0ZWRfXx+OyHIe1E3yZ
 h1dd+gLf6rq8n9X/VgsLKeIjOw30xUEFxDDLcHQJr4gjiSbiz0ec8X68eA85JkWDv3wPuSYkfE5
 U6Hq8MITWdtWwOtyCuPj3bgLvbzT9tTqHTAayh4haVKXpxnuXmtYVO37GAjL9C9xjCztw4rA595
 gKavmTKtk/wJoyKJxtBpHs29cZS88KoMSYnPvaVhaxzyPNScIQp/b8UiEqkS0qLL88bM4Cntuk1
 eb8czdlvNYI/1Jr8kUJZvf68jP8zSoBKOWM1BxDOoi6iZL85TSRCRH9AbXMIV261EzWIYFM5nwK
 hAT3vrpnkkOxuHRMdLVPzGTH8Wc2S1yGoLAssAf49RpdFbgql+uQpO9pStdhAeAkBM6eFr1WDsR
 thlHk6GvxDOzfuS0L/COV/bodD/3JesEhSAbmZnDobHvh9qaCJqE/BKwIKEsE36GykcK54Wu7sS
 Hdt5HOGOzWRPmP12uVA==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.9,FMLib:17.12.100.49
 definitions=2025-12-28_06,2025-12-26_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 adultscore=0 clxscore=1015 phishscore=0 impostorscore=0 suspectscore=0
 lowpriorityscore=0 bulkscore=0 malwarescore=0 spamscore=0 priorityscore=1501
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2512120000 definitions=main-2512280159

Add PSCI SYSTEM_RESET2 reboot-modes for talos based boards, for use by
the psci_reboot_mode driver.

The following modes are defined:
- bootloader: reboot into fastboot mode for fastboot flashing.
- edl: reboot into emergency download mode for image loading via
  the Firehose protocol.

Support for these modes is firmware dependent.

Signed-off-by: Song Xue <quic_songxue@quicinc.com>
Signed-off-by: Shivendra Pratap <shivendra.pratap@oss.qualcomm.com>
---
 arch/arm64/boot/dts/qcom/talos.dtsi | 5 +++++
 1 file changed, 5 insertions(+)

diff --git a/arch/arm64/boot/dts/qcom/talos.dtsi b/arch/arm64/boot/dts/qcom/talos.dtsi
index 95d26e3136229f9015d49e2be22f6b28f1e842f4..11a2cfa209065776a8ae61c6e661c09bb871c400 100644
--- a/arch/arm64/boot/dts/qcom/talos.dtsi
+++ b/arch/arm64/boot/dts/qcom/talos.dtsi
@@ -613,6 +613,11 @@ cluster_pd: power-domain-cluster {
 					      &cluster_sleep_1
 					      &cluster_sleep_2>;
 		};
+
+		reboot-mode {
+			mode-bootloader = <0x80010001 0x2>;
+			mode-edl = <0x80000000 0x1>;
+		};
 	};
 
 	reserved-memory {

-- 
2.34.1


