Return-Path: <linux-pm+bounces-16516-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id F3C129B1CD6
	for <lists+linux-pm@lfdr.de>; Sun, 27 Oct 2024 10:37:20 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 4D8A1B2125B
	for <lists+linux-pm@lfdr.de>; Sun, 27 Oct 2024 09:37:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B400F126C17;
	Sun, 27 Oct 2024 09:37:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=analog.com header.i=@analog.com header.b="mYIJYr1y"
X-Original-To: linux-pm@vger.kernel.org
Received: from mx0a-00128a01.pphosted.com (mx0a-00128a01.pphosted.com [148.163.135.77])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AE4F07DA79;
	Sun, 27 Oct 2024 09:37:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.135.77
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730021830; cv=none; b=g37LmpnpO24Wc9aVeyPYEHS0++XSWt3tPpiD9KzaFUW0zTtgC5azzXzCqFbUSM4wEJufjPw0Ii1Sr8Ei48Kg0cddtP/yi30u/2LjXb839YM/zt0xxxHG4ozGl2U1kX+poLLXvFPkxOv0kC9SayD7fj9FMM/OtB3Rc0gCn3YNiC4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730021830; c=relaxed/simple;
	bh=+o+e0yc8z2cYvVr7ThWL/jjTXKKohxTY35SoOejb2tA=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=nEuYhQhIkbI6Yg+q641pk8UU30pE3lQwao5DgXbE+5R6TKn/MtcNVgywiBWqDCTP+brdFdkjYbQ7G8djMBIBgpvv2fSUFSkfaJ6nSHCxr1n+QJefkSMTCP7RUJ/M04Rek8U9lGVlud11asimlbSspQpcCtBkni4DyAg1Uy/4wUM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=analog.com; spf=pass smtp.mailfrom=analog.com; dkim=pass (2048-bit key) header.d=analog.com header.i=@analog.com header.b=mYIJYr1y; arc=none smtp.client-ip=148.163.135.77
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=analog.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=analog.com
Received: from pps.filterd (m0167088.ppops.net [127.0.0.1])
	by mx0a-00128a01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 49R43dxa027775;
	Sun, 27 Oct 2024 03:19:16 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=analog.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=DKIM; bh=f7XnJ
	LRudKUw+rCrfpYbgUrUwaQnQvaE21uxx+0aig0=; b=mYIJYr1y7vaW+eA5J8APk
	d6Jb9BrCEP5JMVXlRY5zegx4xIt8pQivDmIx82dncJIaIPljHJwBqb/NH+pH0B1h
	0pTjL0OdyClg5kOFnMrniPiuZIy7sTFJrcG/dhrDURzp8Pmh7267fnNCqr6ooz6K
	J7UcTQN9HD+eR5X+SpAV7bXA6L6Isqbxsj+GiHdiBY0tPUCv9FQvAD+K9r4h5GuI
	bzFhMK70jpeCQdO5buI6KGnlV2Ii7/kHLI9HynEl4ShBZTxZrFpFB8KS7Ur/97LP
	+ygOjDzafcz89E9kg9TpNSYcM/dWWrnhUOGTuI+BHFHxHpXR+xQZ5MZ1F4ZE/9VF
	A==
Received: from nwd2mta4.analog.com ([137.71.173.58])
	by mx0a-00128a01.pphosted.com (PPS) with ESMTPS id 42gt92ka19-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Sun, 27 Oct 2024 03:19:15 -0400 (EDT)
Received: from ASHBMBX9.ad.analog.com (ASHBMBX9.ad.analog.com [10.64.17.10])
	by nwd2mta4.analog.com (8.14.7/8.14.7) with ESMTP id 49R7JEuJ014722
	(version=TLSv1/SSLv3 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=FAIL);
	Sun, 27 Oct 2024 03:19:14 -0400
Received: from ASHBMBX9.ad.analog.com (10.64.17.10) by ASHBMBX9.ad.analog.com
 (10.64.17.10) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.14; Sun, 27 Oct
 2024 03:19:14 -0400
Received: from zeus.spd.analog.com (10.66.68.11) by ashbmbx9.ad.analog.com
 (10.64.17.10) with Microsoft SMTP Server id 15.2.986.14 via Frontend
 Transport; Sun, 27 Oct 2024 03:19:14 -0400
Received: from kim-VirtualBox.ad.analog.com (KPALLER2-L03.ad.analog.com [10.116.18.26])
	by zeus.spd.analog.com (8.15.1/8.15.1) with ESMTP id 49R7IxwL009789;
	Sun, 27 Oct 2024 03:19:07 -0400
From: Kim Seer Paller <kimseer.paller@analog.com>
To: <linux-pm@vger.kernel.org>, <devicetree@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>
CC: Sebastian Reichel <sre@kernel.org>, Rob Herring <robh@kernel.org>,
        Krzysztof Kozlowski <krzk+dt@kernel.org>,
        Conor Dooley <conor+dt@kernel.org>,
        Mike Looijmans <mike.looijmans@topic.nl>
Subject: [PATCH 1/2] dt-bindings: power/supply: Add ltc4162-f/s and ltc4015
Date: Sun, 27 Oct 2024 15:18:51 +0800
Message-ID: <20241027071852.56240-2-kimseer.paller@analog.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20241027071852.56240-1-kimseer.paller@analog.com>
References: <20241027071852.56240-1-kimseer.paller@analog.com>
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ADIRuleOP-NewSCL: Rule Triggered
X-Proofpoint-GUID: yp_7kNsaEm6WFwCMMaaDbT2wlHhj5tg9
X-Proofpoint-ORIG-GUID: yp_7kNsaEm6WFwCMMaaDbT2wlHhj5tg9
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1039,Hydra:6.0.680,FMLib:17.12.60.29
 definitions=2024-09-06_09,2024-09-06_01,2024-09-02_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 mlxscore=0 suspectscore=0
 phishscore=0 mlxlogscore=999 priorityscore=1501 clxscore=1015 adultscore=0
 bulkscore=0 impostorscore=0 malwarescore=0 lowpriorityscore=0 spamscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.19.0-2409260000
 definitions=main-2410270062

Add support for ltc4162-f/s and ltc4015

- Add compatible entries for ltc4162-f/s and ltc4015
- Include datasheets for new devices

Signed-off-by: Kim Seer Paller <kimseer.paller@analog.com>
---
 .../devicetree/bindings/power/supply/ltc4162-l.yaml         | 6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/Documentation/devicetree/bindings/power/supply/ltc4162-l.yaml b/Documentation/devicetree/bindings/power/supply/ltc4162-l.yaml
index 29d536541..9b546150d 100644
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
       - lltc,ltc4162-l
+      - lltc,ltc4162-f
+      - lltc,ltc4162-s
+      - lltc,ltc4015
 
   reg:
     maxItems: 1
-- 
2.34.1


