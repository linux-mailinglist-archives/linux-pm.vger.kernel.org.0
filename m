Return-Path: <linux-pm+bounces-39981-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 08304CE532A
	for <lists+linux-pm@lfdr.de>; Sun, 28 Dec 2025 18:02:44 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 1479B3030FDE
	for <lists+linux-pm@lfdr.de>; Sun, 28 Dec 2025 17:01:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EC8D0224AF1;
	Sun, 28 Dec 2025 17:01:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="OxIe5rbp";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="S6GFiRuo"
X-Original-To: linux-pm@vger.kernel.org
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1A28E221FBA
	for <linux-pm@vger.kernel.org>; Sun, 28 Dec 2025 17:01:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1766941295; cv=none; b=fZs5HSRxCUXUMc8jm7aOw+v7k7EQVds0Qhtku6ejsr+81lqD+Eof+w7Xn+qbGBvuEtfpnoXsy34Gt5Aat31cErmBrNL6e89ztLeXzRbtFSZD1JzU/vs6MmqhENp/t5/r3KqyYfV04xW5JbcCPemchYquItXomWySPQRc0nuyerQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1766941295; c=relaxed/simple;
	bh=Z3Uvt1g22UCAzzm9Ye5G+m0KkYhJ6zD99kCW5R0yLXs=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=gBd03YzF7LVIOFM5sKNBIgIGgqPnfZ2Xe+v+t2SNoJS0G4G8IaLYwkc1GQuUkgtIJDsG3CvkTNz8PvBgsXdfo4jOJ3R8QADtAwGr1Yi6K/peCwu5MLz4jMFExDERr8559yvQF2zDEQuB7g+Xht9Ny6/1+1vgA201sxJU00yxPf4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=OxIe5rbp; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=S6GFiRuo; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279868.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 5BSEfQP52765162
	for <linux-pm@vger.kernel.org>; Sun, 28 Dec 2025 17:01:33 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	EgkVy6DtzgeepUjDzeDturVG3Tl9T2Q5JP6w6jnsXWk=; b=OxIe5rbp2AI8i7+J
	sleeImxYtFB3KisFURIXpg9dmVXd4NIXyRYm0tQJ5b48Hn0bowHUTIKrkZYveCir
	nYoggDNWbkg+78ugS03nRjCLWajSISquA4pA4JAkfiDbh/ZFzjb+R2dmvoSZSUIN
	NMyJjDm/ROaw61QVK06iQ0c/OYldcJesoP4oVJzWxobvYBNslwT8IDlCkBnPp9zG
	uOJMW5vppnC+tCKeXGfJo0HfilqH0H2CId8joKYbv+cN5TUGrNDXXdscYSke6qwP
	Bu7g96MuPfLHbDEqcoMmePWlhBKQpvV1YdSF8ONIwdfEv006lzMfJngDBHmiMSqZ
	PItqRQ==
Received: from mail-pl1-f199.google.com (mail-pl1-f199.google.com [209.85.214.199])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4ba6sg2ggb-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-pm@vger.kernel.org>; Sun, 28 Dec 2025 17:01:32 +0000 (GMT)
Received: by mail-pl1-f199.google.com with SMTP id d9443c01a7336-29f25e494c2so96745425ad.0
        for <linux-pm@vger.kernel.org>; Sun, 28 Dec 2025 09:01:32 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1766941292; x=1767546092; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=EgkVy6DtzgeepUjDzeDturVG3Tl9T2Q5JP6w6jnsXWk=;
        b=S6GFiRuoCpbEOHsP81kGArXGdbKuzCGcmZNktIdrn1LHWloN4PLkLDi33P+Ol6nY0D
         1YUvf3Vh7U1nZwyHRIRcLzdTdapHKO42i7ubOrppeDka8cirVv6EqJ58bayY8XzwYz33
         /CnhT38ZPmQ8HDR3xbNU2xfa1/0x+ISRC9If6ff8JjLxOlYSJHdWXHxRZgq0qq14kC3w
         Ew/SslMl00hGTENG2NkB35Q2ybc5RA9PHHn87EEOqD8E7q5OchSFgjUcj7MuJVJPfIl3
         z6yQvxiV0t/86lAPlMrTvQoyt+qnVHreyClzz+2V6wmYX5yhJXB5gv0opTupsFpbl6BK
         S0cw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1766941292; x=1767546092;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-gg:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=EgkVy6DtzgeepUjDzeDturVG3Tl9T2Q5JP6w6jnsXWk=;
        b=HT54zjZyksLii5fVOeVrpUirnemJAhtacdQzxCFf5wnESLypSiVGt06M3TRLvGLK1R
         OrDKYwBYJQaK/Zo5w/sMBa1KmFfgZxkMoBwyjGLJ2ADQn9ytq+u1cy5eC3RQX5eBEeyu
         Odp3BcauoZsJ4u2JM9Ij9sKfQcMvLLapyrVeUFdSKWddhoIArOlVrID9zZ+YvswExgSg
         nNp4qe03RfR2IDqk60SlNHPjUdGRSBqDi22bID2S5VrCR7uBsTmleezToAo1D9l6vS1Q
         Mu+SxlPi5qOSjI2AHk5GLyzBuQGpZaBKk9FwhefHuyNHix2LOXqG7vrtNqveMcDZY5Ks
         AAHw==
X-Forwarded-Encrypted: i=1; AJvYcCXmAXxbBMIqiuS/pkKwM4PYV/+kPPBtf//ZNqbZQ9e3MYmDgSxzCX8bBvmtej8lB7aEv5UTzcNDyg==@vger.kernel.org
X-Gm-Message-State: AOJu0YzO6qv0S6vzjhLj5qT29emMPJNrzBaXvJh6WZv16A+bAXem47DU
	yL1QfvoqU7adLBdpvqXivIo7J089yueIWSwT5rh9c2gMiriVpSk9IvYhNEOYQCoY7XWBtFGPI+m
	1tCROxMKmP+IBNghDSJGuVkVy3E7RBL8IJs3xrx5/ZgCwy+qDZ7ua0f0ekhKfgg==
X-Gm-Gg: AY/fxX66vMTmlZXZt8H02qUEB4g1XDqV6rKROdK66Eoo0WaQfFCFmKeUfdxYOl1qTT+
	/QPZYMg3w61xu4MfW/ntzR1xOFEeKE6OvPn/0BAxhty6pnDLel/soINtcVSgoigQg3PHCccn2OW
	HB6tRlzhboYBUpzuTO5M3vL5N8MFHs6Pqqm5a6Hsf4My0VfZghtTq7Nz54/YcU1aQHRpw26Vmsd
	VgIs1vxGmT62DtApGrLwCNpJXkqp+5gyiXqu0uRibAJWmNgW2NkpXjw8E9yE/b3avwzndrF3d6p
	c/ruIai30h/Z2EguKbr7ZzjVujyDgxKCxX35gYFGXrbVoMuJBgvX3d4HgG8b+kyE2t7psL//vvl
	/eEbtXv5R7/MZp8kY0to5K7SjRRMi5MVlvts=
X-Received: by 2002:a17:902:f641:b0:2a0:acdb:ce0c with SMTP id d9443c01a7336-2a2f0d5e6b6mr328165585ad.29.1766941291493;
        Sun, 28 Dec 2025 09:01:31 -0800 (PST)
X-Google-Smtp-Source: AGHT+IFkVDTis+MO+jJ2XVc11RH1dUAvWYZWPtIZDBfV3hoUR9sZUoKcqO5XGZRumnuBx6nmZp35pg==
X-Received: by 2002:a17:902:f641:b0:2a0:acdb:ce0c with SMTP id d9443c01a7336-2a2f0d5e6b6mr328165215ad.29.1766941290854;
        Sun, 28 Dec 2025 09:01:30 -0800 (PST)
Received: from work.lan ([2409:4091:a0f4:6806:90aa:5191:e297:e185])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-7ff7ae354easm27053925b3a.16.2025.12.28.09.01.25
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 28 Dec 2025 09:01:30 -0800 (PST)
From: Manivannan Sadhasivam <manivannan.sadhasivam@oss.qualcomm.com>
Date: Sun, 28 Dec 2025 22:31:02 +0530
Subject: [PATCH v4 2/5] dt-bindings: connector: Add PCIe M.2 Mechanical Key
 M connector
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20251228-pci-m2-v4-2-5684868b0d5f@oss.qualcomm.com>
References: <20251228-pci-m2-v4-0-5684868b0d5f@oss.qualcomm.com>
In-Reply-To: <20251228-pci-m2-v4-0-5684868b0d5f@oss.qualcomm.com>
To: Bjorn Helgaas <bhelgaas@google.com>,
        Manivannan Sadhasivam <mani@kernel.org>, Rob Herring <robh@kernel.org>,
        Krzysztof Kozlowski <krzk+dt@kernel.org>,
        Conor Dooley <conor+dt@kernel.org>,
        Bartosz Golaszewski <brgl@bgdev.pl>,
        Damien Le Moal <dlemoal@kernel.org>, Niklas Cassel <cassel@kernel.org>,
        Linus Walleij <linus.walleij@linaro.org>,
        Bartosz Golaszewski <brgl@kernel.org>
Cc: linux-kernel@vger.kernel.org, linux-pci@vger.kernel.org,
        devicetree@vger.kernel.org, linux-arm-msm@vger.kernel.org,
        Stephan Gerhold <stephan.gerhold@linaro.org>,
        Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>,
        linux-pm@vger.kernel.org, linux-ide@vger.kernel.org,
        Manivannan Sadhasivam <manivannan.sadhasivam@oss.qualcomm.com>,
        Frank Li <Frank.Li@nxp.com>
X-Mailer: b4 0.14.3
X-Developer-Signature: v=1; a=openpgp-sha256; l=5734;
 i=manivannan.sadhasivam@oss.qualcomm.com; h=from:subject:message-id;
 bh=Z3Uvt1g22UCAzzm9Ye5G+m0KkYhJ6zD99kCW5R0yLXs=;
 b=owEBbQGS/pANAwAKAVWfEeb+kc71AcsmYgBpUWJZBBU6idHrl067Trml1v/iED+hvBV/J/neZ
 FwbwrikFlKJATMEAAEKAB0WIQRnpUMqgUjL2KRYJ5dVnxHm/pHO9QUCaVFiWQAKCRBVnxHm/pHO
 9bDyCACj9sp74ccPzpkJ1IG4951rGuWl8afBwQGBEi4fAyDDMKJv57y9xb2r3E4ZhIys7s22zjT
 DvdKi6U+IHgpnE5DOWQCjEuWm79P/Gfx+/juIaTkCbC8JXmzFMbfdyiNKgYhHoIKUpXSvA++3kq
 J6qKuqASYnaMz7hlXKUsU5KHPL/Z9bHUIVX+Z/mQju/dAXsblt96Nd55mfsKgc4LfvxzsqkOTJj
 AuA5VUMfteeSv2DHO2PHP/kjK09m7sy3dBcwyNwk2GLqg8RW57J9vFsGq3X+YN3vyKNnVwWJewe
 9j0czX0BdzpmH8hDO3DmYgLPw3qgUsRxjEi6kJBbhIFB+CMe
X-Developer-Key: i=manivannan.sadhasivam@oss.qualcomm.com; a=openpgp;
 fpr=C668AEC3C3188E4C611465E7488550E901166008
X-Proofpoint-GUID: 31gbIkguTwFCh52QrdkGp3D2UHQLM-aY
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUxMjI4MDE1NiBTYWx0ZWRfX1uPiL/K+tlTg
 MUSocAxy4SunuJjHn3njevG6UmwmAkASK9qW6rMJdEPGURHUeivZmTc1HMw5UC7CQPFK77sss7F
 19aU1S915qX/2uIQez5ronSQqi5f++YuFeoSlDOTIxcBP0ePW3yjtx7zryR2sNpz6T6oIb3eNuq
 Ze0OUmqq74C/yX/fVAuVYRazYNQnIN1yCLdOI0ROtHsdBNhF5uom/aklmhBqKPd2tS5yXUyEhXS
 DVh7xEOQP7vi5mnWzk9z3wgXj8Q+h61hmB8wpX3p6f6ABygudKzdoa6xAGnktMc1dKHVXsRgB2n
 PrCd3dO/JUci0Rm99Rd30wgDWiWHtDDXnbG6/b458UK29e1ULcgzV2Ut+93hEAAajaz8BxKHUFC
 dS4JQKSbIPpjSkfw0qtkV8PG2V/TSrG9StpBIC5Oy7IYQaC4xxG/j9JFDZeJHkCz6aFyf8ofguT
 hkbmfYj6DGudJAAYIqg==
X-Proofpoint-ORIG-GUID: 31gbIkguTwFCh52QrdkGp3D2UHQLM-aY
X-Authority-Analysis: v=2.4 cv=Y+L1cxeN c=1 sm=1 tr=0 ts=6951626d cx=c_pps
 a=JL+w9abYAAE89/QcEU+0QA==:117 a=xqWC_Br6kY4A:10 a=IkcTkHD0fZMA:10
 a=wP3pNCr1ah4A:10 a=s4-Qcg_JpJYA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=gEfo2CItAAAA:8 a=8AirrxEcAAAA:8 a=EUspDBNiAAAA:8 a=wQxqEM7SeJhtJFFEbD4A:9
 a=QEXdDO2ut3YA:10 a=324X-CrmTo6CU4MGRt3R:22 a=sptkURWiP4Gy88Gu7hUp:22
 a=ST-jHhOKWsTCqRlWije3:22
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.9,FMLib:17.12.100.49
 definitions=2025-12-28_06,2025-12-26_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 impostorscore=0 spamscore=0 malwarescore=0 clxscore=1015 phishscore=0
 lowpriorityscore=0 priorityscore=1501 suspectscore=0 bulkscore=0 adultscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2512120000 definitions=main-2512280156

Add the devicetree binding for PCIe M.2 Mechanical Key M connector defined
in the PCI Express M.2 Specification, r4.0, sec 5.3. This connector
provides interfaces like PCIe and SATA to attach the Solid State Drives
(SSDs) to the host machine along with additional interfaces like USB, and
SMBus for debugging and supplementary features. At any point of time, the
connector can only support either PCIe or SATA as the primary host
interface.

The connector provides a primary power supply of 3.3v, along with an
optional 1.8v VIO supply for the Adapter I/O buffer circuitry operating at
1.8v sideband signaling.

The connector also supplies optional signals in the form of GPIOs for fine
grained power management.

Reviewed-by: Frank Li <Frank.Li@nxp.com>
Signed-off-by: Manivannan Sadhasivam <manivannan.sadhasivam@oss.qualcomm.com>
---
 .../bindings/connector/pcie-m2-m-connector.yaml    | 133 +++++++++++++++++++++
 1 file changed, 133 insertions(+)

diff --git a/Documentation/devicetree/bindings/connector/pcie-m2-m-connector.yaml b/Documentation/devicetree/bindings/connector/pcie-m2-m-connector.yaml
new file mode 100644
index 000000000000..e912ee6f6a59
--- /dev/null
+++ b/Documentation/devicetree/bindings/connector/pcie-m2-m-connector.yaml
@@ -0,0 +1,133 @@
+# SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause)
+%YAML 1.2
+---
+$id: http://devicetree.org/schemas/connector/pcie-m2-m-connector.yaml#
+$schema: http://devicetree.org/meta-schemas/core.yaml#
+
+title: PCIe M.2 Mechanical Key M Connector
+
+maintainers:
+  - Manivannan Sadhasivam <manivannan.sadhasivam@oss.qualcomm.com>
+
+description:
+  A PCIe M.2 M connector node represents a physical PCIe M.2 Mechanical Key M
+  connector. The Mechanical Key M connectors are used to connect SSDs to the
+  host system over PCIe/SATA interfaces. These connectors also offer optional
+  interfaces like USB, SMBus.
+
+properties:
+  compatible:
+    const: pcie-m2-m-connector
+
+  vpcie3v3-supply:
+    description: A phandle to the regulator for 3.3v supply.
+
+  vpcie1v8-supply:
+    description: A phandle to the regulator for VIO 1.8v supply.
+
+  ports:
+    $ref: /schemas/graph.yaml#/properties/ports
+    description: OF graph bindings modeling the interfaces exposed on the
+      connector. Since a single connector can have multiple interfaces, every
+      interface has an assigned OF graph port number as described below.
+
+    properties:
+      port@0:
+        $ref: /schemas/graph.yaml#/properties/port
+        description: Host interfaces of the connector
+
+        properties:
+          endpoint@0:
+            $ref: /schemas/graph.yaml#/properties/endpoint
+            description: PCIe interface
+
+          endpoint@1:
+            $ref: /schemas/graph.yaml#/properties/endpoint
+            description: SATA interface
+
+        anyOf:
+          - required:
+              - endpoint@0
+          - required:
+              - endpoint@1
+
+      port@1:
+        $ref: /schemas/graph.yaml#/properties/port
+        description: USB 2.0 interface
+
+      i2c-parent:
+        $ref: /schemas/types.yaml#/definitions/phandle
+        description: SMBus interface
+
+    required:
+      - port@0
+
+  clocks:
+    description: 32.768 KHz Suspend Clock (SUSCLK) input from the host system to
+      the M.2 card. Refer, PCI Express M.2 Specification r4.0, sec 3.1.12.1 for
+      more details.
+    maxItems: 1
+
+  pedet-gpios:
+    description: GPIO input to PEDET signal. This signal is used by the host
+      systems to determine the communication protocol that the M.2 card uses;
+      SATA signaling (low) or PCIe signaling (high). Refer, PCI Express M.2
+      Specification r4.0, sec 3.3.4.2 for more details.
+    maxItems: 1
+
+  viocfg-gpios:
+    description: GPIO output to IO voltage configuration (VIO_CFG) signal. This
+      signal is used by the M.2 card to indicate to the host system that the
+      card supports an independent IO voltage domain for the sideband signals.
+      Refer, PCI Express M.2 Specification r4.0, sec 3.1.15.1 for more details.
+    maxItems: 1
+
+  pwrdis-gpios:
+    description: GPIO input to Power Disable (PWRDIS) signal. This signal is
+      used by the host system to disable power on the M.2 card. Refer, PCI
+      Express M.2 Specification r4.0, sec 3.3.5.2 for more details.
+    maxItems: 1
+
+  pln-gpios:
+    description: GPIO output to Power Loss Notification (PLN#) signal. This
+      signal is use to notify the M.2 card by the host system that the power
+      loss event is expected to occur. Refer, PCI Express M.2 Specification
+      r4.0, sec 3.2.17.1 for more details.
+    maxItems: 1
+
+  plas3-gpios:
+    description: GPIO output to Power Loss Acknowledge (PLA_S3#) signal. This
+      signal is used by the M.2 card to notify the host system, the status of
+      the M.2 card's preparation for power loss.
+    maxItems: 1
+
+required:
+  - compatible
+  - vpcie3v3-supply
+
+additionalProperties: false
+
+examples:
+  # PCI M.2 Key M connector for SSDs with PCIe interface
+  - |
+    connector {
+        compatible = "pcie-m2-m-connector";
+        vpcie3v3-supply = <&vreg_nvme>;
+
+        ports {
+            #address-cells = <1>;
+            #size-cells = <0>;
+
+            port@0 {
+                #address-cells = <1>;
+                #size-cells = <0>;
+
+                reg = <0>;
+
+                endpoint@0 {
+                    reg = <0>;
+                    remote-endpoint = <&pcie6_port0_ep>;
+                };
+            };
+        };
+    };

-- 
2.48.1


