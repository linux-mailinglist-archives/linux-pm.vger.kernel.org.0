Return-Path: <linux-pm+bounces-41550-lists+linux-pm=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-pm@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id wM4GKRreeGn7tgEAu9opvQ
	(envelope-from <linux-pm+bounces-41550-lists+linux-pm=lfdr.de@vger.kernel.org>)
	for <lists+linux-pm@lfdr.de>; Tue, 27 Jan 2026 16:47:38 +0100
X-Original-To: lists+linux-pm@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 1A8BF970A8
	for <lists+linux-pm@lfdr.de>; Tue, 27 Jan 2026 16:47:38 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 2004030EE5FD
	for <lists+linux-pm@lfdr.de>; Tue, 27 Jan 2026 15:28:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4D92C360746;
	Tue, 27 Jan 2026 15:26:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="XizrUHOb";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="BHmw3BjU"
X-Original-To: linux-pm@vger.kernel.org
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 854A9361DBC
	for <linux-pm@vger.kernel.org>; Tue, 27 Jan 2026 15:26:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769527595; cv=none; b=Omkhsdrt13OIS0L6rs/DzCf9RVWSjP/CjjI2ydAkI2lcT5XmM8GLQ0Go3qH2OV+ora/+2m+lzKTJ7/h7BXQUJNPj0T7SHuZCKXrFWx1knFvDluwTm1Qeai5vT+Lz1bWRhEYeZ/JJP5Tsf/cClr0ZVOFccWb2BwBzXQU6N7Bw6UA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769527595; c=relaxed/simple;
	bh=LRFTyZdDZzEIApAXCaO6Vf7pEkXsEikpYHJL//tUv4E=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=DjmKSsyMlEKIJaFqzmQPK/CeJ2xD2Dte64yTtLGtrOspgm8on1GlAobuix/yXE3J1fgjUVP+yKJpwYFo0kDl3Zj/K+kiZKjG1AuoajI6qBYpk2vja9zs17aMiQTHjXZo4EgtevjXS6jo7dx5cSQCOchV1pYx8eMPt44QOPA+smA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=XizrUHOb; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=BHmw3BjU; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279869.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 60RA9MLp1268740
	for <linux-pm@vger.kernel.org>; Tue, 27 Jan 2026 15:26:32 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	G9bElWJav3IGntOkEK9NYd+SDZciqNZqq2UyZZqUhA4=; b=XizrUHOb5LTp4GBG
	DGJNGNT7lrHbHn0FMgSANgOEFh33lVFhpABOJl05m/rcGOpPKDvLWeMmRd2HLxhT
	pgtOfnItiCLxw58nf7l3+K8Ekpilc0ZpULJpjSOM6/391V5NC6OeWq8fETQqSbnV
	yghlf//ngfGy8KI6hALHe4ips2VqMh1HmDOvyjhvF0HSTZkkHCGKYpUOR3F9sgnv
	9ryA+XQWK3rdaPhIt8B0LyQxtGoNgaM8TM6/cdaLBp4aF2KC8Vs1Jm3HDrW4lRZ/
	3XohepQelyrabSmoIkjCEzCDKSyl9mcMUmi2/upz6+zbi+CzUJ8IzoXfhIPaB1jL
	TeHuKA==
Received: from mail-qk1-f197.google.com (mail-qk1-f197.google.com [209.85.222.197])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4bxnyat75p-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-pm@vger.kernel.org>; Tue, 27 Jan 2026 15:26:32 +0000 (GMT)
Received: by mail-qk1-f197.google.com with SMTP id af79cd13be357-8bb9f029f31so2054525885a.2
        for <linux-pm@vger.kernel.org>; Tue, 27 Jan 2026 07:26:32 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1769527592; x=1770132392; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=G9bElWJav3IGntOkEK9NYd+SDZciqNZqq2UyZZqUhA4=;
        b=BHmw3BjURvZ8NIskHsIPc7cdT5vMMbNzACJYneAMbtqhG72wVe/8WIVS3MV8Uh3XOf
         4G757u55xXN3spIyPzpKmoxlkJyyhTiMQ523fg00Ze/3N7sV5Not9omwz1mBISDAGAzQ
         OtOmHSGoc8t9zIfn1A/HziEfTljEn7yVXjEQMqiisMbrG0n3qITeNFqGSFg9GsCWj/fw
         iZIPoITd/bAEoamHDHtc7fZHv05YMD4fJrgvF1hmdkue+TNqNfevW205PJHdJdzKf9in
         nt6TqCWn1MR5f5dOK6dIM3gvPG5i1MQkvo++AE21xSkKtrhgPVJB4NEt6bPR1bEdYrHs
         b5bQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1769527592; x=1770132392;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-gg:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=G9bElWJav3IGntOkEK9NYd+SDZciqNZqq2UyZZqUhA4=;
        b=dLO3yKkcCtYPSTmgIEtg/ueLYnJpPPcbvSK4btl/lr0lTGZyBt49yoTn7vsyN7Id7U
         4ng5u7BZAo7vXyu9rNa6cBMPc5ir5R23IW60f+jtmxyNApwnhnvMUJmL0fX10LK+CsaN
         UaSxlp5mtAR3FzKfw0E6RuC/crEuwmNfIdi+YbS9L83vkY23xaOwKjTJxhUIA4b8bwyD
         eMfW5p7KrroQIR4Aa1YqV8Ub6JuocgsJ2/GMYMoCK9LKsP4X3uPc6A7EilYNCTz6hrBY
         Td0erEjhIyUBvLHw3lat+lzC/8fKBdmsrkvYWsXzBUKiWjRydxIcYVRa2qjowPYevslY
         0tjA==
X-Forwarded-Encrypted: i=1; AJvYcCWSKWRh6mUJM5yTsZGGWGy+HTa67/YIGeNfwqfR+0AXTPTParVCPCiUzhfDsuW+mNeu08w/Rf2DWQ==@vger.kernel.org
X-Gm-Message-State: AOJu0Yyx0WArmsG1R2y3vEFzOjkB+NvVfIzDPtrHzu+H00gvg9Bp3XSx
	c5w4Si/S6pRdHuzqZAgkcpT517hszmBHQ87TwjnAyx1sV2Zy6NRtK18wyLyDXcI5Nl3Uq0nzHA1
	d+GQv5D7jvAZUbQoIz7n9acxcr0aL3MshCduA92CI7n/6oIXAF5Dt6IgPyT/Ugg6UZiI/sA==
X-Gm-Gg: AZuq6aKFN+RNkImC/mH7cUoU6VrzivZOvUBlgJ/e7JrutB4CpOhSCYZb7vd5DPb0Fu8
	Ogc/+i5KoPgL2ucXUDnIaNF+v4acKPKpJYjizjCN5YJZ0UqZVwbZjoQh8bti7BYJBztdDzCLIyO
	mQkDOSVZNOeH5JxHoo9WcwFbSYPDSoG8IJsti1oQXwc2QrZn+JOmzNj3x+J6uX0iCjfbiZ2ztp3
	iWO/HkcprRFsVBPem7+NSgy1cKV+EF96293GsapMnOFj8k2/gRFwv4VYWzlb0YeRbTyJMaJM57L
	1e61OzFNkGtQ2nWGuESESKKTujoukoeSdJhX5jlVLUU7vhBnBNAFh75/rEaXMCVmozHL00vG74L
	MWzyEdW3HaTc7owttmw==
X-Received: by 2002:a05:620a:4091:b0:8c2:9ff4:a8bd with SMTP id af79cd13be357-8c70b84a289mr232636785a.15.1769527591537;
        Tue, 27 Jan 2026 07:26:31 -0800 (PST)
X-Received: by 2002:a05:620a:4091:b0:8c2:9ff4:a8bd with SMTP id af79cd13be357-8c70b84a289mr232631685a.15.1769527590928;
        Tue, 27 Jan 2026 07:26:30 -0800 (PST)
Received: from hackbox.lan ([86.121.162.109])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-435b1f744e2sm40967260f8f.31.2026.01.27.07.26.29
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 27 Jan 2026 07:26:30 -0800 (PST)
From: Abel Vesa <abel.vesa@oss.qualcomm.com>
Date: Tue, 27 Jan 2026 17:26:17 +0200
Subject: [PATCH v2 1/2] dt-bindings: interconnect: document the RPMh
 Network-On-Chip interconnect in Eliza SoC
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260127-eliza-interconnect-v2-1-b238a8e04976@oss.qualcomm.com>
References: <20260127-eliza-interconnect-v2-0-b238a8e04976@oss.qualcomm.com>
In-Reply-To: <20260127-eliza-interconnect-v2-0-b238a8e04976@oss.qualcomm.com>
To: Georgi Djakov <djakov@kernel.org>, Rob Herring <robh@kernel.org>,
        Krzysztof Kozlowski <krzk+dt@kernel.org>,
        Conor Dooley <conor+dt@kernel.org>,
        Odelu Kukatla <odelu.kukatla@oss.qualcomm.com>
Cc: linux-arm-msm@vger.kernel.org, linux-pm@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        Abel Vesa <abel.vesa@oss.qualcomm.com>
X-Mailer: b4 0.15-dev-47773
X-Developer-Signature: v=1; a=openpgp-sha256; l=8576;
 i=abel.vesa@oss.qualcomm.com; h=from:subject:message-id;
 bh=W0eSF1iasjTylkltDBGnjA3H0CS8qmWgJEqvugrrEww=;
 b=owEBbQKS/ZANAwAKARtfRMkAlRVWAcsmYgBpeNkhYi29fFswy3woWetH5vAON0/RgrIT2G2Bu
 MiEs26zc1iJAjMEAAEKAB0WIQRO8+4RTnqPKsqn0bgbX0TJAJUVVgUCaXjZIQAKCRAbX0TJAJUV
 Vsp6D/9VTkAWZm3Qfeb3srCMjPVdo0p+JmFhghaLqxeHDPhInW0YkQP9tEaT0DxfHoIvupP6jOL
 /Zu8xBjX9D9rAW5tRfjFqJ44cUrU6Ih/ukIr++SNEz5bDctoPR2VeNW7PIi8vpLe5uLqXuUhDJY
 B85dZbEF13G9PKXPKfZKXSobkcEcibxLw6VpHHitB2T2a2mIYR9BM61Y/bfJ4RFhkwcE4S2iiwS
 XUgZPmJNeqDD8ISv0ILDGHy5kho/4v7PDZzqpiIjEj+Q+m06a/mBFVC7suvqZamCpmX4HQJPGIo
 iVY9ERVtUH5Kr7bU2CYXJnG0ftNSD4diNPe8/S6de8LNbS4nimZvoxvW5/3xbpRlet3pNPalvlK
 9KDGqM7c6vJ4mQ6E+1Hd34487SAGjrvPlVdiAClGzZIRbPX9AeFsCHP38t/LA52cFX9YarWOjN3
 g0axurDgQFvjyiW+UH2wVgsH0wMc8IdJdETDA6tH9U5QToZxhDj+ef7dcRBdeMOeAaw9zauE/+w
 YflKisavH51qZ7PwvuWDkeIXWL9CxEkXPAm6WHFE/Q/4D18pBbXgsEqMH9P8/r5iaE+lfWpDCiY
 xvERcZcsRxKxetwB8AOmGAVxfKbSAxd9uMBH3BTl5iX/S6cltzhJsz/87aVlcpZwsaFIVDLIuP/
 DjMIoty1mf06t1A==
X-Developer-Key: i=abel.vesa@oss.qualcomm.com; a=openpgp;
 fpr=6AFF162D57F4223A8770EF5AF7BF214136F41FAE
X-Proofpoint-GUID: yJ0COzJVIJF4VW2RSWdrp_uSKoMdhq-R
X-Authority-Analysis: v=2.4 cv=JZqxbEKV c=1 sm=1 tr=0 ts=6978d928 cx=c_pps
 a=50t2pK5VMbmlHzFWWp8p/g==:117 a=oauzzCmhM186DRC0Y2yWPg==:17
 a=IkcTkHD0fZMA:10 a=vUbySO9Y5rIA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=gEfo2CItAAAA:8 a=EUspDBNiAAAA:8
 a=Iq7QPC57mEAaqCDayAAA:9 a=QEXdDO2ut3YA:10 a=IoWCM6iH3mJn3m4BftBB:22
 a=sptkURWiP4Gy88Gu7hUp:22
X-Proofpoint-ORIG-GUID: yJ0COzJVIJF4VW2RSWdrp_uSKoMdhq-R
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwMTI3MDEyNiBTYWx0ZWRfX1PiAafadAH9M
 B09pEsZaRN2DzoJ0zJHeFaPKupGCD0yp9DD42Muv6egllIYA5QblEjt3kqoa5zz6jvbt89hA8St
 3IY48KrI5JlmvRgVYzRGIFwgFWNUsjFCxCr0V/gdrJWnTfVok40MuqY6ik+zO+rMpyJTdWx5tDa
 vUasNmM7QYbvUlN+RgulFh9UsA4rBJK3CybUUvhlTT6zwk8zvieZlE0WMEUbEeE2lYWryAeeLZS
 MglrqUVl42eyEL0voUckhQjKhulB0bX9eqWthfwch5lLqaPXn08EQNTIGpx4GAg/0TKCHimIZrv
 iaJjJrQ6bzMl1Nte6QhwQA8jJ1qaY+Zis9b3Lv2InAVUNdIwDp3Afge5I0aKiJbKgOhBNbagvgP
 9e+Q08wp2guVwSOUO1n2iOi1MoKuB98pCD0z6ssJjY596u4O38KeK2Bu5VwgVFHYez576n4WF02
 RSSLofp4VKA8cvnsn8g==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-01-27_03,2026-01-27_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 priorityscore=1501 impostorscore=0 suspectscore=0 lowpriorityscore=0
 malwarescore=0 spamscore=0 adultscore=0 clxscore=1015 phishscore=0
 bulkscore=0 classifier=typeunknown authscore=0 authtc= authcc= route=outbound
 adjust=0 reason=mlx scancount=1 engine=8.22.0-2601150000
 definitions=main-2601270126
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[qualcomm.com,reject];
	R_DKIM_ALLOW(-0.20)[qualcomm.com:s=qcppdkim1,oss.qualcomm.com:s=google];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c04:e001:36c::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c04::/32, country:SG];
	DKIM_TRACE(0.00)[qualcomm.com:+,oss.qualcomm.com:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	TAGGED_FROM(0.00)[bounces-41550-lists,linux-pm=lfdr.de];
	DBL_BLOCKED_OPENRESOLVER(0.00)[devicetree.org:url,tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns,qualcomm.com:email,qualcomm.com:dkim,16e0000:email];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[abel.vesa@oss.qualcomm.com,linux-pm@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_PROHIBIT(0.00)[1.111.188.160:email];
	MID_RHS_MATCH_FROM(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	TAGGED_RCPT(0.00)[linux-pm,dt];
	RCPT_COUNT_SEVEN(0.00)[10];
	RCVD_COUNT_SEVEN(0.00)[7]
X-Rspamd-Queue-Id: 1A8BF970A8
X-Rspamd-Action: no action

From: Odelu Kukatla <odelu.kukatla@oss.qualcomm.com>

Document the RPMh Network-On-Chip Interconnect of the Eliza platform.

Signed-off-by: Odelu Kukatla <odelu.kukatla@oss.qualcomm.com>
Signed-off-by: Abel Vesa <abel.vesa@oss.qualcomm.com>
---
 .../bindings/interconnect/qcom,eliza-rpmh.yaml     | 141 +++++++++++++++++++++
 include/dt-bindings/interconnect/qcom,eliza-rpmh.h | 136 ++++++++++++++++++++
 2 files changed, 277 insertions(+)

diff --git a/Documentation/devicetree/bindings/interconnect/qcom,eliza-rpmh.yaml b/Documentation/devicetree/bindings/interconnect/qcom,eliza-rpmh.yaml
new file mode 100644
index 000000000000..d856561eb578
--- /dev/null
+++ b/Documentation/devicetree/bindings/interconnect/qcom,eliza-rpmh.yaml
@@ -0,0 +1,141 @@
+# SPDX-License-Identifier: GPL-2.0-only OR BSD-2-Clause
+%YAML 1.2
+---
+$id: http://devicetree.org/schemas/interconnect/qcom,eliza-rpmh.yaml#
+$schema: http://devicetree.org/meta-schemas/core.yaml#
+
+title: Qualcomm RPMh Network-On-Chip Interconnect on Eliza SoC
+
+maintainers:
+  - Odelu Kukatla <odelu.kukatla@oss.qualcomm.com>
+
+description: |
+  RPMh interconnect providers support system bandwidth requirements through
+  RPMh hardware accelerators known as Bus Clock Manager (BCM). The provider is
+  able to communicate with the BCM through the Resource State Coordinator (RSC)
+  associated with each execution environment. Provider nodes must point to at
+  least one RPMh device child node pertaining to their RSC and each provider
+  can map to multiple RPMh resources.
+
+  See also: include/dt-bindings/interconnect/qcom,eliza-rpmh.h
+
+properties:
+  compatible:
+    enum:
+      - qcom,eliza-aggre1-noc
+      - qcom,eliza-aggre2-noc
+      - qcom,eliza-clk-virt
+      - qcom,eliza-cnoc-cfg
+      - qcom,eliza-cnoc-main
+      - qcom,eliza-gem-noc
+      - qcom,eliza-lpass-ag-noc
+      - qcom,eliza-lpass-lpiaon-noc
+      - qcom,eliza-lpass-lpicx-noc
+      - qcom,eliza-mc-virt
+      - qcom,eliza-mmss-noc
+      - qcom,eliza-nsp-noc
+      - qcom,eliza-pcie-anoc
+      - qcom,eliza-system-noc
+
+  reg:
+    maxItems: 1
+
+  clocks:
+    minItems: 1
+    maxItems: 2
+
+required:
+  - compatible
+
+allOf:
+  - $ref: qcom,rpmh-common.yaml#
+  - if:
+      properties:
+        compatible:
+          contains:
+            enum:
+              - qcom,eliza-clk-virt
+              - qcom,eliza-mc-virt
+    then:
+      properties:
+        reg: false
+    else:
+      required:
+        - reg
+
+  - if:
+      properties:
+        compatible:
+          contains:
+            enum:
+              - qcom,eliza-aggre1-noc
+    then:
+      properties:
+        clocks:
+          items:
+            - description: aggre USB3 PRIM AXI clock
+
+  - if:
+      properties:
+        compatible:
+          contains:
+            enum:
+              - qcom,eliza-aggre2-noc
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
+              - qcom,eliza-pcie-anoc
+    then:
+      properties:
+        clocks:
+          items:
+            - description: aggre-NOC PCIe AXI clock
+            - description: cfg-NOC PCIe a-NOC AHB clock
+
+  - if:
+      properties:
+        compatible:
+          contains:
+            enum:
+              - qcom,eliza-aggre1-noc
+              - qcom,eliza-aggre2-noc
+              - qcom,eliza-pcie-anoc
+    then:
+      required:
+        - clocks
+    else:
+      properties:
+        clocks: false
+
+unevaluatedProperties: false
+
+examples:
+  - |
+    gem_noc: interconnect@24100000 {
+        compatible = "qcom,eliza-gem-noc";
+        reg = <0x24100000 0x163080>;
+        #interconnect-cells = <2>;
+        qcom,bcm-voters = <&apps_bcm_voter>;
+    };
+
+    mc_virt: interconnect-2 {
+        compatible = "qcom,eliza-mc-virt";
+        #interconnect-cells = <2>;
+        qcom,bcm-voters = <&apps_bcm_voter>;
+    };
+
+    aggre1_noc: interconnect@16e0000 {
+        compatible = "qcom,eliza-aggre1-noc";
+        reg = <0x16e0000 0x16400>;
+        #interconnect-cells = <2>;
+        qcom,bcm-voters = <&apps_bcm_voter>;
+        clocks = <&gcc_aggre_usb3_prim_axi_clk>;
+    };
diff --git a/include/dt-bindings/interconnect/qcom,eliza-rpmh.h b/include/dt-bindings/interconnect/qcom,eliza-rpmh.h
new file mode 100644
index 000000000000..95db2fe647de
--- /dev/null
+++ b/include/dt-bindings/interconnect/qcom,eliza-rpmh.h
@@ -0,0 +1,136 @@
+/* SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause) */
+/*
+ * Copyright (c) Qualcomm Technologies, Inc. and/or its subsidiaries.
+ */
+
+#ifndef __DT_BINDINGS_INTERCONNECT_QCOM_ELIZA_H
+#define __DT_BINDINGS_INTERCONNECT_QCOM_ELIZA_H
+
+#define MASTER_QSPI_0				0
+#define MASTER_QUP_1				1
+#define MASTER_UFS_MEM				2
+#define MASTER_USB3_0				3
+#define SLAVE_A1NOC_SNOC			4
+
+#define MASTER_QUP_2				0
+#define MASTER_CRYPTO				1
+#define MASTER_IPA				2
+#define MASTER_SOCCP_AGGR_NOC			3
+#define MASTER_QDSS_ETR				4
+#define MASTER_QDSS_ETR_1			5
+#define MASTER_SDCC_1				6
+#define MASTER_SDCC_2				7
+#define SLAVE_A2NOC_SNOC			8
+
+#define MASTER_QUP_CORE_1			0
+#define MASTER_QUP_CORE_2			1
+#define SLAVE_QUP_CORE_1			2
+#define SLAVE_QUP_CORE_2			3
+
+#define MASTER_CNOC_CFG				0
+#define SLAVE_AHB2PHY_SOUTH			1
+#define SLAVE_AHB2PHY_NORTH			2
+#define SLAVE_CAMERA_CFG			3
+#define SLAVE_CLK_CTL				4
+#define SLAVE_CRYPTO_0_CFG			5
+#define SLAVE_DISPLAY_CFG			6
+#define SLAVE_GFX3D_CFG				7
+#define SLAVE_I3C_IBI0_CFG			8
+#define SLAVE_I3C_IBI1_CFG			9
+#define SLAVE_IMEM_CFG				10
+#define SLAVE_CNOC_MSS				11
+#define SLAVE_PCIE_0_CFG			12
+#define SLAVE_PRNG				13
+#define SLAVE_QDSS_CFG				14
+#define SLAVE_QSPI_0				15
+#define SLAVE_QUP_1				16
+#define SLAVE_QUP_2				17
+#define SLAVE_SDCC_2				18
+#define SLAVE_TCSR				19
+#define SLAVE_TLMM				20
+#define SLAVE_UFS_MEM_CFG			21
+#define SLAVE_USB3_0				22
+#define SLAVE_VENUS_CFG				23
+#define SLAVE_VSENSE_CTRL_CFG			24
+#define SLAVE_CNOC_MNOC_HF_CFG			25
+#define SLAVE_CNOC_MNOC_SF_CFG			26
+#define SLAVE_PCIE_ANOC_CFG			27
+#define SLAVE_QDSS_STM				28
+#define SLAVE_TCU				29
+
+#define MASTER_GEM_NOC_CNOC			0
+#define MASTER_GEM_NOC_PCIE_SNOC		1
+#define SLAVE_AOSS				2
+#define SLAVE_IPA_CFG				3
+#define SLAVE_IPC_ROUTER_CFG			4
+#define SLAVE_SOCCP				5
+#define SLAVE_TME_CFG				6
+#define SLAVE_APPSS				7
+#define SLAVE_CNOC_CFG				8
+#define SLAVE_DDRSS_CFG				9
+#define SLAVE_BOOT_IMEM				10
+#define SLAVE_IMEM				11
+#define SLAVE_BOOT_IMEM_2			12
+#define SLAVE_SERVICE_CNOC			13
+#define SLAVE_PCIE_0				14
+#define SLAVE_PCIE_1				15
+
+#define MASTER_GPU_TCU				0
+#define MASTER_SYS_TCU				1
+#define MASTER_APPSS_PROC			2
+#define MASTER_GFX3D				3
+#define MASTER_LPASS_GEM_NOC			4
+#define MASTER_MSS_PROC				5
+#define MASTER_MNOC_HF_MEM_NOC			6
+#define MASTER_MNOC_SF_MEM_NOC			7
+#define MASTER_COMPUTE_NOC			8
+#define MASTER_ANOC_PCIE_GEM_NOC		9
+#define MASTER_SNOC_SF_MEM_NOC			10
+#define MASTER_WLAN_Q6				11
+#define MASTER_GIC				12
+#define SLAVE_GEM_NOC_CNOC			13
+#define SLAVE_LLCC				14
+#define SLAVE_MEM_NOC_PCIE_SNOC			15
+
+#define MASTER_LPIAON_NOC			0
+#define SLAVE_LPASS_GEM_NOC			1
+
+#define MASTER_LPASS_LPINOC			0
+#define SLAVE_LPIAON_NOC_LPASS_AG_NOC		1
+
+#define MASTER_LPASS_PROC			0
+#define SLAVE_LPICX_NOC_LPIAON_NOC		1
+
+#define MASTER_LLCC				0
+#define SLAVE_EBI1				1
+
+#define MASTER_CAMNOC_NRT_ICP_SF		0
+#define MASTER_CAMNOC_RT_CDM_SF			1
+#define MASTER_CAMNOC_SF			2
+#define MASTER_VIDEO_MVP			3
+#define MASTER_VIDEO_V_PROC			4
+#define MASTER_CNOC_MNOC_SF_CFG			5
+#define MASTER_CAMNOC_HF			6
+#define MASTER_MDP				7
+#define MASTER_CNOC_MNOC_HF_CFG			8
+#define SLAVE_MNOC_SF_MEM_NOC			9
+#define SLAVE_SERVICE_MNOC_SF			10
+#define SLAVE_MNOC_HF_MEM_NOC			11
+#define SLAVE_SERVICE_MNOC_HF			12
+
+#define MASTER_CDSP_PROC			0
+#define SLAVE_CDSP_MEM_NOC			1
+
+#define MASTER_PCIE_ANOC_CFG			0
+#define MASTER_PCIE_0				1
+#define MASTER_PCIE_1				2
+#define SLAVE_ANOC_PCIE_GEM_NOC			3
+#define SLAVE_SERVICE_PCIE_ANOC			4
+
+#define MASTER_A1NOC_SNOC			0
+#define MASTER_A2NOC_SNOC			1
+#define MASTER_CNOC_SNOC			2
+#define MASTER_NSINOC_SNOC			3
+#define SLAVE_SNOC_GEM_NOC_SF			4
+
+#endif

-- 
2.48.1


