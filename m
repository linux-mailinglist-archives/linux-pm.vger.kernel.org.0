Return-Path: <linux-pm+bounces-41881-lists+linux-pm=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-pm@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id AC9xGV9NgGlQ6AIAu9opvQ
	(envelope-from <linux-pm+bounces-41881-lists+linux-pm=lfdr.de@vger.kernel.org>)
	for <lists+linux-pm@lfdr.de>; Mon, 02 Feb 2026 08:08:15 +0100
X-Original-To: lists+linux-pm@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 1AD1DC912C
	for <lists+linux-pm@lfdr.de>; Mon, 02 Feb 2026 08:08:14 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 480A030226AC
	for <lists+linux-pm@lfdr.de>; Mon,  2 Feb 2026 07:06:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C7B1E30E0F5;
	Mon,  2 Feb 2026 07:06:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="Fmd2yO57";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="CjH7zC0l"
X-Original-To: linux-pm@vger.kernel.org
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 753F422156A
	for <linux-pm@vger.kernel.org>; Mon,  2 Feb 2026 07:06:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770015993; cv=none; b=IE77QfvhntiTDdv81fgjo4YWI01E7PbcO1z6AmxAXgCzIGQ42j3PtbQXsAKAdi/skvZuHDpH01HJ58g2/gL4T0UFaYi1poYqRm/A8jEg1Nd2ePnqEj5QjFNVBDv64KIhJ0h3iilxtNwSManhYYBVL5WOGN+5qxM2cEYIBLS/lbM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770015993; c=relaxed/simple;
	bh=4nikkiBRwcIj+UOuGQUPQrF566Nt8SsIWg7e17PpZmI=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=L8cJJxQQgBH9K9WytPRvDPne+b805MlJlBf+GOHjSvvB8oX331cN3JZZBUrGY9CCkQfUfu34MJ7IZsGJXJceTfOgMhRf47bd8JIlfrJeaJoR0kOdatVhkey6AGxF0/Xi9lc/6Fk5LQ24tzfFs1J++SeC+3sFzcqj6hSE2XgtOts=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=Fmd2yO57; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=CjH7zC0l; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279869.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 611N0RHM2367015
	for <linux-pm@vger.kernel.org>; Mon, 2 Feb 2026 07:06:31 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	eqlrYKConwWmWXVxvY+ChB3qFcGuPMtgxyGYyGIq1m8=; b=Fmd2yO57jtRzjFfw
	PSg8xIL3C3HiZA7eoyoAa4VwJtxwS7scDMpzk8xef+aY7GlMz76+fHAwnXM/nYfk
	GaqbB/tecV43Wtj28NVeHfw1k6aZ4/tOAxBLg+OrbbCSABlbDwI1eWKm0vfqF+yX
	qP5Hbsc2h3qwRaL9imG8KW1i+F2rAj9I4HOg4CwSFHu6G4aKc/8exLonqiR4ohoM
	hitd9AQKS3PrX3F0XJhA3I2AzKj4mB3/xW0j0GTBH6/xfCyi7tP6hTknd9BoEsTi
	upgG65d/54mVuPNRhL+BAgd9pXKqPQVpNwrqJy46cU+zyoOo86dmpe0kZXvHoBSy
	dWUN7A==
Received: from mail-pf1-f198.google.com (mail-pf1-f198.google.com [209.85.210.198])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4c1ard4b31-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-pm@vger.kernel.org>; Mon, 02 Feb 2026 07:06:31 +0000 (GMT)
Received: by mail-pf1-f198.google.com with SMTP id d2e1a72fcca58-81efa628efbso4126619b3a.1
        for <linux-pm@vger.kernel.org>; Sun, 01 Feb 2026 23:06:31 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1770015990; x=1770620790; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=eqlrYKConwWmWXVxvY+ChB3qFcGuPMtgxyGYyGIq1m8=;
        b=CjH7zC0lhPuYMKDkWjXFHqWbXk/ZwIkP1pZqZYOBtpYI2iCl7xdMRL8WzfxmITwApV
         NuoOEbu//HIaiPEDnsX6evkEiABASZrZDuhR4262dZD8cVqoIOK1bIP351dsWHKvvPdw
         KQzOsR+wmHdPJjmksL1d7Dthtn3PusUwf+DB+QXwXS/fuw3SkB2v6SVTW5Cu3auKCsjf
         Mg1cBEpv1pKm/MAIPqT5ToHP4ZfgjBrCnLBUAH/Ro5eOJSuXXUeVjNRmT+94Aw4M0okl
         gQaNmF+pqvsLWcC4ZKrRP1m/GjaJmbTaKFMNUYvVojRQ8AGW7jiFQOPWtke3Wur4uODH
         B1Rg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1770015990; x=1770620790;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=eqlrYKConwWmWXVxvY+ChB3qFcGuPMtgxyGYyGIq1m8=;
        b=dxjryfs533i+imnHWS9nkXgCtXHkPfEHGQqAk2MqNeL5EsCy0PLiMwUo0cKugGuUrb
         fIYMtxAEWe9jrJ33MZa6dh240Cdt0JUR7QW7JwxsRAS5lC9IpqsCsgPurCVBRsc2d76f
         6Lvh/1esi4Xi6WVXAtnbRtV1jMQ/URaJ5HmrxPfyyGNzKUdVbHDdHps2kg68yF2WCYrg
         cxHdapHXQFJ+6vWhZG448c4QzV61U1xdRFH+RnKIxwGnXKwnZ4itMVIbnjkJhCeUHMe9
         qex+fPsSqp/0Ws0oVw3T3ImZR2fj9spE50Q6jpn8wctd244hdSxkTCWAePpI1sB5BZ+h
         FKCg==
X-Forwarded-Encrypted: i=1; AJvYcCVYwAuteGACAGiiCvx8SrusnTVduy4xFvfWRrBykFBCLZTNgZzrHq/nO2chXn8zt0PnXlzqAlhxJQ==@vger.kernel.org
X-Gm-Message-State: AOJu0Yy6gtGZuRx9sfyTJceHFgyU/v8MPeQILkB/ze17vnLLaF4ueTPq
	VWo7HM6yAhFOuu1B6J2wJ30+wPOgaq+iUehqunTPmSbbnwiIBRfvR9bf9zyuN43Nz7Tvi37E2TG
	fbzjzthMbVL9/5dCtKYF03SVli+2lXttp0+e/I/IT3w64gwe6NOzeBw0tRrozBg==
X-Gm-Gg: AZuq6aIFtkavV8J6L0N7GBVNv9lSZLYsAlRx1aJ+OCrCDMh8IUHUu6ll5HSeQe5z0aK
	kN0dT4C/+NGEeAED2nbBq0T/wn2piGiC5ncsaeGnxhcyFuHCkf82gARbfc9XSwp0Z1JQ8VuiF9/
	WID5cl/8leVky01ZACSZQaVDgQpEiaH04kC+SkJC3nIgXp06Irz5LaFIies26a0XvyY0tMLsoge
	PEiyLhEcpOkM08/TQUo+C+k1oQo1N2zpTfFzAsLmIJlu69b06iS4QD22AsdqCfMbmifziQ6dluV
	UPk3RHmO7XUnvHd947byHhMSzT/djLUArnCaIsWjwiFDQdHy/FySTTXDHJxOKCjSvcQhKgbYH5H
	NmkGMCmY3mgab70U3l0y3f22SnWBhOEL1DH3rISmLtek=
X-Received: by 2002:a05:6a00:a22a:b0:81f:4e6a:7276 with SMTP id d2e1a72fcca58-823aa40b600mr10714941b3a.14.1770015990170;
        Sun, 01 Feb 2026 23:06:30 -0800 (PST)
X-Received: by 2002:a05:6a00:a22a:b0:81f:4e6a:7276 with SMTP id d2e1a72fcca58-823aa40b600mr10714904b3a.14.1770015989631;
        Sun, 01 Feb 2026 23:06:29 -0800 (PST)
Received: from hu-okukatla-hyd.qualcomm.com ([202.46.22.19])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-82379c54fcasm16265727b3a.66.2026.02.01.23.06.25
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 01 Feb 2026 23:06:29 -0800 (PST)
From: Odelu Kukatla <odelu.kukatla@oss.qualcomm.com>
To: Georgi Djakov <djakov@kernel.org>, Rob Herring <robh@kernel.org>,
        Krzysztof Kozlowski <krzk+dt@kernel.org>,
        Conor Dooley <conor+dt@kernel.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Konrad Dybcio <konradybcio@kernel.org>
Cc: Raviteja Laggyshetty <raviteja.laggyshetty@oss.qualcomm.com>,
        Odelu Kukatla <odelu.kukatla@oss.qualcomm.com>,
        Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>,
        linux-arm-msm@vger.kernel.org, linux-pm@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        Mike Tipton <mike.tipton@oss.qualcomm.com>
Subject: [PATCH 1/3] dt-bindings: interconnect: qcom,qcs615-rpmh: add clocks property to enable QoS
Date: Mon,  2 Feb 2026 12:35:32 +0530
Message-ID: <20260202070534.1281652-2-odelu.kukatla@oss.qualcomm.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260202070534.1281652-1-odelu.kukatla@oss.qualcomm.com>
References: <20260202070534.1281652-1-odelu.kukatla@oss.qualcomm.com>
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwMjAyMDA2MCBTYWx0ZWRfX8yEtMdAygXPn
 6wvRyj8SQ1WxlYUATMkPzEueBnK13bLozWHnnvOU7M3MZxyatF4xIpHVaMBj5Kv9a1z8b2RSLsw
 8ZCmpPC1/dadL9Gqj9S8+JkmlMXFTXcnvUkDyrkqQ9Fux7YvqB0JMz4jMaEk5PFZpR2YuFzBn7H
 YqV4VF24vX79EOmcOuK1/AQPzUIHu7g9MUo04LHv2DPzEZ9Nrff0FpvngsA8F1IWhPr9NTEfN2j
 jnxX3ZWTB0biIx6IYZuzindDS55q78lk+096YdVYbc0mUxzj3+dp0kP8RzD7o4MkAzkmboR+MZO
 YAb/LmLyrmi5eFuu4fKYs9x6IeIu46sWpAq4LEXjLwlzMyD4ezdWjQdGfinoVPZJSeoEwwBoOst
 saMU1tW2AEWphgpgprEtqiAnd2qHkRH2uYDYtvPN1qCXERiY4FGUROT36x39PNvgIExe8ASO43d
 a2khfi1/fEG0KpmuMRw==
X-Authority-Analysis: v=2.4 cv=J6anLQnS c=1 sm=1 tr=0 ts=69804cf7 cx=c_pps
 a=m5Vt/hrsBiPMCU0y4gIsQw==:117 a=fChuTYTh2wq5r3m49p7fHw==:17
 a=IkcTkHD0fZMA:10 a=HzLeVaNsDn8A:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=EUspDBNiAAAA:8 a=uL_lTmy6sO8e-wU5O2sA:9
 a=3ZKOabzyN94A:10 a=QEXdDO2ut3YA:10 a=IoOABgeZipijB_acs4fv:22
X-Proofpoint-ORIG-GUID: 9sBH_q3eUa0zfuhCWJqa7nvzIuL6SDjJ
X-Proofpoint-GUID: 9sBH_q3eUa0zfuhCWJqa7nvzIuL6SDjJ
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-02-02_02,2026-01-30_04,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 lowpriorityscore=0 priorityscore=1501 phishscore=0 suspectscore=0
 malwarescore=0 bulkscore=0 adultscore=0 clxscore=1015 spamscore=0
 impostorscore=0 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2601150000
 definitions=main-2602020060
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-1.16 / 15.00];
	MID_CONTAINS_FROM(1.00)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[qualcomm.com,reject];
	R_DKIM_ALLOW(-0.20)[qualcomm.com:s=qcppdkim1,oss.qualcomm.com:s=google];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-41881-lists,linux-pm=lfdr.de];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,oss.qualcomm.com:mid,oss.qualcomm.com:dkim,0.25.240.160:email,qualcomm.com:email,qualcomm.com:dkim];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[14];
	MIME_TRACE(0.00)[0:+];
	DKIM_TRACE(0.00)[qualcomm.com:+,oss.qualcomm.com:+];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	TO_DN_SOME(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[odelu.kukatla@oss.qualcomm.com,linux-pm@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	TAGGED_RCPT(0.00)[linux-pm,dt];
	NEURAL_HAM(-0.00)[-1.000];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	RCVD_COUNT_SEVEN(0.00)[7]
X-Rspamd-Queue-Id: 1AD1DC912C
X-Rspamd-Action: no action

Aggre1-noc interconnect node on QCS615 has QoS registers located
inside a block whose interface is clock-gated. For that node,
driver must enable the corresponding clock(s) before accessing
the registers. Add the 'clocks' property so the driver can obtain
and enable the required clock(s).

Only interconnects that have clock‑gated QoS register interface
use this property; it is not applicable to all interconnect nodes.

Signed-off-by: Odelu Kukatla <odelu.kukatla@oss.qualcomm.com>
---
 .../interconnect/qcom,qcs615-rpmh.yaml        | 44 +++++++++++++++++++
 1 file changed, 44 insertions(+)

diff --git a/Documentation/devicetree/bindings/interconnect/qcom,qcs615-rpmh.yaml b/Documentation/devicetree/bindings/interconnect/qcom,qcs615-rpmh.yaml
index e06404828824..096a9064cc01 100644
--- a/Documentation/devicetree/bindings/interconnect/qcom,qcs615-rpmh.yaml
+++ b/Documentation/devicetree/bindings/interconnect/qcom,qcs615-rpmh.yaml
@@ -34,6 +34,10 @@ properties:
   reg:
     maxItems: 1
 
+  clocks:
+    minItems: 3
+    maxItems: 3
+
 required:
   - compatible
 
@@ -53,6 +57,36 @@ allOf:
       required:
         - reg
 
+  - if:
+      properties:
+        compatible:
+          contains:
+            enum:
+              - qcom,qcs615-aggre1-noc
+    then:
+      properties:
+        clocks:
+          items:
+            - description: aggre UFS PHY AXI clock
+            - description: aggre USB2 SEC AXI clock
+            - description: aggre USB3 PRIM AXI clock
+
+  - if:
+      properties:
+        compatible:
+          contains:
+            enum:
+              - qcom,qcs615-camnoc-virt
+              - qcom,qcs615-config-noc
+              - qcom,qcs615-dc-noc
+              - qcom,qcs615-gem-noc
+              - qcom,qcs615-mc-virt
+              - qcom,qcs615-mmss-noc
+              - qcom,qcs615-system-noc
+    then:
+      properties:
+        clocks: false
+
 unevaluatedProperties: false
 
 examples:
@@ -69,3 +103,13 @@ examples:
         #interconnect-cells = <2>;
         qcom,bcm-voters = <&apps_bcm_voter>;
     };
+
+    aggre1_noc: interconnect@1700000 {
+        compatible = "qcom,qcs615-aggre1-noc";
+        reg = <0x1700000 0x3f200>;
+        #interconnect-cells = <2>;
+        qcom,bcm-voters = <&apps_bcm_voter>;
+        clocks = <&gcc_aggre_ufs_phy_axi_clk>,
+                 <&gcc_aggre_usb2_sec_axi_clk>,
+                 <&gcc_aggre_usb3_prim_axi_clk>;
+    };
-- 
2.43.0


