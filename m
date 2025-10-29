Return-Path: <linux-pm+bounces-37000-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 00D21C17CDA
	for <lists+linux-pm@lfdr.de>; Wed, 29 Oct 2025 02:14:38 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 71C2E1AA3E70
	for <lists+linux-pm@lfdr.de>; Wed, 29 Oct 2025 01:13:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 850122DA74C;
	Wed, 29 Oct 2025 01:13:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=richtek.com header.i=@richtek.com header.b="ugyjddzT"
X-Original-To: linux-pm@vger.kernel.org
Received: from mg.richtek.com (mg.richtek.com [220.130.44.152])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 019C1268690;
	Wed, 29 Oct 2025 01:13:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=220.130.44.152
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761700409; cv=none; b=nL74O+93MN7/9n/bR2AQ5spghu6Zs8eRoxJwmzXXC9qKpXoVRC4F28nKCCdJ5yrqb4sSNJsFzv9wuQuU5isw5TuXh5rEV2Kxy4Q3933O63YAt0i/dS25zT0oJYLMDFsdNiuiA0B+jgsXiMtlbl1wQcxXVK00Fh602gQGDMPa5qU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761700409; c=relaxed/simple;
	bh=mWa2X6+LwOfYjxifvkpf0MwpY+8Ko/hN94i6VZGnI/Y=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=aGX0VKpUPynmilTQv8YXGznmMK53/kpdmiGxd9eJ46gw3BKdzCD4p/uI136E6N/lt7kb1xIqhGg0suxSTOpPofmoQOMaQzShGcF9efUf+NHezi0H/LqYNrLWl+JDvY67adgmd9KE+6gS3dsFv0xcJAT+o48MuL+3AbaO6sFp1h4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=richtek.com; spf=pass smtp.mailfrom=richtek.com; dkim=pass (2048-bit key) header.d=richtek.com header.i=@richtek.com header.b=ugyjddzT; arc=none smtp.client-ip=220.130.44.152
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=richtek.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=richtek.com
X-MailGates: (SIP:2,PASS,NONE)(compute_score:DELIVER,40,3)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=richtek.com;
	s=richtek; t=1761700404;
	bh=JKEaJHKyx0kJcYHT5vN38l5qT8Wfjpm5itdP0coVV+Y=; l=1177;
	h=From:To:Subject:Date:Message-ID:MIME-Version;
	b=ugyjddzTkSTHE+iUB087Lfd8mvZ1ch+x8i1nBluYdcFxMzcHVcEOBrHrj3Cpc16VQ
	 Yg3QpEAnxCFfD/6eOWN7LPj80ELJ97B0XMEhsENG1FTUYpxHJJ3/pL/reu/1ldb81e
	 dkJOS5uOJoWaJLe/KyeFrfd0JAEN3e09fqghzMpf2EWklzU5FPJrRfYLwQslw3sdFr
	 zr4fV2gW1+IXt6sOxCQwGRtWxfumAVIUefUZ1qy7SqWjnwfzZC9djjBgHCbNUrjoGl
	 I5+oTfnY2WwBaQ2+Gv0zEBKZgMIBBMNx37P620sQYcSxO3mjzZB6jOcd5QqEUKM+om
	 2h5PqE6N7zBzA==
Received: from 192.168.10.46
	by mg.richtek.com with MailGates ESMTPS Server V6.0(3436937:0:AUTH_RELAY)
	(envelope-from <cy_huang@richtek.com>)
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256/256); Wed, 29 Oct 2025 09:13:18 +0800 (CST)
Received: from ex3.rt.l (192.168.10.46) by ex3.rt.l (192.168.10.46) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1748.26; Wed, 29 Oct
 2025 09:13:18 +0800
Received: from git-send.richtek.com (192.168.10.154) by ex3.rt.l
 (192.168.10.45) with Microsoft SMTP Server id 15.2.1748.26 via Frontend
 Transport; Wed, 29 Oct 2025 09:13:18 +0800
From: <cy_huang@richtek.com>
To: Sebastian Reichel <sre@kernel.org>, Krzysztof Kozlowski
	<krzk+dt@kernel.org>
CC: Rob Herring <robh@kernel.org>, Conor Dooley <conor+dt@kernel.org>,
	"ChiYuan Huang" <cy_huang@richtek.com>, <devicetree@vger.kernel.org>,
	<linux-pm@vger.kernel.org>, <linux-kernel@vger.kernel.org>
Subject: [PATCH v3 0/3] Add Richtek RT9756 Smart-Cap divider charger
Date: Wed, 29 Oct 2025 09:14:42 +0800
Message-ID: <cover.1761699952.git.cy_huang@richtek.com>
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

V3
- Instead using customized attribute to report battery voltage and
  current, create a battery psy to report it

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

 .../ABI/testing/sysfs-class-power-rt9756      |  30 +
 .../bindings/power/supply/richtek,rt9756.yaml |  72 ++
 drivers/power/supply/Kconfig                  |  15 +
 drivers/power/supply/Makefile                 |   1 +
 drivers/power/supply/rt9756.c                 | 955 ++++++++++++++++++
 5 files changed, 1073 insertions(+)
 create mode 100644 Documentation/ABI/testing/sysfs-class-power-rt9756
 create mode 100644 Documentation/devicetree/bindings/power/supply/richtek,rt9756.yaml
 create mode 100644 drivers/power/supply/rt9756.c

-- 
2.34.1


