Return-Path: <linux-pm+bounces-14440-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id CA43197C5F5
	for <lists+linux-pm@lfdr.de>; Thu, 19 Sep 2024 10:32:59 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 08F7E1C21E21
	for <lists+linux-pm@lfdr.de>; Thu, 19 Sep 2024 08:32:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 54B0A19ADA8;
	Thu, 19 Sep 2024 08:31:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b="yK9pB+hV"
X-Original-To: linux-pm@vger.kernel.org
Received: from lelv0142.ext.ti.com (lelv0142.ext.ti.com [198.47.23.249])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9526519A28D;
	Thu, 19 Sep 2024 08:31:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.47.23.249
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1726734696; cv=none; b=eog6A+tp8RyLQ2Vq92HiqIzML6BMBa1krF2rxMwi6z2z0axM+zxBFrFwiFaEX8dQ04mrTF3FpVbNeihLlhoXDocHYh7ocRNQOjBUr1YZdfEqEWbYEio+zd0HMFzDxGaQyrr4b7+zeVMBoknHauO485CZSX7jet0JYTPzO2wYgk0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1726734696; c=relaxed/simple;
	bh=R9YcD5RqnNWb8dU3XJtUCWMVjJ/amb+Py3njXxak5ZU=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=EBAQGsHp4R2JcRh/ldj9bzIyxF+XDzydJzWsfw1fG9xim1H0KhhTHZA9WURnF+bFHJmwXMxLj4osGmQ7WDVd8CVCpt74stzmHdyZlfFfAiL52sWRn8Wc4mTAOk3OwGuoUh0r9hySp+nkhmkWsA3uKD7uP2Z6VXF0odwW69eL+aE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ti.com; spf=pass smtp.mailfrom=ti.com; dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b=yK9pB+hV; arc=none smtp.client-ip=198.47.23.249
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ti.com
Received: from lelv0265.itg.ti.com ([10.180.67.224])
	by lelv0142.ext.ti.com (8.15.2/8.15.2) with ESMTP id 48J8VTvA015295;
	Thu, 19 Sep 2024 03:31:29 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
	s=ti-com-17Q1; t=1726734689;
	bh=fJCpmKvRBq8xdpxYsd06LIReO40i1UjcNNYyAp/OQ48=;
	h=From:To:CC:Subject:Date:In-Reply-To:References;
	b=yK9pB+hVpcYJWDyu4TnYvoLsIYPCPrjxXZiEmpa0g9NuVVxSCVx6JIKbf55rf6UWO
	 TPiuweNvC4m5eN1y2/c/0KwCKV4JoK1bnLzXj4zZGsZ+8FuPd5ni2XbRfs0Yz3BAUZ
	 MOpxGN2A4GO6+G806qgATRkYXWa3O9GyY3hfPcJA=
Received: from DFLE106.ent.ti.com (dfle106.ent.ti.com [10.64.6.27])
	by lelv0265.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 48J8VTDF004025
	(version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
	Thu, 19 Sep 2024 03:31:29 -0500
Received: from DFLE112.ent.ti.com (10.64.6.33) by DFLE106.ent.ti.com
 (10.64.6.27) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23; Thu, 19
 Sep 2024 03:31:28 -0500
Received: from lelvsmtp6.itg.ti.com (10.180.75.249) by DFLE112.ent.ti.com
 (10.64.6.33) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23 via
 Frontend Transport; Thu, 19 Sep 2024 03:31:28 -0500
Received: from lcpd911.dhcp.ti.com (lcpd911.dhcp.ti.com [172.24.227.226])
	by lelvsmtp6.itg.ti.com (8.15.2/8.15.2) with ESMTP id 48J8Urgb042798;
	Thu, 19 Sep 2024 03:31:25 -0500
From: Dhruva Gole <d-gole@ti.com>
To: Nishanth Menon <nm@ti.com>, Vignesh Raghavendra <vigneshr@ti.com>,
        Tero
 Kristo <kristo@kernel.org>,
        Viresh Kumar <viresh.kumar@linaro.org>,
        "Rafael J
 . Wysocki" <rafael@kernel.org>
CC: <linux-pm@vger.kernel.org>, <devicetree@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>, <linux-arm-kernel@lists.infradead.org>,
        Dhruva Gole <d-gole@ti.com>, Rob Herring <robh@kernel.org>,
        Krzysztof
 Kozlowski <krzk+dt@kernel.org>
Subject: [PATCH V4 6/6] cpufreq: ti-cpufreq: Update efuse/rev offsets in AM62 family
Date: Thu, 19 Sep 2024 13:58:10 +0530
Message-ID: <20240919082809.174589-7-d-gole@ti.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240919082809.174589-1-d-gole@ti.com>
References: <20240919082809.174589-1-d-gole@ti.com>
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-C2ProcessedOrg: 333ef613-75bf-4e12-a4b1-8e3623f5dcea

With the Silicon revision being taken directly from socinfo, there's no
longer any need for reading any SOC register for revision from this driver.
Hence, we do not require any rev_offset for AM62 family of devices.
The efuse offset should be 0x0 for AM625 as well, as the syscon
register being used from DT refers to the efuse_offset directly.

Signed-off-by: Dhruva Gole <d-gole@ti.com>
---

Viresh, Nishanth, Vignesh,

This driver fix is better to go with PATCH 5/6.

Subject: [PATCH V4 5/6] arm64: dts: ti: k3-am62: use opp_efuse_table for
 opp-table syscon

That patch fixes the efuse offset in the AM625 DT.
Without it, the driver will read from an incorrect efuse offset, and end
up breaking things in -next till all the DT changes make it in.
Hence, it would be preferrable if this entire series goes via a single
maintainer's tree.
Viresh, perhaps if you can ack this single patch, then Vignesh/Nishanth
could take it up if there are no objections?

I am sorry that this break compatibility with older AM625 devicetree.
However, the old devicetree was marking the entire wkup_conf as "syscon",
"simple-mfd" which was wrong and needed to be fixed.

This series finally tries to bring order to DT and the driver.

However, if there is still any way to maintain the backward
compatibility, then I am open to suggestions. Please try
and understand here that the ask for backward compatibility here
is to ask the driver to support a case where the register offset itself
was to be picked from a different node. I am not sure there's any
clean way to do this.

---
 drivers/cpufreq/ti-cpufreq.c | 5 +----
 1 file changed, 1 insertion(+), 4 deletions(-)

diff --git a/drivers/cpufreq/ti-cpufreq.c b/drivers/cpufreq/ti-cpufreq.c
index ba621ce1cdda..870ab0b376c1 100644
--- a/drivers/cpufreq/ti-cpufreq.c
+++ b/drivers/cpufreq/ti-cpufreq.c
@@ -313,10 +313,9 @@ static const struct soc_device_attribute k3_cpufreq_soc[] = {
 
 static struct ti_cpufreq_soc_data am625_soc_data = {
 	.efuse_xlate = am625_efuse_xlate,
-	.efuse_offset = 0x0018,
+	.efuse_offset = 0x0,
 	.efuse_mask = 0x07c0,
 	.efuse_shift = 0x6,
-	.rev_offset = 0x0014,
 	.multi_regulator = false,
 };
 
@@ -325,7 +324,6 @@ static struct ti_cpufreq_soc_data am62a7_soc_data = {
 	.efuse_offset = 0x0,
 	.efuse_mask = 0x07c0,
 	.efuse_shift = 0x6,
-	.rev_offset = 0x0014,
 	.multi_regulator = false,
 };
 
@@ -334,7 +332,6 @@ static struct ti_cpufreq_soc_data am62p5_soc_data = {
 	.efuse_offset = 0x0,
 	.efuse_mask = 0x07c0,
 	.efuse_shift = 0x6,
-	.rev_offset = 0x0014,
 	.multi_regulator = false,
 };
 
-- 
2.34.1


