Return-Path: <linux-pm+bounces-31530-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id D4B7CB14723
	for <lists+linux-pm@lfdr.de>; Tue, 29 Jul 2025 06:21:49 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 20515189F86C
	for <lists+linux-pm@lfdr.de>; Tue, 29 Jul 2025 04:22:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2E058227599;
	Tue, 29 Jul 2025 04:21:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=richtek.com header.i=@richtek.com header.b="0Xpg6Poz"
X-Original-To: linux-pm@vger.kernel.org
Received: from mg.richtek.com (mg.richtek.com [220.130.44.152])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 879D48632B;
	Tue, 29 Jul 2025 04:21:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=220.130.44.152
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753762904; cv=none; b=IX1vnSFcrJAylK0B0Hfxb/rVgtfM+sYQgo/9/h3S12guiNDxdryZBtFudUqK9zuJ32lxcL/1NlxdPih99Jm4pEIpWOOIBUZrKcEh5Wv6UQZ2+31gKhSmd89gQlpce5Irh4aI/CXDImM0tC52pUOnLbLshbCh+9dydiK9JraByYw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753762904; c=relaxed/simple;
	bh=fdzNDsUXB9xgLivv5y6n/IHrECHOIhd8pAlb1XV6+34=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=GybvMC7s6c4NAYBsx6ZJq5UcJxcp+7r+/5BEV28RbO0xYGcgCbKTug8+KKWzptesrWRnsZThHVPICs2jzKBxrtvmyzTry7AKVUfjoqrzZkGqDTcqplp+u1tLVOCSKK5YlHjvpgXCgqTW+w9KzLWNR4UlJtjJ9A+PaO/X8mWyts4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=richtek.com; spf=pass smtp.mailfrom=richtek.com; dkim=pass (2048-bit key) header.d=richtek.com header.i=@richtek.com header.b=0Xpg6Poz; arc=none smtp.client-ip=220.130.44.152
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=richtek.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=richtek.com
X-MailGates: (SIP:2,PASS,NONE)(compute_score:DELIVER,40,3)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=richtek.com;
	s=richtek; t=1753762892;
	bh=AimXEuUCX9TJ+wqawxamINMlJYnCiL2Og9q6SOAOG34=; l=892;
	h=From:To:Subject:Date:Message-ID:MIME-Version;
	b=0Xpg6Poz6COkez+3UsjdE2+Y8PXj62SJJqdLos4en/km1QwGrLONpkB5TRbfG3Eby
	 cD1TdjzInTCosVbDksYCpuXwARwBc0GpCGl7qMme8e8OtagOn2Q8KzCi1CniD40P61
	 EZ+MIMt1lGwGdzEXVO+e60j9MnMtDfGDRW6K5KJyHPr1sahohIeneUpPyDabKPvY5b
	 0uLomaZ5f9w8X1aCREnwhRaU0nM7TY4ST4ZCsQJy3MDdZkfcg1UwKnfdvp2j/Q5WH6
	 lKvXz+gZQBBBHAX0E+Iyq+ImTbYUA93tIYExkQffEvtO/bD8BD1tTYpApHhM4rwvfx
	 dmbSs9Sb/uVzQ==
Received: from 192.168.10.47
	by mg.richtek.com with MailGates ESMTPS Server V6.0(244579:0:AUTH_RELAY)
	(envelope-from <cy_huang@richtek.com>)
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256/256); Tue, 29 Jul 2025 12:21:18 +0800 (CST)
Received: from ex3.rt.l (192.168.10.46) by ex4.rt.l (192.168.10.47) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.11; Tue, 29 Jul
 2025 12:21:17 +0800
Received: from git-send.richtek.com (192.168.10.154) by ex3.rt.l
 (192.168.10.45) with Microsoft SMTP Server id 15.2.1544.11 via Frontend
 Transport; Tue, 29 Jul 2025 12:21:17 +0800
From: <cy_huang@richtek.com>
To: Sebastian Reichel <sre@kernel.org>, Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>
CC: Conor Dooley <conor+dt@kernel.org>, ChiYuan Huang <cy_huang@richtek.com>,
	<devicetree@vger.kernel.org>, <linux-pm@vger.kernel.org>,
	<linux-kernel@vger.kernel.org>
Subject: [PATCH 0/3] Add Richtek RT9756 Smart-Cap dividor charger
Date: Tue, 29 Jul 2025 12:21:53 +0800
Message-ID: <cover.1753759794.git.cy_huang@richtek.com>
X-Mailer: git-send-email 2.43.5
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain

From: ChiYuan Huang <cy_huang@richtek.com>

This patch series adds support for RT9756 charger.

ChiYuan Huang (3):
  dt-bindings: power: supply: Add Richtek RT9756 smart cap divider
    charger
  power: supply: rt9756: Add Richtek RT9756 smart cap divider charger
  Documentation: power: rt9756: Document exported sysfs entries

 .../ABI/testing/sysfs-class-power-rt9756      |  52 +
 .../bindings/power/supply/richtek,rt9756.yaml |  70 ++
 drivers/power/supply/Kconfig                  |  15 +
 drivers/power/supply/Makefile                 |   1 +
 drivers/power/supply/rt9756.c                 | 932 ++++++++++++++++++
 5 files changed, 1070 insertions(+)
 create mode 100644 Documentation/ABI/testing/sysfs-class-power-rt9756
 create mode 100644 Documentation/devicetree/bindings/power/supply/richtek,rt9756.yaml
 create mode 100644 drivers/power/supply/rt9756.c


base-commit: 038d61fd642278bab63ee8ef722c50d10ab01e8f
-- 
2.34.1


