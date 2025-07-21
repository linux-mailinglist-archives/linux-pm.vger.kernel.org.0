Return-Path: <linux-pm+bounces-31229-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 7D240B0CA7F
	for <lists+linux-pm@lfdr.de>; Mon, 21 Jul 2025 20:30:09 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id C58ED3BE152
	for <lists+linux-pm@lfdr.de>; Mon, 21 Jul 2025 18:29:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 17D802E3AE2;
	Mon, 21 Jul 2025 18:29:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="Nz9IARnS"
X-Original-To: linux-pm@vger.kernel.org
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8043F2E3399
	for <linux-pm@vger.kernel.org>; Mon, 21 Jul 2025 18:29:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753122575; cv=none; b=Pk6qt/3zdkIqevI79P8BoRackOQGiiCaU2KdJjf6ecfVqpE0ssJubePshovSa6e0/YxF9xdS7c8yny56QnE9hIopMR0kv52OFBUfSo+dIbUfDkLlptDWsjA/UugmFpP08xOpq0c0O6VZCn9B1MYRMWC7DXDblNj4gtAO/4RuL54=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753122575; c=relaxed/simple;
	bh=TXtx922bW7Cthax35l5eL6qlXJtqJfd163vx/p8QQUw=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=daSlUsitMRfdYGWmRY8/tPT4VxZh61MtVgRVPSRrErUh4ujk6xcJk2pjl+E95zZx2FjXD/7yBM3tbd5THN5t+/GgMLH29k9kqxZueTm3wHygyLUy3lnNAenz9B61Tz+mA1z9Ivglis4phmEhRVZdD5jszyOVlC6GLnxr3zT1tQw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=Nz9IARnS; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279868.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 56LH1xOq001048
	for <linux-pm@vger.kernel.org>; Mon, 21 Jul 2025 18:29:32 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	dVmI/zpQBLHcmY6/km9+lnVLqKzUs1cGOy2afpNbw1A=; b=Nz9IARnSnjy4o3WP
	enj39xfEdma5CFqTgjQsX0Ks4/lU1+Q4PTwNMxFoSdJ49AGzdBlDtcF6behBXAmQ
	FQylQDMi5F9khivZUgHTAr1iXBK1zklqqQ3iZXT/pbPF+iDGXB/9suzemK02r8lM
	f6X0yX4RgsHnxJWQEFZvoSCdVTIBcmvs/gv68JR5lXeusf/A2m09mdfIx+N6Fup/
	UvYm8f8WyqmFvjFB3bNT3a/Rwjz/LJV4Fv4qn/VoAdW+/LM4nlJdmtt9Puvb34/s
	743xUP7hPlv1EuhRzG3eUu9iCxO9ziY8IaPwgE//2YQw42ASynzefq91YxNC3c1I
	AGbdJA==
Received: from mail-pl1-f197.google.com (mail-pl1-f197.google.com [209.85.214.197])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 48044deqxr-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
	for <linux-pm@vger.kernel.org>; Mon, 21 Jul 2025 18:29:31 +0000 (GMT)
Received: by mail-pl1-f197.google.com with SMTP id d9443c01a7336-235e1d70d67so42508665ad.0
        for <linux-pm@vger.kernel.org>; Mon, 21 Jul 2025 11:29:31 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1753122571; x=1753727371;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=dVmI/zpQBLHcmY6/km9+lnVLqKzUs1cGOy2afpNbw1A=;
        b=klFTLuVYXPwWI2JKy6Y+/eZ9gG2tiqHlk7hR3peNcoipggPeDam4bpnKDVBopHZDus
         //FeOOzqZz8DX3bE7KmASWnrGSPshnKiljK9y3BbvFLNU69HKQPgUalJ00G7qCKoBCw7
         PErZwXO+9SD+JEOpcJK5884LndJ51WtnWxSCuScmiyl2HXSjqofoV/M+u5bW2ELC6qys
         o59oUG/0jGhc9jwYW6khL1l2G7t7Pd864MRHcpHwHE1i0f/815V45c/eJErPO5RsUJwL
         dEix8KQWUHqet3ftIlxnw/6iXG3NsbK/6D21ZIHw46DsQSxvMtEKmHzLml//pYx+k/lt
         j77g==
X-Forwarded-Encrypted: i=1; AJvYcCWqZ2GRGOZfYWGIKiPXrJWd+thlh1ZbRL1dXY7+tvdjxZpyTrgASExPmaBRC3f7HRETgPQkiSdSzg==@vger.kernel.org
X-Gm-Message-State: AOJu0Yy9k48Sny7Qfkec81lVtxH4uSyRmF3CZExvhYZJYOPYHNS+31wF
	51J+kfbKz7e6SJnc1YAsaL+YcI0NH59zUCNf71TT2Fx9FDDsBvbMyqIEALVT7/WnOw3UE3XpBtq
	sS2EckH2URjE5D0hEalknFNpgBt9soXFGWP9U3ZfEGIdLqVI9ifhxB4IdVLsi2A==
X-Gm-Gg: ASbGncsHQwFaBDP8k8xGDEmuAqX3mJY0BHDcpkxU6EQKoNWa+2O6Dk5bXtbl89/iG3c
	IQMz9vBZIaOmnqbdedXxywI7HxBt7TPIk0lmU0l3W0+N7KGAzkVexC1yDx2JQ14IeMIeDxRojZH
	0doJ/UwjL3uGtkarUZLxljsoYQM5Gpf8pn42HGmKDAWlYA5s+tKY4vqaqA6/ZSwyuJdee7skMHM
	Cgq6ZD7QNQECIKzw9Qe3YLv0shQf2UEILfy910CoQkOfnlP5jJZa1NHDnND+c/E8VAtmgM1Vglb
	YjQmZ4mlhB9cojgMiJsMmlsz0Z0qjBzgaAznt8EAegdr9MEvm+zIcobDB/cN2cTtsExBpSdUB7I
	i
X-Received: by 2002:a17:902:f60a:b0:234:aa98:7d41 with SMTP id d9443c01a7336-23e257608famr282083385ad.42.1753122570631;
        Mon, 21 Jul 2025 11:29:30 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IH2v+24oc4EGuXA/VCAKEi0tkhjcXI5flOV7/cv88JcfHdhd0j3Bztjw4+c1dSccqUc0h5COA==
X-Received: by 2002:a17:902:f60a:b0:234:aa98:7d41 with SMTP id d9443c01a7336-23e257608famr282082955ad.42.1753122570168;
        Mon, 21 Jul 2025 11:29:30 -0700 (PDT)
Received: from hu-spratap-hyd.qualcomm.com ([202.46.22.19])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-23e3b6ef4b8sm61414545ad.194.2025.07.21.11.29.22
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 21 Jul 2025 11:29:29 -0700 (PDT)
From: Shivendra Pratap <shivendra.pratap@oss.qualcomm.com>
Date: Mon, 21 Jul 2025 23:58:50 +0530
Subject: [PATCH v12 3/8] dt-bindings: arm: Document reboot mode magic
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250721-arm-psci-system_reset2-vendor-reboots-v12-3-87bac3ec422e@oss.qualcomm.com>
References: <20250721-arm-psci-system_reset2-vendor-reboots-v12-0-87bac3ec422e@oss.qualcomm.com>
In-Reply-To: <20250721-arm-psci-system_reset2-vendor-reboots-v12-0-87bac3ec422e@oss.qualcomm.com>
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
X-Developer-Signature: v=1; a=ed25519-sha256; t=1753122539; l=2577;
 i=shivendra.pratap@oss.qualcomm.com; s=20250710; h=from:subject:message-id;
 bh=Pb0JW5FgpXpfFWALyentRdrGNmebMgVj4WCNzS0Y1bY=;
 b=pptw5r8GqVdGNeKRHeianN38LF9fFIuF8QV2U/PQ7Mx8OoSZB0w/WPhNdsfuuQZ8vBD1NQoVo
 Czo/OiAwv1EBWHrKCYsHwu6lR2k236wFsub+A8iOZv7TumxiO4APofJ
X-Developer-Key: i=shivendra.pratap@oss.qualcomm.com; a=ed25519;
 pk=CpsuL7yZ8NReDPhGgq6Xn/SRoa59mAvzWOW0QZoo4gw=
X-Authority-Analysis: v=2.4 cv=BJ6zrEQG c=1 sm=1 tr=0 ts=687e870b cx=c_pps
 a=cmESyDAEBpBGqyK7t0alAg==:117 a=fChuTYTh2wq5r3m49p7fHw==:17
 a=IkcTkHD0fZMA:10 a=Wb1JkmetP80A:10 a=EUspDBNiAAAA:8 a=VwQbUJbxAAAA:8
 a=UInjrUrXc7y1C1sAkbYA:9 a=QEXdDO2ut3YA:10 a=1OuFwYUASf3TG4hYMiVC:22
X-Proofpoint-GUID: ECBS4Cd32vLFUazwccvs91SQ9r6xKPKf
X-Proofpoint-ORIG-GUID: ECBS4Cd32vLFUazwccvs91SQ9r6xKPKf
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwNzIxMDE2NCBTYWx0ZWRfX1axd/uEahkJ0
 DU9NGIlTOVW6AmpSojBDQTkYnWSAeOFpACxZWXUsXHRQMmARRi2hV3OtlysW447LbtmAylmuJHD
 3w9U2Gr8LRq/yeILz9V49gUIReHhj69+QLfjCBz8B9d7X+ZW8SLCRi4EKMj4kZFVzKZObg5KlE9
 aeWABSq5nqWRo7STRveHeIJIhFHX17B+UrEvw/t/MST56EeD3oPgNCSyMzV0dF3LDc+4jw1dcFi
 eFBBS4mt4COAW+M3vM+gWwe8CDKF6ehYFC9SucSXOrS1iAgVCGUkGjdGAlOgQno7vjl2WfayW4e
 2QRmdXGiVNYWsNqvRShg6oJqlXzRapxZyayfkeS84O2ZOgmUgYZlpNOOB2JBGpbhZwJ7kXXwMeq
 kE+6neaPYI8rwl5lNfwudPhGi61ejNSoa0qquHWohE/s6nBxOP/oHzqf2mEnn6wMxRy/pIR8
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-07-21_05,2025-07-21_02,2025-03-28_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 priorityscore=1501 lowpriorityscore=0 clxscore=1015 spamscore=0
 mlxlogscore=999 suspectscore=0 impostorscore=0 phishscore=0 adultscore=0
 mlxscore=0 malwarescore=0 bulkscore=0 classifier=spam authscore=0 authtc=n/a
 authcc= route=outbound adjust=0 reason=mlx scancount=1
 engine=8.19.0-2505280000 definitions=main-2507210164

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


