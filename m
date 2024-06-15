Return-Path: <linux-pm+bounces-9238-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id F031E9099DF
	for <lists+linux-pm@lfdr.de>; Sat, 15 Jun 2024 22:34:15 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 5E6952824C8
	for <lists+linux-pm@lfdr.de>; Sat, 15 Jun 2024 20:34:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 31AF51E89C;
	Sat, 15 Jun 2024 20:34:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ZmQUFKcY"
X-Original-To: linux-pm@vger.kernel.org
Received: from mail-wr1-f51.google.com (mail-wr1-f51.google.com [209.85.221.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 836202628B;
	Sat, 15 Jun 2024 20:34:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718483650; cv=none; b=VZPlAKCkhS2YzKo/7zzCULYQXLMw2BSbnJkrzL0wIpiaIMRBLPkaki+t1/fvMG56PiGMYxsyWeKbe0xTyV8952lNml/hGEUPHnuBO5w7Ixxs1nqcI/CIbfYl3vA6UE4m/NTspWYbwtD5RdWQQLbLIzaXLPSbqSUnSsjO2SbLXFU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718483650; c=relaxed/simple;
	bh=CGw/p4HdUyl7cIFLKWo2c3fm5nngxfZZgk50+ibSyYI=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=t4LXFAwXxvhf6+M4U31Orm+izK/X/uShEGML9JOc6VA0IW+XxX4OtA+t+Tm6vB456lYCuXK9DLrsuhIAR+rESNAlo7tvH/qCe+WfyGA9EaMVHom8yDQ94mNa8x7r7vhEg7u+LvVhmgb/JGaYsmJtKmv9ppL1wUgqCCxiJnl80Hg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=ZmQUFKcY; arc=none smtp.client-ip=209.85.221.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wr1-f51.google.com with SMTP id ffacd0b85a97d-35f2d723ef0so2820312f8f.1;
        Sat, 15 Jun 2024 13:34:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1718483647; x=1719088447; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=RwYF5vM+myLWhVdItuvwuNRcI2FDTJk1TycsN6c8428=;
        b=ZmQUFKcYWdLnyXcqxGyZcpjKztA/Nvr/JUn7HiZcJuWw7X7juMyRW0goMagbiXH9PD
         pZBhJ2yHVpVKynElRbXWalomC1sM5dqyXSqqVGkLOnw4bP//IN5IRf9uXuUrCYf/IN6+
         gyIB3akquVLSFxdWQZan+SVJ8ReTBf8Fl1w65Ewcdu1ihvbk7e3Jyfu9uqvL1CjtlP/b
         Atte0l868FGyWPSkzjnkbdDoL2L2M+Xy8u7XDpsPOYZPAhjmRiWMHLB7c/FWkhBduh7b
         Vo3hUyo5x1RXbTRhilC9xE1Qb/y4dNNHQBuUQ3PrFMSm/xkOdaymII3/cZRRPKFL0Pvn
         HhTA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1718483647; x=1719088447;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=RwYF5vM+myLWhVdItuvwuNRcI2FDTJk1TycsN6c8428=;
        b=QDUnVMmV0KMu0fgLuIWuOdLqHvmkW/xvtqIpLG8r/Ia0XjGsPNhz2w/D9+ltqMNGef
         jwGqdaXUNX27aKTrme0pfq/419CbUGJdToEt1hpl5IxAsKlOq0gjWBCp2VvOsAsOvWe+
         KsHIWKiYdsuYzdWl0JGl62NZl1Jo35RKEY/jT1cFrEeHhS9cvdzs46H2f958BOE7s41X
         8IRUaDs98RhUoyxXZUg2G/14RNCkrBGn1f4hkv6M3SeeIhvF+GXdYhGj4sx0LZ+zsDPV
         9KT1IhX9kMftRyLPeuAa5v/6NJDkBn7f5JGtYRrWgDzucBax4XbrKfiwb9oCNhT43oOL
         0xWQ==
X-Forwarded-Encrypted: i=1; AJvYcCVR0o7uH8+50T4Ryqb9zJTmft+eIXA6jxikUHYij9qpGzcR1pKumQaiIbeVHzSEWMBmPEsShR0z7DX2Tx0otRs269VjeVyCjn/9CCNZahyWMbr4INqPDCkDl4KLYKU6xTczv6kyG7o=
X-Gm-Message-State: AOJu0YzW9bDAjRFiya5rr/DaRirxazE4EeRr2qmOUkfZsnTGiwpznkU2
	s4v82GBC1wo4VvOkxslwDsA2A8nKVVj5WbBTcTGX60IhsFrc573C8b1JZA==
X-Google-Smtp-Source: AGHT+IGvPNi+03n9Mc7JNGDjf9p35VACAuBFo6hzkLllyBui5nQuCO1wfGMR2YuOSkvEaKY8y8BZjg==
X-Received: by 2002:a05:6000:1289:b0:35f:1c6b:2b24 with SMTP id ffacd0b85a97d-3607a7610bemr3971861f8f.29.1718483646597;
        Sat, 15 Jun 2024 13:34:06 -0700 (PDT)
Received: from debian.fritz.box ([93.184.186.109])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-360750935f8sm7973510f8f.11.2024.06.15.13.34.05
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 15 Jun 2024 13:34:05 -0700 (PDT)
From: Dimitri Fedrau <dima.fedrau@gmail.com>
To: 
Cc: Dimitri Fedrau <dima.fedrau@gmail.com>,
	Sebastian Reichel <sre@kernel.org>,
	linux-kernel@vger.kernel.org,
	linux-pm@vger.kernel.org
Subject: [PATCH v3 0/2] power: supply: add support for MAX1720x standalone fuel
Date: Sat, 15 Jun 2024 22:33:48 +0200
Message-Id: <20240615203352.164234-1-dima.fedrau@gmail.com>
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
  - Sorry for the confusion

Dimitri Fedrau (2):
  dt-bindings: power: supply: add support for MAX17201/MAX17205 fuel
    gauge
  power: supply: add support for MAX1720x standalone fuel gauge

 .../bindings/power/supply/maxim,max1720x.yaml |  51 +++
 drivers/power/supply/Kconfig                  |  12 +
 drivers/power/supply/Makefile                 |   1 +
 drivers/power/supply/max1720x_battery.c       | 324 ++++++++++++++++++
 4 files changed, 388 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/power/supply/maxim,max1720x.yaml
 create mode 100644 drivers/power/supply/max1720x_battery.c

-- 
2.39.2


