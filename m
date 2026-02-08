Return-Path: <linux-pm+bounces-42264-lists+linux-pm=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-pm@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id YAF7LZ7NiGn6wAQAu9opvQ
	(envelope-from <linux-pm+bounces-42264-lists+linux-pm=lfdr.de@vger.kernel.org>)
	for <lists+linux-pm@lfdr.de>; Sun, 08 Feb 2026 18:53:34 +0100
X-Original-To: lists+linux-pm@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 285111099A2
	for <lists+linux-pm@lfdr.de>; Sun, 08 Feb 2026 18:53:34 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 6B4F030086ED
	for <lists+linux-pm@lfdr.de>; Sun,  8 Feb 2026 17:53:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 994532E542C;
	Sun,  8 Feb 2026 17:53:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=disroot.org header.i=@disroot.org header.b="kT3oJbop"
X-Original-To: linux-pm@vger.kernel.org
Received: from layka.disroot.org (layka.disroot.org [178.21.23.139])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AC35F23A9B3;
	Sun,  8 Feb 2026 17:53:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=178.21.23.139
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770573205; cv=none; b=rzp0uw3StzBa/gQlipflhg1ycP7iN87eX3aWaliGmu54RIcIhwrlxQD+oFWT9l8WDDpZGN3+K9xWrJbsTVAkYjQg+wQOzIfczuTK90np08XUxO5688rX8RndP3LxrVwIhuhkedNZ4JRz1BzYB6NMm5y80ojqjLwHpNdBYxDMYEY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770573205; c=relaxed/simple;
	bh=Pu+m854baPlsj4/F+h1GYe5y3YUWvgvtyTFNfAh4qAs=;
	h=From:Subject:Date:Message-Id:MIME-Version:Content-Type:To:Cc; b=ML4rnel7ZYZfeEk/jFzCVz5ufLWPrKZbCrWSBkw0XlY5+/gpfMdwO+7aLz67dlCZDY4dvS+Mxx1vCTIHTIbinT6vz2b+T1JiEUvkP1sCQEVsyhuJNrlYeJBWjgAWJa9RR7IpwDF8RJyYtxUHRyAJqfJgK7xlnlR61hjqufF1mVE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=disroot.org; spf=pass smtp.mailfrom=disroot.org; dkim=pass (2048-bit key) header.d=disroot.org header.i=@disroot.org header.b=kT3oJbop; arc=none smtp.client-ip=178.21.23.139
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=disroot.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=disroot.org
Received: from [127.0.0.1] (localhost [127.0.0.1])
	by disroot.org (Postfix) with ESMTP id 38877276CF;
	Sun,  8 Feb 2026 18:53:17 +0100 (CET)
X-Virus-Scanned: SPAM Filter at disroot.org
Received: from layka.disroot.org ([127.0.0.1])
 by localhost (disroot.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id qFa9nsA_yZ2F; Sun,  8 Feb 2026 18:53:16 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=disroot.org; s=mail;
	t=1770573196; bh=Pu+m854baPlsj4/F+h1GYe5y3YUWvgvtyTFNfAh4qAs=;
	h=From:Subject:Date:To:Cc;
	b=kT3oJbopiX3ioUiGxC/zfDP2omZyLYPUt2ShHidtjJylrHTaBLbHlT4F4U6k3lRP+
	 y4ovpWyhFp391QqA0+U/zU3rBknkhmog0cXOtVqQdZxFf9/M1zb9yRUw4aNZPHLcr8
	 IC9LTgMQngLlXYMqtlcmP6c0rLyMCJmOi3hG9JlX6H2c1PjLHG4Z0F7NgOZGCn4h6F
	 w0Wc0a/lJ31S03LxjD+bAnh8qvf0bQaMIMQPzOK8iA535ad6EULmB/Bv8kyXqbzPsV
	 r+ZOP7Z2Z7h8uubpSIHKk4Cip0IbSeOdROmtnKfMmpW/uVzqc3jtweP4k7alkgfdUe
	 PO1xXY97kKFhw==
From: Kaustabh Chakraborty <kauschluss@disroot.org>
Subject: [PATCH v2 0/2] Add support for Samsung S2MU005 battery fuel gauge
 device
Date: Sun, 08 Feb 2026 23:22:29 +0530
Message-Id: <20260208-s2mu005-fuelgauge-v2-0-be3af8969291@disroot.org>
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIAF3NiGkC/32NQQ7CIBBFr9LMWsyAlhRX3sN0UWVKJ9HSQCGah
 ruLPYDL9/P/+xtECkwRLs0GgTJH9nMFdWjgMQ2zI8G2MihUGqXSIqpXQmzFmOjphlQLqiVjTUs
 nvGuouyXQyO/deesrTxxXHz77RZa/9J8tS4FCd4M8a7LYSXO1HIP369EHB30p5QtLTz9btAAAA
 A==
X-Change-ID: 20260126-s2mu005-fuelgauge-25e9d95e30b6
To: Yassine Oudjana <y.oudjana@protonmail.com>, 
 Sebastian Reichel <sre@kernel.org>, Rob Herring <robh@kernel.org>, 
 Krzysztof Kozlowski <krzk+dt@kernel.org>, 
 Conor Dooley <conor+dt@kernel.org>
Cc: linux-pm@vger.kernel.org, devicetree@vger.kernel.org, 
 linux-kernel@vger.kernel.org, Kaustabh Chakraborty <kauschluss@disroot.org>
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
	TAGGED_FROM(0.00)[bounces-42264-lists,linux-pm=lfdr.de];
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
	NEURAL_HAM(-0.00)[-0.972];
	RCPT_COUNT_SEVEN(0.00)[9];
	MID_RHS_MATCH_FROM(0.00)[];
	TO_DN_SOME(0.00)[];
	TAGGED_RCPT(0.00)[linux-pm,dt];
	DBL_BLOCKED_OPENRESOLVER(0.00)[disroot.org:email,disroot.org:dkim,disroot.org:mid,sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: 285111099A2
X-Rspamd-Action: no action

This patch series adds supports for the battery fuel gauge device for
Samsung S2MU005 PMIC battery chargers. It reports various metrics,
including incoming voltage, current, battery capacity, etc.

Although this device is independent of the actual PMIC which it
accompanies in functionality, it is used in conjunction with the PMIC's
charger sub-device to provide complete battery status.

Signed-off-by: Kaustabh Chakraborty <kauschluss@disroot.org>
---
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
 drivers/power/supply/Kconfig                       |   9 +
 drivers/power/supply/Makefile                      |   1 +
 drivers/power/supply/s2mu005-battery.c             | 306 +++++++++++++++++++++
 4 files changed, 365 insertions(+)
---
base-commit: 9845cf73f7db6094c0d8419d6adb848028f4a921
change-id: 20260126-s2mu005-fuelgauge-25e9d95e30b6

Best regards,
-- 
Kaustabh Chakraborty <kauschluss@disroot.org>


