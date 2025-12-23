Return-Path: <linux-pm+bounces-39881-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 5806ECDA0D1
	for <lists+linux-pm@lfdr.de>; Tue, 23 Dec 2025 18:10:21 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 4CABF3045695
	for <lists+linux-pm@lfdr.de>; Tue, 23 Dec 2025 17:08:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4F067346A1A;
	Tue, 23 Dec 2025 17:08:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="IFTHkIP4";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="GFfSsI1K"
X-Original-To: linux-pm@vger.kernel.org
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 76EF5346A05
	for <linux-pm@vger.kernel.org>; Tue, 23 Dec 2025 17:08:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1766509710; cv=none; b=B9jMCwCwZUiTX3OJD9mDXg0rGULD51CviKEHVL1Uh8WTzikxWwfW48G5zkWeMqkRY3xZU9RmmcAg+u1sDOgmjZWJ7w1Ap5mCNC9MnO+yAPtrs/BWEdI93SX+bZsFlJ3szfZ5ucmoYUC0nJErCdG6WLabAUcnoOfHMqV+jGULwro=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1766509710; c=relaxed/simple;
	bh=yBVN4FEHADdTSQ++LEmhmTEyByZ3pz1DEJtf2+BqO1w=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=fKSt1OqQkgk91HoQtbuQ3LkLhMJyoQy7p6e9K039IN2Dt5UkXcgyKEgxRTPYib2QbuQag0rLq4eDB1ooRJ8n9ogTBEXFc1zAsm1cfkzJR8d3LSDnN4E4j/EJTv/RcubX6pVc2+v0rFbLmX3Bg6XhLfSur6MqD+guXEm6uqlb7n0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=IFTHkIP4; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=GFfSsI1K; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279865.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 5BNErumQ461397
	for <linux-pm@vger.kernel.org>; Tue, 23 Dec 2025 17:08:27 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	PO6gg0/IWEmCTv8xrfB/fKl5SzRNa5BhzNOETtSDJoo=; b=IFTHkIP4gCO+iCZQ
	esD2VfxvcdCzb0Qo5iM8UyRDdyoZs5+2GRuA21JG5HRUvPRNFUCI7J2bWmmteioc
	5CcLxPYMbE8vra3Mb7UQehJGpwqOMto2u8YdVEzlle0KubBRzhaxnBSYrcZgcDc7
	qJCniMtQBqM10SdehfWMGBSdRlOLfzMn9sZzJeBfJi1f7Uv1YlLKFL5lMNmq6XuU
	GlY3Mg5F7/PaWcQLntvnuOSms+13/j+K5s2yEBqzW9GJMW55t5IkHx5yQsMVGkpo
	4FsMqd4Z1uIeJ2byNmX3ghxw/a6M5F+I9A6Bb5S1hpUlx3mZKHsbwVUJzrMHrFGr
	OFtroQ==
Received: from mail-pl1-f200.google.com (mail-pl1-f200.google.com [209.85.214.200])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4b7w8frec5-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-pm@vger.kernel.org>; Tue, 23 Dec 2025 17:08:27 +0000 (GMT)
Received: by mail-pl1-f200.google.com with SMTP id d9443c01a7336-2a0dabc192eso114298365ad.0
        for <linux-pm@vger.kernel.org>; Tue, 23 Dec 2025 09:08:27 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1766509707; x=1767114507; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=PO6gg0/IWEmCTv8xrfB/fKl5SzRNa5BhzNOETtSDJoo=;
        b=GFfSsI1KrnPGeLPuth9IVgzvZ0hmDOjWG49Z2FecQ58NAYwde9/nAuIdnFqfren4NJ
         Aq3BYqQwV25bb0ros4kYQjBvnbKNbraeBMh7U7bHvX60N3I3y/aX+xENZ0tSUVTzRCn1
         sG0IcUzZVuyZTfy8ibHXPuJbCL6ND+yVOhzJdwsXguoI4hrSTLb5K/Ag50ArARlOZiYQ
         LXF1VRh3JavPCcn8P/4mH6+kkTSz2nOW6QY1vRTvXM/uVk5drQScTema7g2s0S+NlX2M
         /OmGt1Lds7s8UcheE2KmBiQyZ8blJ+2d6Z+sVEX2kOau0O0ZtB/lJXIwXDYUy866ylgf
         Bsbw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1766509707; x=1767114507;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-gg:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=PO6gg0/IWEmCTv8xrfB/fKl5SzRNa5BhzNOETtSDJoo=;
        b=R/2SOQ4IKnDmjHU3CU3jJP8F3jZM2owZ9p1eQM7QduDvsPrm8tPdsx+xJYKGWsfeug
         bG4kpGATKSk11+Wbrf36DAZ2oyUHWn69647uvycsB/ez1VtxiwYYnzWmiKzH2N+4FUFg
         456CoBe52EhWGdmKUzPtLDilZ2mPUkTkIe96nI5oR0P2p7UBY2J5kDSB7Pl1SSCBoiuT
         inPCqxQsugXKsSrYhsO58GnXgTUWyMWc3O7Tu6jYZIt27LKLO8gEE+LEC/AKh/vSf7Mo
         pAwo2kHUY2JDrOxPPuLgSdRv6OoXZqUCLmP1gUvF36GU+gxBRuv5WyHDLn/kcLg7asuu
         A2Vg==
X-Forwarded-Encrypted: i=1; AJvYcCVLXUkwQA0OIWzf49Bopid7S+yHTpdvB0gMPod6onHkv91qfGzD5Gf5/6/mOIdWLvJLFHUpJS/9rw==@vger.kernel.org
X-Gm-Message-State: AOJu0Yzf+AdMUWnUdW4wf2JhupeiGJHdrsHZkgl9QcKCAXuEvI65pQo0
	AgP43+Pe1t3V/iZmVVxwKATubg3Vc3XKqL8L9uZ4ukls8zZAhN7C1HxewFeTfYtKmbkULsnfBFB
	GIl57wa4SadvSYl0apqOJVsZX5+ErsoXdmULh7pCIi98LrMRw1vWrDPC7WvT8oQ==
X-Gm-Gg: AY/fxX70woWuRv0yrWAhXkI8M0AvGWFcVlmbL9PwikfPe6rQy2eVOYAAN2SJGqdd5sj
	pRlE6GfbuI74HHMNF5mXBfsz6+ZhdoOw5gKoZoS4uGrdbWjo6pimdbyc4HIlL8k3t/SNrAuTwTC
	5GqsHUVIq/VjtGkbfJ+P/F2ETNj6n5P2yPDYt533Q4H3m181MzegivSPfSGaM6zdMpizxOjldom
	Dik7AGRMdzLSutUN6Lh18ZoGmjPAeqsKBWfpCOGzK3I0EkbqyTLAOFMOQFNdeX92aHSamrkdAhx
	3ZbwacAmAEtz06xknSRXCgNELhE1wMibou/WuMGWHW9WFMdMU6Vk7degwhkonpiLgT17xSU4xk1
	8Tbq6pbU9And80zO7oMEk4Le9DCzUWTh/xU2NjmhGi1g6JA==
X-Received: by 2002:a17:902:d547:b0:2a2:acc5:7a42 with SMTP id d9443c01a7336-2a2f2833082mr153857725ad.48.1766509706774;
        Tue, 23 Dec 2025 09:08:26 -0800 (PST)
X-Google-Smtp-Source: AGHT+IFzbQHGQiGNm8TT1s7wytBJ19OTYg4PZTrG+p6fVpioUAHdizIi5FXebJN3u7utRL4JFRecTg==
X-Received: by 2002:a17:902:d547:b0:2a2:acc5:7a42 with SMTP id d9443c01a7336-2a2f2833082mr153857415ad.48.1766509706317;
        Tue, 23 Dec 2025 09:08:26 -0800 (PST)
Received: from hu-spratap-hyd.qualcomm.com ([202.46.22.19])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2a2f3d5d863sm130019325ad.80.2025.12.23.09.08.21
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 23 Dec 2025 09:08:26 -0800 (PST)
From: Shivendra Pratap <shivendra.pratap@oss.qualcomm.com>
Date: Tue, 23 Dec 2025 22:37:36 +0530
Subject: [PATCH v18 05/10] dt-bindings: arm: Document reboot mode magic
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20251223-arm-psci-system_reset2-vendor-reboots-v18-5-32fa9e76efc3@oss.qualcomm.com>
References: <20251223-arm-psci-system_reset2-vendor-reboots-v18-0-32fa9e76efc3@oss.qualcomm.com>
In-Reply-To: <20251223-arm-psci-system_reset2-vendor-reboots-v18-0-32fa9e76efc3@oss.qualcomm.com>
To: Lorenzo Pieralisi <lpieralisi@kernel.org>, Arnd Bergmann <arnd@arndb.de>,
        Bjorn Andersson <andersson@kernel.org>,
        Sebastian Reichel <sre@kernel.org>, Rob Herring <robh@kernel.org>,
        Sudeep Holla <sudeep.holla@arm.com>,
        Souvik Chakravarty <Souvik.Chakravarty@arm.com>,
        Krzysztof Kozlowski <krzk+dt@kernel.org>,
        Andy Yan <andy.yan@rock-chips.com>,
        Bartosz Golaszewski <brgl@kernel.org>
Cc: Florian Fainelli <florian.fainelli@broadcom.com>,
        Krzysztof Kozlowski <krzk@kernel.org>,
        Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>,
        Mukesh Ojha <mukesh.ojha@oss.qualcomm.com>,
        Andre Draszik <andre.draszik@linaro.org>,
        Kathiravan Thirumoorthy <kathiravan.thirumoorthy@oss.qualcomm.com>,
        linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-arm-msm@vger.kernel.org,
        Shivendra Pratap <shivendra.pratap@oss.qualcomm.com>,
        Srinivas Kandagatla <srini@kernel.org>
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=ed25519-sha256; t=1766509672; l=2477;
 i=shivendra.pratap@oss.qualcomm.com; s=20250710; h=from:subject:message-id;
 bh=yBVN4FEHADdTSQ++LEmhmTEyByZ3pz1DEJtf2+BqO1w=;
 b=q8FNumK28qbLcXa8ZM4rvWLCTPDJr/novRp+CoyeNvg8BIzOUYt8Xni8SOmjIpKt2fOpnc3Hp
 D1GAhEWVvrcBDsBp7kMNU46hERQA9K1RY55AeSGyg60UWowaC1sAFLB
X-Developer-Key: i=shivendra.pratap@oss.qualcomm.com; a=ed25519;
 pk=CpsuL7yZ8NReDPhGgq6Xn/SRoa59mAvzWOW0QZoo4gw=
X-Proofpoint-GUID: Wi7hWEs3EemVpaZCjqzF6Rz2VbP4OCTD
X-Proofpoint-ORIG-GUID: Wi7hWEs3EemVpaZCjqzF6Rz2VbP4OCTD
X-Authority-Analysis: v=2.4 cv=QutTHFyd c=1 sm=1 tr=0 ts=694acc8b cx=c_pps
 a=IZJwPbhc+fLeJZngyXXI0A==:117 a=fChuTYTh2wq5r3m49p7fHw==:17
 a=IkcTkHD0fZMA:10 a=wP3pNCr1ah4A:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=VwQbUJbxAAAA:8 a=EUspDBNiAAAA:8
 a=Z1E3qa2j_4PWJv3PNLYA:9 a=QEXdDO2ut3YA:10 a=uG9DUKGECoFWVXl0Dc02:22
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUxMjIzMDE0MiBTYWx0ZWRfXwfVBYhgBYIug
 JA8ExkAlPcOkCZ4pZtPeDN8dgMSxVR7lkwr1iaKqstDgF4j4B8KVaaAphXDoGmw+aTfVHQlVdHF
 Ab1fAvnl92ER9QePgS8CbAlDaLtseaVRAcu42A5PYC1Q7chF+PWM78TJWZtmTkVYiJAzZCsHACB
 LRquof9OKpW3MWnZSzjuLfylWLdJ0DtDtSRW9Juj22VEeJUUi4+ljTLLlpagzM/tp4NMEnp9a9b
 ISgfGYrMqfFb1nmpkEbrb1QMjDphaG35nNPG8ujnTMTL9z91Rr1OjeJhW9j45seRAky5wSTz2EU
 wge+i+9Z7q/7m7UZvm8e01Gj3G6+yqsbbR/C/dr5sz5wu7FW9RW8mOlQ3teTCnNMv4H+7aZqJMo
 uagmd8VKHrXtMi2pez7KviSuXRBzHlS32pB7htudbjZArt2qwkTzXXZ3lQDwNQz0EXlCAYZJSg1
 C2F90pb/bsnnGCeYJBQ==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.9,FMLib:17.12.100.49
 definitions=2025-12-23_04,2025-12-22_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 suspectscore=0 phishscore=0 bulkscore=0 impostorscore=0 spamscore=0
 malwarescore=0 clxscore=1015 lowpriorityscore=0 priorityscore=1501
 adultscore=0 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2512120000
 definitions=main-2512230142

Add bindings to describe vendor-specific reboot modes. Values here
correspond to valid parameters to vendor-specific reset types in PSCI
SYSTEM_RESET2 call.

Reviewed-by: Rob Herring (Arm) <robh@kernel.org>
Signed-off-by: Shivendra Pratap <shivendra.pratap@oss.qualcomm.com>
---
 Documentation/devicetree/bindings/arm/psci.yaml | 42 +++++++++++++++++++++++++
 1 file changed, 42 insertions(+)

diff --git a/Documentation/devicetree/bindings/arm/psci.yaml b/Documentation/devicetree/bindings/arm/psci.yaml
index 6e2e0c551841111fbb0aa8c0951dca411b94035c..5fdcbf331ea5620363638feb6f8105427a87c00f 100644
--- a/Documentation/devicetree/bindings/arm/psci.yaml
+++ b/Documentation/devicetree/bindings/arm/psci.yaml
@@ -98,6 +98,26 @@ properties:
       [1] Kernel documentation - ARM idle states bindings
         Documentation/devicetree/bindings/cpu/idle-states.yaml
 
+  reboot-mode:
+    type: object
+    $ref: /schemas/power/reset/reboot-mode.yaml#
+    unevaluatedProperties: false
+    properties:
+      # "mode-normal" is just SYSTEM_RESET
+      mode-normal: false
+    patternProperties:
+      "^mode-.*$":
+        minItems: 1
+        maxItems: 2
+        description: |
+          Describes a vendor-specific reset type. The string after "mode-"
+          maps a reboot mode to the parameters in the PSCI SYSTEM_RESET2 call.
+
+          Parameters are named mode-xxx = <type[, cookie]>, where xxx is the
+          name of the magic reboot mode, type corresponds to the reset_type
+          and the values should be provided as per the PSCI SYSTEM_RESET2
+          specs. The cookie value is optional and defaulted to zero.
+
 patternProperties:
   "^power-domain-":
     $ref: /schemas/power/power-domain.yaml#
@@ -137,6 +157,15 @@ allOf:
       required:
         - cpu_off
         - cpu_on
+  - if:
+      not:
+        properties:
+          compatible:
+            contains:
+              const: arm,psci-1.0
+    then:
+      properties:
+        reboot-mode: false
 
 additionalProperties: false
 
@@ -260,4 +289,17 @@ examples:
         domain-idle-states = <&cluster_ret>, <&cluster_pwrdn>;
       };
     };
+
+  - |+
+
+    // Case 5: SYSTEM_RESET2 vendor resets
+    psci {
+      compatible = "arm,psci-1.0";
+      method = "smc";
+
+      reboot-mode {
+        mode-edl = <0x80000000 1>;
+        mode-bootloader = <0x80010001 2>;
+      };
+    };
 ...

-- 
2.34.1


