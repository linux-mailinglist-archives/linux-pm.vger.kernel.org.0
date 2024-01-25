Return-Path: <linux-pm+bounces-2743-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 61F9683C6DD
	for <lists+linux-pm@lfdr.de>; Thu, 25 Jan 2024 16:35:23 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 049E41F24342
	for <lists+linux-pm@lfdr.de>; Thu, 25 Jan 2024 15:35:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BFCDA74E02;
	Thu, 25 Jan 2024 15:35:03 +0000 (UTC)
X-Original-To: linux-pm@vger.kernel.org
Received: from baptiste.telenet-ops.be (baptiste.telenet-ops.be [195.130.132.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B450273192
	for <linux-pm@vger.kernel.org>; Thu, 25 Jan 2024 15:35:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.130.132.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706196903; cv=none; b=NM3oV4BliC1tQSyX4aeGSzfgAQT0/HoHXzEslJ384fbbKifefdOAXfgn9rxqrEDVTvRJwvDDaHzpgb68DoqYC4C35hx1kWRjyJtb+OuaWGSYYfBpj4xD0sZL8W7DNt9tvUKQbupH0+1g0mfRmxJE7tMNM7PRrJNVK3WEtwr6TkI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706196903; c=relaxed/simple;
	bh=7k0+BPt755vhBCbjrPSf56+yw3Lv4ac5eXyCUnlz+rQ=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=FYTvP0slnrX767QGWsKzXFrjm8DFY9oAU7Nx4SjW7MLKQcMh7UaLNE1tfl1hMHpM+DHG0NFlI5+XxXc95lxmFFw7USfDORIwJrZ77yytGk9m8m5IxHBWnofp06JIo5lVsuCi1Hw8TZpp3f8AVj/VzoKF5KgQXueXijz5YdZXOXg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=glider.be; spf=none smtp.mailfrom=linux-m68k.org; arc=none smtp.client-ip=195.130.132.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=glider.be
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux-m68k.org
Received: from ramsan.of.borg ([IPv6:2a02:1810:ac12:ed40:bc9e:fcb8:8aa3:5dc0])
	by baptiste.telenet-ops.be with bizsmtp
	id f3am2B00258agq2013amrl; Thu, 25 Jan 2024 16:34:58 +0100
Received: from rox.of.borg ([192.168.97.57])
	by ramsan.of.borg with esmtp (Exim 4.95)
	(envelope-from <geert@linux-m68k.org>)
	id 1rT1jo-00GUvq-37;
	Thu, 25 Jan 2024 16:34:46 +0100
Received: from geert by rox.of.borg with local (Exim 4.95)
	(envelope-from <geert@linux-m68k.org>)
	id 1rT1kc-00Fs2g-2K;
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
	Conor Dooley <conor.dooley@microchip.com>,
	Wolfram Sang <wsa+renesas@sang-engineering.com>
Subject: [PATCH v2 06/15] dt-bindings: soc: renesas: Document R-Car V4M Gray Hawk Single
Date: Thu, 25 Jan 2024 16:34:34 +0100
Message-Id: <1065a81afb8dbed09b0098b51dc7fb22da421a97.1706194617.git.geert+renesas@glider.be>
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

Document the compatible values for the Renesas R-Car V4M (R8A779H0) SoC
and the Renesas Gray Hawk Single development board.

Signed-off-by: Geert Uytterhoeven <geert+renesas@glider.be>
Acked-by: Conor Dooley <conor.dooley@microchip.com>
Reviewed-by: Wolfram Sang <wsa+renesas@sang-engineering.com>
---
v2:
  - Add Acked-by, Reviewed-by,
  - Add "board" to compatible comment.

The Gray Hawk Single board is an integrated variant of the (not yet
supported) Gray Hawk board stack, which is very similar to the White
Hawk board stack.
---
 Documentation/devicetree/bindings/soc/renesas/renesas.yaml | 6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/Documentation/devicetree/bindings/soc/renesas/renesas.yaml b/Documentation/devicetree/bindings/soc/renesas/renesas.yaml
index 15b9dd52938996f4..1a228dd4822ccda2 100644
--- a/Documentation/devicetree/bindings/soc/renesas/renesas.yaml
+++ b/Documentation/devicetree/bindings/soc/renesas/renesas.yaml
@@ -361,6 +361,12 @@ properties:
           - const: renesas,white-hawk-cpu
           - const: renesas,r8a779g0
 
+      - description: R-Car V4M (R8A779H0)
+        items:
+          - enum:
+              - renesas,gray-hawk-single # Gray Hawk Single board (RTP8A779H0ASKB0F10S)
+          - const: renesas,r8a779h0
+
       - description: R-Car H3e (R8A779M0)
         items:
           - enum:
-- 
2.34.1


