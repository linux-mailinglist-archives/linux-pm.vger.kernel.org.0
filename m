Return-Path: <linux-pm+bounces-41508-lists+linux-pm=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-pm@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id 8JXLDdQveGn5ogEAu9opvQ
	(envelope-from <linux-pm+bounces-41508-lists+linux-pm=lfdr.de@vger.kernel.org>)
	for <lists+linux-pm@lfdr.de>; Tue, 27 Jan 2026 04:24:04 +0100
X-Original-To: lists+linux-pm@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 90EA68F86C
	for <lists+linux-pm@lfdr.de>; Tue, 27 Jan 2026 04:24:03 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 0A8253049940
	for <lists+linux-pm@lfdr.de>; Tue, 27 Jan 2026 03:22:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8276C30AAAF;
	Tue, 27 Jan 2026 03:22:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="nqMQpM1w";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="Wpbcqhyt"
X-Original-To: linux-pm@vger.kernel.org
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B176F301717
	for <linux-pm@vger.kernel.org>; Tue, 27 Jan 2026 03:22:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769484158; cv=none; b=HSSHWWq0ZMMEHZXPw55clKuecDh+G+jEHhIaw3CWyV3tnYFoSeDsL3ZmSUsOUpAILoxwYGqsefi+IUX28sxdvfdPqkuq4KhOMhjbYo19ehZtYZgDEquskVIEopQ/ebfG9o+w97W4xCwILB2vvRbjNB4wExlBZb3iJMmdSQPikk8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769484158; c=relaxed/simple;
	bh=cs4/U0yCoIK14CAokJ4FgfwNwI8yPzhO6UzxegPP8to=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=qC4YuUSB+4lvyrMiv0VRprRGoLS/DzSe375HwofXGKcb9TGzijUB1G7Ua353gQjEQGG5193VUESChOLTszptAe5DT30UGIgQuAaCt6UCmmRi0Xj0wbEanCI39ViUtIQ86sqT+nYMCeWHlYe3KiBWg/fUmcIHrj2gQMZBiDR8gUA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=nqMQpM1w; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=Wpbcqhyt; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279873.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 60QKhPqc2881892
	for <linux-pm@vger.kernel.org>; Tue, 27 Jan 2026 03:22:35 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	U9Qq7IFWdko0kN7I5C2MTVrPBpRcROGKPHud5ivKK0w=; b=nqMQpM1w2ko07H3h
	HcJ1j3O/mnJt0l1kfZbZ3kogwGo5RvNZ0SrikOXI6CVGQthHVPJ9Hl/7kh+Lo4ez
	wlMtkc+4bD/ybY83N21ZCaLp8MRK3yT/BFNU1VEYB7AlkobeoBckBwVK/fqmCDOg
	y33HQEXrvByAt0yaX40QrIFOeQ0sYfu/AvaTqDBeDsPwAUh7m7J/DsWPt4CdpllD
	flimIRzzCBX1du7s62V/Jn2FS8PxhKLwcnHnfnXgEJsZ5DNyVQXOKprS3nMxtJaC
	HFurZhGTH2QOY9XAWCCBkituL73DwuhQ6xloXXbh1DvBfPCkHop4h0va/TlCpSTb
	VE/3SA==
Received: from mail-pl1-f198.google.com (mail-pl1-f198.google.com [209.85.214.198])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4bxffs0wdh-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-pm@vger.kernel.org>; Tue, 27 Jan 2026 03:22:35 +0000 (GMT)
Received: by mail-pl1-f198.google.com with SMTP id d9443c01a7336-29f2381ea85so109570685ad.0
        for <linux-pm@vger.kernel.org>; Mon, 26 Jan 2026 19:22:35 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1769484155; x=1770088955; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=U9Qq7IFWdko0kN7I5C2MTVrPBpRcROGKPHud5ivKK0w=;
        b=Wpbcqhytqr3qsJzUqH40UTi5Fh8bvL2eoxJz/yDSSXDWSdcjGu9aEa2+qAw4u3LlDH
         3RaL/bwaDebJvKlWm2OPKQ6nDbDitW/73etrIqRfzVdWqrXV6Wyc4+0papcwXsl7MXQv
         KZ691P+1u4PsCwNONUDjYjKP1WKvJhDUDn8Ahz+J6DK8t4p+NKJOiW09jzP2ZaZXkXd2
         l9egYctZ60LhptH+yTsyVlLeOHiQ2bsf3v8lcoRqyzIFfJnh15c6UCBj0dLi+C92GAkJ
         JlEExzQfr94uUXUZeo4VhShGyDoUQvyujxzxF6/bcKPtso3tfpTGuC2ARoGwWMiAN49p
         Np8A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1769484155; x=1770088955;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-gg:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=U9Qq7IFWdko0kN7I5C2MTVrPBpRcROGKPHud5ivKK0w=;
        b=GaFc9qiYG71UrJVu7bkk9EfscC5RM40ogVc/KI7+ZCtT+u2DRmwTyMj2RAIelHSQiA
         6CD97pJNsrX8L5xc5RsMUW8Bumc3m6acjnbmBjqvB3d48UK1tST6bWlT7pZHfl1vi3OJ
         CxsJc+dOboESFbs+ySX+9mPuH5WzekYfEybxUZ4Hs/nundyYTBXkzNrP6JYdqxSzOYm5
         X04BVI/ZVwdgJzNTnNfPHdD3bFtLD0NXlVpzcAaTHTJMUA5d3edDAuaz5hVCpIqL6Qv7
         PHBeFrhlsoMJLdSbwuLegQKKHHxc+OJFnywox76WIP+7o727sxoK1bQC3GHTpbCQizDP
         7E1g==
X-Forwarded-Encrypted: i=1; AJvYcCXAKWxgK6DZ77wJ5+lJandLh5CRW5y1wuI8oV/NntVYUJT535KuDyqgmKPUbMKD9L31n1LAYjIpqA==@vger.kernel.org
X-Gm-Message-State: AOJu0YwSRx2F12plIcPXq2ar+sA2bFg/M/TNmThPSIL6RZhRqmW8Z568
	8UrscgXIefaJdvPUGrMKj3ACI4AF8wY6atu7cXFhrZYZa0ry70jI/iCCKTH4hdTMWVR5WrDN6l1
	6HF6NH4wP3TABAfid2WDP1Ibdp2GxWTIR78k05TJSNHL3uTU+dfFRWvqoO8BI5A==
X-Gm-Gg: AZuq6aIoasYlix6ZLscC6bG3gEI6Vmo6yMV4lQ58Dri5qfHM7269lno1LAmuWEEzI65
	0FAHCXMTIaWL1P69+UVRg24Iuu6ZiRCeXTsMUqEXVofhxpEtM0FiVRhLmmnOM6T2MszsdQWU/+8
	PXmSugcBVU+XaU3lD9rxnTmgwlQlDH4WPRRi3eNXcOfVdeHjz3bJrZmxkx0Iw74wOIxy3djLM71
	XIkI7eJSDoywe6CxrlHPUSaa8RAHQREJOt9SfVw/1ScIC05GdJqVulVmUqai/EpCioxfk6u9eih
	4orfaF/8GkwCilXE33N/p9ZEYEqtdDOJalVE7qwq1IgmfTZY933W4Knf6PMYjl1iis/ri7fuX5P
	jyZ/TI6A+8NLdKSgaDPzX3W5SIHA4a5PT
X-Received: by 2002:a17:903:2344:b0:297:e3c4:b2b0 with SMTP id d9443c01a7336-2a870df545bmr3939785ad.54.1769484154618;
        Mon, 26 Jan 2026 19:22:34 -0800 (PST)
X-Received: by 2002:a17:903:2344:b0:297:e3c4:b2b0 with SMTP id d9443c01a7336-2a870df545bmr3939505ad.54.1769484154153;
        Mon, 26 Jan 2026 19:22:34 -0800 (PST)
Received: from [169.254.0.6] ([202.46.22.19])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2a802daa874sm101341625ad.13.2026.01.26.19.22.31
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 26 Jan 2026 19:22:33 -0800 (PST)
From: Raviteja Laggyshetty <raviteja.laggyshetty@oss.qualcomm.com>
Date: Tue, 27 Jan 2026 03:22:06 +0000
Subject: [PATCH v2 1/2] dt-bindings: interconnect: document the RPMh
 Network-On-Chip interconnect in Mahua SoC
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260127-mahua_icc-v2-1-f0d8ddf7afca@oss.qualcomm.com>
References: <20260127-mahua_icc-v2-0-f0d8ddf7afca@oss.qualcomm.com>
In-Reply-To: <20260127-mahua_icc-v2-0-f0d8ddf7afca@oss.qualcomm.com>
To: Georgi Djakov <djakov@kernel.org>, Rob Herring <robh@kernel.org>,
        Krzysztof Kozlowski <krzk+dt@kernel.org>,
        Conor Dooley <conor+dt@kernel.org>,
        Raviteja Laggyshetty <raviteja.laggyshetty@oss.qualcomm.com>,
        Mike Tipton <mike.tipton@oss.qualcomm.com>
Cc: linux-arm-msm@vger.kernel.org, linux-pm@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        Odelu Kukatla <odelu.kukatla@oss.qualcomm.com>
X-Mailer: b4 0.14.2
X-Proofpoint-GUID: n9NCvAw1TOkjtznDTLQUI8leu2Ws64Xv
X-Authority-Analysis: v=2.4 cv=YpcChoYX c=1 sm=1 tr=0 ts=69782f7b cx=c_pps
 a=MTSHoo12Qbhz2p7MsH1ifg==:117 a=fChuTYTh2wq5r3m49p7fHw==:17
 a=IkcTkHD0fZMA:10 a=vUbySO9Y5rIA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=gEfo2CItAAAA:8 a=EUspDBNiAAAA:8
 a=XbHj8r4lGLmVoAHgLPwA:9 a=QEXdDO2ut3YA:10 a=GvdueXVYPmCkWapjIL-Q:22
 a=sptkURWiP4Gy88Gu7hUp:22
X-Proofpoint-ORIG-GUID: n9NCvAw1TOkjtznDTLQUI8leu2Ws64Xv
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwMTI3MDAyNSBTYWx0ZWRfX076SRZyeN24d
 +pTZOumhVUB+7JNJlQt0yALgKIRDpaeReuztNvLSm++T0jK7PkH7euhISbjlDsF3b3O/OwUgRYk
 8ZatUwMMCfAKGKmZREXcdc8m6JcAA30UPfXS1EAYe3BzBqsyEE1mjko6k6ZB3hkVTpNi3XziWDY
 1F97eyCTqiFqgEcMV8bcbQQC52C4nHiISPqhqlJVD+8ViLcHsTtH3El/jxfZFljw9vmiCgb9sno
 hKETi275d6FuDO/WTZ+O38Na8bwufsCQOkj+/c0XQ8yhBpjdTYBLTOr5XD/nOISrqXZHWaZvwgo
 AO+OAhEQMp90QaaJZv1UkEfKi9T+ooT5ESWazTibtUcbXxh7D/tvuV/iJxS9AszmzD20HUq1Mj/
 mGSXM/e7JmgjKvi2WY/WkqfwAGyoeIQRGq0zgV2ChGG9Z5KxMCB5welOlio5oTIS7U3KEry59hj
 CHcmR/qHOkXE4o6pYSQ==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.20,FMLib:17.12.100.49
 definitions=2026-01-27_01,2026-01-26_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 lowpriorityscore=0 clxscore=1015 phishscore=0 impostorscore=0 suspectscore=0
 spamscore=0 malwarescore=0 bulkscore=0 adultscore=0 priorityscore=1501
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2601150000 definitions=main-2601270025
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[qualcomm.com,reject];
	R_DKIM_ALLOW(-0.20)[qualcomm.com:s=qcppdkim1,oss.qualcomm.com:s=google];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	DKIM_TRACE(0.00)[qualcomm.com:+,oss.qualcomm.com:+];
	DBL_BLOCKED_OPENRESOLVER(0.00)[devicetree.org:url,oss.qualcomm.com:mid,oss.qualcomm.com:dkim,sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,qualcomm.com:email,qualcomm.com:dkim];
	RCVD_TLS_LAST(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	TAGGED_FROM(0.00)[bounces-41508-lists,linux-pm=lfdr.de];
	MIME_TRACE(0.00)[0:+];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[linux-pm,dt];
	FROM_NEQ_ENVFROM(0.00)[raviteja.laggyshetty@oss.qualcomm.com,linux-pm@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	MID_RHS_MATCH_FROM(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	RCPT_COUNT_SEVEN(0.00)[11];
	RCVD_COUNT_SEVEN(0.00)[7]
X-Rspamd-Queue-Id: 90EA68F86C
X-Rspamd-Action: no action

Document the RPMh Network-on-Chip (NoC) interconnect for the Qualcomm
Mahua platform.

Mahua is a derivative of the Glymur SoC. Many interconnect nodes are
identical and continue to use Glymur fallback compatibles. Mahua
introduces SoC-specific configurations and topologies for several
NoC blocks, including CNOC, HSCNOC, PCIe West ANoC/Slave NoCs.
This updates the existing Glymur yaml schema to include Mahua-specific
compatible strings, using two-cell "fallback" compatibles wherever
the hardware is identical with Glymur.

Co-developed-by: Odelu Kukatla <odelu.kukatla@oss.qualcomm.com>
Signed-off-by: Odelu Kukatla <odelu.kukatla@oss.qualcomm.com>
Signed-off-by: Raviteja Laggyshetty <raviteja.laggyshetty@oss.qualcomm.com>
---
 .../bindings/interconnect/qcom,glymur-rpmh.yaml    | 132 +++++++++++++++++----
 1 file changed, 109 insertions(+), 23 deletions(-)

diff --git a/Documentation/devicetree/bindings/interconnect/qcom,glymur-rpmh.yaml b/Documentation/devicetree/bindings/interconnect/qcom,glymur-rpmh.yaml
index d55a7bcf5591eea79c173a12b12c659321ca3c2e..723ae547ae06073b7fa93dc7a94f33336068519b 100644
--- a/Documentation/devicetree/bindings/interconnect/qcom,glymur-rpmh.yaml
+++ b/Documentation/devicetree/bindings/interconnect/qcom,glymur-rpmh.yaml
@@ -4,7 +4,7 @@
 $id: http://devicetree.org/schemas/interconnect/qcom,glymur-rpmh.yaml#
 $schema: http://devicetree.org/meta-schemas/core.yaml#
 
-title: Qualcomm RPMh Network-On-Chip Interconnect on GLYMUR
+title: Qualcomm RPMh Network-On-Chip Interconnect on Glymur and Mahua SoCs
 
 maintainers:
   - Raviteja Laggyshetty <raviteja.laggyshetty@oss.qualcomm.com>
@@ -21,28 +21,98 @@ description: |
 
 properties:
   compatible:
-    enum:
-      - qcom,glymur-aggre1-noc
-      - qcom,glymur-aggre2-noc
-      - qcom,glymur-aggre3-noc
-      - qcom,glymur-aggre4-noc
-      - qcom,glymur-clk-virt
-      - qcom,glymur-cnoc-cfg
-      - qcom,glymur-cnoc-main
-      - qcom,glymur-hscnoc
-      - qcom,glymur-lpass-ag-noc
-      - qcom,glymur-lpass-lpiaon-noc
-      - qcom,glymur-lpass-lpicx-noc
-      - qcom,glymur-mc-virt
-      - qcom,glymur-mmss-noc
-      - qcom,glymur-nsinoc
-      - qcom,glymur-nsp-noc
-      - qcom,glymur-oobm-ss-noc
-      - qcom,glymur-pcie-east-anoc
-      - qcom,glymur-pcie-east-slv-noc
-      - qcom,glymur-pcie-west-anoc
-      - qcom,glymur-pcie-west-slv-noc
-      - qcom,glymur-system-noc
+    oneOf:
+      - items:
+          - enum:
+              - qcom,mahua-clk-virt
+          - const: qcom,glymur-clk-virt
+      - items:
+          - enum:
+              - qcom,mahua-cnoc-main
+          - const: qcom,glymur-cnoc-main
+      - items:
+          - enum:
+              - qcom,mahua-system-noc
+          - const: qcom,glymur-system-noc
+      - items:
+          - enum:
+              - qcom,mahua-pcie-east-anoc
+          - const: qcom,glymur-pcie-east-anoc
+      - items:
+          - enum:
+              - qcom,mahua-aggre1-noc
+          - const: qcom,glymur-aggre1-noc
+      - items:
+          - enum:
+              - qcom,mahua-aggre2-noc
+          - const: qcom,glymur-aggre2-noc
+      - items:
+          - enum:
+              - qcom,mahua-aggre3-noc
+          - const: qcom,glymur-aggre3-noc
+      - items:
+          - enum:
+              - qcom,mahua-aggre4-noc
+          - const: qcom,glymur-aggre4-noc
+      - items:
+          - enum:
+              - qcom,mahua-mmss-noc
+          - const: qcom,glymur-mmss-noc
+      - items:
+          - enum:
+              - qcom,mahua-pcie-east-slv-noc
+          - const: qcom,glymur-pcie-east-slv-noc
+      - items:
+          - enum:
+              - qcom,mahua-lpass-lpiaon-noc
+          - const: qcom,glymur-lpass-lpiaon-noc
+      - items:
+          - enum:
+              - qcom,mahua-lpass-lpicx-noc
+          - const: qcom,glymur-lpass-lpicx-noc
+      - items:
+          - enum:
+              - qcom,mahua-lpass-ag-noc
+          - const: qcom,glymur-lpass-ag-noc
+      - items:
+          - enum:
+              - qcom,mahua-nsinoc
+          - const: qcom,glymur-nsinoc
+      - items:
+          - enum:
+              - qcom,mahua-oobm-ss-noc
+          - const: qcom,glymur-oobm-ss-noc
+      - items:
+          - enum:
+              - qcom,mahua-nsp-noc
+          - const: qcom,glymur-nsp-noc
+      - enum:
+          - qcom,glymur-aggre1-noc
+          - qcom,glymur-aggre2-noc
+          - qcom,glymur-aggre3-noc
+          - qcom,glymur-aggre4-noc
+          - qcom,glymur-clk-virt
+          - qcom,glymur-cnoc-cfg
+          - qcom,glymur-cnoc-main
+          - qcom,glymur-hscnoc
+          - qcom,glymur-lpass-ag-noc
+          - qcom,glymur-lpass-lpiaon-noc
+          - qcom,glymur-lpass-lpicx-noc
+          - qcom,glymur-mc-virt
+          - qcom,glymur-mmss-noc
+          - qcom,glymur-nsinoc
+          - qcom,glymur-nsp-noc
+          - qcom,glymur-oobm-ss-noc
+          - qcom,glymur-pcie-east-anoc
+          - qcom,glymur-pcie-east-slv-noc
+          - qcom,glymur-pcie-west-anoc
+          - qcom,glymur-pcie-west-slv-noc
+          - qcom,glymur-system-noc
+          - qcom,mahua-mc-virt
+          - qcom,mahua-cnoc-cfg
+          - qcom,mahua-pcie-west-anoc
+          - qcom,mahua-pcie-west-slv-noc
+          - qcom,mahua-hscnoc
 
   reg:
     maxItems: 1
@@ -63,6 +133,7 @@ allOf:
             enum:
               - qcom,glymur-clk-virt
               - qcom,glymur-mc-virt
+              - qcom,mahua-mc-virt
     then:
       properties:
         reg: false
@@ -85,6 +156,20 @@ allOf:
             - description: aggre PCIE_4 WEST AXI clock
             - description: aggre PCIE_6 WEST AXI clock
 
+  - if:
+      properties:
+        compatible:
+          contains:
+            enum:
+              - qcom,mahua-pcie-west-anoc
+    then:
+      properties:
+        clocks:
+          items:
+            - description: aggre PCIE_3B WEST AXI clock
+            - description: aggre PCIE_4 WEST AXI clock
+            - description: aggre PCIE_6 WEST AXI clock
+
   - if:
       properties:
         compatible:
@@ -132,6 +217,7 @@ allOf:
           contains:
             enum:
               - qcom,glymur-pcie-west-anoc
+              - qcom,mahua-pcie-west-anoc
               - qcom,glymur-pcie-east-anoc
               - qcom,glymur-aggre2-noc
               - qcom,glymur-aggre4-noc

-- 
2.43.0


