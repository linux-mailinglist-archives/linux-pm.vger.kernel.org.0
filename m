Return-Path: <linux-pm+bounces-9380-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 9044590B9FC
	for <lists+linux-pm@lfdr.de>; Mon, 17 Jun 2024 20:46:06 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 01C421F223B1
	for <lists+linux-pm@lfdr.de>; Mon, 17 Jun 2024 18:46:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CE3AE198856;
	Mon, 17 Jun 2024 18:46:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="eEoUSeql"
X-Original-To: linux-pm@vger.kernel.org
Received: from mail-wr1-f52.google.com (mail-wr1-f52.google.com [209.85.221.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1C1EE441F;
	Mon, 17 Jun 2024 18:45:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718649960; cv=none; b=oBjH2LE9WbuVRdhP7Df7f5mdSGDkWLNwmAHCcVacUz4lADXyZhrvZM4JCNk63dDdGx+31AxNI+5Te1a9L38sR78KTy33kuXpAX7VdZVvXZkast9hifZqfTwc5Zo7EAJ1Iu6faxuUnjyOR0JNwMmegOv+x3kYuMfsH7mfHi+JA1E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718649960; c=relaxed/simple;
	bh=6kWQpS9eLM072jgzABjjZKWSIyTdU2QIJ0UNEyUE0bM=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=XZWiWzwQDh94yJW8MtHXwiuw3dGDqyFkz1dmDmY425dlJOrxeaSd9X5B727Vx6QYgZUOx55Cl4PlN0BDXSubUr1/yJmJENLlCVQLUcA48i0RlozCFBL8UguJO8RjZnPimehsc97HZl+MJJubSDWNKYdX5Y5y9LMaJqUtdVlxVM8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=eEoUSeql; arc=none smtp.client-ip=209.85.221.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wr1-f52.google.com with SMTP id ffacd0b85a97d-354b722fe81so4230285f8f.3;
        Mon, 17 Jun 2024 11:45:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1718649957; x=1719254757; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=RNDprGsvBjQ5lpg+8nT0XkdPxAQlru1DaA56wCGwcSM=;
        b=eEoUSeqlVjUQKjal769EFVcCBW348V93cIm9JrrTWrNHFJ/cpB7UTFCF1tfml3s9/7
         krGqOHBPQ84rtFErBnXdAS96CPDC3xyuEijg5X61R85ttqf+KFnv8fAUUx6ulPCp6gu7
         pC6PKeyrDlW5xO3TV5uJ0RhNywAgvAGl4Zpk5myb/Ryo6A4H8o/ZjTS1XqWzVvoEYB3E
         ebrC8EI3SSKerOELiyPZe0Sfmml30vzUyA3lJ29vMA4N3UgT37N+E3z4sEzUQ5Ida2zM
         WF6lndasD2oa349zD8Mj19YVxHyXMQWq6VIcElDoJRTSaWXHXZk7fJ/rNu3UXTi2/Dr1
         7BRg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1718649957; x=1719254757;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=RNDprGsvBjQ5lpg+8nT0XkdPxAQlru1DaA56wCGwcSM=;
        b=F4mbt1YOZO1kGcCt4EzEMKi8VxMxlkInTjLUxSZ2PSVMFWvYJu/vjzYKPjxELx4/wz
         f0MmQbW5UCVsQ4ztMNnvJc+CD/7mNG9VkSv+Zc/JMInc+OBVUJoNmzzSkD0xbt4UTTWp
         oFo/slOeg02U3GPdSI/aUPMN08mUQ2M3TNB2hVRCzkXzfa63tka1e3GVVZcV//6IF2sX
         AIcoAfDb9YQzbNk3ItvtKdFFdEuEa5Elqp7+64hXHv7/0KopNLof6ToC1g6MAjhTcnB5
         y34qaHYFQA8dOIet56rS2KX3+J2TJvph62qfVpOL9dZb0LD5t5ebGvtm9t2++MKTUSU6
         BKUg==
X-Forwarded-Encrypted: i=1; AJvYcCUtb0EWRNphJGGVnQcOfs4TPoBhWvAa07v3YoUnH27eTjzW8oRM8n1kmcMlaUpwa/lQRHqwSFnHWx1xBFTM8aX0iz/iPY4HKQqa12/I/4rDjHU3uhEidMT5zV+7vxjaMger5UJFgCcJPCbEaJH18bvMTTrhf0s3LzOBFCwpHrHmLht9
X-Gm-Message-State: AOJu0Yzb7NJwys5j350fPFowX4z+8nWmBy3Jv6VKq7RL+fBkU1jZm0HO
	8+i3SCfKiOd4i15NncLA6dVtd5sP9dbNxwg5hFDiOtDQI9uEyO/+
X-Google-Smtp-Source: AGHT+IEfr0TY7yXXoteO4w7tww2cogvFqswv9L2uCG4Ka71RmqqqN/X2AtgALlXI49v+50ryBr/SnQ==
X-Received: by 2002:a5d:468a:0:b0:360:709c:5040 with SMTP id ffacd0b85a97d-3607a736520mr7972239f8f.2.1718649957041;
        Mon, 17 Jun 2024 11:45:57 -0700 (PDT)
Received: from debian.fritz.box ([93.184.186.109])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-360750f249csm12410327f8f.75.2024.06.17.11.45.56
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 17 Jun 2024 11:45:56 -0700 (PDT)
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
Subject: [PATCH v4 0/2] power: supply: add support for MAX1720x standalone fuel
Date: Mon, 17 Jun 2024 20:45:02 +0200
Message-Id: <20240617184504.304211-1-dima.fedrau@gmail.com>
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

Dimitri Fedrau (2):
  dt-bindings: power: supply: add support for MAX17201/MAX17205 fuel
    gauge
  power: supply: add support for MAX1720x standalone fuel gauge

 .../bindings/power/supply/maxim,max1720x.yaml |  55 +++
 drivers/power/supply/Kconfig                  |  12 +
 drivers/power/supply/Makefile                 |   1 +
 drivers/power/supply/max1720x_battery.c       | 363 ++++++++++++++++++
 4 files changed, 431 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/power/supply/maxim,max1720x.yaml
 create mode 100644 drivers/power/supply/max1720x_battery.c

-- 
2.39.2


