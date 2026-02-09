Return-Path: <linux-pm+bounces-42366-lists+linux-pm=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-pm@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id mPqkCV1Iimm9JAAAu9opvQ
	(envelope-from <linux-pm+bounces-42366-lists+linux-pm=lfdr.de@vger.kernel.org>)
	for <lists+linux-pm@lfdr.de>; Mon, 09 Feb 2026 21:49:33 +0100
X-Original-To: lists+linux-pm@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [104.64.211.4])
	by mail.lfdr.de (Postfix) with ESMTPS id 407621148D3
	for <lists+linux-pm@lfdr.de>; Mon, 09 Feb 2026 21:49:32 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id 107373008602
	for <lists+linux-pm@lfdr.de>; Mon,  9 Feb 2026 20:49:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8C54333BBD2;
	Mon,  9 Feb 2026 20:49:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="G08Ldzh4";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="GKPC0ywa"
X-Original-To: linux-pm@vger.kernel.org
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 22B81311972
	for <linux-pm@vger.kernel.org>; Mon,  9 Feb 2026 20:49:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770670160; cv=none; b=nPD+WqNbqKVYsuvHxlTN5Zklj97N4HcHqFXrzG2LCwQKR/djGCxzS7C6XNDqqtmGKdL9KS60PWPKSQNi6OrG5+i1W3F1vi1uZpAHUoC7JtwDMBrEtcojgkXSx4FvBfg74kkecPss0gevE3r/EbwI7ZkCO3yH4s/ISJtxLhb+Cck=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770670160; c=relaxed/simple;
	bh=HwnGZ3cKZvOD2FzYP6um9IqcfY3jnwy0Lssknz6kz1g=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=gFuVULXYyLycKATr4qMH9RjAN7WNIqlsIpfWn6tds2LpHTYFtTPb8lR+dolqAkwg/BXeQYGva/KImZ/4o2wX+hiNi/LxVu6kV/Ff/CTPSEfSOUVTHmRvue9dV2HSB0LmG/peVwsZNfxGs9smCqBtwT94RS9HKH/Tw/l3yPV/ZK0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=G08Ldzh4; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=GKPC0ywa; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279864.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 619DF7Fa857025
	for <linux-pm@vger.kernel.org>; Mon, 9 Feb 2026 20:49:18 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:date:from:in-reply-to:message-id
	:mime-version:references:subject:to; s=qcppdkim1; bh=xiuvzHoOW/F
	8kB3kHeqD8PEamlh8VCXtCJ3Ykz5i4zg=; b=G08Ldzh42Jozrf/HSU+ysZrTMsB
	NCBcchNiA11/egHMLOXLCwJoFabA8ku6kXKlCSCoUjGhShK38rPzUZA60ifqdF4l
	xFWJo+dPbQXxIrfxPV84EimRuvZ+mZq0y3e2PRLE/8udbP61MvTlBaB4iGVPDAiN
	Nohm9C3DHmZB83/WV4AMatYf6p2bVEXzHwyrJut6OxQ6dIi+ygdzXxxP5xjbIhOc
	xjraJ1PX+RFUbSgE2AO9f+4YDSDleHzOoAfmTQhApI9ABMmZKqIoqWEg1we6VJ7t
	ZNNsCD79463lSLlC3FoZ539KUhEn5DTRedk1DsJnl2LenORXRKIri27cz5w==
Received: from mail-dy1-f198.google.com (mail-dy1-f198.google.com [74.125.82.198])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4c7ga61fmm-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-pm@vger.kernel.org>; Mon, 09 Feb 2026 20:49:18 +0000 (GMT)
Received: by mail-dy1-f198.google.com with SMTP id 5a478bee46e88-2ba68ed568bso539923eec.1
        for <linux-pm@vger.kernel.org>; Mon, 09 Feb 2026 12:49:18 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1770670158; x=1771274958; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=xiuvzHoOW/F8kB3kHeqD8PEamlh8VCXtCJ3Ykz5i4zg=;
        b=GKPC0ywaho+eLAOBo5zbB1j+01XZXqoK9tLnHwqKgP3Ku3wtGo41I/ybqmThH9BqST
         8u97ljsTnXDQW48NL7pSPoPipbOWH3u2Nu8hu18o0/xkM8iK4mnJ1fKes4Bd6eDCfjMR
         HYKEO128W8ngLVkLADHu+pMFEW3gan50pho3G6GWw5in0Trux7TfmDyFntmtD7jmC0a9
         rlcW0Nyqd8yBfXgatuw9PR3PNyOd/d8OYhWjLmaaVcpqnTDBtsVAL332A/oY4vY1ZNeh
         LiHZRnEZQMj/8x+6aYSbPHeNUEBQ4/2i6MWPE7HKIdZqnSIA58XyDZBhvrmez0bYMUC/
         8LnA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1770670158; x=1771274958;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=xiuvzHoOW/F8kB3kHeqD8PEamlh8VCXtCJ3Ykz5i4zg=;
        b=HyeS/RjsUvcj0SnkuPYnQVbSwdlR9/+s5o7djYHIL50tGyTnlG6mtV58GzRUCx2rpS
         vbjcyVuhHAbqwoX0EpxN1rCsjmR/mCb3SFIElMLQgksx7Am0bjPM4PSBGhPS2GZ45R5V
         n2VoVXa72uRzNdqC+ixnIxZQFqQgZM+DAOb3ZROWfTg6yNv0Gp/900jZR/Lhz9Vinu3R
         cI1bcjElwwe/r9425tELJdiQ1IrnWAWI2qhdA25OeFKRU3cVh5IlO1ct9ezWUtkiUvoa
         JVT0qOWr6RobON0qn1Y0R122U4JTp+PwI8Y+uRciLS93+jWfniVCpjWvZ8hfWxXqkNv6
         SBgg==
X-Forwarded-Encrypted: i=1; AJvYcCWzrvBLtI3T/PLimBvqSzP0U8lmM1rXO+DTeraqf5wWcjl5DOVT4FmD4wLo7ofATNB0R1PGQ8P0Ig==@vger.kernel.org
X-Gm-Message-State: AOJu0YxkcKmAIqlsXnyT+uaZkuBHYsQqb4UNpwnq9ge1ymwL9ma4ONCe
	UTSKccxRARrUOTrxvYifKHnQdDpgv5YQJ4mjXxDTWV0mFrc0vi9hhRpHDm38H2XvomxJdM7WDOg
	jNvLAFu6mnBWZzdiP9oIzKOTn6qfLa6EJC0c1o94lJokyFkCKAPJg2EeFE4qmcg==
X-Gm-Gg: AZuq6aIf+rmUHI1zdPJXyLFL2Owo2EFClnU83/9wEMhzphRyL0proMyHyJDmNh/kWRE
	1QwlaMzjvC0ImoGMNVj/Fvv0sBVRAQC3v3LbSJZNyNJHnxwrFwTSWQjyXUdm/LqqJ+cBH1fTkh5
	p6t+oKdWU+SCsQwfOJSq2gjVf8NvN+uMex+X60vQP89pG8xeWjXzEK7a8M792fpSQF4NASxT7d3
	tUQdAERYTiBSsJnobhVA6mgVt7/fnFuH/viniNCxAr8KgN2TlAkL4ya0m6ze5alDNvPyZEuCLMV
	mzCoVgrtvRFYKiHTZcdymylKctn7yHM1GurrjP55UwUTkeQFGruL7xZC0BsdZR9gtS1ayzUdXJM
	8wy6OVEt1E2TR1ZtYLT00aNPNurp+yrUPXiHHtdlLTMyijfCaJx3nr2l1UlPfEw5kVn57uEH5
X-Received: by 2002:a05:7300:862b:b0:2b7:4f83:9a84 with SMTP id 5a478bee46e88-2ba89d74668mr36039eec.17.1770670157873;
        Mon, 09 Feb 2026 12:49:17 -0800 (PST)
X-Received: by 2002:a05:7300:862b:b0:2b7:4f83:9a84 with SMTP id 5a478bee46e88-2ba89d74668mr36032eec.17.1770670157306;
        Mon, 09 Feb 2026 12:49:17 -0800 (PST)
Received: from hu-amelende-lv.qualcomm.com (Global_NAT1.qualcomm.com. [129.46.96.20])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-2ba89ae14c9sm106247eec.29.2026.02.09.12.49.16
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 09 Feb 2026 12:49:16 -0800 (PST)
From: Anjelique Melendez <anjelique.melendez@oss.qualcomm.com>
To: andersson@kernel.org, konradybcio@kernel.org, robh@kernel.org,
        krzk+dt@kernel.org, conor+dt@kernel.org, sre@kernel.org,
        heikki.krogerus@linux.intel.com, gregkh@linuxfoundation.org
Cc: linux-arm-msm@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-pm@vger.kernel.org,
        linux-usb@vger.kernel.org
Subject: [PATCH v5 1/5] dt-bindings: soc: qcom: qcom,pmic-glink: Add Glymur and Kaanapali compatibles
Date: Mon,  9 Feb 2026 12:49:11 -0800
Message-Id: <20260209204915.1983997-2-anjelique.melendez@oss.qualcomm.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20260209204915.1983997-1-anjelique.melendez@oss.qualcomm.com>
References: <20260209204915.1983997-1-anjelique.melendez@oss.qualcomm.com>
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Proofpoint-ORIG-GUID: h8Do3Qwb1insmJ_ZY-03EzWg88JQktZX
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwMjA5MDE3NSBTYWx0ZWRfX0PSE2aCk2cu8
 VdKph/m1S2MF8e3JdNQp60GavYZn63S4KxBFT/PCfAr+5ENgM2mU/YvGBkFJdCaVfOkqeJyOC6M
 BGQW/mirQZTE2psJTTaoKtFzpOfqQYq7muD8TJ/nSosnX8ExKMSpooOF1M/H+bUwBEO2BeEoppj
 tGha9uUwYc5MuT7JgzhQ/dfBGq+DrbIQ54jI4t3nl5Fs55loJ2rR6f5sv9HixCkgFBzJG3sFsJr
 apM+cEcE8iTQ1Y5t0C/UwzI9DyNzilxswcb7P3zv1EJomo6bpPTim20RcZnM1OXBcquoykEgWvU
 BjlZLCukMeVvNsRzYCD6RhYy/qyQOzvtnwT7jYiYYo6otILni7nqs2REMzv2of0Jun2YVQrFGit
 5lNpsbP0CpqafxtFvL1y6KrAmMpQcOAi2ConPnsTNH+3t6LJALd4JeA1qUp1boDvO5Ewu00D6RW
 EianbQgtX88cSKlg6yw==
X-Authority-Analysis: v=2.4 cv=WK1yn3sR c=1 sm=1 tr=0 ts=698a484e cx=c_pps
 a=wEP8DlPgTf/vqF+yE6f9lg==:117 a=ouPCqIW2jiPt+lZRy3xVPw==:17
 a=HzLeVaNsDn8A:10 a=s4-Qcg_JpJYA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=Mpw57Om8IfrbqaoTuvik:22 a=GgsMoib0sEa3-_RKJdDe:22 a=EUspDBNiAAAA:8
 a=dzyBTGdPCLdzs2CRRPwA:9 a=bBxd6f-gb0O0v-kibOvt:22
X-Proofpoint-GUID: h8Do3Qwb1insmJ_ZY-03EzWg88JQktZX
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-02-09_01,2026-02-09_04,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 bulkscore=0 priorityscore=1501 suspectscore=0 adultscore=0 malwarescore=0
 clxscore=1015 impostorscore=0 lowpriorityscore=0 phishscore=0 spamscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2601150000 definitions=main-2602090175
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [0.84 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	MID_CONTAINS_FROM(1.00)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[qualcomm.com,reject];
	R_MISSING_CHARSET(0.50)[];
	R_SPF_ALLOW(-0.20)[+ip4:104.64.211.4:c];
	R_DKIM_ALLOW(-0.20)[qualcomm.com:s=qcppdkim1,oss.qualcomm.com:s=google];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FROM_NEQ_ENVFROM(0.00)[anjelique.melendez@oss.qualcomm.com,linux-pm@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	TAGGED_FROM(0.00)[bounces-42366-lists,linux-pm=lfdr.de];
	MIME_TRACE(0.00)[0:+];
	RCVD_TLS_LAST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	DKIM_TRACE(0.00)[qualcomm.com:+,oss.qualcomm.com:+];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TAGGED_RCPT(0.00)[linux-pm,dt];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sin.lore.kernel.org:helo,sin.lore.kernel.org:rdns,oss.qualcomm.com:mid,oss.qualcomm.com:dkim];
	TO_DN_NONE(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	ASN(0.00)[asn:63949, ipnet:104.64.192.0/19, country:SG];
	RCPT_COUNT_TWELVE(0.00)[13];
	RCVD_COUNT_SEVEN(0.00)[7]
X-Rspamd-Queue-Id: 407621148D3
X-Rspamd-Action: no action

Glymur (a recent compute platform) and Kaanapali (a recent mobile
platform) have the charger FW running on a new subsystem SOCCP (SOC
Control Processor) instead of on ADSP like in previous platforms. Because
of this, pmic_glink interface on Glymur and Kaanapali platforms are not
compatible with previous platforms. Hence, add new compatible strings
for Glymur and Kaanapali.

Signed-off-by: Anjelique Melendez <anjelique.melendez@oss.qualcomm.com>
---
 Documentation/devicetree/bindings/soc/qcom/qcom,pmic-glink.yaml | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/Documentation/devicetree/bindings/soc/qcom/qcom,pmic-glink.yaml b/Documentation/devicetree/bindings/soc/qcom/qcom,pmic-glink.yaml
index 7085bf88afab..ff01d2f3ee5b 100644
--- a/Documentation/devicetree/bindings/soc/qcom/qcom,pmic-glink.yaml
+++ b/Documentation/devicetree/bindings/soc/qcom/qcom,pmic-glink.yaml
@@ -23,6 +23,8 @@ properties:
     oneOf:
       - items:
           - enum:
+              - qcom,glymur-pmic-glink
+              - qcom,kaanapali-pmic-glink
               - qcom,qcm6490-pmic-glink
               - qcom,sc8180x-pmic-glink
               - qcom,sc8280xp-pmic-glink
-- 
2.34.1


