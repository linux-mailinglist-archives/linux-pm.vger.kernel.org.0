Return-Path: <linux-pm+bounces-9027-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 53FE3905905
	for <lists+linux-pm@lfdr.de>; Wed, 12 Jun 2024 18:43:01 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 55C161C21CC8
	for <lists+linux-pm@lfdr.de>; Wed, 12 Jun 2024 16:43:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CB7F1181D15;
	Wed, 12 Jun 2024 16:42:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b="nnvQb5/P"
X-Original-To: linux-pm@vger.kernel.org
Received: from lelv0143.ext.ti.com (lelv0143.ext.ti.com [198.47.23.248])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 45881181BAA;
	Wed, 12 Jun 2024 16:42:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.47.23.248
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718210545; cv=none; b=AP4Jq7o3YIiVs4VOfiPU+ThEjKi2Koozb0CDp0lbnQnqiPep1TCBbj5pTCw3rtwjBKGNzW+HpiRyU4aYw6agfNM3wHYo/n8f1ZI9UjGOpy+kaNaLela9TPJF1Dh+Pznc/lJAP+2qnqXoxAaKyeZGFw0TusK6jSrpxDpUv7IalFk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718210545; c=relaxed/simple;
	bh=loz+yb0OobqkWSAdNdNFmwXBpbGuxDenjLdUFVUe7sc=;
	h=From:Subject:Date:Message-ID:MIME-Version:Content-Type:To:CC; b=rW02kqfoOuQGHl22KIhs8c+0+yfwEsnN8wfZRy5bHoRlr6K9UPO+Mykj4YtdZ3WxNR13d5jrFgSZ4p+35WD64/CywLHrECdT5eoh+M6kTsi5bnP5+EWNq+Jkmzc6o1YsycQ5bK3PazR1M4ovBtVMBGzV/oZY7iP2DfticiUICRg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ti.com; spf=pass smtp.mailfrom=ti.com; dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b=nnvQb5/P; arc=none smtp.client-ip=198.47.23.248
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ti.com
Received: from fllv0034.itg.ti.com ([10.64.40.246])
	by lelv0143.ext.ti.com (8.15.2/8.15.2) with ESMTP id 45CGgBB5127385;
	Wed, 12 Jun 2024 11:42:11 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
	s=ti-com-17Q1; t=1718210531;
	bh=rKB0v+FMA+1HwxPXsYfUmmAJSpVBosvWTgK2qlbK8xc=;
	h=From:Subject:Date:To:CC;
	b=nnvQb5/P8hPyRmnDbcgAiiOj5ft3vfl7E72xi39NIRT8FITiyRi7SKr+nUEyCbP5w
	 xhhpZ4NzjRrcoy3zFaFcAMBh7Y2Ezv6BkaCweW9yCbmMQI09KNHXA0DMt185BmBX2k
	 0mWCWis3KLXSCex5og0OXddUUTTqAA1wQOgNz58w=
Received: from DLEE105.ent.ti.com (dlee105.ent.ti.com [157.170.170.35])
	by fllv0034.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 45CGgBwI066238
	(version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
	Wed, 12 Jun 2024 11:42:11 -0500
Received: from DLEE106.ent.ti.com (157.170.170.36) by DLEE105.ent.ti.com
 (157.170.170.35) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23; Wed, 12
 Jun 2024 11:42:10 -0500
Received: from lelvsmtp6.itg.ti.com (10.180.75.249) by DLEE106.ent.ti.com
 (157.170.170.36) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23 via
 Frontend Transport; Wed, 12 Jun 2024 11:42:10 -0500
Received: from localhost (bb.dhcp.ti.com [128.247.81.12])
	by lelvsmtp6.itg.ti.com (8.15.2/8.15.2) with ESMTP id 45CGgAnN099377;
	Wed, 12 Jun 2024 11:42:10 -0500
From: Bryan Brattlof <bb@ti.com>
Subject: [PATCH 0/5] Update OPP table and add entries for AM62Ax & AM62Px
 SoCs
Date: Wed, 12 Jun 2024 11:41:49 -0500
Message-ID: <20240612-ti-opp-updates-v1-0-3551c31d9872@ti.com>
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIAM3PaWYC/x3MMQ6AIAxA0auYzjYBhAGvYhxQqnZRAmhMCHeXO
 L7h/wKJIlOCsSsQ6eHE19kg+w7Ww507IftmUEJpYYTFzHiFgHfwLlNCaVcprFvkYDS0KETa+P2
 H01zrByhQ/6JgAAAA
To: "Rafael J. Wysocki" <rafael@kernel.org>,
        Viresh Kumar
	<viresh.kumar@linaro.org>, Lee Jones <lee@kernel.org>,
        Rob Herring
	<robh@kernel.org>,
        Krzysztof Kozlowski <krzk+dt@kernel.org>,
        Conor Dooley
	<conor+dt@kernel.org>, Nishanth Menon <nm@ti.com>,
        Vignesh Raghavendra
	<vigneshr@ti.com>,
        Tero Kristo <kristo@kernel.org>
CC: Vibhore Vardhan <vibhore@ti.com>, <linux-pm@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>, <devicetree@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>, Bryan Brattlof <bb@ti.com>
X-Mailer: b4 0.13.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=1507; i=bb@ti.com;
 h=from:subject:message-id; bh=loz+yb0OobqkWSAdNdNFmwXBpbGuxDenjLdUFVUe7sc=;
 b=owNCWmg5MUFZJlNZeTm+RgAAYX////bP/z0r2ev13o79f+vuO7T/9jbPDfvfW/2q05//+/+wA
 Rs2g7SABoNBoaA0AANBpoAGj0gGgAAAaAA0GgNBoNA0A09QGmj1ANPTKep4KIA0GjIBoAZMjIND
 QNNAMgMg0GmQ0AZGQ0GTAjRoNGg0ZMjIMmTIPU0aD0mgA7U09RkekABoAyDQA00NqGmgNAAaAAM
 mIAaZHqaaMg0PUZGmgAPSGQ9TQaBoBoCCxCJ08QSROTwUs3qcZSRclLCLl8L9O68cq+EA6hExA5
 cpckUDaJimCZgB50fTiw+sCLVcMhvz5FGbStI4FeumouoAOXQocGCdyEoZKNZlAjMqxKE9/aGWu
 0UF6OapDipTasPtlyGER/9WUPb7+mOsE70tBlc3ptNxgy8TwoO/r+idfCwJgBuBlIyVsjhIgbtZ
 zA4Id50q3XwCHeVYsLAo9gMLssrYFf7Ju6kj1051iyg6VJq6kr0Ge8YXFKPwvlE0ghkmOP8zYLU
 +dAvOLfMH07JQKpahVb2NHFePVhhfZnrifU0vezmmtXUW9cfofoKeGYfg/2eY551pMIUsU6VvNJ
 AhETYADBAQbnTsikBAwhBorLAZNxeBiISvJUMYd4SBwiT7gQSbLK4kCY2wVJ7kf+Uny9kB4zah/
 MLyFghmih/xdyRThQkHk5vkYA==
X-Developer-Key: i=bb@ti.com; a=openpgp;
 fpr=D3D177E40A38DF4D1853FEEF41B90D5D71D56CE0
X-EXCLAIMER-MD-CONFIG: e1e8a2fd-e40a-4ac6-ac9b-f7e9cc9ee180

Hello Everyone

This series starts off the process of updating the OPP decoding tables 
to align with the new speed grade schemes for TI's AM62Ax and AM62Px SoC 
families.

Following this update is the updated binding and the OPPv2 entries we 
will be using for the SoC including the 1.4GHz frequency for our 
reference boards when the VDD_CORE allows.

Thanks for reviewing
~Bryan

Signed-off-by: Bryan Brattlof <bb@ti.com>
---
Bryan Brattlof (5):
      cpufreq: ti: update OPP table for AM62Ax SoCs
      cpufreq: ti: update OPP table for AM62Px SoCs
      DONOTMERGE: dt-bindings: mfd: syscon: add TI's opp table compatible
      DONOTMERGE: arm64: dts: ti: k3-am62p: add in opp tables
      DONOTMERGE: arm64: dts: ti: k3-am62a: add in opp table

 Documentation/devicetree/bindings/mfd/syscon.yaml |  1 +
 arch/arm64/boot/dts/ti/k3-am62a-wakeup.dtsi       |  5 ++
 arch/arm64/boot/dts/ti/k3-am62a7-sk.dts           |  9 +++
 arch/arm64/boot/dts/ti/k3-am62a7.dtsi             | 51 ++++++++++++
 arch/arm64/boot/dts/ti/k3-am62p-wakeup.dtsi       |  6 ++
 arch/arm64/boot/dts/ti/k3-am62p5-sk.dts           |  9 +++
 arch/arm64/boot/dts/ti/k3-am62p5.dtsi             | 47 ++++++++++++
 drivers/cpufreq/ti-cpufreq.c                      | 94 ++++++++++++++++++++++-
 8 files changed, 220 insertions(+), 2 deletions(-)
---
base-commit: 629b57597ab52cef2ac5dd16042183c298cc52ed
change-id: 20240509-ti-opp-updates-19c109ab1354

Best regards,
-- 
Bryan Brattlof <bb@ti.com>


