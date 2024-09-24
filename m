Return-Path: <linux-pm+bounces-14608-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 157C29842BC
	for <lists+linux-pm@lfdr.de>; Tue, 24 Sep 2024 11:55:57 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 04599B27CEB
	for <lists+linux-pm@lfdr.de>; Tue, 24 Sep 2024 09:53:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E75EE16DED5;
	Tue, 24 Sep 2024 09:51:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b="nBaDzqwb"
X-Original-To: linux-pm@vger.kernel.org
Received: from fllv0016.ext.ti.com (fllv0016.ext.ti.com [198.47.19.142])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5A2A917C9F9;
	Tue, 24 Sep 2024 09:51:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.47.19.142
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727171494; cv=none; b=CpaSR2gTElGo4ByHKsLoM8EzVG+5X/LVde0QOq4zZUKKAApv4Kr6WWuC6DYJc7stsmJJ3CKsUcAjYUw38pPhmN0h2iUY3Ke1R4AeCKA8hUsmyRFcpUib0/8vecEgR+G0RgEcK9nP8A8MY/IYWNPZPOYhC/LKI0EFGVk9BmfsaBA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727171494; c=relaxed/simple;
	bh=MdcHjICSpj3jCUd6bD1wEhgq64QDj+cNSJHu45+y/Zc=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-ID:References:
	 In-Reply-To:To:CC; b=IKB3rA0Nen1jDtbNKqJm8IPddJZPpH78F+Oa36Jl0PLqU0bH02Nv9wEgzPoNM60WF2jTq/KOD087oxq2nfleRlJ6iOWOSYgSHbW700+wWgQeFRYSCbJvHinF+dhXgflrZXdAymgLguE26ysUKi4glKuSC1l4Wx7Yrq4Lt4RJAaE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ti.com; spf=pass smtp.mailfrom=ti.com; dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b=nBaDzqwb; arc=none smtp.client-ip=198.47.19.142
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ti.com
Received: from lelv0265.itg.ti.com ([10.180.67.224])
	by fllv0016.ext.ti.com (8.15.2/8.15.2) with ESMTP id 48O9pSWc003212;
	Tue, 24 Sep 2024 04:51:28 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
	s=ti-com-17Q1; t=1727171488;
	bh=QeoCQfMkCQADOer2TgZxIF8m7AprUWBAy1/d+sbV/2M=;
	h=From:Date:Subject:References:In-Reply-To:To:CC;
	b=nBaDzqwb6MVxVceHkbjWkP5UHC0KdnRjebzz+6oqFo8MphqBujflDNBSWbV0hBEyd
	 Ngh0sNZ88WZULv0J4/Nmp2/JYL7HTBJlssd276NPFMderqJQPsmtOa1fTi1i4RGxx9
	 knAhOvcjq3kccujW3mfcGEM7h3MuNxMV1zJ1lfuI=
Received: from DFLE100.ent.ti.com (dfle100.ent.ti.com [10.64.6.21])
	by lelv0265.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 48O9pR4b001109
	(version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
	Tue, 24 Sep 2024 04:51:27 -0500
Received: from DFLE105.ent.ti.com (10.64.6.26) by DFLE100.ent.ti.com
 (10.64.6.21) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23; Tue, 24
 Sep 2024 04:51:27 -0500
Received: from lelvsmtp6.itg.ti.com (10.180.75.249) by DFLE105.ent.ti.com
 (10.64.6.26) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23 via
 Frontend Transport; Tue, 24 Sep 2024 04:51:28 -0500
Received: from [127.0.1.1] (lcpd911.dhcp.ti.com [172.24.227.226])
	by lelvsmtp6.itg.ti.com (8.15.2/8.15.2) with ESMTP id 48O9owSv017217;
	Tue, 24 Sep 2024 04:51:23 -0500
From: Dhruva Gole <d-gole@ti.com>
Date: Tue, 24 Sep 2024 15:20:46 +0530
Subject: [PATCH v5 6/6] cpufreq: ti-cpufreq: Update efuse/rev offsets in
 AM62 family
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-ID: <20240924-ti-cpufreq-fixes-v5-v5-6-cbe16b9ddb1b@ti.com>
References: <20240924-ti-cpufreq-fixes-v5-v5-0-cbe16b9ddb1b@ti.com>
In-Reply-To: <20240924-ti-cpufreq-fixes-v5-v5-0-cbe16b9ddb1b@ti.com>
To: Nishanth Menon <nm@ti.com>, Vignesh Raghavendra <vigneshr@ti.com>,
        Tero
 Kristo <kristo@kernel.org>, Rob Herring <robh@kernel.org>,
        Krzysztof
 Kozlowski <krzk+dt@kernel.org>,
        Conor Dooley <conor+dt@kernel.org>,
        "Rafael
 J. Wysocki" <rafael@kernel.org>,
        Viresh Kumar <viresh.kumar@linaro.org>
CC: <linux-arm-kernel@lists.infradead.org>, <devicetree@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>, <linux-pm@vger.kernel.org>,
        Andrew Davis
	<afd@ti.com>, Bryan Brattlof <bb@ti.com>,
        Dhruva Gole <d-gole@ti.com>
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=ed25519-sha256; t=1727171458; l=1509;
 i=d-gole@ti.com; s=20240919; h=from:subject:message-id;
 bh=MdcHjICSpj3jCUd6bD1wEhgq64QDj+cNSJHu45+y/Zc=;
 b=zrW5/Ctpd0tlw/Wd7DOLEV4OODMMPTYP7G9B1A0wAu8d0i4qc+SLtYRVwEWrFQ1OHfn8pt2Te
 YGB8tvLZDK7C9ljPQBADMn2Rml3RrsvfUK0b5lEnpTxKzpnhU0iM3Mh
X-Developer-Key: i=d-gole@ti.com; a=ed25519;
 pk=k8NnY4RbxVqeqGsYfTHeVn4hPOHkjg7Mii0Ixs4rghM=
X-C2ProcessedOrg: 333ef613-75bf-4e12-a4b1-8e3623f5dcea

With the Silicon revision being taken directly from socinfo, there's no
longer any need for reading any SOC register for revision from this driver.
Hence, we do not require any rev_offset for AM62 family of devices.
The efuse offset should be 0x0 for AM625 as well, as the syscon
register being used from DT refers to the efuse_offset directly.

Signed-off-by: Dhruva Gole <d-gole@ti.com>
---
 drivers/cpufreq/ti-cpufreq.c | 5 +----
 1 file changed, 1 insertion(+), 4 deletions(-)

diff --git a/drivers/cpufreq/ti-cpufreq.c b/drivers/cpufreq/ti-cpufreq.c
index ba621ce1cdda694c98867422dbb7f10c0df2afef..870ab0b376c1c0389b952b61a13d169b174538bb 100644
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


