Return-Path: <linux-pm+bounces-32585-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 3F39AB2B19B
	for <lists+linux-pm@lfdr.de>; Mon, 18 Aug 2025 21:28:50 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 396D3520878
	for <lists+linux-pm@lfdr.de>; Mon, 18 Aug 2025 19:28:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 80329274676;
	Mon, 18 Aug 2025 19:26:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b="Zb4RTiFB"
X-Original-To: linux-pm@vger.kernel.org
Received: from fllvem-ot04.ext.ti.com (fllvem-ot04.ext.ti.com [198.47.19.246])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D268A26E143;
	Mon, 18 Aug 2025 19:26:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.47.19.246
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755545218; cv=none; b=Y7rwA5ypfDlQfaEcyHRkUj97Cs5ZG5O02NM2tfEUPglj/YMZHICea5Hf2JBL05pPHgMy8c1LbnO/n0gfIUECLnr1m+u0qHTWO0P36aWzs1mYzbf7ho11Y0SF387ihlbB/1s61VA2lUpa3Al2UDAw9RFcHAWxB8q9OKIordTqLMw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755545218; c=relaxed/simple;
	bh=lgO6Fv74/3EhDqY7ISz2ttn0thbzJcrFVWcR+68l4S0=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=R8sz8f9pNdP1OYL8TlOXeFBNRxzYsV0kTG/G7Nb+LjlFMWFpQnJryXGSZn+ovCn3EcGaE2jraJX/zPqXWtSbTwNj+CzXSsxe7lJagNYcloNGAzVMLcOkK8lypwasFBKoeZstFCq82y8hJTI3O+tOP8kF0Rn/a6fIsEDBvyoogmE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ti.com; spf=pass smtp.mailfrom=ti.com; dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b=Zb4RTiFB; arc=none smtp.client-ip=198.47.19.246
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ti.com
Received: from fllvem-sh03.itg.ti.com ([10.64.41.86])
	by fllvem-ot04.ext.ti.com (8.15.2/8.15.2) with ESMTP id 57IJQXvn3147286;
	Mon, 18 Aug 2025 14:26:33 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
	s=ti-com-17Q1; t=1755545193;
	bh=VpHXmYx68i0rBEZSPh5Z9xmDRv11T/PfxoDuADg+r/U=;
	h=From:To:CC:Subject:Date:In-Reply-To:References;
	b=Zb4RTiFB6SD/V954Oonj/k+ByfKZ2/FbvAjQNBQOPqXRi4AVJfMtcQ+n8K5snxWr+
	 LwxPJfbzXgQM0sp8+a7NUJsimp3U3IXYL90syqBXc6AI3p+o/Ft+CNrgir8j8SOsRz
	 Vr1PZuiZaw9udI3pG0E1wxwOI/oqfTgFRD0nnZJU=
Received: from DFLE111.ent.ti.com (dfle111.ent.ti.com [10.64.6.32])
	by fllvem-sh03.itg.ti.com (8.18.1/8.18.1) with ESMTPS id 57IJQXmW039961
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-SHA256 bits=128 verify=FAIL);
	Mon, 18 Aug 2025 14:26:33 -0500
Received: from DFLE112.ent.ti.com (10.64.6.33) by DFLE111.ent.ti.com
 (10.64.6.32) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.55; Mon, 18
 Aug 2025 14:26:33 -0500
Received: from lelvem-mr06.itg.ti.com (10.180.75.8) by DFLE112.ent.ti.com
 (10.64.6.33) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.55 via
 Frontend Transport; Mon, 18 Aug 2025 14:26:33 -0500
Received: from judy-hp.dhcp.ti.com (judy-hp.dhcp.ti.com [128.247.81.105])
	by lelvem-mr06.itg.ti.com (8.18.1/8.18.1) with ESMTP id 57IJQWxX1525949;
	Mon, 18 Aug 2025 14:26:32 -0500
From: Judith Mendez <jm@ti.com>
To: Judith Mendez <jm@ti.com>, Nishanth Menon <nm@ti.com>,
        Krzysztof Kozlowski
	<krzk+dt@kernel.org>
CC: Vignesh Raghavendra <vigneshr@ti.com>, Tero Kristo <kristo@kernel.org>,
        Rob Herring <robh@kernel.org>, Conor Dooley <conor+dt@kernel.org>,
        "Rafael J
 . Wysocki" <rafael@kernel.org>,
        Viresh Kumar <viresh.kumar@linaro.org>, Bryan
 Brattlof <bb@ti.com>,
        <linux-arm-kernel@lists.infradead.org>, <devicetree@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>, <linux-pm@vger.kernel.org>
Subject: [PATCH 2/3] cpufreq: ti: Allow all silicon revisions to support OPPs
Date: Mon, 18 Aug 2025 14:26:31 -0500
Message-ID: <20250818192632.2982223-3-jm@ti.com>
X-Mailer: git-send-email 2.49.0
In-Reply-To: <20250818192632.2982223-1-jm@ti.com>
References: <20250818192632.2982223-1-jm@ti.com>
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-C2ProcessedOrg: 333ef613-75bf-4e12-a4b1-8e3623f5dcea

More silicon revisions are being defined for AM62x, AM62Px, and AM62ax
SoCs. These silicon may also support currently establishes OPPs, so remove
the revision limitation in ti-cpufreq and thus determine if an OPP applies
with speed grade efuse parsing.

Signed-off-by: Judith Mendez <jm@ti.com>
---
 drivers/cpufreq/ti-cpufreq.c | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/drivers/cpufreq/ti-cpufreq.c b/drivers/cpufreq/ti-cpufreq.c
index f7be09dc63e3..90c896d02649 100644
--- a/drivers/cpufreq/ti-cpufreq.c
+++ b/drivers/cpufreq/ti-cpufreq.c
@@ -311,9 +311,9 @@ static struct ti_cpufreq_soc_data am3517_soc_data = {
 };
 
 static const struct soc_device_attribute k3_cpufreq_soc[] = {
-	{ .family = "AM62X", .revision = "SR1.0" },
-	{ .family = "AM62AX", .revision = "SR1.0" },
-	{ .family = "AM62PX", .revision = "SR1.0" },
+	{ .family = "AM62X", },
+	{ .family = "AM62AX", },
+	{ .family = "AM62PX", },
 	{ /* sentinel */ }
 };
 
-- 
2.49.0


