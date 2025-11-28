Return-Path: <linux-pm+bounces-38886-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 02E90C9261F
	for <lists+linux-pm@lfdr.de>; Fri, 28 Nov 2025 16:01:55 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 823AF4E31C2
	for <lists+linux-pm@lfdr.de>; Fri, 28 Nov 2025 15:01:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D1EFE329C7F;
	Fri, 28 Nov 2025 15:01:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="R7+SIvSg";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="Dt1c7Lf3"
X-Original-To: linux-pm@vger.kernel.org
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9561F27464F
	for <linux-pm@vger.kernel.org>; Fri, 28 Nov 2025 15:01:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1764342110; cv=none; b=iEUFrWFYgjAG2KyHJZ9npkPjmDB8sRfZtGDAezZ8dx3jFZKyVZlJg7J/sBZryTWvKtPIl4jgVTLt+w3lVQ4nedH8zxtiJgyghTFLQthsTRavZXtpF9dM5fwraQj5gTYuqjwwpJHEXYNUgDBuDOxIHVnGyLLHJXbV7vCz5Zpl8PM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1764342110; c=relaxed/simple;
	bh=xEfRUtmqH7shVoSYTWEh+/jIlgLDvmWXykH2vAbwbU4=;
	h=From:To:Cc:Subject:Date:Message-Id; b=oM/rJpsWsD8DK3IQp2FfjzJXlHJB4ykRYlm9clIq2uapefvgol3HZmFK8/pZ1SZXQX8d0t/Bv7DjZOEgQxW5CH+Yuobu05D5PVqny/xF2+uLaoq86dtLr4OfvpNg9Gv5HVFYM89AZLm80sYnG0ZXQQSJt++wTEORw58sCKb0TQw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=R7+SIvSg; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=Dt1c7Lf3; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279872.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 5AS8rm0t3989819
	for <linux-pm@vger.kernel.org>; Fri, 28 Nov 2025 15:01:47 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:date:from:message-id:subject:to; s=qcppdkim1; bh=y7p6yQCcke6d
	kbfGd76T3swz046SLZ5QbkD0+DxbteA=; b=R7+SIvSgiQNW28881A/JuOXei/An
	Q1tLuuIJ2WW/+W5eGC/EBcLtQ4BG60dsjVYMkxi/ERTf3le7MnaHtuA1ZNQl+/0U
	1GjbX7WABw/MtgMEphMi9DkiEZm1PTFxZs5b6omg7+J2qK/tID5ZyewY/3yePkeT
	5VqFEAPWPxIFJR4qWm09k9uTuU5BATq/t562dWbDVZtFgGZD137j3H6Tl6bPZXmm
	KXAsyABt8F7/QuDZ8yAqtbSDzudiIZe/OTtQ5t/uZQvlIq5E6eEkjaiQ7cmzqgBF
	unlDsNbJy+PXjqMVx7mfj85pDgIePyulWCeAsZwmH1TpDUe5k1LXAmCTTw==
Received: from mail-pl1-f198.google.com (mail-pl1-f198.google.com [209.85.214.198])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4aq8mm8yfe-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-pm@vger.kernel.org>; Fri, 28 Nov 2025 15:01:47 +0000 (GMT)
Received: by mail-pl1-f198.google.com with SMTP id d9443c01a7336-298535ef0ccso21892435ad.3
        for <linux-pm@vger.kernel.org>; Fri, 28 Nov 2025 07:01:47 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1764342107; x=1764946907; darn=vger.kernel.org;
        h=message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=y7p6yQCcke6dkbfGd76T3swz046SLZ5QbkD0+DxbteA=;
        b=Dt1c7Lf3OeZp9He83jhd+cFVgY2eB0E/jPUeyW6wiErcGeCrsS4U0H2Sv3i+oquR1l
         FsmtIjdhpM1nj81CDKMMczLP8MNYZ2Eqb/z6WsSyl6+yAwE3UU6lkrh7fnaXDZmupfsl
         u29Y870Ri1baQ1mYf3wntpURVpv22KZQfVGqLp/zN1ipuMFTpkb60j8t8KNVNExjYf6R
         8mIb07J1DwULsfIZfZmpPAAf49oHR8gpUul4FWyb4hFQ+Asno7O9AtEEQbedoEJaYWRA
         yk5BXCqQgmVzDHP8jL3tUXzvXq5lrCRqmUTzriQeYGBfcfgMYWMEcLu/b/jBPWxbguKA
         2zwQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1764342107; x=1764946907;
        h=message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=y7p6yQCcke6dkbfGd76T3swz046SLZ5QbkD0+DxbteA=;
        b=v/4bbIZnR+083LzX85m64/O17+T7DIjtUuc8RqT8b1UiTKn1eOuhuVae4YWquglGSt
         dmTT7JkS6eklOq18KZnFpIPF8dWB7cUAqsXlg28nuA8yySKf+l1JAI0c2c/IosMOMVKt
         SO85gkGoPGOcszBKq9keafT3hSjBWMxDDBa/sGJinLAGX2Y8tGtMj+7jUFWIEDqgw+YJ
         7mfEaCI8FQjHt4gqiZU4RaioFg4Mmwhz8BPKIfLirotfvSJ3I8EKvdtg/ae6xzKQ2sFE
         vQH+5uyb0qgNql0q4T/wH6toH2vsFydRZgYGxUuCEfU7N/y44wLQirG/SAUUREJxIj7D
         Ki6Q==
X-Forwarded-Encrypted: i=1; AJvYcCVSPG758cKG9z6DMRVrpXNXjIqit72VXTuu2HdpbbaFxTy7I+ZJ4cbb87BbY2tqZjAojSQB0dTiOw==@vger.kernel.org
X-Gm-Message-State: AOJu0YxLRe4dvM96A7nb7Amnj6rJZ2rwaVFF33Yof1xZ/bero9yU7wIa
	OWsYvP617W0vm3GY57e9qd+EoLkwxrtTiJAIln32YMob0RIUGHYC05evAlVaUzadVmnP8vG6wQO
	O/ntVSGvds0awqCmW06GvH6FmfNfZ6c1f8cvo4UgV6gPZEdCpntLOOEJSq5Okxg==
X-Gm-Gg: ASbGncsF1iDfZlEz2oeMPRoRJ1ii+XJg3wfFptYS+zmwhWZ93CmazWU9rUVghw38roA
	Yf0zl5koJSHn2/3JqTyNTgUmOlUttPKx8rH5WXSuGgUj2ryvYD7J43EmnS+ry53UbQjxloFS6FL
	tWPiJ6/VnfJLUsLgdlqDvW2yBtrkwM4pmpp8TJ5c2D5hhTICUANxmqmb93cR3MKwmwbUqX7oWG4
	zy7e9EBgPxfLjoGW8DSC7qbUOLBeSNZ7ror9ZmPb6TxaqpTafzzOvZ7neZq6wYPFlesrP3+Qrwn
	g54bY0k9rx3YIs4v19G7uo+VybKTSn+aLhpVBSjQQ0KA0zYy3609mwoaUXfJ0GFA2ThpdWID8bb
	wyP1YtuDCyjzagFQk3npvI9B0UG+I9467EIk2qvIiiFM=
X-Received: by 2002:a17:902:ef50:b0:298:34b:492c with SMTP id d9443c01a7336-29bab2de50amr165713495ad.54.1764342106363;
        Fri, 28 Nov 2025 07:01:46 -0800 (PST)
X-Google-Smtp-Source: AGHT+IEpI/BufIbwOVwPHLz/kJYkcxerhQ6rcnfU87Bqc+reHKOFkzwqLvCM71gMvDDQnwywkhuxDQ==
X-Received: by 2002:a17:902:ef50:b0:298:34b:492c with SMTP id d9443c01a7336-29bab2de50amr165712795ad.54.1764342105618;
        Fri, 28 Nov 2025 07:01:45 -0800 (PST)
Received: from hu-okukatla-hyd.qualcomm.com ([202.46.23.25])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-29bceb7cf89sm48930635ad.99.2025.11.28.07.01.41
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 28 Nov 2025 07:01:45 -0800 (PST)
From: Odelu Kukatla <odelu.kukatla@oss.qualcomm.com>
To: Georgi Djakov <djakov@kernel.org>, Rob Herring <robh@kernel.org>,
        Krzysztof Kozlowski <krzk+dt@kernel.org>,
        Conor Dooley <conor+dt@kernel.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Konrad Dybcio <konradybcio@kernel.org>
Cc: Raviteja Laggyshetty <raviteja.laggyshetty@oss.qualcomm.com>,
        Odelu Kukatla <odelu.kukatla@oss.qualcomm.com>,
        Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>,
        Bartosz Golaszewski <bartosz.golaszewski@linaro.org>,
        linux-arm-msm@vger.kernel.org, linux-pm@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        Mike Tipton <mike.tipton@oss.qualcomm.com>
Subject: [PATCH 0/3] Enable QoS configuration on QCS8300
Date: Fri, 28 Nov 2025 20:31:03 +0530
Message-Id: <20251128150106.13849-1-odelu.kukatla@oss.qualcomm.com>
X-Mailer: git-send-email 2.17.1
X-Proofpoint-ORIG-GUID: Gv8IQKaaGE7L8-m7RLGHdZoy1x-i0vCi
X-Proofpoint-GUID: Gv8IQKaaGE7L8-m7RLGHdZoy1x-i0vCi
X-Authority-Analysis: v=2.4 cv=Cvqys34D c=1 sm=1 tr=0 ts=6929b95b cx=c_pps
 a=MTSHoo12Qbhz2p7MsH1ifg==:117 a=ZePRamnt/+rB5gQjfz0u9A==:17
 a=6UeiqGixMTsA:10 a=s4-Qcg_JpJYA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=fIl7fISSXmXrEScvsbQA:9 a=GvdueXVYPmCkWapjIL-Q:22
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUxMTI4MDExMCBTYWx0ZWRfXwVWcmaPEZdSB
 4OLhBWg9Yjs9DbEgq2IYmIWQ3LDeJe5v07ptSWvr28QkoGnyVVwzPCny18wpycQ4jyWjPMNgUhe
 zng/fKVNd5hwUGUik17qKsi+2mPdp9fkKgjAWYGiUuqqIv917xFHA2IEq/jIbBzz7fIux4IRQ1j
 fvO0IxxISFMAuyGrt2VduN0/LbOrt+E1J+vRp6ew4cJGt9kV8289xscNr/R9RvlkqPZrtLqRtdp
 pJTYfJP2Esh0KkaD1wxEgMTsv9cBmeWDIYKj9GMtiesRcm5ZoBjLpc3FJZJ7f0WnjoCT8Evxa/Y
 jP/cJnZ2SMYjUewqSluuibRU0vGufECWM+Q1KObnmBJLdLuMcHjL1S4KH2nmx8oxwvA/n2M4RvD
 YVaPmBfLL7b6AjhENP1SW1ehGT6FkQ==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.9,FMLib:17.12.100.49
 definitions=2025-11-28_03,2025-11-27_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 spamscore=0 adultscore=0 priorityscore=1501 malwarescore=0 impostorscore=0
 suspectscore=0 clxscore=1015 lowpriorityscore=0 bulkscore=0 phishscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2510240001 definitions=main-2511280110
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>

This series enables QoS configuration for QNOC type device which
can be found on QCS8300 platform. It enables QoS configuration
for master ports with predefined priority and urgency forwarding.
This helps in prioritizing the traffic originating from different
interconnect masters at NOC (Network On Chip). 
The system may function normally without this feature. However,
enabling QoS helps optimize latency and bandwidth across subsystems
like CPU, GPU, and multimedia engines, which becomes important in
high-throughput scenarios. This is a feature aimed at performance
enhancement to improve system performance under concurrent workloads.

Odelu Kukatla (3):
  dt-bindings: interconnect: add clocks property to enable QoS on
    qcs8300
  interconnect: qcom: qcs8300: enable QoS configuration
  arm64: dts: qcom: qcs8300: Add clocks for QoS configuration

 .../interconnect/qcom,qcs8300-rpmh.yaml       |  53 ++-
 arch/arm64/boot/dts/qcom/monaco.dtsi          |   6 +
 drivers/interconnect/qcom/qcs8300.c           | 375 ++++++++++++++++++
 3 files changed, 428 insertions(+), 6 deletions(-)

-- 
2.17.1


