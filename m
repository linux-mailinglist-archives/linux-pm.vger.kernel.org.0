Return-Path: <linux-pm+bounces-28719-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 0B8DEAD9ED2
	for <lists+linux-pm@lfdr.de>; Sat, 14 Jun 2025 20:11:07 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 2D4621897DD8
	for <lists+linux-pm@lfdr.de>; Sat, 14 Jun 2025 18:11:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A037E2EACF6;
	Sat, 14 Jun 2025 18:09:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=samsung.com header.i=@samsung.com header.b="SX0QDtos"
X-Original-To: linux-pm@vger.kernel.org
Received: from mailout2.w1.samsung.com (mailout2.w1.samsung.com [210.118.77.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 921252E88AD
	for <linux-pm@vger.kernel.org>; Sat, 14 Jun 2025 18:09:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=210.118.77.12
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1749924564; cv=none; b=Qa1FFHwVMo+upoiijj/TgNPrW8alJWL0qH6/GY+j30kU9LPOqjidvPfiblldVj+1LFjNwBi1qlB8g/TOjmXGdd2De1XFeeFa18cDZLnUt21TJrIbPBrR18ZFeLW2jGT+Lz8bs0Vdg+ZqUpUEfiMsD4LRGrqD/UsYypAfPue85eE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1749924564; c=relaxed/simple;
	bh=7AzkJzyMtlyRZ3L8jj0gHiRqZpAYGhtMYEoeo/ElVyM=;
	h=From:Date:Subject:MIME-Version:Message-Id:In-Reply-To:To:Cc:
	 Content-Type:References; b=U+BQPq265GpSlbFSKUUc4dyLlt0laAJ8RrTkD/o3TJVL6629ig5TA6PSRQ1Hu4tHa9al3s07VCdmvS7qOJCKUi4dhEMxsBJQEYLnOPaDMtWR1s4wnZlhRBgbr4e+8rmMMbc4IjmaEqJFh9dnx8tYiRs+t79sxU2Rgkenb3zSYvY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=samsung.com; spf=pass smtp.mailfrom=samsung.com; dkim=pass (1024-bit key) header.d=samsung.com header.i=@samsung.com header.b=SX0QDtos; arc=none smtp.client-ip=210.118.77.12
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=samsung.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=samsung.com
Received: from eucas1p2.samsung.com (unknown [182.198.249.207])
	by mailout2.w1.samsung.com (KnoxPortal) with ESMTP id 20250614180914euoutp027eb11ee879d98421bf851a058e12f3b4~I_xxxEWx40516105161euoutp02F
	for <linux-pm@vger.kernel.org>; Sat, 14 Jun 2025 18:09:14 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout2.w1.samsung.com 20250614180914euoutp027eb11ee879d98421bf851a058e12f3b4~I_xxxEWx40516105161euoutp02F
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
	s=mail20170921; t=1749924554;
	bh=03clYuLUe6lZViLZ7J3QsFCYeiK6qNUgF531eyi5Uj4=;
	h=From:Date:Subject:In-Reply-To:To:Cc:References:From;
	b=SX0QDtosxymnYJ9fMe40jJ7GyFyQrdjDht4B+f/CXbtqecpM8vBi+fHVwXxzQl7oA
	 dB/iNF5DLL48nUjCe/HyaV3ITUiASudgcHTAp0oJyiTwKP+zd6rHNAgCSTLVjNk/a4
	 AY/74CQ4V2aBjeqJgGkR9IXVNyOmE0m6WsgdHYjo=
Received: from eusmtip1.samsung.com (unknown [203.254.199.221]) by
	eucas1p2.samsung.com (KnoxPortal) with ESMTPA id
	20250614180913eucas1p2554c9e8d5024c534565d3c1de58f2e61~I_xw2bPmU3062230622eucas1p2x;
	Sat, 14 Jun 2025 18:09:13 +0000 (GMT)
Received: from AMDC4942.eu.corp.samsungelectronics.net (unknown
	[106.210.136.40]) by eusmtip1.samsung.com (KnoxPortal) with ESMTPA id
	20250614180912eusmtip1e08743a9bcee9b7280e90351569ae07e~I_xvwqq-J1758317583eusmtip1q;
	Sat, 14 Jun 2025 18:09:12 +0000 (GMT)
From: Michal Wilczynski <m.wilczynski@samsung.com>
Date: Sat, 14 Jun 2025 20:06:12 +0200
Subject: [PATCH v4 6/8] riscv: dts: thead: th1520: Add GPU clkgen reset to
 AON node
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Message-Id: <20250614-apr_14_for_sending-v4-6-8e3945c819cd@samsung.com>
In-Reply-To: <20250614-apr_14_for_sending-v4-0-8e3945c819cd@samsung.com>
To: Drew Fustini <drew@pdp7.com>, Guo Ren <guoren@kernel.org>,  Fu Wei
	<wefu@redhat.com>, Rob Herring <robh@kernel.org>,  Krzysztof Kozlowski
	<krzk+dt@kernel.org>,  Conor Dooley <conor+dt@kernel.org>,  Michal
	Wilczynski <m.wilczynski@samsung.com>,  Bartosz Golaszewski <brgl@bgdev.pl>,
	Philipp Zabel <p.zabel@pengutronix.de>,  Frank Binns
	<frank.binns@imgtec.com>, Matt Coster <matt.coster@imgtec.com>,  Maarten
	Lankhorst <maarten.lankhorst@linux.intel.com>,  Maxime Ripard
	<mripard@kernel.org>, Thomas Zimmermann <tzimmermann@suse.de>,  David Airlie
	<airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>,  Paul Walmsley
	<paul.walmsley@sifive.com>,  Palmer Dabbelt <palmer@dabbelt.com>, Albert Ou
	<aou@eecs.berkeley.edu>,  Alexandre Ghiti <alex@ghiti.fr>, Ulf Hansson
	<ulf.hansson@linaro.org>,  Marek Szyprowski <m.szyprowski@samsung.com>
Cc: linux-riscv@lists.infradead.org, devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org, linux-pm@vger.kernel.org, 
	dri-devel@lists.freedesktop.org
X-Mailer: b4 0.15-dev
X-CMS-MailID: 20250614180913eucas1p2554c9e8d5024c534565d3c1de58f2e61
X-Msg-Generator: CA
Content-Type: text/plain; charset="utf-8"
X-RootMTR: 20250614180913eucas1p2554c9e8d5024c534565d3c1de58f2e61
X-EPHeader: CA
X-CMS-RootMailID: 20250614180913eucas1p2554c9e8d5024c534565d3c1de58f2e61
References: <20250614-apr_14_for_sending-v4-0-8e3945c819cd@samsung.com>
	<CGME20250614180913eucas1p2554c9e8d5024c534565d3c1de58f2e61@eucas1p2.samsung.com>

Add the "gpu-clkgen" reset property to the AON device tree node. This
allows the AON power domain driver to detect the capability to power
sequence the GPU and spawn the necessary pwrseq-thead-gpu auxiliary
driver for managing the GPU's complex power sequence.

This commit also adds the prerequisite
dt-bindings/reset/thead,th1520-reset.h include to make the
TH1520_RESET_ID_GPU_CLKGEN available. This include was previously
dropped during a conflict resolution [1].

Link: https://lore.kernel.org/all/aAvfn2mq0Ksi8DF2@x1/ [1]

Reviewed-by: Ulf Hansson <ulf.hansson@linaro.org>
Signed-off-by: Michal Wilczynski <m.wilczynski@samsung.com>
---
 arch/riscv/boot/dts/thead/th1520.dtsi | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/arch/riscv/boot/dts/thead/th1520.dtsi b/arch/riscv/boot/dts/thead/th1520.dtsi
index 1db0054c4e093400e9dbebcee5fcfa5b5cae6e32..f3f5db0201ab8c0306d4d63072a1573431e51893 100644
--- a/arch/riscv/boot/dts/thead/th1520.dtsi
+++ b/arch/riscv/boot/dts/thead/th1520.dtsi
@@ -7,6 +7,7 @@
 #include <dt-bindings/interrupt-controller/irq.h>
 #include <dt-bindings/clock/thead,th1520-clk-ap.h>
 #include <dt-bindings/power/thead,th1520-power.h>
+#include <dt-bindings/reset/thead,th1520-reset.h>
 
 / {
 	compatible = "thead,th1520";
@@ -234,6 +235,8 @@ aon: aon {
 		compatible = "thead,th1520-aon";
 		mboxes = <&mbox_910t 1>;
 		mbox-names = "aon";
+		resets = <&rst TH1520_RESET_ID_GPU_CLKGEN>;
+		reset-names = "gpu-clkgen";
 		#power-domain-cells = <1>;
 	};
 

-- 
2.34.1


