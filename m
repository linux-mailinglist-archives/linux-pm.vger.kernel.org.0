Return-Path: <linux-pm+bounces-27285-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 4A506ABB20E
	for <lists+linux-pm@lfdr.de>; Mon, 19 May 2025 00:08:43 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 180651895F47
	for <lists+linux-pm@lfdr.de>; Sun, 18 May 2025 22:08:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D0E5D212B05;
	Sun, 18 May 2025 22:07:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kwiboo.se header.i=@kwiboo.se header.b="zUKPttTg"
X-Original-To: linux-pm@vger.kernel.org
Received: from smtp.forwardemail.net (smtp.forwardemail.net [149.28.215.223])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 26863211497
	for <linux-pm@vger.kernel.org>; Sun, 18 May 2025 22:07:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=149.28.215.223
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747606076; cv=none; b=czaOgOje4pqw1p3JoGkgOUiIouOup/D+LCEDULYWHTdsZTOGUHVZBNJm1y1GZ+SVSrnWLVQGRAJZM0asEFlAOh837s8nf8le65SQkuoHg3BLG5bSfXZOmA8zTA2zk/auhAfJDMi56VUErgi62QxYn7SL7Eufy5iJ7V4oUdD8GgU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747606076; c=relaxed/simple;
	bh=NI8ZpKqVeT2O0wYKWvr00l6EYFZUEguyKS4NdA4QyWs=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=jJpCC9nas3Zq719MbgfDQYmiT3l1pv7eYhTCM6MRDsfn6hCIWpkAFId4MQN3KNXeACd1RTi3rjHe+lx+D6jZ/4z38VO5D6AWaDjC1eHp5jyknD+a9y1bbg+6zQhaKKNfB7Xrqep4+AyqBzK4MrEejZQTs1amCvALmxN3VdurcNM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=kwiboo.se; spf=pass smtp.mailfrom=fe-bounces.kwiboo.se; dkim=pass (2048-bit key) header.d=kwiboo.se header.i=@kwiboo.se header.b=zUKPttTg; arc=none smtp.client-ip=149.28.215.223
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=kwiboo.se
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=fe-bounces.kwiboo.se
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kwiboo.se;
 h=Content-Transfer-Encoding: MIME-Version: References: In-Reply-To:
 Message-ID: Date: Subject: Cc: To: From; q=dns/txt; s=fe-e1b5cab7be;
 t=1747606074; bh=EMpzWrkVyV6vMCT5CK0scK0XhgFMcmSqXuqMq+/6SaA=;
 b=zUKPttTgWYJJhNfLn+HjO0H5AvKkd30UExTpo/psAG1ek3CLqHZrqSHTQBN9R/avQVNiAHbYQ
 R27vLIJo6h8p5AbR8iRcDdTdthTZ5rjrhx3CBdS2jm2jxvPQpTqpNnbzGS1kK2OHRrZfRKQ9o5J
 sMdfu/urLqncVtLUBAGfkTCW2nrweQ1fkdw0ZJiJA+7sJq5iOCYt/OO6uJP2/5110jTa2mU2Mh2
 SUNuPTQJeZpAoAZIvitRcATf5agNIaulEJVqGnD976/bc9wUXbpA5DfXMBT9MNPkv/Oh6rLblHo
 5NQvZc2bL/j5VnwTgkAlXdGWIgz10FUsWrIlBilKrKdA==
X-Forward-Email-ID: 682a5a3378cae75fbd8d4719
X-Forward-Email-Sender: rfc822; jonas@kwiboo.se, smtp.forwardemail.net,
 149.28.215.223
X-Forward-Email-Version: 1.0.3
X-Forward-Email-Website: https://forwardemail.net
X-Complaints-To: abuse@forwardemail.net
X-Report-Abuse: abuse@forwardemail.net
X-Report-Abuse-To: abuse@forwardemail.net
From: Jonas Karlman <jonas@kwiboo.se>
To: Heiko Stuebner <heiko@sntech.de>,
	Ulf Hansson <ulf.hansson@linaro.org>,
	Jonathan Cameron <jic23@kernel.org>,
	David Lechner <dlechner@baylibre.com>,
	=?UTF-8?q?Nuno=20S=C3=A1?= <nuno.sa@analog.com>,
	Andy Shevchenko <andy@kernel.org>,
	Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>
Cc: Yao Zi <ziyao@disroot.org>,
	Chukun Pan <amadeus@jmu.edu.cn>,
	linux-rockchip@lists.infradead.org,
	linux-pm@vger.kernel.org,
	devicetree@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org,
	Jonas Karlman <jonas@kwiboo.se>,
	linux-iio@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH 8/9] dt-bindings: iio: adc: rockchip-saradc: Allow use of a power-domain
Date: Sun, 18 May 2025 22:06:55 +0000
Message-ID: <20250518220707.669515-9-jonas@kwiboo.se>
X-Mailer: git-send-email 2.49.0
In-Reply-To: <20250518220707.669515-1-jonas@kwiboo.se>
References: <20250518220707.669515-1-jonas@kwiboo.se>
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The SARADC controller in most Rockchip SoCs are part or power domains
that are always powered on, i.e. PD_BUS or PD_PERI.

On RK3528 the SARADC controller is part of the PD_VPU power domain.

Add support to describe power-domains for the SARADC controllers.

Signed-off-by: Jonas Karlman <jonas@kwiboo.se>
---
 Documentation/devicetree/bindings/iio/adc/rockchip-saradc.yaml | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/Documentation/devicetree/bindings/iio/adc/rockchip-saradc.yaml b/Documentation/devicetree/bindings/iio/adc/rockchip-saradc.yaml
index 41e0c56ef8e3..f776041fd08f 100644
--- a/Documentation/devicetree/bindings/iio/adc/rockchip-saradc.yaml
+++ b/Documentation/devicetree/bindings/iio/adc/rockchip-saradc.yaml
@@ -47,6 +47,9 @@ properties:
       - const: saradc
       - const: apb_pclk
 
+  power-domains:
+    maxItems: 1
+
   resets:
     maxItems: 1
 
-- 
2.49.0


