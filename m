Return-Path: <linux-pm+bounces-40130-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id A54F2CEE981
	for <lists+linux-pm@lfdr.de>; Fri, 02 Jan 2026 13:57:38 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id EFEC630303B7
	for <lists+linux-pm@lfdr.de>; Fri,  2 Jan 2026 12:56:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4D6E8314A65;
	Fri,  2 Jan 2026 12:49:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="QczwO7Sb";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="PJkc/7p1"
X-Original-To: linux-pm@vger.kernel.org
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AF32F313E02
	for <linux-pm@vger.kernel.org>; Fri,  2 Jan 2026 12:49:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1767358160; cv=none; b=Hn6rU9syaox0uqttWbPu/jZFrPOPgxoCO4MezxEvQwb/0wm5Q4vMLz2PCE5qQHKFtiAUDAMXyyaS1yan4OZF9SCgSJ38xS+/tD6m2t20PNB9T0YQRl0Kb8ukcBK/njc+C3eKoi7h6NKpKhwN7nhBF+Q4Z6Jq8DI5EESO2I5Yhkc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1767358160; c=relaxed/simple;
	bh=CByj1rkU5zEzBBBrW/OJ2X8lHA6LjYMZv9EsVJP4P54=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=Upw5CQwulFVbGyAU4P+wnVrROqThAbpr8HzlwtW4UY6LNpGHtY77TFxY3ZF+4WPy158i/NEdMDxb23jmyHnT8s0lx3EwfrjmvMjCdsVdtoMuBEiY7Bf8p6xZE/uQRYQjyTJSZUcX8ll86mTHO5uS78rfMqhlgoJEqRg6o/c6Mls=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=QczwO7Sb; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=PJkc/7p1; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279863.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 6029VviL426589
	for <linux-pm@vger.kernel.org>; Fri, 2 Jan 2026 12:49:17 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:date:from:message-id:mime-version
	:subject:to; s=qcppdkim1; bh=b42LPC6wZk3Y+SOS+y3F8UFXSo+1kuRMvyk
	c+T91sOs=; b=QczwO7Sbx1ChCoxgc0boFxvfNE6tNHASNPLZUfX/XRMNIGREM+E
	IWF0IKK9fxjXaAvYy7dLumkg4sK7XUn7ZJ8tfqozcXiO51iPMhe4IKF6GikYIZ5Y
	acirOVXy7HhtoGi/clXyE2gIx/A0EdbXQA1q4Q+FC4CwfRljghJX+vLsCgbPqK1n
	RIz/vNlhzpY1gbLcsLsmBs+Au+icIz8CJsjsaPLuWmPlU/ZmEn2pDm/nuYCU65Qk
	fOPvj2ZihzcZvs6Qc32f3qPaJ9CKvqotwIJYMXJA8rx77bSsn3+Ddl2w0HAgCXaa
	nKbX4dTn583qW2brfPRfUN529J1LniTc8Tw==
Received: from mail-qt1-f197.google.com (mail-qt1-f197.google.com [209.85.160.197])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4be6fjrxpm-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-pm@vger.kernel.org>; Fri, 02 Jan 2026 12:49:17 +0000 (GMT)
Received: by mail-qt1-f197.google.com with SMTP id d75a77b69052e-4f35f31000cso165007311cf.2
        for <linux-pm@vger.kernel.org>; Fri, 02 Jan 2026 04:49:17 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1767358157; x=1767962957; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=b42LPC6wZk3Y+SOS+y3F8UFXSo+1kuRMvykc+T91sOs=;
        b=PJkc/7p1agO6uHUlr8Q8J4QEKSHCRDElIdldaRZ0Ew7PIIf4xH1EP0F67q15iX2AKz
         xxZ2PvnBNsfe0c94uHXxNgXXtp2fpasfi/YKjPhfQZP1D14w0n8MPNrEsNnnQwhu3Rja
         1Doc9lg+pPqkBDPbDIZzz9WBuMSWz2J5iw7V65xcFSKjedYBKKPPOgXWHyhZ3dbKeYIu
         x53F6z4qMFQQK0xAdzQF6u8bpDBQRa5MQ1tGzR4A5q/OR62FR563cEjzfLTjTflw05nG
         QnYDgMtCb4JTKvpsZDcsssq/UR7/TM2sY5fdI4t9rD6vAMWIXsqqiKnQBSmqrjDix7Hd
         Bnbw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1767358157; x=1767962957;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=b42LPC6wZk3Y+SOS+y3F8UFXSo+1kuRMvykc+T91sOs=;
        b=CHBGvxBipOO1mLFESnG0hGJ4HX35d3mlNqpxBEv0W1lBmtY5iD3yFG/DU8jpPmzhyv
         QivNhYpVRbJ1yI+O3HRY4dX/kGclJ/OemXv7wL8uZvoO0Sd4ztLboRnJbRYSM2Iec68s
         5+lGOvg+K5BasvIBV3bnIbcx+sdst9+UwczdA8r2twCs0OzgmO5PFja0Ub/C69R6sDL2
         OEhsZQeAtMegOxup7do95QdK5X/fZPS3RiDU/U3JLu1gRd8sGBCoIsX4G6q+A8CMxA5C
         aZZq7BKDzaRk8CUV1z2dBYKtciuyEP7HhFGfqHPYZy0N6t5vwjO9GbTZxfcq0Mjil4xz
         acyw==
X-Forwarded-Encrypted: i=1; AJvYcCU/slpX/NdVLNR9W72w/64jdMUh6MncftSL66VZraF5dUdXbGQFYEXqhZBy+E6+BoE6Lke50J7CzQ==@vger.kernel.org
X-Gm-Message-State: AOJu0YxbHaZKiwNA4KgJPjhwi7qfxwx4CnEcNgrxH+QaWhyieZz9Gqv6
	l7IMNkRJp9xlnAvRRm04VSvFfQos5G3TeJvR1seqAnSPOY4coRtOlWctqxPuPaaFjQjprkQPnW2
	RHO7TA+6WWK5cCZazBJq+Z5lGe/nIhxNImK1G/kHazZ2vILO4ZVkjaArMghKkvQ==
X-Gm-Gg: AY/fxX5ebh9llkqjY5fa+vzUgd3AfCQYiav/x6llFFALgx2CtDu21pOXcSTtX0FrNAq
	n4Xu4Q93cSecyndUDpIz6JS9cytzND2HNo7pLsBhqxc+iSh7T5u2FgjF+9C0xWTmgXFUmNmPdpz
	CoQrDD6Lm98TYNnO5IMJZ7GK9wzqTurMMDGawofL2+IyzrP78mZ8TzNvors2WpG3PzKoyJ8wIXo
	8pUSkOJYS3Y1vyjamYvW0mkgTKIonkJwBarXfTyMgfiVMmrzgeI1Y8MFk8zIbu2QPjtEI101YVn
	vaaIHUezl/6++mUAQT73Blrrqozu+LU4B6kGa266AgLTKqealZUDq4xg7bDiedIlOmKDYK0lSMz
	p+ZIkm5GzrRhZxdQMxFHcEpGIhw==
X-Received: by 2002:a05:622a:7281:b0:4ec:f26f:5aea with SMTP id d75a77b69052e-4f4d61f8db9mr341684521cf.68.1767358156793;
        Fri, 02 Jan 2026 04:49:16 -0800 (PST)
X-Google-Smtp-Source: AGHT+IHGIwY87IupOkUJnm29pNdOn/G+t5O+RHiMq3Y4H7KIvOiXIC0vX/TZ4R84yFP+bxQMHhpEog==
X-Received: by 2002:a05:622a:7281:b0:4ec:f26f:5aea with SMTP id d75a77b69052e-4f4d61f8db9mr341684311cf.68.1767358156376;
        Fri, 02 Jan 2026 04:49:16 -0800 (PST)
Received: from quoll ([178.197.218.229])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-47be2724fe8sm940572215e9.1.2026.01.02.04.49.15
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 02 Jan 2026 04:49:15 -0800 (PST)
From: Krzysztof Kozlowski <krzysztof.kozlowski@oss.qualcomm.com>
To: Viresh Kumar <vireshk@kernel.org>, Nishanth Menon <nm@ti.com>,
        Stephen Boyd <sboyd@kernel.org>, linux-pm@vger.kernel.org,
        linux-kernel@vger.kernel.org
Cc: Krzysztof Kozlowski <krzysztof.kozlowski@oss.qualcomm.com>
Subject: [PATCH] OPP: of: Simplify with scoped for each OF child loop
Date: Fri,  2 Jan 2026 13:49:14 +0100
Message-ID: <20260102124913.64606-2-krzysztof.kozlowski@oss.qualcomm.com>
X-Mailer: git-send-email 2.51.0
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=1271; i=krzysztof.kozlowski@oss.qualcomm.com;
 h=from:subject; bh=CByj1rkU5zEzBBBrW/OJ2X8lHA6LjYMZv9EsVJP4P54=;
 b=owEBbQKS/ZANAwAKAcE3ZuaGi4PXAcsmYgBpV77Jh2qVoa6dTATQgNwXwLaAIvpNeYQiNxdcO
 3i5CR+yyZOJAjMEAAEKAB0WIQTd0mIoPREbIztuuKjBN2bmhouD1wUCaVe+yQAKCRDBN2bmhouD
 12z2D/46rfaX4B8ofTGuLrPRfA8kQLdw19q4V3ivAZqGvoOAP/RvHynqzJNfQpdbDME/rCdZ701
 VA/NviNVZc2mWieOgGBNVrOjlpkDHE221+E2FPRWufJUPWRfKkVdVhM+XTLhGP00YEK07k6HjRq
 jP8m0Co9d5CasNa8ZabEbKoRp2D9GiQQwtMDRoJiyhsnTmRgKRTyXYmMA2oC5Nea+J9Ol1rdmt7
 epdUpwR8RZj3mi2qeIRyXOEMA7HXS5gpL9obRUBqxOJZdmliz36zRzGTosAPJik28uIfX33w+CM
 f65NFi22Z4EvVywndW9Oy75ACoPL33pZY29kzYQhbAJQTf27t7i8aopjblwGyIV80l3n17wW3Ko
 8C92Q2xfLxMybZvt697x+1vv++YN2zP0vnTwnqaE915ufsqOM5xAHWI27eWA4iPX5Pzkqoqj/9+
 yompiReN9rQQUagUtTccH8uZKSykPxeSi6HhqUTcEtpEbLuu+euO4fGmvXpnCTfNJMapc+UQfL8
 3mY+7QNny33KajYyvyJQJQTTTVJT/UfTWgoRev4aY7nGgSX4g6GmtE+6yAjrakd1nXgPhNJaWqo
 qtMlJRN6kTZMz4HtXnDYwu8xGTUQMkwDZH8xNE1eFgEHBjtIQk6RpZjxQc/AKNdgKxCbsaFXss/ M+DruYgspBmZkOA==
X-Developer-Key: i=krzysztof.kozlowski@oss.qualcomm.com; a=openpgp; fpr=9BD07E0E0C51F8D59677B7541B93437D3B41629B
Content-Transfer-Encoding: 8bit
X-Authority-Analysis: v=2.4 cv=Av7jHe9P c=1 sm=1 tr=0 ts=6957becd cx=c_pps
 a=EVbN6Ke/fEF3bsl7X48z0g==:117 a=Eb9f15NH/cHKzfGOmZSO4Q==:17
 a=vUbySO9Y5rIA:10 a=s4-Qcg_JpJYA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=EUspDBNiAAAA:8 a=kVq6N5mEIK0mURhpU1kA:9 a=a_PwQJl-kcHnX1M80qC6:22
X-Proofpoint-ORIG-GUID: WC3GewCjCAJvNxkXP4e_PQO1w9bF3CPr
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwMTAyMDExMyBTYWx0ZWRfXwM7GKntI2d3B
 RnfDQF79ZDgPyaAjSqALvJM9I1xj9JvcqKMgFajwGJr+2h2WQPx7co9GMwrw+5kFCZkad6dbm+m
 rXyhhlx1q2No/7GlE43qgYgDbdMjlSq3UEF4TtrJYjrTL8d6BY76CguRub1lOaHm4vBfsKR+2YC
 rbRp+JsyruOjBIrod0m/tLfAlZ3K85mOQhYMqkE3Y1L7j99j/gL7lcTTVzoUrLEA0/40Zi45UzV
 NPjIi5k/u7cCT39PpzeU1qS0Q2VB0IMv7cILH7o/XxZKLTMEGs8GI/LM66+Dcm94KA/lPttVhsZ
 cV9Mm+CphIbe7X9dU2HVIR4fXdzFSy6e1Tcbs5xDkTflJLoAA+zduP01iG0NZxy+x7l0k9Rmyg6
 RhFRcxdSNcd8/4MXmFg6zQdjcma7sdUioIWaZacFFRlSb+8280NaOAszZ0KUzM2JcPhPNnd50BI
 zfoyHVmZXVxITEkhSng==
X-Proofpoint-GUID: WC3GewCjCAJvNxkXP4e_PQO1w9bF3CPr
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.9,FMLib:17.12.100.49
 definitions=2026-01-02_01,2025-12-31_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 malwarescore=0 clxscore=1015 phishscore=0 priorityscore=1501 suspectscore=0
 lowpriorityscore=0 impostorscore=0 bulkscore=0 spamscore=0 adultscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2512120000 definitions=main-2601020113

Use scoped for-each loop when iterating over device nodes to make code a
bit simpler.

Signed-off-by: Krzysztof Kozlowski <krzysztof.kozlowski@oss.qualcomm.com>
---
 drivers/opp/of.c | 4 +---
 1 file changed, 1 insertion(+), 3 deletions(-)

diff --git a/drivers/opp/of.c b/drivers/opp/of.c
index 1e0d0adb18e1..a268c2b250c0 100644
--- a/drivers/opp/of.c
+++ b/drivers/opp/of.c
@@ -956,7 +956,6 @@ static struct dev_pm_opp *_opp_add_static_v2(struct opp_table *opp_table,
 /* Initializes OPP tables based on new bindings */
 static int _of_add_opp_table_v2(struct device *dev, struct opp_table *opp_table)
 {
-	struct device_node *np;
 	int ret, count = 0;
 	struct dev_pm_opp *opp;
 
@@ -971,13 +970,12 @@ static int _of_add_opp_table_v2(struct device *dev, struct opp_table *opp_table)
 	}
 
 	/* We have opp-table node now, iterate over it and add OPPs */
-	for_each_available_child_of_node(opp_table->np, np) {
+	for_each_available_child_of_node_scoped(opp_table->np, np) {
 		opp = _opp_add_static_v2(opp_table, dev, np);
 		if (IS_ERR(opp)) {
 			ret = PTR_ERR(opp);
 			dev_err(dev, "%s: Failed to add OPP, %d\n", __func__,
 				ret);
-			of_node_put(np);
 			goto remove_static_opp;
 		} else if (opp) {
 			count++;
-- 
2.51.0


