Return-Path: <linux-pm+bounces-32375-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 44270B25D64
	for <lists+linux-pm@lfdr.de>; Thu, 14 Aug 2025 09:32:00 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 6ED1D1C83EC4
	for <lists+linux-pm@lfdr.de>; Thu, 14 Aug 2025 07:32:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 978F4271465;
	Thu, 14 Aug 2025 07:30:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=richtek.com header.i=@richtek.com header.b="0cuAFlmC"
X-Original-To: linux-pm@vger.kernel.org
Received: from mg.richtek.com (mg.richtek.com [220.130.44.152])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D9F412FF67C;
	Thu, 14 Aug 2025 07:30:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=220.130.44.152
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755156631; cv=none; b=VaaIMfBhGQFSpwUpNu/coVqIcMLxcGzCz5uBlJ+G8qhzjI114zsk5vkShUjV2Cok5s8hlfO9oXWgcsgTaY4yJzBMgWeU4D8enWO96lBCE0KdZA76N2zynbq3s1uiXLBcK9wrb+MBn0A+Rc9jirncHXYBTzmHnMXu6H73ASCN9m0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755156631; c=relaxed/simple;
	bh=BgpL/qeJvgcZBCwwScC7+fuQidTdFioLiY1RUBgzWp8=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=OZ78COMxAI+bknnAu/0lg1BEfoP/+jcBrUlntVP05YZEpa9epYFXdJCF2nMmnTQEYBFBYLA//4nGrj++03uY+gGLCuaIcH/M/5+vVQz54Mcm6VwdnnPzci1+53ZVZZVKaSxcHBasr9i+NmMeIzpxyHnBoDOiU9r9SXCb2CwYkDI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=richtek.com; spf=pass smtp.mailfrom=richtek.com; dkim=pass (2048-bit key) header.d=richtek.com header.i=@richtek.com header.b=0cuAFlmC; arc=none smtp.client-ip=220.130.44.152
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=richtek.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=richtek.com
X-MailGates: (SIP:2,PASS,NONE)(compute_score:DELIVER,40,3)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=richtek.com;
	s=richtek; t=1755156626;
	bh=S9rxrFf8qezYW4KrXLdUVidv8njftc7BpZoygBQ6NlU=; l=1115;
	h=From:To:Subject:Date:Message-ID:MIME-Version;
	b=0cuAFlmCeXTF1lGbVS4mqhEMnVRj9AslalUb4o3dGTqK5a4/aU5xtmN2A7DnfjrsT
	 6AU2ubAN0onFwmNa48IUF7mIU6HQHY4buNgnvknuWyK6T4C7y118hS43DLBXWvnXy4
	 z2Q8CL+EJ0ed4jrwfeFGkVDdy7WMCZ48IQyGLCzlH4Z7z2nearnmdiENK+YaRRX95M
	 vY0EXI459JNUPfhP0n5/ITCNiGOtUC82j8x3yMqOqCFSEnfF8hyWgpRd9y2b3QduL0
	 BuGA0Yv4YPZxQBMfpV6hVdXfiSjwWl3LshYDsd9etglmwCr0HqTfQ8/OX7ayFat8yK
	 kkZh1WdfJew/Q==
Received: from 192.168.10.47
	by mg.richtek.com with MailGates ESMTPS Server V6.0(817465:0:AUTH_RELAY)
	(envelope-from <cy_huang@richtek.com>)
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256/256); Thu, 14 Aug 2025 15:30:19 +0800 (CST)
Received: from ex4.rt.l (192.168.10.47) by ex4.rt.l (192.168.10.47) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.11; Thu, 14 Aug
 2025 15:30:19 +0800
Received: from git-send.richtek.com (192.168.10.154) by ex4.rt.l
 (192.168.10.45) with Microsoft SMTP Server id 15.2.1544.11 via Frontend
 Transport; Thu, 14 Aug 2025 15:30:19 +0800
From: <cy_huang@richtek.com>
To: Sebastian Reichel <sre@kernel.org>, Krzysztof Kozlowski
	<krzk+dt@kernel.org>
CC: Rob Herring <robh@kernel.org>, Conor Dooley <conor+dt@kernel.org>,
	"ChiYuan Huang" <cy_huang@richtek.com>, <devicetree@vger.kernel.org>,
	<linux-pm@vger.kernel.org>, <linux-kernel@vger.kernel.org>
Subject: [PATCH RESEND v2 0/3] Add Richtek RT9756 Smart-Cap divider charger
Date: Thu, 14 Aug 2025 15:31:05 +0800
Message-ID: <cover.1755154950.git.cy_huang@richtek.com>
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

RESEND V2
- Add 'Reviewed-by' tag in dt-binding patch

V2
- Add reference to 'power-supply.yaml'
- Remove 'wakeup-source' from required property list
- Use 'unevaluatedProperties' to replace 'additionalProperties'

ChiYuan Huang (3):
  dt-bindings: power: supply: Add Richtek RT9756 smart cap divider
    charger
  power: supply: rt9756: Add Richtek RT9756 smart cap divider charger
  Documentation: power: rt9756: Document exported sysfs entries

 .../ABI/testing/sysfs-class-power-rt9756      |  52 +
 .../bindings/power/supply/richtek,rt9756.yaml |  72 ++
 drivers/power/supply/Kconfig                  |  15 +
 drivers/power/supply/Makefile                 |   1 +
 drivers/power/supply/rt9756.c                 | 932 ++++++++++++++++++
 5 files changed, 1072 insertions(+)
 create mode 100644 Documentation/ABI/testing/sysfs-class-power-rt9756
 create mode 100644 Documentation/devicetree/bindings/power/supply/richtek,rt9756.yaml
 create mode 100644 drivers/power/supply/rt9756.c


base-commit: 038d61fd642278bab63ee8ef722c50d10ab01e8f
-- 
2.34.1


