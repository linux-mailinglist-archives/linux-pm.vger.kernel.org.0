Return-Path: <linux-pm+bounces-42975-lists+linux-pm=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-pm@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id gOISMN0Bm2nPpgMAu9opvQ
	(envelope-from <linux-pm+bounces-42975-lists+linux-pm=lfdr.de@vger.kernel.org>)
	for <lists+linux-pm@lfdr.de>; Sun, 22 Feb 2026 14:17:17 +0100
X-Original-To: lists+linux-pm@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [104.64.211.4])
	by mail.lfdr.de (Postfix) with ESMTPS id 21B1416F259
	for <lists+linux-pm@lfdr.de>; Sun, 22 Feb 2026 14:17:17 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id 9B162300BCA0
	for <lists+linux-pm@lfdr.de>; Sun, 22 Feb 2026 13:17:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A605526FDBF;
	Sun, 22 Feb 2026 13:17:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="key not found in DNS" (0-bit key) header.d=abscue.de header.i=@abscue.de header.b="nVKSSTsX"
X-Original-To: linux-pm@vger.kernel.org
Received: from srv01.abscue.de (abscue.de [89.58.28.240])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1AB13849C;
	Sun, 22 Feb 2026 13:17:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=89.58.28.240
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1771766226; cv=none; b=rHty3K3GJAp4l+wqpktCD6ek2IS0vJ4dcPn9slzkxLcOZz039JstSqP1s26HqWyLWablIuKDtdV3hn3qr/D7gj/7E0nT7WHHFItjGJZFu+XQsTieD9tKynlAw/HBbyZptgaySFZT4MK80zmNsA1LF4GKXnXfCJdwZSMMlaT01Fg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1771766226; c=relaxed/simple;
	bh=qto2akkstPQ98aVQz6M6qBPN/w6YfDpxYc+vdy/ltC8=;
	h=From:Subject:Date:Message-Id:MIME-Version:Content-Type:To:Cc; b=T2vQyJ5RWCq3QreFgmM9JDhKPo6f+pfHf+h5tdGizyXFrHaa+gDxsoRdCZerupgJzO2RVm4hCEA5I8krvVBGL7SgSxM3oiP8Dr3FU6kMDi2VmGolZ/xCOkKULYPZzjwezJlDN5vznkFArGCnPQO361Qv5wE7nO+WM0BbwPrJ+rg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=abscue.de; spf=pass smtp.mailfrom=abscue.de; dkim=fail (0-bit key) header.d=abscue.de header.i=@abscue.de header.b=nVKSSTsX reason="key not found in DNS"; arc=none smtp.client-ip=89.58.28.240
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=abscue.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=abscue.de
Received: from fluffy-mammal.metal.fwg-cag.de (unknown [IPv6:2001:9e8:cde0:3300:edee:770f:8e03:a80])
	by srv01.abscue.de (Postfix) with ESMTPSA id 847AD1C01B6;
	Sun, 22 Feb 2026 14:16:53 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=abscue.de; s=dkim;
	t=1771766215;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding;
	bh=I95L1FK39p9sstQOtS2SIlULTZrZBIxteJlayS5dC3k=;
	b=nVKSSTsXf6/IxKelQhh7jzxLQfCXo2/TOlKkGtPnzBLmsggExTGnpmKpk/wXnuyfJAHmVu
	a4flU1JKNodBquq+mZDNkULryh1CkiG8ykGlq3JiPGhk6zB7vRhAPGSCALF25DX/y373Iw
	BcmNVfLAibt2n1KL7lfbkZRBSe4fIIcWdpxc9Bsdgya2rfTfGoPZ3umXtrEmbVtG24uabS
	lm/rFUAW5aR6Bzlqu5zWYJVjnLyI6hql+yycmolAdLLb+pzjMtMME2jBJKeWaZrd5TsF/e
	1q6xSx/U+6vhGoVkaUbtSlUWETy0fD4A+tQWZ/va7xU3qPwDNZS1Zu24/fb4JQ==
From: =?utf-8?q?Otto_Pfl=C3=BCger?= <otto.pflueger@abscue.de>
Subject: [PATCH 0/6] mfd: sc27xx: Use MFD cells and devm_mfd_add_devices()
Date: Sun, 22 Feb 2026 14:16:44 +0100
Message-Id: <20260222-sc27xx-mfd-cells-v1-0-69526fe74c77@abscue.de>
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
X-B4-Tracking: v=1; b=H4sIALwBm2kC/x3MSwqAMAwA0atI1gZqREWvIi5qm2rAHw1IQby7x
 eVbzDygHIUVhuKByLeonEdGVRbgVnssjOKzgQy1hqhCddSlhHvw6HjbFL2du940obaWIWdX5CD
 pX47T+368iOKHYgAAAA==
X-Change-ID: 20260221-sc27xx-mfd-cells-dab7905f3aae
To: Alexandre Belloni <alexandre.belloni@bootlin.com>, 
 Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>, 
 Conor Dooley <conor+dt@kernel.org>, Orson Zhai <orsonzhai@gmail.com>, 
 Baolin Wang <baolin.wang@linux.alibaba.com>, 
 Chunyan Zhang <zhang.lyra@gmail.com>, Lee Jones <lee@kernel.org>, 
 Pavel Machek <pavel@kernel.org>, Liam Girdwood <lgirdwood@gmail.com>, 
 Mark Brown <broonie@kernel.org>, Sebastian Reichel <sre@kernel.org>
Cc: linux-rtc@vger.kernel.org, devicetree@vger.kernel.org, 
 linux-kernel@vger.kernel.org, linux-leds@vger.kernel.org, 
 linux-pm@vger.kernel.org, 
 =?utf-8?q?Otto_Pfl=C3=BCger?= <otto.pflueger@abscue.de>
X-Mailer: b4 0.14.3
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [0.04 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	R_SPF_ALLOW(-0.20)[+ip4:104.64.211.4:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-42975-lists,linux-pm=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	DMARC_NA(0.00)[abscue.de];
	RCVD_COUNT_THREE(0.00)[4];
	FREEMAIL_TO(0.00)[bootlin.com,kernel.org,gmail.com,linux.alibaba.com];
	DKIM_TRACE(0.00)[abscue.de:~];
	MIME_TRACE(0.00)[0:+];
	R_DKIM_PERMFAIL(0.00)[abscue.de:s=dkim];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[18];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[otto.pflueger@abscue.de,linux-pm@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	ASN(0.00)[asn:63949, ipnet:104.64.192.0/19, country:SG];
	NEURAL_HAM(-0.00)[-0.584];
	TAGGED_RCPT(0.00)[linux-pm,dt];
	MID_RHS_MATCH_FROM(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TO_DN_SOME(0.00)[]
X-Rspamd-Queue-Id: 21B1416F259
X-Rspamd-Action: no action

These changes resulted from the need to decouple the the Linux device
driver hierarchy from the device tree bindings for two different series
introducing regulator [1] and poweroff [2] support for the SC2730 PMIC.

There are different PMICs in the SC27xx series, including SC2730 and
SC2731. These have a lot of similarities, but some differences too. For
instance, they contain compatible RTC blocks, but completely different
sets of regulators.

On the Linux side, each PMIC block needs its own driver. The MFD driver
currently uses devm_of_platform_populate() to load the drivers for the
components of the PMIC, which only works when each component has its own
sub-node with a "compatible" property that is used to select a driver
for the device.

When viewed from the device tree side, the parent node representing the
PMIC already contains a "compatible" property that distinguishes the
different PMICs. While the device tree bindings currently do require a
separate "compatible" property for each sub-node (ADC, fuel gauge,
regulators, ...), this is essentially redundant since the node name and
the parent compatible uniquely identify the component. Moreover, some
parts of the PMIC such as the poweroff/reboot controller do not even
need a corresponding device tree node.

Change the MFD driver to use MFD cells instead, which allows it to
instantiate sub-devices both with and without device tree nodes.
Devices that do not have a separate device tree node with its own
"compatible" property can be matched by their platform device ID.
Use this to hook up the existing SC2731 poweroff and regulator drivers,
which were previously not loaded at all due to the lack of an ID table.

In the device tree bindings, deprecate the redundant "compatible"
property for the "regulators" node. While it might make sense to do this
for the other components too, there are a few reasons to only change the
regulators at this point:
 - The regulators node is special since it is not as independent as the
   other components. For instance, it is the only child node of the PMIC
   that does not have a "reg" property. The set of regulators also
   differs much more between different PMIC models than the register
   layout of the other components.
 - We already have some other PMICs where only the regulators are
   treated specially like this, such as MediaTek MT6359 and MT6370.
 - It was suggested to remove the "compatible" property for the new
   SC2730 regulator bindings I am preparing in [2]. The bindings for
   the other components do not need any significant changes at the
   moment.
 - Unlike the poweroff and regulator components, the other parts are
   already working with the existing drivers and bindings.

For the other components that still have a "compatible" property used
for matching MFD cells, ensure that an SC2730-specific compatible is
defined in the bindings so that it can be listed in the SC2730-specific
device table in the MFD driver.

Signed-off-by: Otto Pflüger <otto.pflueger@abscue.de>

[1]: https://lore.kernel.org/all/20250926-sc2730-reboot-v1-0-62ebfd3d31bb@abscue.de/
[2]: https://lore.kernel.org/all/20260220-sc2730-regulators-v1-0-3f2bbc9ecf14@abscue.de/

---
Otto Pflüger (6):
      dt-bindings: rtc: sc2731: Add compatible for SC2730
      dt-bindings: leds: sc2731: Add compatible for SC2730
      regulator: dt-bindings: sc2731: Deprecate compatible property
      mfd: sprd-sc27xx: Switch to devm_mfd_add_devices()
      power: reset: sc27xx: Add platform_device_id table
      regulator: sc2731: Add platform_device_id table

 .../devicetree/bindings/leds/sprd,sc2731-bltc.yaml |  7 ++++-
 .../devicetree/bindings/mfd/sprd,sc2731.yaml       |  2 --
 .../bindings/regulator/sprd,sc2731-regulator.yaml  |  4 +--
 .../devicetree/bindings/rtc/sprd,sc2731-rtc.yaml   |  7 ++++-
 drivers/mfd/sprd-sc27xx-spi.c                      | 33 +++++++++++++++++++++-
 drivers/power/reset/sc27xx-poweroff.c              |  8 ++++++
 drivers/regulator/sc2731-regulator.c               | 10 ++++++-
 7 files changed, 62 insertions(+), 9 deletions(-)
---
base-commit: d4906ae14a5f136ceb671bb14cedbf13fa560da6
change-id: 20260221-sc27xx-mfd-cells-dab7905f3aae

Best regards,
-- 
Otto Pflüger <otto.pflueger@abscue.de>


