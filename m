Return-Path: <linux-pm+bounces-43612-lists+linux-pm=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-pm@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id GERqFuqBqGlpvQAAu9opvQ
	(envelope-from <linux-pm+bounces-43612-lists+linux-pm=lfdr.de@vger.kernel.org>)
	for <lists+linux-pm@lfdr.de>; Wed, 04 Mar 2026 20:03:06 +0100
X-Original-To: lists+linux-pm@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id DDF3B206C96
	for <lists+linux-pm@lfdr.de>; Wed, 04 Mar 2026 20:03:05 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 2E5113018761
	for <lists+linux-pm@lfdr.de>; Wed,  4 Mar 2026 18:58:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D15C23D7D63;
	Wed,  4 Mar 2026 18:58:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="es3DPGsL"
X-Original-To: linux-pm@vger.kernel.org
Received: from mail-lj1-f172.google.com (mail-lj1-f172.google.com [209.85.208.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 616F93D6CCE
	for <linux-pm@vger.kernel.org>; Wed,  4 Mar 2026 18:58:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772650685; cv=none; b=pJ8H2GY1+ACtFgEYDdz0ftD1Xb+veg8XqrqTUnkELrJtMOy2k8sCMI3ZGzgX8RUX/Ni6aiDD7xiIMshc8qYVqPK4OtBnfuEXToYey7a2nahBapggLFaarjeHGC4aIMUcZnHfnemnIl2SdiMhCgLRW43027vNyxmTVD/ujs4PZAc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772650685; c=relaxed/simple;
	bh=R2AUYnU8Wz8oU/h5rvR1qBJ/kWXkextxlhRXzMBmDPY=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version:Content-Type; b=ryJo4BgJ/+HNmwFJhjqgWtDZn+RwOH1kcQRpOVrTemDv0E7Bv6N3lm71edKQhklrdWUYcztrw8gYKDYAbSgBTpVKY5rrybxIAOhRSPnBIWWXKFkCyJhYKGR0LUOaO1m/VCBYQzd0UlqQzSN8LFD8ftT5MnGJVMTKU3RFKURNkRU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=es3DPGsL; arc=none smtp.client-ip=209.85.208.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-lj1-f172.google.com with SMTP id 38308e7fff4ca-38a2f196cbaso14549911fa.1
        for <linux-pm@vger.kernel.org>; Wed, 04 Mar 2026 10:58:04 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1772650683; x=1773255483; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=3/VwVHY85Z4sAx1gqqncPobsH7DOkhMw1reihUc4ZtI=;
        b=es3DPGsLJn26+Co2HAWCOqc4Gh2z5omQEHbjEFXZ0LWlgaoyj7VsrmenNpRO2hVVaJ
         gl4U3I10/1Ol7mUuJaJi0v52Z72Cy2jno8kmqyRx+7hpBGYkQSCruI7q3mhjBxsPFu4Q
         rHrBnBKmUw7Ctnvej6jWevizr3tfKFV2In6x5T/Kmex9f724I/bl4SK0MJY90eFv8GAQ
         Sdm0iCmjhC014efPxAQ8hkDr4RTrvjg3ud0BbuTpZUWO4uhz0Muq96QnOyoxzQzB+2vW
         fZ40xDQGoYD/OKDXCmxb8899Ywm/lXTAG7pxT4KIekaM4kYNFrns6RXfpUwd8ILkursD
         ZlEg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1772650683; x=1773255483;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=3/VwVHY85Z4sAx1gqqncPobsH7DOkhMw1reihUc4ZtI=;
        b=LvF7sDdIEd3QfoXcKltrAxFMcB0Bd1aMWB8uO3vOuPh5/iz1YsoGA/eb0A4GuErNoD
         z6N+wXO9nYONp6Jo1Viw4E3T0WwDbwLE8w14hwRrr6qXbqucwaaaFrnX2JC1X2Znu3mn
         pQyJN2os5VtJFN5dyOmw6kkSCne9Wrbmty6CT9rYeps0nO64bGkl6wWGPMHdIECvq8sQ
         qpySHf7YTrntti6AIfSUeajGSRUUJMb1XjH/Vy1iXfgIj0GX9bhvD7pLG1bMJR2ATxZ2
         sYC6XXpl5mCPy76uDRkxf4hz0O4mPqY2RxXqkly4vMG5yt2iarZU+WSp6nJGeGIIfx0x
         YsaA==
X-Forwarded-Encrypted: i=1; AJvYcCXhbW+/VQzvFxPIdkwJzcQS5AQzSKbg5G6Omy/Rywo1QOEvMOcSPfHAmZz66eYCDHVrUbMDC6GgjQ==@vger.kernel.org
X-Gm-Message-State: AOJu0Yzx0Dpniq5Ta1Iiy1P6MREEzUbR6HsdRKj8dPyGZQhrUXk8jlEc
	o4LMxIgHx88eayP9wQIDlO34eWJ6dwqE5Pw/UpUOUHoK6p9Gfl2zFZgs
X-Gm-Gg: ATEYQzyIdyRNKBwQFXo4OwaxS9EYa1mstp3SnNs5Y4V3HTEOMa3HkukVp/wKdhG5a5B
	h5E96AgrQ6ylHi3YNwH64VnLJsVk2tG2R/vRC7DU2/deFX/VgskI9drUb7nM69grsB/SoHUkVjc
	oU6sWD0z23zCPFwnPpqDR6zqYFGgLkdNyYtftinVWlfaKzuqWvOSHWeQyTg4RK8N07Syg4y9X/K
	Dztnet81/Fmaiziln1PTB/LdBTM5oUXg5SHD724UGHmQGzneOhgkgkIIyAxdxdeOt2wfPqh0vby
	gCVBOfDTBTxnCzkL4lknAlifNa+uP5j6hjf/n9iPcgKErXgOpJJfVAb83RPC1FzwQGa+czWYIDS
	U3VO+VeipmjEqvFQBaoS5lea1sJzqQA0PeyGrtTnko5Wy+kFn387+zOLFhaAds6Jj7bmT8TnFVQ
	/4yh0dvmqy1wReRsQZYLOvtl0=
X-Received: by 2002:a05:651c:1581:b0:385:dde5:1bf3 with SMTP id 38308e7fff4ca-38a2c564e64mr24339791fa.6.1772650682396;
        Wed, 04 Mar 2026 10:58:02 -0800 (PST)
Received: from xeon ([188.163.112.72])
        by smtp.gmail.com with ESMTPSA id 2adb3069b0e04-5a12a6ddd3bsm704985e87.0.2026.03.04.10.58.01
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 04 Mar 2026 10:58:01 -0800 (PST)
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
Subject: [PATCH v5 0/7] mfd: Add support for Asus Transformer embedded controller
Date: Wed,  4 Mar 2026 20:57:44 +0200
Message-ID: <20260304185751.83494-1-clamor95@gmail.com>
X-Mailer: git-send-email 2.51.0
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Rspamd-Queue-Id: DDF3B206C96
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
	TAGGED_FROM(0.00)[bounces-43612-lists,linux-pm=lfdr.de];
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
	NEURAL_HAM(-0.00)[-0.998];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[linux-pm,dt];
	ASN(0.00)[asn:63949, ipnet:172.105.96.0/20, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[tor.lore.kernel.org:rdns,tor.lore.kernel.org:helo]
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

Changes in v5:
- added asus,tf600t-ec-dock compatible to schema
- rebased on top of v7.0
- kzalloc > kzalloc_obj in keys and kbc
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

 .../asus,tf201-ec-pad.yaml                    | 119 +++
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
 18 files changed, 2084 insertions(+)
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


