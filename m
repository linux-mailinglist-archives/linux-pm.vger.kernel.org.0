Return-Path: <linux-pm+bounces-32066-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 2FAA8B1E9DF
	for <lists+linux-pm@lfdr.de>; Fri,  8 Aug 2025 16:04:19 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id B06971C25319
	for <lists+linux-pm@lfdr.de>; Fri,  8 Aug 2025 14:04:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A60DE27EFEE;
	Fri,  8 Aug 2025 14:03:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="XkT+Hxdu"
X-Original-To: linux-pm@vger.kernel.org
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0724E27EC73
	for <linux-pm@vger.kernel.org>; Fri,  8 Aug 2025 14:03:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754661838; cv=none; b=MjQwagdh07nF5gRn0JxDLNXCK2X490443ea7fBhXHE7yE/WB273w8SN588Urz3GcgxYRfKgER7TGzx7V82gGoDy7zIFoY3qmn8r73KaBOC5W92hhSl2Z/QvhIO+GJ9carJaibGE8eAJWLl48uazYhe32y4AsBQOzfwJd1K1jNPA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754661838; c=relaxed/simple;
	bh=NIUgvFjTnufpMaUkhepDMTHRYMdG1B9PZQLZLAxkW70=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References; b=Vj/v9JuCQeFCYFBnfWMWDhC11CPozeguiqOvbilWg8a/5bKl1Vjgx8YN7oNo+fZKuBLH/QAlLadNx3MK+RMgvvOUd+tU1HYGWRnzk2VROq8IbOh6r42u6Udc9J1u2DXApWpc/EBJYh30FlvAmsBnaXf5BBh+92iub59Gr7ZTj8Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=XkT+Hxdu; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279867.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 5787MALn018698
	for <linux-pm@vger.kernel.org>; Fri, 8 Aug 2025 14:03:56 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:date:from:in-reply-to:message-id:references:subject:to; s=
	qcppdkim1; bh=cnwUV/QDjexBy5i2zSATpYmuz01jPJJmOp4tvR0Fjy8=; b=Xk
	T+HxduDoSB2QQmVB7zz54+Mo7dYHn/AApzxrJE1mNG/dPhFcIo2Z6QWFDef6pgrO
	PTzTqeBGVnzDaFfALKMtniB0lgPPQB2ox0Cc8LYD64IJs89LXZMEbDRS0qIzw2Fz
	gdBz1CADWa+Q7BmejfEFsB1aJAE0d5BuKoWunBjzLygXVKOkmgo2ZYV/W+vxUZrD
	3Ggkzn88o6gx16g+tDTABZYa2sHrkGqFHtFqPG4Rvo5yFN6hUUsN1pyCxke0TSuL
	rpCEMVrQog1NRx1F9HQaOW96+qY3eZ0TPwcuP4Hx20xe7hF7NRUprG4Fyl/iRXLA
	EZFEjNHNprdPInLi4Wlw==
Received: from mail-pf1-f198.google.com (mail-pf1-f198.google.com [209.85.210.198])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 48bpy8j8yx-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
	for <linux-pm@vger.kernel.org>; Fri, 08 Aug 2025 14:03:56 +0000 (GMT)
Received: by mail-pf1-f198.google.com with SMTP id d2e1a72fcca58-76bcd829ff1so2384550b3a.1
        for <linux-pm@vger.kernel.org>; Fri, 08 Aug 2025 07:03:55 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1754661834; x=1755266634;
        h=references:in-reply-to:message-id:date:subject:cc:to:from
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=cnwUV/QDjexBy5i2zSATpYmuz01jPJJmOp4tvR0Fjy8=;
        b=CU8w/yRZN5UXm5UKMEi+cfGWY36zcMTXwT4plA2QlfK8wOA7UK7Y27pRASqrosY86m
         +rJ4vt7wkKG4OWVe0i/2CQQZXt7l78RIhdRcl+rVBKDeWM8QyJLa0N3JWliZmzQ3fZRx
         a84kYh37/n5b31pEb8EBd5PeIDUL8Fdy9u34QnfkDtu1N6urkC+lDJeSYECaleGkrKbR
         0d04P9NZdEr6AmGn6CXm0RmHyYyWhphWTi4EWgb9LsSeGtkxrl1AhFkb24Ldh2sb4dQF
         jIu03X8zktx127tNKWXVwP3/I0diJklvl3s0wm5ORF/zjyeMmrYDs4iDqtiWs666hvC1
         OMUQ==
X-Forwarded-Encrypted: i=1; AJvYcCWpo056lrOgJBQo7Dpeeo/q8LgadikBNTdv56pT+kLFSO9oDZK5pVXNZ1G5NQHdInG64SbFGYUtvQ==@vger.kernel.org
X-Gm-Message-State: AOJu0Yxu8JSyVW0bHG8IVrBWc9c7CY5km2PJW5nzIsRMPsEEmwbSXC7C
	6WE3Ngd87ecm2JGnfz0It/1rssvlmt7xMAkvP5ZALFhe/Ol3Sy+JJf9S9YNf8HYGSFTGqjO2uV9
	gHIpvREO30QlMmsnyHNfJXRyynspfvxzRQZh9plwBNaX9EVjPBdF39tujxsJNsA==
X-Gm-Gg: ASbGncv54TcGnIa8jrxt0SR4crZ536OqCePn7I/3PJWim7GLhohQJChKwBQdnfPfjl1
	rEwu4s2HKLu96VetHXgRdnl/8Oe5RBBEZUI+pJCkh/WiQvpLK7tz6WjiZM6hpHHQbN017GIwmOp
	BaU6Q7l3sbY2oozrLPYg8xJ9escAR+MFl5qYBt2p/XsxnP9A7I/S98na2lZiL20CokdITuKXOTo
	+4kjdpTDZqlA1rzy1hTKKTREI4LjM21Q1c+Y5K0tq/ZY7GGkLmj6KFKZLxYv0zaDt+OCOZARUbC
	dtpKWStGDCP/MDkSx3kE37tln/kiX/fBnBNKyFqzCAWMZHuYVQYz7fiiq7J1S4P3zIgBRh2fwQ=
	=
X-Received: by 2002:a05:6a00:23d2:b0:76b:c557:b945 with SMTP id d2e1a72fcca58-76c461f7dfcmr5163486b3a.24.1754661834252;
        Fri, 08 Aug 2025 07:03:54 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IHTzksWDnpE2o7+ZsFPvW6Wq4obz7S9H+b2kg5hFSWzEbMcyjh4qUMKtT2DtOoa8U5Mt9x6nQ==
X-Received: by 2002:a05:6a00:23d2:b0:76b:c557:b945 with SMTP id d2e1a72fcca58-76c461f7dfcmr5163411b3a.24.1754661833734;
        Fri, 08 Aug 2025 07:03:53 -0700 (PDT)
Received: from hu-okukatla-hyd.qualcomm.com ([202.46.23.25])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-76c2078afd8sm8595621b3a.117.2025.08.08.07.03.49
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 08 Aug 2025 07:03:53 -0700 (PDT)
From: Odelu Kukatla <odelu.kukatla@oss.qualcomm.com>
To: Georgi Djakov <djakov@kernel.org>, Rob Herring <robh@kernel.org>,
        Krzysztof Kozlowski <krzk+dt@kernel.org>,
        Conor Dooley <conor+dt@kernel.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Konrad Dybcio <konradybcio@kernel.org>
Cc: Raviteja Laggyshetty <quic_rlaggysh@quicinc.com>,
        Odelu Kukatla <odelu.kukatla@oss.qualcomm.com>,
        Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>,
        Bartosz Golaszewski <bartosz.golaszewski@linaro.org>,
        linux-arm-msm@vger.kernel.org, linux-pm@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        Mike Tipton <mike.tipton@oss.qualcomm.com>
Subject: [PATCH 1/3] dt-bindings: interconnect: add clocks property to enable QoS on sa8775p
Date: Fri,  8 Aug 2025 19:32:58 +0530
Message-Id: <20250808140300.14784-2-odelu.kukatla@oss.qualcomm.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20250808140300.14784-1-odelu.kukatla@oss.qualcomm.com>
References: <20250808140300.14784-1-odelu.kukatla@oss.qualcomm.com>
X-Proofpoint-GUID: -wwoyvIDI3LucAriTS0RlUpQBREmPr-9
X-Proofpoint-ORIG-GUID: -wwoyvIDI3LucAriTS0RlUpQBREmPr-9
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwODA2MDAwOSBTYWx0ZWRfX4rrLbPKb/d7/
 dWEcoOtwWoppP84iOSlMQD+i2YDLZtVPZ6FcTm7Q1+N6kUq6KnC8Nw5PMt+/og8+i/Tz6XvHfDL
 4OoUFQhEbr3Xi6tvME0+o0imUd3kEWf8mVnG6XUKXLiHiyaIOA9+sEDaiN7XgVQsRI642Cw3m74
 s1T0p+s7Xmw1VJ+5oeUj67e96Aro29uhaUCLUWiJuh/HKWQVHNBj3RnBcHJiCWryZUZKFMaYMRX
 VcVIwMkxNZakwMvrvcwqqpGNXmKMigEE6RW/C/+VoXTQh/x1ieBYBiu74S90q+taaCM0LE0RCtR
 axwdNce01tfMW5lZy6BoZojQJbwkF90mVC14/Cy1OvIi3qV3DMrLKXCDvfyBICXL84XYhQ1PAzp
 EiaCErMw
X-Authority-Analysis: v=2.4 cv=GrlC+l1C c=1 sm=1 tr=0 ts=689603cc cx=c_pps
 a=m5Vt/hrsBiPMCU0y4gIsQw==:117 a=ZePRamnt/+rB5gQjfz0u9A==:17
 a=2OwXVqhp2XgA:10 a=EUspDBNiAAAA:8 a=kq7KVtybw__Sne4F7ZAA:9
 a=IoOABgeZipijB_acs4fv:22
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-08-08_04,2025-08-06_01,2025-03-28_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 spamscore=0 malwarescore=0 clxscore=1011 suspectscore=0 priorityscore=1501
 phishscore=0 adultscore=0 bulkscore=0 impostorscore=0 classifier=typeunknown
 authscore=0 authtc= authcc= route=outbound adjust=0 reason=mlx scancount=1
 engine=8.19.0-2507300000 definitions=main-2508060009
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>

Add reg and clocks properties to enable the clocks required
for accessing QoS configuration.

Signed-off-by: Odelu Kukatla <odelu.kukatla@oss.qualcomm.com>
---
 .../interconnect/qcom,sa8775p-rpmh.yaml       | 78 ++++++++++++++++++-
 1 file changed, 77 insertions(+), 1 deletion(-)

diff --git a/Documentation/devicetree/bindings/interconnect/qcom,sa8775p-rpmh.yaml b/Documentation/devicetree/bindings/interconnect/qcom,sa8775p-rpmh.yaml
index db19fd5c5708..be3d02fb73a4 100644
--- a/Documentation/devicetree/bindings/interconnect/qcom,sa8775p-rpmh.yaml
+++ b/Documentation/devicetree/bindings/interconnect/qcom,sa8775p-rpmh.yaml
@@ -33,18 +33,94 @@ properties:
       - qcom,sa8775p-pcie-anoc
       - qcom,sa8775p-system-noc
 
+  reg:
+    maxItems: 1
+
+  clocks:
+    minItems: 2
+    maxItems: 5
+
 required:
   - compatible
 
 allOf:
   - $ref: qcom,rpmh-common.yaml#
+  - if:
+      properties:
+        compatible:
+          contains:
+            enum:
+              - qcom,sa8775p-clk-virt
+              - qcom,sa8775p-mc-virt
+    then:
+      properties:
+        reg: false
+    else:
+      required:
+        - reg
+
+  - if:
+      properties:
+        compatible:
+          contains:
+            enum:
+              - qcom,sa8775p-aggre1-noc
+    then:
+      properties:
+        clocks:
+          items:
+            - description: aggre UFS PHY AXI clock
+            - description: aggre QUP PRIM AXI clock
+            - description: aggre USB2 PRIM AXI clock
+            - description: aggre USB3 PRIM AXI clock
+            - description: aggre USB3 SEC AXI clock
+
+  - if:
+      properties:
+        compatible:
+          contains:
+            enum:
+              - qcom,sa8775p-aggre2-noc
+    then:
+      properties:
+        clocks:
+          items:
+            - description: aggre UFS CARD AXI clock
+            - description: RPMH CC IPA clock
+
+  - if:
+      properties:
+        compatible:
+          contains:
+            enum:
+              - qcom,sa8775p-aggre1-noc
+              - qcom,sa8775p-aggre2-noc
+    then:
+      required:
+        - clocks
+    else:
+      properties:
+        clocks: false
 
 unevaluatedProperties: false
 
 examples:
   - |
-    aggre1_noc: interconnect-aggre1-noc {
+    #include <dt-bindings/clock/qcom,sa8775p-gcc.h>
+    clk_virt: interconnect-clk-virt {
+        compatible = "qcom,sa8775p-clk-virt";
+        #interconnect-cells = <2>;
+        qcom,bcm-voters = <&apps_bcm_voter>;
+    };
+
+    aggre1_noc: interconnect@16c0000 {
         compatible = "qcom,sa8775p-aggre1-noc";
+        reg = <0x016c0000 0x18080>;
         #interconnect-cells = <2>;
         qcom,bcm-voters = <&apps_bcm_voter>;
+        clocks = <&gcc GCC_AGGRE_UFS_PHY_AXI_CLK>,
+                 <&gcc GCC_AGGRE_NOC_QUPV3_AXI_CLK>,
+                 <&gcc GCC_AGGRE_USB2_PRIM_AXI_CLK>,
+                 <&gcc GCC_AGGRE_USB3_PRIM_AXI_CLK>,
+                 <&gcc GCC_AGGRE_USB3_SEC_AXI_CLK>;
     };
-- 
2.17.1


