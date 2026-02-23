Return-Path: <linux-pm+bounces-42985-lists+linux-pm=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-pm@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id uG9IDUj0m2nk+AMAu9opvQ
	(envelope-from <linux-pm+bounces-42985-lists+linux-pm=lfdr.de@vger.kernel.org>)
	for <lists+linux-pm@lfdr.de>; Mon, 23 Feb 2026 07:31:36 +0100
X-Original-To: lists+linux-pm@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id A32611721C8
	for <lists+linux-pm@lfdr.de>; Mon, 23 Feb 2026 07:31:35 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 8C9A930156EA
	for <lists+linux-pm@lfdr.de>; Mon, 23 Feb 2026 06:31:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 85F94346779;
	Mon, 23 Feb 2026 06:31:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="YcZL5Uf/"
X-Original-To: linux-pm@vger.kernel.org
Received: from mail-lf1-f49.google.com (mail-lf1-f49.google.com [209.85.167.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 186863446AF
	for <linux-pm@vger.kernel.org>; Mon, 23 Feb 2026 06:31:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1771828291; cv=none; b=NoxaxENhN/NSSurBfPKubcxflcaXs+wLtoJtjr843N2b5GzWAWP/gQWQm/ma6gVwZyu2TtccqrHDwJw+hlkUZKbHxyc4xfWwkxYLFOHFRWD3A2spoYi3GgY7vkPc+bfJbaKYwz6sC4xm4DCL6vDjnTsvuTy/aelevBhdApIBx9E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1771828291; c=relaxed/simple;
	bh=3JKhQ9beP6hoqU3EcKP3gop2A/k01QbGeVyTyZU4Hps=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version:Content-Type; b=XW0tM2E+ekEgg8ByHPjKrJj72ZNnqqUNEuA8PlfIo6PblLGCeTQTIUEbqj8+QP/fcsTucwb+PwvCQWjuk4fNobyiBH1tt4V4B4jREmI+pOmYf6QPIi0hbrI6yXIb/vKV7AW5BuK+rr+nJgYcmkLfwzUt48M1rEQ8SVYT7AZxxSo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=YcZL5Uf/; arc=none smtp.client-ip=209.85.167.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-lf1-f49.google.com with SMTP id 2adb3069b0e04-59e5aa4ca41so3770411e87.2
        for <linux-pm@vger.kernel.org>; Sun, 22 Feb 2026 22:31:29 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1771828288; x=1772433088; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=KdetahYQfYhDlhuTa9nYkHK4GpTIEKzr2ZQLLZ1gumA=;
        b=YcZL5Uf/RdWlESKhvLk8DiVdnvltEvqFRteLZ4HvEHDg+vnYBWeD+JSWAVyGpZzI+B
         H/DxLD3dVadaL1U/YnyumzrSylXgSe9j531mt5W1sVb/6bSwMcwynXhhIL2qkrFBOHYT
         vH31kcaO913KcrWDv2VYrFKdvqPV1s6LlrfAA3epfA1a8OWX/L9EELxIp/yd3d4XvYDO
         NfL50o/4quObmKqYepPIONHlrOlpC1xkmJALUb09+WVvDf+4AgleZ2iroe2S44PD4n7Z
         2TFeIrLljwOk9zy7C/isxk1Bqieth3doVWEnERvcRxNUQQZz0mlQRMqjwLiex4dLhsX1
         msWA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1771828288; x=1772433088;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=KdetahYQfYhDlhuTa9nYkHK4GpTIEKzr2ZQLLZ1gumA=;
        b=HGUzVW04Nz8GfQXSAB0boGGxXhaBxA2OuutLmHcdHWYrGE/7CPEqIyZzbP6IXAprGr
         VWI5vWvK4PqT29f+MgtL/Aj/tNq6ItLiEMpwqSGgnd3i+glCcmsz5PISCW24YApKNUYe
         ITGFA/6x17irxOT3Y355K4rhr3NckJ9kkzsIUjxEwVZS4ftUGcUvgLACgS3aDJ+lhPEs
         FFY2BgxzguXd8uYKRb/Hg2EuxK3Zu83NHJF1T0+HZzAihjZO2MGF6Uvu/G3UqOcRxUhK
         KI0aQyjnALhuVKPAA7U/iMF60KvAequwE6iyNZPb6qhi9WXKisUNhLAd1pD6Ed780wGc
         IZ0w==
X-Forwarded-Encrypted: i=1; AJvYcCWuFMN8NB11irdD+sfmyYzUVcgYjHglttRTOh6QhW2oAYH0bnc/fUCGWlGpuLarWbfNwL2kI+KZCg==@vger.kernel.org
X-Gm-Message-State: AOJu0YxGTd2gnRNFK30D9sbU9VDIOhjITQzezzoPfLmLczVk8FUDJIlK
	ZnSLI/Tr/O2vyw6iOF5uDCiWtSpR/fvO1qAWFPZXAwdg2kqVlOQssdqQ
X-Gm-Gg: AZuq6aL/vYwokvl22qa/7pAfTeK1uZKJ1nyG8GrC3Xj8qchb4xl9ze+6VuItSmetBSJ
	ge1yh2sihPAW0qzvlgdvFpyho0iZn2L477z83B/KDj9UQOFxDfDE30k3p+99X5oQoGVfHNtgXmL
	zZ5/ZH2O9Qsm9pHTEl+zFK/iAUTzEQcrVjv1FFKG3RME9ysRhjxxUD+vONjf5KUiCY16Fujym/v
	aThF8YDBqcB/hroZdfCtCj/EuPJAFNe0lKmYjfdt0ROIZgWT99KaD60/A0lve2xqRgNyPqFAf1s
	AALBBYAWiMH2IcAk/IVAmDnYfsZTPW9JvAf2kOos84wVaubmvbbqggtK5TjDgfMdyWlbEBnjCPd
	Y87+JunrI9h9xyXCQnBSL1OrB9iXBL8OJgfcREnrhniCiwI5kmN/+HxRw2OCizfvpMCYlDvwK75
	tRuuGE1Wxf9O/m
X-Received: by 2002:a05:6512:33d3:b0:59e:53c0:5413 with SMTP id 2adb3069b0e04-5a0ed87d8admr2321278e87.5.1771828288020;
        Sun, 22 Feb 2026 22:31:28 -0800 (PST)
Received: from xeon ([188.163.112.76])
        by smtp.gmail.com with ESMTPSA id 2adb3069b0e04-5a0eeb14596sm1361320e87.26.2026.02.22.22.31.26
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 22 Feb 2026 22:31:27 -0800 (PST)
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
Subject: [PATCH v4 0/7] mfd: Add support for Asus Transformer embedded controller
Date: Mon, 23 Feb 2026 08:30:52 +0200
Message-ID: <20260223063059.11322-1-clamor95@gmail.com>
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
	MID_CONTAINS_FROM(1.00)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[gmail.com,none];
	R_SPF_ALLOW(-0.20)[+ip4:172.105.105.114:c];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20230601];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-42985-lists,linux-pm=lfdr.de];
	FREEMAIL_TO(0.00)[kernel.org,gmail.com,agorria.com,rere.qmqm.pl];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	FREEMAIL_FROM(0.00)[gmail.com];
	RCPT_COUNT_TWELVE(0.00)[15];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[clamor95@gmail.com,linux-pm@vger.kernel.org];
	DKIM_TRACE(0.00)[gmail.com:+];
	NEURAL_HAM(-0.00)[-1.000];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[linux-pm,dt];
	ASN(0.00)[asn:63949, ipnet:172.105.96.0/20, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: A32611721C8
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

Changes in v4:
- grouped known programming models of EC chronologically (both schema
  and driver)
- call debugfs init only if CONFIG_DEBUG_FS is enabled
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

 .../asus,tf201-ec-pad.yaml                    | 105 +++
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
 drivers/mfd/asus-transformer-ec.c             | 762 ++++++++++++++++++
 drivers/power/supply/Kconfig                  |  22 +
 drivers/power/supply/Makefile                 |   2 +
 .../supply/asus-transformer-ec-battery.c      | 272 +++++++
 .../supply/asus-transformer-ec-charger.c      | 193 +++++
 include/linux/mfd/asus-transformer-ec.h       | 162 ++++
 18 files changed, 2070 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/embedded-controller/asus,tf201-ec-pad.yaml
 create mode 100644 drivers/input/keyboard/asus-transformer-ec-keys.c
 create mode 100644 drivers/input/serio/asus-transformer-ec-kbc.c
 create mode 100644 drivers/leds/leds-asus-transformer-ec.c
 create mode 100644 drivers/mfd/asus-transformer-ec.c
 create mode 100644 drivers/power/supply/asus-transformer-ec-battery.c
 create mode 100644 drivers/power/supply/asus-transformer-ec-charger.c
 create mode 100644 include/linux/mfd/asus-transformer-ec.h

-- 
2.51.0


