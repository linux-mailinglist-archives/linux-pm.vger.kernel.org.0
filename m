Return-Path: <linux-pm+bounces-2745-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 3A2C083C6E3
	for <lists+linux-pm@lfdr.de>; Thu, 25 Jan 2024 16:35:30 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id E84AF295304
	for <lists+linux-pm@lfdr.de>; Thu, 25 Jan 2024 15:35:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2263274E17;
	Thu, 25 Jan 2024 15:35:04 +0000 (UTC)
X-Original-To: linux-pm@vger.kernel.org
Received: from albert.telenet-ops.be (albert.telenet-ops.be [195.130.137.90])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B9C457317F
	for <linux-pm@vger.kernel.org>; Thu, 25 Jan 2024 15:34:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.130.137.90
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706196904; cv=none; b=DH6vR4nZ5/2cYxrU49Opln/HC/uvI8iJnOXJ4qFGYlJn4HiB89vOGd4bxGxXJPQL1NEhdIhzbBnaCp+6uZqq49VvSR+cRKk9c64sTYTSLm9S7z/pvL7IabZbIglyItvq05vLB0noO1+H94mA5DBVTlpk47Frl0/NEnTHrvV7OO4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706196904; c=relaxed/simple;
	bh=miU3KgyoRL/DnHsCK7yuQkwQeANobdlCrfj7pCVoidc=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=cxMjpOz0MQyJcBtiMqX32cslD/1UQQd3n3tEYl96Ken7K9KqKWsNF6cNRrcXXZGdRJ3UBkBSgSJBpall6O+nMh3Vc1g5HUp6Ep37GFo1padBFbHa67yi8mR4FHH0rugXvHYR7xZncXX1Ae4bgnwcJ9E7cBLODsuZ2ihoUXsSarE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=glider.be; spf=none smtp.mailfrom=linux-m68k.org; arc=none smtp.client-ip=195.130.137.90
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=glider.be
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux-m68k.org
Received: from ramsan.of.borg ([IPv6:2a02:1810:ac12:ed40:bc9e:fcb8:8aa3:5dc0])
	by albert.telenet-ops.be with bizsmtp
	id f3am2B00L58agq2063am9W; Thu, 25 Jan 2024 16:34:57 +0100
Received: from rox.of.borg ([192.168.97.57])
	by ramsan.of.borg with esmtp (Exim 4.95)
	(envelope-from <geert@linux-m68k.org>)
	id 1rT1jo-00GUwE-8I;
	Thu, 25 Jan 2024 16:34:46 +0100
Received: from geert by rox.of.borg with local (Exim 4.95)
	(envelope-from <geert@linux-m68k.org>)
	id 1rT1kc-00Fs3A-7i;
	Thu, 25 Jan 2024 16:34:46 +0100
From: Geert Uytterhoeven <geert+renesas@glider.be>
To: Michael Turquette <mturquette@baylibre.com>,
	Stephen Boyd <sboyd@kernel.org>,
	Rob Herring <robh+dt@kernel.org>,
	Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Philipp Zabel <p.zabel@pengutronix.de>,
	Magnus Damm <magnus.damm@gmail.com>,
	Catalin Marinas <catalin.marinas@arm.com>,
	Will Deacon <will@kernel.org>,
	Ulf Hansson <ulf.hansson@linaro.org>
Cc: Cong Dang <cong.dang.xn@renesas.com>,
	Duy Nguyen <duy.nguyen.rh@renesas.com>,
	Hai Pham <hai.pham.ud@renesas.com>,
	Linh Phung <linh.phung.jy@renesas.com>,
	linux-renesas-soc@vger.kernel.org,
	linux-clk@vger.kernel.org,
	devicetree@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org,
	linux-pm@vger.kernel.org,
	Geert Uytterhoeven <geert+renesas@glider.be>,
	Wolfram Sang <wsa+renesas@sang-engineering.com>
Subject: [PATCH v2 12/15] soc: renesas: rcar-rst: Add support for R-Car V4M
Date: Thu, 25 Jan 2024 16:34:40 +0100
Message-Id: <13dc9f014e27db5092b3cc23edddf4b5e01a6645.1706194617.git.geert+renesas@glider.be>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <cover.1706194617.git.geert+renesas@glider.be>
References: <cover.1706194617.git.geert+renesas@glider.be>
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Duy Nguyen <duy.nguyen.rh@renesas.com>

Add support for the R-Car V4M (R8A779H0) SoC to the R-Car RST driver.

Signed-off-by: Duy Nguyen <duy.nguyen.rh@renesas.com>
Signed-off-by: Geert Uytterhoeven <geert+renesas@glider.be>
Reviewed-by: Wolfram Sang <wsa+renesas@sang-engineering.com>
---
Early firmware versions may not enable WDT resets, so you may need to do
s/rcar_rst_gen4/rcar_rst_v3u/ for testing.

v2:
  - Add Reviewed-by.
---
 drivers/soc/renesas/rcar-rst.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/soc/renesas/rcar-rst.c b/drivers/soc/renesas/rcar-rst.c
index 98fd97da6cd4330d..7ba02f3a4a4fbb9f 100644
--- a/drivers/soc/renesas/rcar-rst.c
+++ b/drivers/soc/renesas/rcar-rst.c
@@ -117,6 +117,7 @@ static const struct of_device_id rcar_rst_matches[] __initconst = {
 	{ .compatible = "renesas,r8a779a0-rst", .data = &rcar_rst_v3u },
 	{ .compatible = "renesas,r8a779f0-rst", .data = &rcar_rst_gen4 },
 	{ .compatible = "renesas,r8a779g0-rst", .data = &rcar_rst_gen4 },
+	{ .compatible = "renesas,r8a779h0-rst", .data = &rcar_rst_gen4 },
 	{ /* sentinel */ }
 };
 
-- 
2.34.1


