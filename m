Return-Path: <linux-pm+bounces-43407-lists+linux-pm=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-pm@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id UFVwIZWRpWmoDgYAu9opvQ
	(envelope-from <linux-pm+bounces-43407-lists+linux-pm=lfdr.de@vger.kernel.org>)
	for <lists+linux-pm@lfdr.de>; Mon, 02 Mar 2026 14:33:09 +0100
X-Original-To: lists+linux-pm@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id C0DE61D9D24
	for <lists+linux-pm@lfdr.de>; Mon, 02 Mar 2026 14:33:08 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 8F058304C09C
	for <lists+linux-pm@lfdr.de>; Mon,  2 Mar 2026 13:32:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1FB0B3F23DD;
	Mon,  2 Mar 2026 13:32:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="OJ0ksvPW"
X-Original-To: linux-pm@vger.kernel.org
Received: from mail-ed1-f48.google.com (mail-ed1-f48.google.com [209.85.208.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 786132E9EB5
	for <linux-pm@vger.kernel.org>; Mon,  2 Mar 2026 13:32:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772458339; cv=none; b=SlkESn2kqc5bzC7zv78DQ1TaRf+Pp7gy4ZwsOsJ84SMskVbyrOMVOQdId6AHZMjCfmdzDVYaPVlXFcXhGJUkwf0HlLQjexGebro3KJdUUHEVlDzT94BkYpDM1ICxZ4AX/IwL9s9F+FaLaezLC1RT5rLpWARwFdFuCJMreuOZUv4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772458339; c=relaxed/simple;
	bh=/v9rUDNVeFCUg4ml76H2sT8dZY4AQ6D46+Mye12m2Wc=;
	h=From:Subject:Date:Message-Id:MIME-Version:Content-Type:To:Cc; b=fuh7gmWjYTrdsOk4WQZm3fAgDkY1DmIrsRyf8TCFJljsJaPT+jNNxYqsx0EOBi5nC8gn0iqoTAmf7/GGDwxdc3v7jMhFwua+nHpk8RioNAA3SkPgzJE7VLfiTJjt35d/N+pQ4JnsKm7N+Zu1qjUQ/pD+N2eA8bvT095onpCK6II=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=OJ0ksvPW; arc=none smtp.client-ip=209.85.208.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-ed1-f48.google.com with SMTP id 4fb4d7f45d1cf-65a26c220b6so5739400a12.0
        for <linux-pm@vger.kernel.org>; Mon, 02 Mar 2026 05:32:17 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1772458336; x=1773063136; darn=vger.kernel.org;
        h=cc:to:content-transfer-encoding:mime-version:message-id:date
         :subject:from:from:to:cc:subject:date:message-id:reply-to;
        bh=ovH8NF9OBNMsdXoNg2WPMRmni3UPoclCGTCz4c6VJFU=;
        b=OJ0ksvPWbcy1OySYyoANO3mkzRiGUxZA9XLARWUl3iJWkybwmP5etn3JCrxQRKc8Go
         4t4MrV25GYDQvOvBLDbYY/sBzjvxm/vvIWN3te0ouUahZWx4wRr0fTf48tOAzLxsvfJp
         WEfqAV6Aqhi8Lctl0LXf2muGyhirpWSVDwnuMOKDY+Jqv0X5i3uznCyZ/Z8ZENoEy8Vf
         W89ZeI7Q0fvuMpZhDARH6Ct32ht3aR5wQY2+k0et8p82Tn+zwxWQhotQVU8ZQMUU7o6O
         yiNvDeehpDPRzE3ipBDhPnarzuntLyIF1K+bDAlEMbb6kB1zSWBhm3LiiebHGNSyYano
         Sdbg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1772458336; x=1773063136;
        h=cc:to:content-transfer-encoding:mime-version:message-id:date
         :subject:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ovH8NF9OBNMsdXoNg2WPMRmni3UPoclCGTCz4c6VJFU=;
        b=B9b859EL5ItsS2TfDy+YyUvjL0WPhHJa6yDN0ZmrH3p0dkyfaAL7rcnyXOROzoIhOV
         9U0pkD0AGp1IeFmFI9iXvOQy4GY0wLIHTUvTpiN+CryCbwtpAjLOkjB1fIgzk9N/5IsL
         U/WmBx/DriYlL3LMPFVka5yuN4HH5FRQ6zhL6t7X9F0Dvummk4MJ45KWUuJTg4Nk43mx
         ydAaFVKy32LxbC++3eBHKkcEcTOLA47VJKmeR/6T92HhpvDVhpMBgJZ7ut690O5jQefJ
         yKEiemT8D07TvzEFrhkldPtQPxAeYgUk+79J4NOaM9tys7yDhl0n7u8htRQfwXPaSlnj
         zFSA==
X-Forwarded-Encrypted: i=1; AJvYcCUzEUMIk4L1jGPuIxFAMJWVghRUKq1H2dn3cSgCyIAMAhVh1508Lwh4IXSdIPOnmjpyrtqrd+Kk/w==@vger.kernel.org
X-Gm-Message-State: AOJu0YyELJSzYnMhEthm8IM53a4q3sjWWYsUqBMVBoDsB4bJJJpexsd0
	2gihpfW4Z3XXwPlCFYD+TXKHYwWhOmbq8Wlxe3iYTe9Yom7koqtv93KnO2FjTJgKVwk=
X-Gm-Gg: ATEYQzyJYFgFyCRqhlDVy0MsoA2nsvdSJe85KnmuhTa3quY0taW8ot4ZUmU3I/OlVFg
	oNk1YX2o8boYK4fyBwmzEnA7Ftr6cL7RtrRfgn+QGI/ok+U1385iLC+3km/1If2/4CzeE1EgnXg
	eSd+0oCsX7fEfAq79IYnkQg498jrSnhXeP7a9GyEbaMjOYtKZpZnlgdsXiNYKV6AK6AeYG4G4uc
	1JSfpfP0tJ/rdaOkdwd3s9H/NmmjKxRoMT24vhul/X3yktDWyzOwb6YtKUgqpuU1/C2gOQPrMvJ
	l1ve7hP007tscpG1bp2WlSv0wi6ZuIzc9QZUyW4BUEqQG+R7Ia6smc6sw0zrMFE4hFFOnfYyoxa
	5Kh+z2Ms25SCTS1cXobAoBjiPQmp++Nrn14FV3CvZMc25Lf8VD0lKVwYCYkj0wko8lJ//FBW1dX
	WcHNi+187hCwGo/sp7x0/Hd+Ma24J9vL+zP1B6LPb99In0kPknV9RbbBEvtrhygAnFrmppXo1rd
	Gbv5upar6lCLRQ=
X-Received: by 2002:a05:6402:398b:b0:65f:a9f5:750b with SMTP id 4fb4d7f45d1cf-65fddaf6f25mr5895152a12.15.1772458335689;
        Mon, 02 Mar 2026 05:32:15 -0800 (PST)
Received: from puffmais2.c.googlers.com (221.210.91.34.bc.googleusercontent.com. [34.91.210.221])
        by smtp.gmail.com with ESMTPSA id 4fb4d7f45d1cf-65fabf6d1c6sm3282988a12.17.2026.03.02.05.32.14
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 02 Mar 2026 05:32:15 -0800 (PST)
From: =?utf-8?q?Andr=C3=A9_Draszik?= <andre.draszik@linaro.org>
Subject: [PATCH v3 00/11] power: supply: max17042: support Maxim MAX77759
 fuel gauge
Date: Mon, 02 Mar 2026 13:31:59 +0000
Message-Id: <20260302-max77759-fg-v3-0-3c5f01dbda23@linaro.org>
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
X-B4-Tracking: v=1; b=H4sIAFCRpWkC/23MQQ6CMBCF4auQrq2ZVqHgynsYFwVmYBKlpjUNh
 vTuFlaSuHwv+f5FBPSMQVyKRXiMHNhNeZwOhehGOw0ouc9baNAVaF3Jp52NMWUjaZBA55agVlW
 Hvcji5ZF43mq3e94jh7fzny0e1fr+70QlQRKBhdoasA1dHzxZ747OD2INRf2LzR7rjLGEFktSj
 SLY4ZTSF95xp/fkAAAA
X-Change-ID: 20260226-max77759-fg-0f4bf0816ced
To: Hans de Goede <hansg@kernel.org>, Krzysztof Kozlowski <krzk@kernel.org>, 
 Marek Szyprowski <m.szyprowski@samsung.com>, 
 Sebastian Krzyszkowiak <sebastian.krzyszkowiak@puri.sm>, 
 Purism Kernel Team <kernel@puri.sm>, Sebastian Reichel <sre@kernel.org>, 
 Rob Herring <robh@kernel.org>, Conor Dooley <conor+dt@kernel.org>, 
 Ramakrishna Pallala <ramakrishna.pallala@intel.com>
Cc: Peter Griffin <peter.griffin@linaro.org>, 
 Tudor Ambarus <tudor.ambarus@linaro.org>, Juan Yescas <jyescas@google.com>, 
 Amit Sunil Dhamne <amitsd@google.com>, kernel-team@android.com, 
 linux-pm@vger.kernel.org, devicetree@vger.kernel.org, 
 linux-kernel@vger.kernel.org, 
 =?utf-8?q?Andr=C3=A9_Draszik?= <andre.draszik@linaro.org>, 
 Conor Dooley <conor.dooley@microchip.com>, stable@vger.kernel.org
X-Mailer: b4 0.14.3
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.66 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[linaro.org,none];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	R_DKIM_ALLOW(-0.20)[linaro.org:s=google];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	MIME_TRACE(0.00)[0:+];
	RCPT_COUNT_TWELVE(0.00)[20];
	FORGED_SENDER_MAILLIST(0.00)[];
	TAGGED_FROM(0.00)[bounces-43407-lists,linux-pm=lfdr.de];
	DKIM_TRACE(0.00)[linaro.org:+];
	RCVD_TLS_LAST(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	FROM_HAS_DN(0.00)[];
	TO_DN_SOME(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[andre.draszik@linaro.org,linux-pm@vger.kernel.org];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	NEURAL_HAM(-0.00)[-1.000];
	TAGGED_RCPT(0.00)[linux-pm,dt];
	MID_RHS_MATCH_FROM(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,linaro.org:mid,linaro.org:dkim,linaro.org:email,uevent.name:url,sysfs.technology:url,sysfs.online:url]
X-Rspamd-Queue-Id: C0DE61D9D24
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

A DT update for Pixel 6 has been posted in
https://lore.kernel.org/all/20260302-max77759-fg-dts-v2-1-12f1109a6fee@linaro.org/

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
Changes in v3:
- update commit message patch 5 (dev_err_probe)
- drop stray comment patch 6 (overflow)
- add Fixes tag to patch 6 (overflow) (Pete)
- collect tags
- Link to v2: https://lore.kernel.org/r/20260227-max77759-fg-v2-0-e50be5f191f0@linaro.org

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
 drivers/power/supply/max17042_battery.c            | 130 ++++++++++++++++++---
 include/linux/power/max17042_battery.h             |  25 +++-
 3 files changed, 148 insertions(+), 28 deletions(-)
---
base-commit: 3fa5e5702a82d259897bd7e209469bc06368bf31
change-id: 20260226-max77759-fg-0f4bf0816ced

Best regards,
-- 
André Draszik <andre.draszik@linaro.org>


