Return-Path: <linux-pm+bounces-4376-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 95233862B6A
	for <lists+linux-pm@lfdr.de>; Sun, 25 Feb 2024 17:08:02 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 4E411281A6A
	for <lists+linux-pm@lfdr.de>; Sun, 25 Feb 2024 16:08:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1F299168DE;
	Sun, 25 Feb 2024 16:07:58 +0000 (UTC)
X-Original-To: linux-pm@vger.kernel.org
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C6DD91758E;
	Sun, 25 Feb 2024 16:07:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708877278; cv=none; b=Ch3WLixCtl5IUv6U/YnKDZzi1QKhPBSZET3vm+J5orV/QF0B4PPZqVlOI6SBS1ur5/LKtCO+MIczVt2KFmERCqntfe3GuQh7BZBc6CaYWrJgRuHPw4lMJUZLB07iReUjJkd6cU5k2U/LUTUkY7FCZD58gynVzbMdLV2DnRJGdqQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708877278; c=relaxed/simple;
	bh=9eVf+dLCV/gAeiuLnMXIrWtXA4B8CEkB3FNsi7wdrTI=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=AtT2q4rhpTuhAezdF43/i7OhoN8ViLrO6F568MxNchhm0duFTXtLB8Mj+NunYrvScp3RuLR6YhvM/7XkD7hzFL3zn1Ak+xU8p9RpfMFR1APgKQTAfSGqgAbc/T3OP90UYoy+r1lN3Wzgu2UKyt38iCNUDrmPLAtZU24+7HFaqJ4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id ABD161042;
	Sun, 25 Feb 2024 08:08:27 -0800 (PST)
Received: from localhost.localdomain (unknown [172.31.20.19])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 387273F73F;
	Sun, 25 Feb 2024 08:07:47 -0800 (PST)
From: Andre Przywara <andre.przywara@arm.com>
To: Ulf Hansson <ulf.hansson@linaro.org>,
	Jernej Skrabec <jernej.skrabec@gmail.com>,
	Chen-Yu Tsai <wens@csie.org>,
	Samuel Holland <samuel@sholland.org>,
	Michael Turquette <mturquette@baylibre.com>,
	Stephen Boyd <sboyd@kernel.org>
Cc: linux-clk@vger.kernel.org,
	linux-pm@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org,
	linux-sunxi@lists.linux.dev
Subject: [RFC PATCH 0/1] sunxi: H616: add GPU power domain driver
Date: Sun, 25 Feb 2024 16:06:15 +0000
Message-Id: <20240225160616.15001-1-andre.przywara@arm.com>
X-Mailer: git-send-email 2.35.8
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The Allwinner provided BSP code and experiments show that the Mali GPU
on the Allwinner H616 SoC needs to have a bit in one PRCM register
cleared to work. In the WIP graphics support patches, this was typically
covered by a U-Boot one-liner hack.

This patch here adds a proper power-domain driver for this one bit.
Since "power-domains" is a generic DT property, it already works on the
Panfrost driver side, without extra code. Said register is in the PRCM
MMIO range, which we already use in the R-CCU driver, so add the power
domain registration code there.
I mark this as RFC to get answers to some questions. Once people are
happy with the approach, I will send out a proper series with the
respective Kconfig and DT patches.

- Is modelling this as a power domain the right approach in the first
  place? Is that maybe just another reset bit? The logic seems backwards
  for that (bit set = disabled), but who knows?
- Is embedding this in the R-CCU driver the right way? I also have a
  version for a standalone driver in a separate file, but we have to
  artificially split the MMIO region to not conflict with the R-CCU
  driver, which looks arbitrary. If anyone has any information about
  the PRCM (register map), it would help to make an informed decision.
- Experiments in U-Boot identify bit 0 in 0x7010260 as behaving similar
  as our bit 0 in 0x7010254 here, so chances are there is another power
  domain for some other peripheral nearby. Also bits 0x7010250[9:0] are
  writable and stick, with setting bit 2 hanging the chip. So to allow
  further extensions without breaking compatibility, I made this a
  one-cell power domain ("power-domains = <&r_ccu 0>;"). Please let me
  know if this sounds overkill and a simple ("no cell") approach would be
  better.
- This patch makes the R-CCU driver dependent on CONFIG_PM. Shall we model
  this is a simple "select" or "depends on" in Kconfig, or shall the code
  be made conditional in the R-CCU driver, to allow compilation without
  PM support enabled?
- Shall any failure in registering the PPU driver also abort the R-CCU
  probe? Or do we treat this as optional?

I'd be grateful for any feedback.

Cheers,
Andre

Andre Przywara (1):
  clk: sunxi-ng: h6-r: add GPU power domain

 drivers/clk/sunxi-ng/ccu-sun50i-h6-r.c | 84 ++++++++++++++++++++++++++
 1 file changed, 84 insertions(+)

-- 
2.35.8


