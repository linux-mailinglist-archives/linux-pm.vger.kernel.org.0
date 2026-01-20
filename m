Return-Path: <linux-pm+bounces-41167-lists+linux-pm=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-pm@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id YPHiKryjb2kNDwAAu9opvQ
	(envelope-from <linux-pm+bounces-41167-lists+linux-pm=lfdr.de@vger.kernel.org>)
	for <lists+linux-pm@lfdr.de>; Tue, 20 Jan 2026 16:48:12 +0100
X-Original-To: lists+linux-pm@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 1C57E46AC4
	for <lists+linux-pm@lfdr.de>; Tue, 20 Jan 2026 16:48:12 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 42B2F56B945
	for <lists+linux-pm@lfdr.de>; Tue, 20 Jan 2026 13:41:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4E9BF43C05E;
	Tue, 20 Jan 2026 13:38:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="Keb6RnWV";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="Q+49glnK"
X-Original-To: linux-pm@vger.kernel.org
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B02E121ABBB
	for <linux-pm@vger.kernel.org>; Tue, 20 Jan 2026 13:38:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768916299; cv=none; b=FJVtRGWjLD5UrpZKLVu9hn8hE8mM5aiPLIRjJ46KoyqFcxxd2o9iKvhe0VMwE1AmJxStjBPNmRrB/N6mj3wG1MGJiXea08DExva2NseLo+QvZfygnGlkr8x5Ss0WotwupuXCpLJzJC7qEF1dUQPcAb2bLgsO75lzhprdFmzOswY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768916299; c=relaxed/simple;
	bh=qsHYpCRnHkR9B4hsaDF2UxeZUZc9qiyn2qq13er/Eo0=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:To:Cc; b=uBv2ouAZf2GA+ONn5IlepEB2fOv71G9x/yPG45udevel6ZrLLZ8CXRa29Bq4/cIcCnU6Pf7lnftTf05EKGRdZ/X7QTQAu0pGwyF6/kzdl0S+38a9AXBvxOdpu8bnlmitNYOcVwSHpV0ICxF3cmGRxTIdDXDTVoMjYMSW+nmj+XE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=Keb6RnWV; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=Q+49glnK; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279866.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 60KA7lxP3837153
	for <linux-pm@vger.kernel.org>; Tue, 20 Jan 2026 13:38:17 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:message-id
	:mime-version:subject:to; s=qcppdkim1; bh=267stE2GFuXel8U/+66Flp
	SLqJa+/S4BZouInklqODc=; b=Keb6RnWVf5omLaHbSodX96ZoHrYUs0Trpls0yB
	Gyz0EkmLp/bipEmk/cFMFGXkfarp5s/foRVA7UTXiGPmD0x23Sur0s6DIiEjIiKD
	slfCoZkKrvRB1orj144bjwz16MXziKUnMtEz2FP+hMhFXAOSd3PnghldXrAymoC1
	sK51s2ctpze2jiY83ywHkWHVOp6EbwUDtpHdNgSCDlrzzOWmWN5A1/1MmJ7bL6Xt
	lO8fHne+giMUxjwmM61/NY/SdKG5yb/ZmofIpQA54Qica3BHOxM3f/CzZ3LANtDM
	n08g1sZzwzPvMYY3IPZg1akWJBr0E1C+j3rWjsQQl8REEiQg==
Received: from mail-pg1-f199.google.com (mail-pg1-f199.google.com [209.85.215.199])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4bt7pb8jm1-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-pm@vger.kernel.org>; Tue, 20 Jan 2026 13:38:16 +0000 (GMT)
Received: by mail-pg1-f199.google.com with SMTP id 41be03b00d2f7-c52ab75d57cso3028028a12.1
        for <linux-pm@vger.kernel.org>; Tue, 20 Jan 2026 05:38:16 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1768916296; x=1769521096; darn=vger.kernel.org;
        h=cc:to:message-id:content-transfer-encoding:mime-version:subject
         :date:from:from:to:cc:subject:date:message-id:reply-to;
        bh=267stE2GFuXel8U/+66FlpSLqJa+/S4BZouInklqODc=;
        b=Q+49glnKRNDhAODOeogIsq1UInd3/rFjHfzUud7+HwdFDl7OT8Efnw8akDhEN3iuts
         CfffQQAvobHOHSmrOkPzU+1eriKxofrmWP4VekwhqIFZ3oEY/BoJVEDFrPDw0DasGVe1
         pk3XaaAbg1t2T2Hg7X0iOPlLL/hmpcxUeEjlLAwiGzv1gzQ6xs1f17XPa1XKI6lvVE/M
         BO1RG8qQ7fX4iG+GG1maRrVuYNmNHiu8Z5wUgE6NWa7n5UPVrQBYkMuZ9vOGTMx6L/ZE
         DiLh2IfIUTuW0PlgD5Xff9e6jNM0GntoFmCEP26QJDqLMZSg/aqYuVG2Wevn51XgY9qi
         MNtQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1768916296; x=1769521096;
        h=cc:to:message-id:content-transfer-encoding:mime-version:subject
         :date:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=267stE2GFuXel8U/+66FlpSLqJa+/S4BZouInklqODc=;
        b=PiMgEBcAAHvln9FO953mzKsqdZVoMrltpxVeRahJ5hnJEVD6hiEfW6pGU4EmPog+It
         /rGinQYV48wz76YmxEcezBTCd9/joiD9RoeyUSWYDIeAObR4j4qT8abmZC2N3p9Rprx/
         nC+lneLl5t3lo1KKWmIWiZz/8rIvGl7zmlBk6Piv9l3iB9JwEYIhDlJsj9psF+XBTyzD
         SWCbocMczpmCP0ihBrXDgfLqOtamL13vvykAt14XwyKwcgKVM2KgrxU2cMqZNbiH5Xe2
         Jn1VZBN5Sb/FXpXbJ3dGc9kUWQxASJ3PYEBGRXPlXcCUz7stXob3+8GQtsPCidtETli/
         YVAQ==
X-Forwarded-Encrypted: i=1; AJvYcCUWdwopMwm8wUYdQc4uq12b/NLRYDDPi7GgkkxzKrm9Fo0DdatQdyja0MBlaOKrSgTqVRARuxxwNQ==@vger.kernel.org
X-Gm-Message-State: AOJu0YzvHYiva4+Q1evEc8N/xwmIDhs1D4fKE8iwmNuRv5NasJpvBMiu
	M3zh433Oi+CQnJqrv7/566HK7zk4lZYAnn0+VxYYTdj6tZindvZwrGPjaTNO9hSrPZ0Vw/wlN3i
	YnGjOXhIUW0Cwn8QXgIYh2Oct/WkIRAfhLfH6MJh1PywQwv+TkjXH6KhAGvTnqg==
X-Gm-Gg: AZuq6aK32P8RPJTWG9JjxQZzqZ04eD1o5QNYlg6cpnvrsFXAgoQqf00cOsA2waS1LEo
	YL+hO3RjJu3Xf/T6i78fP1GAHNkoViT0ikG+qJl9YxCl85PgGfg10EBvfxPH8pHWmbCVNjmOyGM
	j/dNfciHvQkwgY0EH9dLD4bpf0hZ2eAdxbfeo/76sipkaoe98FWIWEg74JG+cmAcxV4YvgcsQc3
	Ikam0pFMYanrWtvZPwC5vMrFgbOSBSmFbsHMDbHLyfrYz8AZPS/su7m3YTr6/82lx77q6GAbCaM
	Ap1k6461MGNmvt3YaP1P6VYi9il+bPkeliU2/S00pJIt7DHQBims27vWTPkE6Zp/yeR9EFZhjHo
	r032wkuygZdvrUhBqdrTbdLAwnm5zSeLo2EzfiKqkVgvUP7vVSoUkmf9GXwZ9ssvEu6ytG9nOcy
	l2OCrC9Ub5ooHzMwblIc8r9ZdSkTpB988zHAYi
X-Received: by 2002:a17:903:19c8:b0:2a0:8f6f:1a12 with SMTP id d9443c01a7336-2a7698fb4a5mr17389555ad.17.1768916296177;
        Tue, 20 Jan 2026 05:38:16 -0800 (PST)
X-Received: by 2002:a17:903:19c8:b0:2a0:8f6f:1a12 with SMTP id d9443c01a7336-2a7698fb4a5mr17389275ad.17.1768916295592;
        Tue, 20 Jan 2026 05:38:15 -0800 (PST)
Received: from hu-ppapaniy-blr.qualcomm.com (blr-bdr-fw-01_GlobalNAT_AllZones-Outside.qualcomm.com. [103.229.18.19])
        by smtp.gmail.com with ESMTPSA id 41be03b00d2f7-c5edf37b380sm12036532a12.34.2026.01.20.05.38.12
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 20 Jan 2026 05:38:15 -0800 (PST)
From: Pragnesh Papaniya <pragnesh.papaniya@oss.qualcomm.com>
Date: Tue, 20 Jan 2026 19:07:35 +0530
Subject: [PATCH] dt-bindings: interconnect: qcom-bwmon: Document Glymur
 BWMONs
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260120-glymur_bwmon_binding-v1-1-57848445eccf@oss.qualcomm.com>
X-B4-Tracking: v=1; b=H4sIAB6Fb2kC/x3MSwqAMAwA0atI1hbaLlS8iogYG2tAo7T4Q7y7x
 eVbzDwQKTBFqLMHAh0ceZUEk2cwTL14UuySwWpbaGO18vO97KHDc1mlQxbH4pUrqqpEi+hGAyn
 dAo18/dumfd8PUOZDz2YAAAA=
X-Change-ID: 20260120-glymur_bwmon_binding-d6887b2bbdf1
To: Krzysztof Kozlowski <krzk@kernel.org>, Georgi Djakov <djakov@kernel.org>,
        Rob Herring <robh@kernel.org>, Conor Dooley <conor+dt@kernel.org>
Cc: linux-arm-msm@vger.kernel.org, linux-pm@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        rajendra.nayak@oss.qualcomm.com, sibi.sankar@oss.qualcomm.com,
        pankaj.patil@oss.qualcomm.com,
        Pragnesh Papaniya <pragnesh.papaniya@oss.qualcomm.com>
X-Mailer: b4 0.14.3
X-Developer-Signature: v=1; a=ed25519-sha256; t=1768916292; l=1131;
 i=pragnesh.papaniya@oss.qualcomm.com; s=20260120; h=from:subject:message-id;
 bh=qsHYpCRnHkR9B4hsaDF2UxeZUZc9qiyn2qq13er/Eo0=;
 b=GOehMMGTepIPP9nBawCSmRE58R095vP8GAXG3TBLjmkUoJwOyw8qOrQ7tgJ6+Orm+KOnER05Z
 ihk4GY7dMtNDpduzS2iLZ+HiXyRvd5cX1YRXMc1ZUxJjIkETyT2UdQM
X-Developer-Key: i=pragnesh.papaniya@oss.qualcomm.com; a=ed25519;
 pk=09P9nFmZLXJ9+4Jx10ZK5rIW0Fmk79A/DLErm6aVA0c=
X-Authority-Analysis: v=2.4 cv=OMwqHCaB c=1 sm=1 tr=0 ts=696f8548 cx=c_pps
 a=Oh5Dbbf/trHjhBongsHeRQ==:117 a=Ou0eQOY4+eZoSc0qltEV5Q==:17
 a=IkcTkHD0fZMA:10 a=vUbySO9Y5rIA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=EUspDBNiAAAA:8 a=yciQ9CAyKdn08I1YtksA:9
 a=QEXdDO2ut3YA:10 a=_Vgx9l1VpLgwpw_dHYaR:22
X-Proofpoint-GUID: yI0fLANNccBx0tToE4Klt5nSMh1jJub1
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwMTIwMDExMiBTYWx0ZWRfX2B4Y27dK8PE/
 xRj96AI/XAa1EB/Dh5ezxyer+V0j+mCiJfwxgiwkHSn2kWiATTF2mHVskH6DDidXXAzaDTgY6W/
 wXFXvI4pmv+otUxoqvd1OhiMMGUR7A/Gd+tfAKGXGQ0iMlQN8Wk7rYQZgtxP70il7wzzVs5ssUu
 MWHV5HRgjwR2GvH+svjSWmRmTT/aBqjMWBAldWtTIBa+55Wcch8mR24ht4cx0wWtImMVBea48Ya
 KwEkDcOdhRJZB+e775tfCB6ADUvdlUUM40ibaLmLNXtC3CXtCMabWwfVKy04p1ske5tPCuOrg0l
 6Qh3hUq9K/B0Ci4ROO3i9oe8gT1LAlI/t6euslxR7G/lbs+WAQt6RIRNQSlI/DvJWTMUYq069Zd
 LVbHdSG6gg1Xf2SNv0eMiIdQrmHdSKM/rbLXijDsmRbS9IKVibWaYxF3YgV5fmbIWvI/6XQkAbf
 WMq1DIfg+Bww+Vpn6Bw==
X-Proofpoint-ORIG-GUID: yI0fLANNccBx0tToE4Klt5nSMh1jJub1
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.20,FMLib:17.12.100.49
 definitions=2026-01-20_03,2026-01-20_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 clxscore=1011 suspectscore=0 lowpriorityscore=0 malwarescore=0 spamscore=0
 adultscore=0 impostorscore=0 bulkscore=0 priorityscore=1501 phishscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2601150000 definitions=main-2601200112
X-Spamd-Result: default: False [-1.96 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW_WITH_FAILURES(-0.50)[];
	R_DKIM_ALLOW(-0.20)[qualcomm.com:s=qcppdkim1,oss.qualcomm.com:s=google];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	DMARC_POLICY_ALLOW(0.00)[qualcomm.com,reject];
	DKIM_TRACE(0.00)[qualcomm.com:+,oss.qualcomm.com:+];
	TAGGED_FROM(0.00)[bounces-41167-lists,linux-pm=lfdr.de];
	DBL_BLOCKED_OPENRESOLVER(0.00)[oss.qualcomm.com:mid,oss.qualcomm.com:dkim,dfw.mirrors.kernel.org:rdns,dfw.mirrors.kernel.org:helo];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[12];
	MIME_TRACE(0.00)[0:+];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	ASN(0.00)[asn:7979, ipnet:2605:f480::/32, country:US];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[pragnesh.papaniya@oss.qualcomm.com,linux-pm@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	MID_RHS_MATCH_FROM(0.00)[];
	R_SPF_SOFTFAIL(0.00)[~all:c];
	TAGGED_RCPT(0.00)[linux-pm,dt];
	RCVD_COUNT_SEVEN(0.00)[7]
X-Rspamd-Queue-Id: 1C57E46AC4
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

Document Glymur BWMONs, which has multiple (one per cluster) BWMONv4
instances for the CPU->DDR path.

Signed-off-by: Pragnesh Papaniya <pragnesh.papaniya@oss.qualcomm.com>
---
 Documentation/devicetree/bindings/interconnect/qcom,msm8998-bwmon.yaml | 1 +
 1 file changed, 1 insertion(+)

diff --git a/Documentation/devicetree/bindings/interconnect/qcom,msm8998-bwmon.yaml b/Documentation/devicetree/bindings/interconnect/qcom,msm8998-bwmon.yaml
index 17b09292000e..ce79521bb1ef 100644
--- a/Documentation/devicetree/bindings/interconnect/qcom,msm8998-bwmon.yaml
+++ b/Documentation/devicetree/bindings/interconnect/qcom,msm8998-bwmon.yaml
@@ -25,6 +25,7 @@ properties:
       - const: qcom,msm8998-bwmon       # BWMON v4
       - items:
           - enum:
+              - qcom,glymur-cpu-bwmon
               - qcom,kaanapali-cpu-bwmon
               - qcom,qcm2290-cpu-bwmon
               - qcom,qcs615-cpu-bwmon

---
base-commit: d08c85ac8894995d4b0d8fb48d2f6a3e53cd79ab
change-id: 20260120-glymur_bwmon_binding-d6887b2bbdf1

Best regards,
-- 
Pragnesh Papaniya <pragnesh.papaniya@oss.qualcomm.com>


