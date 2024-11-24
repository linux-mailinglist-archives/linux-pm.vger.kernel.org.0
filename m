Return-Path: <linux-pm+bounces-17996-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id E4B689D6CBB
	for <lists+linux-pm@lfdr.de>; Sun, 24 Nov 2024 06:37:38 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id C168CB21294
	for <lists+linux-pm@lfdr.de>; Sun, 24 Nov 2024 05:37:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3511C154444;
	Sun, 24 Nov 2024 05:37:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=analog.com header.i=@analog.com header.b="QI5lVmwD"
X-Original-To: linux-pm@vger.kernel.org
Received: from mx0a-00128a01.pphosted.com (mx0a-00128a01.pphosted.com [148.163.135.77])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 854911E4B0;
	Sun, 24 Nov 2024 05:37:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.135.77
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732426645; cv=none; b=UajtY0onbYHNys8F3zmjeBPFEh8PqE6s8gIoDLZ5c6GSvBoV5WjgdYzKYcnfi1u6jZZO/+Mfu8UY3Nlvj/rVzE0/RzDAu7UfqwsQuDH1w3ZPnmoqMjZ0yPAeIpevPpCwbt/siKbNMOWBeT2Ip22crKR+jDnXgiGz/FzzYxSeFbo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732426645; c=relaxed/simple;
	bh=1YKomkwpiGBc6nPaALBtYBaLKIfZ16oaAsPuwY4HVj8=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=VHQsw32BXUvWdZVe3Gh5lLTKb4GgyXloQGdRSs7u1qowRQWDHKY7KBjvag9e/0cZ4vX0+YyY64WkVTROwJQ/h0fuLR/P70Zx7s822MqdU8MKJBE5BrUqyqjfQNhLyT+0M+t+VBt5tILK+Ch/nXvf/u6TQ3aQG92/0bhHRFOUOf4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=analog.com; spf=pass smtp.mailfrom=analog.com; dkim=pass (2048-bit key) header.d=analog.com header.i=@analog.com header.b=QI5lVmwD; arc=none smtp.client-ip=148.163.135.77
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=analog.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=analog.com
Received: from pps.filterd (m0167088.ppops.net [127.0.0.1])
	by mx0a-00128a01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 4AO1HfBk010650;
	Sun, 24 Nov 2024 00:37:05 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=analog.com; h=cc
	:content-transfer-encoding:content-type:date:from:message-id
	:mime-version:subject:to; s=DKIM; bh=vd5pBbWV0IlQckYFHPr/nEm+WGg
	2x3xfrkbt5dOGoX4=; b=QI5lVmwD4zhCy0wkD23NKxmU6uyPnoMr2xBa5nsro5s
	sdngwReMgV4bZTdX2gBgrQpskAwWWipme/ZWTuttc6qFYIL2dv+Gh0BhxwjhhmxX
	GBkoo1TRztgnQh3h0CHqUQImeJwges6ZL6KRS+6ITwXlHC0Ya+wfk8RgcjUPdLpC
	mBd/QD9VohgjvtB66wkcBsoNhua64wfFfUCtYn/iXmAn7rkw5eu1yD2Kn+vSW38F
	UzMHkW/7N4uJk3C3S2J4EBfBLep4rMiOpwZkTmyHu1RuEqcEV2xmEDMXmVZhEVWN
	9GN0GBV4dn2Z/04vC1IPsJvnr16Hubpr3853MGSpftA==
Received: from nwd2mta3.analog.com ([137.71.173.56])
	by mx0a-00128a01.pphosted.com (PPS) with ESMTPS id 4339s73k0r-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Sun, 24 Nov 2024 00:37:04 -0500 (EST)
Received: from ASHBMBX8.ad.analog.com (ASHBMBX8.ad.analog.com [10.64.17.5])
	by nwd2mta3.analog.com (8.14.7/8.14.7) with ESMTP id 4AO5b37c034174
	(version=TLSv1/SSLv3 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=FAIL);
	Sun, 24 Nov 2024 00:37:03 -0500
Received: from ASHBCASHYB5.ad.analog.com (10.64.17.133) by
 ASHBMBX8.ad.analog.com (10.64.17.5) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.986.14; Sun, 24 Nov 2024 00:37:03 -0500
Received: from ASHBMBX8.ad.analog.com (10.64.17.5) by
 ASHBCASHYB5.ad.analog.com (10.64.17.133) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.986.14; Sun, 24 Nov 2024 00:37:02 -0500
Received: from zeus.spd.analog.com (10.66.68.11) by ashbmbx8.ad.analog.com
 (10.64.17.5) with Microsoft SMTP Server id 15.2.986.14 via Frontend
 Transport; Sun, 24 Nov 2024 00:37:02 -0500
Received: from kim-VirtualBox.ad.analog.com (KPALLER2-L03.ad.analog.com [10.116.18.26])
	by zeus.spd.analog.com (8.15.1/8.15.1) with ESMTP id 4AO5aocn007246;
	Sun, 24 Nov 2024 00:36:53 -0500
From: Kim Seer Paller <kimseer.paller@analog.com>
To: Sebastian Reichel <sre@kernel.org>, Rob Herring <robh@kernel.org>,
        Krzysztof Kozlowski <krzk+dt@kernel.org>,
        Conor Dooley <conor+dt@kernel.org>,
        Mike Looijmans <mike.looijmans@topic.nl>
CC: <linux-pm@vger.kernel.org>, <devicetree@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>,
        Kim Seer Paller <kimseer.paller@analog.com>
Subject: [PATCH v4 1/2] dt-bindings: power/supply: Add ltc4162-f/s and ltc4015
Date: Sun, 24 Nov 2024 13:36:42 +0800
Message-ID: <20241124053643.6602-1-kimseer.paller@analog.com>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ADIRuleOP-NewSCL: Rule Triggered
X-Proofpoint-ORIG-GUID: tCCuzsA38qw8QWaeNypptHAmNgofiKhf
X-Proofpoint-GUID: tCCuzsA38qw8QWaeNypptHAmNgofiKhf
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1039,Hydra:6.0.680,FMLib:17.12.60.29
 definitions=2024-09-06_09,2024-09-06_01,2024-09-02_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 phishscore=0 spamscore=0
 impostorscore=0 lowpriorityscore=0 malwarescore=0 mlxlogscore=999
 mlxscore=0 bulkscore=0 adultscore=0 priorityscore=1501 suspectscore=0
 clxscore=1015 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2409260000 definitions=main-2411240045

Add LTC4162-F/S and LTC4015 to the supported devices of LTC4162-L.
They share a common set of registers. The only differences lie in the
resolution value of the scaling factor for battery voltage and battery
current measurement, input voltage, and input current for different
battery chemistries. The differences also include the calculation of
setting and getting the actual voltage applied to the charge voltage,
as well as getting the die temperature.

This add compatible entries for ltc4162-f/s and ltc4015 and include
datasheets for new devices.

Signed-off-by: Kim Seer Paller <kimseer.paller@analog.com>
---
V3 -> V4: Arranged the compatible entries in alphabetical order.
V2 -> V3: Described differences in the programming model between variants/devices.
V1 -> V2: Modified commit message describing differences between
          variants/devices.

 .../devicetree/bindings/power/supply/ltc4162-l.yaml         | 6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/Documentation/devicetree/bindings/power/supply/ltc4162-l.yaml b/Documentation/devicetree/bindings/power/supply/ltc4162-l.yaml
index 29d536541..06595a953 100644
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

base-commit: 05d9044177c3e910921522e0209640d3b825a6ae
-- 
2.34.1


