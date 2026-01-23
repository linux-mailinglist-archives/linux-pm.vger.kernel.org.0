Return-Path: <linux-pm+bounces-41372-lists+linux-pm=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-pm@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id KLxYNv1sc2mnvgAAu9opvQ
	(envelope-from <linux-pm+bounces-41372-lists+linux-pm=lfdr.de@vger.kernel.org>)
	for <lists+linux-pm@lfdr.de>; Fri, 23 Jan 2026 13:43:41 +0100
X-Original-To: lists+linux-pm@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id 4E73175F00
	for <lists+linux-pm@lfdr.de>; Fri, 23 Jan 2026 13:43:41 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 58E55302963F
	for <lists+linux-pm@lfdr.de>; Fri, 23 Jan 2026 12:43:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 713F12E9ECA;
	Fri, 23 Jan 2026 12:43:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="RmMhuimq";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="WqvPHN7o"
X-Original-To: linux-pm@vger.kernel.org
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A86E72DCF61
	for <linux-pm@vger.kernel.org>; Fri, 23 Jan 2026 12:43:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769172214; cv=none; b=WeSosYdQSrncF+HHtf3hbZaKAaUNL/QBc0NAkLuxD6HzxZAFJOPaR6JCaC6Qm43Ch0OLuCphivbPVWm56wmBAmK1lL6nhfvw69iykxgkxG2rNxELE2GmhbGs8ekez6byGwUYAxnN+fztyeeMz262VWUaloccj3x8x7CYTx+9OmU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769172214; c=relaxed/simple;
	bh=bj+/tcm3Ln9DGFASl4hec/3C/N6tp2p9nps2L8z44cE=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=fUjNkuFTmpAkAorrwr7EPTyMPQWrwEjFww0N4CZ/SEfHBtuYJJFNzXDPmD/T8NtIosD2tQKuECWV50OlvIPzYyD9jnxZNJlgBDqc8MJ9CJmfw2tmEBJNzAoZErHVqdcTBriH+xqvoTexy6XWf9blxatii1EkDZZ1M7Gw7heZeBE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=RmMhuimq; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=WqvPHN7o; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279870.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 60N6Z2k83790128
	for <linux-pm@vger.kernel.org>; Fri, 23 Jan 2026 12:43:31 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	NDxkpmLDWgegXc56cBUoIq4RpSg4JqMyGoKj3VfXVzw=; b=RmMhuimqnN74JJJF
	m/DWqJ9gGXwm6HHfnASTptFRIux8cg1u0wcoL9UKe8tjwbZutHRZlxdW13IT+Y0u
	kxff4tKp1a3TLQlJmVKWm1kV2DmVebiJqst64OxiiiP6aqiEENk0KABbrQNgB9sP
	E0/3ssBWU4n76M01w2ZsNCUOC6B56WLofw45goaGJw3og8ZPCeVKCvU0J1A42h5N
	P8cVRQ9BcD+YIbIytB5HdbClmwN6xbGQTpl8qC0hY/iuvQD1BsH324oco9eoT79L
	vvWLZUZlYk1Um+TKxbvx3qbiS8B/rlJpbqPjD4GTHqP8smCy+CfgUbD3xqax2IA5
	dM6BBg==
Received: from mail-qk1-f197.google.com (mail-qk1-f197.google.com [209.85.222.197])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4buqyp3men-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-pm@vger.kernel.org>; Fri, 23 Jan 2026 12:43:31 +0000 (GMT)
Received: by mail-qk1-f197.google.com with SMTP id af79cd13be357-8bb9f029f31so720265185a.2
        for <linux-pm@vger.kernel.org>; Fri, 23 Jan 2026 04:43:31 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1769172211; x=1769777011; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=NDxkpmLDWgegXc56cBUoIq4RpSg4JqMyGoKj3VfXVzw=;
        b=WqvPHN7oyYVtuVdf751MSXUJl4sbnVUNCv7Wl4cL8H2JbvsLRv86LcbOCFaKZbJliU
         26/AL33KeN12G6EEopkFLBtDUhj2Z4NaQAbc1CVS90Fen3TMNo1dcGzbID6db9OzLddf
         gW6qTnC60qJVf2uB03keiZCegsUnt6mrUcKZa48TfFMHSGaw7gJjb1VVR/EkJ6GaA5nL
         uCQjIhQc5N4lPFXVvfMo/nTtfgjNRzatrE+KF5+AqKD3/sAcjRhHSpcVHpT47ydVkrxo
         DYGUWkthoY2NjAH4G+vgpULOEC/MUqGZSZiv3V9ORvV4N09Q1yrLOLPs6ZH9F6VktBgT
         nMGg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1769172211; x=1769777011;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-gg:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=NDxkpmLDWgegXc56cBUoIq4RpSg4JqMyGoKj3VfXVzw=;
        b=H/y4YmV2y0qC92jk3U4S6rZQ43bVFOXpjTzWWKdvuA++GUQBm810OCEMczFHJh9GSE
         Mb2kTYkUn/udBgj4kZSmliQMd0HnrookFJTh5XOGlCNvdnSN2ujgPJr8oUGq1khYDxLJ
         NKlr4wRsdbOw0UZYqrF1FQdxoj+EZ5K/wCxWRTjiExM9bmvPOI9dmzsNW/WMItmj2Rwe
         fMmTgZ95miQTU3gXYhyKKi+f23r3bwxclQubYrPF4D0a1gAlsdkymjyuZs9mp9K+btEU
         RK0o4gW7ZQPhaQguwEsM5Cmb2xL5dJNvrHJgstgC+NbQ0Oj59CdwLQyi5PYyuSXdQrFx
         1tAA==
X-Forwarded-Encrypted: i=1; AJvYcCWFMC5gh/oTgfY4kxqkCDxl0ZI0yp66HQcyttrU03MeHVgMohNArgpEqe0eAhZ7ZbZFRo0bPvV6KQ==@vger.kernel.org
X-Gm-Message-State: AOJu0Yz1Kdi+3Hn0kTBNNrJGBIvJ/mh4wyzt5rGKy1lB36Bsk9q9mWai
	Z/Oix+GcyhfuBNPhPtqZJGup0EZhj/OrNDGwdceLHa5jMaxo91dyha7gxWsC3EGsG3gHv+MhELJ
	/eQuEhKOCbH10BhC5/LyhlBNmU3XdetzqR9MrKqTpiImFOhLKbOsp181UcIjcMeQEPzWvXg==
X-Gm-Gg: AZuq6aLvjqr1Y6xeBadUqUh3dK4WfbjfqSaVCjJ380kBDxZXfjMmUv6uxvxjhj4bJoy
	OEFZI87QbeOMiGaiW/E7480twB1fjPWkC0fTvmOX03ze373+td37Vjds4Me4y4BWejBUSIk0deg
	0WEM9AfU5pzldKEy/Wml4TShxT7p6Ti+oQWeZcuv15B0gMl6OMaJ6JVjAjGcgAnqsjN8pq3Hoyo
	Xcyas1tEuT/OC2g2Bfj4IKIoTcUxFwxVPP86ZhDErvgeMzBhFmpiNIeg4sJHIv0GZm/OoOhE+PA
	bN5zVdndie2QE85nNvaOTqvjEEv7dsaVAaxgqTGeMaNNzzF7FgDdXHpOZclfJWxVigV4ohCGfO6
	uEfV9mtt0K4e5BRNLtQ==
X-Received: by 2002:a05:620a:2556:b0:8c6:de6f:899c with SMTP id af79cd13be357-8c6e2d96777mr323381085a.2.1769172210529;
        Fri, 23 Jan 2026 04:43:30 -0800 (PST)
X-Received: by 2002:a05:620a:2556:b0:8c6:de6f:899c with SMTP id af79cd13be357-8c6e2d96777mr323376585a.2.1769172209888;
        Fri, 23 Jan 2026 04:43:29 -0800 (PST)
Received: from hackbox.lan ([86.121.163.152])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-435b1e7156dsm6328543f8f.20.2026.01.23.04.43.28
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 23 Jan 2026 04:43:29 -0800 (PST)
From: Abel Vesa <abel.vesa@oss.qualcomm.com>
Date: Fri, 23 Jan 2026 14:43:20 +0200
Subject: [PATCH 1/2] dt-bindings: interconnect: document the RPMh
 Network-On-Chip interconnect in Eliza SoC
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260123-eliza-interconnect-v1-1-010ff0d100c9@oss.qualcomm.com>
References: <20260123-eliza-interconnect-v1-0-010ff0d100c9@oss.qualcomm.com>
In-Reply-To: <20260123-eliza-interconnect-v1-0-010ff0d100c9@oss.qualcomm.com>
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
 bh=7wL3PSxgy+pKzjza8h3WxOZHhGZt7XX8Slj/CGMM2+I=;
 b=owEBbQKS/ZANAwAKARtfRMkAlRVWAcsmYgBpc2zs31wfGHMGc2vzcKumnAI37J5s0+jH3xumy
 2sYJhIGlIeJAjMEAAEKAB0WIQRO8+4RTnqPKsqn0bgbX0TJAJUVVgUCaXNs7AAKCRAbX0TJAJUV
 VphLD/9ODSeUAMoKaIIheJd698YHJ5waxMIN/l8RlgfQK/Rjils+VqUJSKCueyKkq5WgfT7VYqg
 c09xX6+rJC+S1iUeqF76FM26KZBkExk3Yr8l1oHGmkK1hRcS9vOkIlzpI+WRopZzV1UIEHDxEcj
 yJduowlwxnbv7LxTqra5L9UlL3u/GHMajtJodZuWuB4kq0fw/MP5FYQqABohm/YwJsgxndfVva5
 aSU4igvbmGP8Mg2HhvYGzVoy/SDId2N3D/WGQt4P7gwxz1Tno7UtcKYejA891ChrjpWEY62lwi+
 kpWeMtZKW1mI7ouk0F54zRKB16dNc1Z3yLg+l1DFEY5+eyj5Ii8F00/T7of7ITsJRR1QLUloLTY
 u6RH1yxZugwHS4Hax4QJ4t9dmeKygFQyj774vIMel+Pv3jeRbpegoFv+ypRhXnPLyBfxGW1gfa9
 P/QnmJlEeKKiy8/L+zgYyehT/+6sm8UuCLZLrhwCuraFS49lJxVDt0zVIv1jrl3bNxCdSSp9o5V
 vGCSWaaClKH59TfwNXvR2rIzrW1/1j3kVIcQeh8M7EMxBQcFkaI8rQWa4obYv4sG3wYjZWtFF6J
 V6QmvM2+2cpsKzltcK5FMmS3XsUVuHrGsixj65LtVnkGiha5cPfuSC4BRG0sboBHPMaz6xpIhab
 SUDDqEwSa9kfp7Q==
X-Developer-Key: i=abel.vesa@oss.qualcomm.com; a=openpgp;
 fpr=6AFF162D57F4223A8770EF5AF7BF214136F41FAE
X-Authority-Analysis: v=2.4 cv=RMy+3oi+ c=1 sm=1 tr=0 ts=69736cf3 cx=c_pps
 a=50t2pK5VMbmlHzFWWp8p/g==:117 a=RUlelSpolvTNyr7Sls5SJA==:17
 a=IkcTkHD0fZMA:10 a=vUbySO9Y5rIA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=gEfo2CItAAAA:8 a=EUspDBNiAAAA:8
 a=Iq7QPC57mEAaqCDayAAA:9 a=QEXdDO2ut3YA:10 a=IoWCM6iH3mJn3m4BftBB:22
 a=sptkURWiP4Gy88Gu7hUp:22
X-Proofpoint-ORIG-GUID: CqzHRFpd1y80U1OnSWdtLj085f0GgTA2
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwMTIzMDEwNCBTYWx0ZWRfX9jOedWJ5AXYL
 WFw+kQy3oXuDe34eHSJu6MOPcIkVWpKn0wzndbOTrmoUkJxwdSlDp1VtoYgxqx7pcrb1euPIXJD
 tJd2P4dh0Gm+tgpeKtdK0BFa7cQ/ubL4gPHwvLq1Nia27jsUf3Us4VjTHU1GpqvLLMxScOePXQF
 of9LR0YKP+LrLFflNd/HoXGkZiVA7T15H15fRL/fu3Mjyml5/ImkhgkKTods+K+va5IQaLgq4XE
 lmjKFgegftVqEHgve9iUhniunE1C2e/BWMhTGYXGsjtPTDFGIaMklZx+c1A122uTzXU0E+CLZ0X
 VTE8r2zeK5hTh+IBvQEABft1uyyzcjkfdXQOyarxEGG2XAMYroHKiJ05R8N7d3oUQ2WMNlU2ZTQ
 4oazDL6zapC7NrZ9FrI7Q7hEVSYJMUs/zV16pF/LRbH24oDw/mHjfNc/frgQbMMBcdbhVHY7oPI
 DzmBSVbZvk3ZX9VhZow==
X-Proofpoint-GUID: CqzHRFpd1y80U1OnSWdtLj085f0GgTA2
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.20,FMLib:17.12.100.49
 definitions=2026-01-23_02,2026-01-22_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 malwarescore=0 priorityscore=1501 clxscore=1015 impostorscore=0
 lowpriorityscore=0 suspectscore=0 bulkscore=0 adultscore=0 spamscore=0
 phishscore=0 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2601150000
 definitions=main-2601230104
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[qualcomm.com,reject];
	R_DKIM_ALLOW(-0.20)[qualcomm.com:s=qcppdkim1,oss.qualcomm.com:s=google];
	R_SPF_ALLOW(-0.20)[+ip4:172.105.105.114:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	DKIM_TRACE(0.00)[qualcomm.com:+,oss.qualcomm.com:+];
	DBL_BLOCKED_OPENRESOLVER(0.00)[oss.qualcomm.com:mid,oss.qualcomm.com:dkim,qualcomm.com:email,qualcomm.com:dkim,tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns,16e0000:email,devicetree.org:url,1.111.188.160:email];
	RCVD_TLS_LAST(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	TAGGED_FROM(0.00)[bounces-41372-lists,linux-pm=lfdr.de];
	MIME_TRACE(0.00)[0:+];
	ASN(0.00)[asn:63949, ipnet:172.105.96.0/20, country:SG];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[linux-pm,dt];
	FROM_NEQ_ENVFROM(0.00)[abel.vesa@oss.qualcomm.com,linux-pm@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	MID_RHS_MATCH_FROM(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	RCPT_COUNT_SEVEN(0.00)[10];
	RCVD_COUNT_SEVEN(0.00)[7]
X-Rspamd-Queue-Id: 4E73175F00
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
index 000000000000..20da73c1c778
--- /dev/null
+++ b/Documentation/devicetree/bindings/interconnect/qcom,eliza-rpmh.yaml
@@ -0,0 +1,141 @@
+# SPDX-License-Identifier: GPL-2.0-only OR BSD-2-Clause
+%YAML 1.2
+---
+$id: http://devicetree.org/schemas/interconnect/qcom,eliza-rpmh.yaml#
+$schema: http://devicetree.org/meta-schemas/core.yaml#
+
+title: Qualcomm RPMh Network-On-Chip Interconnect on ELIZA SoC
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


