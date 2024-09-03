Return-Path: <linux-pm+bounces-13401-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 0FC0A969A2B
	for <lists+linux-pm@lfdr.de>; Tue,  3 Sep 2024 12:30:54 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id C0905284783
	for <lists+linux-pm@lfdr.de>; Tue,  3 Sep 2024 10:30:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 40D491AB6E7;
	Tue,  3 Sep 2024 10:30:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b="vdEf0L2p"
X-Original-To: linux-pm@vger.kernel.org
Received: from fllv0015.ext.ti.com (fllv0015.ext.ti.com [198.47.19.141])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 588981A0BEC;
	Tue,  3 Sep 2024 10:30:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.47.19.141
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725359449; cv=none; b=Xm7bv1mM+pw9RjJF166ARmMcTxfqWlOipEMi3zmvJGc3RNG/wm6c9hA+e9MxPk0X4yEdELnr2IY2Tf51R0Dy1WLRTBiWZg1TMOPdyB6z5GamGrBV12k2s6BBjw4w2eGx8ZhxB0v0C2rfdDnHousajPmfXfFzaaIdfih1AMuKCHA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725359449; c=relaxed/simple;
	bh=LOR0Zp7NxGvrm+QVjkcnA81zrYiOZkUdYoVIhRNDWe0=;
	h=From:Subject:Date:Message-ID:MIME-Version:Content-Type:To:CC; b=d/FaL3opZ9XHHUG8CPq2RhrF2PKrzyvuD5WGCyL9rmnR6okUgNEif8Z0mfk3LN1eEwBIaG3+X+/K5bTR5izEY5/4YCyoaoB7JIYwEFEZ+FdYqfqwFgju0gYnEFc7Psd8qIct7Sj2mvZm7GVugypLLbAkGqHJXvNcO4DVw2gMl74=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ti.com; spf=pass smtp.mailfrom=ti.com; dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b=vdEf0L2p; arc=none smtp.client-ip=198.47.19.141
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ti.com
Received: from fllv0034.itg.ti.com ([10.64.40.246])
	by fllv0015.ext.ti.com (8.15.2/8.15.2) with ESMTP id 483AUgwN085078;
	Tue, 3 Sep 2024 05:30:42 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
	s=ti-com-17Q1; t=1725359442;
	bh=GUVgHwhBPbcKPFtgunm6MFljLDZyTo0fx7zWbkx9FIM=;
	h=From:Subject:Date:To:CC;
	b=vdEf0L2pD3rN2Apdwna+IsP3M+9QMi6ZnNVkXRGTZYFpI24LD+BknuTtBU75qdQur
	 VM5WFKFRLeMwm0fm+VWGRfpOK3cuUNZXaUY9w9Q0qEuYAlE9oJEB0XqFiE980A6ceb
	 n9jlogmMr1VT9EDGF9WMW39E/MUaoFUvRRkk6ABQ=
Received: from DFLE105.ent.ti.com (dfle105.ent.ti.com [10.64.6.26])
	by fllv0034.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 483AUfWL014075
	(version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
	Tue, 3 Sep 2024 05:30:42 -0500
Received: from DFLE100.ent.ti.com (10.64.6.21) by DFLE105.ent.ti.com
 (10.64.6.26) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23; Tue, 3
 Sep 2024 05:30:42 -0500
Received: from lelvsmtp6.itg.ti.com (10.180.75.249) by DFLE100.ent.ti.com
 (10.64.6.21) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23 via
 Frontend Transport; Tue, 3 Sep 2024 05:30:41 -0500
Received: from [127.0.1.1] (lcpd911.dhcp.ti.com [172.24.227.68])
	by lelvsmtp6.itg.ti.com (8.15.2/8.15.2) with ESMTP id 483AUb67012445;
	Tue, 3 Sep 2024 05:30:38 -0500
From: Dhruva Gole <d-gole@ti.com>
Subject: [PATCH 0/2] dt-bindings: opp: operating-points-v2-ti-cpu: Describe
 opp-supported-hw
Date: Tue, 3 Sep 2024 16:00:06 +0530
Message-ID: <20240903-b4-opp-dt-binding-fix-v1-0-f7e186456d9f@ti.com>
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIAC7l1mYC/x2MywqAIBAAfyX23IJp71+JDpVb7cVEIwLx31s6z
 sBMgkiBKcJYJAj0cOTLCVRlAdu5uIOQrTBopWs1KINrjZf3aG9c2Vl2B+78Yme2ttdD11RWg7Q
 +kOj/O805f8/IseFnAAAA
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
X-Developer-Signature: v=1; a=ed25519-sha256; t=1725359437; l=760;
 i=d-gole@ti.com; s=20240902; h=from:subject:message-id;
 bh=LOR0Zp7NxGvrm+QVjkcnA81zrYiOZkUdYoVIhRNDWe0=;
 b=j1dNqwftlTS8Z90COpkUgQK1Jeq0l8II9VVeY0P0q+6MOxJzT60Fy786CLgG+1OCgSsuIgMzp
 NLV5Rb+OKrKDZedJR7yU6zpu7F2kIzc6s+C/c54oPuePD0erCu8A5bs
X-Developer-Key: i=d-gole@ti.com; a=ed25519;
 pk=yOC9jqVaW3GN10oty8eZJ20dN4jcpE8JVoaODDmyZvA=
X-EXCLAIMER-MD-CONFIG: e1e8a2fd-e40a-4ac6-ac9b-f7e9cc9ee180

dt-bindings: opp: operating-points-v2-ti-cpu: Describe opp-supported-hw

This series tries to bring back the description about what goes into
opp-supported-hw from the older binding.

While at it, also updating the maintainers entry.

Signed-off-by: Dhruva Gole <d-gole@ti.com>
---
Dhruva Gole (2):
      dt-bindings: opp: operating-points-v2-ti-cpu: Describe opp-supported-hw
      dt-bindings: opp: operating-points-v2-ti-cpu: Update maintainers

 .../devicetree/bindings/opp/operating-points-v2-ti-cpu.yaml       | 8 ++++++--
 1 file changed, 6 insertions(+), 2 deletions(-)
---
base-commit: ecc768a84f0b8e631986f9ade3118fa37852fef0
change-id: 20240903-b4-opp-dt-binding-fix-73c6829751d2

Best regards,
-- 
Dhruva Gole <d-gole@ti.com>


