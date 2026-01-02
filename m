Return-Path: <linux-pm+bounces-40129-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 70AD8CEE9D3
	for <lists+linux-pm@lfdr.de>; Fri, 02 Jan 2026 14:01:15 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id E00B13063809
	for <lists+linux-pm@lfdr.de>; Fri,  2 Jan 2026 12:57:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8C9EF313290;
	Fri,  2 Jan 2026 12:48:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="Gbq2/yGx";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="JE0Uu3yf"
X-Original-To: linux-pm@vger.kernel.org
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0F2653112D5
	for <linux-pm@vger.kernel.org>; Fri,  2 Jan 2026 12:48:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1767358127; cv=none; b=FdtxaZAU0S/pKYM3R0LXe4sHvqJuL4SKYU6sZ1+8UqCZIdiI6hn2WFeGkrglglaR7SWy7LLvFce+fXq72EPZBgwfV40nHEY67x0X5ePQqlbp/o7kKPRlKKkd7euZyN9mb4S0sDN/ZrYjoKTH/Q78fynv4LH9/bE0/3sgkEe5MnI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1767358127; c=relaxed/simple;
	bh=OcIwlu3RbDzj4APk+zQqEeDgPBcykjsRQep6QGMTQ8Q=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=nj44Oogi92w94hGQI1f7dy4bBxXFYtUuQX+8WfYac8DHSl7L/QHsuDF+x/ftVFLm/iM451VVP+M1vz5e7IaQNOg9Hl3weF6M8nmDRcPsJxdJPMoWnPVH8YUWv/9gE9/GcYdq48KSbLOwCfLFogs2wcEeWaytiN6B/vWWv32/IRM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=Gbq2/yGx; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=JE0Uu3yf; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279862.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 6029WFde824652
	for <linux-pm@vger.kernel.org>; Fri, 2 Jan 2026 12:48:45 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:date:from:message-id:mime-version
	:subject:to; s=qcppdkim1; bh=BUpoZ+T7vDuEG/zi9mTKqt429b9xs4793EN
	UoDPiZsQ=; b=Gbq2/yGxcJnzNtOCF+g/chY2PsBMvMQE6iLdlI1gxLGkfXxwmhZ
	tBGk0QHkfM9gsZ5/4cxUIeAhcLbeiSBS43V898bUs3qFg/5NvE2U3yUZeAyb7ZN7
	MHwbLsZThpLeiW//QnaSmoQQ+gLjkQ7cfMkc6oHCpMQpL966gv2OS5ETtGYatpSP
	FfEQS0NxzoShA9QtSdjeNLd8SvluGU+F1lqxiHzJSvV/pAKWzdnSKLcL+eXvmMeq
	e0rXx19FLFX75Usi0dj3QHYbEG+FML7ZZfTXhEHBAJWzimgd6cInGlgOHh2hwbJ9
	Onrp0dVUxEiz1AnqHXTp5eGvlyZcylgZYkA==
Received: from mail-qt1-f198.google.com (mail-qt1-f198.google.com [209.85.160.198])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4bd8533bva-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-pm@vger.kernel.org>; Fri, 02 Jan 2026 12:48:45 +0000 (GMT)
Received: by mail-qt1-f198.google.com with SMTP id d75a77b69052e-4f1b39d7ed2so265692741cf.2
        for <linux-pm@vger.kernel.org>; Fri, 02 Jan 2026 04:48:45 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1767358124; x=1767962924; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=BUpoZ+T7vDuEG/zi9mTKqt429b9xs4793ENUoDPiZsQ=;
        b=JE0Uu3yfri4KMSstzASngQBvp5BqTm3vJmUEcyDeBVPjiU3AH1Lrsgmocmp51vHdQm
         ELs1RcsbH3y3hFuzF/1OPkXONwlQajYpyBJ2yS7qpMxSiSiAQqAu9MKO75grC+PEVgRB
         ih0K+Bc6c77l8qa2Z2MmZo9k9d4L6LUr1p7iv0C1vGsmfcxBfUmDhiSjK++vL21dHBi3
         bDJR4ZqZrKuu5fUv/QkPXjRzc7wOo8pC5KmvnrgTXkrVDaFa3sGhFMZ5hknh1dSM6888
         tDr6I6EpCrWclbrff3spnk/zKUzF7/o5HwBnHch2ItBc8I6lw2xQcvN/fBW6I3nDQf1E
         +Gvw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1767358124; x=1767962924;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=BUpoZ+T7vDuEG/zi9mTKqt429b9xs4793ENUoDPiZsQ=;
        b=wanjN8kdoL0G9RZZMWRRXkVRKj+Ubjc0QffRbQZVN1gpKf55+KSQiIy5p6UurdK8JF
         rt0Y33+azhTachQHbZyNj3o8uWVD7JKCXpAOw87t6ClhcCzZWD4FdB4GWDZ0V3p9BZQh
         7ZutikYRAF1DXHvEO29lwS3hOh0hGlza2fEAleeZgREOWCkUJR0lPVq1z6G5kHYK0DkL
         OlwmQuDfeGSbgoBXiQSA1sTiUx6bkqxmcEvA5ijlk6DrJ+GfTAFaRL6t4XKhoPD76yxw
         RxD6vDT+ipGnapDabvsav02CXiHCPdmv/6qxeS8quaKX2QiRYe+heo6bVKZfUeVtQm4y
         yyRQ==
X-Forwarded-Encrypted: i=1; AJvYcCVRN1aDvNQ7Otlk62dMdQsrxovWhu+sH7Rj1RXoNJKdtHoRhf1iLim/5kSq8bBxY5zlXv+wMR4u/w==@vger.kernel.org
X-Gm-Message-State: AOJu0YyJ0WMVdHEbGrFe5CKWdmwsq/WX71dVB/OtL+osOsjdI7a+cQGv
	jQacn001igxnxYJHBR6DbJcRp8419VpuRYXZXFWXEpRh2AIFboFqINcTcVYV1KlEesRL0qeZV2V
	vQlTIbDSBKcX9MAmZFeJCFJ8D2EJKvPr6ZINxU+vzgoH++01pUe7yvYPrFD/ThQ==
X-Gm-Gg: AY/fxX4mpvnZW2BjSwy/HRXVZmsyso461FGHBuMLAUSbLG9QnaKWW1ExEpTK02XS6o/
	87GJ+t4K2OBedfRv3I5p69mJCaB/HEGzEbfA9K7mspmmfLKLNaKwxoH4ivw//aZxhfSaEiPqTyo
	INmMN/RvSI/ZSzQ2zlCUbgXUmfcH9WqlEymh3EsRwaKC15C4lRuzqbNQH1yb/Fc/YpQdwULMiyk
	1Ma7QzYl0IV+IRZRqrSIPKnDBs7M7t9qlhldX1+g3St7eQIniRMmlKLH8eySerQmNKJEdfz4iKZ
	T7oMrPbNJaaI4nS7xzMzsMkwssdlPnrAgRsH6Dhpm06oooEvSzcFQPHWH3rrj16CeckObOFZzzO
	13ys5mFMhTFuOw9NitLVVk65vwQ==
X-Received: by 2002:ac8:758f:0:b0:4f4:de66:5901 with SMTP id d75a77b69052e-4f4de665a8emr387649901cf.5.1767358124447;
        Fri, 02 Jan 2026 04:48:44 -0800 (PST)
X-Google-Smtp-Source: AGHT+IEgYCvGqiuv6UXoD9T46glKCVF4tcH0dvAXXUkL6iY+OU9BbPdW5meF8oWRi7nxOWejP/gtng==
X-Received: by 2002:ac8:758f:0:b0:4f4:de66:5901 with SMTP id d75a77b69052e-4f4de665a8emr387649731cf.5.1767358124097;
        Fri, 02 Jan 2026 04:48:44 -0800 (PST)
Received: from quoll ([178.197.218.229])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-47be3aac6d9sm328265755e9.4.2026.01.02.04.48.43
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 02 Jan 2026 04:48:43 -0800 (PST)
From: Krzysztof Kozlowski <krzysztof.kozlowski@oss.qualcomm.com>
To: Ulf Hansson <ulf.hansson@linaro.org>,
        Matthias Brugger <matthias.bgg@gmail.com>,
        AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>,
        linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org,
        linux-mediatek@lists.infradead.org
Cc: Krzysztof Kozlowski <krzysztof.kozlowski@oss.qualcomm.com>
Subject: [PATCH] pmdomain: mediatek: Simplify with scoped for each OF child loop
Date: Fri,  2 Jan 2026 13:48:41 +0100
Message-ID: <20260102124840.64424-2-krzysztof.kozlowski@oss.qualcomm.com>
X-Mailer: git-send-email 2.51.0
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=1420; i=krzysztof.kozlowski@oss.qualcomm.com;
 h=from:subject; bh=OcIwlu3RbDzj4APk+zQqEeDgPBcykjsRQep6QGMTQ8Q=;
 b=owEBbQKS/ZANAwAKAcE3ZuaGi4PXAcsmYgBpV76oDAEMOGl9Z/fKeLxpkVZ7CyPuujcbJEqlX
 ymFmzy20JqJAjMEAAEKAB0WIQTd0mIoPREbIztuuKjBN2bmhouD1wUCaVe+qAAKCRDBN2bmhouD
 1yxyD/9wFzZRH+PYMR3wZFgaITMzhBAmjzbA/ynFwhrMvt/NU7/qwQz6iwrk+/tRwdWPtY4K3Ij
 Kgm6rBv7McPdYuZpzXmS4agwDTGSK1rMkkP7NToFQ2Noui6JMuX/rXZRgbee8YTWgbEVCQhNTDg
 bEaT5xFT16UNOuY1XVa5DcJmkfVXPcv+iuaxiSmnD7jKBeLhf6pH7tDDNoQkhmfqB+w5etusJda
 U5nlRktyIIbkT4raJpH9K0JXfdh1NHDiIhW6YvXcfzeS7v9Vsk6zPsWSlNcKKeIAs176+THWw00
 0PdVa1vdAcT4UsIfJNCbmyhIXOQyX0lpi+8a1R8v1ZyRIQlCIbxeUv7/T5+Go8/cEvT4ejrm368
 A1V2RnEwqw+P7B4yt9CuLXT28FP+eSXY8iFE7CcBCi7FWbAvZ1hOkVi6JZTx5nlneZC2+n/g6L8
 YLTc+E/p64pnCtbJUQRzcP0n1zQ5DMBKcmk7B9ygrab4A9UnGTZ0OWlLDzFfdKoS9WDapn04tvL
 nA071AAeFHm+FlYce2Waql1OsLt4D0BcdCNxQfpxeY7YK4vWQGqY6JXvKphbylfoN6UNS9loctk
 TyW24FMX7hsA8xnsejPkYlnwywBcmlj6AYo0NYYeq3qcTw943UdsqtI3FkbY4qaZ8KzUeUc8o38 KtOFgun2wv/jFnQ==
X-Developer-Key: i=krzysztof.kozlowski@oss.qualcomm.com; a=openpgp; fpr=9BD07E0E0C51F8D59677B7541B93437D3B41629B
Content-Transfer-Encoding: 8bit
X-Proofpoint-GUID: 3AbPtVxQrw29C81hk-6mJYmpOTQ9ygHM
X-Authority-Analysis: v=2.4 cv=fL80HJae c=1 sm=1 tr=0 ts=6957bead cx=c_pps
 a=mPf7EqFMSY9/WdsSgAYMbA==:117 a=Eb9f15NH/cHKzfGOmZSO4Q==:17
 a=vUbySO9Y5rIA:10 a=s4-Qcg_JpJYA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=EUspDBNiAAAA:8 a=2lWiiPulESlkJRycB4IA:9 a=dawVfQjAaf238kedN5IG:22
X-Proofpoint-ORIG-GUID: 3AbPtVxQrw29C81hk-6mJYmpOTQ9ygHM
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwMTAyMDExMyBTYWx0ZWRfX/5c6C+Kh4GUj
 bSYwd+UBqUwXgXJVsUpZzcjqnvcT8jgVZRzdolHOSXS0AKetzYxf4h2Yur0hJAGCnCchpTC+nZO
 /t0WXmuGBX8cWhlPtl40IBcOEybV76eH3aVEtDSvRSZOZrGzFjnfwoK3bUATo7xvgB1AUdrxfJH
 iT4z5/yPKi8FOqJxk9lZImwKRjDcEQ23M6x9UjDsswcvOkK3W9CwsRGZvnAcqdmSLV30nDOclp/
 L2mWDlp3T+P3x+jETrkqq/PV4HL92UjmXUrt8gq75/oJFZLTD5+k+0u6yzJOnT6hwkfNdKTUmk1
 kjTazwvdFUmfvTUybbAMwnLq3rHVR5wwnMkynqd9rZAz1NRqqyZB58gauboQfZ6Js6TtAhXrln5
 QL836JATh2QYGf8rN1nt3o6JgwUgck8AC8IsgNnY7KNMzGWi1LR39A5kLWly6BE6pui9Ts0wDS2
 iIOURsFe52xoQjBpKjA==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.9,FMLib:17.12.100.49
 definitions=2026-01-02_01,2025-12-31_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 clxscore=1015 malwarescore=0 lowpriorityscore=0 suspectscore=0
 priorityscore=1501 phishscore=0 spamscore=0 impostorscore=0 adultscore=0
 bulkscore=0 classifier=typeunknown authscore=0 authtc= authcc= route=outbound
 adjust=0 reason=mlx scancount=1 engine=8.22.0-2512120000
 definitions=main-2601020113

Use scoped for-each loop when iterating over device nodes to make code a
bit simpler.

Signed-off-by: Krzysztof Kozlowski <krzysztof.kozlowski@oss.qualcomm.com>
---
 drivers/pmdomain/mediatek/mtk-pm-domains.c | 8 ++------
 1 file changed, 2 insertions(+), 6 deletions(-)

diff --git a/drivers/pmdomain/mediatek/mtk-pm-domains.c b/drivers/pmdomain/mediatek/mtk-pm-domains.c
index 80561d27f2b2..ab2514c78c14 100644
--- a/drivers/pmdomain/mediatek/mtk-pm-domains.c
+++ b/drivers/pmdomain/mediatek/mtk-pm-domains.c
@@ -1191,7 +1191,6 @@ static int scpsys_probe(struct platform_device *pdev)
 	struct device *dev = &pdev->dev;
 	struct device_node *np = dev->of_node;
 	const struct scpsys_soc_data *soc;
-	struct device_node *node;
 	struct device *parent;
 	struct scpsys *scpsys;
 	int num_domains, ret;
@@ -1235,21 +1234,18 @@ static int scpsys_probe(struct platform_device *pdev)
 		return ret;
 
 	ret = -ENODEV;
-	for_each_available_child_of_node(np, node) {
+	for_each_available_child_of_node_scoped(np, node) {
 		struct generic_pm_domain *domain;
 
 		domain = scpsys_add_one_domain(scpsys, node);
 		if (IS_ERR(domain)) {
 			ret = PTR_ERR(domain);
-			of_node_put(node);
 			goto err_cleanup_domains;
 		}
 
 		ret = scpsys_add_subdomain(scpsys, node);
-		if (ret) {
-			of_node_put(node);
+		if (ret)
 			goto err_cleanup_domains;
-		}
 	}
 
 	if (ret) {
-- 
2.51.0


