Return-Path: <linux-pm+bounces-26356-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 8127DAA0313
	for <lists+linux-pm@lfdr.de>; Tue, 29 Apr 2025 08:22:08 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 1A3777A4312
	for <lists+linux-pm@lfdr.de>; Tue, 29 Apr 2025 06:19:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 12F41278168;
	Tue, 29 Apr 2025 06:18:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="f4n9pxzN"
X-Original-To: linux-pm@vger.kernel.org
Received: from mail-ed1-f50.google.com (mail-ed1-f50.google.com [209.85.208.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3DA0B7405A;
	Tue, 29 Apr 2025 06:18:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1745907512; cv=none; b=eCKJrKP9FysXDbev8Dvqc3TZD824cBmv2lJ5ZheI3p7Pqi1lgCFrVrxWDy5GzLtvkkTjmeUjBnImYcQnpWfOjdzQmdEzZRAugosKcllkEr3d6/XFDPxblBcAwDVj2eMFsyhA1/osHGx/t7bYEJoolRvuNgD0icZukURt8hnG+ko=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1745907512; c=relaxed/simple;
	bh=cu2YGhMwTXRXoDOhKCOJulyp43CXklzRH3EmmxyA1Vg=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=CUr1USXidCrgUSzVUrJF46A/e89DcefQIq4EfJfssJEYem7x3Ibm8ygG5DbDv3uz9oyOXlRphaIE11z6QTDh4YGRDd3pGIqSkkgmDL5WT73m0NVxwHDfhuFFqLMiMAKTEOiP3UZU/e7G/o3wHQ473QaSGoKldp9mroYzDJ34DhM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=f4n9pxzN; arc=none smtp.client-ip=209.85.208.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ed1-f50.google.com with SMTP id 4fb4d7f45d1cf-5f63ac6ef0fso6779008a12.1;
        Mon, 28 Apr 2025 23:18:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1745907509; x=1746512309; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=SxnqY4X0sY6/scdLHV+pN5MKndUjVPCeKrlCIqdGx80=;
        b=f4n9pxzNOZ1MRYdSi4JnidzqaAUuS/+tvlkVfqb8jHUWIiYvszkmCHf0kYvxryFNVj
         4KbVKQfAGIj01ZKMC0Sn3TiKK8wpDI4akTc0GplzaxLcX2N0bkbg8aADFHEY9Snd8dXw
         XTxPZrZ432FlL87/zPmfbSRwFTF8VUtiYpgn23eJ4ZVSQ98WEDky8IdA47lgK6iIQFLr
         8DA8jAZWUO55uhUSHNPKtNBCpqk2SdWu0SY/nxE2viOTCjQm7bc8XLfb8apNVOH8szFL
         AoYFJ7UeaIjdNDFZN+TLzywGYBO/GEEqW6l7S/zGEibmvT6e9DwInE+RSpfEa3Q5MDFu
         aTcA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1745907509; x=1746512309;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=SxnqY4X0sY6/scdLHV+pN5MKndUjVPCeKrlCIqdGx80=;
        b=CtB3b6raEP0Io/bek6jgdzwRGaJ1/kvI4byweMtMiXLllxkcGQA0eK8Yopncva1G0g
         KyiM5LujosEDMo41bve2zEsVHuSMSgdmMQwmqbRypEGiZGXbtd2MqXia3r36h9jZ972l
         Mj4jQbRjfrnALv6rPhmX+m+vjQhrCIvF6dtcUZ0n9hkJyZq7E6wSUn0+rjvb8RLQepdZ
         YZgoDJgP+vUpM8EB0ReHd1f69D23UE0sdKlDB1EP1kg/vhMHx/YlXGQiynvS1IRXezF3
         mAOfGzMKYCKdBYV4CtslutE2pKPmgAIyh57YEwmcNSxpQaJBI+2nMh3xX1ey0oSgFcLs
         62JA==
X-Forwarded-Encrypted: i=1; AJvYcCVfe0jOMXESLK4rXj2LKN4Lr19fc23GBXz1G/OYOOIl9k9zUbKJliq5p4l+CHwDP8FxCooOOVROoRg6Mk9a@vger.kernel.org, AJvYcCXFIrYQ1ZxpOP7psh499Q7V3s7Y+Kkz+QIlLIBmJAPQUd+vO3S9s4SqGhcabIIYm6ErRV8Ni8y2CXn7@vger.kernel.org, AJvYcCXMkj+l3ivIbxQYvgnVECsIdX901WngWR7dA9cCG2Ork5RbVM/R8bQ+VHSL3/pLg1C0RCipRqz2gvzNfSQ=@vger.kernel.org
X-Gm-Message-State: AOJu0YxLAur3M7ZwzzcTUEImaTE//+kWHabvKqowPq3ICG42W0XAiUah
	0MrciMQJLZw7XpTddToGA7OSDQEK7UR+8Ja11+stQ6tEY10Q1TTi
X-Gm-Gg: ASbGncutitOTIxelmiQvICvqyXKtK/qG3njUExMMolQp6gUruWtR7LeXv1Ec5GHcGmt
	kgr6f1uJHJxWUZB+wHv0l+0z+Is4lFpG41Rt0IZpu2y1TJMKAp0afmV/o8OVPT2IgjAGhz/6kYe
	64R/BAt4X8VZm8mFJyyDYVDgfSnqIdLCRBVHznOBNk7S7yfrEorgNXlS8dUORgVJTsoSOZdiED9
	jPQFHg5eg0jZRWdxw82hwFKP6lLeUcGNf+0xVnie5ysnTzH/Lq9h6B4tccmCCMdJB2XDADsZ5T2
	Xvwnm/Vv75U04XWWcilKQg71Pc/Te04h
X-Google-Smtp-Source: AGHT+IHAHcbigwBuqfbbIr+9Y3VE3b0IbwZKs2AahD2N4aud0BCXQmTE505TkfCy8nXomx9tSeudOA==
X-Received: by 2002:a05:6402:13d5:b0:5ed:19b4:98ea with SMTP id 4fb4d7f45d1cf-5f8390bd1c6mr1709359a12.0.1745907509350;
        Mon, 28 Apr 2025 23:18:29 -0700 (PDT)
Received: from xeon.. ([188.163.112.70])
        by smtp.gmail.com with ESMTPSA id 4fb4d7f45d1cf-5f7013ff9c5sm6996570a12.28.2025.04.28.23.18.28
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 28 Apr 2025 23:18:29 -0700 (PDT)
From: Svyatoslav Ryhel <clamor95@gmail.com>
To: Sebastian Reichel <sre@kernel.org>,
	Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Thierry Reding <thierry.reding@gmail.com>,
	Jonathan Hunter <jonathanh@nvidia.com>,
	Neil Armstrong <neil.armstrong@linaro.org>,
	Jonathan Cameron <Jonathan.Cameron@huawei.com>,
	=?UTF-8?q?Rafa=C5=82=20Mi=C5=82ecki?= <rafal@milecki.pl>,
	Aradhya Bhatia <a-bhatia1@ti.com>,
	Svyatoslav Ryhel <clamor95@gmail.com>
Cc: linux-pm@vger.kernel.org,
	devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	linux-tegra@vger.kernel.org
Subject: [PATCH v3 0/4] power: supply: add support for Pegatron Chagall battery
Date: Tue, 29 Apr 2025 09:17:58 +0300
Message-ID: <20250429061803.9581-1-clamor95@gmail.com>
X-Mailer: git-send-email 2.48.1
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The Pegatron Chagall is an Android tablet utilizing a customized Cypress
CG7153AM microcontroller (MCU) as its battery fuel gauge. It supports a
single-cell battery and features a dual-color charging LED.

---
Changes in v3:
- status update handled via default-trigger
- chagall_battery_prop_offs sorted by chagall_battery_properties
- separated status logic into chagall_battery_get_status helper
- removed controversial POWER_SUPPLY_STATUS_NOT_CHARGING use
- code formatting improvemets

Changes in v2:
- removed CG7153AM mentions in code, documentation and commit messages
- moved schema to power/supply
- left only pegatron,chagall compatible, other is dropped
---

Svyatoslav Ryhel (4):
  dt-bindings: vendor-prefixes: add prefix for Pegatron Corporation
  dt-bindings: power: supply: Document Pegatron Chagall fuel gauge
  power: supply: Add driver for Pegatron Chagall battery
  ARM: tegra: chagall: Add embedded controller node

 .../power/supply/pegatron,chagall-ec.yaml     |  49 +++
 .../devicetree/bindings/vendor-prefixes.yaml  |   2 +
 .../dts/nvidia/tegra30-pegatron-chagall.dts   |  16 +
 drivers/power/supply/Kconfig                  |  12 +
 drivers/power/supply/Makefile                 |   1 +
 drivers/power/supply/chagall-battery.c        | 291 ++++++++++++++++++
 6 files changed, 371 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/power/supply/pegatron,chagall-ec.yaml
 create mode 100644 drivers/power/supply/chagall-battery.c

-- 
2.48.1


