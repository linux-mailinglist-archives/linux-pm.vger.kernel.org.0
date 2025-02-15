Return-Path: <linux-pm+bounces-22156-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 6595CA3713B
	for <lists+linux-pm@lfdr.de>; Sun, 16 Feb 2025 00:35:38 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id A15F87A3E8A
	for <lists+linux-pm@lfdr.de>; Sat, 15 Feb 2025 23:34:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2E0DD1A23A8;
	Sat, 15 Feb 2025 23:35:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=collabora.com header.i=nicolas.frattaroli@collabora.com header.b="jbPHXtKR"
X-Original-To: linux-pm@vger.kernel.org
Received: from sender4-op-o14.zoho.com (sender4-op-o14.zoho.com [136.143.188.14])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4D55442AA5;
	Sat, 15 Feb 2025 23:35:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=136.143.188.14
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739662529; cv=pass; b=jwDwnTvZjLPpYw/Xva1KB4g2rtGXoOUeTC9CYjrBqy4nLfdstXjBs8d4v3nxUlL7AzJHg4SnDMdN6QpOtE36sTbrm7uXj0PU3PswsSjqWbIKX7VO+MTUuGjJBsrUOss82NoHl9G/KKZjPaKpAo2qDBCSGXKfjBHl8It0C8tbp/w=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739662529; c=relaxed/simple;
	bh=3U34nazgbQM+gxbpQhKeoB2hzKFJEarbj37PvDzHW1w=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=WNd1IfXJMOVFAX8lwcTtqAjQ9wDvWtB6RyGixzmPnJK1Kp6YDYJYaLaCz+yPI+MWzH+zWH+JRtqBmNYfX9RP1QJ1HaX7RUHpmrh5FepbmwNyeeODu2F10jS80wjkCdNfnVWLNsQhfyvpjRF0EPnR8FRsmQshZGJ4EXBdQgqBzkQ=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=collabora.com; spf=pass smtp.mailfrom=collabora.com; dkim=pass (1024-bit key) header.d=collabora.com header.i=nicolas.frattaroli@collabora.com header.b=jbPHXtKR; arc=pass smtp.client-ip=136.143.188.14
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=collabora.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=collabora.com
ARC-Seal: i=1; a=rsa-sha256; t=1739662508; cv=none; 
	d=zohomail.com; s=zohoarc; 
	b=mbifMoSoMISXAR3xZXE43PYTb4VKgKz3cmubZVfwwT2VLJgOT22619GtQ8sidUBoPXi0Sko/Anpf+p5uar7g90Xe3Ztxunk3hAHVDTagAScw//nKcNeljvApYgOdaSU0gYe4GgkXADDA/TdUqUxGXe+EbA3ohQZ8NwR5YQfszMc=
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=zohomail.com; s=zohoarc; 
	t=1739662508; h=Content-Type:Content-Transfer-Encoding:Cc:Cc:Date:Date:From:From:In-Reply-To:MIME-Version:Message-ID:References:Subject:Subject:To:To:Message-Id:Reply-To; 
	bh=sbLLDWdkkmGg2gJ/dWXDp9NJrL5rckyuc1qaW2EiOzg=; 
	b=KUAoQz/q6ZiXs1LrledRyiwjuenPgJq1NSTzToxd5g+3XHObSDX3zabLyyWhMYGUoA2H4IjJiA5qC3nZ7erEjl9Fkbx+v0PUJpN3T7enOKcAc2ibH01fY/IbB78YNqGqJKr9iSkXIqFRSNkETeNFo51SGjBDRjpIvyMWP5cimYk=
ARC-Authentication-Results: i=1; mx.zohomail.com;
	dkim=pass  header.i=collabora.com;
	spf=pass  smtp.mailfrom=nicolas.frattaroli@collabora.com;
	dmarc=pass header.from=<nicolas.frattaroli@collabora.com>
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; t=1739662508;
	s=zohomail; d=collabora.com; i=nicolas.frattaroli@collabora.com;
	h=From:From:Date:Date:Subject:Subject:MIME-Version:Content-Type:Content-Transfer-Encoding:Message-Id:Message-Id:References:In-Reply-To:To:To:Cc:Cc:Reply-To;
	bh=sbLLDWdkkmGg2gJ/dWXDp9NJrL5rckyuc1qaW2EiOzg=;
	b=jbPHXtKR3x8zgy3OraOCzqKnb5xaJx6sWJxZLhDmx6BWw1Ma1PzwJDqA8ofG3pHy
	F24QkmqCJCQeHj2JuAVy4DgkdK9uuZFxGQOw6kjE29S07J5ne7VaKxxUJqWNNfB7Wc/
	A2pf+mdyOC46VtBThZRlGsnH6tv2UXN7L9a9T+tI=
Received: by mx.zohomail.com with SMTPS id 173966250691519.102304818019547;
	Sat, 15 Feb 2025 15:35:06 -0800 (PST)
From: Nicolas Frattaroli <nicolas.frattaroli@collabora.com>
Date: Sun, 16 Feb 2025 00:34:50 +0100
Subject: [PATCH 1/6] dt-bindings: rockchip-thermal: Add RK3576 compatible
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250216-rk3576-tsadc-upstream-v1-1-6ec969322a14@collabora.com>
References: <20250216-rk3576-tsadc-upstream-v1-0-6ec969322a14@collabora.com>
In-Reply-To: <20250216-rk3576-tsadc-upstream-v1-0-6ec969322a14@collabora.com>
To: "Rafael J. Wysocki" <rafael@kernel.org>, 
 Daniel Lezcano <daniel.lezcano@linaro.org>, Zhang Rui <rui.zhang@intel.com>, 
 Lukasz Luba <lukasz.luba@arm.com>, Rob Herring <robh@kernel.org>, 
 Krzysztof Kozlowski <krzk+dt@kernel.org>, 
 Conor Dooley <conor+dt@kernel.org>, Heiko Stuebner <heiko@sntech.de>
Cc: Sebastian Reichel <sebastian.reichel@collabora.com>, 
 kernel@collabora.com, linux-pm@vger.kernel.org, devicetree@vger.kernel.org, 
 linux-arm-kernel@lists.infradead.org, linux-rockchip@lists.infradead.org, 
 linux-kernel@vger.kernel.org, 
 Nicolas Frattaroli <nicolas.frattaroli@collabora.com>
X-Mailer: b4 0.14.2

Add a new compatible for the thermal sensor device on the RK3576 SoC.

Signed-off-by: Nicolas Frattaroli <nicolas.frattaroli@collabora.com>
---
 Documentation/devicetree/bindings/thermal/rockchip-thermal.yaml | 1 +
 1 file changed, 1 insertion(+)

diff --git a/Documentation/devicetree/bindings/thermal/rockchip-thermal.yaml b/Documentation/devicetree/bindings/thermal/rockchip-thermal.yaml
index b717ea8261ca24ebaf709f410ec6372de1366b8a..49ceed68c92ce5a32ed8d4f39bd88fd052de0e80 100644
--- a/Documentation/devicetree/bindings/thermal/rockchip-thermal.yaml
+++ b/Documentation/devicetree/bindings/thermal/rockchip-thermal.yaml
@@ -21,6 +21,7 @@ properties:
       - rockchip,rk3368-tsadc
       - rockchip,rk3399-tsadc
       - rockchip,rk3568-tsadc
+      - rockchip,rk3576-tsadc
       - rockchip,rk3588-tsadc
       - rockchip,rv1108-tsadc
 

-- 
2.48.1


