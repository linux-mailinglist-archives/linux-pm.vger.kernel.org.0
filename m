Return-Path: <linux-pm+bounces-43587-lists+linux-pm=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-pm@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id KP8/IK9nqGl3uQAAu9opvQ
	(envelope-from <linux-pm+bounces-43587-lists+linux-pm=lfdr.de@vger.kernel.org>)
	for <lists+linux-pm@lfdr.de>; Wed, 04 Mar 2026 18:11:11 +0100
X-Original-To: lists+linux-pm@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id EDA80204ECE
	for <lists+linux-pm@lfdr.de>; Wed, 04 Mar 2026 18:11:10 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 1082930CE46C
	for <lists+linux-pm@lfdr.de>; Wed,  4 Mar 2026 17:04:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4EDF83793D2;
	Wed,  4 Mar 2026 17:04:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=disroot.org header.i=@disroot.org header.b="mg8j9LiM"
X-Original-To: linux-pm@vger.kernel.org
Received: from layka.disroot.org (layka.disroot.org [178.21.23.139])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C071837880A;
	Wed,  4 Mar 2026 17:04:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=178.21.23.139
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772643860; cv=none; b=gjAKJtRqkemsX7XRUeziGoDfOVqT0B+EURv7oXjSXbiY+abMn8QuX+C3QQRFmaOnFZkr7goXQ4mniB1O578YTWvaPrvf3xdR8kLQnmmHNoGhXRKLcJtk/ODmXxjqZkwBtJAloDaHZfCfcj3Tnvf14nkzOTmn7XF1339DzJsWk+w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772643860; c=relaxed/simple;
	bh=MMhOI27FbK2gsHYqPxbj7IRqq0LvFdRKpts3+c7aCUk=;
	h=From:Subject:Date:Message-Id:MIME-Version:Content-Type:To:Cc; b=EDZEgPp2WMjnv1989oGW2Hq4BL7kQvHHN2ok33gJuEHXej3A8G8VwcDvLB7H1K1eFR3B3ox1+8doiODg5AkdQafg+bbvp6WxGS1UXIQxkFS2mYTZ+zDGG/6blSx40DWRH6Ysg02jgavaRJKQZyKWiB+pB06NOPw/V5X//o5Kzkk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=disroot.org; spf=pass smtp.mailfrom=disroot.org; dkim=pass (2048-bit key) header.d=disroot.org header.i=@disroot.org header.b=mg8j9LiM; arc=none smtp.client-ip=178.21.23.139
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=disroot.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=disroot.org
Received: from [127.0.0.1] (localhost [127.0.0.1])
	by disroot.org (Postfix) with ESMTP id 567BF26FAD;
	Wed,  4 Mar 2026 18:04:10 +0100 (CET)
X-Virus-Scanned: SPAM Filter at disroot.org
Received: from layka.disroot.org ([127.0.0.1])
 by localhost (disroot.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id LwYsMOZQ5Yn7; Wed,  4 Mar 2026 18:04:09 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=disroot.org; s=mail;
	t=1772643845; bh=MMhOI27FbK2gsHYqPxbj7IRqq0LvFdRKpts3+c7aCUk=;
	h=From:Subject:Date:To:Cc;
	b=mg8j9LiMxt8stFLzDf/t/gEi6sVimh+nCCPcyyZqoKS76SSt4wJihvrtd9chxJ9BX
	 oYtgwoE3apeqVwwANpLL9IIQc8twBbeqwLlLUZmicheDVlF0TyWaVdTaXN0KYpKlk7
	 pKuEnBvBJEYtmbz0ORVWkOWtr11G+grvjEI8UCf5eVF/RKiuBVC87DJI8SM5kJUiI9
	 yMjZs/+u0U61IlV33jp+q4T/TQ23SFJ0cMMtf03iE/hiY8sC6DdalfXnsJWFL1SflX
	 3/rp+hl/uTeHLWQf1UWt/nWRF/tuwLpEEGGcVkugTpZPqDd1HN9CxwVA0no3dzntXA
	 MATiT5ZTXDObQ==
From: Kaustabh Chakraborty <kauschluss@disroot.org>
Subject: [PATCH v3 0/2] Add support for Samsung S2MU005 battery fuel gauge
 device
Date: Wed, 04 Mar 2026 22:33:54 +0530
Message-Id: <20260304-s2mu005-fuelgauge-v3-0-e4dc4e47cde8@disroot.org>
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIAPplqGkC/33NwQrCMAyA4VcZPVtJM1daT76HeOhsthV0lXYty
 ti72+0ignj8Q/JlZpGCo8iO1cwCZRedH0vUu4pdBzP2xJ0tzRBQgkDJI94TQMO7RLfepLKADWm
 rG6qhlazcPQJ17rmZ50vpwcXJh9f2Iot1+k/LggOXyoiDJAtK6JN1MXg/7X3o2epl/BgI6peBx
 WipNp3SUqMW38ayLG8Gm9kC+AAAAA==
X-Change-ID: 20260126-s2mu005-fuelgauge-25e9d95e30b6
To: Yassine Oudjana <y.oudjana@protonmail.com>, 
 Sebastian Reichel <sre@kernel.org>, Rob Herring <robh@kernel.org>, 
 Krzysztof Kozlowski <krzk+dt@kernel.org>, 
 Conor Dooley <conor+dt@kernel.org>
Cc: linux-pm@vger.kernel.org, devicetree@vger.kernel.org, 
 linux-kernel@vger.kernel.org, Kaustabh Chakraborty <kauschluss@disroot.org>, 
 Conor Dooley <conor.dooley@microchip.com>
X-Rspamd-Queue-Id: EDA80204ECE
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.66 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[disroot.org,reject];
	R_DKIM_ALLOW(-0.20)[disroot.org:s=mail];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FROM_HAS_DN(0.00)[];
	TAGGED_FROM(0.00)[bounces-43587-lists,linux-pm=lfdr.de];
	RECEIVED_HELO_LOCALHOST(0.00)[];
	FREEMAIL_TO(0.00)[protonmail.com,kernel.org];
	RCVD_TLS_LAST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	DKIM_TRACE(0.00)[disroot.org:+];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	MISSING_XM_UA(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[kauschluss@disroot.org,linux-pm@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	NEURAL_HAM(-0.00)[-0.999];
	RCPT_COUNT_SEVEN(0.00)[10];
	MID_RHS_MATCH_FROM(0.00)[];
	TO_DN_SOME(0.00)[];
	TAGGED_RCPT(0.00)[linux-pm,dt];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:rdns,sea.lore.kernel.org:helo,disroot.org:dkim,disroot.org:email,disroot.org:mid]
X-Rspamd-Action: no action

This patch series adds supports for the battery fuel gauge device for
Samsung S2MU005 PMIC battery chargers. It reports various metrics,
including incoming voltage, current, battery capacity, etc.

Although this device is independent of the actual PMIC which it
accompanies in functionality, it is used in conjunction with the PMIC's
charger sub-device to provide complete battery status.

Signed-off-by: Kaustabh Chakraborty <kauschluss@disroot.org>
---
Changes in v3:
- added missing Acked-by from Conor
- set Kconfig dependencies (Sebastian Reichel) 
- fix superfluous headers in driver (Sebastian Reichel) 
- add missing psy_cfg.fwnode (Sebastian Reichel) 
- Link to v2: https://lore.kernel.org/r/20260208-s2mu005-fuelgauge-v2-0-be3af8969291@disroot.org

Changes in v2:
- s/fuelgauge/fuel-gauge in dt-bindings (Conor Dooley)
- do not print error messages for -ENOMEM (Sebastian Reichel)
- remove redundant irq_get_trigger_type() (Sebastian Reichel)
- set regmap val_bits to 16 (Sebastian Reichel)
- switch to regmap_{read,write}()
- add current_avg and voltage_avg properties
- implement workaround for false positives due to hysteresis
- Link to v1: https://lore.kernel.org/r/20260126-s2mu005-fuelgauge-v1-0-68a146ed0819@disroot.org

---
Kaustabh Chakraborty (1):
      dt-bindings: power: supply: document Samsung S2MU005 battery fuel gauge

Yassine Oudjana (1):
      power: supply: add support for S2MU005 battery fuel gauge device

 .../power/supply/samsung,s2mu005-fuel-gauge.yaml   |  49 ++++
 drivers/power/supply/Kconfig                       |  11 +
 drivers/power/supply/Makefile                      |   1 +
 drivers/power/supply/s2mu005-battery.c             | 307 +++++++++++++++++++++
 4 files changed, 368 insertions(+)
---
base-commit: fc7b1a72c6cd5cbbd989c6c32a6486e3e4e3594d
change-id: 20260126-s2mu005-fuelgauge-25e9d95e30b6

Best regards,
-- 
Kaustabh Chakraborty <kauschluss@disroot.org>


