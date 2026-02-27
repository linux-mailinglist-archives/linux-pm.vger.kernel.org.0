Return-Path: <linux-pm+bounces-43281-lists+linux-pm=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-pm@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id EDJGNoZEoWkirwQAu9opvQ
	(envelope-from <linux-pm+bounces-43281-lists+linux-pm=lfdr.de@vger.kernel.org>)
	for <lists+linux-pm@lfdr.de>; Fri, 27 Feb 2026 08:15:18 +0100
X-Original-To: lists+linux-pm@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id 5D8151B3B00
	for <lists+linux-pm@lfdr.de>; Fri, 27 Feb 2026 08:15:18 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 0BF9D302CD25
	for <lists+linux-pm@lfdr.de>; Fri, 27 Feb 2026 07:15:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8B68C3290C7;
	Fri, 27 Feb 2026 07:15:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="WVKBcG9E"
X-Original-To: linux-pm@vger.kernel.org
Received: from mail-ej1-f51.google.com (mail-ej1-f51.google.com [209.85.218.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 337AE301701
	for <linux-pm@vger.kernel.org>; Fri, 27 Feb 2026 07:15:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772176513; cv=none; b=e9vwqerFFEUihVAZ/k/dSdKJwra03rtMsAujOhXaLzZJml22vomNDes04k17FvDQWaxm+wNgNlWWrAV5leK2W5JNBZYgAIlgP3JpacFM3wDw+fD0+tf0KcpIp6ifFzyTR72tugGV/70xtavdQTUiY5jHRKlN+ev59hgJBcJcygE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772176513; c=relaxed/simple;
	bh=69RiUfVmBpCp5tV21obni29ooBpUyV/rTP26GCTQsoU=;
	h=From:Subject:Date:Message-Id:MIME-Version:Content-Type:To:Cc; b=eTQyksbAytFMr/tGcnbppkqI82Qi1d1XfmjltZ+gteOEmA+is2Ds3GuL/6/9uLDV81QvbYPXT8UQbSNExQji3/aBwsw1azKgctsRjyeYfn/RluM80xe5xk/CCNPK52bolLI5uNoueZ/XrwzFpzs3bRZPLv0r3qOMoh9qVdqXPNE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=WVKBcG9E; arc=none smtp.client-ip=209.85.218.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-ej1-f51.google.com with SMTP id a640c23a62f3a-b93698bb57aso209176366b.0
        for <linux-pm@vger.kernel.org>; Thu, 26 Feb 2026 23:15:10 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1772176509; x=1772781309; darn=vger.kernel.org;
        h=cc:to:content-transfer-encoding:mime-version:message-id:date
         :subject:from:from:to:cc:subject:date:message-id:reply-to;
        bh=oHElnmhYtGg+26fmBxabQr+c6QhRzJ5RN9Z3pPQAGwM=;
        b=WVKBcG9E1XHo/t7hK4I6U0wqsdob2wpR/x6QPyjx7gSarpkRLqGEu1z7kpjmhLzbzK
         TMek6Yw4MUUzrzIoPrhWHW5/Su8VcbE4YxvLhmilh08piOMhHqf1SYgEdCoptyzr3Hq6
         +Kh6Qy3DWaN9SSuq/eBqX4S897l9kH7fYwKe+toPkxLBSGKiYQn2/m1WULKqB4F+E2ae
         z2w4Ta2o8RdkltsSDGt1iCuL+aNz1CyPS6Hkzcq5+7dPjhfELN2Pse/mk7j8rYznSYMx
         yZXN35md9phE8t+bwYX7Hd/vf46yg12XFbiiUB+rtIc9Me4v65YHMNhYmvWRT46+LD86
         8fTA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1772176509; x=1772781309;
        h=cc:to:content-transfer-encoding:mime-version:message-id:date
         :subject:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=oHElnmhYtGg+26fmBxabQr+c6QhRzJ5RN9Z3pPQAGwM=;
        b=v/gO2dD3WppsG64/JL2wbE0ZTD9XUMcXQRCPFwBsPexWR423caJd3WEsAf4iVhpQX0
         CxZzwkE3U6z6vvLI2KznWCz9uV/VHqT4/ChuBHG0UVQFQ8xNYV5Q8aZR40cqWis93/8A
         P/99/IG11C6U97QFhiEeXLWcK33dsgLZU4lADH7eNEJqA5UXay2gNHZ9x/5WdRQHVAU0
         JNvC/dw9rpAjQRyvEaoLvF0GvVAWoCpMZCgWCx24qlQ+/YTMi1EZtA/GKlalSWOOQXeY
         MjVPumz6S/nRZS0WtCRewiQ1O2J3PLMq4I6v/gayjyyNv34oGIxIzY3QEH/4fyqsl2Wg
         wYww==
X-Forwarded-Encrypted: i=1; AJvYcCWvtrb4cb5gc5Otwy2ETHiMSIfg81anbnhd8zWLIEIcJOTokeMP1Pk1FB9CjQj/O/4/hOVH0oJUMw==@vger.kernel.org
X-Gm-Message-State: AOJu0YzyxefcUX4nruAcwmnemeqNqvDvJ/ffcCMwfqp/3XmddxSLv6cl
	htuV8r+XjciGfZTq15lt85gq4d6717TPQnSBq1tP3VU7KaQUavOl1ZOesoGDAJijoW0=
X-Gm-Gg: ATEYQzzlD7RHuiWaWJzupan7KNUKaYLJurUgMr4xiClPlTCCVwIeffrFFHiF3PzfKzg
	TGBQbh5DfftktA041CEnbFJPiJ1FNnb3/vrGHMWJnZyDVQtVEu6AzC2QHs4Ahwrc4cGQrpz85cO
	pNwh1H8n5KrBtmzzz0MVEhsSVxV5DShBjdyapokBoWNcBuIjfLofZ4UxNpiFwRtqQv7DSb9LJUe
	0nRU2xUdy6Ii8bYXXGwBNaN0GVBy+7gqtEYeB5CWDWERw7GKzHSrl2UKwTNF1wh9U4MprV0hl9L
	I+Qw3ww++mE3AqagQIOsaxr3prOpI0N9fKF4rGADq1N6iJ2a/dLjXNwQt0OIZRLHgNniouVYyq2
	KzU229shElAZ5+cvjBapied2FDVB5VfETXH3MbmeX5VhmIOLBEFFCw/jeqRL5hJfKZ/n0TeLH/3
	l/Sm4Au9lUGRQFnfhonrwIV+bsecl+/nm7Qj8O3diEqpVJwXlfIKzx8U7+gQhB6dEz/tzIbgCFz
	EpG+IFaGk3gxzT43T4fcTnM/9AS
X-Received: by 2002:a17:907:7b8e:b0:b8f:6f94:a618 with SMTP id a640c23a62f3a-b9375932afdmr117483566b.17.1772176509421;
        Thu, 26 Feb 2026 23:15:09 -0800 (PST)
Received: from puffmais2.c.googlers.com (244.175.141.34.bc.googleusercontent.com. [34.141.175.244])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-b935aeee867sm124205066b.66.2026.02.26.23.15.08
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 26 Feb 2026 23:15:09 -0800 (PST)
From: =?utf-8?q?Andr=C3=A9_Draszik?= <andre.draszik@linaro.org>
Subject: [PATCH v2 00/11] power: supply: max17042: support Maxim MAX77759
 fuel gauge
Date: Fri, 27 Feb 2026 07:15:05 +0000
Message-Id: <20260227-max77759-fg-v2-0-e50be5f191f0@linaro.org>
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
X-B4-Tracking: v=1; b=H4sIAHlEoWkC/23MQQ7CIBCF4as0sxYzEIXWlfcwXWDL0EkUDBhS0
 3B3sWuX/0vet0F2iV2GS7dBcoUzx9BCHTqYFhu8Ezy3BoVKo1JaPO1qjDkPgrxAOt0Je6knN0N
 7vJIjXnftNrZeOL9j+ux4kb/1v1OkQEGEFntr0A50fXCwKR5j8jDWWr/OKfkEpwAAAA==
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
 =?utf-8?q?Andr=C3=A9_Draszik?= <andre.draszik@linaro.org>, 
 Conor Dooley <conor.dooley@microchip.com>
X-Mailer: b4 0.14.3
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.66 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[linaro.org,none];
	R_SPF_ALLOW(-0.20)[+ip4:172.105.105.114:c];
	R_DKIM_ALLOW(-0.20)[linaro.org:s=google];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	MIME_TRACE(0.00)[0:+];
	RCPT_COUNT_TWELVE(0.00)[18];
	FORGED_SENDER_MAILLIST(0.00)[];
	TAGGED_FROM(0.00)[bounces-43281-lists,linux-pm=lfdr.de];
	DKIM_TRACE(0.00)[linaro.org:+];
	RCVD_TLS_LAST(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	FROM_HAS_DN(0.00)[];
	TO_DN_SOME(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[andre.draszik@linaro.org,linux-pm@vger.kernel.org];
	ASN(0.00)[asn:63949, ipnet:172.105.96.0/20, country:SG];
	NEURAL_HAM(-0.00)[-0.998];
	TAGGED_RCPT(0.00)[linux-pm,dt];
	MID_RHS_MATCH_FROM(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sysfs.technology:url,sysfs.online:url,linaro.org:mid,linaro.org:dkim,linaro.org:email,tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: 5D8151B3B00
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
Changes in v2:
- collect tags
- update commit message subject prefix of patch 10 to avoid duplication
- patch 11 (time to full reporting):
  - limit to max17055 & max77759, the datasheet for max17047 and
    max17050 describes the register as 'reserved'. I was mislead by the
    comment and enum ordering in max17042_battery.h
  - report as POWER_SUPPLY_PROP_TIME_TO_FULL_NOW (not _AVG). The
    max17050 datasheet is a bit clearer than the max77759 one on that.
- Link to v1: https://lore.kernel.org/r/20260226-max77759-fg-v1-0-ff0a08a70a9f@linaro.org

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
      power: supply: max17042: consider task period (max77759)
      power: supply: max17042: report time to full (max17055 & max77759)

 .../bindings/power/supply/maxim,max17042.yaml      |  21 ++--
 drivers/power/supply/max17042_battery.c            | 134 ++++++++++++++++++---
 include/linux/power/max17042_battery.h             |  25 +++-
 3 files changed, 152 insertions(+), 28 deletions(-)
---
base-commit: 877552aa875839314afad7154b5a561889e87ea9
change-id: 20260226-max77759-fg-0f4bf0816ced

Best regards,
-- 
André Draszik <andre.draszik@linaro.org>


