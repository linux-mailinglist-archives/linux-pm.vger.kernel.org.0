Return-Path: <linux-pm+bounces-41517-lists+linux-pm=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-pm@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id yGx4GwV/eGmcqQEAu9opvQ
	(envelope-from <linux-pm+bounces-41517-lists+linux-pm=lfdr.de@vger.kernel.org>)
	for <lists+linux-pm@lfdr.de>; Tue, 27 Jan 2026 10:01:57 +0100
X-Original-To: lists+linux-pm@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id 879DD9169A
	for <lists+linux-pm@lfdr.de>; Tue, 27 Jan 2026 10:01:56 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 73864301452F
	for <lists+linux-pm@lfdr.de>; Tue, 27 Jan 2026 09:01:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8AAA5331A7E;
	Tue, 27 Jan 2026 09:01:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="ltZ9Es4A";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="h/adpnTU"
X-Original-To: linux-pm@vger.kernel.org
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 322DA2C0270
	for <linux-pm@vger.kernel.org>; Tue, 27 Jan 2026 09:01:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769504512; cv=none; b=tfw56uA3otsRD+gRdCglmpGwe+dlAHhngTe31yHjzAbfOWLtn/45wF5nmTDUF8nFVLfo64IzT4WV/2WwoUEpwlbYPSRAE1AIighSAkgb1PLcY7aa9f47xTpH8r+l34Zc9O8g8n6k7ZLmWJ5B0EruJJegIevHOBvWZYUxT4FhMjg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769504512; c=relaxed/simple;
	bh=Oik/qwTKsOA6npTm0TkNDx86wTm/52/PPO9Xasj6gTY=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=a2MffiH8RgE/RFVfKbocq9CgACkl2xgJA++Z7zBnOvqMTYDOZ6M5gr52N2dsYxz+poTtv0mpXKl4N2eM3XcjzrNz2u3XG5muO9beLL6ODFK8VUw1H8rOLgo39iAX8AMhqKl//PgkodoupB0v01at7Lg9kUPUDAqBEVmlYUhpvw4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=ltZ9Es4A; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=h/adpnTU; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279865.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 60R4UBEY495963
	for <linux-pm@vger.kernel.org>; Tue, 27 Jan 2026 09:01:50 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	ITz6w/Q2w67Ducysc+bZG/olR38WeARfEZrkn5j4QzM=; b=ltZ9Es4AGHOwn0Dx
	BKzhQMERsyzO8iV+NG6a1o3O8h7UyMG+PsMJGaDo8Vkg2PenXk03Z6WsI05owVX1
	Fasvclv3l6qyd30iwLWubjv8hC9jZxU4zY0lqrx19VXEJ1lqWUiQ/pOHiCPY5WOO
	4WCuedSVtNiIVMjEEBakhbTQwr/D9Afmxb+Ort4ZLlbgaV5cydHjol2ksww3oZTx
	mvcXe/J3tbW6A4dCcZsj6z7MFq6OMT108WpKlH1062WOP4/kNMGawgCT4plK+TKI
	X+n+JMx//adIDq7tuX0o9p9oNa4J4DgZ1TXWAvymu859m1FjmR2UkP34mDY1NZcW
	oBlMyQ==
Received: from mail-pf1-f198.google.com (mail-pf1-f198.google.com [209.85.210.198])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4bxf3bj263-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-pm@vger.kernel.org>; Tue, 27 Jan 2026 09:01:50 +0000 (GMT)
Received: by mail-pf1-f198.google.com with SMTP id d2e1a72fcca58-81f42368322so4144612b3a.3
        for <linux-pm@vger.kernel.org>; Tue, 27 Jan 2026 01:01:50 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1769504510; x=1770109310; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ITz6w/Q2w67Ducysc+bZG/olR38WeARfEZrkn5j4QzM=;
        b=h/adpnTUUKY5cXD6CtlUbLu+3fDh9AfSvT4EsflaSTBsnrAsM7cdvfgfmELfzpxblD
         grl9NIpdzWIG2XZ85Eno0G/nyUIN2i0wQqcmn5I1WDwm1jBLX77eWwjIcb0pwklgJk0t
         6NnnLZPAUUR+bmU1VbK8WgX92vS/wKKv8sba2aFXLt+ly7aXHii0n9WLwpHt5Lp76BR5
         JXu4fADR2xXTseoaVLR3jh5+zI/eOO5XbzqrLFNGuaU1uNK8P6zERbwB+XFIiCasvN7m
         y1z3YZi9B56MRnlAGSoAm6yRFaGP/ABw/74Ls1qY/PKXiYk+gxRTiaKXpEZi0RZYLujk
         TWwQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1769504510; x=1770109310;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=ITz6w/Q2w67Ducysc+bZG/olR38WeARfEZrkn5j4QzM=;
        b=F58XoQBJkh0ruhXfvkIo4JpUi7PwFzNxiIteb4Pg4P+AX6SeGjJW0d8PFYtJ3sTp09
         fRPMegVdbZOdrUrWGZvOle0did4yEJE9DyCeVPACwxsEiGdMRakyuBj37S10QkDD0uUc
         3ZeEMMmPgzt05hEPBOMI32g82zSTywiaNrl1ys3VwQyBoNMGVLfrBv+NPR9WRy/JfLCX
         p9nEuiQA6TWprBwAGhLxGJ7z7G6AypzXgpNytwVXH6JEFIa096L/NQymsJ8zDxomEhHH
         fpaYxE+BY+HpeJMyp+YwOdccpgyN5AJtJYTvw7bS2pXzgl96tEW6Oh0AXkuSDrCrtRRx
         x+0A==
X-Forwarded-Encrypted: i=1; AJvYcCXvj6l7A4xDYd+CYF3LE/Tg2S7Cmw9q++FNQ4pCnol82HoGOrF3lsPM9tEhDKJMhWd+pr1pxFziyw==@vger.kernel.org
X-Gm-Message-State: AOJu0Ywvo6pt1JN2m791Kb1rP2AIxm1pSkbmnPq39t+YcL4u0qxmQtMT
	Qq+ufhUucq+cgN6dmzvPmgK3Fdq7HY2pzcvIqxM+Fm5IXANxJAXr79MyrHmdg7D/F8xwFQoNxvJ
	K+9OCqhHmuj6xnASfZxCjRieRNIhNPZZUU4Zwn3pIaZB1zjoxrUntLkDJDo3BNg==
X-Gm-Gg: AZuq6aIyNGnciugScKwe73+QJWggNHxLLJ2lqPwlluEKuB63YciNSXrhMVC/wSzbgYX
	ovgc6ezbC6FUGZXw7LxSLxIKodUaufZpl5mvB+I+NCPN6C3B2jgHJVRDtpFq0HcMkPadWVg9HFX
	IX0WgzG5OutfUHZIHciconJI1TLoLkU9mtcSuxfWsWS4vAqlnWdKsFskeNPZQdCdW9iV8qEp/f3
	sWvKXX1uP586+Ez6bNBmDw6zVZUAJSem/aSpSe8LG5mRAVSTrZfjMfUkxbH/a+36312hvF99Eo1
	FplgxGMJLHQbTrr5IWiDdsh5KXX1BNPMEFLKpRqtu6Lv9VP3j19YqyxoM+zLM2ABNV/grmv5ZrU
	Kr/jrjfOQAPFQEXwn8ubQIodRsB+BqbfzKgCjCzspruo=
X-Received: by 2002:a05:6a00:1a17:b0:81b:c2b5:31a with SMTP id d2e1a72fcca58-823692bf878mr1087410b3a.53.1769504509698;
        Tue, 27 Jan 2026 01:01:49 -0800 (PST)
X-Received: by 2002:a05:6a00:1a17:b0:81b:c2b5:31a with SMTP id d2e1a72fcca58-823692bf878mr1087369b3a.53.1769504509180;
        Tue, 27 Jan 2026 01:01:49 -0800 (PST)
Received: from hu-okukatla-hyd.qualcomm.com ([202.46.22.19])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-8231873bf53sm11579228b3a.45.2026.01.27.01.01.45
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 27 Jan 2026 01:01:48 -0800 (PST)
From: Odelu Kukatla <odelu.kukatla@oss.qualcomm.com>
To: Georgi Djakov <djakov@kernel.org>, Rob Herring <robh@kernel.org>,
        Krzysztof Kozlowski <krzk+dt@kernel.org>,
        Conor Dooley <conor+dt@kernel.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Konrad Dybcio <konradybcio@kernel.org>
Cc: Raviteja Laggyshetty <raviteja.laggyshetty@oss.qualcomm.com>,
        Odelu Kukatla <odelu.kukatla@oss.qualcomm.com>,
        Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>,
        Bartosz Golaszewski <bartosz.golaszewski@linaro.org>,
        linux-arm-msm@vger.kernel.org, linux-pm@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        Mike Tipton <mike.tipton@oss.qualcomm.com>
Subject: [PATCH v2 1/3] dt-bindings: interconnect: qcom,qcs8300-rpmh: add clocks property to enable QoS
Date: Tue, 27 Jan 2026 14:31:14 +0530
Message-ID: <20260127090116.1438780-2-odelu.kukatla@oss.qualcomm.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260127090116.1438780-1-odelu.kukatla@oss.qualcomm.com>
References: <20260127090116.1438780-1-odelu.kukatla@oss.qualcomm.com>
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Proofpoint-ORIG-GUID: Xho3TsbRPTe4Ez6VBXk5fT3l7EwPGRhm
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwMTI3MDA3MyBTYWx0ZWRfX2YH0eRj7lutD
 LOw96doaFcRw9BgWTUmpWjBtRQR9YPADGyDS696aY99dbG106pXp4SK9ty2pVJYBQL42votjKj2
 fkLFRiRKG6MDoqWvoRSYp0v/TC98Veu+MKYEYXvaoeSp+kekqGmCvuAspjMM6KmstvIQjXfE92c
 ETVpITgoa96hGXF6op3fGaCsJ2DQxOu/V35Kj9adZYH7w/LbzYE/Sk2Q2o3gbcGnpAR/vMxQ0dR
 nlH5w7hcE7Cw9uciloBS0rKZEpURvVyHTguUR0DPdI7xzD800vw1wmngMItOCz04akecLwHryka
 zG+HapJVu251XyBuAG/NSS/U37rXeYvUvUaBBTdeLvZQdQlO2Hn1TuXT75YRtyo2T3pwrH4jxe+
 hb+T1zITaXj8zeSuRCUxZQJWOAlqtSZD2mgj3gMMqGcICVdNZ3wS97xGNqKDAdau5fPP+i+r14C
 3Kal4Jjp4C26ipW5h1Q==
X-Proofpoint-GUID: Xho3TsbRPTe4Ez6VBXk5fT3l7EwPGRhm
X-Authority-Analysis: v=2.4 cv=AOFXvqQI c=1 sm=1 tr=0 ts=69787efe cx=c_pps
 a=m5Vt/hrsBiPMCU0y4gIsQw==:117 a=fChuTYTh2wq5r3m49p7fHw==:17
 a=IkcTkHD0fZMA:10 a=vUbySO9Y5rIA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=EUspDBNiAAAA:8 a=OrdcpLHLpR68xOABugYA:9
 a=3ZKOabzyN94A:10 a=QEXdDO2ut3YA:10 a=IoOABgeZipijB_acs4fv:22
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.20,FMLib:17.12.100.49
 definitions=2026-01-27_01,2026-01-26_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 clxscore=1015 suspectscore=0 phishscore=0 adultscore=0 priorityscore=1501
 lowpriorityscore=0 bulkscore=0 spamscore=0 impostorscore=0 malwarescore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2601150000 definitions=main-2601270073
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-1.16 / 15.00];
	MID_CONTAINS_FROM(1.00)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[qualcomm.com,reject];
	R_DKIM_ALLOW(-0.20)[qualcomm.com:s=qcppdkim1,oss.qualcomm.com:s=google];
	R_SPF_ALLOW(-0.20)[+ip4:172.105.105.114:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-41517-lists,linux-pm=lfdr.de];
	DBL_BLOCKED_OPENRESOLVER(0.00)[qualcomm.com:email,qualcomm.com:dkim,tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[15];
	MIME_TRACE(0.00)[0:+];
	DKIM_TRACE(0.00)[qualcomm.com:+,oss.qualcomm.com:+];
	ASN(0.00)[asn:63949, ipnet:172.105.96.0/20, country:SG];
	TO_DN_SOME(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[odelu.kukatla@oss.qualcomm.com,linux-pm@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	TAGGED_RCPT(0.00)[linux-pm,dt];
	NEURAL_HAM(-0.00)[-1.000];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	RCVD_COUNT_SEVEN(0.00)[7]
X-Rspamd-Queue-Id: 879DD9169A
X-Rspamd-Action: no action

Some QCS8300 interconnect nodes have QoS registers located inside
a block whose interface is clock-gated. For those nodes, driver
must enable the corresponding clock(s) before accessing the
registers. Add the 'clocks' property so the driver can obtain
and enable the required clock(s).

Only interconnects that have clock‑gated QoS register interface
use this property; it is not applicable to all interconnect nodes.

Signed-off-by: Odelu Kukatla <odelu.kukatla@oss.qualcomm.com>
---
 .../interconnect/qcom,qcs8300-rpmh.yaml       | 63 +++++++++++++++++++
 1 file changed, 63 insertions(+)

diff --git a/Documentation/devicetree/bindings/interconnect/qcom,qcs8300-rpmh.yaml b/Documentation/devicetree/bindings/interconnect/qcom,qcs8300-rpmh.yaml
index e9f528d6d9a8..88fe17277110 100644
--- a/Documentation/devicetree/bindings/interconnect/qcom,qcs8300-rpmh.yaml
+++ b/Documentation/devicetree/bindings/interconnect/qcom,qcs8300-rpmh.yaml
@@ -35,6 +35,10 @@ properties:
   reg:
     maxItems: 1
 
+  clocks:
+    minItems: 1
+    maxItems: 4
+
 required:
   - compatible
 
@@ -54,6 +58,64 @@ allOf:
       required:
         - reg
 
+  - if:
+      properties:
+        compatible:
+          contains:
+            enum:
+              - qcom,qcs8300-aggre1-noc
+    then:
+      properties:
+        clocks:
+          items:
+            - description: aggre UFS PHY AXI clock
+            - description: aggre QUP PRIM AXI clock
+            - description: aggre USB2 PRIM AXI clock
+            - description: aggre USB3 PRIM AXI clock
+
+  - if:
+      properties:
+        compatible:
+          contains:
+            enum:
+              - qcom,qcs8300-aggre2-noc
+    then:
+      properties:
+        clocks:
+          items:
+            - description: RPMH CC IPA clock
+
+  - if:
+      properties:
+        compatible:
+          contains:
+            enum:
+              - qcom,qcs8300-gem-noc
+    then:
+      properties:
+        clocks:
+          items:
+            - description: GCC DDRSS GPU AXI clock
+
+  - if:
+      properties:
+        compatible:
+          contains:
+            enum:
+              - qcom,qcs8300-clk-virt
+              - qcom,qcs8300-config-noc
+              - qcom,qcs8300-dc-noc
+              - qcom,qcs8300-gpdsp-anoc
+              - qcom,qcs8300-lpass-ag-noc
+              - qcom,qcs8300-mc-virt
+              - qcom,qcs8300-mmss-noc
+              - qcom,qcs8300-nspa-noc
+              - qcom,qcs8300-pcie-anoc
+              - qcom,qcs8300-system-noc
+    then:
+      properties:
+        clocks: false
+
 unevaluatedProperties: false
 
 examples:
@@ -63,6 +125,7 @@ examples:
         reg = <0x9100000 0xf7080>;
         #interconnect-cells = <2>;
         qcom,bcm-voters = <&apps_bcm_voter>;
+        clocks = <&gcc_ddrss_gpu_axi_clk>;
     };
 
     clk_virt: interconnect-0 {
-- 
2.43.0


