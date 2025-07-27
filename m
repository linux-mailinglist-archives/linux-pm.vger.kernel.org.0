Return-Path: <linux-pm+bounces-31439-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id D5B8DB1308A
	for <lists+linux-pm@lfdr.de>; Sun, 27 Jul 2025 18:27:29 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 284E03AB891
	for <lists+linux-pm@lfdr.de>; Sun, 27 Jul 2025 16:26:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C1E57225390;
	Sun, 27 Jul 2025 16:25:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="OZynjd0b"
X-Original-To: linux-pm@vger.kernel.org
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3ED60224AFE
	for <linux-pm@vger.kernel.org>; Sun, 27 Jul 2025 16:25:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753633552; cv=none; b=TgY/p0ClpqwXRmd2K8yi32OgmqaDse72dSbiQAma7gl5ZNHB+sQ9Vj+Vtaykw+q4xbzL2J90SO+c9JYkTjfQm9+6V6p9FmR6Ao0CB7txpUKVZDANjedeur2dST3v2e/xNNlWZ2akoFY6ahx2VljTfqczLkWdGxfpxgf7GqvqJCg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753633552; c=relaxed/simple;
	bh=TXtx922bW7Cthax35l5eL6qlXJtqJfd163vx/p8QQUw=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=rxk0Vp1FhjhdR5nEFqczaPZteziVpR+SAL7CIfY/ECo4GPsQ19GJNQ0tDmH0CQdMltwsekQ4UJsKm7iHs6rR4ZNCExQBU6g4T++4+oAoB5R2h6aVO8xEvw7BCF2Gw/kxhmAlOUb1SNg2OKj54VLj+CABQaTKk2x0nSuDltX4t0M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=OZynjd0b; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279867.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 56RDagSH017033
	for <linux-pm@vger.kernel.org>; Sun, 27 Jul 2025 16:25:50 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	dVmI/zpQBLHcmY6/km9+lnVLqKzUs1cGOy2afpNbw1A=; b=OZynjd0bEGHbnJJ3
	IWW/B+kDbmJVKigmjkl1uTDl5LCq3FVamQjo/ab340CcnS6W4wYsKSqRSuDZ2xkI
	uz8pouY58AIthEQHNdVJwGEj59ZvtTQXhmLF02qtSg7q8eiTg4WaYmnR/CIQ5D0B
	1ZqsG+u5s4c+Jsx5dpDME/gZh48EggAr8o15CvWkLUA2/YO78dQ34EX0bxrsGKGw
	OZJ21VI9E33OgyfTJcE+YqK9O+ShZptev+nOH/8JKUHXN4NtqY4X98m+vKoXn8rh
	yUXH9MTJfN6Mi7Y6Nv9MoR3L0UOP9zON8kbAUOP/PewWsFd1oJ4Vb2E9CEwYx3J5
	Ylt8dw==
Received: from mail-pl1-f199.google.com (mail-pl1-f199.google.com [209.85.214.199])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 484mqk2k5n-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
	for <linux-pm@vger.kernel.org>; Sun, 27 Jul 2025 16:25:50 +0000 (GMT)
Received: by mail-pl1-f199.google.com with SMTP id d9443c01a7336-240012b74dfso4306345ad.2
        for <linux-pm@vger.kernel.org>; Sun, 27 Jul 2025 09:25:50 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1753633550; x=1754238350;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=dVmI/zpQBLHcmY6/km9+lnVLqKzUs1cGOy2afpNbw1A=;
        b=CvxfqJJHOrgYIaAukjLKOHtbHPWKqsVVjTEaszjCN2zhWBsZ+3S+b7XB2gPo3hX7x5
         1YC6RXGfVmwf+uIPiCfj/VrRbEXcIkMPnNaDWkyLBTTGVw/gCpW53TBRDL9BV0FfJ2QQ
         MhrknAPpT83mbk0DyR/oCFbKVSw/0DDM94qL2jkPu48ByL6KelBI0hO4dD6Qu31gzkku
         riRyEZX0ftdBjqLr64GFWlDDCNRTg2L+QnIIt7Jm4xZKFPUAe//DcZuge5iPt4vVFLYa
         PoSTxx4p3PmBuQJn37ypaouTM9CNMAPGEBlu0kHun/Q4oV950QlhsC+d2jdPCtcsxE6M
         Fmmg==
X-Forwarded-Encrypted: i=1; AJvYcCUdTHbitUpZXqanqKDIUNf8iDK7PpSlLRF149ANaKzBSgwSWzVpxcJvIB7JJfk7YAI+hKB9cc7V2A==@vger.kernel.org
X-Gm-Message-State: AOJu0YwV6Zs5TIa5cLFI9Fda3NqiJrLqYv6vfBddNYQBtLq9uCulms3m
	ybimcTL3zscdA6cVvyxhMtkFvfPSfYN8kJsaNM/xaLqykQOX0/rfMGANI0fpsTppIsTynmvvsHH
	IOuw5Zuwr4mY82laZ5aqeDOPMOFmbhrM0sy5g8RX9cTLlalFGpyNOBpIis7CRYA==
X-Gm-Gg: ASbGncs56CxMjShJIMwNsxkMPu8fo2FPnn2ulyNklL5ArYGhqBiYGUjbqLBcDokSb1Q
	7V/HKjzWmEDut6ASch042LHolOxPXwLtXWhrAiNFguO9buaSQWjCFMvSzsOcnoTIZLj4rFgdIlW
	CvLlh5F+WLTqgWUtWNJlFHIHB7ArkgCd+dOSBdQRz5X4rp6GIcsRIY/WxfZ4aNeFcl6ElItfA0r
	RU55XA+s7UgYHFJMy7Flb27zuvXZIbQ6tw5eY9Uf8kv7P/i0Zk9VvpwKzrHZr9EvbqZSwIuPTzd
	907+DGrYnUBxtJ6Qu2VscxpvfUMuxLTX+1ViPIjblwNl11YHkXetQGu6GuC/ug3U2haqZQBj8Za
	L
X-Received: by 2002:a17:903:1107:b0:23f:d903:d867 with SMTP id d9443c01a7336-23fd903d9fdmr68042105ad.35.1753633549299;
        Sun, 27 Jul 2025 09:25:49 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IEL3wWdtZ6aYUyxBwD4I04sxzmNGeS8xOyoLA0/pGD4nypDDQZu/utCQqLS7ndqtErXNjHKbw==
X-Received: by 2002:a17:903:1107:b0:23f:d903:d867 with SMTP id d9443c01a7336-23fd903d9fdmr68041555ad.35.1753633548710;
        Sun, 27 Jul 2025 09:25:48 -0700 (PDT)
Received: from hu-spratap-hyd.qualcomm.com ([202.46.22.19])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-23fd9397ebbsm29110325ad.210.2025.07.27.09.25.41
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 27 Jul 2025 09:25:48 -0700 (PDT)
From: Shivendra Pratap <shivendra.pratap@oss.qualcomm.com>
Date: Sun, 27 Jul 2025 21:54:49 +0530
Subject: [PATCH v13 06/10] dt-bindings: arm: Document reboot mode magic
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250727-arm-psci-system_reset2-vendor-reboots-v13-6-6b8d23315898@oss.qualcomm.com>
References: <20250727-arm-psci-system_reset2-vendor-reboots-v13-0-6b8d23315898@oss.qualcomm.com>
In-Reply-To: <20250727-arm-psci-system_reset2-vendor-reboots-v13-0-6b8d23315898@oss.qualcomm.com>
To: Bartosz Golaszewski <bartosz.golaszewski@linaro.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Sebastian Reichel <sre@kernel.org>, Rob Herring <robh@kernel.org>,
        Sudeep Holla <sudeep.holla@arm.com>,
        Souvik Chakravarty <Souvik.Chakravarty@arm.com>,
        Krzysztof Kozlowski <krzk+dt@kernel.org>,
        Conor Dooley <conor+dt@kernel.org>, Andy Yan <andy.yan@rock-chips.com>,
        Mark Rutland <mark.rutland@arm.com>,
        Lorenzo Pieralisi <lpieralisi@kernel.org>,
        Arnd Bergmann <arnd@arndb.de>, Konrad Dybcio <konradybcio@kernel.org>,
        cros-qcom-dts-watchers@chromium.org, Vinod Koul <vkoul@kernel.org>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Will Deacon <will@kernel.org>,
        Florian Fainelli <florian.fainelli@broadcom.com>
Cc: Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>,
        Mukesh Ojha <mukesh.ojha@oss.qualcomm.com>,
        Stephen Boyd <swboyd@chromium.org>,
        Andre Draszik <andre.draszik@linaro.org>, linux-pm@vger.kernel.org,
        linux-kernel@vger.kernel.org, devicetree@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-arm-msm@vger.kernel.org,
        Elliot Berman <quic_eberman@quicinc.com>,
        Shivendra Pratap <shivendra.pratap@oss.qualcomm.com>,
        Srinivas Kandagatla <srini@kernel.org>,
        Elliot Berman <elliot.berman@oss.qualcomm.com>
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=ed25519-sha256; t=1753633495; l=2577;
 i=shivendra.pratap@oss.qualcomm.com; s=20250710; h=from:subject:message-id;
 bh=Pb0JW5FgpXpfFWALyentRdrGNmebMgVj4WCNzS0Y1bY=;
 b=q2Cpgc5X/5vvp5IW+bSMM73MNGrPdxZ9TyGWHgnn7fEPw/7YCTssgw97rASyUi8M1FNatC4RE
 D62Y1b8i1PMAAg0ElzQjqtUuEhXWnmNzMVrBj50GG82dX0mbqehtdl0
X-Developer-Key: i=shivendra.pratap@oss.qualcomm.com; a=ed25519;
 pk=CpsuL7yZ8NReDPhGgq6Xn/SRoa59mAvzWOW0QZoo4gw=
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwNzI3MDE0NCBTYWx0ZWRfXzc/Hbw6FqUbo
 86w8rOC6YNjj2uwd54PP389JpOAdNH9knmuO0r67QG8E6lpRbOO+wrDKPloZF+gUdNe8yonnhW8
 nd/GLqmzgAw/ghyfu9mJflH192Dq8Di/A2ky8TrQ9fmtv5KhzyB58kju1pjwx1rjplWKSKXrBp1
 YvPXsntziRzMF8r2qrVYWBtPP956ItUN93vxXiaU+nQTY0GsVmLUoqx31OxZrIO1YXwDP1M5IGn
 3T9026YJ7NzBDrewaYHkR6IwLWBFDtkes+v13vUPVWgSAcois3GK35EMhR/73Ayu19KvQVZH26S
 SmryJL8X0t4Koc6AI8MqpBkVDsFsVjnCnpmoMXeOYh5SoaM12N31mLXTd+KjhHCwb31U/ccn2XH
 /3ql8phHJ0yWMQ4A3qKsJx4WQ+Nq579pG0Bh0PcdaojbIqkhNQrMsfX0U3gBtFGDNz3Jd5zs
X-Authority-Analysis: v=2.4 cv=fqPcZE4f c=1 sm=1 tr=0 ts=6886530e cx=c_pps
 a=JL+w9abYAAE89/QcEU+0QA==:117 a=fChuTYTh2wq5r3m49p7fHw==:17
 a=IkcTkHD0fZMA:10 a=Wb1JkmetP80A:10 a=EUspDBNiAAAA:8 a=VwQbUJbxAAAA:8
 a=UInjrUrXc7y1C1sAkbYA:9 a=QEXdDO2ut3YA:10 a=324X-CrmTo6CU4MGRt3R:22
X-Proofpoint-GUID: Do4x73GvzQDg77rYZRd7KeZB-3GPnLxT
X-Proofpoint-ORIG-GUID: Do4x73GvzQDg77rYZRd7KeZB-3GPnLxT
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-07-27_05,2025-07-24_01,2025-03-28_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 priorityscore=1501 clxscore=1015 lowpriorityscore=0 impostorscore=0
 adultscore=0 mlxscore=0 spamscore=0 mlxlogscore=999 phishscore=0 bulkscore=0
 malwarescore=0 suspectscore=0 classifier=spam authscore=0 authtc=n/a authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.19.0-2505280000
 definitions=main-2507270144

From: Elliot Berman <elliot.berman@oss.qualcomm.com>

Add bindings to describe vendor-specific reboot modes. Values here
correspond to valid parameters to vendor-specific reset types in PSCI
SYSTEM_RESET2 call.

Reviewed-by: Rob Herring (Arm) <robh@kernel.org>
Signed-off-by: Elliot Berman <elliot.berman@oss.qualcomm.com>
Signed-off-by: Shivendra Pratap <shivendra.pratap@oss.qualcomm.com>
---
 Documentation/devicetree/bindings/arm/psci.yaml | 43 +++++++++++++++++++++++++
 1 file changed, 43 insertions(+)

diff --git a/Documentation/devicetree/bindings/arm/psci.yaml b/Documentation/devicetree/bindings/arm/psci.yaml
index 7360a2849b5bd1e4cbadac533c1a7228573288d4..da3a584c76b48e313a5d4cb7c8e0c3a3628fd1bb 100644
--- a/Documentation/devicetree/bindings/arm/psci.yaml
+++ b/Documentation/devicetree/bindings/arm/psci.yaml
@@ -98,6 +98,27 @@ properties:
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
+          Parameters are named mode-xxx = <type[, cookie]>, where xxx
+          is the name of the magic reboot mode, type is the lower 31 bits
+          of the reset_type, and, optionally, the cookie value. If the cookie
+          is not provided, it is defaulted to zero.
+          The 31st bit (vendor-resets) will be implicitly set by the driver.
+
 patternProperties:
   "^power-domain-":
     $ref: /schemas/power/power-domain.yaml#
@@ -137,6 +158,15 @@ allOf:
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
+        reset-types: false
 
 additionalProperties: false
 
@@ -261,4 +291,17 @@ examples:
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
+        mode-edl = <0>;
+        mode-bootloader = <1 2>;
+      };
+    };
 ...

-- 
2.34.1


