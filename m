Return-Path: <linux-pm+bounces-14960-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id A5A2998A922
	for <lists+linux-pm@lfdr.de>; Mon, 30 Sep 2024 17:54:20 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 5EE241F23638
	for <lists+linux-pm@lfdr.de>; Mon, 30 Sep 2024 15:54:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id ACF6D192580;
	Mon, 30 Sep 2024 15:54:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kemnade.info header.i=@kemnade.info header.b="PjbG8syM"
X-Original-To: linux-pm@vger.kernel.org
Received: from mail.andi.de1.cc (mail.andi.de1.cc [178.238.236.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 09D4F18FDD8;
	Mon, 30 Sep 2024 15:54:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=178.238.236.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727711654; cv=none; b=IR3XkPFETOuBin3f2VMAy7X7EqEnftA/JnM+28G9MdLIMIiXVP5fPtrHqM0k6mn6PaSib0eJ1Re643O7HTVr1uLfvoWuc1qWBKVKCL57FW/6qbkKzmsKbnqzur+QVXUtoZX9f1U0XeXwq4yaDou8bSwkkEOKPFKqyCC529w1l+s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727711654; c=relaxed/simple;
	bh=XHeCVGCAA68uB+iXaSC+zM7kVclsEPnj83oCvfKfN+k=;
	h=From:To:Cc:Subject:Date:Message-Id:Content-Type:MIME-Version; b=JE1ox+dccin5F/h8i6xBVvi+JnXb/srsfPwOjSzStMACJS00guGxfiqrmzfa1dyk3ATmLC7Ue4HQq65rhZeybClZhu3L58M2BYsJRglZY3aU8iO6feASEVcCuzFsHOLbz0SQt2xdZp+0jCAjso88GwWMb0SVbVQYHBfA8C7zlbk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=kemnade.info; spf=pass smtp.mailfrom=kemnade.info; dkim=pass (2048-bit key) header.d=kemnade.info header.i=@kemnade.info header.b=PjbG8syM; arc=none smtp.client-ip=178.238.236.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=kemnade.info
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=kemnade.info
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=kemnade.info; s=20220719; h=Cc:From:Sender:Reply-To:Content-ID:
	Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
	:Resent-Message-ID:In-Reply-To:References;
	bh=64AltZ5JsyGhLpm5jJhK2CpzvWYO5cy1DKGUkmUcpmw=; b=PjbG8syMtiRMip5qp28/Bfc/0p
	dFXJDAdLcU7DmvkxEbj8oX/6X7QDbC2bi1wfowsLHxKkBDEuK/g9ZdKhLPLOOsfuTkZxyw1zlmtZ/
	0lStGC0Yo3PVzAvgpova3BYfS+9HgAJyCq9MyLZ/3C1jD1K7hu52AK8Mh/ZE/K6PDMppq3OI/NDdH
	ISd/3lKTus93/zDm8eX4usx13qUhu1Fu+0qywWanmt2z56znwibVz/lBe6rHmX3MvF6TFWdaEIgS2
	1YTlBetSNjerYJhoVV+f6xoDuDn2CeLXzSrZWRH7OPCyY9RZ98VsvBBYrJ/8jrhXlQFdg3IsiTyrh
	0Uvl3OCA==;
From: Andreas Kemnade <andreas@kemnade.info>
To: Krzysztof Kozlowski <krzk+dt@kernel.org>,
	linux-pm@vger.kernel.org,
	Conor Dooley <conor+dt@kernel.org>,
	tony@atomide.com,
	linux-kernel@vger.kernel.org,
	linux-omap@vger.kernel.org,
	Lee Jones <lee@kernel.org>,
	devicetree@vger.kernel.org,
	Sebastian Reichel <sre@kernel.org>,
	Rob Herring <robh@kernel.org>
Cc: Andreas Kemnade <andreas@kemnade.info>
Subject: [PATCH v2 0/3] power: supply: twl6030/32 charger
Date: Mon, 30 Sep 2024 17:54:01 +0200
Message-Id: <20240930155404.1275702-1-andreas@kemnade.info>
X-Mailer: git-send-email 2.39.2
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Add basic support for the charger in the TWL6030/32. Supported is the USB
path. AC path is not handled yet, also there is no entry yet
in /sys/class/power_supply with type battery yet.

Without this series, devices will happily drain battery when running
on mainline.

Changes in v2:
- s/bci/charger in mfd schema
- additionalProperties for charger node
- extended example in mfd schema
- no quotes for compatibles in charger schema
- no example in charger schema
- interrupt description in charger schema
- replace device_is_compatible by driver data
- clang compile fix
- removed alias
- style fixes

Andreas Kemnade (3):
  dt-bindings: power: supply: Add TI TWL603X charger
  dt-bindings: mfd: twl: add charger node also for TWL603x
  power: supply: initial support for TWL6030/32

 .../devicetree/bindings/mfd/ti,twl.yaml       |  22 +
 .../power/supply/ti,twl6030-charger.yaml      |  48 ++
 drivers/power/supply/Kconfig                  |  10 +
 drivers/power/supply/Makefile                 |   1 +
 drivers/power/supply/twl6030_charger.c        | 580 ++++++++++++++++++
 5 files changed, 661 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/power/supply/ti,twl6030-charger.yaml
 create mode 100644 drivers/power/supply/twl6030_charger.c

-- 
2.39.2


