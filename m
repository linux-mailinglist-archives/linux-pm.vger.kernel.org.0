Return-Path: <linux-pm+bounces-13333-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 2D10D96834A
	for <lists+linux-pm@lfdr.de>; Mon,  2 Sep 2024 11:33:20 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id CB08C1F23518
	for <lists+linux-pm@lfdr.de>; Mon,  2 Sep 2024 09:33:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 591D61D2F6B;
	Mon,  2 Sep 2024 09:32:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b="KJLBDOTw"
X-Original-To: linux-pm@vger.kernel.org
Received: from lelv0142.ext.ti.com (lelv0142.ext.ti.com [198.47.23.249])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 99A9A1D2F4A;
	Mon,  2 Sep 2024 09:32:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.47.23.249
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725269573; cv=none; b=k6wGjOTm/sRDcHo4VSf97gyuR/VHb1ctltgNaCI0+X9P4+no9NcjDgw03NvXRlpo6D5+OMQxOeL22FJTxiT/m2/nx2QImzd7W9TMEL5VEuHE+ZdJzt7mhGksTqHKHgjAW6ng0I2TZ+2EARry/W6uvSgVR/dUvHe15keBjtijjdg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725269573; c=relaxed/simple;
	bh=nq46uZJLcEoJhJX/Y3rLACiJqMacu/+fOzH+Mto/gsg=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=Tl5yu/Q+HlxSgggfVmAUJytOrQU//B4R77xDlPI1hPFbZArO1lJ6wJ0SO9ZgN095AmEzVERjMJl1y2JWE4mTfTe4/9qxmkVZBFaBIBt84EfC0UqiO7QM1pOU0TAQ4VKx/DDTPbO3iggfk3917RDJ6s6AoEuWq0dS9gq/4P/11fw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ti.com; spf=pass smtp.mailfrom=ti.com; dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b=KJLBDOTw; arc=none smtp.client-ip=198.47.23.249
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ti.com
Received: from lelv0266.itg.ti.com ([10.180.67.225])
	by lelv0142.ext.ti.com (8.15.2/8.15.2) with ESMTP id 4829WjF9074521;
	Mon, 2 Sep 2024 04:32:45 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
	s=ti-com-17Q1; t=1725269565;
	bh=gaS91yKXO7G1zpchqnIy09lfpA2W8HvrlWUkg/C8O/I=;
	h=From:To:CC:Subject:Date:In-Reply-To:References;
	b=KJLBDOTwT80SpNIswegFvYk9YfEEee6NleeLO7s1p6E3Z+4wtjISeiV34d61mnWAg
	 gfwKMh243M6IUILgIKWWOjmE/GydR+VSnkAywx2SCbvRuK6FEXiS4MUqLHgPlfeng6
	 P5eNKxfP4BGH/g+/bIeRTlHzb0ZlzTT+oMDrM2S4=
Received: from DLEE115.ent.ti.com (dlee115.ent.ti.com [157.170.170.26])
	by lelv0266.itg.ti.com (8.15.2/8.15.2) with ESMTP id 4829WjRB037779;
	Mon, 2 Sep 2024 04:32:45 -0500
Received: from DLEE112.ent.ti.com (157.170.170.23) by DLEE115.ent.ti.com
 (157.170.170.26) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23; Mon, 2
 Sep 2024 04:32:44 -0500
Received: from lelvsmtp6.itg.ti.com (10.180.75.249) by DLEE112.ent.ti.com
 (157.170.170.23) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23 via
 Frontend Transport; Mon, 2 Sep 2024 04:32:44 -0500
Received: from lcpd911.dhcp.ti.com (lcpd911.dhcp.ti.com [172.24.227.68])
	by lelvsmtp6.itg.ti.com (8.15.2/8.15.2) with ESMTP id 4829WT7L109047;
	Mon, 2 Sep 2024 04:32:41 -0500
From: Dhruva Gole <d-gole@ti.com>
To: "Rafael J . Wysocki" <rafael@kernel.org>,
        Viresh Kumar
	<viresh.kumar@linaro.org>,
        Tero Kristo <kristo@kernel.org>, Rob Herring
	<robh@kernel.org>,
        Krzysztof Kozlowski <krzk+dt@kernel.org>,
        Conor Dooley
	<conor+dt@kernel.org>
CC: Nishanth Menon <nm@ti.com>, Vignesh Raghavendra <vigneshr@ti.com>,
        <bb@ti.com>, <vibhore@ti.com>, <linux-pm@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>, <devicetree@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>, Dhruva Gole <d-gole@ti.com>
Subject: [PATCH 2/2] cpufreq: ti-cpufreq: Make the AM625 efuse_offset 0
Date: Mon, 2 Sep 2024 15:02:22 +0530
Message-ID: <20240902093222.2828345-3-d-gole@ti.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240902093222.2828345-1-d-gole@ti.com>
References: <20240902093222.2828345-1-d-gole@ti.com>
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-EXCLAIMER-MD-CONFIG: e1e8a2fd-e40a-4ac6-ac9b-f7e9cc9ee180

Since the efuse_offset is basically derived from the syscon node, we no
longer need to use any efuse_offset for AM625. This is in line with how
the AM62Ax and AM62Px are already doing.

Signed-off-by: Dhruva Gole <d-gole@ti.com>
---
 drivers/cpufreq/ti-cpufreq.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/cpufreq/ti-cpufreq.c b/drivers/cpufreq/ti-cpufreq.c
index ba621ce1cdda..98e320832f78 100644
--- a/drivers/cpufreq/ti-cpufreq.c
+++ b/drivers/cpufreq/ti-cpufreq.c
@@ -313,7 +313,7 @@ static const struct soc_device_attribute k3_cpufreq_soc[] = {
 
 static struct ti_cpufreq_soc_data am625_soc_data = {
 	.efuse_xlate = am625_efuse_xlate,
-	.efuse_offset = 0x0018,
+	.efuse_offset = 0x0,
 	.efuse_mask = 0x07c0,
 	.efuse_shift = 0x6,
 	.rev_offset = 0x0014,
-- 
2.34.1


