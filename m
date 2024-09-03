Return-Path: <linux-pm+bounces-13402-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 106A0969A30
	for <lists+linux-pm@lfdr.de>; Tue,  3 Sep 2024 12:31:13 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 83F26B22D30
	for <lists+linux-pm@lfdr.de>; Tue,  3 Sep 2024 10:31:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 776771C62D1;
	Tue,  3 Sep 2024 10:30:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b="JYtcVU6h"
X-Original-To: linux-pm@vger.kernel.org
Received: from fllv0016.ext.ti.com (fllv0016.ext.ti.com [198.47.19.142])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CA43619F404;
	Tue,  3 Sep 2024 10:30:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.47.19.142
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725359452; cv=none; b=vEeTwbSJuYhsqrnGfPm1Xaoda5PN8EdYLUIGajwEJJLRah01gpGYjODbmAcnBQnxNHzefslcX6S/Zuofiimp5YKhUybbjqzzWgI9TujejdAHuFgTa5Eypg2h2G3XlMX3dDHWEt6fV/ZPLHyFT9MIHBYC6bmXC+z1espA8G0kwsc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725359452; c=relaxed/simple;
	bh=04BRrrWr2ZJKTFcyOeUq09xeVMNJ9nb6AYlKDZHpPdc=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-ID:References:
	 In-Reply-To:To:CC; b=km59mYcC/YXcWIxZURXmeNN1yAn+m/oHRp0RGA22VtBTFmCjBCU82R3UOdmd+mNr97b6eY0TdB2FKfXBrDiw0pArgSgaNLgWObN2hPVuVTgVQlBfTf6lxietMiyj5hGkG7OCRYZA8iL4i6gOdnhSex4b8ADXhEUwhEIEjW17DKc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ti.com; spf=pass smtp.mailfrom=ti.com; dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b=JYtcVU6h; arc=none smtp.client-ip=198.47.19.142
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ti.com
Received: from lelv0265.itg.ti.com ([10.180.67.224])
	by fllv0016.ext.ti.com (8.15.2/8.15.2) with ESMTP id 483AUjdL044512;
	Tue, 3 Sep 2024 05:30:45 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
	s=ti-com-17Q1; t=1725359445;
	bh=e9a445VSklRmZ8kpkTA4CFnEaYQX8TT0dfBkdFG/Jq0=;
	h=From:Date:Subject:References:In-Reply-To:To:CC;
	b=JYtcVU6h7UHXaH9pX51LodNK+4nG4ZTxCmtSXkjbBA5jV69o61Sab1Tp2lGGWLpes
	 egEtVAq5NtMOUyOawsqpoXfccT1lU9QRSvEisfWOU95B5P0rKqKnYR5PeOIG+Dg2sV
	 3MQVGq6BcJWhhKiWsfifCDNq8WvFFRmi2hvSLAx0=
Received: from DLEE100.ent.ti.com (dlee100.ent.ti.com [157.170.170.30])
	by lelv0265.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 483AUjxx003285
	(version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
	Tue, 3 Sep 2024 05:30:45 -0500
Received: from DLEE115.ent.ti.com (157.170.170.26) by DLEE100.ent.ti.com
 (157.170.170.30) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23; Tue, 3
 Sep 2024 05:30:45 -0500
Received: from lelvsmtp6.itg.ti.com (10.180.75.249) by DLEE115.ent.ti.com
 (157.170.170.26) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23 via
 Frontend Transport; Tue, 3 Sep 2024 05:30:45 -0500
Received: from [127.0.1.1] (lcpd911.dhcp.ti.com [172.24.227.68])
	by lelvsmtp6.itg.ti.com (8.15.2/8.15.2) with ESMTP id 483AUb68012445;
	Tue, 3 Sep 2024 05:30:42 -0500
From: Dhruva Gole <d-gole@ti.com>
Date: Tue, 3 Sep 2024 16:00:07 +0530
Subject: [PATCH 1/2] dt-bindings: opp: operating-points-v2-ti-cpu: Describe
 opp-supported-hw
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-ID: <20240903-b4-opp-dt-binding-fix-v1-1-f7e186456d9f@ti.com>
References: <20240903-b4-opp-dt-binding-fix-v1-0-f7e186456d9f@ti.com>
In-Reply-To: <20240903-b4-opp-dt-binding-fix-v1-0-f7e186456d9f@ti.com>
To: Viresh Kumar <vireshk@kernel.org>, Nishanth Menon <nm@ti.com>,
        Stephen
 Boyd <sboyd@kernel.org>, Rob Herring <robh@kernel.org>,
        Krzysztof Kozlowski
	<krzk+dt@kernel.org>,
        Conor Dooley <conor+dt@kernel.org>
CC: Viresh Kumar <viresh.kumar@linaro.org>,
        Krzysztof Kozlowski
	<krzysztof.kozlowski@linaro.org>,
        Vignesh Raghavendra <vigneshr@ti.com>, <linux-pm@vger.kernel.org>,
        <devicetree@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        Dhruva Gole <d-gole@ti.com>
X-Mailer: b4 0.14.1
X-Developer-Signature: v=1; a=ed25519-sha256; t=1725359437; l=1302;
 i=d-gole@ti.com; s=20240902; h=from:subject:message-id;
 bh=04BRrrWr2ZJKTFcyOeUq09xeVMNJ9nb6AYlKDZHpPdc=;
 b=nxSM/9osq9SPVi0vZXpseIuuF3jm6BmXC2rBb0bo2s6oNzIl9RtVXvViWa6MUHIYHG1EDL6qT
 WZ3Cb/alNrvCYgyo8qbs2HxBsVErIWcTmeVfzeF82L4JOAugu7aOr6d
X-Developer-Key: i=d-gole@ti.com; a=ed25519;
 pk=yOC9jqVaW3GN10oty8eZJ20dN4jcpE8JVoaODDmyZvA=
X-EXCLAIMER-MD-CONFIG: e1e8a2fd-e40a-4ac6-ac9b-f7e9cc9ee180

It seems like we missed migrating the complete information from the old
DT binding where we had described what the opp-supported-hw is supposed
to describe. Hence, bring back the exact description from the previous
binding to the current one.

Fixes: e576a9a8603f ("dt-bindings: cpufreq: Convert ti-cpufreq to json schema")
Signed-off-by: Dhruva Gole <d-gole@ti.com>
---
 .../devicetree/bindings/opp/operating-points-v2-ti-cpu.yaml         | 6 +++++-
 1 file changed, 5 insertions(+), 1 deletion(-)

diff --git a/Documentation/devicetree/bindings/opp/operating-points-v2-ti-cpu.yaml b/Documentation/devicetree/bindings/opp/operating-points-v2-ti-cpu.yaml
index 02d1d2c17129..90855009cb81 100644
--- a/Documentation/devicetree/bindings/opp/operating-points-v2-ti-cpu.yaml
+++ b/Documentation/devicetree/bindings/opp/operating-points-v2-ti-cpu.yaml
@@ -45,7 +45,11 @@ patternProperties:
       clock-latency-ns: true
       opp-hz: true
       opp-microvolt: true
-      opp-supported-hw: true
+      opp-supported-hw:
+        description: |
+          Two bitfields indicating:
+            1. Which revision of the SoC the OPP is supported by
+            2. Which eFuse bits indicate this OPP is available
       opp-suspend: true
       turbo-mode: true
 

-- 
2.34.1


