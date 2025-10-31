Return-Path: <linux-pm+bounces-37163-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id 79804C23868
	for <lists+linux-pm@lfdr.de>; Fri, 31 Oct 2025 08:18:55 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 28E194EE0E5
	for <lists+linux-pm@lfdr.de>; Fri, 31 Oct 2025 07:18:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AE64832939D;
	Fri, 31 Oct 2025 07:18:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=richtek.com header.i=@richtek.com header.b="sRmVx62e"
X-Original-To: linux-pm@vger.kernel.org
Received: from mg.richtek.com (mg.richtek.com [220.130.44.152])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C7C0426B2CE;
	Fri, 31 Oct 2025 07:18:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=220.130.44.152
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761895116; cv=none; b=ojZkdkTtap7ib7I15CLvYzEZ5FAYtvzJro8M71UXzTNA2ypXq2tAcddT+6tnOumsvQ3T96b7Kd1u5IQ8bCgaVO+kaf/i9tfefurq5FU3U3YTVMQ4xR3ZOKa+voh1uQO9oYBNOeq6q6MQHgOwPg2GIW4TwpnPZZilS+u8XfCNmig=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761895116; c=relaxed/simple;
	bh=Xd5uxiXG50oCu+kLrTNjXtSylAolIt2j0q3BJlvWUvw=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=CIhPxKaEVVcFJPk0/XXAPhKp0cZtVaP2caQmBfH9CTejngAVJmmYRNi3/BYBKWtFkRjtoXN3DVlBgmTGgCO8kgfRF5Kjnc4VaqN+vUDT/UC66pPnLqV1k+lurTWwkdEwibBNGFSUKkZWLYN5Ks6VKu+abaFowv5z1ppmlfUemQo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=richtek.com; spf=pass smtp.mailfrom=richtek.com; dkim=pass (2048-bit key) header.d=richtek.com header.i=@richtek.com header.b=sRmVx62e; arc=none smtp.client-ip=220.130.44.152
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=richtek.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=richtek.com
X-MailGates: (SIP:2,PASS,NONE)(compute_score:DELIVER,40,3)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=richtek.com;
	s=richtek; t=1761895104;
	bh=sAr1pUXnqThXQ2AsKalxNuYNCUtUyLIp47NV6VFVxYw=; l=1235;
	h=From:To:Subject:Date:Message-ID:MIME-Version;
	b=sRmVx62ePDbjuLMJWic11iGxGO+CCqqhhHN76xHk3FUd3d9XYDD2kt1ucrOU72zd5
	 UcJXM4fTEh0qM5K+rBzZfT7J+WkUpqQ5fJcsWmzo0hONZDHIdwn7cvVrgGxop2V82m
	 UYX0acqT+c+XTl9z3at2nOCnzAPU0exh3gEW6sY4sqFR1qNFbrrMbdLxQGvltX1/AA
	 j++lAaFw6kOtEzCaeDw/oaEj+ZV2nEZEBArU0umgFZgwaJbZoZjYc6YMhIt3RZ2vtE
	 5Rs0i92JO2PEdeayK0GpoUsbWR5fIPchoxV1NYmS75ZTstdKWwq8A7VQxJkBZgVxNN
	 1aGkBHRAYzDiQ==
Received: from 192.168.10.46
	by mg.richtek.com with MailGates ESMTPS Server V6.0(3436932:0:AUTH_RELAY)
	(envelope-from <cy_huang@richtek.com>)
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256/256); Fri, 31 Oct 2025 15:18:08 +0800 (CST)
Received: from ex4.rt.l (192.168.10.47) by ex3.rt.l (192.168.10.46) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1748.26; Fri, 31 Oct
 2025 15:18:08 +0800
Received: from git-send.richtek.com (192.168.10.154) by ex4.rt.l
 (192.168.10.45) with Microsoft SMTP Server id 15.2.1748.26 via Frontend
 Transport; Fri, 31 Oct 2025 15:18:08 +0800
From: <cy_huang@richtek.com>
To: Sebastian Reichel <sre@kernel.org>, Krzysztof Kozlowski
	<krzk+dt@kernel.org>
CC: ob Herring <robh@kernel.org>, Conor Dooley <conor+dt@kernel.org>, "ChiYuan
 Huang" <cy_huang@richtek.com>, <devicetree@vger.kernel.org>,
	<linux-pm@vger.kernel.org>, <linux-kernel@vger.kernel.org>
Subject: [PATCH v4 0/3] Add Richtek RT9756 Smart-Cap divider charger
Date: Fri, 31 Oct 2025 15:19:32 +0800
Message-ID: <cover.1761894605.git.cy_huang@richtek.com>
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

V4
- Fix sparse error that kernel test robot reported

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


