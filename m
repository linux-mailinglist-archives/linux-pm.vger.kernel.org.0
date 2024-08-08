Return-Path: <linux-pm+bounces-11997-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 4BF6894C2CD
	for <lists+linux-pm@lfdr.de>; Thu,  8 Aug 2024 18:34:25 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id AF965B28D33
	for <lists+linux-pm@lfdr.de>; Thu,  8 Aug 2024 16:34:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 13804190678;
	Thu,  8 Aug 2024 16:34:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=collabora.com header.i=detlev.casanova@collabora.com header.b="W08eMFc3"
X-Original-To: linux-pm@vger.kernel.org
Received: from sender4-op-o14.zoho.com (sender4-op-o14.zoho.com [136.143.188.14])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5DF94190079;
	Thu,  8 Aug 2024 16:33:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=136.143.188.14
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723134839; cv=pass; b=WQZb/u0MHifgBQysXeyieKqo9tJfNC0ptyIoI4tkUgMm8/Cck6pYzXYWK8j9F86qBlcSW7D80u4yaOjHEnPGMQlyuPsefCKgIsqN5hUTBftlHi20RwJ7WY00TI5I8M7vDwB3ec8IvPhHFtS95zi1RVjH70rKDEbsmEITuJ4Cg+c=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723134839; c=relaxed/simple;
	bh=7chZuhTNmRrjrIC+yqjL8bk0QnvRVNVfEvzzu7jPKYY=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=RRclCaxzMN9ZkpNfNun73JpaotS65TyA8hiefFLokK/baVXLmhHnErkTfW9Li7Ro8999H9MM1Bxqd25HF3JygEUIjCWiI6aoX4r+3yZ4otUTXI28gjtxdUGm0D7yBJXbad3ltoTHe+lZ55vXjq2twvju+j89ruj3vUfbtu3QLCc=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=collabora.com; spf=pass smtp.mailfrom=collabora.com; dkim=pass (1024-bit key) header.d=collabora.com header.i=detlev.casanova@collabora.com header.b=W08eMFc3; arc=pass smtp.client-ip=136.143.188.14
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=collabora.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=collabora.com
Delivered-To: detlev.casanova@collabora.com
ARC-Seal: i=1; a=rsa-sha256; t=1723134816; cv=none; 
	d=zohomail.com; s=zohoarc; 
	b=iDPWYWlOfe54Ce5X5GyGC3aRRR4PDVqFhM4E8MpQuGrgTA+/B7Fz8mJPuzvzFQW1vaFbF941UvuAc7pTfmbAw62cNJXHlcqgWVxaSvCKFPJBvhBCMSeP0DpzH9fSNaM6wwcc/HR2fIZCfMhIYlyP6d+W/4ZeP3p411ARR2TXJR4=
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=zohomail.com; s=zohoarc; 
	t=1723134816; h=Content-Transfer-Encoding:Cc:Cc:Date:Date:From:From:MIME-Version:Message-ID:Subject:Subject:To:To:Message-Id:Reply-To; 
	bh=NmqcV9imI6SfgcIxSQfScmTXomw4vtotLJTJkgfLYDA=; 
	b=f6O5ysVa4OLVPFzF34YFfUYIKsG4QskrNH4JxANXVMSZ+712mYZhEAYO1pIr143myYNfavCg0EF6wDqohgW+Xfw43ADQJhEkrXqs6LwMV2JBQfHedBZ7AdZ80JveCNXvuhFLLNQ9ECNfb//d2pVrW21DafSK90zrMj/LueDcVDo=
ARC-Authentication-Results: i=1; mx.zohomail.com;
	dkim=pass  header.i=collabora.com;
	spf=pass  smtp.mailfrom=detlev.casanova@collabora.com;
	dmarc=pass header.from=<detlev.casanova@collabora.com>
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; t=1723134816;
	s=zohomail; d=collabora.com; i=detlev.casanova@collabora.com;
	h=From:From:To:To:Cc:Cc:Subject:Subject:Date:Date:Message-ID:MIME-Version:Content-Transfer-Encoding:Message-Id:Reply-To;
	bh=NmqcV9imI6SfgcIxSQfScmTXomw4vtotLJTJkgfLYDA=;
	b=W08eMFc3zFZm/8nWGANJGr7fWFSowSiV30h0usWckR1QpSi6cRqQCFEkM/X8U7Ml
	rI+ChtmX8xm9XkXQ71V6Y0l0YzjOR76APf2x2OTibbGtYuvsOfS5Y7RlGlF1Sl04rAs
	RBSeFf4sMNGQ6y5EcsJlYJHAqsWUrYjPNYwTQJOw=
Received: by mx.zohomail.com with SMTPS id 1723134814543747.8071954226422;
	Thu, 8 Aug 2024 09:33:34 -0700 (PDT)
From: Detlev Casanova <detlev.casanova@collabora.com>
To: linux-kernel@vger.kernel.org
Cc: Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Heiko Stuebner <heiko@sntech.de>,
	Ulf Hansson <ulf.hansson@linaro.org>,
	Detlev Casanova <detlev.casanova@collabora.com>,
	Finley Xiao <finley.xiao@rock-chips.com>,
	Jagan Teki <jagan@edgeble.ai>,
	Arnd Bergmann <arnd@arndb.de>,
	Elaine Zhang <zhangqing@rock-chips.com>,
	devicetree@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org,
	linux-rockchip@lists.infradead.org,
	linux-pm@vger.kernel.org,
	kernel@collabora.com
Subject: [PATCH v2 0/2] Add power-controller support for rk3576
Date: Thu,  8 Aug 2024 12:31:03 -0400
Message-ID: <20240808163451.80750-1-detlev.casanova@collabora.com>
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

Changes since v1:
- Rename rk3576-power.h to rockchip,rk3576-power.h
- Add memory reset support
- Squashed header files with bindings commit
- Updated license
- Fix commit messages for subsystem.

Finley Xiao (2):
  dt-bindings: power: Add support for RK3576 SoC
  pmdomain: rockchip: Add support for rk3576 SoC

 .../power/rockchip,power-controller.yaml      |  1 +
 drivers/pmdomain/rockchip/pm-domains.c        | 73 ++++++++++++++++++-
 .../dt-bindings/power/rockchip,rk3576-power.h | 30 ++++++++
 3 files changed, 101 insertions(+), 3 deletions(-)
 create mode 100644 include/dt-bindings/power/rockchip,rk3576-power.h

-- 
2.46.0


