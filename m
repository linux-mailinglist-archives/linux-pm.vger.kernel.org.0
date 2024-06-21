Return-Path: <linux-pm+bounces-9755-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 6572A91261C
	for <lists+linux-pm@lfdr.de>; Fri, 21 Jun 2024 14:57:57 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id D96941F27ED1
	for <lists+linux-pm@lfdr.de>; Fri, 21 Jun 2024 12:57:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 77E47153828;
	Fri, 21 Jun 2024 12:57:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="HLhHHUVK"
X-Original-To: linux-pm@vger.kernel.org
Received: from mail-ed1-f41.google.com (mail-ed1-f41.google.com [209.85.208.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9BB371534E8;
	Fri, 21 Jun 2024 12:57:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718974673; cv=none; b=PzAy3vImS2VOTPbs9NWmJakYgZaSVymarPzizsrewrg5cEZAE3zcbMLz2/u9npuh8VeThk6JhzCdeBZe+L3oWlunoW/ZueBfAa3+9INBT1jZb7xwqasB87vfr05Z3ATUK2R/6G4TLKarAOM8xj2Vr+6R19kEKemxHcEAvZ5XHX0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718974673; c=relaxed/simple;
	bh=YRpzhRZMd/owSYXAqsZC8ISCrInjHHfQAXcFXjpaQNA=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=KrJQPRqW+4ztkQIzqR/Kk2Dgh95BMZqIlhrz8cVJc1L/NfK80Eq0YfN/FWHzeQNVHUzDrkJZTFJSPOK9hqm6MM+MRbPo9IQiM5UEFuyy1oYW2C6ikG03aNDRdnTL6K7BZxbBZ+sQm6IjJ4yDF5H0jTB/KUlojsVd5PE8KyWE7/o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=HLhHHUVK; arc=none smtp.client-ip=209.85.208.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ed1-f41.google.com with SMTP id 4fb4d7f45d1cf-57d0eca877cso2330851a12.2;
        Fri, 21 Jun 2024 05:57:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1718974670; x=1719579470; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=NrnAU6mhz/kl2NrmklHMGMGU8HHSJk2j81Klofccxog=;
        b=HLhHHUVKABWk9rGYOLC3A72dJB+B/ZCsZSF+AOvmHXEXiuQXX9dyLxsHiaY75iHI18
         5r6L/zo1StwQJDdr6IJw2A1rwZV9PRNKx9P4lgIkVWssk26/B+7nQK9reSVkdeDVam7m
         a2kmOCP2nEZjShkRmRpNoLrkl8mpfo1sczXiIStb0reDDf6jQI8o8OlWww23NquhGfH+
         U68BucGqFY7ptRaHqfsaFoY/2ngCRwBByhN0AQmj+GO0Fx/h9UCZ3D8eK1Kyoi1MTtiZ
         NQKhON223oe4Jh2mQkRvtu13Ja+T3lsnP9U6NmjL21yrVM7X9wBoUTFeWZDUZupd/F6E
         jkFg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1718974670; x=1719579470;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=NrnAU6mhz/kl2NrmklHMGMGU8HHSJk2j81Klofccxog=;
        b=RIqus6pD/DtOKbTY1oiVIU+Oa321BNSYeNG9H5zSwRUoDsf1BKO7YY1CkLoG61xy3U
         zfvHsd4QZNjUJ/o60SZXUJeA9xzDH3dUIcMoY7jl49XfsUk1hg3ZAUu+l7B/uLxFhTRJ
         Bxizut0aDPqHfmtx01qCSPZEXzxthiJCsNrbTYp71jR3Dr5rD5VzoiROT8hqdRXYuWM0
         gpIw6Mmx95wIHVYgAKElSQehG9OgHaicAlguA3QCSyXkrHUMKs4iwgyzlkCOHxd4qXLm
         U5qEGb7W8sdrwgUwIIAtM495o5po4dVG09mCwZvswsBntXHNyUyB+0F0mFWm0yAWOR5T
         0TmA==
X-Forwarded-Encrypted: i=1; AJvYcCWRdER0Cq1lajT6QzfdkgiVK8jR4m8qhlyjkBr3NLlG7c407OMHoqX8x8CFgmirQClaT43sl7Ixe42FAVof0N+6rAGb7RcrEYAL/gCFyePanDzsV7dzHbdszw2TiooThuxw1SdeaMWR6SgwmEz27GsxHUBte+GMTF+B6IXF00+mQBwm
X-Gm-Message-State: AOJu0YyXrduRzXOXKejSpvU1zsOxbie9MxIyjEL+NxysSWfa7bKPZbfb
	rTmAYBI43m0cilXv5FJP8xc95nrUOjQCXJ4QsV4dbDuLNFBtOpQqaBRmFA==
X-Google-Smtp-Source: AGHT+IGfUKvKjZVPnKDkHyB4Nk/l6sFqObU//QF8QzBy5wNgB42KOKkMNx5+RqrkuvumV2tbXjypJg==
X-Received: by 2002:a17:906:fac2:b0:a5c:eafb:5288 with SMTP id a640c23a62f3a-a6fab62bca2mr575577666b.31.1718974669497;
        Fri, 21 Jun 2024 05:57:49 -0700 (PDT)
Received: from debian.fritz.box ([93.184.186.109])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-a6fcf548eafsm81226266b.116.2024.06.21.05.57.47
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 21 Jun 2024 05:57:49 -0700 (PDT)
From: Dimitri Fedrau <dima.fedrau@gmail.com>
To: 
Cc: Sebastian Reichel <sre@kernel.org>,
	Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	linux-pm@vger.kernel.org,
	devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	=?UTF-8?q?Thomas=20Wei=C3=9Fschuh?= <thomas@t-8ch.de>,
	Dimitri Fedrau <dima.fedrau@gmail.com>
Subject: [PATCH v5 0/2] power: supply: add support for MAX1720x standalone fuel
Date: Fri, 21 Jun 2024 14:57:42 +0200
Message-Id: <20240621125744.363564-1-dima.fedrau@gmail.com>
X-Mailer: git-send-email 2.39.2
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Changes to max1721x_battery.c:
  - reading manufacturer, model name and serial number is only possible
    when SBS functions of the IC are enabled.(nNVCfg0.enSBS) Factory
    default is off. Manufacturer is "Maxim Integrated" and the model name
    can be derived by register MAX172XX_DEV_NAME. Serial number is not
    available anymore.
  - According to the datasheet MAX172XX_BAT_PRESENT is at BIT(3) not
    BIT(4). Furthermore the naming is misleading, when BIT(3) is set the
    battery is not present.
  - Removed DeviceName, ManufacturerName and SerialNumber from struct
    max17211_device_info

Changes in V2:
  - Changed E-Mail in Patch (2/2) Signed-Off

Changes in V3:
  - Changed E-Mail in Patch (2/2) Author

Changes in V4:
  - add compatibles "maxim,max17201, "maxim,max17205" in bindings
  - use generic node name fuel-gauge@36 instead of max17201@36 in bindings
  - remove status in bindings
  - fix spelling mistakes in commit message
  - fix indentation in Kconfig
  - fix typos in max1720x_battery.c
  - Drop bat and bat_desc from info struct.
  - MAX172XX_DEV_NAME and MAX172XX_DESIGN_CAP aren't volatile, adjust regmap
  - constify max1720x_manufacturer, max17201_model, max17205_model
  - constify max1720x_battery_props
  - Remove braces around reg in max172xx_current_to_voltage
  - Skip initialization of reg_val in max1720x_battery_get_property
  - Remove braces around FIELD_GET() in max1720x_battery_get_property
  - In case POWER_SUPPLY_PROP_PRESENT there is an early return if ret < 0.
    Return 0 if regmap_read fails, device is not responding in case
    battery is not inserted
  - Implement multi-byte readings instead of i2c_smbus_read_word_data
  - Drop ancillary from info
  - Drop both calls to i2c_set_clientdata in max1720x_probe
  - Get rid of max1720x_remove
  - Remove comma after sentinel in max1720x_of_match
  - Fix alignment of max1720x_i2c_driver
  - Fix return value of dev_err_probe after max1720x_probe_sense_resistor
    to use ret instead of PTR_ERR(info->bat)

Changes in V5:
  - oneOf with list and fallback in bindings
  - unevaluatedProperties: false in bindings
  - switch back to i2c_smbus_read_word_data when reading from ancillary
  - add psy_cfg.fwnode = dev_fwnode(dev) in max1720x_probe
  - set max_register in max1720x_regmap_cfg to MAX172XX_ATAVCAP
  - fix typo in define: MAX1720X_NRSENSE instead of MAX1720_NRSENSE

Dimitri Fedrau (2):
  dt-bindings: power: supply: add support for MAX17201/MAX17205 fuel
    gauge
  power: supply: add support for MAX1720x standalone fuel gauge

 .../bindings/power/supply/maxim,max1720x.yaml |  58 +++
 drivers/power/supply/Kconfig                  |  12 +
 drivers/power/supply/Makefile                 |   1 +
 drivers/power/supply/max1720x_battery.c       | 338 ++++++++++++++++++
 4 files changed, 409 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/power/supply/maxim,max1720x.yaml
 create mode 100644 drivers/power/supply/max1720x_battery.c

-- 
2.39.2


