Return-Path: <linux-pm+bounces-2746-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 4793E83C6E5
	for <lists+linux-pm@lfdr.de>; Thu, 25 Jan 2024 16:35:33 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 7AB301C216C3
	for <lists+linux-pm@lfdr.de>; Thu, 25 Jan 2024 15:35:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4367574E1A;
	Thu, 25 Jan 2024 15:35:04 +0000 (UTC)
X-Original-To: linux-pm@vger.kernel.org
Received: from xavier.telenet-ops.be (xavier.telenet-ops.be [195.130.132.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 426657319E
	for <linux-pm@vger.kernel.org>; Thu, 25 Jan 2024 15:35:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.130.132.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706196904; cv=none; b=Mz545M8Evzi3C9vzWpeBSeqxRMbT9YQexIdEJDetboVYdMUPiAcUAv9/HUS8Jp14qx3x7c8lFH5GpP0ITZ1c4aN4O0fpoCpi+Ni4ptpCOlzXC2wAL2fgOEZMwarfHs7IuVdSIB3tLkhupjX0c979U1G/dhdfYjkhc6gzXqKR6Ts=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706196904; c=relaxed/simple;
	bh=93GkKmd4fyfQi5SOpTnAYdsS7YxqGZvt4lLw8GcEVM0=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version:Content-Type; b=mI6+e2jrtapYaUJx93EO5bWVScisZjil9Wr7zJ9JndD+KmAv00x6uZR1BVokMUrYz6Uk3Phq2bwJil0Y4cAHQ99MM+btMt7n3ymXUYrEBEXsBqYFC6B5jHOq0pPPU6v9eMDFxPq5E2oVJrZkz1FhP1NSrS77A95CM5hDXBWLQ0A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=glider.be; spf=none smtp.mailfrom=linux-m68k.org; arc=none smtp.client-ip=195.130.132.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=glider.be
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux-m68k.org
Received: from ramsan.of.borg ([IPv6:2a02:1810:ac12:ed40:bc9e:fcb8:8aa3:5dc0])
	by xavier.telenet-ops.be with bizsmtp
	id f3am2B00858agq2013amcN; Thu, 25 Jan 2024 16:34:58 +0100
Received: from rox.of.borg ([192.168.97.57])
	by ramsan.of.borg with esmtp (Exim 4.95)
	(envelope-from <geert@linux-m68k.org>)
	id 1rT1jo-00GUvt-3q;
	Thu, 25 Jan 2024 16:34:46 +0100
Received: from geert by rox.of.borg with local (Exim 4.95)
	(envelope-from <geert@linux-m68k.org>)
	id 1rT1kc-00Fs2l-3A;
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
	=?UTF-8?q?Niklas=20S=C3=B6derlund?= <niklas.soderlund+renesas@ragnatech.se>,
	Wolfram Sang <wsa+renesas@sang-engineering.com>
Subject: [PATCH v2 07/15] clk: renesas: rcar-gen4: Add support for FRQCRC1
Date: Thu, 25 Jan 2024 16:34:35 +0100
Message-Id: <f64d5573a92a18505619ff0ff808d50cfc2bde55.1706194617.git.geert+renesas@glider.be>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <cover.1706194617.git.geert+renesas@glider.be>
References: <cover.1706194617.git.geert+renesas@glider.be>
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

R-Car V4H and V4M have a second Frequency Control Register C.
Add support for this by treating bit field offsets beyond 31 as
referring to the second register.

Signed-off-by: Geert Uytterhoeven <geert+renesas@glider.be>
Reviewed-by: Niklas Söderlund <niklas.soderlund+renesas@ragnatech.se>
Reviewed-by: Wolfram Sang <wsa+renesas@sang-engineering.com>
---
Tested by enabling CLOCK_ALLOW_WRITE_DEBUGFS and checking the impact of
CPU core clk rate on CPU core speed on R-Car V4M.

v2:
  - Add Reviewed-by.
---
 drivers/clk/renesas/rcar-gen4-cpg.c | 10 ++++++++--
 1 file changed, 8 insertions(+), 2 deletions(-)

diff --git a/drivers/clk/renesas/rcar-gen4-cpg.c b/drivers/clk/renesas/rcar-gen4-cpg.c
index 8f771fe59bfdc756..8e4559fbb0bc3352 100644
--- a/drivers/clk/renesas/rcar-gen4-cpg.c
+++ b/drivers/clk/renesas/rcar-gen4-cpg.c
@@ -220,7 +220,8 @@ static struct clk * __init cpg_pll_clk_register(const char *name,
  */
 #define CPG_FRQCRB			0x00000804
 #define CPG_FRQCRB_KICK			BIT(31)
-#define CPG_FRQCRC			0x00000808
+#define CPG_FRQCRC0			0x00000808
+#define CPG_FRQCRC1			0x000008e0
 
 struct cpg_z_clk {
 	struct clk_hw hw;
@@ -345,7 +346,12 @@ static struct clk * __init cpg_z_clk_register(const char *name,
 	init.parent_names = &parent_name;
 	init.num_parents = 1;
 
-	zclk->reg = reg + CPG_FRQCRC;
+	if (offset < 32) {
+		zclk->reg = reg + CPG_FRQCRC0;
+	} else {
+		zclk->reg = reg + CPG_FRQCRC1;
+		offset -= 32;
+	}
 	zclk->kick_reg = reg + CPG_FRQCRB;
 	zclk->hw.init = &init;
 	zclk->mask = GENMASK(offset + 4, offset);
-- 
2.34.1


