Return-Path: <linux-pm+bounces-27282-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 45A34ABB204
	for <lists+linux-pm@lfdr.de>; Mon, 19 May 2025 00:08:05 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 5FA8417447D
	for <lists+linux-pm@lfdr.de>; Sun, 18 May 2025 22:08:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6741920C02E;
	Sun, 18 May 2025 22:07:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kwiboo.se header.i=@kwiboo.se header.b="GL2szQXj"
X-Original-To: linux-pm@vger.kernel.org
Received: from smtp.forwardemail.net (smtp.forwardemail.net [149.28.215.223])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B4A11205ACF
	for <linux-pm@vger.kernel.org>; Sun, 18 May 2025 22:07:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=149.28.215.223
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747606065; cv=none; b=ZaBz3DOE1RqaJDwGBx+KUa4KC8aDbzs1Fq4Hj3lmngWkHtUXxC0u4QtoZibYIpGqEZrrgFLsgM3xeT5E9Rm+8GHB+mHT3EqDBjhlfy35ZCYLEKG1Htbhot0tsc6Yby9xh1FjN+jUCa5r2NmAaLK4ggE0XScnaRVNLO7V812OTgk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747606065; c=relaxed/simple;
	bh=IaouxIHOdXcJtAHSznf8PEqezOyP8PmUvFtKqQi5Vbg=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=d3qPvaVn6sRlo4QDPiM8j7dJ/mQWuSVWCrQwU5upcZVvezi//xF1170WRdBKZq5o7I20o8RiU/Z7xHuuOAiQ/qh9bXNCgCKpmZAlCb7a/mnAzn6aD3VGaqiXdjnfjgNLw6v2KfJ4grQGjG+Dmwmgji/FueNgxhDDy0JyBbOqBcc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=kwiboo.se; spf=pass smtp.mailfrom=fe-bounces.kwiboo.se; dkim=pass (2048-bit key) header.d=kwiboo.se header.i=@kwiboo.se header.b=GL2szQXj; arc=none smtp.client-ip=149.28.215.223
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=kwiboo.se
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=fe-bounces.kwiboo.se
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kwiboo.se;
 h=Content-Transfer-Encoding: MIME-Version: References: In-Reply-To:
 Message-ID: Date: Subject: Cc: To: From; q=dns/txt; s=fe-e1b5cab7be;
 t=1747606063; bh=JlFCAc4M4tsY005AhENFwugyMYaX2j/qB+dCiJDYFXQ=;
 b=GL2szQXjO0PrkJBfC1+txCrU/nACX/HRo0oxTmrIMpkDPaKGUelggy0E1jz4WAtPFpnpvyoJL
 j0oP1KlUmeYDL7A6M0jbmbRfO+HsFLtEw/SYWNpQ9oqkTbzF+c/9rb+a7kIsJEpC6I7QBH59ocU
 H9GCDf2cbzRqJLxwFJuc22gTDnVHa02jF12tBBkssOl8JJl5Xsb+fyQZBVr8ypHVwOr/eL95bi8
 BHauZXd0hnGioB7SyvE5/4oFs/ttl199uxvz/U8MJtnPRSyeR0CrwUSWIAjmVrlh/OedV2Nej2K
 fz952nv/vBzO/VWC03RMBLQZkM+MN2qPlBa7E7ttXOpA==
X-Forward-Email-ID: 682a5a2a78cae75fbd8d46ef
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
	Linus Walleij <linus.walleij@linaro.org>,
	Bartosz Golaszewski <brgl@bgdev.pl>,
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
	linux-gpio@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH 6/9] dt-bindings: gpio: rockchip: Allow use of a power-domain
Date: Sun, 18 May 2025 22:06:53 +0000
Message-ID: <20250518220707.669515-7-jonas@kwiboo.se>
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

The GPIO controllers in most Rockchip SoCs are part or power domains
that are always powered on, i.e. PD_BUS or PD_PMU.

On RK3528 the GPIO controllers are spread out among the PD_RKVENC, PD_VO
and PD_VPU power domains.

Add support to describe power-domains for the GPIO controllers.

Signed-off-by: Jonas Karlman <jonas@kwiboo.se>
---
 Documentation/devicetree/bindings/gpio/rockchip,gpio-bank.yaml | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/Documentation/devicetree/bindings/gpio/rockchip,gpio-bank.yaml b/Documentation/devicetree/bindings/gpio/rockchip,gpio-bank.yaml
index d76987ce8e50..bdd83f42615c 100644
--- a/Documentation/devicetree/bindings/gpio/rockchip,gpio-bank.yaml
+++ b/Documentation/devicetree/bindings/gpio/rockchip,gpio-bank.yaml
@@ -41,6 +41,9 @@ properties:
   "#interrupt-cells":
     const: 2
 
+  power-domains:
+    maxItems: 1
+
 patternProperties:
   "^.+-hog(-[0-9]+)?$":
     type: object
-- 
2.49.0


