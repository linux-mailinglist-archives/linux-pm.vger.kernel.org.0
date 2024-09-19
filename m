Return-Path: <linux-pm+bounces-14452-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id BA4C097C6CC
	for <lists+linux-pm@lfdr.de>; Thu, 19 Sep 2024 11:19:09 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 7689F285A23
	for <lists+linux-pm@lfdr.de>; Thu, 19 Sep 2024 09:19:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4BE30199FC9;
	Thu, 19 Sep 2024 09:18:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=collabora.com header.i=@collabora.com header.b="AIZoFIXj"
X-Original-To: linux-pm@vger.kernel.org
Received: from bali.collaboradmins.com (bali.collaboradmins.com [148.251.105.195])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5153C19922E;
	Thu, 19 Sep 2024 09:18:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.251.105.195
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1726737521; cv=none; b=fgLE9Htc8yYG044tjhIQmi+0livmuRHWYrUoHRvYtN/Dwzs58fCjA3RCz/QOZzgzLA97UylHG76LD+fH776i0YsJA+vdEMXI64T1MJOKDPtp4JKqXmlCAEtmeBQd2Vsv8QIcWJUdqqBZY6ilDM81MdyKWpzf3LMZooCbhKCVJeo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1726737521; c=relaxed/simple;
	bh=bJez817c2m5RLP6sWTa3KX8AZeuQ47sU7hDMIpxChwE=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=rJgqMUpCQTZZZOduRFI2J3Qgit+R0JyeNt/n4rjjYwSRA61Ae+o+eoMpi55NH6QVBftXI2liZ3M+7WTJ8agyQDAaDkMgcpFPeO12JY6XyM/CgsGN8TUa1+OmxpKl9YG42bHT0K/pWds+TAhjq/tJbt5jAFsVg9StYWwPeL28aN0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=collabora.com; spf=pass smtp.mailfrom=collabora.com; dkim=pass (2048-bit key) header.d=collabora.com header.i=@collabora.com header.b=AIZoFIXj; arc=none smtp.client-ip=148.251.105.195
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=collabora.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=collabora.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
	s=mail; t=1726737516;
	bh=bJez817c2m5RLP6sWTa3KX8AZeuQ47sU7hDMIpxChwE=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=AIZoFIXjW8ogoEzg/z2qwQqgL19CBRs3kb9WY+L0e6aT2s/HVWr7DMNspYzf66ZQG
	 /D7Rg09y8+C8ox0jlXX5j31IX66EZhaN9xX8iLLNZHBZAUc125U+/D1S/Wej9Mz1vZ
	 gzJlPJZbSZ8/N3U9462xMDDQBx9aTWSrNh8WHBGs8dPbNkHOhrceWzC45IBLwFb/vF
	 sDI1xDjQ0kAga5iJHrwL9m3etTqZotKSpkafb/7wpmCG7TcXxDnNs9R8nw8SocDSN0
	 a8y8PN1k22E+B5BsSnSfQWGZg3sBzuAdY1kyoeOIFYuQJgEOjX95RoIyb24tnjIkYS
	 GioQsugI0thWQ==
Received: from jupiter.universe (dyndsl-091-248-208-160.ewe-ip-backbone.de [91.248.208.160])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits))
	(No client certificate requested)
	(Authenticated sender: sre)
	by bali.collaboradmins.com (Postfix) with ESMTPSA id 86D6217E1091;
	Thu, 19 Sep 2024 11:18:36 +0200 (CEST)
Received: by jupiter.universe (Postfix, from userid 1000)
	id 5DE28480086; Thu, 19 Sep 2024 11:18:36 +0200 (CEST)
From: Sebastian Reichel <sebastian.reichel@collabora.com>
To: Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Heiko Stuebner <heiko@sntech.de>,
	Ulf Hansson <ulf.hansson@linaro.org>
Cc: Elaine Zhang <zhangqing@rock-chips.com>,
	=?UTF-8?q?Adri=C3=A1n=20Mart=C3=ADnez=20Larumbe?= <adrian.larumbe@collabora.com>,
	Boris Brezillon <boris.brezillon@collabora.com>,
	Chen-Yu Tsai <wens@csie.org>,
	devicetree@vger.kernel.org,
	linux-rockchip@lists.infradead.org,
	linux-kernel@vger.kernel.org,
	linux-pm@vger.kernel.org,
	Sebastian Reichel <sebastian.reichel@collabora.com>,
	kernel@collabora.com
Subject: [PATCH v2 4/6] dt-bindings: power: rockchip: add regulator support
Date: Thu, 19 Sep 2024 11:12:45 +0200
Message-ID: <20240919091834.83572-5-sebastian.reichel@collabora.com>
X-Mailer: git-send-email 2.45.2
In-Reply-To: <20240919091834.83572-1-sebastian.reichel@collabora.com>
References: <20240919091834.83572-1-sebastian.reichel@collabora.com>
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Add optional support for a voltage supply required to enable a
power domain. The binding follows the way it is handled by the
Mediatek binding to keep things consistent.

This will initially be used by the RK3588 GPU power domain, which
fails to be enabled when the GPU regulator is not enabled.

Reviewed-by: Heiko Stuebner <heiko@sntech.de>
Acked-by: Rob Herring (Arm) <robh@kernel.org>
Signed-off-by: Sebastian Reichel <sebastian.reichel@collabora.com>
---
 .../devicetree/bindings/power/rockchip,power-controller.yaml   | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/Documentation/devicetree/bindings/power/rockchip,power-controller.yaml b/Documentation/devicetree/bindings/power/rockchip,power-controller.yaml
index 0d5e999a58f1..0b4c5b174812 100644
--- a/Documentation/devicetree/bindings/power/rockchip,power-controller.yaml
+++ b/Documentation/devicetree/bindings/power/rockchip,power-controller.yaml
@@ -131,6 +131,9 @@ $defs:
           A number of phandles to clocks that need to be enabled
           while power domain switches state.
 
+      domain-supply:
+        description: domain regulator supply.
+
       pm_qos:
         $ref: /schemas/types.yaml#/definitions/phandle-array
         items:
-- 
2.45.2


