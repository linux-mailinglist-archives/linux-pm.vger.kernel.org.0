Return-Path: <linux-pm+bounces-41555-lists+linux-pm=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-pm@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id EK5zMtvheGkGtwEAu9opvQ
	(envelope-from <linux-pm+bounces-41555-lists+linux-pm=lfdr.de@vger.kernel.org>)
	for <lists+linux-pm@lfdr.de>; Tue, 27 Jan 2026 17:03:39 +0100
X-Original-To: lists+linux-pm@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 782989753F
	for <lists+linux-pm@lfdr.de>; Tue, 27 Jan 2026 17:03:39 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 08A3C30E0D68
	for <lists+linux-pm@lfdr.de>; Tue, 27 Jan 2026 15:57:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7A48035E53E;
	Tue, 27 Jan 2026 15:57:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="fL9k6hEY";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="jrWPTAeh"
X-Original-To: linux-pm@vger.kernel.org
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 919F635EDD4
	for <linux-pm@vger.kernel.org>; Tue, 27 Jan 2026 15:57:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769529474; cv=none; b=sqDcrugxAYj214teMmtXQRqtnerguegbIHN2d3vrUPgrkpYOOZfz+fVUR6T+K+R3NcsK6fRynYBxMxTwcjv2IxUh7y/pXNDU4YMeRM4M+leT3/GpPWOcThCuYVJ6mj/XfeOaUz6oNKs7NgQoZ2bQkCzwJuV2oAbjSq8krBImdf4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769529474; c=relaxed/simple;
	bh=rBN9H4kI0rq1cyFsHjZZ/dN5fz5IcTQM2qjaff5Xugc=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=Y0DOsOUmPNBkuDGZaxaiBAp8OuYllFFE1n/L8D87jQcGbP73HSjzvgUwoPcGJ47mT8B5sEUfQvm+QgBj2yEFuCPcQEvXCpnnVgLHCL9cYu7IR163M8fLahkV6M6Q+Y0+QTtFzOFaF/pl4jlH3ZWLJcf5Pswdw5JjZZgNaPrRt18=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=fL9k6hEY; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=jrWPTAeh; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279873.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 60RA6KYY3857541
	for <linux-pm@vger.kernel.org>; Tue, 27 Jan 2026 15:57:51 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:date:from:in-reply-to:message-id
	:mime-version:references:subject:to; s=qcppdkim1; bh=bDw6El/I8Qn
	/jmYF9BqPfB+N3QPvQqvwh4YJYPYnhVY=; b=fL9k6hEYKTFawRZHDjOqgkg2osb
	01SZT+oRp0kwCiznuEtDE9dFFWfbr9e2wt17XPhJaxvkY29ZBDJxqdqam8MI2zD+
	0RbbAD4YOoVZY40X0iJkfu1EHuPwK05bbz+DChU/9MNv09KJGCg+nnuL6KX0vnis
	iOxxgpbldoGvhbZOuEz+gga2xMv2382wYRulPBs8ur9Mb1xXdsKQcFAlQO47oiYa
	qkI6LqVcBqtbcrQkp5pXB60xbRwPCI9NzyIL+ttxsggjFkJJhFGzELtQgYum7WSp
	EaetbOCMvihl+1XRfsA4KrCoP22YPHjBAnn8yegQ41nRNJT/ln+j3Uak9rA==
Received: from mail-pl1-f198.google.com (mail-pl1-f198.google.com [209.85.214.198])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4bxffs3acb-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-pm@vger.kernel.org>; Tue, 27 Jan 2026 15:57:51 +0000 (GMT)
Received: by mail-pl1-f198.google.com with SMTP id d9443c01a7336-2a78c094ad6so59520045ad.1
        for <linux-pm@vger.kernel.org>; Tue, 27 Jan 2026 07:57:51 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1769529470; x=1770134270; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=bDw6El/I8Qn/jmYF9BqPfB+N3QPvQqvwh4YJYPYnhVY=;
        b=jrWPTAehauc4YN9wLtO1PZu1du4HNRPH7pbU2cX78EdJePTyKGBtvTAwg+jjfj4Ysk
         AoCwL+xfrbMbgbWJ86+2c63sIhdPg8TzUcDYfxsQx5JTBnntsRZkVnykm+Ds7WycuUFd
         XSNhvGaNot2WIQMahkEHUtt3tcCpansTJcec26kN+rGzFO6ndnBzkTlRN19c/DQIaz6D
         IIjeTGJ523vElSgnV+FRgM/MStBLM0KTHbmuhm2Bk6zA9jWvILpCU5ouz34JzHOiNl7D
         NKfp2x470MGv8Si+G9mkb3Con6Qmseyjn6FBFaGan0mxdaLCaEqMrSKWD0wE0WxekJRh
         A5XQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1769529470; x=1770134270;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=bDw6El/I8Qn/jmYF9BqPfB+N3QPvQqvwh4YJYPYnhVY=;
        b=L/9oUais5+vatzfqbEl370pxY+xpaY06J2c3AX5ikF+/DLt047Pa+4pQZa5YqXFVrg
         Dz1hSpTITPBH4L1M9YIBZ5AOPVWO5gXs4iat8FXoSEYv9jYR4XZbDNVROZy9fmEZGSdV
         Pwi6HkfgMrUacwG93HARVYBvmDHoKVUWThsvghVybwjHM0dSf+AixvChZOIVHWF25wK7
         kR00P8PJv2XRaBR01o8foB3Ydq1CqchzrwiqOG0+GvT365jnm/FhMNGLZIexnr0ENqCV
         QLh8hh4zMqT1TJ/eh6HN6vkO2um4zfJbJQ04+N/PbD/OMa31wG9otrRLe33F/FfOo4Eo
         m1uQ==
X-Forwarded-Encrypted: i=1; AJvYcCW7f/U90cYC4LNLhdxegITb+OIffMN+pRFPeqW45fqtywAFHDuJTKi2dSpxdLgw0dShhq2ZWgf6YQ==@vger.kernel.org
X-Gm-Message-State: AOJu0YwVY9hjpdPnnoOf5oBbjIKdp1G1a3SHnsingFXy4YDYa1e46akm
	DcYAzsc9ah4+UJLCaLCPjFaVlIQOzquq16AieACDwYs9A2eKWIMOnMC1/0QqKPJ2np2Jf2I+KzE
	JnzHJNRevkfFSVmAxHNGrtsFQqqHp0OKqV2Nq4pm3jZzzDydJru+Breq56Osjjg==
X-Gm-Gg: AZuq6aJSgyMWC++elg7wO3PAKfbaKJ6I3d4Q2KFbiLxccarnVeBkHYIqM4kzPaM+l3W
	KOs4khb1AhD4bgMFfGBRumvyKwaoejhxzQEHIxIyiH6nYTzDPCuwLksItj3CvMqxJCq3fDLIHfB
	ntGzzpVF+GBCN5fVrwi4c3yBGFjUY4uFbuQegq+4CLGWaHCleIDxCG7vGmQ7x4SSHn47fDeAWTW
	G7dEel3rU1JZmqG6OdguUsFlG2JcneWHwQUIhunOgFNNC06ZZRrVdI+m8v3WatiJvJvZ0Pr8z06
	cqdqadffqTka+D7oYfPd9ABWJDpkLoaEpFSU84Cz5KZy42rgsNw+I9LgPoNLFxd4noylGdlC06k
	E9qfsLT2eNDwd4vOdWZTDkRJ8rxIP5jbiHOju2QA=
X-Received: by 2002:a17:903:3583:b0:29f:cb81:8bd1 with SMTP id d9443c01a7336-2a870e0ad2emr22212565ad.55.1769529470348;
        Tue, 27 Jan 2026 07:57:50 -0800 (PST)
X-Received: by 2002:a17:903:3583:b0:29f:cb81:8bd1 with SMTP id d9443c01a7336-2a870e0ad2emr22212325ad.55.1769529469807;
        Tue, 27 Jan 2026 07:57:49 -0800 (PST)
Received: from hu-gkohli-hyd.qualcomm.com ([202.46.23.25])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2a802ede745sm120577465ad.44.2026.01.27.07.57.45
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 27 Jan 2026 07:57:49 -0800 (PST)
From: Gaurav Kohli <gaurav.kohli@oss.qualcomm.com>
To: andersson@kernel.org, mathieu.poirier@linaro.org, robh@kernel.org,
        krzk+dt@kernel.org, conor+dt@kernel.org, rui.zhang@intel.com,
        lukasz.luba@arm.com, konradybcio@kernel.org, mani@kernel.org,
        casey.connolly@linaro.org, amit.kucheria@oss.qualcomm.com
Cc: linux-arm-msm@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-pm@vger.kernel.org,
        gaurav.kohli@oss.qualcomm.com, manaf.pallikunhi@oss.qualcomm.com
Subject: [PATCH v2 2/8] dt-bindings: thermal: Add qcom,qmi-cooling yaml bindings
Date: Tue, 27 Jan 2026 21:27:16 +0530
Message-Id: <20260127155722.2797783-3-gaurav.kohli@oss.qualcomm.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20260127155722.2797783-1-gaurav.kohli@oss.qualcomm.com>
References: <20260127155722.2797783-1-gaurav.kohli@oss.qualcomm.com>
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Proofpoint-GUID: yFnodBdVZn-U61R5ook4qe-Ql6yfju_Y
X-Authority-Analysis: v=2.4 cv=YpcChoYX c=1 sm=1 tr=0 ts=6978e07f cx=c_pps
 a=MTSHoo12Qbhz2p7MsH1ifg==:117 a=ZePRamnt/+rB5gQjfz0u9A==:17
 a=vUbySO9Y5rIA:10 a=s4-Qcg_JpJYA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=gEfo2CItAAAA:8 a=EUspDBNiAAAA:8 a=sYNnw0LgJqtDHXS-OV0A:9
 a=GvdueXVYPmCkWapjIL-Q:22 a=sptkURWiP4Gy88Gu7hUp:22
X-Proofpoint-ORIG-GUID: yFnodBdVZn-U61R5ook4qe-Ql6yfju_Y
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwMTI3MDEzMCBTYWx0ZWRfX5VE47eOPe+7N
 a4Mqe3ck5Q9EyhDT53MJ2KGX+Evl6UfxV+Yakfg6GW6hETGNdohpcristmDPkwOVsAvS8/VNK73
 R7xdigWx+KqRfBoHXZ9tFWNgjAKsGM0iQZL4CzXpkvnQoKuINbCwrQNb7coZTehDLkkxyvQXuLC
 se9BUGUk3QqPIqfac2KnwmsPdRo3WNpNqpw++Tuy4scyn8DvMClcbnGpLN9tcUec1U5UnUaEkUd
 gV35f4qXMmGTpdIiAN3+ZwYtIaUQMXDVRYfrW8lihSrH0b6/WMBpPHec1kcuohHQTTmVWtpNzhE
 K94aj+6jwyZ8hW3JHgQ+Tn0y9+enaYZN5SLMupIJmK3tplf1UHAPAUyoyFWnljHADwpgUsuboKW
 Zim3CvDEvWwfFRyU3T2a+6KhNu0QO+bH00lfYplq8XRQdDbBBJKx8ez4AFdPkQBZDhMSRZjGC4S
 j/1iRbov9kz9YN/VQ4A==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-01-27_03,2026-01-27_03,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 lowpriorityscore=0 clxscore=1015 phishscore=0 impostorscore=0 suspectscore=0
 spamscore=0 malwarescore=0 bulkscore=0 adultscore=0 priorityscore=1501
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2601150000 definitions=main-2601270130
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [0.84 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	MID_CONTAINS_FROM(1.00)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[qualcomm.com,reject];
	R_MISSING_CHARSET(0.50)[];
	R_DKIM_ALLOW(-0.20)[qualcomm.com:s=qcppdkim1,oss.qualcomm.com:s=google];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FROM_NEQ_ENVFROM(0.00)[gaurav.kohli@oss.qualcomm.com,linux-pm@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	TAGGED_FROM(0.00)[bounces-41555-lists,linux-pm=lfdr.de];
	MIME_TRACE(0.00)[0:+];
	RCVD_TLS_LAST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_NONE(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	DBL_BLOCKED_OPENRESOLVER(0.00)[qualcomm.com:email,qualcomm.com:dkim,devicetree.org:url,oss.qualcomm.com:mid,oss.qualcomm.com:dkim,sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns];
	DKIM_TRACE(0.00)[qualcomm.com:+,oss.qualcomm.com:+];
	TAGGED_RCPT(0.00)[linux-pm,dt];
	RCPT_COUNT_TWELVE(0.00)[17];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	RCVD_COUNT_SEVEN(0.00)[7]
X-Rspamd-Queue-Id: 782989753F
X-Rspamd-Action: no action

The cooling subnode of a remoteproc represents a client of the Thermal
Mitigation Device QMI service running on it. Each subnode of the cooling
node represents a single control exposed by the service.

Signed-off-by: Gaurav Kohli <gaurav.kohli@oss.qualcomm.com>
---
 .../bindings/remoteproc/qcom,pas-common.yaml  |  6 ++
 .../bindings/thermal/qcom,qmi-cooling.yaml    | 72 +++++++++++++++++++
 2 files changed, 78 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/thermal/qcom,qmi-cooling.yaml

diff --git a/Documentation/devicetree/bindings/remoteproc/qcom,pas-common.yaml b/Documentation/devicetree/bindings/remoteproc/qcom,pas-common.yaml
index 68c17bf18987..6a736161d5ae 100644
--- a/Documentation/devicetree/bindings/remoteproc/qcom,pas-common.yaml
+++ b/Documentation/devicetree/bindings/remoteproc/qcom,pas-common.yaml
@@ -80,6 +80,12 @@ properties:
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
index 000000000000..0dd3bd84c176
--- /dev/null
+++ b/Documentation/devicetree/bindings/thermal/qcom,qmi-cooling.yaml
@@ -0,0 +1,72 @@
+# SPDX-License-Identifier: (GPL-2.0 OR BSD-2-Clause)
+
+%YAML 1.2
+---
+$id: http://devicetree.org/schemas/thermal/qcom,qmi-cooling.yaml#
+$schema: http://devicetree.org/meta-schemas/core.yaml#
+
+title: Qualcomm QMI based thermal mitigation (TMD) cooling devices
+
+maintainers:
+  - Gaurav Kohli <gaurav.kohli@oss.qualcomm.com>
+
+description:
+  Qualcomm QMI-based TMD cooling devices are used to mitigate thermal conditions
+  across multiple remote subsystems. These devices operate based on junction
+  temperature sensors (TSENS) associated with thermal zones for each subsystem.
+
+properties:
+  compatible:
+    enum:
+      - qcom,qmi-cooling-cdsp
+      - qcom,qmi-cooling-cdsp1
+
+patternProperties:
+  "cdsp-tmd[0-9]*$":
+    type: object
+
+    description:
+      Each subnode which represents qmi communication to CDSP.
+
+    properties:
+      label:
+        maxItems: 1
+
+      "#cooling-cells":
+        $ref: /schemas/thermal/thermal-cooling-devices.yaml#/properties/#cooling-cells
+
+    required:
+      - label
+      - "#cooling-cells"
+
+    additionalProperties: false
+
+required:
+  - compatible
+
+additionalProperties: false
+
+examples:
+  - |
+    remoteproc-cdsp {
+        cooling {
+            compatible = "qcom,qmi-cooling-cdsp";
+
+            cdsp_tmd0: cdsp-tmd0 {
+              label = "cdsp_sw";
+              #cooling-cells = <2>;
+            };
+        };
+    };
+
+  - |
+    remoteproc-cdsp1 {
+        cooling {
+            compatible = "qcom,qmi-cooling-cdsp1";
+
+            cdsp_tmd1: cdsp-tmd1 {
+              label = "cdsp_sw";
+              #cooling-cells = <2>;
+            };
+        };
+    };
-- 
2.34.1


