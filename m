Return-Path: <linux-pm+bounces-36339-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 9CF85BE7DC6
	for <lists+linux-pm@lfdr.de>; Fri, 17 Oct 2025 11:44:43 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 3CDCD6E17D1
	for <lists+linux-pm@lfdr.de>; Fri, 17 Oct 2025 09:39:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C5A1A2D7DC1;
	Fri, 17 Oct 2025 09:38:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=rock-chips.com header.i=@rock-chips.com header.b="hMuhADEP"
X-Original-To: linux-pm@vger.kernel.org
Received: from mail-m32101.qiye.163.com (mail-m32101.qiye.163.com [220.197.32.101])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 65B442D7388;
	Fri, 17 Oct 2025 09:38:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=220.197.32.101
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760693934; cv=none; b=TFkaTxGCZuuqhl95bQE70MuGJcfvjsf0iA+foM3bjcO1EpUNhjzaw65UijE4INspzWtusLn/H7embIdfL2IuknftY9JTMgdLgk/0GYDKYQkW89z2/1ZoN59oiRWKfXjxZl0GVTsnUUY+ZNu6Z84HuTGSyDke+S8+7uxe4tr1j+o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760693934; c=relaxed/simple;
	bh=GQ6R570uQrtw7VpX38UcuaUMLbdw1hKLzXQSSJtmD4o=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=suY7kXhcuPGJPyMdn+OcuMsPKfFFg0Kkj5+PiStO2ICv7J4JNawfX+0agEgkZI/oILEUlf7+Gw2t6W0Et/AVVOZCAK5afkyo+kOrMD1Qdo+jhif6gqqDzgCQtNwAXdyX96Bur5hDD9edTCZKq5ZN9MZshuQnbcKeUHpH/oCjTq8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=rock-chips.com; spf=pass smtp.mailfrom=rock-chips.com; dkim=pass (1024-bit key) header.d=rock-chips.com header.i=@rock-chips.com header.b=hMuhADEP; arc=none smtp.client-ip=220.197.32.101
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=rock-chips.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=rock-chips.com
Received: from xf.. (unknown [58.22.7.114])
	by smtp.qiye.163.com (Hmail) with ESMTP id 264523269;
	Fri, 17 Oct 2025 17:38:40 +0800 (GMT+08:00)
From: Finley Xiao <finley.xiao@rock-chips.com>
To: heiko@sntech.de
Cc: robh@kernel.org,
	krzk+dt@kernel.org,
	conor+dt@kernel.org,
	ulf.hansson@linaro.org,
	devicetree@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org,
	linux-rockchip@lists.infradead.org,
	linux-kernel@vger.kernel.org,
	linux-pm@vger.kernel.org,
	zhangqing@rock-chips.com,
	sugar.zhang@rock-chips.com,
	huangtao@rock-chips.com,
	Finley Xiao <finley.xiao@rock-chips.com>
Subject: [PATCH v4 0/2] Add power-controller support for RV1126B
Date: Fri, 17 Oct 2025 17:38:32 +0800
Message-ID: <20251017093834.331998-1-finley.xiao@rock-chips.com>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-HM-Tid: 0a99f189210a03a9kunmbe68a2b91698e9
X-HM-MType: 1
X-HM-Spam-Status: e1kfGhgUHx5ZQUpXWQgPGg8OCBgUHx5ZQUlOS1dZFg8aDwILHllBWSg2Ly
	tZV1koWUFDSUNOT01LS0k3V1ktWUFJV1kPCRoVCBIfWUFZQkNCHlZCS0pDQk1MQ01JQkpWFRQJFh
	oXVRMBExYaEhckFA4PWVdZGBILWUFZTkNVSUlVTFVKSk9ZV1kWGg8SFR0UWUFZT0tIVUpLSU9PT0
	hVSktLVUpCS0tZBg++
DKIM-Signature: a=rsa-sha256;
	b=hMuhADEPSmwP6nPasnEsJ31HuhbuNxT3etn3+hJJkFF62U7zWJC8lq+LcH/zBZZl7vGpFiijdsoOn54FZy4hlmlP7K0O+I9MNURftFqGk8K+ZAfI9ik/F1H0BPPUBQHk8FcYzX4o4naL5CW7pSQ64Kwd4wlHa9s63crTXOuFojs=; c=relaxed/relaxed; s=default; d=rock-chips.com; v=1;
	bh=LjF9ZqEFw1pOCkzkvk35rLOTjYm8/YyQQGfvrv/Wf0E=;
	h=date:mime-version:subject:message-id:from;

Add support for the power domain controller on the RV1126B SoC.

Finley Xiao (2):
  dt-bindings: power: rockchip: Add support for RV1126B
  pmdomain: rockchip: Add support for RV1126B

 .../power/rockchip,power-controller.yaml      |  2 +
 drivers/pmdomain/rockchip/pm-domains.c        | 41 +++++++++++++++++++
 .../power/rockchip,rv1126b-power-controller.h | 17 ++++++++
 3 files changed, 60 insertions(+)
 create mode 100644 include/dt-bindings/power/rockchip,rv1126b-power-controller.h

-- 
2.43.0


