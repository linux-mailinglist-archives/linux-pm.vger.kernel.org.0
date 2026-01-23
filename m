Return-Path: <linux-pm+bounces-41381-lists+linux-pm=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-pm@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id EEyFDwqtc2nOxwAAu9opvQ
	(envelope-from <linux-pm+bounces-41381-lists+linux-pm=lfdr.de@vger.kernel.org>)
	for <lists+linux-pm@lfdr.de>; Fri, 23 Jan 2026 18:16:58 +0100
X-Original-To: lists+linux-pm@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id DB8B378E5C
	for <lists+linux-pm@lfdr.de>; Fri, 23 Jan 2026 18:16:57 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 96BCB30401A1
	for <lists+linux-pm@lfdr.de>; Fri, 23 Jan 2026 17:13:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5C87331A568;
	Fri, 23 Jan 2026 17:13:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="S9uW6ZBL";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="VXKfNbgJ"
X-Original-To: linux-pm@vger.kernel.org
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C123A30B52B
	for <linux-pm@vger.kernel.org>; Fri, 23 Jan 2026 17:13:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769188394; cv=none; b=gV+jITawJNtUqJpuswRMnjryHdCxGroanKb8ovisW0AKo+TVJvSeYmUrwPkVvic8OJmYIJ8igxV3SVKSALMXW/d5yCE9a6fl43VwYIVUqKV387aBM0UMyG+Z54Pwq6Q2jux41biT7hbRSkoFhXsPxQHcLy34fyi54tr6YOY6L3k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769188394; c=relaxed/simple;
	bh=cs4/U0yCoIK14CAokJ4FgfwNwI8yPzhO6UzxegPP8to=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=ZJZPd9jfvTRX21s1ycI9vptLkpD0Xo/zLl4wnwRjj9dwijO7xmLuFpGsW8ytsvo1dNQUEzLELLKyQr+5OCEgdf2HFJAWTiA2993x0ova/HLXxmS2qTe8ZVn5AV0Kid/IKkpHtIkYn2PphkUtGAbSuGjVx8znWT2kF36hw8D5tZw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=S9uW6ZBL; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=VXKfNbgJ; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279869.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 60N9WMTO722645
	for <linux-pm@vger.kernel.org>; Fri, 23 Jan 2026 17:13:12 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	U9Qq7IFWdko0kN7I5C2MTVrPBpRcROGKPHud5ivKK0w=; b=S9uW6ZBLoLukeFAl
	7/1K9cVjzGy4RUIsNyX2auYXl0pYaqI9Hym53P9sdjIR2h1+I8aJ6rxa/nBaqt2q
	KRrtBjaBDm8zrUocrzJ+xDtzzPP37Vaol/5r3S7TbOY6cXFg5CC/zXpO+9gOaX/a
	Nfy197IqFYSVLIciwajSjGy8mZrUJ/XRDSv2SD+vRweWeoeuydn4qwRj9opk3/Wi
	1YUTuQCRlKMNhSKJTlPCtpcCoMCJZEcrcj0w4sQkuPfobRxjBbFhFeqwAs4F4nd4
	pxyryPIiIMHmOumBXvzXr1OQv4iX9YCIT/9YQq5bGxlBxCS7G3LTGtiUBqgvA1de
	pr1/Yg==
Received: from mail-pj1-f70.google.com (mail-pj1-f70.google.com [209.85.216.70])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4bv069jx3y-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-pm@vger.kernel.org>; Fri, 23 Jan 2026 17:13:11 +0000 (GMT)
Received: by mail-pj1-f70.google.com with SMTP id 98e67ed59e1d1-34c48a76e75so2225308a91.1
        for <linux-pm@vger.kernel.org>; Fri, 23 Jan 2026 09:13:11 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1769188391; x=1769793191; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=U9Qq7IFWdko0kN7I5C2MTVrPBpRcROGKPHud5ivKK0w=;
        b=VXKfNbgJSLgdH2XYW+xjC8JfmNzuwgsp1+Xw0nSIlmKgxJfmFDx5HEsCSZAB81ChcE
         99dupf1MU0uG8sk/GBX0CPvBbWMWti8Qjv45I/ojfY6YRhZDKxw8DvNWm9kHiN8pSF7u
         E1mRBn6d0BqlPsAg/lIxCqEp/+DehGsieqIbopY3PwVlHzZ5x1W+OeLchAnaPR6goI/0
         GPWePnB2fE1LVHzGLBbf4uwK4MOD0if6ZlmXQlR2jhUQrxNjYJgDM1CcTHZPziT0TIxN
         sWi0PWmpxujVVTQJCtGoOJQ3R8ZobedcGM8Xk4aJckWf4VFod544qO48MmkL1+YNYZ9r
         tYbA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1769188391; x=1769793191;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-gg:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=U9Qq7IFWdko0kN7I5C2MTVrPBpRcROGKPHud5ivKK0w=;
        b=VpgBPp0i2TSEjUDc6nN3PQZNwd2h8WzAc6l5IwdKY5T+ITcVsIIsKi6tew2XfkReun
         Azo2evJDPB5gFWgv5XZKJ5iQZ+q2aTikP2qldCiVUnJ9FYi2DZQtETmUSb9qTFcHAZsd
         hP4UOTX3b1AbmPPaI2CZ1+P8LgjskwjWm9W+Ab1/NlYuZC4kQA3dkEx2DAyCtfnakHBT
         joaBn6XS4Wuej7ddaFAxH9ymZEfrMsBlpsHPcmy3ZEsZJl607/hZlsjpi66mQQ5eqxZ3
         P0Hl4P1C2tAn50f60xHByh4gNK0KrjQML8fMzXSWjF06rWTHnqlfAkAuQkLKp1fIhiUS
         tW9Q==
X-Forwarded-Encrypted: i=1; AJvYcCUZcxtGIirseahEy0MjPFA35gXz5EIvJiwYC1YeEeGcIE2Q6kqfxhdnWo94h5F9LPI679HFvAFHpQ==@vger.kernel.org
X-Gm-Message-State: AOJu0YyEJvzSzDmsg4K+vjlrjEDC0rGx2VA7COSvTEIN/h0znEER6I/P
	2x7sWbMoHg77W9bOyz7HyQBl1GWhBGZ2+5QRfUHax5UfwYp4q+QB7eTcZlvXOha3avRZVYF1768
	9KwpRL7N2ItIskeARASTLtRbdI6aMKz1ACHFw5bRFIVPR+QkW0Qd6VtlcFHpTzf1DILhIUg==
X-Gm-Gg: AZuq6aL1Jvepkv8Ug4OlB/skzXm3TlTqrE4KgrbP4xw04EaO7TFMk+R1kXgH192w30H
	wqcgWxv3HBLrPGcRYhZ0TLFvZE7EfWDmf9tH0qV0a2+sg6B/8j7sOectI3Ts2ZROwhCxpvoinsW
	y3gtl9xwemyUzdWjAwcU/Y9InLRY5fRPVDGz7ygEOwkiYGlFmRYfO1j+N2PeviUtxdlqVxhmm66
	BpDbDiuzhzFtklb2VCBwB3s20oZVGVFpM/BaM7oPVzxBLZGtQ4HFt3RwITEj/rOJ/2VNj59slrH
	Y3SHkTH+hFotzc7RyBgblz53zGsZXY1OuQIWFw9FUVjQO/3iWaTfsYzuonMTABrkJBPJgkQrxo4
	KXqHwszT8qD03ajFYfexHoiEno3mmnT2k
X-Received: by 2002:a17:90b:388a:b0:353:f7b:6d60 with SMTP id 98e67ed59e1d1-35368b4bfc2mr2930785a91.33.1769188390172;
        Fri, 23 Jan 2026 09:13:10 -0800 (PST)
X-Received: by 2002:a17:90b:388a:b0:353:f7b:6d60 with SMTP id 98e67ed59e1d1-35368b4bfc2mr2930771a91.33.1769188389653;
        Fri, 23 Jan 2026 09:13:09 -0800 (PST)
Received: from [169.254.0.6] ([202.46.22.19])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-3536ef9ddb9sm1191358a91.3.2026.01.23.09.13.06
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 23 Jan 2026 09:13:09 -0800 (PST)
From: Raviteja Laggyshetty <raviteja.laggyshetty@oss.qualcomm.com>
Date: Fri, 23 Jan 2026 17:12:35 +0000
Subject: [PATCH 1/2] dt-bindings: interconnect: document the RPMh
 Network-On-Chip interconnect in Mahua SoC
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260123-mahua_icc-v1-1-bc82cb087f1e@oss.qualcomm.com>
References: <20260123-mahua_icc-v1-0-bc82cb087f1e@oss.qualcomm.com>
In-Reply-To: <20260123-mahua_icc-v1-0-bc82cb087f1e@oss.qualcomm.com>
To: Georgi Djakov <djakov@kernel.org>, Rob Herring <robh@kernel.org>,
        Krzysztof Kozlowski <krzk+dt@kernel.org>,
        Conor Dooley <conor+dt@kernel.org>,
        Raviteja Laggyshetty <raviteja.laggyshetty@oss.qualcomm.com>
Cc: linux-arm-msm@vger.kernel.org, linux-pm@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        Odelu Kukatla <odelu.kukatla@oss.qualcomm.com>
X-Mailer: b4 0.14.2
X-Authority-Analysis: v=2.4 cv=eLUeTXp1 c=1 sm=1 tr=0 ts=6973ac27 cx=c_pps
 a=0uOsjrqzRL749jD1oC5vDA==:117 a=fChuTYTh2wq5r3m49p7fHw==:17
 a=IkcTkHD0fZMA:10 a=vUbySO9Y5rIA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=gEfo2CItAAAA:8 a=EUspDBNiAAAA:8
 a=XbHj8r4lGLmVoAHgLPwA:9 a=QEXdDO2ut3YA:10 a=mQ_c8vxmzFEMiUWkPHU9:22
 a=sptkURWiP4Gy88Gu7hUp:22
X-Proofpoint-GUID: oZQdf7NOzvhVjHccwQvFZoKq5ZQipx2L
X-Proofpoint-ORIG-GUID: oZQdf7NOzvhVjHccwQvFZoKq5ZQipx2L
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwMTIzMDEyOSBTYWx0ZWRfXyZTlkJAUC+K8
 SogL13XKfGuqKHlXncN7oGDQE3oG/aOAebDLKSVbr0TcpV08u+F+/g/PtWWPM8xLEn/q3QeTHUw
 mr/lQYdLxC6kUinegMDmPHmQI831yJsxNGzUN72CZSfukDtGpqnPQXaplxAfFV3LcILrgxHjboi
 gCafBAHufvLdhls4FQgj25sO90zcGV/vS347Sh+V2xOphe1fFi/BfyBytrD5vFs7p1nTqYcFJpN
 ytzUWTJP8EFojpe/cGYjyX2XqFLW4BUwjjdRQ2lXfwEcpVcr2ZycrnTFReMHOC1xlY4rLkdagxH
 oZgcekZouvF4B1yd6uPmlup2mhqkMokkq1NeY80NKcO94A8jhjdsVIaG+I4laBTejlus9uHocAM
 h2CWXPS8EOC86Efw15WjNIFZNYWirul8h2tb9Hb7i9unw2MydJx4mMkhRTwXKsrpvG/uwghowv1
 r4OZyXy39WgGExtYvlA==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.20,FMLib:17.12.100.49
 definitions=2026-01-23_02,2026-01-22_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 malwarescore=0 priorityscore=1501 adultscore=0 impostorscore=0 clxscore=1015
 phishscore=0 lowpriorityscore=0 suspectscore=0 bulkscore=0 spamscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2601150000 definitions=main-2601230129
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[qualcomm.com,reject];
	R_DKIM_ALLOW(-0.20)[qualcomm.com:s=qcppdkim1,oss.qualcomm.com:s=google];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	DKIM_TRACE(0.00)[qualcomm.com:+,oss.qualcomm.com:+];
	DBL_BLOCKED_OPENRESOLVER(0.00)[devicetree.org:url,oss.qualcomm.com:mid,oss.qualcomm.com:dkim,qualcomm.com:email,qualcomm.com:dkim,sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns];
	RCVD_TLS_LAST(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	TAGGED_FROM(0.00)[bounces-41381-lists,linux-pm=lfdr.de];
	MIME_TRACE(0.00)[0:+];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[linux-pm,dt];
	FROM_NEQ_ENVFROM(0.00)[raviteja.laggyshetty@oss.qualcomm.com,linux-pm@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	MID_RHS_MATCH_FROM(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	RCPT_COUNT_SEVEN(0.00)[10];
	RCVD_COUNT_SEVEN(0.00)[7]
X-Rspamd-Queue-Id: DB8B378E5C
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


