Return-Path: <linux-pm+bounces-16799-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 6B2399B74F9
	for <lists+linux-pm@lfdr.de>; Thu, 31 Oct 2024 08:04:59 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 9CC3C1C21F27
	for <lists+linux-pm@lfdr.de>; Thu, 31 Oct 2024 07:04:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 016B91714D3;
	Thu, 31 Oct 2024 07:03:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=epochal.quest header.i=@epochal.quest header.b="jskWGbQg"
X-Original-To: linux-pm@vger.kernel.org
Received: from thales.epochal.quest (thales.epochal.quest [51.222.15.28])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 165E714F9F8;
	Thu, 31 Oct 2024 07:03:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=51.222.15.28
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730358216; cv=none; b=kCa6YNw7VOlHtpQLBPBZDo1ZTBLxG2wt3zD6XVO1Ha/iFxK0ZiVrWfusm29rvjdZMM0gomPMWgdg/SITLeCT32JefLKPjvfCl9v4+oodCQdSVr7aKh7+LsqGG9gmBuj5BdesaFpWtMhn5xzz7GxPmHzp7sea4bPAswcB1B9VqI8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730358216; c=relaxed/simple;
	bh=wUIk/mmpLDWeouMgYhaf2tgEePqBaUSdmwuO0VnKGzM=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=ABraNEJ7ieuJQtt37/OKhN0q0ITZBnmyFNFx+iRY1fOaOr2W43KIeehvp8wAnd55z71TCAuqiFYnYdrK4gjL55vWaZDHtPliaQwSMqenSERByQq8HuGVz39m6oEx+zV/vF9RZvof/QYggU/Q7ylsxXY0D2MASbL5n0zQXaijtko=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=epochal.quest; spf=pass smtp.mailfrom=epochal.quest; dkim=pass (2048-bit key) header.d=epochal.quest header.i=@epochal.quest header.b=jskWGbQg; arc=none smtp.client-ip=51.222.15.28
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=epochal.quest
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=epochal.quest
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=epochal.quest;
	s=default; t=1730358206;
	bh=wUIk/mmpLDWeouMgYhaf2tgEePqBaUSdmwuO0VnKGzM=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=jskWGbQg985yW0BZQQi3CQ6hHJO7+HaROsZ9qZhwlh0HMYwlM2bxzF4bNP3vOOeAj
	 nPp/7UkifmYOJwkcAWsDz8hbJ/yFPkodWVwzlipNZymcQFY+V8p5J8HQN1ZPvpd9Kt
	 fzgk1sBLInXwNycHN2ctK5f11Z6Uq0qrWGaEM5DB9khCN6b9pW1PMaUEt0Vpmfd2cb
	 VKFbEu/ezqvXUNON81kfrJ30xwXHzGq/crovPoVgLSUQ/+xkzC46tvCmjeLY9SFsww
	 TdO8cRGL4ZJGYxB19YcSHlpj4xj7iaTpwJo/8CM4n/DWCzuDzceuHmoqMm1mhs1wTN
	 LyEwBimJgmc9Q==
X-Virus-Scanned: by epochal.quest
From: Cody Eksal <masterr3c0rd@epochal.quest>
To: Yangtao Li <tiny.windzz@gmail.com>,
	Viresh Kumar <vireshk@kernel.org>,
	Nishanth Menon <nm@ti.com>,
	Stephen Boyd <sboyd@kernel.org>,
	Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Chen-Yu Tsai <wens@csie.org>,
	Jernej Skrabec <jernej.skrabec@gmail.com>,
	Samuel Holland <samuel@sholland.org>,
	Maxime Ripard <mripard@kernel.org>
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Kishon Vijay Abraham I <kishon@kernel.org>,
	Michael Turquette <mturquette@baylibre.com>,
	"Rafael J. Wysocki" <rafael@kernel.org>,
	Vinod Koul <vkoul@kernel.org>,
	Viresh Kumar <viresh.kumar@linaro.org>,
	Parthiban <parthiban@linumiz.com>,
	Andre Przywara <andre.przywara@arm.com>,
	Cody Eksal <masterr3c0rd@epochal.quest>,
	linux-pm@vger.kernel.org,
	devicetree@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org,
	linux-sunxi@lists.linux.dev,
	linux-kernel@vger.kernel.org
Subject: [PATCH v2 11/13] dt-bindings: opp: h6: Add A100 operating points
Date: Thu, 31 Oct 2024 04:02:24 -0300
Message-ID: <20241031070232.1793078-12-masterr3c0rd@epochal.quest>
X-Mailer: git-send-email 2.47.0
In-Reply-To: <20241031070232.1793078-1-masterr3c0rd@epochal.quest>
References: <20241031070232.1793078-1-masterr3c0rd@epochal.quest>
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The A100, similar to the H6 and H616, use an NVMEM value to determine
speed binnings. The method used is similar to that of the H6. However,
the information is stored at a slightly different bit offset.

Add a new compatible for the A100.

Signed-off-by: Cody Eksal <masterr3c0rd@epochal.quest>
---
Changes in V2:
 - Fix ordering of compatibles

 .../bindings/opp/allwinner,sun50i-h6-operating-points.yaml       | 1 +
 1 file changed, 1 insertion(+)

diff --git a/Documentation/devicetree/bindings/opp/allwinner,sun50i-h6-operating-points.yaml b/Documentation/devicetree/bindings/opp/allwinner,sun50i-h6-operating-points.yaml
index ec5e424bb3c8..75ab552f6ecd 100644
--- a/Documentation/devicetree/bindings/opp/allwinner,sun50i-h6-operating-points.yaml
+++ b/Documentation/devicetree/bindings/opp/allwinner,sun50i-h6-operating-points.yaml
@@ -22,6 +22,7 @@ allOf:
 properties:
   compatible:
     enum:
+      - allwinner,sun50i-a100-operating-points
       - allwinner,sun50i-h6-operating-points
       - allwinner,sun50i-h616-operating-points
 
-- 
2.47.0


