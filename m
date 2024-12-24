Return-Path: <linux-pm+bounces-19737-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 1A8FD9FBC1E
	for <lists+linux-pm@lfdr.de>; Tue, 24 Dec 2024 11:22:41 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id D02A01635D9
	for <lists+linux-pm@lfdr.de>; Tue, 24 Dec 2024 10:16:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E5BF81AF0CB;
	Tue, 24 Dec 2024 10:15:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=rock-chips.com header.i=@rock-chips.com header.b="imNGrpl1"
X-Original-To: linux-pm@vger.kernel.org
Received: from mail-m49230.qiye.163.com (mail-m49230.qiye.163.com [45.254.49.230])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 436541946A1;
	Tue, 24 Dec 2024 10:15:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.254.49.230
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1735035357; cv=none; b=gwzcOKFrfwLvR2G2sVLuedBRvg1pjwle1Yb8gnPQ/co9wmRU5BlAHYtY0JYjtiNKvIMWpx/EviAjEwIfw9KcneOSo7yILO4+XLmuoeI/VRwPnrRBw+Uf304ZuHytkfCNS4bZ4xMIfsKxFVjFmtNrQONavXDGJowfNDRPWFoDxVs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1735035357; c=relaxed/simple;
	bh=4BZY+XP9HwsIho6izf12WfdDWvxkNw0NmnYZTnXU9u0=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=mZnzZ1h6pgCQ9BBkRo2q5K5qXVGKm4lWHBwbR2ryc7r/DPYNpVKd2bYW/EyLIw17mk0pUtrDUof02VW6uQcla8QytyqWysA7RHuiGATQalSCecwHlZ06ric9UR2z4soy8x4Ya0qmqKLDTJaQt6G670DYSjpKdTn4EHzctW0SmiA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=rock-chips.com; spf=pass smtp.mailfrom=rock-chips.com; dkim=pass (1024-bit key) header.d=rock-chips.com header.i=@rock-chips.com header.b=imNGrpl1; arc=none smtp.client-ip=45.254.49.230
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=rock-chips.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=rock-chips.com
Received: from localhost.localdomain (unknown [58.22.7.114])
	by smtp.qiye.163.com (Hmail) with ESMTP id 6aa9051a;
	Tue, 24 Dec 2024 17:40:18 +0800 (GMT+08:00)
From: Kever Yang <kever.yang@rock-chips.com>
To: heiko@sntech.de
Cc: linux-rockchip@lists.infradead.org,
	Kever Yang <kever.yang@rock-chips.com>,
	devicetree@vger.kernel.org,
	Conor Dooley <conor+dt@kernel.org>,
	Rob Herring <robh@kernel.org>,
	Lukasz Luba <lukasz.luba@arm.com>,
	linux-pm@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Zhang Rui <rui.zhang@intel.com>,
	"Rafael J. Wysocki" <rafael@kernel.org>,
	linux-arm-kernel@lists.infradead.org,
	Daniel Lezcano <daniel.lezcano@linaro.org>
Subject: [PATCH 1/2] dt-bindings: rockchip-thermal: Support the RK3562 SoC compatible
Date: Tue, 24 Dec 2024 17:40:14 +0800
Message-Id: <20241224094015.3816301-1-kever.yang@rock-chips.com>
X-Mailer: git-send-email 2.25.1
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-HM-Spam-Status: e1kfGhgUHx5ZQUpXWQgPGg8OCBgUHx5ZQUlOS1dZFg8aDwILHllBWSg2Ly
	tZV1koWUFDSUNOT01LS0k3V1ktWUFJV1kPCRoVCBIfWUFZQkNDH1YdH0NLSh9IQxoeHU5WFRQJFh
	oXVRMBExYaEhckFA4PWVdZGBILWUFZTkNVSUlVTFVKSk9ZV1kWGg8SFR0UWUFZT0tIVUpLSU9PT0
	hVSktLVUpCS0tZBg++
X-HM-Tid: 0a93f809e51703afkunm6aa9051a
X-HM-MType: 1
X-HM-Sender-Digest: e1kMHhlZQR0aFwgeV1kSHx4VD1lBWUc6Pwg6HAw5DjIQGEoWFjlJMRAe
	DE4aCgxVSlVKTEhOS0hISUlLSklJVTMWGhIXVRAeDR4JVQIaFRw7CRQYEFYYExILCFUYFBZFWVdZ
	EgtZQVlOQ1VJSVVMVUpKT1lXWQgBWUFDSk03Bg++
DKIM-Signature:a=rsa-sha256;
	b=imNGrpl13fG1lpaN9pIzz3zYhTcgYxiySLeNX6PewZQwVSViJ6pK2/nwCngARHQbd90xbB9Cwn5TA6km2VCx/cbDwfjtAlfJtBHgL72AeHqiH1iIN5gur3bHENW7WeTJiFc37d01tZFD2KMZZPV8Fkayd42yi+a/cbo/9nPoFZA=; s=default; c=relaxed/relaxed; d=rock-chips.com; v=1;
	bh=GsM3e7XTMaEdnzl6LqqgFbWzKt5lpe2maRUf73VkOp4=;
	h=date:mime-version:subject:message-id:from;

Add a new compatible for tsadc on RK3562 SoCs.

Signed-off-by: Kever Yang <kever.yang@rock-chips.com>
---

 Documentation/devicetree/bindings/thermal/rockchip-thermal.yaml | 1 +
 1 file changed, 1 insertion(+)

diff --git a/Documentation/devicetree/bindings/thermal/rockchip-thermal.yaml b/Documentation/devicetree/bindings/thermal/rockchip-thermal.yaml
index b717ea8261ca..f55f2045fc84 100644
--- a/Documentation/devicetree/bindings/thermal/rockchip-thermal.yaml
+++ b/Documentation/devicetree/bindings/thermal/rockchip-thermal.yaml
@@ -20,6 +20,7 @@ properties:
       - rockchip,rk3328-tsadc
       - rockchip,rk3368-tsadc
       - rockchip,rk3399-tsadc
+      - rockchip,rk3562-tsadc
       - rockchip,rk3568-tsadc
       - rockchip,rk3588-tsadc
       - rockchip,rv1108-tsadc
-- 
2.25.1


