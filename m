Return-Path: <linux-pm+bounces-41847-lists+linux-pm=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-pm@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id rpljL4Iuf2kZlQIAu9opvQ
	(envelope-from <linux-pm+bounces-41847-lists+linux-pm=lfdr.de@vger.kernel.org>)
	for <lists+linux-pm@lfdr.de>; Sun, 01 Feb 2026 11:44:18 +0100
X-Original-To: lists+linux-pm@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [172.232.135.74])
	by mail.lfdr.de (Postfix) with ESMTPS id 523A2C576B
	for <lists+linux-pm@lfdr.de>; Sun, 01 Feb 2026 11:44:18 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id 67C4E30022E2
	for <lists+linux-pm@lfdr.de>; Sun,  1 Feb 2026 10:44:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6C664322C99;
	Sun,  1 Feb 2026 10:44:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="gROvpyKY"
X-Original-To: linux-pm@vger.kernel.org
Received: from mail-wr1-f45.google.com (mail-wr1-f45.google.com [209.85.221.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B89702EC54C
	for <linux-pm@vger.kernel.org>; Sun,  1 Feb 2026 10:44:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769942654; cv=none; b=MaagVNxdUOKWaVz41toiXE1REo2tHIKCs/mlDoHc5TfjLzG6aWdb/aK/plotCEi2sqcFPoaR29DnXzEgOj8D0tX2n4CRO9V96Jkddn2DIDWSwunTrd+e+83BKns5z96BuCZZwuRIyEvE0yPx/BFvYVph/BesHpB6zFn3HV/V+2k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769942654; c=relaxed/simple;
	bh=z0OeZ0DJQ0E/+donS2QQkMz+d62Uv6TmN9IynwMz9Hs=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version:Content-Type; b=JHAkqly10HDbKbWlaIBV6akEZ23wNLSU4n8RB5MnGenDfb5OkirK1hdP6U3pA+hvPZaNpeWnyqo3NhuiZcxkQGRlgTHn7/jCR51vjVQRqBAs2dhDdhCJHsfBqKhPd0lTAYOtlaqispfhKaz7VmuwPzWLP2s47/btXnjQuEklmEk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=gROvpyKY; arc=none smtp.client-ip=209.85.221.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wr1-f45.google.com with SMTP id ffacd0b85a97d-42fbbc3df8fso2684153f8f.2
        for <linux-pm@vger.kernel.org>; Sun, 01 Feb 2026 02:44:12 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1769942651; x=1770547451; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=JaZLxb/TpfjjyCLjMdtwmkz7IMvUMrg74EGxr+gYNgs=;
        b=gROvpyKYSnTUJkQJcIzYaiOop7uXsdVdFQGEarkCejwB8yrnhV9oaEndWdSbYbiy3b
         Md9bmHa5C7NpPJrOD5p+eWiYPq6hIk3A2c8DIjbwrIOr8ZkaEAZfsPxsX3maXygqayPA
         LgIoDNSnASA+qeJRMbFh+OkydaJro0BjItd/+qzuZyX2TJLMXb5mRDxb3Ntlg1qxmQOK
         +RZl+xJlegAtnZnoBfTCzAfIJ7+2/Ny1+UBbKUHBl+1pkHvK85q46bRDQOdiwG5G/uTn
         +pkeornbDPnPZJbWV1TuFckhYxqC1m3K2LAyfxlzX1EpN6BM01NuxS4eV3Vz+eJ26IDA
         8VPA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1769942651; x=1770547451;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=JaZLxb/TpfjjyCLjMdtwmkz7IMvUMrg74EGxr+gYNgs=;
        b=VqBPcVjKlixyaEyNh/Md3iN8i5vkZSycwl4qq4aMWjEn2dY8lcXNs0OMClPHu8IkwD
         Ct5JTM1w5Rs/wLp8tMcZ1gFee167hwZgugkM6omwsODZ8i6ywOMDYAcLLb0J4ucVcFrf
         BAgXGLXMrk3lx2Yn1OH0DCnqqsWiusdeCxBBaBuYJIuubKCzJ1eex/On+546ivOnmhNI
         6ADuOaXhCtdww5r4WxIceJuCvjL2xF9qVlUTv/xV6oTEGxv/toLTmb/Yi2tHvjOEw4nm
         oSnrUxgBYskbBNc7c449N+H9BfEimImxYX4lDVRnHl4++88hGTdZbFAUkVONj34445Fs
         idsg==
X-Forwarded-Encrypted: i=1; AJvYcCXQ2iW07+oGM/81sLUUNprnqc7eKYPqzNOnybtsLugcn1x8+jc5tuNnYcqAliuVYve3eGRBNjfqhg==@vger.kernel.org
X-Gm-Message-State: AOJu0YyoBTGJ/IizqdIVDXk57T9pPNpJheIYRtBZnIMCoVSw8Us1dmhb
	ul5fFeYjjSSpmrtznqt6A5YGpsJT+x3L2NyZYCiJ+aUOs+jZOTQGDXA9
X-Gm-Gg: AZuq6aLhWtq27guD1H5Rpnes6mf5Pl1tuQD7Yylj2uslnLbkFcZGM9ykCdFA0KEhEh+
	83PnLZSUuCZL7QLsmAn6Bwf6iFu6Y5F7piwLev2sst3ZyK3cuI8pAJH6KNMnOpvlC8+5iFiPFs2
	iYiOdMZEWaMtf5ujakYx4pfv+sygD3PRwOSpCV1UOXODAvViB9lnyWBqg3sq/GNIiN4LWTJ4nQW
	tEUt4OP17wkWAG48bPdVIT79FUL2WMXBiuJly5segIYBn7c7X8hVaBR1oLfe0TJy1gXurA8js1Y
	P+JmVCiH2LzdGn4XRLFZv2euOY8b2PkrhglUrXvqTzewsYDnNhIA31dfKiQc3bbEVas2rwz9MKU
	e43XKNAVbuzWk2n4COuGBEucSdmBwemQ4fhJnQHiyVvUlm4alQlpO4C80dMX2VWCCW4n8ao7HZz
	l7Gj+CvKGtNyE=
X-Received: by 2002:a05:600c:474d:b0:47e:e952:86ca with SMTP id 5b1f17b1804b1-482db4486e9mr105328755e9.2.1769942650796;
        Sun, 01 Feb 2026 02:44:10 -0800 (PST)
Received: from xeon ([188.163.112.49])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4806ce56490sm308947455e9.12.2026.02.01.02.44.09
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 01 Feb 2026 02:44:10 -0800 (PST)
From: Svyatoslav Ryhel <clamor95@gmail.com>
To: Lee Jones <lee@kernel.org>,
	Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Dmitry Torokhov <dmitry.torokhov@gmail.com>,
	Pavel Machek <pavel@kernel.org>,
	Arnd Bergmann <arnd@arndb.de>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Sebastian Reichel <sre@kernel.org>,
	Svyatoslav Ryhel <clamor95@gmail.com>,
	=?UTF-8?q?Micha=C5=82=20Miros=C5=82aw?= <mirq-linux@rere.qmqm.pl>,
	Ion Agorria <ion@agorria.com>
Cc: devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	linux-input@vger.kernel.org,
	linux-leds@vger.kernel.org,
	linux-pm@vger.kernel.org
Subject: [PATCH v1 0/9] mfd: Add support for Asus Transformer embedded controller
Date: Sun,  1 Feb 2026 12:43:34 +0200
Message-ID: <20260201104343.79231-1-clamor95@gmail.com>
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
	R_SPF_ALLOW(-0.20)[+ip4:172.232.135.74];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-41847-lists,linux-pm=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FREEMAIL_TO(0.00)[kernel.org,gmail.com,arndb.de,linuxfoundation.org,rere.qmqm.pl,agorria.com];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[17];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	FREEMAIL_FROM(0.00)[gmail.com];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[clamor95@gmail.com,linux-pm@vger.kernel.org];
	DKIM_TRACE(0.00)[gmail.com:+];
	NEURAL_HAM(-0.00)[-1.000];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[linux-pm,dt];
	ASN(0.00)[asn:63949, ipnet:172.232.128.0/19, country:SG];
	TO_DN_SOME(0.00)[]
X-Rspamd-Queue-Id: 523A2C576B
X-Rspamd-Action: no action

Add support for embedded controller used in Asus Transformers for
managing power and input functions.

Michał Mirosław (7):
  misc: Support Asus Transformer's EC access device
  mfd: Add driver for Asus Transformer embedded controller
  input: serio: Add driver for Asus Transformer dock keyboard and
    touchpad
  input: keyboard: Add driver for Asus Transformer dock multimedia keys
  leds: Add driver for Asus Transformer LEDs
  power: supply: Add driver for Asus Transformer battery
  power: supply: Add charger driver for Asus Transformers

Svyatoslav Ryhel (2):
  dt-bindings: misc: document ASUS Transformers EC Dockram
  dt-bindings: mfd: document ASUS Transformer EC

 .../devicetree/bindings/mfd/asus,ec.yaml      | 153 ++++++
 .../bindings/misc/asus,dockram.yaml           |  40 ++
 drivers/input/keyboard/Kconfig                |  10 +
 drivers/input/keyboard/Makefile               |   1 +
 drivers/input/keyboard/asus-ec-keys.c         | 285 +++++++++++
 drivers/input/serio/Kconfig                   |  15 +
 drivers/input/serio/Makefile                  |   1 +
 drivers/input/serio/asus-ec-kbc.c             | 162 ++++++
 drivers/leds/Kconfig                          |  11 +
 drivers/leds/Makefile                         |   1 +
 drivers/leds/leds-asus-ec.c                   | 106 ++++
 drivers/mfd/Kconfig                           |  14 +
 drivers/mfd/Makefile                          |   1 +
 drivers/mfd/asus-ec.c                         | 460 ++++++++++++++++++
 drivers/misc/Kconfig                          |   9 +
 drivers/misc/Makefile                         |   1 +
 drivers/misc/asus-dockram.c                   | 327 +++++++++++++
 drivers/power/supply/Kconfig                  |  22 +
 drivers/power/supply/Makefile                 |   2 +
 drivers/power/supply/asus-ec-battery.c        | 282 +++++++++++
 drivers/power/supply/asus-ec-charger.c        | 205 ++++++++
 include/linux/mfd/asus-ec.h                   | 113 +++++
 22 files changed, 2221 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/mfd/asus,ec.yaml
 create mode 100644 Documentation/devicetree/bindings/misc/asus,dockram.yaml
 create mode 100644 drivers/input/keyboard/asus-ec-keys.c
 create mode 100644 drivers/input/serio/asus-ec-kbc.c
 create mode 100644 drivers/leds/leds-asus-ec.c
 create mode 100644 drivers/mfd/asus-ec.c
 create mode 100644 drivers/misc/asus-dockram.c
 create mode 100644 drivers/power/supply/asus-ec-battery.c
 create mode 100644 drivers/power/supply/asus-ec-charger.c
 create mode 100644 include/linux/mfd/asus-ec.h

-- 
2.51.0


