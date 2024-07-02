Return-Path: <linux-pm+bounces-10321-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 02C0592390D
	for <lists+linux-pm@lfdr.de>; Tue,  2 Jul 2024 11:03:28 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 5D0EBB246D7
	for <lists+linux-pm@lfdr.de>; Tue,  2 Jul 2024 09:03:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 666A214EC7F;
	Tue,  2 Jul 2024 09:03:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="CJeIankZ"
X-Original-To: linux-pm@vger.kernel.org
Received: from mail-wm1-f42.google.com (mail-wm1-f42.google.com [209.85.128.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9F7E51A28B;
	Tue,  2 Jul 2024 09:03:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719910999; cv=none; b=mJq9IUCkAApvXCmEHfxwWC6Tjb+4jfVtBuUmI9dcT0gF1jjG10gUqNRXalIFN22kVnjvomuM3WU1vctv9y9cap4VChkAsZCsefTn9B2qk/PdEBqmPMtYGYZ4aGId3c/UhpHS638WrfCbMQxcIQJpho7PjuKsz6ROGWnv5+rc94g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719910999; c=relaxed/simple;
	bh=ujB77ptjDabwaJ1Jl5QxpUHkgSzWC969f5UndpokvHw=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=k2FASwyOzxPQB3B7Wo32VTzogR4/KZCfTi9nU5hCcr43BL/Xnxt1pAD5iv0MbiTrFZpFjM3ezhxxrEl82JGCDCETQ9Ix7iYDRoWktabXNgrtnMmbSusZWYbwCfJMCVvv4jF1Kq4g4iJJcTxKtPuKdm5amT+qivPZdgF12KQDVrE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=CJeIankZ; arc=none smtp.client-ip=209.85.128.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f42.google.com with SMTP id 5b1f17b1804b1-42565670e20so29342205e9.0;
        Tue, 02 Jul 2024 02:03:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1719910996; x=1720515796; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=HZ0VmcNpukRjUt6NMcgrQkQfn8UoR2wsLONe+DcxFTA=;
        b=CJeIankZYHoYUYKza9fiRlxFqnDXw70blTmCjT6sbVecDuBZShuwJxpqZxlBethMcM
         T1Gm8uo/tl89Ehf/y52haTCHzmx4en8Mv0FiAOz+aEHsDpsvTnRXbHK6SH1qnoyCM19A
         yLchDwHSaNd/eUYht4qFyIrAG5LKD2SF4hSwNjgK3ffxn7XKxYXzmkvPW8eDiirE9CZt
         HGJN/m4cnQajxb29ZlYZOpHk+LkAXxjPCY1NdRsEXTpfW+QP3YMrM7BSxqu2BeTjupmn
         OmZqdSCbwPRVj47fR/gbfdQi8K3qwHgmd2RPys/x/VaGg4WIgVBkXkhMbOW+97J2sOAm
         VYDA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1719910996; x=1720515796;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=HZ0VmcNpukRjUt6NMcgrQkQfn8UoR2wsLONe+DcxFTA=;
        b=XJOP7RJpmh8mQxd+EOKrPLlGDOW6XYFhud9SuX9me0gJWyYa7LiimiygiRcRAJxy0V
         q0IQxLHgzTGDT+MiKRR+0cULeJ6ZtfliTmGj3aNcXKPBuTFMzVZzzU1NJnQO+fYJRPgu
         hcnQF0mL46ERjh1hsU3YZbhZLOvQJuFrgk/+pOANHXh/BbRK9SGKQwNo2qnbvCFAhrbs
         fJe2X9LazpGiAny4zatyOXFmK8FOqBdy60qfStO3iBdJJY5AoJswcEi0BH/hPGlJV6oK
         dVPPl3WYmKkEd4OIuAbpJPWK9jfnx6D6rthVMTUYoSLzok5h1p3thQHoCQCjepe0vrXg
         Marw==
X-Forwarded-Encrypted: i=1; AJvYcCVUX1014Jw7KuNENOLbOL0XBoDUbHnp/QxsMOqoYrrGjvpFiBGZSKNkXY3mYd+3OSu09VGKgZeFwlFyfCVEAwMJGOGQcM4A7E79gnu5PTuhEsZYrfhHuYKGvLUuNEQreRU8LIDg57mQGRy1nD3+MnoxpoxFQ9fnBC5qfBJ+5r+MMspQ
X-Gm-Message-State: AOJu0Yx3yBlwGhF+Mz5rtACCuoKisRzhBbKKcTwA8SoPz2Jo8+bLfAsf
	f/Zf339Pz8aMLP4XSG7rt7W3EbVkilcT+39ZxuV7QbkeM5iJ93iOehMrhw==
X-Google-Smtp-Source: AGHT+IFPE7exeWmXZhhwvTbKuuiaUSiKYfBTrxAXDMgY2BLSTreO9Sq3ct8mdPLVrvY20hY/EnCHww==
X-Received: by 2002:a5d:47af:0:b0:362:d7ac:ae70 with SMTP id ffacd0b85a97d-36774f44ee8mr9351658f8f.5.1719910995308;
        Tue, 02 Jul 2024 02:03:15 -0700 (PDT)
Received: from debian.fritz.box ([93.184.186.109])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-3675a0e1688sm12616624f8f.60.2024.07.02.02.03.14
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 02 Jul 2024 02:03:14 -0700 (PDT)
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
Subject: [PATCH v6 0/2] power: supply: add support for MAX1720x standalone fuel
Date: Tue,  2 Jul 2024 11:03:06 +0200
Message-Id: <20240702090308.8848-1-dima.fedrau@gmail.com>
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

Changes in V6:
  - s/1720x/17201/ in title and in the filename of the bindings
  - remove compatible "maxim,max17205" from max1720x_of_match
  - Added Reviewed-by: Sebastian Reichel <sre@kernel.org>, hope this is
    still okay due to changes in V5 and V6

Dimitri Fedrau (2):
  dt-bindings: power: supply: add support for MAX17201/MAX17205 fuel
    gauge
  power: supply: add support for MAX1720x standalone fuel gauge

 .../bindings/power/supply/maxim,max17201.yaml |  58 +++
 drivers/power/supply/Kconfig                  |  12 +
 drivers/power/supply/Makefile                 |   1 +
 drivers/power/supply/max1720x_battery.c       | 337 ++++++++++++++++++
 4 files changed, 408 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/power/supply/maxim,max17201.yaml
 create mode 100644 drivers/power/supply/max1720x_battery.c

-- 
2.39.2


