Return-Path: <linux-pm+bounces-32584-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id D6C99B2B193
	for <lists+linux-pm@lfdr.de>; Mon, 18 Aug 2025 21:27:59 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 37DB57AC918
	for <lists+linux-pm@lfdr.de>; Mon, 18 Aug 2025 19:26:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CB9402773EA;
	Mon, 18 Aug 2025 19:26:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b="g5ZitLUM"
X-Original-To: linux-pm@vger.kernel.org
Received: from lelvem-ot01.ext.ti.com (lelvem-ot01.ext.ti.com [198.47.23.234])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 182F42737E7;
	Mon, 18 Aug 2025 19:26:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.47.23.234
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755545204; cv=none; b=EolY2rIR74ElroUofuQtEROsXzD/z3AjAzpOTigl6htBBcVAQE8/nG9huiXMpuRLl5a8kcNIjv5WH9FGX0QGvTNtTGyctehXtPo6D3y0M0EBFGn7RgYGF6wht0LBo7HJ9GPci18lqG9RgK4YUoc8T208Candh5edUOWpHzsczoY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755545204; c=relaxed/simple;
	bh=eoLXwqOOfIRrHS8VYQfB6OgLGsfrMp71CnW1YYlCn0o=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=o1Z2sO7N83pN7MKhDfJPVvbrnnZPAEYlTwHGeGAWRrB6SXv8LDj5Y54KoZlDcwbtJFMLU1x2yU0kr8QqbFBeFfhjq4GHtXwhCoVIfly1RrZBADC7mgasvaMjy55hd6rbCXJqBp99JWJXiotflmcIWP0TwdBftRVS7o8Xn3PXx/4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ti.com; spf=pass smtp.mailfrom=ti.com; dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b=g5ZitLUM; arc=none smtp.client-ip=198.47.23.234
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ti.com
Received: from fllvem-sh03.itg.ti.com ([10.64.41.86])
	by lelvem-ot01.ext.ti.com (8.15.2/8.15.2) with ESMTP id 57IJQXQe2784525;
	Mon, 18 Aug 2025 14:26:33 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
	s=ti-com-17Q1; t=1755545193;
	bh=UXRkk2zDcggKtqTefi0QIESttIf8M0uGEmhb4YEPw9E=;
	h=From:To:CC:Subject:Date:In-Reply-To:References;
	b=g5ZitLUMZVY9XhusOnJzaZgC1dVg3TOVuLIw1Yth2hbrBTzQqnOshzzCjp4gkVGox
	 9DdrO9tyNhC3l5IyFmx5mhBAztHm+ilBLZyRAZWb5fdIECK1XGlidR/nUWUl1KUhqO
	 Y6eFxa7yK/sUNchkvG0VhP+eIMIJioPNoTbFoOik=
Received: from DFLE113.ent.ti.com (dfle113.ent.ti.com [10.64.6.34])
	by fllvem-sh03.itg.ti.com (8.18.1/8.18.1) with ESMTPS id 57IJQXMO039962
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-SHA256 bits=128 verify=FAIL);
	Mon, 18 Aug 2025 14:26:33 -0500
Received: from DFLE109.ent.ti.com (10.64.6.30) by DFLE113.ent.ti.com
 (10.64.6.34) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.55; Mon, 18
 Aug 2025 14:26:33 -0500
Received: from lelvem-mr06.itg.ti.com (10.180.75.8) by DFLE109.ent.ti.com
 (10.64.6.30) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.55 via
 Frontend Transport; Mon, 18 Aug 2025 14:26:33 -0500
Received: from judy-hp.dhcp.ti.com (judy-hp.dhcp.ti.com [128.247.81.105])
	by lelvem-mr06.itg.ti.com (8.18.1/8.18.1) with ESMTP id 57IJQWxY1525949;
	Mon, 18 Aug 2025 14:26:33 -0500
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
Subject: [PATCH 3/3] arm64: dts: ti: k3-am62p: Fix supported hardware for 1GHz OPP
Date: Mon, 18 Aug 2025 14:26:32 -0500
Message-ID: <20250818192632.2982223-4-jm@ti.com>
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

The 1GHz OPP is supported on speed grade "O" as well according to the
device datasheet [0], so fix the opp-supported-hw property to support
this speed grade for 1GHz OPP.

[0] https://www.ti.com/lit/gpn/am62p
Fixes: 76d855f05801 ("arm64: dts: ti: k3-am62p: add opp frequencies")
Cc: stable@vger.kernel.org
Signed-off-by: Judith Mendez <jm@ti.com>
---
 arch/arm64/boot/dts/ti/k3-am62p5.dtsi | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/arm64/boot/dts/ti/k3-am62p5.dtsi b/arch/arm64/boot/dts/ti/k3-am62p5.dtsi
index 202378d9d5cf..8982a7b9f1a6 100644
--- a/arch/arm64/boot/dts/ti/k3-am62p5.dtsi
+++ b/arch/arm64/boot/dts/ti/k3-am62p5.dtsi
@@ -135,7 +135,7 @@ opp-800000000 {
 
 		opp-1000000000 {
 			opp-hz = /bits/ 64 <1000000000>;
-			opp-supported-hw = <0x01 0x0006>;
+			opp-supported-hw = <0x01 0x0007>;
 			clock-latency-ns = <6000000>;
 		};
 
-- 
2.49.0


