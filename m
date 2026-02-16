Return-Path: <linux-pm+bounces-42700-lists+linux-pm=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-pm@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id WLHaFo8ok2kI2AEAu9opvQ
	(envelope-from <linux-pm+bounces-42700-lists+linux-pm=lfdr.de@vger.kernel.org>)
	for <lists+linux-pm@lfdr.de>; Mon, 16 Feb 2026 15:24:15 +0100
X-Original-To: lists+linux-pm@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [104.64.211.4])
	by mail.lfdr.de (Postfix) with ESMTPS id 79897144929
	for <lists+linux-pm@lfdr.de>; Mon, 16 Feb 2026 15:24:14 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id 1EC7B3004693
	for <lists+linux-pm@lfdr.de>; Mon, 16 Feb 2026 14:23:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 202A13115B0;
	Mon, 16 Feb 2026 14:23:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="CeX53Jet";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="ViAzEraL"
X-Original-To: linux-pm@vger.kernel.org
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ABE6F310645
	for <linux-pm@vger.kernel.org>; Mon, 16 Feb 2026 14:23:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1771251830; cv=none; b=fGVueXCQ2W8wsYf8ElHhnwaXcgRDnd8onOMMiErKlGeWBukjeyAVIK98tKQm5VHpjWEJf5qI+iVthUsm+4tsCZSc03QzP2RLuDpr9DOf64tg9QJjMcA0xi4aXOXYReX1IJV2PlcGLmljBuET7ZJ7zvepJ1QZCVJMbExFCNTkpbo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1771251830; c=relaxed/simple;
	bh=Iiuil9S13HyvVze1LYPkhHu8cLgUNL75hWhkbEfEX34=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=rUznanDo/XWAwJa2tr+8FW5bT6sfuwR6Paj2VsPEGhcRXF4EwbRGtTeVx6EcDEoIl79xYuCIY1fQrg4DE7Qxeu7jiOYN+m6lNhP1CHwhKfMwklOvZe++S/SuSIL75imwt3nV+DPZAF2XmlBGmteYT7WLsLz2lg6y02qVhbwfRG8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=CeX53Jet; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=ViAzEraL; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279869.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 61GBQHud3685271
	for <linux-pm@vger.kernel.org>; Mon, 16 Feb 2026 14:23:42 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	tdDAFqnGWX0ame6wpW0GALZ7J5cThgnLOFF85Nj4Z6o=; b=CeX53Jet/pIwCAGf
	K43dnQSUVp80XX+M4MlJd4EmaD1heyZT4mee2Ss3/LPoDOzHgAdgleCgPEQfBCzr
	m6W/FTKg+fOeqV46GAq+g4LOrbt6MkkUPef9RHGLhVv2Y2eMITqKSIa/JnXllHuX
	9w01csg9wZEV3i+8ZlCKYk7JOMutmuk6Y+s9buSqq/zUVgazIKF5k9EKjew5liyM
	oWzYmEkgaU5LGB7rzdFTGbN7ztQ1ZwUhvAXS3KBpSx00mfz1IEwh9P2zTmOgng0a
	DrcRgzLcRPa30oibFRITtf786x1fzIZi9hYRkLvlUOT4sPafV+uMPqm+dX3O0An4
	/797HA==
Received: from mail-qk1-f200.google.com (mail-qk1-f200.google.com [209.85.222.200])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4cag24cudq-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-pm@vger.kernel.org>; Mon, 16 Feb 2026 14:23:42 +0000 (GMT)
Received: by mail-qk1-f200.google.com with SMTP id af79cd13be357-8c71500f274so340475185a.1
        for <linux-pm@vger.kernel.org>; Mon, 16 Feb 2026 06:23:42 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1771251821; x=1771856621; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=tdDAFqnGWX0ame6wpW0GALZ7J5cThgnLOFF85Nj4Z6o=;
        b=ViAzEraLSR1o/YGu4YtWRetaIO36FGQmWocfatOvx+6TZtDJarcPqxiZb8+vV+Ot2x
         k45T3hYfxuwg90yyPE5ExdexrhBqMlb61BwHS8qf3n306thYIV8deMb9juOFmo7M7UxB
         Z3G+Ji3HXZbBTk+ShP4ylMz6SLGx/JB+2JiXZZIkDgk2H7gm5vtPL7xsFhD5obZBvO6S
         0UY+QT74QzZnuVST1YT1o774ljIH1y9QOM+NsUP65C2AAam+Ha/QJ32IpfivNUGXeYOo
         hka8ubRH8AS10X0Kll7nGExSoqoL9g4bY8JLFT05aUu4NQK1gplRKiAV7Ovyc6KBlM8L
         +hMw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1771251822; x=1771856622;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-gg:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=tdDAFqnGWX0ame6wpW0GALZ7J5cThgnLOFF85Nj4Z6o=;
        b=UiFM2GfYwgd8tSrCHsw2rdkwURiOn1ZoGaVpxBeYDiQCJGwmwd8K7yKKaRcdS8n4rD
         hkLsuuew6NfBhdvhMCmyjGDe7Lp1GhDsPFXVwAD+e9zB15TuhK/oXFOjupz2Q0GGVelM
         vzrgJBh2jR43fxemZgFe/6WCu7fvddmfLvAng6R7UJTG+dj36XvH+v7P5pMh36icTPAx
         VhmGsPsMdLu63pm1F1inuf6cAsyU4zaBB+oGd5qIYEewoPoCwIwjLwotqcGIKot2ZPEb
         5VkKu9GDft4w97Q37Lsuzg55fToVZKE4uKhNQSb0/DDh96hG7k4vLOkucnwbGpBllR8v
         +AsQ==
X-Forwarded-Encrypted: i=1; AJvYcCWIwOHovwPqmXBg8a5wZngBP4DyViurJ9DPtKzI9lVzwLjCTWyABhSDq5fTO+blvuQBbhg4JoWcoA==@vger.kernel.org
X-Gm-Message-State: AOJu0YwrblBivhniZuCelAhx+HEK4vHfvPuaGKDPUZe1ekJzb1dY6FYi
	aYhuHapt66SSZwvuqjDhjXaLxFueH6vZ+z/hfyDDPHvWmp/h+ALvvkizJoXChlRI5mU48EuAXG8
	UnR6gBevv6Wr33enwkmMTqKSjE1w29LquNC2f2DzXHtaMHVc22E05OPo3shrMrQ==
X-Gm-Gg: AZuq6aIx13f/zJTwfPyBcojEiJp2SCPpneoxwGJvb53GdZOxk/JK3ICqmJRs1DIwWAh
	C4ub0kzxiD2uiT6mTS+7o8zfiHhIKKjkbML8OTiS+aahPZvDSsSIM/FN1PnhXrH9Q2KyRlhZbnC
	GWLq/45cfs9y2kTHU1yZf2kUws0wu5Ple36MTNLZHyuwBbT/sNBqdFwVadCc7R5iZPpgqNGi1WF
	4+b7sHEvmd/gOc/QH1fRlZGfMsp/vMGZ94idN+FAYBnesBRY+8AfM4rcrah6/G7wmpvtIemavqi
	Gt2baSjgIEJlYhhiJ+1xFNvzyGyKuZrdB4aHH7c0pRqUeLcxta338DmXq9XZNmPJ9NeDINYJQU8
	LUVO6QEDLOcqwmBwe6VgRAdrdZxokww==
X-Received: by 2002:a05:620a:458f:b0:8a2:e1db:f442 with SMTP id af79cd13be357-8cb422b2fa6mr1215568285a.30.1771251821114;
        Mon, 16 Feb 2026 06:23:41 -0800 (PST)
X-Received: by 2002:a05:620a:458f:b0:8a2:e1db:f442 with SMTP id af79cd13be357-8cb422b2fa6mr1215563585a.30.1771251820328;
        Mon, 16 Feb 2026 06:23:40 -0800 (PST)
Received: from hackbox.lan ([86.121.162.109])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-48371a34d66sm101714975e9.20.2026.02.16.06.23.38
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 16 Feb 2026 06:23:39 -0800 (PST)
From: Abel Vesa <abel.vesa@oss.qualcomm.com>
Date: Mon, 16 Feb 2026 16:23:18 +0200
Subject: [PATCH 1/2] dt-bindings: power: qcom,rpmpd: document the Eliza
 RPMh Power Domains
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260216-eliza-pmdomain-v1-1-c51260a47d6d@oss.qualcomm.com>
References: <20260216-eliza-pmdomain-v1-0-c51260a47d6d@oss.qualcomm.com>
In-Reply-To: <20260216-eliza-pmdomain-v1-0-c51260a47d6d@oss.qualcomm.com>
To: Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>,
        Conor Dooley <conor+dt@kernel.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Ulf Hansson <ulf.hansson@linaro.org>
Cc: linux-arm-msm@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-pm@vger.kernel.org,
        Abel Vesa <abel.vesa@oss.qualcomm.com>
X-Mailer: b4 0.15-dev-47773
X-Developer-Signature: v=1; a=openpgp-sha256; l=737;
 i=abel.vesa@oss.qualcomm.com; h=from:subject:message-id;
 bh=Iiuil9S13HyvVze1LYPkhHu8cLgUNL75hWhkbEfEX34=;
 b=owEBbQKS/ZANAwAKARtfRMkAlRVWAcsmYgBpkyhmm/jI6D+9HaAgvGPqytBk0tOaPzu9Y3Oza
 mJOeK1GLISJAjMEAAEKAB0WIQRO8+4RTnqPKsqn0bgbX0TJAJUVVgUCaZMoZgAKCRAbX0TJAJUV
 VjuOD/9vt++BzU4In0EtL0RIjHrXGRz62Z+uDBR+3e7oiXLjY0n9DAu4FXXUkifnfvEEH0cJ5zP
 8uQij488gmUsi3F0WZLp6mcPI5AwGL/SwXxqWDNMm8n3R4myRBVdGPx4F6eujU37Ik9rHpJBTX6
 oXucBAMvS6gZix+mzqOqWilOL6J1xR+dYMgN3dpNUzsF/Ii6BgOwhJEczBdIa44jV3X5LLKNYms
 4lAyIrMCHGUGTAF+BySKGyrB7VmFJfrVdOOcbLKw88PPZXAQTvAVpvMCP45rbD2iTi8ERxUF524
 wnojj/rCIaAo7ptsjE6rEMMYH1aSkQxqGmpqdHzXIj6nhS7bhzSVLo+w7wCEvle4p/oWckCrOjt
 WftpQt0ZqHwLQCXZDWZo/nUU7jsNRAQGGySqORkqcJ3daiuxVtKMPhGNjFIlV4KaMLw1nXePQ9q
 43GSuClmI4VBZCI+S7Lb1IbzcF48dgJnjDAjneYqcoJxf4X+2qsON8OTVg0Nd0crEFDBb7Uojcz
 iPMa4PYZJtlxxK9AFjHHXg+KfTlTQrN7jf7hDsZe50putr6Yp2BdeL/yy+uvQhV6ccaBXCUb0lI
 pke7RJHC4cX0mOisSUcOSdRMMXN6SMclgpRN7RvvGGE4aBWqrhNtCorzSUI+z9vyi+26eFs/ptw
 o/mXCpNM5eSbk0Q==
X-Developer-Key: i=abel.vesa@oss.qualcomm.com; a=openpgp;
 fpr=6AFF162D57F4223A8770EF5AF7BF214136F41FAE
X-Proofpoint-GUID: R9DIHyNdVdU2btgafkcThkbWQ3RkIuzc
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwMjE2MDEyMiBTYWx0ZWRfX7Gj6RJAvWBsk
 llC1Ysa/mn7t+eTx4AvtDNgIm8Rd6vKN+sFMoqBhqCly9FCBU8DglXOeTeJPQdWVa6/Cny0PtE4
 VGoZk9MHaLtXiPXVTwsh37auVeiisN046x5Dk+8fQrJMbRbEnIFgW18cHQve0Wcjl31g5yMfWX4
 HL8sZkMMGL+3/WDIScQwCGPD3VU8IjNd2Dwz28zztQ8UgHVvu1K0CE59G2O2MHTapMigN4Km1AB
 IX+LxDaO5PbTUnvxNwakeN+MwUFW8xHJxm6ZSAoy7GQKER11sXjrZ5dGChl1OJRO1Qw6l+4r9c6
 RKDEep88PWVhkUuyjKLau5fkdL5ZoYmewyuzmmMd8luxtVpkdQk5jM+R5Bg4o4U2I8tPrK03IgE
 02sOr6SFoNrlR+o2pqXqdA5djcTAUPH1Rmp23XdLSMTbUlT5+6LFBxb+76Wq5On2dC1TkC4JeN0
 On7qhH4Fb5TlF71Pvtg==
X-Proofpoint-ORIG-GUID: R9DIHyNdVdU2btgafkcThkbWQ3RkIuzc
X-Authority-Analysis: v=2.4 cv=aetsXBot c=1 sm=1 tr=0 ts=6993286e cx=c_pps
 a=hnmNkyzTK/kJ09Xio7VxxA==:117 a=oauzzCmhM186DRC0Y2yWPg==:17
 a=IkcTkHD0fZMA:10 a=HzLeVaNsDn8A:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=Mpw57Om8IfrbqaoTuvik:22 a=GgsMoib0sEa3-_RKJdDe:22
 a=EUspDBNiAAAA:8 a=-qkovbBEdaU6HcigwZ0A:9 a=QEXdDO2ut3YA:10
 a=PEH46H7Ffwr30OY-TuGO:22
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-02-16_04,2026-02-16_03,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 impostorscore=0 phishscore=0 priorityscore=1501 malwarescore=0 suspectscore=0
 spamscore=0 lowpriorityscore=0 bulkscore=0 clxscore=1015 adultscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2601150000 definitions=main-2602160122
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.66 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[qualcomm.com,reject];
	R_DKIM_ALLOW(-0.20)[qualcomm.com:s=qcppdkim1,oss.qualcomm.com:s=google];
	R_SPF_ALLOW(-0.20)[+ip4:104.64.211.4:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	DKIM_TRACE(0.00)[qualcomm.com:+,oss.qualcomm.com:+];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-42700-lists,linux-pm=lfdr.de];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sin.lore.kernel.org:helo,sin.lore.kernel.org:rdns,qualcomm.com:email,qualcomm.com:dkim,oss.qualcomm.com:mid,oss.qualcomm.com:dkim];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[abel.vesa@oss.qualcomm.com,linux-pm@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	ASN(0.00)[asn:63949, ipnet:104.64.192.0/19, country:SG];
	MID_RHS_MATCH_FROM(0.00)[];
	TAGGED_RCPT(0.00)[linux-pm,dt];
	RCPT_COUNT_SEVEN(0.00)[10];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	RCVD_COUNT_SEVEN(0.00)[7]
X-Rspamd-Queue-Id: 79897144929
X-Rspamd-Action: no action

Document the RPMh Power Domains on the Eliza Platform.

Signed-off-by: Abel Vesa <abel.vesa@oss.qualcomm.com>
---
 Documentation/devicetree/bindings/power/qcom,rpmpd.yaml | 1 +
 1 file changed, 1 insertion(+)

diff --git a/Documentation/devicetree/bindings/power/qcom,rpmpd.yaml b/Documentation/devicetree/bindings/power/qcom,rpmpd.yaml
index 27af5b8aa134..8174ceeab572 100644
--- a/Documentation/devicetree/bindings/power/qcom,rpmpd.yaml
+++ b/Documentation/devicetree/bindings/power/qcom,rpmpd.yaml
@@ -17,6 +17,7 @@ properties:
   compatible:
     oneOf:
       - enum:
+          - qcom,eliza-rpmhpd
           - qcom,glymur-rpmhpd
           - qcom,kaanapali-rpmhpd
           - qcom,mdm9607-rpmpd

-- 
2.48.1


