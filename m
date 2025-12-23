Return-Path: <linux-pm+bounces-39857-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 61C87CD9468
	for <lists+linux-pm@lfdr.de>; Tue, 23 Dec 2025 13:34:54 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id C8A16301AD10
	for <lists+linux-pm@lfdr.de>; Tue, 23 Dec 2025 12:33:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A0CE03321D8;
	Tue, 23 Dec 2025 12:33:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="OuHLIqI8";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="PlEujr5O"
X-Original-To: linux-pm@vger.kernel.org
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1C7A822DFA5
	for <linux-pm@vger.kernel.org>; Tue, 23 Dec 2025 12:33:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1766493228; cv=none; b=lyd5USOL7Vnzhhn7Vta+QWEA22QHtXjGKAA7Y2v8gxtHpBGuF8inYbFhchfWi3RvLPCAFrb6QU8bZxEvZSKIKOQ5NGjPxCBlhK9eNftmlMESd3EZCu0gvmKYASmA6A2iMGiJcxm13qa2xjCFPaVuQ+KZxXqkR1ll9QPou3N3bdY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1766493228; c=relaxed/simple;
	bh=hqh0NA/7LUUbnoPyHkpb6aJUstRQUnXCGHG5seXrRKM=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=alX8/Vx7+hL21KsGyR5IY3Zds4F1YSAixs7pAyFQwXcpWsgSaeZORKRlCNZQYtW9hdPN7DS/WYw8KAGAhCziV1Er1gZB9f9OL8Gd5avZBM6v17Cl+Tx8h292G+UgbLyO57Yh48P5EUPa4e2g2hx1lOvXRw3rRVftNL0lI3rjq4A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=OuHLIqI8; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=PlEujr5O; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279867.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 5BN8goVQ2748768
	for <linux-pm@vger.kernel.org>; Tue, 23 Dec 2025 12:33:46 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:date:from:in-reply-to:message-id
	:mime-version:references:subject:to; s=qcppdkim1; bh=2QFJ4sRCSjI
	RUF6KSjeGSsEFmTIfdcXI/Y6g41538/s=; b=OuHLIqI8x1MWJGfhzvINflacZMx
	+ePD2Z8cazUOnQuWdp6HGbaZW5j+bMApb8OxsrithMkIaLsrUkwqnH8ZUmpJZVe1
	lXKP1BzdOHrt8sCKWSa6KKm69vZweSovtAC5k4bXm4FAIldJcGiJ4HjRsTxdgUPb
	JdJhaQAuOOLiL8ZR0P686/estr8pd4B4NnVVLg/EptTVMEI7ECIbBNzC2bDuJzaV
	RyviJz99/Ca2HkSCsGf4Q5PJYsaijFljEX9tAiwIzLX6RyL2I17vlADIWL1LWIPg
	71rYSHo1awYl1Vz9gWUnzcz2Hyk6wKww8ZxDZg2oq6yPBljw724RDoKH5cw==
Received: from mail-pf1-f197.google.com (mail-pf1-f197.google.com [209.85.210.197])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4b7h5ct2y4-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-pm@vger.kernel.org>; Tue, 23 Dec 2025 12:33:46 +0000 (GMT)
Received: by mail-pf1-f197.google.com with SMTP id d2e1a72fcca58-7f89d880668so7465186b3a.2
        for <linux-pm@vger.kernel.org>; Tue, 23 Dec 2025 04:33:46 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1766493225; x=1767098025; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=2QFJ4sRCSjIRUF6KSjeGSsEFmTIfdcXI/Y6g41538/s=;
        b=PlEujr5OgaonjaMvL3QBryJHvrgaMX9Xc/vahDBkKSZsXavQo3Xo2X6CNjch81z406
         h+I7EGEk2cczGQWmnTwT7r/gCpa8Y7oBjFdt5COxTRwQuMLWRUey+j3sGDmFoHXYOAMy
         joEDZeZpsgw+YTesBqh8hUGL9hWDP2STI1POdDxQp62bq1zvHrO4VS2IV++GXyILXr25
         xUP5Yh53o2yLjbCJBbv9QHFaIgxFNZyPGg8g88LmdYrw+Cg3pnVw2JpGc+C3y4DXpenQ
         bFOKejTSi1Db8jJGaFzcABruKuGsPOwGvXUIfc3rpZKG/c7qfGeAVSXLB3eI6+3n7HrB
         mLdA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1766493225; x=1767098025;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=2QFJ4sRCSjIRUF6KSjeGSsEFmTIfdcXI/Y6g41538/s=;
        b=qmLqj0mRpzTp285HKoE7o4fCzA+YV4r/ejLfpIkFkft8haDi7ScGgdLcKTWGiA/5Yw
         1moZuUzPE6v2ztekHpufzmSr+5D0I5Y7TIFKt5RYzQm1WfjdSEj6PfcFg8eyOwFtiZHP
         t6KsWOfrDqicb0LgXpTapckXwB0jZpMQBOX+ek4c6RCuXY07ly19dCnwZVik7IrakZTH
         10JuR9tRpP4LvSZSvsRajljXPJtVxKQigIrr98S0ig8LifBFFTsoT4xmz0m0Vu+cgrd8
         HfSPpxc6ol2pnE9RKSsUrMHLqJKN5THmGJsWSnEdD3hFOQKdUayzGlQA5jy3UyyznvBs
         yp/g==
X-Forwarded-Encrypted: i=1; AJvYcCUM5H46hQG9f3uL5hiP9jhbQuRZY/7AGHlDp5abERdp7h515leSMz3sAKdgUKzPv5ya983Medtt2w==@vger.kernel.org
X-Gm-Message-State: AOJu0YyxVELl9vv9Lo45Q7lypkfXdEiyAiB+ZBdpbqhfs7twqbvbOcMi
	HPqFjXEkC8ynsqWrqFcGWbGdqVN6Hlr/X2Df4yLqS5cbITbDr6xms1cQlK23Y4UrvdCpBxfpgal
	TNwipMEF5KT2FCWVtG1+fcpQ7b2sBf4ucXZjNUXoKZY6r2pu8yTDLKGdW+Cu0VA==
X-Gm-Gg: AY/fxX4mrdjKf+m/uL5D8n7I79+AQUQGGYzMpTVn2iZwu/7JZeITU2xfov7ws8/mdQl
	0vqsnrgWE2gJXeDHy13nVyUkZ2s8ZTu7ETW2tANkZc5oqV4SwlBsBoe8hV1M1yiChfBQW6LMpx4
	ZsE2kGiVIEd5Yx/aUIX/Z8yk+6QiSnBAXiQUnfWNFxBSJyBlJLla79DfnjaHVzRW+cV67eJOtWb
	VDPNuP5wER5c0iYclC+rC1MK2SZEKZo3JbU0fRABJEdueTe3VUICtDvjO68vdzRsF5hH+aRu35g
	/ZzMxeljO3ZBL67C3nv9Rnnpe89scz1isKXvG1OH03EKSKr57Mj6Rpm92rQRdCxPxp27VuAdiCB
	vrCTLlv1WpqxoytTZP0Rxt6ue6gmEEQ+q2nG24sE=
X-Received: by 2002:a05:6a20:975a:b0:35d:53dc:cb61 with SMTP id adf61e73a8af0-37cba052f66mr542375637.24.1766493225260;
        Tue, 23 Dec 2025 04:33:45 -0800 (PST)
X-Google-Smtp-Source: AGHT+IH2xBlIuxkENGpa6zV3sK+E4w9okraYPgPzc/6GjO9cnf7MOcxTF5wmQSxsSXvR6RdkR++LLQ==
X-Received: by 2002:a05:6a20:975a:b0:35d:53dc:cb61 with SMTP id adf61e73a8af0-37cba052f66mr542341637.24.1766493224673;
        Tue, 23 Dec 2025 04:33:44 -0800 (PST)
Received: from hu-gkohli-hyd.qualcomm.com ([202.46.23.25])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-34e921b39dfsm12936044a91.8.2025.12.23.04.33.39
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 23 Dec 2025 04:33:44 -0800 (PST)
From: Gaurav Kohli <gaurav.kohli@oss.qualcomm.com>
To: andersson@kernel.org, mathieu.poirier@linaro.org, robh@kernel.org,
        krzk+dt@kernel.org, conor+dt@kernel.org, rafael@kernel.org,
        daniel.lezcano@linaro.org, rui.zhang@intel.com, lukasz.luba@arm.com,
        konradybcio@kernel.org, amitk@kernel.org, mani@kernel.org,
        casey.connolly@linaro.org
Cc: linux-arm-msm@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-pm@vger.kernel.org,
        Gaurav Kohli <gaurav.kohli@oss.qualcomm.com>
Subject: [PATCH v1 3/8] dt-bindings: thermal: Add qcom,qmi-cooling yaml bindings
Date: Tue, 23 Dec 2025 18:02:22 +0530
Message-Id: <20251223123227.1317244-4-gaurav.kohli@oss.qualcomm.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20251223123227.1317244-1-gaurav.kohli@oss.qualcomm.com>
References: <20251223123227.1317244-1-gaurav.kohli@oss.qualcomm.com>
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUxMjIzMDEwMiBTYWx0ZWRfX57LtrOADq0jS
 3oapUhqa54pLnzyKTv6+9BXXAhnFEGz7NFUGPp2JzYJCJEvV7aCP4/Mr3z+NFCVr49ULZ8exxUj
 1DOy9Q9qzI/6Pd76qTrnOwtat01y0Bb2kBWwQla+BN2BTiV0X7b5zDix25gfSLHXtYkwS/Jp9EO
 +2yah8RBC0buZlLF+kb5z2stg3a9BCEePDWlboZSwbURrIa67IfTw1GdTc9qP+XQI2YFpCTSM4n
 y06NIidY5LJXyNg1grlchB7/KP4GnauReOwneIkPe1ARQ3P5KoJ5LE4N43+IvrCRUW5stDae3kK
 FvZ0q8H+HCDntY8aIK8GpptzkyxC51UZXWxnw80ygS54xZAY9ziQe7q+IQoPtpffV1U8UZxM1SK
 iMl9wBTtiNAxURq0+F0Y50s5gyUo8a6M4Moc8yrHuHHhLliXcP9EqN5zsgDOWgfiQZchz0hQL+G
 qoQJ0eGgfomNCzybjVA==
X-Proofpoint-ORIG-GUID: 6r2CutdZwRDOevOINnfsfW0ZL2DHataQ
X-Authority-Analysis: v=2.4 cv=LeUxKzfi c=1 sm=1 tr=0 ts=694a8c2a cx=c_pps
 a=rEQLjTOiSrHUhVqRoksmgQ==:117 a=ZePRamnt/+rB5gQjfz0u9A==:17
 a=wP3pNCr1ah4A:10 a=s4-Qcg_JpJYA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=gEfo2CItAAAA:8 a=KKAkSRfTAAAA:8 a=EUspDBNiAAAA:8 a=NXK8_YvQBftZ-6IfvBoA:9
 a=2VI0MkxyNR6bbpdq8BZq:22 a=sptkURWiP4Gy88Gu7hUp:22 a=cvBusfyB2V15izCimMoJ:22
X-Proofpoint-GUID: 6r2CutdZwRDOevOINnfsfW0ZL2DHataQ
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.9,FMLib:17.12.100.49
 definitions=2025-12-23_03,2025-12-22_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 spamscore=0 suspectscore=0 phishscore=0 priorityscore=1501 lowpriorityscore=0
 clxscore=1011 impostorscore=0 adultscore=0 bulkscore=0 malwarescore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2512120000 definitions=main-2512230102

The cooling subnode of a remoteproc represents a client of the Thermal
Mitigation Device QMI service running on it. Each subnode of the cooling
node represents a single control exposed by the service.

Add maintainer name also and update this binding for cdsp substem.

Co-developed-by: Casey Connolly <casey.connolly@linaro.org>
Signed-off-by: Gaurav Kohli <gaurav.kohli@oss.qualcomm.com>
Signed-off-by: Casey Connolly <casey.connolly@linaro.org>
---
 .../bindings/remoteproc/qcom,pas-common.yaml  |  6 ++
 .../bindings/thermal/qcom,qmi-cooling.yaml    | 99 +++++++++++++++++++
 2 files changed, 105 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/thermal/qcom,qmi-cooling.yaml

diff --git a/Documentation/devicetree/bindings/remoteproc/qcom,pas-common.yaml b/Documentation/devicetree/bindings/remoteproc/qcom,pas-common.yaml
index 63a82e7a8bf8..bbc82253f76b 100644
--- a/Documentation/devicetree/bindings/remoteproc/qcom,pas-common.yaml
+++ b/Documentation/devicetree/bindings/remoteproc/qcom,pas-common.yaml
@@ -77,6 +77,12 @@ properties:
       and devices related to the ADSP.
     unevaluatedProperties: false
 
+  cooling:
+    $ref: /schemas/thermal/qcom,qmi-cooling.yaml#
+    description:
+      Cooling subnode which represents the cooling devices exposed by the Modem.
+    unevaluatedProperties: false
+
 required:
   - clocks
   - clock-names
diff --git a/Documentation/devicetree/bindings/thermal/qcom,qmi-cooling.yaml b/Documentation/devicetree/bindings/thermal/qcom,qmi-cooling.yaml
new file mode 100644
index 000000000000..90b46712d241
--- /dev/null
+++ b/Documentation/devicetree/bindings/thermal/qcom,qmi-cooling.yaml
@@ -0,0 +1,99 @@
+# SPDX-License-Identifier: (GPL-2.0 OR BSD-2-Clause)
+# Copyright 2023 (c), Linaro Limited
+
+%YAML 1.2
+---
+$id: http://devicetree.org/schemas/thermal/qcom,qmi-cooling.yaml#
+$schema: http://devicetree.org/meta-schemas/core.yaml#
+
+title: Qualcomm QMI based thermal mitigation (TMD) cooling devices.
+
+maintainers:
+  - Caleb Connolly <caleb.connolly@linaro.org>
+  - Gaurav Kohli <gaurav.kohli@oss.qualcomm.com>
+
+description:
+  Qualcomm QMI-based TMD cooling devices are used to mitigate thermal conditions
+  across multiple remote subsystems. These devices operate based on junction temperature
+  sensors (TSENS) associated with thermal zones for each subsystem.
+
+  Each subnode corresponds to a control interface for a single instance of the TMD
+  service running on a remote subsystem.
+
+definitions:
+  tmd:
+    type: object
+    description: |
+      A single Thermal Mitigation Device exposed by a remote subsystem.
+    properties:
+      label:
+        maxItems: 1
+      "#cooling-cells":
+        $ref: /schemas/thermal/thermal-cooling-devices.yaml#/properties/#cooling-cells
+      phandle: true
+
+    required:
+      - label
+      - "#cooling-cells"
+
+    additionalProperties: false
+
+properties:
+  compatible:
+    enum:
+      - qcom,qmi-cooling-modem
+      - qcom,qmi-cooling-cdsp
+
+  vdd:
+    $ref: "#/definitions/tmd"
+    description:
+      Modem processor temperature TMD
+    properties:
+      label:
+        const: modem
+
+required:
+  - compatible
+
+allOf:
+  - if:
+      properties:
+        compatible:
+          contains:
+            const: qcom,qmi-cooling-cdsp
+    then:
+      properties:
+        cdsp_sw:
+          $ref: "#/definitions/tmd"
+          description:
+            CDSP software TMD
+          properties:
+            label:
+              const: cdsp_sw
+
+unevaluatedProperties: false
+
+examples:
+  - |
+    remoteproc-cdsp {
+        cooling {
+            compatible = "qcom,qmi-cooling-cdsp";
+
+            cdsp_sw0: cdsp_sw {
+              label = "cdsp_sw";
+              #cooling-cells = <2>;
+            };
+        };
+    };
+
+    remoteproc-cdsp1 {
+        cooling {
+            compatible = "qcom,qmi-cooling-cdsp1";
+
+            cdsp_sw1: cdsp_sw {
+              label = "cdsp_sw";
+              #cooling-cells = <2>;
+            };
+        };
+    };
+...
-- 
2.34.1


