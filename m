Return-Path: <linux-pm+bounces-42357-lists+linux-pm=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-pm@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id SHMQILfgiWnGCwAAu9opvQ
	(envelope-from <linux-pm+bounces-42357-lists+linux-pm=lfdr.de@vger.kernel.org>)
	for <lists+linux-pm@lfdr.de>; Mon, 09 Feb 2026 14:27:19 +0100
X-Original-To: lists+linux-pm@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id DBDE810FAB6
	for <lists+linux-pm@lfdr.de>; Mon, 09 Feb 2026 14:27:18 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 726523019515
	for <lists+linux-pm@lfdr.de>; Mon,  9 Feb 2026 13:23:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0D1F0378838;
	Mon,  9 Feb 2026 13:23:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="N4oGc/+Y";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="grgE9hK0"
X-Original-To: linux-pm@vger.kernel.org
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CF4EE274B48
	for <linux-pm@vger.kernel.org>; Mon,  9 Feb 2026 13:23:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770643434; cv=none; b=lodeliTPmRkvToqPHbkY3XwVc8eBIQ0ZcRabn+ylOOt/RjZpuP0rQ7/7yUWgOQpxb4jiJTAxcT6ElKPNDOdbIKgZ59xZjIC9ph/l1Z3MVRE7fBJbHbCZV62nSLqI5I9fy1Y/MpldB6sneSieYE+fTATAbeQCWmGwzJV9/6yLg9Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770643434; c=relaxed/simple;
	bh=+/Gu/bOzREMsyojxtBLS2rrsVxBEz/1x89UZ/kvwe+U=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=Q7q733S5JV1WzscKVA/QTo4h8OP2X3ToExqc8rBEE4i6L0bNu+5ZMZFaYIMCyvkf5eBl6DDgIWGcUuomO6Bp6/mHNWOJOxNYhzTqoRPdZPv2mwCJptMHGPw2REyYIDMmO7CYnpiX8FAd8aQVcs7rqLFHaZyxKyEQpg3hWZFsEdg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=N4oGc/+Y; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=grgE9hK0; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279865.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 619Akni53699967
	for <linux-pm@vger.kernel.org>; Mon, 9 Feb 2026 13:23:54 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	kINSpanPXinEKIu6zisValx81lzCgphYv7gFKnGPwhI=; b=N4oGc/+YVA9tE7mW
	TeXnadCkGD4wa9mhFhhvmFtHrXOVXala6+5F9h83IuikT0bUVnSW2Wm6i+BwUz0P
	LaZXPtrPmFmzi9NikJAhWVp65g3ssUp0bzwJ7CZYdtecvAh7aIzVbkh1ZQwl6J+l
	noBjNQU1YvwbhtA3Cj2xIq7ZDWw7WjLSUuVK8Svhi1+h/mNnT1H6URbYpfKYpspE
	3Y34qmDshzC4BIQnNgWKVmqKqhRrwkGZi3Cyj58jL1yBgBkLerb0Jcf4omQvVITn
	0ZERfB9JTy8qIqpLQlM1b33DllqbljCDGrWF/L4kb0JWCF/u/Fz5XKrcJ0SyNkAZ
	UtZUDw==
Received: from mail-pl1-f198.google.com (mail-pl1-f198.google.com [209.85.214.198])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4c7e4m8fbh-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-pm@vger.kernel.org>; Mon, 09 Feb 2026 13:23:54 +0000 (GMT)
Received: by mail-pl1-f198.google.com with SMTP id d9443c01a7336-2aad60525deso45087955ad.1
        for <linux-pm@vger.kernel.org>; Mon, 09 Feb 2026 05:23:54 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1770643433; x=1771248233; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=kINSpanPXinEKIu6zisValx81lzCgphYv7gFKnGPwhI=;
        b=grgE9hK0SX0XHSOOYxSr5Pb+V4rkq49bT+i0GAjc2oBVt7BT6N/2x53ggV/btOQEtZ
         qJ55La7WvjMMV8OkQjqsNrRCEmFEW2TFekvJ1voxDLpapBWdUI60c9AwuFv5mo2LnnsV
         bgGz2hzvICBEm4Hf0HoWEfFx3NK/uZoxKMXor9HdbScjuuBV7q24OT8Vs88bBC5CBJyw
         Wmxiu3pyWPIwQV0fWAV/U1hh/NZ87RdA8nz+rnvaoB4TIVLFVhoiNLC6eM1G+MD2wGjw
         eWcsXXKix65laSPtcIJW5BSKP7NmlHqEyJkP2z1BlL36mQ4blxsnLoBMUGCZXeJ9gTod
         VVMA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1770643433; x=1771248233;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-gg:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=kINSpanPXinEKIu6zisValx81lzCgphYv7gFKnGPwhI=;
        b=iDN5ngxCyXKlFv3JyOMq4pQTtfPApcywGZlxhqv9xTBSYmyE9OHHRPl40++9E9ZSaf
         I4rDhHNBe+JYOiB8bntlkEEOxOPr32sVPyYAEQDgv6H3J0ZBkiPX2sqxHmGwaASPu1wa
         uTvqo4KqKMoqcJvUxG/el+2br/HCzR+3e3ITA7TuPscqVWLR3T7IDGjV5NyKRbAZlWmX
         EYdcgkNFSQ1vNU15h1mFygAtvsh90i6+nsmrRO31Du65IicFUph03ZArKDqYlyGfYFuc
         h72Qe9QGplT00KSksqH0w7OjGOS9KBXwAg4xvurNPpO5+TAY9bsuXAUG/ABpUcDZX9uS
         8fgg==
X-Gm-Message-State: AOJu0Yy42glKm/S6N4l15g8peCnel7DjOj94LhVS7UaNhZ1/7nXeR6SK
	PBq8sFBqqW5rdF0l08dSY5Daxkl3bV8QLa4THyHa3UCY1q2Z9M3t7kRdfvcshq5Fd7XGXBXTdes
	iSZWoJ60cJ53K8l97u1n7ILMmk+pash0vq7ZCzb7VBNsPJyT0K5Hsaf8TPa6U
X-Gm-Gg: AZuq6aKSPrChz2Q0y4/hzqib+Oj8os1E14ekpu82Gc0wh5gUbM6Qs9A4WGy1wlAgt2D
	xXSDfeDxCit0fTqrVIvS63nl2BuK+qP+3UovGcGDkHtiRKgMXlhvbwQPeMi4ZFEpLAmrKX2uuL8
	rEma1umI34RlWLSM/sk8/OIyC+N52L2AMCh0wXTr9jz2tfjfYEy/Wu2JqcNxMnmYXdn6hqopbHs
	ogyxd6VT2DY/UfSAOqfrpnoSq/nYWFsFAYsj74+zbLHrjvASiDCisSmbft7rqa3MIIwfkSK2i5T
	iIDoH4eBNrXs0aYl0kUMRu7+MOQJPoRPNgjrz5YQyVchb2aJOA1uz+osiCBY3K3KpcinmtDIsP0
	M8ARbS+4LXipWyxQXot8D89GwmsqxqieNt2tced9Z8nBR+GHtrjk=
X-Received: by 2002:a17:903:1b04:b0:2a9:4507:3e86 with SMTP id d9443c01a7336-2a951627cf0mr111516745ad.19.1770643433326;
        Mon, 09 Feb 2026 05:23:53 -0800 (PST)
X-Received: by 2002:a17:903:1b04:b0:2a9:4507:3e86 with SMTP id d9443c01a7336-2a951627cf0mr111516475ad.19.1770643432877;
        Mon, 09 Feb 2026 05:23:52 -0800 (PST)
Received: from hu-kotarake-hyd.qualcomm.com ([202.46.23.25])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2a9521ba245sm107895765ad.47.2026.02.09.05.23.48
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 09 Feb 2026 05:23:52 -0800 (PST)
From: Rakesh Kota <rakesh.kota@oss.qualcomm.com>
Date: Mon, 09 Feb 2026 18:53:37 +0530
Subject: [PATCH v2 2/3] dt-bindings: input: qcom,pm8941-pwrkey: Document
 PMM8654AU
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260209-add_pwrkey_and_resin-v2-2-f944d87b9a93@oss.qualcomm.com>
References: <20260209-add_pwrkey_and_resin-v2-0-f944d87b9a93@oss.qualcomm.com>
In-Reply-To: <20260209-add_pwrkey_and_resin-v2-0-f944d87b9a93@oss.qualcomm.com>
To: Sebastian Reichel <sre@kernel.org>, Rob Herring <robh@kernel.org>,
        Krzysztof Kozlowski <krzk+dt@kernel.org>,
        Conor Dooley <conor+dt@kernel.org>, Vinod Koul <vkoul@kernel.org>,
        Dmitry Torokhov <dmitry.torokhov@gmail.com>,
        Courtney Cavin <courtney.cavin@sonymobile.com>,
        Bjorn Andersson <andersson@kernel.org>,
        Konrad Dybcio <konradybcio@kernel.org>
Cc: linux-pm@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-arm-msm@vger.kernel.org,
        linux-input@vger.kernel.org,
        Rakesh Kota <rakesh.kota@oss.qualcomm.com>
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=ed25519-sha256; t=1770643418; l=1331;
 i=rakesh.kota@oss.qualcomm.com; s=20250919; h=from:subject:message-id;
 bh=+/Gu/bOzREMsyojxtBLS2rrsVxBEz/1x89UZ/kvwe+U=;
 b=ijX3YIvOnRyfVlnlkeN9NfEiJ4B1RPQghZcI/UnOiX8PNUgwUqTz+cxU6/56oV6kerN695nLL
 e8T9xaVApd7BPznSzph85uZilNnxZZpl7jbOvuPdoGLKhRzPZLaj9fB
X-Developer-Key: i=rakesh.kota@oss.qualcomm.com; a=ed25519;
 pk=dFhv9yPC8egZglsSLDMls08cOvZKZkG6QQn1a/ofwNU=
X-Proofpoint-GUID: PQXmWN6R-lwnBeNmI5DD-DkITGb7YKrP
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwMjA5MDExMiBTYWx0ZWRfX5pfLuswOW2wx
 mhLUy80VCo2e2yOOCER9Una7Lk6lSU+1wpcYJj86WpuIf2PHVf8pHmsQrgAec+TGgEI7S91OqJY
 nR4JDF+AztD0EW0Fm9n6RjBOrY71NW6WkLP4lvbyUVjJJ99z7OcdXEBTsmqPfXszlL//C9Q3zIu
 w0Dp+wTRw9v9OYlApI/mNvapDFkITuGf7549S40/6uz1Q1dDSO38L378h8opnoDLcpO2tIYHOpP
 WBPwSDrPNlDcRBxi7+H6ekWefdo/vHqO9pSKb0pMi3j46aleXf+brMwEU+rCjpFd0bR3LijH+t5
 RUj7ss9EaDHu9fSA+xOOLVhOUHHq91dScWfi/MhNyeD3BVTKnkzqEesbjzr/SlzBi4m52pU872C
 1h9ixNMDwpI/Ov1iMtmi+Yt3LYParWBSEC6ke0QFb8hE/TK5xYUReM7Alp7LZ08I5Hg5EvwR7BJ
 ZhqAXbzrKmrq5TXpVug==
X-Proofpoint-ORIG-GUID: PQXmWN6R-lwnBeNmI5DD-DkITGb7YKrP
X-Authority-Analysis: v=2.4 cv=WecBqkhX c=1 sm=1 tr=0 ts=6989dfea cx=c_pps
 a=MTSHoo12Qbhz2p7MsH1ifg==:117 a=ZePRamnt/+rB5gQjfz0u9A==:17
 a=IkcTkHD0fZMA:10 a=HzLeVaNsDn8A:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=Mpw57Om8IfrbqaoTuvik:22 a=GgsMoib0sEa3-_RKJdDe:22
 a=EUspDBNiAAAA:8 a=Jjn6TvgLJkZUgEtuktkA:9 a=QEXdDO2ut3YA:10
 a=GvdueXVYPmCkWapjIL-Q:22
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-02-08_05,2026-02-09_03,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 clxscore=1015 impostorscore=0 malwarescore=0 bulkscore=0 phishscore=0
 spamscore=0 priorityscore=1501 adultscore=0 lowpriorityscore=0 suspectscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2601150000 definitions=main-2602090112
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.66 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[qualcomm.com,reject];
	R_DKIM_ALLOW(-0.20)[qualcomm.com:s=qcppdkim1,oss.qualcomm.com:s=google];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-42357-lists,linux-pm=lfdr.de];
	FREEMAIL_TO(0.00)[kernel.org,gmail.com,sonymobile.com];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[15];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,qualcomm.com:email,qualcomm.com:dkim,oss.qualcomm.com:mid,oss.qualcomm.com:dkim];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[rakesh.kota@oss.qualcomm.com,linux-pm@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[qualcomm.com:+,oss.qualcomm.com:+];
	MID_RHS_MATCH_FROM(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[linux-pm,dt];
	TO_DN_SOME(0.00)[];
	RCVD_COUNT_SEVEN(0.00)[7]
X-Rspamd-Queue-Id: DBDE810FAB6
X-Rspamd-Action: no action

Add compatible strings for PMM8654AU power key and resin support.
These blocks are compatible with PMK8350, so use that as the
fallback.

Signed-off-by: Rakesh Kota <rakesh.kota@oss.qualcomm.com>
---
 .../devicetree/bindings/input/qcom,pm8941-pwrkey.yaml   | 17 ++++++++++++-----
 1 file changed, 12 insertions(+), 5 deletions(-)

diff --git a/Documentation/devicetree/bindings/input/qcom,pm8941-pwrkey.yaml b/Documentation/devicetree/bindings/input/qcom,pm8941-pwrkey.yaml
index f978cf965a4d497cb7a4c670cea368c3ac70b67e..f2543d6faefdc42c36c4b9851e0f9532e73dd02a 100644
--- a/Documentation/devicetree/bindings/input/qcom,pm8941-pwrkey.yaml
+++ b/Documentation/devicetree/bindings/input/qcom,pm8941-pwrkey.yaml
@@ -12,11 +12,18 @@ maintainers:
 
 properties:
   compatible:
-    enum:
-      - qcom,pm8941-pwrkey
-      - qcom,pm8941-resin
-      - qcom,pmk8350-pwrkey
-      - qcom,pmk8350-resin
+    oneOf:
+      - enum:
+          - qcom,pm8941-pwrkey
+          - qcom,pm8941-resin
+          - qcom,pmk8350-pwrkey
+          - qcom,pmk8350-resin
+      - items:
+          - const: qcom,pmm8654au-pwrkey
+          - const: qcom,pmk8350-pwrkey
+      - items:
+          - const: qcom,pmm8654au-resin
+          - const: qcom,pmk8350-resin
 
   interrupts:
     maxItems: 1

-- 
2.34.1


