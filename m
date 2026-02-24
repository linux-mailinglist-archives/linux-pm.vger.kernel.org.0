Return-Path: <linux-pm+bounces-43138-lists+linux-pm=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-pm@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id gOvCCFyPnWkXQgQAu9opvQ
	(envelope-from <linux-pm+bounces-43138-lists+linux-pm=lfdr.de@vger.kernel.org>)
	for <lists+linux-pm@lfdr.de>; Tue, 24 Feb 2026 12:45:32 +0100
X-Original-To: lists+linux-pm@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id BF33E18680F
	for <lists+linux-pm@lfdr.de>; Tue, 24 Feb 2026 12:45:31 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id BF0B230CD4AB
	for <lists+linux-pm@lfdr.de>; Tue, 24 Feb 2026 11:43:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 67D0137FF6D;
	Tue, 24 Feb 2026 11:43:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="EpDE8xtO";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="FUvcs+ms"
X-Original-To: linux-pm@vger.kernel.org
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D06F237FF73
	for <linux-pm@vger.kernel.org>; Tue, 24 Feb 2026 11:43:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1771933403; cv=none; b=QWaysrUwMIh2geYKKLqVnoqurD3OFxnn8SxegqCqczbIWC1gcTVDb+xC8/Fqquj5k6CREATu1y8Gz6P7tUc+DcTNgDI7b4KOzsdE0zrTP35VZdAbNRPpQQLeZq85esKwz9Ku12cJulONrJa3SBY/4wZxMKRoJdvuIZdMc/GMuic=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1771933403; c=relaxed/simple;
	bh=IbB4YVar9H2oGQLxxos0jf3KzguWwC3rhVwArf8uo24=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=GfsQI3NTf6Js9u/i1e0StbhPLNDmBapC+odfSuNl193Ny159MHzXnxP/WAamdppwImuxAuuQXzh2M+fkpFuHz2s0K71SkyWK3fcpg0sks9PUvL0XwT7UkUOnSgdvPM4NMpj3QLQbs1+p1hka8t1sUzrQeY26xTc6lZLxsjSzH10=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=EpDE8xtO; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=FUvcs+ms; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279870.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 61OAFfrG3324928
	for <linux-pm@vger.kernel.org>; Tue, 24 Feb 2026 11:43:20 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	/uqWnqV+L1ugfI18TNfBqQtZfh09dKzEi5We4ZfX48k=; b=EpDE8xtOH+I2lTN8
	x9FQ5EvyPvcalj97JI3zi9ISBgJomqYo5Ss7Apj7KD0D9QFiqtWkm+jEtMAcAH4C
	YVcDJhXp6VeVnPCcbGX2ql9cVDm/7uyGYpneZz+cweEhdGMHS94jEdj5Ooapo+lJ
	Qheu6V/AODEUmS6thFHp3kXwC/FCrON0Gb2Dna4RZ+kCUV+bztH/LlkMuiIO0Vis
	agg3neXGGbIax7ck35PrnHPianWJ5y3m1DxLfkUZWT3KcJzUzbLvFth/tKLhbfeN
	b8SvmJfxbYMCC2FvpbNnahJGorSJDwkB5Bjzv6Sn5R75esxiULTPINd/o+K3Morf
	5l88xQ==
Received: from mail-qk1-f197.google.com (mail-qk1-f197.google.com [209.85.222.197])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4cgn8y41ye-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-pm@vger.kernel.org>; Tue, 24 Feb 2026 11:43:20 +0000 (GMT)
Received: by mail-qk1-f197.google.com with SMTP id af79cd13be357-8cb4b8e9112so479012585a.2
        for <linux-pm@vger.kernel.org>; Tue, 24 Feb 2026 03:43:20 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1771933400; x=1772538200; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=/uqWnqV+L1ugfI18TNfBqQtZfh09dKzEi5We4ZfX48k=;
        b=FUvcs+msNlmKs7JtSiLvnZZoTz6Yu0hdqt1B5kcYYyYx+l+xI1pTikrVIVWpB13U6w
         qYis/kVcte13dtaqeHK/Hjh4k7biB3F+v8qr/SJ2XRTMLiNDXUYlMeVqNWSp79eMiENI
         YUAfufSXBVWXBIYPuIZDGZu8BNEkPNZUtUc7cSsVd6RnfngJ1NqBEn+YnGaJ6cFIOE1X
         Bmv4E++ylyga84b0DXbp5yG4UmNUEMTjj67jxlRogrdOoQ4DxYWR1a96P6Pet6igGgNZ
         SQi4J7MS6GVArgxCiwcHfGlEY9U7VYlbXaxalC/ksKanC/mUbU+R9b4OjO8wqVHNweXw
         0jOQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1771933400; x=1772538200;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-gg:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=/uqWnqV+L1ugfI18TNfBqQtZfh09dKzEi5We4ZfX48k=;
        b=K35TEfPlNbB6b929PnZJEnhcyEK2aoq+v6Ax30NdS8r65A02FDNp+wzoJP9XcU2GDT
         6y5GE4wxyCmLTA0VNIH7kjEPII71fo/H0FEDEbNHeSs2iVyGHthq3nD2nUdqqdznUWXr
         iFpURJb5JKAgRH8KCWa8kQcd/FYF3OhPO2Eelr6dStJbFeBrJ1/veGgGg3mrR2H6IZt7
         cO8NFCRW2r8mLjbL1ZAqKa8Vk8vnPsfJv5f+b9Vg+cbkz7LVXSfZ6ujQHxG4kx5t2d/K
         sV1mzTaf8BzlaDixInGtByzFSZeku0HjWdcXuP4PO9UvTpr+D2FRTPRu5O27XD4NL32f
         NQwg==
X-Forwarded-Encrypted: i=1; AJvYcCVQG0zjNuU1kz1WjNb9ylpGVNaH5jBOSI14ZG9wpQ1zhE2K5cU5XbaAY8ghwFdTNJFPAoEo+n2lRQ==@vger.kernel.org
X-Gm-Message-State: AOJu0YxRT9YmNZpOsRU471MM9YK5ky6IdO4448jTFoQlvZyXBttG9Tl8
	85i90h48GoJJOwfwm7QO7+MlCCgFva05PJtb6kkI/0KvsllqTXqwUx3SuDe95+66+pgjq+/u4kB
	S6bXsa3B6rGd+w09oAwJ0k7HkCTol8YfLzFXP8CsZVojG+xw80LmCduNUa88pTg==
X-Gm-Gg: AZuq6aKHHV8kpUgY4/oujHGWyEKgz99+0xITFHKbqctHHgdU3APuzUVDuSxgLKK5dx6
	2pFasyTYHApR7vPic1KTaKubi9H/Z49P76Cr5hRyp0zfaH79M+Wh3/FaNunl6VxdCOhMN1ZV4cB
	v1ZLdUvSW54zkh61av/loYXJ1TlMmnlFRSWzkQ1rUoH3voljSsH6ul5EoNhgYq3B0bzQ9w6KhEu
	UbEw4lqqSInRDO8rndCRw7b8L2tR1MpUnathPBQqU1WhuSuHvFCqcqjZrHXGukb1/K5XDmHFn7C
	Wb0Sr4P/vauLoktfDGcDXJ031unEFtJnkJ1S+haP/lGEGIGtap2tZkllG5iROlSqEZgSlnSE9gH
	9TAoSvxO1GxDg/9L7jyjD+x3KmJokzQ==
X-Received: by 2002:a05:620a:1a0f:b0:8c6:b45b:9e2d with SMTP id af79cd13be357-8cb8c9fc7a1mr1433010485a.26.1771933399795;
        Tue, 24 Feb 2026 03:43:19 -0800 (PST)
X-Received: by 2002:a05:620a:1a0f:b0:8c6:b45b:9e2d with SMTP id af79cd13be357-8cb8c9fc7a1mr1433007285a.26.1771933399193;
        Tue, 24 Feb 2026 03:43:19 -0800 (PST)
Received: from hackbox.lan ([86.121.162.109])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-483b8915825sm32143335e9.8.2026.02.24.03.43.17
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 24 Feb 2026 03:43:18 -0800 (PST)
From: Abel Vesa <abel.vesa@oss.qualcomm.com>
Date: Tue, 24 Feb 2026 13:43:06 +0200
Subject: [PATCH v4 1/2] dt-bindings: interconnect: document the RPMh
 Network-On-Chip interconnect in Eliza SoC
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260224-eliza-interconnect-v4-1-ad75855d5018@oss.qualcomm.com>
References: <20260224-eliza-interconnect-v4-0-ad75855d5018@oss.qualcomm.com>
In-Reply-To: <20260224-eliza-interconnect-v4-0-ad75855d5018@oss.qualcomm.com>
To: Georgi Djakov <djakov@kernel.org>, Rob Herring <robh@kernel.org>,
        Krzysztof Kozlowski <krzk+dt@kernel.org>,
        Conor Dooley <conor+dt@kernel.org>,
        Odelu Kukatla <odelu.kukatla@oss.qualcomm.com>
Cc: linux-arm-msm@vger.kernel.org, linux-pm@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        Abel Vesa <abel.vesa@oss.qualcomm.com>,
        Krzysztof Kozlowski <krzysztof.kozlowski@oss.qualcomm.com>
X-Mailer: b4 0.15-dev-47773
X-Developer-Signature: v=1; a=openpgp-sha256; l=8711;
 i=abel.vesa@oss.qualcomm.com; h=from:subject:message-id;
 bh=yWz+Ia3BSdn9iw2ojbmE+Q1qWZoZAJaG3IqsE3n4Xhg=;
 b=owEBbQKS/ZANAwAKARtfRMkAlRVWAcsmYgBpnY7QdR2reccwb1xfAerdkaW3UfNY0mn8k4PVz
 L1Dw7csqQeJAjMEAAEKAB0WIQRO8+4RTnqPKsqn0bgbX0TJAJUVVgUCaZ2O0AAKCRAbX0TJAJUV
 VgTED/9L+QVSqI+5/bk1ALHN8iKjUmVebdpa5KiW4nbpCeSJb+IxQkjm55PvJ6sOsUL71xzBuHL
 yEW/Ov0HRjlXVJ7ZNow3dIX+dfFv1TWXzdFBPosnEflVsruN/BpFzyDHvHGJ7aMgUSMv98Hv2KB
 7LCdztYr6hXwttu3TwFnWFCJ1DjAUlTzgEWQvBOu5siF0HBh0mcON7DxFaNfdhJR/tHa6GeN2zR
 Bhb0mKFdQtO8utVS0LbDzF2Ob20mRqlpl/+ntnk3hmSV7qeQ/Ie1gbwGI+6oXPhx7edxIMT4Xsg
 KyTBkMTGmWyy56eOk2qeIPDlTU7DQue84iqIR/GzuVkrkvH4lD69RNzQ40CNHtIKaCmtZSKFwgu
 /Wz9O9z8QGCfKSk6r7L6kL3i+S472xJV/CPbHlE6wTgrPkwcQtfmbY/UHWo2zXLIBlTdRjxro6d
 lfoE05yZzRuxRvAnmmey9l0vD7OpJ6Q82rVI7BkyS3o6z26GafiATCyewV6faTG0A8cAxQAMIY1
 wnYEP/khWEqrSqpnZt6bzZAbLCudzoaVpMFnBsk9Bl0AXyyibv2OS2L8PPjWrcAE6Mfh7rXkawM
 LIiGzlxUdVFTBf6F7+9N2iycrQx4Vf4U1paiwdpaCx4AafymVN6xDiLCyPCosswPHEto/W1Zyda
 Ch/+hTa8v68jTmw==
X-Developer-Key: i=abel.vesa@oss.qualcomm.com; a=openpgp;
 fpr=6AFF162D57F4223A8770EF5AF7BF214136F41FAE
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwMjI0MDA5MyBTYWx0ZWRfX/2uGnKQvJHHF
 /gUGOg32ldrTEA1qsQS2h/QH9YQ+ZjwExuFhaAjY0Loixgmgs+siKdvXlGVtOXHYvoFuyKc3W5Q
 tIJX0paUlT+t9LF8Hsctf869wmTybGBVycctJjyS5ptKKhncS+EXmErtnuEGDb+/00de33h4szT
 hJW2A6JcHl97tzigukg51u4dnoWxXCkTowUSfQ/upnfKaPJFyrIrYb6IZrJeEFDZV58vItzX3ht
 OasoTOMgB6BzKej4pVUG1ZiLHXMepYAlsC+wnCKN6CoXvzukMGxltLKvY8+WrlXHpkuk4Ta8W+K
 jH56sTZnuvkn1aZNOpCPgT4scCJxOF/U/rn3ojWISFT8Ijhp8559l36lEkOKDhpgnI1B+6Na5f3
 gJVrqzMGI8WMTeNzeBI8BlJmUkL32b/R3+Fez3RIq15cymqL5VUQd86gqe28y1DiMEmgZLm1rPK
 ieAYlZpJTcQVn1+S0tA==
X-Authority-Analysis: v=2.4 cv=edYwvrEH c=1 sm=1 tr=0 ts=699d8ed8 cx=c_pps
 a=50t2pK5VMbmlHzFWWp8p/g==:117 a=oauzzCmhM186DRC0Y2yWPg==:17
 a=IkcTkHD0fZMA:10 a=HzLeVaNsDn8A:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=gowsoOTTUOVcmtlkKump:22
 a=gEfo2CItAAAA:8 a=EUspDBNiAAAA:8 a=Iq7QPC57mEAaqCDayAAA:9 a=QEXdDO2ut3YA:10
 a=IoWCM6iH3mJn3m4BftBB:22 a=sptkURWiP4Gy88Gu7hUp:22
X-Proofpoint-GUID: 3G965KMZU1qzUZyVRM6uRmLDY2ofRM-_
X-Proofpoint-ORIG-GUID: 3G965KMZU1qzUZyVRM6uRmLDY2ofRM-_
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-02-24_01,2026-02-23_03,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 adultscore=0 malwarescore=0 phishscore=0 clxscore=1015 priorityscore=1501
 spamscore=0 impostorscore=0 bulkscore=0 suspectscore=0 lowpriorityscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2602130000 definitions=main-2602240093
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[qualcomm.com,reject];
	R_DKIM_ALLOW(-0.20)[qualcomm.com:s=qcppdkim1,oss.qualcomm.com:s=google];
	R_SPF_ALLOW(-0.20)[+ip4:172.105.105.114:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.105.96.0/20, country:SG];
	DKIM_TRACE(0.00)[qualcomm.com:+,oss.qualcomm.com:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	TAGGED_FROM(0.00)[bounces-43138-lists,linux-pm=lfdr.de];
	DBL_BLOCKED_OPENRESOLVER(0.00)[qualcomm.com:email,qualcomm.com:dkim,oss.qualcomm.com:mid,oss.qualcomm.com:dkim,devicetree.org:url,16e0000:email,tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[abel.vesa@oss.qualcomm.com,linux-pm@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_PROHIBIT(0.00)[1.111.188.160:email];
	MID_RHS_MATCH_FROM(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	TAGGED_RCPT(0.00)[linux-pm,dt];
	RCPT_COUNT_SEVEN(0.00)[11];
	RCVD_COUNT_SEVEN(0.00)[7]
X-Rspamd-Queue-Id: BF33E18680F
X-Rspamd-Action: no action

From: Odelu Kukatla <odelu.kukatla@oss.qualcomm.com>

Document the RPMh Network-On-Chip Interconnect of the Eliza platform.

Signed-off-by: Odelu Kukatla <odelu.kukatla@oss.qualcomm.com>
Reviewed-by: Krzysztof Kozlowski <krzysztof.kozlowski@oss.qualcomm.com>
Signed-off-by: Abel Vesa <abel.vesa@oss.qualcomm.com>
---
 .../bindings/interconnect/qcom,eliza-rpmh.yaml     | 142 +++++++++++++++++++++
 include/dt-bindings/interconnect/qcom,eliza-rpmh.h | 136 ++++++++++++++++++++
 2 files changed, 278 insertions(+)

diff --git a/Documentation/devicetree/bindings/interconnect/qcom,eliza-rpmh.yaml b/Documentation/devicetree/bindings/interconnect/qcom,eliza-rpmh.yaml
new file mode 100644
index 000000000000..9a926a97e7bf
--- /dev/null
+++ b/Documentation/devicetree/bindings/interconnect/qcom,eliza-rpmh.yaml
@@ -0,0 +1,142 @@
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
+            - description: aggre UFS PHY AXI clock
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
+        clocks = <&gcc_phy_axi_clk>, <&gcc_prim_axi_clk>;
+        qcom,bcm-voters = <&apps_bcm_voter>;
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


