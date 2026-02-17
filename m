Return-Path: <linux-pm+bounces-42748-lists+linux-pm=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-pm@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id oEOjFJxnlGlFDgIAu9opvQ
	(envelope-from <linux-pm+bounces-42748-lists+linux-pm=lfdr.de@vger.kernel.org>)
	for <lists+linux-pm@lfdr.de>; Tue, 17 Feb 2026 14:05:32 +0100
X-Original-To: lists+linux-pm@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id C454514C547
	for <lists+linux-pm@lfdr.de>; Tue, 17 Feb 2026 14:05:31 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id AF499304116D
	for <lists+linux-pm@lfdr.de>; Tue, 17 Feb 2026 13:01:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 62313337118;
	Tue, 17 Feb 2026 13:00:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="NliCbb2P";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="ZDwj9eOD"
X-Original-To: linux-pm@vger.kernel.org
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 39A8F356A24
	for <linux-pm@vger.kernel.org>; Tue, 17 Feb 2026 13:00:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1771333252; cv=none; b=MPhyoc/oMmzJWEiRbgcxK7Qw5c6QGlc8FbZW/CPCxldDQIU+I3lPWC7MrDbo6H+cVuZFhpipQtip04JSiUyDkVvfdF/Mq4SzrSz0MzgclAeZTwOCXluroj1Cv3txLpEJsA82t0z1Z7ooWYvFJiU0JqfgR73EGqVZeaWd9CEXfm8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1771333252; c=relaxed/simple;
	bh=EzkTHDadVnOE2NfigixNwb2wSzI+jRdeOn659JJ4Y1o=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=ljG6UBCN6KqJgwu1wa71nGkPFnW2z1fCWsIew5rNzkW1Pa1GiimdbDa9jkZr9cC1YQhkKU7TfaR46y4F77VsBQb4yHCLa4XVhZYizXLpjmHXnkdad6FTRDxrY/5Cwz1WMFFj+AGlFe0qY3vqvjaF0ylTP+PJ/p7isFp0bldxNrs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=NliCbb2P; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=ZDwj9eOD; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279866.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 61H6juYE3392907
	for <linux-pm@vger.kernel.org>; Tue, 17 Feb 2026 13:00:50 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:date:from:in-reply-to:message-id
	:mime-version:references:subject:to; s=qcppdkim1; bh=bC++DKedS7f
	bs1KMQy0E+YAY3hYXEPrJJ1jNOPM9ySc=; b=NliCbb2PGIvWvO463CFDT60Prb4
	XsygZnUdCazJ3fOw4bRamK85YS3vHWnf8TychkH97NFztijK25sXrke6xglXiLuK
	nKmWSne0v3VhIB9se2iIKvHnwByZsU1J7ivTv5/kVAvaQNYUUhUeHv/rLcIjPIey
	Uc2jXGL89mqeGhjc5vrD8U4aYYb55w08nRLgu9QAqoZBuju53umWIjsxxmP3CCyt
	FJPze3hHVHvuIBqZPvEegUz1tVwWbYuhaCTQMC35x6/2Ly5PTEdenz8lnSE5Z03B
	gq1E6xYHTt30H9SmwPOoiZW84r1gCFT6VNtc7nQE/fNTqlXy5dNZHB9Quow==
Received: from mail-qk1-f197.google.com (mail-qk1-f197.google.com [209.85.222.197])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4cc5khakn8-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-pm@vger.kernel.org>; Tue, 17 Feb 2026 13:00:50 +0000 (GMT)
Received: by mail-qk1-f197.google.com with SMTP id af79cd13be357-8cb4817f3c8so2176315585a.3
        for <linux-pm@vger.kernel.org>; Tue, 17 Feb 2026 05:00:50 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1771333249; x=1771938049; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=bC++DKedS7fbs1KMQy0E+YAY3hYXEPrJJ1jNOPM9ySc=;
        b=ZDwj9eODbSA0sYn7T+YNAMpHq+FpMOLtKzdhJxFOgrxFxi0LFh0wM7fCDPm+PflKMk
         5p86aS0oycytzzWV51PxRdlmMDLO+/9e9qA4CzA3ODTUOL7LB6ddoA1c/ViioVjg/RhW
         DvZNA47THnlbAPSMbwJvlehPyb98fWWbugds6IG7dgGqArgArQ2dE88Bm/t6Xspj4LN7
         UFp0tpm7IQOPhQRyOdOPEZ1y9GXisX+Xz0ln3zTE97OIAqdJb8FMQ36rXvXPN6CqUaa9
         IpPdZcKVkoMZqfNG7beHo8B2B/bQIlJXeC7waP8K58J3Tr4h4LmYPNoiFH1PonsEbleg
         D3KA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1771333249; x=1771938049;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=bC++DKedS7fbs1KMQy0E+YAY3hYXEPrJJ1jNOPM9ySc=;
        b=nHszIyguFDBHEDw5Xz/+73Fxlbh05XI5oxP9r/5cmjokeUgAaaslgSI8+MBWLsQgtm
         ZunDwlO95DETDld+/UfNW+kNj+1V9KHFz18X/gM//qfefY7gtoPwLeJSHnXXBvI+5cIR
         UPgF+XHCN1H8d/5Q+oCMN8LH5LQVshEMU2UVM4EEABqorpYFbpr65dJS6LPnGHo3ap8a
         ePBO51cO65pc5yLoLf7EnYaCRvGnzeKY9FEqbDlyG5fHQ+B9fGiocX4aPCIrmQklXoSX
         qe5YsxTjClam36pM2wf03JG8BTfT2QirC12X2fIko8tEBlJ5doVMwG89an5PnCOnjmce
         7+Mg==
X-Forwarded-Encrypted: i=1; AJvYcCXIqktCBTKR6RMmzFniPPnNz9z0ODGJljAUe1+jaGWGOSiTv93s1jTwUcDVuM2RBE8kiJ/mG+HUfQ==@vger.kernel.org
X-Gm-Message-State: AOJu0Yxy/3mEoBcw/Nhhet5xzhlwJmUFPizyHE3GgeYK9yLXiIBM/q3E
	6HkLoX3D3piuBdGRNz8wZKIeMs8o2IgZ3w3Oc3njvy6bHQd29NPiA24NQ1jGo23S/lh5FyBDJZj
	KoXF7dyUYONCvn1DECU9AvsDPz8Jjtw7JhlLrWaGw2wYloWGSF85dHuPJwRSBylSUY3XK+w==
X-Gm-Gg: AZuq6aIx9T6zqolh6HXCgMDgnWisulRML9f4JJjYAfbehBJ8m5lJYImwt3EfF6YWK3g
	XX+IVDYbzQ6PZWYETTsESH1FpsqSTmg+3rfpknyXPFCoH6qgj0UbKAb3VwHD220V9QJ0AwgQjau
	NFPL2W/opy519BPNunaaWIe1OVsNcKOXzrzB5FmpnQKgZYFSolPStwOq9U7CQnOC3Cmu6ClkRtl
	iIyqyUqEnLgGgE+VMsR5Rxef/FOWEwANf212G+CRxyVC7/dr6GnE6DC7ExFaIwgeJVJY+cxmPmK
	3sxEZJkCIB2t0lE/WgSUyOvpk34arogVCNwVcGaUCdFp/7J8UN4g8VET6ur5oyElzjR9OGJt/lO
	OCQ1xfKzaWpeR9UHnFnisQoD36fw2794zHH2NyA==
X-Received: by 2002:a05:620a:3947:b0:8c7:106c:cbd4 with SMTP id af79cd13be357-8cb4081fabdmr1564965885a.12.1771333247265;
        Tue, 17 Feb 2026 05:00:47 -0800 (PST)
X-Received: by 2002:a05:620a:3947:b0:8c7:106c:cbd4 with SMTP id af79cd13be357-8cb4081fabdmr1564921785a.12.1771333243774;
        Tue, 17 Feb 2026 05:00:43 -0800 (PST)
Received: from quoll ([178.197.223.140])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-48371a44ae0sm100240045e9.29.2026.02.17.05.00.42
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 17 Feb 2026 05:00:43 -0800 (PST)
From: Krzysztof Kozlowski <krzysztof.kozlowski@oss.qualcomm.com>
To: Georgi Djakov <djakov@kernel.org>, Rob Herring <robh@kernel.org>,
        Krzysztof Kozlowski <krzk+dt@kernel.org>,
        Conor Dooley <conor+dt@kernel.org>,
        Raviteja Laggyshetty <raviteja.laggyshetty@oss.qualcomm.com>,
        linux-arm-msm@vger.kernel.org, linux-pm@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
Cc: Krzysztof Kozlowski <krzysztof.kozlowski@oss.qualcomm.com>
Subject: [PATCH v2 2/2] interconnect: qcom: De-acronymize SoC names
Date: Tue, 17 Feb 2026 14:00:37 +0100
Message-ID: <20260217130035.281752-4-krzysztof.kozlowski@oss.qualcomm.com>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <20260217130035.281752-3-krzysztof.kozlowski@oss.qualcomm.com>
References: <20260217130035.281752-3-krzysztof.kozlowski@oss.qualcomm.com>
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=1624; i=krzysztof.kozlowski@oss.qualcomm.com;
 h=from:subject; bh=EzkTHDadVnOE2NfigixNwb2wSzI+jRdeOn659JJ4Y1o=;
 b=owEBbQKS/ZANAwAKAcE3ZuaGi4PXAcsmYgBplGZ0wIofTUnkIovkhI60z3g9Ux8dN60mwyDXz
 RsJr3BYwcSJAjMEAAEKAB0WIQTd0mIoPREbIztuuKjBN2bmhouD1wUCaZRmdAAKCRDBN2bmhouD
 18NpD/oCJxlG/+6xPVXgrNjQ8dEkszRg0xg60tsRI0zvjl5stBh9s6/OmZRvsrauRh1l0nSONj+
 Fujm5eTRGZIUYyQzrT+NLj54lMWJBpx4mhsD8F1xOmhhoFgCSX/v03AkJ7hGPzPT/4wdYhZUBEt
 EQDF5Y3IUfOTo98NJpN8QI3vFUtCeva4g99+VIZGprgCz5/0o+F9aw43Y6if5USfHCbwE/1UOM4
 LChDggWzTRxyy7MILzPZPxX92acVZlWd9shLeqROOjB5Jto+NH53f7u6s3hcwxq/TwFi/kpsuRl
 BsE1o3knO0EOLdbgF5zXvEKZdSI8mBK1ggQy18lgGBKcaiVItbE4awDRsOrrUR4eegvW9Pd/UF1
 dGb4YL498sdQFF+YBI6zHdpMpqxdpa3T1rrnJJyWlEuGIkNoJvLr7GoGsm7/OewJRRThdbnGasZ
 S2U3kvjy24ZLEm53ze89WDS8bIoWCQket9JQ+yD8NuDtMy/EN2z34qz2xM8avRXbzlKeBRTggx1
 +UEMDWvnpr0ogPUeargkQ17GeErSjXuRFr1XZkFfxs9d52S8Yb8qVq3td71hhAnYMvPrx1Ziofm
 AbpMyRLoOiQNyPG1LiBanjnC57ygo7aair7OMC9WB3Rs9b0nVLCfxqfhRV/5K3gEr0EgkUdCXDH RCK0vrfzeXCn/cQ==
X-Developer-Key: i=krzysztof.kozlowski@oss.qualcomm.com; a=openpgp; fpr=9BD07E0E0C51F8D59677B7541B93437D3B41629B
Content-Transfer-Encoding: 8bit
X-Authority-Analysis: v=2.4 cv=Coyys34D c=1 sm=1 tr=0 ts=69946682 cx=c_pps
 a=50t2pK5VMbmlHzFWWp8p/g==:117 a=6nO30s3o7FuWeffXwhKHTA==:17
 a=HzLeVaNsDn8A:10 a=s4-Qcg_JpJYA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=Mpw57Om8IfrbqaoTuvik:22 a=GgsMoib0sEa3-_RKJdDe:22 a=EUspDBNiAAAA:8
 a=h0AwHwagC81chbRYmVIA:9 a=IoWCM6iH3mJn3m4BftBB:22
X-Proofpoint-GUID: Thk5pgzFUdWlEiyQlCNj9Sy7aDO-LOC0
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwMjE3MDEwNiBTYWx0ZWRfX3y3zMQSM+gDL
 sH+wQCtVP5DsE7sPbayvIxc/rXSCQ/co6ynZEuvBPhGcfaMzKa70+3cuvsQzSjxU//BNfxouzbG
 hHXIH64mQOAVo/ZxY++I9Ecv/V1Qh5Ga6E1/KxzVmjQUbPp5HHdGv4d+E/l5ukw6oWUzNQ7ybLD
 tj3Wfr/MHXeDZTzV1gbfhcOHLt1mgfHSLQ6Ssmh2upP09m7SP/kNwfAiNp2Bhv1uvoGe2yArn5m
 T3JcxuhKYn7lsZ8gHaHGN8SQZExkmQax1IzQFQsJMiCp760/Z2vjcMaGBNkrHg6q1H2/207S9VN
 jMAOgZDCoBhescUWcim/U415wt6Xp+TgXdlCkl6PfptpYX30RfPa1niEIxD342diUyqk8didyKo
 1oscNzbjx8e7jkEf6aQDuV09nnwHLntFVlKEp+nW2RyBoeECxULux+Qt8GwIJW0KAr2UVbEHe5P
 Vq/xkGl3QzV4Jg9o15Q==
X-Proofpoint-ORIG-GUID: Thk5pgzFUdWlEiyQlCNj9Sy7aDO-LOC0
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-02-17_01,2026-02-16_04,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 malwarescore=0 lowpriorityscore=0 spamscore=0 bulkscore=0 impostorscore=0
 priorityscore=1501 clxscore=1015 phishscore=0 adultscore=0 suspectscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2601150000 definitions=main-2602170106
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.66 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_CONTAINS_FROM(1.00)[];
	DMARC_POLICY_ALLOW(-0.50)[qualcomm.com,reject];
	R_MISSING_CHARSET(0.50)[];
	R_DKIM_ALLOW(-0.20)[qualcomm.com:s=qcppdkim1,oss.qualcomm.com:s=google];
	R_SPF_ALLOW(-0.20)[+ip4:172.105.105.114:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-42748-lists,linux-pm=lfdr.de];
	DBL_BLOCKED_OPENRESOLVER(0.00)[tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns,oss.qualcomm.com:mid,oss.qualcomm.com:dkim,qualcomm.com:email,qualcomm.com:dkim];
	FORGED_SENDER_MAILLIST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FROM_HAS_DN(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[krzysztof.kozlowski@oss.qualcomm.com,linux-pm@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	TAGGED_RCPT(0.00)[linux-pm,dt];
	RCPT_COUNT_SEVEN(0.00)[10];
	DKIM_TRACE(0.00)[qualcomm.com:+,oss.qualcomm.com:+];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.105.96.0/20, country:SG];
	TO_DN_SOME(0.00)[];
	RCVD_COUNT_SEVEN(0.00)[7]
X-Rspamd-Queue-Id: C454514C547
X-Rspamd-Action: no action

Glymur and Kaanapali are codenames of Qualcomm SoCs, not acronyms.

Signed-off-by: Krzysztof Kozlowski <krzysztof.kozlowski@oss.qualcomm.com>
---
 drivers/interconnect/qcom/Kconfig  | 4 ++--
 drivers/interconnect/qcom/glymur.c | 2 +-
 2 files changed, 3 insertions(+), 3 deletions(-)

diff --git a/drivers/interconnect/qcom/Kconfig b/drivers/interconnect/qcom/Kconfig
index bb1cb8a640c1..425686f4ec50 100644
--- a/drivers/interconnect/qcom/Kconfig
+++ b/drivers/interconnect/qcom/Kconfig
@@ -9,7 +9,7 @@ config INTERCONNECT_QCOM_BCM_VOTER
 	tristate
 
 config INTERCONNECT_QCOM_GLYMUR
-       tristate "Qualcomm GLYMUR interconnect driver"
+       tristate "Qualcomm Glymur interconnect driver"
        depends on INTERCONNECT_QCOM_RPMH_POSSIBLE
        select INTERCONNECT_QCOM_RPMH
        select INTERCONNECT_QCOM_BCM_VOTER
@@ -18,7 +18,7 @@ config INTERCONNECT_QCOM_GLYMUR
          platforms.
 
 config INTERCONNECT_QCOM_KAANAPALI
-	tristate "Qualcomm KAANAPALI interconnect driver"
+	tristate "Qualcomm Kaanapali interconnect driver"
 	depends on INTERCONNECT_QCOM_RPMH_POSSIBLE
 	select INTERCONNECT_QCOM_RPMH
 	select INTERCONNECT_QCOM_BCM_VOTER
diff --git a/drivers/interconnect/qcom/glymur.c b/drivers/interconnect/qcom/glymur.c
index e5c07795a6c6..4fa8be6375e7 100644
--- a/drivers/interconnect/qcom/glymur.c
+++ b/drivers/interconnect/qcom/glymur.c
@@ -2518,5 +2518,5 @@ static void __exit qnoc_driver_exit(void)
 }
 module_exit(qnoc_driver_exit);
 
-MODULE_DESCRIPTION("GLYMUR NoC driver");
+MODULE_DESCRIPTION("Glymur NoC driver");
 MODULE_LICENSE("GPL");
-- 
2.51.0


