Return-Path: <linux-pm+bounces-32442-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id DE5B1B28222
	for <lists+linux-pm@lfdr.de>; Fri, 15 Aug 2025 16:41:24 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 13965B06AF6
	for <lists+linux-pm@lfdr.de>; Fri, 15 Aug 2025 14:38:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 730CF25A34D;
	Fri, 15 Aug 2025 14:37:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="TqQDhu5N"
X-Original-To: linux-pm@vger.kernel.org
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EE82125DD0B
	for <linux-pm@vger.kernel.org>; Fri, 15 Aug 2025 14:37:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755268640; cv=none; b=jwbfLiUUQcTd8f4nlteVqWiBO8rYGVe3UlVUV0nZHEYhWegW+RrffT6NhLHORlyfC8qqGibvAlR2LYmEwNJFcWHaLOpGFesxVsvRhzklXkMD1wf0p7HgXRNfQXccA1Ad1kqRnpC8HgOgXO9IJpv+mgDpLdjDprdtQ98m/+Ri5C0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755268640; c=relaxed/simple;
	bh=R3BNXlzor3OWM1UHW0bocrQrgSVBuB1WLn0clYEcPVU=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=V6cTUCLM9wD8zWJXRiquAb7XAJvsQXeBa30SmZ1unUwYT7Ji4qXbR3WcfoIaQm/2YmbtBR5MRZQtSLvFadYmx9TtbVtSvXydymrzZQ4PcWhq79dXVsvcIMByzl4w/rLuovtHXQVBcswqAI7wRv3VUR+sbFqbncyz4bWMcBqodlg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=TqQDhu5N; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279864.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 57FEJ7NH032046
	for <linux-pm@vger.kernel.org>; Fri, 15 Aug 2025 14:37:18 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	PIWnFWN9JswVjgeJAZVSk7CUtGSis2EJBGP3G7aJZqM=; b=TqQDhu5NO39E3C9c
	DlAWrzjgii60srxIcxtdQyWR3wXwcyKy9JAwK0Wkm68iH40LRlh4KF0IrrRmhpXr
	6qFAGIJlaLFBGp7JjQUdRqZLfsXN7WRXhs7Xlm2ZTFtbq5352fFbqIiMDh26xN13
	ThczYxNAiAWCrLaa7K8ni610KyzVaIo6QiIvBA33rjsw/1A3TntedMJwrz/fTFYK
	/rruBS/CdTEwRshhZTH7JB5THD4K/PYqwPIT6cSJ2v2WA5NDCBSTXCDOtSS0+1Cg
	DZGcn8ZPjpYxUoLBpIetD3zs3PVyvbG9Kwo0SwF2Px2+vy9drgX/osuS7JZ8kfxv
	mf+r1w==
Received: from mail-pf1-f199.google.com (mail-pf1-f199.google.com [209.85.210.199])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 48g9qa2bay-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
	for <linux-pm@vger.kernel.org>; Fri, 15 Aug 2025 14:37:18 +0000 (GMT)
Received: by mail-pf1-f199.google.com with SMTP id d2e1a72fcca58-76e2e8908fdso1688363b3a.1
        for <linux-pm@vger.kernel.org>; Fri, 15 Aug 2025 07:37:18 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1755268637; x=1755873437;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=PIWnFWN9JswVjgeJAZVSk7CUtGSis2EJBGP3G7aJZqM=;
        b=bAoFlsEF737QueFauCaAPGeptaP4oQkbQ1BTVDk76QURe6AxxM8tRKdsntxNSuMYu8
         PUlqicj5JWg2ydCWJK6kvVPL3bKShKbboEJYZk5rySrwgQZirF2H49cXMHUP74nOFRb7
         ZBBA14EczQSpKDTxF5W3K6kR6pisF5KwEEgPqYJxbbnuhSOcJKQ5P21A/BDMDe7eIhbH
         FrfSHTR/4PJuTgiPB668AXrk563UKbGwQmQKqDpPq70RhyZIp101fHlEcClqhymOqGy+
         OOhrUVw/kaeOUvHM9Kt1Rh0wa0VrjAOx6+SZ3WylQbdPNHYYsIxswHKy6LB8TtfSecOD
         VAAg==
X-Forwarded-Encrypted: i=1; AJvYcCVXej+1XJ8v8zta92qh83rP7+kJAYdy69AetDeSoaAhcT0Dud8ZmfusACFWTnPKdahzD5PvX9fJ9g==@vger.kernel.org
X-Gm-Message-State: AOJu0YyDViMwLPSeONQScrM5jY2R9/nntrEEHfNkCdVKwC3FwP9KqaiA
	ST7h8tEP72ScxPPRFWWx81BbE6BWxhMAnwyBNoSFl1cgDMELJgdq+vF0Vs8rHSSOXRlDY9lA2oG
	NPtrIyXO1sMw7avcHAC3C7YVEgQF+j1+XIO/altMnvedfhQXPiHVjCqgHWz3RAQ==
X-Gm-Gg: ASbGncvXrnfqAfGFfFadtpmVFJIJLEHZOwRxRXcOujaHszTW53vo6lZXXvrD24g+57a
	+MElrMxH6YptDnMxbeLpYwwJ8F2EbVgXn6ro3h5LgoRr7SRfwY+RI6gqF9U64yjoniEeyXultUJ
	tKDl/5jgvvrxz6F12mPeNNrSh3/84N30ichPveGm0SbkZXulOnivfxMq45qCZQjdFupkpHP/2PK
	ZKqgrTHTgDLMqOHP3QhyFY6pifFbd4KWC9vx16ANSgSrTeSX9KEa99qvdqdOOd+Bb7uFkXXzzEl
	hVfaaDSx0rZabs+3+F0O0enp97xNBETUI/zxB6zV3B94kra26Cd3kHECQC5yuL83RLeuZJGF+c7
	b
X-Received: by 2002:a05:6a20:a11e:b0:21a:d1fe:9e82 with SMTP id adf61e73a8af0-240d2f2190dmr4142983637.30.1755268637296;
        Fri, 15 Aug 2025 07:37:17 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IGgsIwndiwgMO/4XCfpnGqesl5qjzt37SrqS5fvAaqtJVwQCB8jw+J4FEIU2+q5voDUoc+zew==
X-Received: by 2002:a05:6a20:a11e:b0:21a:d1fe:9e82 with SMTP id adf61e73a8af0-240d2f2190dmr4142925637.30.1755268636830;
        Fri, 15 Aug 2025 07:37:16 -0700 (PDT)
Received: from hu-spratap-hyd.qualcomm.com ([202.46.22.19])
        by smtp.gmail.com with ESMTPSA id 41be03b00d2f7-b472d73619fsm1437576a12.39.2025.08.15.07.37.09
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 15 Aug 2025 07:37:16 -0700 (PDT)
From: Shivendra Pratap <shivendra.pratap@oss.qualcomm.com>
Date: Fri, 15 Aug 2025 20:05:11 +0530
Subject: [PATCH v14 06/10] dt-bindings: arm: Document reboot mode magic
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250815-arm-psci-system_reset2-vendor-reboots-v14-6-37d29f59ac9a@oss.qualcomm.com>
References: <20250815-arm-psci-system_reset2-vendor-reboots-v14-0-37d29f59ac9a@oss.qualcomm.com>
In-Reply-To: <20250815-arm-psci-system_reset2-vendor-reboots-v14-0-37d29f59ac9a@oss.qualcomm.com>
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
X-Developer-Signature: v=1; a=ed25519-sha256; t=1755268580; l=2577;
 i=shivendra.pratap@oss.qualcomm.com; s=20250710; h=from:subject:message-id;
 bh=SmkKRQQh3S8Gtdgd1oOIc80Ljvpw2jelYZ428aYXpJY=;
 b=L8V9bS20yn3EMfaNLrrEhrT1+PY4b++HwWpE+s1j0w7TmzQIDivAmjeMLzPy07SYrEuOq9kBl
 YPAwB3Zz27LC1Og4aQqxUCjphfUPn6ESHta7Z0UgqDXniNuFgLUnQoZ
X-Developer-Key: i=shivendra.pratap@oss.qualcomm.com; a=ed25519;
 pk=CpsuL7yZ8NReDPhGgq6Xn/SRoa59mAvzWOW0QZoo4gw=
X-Authority-Analysis: v=2.4 cv=CNMqXQrD c=1 sm=1 tr=0 ts=689f461e cx=c_pps
 a=WW5sKcV1LcKqjgzy2JUPuA==:117 a=fChuTYTh2wq5r3m49p7fHw==:17
 a=IkcTkHD0fZMA:10 a=2OwXVqhp2XgA:10 a=EUspDBNiAAAA:8 a=VwQbUJbxAAAA:8
 a=UInjrUrXc7y1C1sAkbYA:9 a=QEXdDO2ut3YA:10 a=OpyuDcXvxspvyRM73sMx:22
X-Proofpoint-GUID: 1GhP_VdBV5W48pT3SW0RENxhXDOzmkm6
X-Proofpoint-ORIG-GUID: 1GhP_VdBV5W48pT3SW0RENxhXDOzmkm6
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwODEyMDE2NCBTYWx0ZWRfXyuZEBuamdWpJ
 6TBumfde0NkjMcaSaRdx1l/qdCuXN/vl/xvf7IhZEwcCLgSJE9wQU3qolHwyOPs8evB0HiE6NR7
 bh6w4d2PYn96KkuYTfgY3PeANygVnaCYik0d4IiTRvB/LcI1ox5MbDA80bby/xCe/FFIlHttQC9
 1ygYPwBBtr9ceI1jCCe/C+7wkKCD95L3VBZw9SujtjZVVRbU2bxeZ2FL73up/21eoeOOFi6s0Zj
 dx8nIyBkoej3cUVxI48gngzDvg7jfz70S2Eu7Ri0ZoFNpytWPcm5T5jA9QZEzGwa75OF+XglLLo
 +uzelWiV8AcF5HQLdHB6l643F3si9EjIgSRcqKBa1JfPiuVXsB1QTIMHI9lF+S0H87f1oOTvi83
 WXqrfi79
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-08-15_05,2025-08-14_01,2025-03-28_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 spamscore=0 adultscore=0 phishscore=0 bulkscore=0 clxscore=1015
 malwarescore=0 impostorscore=0 priorityscore=1501 suspectscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.19.0-2507300000 definitions=main-2508120164

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
index 7360a2849b5bd1e4cbadac533c1a7228573288d4..eca38f8747d320e8371c1dc37cee2287d71821c4 100644
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
+        reboot-mode: false
 
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


