Return-Path: <linux-pm+bounces-42948-lists+linux-pm=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-pm@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id ULdIHvyemGnJKAMAu9opvQ
	(envelope-from <linux-pm+bounces-42948-lists+linux-pm=lfdr.de@vger.kernel.org>)
	for <lists+linux-pm@lfdr.de>; Fri, 20 Feb 2026 18:50:52 +0100
X-Original-To: lists+linux-pm@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 36462169DCE
	for <lists+linux-pm@lfdr.de>; Fri, 20 Feb 2026 18:50:52 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 761E23045E0C
	for <lists+linux-pm@lfdr.de>; Fri, 20 Feb 2026 17:50:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 17F1D36606E;
	Fri, 20 Feb 2026 17:49:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="BVX1tsNH";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="I+qLjGyq"
X-Original-To: linux-pm@vger.kernel.org
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B6BBE35957
	for <linux-pm@vger.kernel.org>; Fri, 20 Feb 2026 17:49:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1771609799; cv=none; b=Rz/y3/ZSSraNTTDBHs7JW5hjnMYf/WwAsZhm1ANcHayj7VobyunAYiJPvFTRsOkFc2CnBPZbsFy0qdlMe6eVIZ2IjHqQTx8pi0zP8LB7qcqGrol0nlptAoJmUiSt9E5zdpHSmrfyPQfvSQ7TZqKIP4ZNwy9nM1NaeJXBMuDhsG8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1771609799; c=relaxed/simple;
	bh=0NZ+CypqiJsLdss+LvH/k62d39Ju/HAfreRXg5phupg=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=mJuTeL7+ijWUbjIWfVgX01Bcz33eO0+5BT5dpTKH1vtIhQfOxjL3hgkHM0OFXeh0qDGveBO7BURxYo9sExNBHG1HVkyms3CTKpSeWHGNjuSl8Tn1FOBTjR6ahCl8GhTRLq9z1RdzDyunFfTUnXA/HUCYlztmEVrYvEOAZBkV3CE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=BVX1tsNH; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=I+qLjGyq; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279869.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 61KGRqvx3699759
	for <linux-pm@vger.kernel.org>; Fri, 20 Feb 2026 17:49:51 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:date:from:in-reply-to:message-id
	:mime-version:references:subject:to; s=qcppdkim1; bh=WFtX1N01ij/
	B+pouCQ2UjU6Esw13VUhjGUoONqvfWzA=; b=BVX1tsNHOEjC62q5ZfjDAyxgji+
	RQfzhI3hrM+RGWbw3CbZTLFZ5+ADPUyE67ASjTQLL2MtAcL7ATcO5JIBXnMLov2j
	JlFapj/q+X080j80tg1GTlHkcZkjcDXkgYYmYUPFmBKRXyclhuEvVqMzivxIx+nx
	J4gX74kkKbVHKsM3EkTyh+8BjUYNF7ZO241bhOZktfsDaFHEyLGIznFDV/qmec3G
	Hi0+XgXJMvQYBp4BDf3sAE5WS+m0lB92Q/1iHwfc4Oe8+p2YCf8R/Xx9fQwy42dQ
	R2yiRQhc8fuc3csJarqH+9i0FDBb4e+0kUGXzObfoz9erAcJeAMWlxnWflg==
Received: from mail-qk1-f199.google.com (mail-qk1-f199.google.com [209.85.222.199])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4ceh5jhvmx-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-pm@vger.kernel.org>; Fri, 20 Feb 2026 17:49:51 +0000 (GMT)
Received: by mail-qk1-f199.google.com with SMTP id af79cd13be357-8cb706313beso307381785a.3
        for <linux-pm@vger.kernel.org>; Fri, 20 Feb 2026 09:49:51 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1771609791; x=1772214591; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=WFtX1N01ij/B+pouCQ2UjU6Esw13VUhjGUoONqvfWzA=;
        b=I+qLjGyqFobpFM5a6pYgoYmUZu32i/wQsSnYN1dTFL20WdPJxc7QKRUsD99j102MsD
         nwJKK7X+Xh8iAlbnISIpMv6W9+/42Zq8I2pgFbfUv0FmBkQ6s/7Ek/svXA5qprCLwkWw
         zRHYLR9k/lhb9c5WfVsJr7ckgsXbtDMqCb+j2tV6Nk9/K+ognVmUMMDLy4NWaDHFY2Ps
         nydvRr6t+ZU7YeucgxcHqtuIydjVV6Lj9MrayhpBmX40YjpAvTmqO58GuoDhyHioqV7l
         wmxx5brVYmZ8evTnFk8512bn5BEPdjhr7pR+j+41X1P6NTRrVxUKH8NbG5wYoBL6pcyS
         UwbA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1771609791; x=1772214591;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=WFtX1N01ij/B+pouCQ2UjU6Esw13VUhjGUoONqvfWzA=;
        b=Q7U77CCNJ+kJLx0T1EO7i8dPKIcGWdYkJXb17mu0uYO5+dAXgcNbw8Sj8dEn7TiMIA
         8TvSYcQFMG+IEhBoSt7LN3VVMPXKM/dM5jlUM8TOvfNKcfsPhas2iSzR/h+WLoyCwso9
         qa8fQguIPTonHgnAwJqx+nWTLkffcSDEd/jaBodLGT4bdfJ9D1X5HS/taTUhPETxR7yu
         jfsacCUcT3VM8KqjyeJE9CTzBvIwVpXs76ifq3h9805D5oWpcLVwY6Mqqn2r21isO8D2
         uD4Tc9D29NZurASd+xq/2VdJPGooQmzihLYcsqVUr8FhMYTA10GyjUV971Mnu3Ykkobt
         CBMg==
X-Forwarded-Encrypted: i=1; AJvYcCUOwTfL0d3K5SLTP+abfugpQVr8g7bwxLdjHopR208aB9d9m9vBXLEGo8Q0tZBoIDon1MY21ZhXNw==@vger.kernel.org
X-Gm-Message-State: AOJu0YwTKC0d/RyphEK9Fg117q+EUCzV2L5dvcRWauinQDsSXiqUo6eK
	UbiodZTmklk4GaVYrv8nqIeJzx3nb4KqNs68G34TPyZ0M5RWAaVbZ9HWj2N+wgaDzy5vgOONy4J
	IlQCOjB3hVR7OkOddUAyoC70W5F2BqoWsOvQDq0mye3UbnfptILwzOAD1Jc1jmg==
X-Gm-Gg: AZuq6aJnYmcQRXnzuUC8XTb9ZwrNU4Y5Wz38SJtmmtIOrhgVxCKWmaLtVqaXt90NTuw
	M4y9DWCkomheQ0Ht2GxtEh6dpLBK00lWCv4B4WZyUPMDdOgrK+ke+fpSKQViurvFBdczTZSM6FL
	EJOQaxmaK9hjWsv34mbZ4Gr2VsPbrTTD8knAtQxTiG1XV3YONMQUJv1uBUqm8omvk9k+y0Fox80
	7CIQa+z7utHF6iJRCOIlDAU7DKeV6G0MoqP7FR7CL3BA3vJiqbAveRPf9PapzaijpMDQgcdBHoc
	i3jB6gQT8PuuiapLsO0vlAd0GUKJ6WOu3xGmu/N9/ujQgM4/q9Zbx7m+8n/iXwrGHRtVJbVKwqd
	9pwkyU06pptSdKkrJBl6nTM5Mno2gWy+kD1tQRA==
X-Received: by 2002:a05:620a:4542:b0:8c0:af6c:fdfa with SMTP id af79cd13be357-8cb8c9cfe8bmr53870685a.3.1771609790856;
        Fri, 20 Feb 2026 09:49:50 -0800 (PST)
X-Received: by 2002:a05:620a:4542:b0:8c0:af6c:fdfa with SMTP id af79cd13be357-8cb8c9cfe8bmr53867085a.3.1771609790350;
        Fri, 20 Feb 2026 09:49:50 -0800 (PST)
Received: from quoll ([178.197.223.140])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-43796a6a5e5sm54071940f8f.9.2026.02.20.09.49.49
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 20 Feb 2026 09:49:49 -0800 (PST)
From: Krzysztof Kozlowski <krzysztof.kozlowski@oss.qualcomm.com>
To: Sebastian Reichel <sre@kernel.org>, Hans de Goede <hansg@kernel.org>,
        Chen-Yu Tsai <wens@kernel.org>, linux-pm@vger.kernel.org,
        linux-kernel@vger.kernel.org
Cc: Krzysztof Kozlowski <krzysztof.kozlowski@oss.qualcomm.com>
Subject: [PATCH 2/4] power: supply: axp288_charger: Simplify returns of dev_err_probe()
Date: Fri, 20 Feb 2026 18:49:40 +0100
Message-ID: <20260220174938.672883-6-krzysztof.kozlowski@oss.qualcomm.com>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <20260220174938.672883-5-krzysztof.kozlowski@oss.qualcomm.com>
References: <20260220174938.672883-5-krzysztof.kozlowski@oss.qualcomm.com>
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=4087; i=krzysztof.kozlowski@oss.qualcomm.com;
 h=from:subject; bh=0NZ+CypqiJsLdss+LvH/k62d39Ju/HAfreRXg5phupg=;
 b=owEBbQKS/ZANAwAKAcE3ZuaGi4PXAcsmYgBpmJ62ewft+80UPxjq530zrBqkEU5XPURsFIL/y
 l8g7SJtg8iJAjMEAAEKAB0WIQTd0mIoPREbIztuuKjBN2bmhouD1wUCaZietgAKCRDBN2bmhouD
 16W2EACOUx41BDN6BCDDA0c9fUfNRP3jZJ6V/fzGkLs/UG+IpwKKUsGZ4jGYvFR3Jv1acg81+Es
 9Mw14z6zXJnYO6MXfBWlND3oPaanq3aLLosO0HUoZR1HrwQC5fosNaAy9n+K854WHgqUviAmos/
 If/L+z4FZtTbtrE/nC2DPIZhNcB2wXzJO5nIBwmdy7Th51OPb1Ane/XuNU4gSYaNu08+o4KM3be
 D2ZS72uLgig+uiI8d/+gbLOezSu8MIMS7P+Q5Xb/mWapLZ85vyQIEVSPNLULmIgnJ5/SxMLlRNL
 rs7J/ZhNgj6CeUcr8kBjq2Utfkpe6gZci3dfBin699B4V5sv9dOqr07QOkWR8Utl7zorCkFsA0Y
 l6HUIqutYv2q+Xm69ia5VLnvU29Z6MUYtQfMgh6/eeWIx2tGqvXGFao4woe7LzTTGm0LMkceHUw
 EwcXDX1hPIygyQ3YVagtyWfHLmPoFA8Hy2FJp0MmU1F53LavG93VmtFzCubYL9NA27tBTSb2OzE
 AVpkLDiL27pWU7kjZCfOzrbPO4mFBzgX9lQ2MjRv9ZmHNm6lDVIvIIPepR+/p253eKp03ozZFA/
 e2HDGQKuBSQXBraBe4gNuuLdDCPx/zp695H9hvNQj9G7+XrD+jqYEeObtSDExHm9qejGBk1StcG 9qhv18l+pEvayPg==
X-Developer-Key: i=krzysztof.kozlowski@oss.qualcomm.com; a=openpgp; fpr=9BD07E0E0C51F8D59677B7541B93437D3B41629B
Content-Transfer-Encoding: 8bit
X-Authority-Analysis: v=2.4 cv=Raedyltv c=1 sm=1 tr=0 ts=69989ebf cx=c_pps
 a=HLyN3IcIa5EE8TELMZ618Q==:117 a=6nO30s3o7FuWeffXwhKHTA==:17
 a=HzLeVaNsDn8A:10 a=s4-Qcg_JpJYA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=Mpw57Om8IfrbqaoTuvik:22 a=GgsMoib0sEa3-_RKJdDe:22 a=EUspDBNiAAAA:8
 a=nn75UsRem9KnWL5VjA8A:9 a=bTQJ7kPSJx9SKPbeHEYW:22
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwMjIwMDE1MiBTYWx0ZWRfX+h0qJ3KqYbuq
 zqkkMK7m6kumT1kM6DC4BYiPiiEtlRnIvvL8O3HAXZmu7m8cql0vyIu6a5QzZKpQ/WmWzQyTpEw
 j3Vp/qHruia5Syv/gPDV1o5di/z3ZyynxtV0SqIQBfAYMNRrvt2OrZyT7oLDw0A/HxyMSWpdfn7
 U0gBWMxAR3lbDWho7d11IKNHFiodHYP7ftZBel0YkqpLu5Ek+6oGN8C1q7pYJPWgfJ0kVEkxwho
 6zow+FkYNbLxNxW1/jH5yEA2a34bH/iKXYoZrK6l5FaUYLzDo7Zxs4LXksUVQcKT/Ad19I31DLB
 sxpVxlpVLycpQIJ8YBj/Qqjswqi1twD+lLYqu+e/Yy7oCHSun6hIXFIbnvMJeCSOD49Cf8fMhjc
 otgLQAIyxlVY529V62GyCMvu3fnJvo223TjnUQFoMAv52KOwfmyD64IU5yOUFP7bSi5El8NSjoj
 7aQuAWCK5NWivGF8mnA==
X-Proofpoint-GUID: JTREWaJJxN8zgn2uBgAyIqgpSP3KHBSz
X-Proofpoint-ORIG-GUID: JTREWaJJxN8zgn2uBgAyIqgpSP3KHBSz
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-02-20_02,2026-02-20_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 priorityscore=1501 lowpriorityscore=0 spamscore=0 phishscore=0 bulkscore=0
 clxscore=1015 suspectscore=0 impostorscore=0 malwarescore=0 adultscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2601150000 definitions=main-2602200152
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.66 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_CONTAINS_FROM(1.00)[];
	DMARC_POLICY_ALLOW(-0.50)[qualcomm.com,reject];
	R_MISSING_CHARSET(0.50)[];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c04:e001:36c::/64:c];
	R_DKIM_ALLOW(-0.20)[qualcomm.com:s=qcppdkim1,oss.qualcomm.com:s=google];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-42948-lists,linux-pm=lfdr.de];
	FORGED_SENDER_MAILLIST(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns,qualcomm.com:email,qualcomm.com:dkim,oss.qualcomm.com:mid,oss.qualcomm.com:dkim];
	MIME_TRACE(0.00)[0:+];
	FROM_HAS_DN(0.00)[];
	TO_DN_SOME(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[krzysztof.kozlowski@oss.qualcomm.com,linux-pm@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	TAGGED_RCPT(0.00)[linux-pm];
	NEURAL_HAM(-0.00)[-0.999];
	DKIM_TRACE(0.00)[qualcomm.com:+,oss.qualcomm.com:+];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c04::/32, country:SG];
	RCPT_COUNT_FIVE(0.00)[6];
	RCVD_COUNT_SEVEN(0.00)[7]
X-Rspamd-Queue-Id: 36462169DCE
X-Rspamd-Action: no action

One of benefits of dev_err_probe() is that it returns the error value
greatly simplifying the error paths (e.g. three lines -> one line).

Signed-off-by: Krzysztof Kozlowski <krzysztof.kozlowski@oss.qualcomm.com>

---

Context depends on previous patch
---
 drivers/power/supply/axp288_charger.c | 52 ++++++++++++---------------
 1 file changed, 22 insertions(+), 30 deletions(-)

diff --git a/drivers/power/supply/axp288_charger.c b/drivers/power/supply/axp288_charger.c
index ca52c2c82b2c..ea0f5caee8f0 100644
--- a/drivers/power/supply/axp288_charger.c
+++ b/drivers/power/supply/axp288_charger.c
@@ -859,12 +859,10 @@ static int axp288_charger_probe(struct platform_device *pdev)
 	info->regmap_irqc = axp20x->regmap_irqc;
 
 	info->cable.edev = extcon_get_extcon_dev(AXP288_EXTCON_DEV_NAME);
-	if (IS_ERR(info->cable.edev)) {
-		dev_err_probe(dev, PTR_ERR(info->cable.edev),
-			      "extcon_get_extcon_dev(%s) failed\n",
-			      AXP288_EXTCON_DEV_NAME);
-		return PTR_ERR(info->cable.edev);
-	}
+	if (IS_ERR(info->cable.edev))
+		return dev_err_probe(dev, PTR_ERR(info->cable.edev),
+				     "extcon_get_extcon_dev(%s) failed\n",
+				     AXP288_EXTCON_DEV_NAME);
 
 	/*
 	 * On devices with broken ACPI GPIO event handlers there also is no ACPI
@@ -878,12 +876,11 @@ static int axp288_charger_probe(struct platform_device *pdev)
 
 	if (extcon_name) {
 		info->otg.cable = extcon_get_extcon_dev(extcon_name);
-		if (IS_ERR(info->otg.cable)) {
-			dev_err_probe(dev, PTR_ERR(info->otg.cable),
-				      "extcon_get_extcon_dev(%s) failed\n",
-				      USB_HOST_EXTCON_NAME);
-			return PTR_ERR(info->otg.cable);
-		}
+		if (IS_ERR(info->otg.cable))
+			return dev_err_probe(dev, PTR_ERR(info->otg.cable),
+					     "extcon_get_extcon_dev(%s) failed\n",
+					     USB_HOST_EXTCON_NAME);
+
 		dev_info(dev, "Using " USB_HOST_EXTCON_HID " extcon for usb-id\n");
 	}
 
@@ -897,11 +894,9 @@ static int axp288_charger_probe(struct platform_device *pdev)
 	charger_cfg.drv_data = info;
 	info->psy_usb = devm_power_supply_register(dev, &axp288_charger_desc,
 						   &charger_cfg);
-	if (IS_ERR(info->psy_usb)) {
-		ret = PTR_ERR(info->psy_usb);
-		dev_err(dev, "failed to register power supply: %d\n", ret);
-		return ret;
-	}
+	if (IS_ERR(info->psy_usb))
+		return dev_err_probe(dev, PTR_ERR(info->psy_usb),
+				     "failed to register power supply: %d\n", ret);
 
 	/* Cancel our work on cleanup, register this before the notifiers */
 	ret = devm_work_autocancel(dev, &info->cable.work,
@@ -913,10 +908,9 @@ static int axp288_charger_probe(struct platform_device *pdev)
 	info->cable.nb.notifier_call = axp288_charger_handle_cable_evt;
 	ret = devm_extcon_register_notifier_all(dev, info->cable.edev,
 						&info->cable.nb);
-	if (ret) {
-		dev_err(dev, "failed to register cable extcon notifier\n");
-		return ret;
-	}
+	if (ret)
+		return dev_err_probe(dev, ret, "failed to register cable extcon notifier\n");
+
 	schedule_work(&info->cable.work);
 
 	ret = devm_work_autocancel(dev, &info->otg.work,
@@ -929,10 +923,10 @@ static int axp288_charger_probe(struct platform_device *pdev)
 	if (info->otg.cable) {
 		ret = devm_extcon_register_notifier(dev, info->otg.cable,
 					EXTCON_USB_HOST, &info->otg.id_nb);
-		if (ret) {
-			dev_err(dev, "failed to register EXTCON_USB_HOST notifier\n");
-			return ret;
-		}
+		if (ret)
+			return dev_err_probe(dev, ret,
+					     "failed to register EXTCON_USB_HOST notifier\n");
+
 		schedule_work(&info->otg.work);
 	}
 
@@ -951,11 +945,9 @@ static int axp288_charger_probe(struct platform_device *pdev)
 		ret = devm_request_threaded_irq(&info->pdev->dev, info->irq[i],
 					NULL, axp288_charger_irq_thread_handler,
 					IRQF_ONESHOT, info->pdev->name, info);
-		if (ret) {
-			dev_err(dev, "failed to request interrupt=%d\n",
-								info->irq[i]);
-			return ret;
-		}
+		if (ret)
+			return dev_err_probe(dev, ret, "failed to request interrupt=%d\n",
+					     info->irq[i]);
 	}
 
 	return 0;
-- 
2.51.0


