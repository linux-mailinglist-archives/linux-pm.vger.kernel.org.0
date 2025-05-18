Return-Path: <linux-pm+bounces-27289-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 21C57ABB22A
	for <lists+linux-pm@lfdr.de>; Mon, 19 May 2025 00:18:38 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id C5FD53B4980
	for <lists+linux-pm@lfdr.de>; Sun, 18 May 2025 22:18:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C26C720D506;
	Sun, 18 May 2025 22:18:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kwiboo.se header.i=@kwiboo.se header.b="udaYl8kp"
X-Original-To: linux-pm@vger.kernel.org
Received: from smtp.forwardemail.net (smtp.forwardemail.net [121.127.44.73])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6D5E91EB18A
	for <linux-pm@vger.kernel.org>; Sun, 18 May 2025 22:18:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=121.127.44.73
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747606698; cv=none; b=oMFFy8JFZhhyx41O22R0ps1UkYnUSEhrXIMDvtEUY4t6kuETGW18g5I/8tXXOO/lIU5BEaRHLLf/KlLtPt1u0g/zYyfU2eVqPm0xCJndtTG38tUOlYRruCdU5T2V2c9g55nIO8gjXhXkrCgXSqtB8US4Qmq51vDQ22d+lc1X63M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747606698; c=relaxed/simple;
	bh=DxKz006jwkGUBZM3BCh+gAyMS2rjqRfxwgG0kqz1dOE=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=rtGPmkt2PCFps16P4aPwGJaCjhWMU2cuDDvOP5C8RZCaBMovVtHPXeywlwwhLEr3mRGhOWRlUn3cvdII28cLeg2jT0m8p1cAm83kcmKAzBp6wFPhf9tQLPsfStA48gJxxHpLHbFEqvDOmS47wgl2Q74r5K2AtxTdE0RVmfTe17U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=kwiboo.se; spf=pass smtp.mailfrom=fe-bounces.kwiboo.se; dkim=pass (2048-bit key) header.d=kwiboo.se header.i=@kwiboo.se header.b=udaYl8kp; arc=none smtp.client-ip=121.127.44.73
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=kwiboo.se
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=fe-bounces.kwiboo.se
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kwiboo.se;
 h=Content-Transfer-Encoding: MIME-Version: References: In-Reply-To:
 Message-ID: Date: Subject: Cc: To: From; q=dns/txt; s=fe-e1b5cab7be;
 t=1747606694; bh=oLHfQ6GJDHKwJN9/gg2l7mvEQ/TXrvVecH6KzjJn08k=;
 b=udaYl8kp9DLTrNBd6v9cbdmxwOuvndeQJ58E8sf5pK0sXvLteasXshilo3NoTjuxoH38YPLfv
 Ckymm/WULqwDkDarAk/DUx2R2nuD0ccXZbscpow3FJQeG4mwVqVkpYMY2vUrz11+7MtFeykQwSH
 Pn2ljipSKgofsiHxnqeKErTGpWe42AYb3/m7DJsHeSoyoMaw4oKTELXv522avxQdDBaPZAfKxk7
 OFgmbcXor3oGor1rs9fJLbQNpiU80901K3bnabDdmysGpUyO8gpPsU0qLRBzgX25Tmy2AtbgiqJ
 7GQ+X5cStQn4/7mItv5p58whndBIp04USY96dX+jCaUQ==
X-Forward-Email-ID: 682a5a1e78cae75fbd8d46b0
X-Forward-Email-Sender: rfc822; jonas@kwiboo.se, smtp.forwardemail.net,
 121.127.44.73
X-Forward-Email-Version: 1.0.3
X-Forward-Email-Website: https://forwardemail.net
X-Complaints-To: abuse@forwardemail.net
X-Report-Abuse: abuse@forwardemail.net
X-Report-Abuse-To: abuse@forwardemail.net
From: Jonas Karlman <jonas@kwiboo.se>
To: Heiko Stuebner <heiko@sntech.de>,
	Ulf Hansson <ulf.hansson@linaro.org>,
	Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Elaine Zhang <zhangqing@rock-chips.com>
Cc: Yao Zi <ziyao@disroot.org>,
	Chukun Pan <amadeus@jmu.edu.cn>,
	linux-rockchip@lists.infradead.org,
	linux-pm@vger.kernel.org,
	devicetree@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org,
	Jonas Karlman <jonas@kwiboo.se>,
	linux-kernel@vger.kernel.org
Subject: [PATCH 3/9] dt-bindings: rockchip: pmu: Add compatible for RK3528
Date: Sun, 18 May 2025 22:06:50 +0000
Message-ID: <20250518220707.669515-4-jonas@kwiboo.se>
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

Add the compatible for the pmu mfd on RK3528 SoC.

Signed-off-by: Jonas Karlman <jonas@kwiboo.se>
---
 Documentation/devicetree/bindings/arm/rockchip/pmu.yaml | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/Documentation/devicetree/bindings/arm/rockchip/pmu.yaml b/Documentation/devicetree/bindings/arm/rockchip/pmu.yaml
index 46c1af851be7..55b2200d6e75 100644
--- a/Documentation/devicetree/bindings/arm/rockchip/pmu.yaml
+++ b/Documentation/devicetree/bindings/arm/rockchip/pmu.yaml
@@ -25,6 +25,7 @@ select:
           - rockchip,rk3288-pmu
           - rockchip,rk3368-pmu
           - rockchip,rk3399-pmu
+          - rockchip,rk3528-pmu
           - rockchip,rk3562-pmu
           - rockchip,rk3568-pmu
           - rockchip,rk3576-pmu
@@ -44,6 +45,7 @@ properties:
           - rockchip,rk3288-pmu
           - rockchip,rk3368-pmu
           - rockchip,rk3399-pmu
+          - rockchip,rk3528-pmu
           - rockchip,rk3562-pmu
           - rockchip,rk3568-pmu
           - rockchip,rk3576-pmu
-- 
2.49.0


