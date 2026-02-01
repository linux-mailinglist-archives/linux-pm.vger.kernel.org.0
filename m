Return-Path: <linux-pm+bounces-41860-lists+linux-pm=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-pm@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id IKW+Er8vf2k8lQIAu9opvQ
	(envelope-from <linux-pm+bounces-41860-lists+linux-pm=lfdr.de@vger.kernel.org>)
	for <lists+linux-pm@lfdr.de>; Sun, 01 Feb 2026 11:49:35 +0100
X-Original-To: lists+linux-pm@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [IPv6:2600:3c09:e001:a7::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 28ACBC593A
	for <lists+linux-pm@lfdr.de>; Sun, 01 Feb 2026 11:49:35 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id 017373005AA4
	for <lists+linux-pm@lfdr.de>; Sun,  1 Feb 2026 10:49:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CB8EF329C7D;
	Sun,  1 Feb 2026 10:49:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="oVyVxA+U";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="OeArFeIA"
X-Original-To: linux-pm@vger.kernel.org
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8D3D432AABD
	for <linux-pm@vger.kernel.org>; Sun,  1 Feb 2026 10:49:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769942960; cv=none; b=O+xFSC2TGp1ZG6YIa44+/sprR6lt7gxf0siqeMB5Td3kC3z0ptSlYH9b5rNYUiEGrc2zgzuedczJOwbWVAQOky+SDDE3M/A//6QtIrsnR4mvlg7s18yZxH7anIq7lK33ZRD4oIUbU1ZYjr4KLUtLOghEizL/yCv0uRzU2U2Owds=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769942960; c=relaxed/simple;
	bh=08Sn8ZyMBT+vHAsuVDVND86rYKzAvCUVmrUVd6L26SM=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=tm+UbvjAGHlJa09NpsJfm4A7kIgWh2pEfL0i5lKAfQd9SgJ2qosKxItx7HY9mZaCBRZzjBPyA8cd+KJaU3LaZyC0OmXI1QNybgxvrUcgJd6QGZF2k3tZTJjVGhEx8lkeZEKG8NBQwBh8oWY/6EGMOoh0FUQb1ZTdQokgHAX4Bus=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=oVyVxA+U; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=OeArFeIA; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279870.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 6117Rr3e053810
	for <linux-pm@vger.kernel.org>; Sun, 1 Feb 2026 10:49:17 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	szfYc8EHy+TFmXH57kCGj8OpDH95rbeoFaUQxs6n4Sc=; b=oVyVxA+UYbouSXTp
	KgS9oi387VYlH7gkjPxAiEYzwU0LxdzEEarm0uLknHmsoQrQRgI+lS4b4fWzLU34
	zZibNCMRQ/Rbpi4q8l8JEJaovJAq4OpoYYYmte5vaQGDbSFZ+iLAA+SLvk96cDnY
	AUVxGAQMqlmZPg1B947MaQOYKHSprWOWdZdSwKRz38T5Z4SOlEbN3km+HfMRVGtn
	3t60UcbZGnxJpSm0U02qrgciTMC+UhtiXSyy7ko7ydOWkVqVw2s8GQln/d1hbE5o
	0hKODYw7REOn9S4J77MYOc8b/UqlAUpAvZXAwH0CvX3N2jhk63vorJ47pReMGaEf
	w/7bTQ==
Received: from mail-qt1-f199.google.com (mail-qt1-f199.google.com [209.85.160.199])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4c1avnjefy-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-pm@vger.kernel.org>; Sun, 01 Feb 2026 10:49:17 +0000 (GMT)
Received: by mail-qt1-f199.google.com with SMTP id d75a77b69052e-502a35b12ceso120290411cf.0
        for <linux-pm@vger.kernel.org>; Sun, 01 Feb 2026 02:49:17 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1769942957; x=1770547757; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=szfYc8EHy+TFmXH57kCGj8OpDH95rbeoFaUQxs6n4Sc=;
        b=OeArFeIAmVM2xl2MG2Gmegpd+fh/kUd7QtQcvtByaluLbAjU9UavRsxC+SSP+4ZIYo
         INxO43S8P6whKH4uoyhuXp5bWlDobTMycxPRXHRK3sWQuYIoGlG27gSHfLh+zx8NmVt9
         Ti+e+tcf2ZBbVSTOWQ9S9DFAfkGGX6qz7B3jYcDkk+5yCfzT1eI6DJQiNSqNvoaWpPyx
         i8H0TpSUPmKlje43t/yNoZJVf7ceAPp6KeK2iCv4EqFDaiFslHdwvYse5PNe6MelBB+4
         uA8L5Dnqp4QSBCkUZ4JGGAbycu2z/5CodjWPnxJgFn8FrUz+nMzalKi9iQ40AAjXD+6S
         Rrqg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1769942957; x=1770547757;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-gg:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=szfYc8EHy+TFmXH57kCGj8OpDH95rbeoFaUQxs6n4Sc=;
        b=vWH9kf4PykIMZg9eyh2BlOf8PVOhIXoFdbz+85lT4sbJ8AUPNmEPo75HO5GueDRt5q
         PVVrMfY7NKJW+5Ho/ulQg9GkTcIF/PmH3VQt6Q0SyClEYYEm9/3rQNf8/EYk2HwI5VJK
         M/LX9JU6RM9Aa6dWKtmU9VYBm9duhEqP7KtskDCOV9lAhDy1yl7NZrt6jRpQLFEiM0JB
         C9a8vNbWnsGTbPfdXI5DVPRmCy8gCG4KtxmC1ayYqOrE+yzcNIlFOuKRvE6ez3I5aKSB
         3CUcjy2wWVxoWHLJMheTb7rXPYujO0CGNG2QMQQgCa7qzihWAuqkl9fVS0xY0m9kePLj
         N5qA==
X-Forwarded-Encrypted: i=1; AJvYcCVnQzLR4CqRBuPvBApk87s8S+LGt5nMLrg3fboN4lgkNcP77VqjksiK2reMQ+1GS2BpK7PZo+kJ6w==@vger.kernel.org
X-Gm-Message-State: AOJu0Yy7CG189mbdmo0wze4bxnmWlaFzrwRztdffOOpP7t/jLK1E0HuW
	bbAv8isFugZ9s0RIQfBvHvcV9ko0RPF2XWXZ+jdzTAXagnUBJmVdiPOLJxYqvLR0O0LHgEKV1Z5
	QgVkPitASq1jZWoY49fHop3skbi2eWxhPlVUfjSsl5NS/V51n23TbbncJnsct6w==
X-Gm-Gg: AZuq6aKvuMI0w5cz1Q9D7cgoPE8i/0Ywlr6Bu1yEeEb7ExpylrEyNB1TYr6bt9XfwoB
	ZdjV5E6TSyB8OhlsX1ctZkKzSHyY1nsIyjuCgXbtFyyt4iOq5OEu6mpNh1h3LVPD7QRfeql4sM5
	jPcFJVFUEsrLW7sRkUzrE1ehAAIdX228MOq4EvifPXpsqX2ro3Q9bNKd/uIkPAV0G1CSYRXeJ2O
	cF9ZEj9pynZqwCJ+lf3Fl8yhhb6iUipjyJpm2c0S0k6NN5kEU9+B9ge2nkVlb/xmL26WM9pNjuz
	sdHozGWWla3QN02NHO7zj+1F2RROo5H3Y5Jiu2t+D627cDvumNtR6oF708K4dS+a3pLTOc16HD2
	9wxgNkBczfDbAC0rZeNvE+e6CbEHBmGK4M/gyV0sN7uB7p74IJAYjnl1aCBemh4KkpIWyHYi6yq
	lAnnF8ovbDGmal1NmvE4x1Ig0=
X-Received: by 2002:a05:622a:15c2:b0:503:2f5b:fb6b with SMTP id d75a77b69052e-505d22d5610mr106499181cf.80.1769942956908;
        Sun, 01 Feb 2026 02:49:16 -0800 (PST)
X-Received: by 2002:a05:622a:15c2:b0:503:2f5b:fb6b with SMTP id d75a77b69052e-505d22d5610mr106498801cf.80.1769942956479;
        Sun, 01 Feb 2026 02:49:16 -0800 (PST)
Received: from umbar.lan (2001-14ba-a073-af00-264b-feff-fe8b-be8a.rev.dnainternet.fi. [2001:14ba:a073:af00:264b:feff:fe8b:be8a])
        by smtp.gmail.com with ESMTPSA id 2adb3069b0e04-59e074b7a8csm2835006e87.77.2026.02.01.02.49.14
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 01 Feb 2026 02:49:15 -0800 (PST)
From: Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>
Date: Sun, 01 Feb 2026 12:49:00 +0200
Subject: [PATCH v2 3/8] media: dt-bindings: qcom,sm8250-venus: sort out
 power domains
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260201-iris-venus-fix-sm8250-v2-3-6f40d2605c89@oss.qualcomm.com>
References: <20260201-iris-venus-fix-sm8250-v2-0-6f40d2605c89@oss.qualcomm.com>
In-Reply-To: <20260201-iris-venus-fix-sm8250-v2-0-6f40d2605c89@oss.qualcomm.com>
To: Bjorn Andersson <andersson@kernel.org>,
        Michael Turquette <mturquette@baylibre.com>,
        Stephen Boyd <sboyd@kernel.org>, Rob Herring <robh@kernel.org>,
        Krzysztof Kozlowski <krzk+dt@kernel.org>,
        Conor Dooley <conor+dt@kernel.org>, Taniya Das <quic_tdas@quicinc.com>,
        Jonathan Marek <jonathan@marek.ca>,
        Ulf Hansson <ulf.hansson@linaro.org>,
        "Rafael J. Wysocki" <rafael@kernel.org>,
        Bryan O'Donoghue <bod@kernel.org>,
        Vikash Garodia <vikash.garodia@oss.qualcomm.com>,
        Dikshita Agarwal <dikshita.agarwal@oss.qualcomm.com>,
        Mauro Carvalho Chehab <mchehab@kernel.org>,
        Stanimir Varbanov <stanimir.varbanov@linaro.org>,
        Abhinav Kumar <abhinav.kumar@linux.dev>,
        Hans Verkuil <hverkuil@kernel.org>,
        Stefan Schmidt <stefan.schmidt@linaro.org>,
        Konrad Dybcio <konradybcio@kernel.org>,
        Bryan O'Donoghue <bryan.odonoghue@linaro.org>,
        Dikshita Agarwal <dikshita@qti.qualcomm.com>
Cc: linux-arm-msm@vger.kernel.org, linux-clk@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-pm@vger.kernel.org, linux-media@vger.kernel.org,
        Mauro Carvalho Chehab <mchehab+huawei@kernel.org>
X-Mailer: b4 0.14.3
X-Developer-Signature: v=1; a=openpgp-sha256; l=1866;
 i=dmitry.baryshkov@oss.qualcomm.com; h=from:subject:message-id;
 bh=08Sn8ZyMBT+vHAsuVDVND86rYKzAvCUVmrUVd6L26SM=;
 b=owEBbQGS/pANAwAKAYs8ij4CKSjVAcsmYgBpfy+kHGPCCxQ13FYzvXdjC5DPK1VzuylOxFe4O
 wIcm9gRSbeJATMEAAEKAB0WIQRMcISVXLJjVvC4lX+LPIo+Aiko1QUCaX8vpAAKCRCLPIo+Aiko
 1RxBB/9Qer3EyE1jBC+/TKxjCJVTeA5Sg+EA/AR7y6sO1PbzX2loz5u84RwJQrQUrucF1q+V3B2
 QARRCtpU6LKkiDoTAkjOGtRCzrDlKxKxFefj6/U15L/dfkeFqidj938rQItOwf/MtyghAl7dHln
 uxLvYFar2GFt2sdJQzgjdvPjY62nnENkbDQhMfl7HhUzKOcTWTkaVZu20E74M4MTVFGbkA8IK+f
 Mqp05/U2oraWxj3EW4ca3yt1lF2qP3sYz+mSbAK9dVjC5ClqMZTVMFg9J1wjBmC0MBxbucyfcxy
 x9B3gXjfAhfzgAPoAyoROSqkm7Jl7EKWKn7L4KMfrbJgjlTl
X-Developer-Key: i=dmitry.baryshkov@oss.qualcomm.com; a=openpgp;
 fpr=8F88381DD5C873E4AE487DA5199BF1243632046A
X-Proofpoint-ORIG-GUID: fWHd_QQTdltIq6jiC_C3XR9qrif7Dr8l
X-Authority-Analysis: v=2.4 cv=bPMb4f+Z c=1 sm=1 tr=0 ts=697f2fad cx=c_pps
 a=WeENfcodrlLV9YRTxbY/uA==:117 a=xqWC_Br6kY4A:10 a=IkcTkHD0fZMA:10
 a=HzLeVaNsDn8A:10 a=s4-Qcg_JpJYA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=EUspDBNiAAAA:8 a=V4YYwRrX08S5_i0GLdQA:9 a=QEXdDO2ut3YA:10
 a=kacYvNCVWA4VmyqE58fU:22
X-Proofpoint-GUID: fWHd_QQTdltIq6jiC_C3XR9qrif7Dr8l
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwMjAxMDA5NCBTYWx0ZWRfX6MvuGNqjgbOV
 q8Hquf57FHuG+uB+rGgS6lvRqwJtHcGMtGcNaAOA036Ld1RFHlduRahRAfBNKNS/0jVgRFyP6gA
 bg7U3lPYORg//FvnaPj5qDbboHQ46cJkPeFgUikGsonwoXexqLU28gjSiMGR01w8NicfmnLqGJ1
 4LhoczgXrQUZ5R+FDQra4Oec2JJJTKPGBbSKvGspAl2wleVCY9Y3ToxGRwNfwDYv7xIfpX2RvpN
 xTk0X743eJ3EaqH6aDSsqqj8F/w9Qhc87Hlxjj3Q5lHJyPHSa/2Ipn01vmFoCEmJLkiCzJ177qu
 gBeB6qedyHSpfiESzNzDRUfkeqp9RoYeInYbhjnzJkj23ZC3kQTMf6RrPLOoLLc6KDe0fPdu0+s
 dU6xZQTxXJGO0NxhT6p6r7PFchUM3t4lID3sKOAd14M5SOBTZCOV8wCHvUlCktLloip18x43+wj
 vCihPQ4H/o7j0RktGuw==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-02-01_04,2026-01-30_04,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 adultscore=0 clxscore=1015 malwarescore=0 suspectscore=0 bulkscore=0
 phishscore=0 priorityscore=1501 spamscore=0 lowpriorityscore=0
 impostorscore=0 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2601150000
 definitions=main-2602010094
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.66 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[qualcomm.com,reject];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c09:e001:a7::/64:c];
	R_DKIM_ALLOW(-0.20)[qualcomm.com:s=qcppdkim1,oss.qualcomm.com:s=google];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	MIME_TRACE(0.00)[0:+];
	RCPT_COUNT_TWELVE(0.00)[28];
	FORGED_SENDER_MAILLIST(0.00)[];
	TAGGED_FROM(0.00)[bounces-41860-lists,linux-pm=lfdr.de];
	DKIM_TRACE(0.00)[qualcomm.com:+,oss.qualcomm.com:+];
	RCVD_TLS_LAST(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[qualcomm.com:email,qualcomm.com:dkim,sto.lore.kernel.org:helo,sto.lore.kernel.org:rdns,oss.qualcomm.com:mid,oss.qualcomm.com:dkim];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[dmitry.baryshkov@oss.qualcomm.com,linux-pm@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c09::/32, country:SG];
	NEURAL_HAM(-0.00)[-1.000];
	TAGGED_RCPT(0.00)[linux-pm,dt,huawei];
	MID_RHS_MATCH_FROM(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	RCVD_COUNT_SEVEN(0.00)[7]
X-Rspamd-Queue-Id: 28ACBC593A
X-Rspamd-Action: no action

First of all, on SM8250 Iris (ex-Venus) core needs to scale clocks which
are powered by the MMCX domain. Add MMCX domain to the list of the power
domain to be used on this platform.

While we are at it, drop minItems from both power-domains and
power-domains-names, it doesn't make sense from the hardware point of
view. There are always 2 GDSCs and two power rails wired to the video
clock controller and Venus. Disallow passing just two.

Signed-off-by: Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>
---
 Documentation/devicetree/bindings/media/qcom,sm8250-venus.yaml | 10 +++++-----
 1 file changed, 5 insertions(+), 5 deletions(-)

diff --git a/Documentation/devicetree/bindings/media/qcom,sm8250-venus.yaml b/Documentation/devicetree/bindings/media/qcom,sm8250-venus.yaml
index da54493220c9..04cbacc251d7 100644
--- a/Documentation/devicetree/bindings/media/qcom,sm8250-venus.yaml
+++ b/Documentation/devicetree/bindings/media/qcom,sm8250-venus.yaml
@@ -21,15 +21,14 @@ properties:
     const: qcom,sm8250-venus
 
   power-domains:
-    minItems: 2
-    maxItems: 3
+    maxItems: 4
 
   power-domain-names:
-    minItems: 2
     items:
       - const: venus
       - const: vcodec0
       - const: mx
+      - const: mmcx
 
   clocks:
     maxItems: 3
@@ -114,8 +113,9 @@ examples:
         interrupts = <GIC_SPI 174 IRQ_TYPE_LEVEL_HIGH>;
         power-domains = <&videocc MVS0C_GDSC>,
                         <&videocc MVS0_GDSC>,
-                        <&rpmhpd RPMHPD_MX>;
-        power-domain-names = "venus", "vcodec0", "mx";
+                        <&rpmhpd RPMHPD_MX>,
+                        <&rpmhpd RPMHPD_MMCX>;
+        power-domain-names = "venus", "vcodec0", "mx", "mmcx";
 
         clocks = <&gcc GCC_VIDEO_AXI0_CLK>,
                  <&videocc VIDEO_CC_MVS0C_CLK>,

-- 
2.47.3


