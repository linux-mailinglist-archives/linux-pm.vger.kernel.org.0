Return-Path: <linux-pm+bounces-38809-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 2ACB0C8E875
	for <lists+linux-pm@lfdr.de>; Thu, 27 Nov 2025 14:42:11 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id E11754E7FF1
	for <lists+linux-pm@lfdr.de>; Thu, 27 Nov 2025 13:41:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EE34228C014;
	Thu, 27 Nov 2025 13:41:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="ot3q+H8U";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="ISx0NKxx"
X-Original-To: linux-pm@vger.kernel.org
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 15491286D7E
	for <linux-pm@vger.kernel.org>; Thu, 27 Nov 2025 13:41:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1764250905; cv=none; b=RrrIJ0+M8xZ+pau4WYAd99ajPtL671tf22gkDzw6LSLH+rIgPUsPuNmxC243jSaktw6kycFhRTDM29W5Q0+RT84lR1tVcZ2f+3As0b2vXMHAmGef6I3bKiv8sjxzVQDLbFKHxk/a13dkJgKf6JYFlKnQtWQghzzULUMFffuhHww=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1764250905; c=relaxed/simple;
	bh=4OUGcMg0ju5t9Xc1HUnE0WRH6R4OUaTZgUyIgpSsfbE=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=cwiRuqrH4YVm+qKVObiCn36YuEzH+Qo0ihhAC4UwkcVIeAlscX41RjClLkEdCsFjrVfXfPXVBE/0jlo7ffznLr2zfHUEEz46fesbCkUxNsYtmbT4w2jIg5JxkZ1Z5me62XK1Zo/+KbkMIMfbr4EVqxRYSpCF3CYN3LeV5IpNkC0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=ot3q+H8U; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=ISx0NKxx; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279865.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 5ARAWCmc914172
	for <linux-pm@vger.kernel.org>; Thu, 27 Nov 2025 13:41:43 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:date:from:in-reply-to:message-id
	:mime-version:references:subject:to; s=qcppdkim1; bh=EGGCcpomE3a
	1W9/bo5UCLEEy3BvQEZ0IAe49EcAnH38=; b=ot3q+H8U5jpjAxPlhuDvfVjGGoP
	m9r8c3uK5ncb+/F1NwQl9XzafMGTh/LdLtpOtVMO+E/BQ/M1xmrv8p40ebnI9Sij
	syDNR9mNCvSxu0Dy/aEZ6f/fqO2t6DNn/sX9+gfaeaPNxCOzlFX0xaxOrYVdzedQ
	+0DTezJVL5miZGWXyLj+LSLOddL42soArBkQoXlzfJodHKqzA8C93Rr5/SYioghs
	l4aEOplsVY3tQShdDDW5EIdAqcnFGle9/HdMsRr+Vrei+LAUz2f29JpWPE6II8Hc
	wfoYonjVuzDj2KXEzWWJJ8QRg3B21AtRchGnwA9JULIyCSLj0eSKsevwIDg==
Received: from mail-pl1-f199.google.com (mail-pl1-f199.google.com [209.85.214.199])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4apmynrdm3-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-pm@vger.kernel.org>; Thu, 27 Nov 2025 13:41:43 +0000 (GMT)
Received: by mail-pl1-f199.google.com with SMTP id d9443c01a7336-297dabf9fd0so12773575ad.0
        for <linux-pm@vger.kernel.org>; Thu, 27 Nov 2025 05:41:43 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1764250903; x=1764855703; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=EGGCcpomE3a1W9/bo5UCLEEy3BvQEZ0IAe49EcAnH38=;
        b=ISx0NKxx1/pdglasvdwMeOcEybUiUPQZ2Z/lmqaFOTkd4h2ZdpIp/LAdz7XnmUHVxc
         CF1AbVqLr1ArWbJp9oU08qFGooyUxAI8c9DrUNaty62jZNhSvgoD1zXI+PoqGbtBl8OF
         yaojtnJr5QQrOkLtP9vORorbOipuax2ZXJtNoa7sO/RYrd7GDUfukQjRnU2e3D2tqaIy
         vlO8Bj8kHregoledbkY/QIGrnO/qy3sg5nMEx59vT+57tE7quBqWnrxKDfWJ0BN/Mgxj
         /lSsIc1viQop7yPcbfv0Tt29Wyo9pbrPl4sKxaEMOWUmgnGFTvuu/Jc/RddYCLwdRmnW
         14GQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1764250903; x=1764855703;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=EGGCcpomE3a1W9/bo5UCLEEy3BvQEZ0IAe49EcAnH38=;
        b=kkiD2SXMVH0bh33sonSbqxGtkrya3uBemHkVbbrYgRSchttTkxxWr5EJIlai20ndqs
         fXUZmoasnQ12vSIDk8GFVDJwy80CxEhO2hpld1XtPUSfq8PCU1HYHZdEmq41jYmHHjIR
         GxkP0k5LsJzye7cLq1mGGgf9UXZQnGnAhICow58FOQCVaz6qG6KHltTXXYmBY7wUe3do
         Hf1z29pap6t2zGjar67bdWeNIZ9k3ojUUm5CuEVsMAD9WQYk2dBVYfyqBTZPUb0Atj5P
         6ygfgcmsTUU2A/d44yqn+kuPhZWEICsAByikrvyfvnpXHNRvLe/D+JL09MVGx+bQf1Ef
         J+3Q==
X-Forwarded-Encrypted: i=1; AJvYcCUCKaLEv+TkN9dBqtCv5fEvM0ozsQiD90qyjwpCaCxGjXjdL8UA6m4C9iJUxALQ2fpSUBNx7RKTxA==@vger.kernel.org
X-Gm-Message-State: AOJu0Yy+M0SJWNrvnPM1LYXqwUBdOChWwi7lnx4zbq4/DrnbffXxxOQG
	GmFtH5ywaQQJnMEPwChRagy1gClIyUbhxQ3I+QvN4AJeQRhayy0wKj7rJwwBfO5vuwTdWk/eaLG
	sJ6FAWL8Djye5PcvdvKSLrRlfUQvRuRQmgexS/7QoPUHy6eSK2TeugPSh5peEMQ==
X-Gm-Gg: ASbGnctVBHa63un5yGkuExj9cWMoJEOc4Yj3yHf3CB8mIPV3hJ3JfOhxABMR/m/SNGf
	qCrCCa3hgS5XGpuaT4Ld/U6c01LIaIpFITYL2Mug+TKwroqsdn7V3ZKm4FSJeG9VqoLH2VM2W0E
	w6m4JGPBhF6AQ3L/b7xqmrC8Z0sxdMj+rw6J6rk+DleaERW6qg9iWIWHJxCQkEbxcszbRzWQflh
	bZDieA6H9i2CUklE/y8UB56712afnhJmcUqcgFwp7vcqOzSqz2fQyMbsppF+GxLztL2cE5yDAud
	IB+DcoExXKxRyEuG+PO5pOuCTbAmGvk1np485gpto/Ddff8bo0dCI9IYMGKRh7IQdU3GPbCNudo
	7LWh3zjEnkyQapbSCd72K7Uut+N1bWxcbOwLAPr8IcmUu
X-Received: by 2002:a17:903:40ca:b0:299:dd98:fac2 with SMTP id d9443c01a7336-29b6c6b2646mr296809405ad.54.1764250901780;
        Thu, 27 Nov 2025 05:41:41 -0800 (PST)
X-Google-Smtp-Source: AGHT+IFjPx9TZ4zc6hlf6vL2I4x61Vjj7XoXSXVtdAplFXfVyPCAp+jHXWHQaeRxTNP0rXywgO7/VA==
X-Received: by 2002:a17:903:40ca:b0:299:dd98:fac2 with SMTP id d9443c01a7336-29b6c6b2646mr296808805ad.54.1764250901231;
        Thu, 27 Nov 2025 05:41:41 -0800 (PST)
Received: from hu-jprakash-hyd.qualcomm.com ([202.46.22.19])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-29bce441600sm18934875ad.29.2025.11.27.05.41.33
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 27 Nov 2025 05:41:40 -0800 (PST)
From: Jishnu Prakash <jishnu.prakash@oss.qualcomm.com>
To: jic23@kernel.org, robh@kernel.org, krzysztof.kozlowski@linaro.org,
        krzk+dt@kernel.org, conor+dt@kernel.org, agross@kernel.org,
        andersson@kernel.org, lumag@kernel.org,
        dmitry.baryshkov@oss.qualcomm.com, konradybcio@kernel.org,
        daniel.lezcano@linaro.org, sboyd@kernel.org, amitk@kernel.org,
        thara.gopinath@gmail.com, lee@kernel.org, rafael@kernel.org,
        subbaraman.narayanamurthy@oss.qualcomm.com,
        david.collins@oss.qualcomm.com, anjelique.melendez@oss.qualcomm.com,
        kamal.wadhwa@oss.qualcomm.com
Cc: rui.zhang@intel.com, lukasz.luba@arm.com, devicetree@vger.kernel.org,
        linux-arm-msm@vger.kernel.org, linux-iio@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-pm@vger.kernel.org,
        cros-qcom-dts-watchers@chromium.org, jishnu.prakash@oss.qualcomm.com,
        quic_kotarake@quicinc.com, neil.armstrong@linaro.org,
        stephan.gerhold@linaro.org,
        Jonathan Cameron <Jonathan.Cameron@huawei.com>
Subject: [PATCH V8 2/4] dt-bindings: iio: adc: Add support for QCOM PMIC5 Gen3 ADC
Date: Thu, 27 Nov 2025 19:10:34 +0530
Message-Id: <20251127134036.209905-3-jishnu.prakash@oss.qualcomm.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20251127134036.209905-1-jishnu.prakash@oss.qualcomm.com>
References: <20251127134036.209905-1-jishnu.prakash@oss.qualcomm.com>
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Proofpoint-ORIG-GUID: N1Gp-JcYVvQqWN1hB4PQGS9E33FfTxUJ
X-Authority-Analysis: v=2.4 cv=QOplhwLL c=1 sm=1 tr=0 ts=69285517 cx=c_pps
 a=JL+w9abYAAE89/QcEU+0QA==:117 a=fChuTYTh2wq5r3m49p7fHw==:17
 a=6UeiqGixMTsA:10 a=s4-Qcg_JpJYA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=VwQbUJbxAAAA:8 a=EUspDBNiAAAA:8 a=gEfo2CItAAAA:8 a=i0EeH86SAAAA:8
 a=YrMGt2jeDSw4g2R_97MA:9 a=324X-CrmTo6CU4MGRt3R:22 a=sptkURWiP4Gy88Gu7hUp:22
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUxMTI3MDEwMSBTYWx0ZWRfX/m3LvlsgDsL+
 pm8HU5j0jPsxxMwvv/4AHG4mnKCPOYwg9SwuNt5RtNVx/y9NSWGkDS0x7zF72eO406DqLk+5b1h
 ry+MTVof6Cq2qJX4VcZhna70UytCBmo/29cTb2yx7jEEJ9FHQc5573Gir1pcm/VBeoM1sASkYAL
 GH/p7uvexssbi4LehV5Dtaz74FpnN/JdBxE51TCXjLe/BCoF71zdA7WDI551+FITLH0VvArBgjv
 PRc/WF1r4EqAwPGaVlrpKWqX6qKBp3MFxhaW9hOXWlpAtKSU0QYFJvYghZ/LeN7grlDwZUzdrNQ
 SrFrceI5+ywCGg44Cy6oN1HWqmdQuIcrGjTCpln2qIWPAIk5sMo5XRNAd7V6XSewF+Gu24lKJLu
 /ppB0xsRRRi7Lt6Dz6Zc9SF8QW9vxQ==
X-Proofpoint-GUID: N1Gp-JcYVvQqWN1hB4PQGS9E33FfTxUJ
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.9,FMLib:17.12.100.49
 definitions=2025-11-25_02,2025-11-27_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 impostorscore=0 malwarescore=0 spamscore=0 lowpriorityscore=0 bulkscore=0
 clxscore=1015 priorityscore=1501 suspectscore=0 phishscore=0 adultscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2510240001 definitions=main-2511270101

For the PMIC5-Gen3 type PMICs, ADC peripheral is present in HW for the
following PMICs: PMK8550, PM8550, PM8550B and PM8550VX PMICs.

It is similar to PMIC5-Gen2, with SW communication to ADCs on all PMICs
going through PBS(Programmable Boot Sequence) firmware through a single
register interface. This interface is implemented on SDAM (Shared
Direct Access Memory) peripherals on the master PMIC PMK8550 rather
than a dedicated ADC peripheral.

Add documentation for PMIC5 Gen3 ADC and update SPMI PMIC bindings to
allow ADC5 Gen3 as adc@ subnode.

Acked-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>
Signed-off-by: Jishnu Prakash <jishnu.prakash@oss.qualcomm.com>
---
Changes since v7:
- Dropped ADC5 GEN3 channel macro definitions from bindings, based
  on discussion with Krzysztof concluded here: 
  https://lore.kernel.org/all/d10e2eea-4b86-4e1a-b7a0-54c55907a605@oss.qualcomm.com/,
  to be added separately in other patches.
- Fixed quotes to use only double quotes for "#address-cells",
  "#size-cells" and "#io-channel-cells" properties, to address Krzysztof's
  comment.
- Removed inclusion of ADC channel macro header files from ADC5 Gen3 example
  and replaced the macros used in the "reg" properties in channel nodes
  with the actual hex values.
- Removed update made under `reg` property in
  Documentation/devicetree/bindings/iio/adc/qcom,spmi-vadc-common.yaml
  which referenced ADC macro binding files, to align with change made
  in patch 1 of this series.

Changes since v6:
- Updated SPMI PMIC bindings to allow ADC5 Gen3 as adc@ subnode, to address
  Neil's comment.
- Replaced 2025 copyright in newly added files with yearless copyright,
  following new internal guidelines.
- Collected Acked-by tag from Jonathan.

Changes since v5:
- Addressed following comments from Krzysztof:
  - Increased line wrap length for top-level device description.
  - Added more details in binding description explaining how number
    of SDAM peripherals used for ADC is allocated per SoC.
  - Dropped "interrupt-names" property.
  - Moved `required` block to after the list of all properties.
  - Dropped | from patternProperties description.
  - Renamed per-PMIC binding files listing ADC channel macro names.
- Addressed following comments from Jonathan:
  - Moved ref before description, under patternProperties.
  - Arranged enum under qcom,hw-settle-time as groups of 8.

Changes since v4:
- Added ADC5 Gen3 documentation in a separate new file to avoid complicating
  existing VADC documentation file further to accomodate this device, as
  suggested by reviewers.

Changes since v3:
- Added ADC5 Gen3 documentation changes in existing qcom,spmi-vadc.yaml file
  instead of adding separate file and updated top-level constraints in documentation
  file based on discussion with reviewers.
- Dropped default SID definitions.
- Addressed other reviewer comments.

Changes since v2:
- Moved ADC5 Gen3 documentation into a separate new file.

Changes since v1:
- Updated properties separately for all compatibles to clarify usage
  of new properties and updates in usage of old properties for ADC5 Gen3.
- Avoided updating 'adc7' name to 'adc5 gen2' and just left a comment
  mentioning this convention.
- Used predefined channel IDs in individual PMIC channel definitions
  instead of numeric IDs.
- Addressed other comments from reviewers.

 .../bindings/iio/adc/qcom,spmi-adc5-gen3.yaml | 151 ++++++++++++++++++
 .../bindings/iio/adc/qcom,spmi-vadc.yaml      |   2 +
 .../bindings/mfd/qcom,spmi-pmic.yaml          |   1 +
 3 files changed, 154 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/iio/adc/qcom,spmi-adc5-gen3.yaml

diff --git a/Documentation/devicetree/bindings/iio/adc/qcom,spmi-adc5-gen3.yaml b/Documentation/devicetree/bindings/iio/adc/qcom,spmi-adc5-gen3.yaml
new file mode 100644
index 000000000000..149f4af8f4b8
--- /dev/null
+++ b/Documentation/devicetree/bindings/iio/adc/qcom,spmi-adc5-gen3.yaml
@@ -0,0 +1,151 @@
+# SPDX-License-Identifier: (GPL-2.0 OR BSD-2-Clause)
+%YAML 1.2
+---
+$id: http://devicetree.org/schemas/iio/adc/qcom,spmi-adc5-gen3.yaml#
+$schema: http://devicetree.org/meta-schemas/core.yaml#
+
+title: Qualcomm's SPMI PMIC ADC5 Gen3
+
+maintainers:
+  - Jishnu Prakash <jishnu.prakash@oss.qualcomm.com>
+
+description: |
+  SPMI PMIC5 Gen3 voltage ADC (ADC) provides interface to clients to read
+  voltage. It is a 16-bit sigma-delta ADC. It also performs the same thermal
+  monitoring function as the existing ADC_TM devices.
+
+  The interface is implemented on SDAM (Shared Direct Access Memory) peripherals
+  on the master PMIC rather than a dedicated ADC peripheral. The number of PMIC
+  SDAM peripherals allocated for ADC is not correlated with the PMIC used, it is
+  programmed in FW (PBS) and is fixed per SOC, based on the SOC requirements.
+  All boards using a particular (SOC + master PMIC) combination will have the
+  same number of ADC SDAMs supported on that PMIC.
+
+properties:
+  compatible:
+    const: qcom,spmi-adc5-gen3
+
+  reg:
+    items:
+      - description: SDAM0 base address in the SPMI PMIC register map
+      - description: SDAM1 base address
+    minItems: 1
+
+  "#address-cells":
+    const: 1
+
+  "#size-cells":
+    const: 0
+
+  "#io-channel-cells":
+    const: 1
+
+  "#thermal-sensor-cells":
+    const: 1
+
+  interrupts:
+    items:
+      - description: SDAM0 end of conversion (EOC) interrupt
+      - description: SDAM1 EOC interrupt
+    minItems: 1
+
+patternProperties:
+  "^channel@[0-9a-f]+$":
+    type: object
+    unevaluatedProperties: false
+    $ref: /schemas/iio/adc/qcom,spmi-vadc-common.yaml
+    description:
+      Represents the external channels which are connected to the ADC.
+
+    properties:
+      qcom,decimation:
+        enum: [ 85, 340, 1360 ]
+        default: 1360
+
+      qcom,hw-settle-time:
+        enum: [ 15, 100, 200, 300, 400, 500, 600, 700,
+                1000, 2000, 4000, 8000, 16000, 32000, 64000, 128000 ]
+        default: 15
+
+      qcom,avg-samples:
+        enum: [ 1, 2, 4, 8, 16 ]
+        default: 1
+
+      qcom,adc-tm:
+        description:
+          ADC_TM is a threshold monitoring feature in HW which can be enabled
+          on any ADC channel, to trigger an IRQ for threshold violation. In
+          earlier ADC generations, it was implemented in a separate device
+          (documented in Documentation/devicetree/bindings/thermal/qcom-spmi-adc-tm5.yaml.)
+          In Gen3, this feature can be enabled in the same ADC device for any
+          channel and threshold monitoring and IRQ triggering are handled in FW
+          (PBS) instead of another dedicated HW block.
+          This property indicates ADC_TM monitoring is done on this channel.
+        type: boolean
+
+required:
+  - compatible
+  - reg
+  - "#address-cells"
+  - "#size-cells"
+  - "#io-channel-cells"
+  - interrupts
+
+additionalProperties: false
+
+examples:
+  - |
+    #include <dt-bindings/interrupt-controller/irq.h>
+
+    pmic {
+      #address-cells = <1>;
+      #size-cells = <0>;
+
+      adc@9000 {
+        compatible = "qcom,spmi-adc5-gen3";
+        reg = <0x9000>, <0x9100>;
+        interrupts = <0x0 0x90 0x1 IRQ_TYPE_EDGE_RISING>,
+                      <0x0 0x91 0x1 IRQ_TYPE_EDGE_RISING>;
+        #address-cells = <1>;
+        #size-cells = <0>;
+        #io-channel-cells = <1>;
+        #thermal-sensor-cells = <1>;
+
+        /* PMK8550 Channel nodes */
+        channel@3 {
+          reg = <0x3>;
+          label = "pmk8550_die_temp";
+          qcom,pre-scaling = <1 1>;
+        };
+
+        channel@44 {
+          reg = <0x44>;
+          label = "pmk8550_xo_therm";
+          qcom,pre-scaling = <1 1>;
+          qcom,ratiometric;
+          qcom,hw-settle-time = <200>;
+          qcom,adc-tm;
+        };
+
+        /* PM8550 Channel nodes */
+        channel@103 {
+          reg = <0x103>;
+          label = "pm8550_die_temp";
+          qcom,pre-scaling = <1 1>;
+        };
+
+        /* PM8550B Channel nodes */
+        channel@78f {
+          reg = <0x78f>;
+          label = "pm8550b_vbat_sns_qbg";
+          qcom,pre-scaling = <1 3>;
+        };
+
+        /* PM8550VS_C Channel nodes */
+        channel@203 {
+          reg = <0x203>;
+          label = "pm8550vs_c_die_temp";
+          qcom,pre-scaling = <1 1>;
+        };
+      };
+    };
diff --git a/Documentation/devicetree/bindings/iio/adc/qcom,spmi-vadc.yaml b/Documentation/devicetree/bindings/iio/adc/qcom,spmi-vadc.yaml
index 16c80709a3ee..72188041e8b5 100644
--- a/Documentation/devicetree/bindings/iio/adc/qcom,spmi-vadc.yaml
+++ b/Documentation/devicetree/bindings/iio/adc/qcom,spmi-vadc.yaml
@@ -15,6 +15,8 @@ description: |
   voltage. The VADC is a 15-bit sigma-delta ADC.
   SPMI PMIC5/PMIC7 voltage ADC (ADC) provides interface to clients to read
   voltage. The VADC is a 16-bit sigma-delta ADC.
+  Note that PMIC7 ADC is the generation between PMIC5 and PMIC5 Gen3 ADC,
+  it can be considered like PMIC5 Gen2.
 
 properties:
   compatible:
diff --git a/Documentation/devicetree/bindings/mfd/qcom,spmi-pmic.yaml b/Documentation/devicetree/bindings/mfd/qcom,spmi-pmic.yaml
index 078a6886f8b1..895645a1f58b 100644
--- a/Documentation/devicetree/bindings/mfd/qcom,spmi-pmic.yaml
+++ b/Documentation/devicetree/bindings/mfd/qcom,spmi-pmic.yaml
@@ -127,6 +127,7 @@ patternProperties:
   "^adc@[0-9a-f]+$":
     type: object
     oneOf:
+      - $ref: /schemas/iio/adc/qcom,spmi-adc5-gen3.yaml#
       - $ref: /schemas/iio/adc/qcom,spmi-iadc.yaml#
       - $ref: /schemas/iio/adc/qcom,spmi-rradc.yaml#
       - $ref: /schemas/iio/adc/qcom,spmi-vadc.yaml#
-- 
2.25.1


