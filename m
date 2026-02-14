Return-Path: <linux-pm+bounces-42642-lists+linux-pm=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-pm@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id YNbqH5W6kGm8cgEAu9opvQ
	(envelope-from <linux-pm+bounces-42642-lists+linux-pm=lfdr.de@vger.kernel.org>)
	for <lists+linux-pm@lfdr.de>; Sat, 14 Feb 2026 19:10:29 +0100
X-Original-To: lists+linux-pm@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id DCE9913CB03
	for <lists+linux-pm@lfdr.de>; Sat, 14 Feb 2026 19:10:28 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 528AB301B910
	for <lists+linux-pm@lfdr.de>; Sat, 14 Feb 2026 18:10:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1387730DD18;
	Sat, 14 Feb 2026 18:10:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="e4oezl4x"
X-Original-To: linux-pm@vger.kernel.org
Received: from mail-ed1-f54.google.com (mail-ed1-f54.google.com [209.85.208.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 14BE62BF006
	for <linux-pm@vger.kernel.org>; Sat, 14 Feb 2026 18:10:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1771092621; cv=none; b=K5CoIVbgG2EHhMJGszwcfsuaXQ/qXCfoTAWV6MQwpl2cQu2bVzdJS7wAzu7he7fuNnM36CUuX+4vKn/Tp/UDdkE57+oNXW/m30OGGWlxvZQuY0d2Tt4eIchXw8NxS1S7rEUZk/p8YdAm250EaZ8bDP4RoqDMPhN9c0JfcV3aHoE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1771092621; c=relaxed/simple;
	bh=6X1C0wECNTPSp6EP/HcEzSJeSFFFyaHViLXEg8EpYB8=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version:Content-Type; b=jJSNyvTkQMjr7BtAj84cqlpz94hzbxv4zXhKwADX+1iOxNiuVyqIu4Fg7WjnMrKdUioq+rI89rPRrmralocz5MjlZ7ICfuQrSv/IFsVDadK8A0PKvEiZI11d/O5DfcXdtyet5VknHtTUieBZB2N2Y7DbSMpmPLzuTgvEcco3/7g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=e4oezl4x; arc=none smtp.client-ip=209.85.208.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ed1-f54.google.com with SMTP id 4fb4d7f45d1cf-6594382a264so2868667a12.1
        for <linux-pm@vger.kernel.org>; Sat, 14 Feb 2026 10:10:18 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1771092617; x=1771697417; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=mBgwHHnAe4QujYI3JUVAZlk83RlrT0NjCZwVRWPSZIU=;
        b=e4oezl4xgeX9C9zB3AMRQw6UXQ3do5VNyag1xRW+k0Dx9siqFoPexugdQS1MMq+SDB
         cMTNjdyqV3Gowof96U4AqnEr/cC3mhCg0RfKkyDINuffdnRAFQwhhZNbYMeVkHCUmRcG
         E20dgM4QYuqAoJpm9cE4gevbqkx+csZeuGNsCKxJD7I4ggSEIaISh/Vy0lXy8+ehnae9
         rdHEALQeUOR2GQnfKRMfNxl6X2IHkBG5kGeIQBrJ7TKIcjkVE9/Ae7vWg+L6Y3W3Qio3
         l2lRUmCygBVyZWG0LWzsLhLgXhOVBlyUrr3cJl8TPH3bLkWRWZDUggfLJEiaa5cWfzQ/
         UIpg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1771092617; x=1771697417;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=mBgwHHnAe4QujYI3JUVAZlk83RlrT0NjCZwVRWPSZIU=;
        b=CyAPhMxSzZ1FexCDMRUw9tF0uXFVGZsYMfSixg8qDRrAG7cE7k4ci545UhYxtU7oqd
         32NGpZnjfcn35KlTY/3BR4s/VsjB2/6KwurCqR2jW1/IiEZoOUOk/jcFoop7ml2ggLEC
         bGRXjCpgYOsHWolB2wGno6mHX214Xw1ocP81z4mjP90PgFpVsns8B83j9jT5tfLFxeAQ
         YY95Uj9AFO5IrKnuJ6T7RpsNH8Jy0ihN4gMn5s4a9XutsStAhuwP1+LHmYl1mFihA+5f
         3M0Xs6/Q1go99v0bhol3gj02mDTjtW3CwUXIhZ/dejSIJIGjlxUudHvWbTFu4raOR2VG
         LTqQ==
X-Forwarded-Encrypted: i=1; AJvYcCUvuCuaiXeKtcniA2Dayh+70Np20+QKj1WiIbcIKSZyudI4j3Wo6Vpz765XDOeWvL2Hd9m3S6djKA==@vger.kernel.org
X-Gm-Message-State: AOJu0YwMgIStzrTZXJ1XxGI3nbFK47gua6M4ekDYNW/Xg9q27No2Vpvb
	dsyT3Y3inOVBYno6crAcuvJblulqyspm7UZfbxuQZ52nU0MIkRv4PFfs
X-Gm-Gg: AZuq6aLkn8i+EjC2YsRO09MtWhvQ3w43fL9unzIlA5SVFmaEImf1HpNn9E9MdmVUBI1
	JdyPbqnfX7Vf2QqsUvS/DMjSKft+v+c94cVx54tIgyXNYCF/w0F82WpQthKEes9C0z7kLaeh3Jf
	yhiizvRLQkHEvzLE6Gkn3gki/PxnCmgBybCeW85IWvkaJmkPh4xS+/EczBFh//m2sI9SjnauGZt
	kU6Ai0jG6Yw4zp8dRYB9mK0IkGHUR545TUiKsR9ntEKLApXG9ilLy5yRMtFdpU+cDLcHYkYV5CI
	iZ0WLWasyobYE4Y4/K/XNc4/3cqWYRZ7fNZMCGQlnsAy9HyA8aYcNQJBSGiRmP2i1Ufi+ySz2ma
	8Ya47WwCxPl1cx8RAsaQzXH+VnNS2fO4aUZdIob7mBhVSr7qNNaavO7U+sV4L0zaskNSdyln/7l
	CBz3z7hQ/JoMIE
X-Received: by 2002:a17:907:7ba0:b0:b8a:fd04:c789 with SMTP id a640c23a62f3a-b8fc3a358f8mr162694866b.22.1771092617220;
        Sat, 14 Feb 2026 10:10:17 -0800 (PST)
Received: from xeon ([188.163.112.48])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-b8fc735e506sm88122066b.11.2026.02.14.10.10.16
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 14 Feb 2026 10:10:16 -0800 (PST)
From: Svyatoslav Ryhel <clamor95@gmail.com>
To: Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Dmitry Torokhov <dmitry.torokhov@gmail.com>,
	Lee Jones <lee@kernel.org>,
	Pavel Machek <pavel@kernel.org>,
	Sebastian Reichel <sre@kernel.org>,
	Svyatoslav Ryhel <clamor95@gmail.com>,
	Ion Agorria <ion@agorria.com>,
	=?UTF-8?q?Micha=C5=82=20Miros=C5=82aw?= <mirq-linux@rere.qmqm.pl>
Cc: devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	linux-input@vger.kernel.org,
	linux-leds@vger.kernel.org,
	linux-pm@vger.kernel.org
Subject: [PATCH v3 0/7] mfd: Add support for Asus Transformer embedded controller
Date: Sat, 14 Feb 2026 20:09:52 +0200
Message-ID: <20260214180959.30714-1-clamor95@gmail.com>
X-Mailer: git-send-email 2.51.0
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [0.34 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_CONTAINS_FROM(1.00)[];
	DMARC_POLICY_ALLOW(-0.50)[gmail.com,none];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20230601];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FREEMAIL_FROM(0.00)[gmail.com];
	TAGGED_FROM(0.00)[bounces-42642-lists,linux-pm=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[15];
	FREEMAIL_TO(0.00)[kernel.org,gmail.com,agorria.com,rere.qmqm.pl];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[gmail.com:+];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[clamor95@gmail.com,linux-pm@vger.kernel.org];
	TO_DN_SOME(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[linux-pm,dt];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: DCE9913CB03
X-Rspamd-Action: no action

Add support for embedded controller used in Asus Transformers for
managing power and input functions.

---
Changes in v2:
- converted sysfs debug exports into debugfs
- added kernel-doc comments for exposed functions
- fixed minor typos and inconsistencies

Changes in v3:
- dropped DockRAM commits (both schema and driver)
- integrated DockRAM functionality directly into the controller driver
- EC schema moved to embedded controllers folder
- removed all cell descriptions from the schema
- removed all compatibles from the cell drivers
- adjusted naming conventions to better align with the ASUS Transformers
- defined EC variant sets to provide coverage for all known devices
---

Michał Mirosław (6):
  mfd: Add driver for ASUS Transformer embedded controller
  input: serio: Add driver for ASUS Transformer dock keyboard and
    touchpad
  input: keyboard: Add driver for ASUS Transformer dock multimedia keys
  leds: Add driver for ASUS Transformer LEDs
  power: supply: Add driver for ASUS Transformer battery
  power: supply: Add charger driver for Asus Transformers

Svyatoslav Ryhel (1):
  dt-bindings: embedded-controller: document ASUS Transformer EC

 .../asus,transformer-ec.yaml                  |  98 +++
 drivers/input/keyboard/Kconfig                |  10 +
 drivers/input/keyboard/Makefile               |   1 +
 .../input/keyboard/asus-transformer-ec-keys.c | 272 +++++++
 drivers/input/serio/Kconfig                   |  15 +
 drivers/input/serio/Makefile                  |   1 +
 drivers/input/serio/asus-transformer-ec-kbc.c | 147 ++++
 drivers/leds/Kconfig                          |  11 +
 drivers/leds/Makefile                         |   1 +
 drivers/leds/leds-asus-transformer-ec.c       |  79 ++
 drivers/mfd/Kconfig                           |  14 +
 drivers/mfd/Makefile                          |   1 +
 drivers/mfd/asus-transformer-ec.c             | 763 ++++++++++++++++++
 drivers/power/supply/Kconfig                  |  22 +
 drivers/power/supply/Makefile                 |   2 +
 .../supply/asus-transformer-ec-battery.c      | 272 +++++++
 .../supply/asus-transformer-ec-charger.c      | 193 +++++
 include/linux/mfd/asus-transformer-ec.h       | 162 ++++
 18 files changed, 2064 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/embedded-controller/asus,transformer-ec.yaml
 create mode 100644 drivers/input/keyboard/asus-transformer-ec-keys.c
 create mode 100644 drivers/input/serio/asus-transformer-ec-kbc.c
 create mode 100644 drivers/leds/leds-asus-transformer-ec.c
 create mode 100644 drivers/mfd/asus-transformer-ec.c
 create mode 100644 drivers/power/supply/asus-transformer-ec-battery.c
 create mode 100644 drivers/power/supply/asus-transformer-ec-charger.c
 create mode 100644 include/linux/mfd/asus-transformer-ec.h

-- 
2.51.0


