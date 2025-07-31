Return-Path: <linux-pm+bounces-31656-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C1292B16BAB
	for <lists+linux-pm@lfdr.de>; Thu, 31 Jul 2025 07:47:55 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id DC3F27B6EE3
	for <lists+linux-pm@lfdr.de>; Thu, 31 Jul 2025 05:46:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A3BFA23B60E;
	Thu, 31 Jul 2025 05:47:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=richtek.com header.i=@richtek.com header.b="Qb1DAGSO"
X-Original-To: linux-pm@vger.kernel.org
Received: from mg.richtek.com (mg.richtek.com [220.130.44.152])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 336735336D;
	Thu, 31 Jul 2025 05:47:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=220.130.44.152
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753940868; cv=none; b=NRtzt9GWFi6twe/S0P7Y/Bxtqy+JVpDzx6K2p6++3/6OAX7jKZ02+m2Sl8rfV6IuHKkj2Iy3eNyPJ8/iO+sH26G6urLLwOE05xzZ7I9SeXhP3eETsXeKRwYm78Zj5XMcvy6jCqlx/fp64PY0XgDK9/ILv54Daj4Bt81A6mnb8Qs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753940868; c=relaxed/simple;
	bh=JVRlUevpKq3F0LLIlQqZcAPCQYadUSaWZCzFpSlu5jo=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=d/GgAvFwC57PYi2gxChzj/vMjeO5/yKZogptFSUuB9VyjWJhbkIkbeLNylD/WJ9UAORRFtBnWAk87q/BlYJbZ5QKGdvkEHT5a6OB5Ds/Xl8/bgiHWODykxrbgVQ6cCJ0uiowWxEA5XP0Yp3DnLpMl2wxpckN+tziJd3mMTZ1B+8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=richtek.com; spf=pass smtp.mailfrom=richtek.com; dkim=pass (2048-bit key) header.d=richtek.com header.i=@richtek.com header.b=Qb1DAGSO; arc=none smtp.client-ip=220.130.44.152
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=richtek.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=richtek.com
X-MailGates: (SIP:2,PASS,NONE)(compute_score:DELIVER,40,3)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=richtek.com;
	s=richtek; t=1753940863;
	bh=xwA/1UmHwgpYqmhZD7WbgeLf0V6UeBGSDO/32ceM6sY=; l=1057;
	h=From:To:Subject:Date:Message-ID:MIME-Version;
	b=Qb1DAGSOyEelHHXhuOV3hT56rbvcVeXwfnjNhanZAODPr4O56RnQB63PxB552F6ov
	 J9QL8GUgHg9DKxDAR/4nbqqvOok48brGzmeVFDRpFueO3QnCn3/WK4Qf68NZuKwwVm
	 MTVWdn6/ebJF+6H0EQc+Z3fFGAhNK39wgzyboo65FlcV0IdiECHvoLuuzCO4RQ79ep
	 +piAG5P6utZBuXgxvifp5IxI+8M31Qqp059p0f3KMdToh3e7CiXQNUbv08qoR64fFT
	 VCdBfafp4a2VBnF3FMFfMv64NoHCRh7Ws0F4TB5pvODvzMAFlB8rjZ/Lyj2MFX9UCK
	 GlmiLPup/CGBQ==
Received: from 192.168.10.47
	by mg.richtek.com with MailGates ESMTPS Server V6.0(244590:0:AUTH_RELAY)
	(envelope-from <cy_huang@richtek.com>)
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256/256); Thu, 31 Jul 2025 13:47:37 +0800 (CST)
Received: from ex3.rt.l (192.168.10.46) by ex4.rt.l (192.168.10.47) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.11; Thu, 31 Jul
 2025 13:47:37 +0800
Received: from git-send.richtek.com (192.168.10.154) by ex3.rt.l
 (192.168.10.45) with Microsoft SMTP Server id 15.2.1544.11 via Frontend
 Transport; Thu, 31 Jul 2025 13:47:37 +0800
From: <cy_huang@richtek.com>
To: Sebastian Reichel <sre@kernel.org>, Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>
CC: Conor Dooley <conor+dt@kernel.org>, ChiYuan Huang <cy_huang@richtek.com>,
	<devicetree@vger.kernel.org>, <linux-pm@vger.kernel.org>,
	<linux-kernel@vger.kernel.org>
Subject: [PATCH v2 0/3] Add Richtek RT9756 Smart-Cap divider charger
Date: Thu, 31 Jul 2025 13:48:15 +0800
Message-ID: <cover.1753940508.git.cy_huang@richtek.com>
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


