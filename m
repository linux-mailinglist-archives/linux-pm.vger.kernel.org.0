Return-Path: <linux-pm+bounces-25426-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 666BCA89297
	for <lists+linux-pm@lfdr.de>; Tue, 15 Apr 2025 05:39:57 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 749A31756F0
	for <lists+linux-pm@lfdr.de>; Tue, 15 Apr 2025 03:39:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 339DB218851;
	Tue, 15 Apr 2025 03:39:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=rock-chips.com header.i=@rock-chips.com header.b="N33YyMZq"
X-Original-To: linux-pm@vger.kernel.org
Received: from mail-m32117.qiye.163.com (mail-m32117.qiye.163.com [220.197.32.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DE07A21859F;
	Tue, 15 Apr 2025 03:39:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=220.197.32.117
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744688391; cv=none; b=ZY7SQDEfIC4eCvzrlVlUWNWiYnreM8xGidC+96VjBaCoSmWaS5dL7MFhecJW7aRj1S23cKL6rD2JZvqXTFHroJ0yIh8o2ETaJAwglq3NQnImYRa7nDZjJNY71srkybr45cYF/4u9dBN69qgzP6FMZD2FqDW+Rikai0+VEV2PzSU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744688391; c=relaxed/simple;
	bh=ADq8GedsFcLtR5YrIYxDPdZL5XrMmwc0SkTS6B6Fl2E=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=fyxR8u0/6wMZFRuOUXcUcFvObiQMMBGpSHIjJKMaSM/gdKD6gPWRvUgDWdko0xHXhCn/32PdBHY0O2h6oV7ynqNLAFp3O13HmhVzMVuQO0F68eztuiCSUEJj7SBPgVMUxYOP6NQg2MV7S9slCHKCbKKeX2AB9SYR89Q0LppBgP4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=rock-chips.com; spf=pass smtp.mailfrom=rock-chips.com; dkim=pass (1024-bit key) header.d=rock-chips.com header.i=@rock-chips.com header.b=N33YyMZq; arc=none smtp.client-ip=220.197.32.117
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=rock-chips.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=rock-chips.com
Received: from localhost.localdomain (unknown [103.29.142.67])
	by smtp.qiye.163.com (Hmail) with ESMTP id 11e3d2162;
	Tue, 15 Apr 2025 11:39:42 +0800 (GMT+08:00)
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
Subject: [PATCH v2 1/2] dt-bindings: rockchip-thermal: Support the RK3562 SoC compatible
Date: Tue, 15 Apr 2025 11:39:39 +0800
Message-Id: <20250415033940.47914-1-kever.yang@rock-chips.com>
X-Mailer: git-send-email 2.25.1
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-HM-Spam-Status: e1kfGhgUHx5ZQUpXWQgPGg8OCBgUHx5ZQUlOS1dZFg8aDwILHllBWSg2Ly
	tZV1koWUFITzdXWS1ZQUlXWQ8JGhUIEh9ZQVkaHhhJVktNS0pCTUtDSx0ZSlYVFAkWGhdVEwETFh
	oSFyQUDg9ZV1kYEgtZQVlKS0hVSUJVSk9JVU1MWVdZFhoPEhUdFFlBWU9LSFVKS0lPT09IVUpLS1
	VKQktLWQY+
X-HM-Tid: 0a963788044203afkunm11e3d2162
X-HM-MType: 1
X-HM-Sender-Digest: e1kMHhlZQR0aFwgeV1kSHx4VD1lBWUc6MTY6Sio6LDJRKBohPksjLDYZ
	DBAKCT9VSlVKTE9PTUNDSENPQkxDVTMWGhIXVRAeDR4JVQIaFRw7CRQYEFYYExILCFUYFBZFWVdZ
	EgtZQVlKS0hVSUJVSk9JVU1MWVdZCAFZQUpMSU03Bg++
DKIM-Signature:a=rsa-sha256;
	b=N33YyMZqBQWAADFsHHYVkwM5CpZdGJC7buuowxQEqP5pwbiUAT0k2BcbsHeand2+okwtZugZvAJf15gYcKVTeCJuRpIBfZ6ednIVXZfw0qKHCBdKPIsdOXirM1x1I8XwNKBruM5I5/ay9pIsJUw9jQQqzMBN+dpDz417sjgP+o0=; c=relaxed/relaxed; s=default; d=rock-chips.com; v=1;
	bh=nsAist8AxtC7M4LMr9CEpwZWddUC1Wkb4AeT8FbLZpM=;
	h=date:mime-version:subject:message-id:from;

Add a new compatible for tsadc on RK3562 SoCs.

Signed-off-by: Kever Yang <kever.yang@rock-chips.com>
---

Changes in v2: None

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


