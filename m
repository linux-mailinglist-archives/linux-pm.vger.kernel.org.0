Return-Path: <linux-pm+bounces-12240-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id BCBE49525AA
	for <lists+linux-pm@lfdr.de>; Thu, 15 Aug 2024 00:27:31 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 71AF11F242C7
	for <lists+linux-pm@lfdr.de>; Wed, 14 Aug 2024 22:27:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4B9A6149C68;
	Wed, 14 Aug 2024 22:27:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=collabora.com header.i=detlev.casanova@collabora.com header.b="gw/eeOJk"
X-Original-To: linux-pm@vger.kernel.org
Received: from sender4-op-o14.zoho.com (sender4-op-o14.zoho.com [136.143.188.14])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8EB4B50269;
	Wed, 14 Aug 2024 22:27:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=136.143.188.14
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723674445; cv=pass; b=mc8q9FXFm1lx2HD5xLFnw5WEGazsY0y5RPZlLazPBufdixX+N9QlL3R5OuOzFo2voz5REPkG+qcxRsSbg4PmWHFv74rfXU3eMQGsofrv96bTvoq/eglLzzh+QM4TTyAS4ZYI7x9YQheV9usk/Xf47/CMJQam7OHYKhpqeo0gB0Y=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723674445; c=relaxed/simple;
	bh=9VJ9jjp6t4L7646AKrQL1N28VmVst/aHB1hDiaffkDQ=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=PRp/x6QeEhR8SomX1BX3w/C0NdFLQefSj+1aDZSlVeE3gMdnfo0JqiQUEMcNflxhZXIZ80m1K8s61r33K6PprIwIB+wx9Z4K7bJ3ZemXdtgcgeETLkTxEjFEZsVFErI7+HKOL6IcK1beHZL6EalShRO4SqVvGNWx/nbcW3AkIbI=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=collabora.com; spf=pass smtp.mailfrom=collabora.com; dkim=pass (1024-bit key) header.d=collabora.com header.i=detlev.casanova@collabora.com header.b=gw/eeOJk; arc=pass smtp.client-ip=136.143.188.14
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=collabora.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=collabora.com
Delivered-To: detlev.casanova@collabora.com
ARC-Seal: i=1; a=rsa-sha256; t=1723674420; cv=none; 
	d=zohomail.com; s=zohoarc; 
	b=X0Q+0WbzCl+mNg8bE/Ns8Z1K2ucO71ZR8jLFHvoxkDcBl2HfYiuK/b6JHPC4DYgNjxGSrzUKzzQ0w8yWgqRayMKzUVU67zuS5a66YXl6D0WJ6d9maeGVWK94HPlEfvksb94apRocJr2SkXFVvPZNQv+obnelSrc5dJ9QaLxs/KE=
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=zohomail.com; s=zohoarc; 
	t=1723674420; h=Content-Transfer-Encoding:Cc:Cc:Date:Date:From:From:MIME-Version:Message-ID:Subject:Subject:To:To:Message-Id:Reply-To; 
	bh=C5EV/s8GV9lXY41yul4dYE04bI+39q3p/wGsLk5ULio=; 
	b=DjUkBXuF7vfqFb9VLjh+U4aaYUW949auzqs3O9lS0y8aHkauAbRCkktzwJtVWKTAeX+q8uKcqLfX1judCR+FmQ5ddYPh9t/nO/YpYRHM646RGU5mp8XBNg2mRJiaNOPD5LN6hLnUmq2DKGtXC1OWYrYr3Qg6tTpX1yn+vLijFuQ=
ARC-Authentication-Results: i=1; mx.zohomail.com;
	dkim=pass  header.i=collabora.com;
	spf=pass  smtp.mailfrom=detlev.casanova@collabora.com;
	dmarc=pass header.from=<detlev.casanova@collabora.com>
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; t=1723674420;
	s=zohomail; d=collabora.com; i=detlev.casanova@collabora.com;
	h=From:From:To:To:Cc:Cc:Subject:Subject:Date:Date:Message-ID:MIME-Version:Content-Transfer-Encoding:Message-Id:Reply-To;
	bh=C5EV/s8GV9lXY41yul4dYE04bI+39q3p/wGsLk5ULio=;
	b=gw/eeOJkZGdvTIBY+6w+9vXaGby37PS1slrN1B7/qd8hxrZ+1NXHA1LTAA5L/25m
	B6Z0gqpyJoxei6/w4wJavrHF0lA2iZzP5Q2vodmVfo29OxHvSDmtWmG5wI570XXreuq
	WJi4Rd3uYyDJvESverBbam8Vr+TxzAJ8H5umvyjc=
Received: by mx.zohomail.com with SMTPS id 1723674418214400.92705418065145;
	Wed, 14 Aug 2024 15:26:58 -0700 (PDT)
From: Detlev Casanova <detlev.casanova@collabora.com>
To: linux-kernel@vger.kernel.org
Cc: Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Heiko Stuebner <heiko@sntech.de>,
	Ulf Hansson <ulf.hansson@linaro.org>,
	Finley Xiao <finley.xiao@rock-chips.com>,
	Detlev Casanova <detlev.casanova@collabora.com>,
	Arnd Bergmann <arnd@arndb.de>,
	Jagan Teki <jagan@edgeble.ai>,
	Elaine Zhang <zhangqing@rock-chips.com>,
	devicetree@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org,
	linux-rockchip@lists.infradead.org,
	linux-pm@vger.kernel.org,
	kernel@collabora.com
Subject: [PATCH v4 0/2] Add power-controller support for rk3576
Date: Wed, 14 Aug 2024 18:26:40 -0400
Message-ID: <20240814222824.3170-1-detlev.casanova@collabora.com>
X-Mailer: git-send-email 2.46.0
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-ZohoMailClient: External

Add support for the power domain controller on the rk3576 SoC.
Patches from downstream have been rebased.

Note that the mentioned TRM is not publicly available.

Changes since v3:
- Remove unused g_mask and reuse DOMAIN_M_O_R

Changes since v2:
- Remove unused delay for npu and vop

Changes since v1:
- Rename rk3576-power.h to rockchip,rk3576-power.h
- Add memory reset support
- Squashed header files with bindings commit
- Updated license
- Fix commit messages for subsystem.

Detlev.

Finley Xiao (2):
  dt-bindings: power: Add support for RK3576 SoC
  pmdomain: rockchip: Add support for RK3576 SoC

 .../power/rockchip,power-controller.yaml      |  1 +
 drivers/pmdomain/rockchip/pm-domains.c        | 45 +++++++++++++++++++
 .../dt-bindings/power/rockchip,rk3576-power.h | 30 +++++++++++++
 3 files changed, 76 insertions(+)
 create mode 100644 include/dt-bindings/power/rockchip,rk3576-power.h

-- 
2.46.0


