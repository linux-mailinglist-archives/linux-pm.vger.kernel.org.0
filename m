Return-Path: <linux-pm+bounces-43005-lists+linux-pm=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-pm@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id iOegF5MUnGkq/gMAu9opvQ
	(envelope-from <linux-pm+bounces-43005-lists+linux-pm=lfdr.de@vger.kernel.org>)
	for <lists+linux-pm@lfdr.de>; Mon, 23 Feb 2026 09:49:23 +0100
X-Original-To: lists+linux-pm@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id BE98717349D
	for <lists+linux-pm@lfdr.de>; Mon, 23 Feb 2026 09:49:22 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id DD57430131E0
	for <lists+linux-pm@lfdr.de>; Mon, 23 Feb 2026 08:49:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6C9BF34D4F3;
	Mon, 23 Feb 2026 08:49:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="Wz5Qam20";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="QbDHwXHF"
X-Original-To: linux-pm@vger.kernel.org
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 38560345751
	for <linux-pm@vger.kernel.org>; Mon, 23 Feb 2026 08:49:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1771836556; cv=none; b=TueoZcZxjyA1vDKq/OxvAJKaFHS7wZKmSNt5tpPxWCOvNkzKbutQPXO2dwaU7dE8yCIhzxHoq5pqq8xuH3ox5zRUM9arl5ugYwT3u3CLWDCAkkoPWAggW09dt4wjp/7cPCeGIBKHgUeSfcnHVRMuOF+wuhRVu9Kc70ChL2s5NQA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1771836556; c=relaxed/simple;
	bh=wWdVjcHHZifLpKJTQMD9B4lE383jI5XBHmwb/3V9bUw=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:To:Cc; b=jSuRMoJn2hFKQ6Uy5nSdhfX+ghyDu+slLjHrndrJzikJZLooVhGrCANK03NTaIZAEELnMCfYvzAZHvKLUEMAkoNtCjeLbQdVTFgSXX5525uY98TE41WZFlkg1Tgbzxqxat7nJlKpUmofmlCQQdQxABg35RE2Sksml3Cyn244cIo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=Wz5Qam20; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=QbDHwXHF; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279872.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 61N8ZTLi1425174
	for <linux-pm@vger.kernel.org>; Mon, 23 Feb 2026 08:49:14 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:message-id
	:mime-version:subject:to; s=qcppdkim1; bh=eSKyydQlaYzgtBT9kaH36X
	jlz+DnegvsJaRM4KYOD9s=; b=Wz5Qam20rI9ZewjvWwVr3RHYEvrNiyN7cURbRy
	pSiXTENw/5Ub0z5NN6dujT3k7L8qrWDOijmUALy5896+XhanLMCEn1Lk5nj2IaVa
	kWZT710eAGzJhffVLs0EE79b4yHmr0jZRTcWh6FHpzHTWQx8TWh49osuFS5TVxjI
	svhMpchdFaYLSeYXoelBjFmTlyeIJLKyr8Nd6lYGhGjWl8WTrR+ShSCMYbMno1bJ
	1LkAWfvEcUf7vXNPDIcZBwAwFjSpziCbYInowwcHFlzivgeqVYHW1KIBjpkkw8dT
	ubt18kJi1XwNQccP+dZDeApg9JbihwCmDvOBAcJ+/qsvGo1Q==
Received: from mail-qk1-f198.google.com (mail-qk1-f198.google.com [209.85.222.198])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4cf5v3uyw8-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-pm@vger.kernel.org>; Mon, 23 Feb 2026 08:49:14 +0000 (GMT)
Received: by mail-qk1-f198.google.com with SMTP id af79cd13be357-8cb4e37a796so3424412085a.2
        for <linux-pm@vger.kernel.org>; Mon, 23 Feb 2026 00:49:13 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1771836553; x=1772441353; darn=vger.kernel.org;
        h=cc:to:message-id:content-transfer-encoding:mime-version:subject
         :date:from:from:to:cc:subject:date:message-id:reply-to;
        bh=eSKyydQlaYzgtBT9kaH36Xjlz+DnegvsJaRM4KYOD9s=;
        b=QbDHwXHFqxSmfeUt+31vsToP41wNhaRR69PFK7mBL8pGJMWYW7FA9nbxeS8D6+mJza
         OipePGNqjrCGWVtJz4LYmc3v5IrzEWPqsjji40hnQtffBaYxCoYjNniEKwa/nEGGkKDv
         x/aZYXYxfF3i7S6s1KrP3OmuhfzDprJz4veYLHr+vfz+u9HOWHA5mzcTgoM0K8VziXit
         SL/NqTTaiVdl/17GlcNnNfr3jUZTBVctf4jKPkAatiSD9ycfA44d+fLXMc2cOgp/dpKt
         kxznAZnv/WdIdIQeTxoLL09tuVPL228Tf3II7jkbnVRbxMGgpiKTVy3WeXpJIbP9xz1O
         mTLQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1771836553; x=1772441353;
        h=cc:to:message-id:content-transfer-encoding:mime-version:subject
         :date:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=eSKyydQlaYzgtBT9kaH36Xjlz+DnegvsJaRM4KYOD9s=;
        b=RiLvW6wy6HDqbaq+eb3aJ8CNTfMMFpMjks0dFpLTeQS1MGu3p0w1zsn1HuDQbwDbiv
         h50ZlByxbHCnkwm0M/tY8SMXxnnLluDkDngK6WZVjEzeAZ4XU30eVNuTD1uFV021VxPx
         NdA07osJEt5Yb77fPZ2WuuzqGxux/iv2tGn2YJhKHKNAcRui/KYFvcQv7hLGFGR92v07
         NyaOClDG1LtDAn0z7q9EkTf8a+IRgl6LvgX3uXdpEPSRNSb8j6cJyXXBdVoS+yP26Vm0
         Hno7TyLJwPAy48RnYjnMhBc3gz6zqvkSncWPv9hokLWDdFiVnJnAfMeahSLXrI3P8QrO
         HR4Q==
X-Forwarded-Encrypted: i=1; AJvYcCUUneofAZe8kCEpHuo2p6UNZ3Zwt9vObkHHm4FEBBhcRfWZ3EoQ6yazNvHaA3Oa3XgDhMbgUI55aQ==@vger.kernel.org
X-Gm-Message-State: AOJu0YxUfcyPK3sHTPTAmzA/1rAZXgY9LJzmOKgHLJjG7UIMe6RntOuJ
	zOwA0GVPmTxVJ9HWtdl3sp4U4n/MpC8sPZ8fvGra66SCu/rP3cgKH4mxPEam0LhLdrscbX0BE0P
	d8Mxbwo1+ZWkzysmBGfi4bHwW1ZIkyG5RI4oZWSLMevsY+Ey7aBSQIf1LW3h2VA==
X-Gm-Gg: AZuq6aLs3fva1vHJcU7qkCqcPTrRKKe0aqmuaUNQ4GMhxwxS2kzMyfmv/nQP/8ZM9sY
	8nViBYEkq1XLWMgi4S2lcr0fq+XwgU9cUl6R4oRBsIAQ6uHFawaHeEqp0/eps8UeqVdmlRZ+ToP
	I+luUrq0ByR8AgIMq9k0X6pRkeF1iNo+yliXQTH/vlx3+jaCuk1Ha8a9/3RpJCn9Tb4NEcFCGrt
	46S6ZJzTMs+J9GkQLusKzPy7w+JFIxB1KJJ6t4FUzGdPvs454qCbQ6vf4iIHP66n0iWSCCKEHYj
	I0d0u3iZiBIUtVE5cL5f53tKd/Cbxo9qkcpR2hDwPFC9uv7N84nbmvu97opN/U7Sim9wJuozUUQ
	Fir8dwB7WBBcZMyNBnOuHLwsj8ogI6Q==
X-Received: by 2002:a05:620a:294d:b0:8c6:ec8f:c8a1 with SMTP id af79cd13be357-8cb8ca71fc7mr957700485a.44.1771836553373;
        Mon, 23 Feb 2026 00:49:13 -0800 (PST)
X-Received: by 2002:a05:620a:294d:b0:8c6:ec8f:c8a1 with SMTP id af79cd13be357-8cb8ca71fc7mr957698685a.44.1771836552783;
        Mon, 23 Feb 2026 00:49:12 -0800 (PST)
Received: from hackbox.lan ([86.121.162.109])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-43970d54760sm17834071f8f.35.2026.02.23.00.49.11
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 23 Feb 2026 00:49:12 -0800 (PST)
From: Abel Vesa <abel.vesa@oss.qualcomm.com>
Date: Mon, 23 Feb 2026 10:49:04 +0200
Subject: [PATCH] dt-bindings: interconnect: OSM L3: Add Eliza OSM L3
 compatible
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260223-eliza-bindings-interconnect-epss-l3-v1-1-fa83970d60ae@oss.qualcomm.com>
X-B4-Tracking: v=1; b=H4sIAH8UnGkC/yXNwQ6CQAyE4VchPdtktxoOvorxALsD1pBCtmiMh
 Hd31eN3mH82chSF07nZqOCprrNVxEND6dbZCNZcTRKkDSLCmPTdca+W1UZntRUlzWZIK2Nx5+n
 IcTiFGCJym0G1tBQM+vq9XK5/+6O/18k3Tfv+AcZJDt6HAAAA
X-Change-ID: 20260222-eliza-bindings-interconnect-epss-l3-1f40101ed6de
To: Georgi Djakov <djakov@kernel.org>, Rob Herring <robh@kernel.org>,
        Krzysztof Kozlowski <krzk+dt@kernel.org>,
        Conor Dooley <conor+dt@kernel.org>,
        Sibi Sankar <sibi.sankar@oss.qualcomm.com>
Cc: linux-arm-msm@vger.kernel.org, linux-pm@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        Abel Vesa <abel.vesa@oss.qualcomm.com>
X-Mailer: b4 0.15-dev-47773
X-Developer-Signature: v=1; a=openpgp-sha256; l=1023;
 i=abel.vesa@oss.qualcomm.com; h=from:subject:message-id;
 bh=wWdVjcHHZifLpKJTQMD9B4lE383jI5XBHmwb/3V9bUw=;
 b=owEBbQKS/ZANAwAKARtfRMkAlRVWAcsmYgBpnBSGkNTgNthmmA5wR7z9s5uKcfUIEcrel9dDx
 ZmRMZVeuK2JAjMEAAEKAB0WIQRO8+4RTnqPKsqn0bgbX0TJAJUVVgUCaZwUhgAKCRAbX0TJAJUV
 VnGtD/9LMmzeWThRDEsWxU4GNu5Zrx2YlVt/t9NaT33g1gxMlQ3TVv7aIJc/SZULTW2TOrZ0Rd0
 dLu/B1aSWiYOhpNLrd7dcS3kpxChJxDPryKz6TphLPDFUA+Xw/95y9f1mXWEsQXgUVIaTpE4cXG
 1XMt4i1GjqZO68GSbjXSUnm5i2cAotisG6IIUuRTK9Gg2Nnf6yZRC5WrL9wfIaKtsfx8ybVxD3H
 +FvTUE5uv++AAFw84tCx39CNoHIFvuCJGdSIT56I1rjnGe6VtUxea52b12FGLxeg5GeyormQQeL
 ERigI+5N5mA3q98CIspuKDhYUS5oRQKrWfXLEkvNiSzQzutMHRulYQom5xZy2m1Y7VNsBszsxLk
 O5DJu8sgAMhOQ3ybJ7+bMmzcDt4PsCzfQng27Ij1ps9G8aQTMPQiiqlbBAwSL6+XPdloh+c/nBZ
 8bsz4ZSR+WofZbwmyHjUQx/DOp6BzkzJTcs27t3giUDTpyrZMkvnzHd9bD4UCPg+eREdPhrHs6c
 8zp8lK3ROQBAHZ5b/14mzkB1vdS+RxfoUc1hbmt3BgQRLI43tO/bLnGNn6jYufoO2NK76JxrruP
 6FJiwmwARs8YW2MHptKqR/wgcvitZNSEK59O2ffx0Xf3Z2uwWNLOA9ja1IG5nvfaMc7f0bYq96O
 PoOCy+WsTmSE/kQ==
X-Developer-Key: i=abel.vesa@oss.qualcomm.com; a=openpgp;
 fpr=6AFF162D57F4223A8770EF5AF7BF214136F41FAE
X-Authority-Analysis: v=2.4 cv=YL6SCBGx c=1 sm=1 tr=0 ts=699c148a cx=c_pps
 a=qKBjSQ1v91RyAK45QCPf5w==:117 a=oauzzCmhM186DRC0Y2yWPg==:17
 a=IkcTkHD0fZMA:10 a=HzLeVaNsDn8A:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=yx91gb_oNiZeI1HMLzn7:22
 a=EUspDBNiAAAA:8 a=r4u9pCY-MgWLWsCgO6sA:9 a=QEXdDO2ut3YA:10
 a=NFOGd7dJGGMPyQGDc5-O:22
X-Proofpoint-ORIG-GUID: H443dmUBJ2l67xnv4elcl6EF_8E_C4VW
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwMjIzMDA3OCBTYWx0ZWRfX/BcUpyEmcmYW
 Oo4q88ClwtxbNSQlgepBOw6WDlIkfBCldn+2LU01o2HuQ5SiGj7AJIXPvFBlkjDj+rCahvBAdQ6
 36UUCA2xlEkPXHDJgTWSifhH5EZtesXXs/TgCgdy4lqCdGHHsAWONrGTgsXMSjKgmAVD/I3k1DV
 EjY66UFluWAu9vwOdbUaZtZHcJpcVJKUkuZIFCPIeCxb7YCVps/cd8Mk3pJgCyjH/8lVcoPiApW
 EBUjbm+ScFdhhUi/P7J/52KAnj+R+7vEJ45P6xoz1svZlNTjmoqSIdl6GwrjnwslGkCWhM9VtBY
 8xj4ZAFw8PKRTc85Kvuxq839JmFLkitiIN5iwwCllkhTUDAcESnw3othwqUsPNLdqA9Wm+hd60M
 l5bQtcMl2MYbFg/YeXmMuBWsWEoOOTQus4C7cpKhgt31Wcvd2R2ZFx2kYJyEV1eGFD75EE7OByh
 WQ10yXx4hjglcERryog==
X-Proofpoint-GUID: H443dmUBJ2l67xnv4elcl6EF_8E_C4VW
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-02-23_01,2026-02-20_04,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 adultscore=0 priorityscore=1501 lowpriorityscore=0 bulkscore=0 phishscore=0
 impostorscore=0 suspectscore=0 clxscore=1015 spamscore=0 malwarescore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2602130000 definitions=main-2602230078
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[qualcomm.com,reject];
	R_DKIM_ALLOW(-0.20)[qualcomm.com:s=qcppdkim1,oss.qualcomm.com:s=google];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	DKIM_TRACE(0.00)[qualcomm.com:+,oss.qualcomm.com:+];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,qualcomm.com:email,qualcomm.com:dkim,oss.qualcomm.com:mid,oss.qualcomm.com:dkim];
	RCVD_TLS_LAST(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	TAGGED_FROM(0.00)[bounces-43005-lists,linux-pm=lfdr.de];
	MIME_TRACE(0.00)[0:+];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[linux-pm,dt];
	FROM_NEQ_ENVFROM(0.00)[abel.vesa@oss.qualcomm.com,linux-pm@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	MID_RHS_MATCH_FROM(0.00)[];
	NEURAL_HAM(-0.00)[-0.999];
	RCPT_COUNT_SEVEN(0.00)[10];
	RCVD_COUNT_SEVEN(0.00)[7]
X-Rspamd-Queue-Id: BE98717349D
X-Rspamd-Action: no action

Eliza, similarly to SDM845, uses OSM hardware for L3 scaling.
Document it.

Signed-off-by: Abel Vesa <abel.vesa@oss.qualcomm.com>
---
 Documentation/devicetree/bindings/interconnect/qcom,osm-l3.yaml | 1 +
 1 file changed, 1 insertion(+)

diff --git a/Documentation/devicetree/bindings/interconnect/qcom,osm-l3.yaml b/Documentation/devicetree/bindings/interconnect/qcom,osm-l3.yaml
index 4b9b98fbe8f2..6182599eb3c1 100644
--- a/Documentation/devicetree/bindings/interconnect/qcom,osm-l3.yaml
+++ b/Documentation/devicetree/bindings/interconnect/qcom,osm-l3.yaml
@@ -28,6 +28,7 @@ properties:
           - const: qcom,osm-l3
       - items:
           - enum:
+              - qcom,eliza-epss-l3
               - qcom,sa8775p-epss-l3
               - qcom,sc7280-epss-l3
               - qcom,sc8280xp-epss-l3

---
base-commit: 6de23f81a5e08be8fbf5e8d7e9febc72a5b5f27f
change-id: 20260222-eliza-bindings-interconnect-epss-l3-1f40101ed6de

Best regards,
--  
Abel Vesa <abel.vesa@oss.qualcomm.com>


