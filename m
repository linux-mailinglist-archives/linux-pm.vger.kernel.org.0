Return-Path: <linux-pm+bounces-36257-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 3DD2DBE3C4A
	for <lists+linux-pm@lfdr.de>; Thu, 16 Oct 2025 15:43:26 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 98BC1189953F
	for <lists+linux-pm@lfdr.de>; Thu, 16 Oct 2025 13:42:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4C267339B4A;
	Thu, 16 Oct 2025 13:41:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=rock-chips.com header.i=@rock-chips.com header.b="bae8bA/j"
X-Original-To: linux-pm@vger.kernel.org
Received: from mail-m49239.qiye.163.com (mail-m49239.qiye.163.com [45.254.49.239])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B6EB518A6C4;
	Thu, 16 Oct 2025 13:41:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.254.49.239
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760622114; cv=none; b=A5MFhLmIxXQxXrgf0ufpCDyXJjuKNoFbQrqF642q0NkG9qLAkpx35U0CiVdvcdrkpMP/raHEoLAlMGPMhdbDwuhVTL2B3uUICoMSWqTq1nQR8grQ6GA/aCa3rC1By53V6tMedGt+2vv7E5CFNnWDDhoxGDRLXRfO07QNvlAldNI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760622114; c=relaxed/simple;
	bh=0UIObik+Gsd/YcNm0oXm++o2U2Xe+Cv/rEgPjBuHEBA=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=PjBBfCvkNbkNaVSfXSpd+vf06Hlv8BO72f3gkh8uHNo2gmz4r712lcgkAC3mSKe/H7ocEACehRzboXuYyiDbmuJJXKt3WOwgMHS3E+o7BzOAfge1i+TXT0SQOI0dBe1u2pDsPYJa8aVZt+tBuNioYZW3c6gh7oWoXAMjIhXPbtI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=rock-chips.com; spf=pass smtp.mailfrom=rock-chips.com; dkim=pass (1024-bit key) header.d=rock-chips.com header.i=@rock-chips.com header.b=bae8bA/j; arc=none smtp.client-ip=45.254.49.239
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=rock-chips.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=rock-chips.com
Received: from xf.. (unknown [58.22.7.114])
	by smtp.qiye.163.com (Hmail) with ESMTP id 26283fe35;
	Thu, 16 Oct 2025 21:41:45 +0800 (GMT+08:00)
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
	finley.xiao@rock-chips.com,
	zhangqing@rock-chips.com,
	sugar.zhang@rock-chips.com,
	huangtao@rock-chips.com
Subject: [PATCH v1 0/2] Add power-controller support for RV1126B
Date: Thu, 16 Oct 2025 21:41:01 +0800
Message-ID: <20251016134103.294636-1-finley.xiao@rock-chips.com>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-HM-Tid: 0a99ed41543303a9kunm0a0c6b9d2863d
X-HM-MType: 1
X-HM-Spam-Status: e1kfGhgUHx5ZQUpXWQgPGg8OCBgUHx5ZQUlOS1dZFg8aDwILHllBWSg2Ly
	tZV1koWUFDSUNOT01LS0k3V1ktWUFJV1kPCRoVCBIfWUFZQ0hCGFYZTxlLSx0eHh5KT09WFRQJFh
	oXVRMBExYaEhckFA4PWVdZGBILWUFZTkNVSUlVTFVKSk9ZV1kWGg8SFR0UWUFZT0tIVUpLSU9PT0
	hVSktLVUpCS0tZBg++
DKIM-Signature: a=rsa-sha256;
	b=bae8bA/juOH8083W4MEdTjSfrVExQ/rESSVCO99d4us43aSIxfVxMWL+4dQJeBC29EN3ziMAWHQlTFd9QbYkEat66FjFjmiAZaxcPUwcpy3zlxKeFi40BzzVBHRAfbIIVd4hyV3xCCT3r4azIYRTh5AIhWEOkitk/om7zjZJ+jg=; c=relaxed/relaxed; s=default; d=rock-chips.com; v=1;
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


