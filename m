Return-Path: <linux-pm+bounces-23048-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id ECFC6A47B18
	for <lists+linux-pm@lfdr.de>; Thu, 27 Feb 2025 12:01:17 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id D364C189222D
	for <lists+linux-pm@lfdr.de>; Thu, 27 Feb 2025 11:00:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E40A2215787;
	Thu, 27 Feb 2025 11:00:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=rock-chips.com header.i=@rock-chips.com header.b="bodHX+nX"
X-Original-To: linux-pm@vger.kernel.org
Received: from mail-m3282.qiye.163.com (mail-m3282.qiye.163.com [220.197.32.82])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5CA8C1662EF;
	Thu, 27 Feb 2025 11:00:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=220.197.32.82
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740654036; cv=none; b=NPvyzjo39cNyPals4KtXl6ivhrbP3ujrliXtks+91XS04+WnYG1INZbU5f+lZge88D6+4+5oY52o/V/LuY1svexivrGqupusc9PbC/1sXj946V2uEBNUUH2VhOzYdq63gY8YbDE5p/qESEfQ3MqC6UHxMJut5S5Vtp4COY/6Vvw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740654036; c=relaxed/simple;
	bh=mdM+ePl0coPnOxwZBVwAhHsPSOaeZuqrB6HncsFy0+Y=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=czRmcDMaL0d8z0PedyDkjYPbRTwFDz/e+MeNpvLqubu4lrXJPYKkXDQqcGffuxr0+TZEXd/5qhMx0y48NyqwUbGyoMbwzEssdshHLsuzm0Br9TIRiCYeHZY/JclBm19IPYgfHIHijzYwAmZh2q4k7SPOJrlz/a/lkg+bOKA6GDQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=rock-chips.com; spf=pass smtp.mailfrom=rock-chips.com; dkim=pass (1024-bit key) header.d=rock-chips.com header.i=@rock-chips.com header.b=bodHX+nX; arc=none smtp.client-ip=220.197.32.82
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=rock-chips.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=rock-chips.com
Received: from localhost.localdomain (unknown [58.22.7.114])
	by smtp.qiye.163.com (Hmail) with ESMTP id c6596ab8;
	Thu, 27 Feb 2025 19:00:23 +0800 (GMT+08:00)
From: Kever Yang <kever.yang@rock-chips.com>
To: heiko@sntech.de
Cc: linux-rockchip@lists.infradead.org,
	Kever Yang <kever.yang@rock-chips.com>,
	devicetree@vger.kernel.org,
	Conor Dooley <conor+dt@kernel.org>,
	Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>,
	Finley Xiao <finley.xiao@rock-chips.com>,
	Rob Herring <robh@kernel.org>,
	Jonathan Cameron <Jonathan.Cameron@huawei.com>,
	Detlev Casanova <detlev.casanova@collabora.com>,
	linux-kernel@vger.kernel.org,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	linux-pm@vger.kernel.org,
	Elaine Zhang <zhangqing@rock-chips.com>,
	linux-arm-kernel@lists.infradead.org,
	Ulf Hansson <ulf.hansson@linaro.org>
Subject: [PATCH v3 0/2] rockchip: Add rk3562 power domain support
Date: Thu, 27 Feb 2025 18:59:55 +0800
Message-Id: <20250227105957.2341107-1-kever.yang@rock-chips.com>
X-Mailer: git-send-email 2.25.1
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-HM-Spam-Status: e1kfGhgUHx5ZQUpXWQgPGg8OCBgUHx5ZQUlOS1dZFg8aDwILHllBWSg2Ly
	tZV1koWUFDSUNOT01LS0k3V1ktWUFJV1kPCRoVCBIfWUFZQ09OGFZPSUIfShhKQkNKGhlWFRQJFh
	oXVRMBExYaEhckFA4PWVdZGBILWUFZTkNVSUlVTFVKSk9ZV1kWGg8SFR0UWUFZT0tIVUpLSU9PT0
	hVSktLVUpCS0tZBg++
X-HM-Tid: 0a954710934803afkunmc6596ab8
X-HM-MType: 1
X-HM-Sender-Digest: e1kMHhlZQR0aFwgeV1kSHx4VD1lBWUc6MzI6Sxw*PTINIw08AhkKOTgw
	Mz5PC0hVSlVKTE9LTU5PS0lPQ0xPVTMWGhIXVRAeDR4JVQIaFRw7CRQYEFYYExILCFUYFBZFWVdZ
	EgtZQVlOQ1VJSVVMVUpKT1lXWQgBWUFDTE83Bg++
DKIM-Signature:a=rsa-sha256;
	b=bodHX+nX26+wDPL0L7R3+BcC9KfsRht18KaUDideUQmHXDFksKtU3M938qsfRLiKOsPKUrER+huHfpcwSyKKAXN0MYlhCUnHEyXIZFx/hywG7F/FYP1g0MO5py7ER51yMZCqQUd4uzHarOQf+T/F2IZQr9XydbwBpUY3NzFW2MM=; c=relaxed/relaxed; s=default; d=rock-chips.com; v=1;
	bh=nwHfhAaVNdbWsSpgLPAqaXSfh9N5ThHSjgQ30wKWVPA=;
	h=date:mime-version:subject:message-id:from;


This patch set add power domain driver for a new SoC rk3562, the SoC DT will
be sent as a separate patch set and the new compatible will be used in the DT.

Changes in v3:
- squash the header file and the binding document
- Update license

Changes in v2:
- rename to rockchip,rk3562-power.h
- update the subject
- use dual license
- update the header name

Finley Xiao (1):
  dt-bindings: power: rockchip: Add support for RK3562 SoC

Kever Yang (1):
  soc: rockchip: power-domain: add power domain support for rk3562

 .../power/rockchip,power-controller.yaml      |  1 +
 drivers/pmdomain/rockchip/pm-domains.c        | 48 ++++++++++++++++++-
 .../dt-bindings/power/rockchip,rk3562-power.h | 35 ++++++++++++++
 3 files changed, 83 insertions(+), 1 deletion(-)
 create mode 100644 include/dt-bindings/power/rockchip,rk3562-power.h

-- 
2.25.1


