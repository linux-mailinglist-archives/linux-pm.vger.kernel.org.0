Return-Path: <linux-pm+bounces-36322-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id C2C7FBE6375
	for <lists+linux-pm@lfdr.de>; Fri, 17 Oct 2025 05:38:15 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 7B0F85855F9
	for <lists+linux-pm@lfdr.de>; Fri, 17 Oct 2025 03:38:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8123F2BDC2A;
	Fri, 17 Oct 2025 03:38:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=rock-chips.com header.i=@rock-chips.com header.b="TOqXYfP0"
X-Original-To: linux-pm@vger.kernel.org
Received: from mail-m49251.qiye.163.com (mail-m49251.qiye.163.com [45.254.49.251])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7ECFC29DB6E;
	Fri, 17 Oct 2025 03:38:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.254.49.251
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760672292; cv=none; b=UiwpI9AJxSLCcFuNunQMrzrqETD6sASOXXUOVMdlTb9Bvta+/4N3iFWUDNrC9pT9roxab897nvPVt7yTox0SaMYpX40Jfc4pkWugMrBTTTKY6sI8qv1wG7SKl2PrWqVgpoG9LKz2GKR+bO0ycaN2S/MiJDlKBkbUdNrhV8YkTyc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760672292; c=relaxed/simple;
	bh=0UIObik+Gsd/YcNm0oXm++o2U2Xe+Cv/rEgPjBuHEBA=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=cVxhaQvfPwt4Xmne94kfVnZJgvUUE+XsCal4OqNEYG4TfBAQh7VmDKglh1Q3gEUkFngsVVRkGta1+uudLJ/pk4j1hDVdV4iBwkfcUPWA4QCBLLerc+Ns9S59MMWRhUfhKdN2H6kkQyh1Gx3s4nHn8BKf0T+ZicThBF5jXW3NAXM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=rock-chips.com; spf=pass smtp.mailfrom=rock-chips.com; dkim=pass (1024-bit key) header.d=rock-chips.com header.i=@rock-chips.com header.b=TOqXYfP0; arc=none smtp.client-ip=45.254.49.251
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=rock-chips.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=rock-chips.com
Received: from xf.. (unknown [58.22.7.114])
	by smtp.qiye.163.com (Hmail) with ESMTP id 2638429c1;
	Fri, 17 Oct 2025 11:37:58 +0800 (GMT+08:00)
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
	Finley Xiao <finley.xiao@rock-chips.com>
Subject: [PATCH v2 0/2] Add power-controller support for RV1126B
Date: Fri, 17 Oct 2025 11:14:23 +0800
Message-ID: <20251017031425.310946-1-finley.xiao@rock-chips.com>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-HM-Tid: 0a99f03ee89303a9kunm1150bbeadf2ea
X-HM-MType: 1
X-HM-Spam-Status: e1kfGhgUHx5ZQUpXWQgPGg8OCBgUHx5ZQUlOS1dZFg8aDwILHllBWSg2Ly
	tZV1koWUFDSUNOT01LS0k3V1ktWUFJV1kPCRoVCBIfWUFZQkxOSFZDGUMYTUxOSkpNSkpWFRQJFh
	oXVRMBExYaEhckFA4PWVdZGBILWUFZTkNVSUlVTFVKSk9ZV1kWGg8SFR0UWUFZT0tIVUpLSU9PT0
	hVSktLVUpCS0tZBg++
DKIM-Signature: a=rsa-sha256;
	b=TOqXYfP09IkKcPagpuOEpUf+7StMwwVgNChueNEEN4THyEQzE8BEQRAKnjq/US/r0mn0cwfYk8zIIlVxpHM/woB8uUCEgb38wM8gxHtLtjySqL6HohXsi6j15iyZvjfB87ex0lW3a3rCknOlK9KiXGiyA42C5ogbz1FSGwsxk6Y=; c=relaxed/relaxed; s=default; d=rock-chips.com; v=1;
	bh=Rq+uvw5+i90RRBLsQFz7WN6PFQUjhoT0ECz9wYD+Q3I=;
	h=date:mime-version:subject:message-id:from;

Add support for the power domain controller on the RV1126B SoC.

Finley Xiao (2):
  dt-bindings: power: rockchip: Add support for RV1126B
  pmdomain: rockchip: Add support for RV1126B

 .../power/rockchip,power-controller.yaml      |  2 +
 drivers/pmdomain/rockchip/pm-domains.c        | 41 +++++++++++++++++++
 .../power/rockchip,rv1126b-power.h            | 17 ++++++++
 3 files changed, 60 insertions(+)
 create mode 100644 include/dt-bindings/power/rockchip,rv1126b-power.h

-- 
2.43.0


