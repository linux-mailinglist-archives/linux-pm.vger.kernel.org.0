Return-Path: <linux-pm+bounces-43244-lists+linux-pm=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-pm@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id +MJvDB9IoGkuhwQAu9opvQ
	(envelope-from <linux-pm+bounces-43244-lists+linux-pm=lfdr.de@vger.kernel.org>)
	for <lists+linux-pm@lfdr.de>; Thu, 26 Feb 2026 14:18:23 +0100
X-Original-To: lists+linux-pm@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 830F61A6405
	for <lists+linux-pm@lfdr.de>; Thu, 26 Feb 2026 14:18:22 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id BF96531262AD
	for <lists+linux-pm@lfdr.de>; Thu, 26 Feb 2026 13:11:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 76415314A6F;
	Thu, 26 Feb 2026 13:11:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="trLkHbkZ"
X-Original-To: linux-pm@vger.kernel.org
Received: from mail-ej1-f41.google.com (mail-ej1-f41.google.com [209.85.218.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3DE9C3164DF
	for <linux-pm@vger.kernel.org>; Thu, 26 Feb 2026 13:11:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772111501; cv=none; b=YoT6Ic9LGXgPIn13L8r+rERiC5Drzi4Q3ayWoxHwx4PqwOe/kXxoW0RRCZINV3ayev+5pFA+llWp4CP3JweGRNUOCR9EM1a6lQfZgkTxCh/BXX7DVCvhJz38FWGf+ydd9obeQfHCDx6zK6qHMZJXM34hXYPLreZC6+cSKP2H9Gc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772111501; c=relaxed/simple;
	bh=IGHiRaxygQNdddHW6bvT5Rc/bkZhiIQw6q4v2x92FDI=;
	h=From:Subject:Date:Message-Id:MIME-Version:Content-Type:To:Cc; b=pfgKjMvShPN+hUpJHC8MFlmK6PO1JT/BywKH4oIvUtVCEbYhl9xm63tgoVoBLeTLUTTR3SbvonCdEEPywE9heU18zveUj9zieSFp26HndKsUzOPhV1IeayPpnm9DbvQYxoKrWGGw2pcHWg2waMsMeQxaghQTEYuwcmaWi9SeC5M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=trLkHbkZ; arc=none smtp.client-ip=209.85.218.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-ej1-f41.google.com with SMTP id a640c23a62f3a-b8fb6ad3243so119354066b.1
        for <linux-pm@vger.kernel.org>; Thu, 26 Feb 2026 05:11:39 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1772111497; x=1772716297; darn=vger.kernel.org;
        h=cc:to:content-transfer-encoding:mime-version:message-id:date
         :subject:from:from:to:cc:subject:date:message-id:reply-to;
        bh=h24Zi+vYuRfQ0kzsXRE347W+ILF1Izf+kpCpD6zpU3w=;
        b=trLkHbkZf/6SGPdjlcqg3if0pBUCKbua0AWi/dO6LV2l/uTljsKcvWY6s6jdKXXiNh
         W1Km9eof8HuHfG+UouCj9ApMSmt6Zw9t0Hg7FPaxh627J2KYXXbM19Vg5Hbumyb4H5e3
         H2ropzWbvDeOMUM5FV+jhN6Qh2uD+/N5VjgmqSstrme25q8hpYSWgzMtLUnClv6S6kg8
         vfEJh9iw6UCzbVTz1PB8Ar+qu3/yq/INqTHuPe+WuB2xKGk4ysDNuTSf+viP9D5ez6lD
         E5B2bzM5q7wfH+zd3Vuu38oNeWSSPPYC/qh/fJvcYQbd2np3wvrZ8IvmMghKoQUPDdf3
         ltNQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1772111497; x=1772716297;
        h=cc:to:content-transfer-encoding:mime-version:message-id:date
         :subject:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=h24Zi+vYuRfQ0kzsXRE347W+ILF1Izf+kpCpD6zpU3w=;
        b=Xfht/AGzBeAB9Lk3d5lr7kTjDTYdHEsXWAiEI8VEn/k69oW2aRe0XwNDw5D/fM4bPf
         V8lFyaS1NhB/ZaOFSVe8Bqj5uyzUzLVNwE3v2RSBpwzlsZXceAkq2CuNtHvUiq4HHYQK
         FZiZO0Ag+Z4WQhqfi+T23p1CQiyFXjfXLpt7k550rUpc/1PpXr/J5/lTXyP5xpSPiES4
         d34/G8a0auCz9l3yxmDK3+a9Q/PhTaYPEqeXkpKYJmo5cm5ik9NHQOfslSxayZ/G9B/F
         SzfbwVG1jv/XtD0qeA6V9nzqRZolnM3h0K/gqh5bJazmcfjeLNpae21f+ME3psMENGP4
         GRXw==
X-Forwarded-Encrypted: i=1; AJvYcCVfUm606Toj7HxNnnPfcRgN0mV0L87DuzUZArwzpCtP8ljbuZd9utD4BusWVSDwG6x1VldJ+qpyKQ==@vger.kernel.org
X-Gm-Message-State: AOJu0Yx5ZQvktxWcjjpuOftar9ZahjUduVyNtoFEQlLQEgPhain+8cME
	El7OxQMlk2hFb7f8O3kGlyiyc/39u2yymTBFPXD8baDo+2h+vzTwt/CZ36FXyd5Kpjg=
X-Gm-Gg: ATEYQzwQhz910zcEb4iwo0b7CdHLnAsXzkd6z9LakVXCxtFsJQNQn7BkvlyFQrKw3rD
	4BKmBeDMqBS6gKWEVvKgmlwLqlkqYY3urmzoHcJ16RYQXy5kRu5nO3HiTGZw0BQCYYstemVXfzy
	G4eLiLD+q8cn6pXgrQuF29ICOvfgbcqMD514NgxR5ptIp84MUH/iaQlURiWC4ZOeSuC7yL7JmMO
	76otgPxDsq/EGOK0FS1G8LC7Hok71AAntfsvEXjCs45vPVqpccNWuWcdj3suslFGOs9VmxChNKG
	g0uk8TeFFiebp2sMu+Vl26Z71pdGnCsyWlXTdfCNXN3cEQJxhCtodRMb/MIEZ+vHqrSSPm4Vwdv
	+Z5xNjHgZT7HrDVIEjWTlDrBKjLFwBVT6CLpwHgGwJEKrasIQqzuzvqb7hRxiBsMqrbG0YGnSZK
	XNKhLi9afT7Vop5C/fBvFszTWYmOMBIP4P0WJ3yv5SWx5QCC5svI0MuM567iyx+Q6xND5Siy7uN
	1XManJdQ0uG0QT9qw==
X-Received: by 2002:a17:906:fe46:b0:b93:46a8:3f3d with SMTP id a640c23a62f3a-b9346a8457dmr416375066b.44.1772111497416;
        Thu, 26 Feb 2026 05:11:37 -0800 (PST)
Received: from puffmais2.c.googlers.com (244.175.141.34.bc.googleusercontent.com. [34.141.175.244])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-b935ac73d2asm55125866b.26.2026.02.26.05.11.36
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 26 Feb 2026 05:11:37 -0800 (PST)
From: =?utf-8?q?Andr=C3=A9_Draszik?= <andre.draszik@linaro.org>
Subject: [PATCH 00/11] power: supply: max17042: support Maxim MAX77759 fuel
 gauge
Date: Thu, 26 Feb 2026 13:11:34 +0000
Message-Id: <20260226-max77759-fg-v1-0-ff0a08a70a9f@linaro.org>
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
X-B4-Tracking: v=1; b=H4sIAIZGoGkC/6tWKk4tykwtVrJSqFYqSi3LLM7MzwNyDHUUlJIzE
 vPSU3UzU4B8JSMDIzMDIyMz3dzECnNzc1NL3bR0XYM0k6Q0AwtDs+TUFCWgjoKi1LTMCrBp0bG
 1tQBIJpVoXQAAAA==
X-Change-ID: 20260226-max77759-fg-0f4bf0816ced
To: Hans de Goede <hansg@kernel.org>, Krzysztof Kozlowski <krzk@kernel.org>, 
 Marek Szyprowski <m.szyprowski@samsung.com>, 
 Sebastian Krzyszkowiak <sebastian.krzyszkowiak@puri.sm>, 
 Purism Kernel Team <kernel@puri.sm>, Sebastian Reichel <sre@kernel.org>, 
 Rob Herring <robh@kernel.org>, Conor Dooley <conor+dt@kernel.org>
Cc: Peter Griffin <peter.griffin@linaro.org>, 
 Tudor Ambarus <tudor.ambarus@linaro.org>, Juan Yescas <jyescas@google.com>, 
 Amit Sunil Dhamne <amitsd@google.com>, kernel-team@android.com, 
 linux-pm@vger.kernel.org, devicetree@vger.kernel.org, 
 linux-kernel@vger.kernel.org, 
 =?utf-8?q?Andr=C3=A9_Draszik?= <andre.draszik@linaro.org>
X-Mailer: b4 0.14.3
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.66 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[linaro.org,none];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	R_DKIM_ALLOW(-0.20)[linaro.org:s=google];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	MIME_TRACE(0.00)[0:+];
	RCPT_COUNT_TWELVE(0.00)[17];
	FORGED_SENDER_MAILLIST(0.00)[];
	TAGGED_FROM(0.00)[bounces-43244-lists,linux-pm=lfdr.de];
	DKIM_TRACE(0.00)[linaro.org:+];
	RCVD_TLS_LAST(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	FROM_HAS_DN(0.00)[];
	TO_DN_SOME(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[andre.draszik@linaro.org,linux-pm@vger.kernel.org];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	NEURAL_HAM(-0.00)[-0.998];
	TAGGED_RCPT(0.00)[linux-pm,dt];
	MID_RHS_MATCH_FROM(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sysfs.technology:url,linaro.org:mid,linaro.org:dkim,linaro.org:email,sysfs.online:url,sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,uevent.name:url]
X-Rspamd-Queue-Id: 830F61A6405
X-Rspamd-Action: no action

Hi,

This series adds support for the fuel gauge integrated into the Maxim
MAX77759, which is a companion PMIC intended for use in mobile phones
and tablets and is used on Google Pixel 6 and 6 Pro (oriole and raven).

Amongst others, the PMIC contains a fuel gauge employing the Maxim
ModelGauge m5 algorithm, that is similar to the ones supported by the
max17042 driver and binding.

The Maxim ModelGauge m5 algorithm, as well as previous generations like
m3 on max17047/max17050, requires the host to save/restore some
register values across power cycles to maintain full accuracy.
Extending the driver for such support is out of scope in this initial
series.

The series starts with binding updates, followed by driver updates and
improvements in preparation for finally adding max77759 support.

A DT update for Pixel 6 will be posted separately.

Note: While there was a previous attempt to add support for this fuel
gauge via a new driver [1], development seems to have come to a halt,
and extending this driver here seems more appropriate. The patches here
are unrelated to that other attempt, other than supporting the same
device.

Test results:
    $ ./test_power_supply_properties.sh max170xx_battery
    TAP version 13
    1..33
    # Testing device max170xx_battery
    ok 1 max170xx_battery.exists
    ok 2 max170xx_battery.uevent.NAME
    ok 3 max170xx_battery.sysfs.type
    ok 4 max170xx_battery.uevent.TYPE
    ok 5 max170xx_battery.sysfs.usb_type # SKIP
    ok 6 max170xx_battery.sysfs.online # SKIP
    # Reported: '1' ()
    ok 7 max170xx_battery.sysfs.present
    # Reported: 'Unknown'
    ok 8 max170xx_battery.sysfs.status
    # Reported: '92' % ()
    ok 9 max170xx_battery.sysfs.capacity
    ok 10 max170xx_battery.sysfs.capacity_level # SKIP
    ok 11 max170xx_battery.sysfs.model_name # SKIP
    ok 12 max170xx_battery.sysfs.manufacturer # SKIP
    ok 13 max170xx_battery.sysfs.serial_number # SKIP
    # Reported: 'Li-ion'
    ok 14 max170xx_battery.sysfs.technology
    # Reported: '36032' ()
    ok 15 max170xx_battery.sysfs.cycle_count
    # Reported: 'System'
    ok 16 max170xx_battery.sysfs.scope
    ok 17 max170xx_battery.sysfs.input_current_limit # SKIP
    ok 18 max170xx_battery.sysfs.input_voltage_limit # SKIP
    # Reported: '4323906' uV (4.32391 V)
    ok 19 max170xx_battery.sysfs.voltage_now
    # Reported: '3660000' uV (3.66 V)
    ok 20 max170xx_battery.sysfs.voltage_min
    # Reported: '4320000' uV (4.32 V)
    ok 21 max170xx_battery.sysfs.voltage_max
    # Reported: '3300000' uV (3.3 V)
    ok 22 max170xx_battery.sysfs.voltage_min_design
    ok 23 max170xx_battery.sysfs.voltage_max_design # SKIP
    # Reported: '289687' uA (289.687 mA)
    ok 24 max170xx_battery.sysfs.current_now
    ok 25 max170xx_battery.sysfs.current_max # SKIP
    # Reported: '3942000' uAh (3.942 Ah)
    ok 26 max170xx_battery.sysfs.charge_now
    # Reported: '4330000' uAh (4.33 Ah)
    ok 27 max170xx_battery.sysfs.charge_full
    # Reported: '4524000' uAh (4.524 Ah)
    ok 28 max170xx_battery.sysfs.charge_full_design
    ok 29 max170xx_battery.sysfs.power_now # SKIP
    ok 30 max170xx_battery.sysfs.energy_now # SKIP
    ok 31 max170xx_battery.sysfs.energy_full # SKIP
    ok 32 max170xx_battery.sysfs.energy_full_design # SKIP
    ok 33 max170xx_battery.sysfs.energy_full_design # SKIP
    # 15 skipped test(s) detected.  Consider enabling relevant config options to improve coverage.
    # Totals: pass:18 fail:0 xfail:0 xpass:0 skip:15 error:0

Cheers,
Andre'

Link: https://lore.kernel.org/all/20250915-b4-gs101_max77759_fg-v6-0-31d08581500f@uclouvain.be/ [1]
Signed-off-by: André Draszik <andre.draszik@linaro.org>
---
André Draszik (11):
      dt-bindings: power: supply: max17042: add support for max77759
      dt-bindings: power: supply: max17042: support shunt-resistor-micro-ohms
      dt-bindings: power: supply: max17042: drop formatting specifier |
      power: supply: max17042: fix a comment typo (then -> than)
      power: supply: max17042: use dev_err_probe() where appropriate
      power: supply: max17042: avoid overflow when determining health
      power: supply: max17042: time to empty is meaningless when charging
      power: supply: max17042: support standard shunt-resistor-micro-ohms DT property
      power: supply: max17042: initial support for Maxim MAX77759
      power: supply: max17042: max17042: consider task period (max77759)
      power: supply: max17042: report time to full

 .../bindings/power/supply/maxim,max17042.yaml      |  21 ++--
 drivers/power/supply/max17042_battery.c            | 136 ++++++++++++++++++---
 include/linux/power/max17042_battery.h             |  25 +++-
 3 files changed, 154 insertions(+), 28 deletions(-)
---
base-commit: 877552aa875839314afad7154b5a561889e87ea9
change-id: 20260226-max77759-fg-0f4bf0816ced

Best regards,
-- 
André Draszik <andre.draszik@linaro.org>


