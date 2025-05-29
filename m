Return-Path: <linux-pm+bounces-27826-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 0A82DAC843F
	for <lists+linux-pm@lfdr.de>; Fri, 30 May 2025 00:25:01 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id ED6461BC636F
	for <lists+linux-pm@lfdr.de>; Thu, 29 May 2025 22:25:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6ADC32571AC;
	Thu, 29 May 2025 22:24:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=samsung.com header.i=@samsung.com header.b="dCo4LnRW"
X-Original-To: linux-pm@vger.kernel.org
Received: from mailout1.w1.samsung.com (mailout1.w1.samsung.com [210.118.77.11])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 32F7D221557
	for <linux-pm@vger.kernel.org>; Thu, 29 May 2025 22:24:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=210.118.77.11
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1748557459; cv=none; b=aMYVgIgIjrqQm9tsUB7pT7GQQyhhwk6D6vl+ACgC/LlyYuJoZgt3wKvZf1fup083ToDoAnOIEaak0hvJOEJ3uWPN4mj2YhHxYZIORIAT0V0ZNWQ0CNmadNxUNA852qSX7Yr9cM7+FhcR6e/Mziyk3SDgOKkDGVPtZDshE8ioCn0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1748557459; c=relaxed/simple;
	bh=gzz08eHWwUxuY3CeJ2uiRThhY0/iCcyEUXquAUPnEIM=;
	h=From:Date:Subject:MIME-Version:Message-Id:In-Reply-To:To:Cc:
	 Content-Type:References; b=IVnbvoEVwP3IOIIkjbicSfAlvlEOfvi5RdHW1yUsV/OsTs8DQh5rZDRDf4SfJqNrZ+CdPDMsI3Onl61Q3NH+CPRSA3IInCEkQJDPe3qtWFavskuchuItWJUjKG00TZPipu7gdbUzfBENqF1wYFsLFRoxYKx+CpuL0XZffNtDsIc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=samsung.com; spf=pass smtp.mailfrom=samsung.com; dkim=pass (1024-bit key) header.d=samsung.com header.i=@samsung.com header.b=dCo4LnRW; arc=none smtp.client-ip=210.118.77.11
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=samsung.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=samsung.com
Received: from eucas1p2.samsung.com (unknown [182.198.249.207])
	by mailout1.w1.samsung.com (KnoxPortal) with ESMTP id 20250529222410euoutp01c6e5eb0971f84d3a18d84bdd2ff67d11~EH7yc7t7V2316223162euoutp014
	for <linux-pm@vger.kernel.org>; Thu, 29 May 2025 22:24:10 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout1.w1.samsung.com 20250529222410euoutp01c6e5eb0971f84d3a18d84bdd2ff67d11~EH7yc7t7V2316223162euoutp014
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
	s=mail20170921; t=1748557450;
	bh=iDKUS4/W4anCMc9efhu9LJv9bqq+RveQHjm6X16x1K4=;
	h=From:Date:Subject:In-Reply-To:To:Cc:References:From;
	b=dCo4LnRWzbECCNOWoukauv0ANlBhHJGWGXYMXYvikk5a8fbpA1qqD2GfAAXzBWOys
	 rsr1Zpl2JWu8UR1d44jOInxEDiWWpMxh+NJogCbgflXUJkfHDhKcGj7luBt/iHCwvY
	 VfsgcaTRGxvXbIj4WJKpF2+BzBGZc854MbzVF70Q=
Received: from eusmtip2.samsung.com (unknown [203.254.199.222]) by
	eucas1p2.samsung.com (KnoxPortal) with ESMTPA id
	20250529222408eucas1p20f62cea4c9c64bb5dda6db1fd38fb333~EH7xQ4-m70456404564eucas1p2V;
	Thu, 29 May 2025 22:24:08 +0000 (GMT)
Received: from AMDC4942.eu.corp.samsungelectronics.net (unknown
	[106.210.136.40]) by eusmtip2.samsung.com (KnoxPortal) with ESMTPA id
	20250529222408eusmtip20e45fce43476667b7407ee8364f8de8a~EH7wV181P2867928679eusmtip2V;
	Thu, 29 May 2025 22:24:07 +0000 (GMT)
From: Michal Wilczynski <m.wilczynski@samsung.com>
Date: Fri, 30 May 2025 00:23:53 +0200
Subject: [PATCH v3 6/8] riscv: dts: thead: Add GPU power sequencer node
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Message-Id: <20250530-apr_14_for_sending-v3-6-83d5744d997c@samsung.com>
In-Reply-To: <20250530-apr_14_for_sending-v3-0-83d5744d997c@samsung.com>
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
X-CMS-MailID: 20250529222408eucas1p20f62cea4c9c64bb5dda6db1fd38fb333
X-Msg-Generator: CA
Content-Type: text/plain; charset="utf-8"
X-RootMTR: 20250529222408eucas1p20f62cea4c9c64bb5dda6db1fd38fb333
X-EPHeader: CA
X-CMS-RootMailID: 20250529222408eucas1p20f62cea4c9c64bb5dda6db1fd38fb333
References: <20250530-apr_14_for_sending-v3-0-83d5744d997c@samsung.com>
	<CGME20250529222408eucas1p20f62cea4c9c64bb5dda6db1fd38fb333@eucas1p2.samsung.com>

Add the device tree node for the T-HEAD TH1520 GPU power sequencer
(gpu_pwrseq) to the th1520.dtsi file.

This node instantiates the thead,th1520-gpu-pwrseq driver, which
is responsible for managing the GPU's power-on/off sequence. The node
specifies the gpu-clkgen reset, which is one of the resources
controlled by this sequencer.

Signed-off-by: Michal Wilczynski <m.wilczynski@samsung.com>
---
 arch/riscv/boot/dts/thead/th1520.dtsi | 6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/arch/riscv/boot/dts/thead/th1520.dtsi b/arch/riscv/boot/dts/thead/th1520.dtsi
index bdbb1b985b0b76cf669a9bf40c6ec37258329056..6170eec79e919b606a2046ac8f52db07e47ef441 100644
--- a/arch/riscv/boot/dts/thead/th1520.dtsi
+++ b/arch/riscv/boot/dts/thead/th1520.dtsi
@@ -238,6 +238,12 @@ aon: aon {
 		#power-domain-cells = <1>;
 	};
 
+	gpu_pwrseq: pwrseq {
+		compatible = "thead,th1520-gpu-pwrseq";
+		resets = <&rst TH1520_RESET_ID_GPU_CLKGEN>;
+		reset-names = "gpu-clkgen";
+	};
+
 	soc {
 		compatible = "simple-bus";
 		interrupt-parent = <&plic>;

-- 
2.34.1


