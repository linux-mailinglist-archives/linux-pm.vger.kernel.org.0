Return-Path: <linux-pm+bounces-42572-lists+linux-pm=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-pm@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id UEVUNEH+jWm0+AAAu9opvQ
	(envelope-from <linux-pm+bounces-42572-lists+linux-pm=lfdr.de@vger.kernel.org>)
	for <lists+linux-pm@lfdr.de>; Thu, 12 Feb 2026 17:22:25 +0100
X-Original-To: lists+linux-pm@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 3A78112F53E
	for <lists+linux-pm@lfdr.de>; Thu, 12 Feb 2026 17:22:25 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 68D03316303B
	for <lists+linux-pm@lfdr.de>; Thu, 12 Feb 2026 16:20:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 20FC3344D89;
	Thu, 12 Feb 2026 16:20:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="Iu5ZfGkZ";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="cib5lilj"
X-Original-To: linux-pm@vger.kernel.org
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9C8BC325725
	for <linux-pm@vger.kernel.org>; Thu, 12 Feb 2026 16:20:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770913221; cv=none; b=nEnbYt1gMLLADUvpT69rHH6WItUVZZUVXN/4yiEDfC/7MvRMscrQcZvPxG4801/k07sLXCuj1LldMf2oPJ+KT0ucIqTa1B7/qiNyrXv2US/SxnNzH64vb6GMY5OWtvSqHpPo2US2++++7BwG7Q2aNNZw1iwi1Gqc9eml9+fFXwM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770913221; c=relaxed/simple;
	bh=TRLTPipXv4v+KxXfbm8DrsJEY9p4cLhTYGU5J3rwR7g=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=hh8xoM5s5kQ/HniJyX7WcQUqf1TQS7hLN9f27z24ZrOROMWCDsiE5uOtArEj/tYqUv7bwdxW1idmg0RfMd4ma4c/bTSV6akFNiQju/DdUdk5EhwDKhs8WqIhNwtjhbM7gvaCMNBpfLpVBudCtfS1XKn1kMyAfzRvHdlImZFQuTA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=Iu5ZfGkZ; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=cib5lilj; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279865.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 61CDRgMJ1067989
	for <linux-pm@vger.kernel.org>; Thu, 12 Feb 2026 16:20:17 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:date:from:message-id:mime-version
	:subject:to; s=qcppdkim1; bh=mi5u0IHjuTZOX7odZMNHAm98HQb5d2Af/uN
	afAkI9/U=; b=Iu5ZfGkZpfJZp0DZyKXsSeEvHxuorbYN/MF3n6LZT8iwmel2vPj
	pznoTnBtuBAE5gvQWAv0FUYo5mv3vKvCyMJJ9KTFSF9xrQ8I1gWA43Mw/R3fRjU8
	bfXjD4TewtYOKEEetMiJOE5TEdX8YiSzgV43VEmiJGRxjaaVEINoJU4/quMtJWgc
	TO2lgaMJ/ztnIsxma1nGog1ozQtjI1ZF3Nu3Zd1Oh9j00mW/81FaEUxFcezAn6sa
	Maz2mb2RB2Vu2ik+gooL+LoGuazEAzwbfqAMzivy6jpT0Gre8vWIzWrAb68a/Z0n
	zFYqPAv2AEyTz1Vk0aTVKdZJ72Znlomgrvg==
Received: from mail-qk1-f200.google.com (mail-qk1-f200.google.com [209.85.222.200])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4c9d09h5vu-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-pm@vger.kernel.org>; Thu, 12 Feb 2026 16:20:17 +0000 (GMT)
Received: by mail-qk1-f200.google.com with SMTP id af79cd13be357-8cb3ad1b81aso19836185a.2
        for <linux-pm@vger.kernel.org>; Thu, 12 Feb 2026 08:20:17 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1770913216; x=1771518016; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=mi5u0IHjuTZOX7odZMNHAm98HQb5d2Af/uNafAkI9/U=;
        b=cib5liljXsb+f4lyIMw5Lxwm9U9OjHdaHEbIn62Rg0yybbo0NKiprSE9KdBOuThAXF
         LHz1S7cXRQqCj2/Mm7vj/tYq8R6czb9ld0W3yE1P01MpVrQ3kUgwuIPq8L83AZ9LWnbx
         bOBf2PhyenF5B8728LWvSCytVYr7i/RaOllZDxaccDumAv1LuTjf1FaPY+Nos/cMMxKk
         TFHgP9dnW/No9tFPmIx0acrbegaaOtpj/sGOI1/TxMbR05AnHiefDWYZvldDHJSovK9V
         ZiFvmUy/UdCvLgLffBIlOBtduDgVC5BIq+pIXV/cCZaKWaxNbiJEQmE1z7rU3NdKBPPQ
         kk8A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1770913216; x=1771518016;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=mi5u0IHjuTZOX7odZMNHAm98HQb5d2Af/uNafAkI9/U=;
        b=mhgyiMfzBQzo/Q43okM58wCMzFJfNOwbIIeFSA6k6bsZRj1lBFIMj7yyIhV35Y+cIw
         080YZyDahfuZPo627hNW484TUjZCw8mBTj5yvDOcQZElPDTrz9k3qTbx1UcD4gLquHr7
         gPXDF514+feZgpU/JvSHiYURL1f66WWTOkouDcg0dtDduq494VTuBJcjYdafSozgMUKn
         HXMcSQKlhpsXQvtKL3n7xtGc0KMHtzW12ZapF5Nkb0tgB7QagyPzNMWy4nvFBZ/Vsk/O
         g+LEWK90PcpoBQS3q5GC25qpVvJtYywgjE3mzRtq5qDaOWRD0Sv36xltRxPiJtThluyi
         ncPA==
X-Forwarded-Encrypted: i=1; AJvYcCXP5xbolK5Vs5ivSyJP1fjnGbsuUECJ8gVpjSaaTFZRFSR9DwhWqoHYgQs1CaeksnzMtmR67lPqjw==@vger.kernel.org
X-Gm-Message-State: AOJu0Yw3cZoUH6W9kVkCwo4One3yA56EEOKcME91vWspFzRSxh2SxttM
	/htiFYs0INT+rcM3xc2ERbCp7FswjyMpfJo+YrDFBVh79uO4Pdv2KtoJr0LFEK0iNKygc2Pnof5
	8CmDPgNyf0ZIVPzBNYUn0ydb9k4YdQyrur4rxCZvFkj9K1UP2VJsLcfjRQnyNWA==
X-Gm-Gg: AZuq6aKSfgxPXjKp8I566Rd/R26Oh9sVtqQbb1dsckzPWL0L0NUvfmUngJL29LPFSfB
	1dMCMfysk8CRvL1O1F9NZx+RBrRu6Fix12teM8WDFQuR+cAU66AUYMUaRj2g2L3gfVlBTHcytmi
	G5bE1k7+MwyBHLeHbINNlufER4vhWyy25QZM+5hfTXDuUJikxFbMg+WMeKJLxXon9i2A9mR71FD
	oNu6C4nVLM+0gkdok/L6hxJI1iM2zTegPg4keqcFwW0bK1VdawwWv03IoRC1vEfvIRcpi8/s9Lj
	aZMo/OOWG67KfYXvZmI4PRIVB3K95IAz4/bNYeI4N0UMHuh9E2PAzGojL/0Naaf0pKNKk9GCaKK
	pMu1cDvMzG8GHbrOs05GVCY+HvcFF+RzQ4AyedA==
X-Received: by 2002:a05:620a:1a19:b0:8c7:16fb:ed49 with SMTP id af79cd13be357-8cb3314fa50mr381881285a.63.1770913216537;
        Thu, 12 Feb 2026 08:20:16 -0800 (PST)
X-Received: by 2002:a05:620a:1a19:b0:8c7:16fb:ed49 with SMTP id af79cd13be357-8cb3314fa50mr381876985a.63.1770913216137;
        Thu, 12 Feb 2026 08:20:16 -0800 (PST)
Received: from quoll ([178.197.223.140])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4834d835f6bsm183882625e9.14.2026.02.12.08.20.13
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 12 Feb 2026 08:20:15 -0800 (PST)
From: Krzysztof Kozlowski <krzysztof.kozlowski@oss.qualcomm.com>
To: Amit Kucheria <amitk@kernel.org>,
        Thara Gopinath <thara.gopinath@gmail.com>,
        "Rafael J. Wysocki" <rafael@kernel.org>,
        Daniel Lezcano <daniel.lezcano@linaro.org>,
        Zhang Rui <rui.zhang@intel.com>, Lukasz Luba <lukasz.luba@arm.com>,
        Rob Herring <robh@kernel.org>,
        Krzysztof Kozlowski <krzk+dt@kernel.org>,
        Conor Dooley <conor+dt@kernel.org>, linux-pm@vger.kernel.org,
        linux-arm-msm@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
Cc: Krzysztof Kozlowski <krzysztof.kozlowski@oss.qualcomm.com>
Subject: [PATCH] dt-bindings: thermal: qcom-tsens: Add Eliza SoC TSENS
Date: Thu, 12 Feb 2026 17:19:50 +0100
Message-ID: <20260212161949.120898-2-krzysztof.kozlowski@oss.qualcomm.com>
X-Mailer: git-send-email 2.51.0
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=1127; i=krzysztof.kozlowski@oss.qualcomm.com;
 h=from:subject; bh=TRLTPipXv4v+KxXfbm8DrsJEY9p4cLhTYGU5J3rwR7g=;
 b=owEBbQKS/ZANAwAKAcE3ZuaGi4PXAcsmYgBpjf2lnsKOhlO9JR41zyTmcq0t1CaJLhQJ0ZlRq
 3F2poGCXfyJAjMEAAEKAB0WIQTd0mIoPREbIztuuKjBN2bmhouD1wUCaY39pQAKCRDBN2bmhouD
 15mVD/wKKp35RLZSvxLU9qspOqCa7bCknspZbwLeaxd2avpodxQTUpcRdqshiSd7cfm12BCJhU5
 qNErh3ml3DbvZ2/LkF4FFYbNCfKoEqLgIhhskW1X+sBKhkuzHcB5BUB1RuNnzfv9oLtONXbB+cR
 954SKzJLpnPhFZPDHq2DvvvSD4ITQWf+Qt4V3f6EzAo+XxwdkIdG42P7qGo8zkbM38+hD1RxtZi
 Fpb7wzBZFsaeUQYDQguI63Is/OJnoTOQ5lydNoVJcfG2O9dLn6lEZLNw4yQ3vRoOV7nYSCFdFVY
 LX6WwwVhmOG2sYGJ54iZhbAq4lp5bqHaSCKG6Fl5+jzBKjpsBpq1Fx22HNbA6n+B9QTUC+FtT4d
 sZ3QgW1r5xDDtDju6BMoxDydVAeIq6Dh/Z9m1DJDS36X9niGTVD+aK35MIOAlBDt2eUCFJiXEEQ
 no7lZgsEVb6xYiVwBxEmtb2zSxMqljmxL3LC76a8m2S4rYuJAwSomtwKtlKx05fKV5+u+UB2yH8
 Y/DaoskYYyPfQrOifV0BJ88NbtKjwh5WufoSunboPyehKHWMdnflCkIFnkUeFTnWbS0v8BD5rt4
 xuo+tKVvi70VgvDQ1RuKxg94H8Rt8jPe+YooxeWSoncfKP3VvepJLnUHmRZ3TnGyJhOzcZ27d5q 7KxabH7LL5aHaqA==
X-Developer-Key: i=krzysztof.kozlowski@oss.qualcomm.com; a=openpgp; fpr=9BD07E0E0C51F8D59677B7541B93437D3B41629B
Content-Transfer-Encoding: 8bit
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwMjEyMDEyNSBTYWx0ZWRfXwQjqL3cK5wzN
 hURE4m12L1JRPhtyVx/cFf7WDmt4fgW33bL3pq74whUY2yR3c6dj3mjboHlbZTb5FrIz0ITi/6l
 C0wcosxDl1LcSXQgyIbrLnKFzzbkGowBuQLMTosoQbHvnVAgejxmyAqnj7e4WA/uxD9D8MIqWN+
 a0xU4hJ8ECuthHHmkdtLoySjxxq2X3TAdkz/qtVutHhdOsdKPd79EMf4IIKwvMY4Hy0gFCLVSWe
 PFoJhIDFOCXyRQ4PpAk+H/CCyiO+fcMDP3LL9yX1YOjM5Hmw8jj2H1qJmRYQ1S60uDTCKFwWs32
 v9QkY0XiBPhbdnVuEbQofr7zvMG6ij/3NcnUknGK/chz0mGJ2nTIhS3EsJKYliPKFXw9Jx/FAho
 p+XPBce6sZu8cqBOeaiHRQt0+OtleGU5k0lmf1EpoYVll7DGbpt+z0XzsJ3+EVlzedsduZDDM82
 c/n8zKCEnlvbFhCd0XA==
X-Proofpoint-GUID: lrq8q7HayX_PWS7u4Bcy0WxZ-MVUZWVb
X-Authority-Analysis: v=2.4 cv=Y6j1cxeN c=1 sm=1 tr=0 ts=698dfdc1 cx=c_pps
 a=hnmNkyzTK/kJ09Xio7VxxA==:117 a=6nO30s3o7FuWeffXwhKHTA==:17
 a=HzLeVaNsDn8A:10 a=s4-Qcg_JpJYA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=Mpw57Om8IfrbqaoTuvik:22 a=GgsMoib0sEa3-_RKJdDe:22 a=VwQbUJbxAAAA:8
 a=EUspDBNiAAAA:8 a=MLjw1J6mtoyfZjlVJ_UA:9 a=PEH46H7Ffwr30OY-TuGO:22
X-Proofpoint-ORIG-GUID: lrq8q7HayX_PWS7u4Bcy0WxZ-MVUZWVb
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-02-12_04,2026-02-12_03,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 spamscore=0 malwarescore=0 adultscore=0 suspectscore=0 bulkscore=0
 lowpriorityscore=0 phishscore=0 priorityscore=1501 impostorscore=0
 clxscore=1015 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2601150000
 definitions=main-2602120125
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [0.84 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_CONTAINS_FROM(1.00)[];
	R_MISSING_CHARSET(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[qualcomm.com,reject];
	R_DKIM_ALLOW(-0.20)[qualcomm.com:s=qcppdkim1,oss.qualcomm.com:s=google];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FREEMAIL_TO(0.00)[kernel.org,gmail.com,linaro.org,intel.com,arm.com,vger.kernel.org];
	RCPT_COUNT_TWELVE(0.00)[14];
	FORGED_SENDER_MAILLIST(0.00)[];
	TAGGED_FROM(0.00)[bounces-42572-lists,linux-pm=lfdr.de];
	MIME_TRACE(0.00)[0:+];
	RCVD_TLS_LAST(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[krzysztof.kozlowski@oss.qualcomm.com,linux-pm@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[qualcomm.com:+,oss.qualcomm.com:+];
	DBL_BLOCKED_OPENRESOLVER(0.00)[qualcomm.com:email,qualcomm.com:dkim,oss.qualcomm.com:mid,oss.qualcomm.com:dkim,sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[linux-pm,dt];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	RCVD_COUNT_SEVEN(0.00)[7]
X-Rspamd-Queue-Id: 3A78112F53E
X-Rspamd-Action: no action

Document the compatible for Qualcomm Eliza SoC TSENS module, fully
compatible with TSENS v2 generation (e.g. SM8650).

Signed-off-by: Krzysztof Kozlowski <krzysztof.kozlowski@oss.qualcomm.com>

---

Eliza SoC is being upstreamed and the compatible will be used in DTSI
posted later/soon.

Some existing work:
https://lore.kernel.org/r/20260119095907.172080-4-krzysztof.kozlowski@oss.qualcomm.com/
https://lore.kernel.org/linux-arm-msm/?q=eliza
---
 Documentation/devicetree/bindings/thermal/qcom-tsens.yaml | 1 +
 1 file changed, 1 insertion(+)

diff --git a/Documentation/devicetree/bindings/thermal/qcom-tsens.yaml b/Documentation/devicetree/bindings/thermal/qcom-tsens.yaml
index 3c5256b0cd9f..6505a386eeee 100644
--- a/Documentation/devicetree/bindings/thermal/qcom-tsens.yaml
+++ b/Documentation/devicetree/bindings/thermal/qcom-tsens.yaml
@@ -54,6 +54,7 @@ properties:
       - description: v2 of TSENS
         items:
           - enum:
+              - qcom,eliza-tsens
               - qcom,glymur-tsens
               - qcom,kaanapali-tsens
               - qcom,milos-tsens
-- 
2.51.0


