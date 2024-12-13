Return-Path: <linux-pm+bounces-19168-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 693239F02BC
	for <lists+linux-pm@lfdr.de>; Fri, 13 Dec 2024 03:38:50 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 7AF3E16A59E
	for <lists+linux-pm@lfdr.de>; Fri, 13 Dec 2024 02:38:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6F2C2143722;
	Fri, 13 Dec 2024 02:38:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=analog.com header.i=@analog.com header.b="0cb4KMrj"
X-Original-To: linux-pm@vger.kernel.org
Received: from mx0b-00128a01.pphosted.com (mx0a-00128a01.pphosted.com [148.163.135.77])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9B90A136327;
	Fri, 13 Dec 2024 02:38:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.135.77
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734057512; cv=none; b=mEDu+17jmZT7JwEJYXnV6vtHA0dyaHIImkSTr79j9iUcJbqaWv20Dz5AGYmQSmkHUJow9pupaGrhNV4C+ANmHl3ECsQgMFDdATjadjYVeVYL17cnTcBQhZeL6UD6TX40qV+7qnctrhh8qBSbYfPiOxtty8rTRk70fOOtAMs+6lg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734057512; c=relaxed/simple;
	bh=qRfNHr9Bz/rWaXCWHJtTl7H23dvMSdOgoYzIMh01orA=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=LIGWnZywYdbIvBtJe8aCFebrFICAqQQpwuGkv8y8Jck0oxgYCUx4D2y7TKvwrNCiWWgC3fPcxUj7rle58LQXhLTxUSVpEbOwUKOJMNUz9AmqhqVCiTy2wUgVgid9MLO9yHZag8qfqYCjY9KEown2+um5+lB1Ttpgo5b2b8ipyyc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=analog.com; spf=pass smtp.mailfrom=analog.com; dkim=pass (2048-bit key) header.d=analog.com header.i=@analog.com header.b=0cb4KMrj; arc=none smtp.client-ip=148.163.135.77
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=analog.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=analog.com
Received: from pps.filterd (m0375855.ppops.net [127.0.0.1])
	by mx0b-00128a01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 4BD0XtXq022176;
	Thu, 12 Dec 2024 21:38:12 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=analog.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=DKIM; bh=ZtUBh
	Q4tT6mmSjaBmqLtT7svgseEfCyA694dOGtPR1g=; b=0cb4KMrjcOlVEiTVO1nZk
	KV3GcuNMslq1+g0piqtqQKSyY2TATLHzapFez/uCnNXIi+KUcubERnl5BVcz6HSc
	MwWzCUGY0pYCZ+1O1ITqHY8fvEDGaNElsLei1GSBVAouuyt5RBliRRvrugpeBuvz
	x5ZFoRyC6SCOoDwxSU6A+LJI0oGtLpEPM1bXygqcq9a+uXClgtfam3GDnIvK039s
	AswlorLp1F4Yw8afY1CLkLMeliAjHa97/I+JLhvMw2TQfqZa7WMYcfdelP7bI2Ns
	enjcxkAa8OS4FlHoEGTxCuZtVBJ/HxZGeOQ9bvcQpsc9sKH554xks5oONHENWDYv
	g==
Received: from nwd2mta3.analog.com ([137.71.173.56])
	by mx0b-00128a01.pphosted.com (PPS) with ESMTPS id 43gagc0g0e-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 12 Dec 2024 21:38:12 -0500 (EST)
Received: from ASHBMBX8.ad.analog.com (ASHBMBX8.ad.analog.com [10.64.17.5])
	by nwd2mta3.analog.com (8.14.7/8.14.7) with ESMTP id 4BD2c91h024824
	(version=TLSv1/SSLv3 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=FAIL);
	Thu, 12 Dec 2024 21:38:09 -0500
Received: from ASHBCASHYB5.ad.analog.com (10.64.17.133) by
 ASHBMBX8.ad.analog.com (10.64.17.5) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.986.14; Thu, 12 Dec 2024 21:38:09 -0500
Received: from ASHBMBX9.ad.analog.com (10.64.17.10) by
 ASHBCASHYB5.ad.analog.com (10.64.17.133) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.986.14; Thu, 12 Dec 2024 21:38:09 -0500
Received: from zeus.spd.analog.com (10.66.68.11) by ashbmbx9.ad.analog.com
 (10.64.17.10) with Microsoft SMTP Server id 15.2.986.14 via Frontend
 Transport; Thu, 12 Dec 2024 21:38:09 -0500
Received: from kim-VirtualBox.ad.analog.com (KPALLER2-L03.ad.analog.com [10.117.223.26])
	by zeus.spd.analog.com (8.15.1/8.15.1) with ESMTP id 4BD2bsXs028303;
	Thu, 12 Dec 2024 21:38:01 -0500
From: Kim Seer Paller <kimseer.paller@analog.com>
To: Sebastian Reichel <sre@kernel.org>, Rob Herring <robh@kernel.org>,
        Krzysztof Kozlowski <krzk+dt@kernel.org>,
        Conor Dooley <conor+dt@kernel.org>,
        Mike Looijmans <mike.looijmans@topic.nl>
CC: <linux-pm@vger.kernel.org>, <devicetree@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>,
        Kim Seer Paller <kimseer.paller@analog.com>,
        Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Subject: [PATCH v6 1/2] dt-bindings: power/supply: Add ltc4162-f/s and ltc4015
Date: Fri, 13 Dec 2024 10:37:45 +0800
Message-ID: <20241213023746.34168-2-kimseer.paller@analog.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20241213023746.34168-1-kimseer.paller@analog.com>
References: <20241213023746.34168-1-kimseer.paller@analog.com>
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ADIRuleOP-NewSCL: Rule Triggered
X-Proofpoint-GUID: DqeUlJoOTRCVSiTujGWGaYVI5Y98ZsTJ
X-Proofpoint-ORIG-GUID: DqeUlJoOTRCVSiTujGWGaYVI5Y98ZsTJ
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1039,Hydra:6.0.680,FMLib:17.12.60.29
 definitions=2024-09-06_09,2024-09-06_01,2024-09-02_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 clxscore=1015 spamscore=0
 bulkscore=0 phishscore=0 lowpriorityscore=0 adultscore=0 mlxlogscore=999
 impostorscore=0 mlxscore=0 suspectscore=0 malwarescore=0
 priorityscore=1501 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2411120000 definitions=main-2412130019

Add LTC4162-F/S and LTC4015 to the supported devices of LTC4162-L.
They share a common set of registers. The only differences lie in the
resolution value of the scaling factor for battery voltage and battery
current measurement, input voltage, and input current for different
battery chemistries. The differences also include the calculation of
setting and getting the actual voltage applied to the charge voltage,
as well as getting the die temperature.

This add compatible entries for ltc4162-f/s and ltc4015 and include
datasheets for new devices.

Acked-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Signed-off-by: Kim Seer Paller <kimseer.paller@analog.com>
---
 .../devicetree/bindings/power/supply/ltc4162-l.yaml         | 6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/Documentation/devicetree/bindings/power/supply/ltc4162-l.yaml b/Documentation/devicetree/bindings/power/supply/ltc4162-l.yaml
index 29d536541152..06595a953659 100644
--- a/Documentation/devicetree/bindings/power/supply/ltc4162-l.yaml
+++ b/Documentation/devicetree/bindings/power/supply/ltc4162-l.yaml
@@ -17,12 +17,18 @@ description: |
   panels, etc., and a rechargeable Lithium-Ion/Polymer battery.
 
   Specifications about the charger can be found at:
+    https://www.analog.com/en/products/ltc4162-l.html
+    https://www.analog.com/en/products/ltc4162-f.html
     https://www.analog.com/en/products/ltc4162-s.html
+    https://www.analog.com/en/products/ltc4015.html
 
 properties:
   compatible:
     enum:
+      - lltc,ltc4015
+      - lltc,ltc4162-f
       - lltc,ltc4162-l
+      - lltc,ltc4162-s
 
   reg:
     maxItems: 1
-- 
2.34.1


