Return-Path: <linux-pm+bounces-29389-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id C80E5AE4AEC
	for <lists+linux-pm@lfdr.de>; Mon, 23 Jun 2025 18:30:49 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 883C53B38AA
	for <lists+linux-pm@lfdr.de>; Mon, 23 Jun 2025 16:27:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2A2782BDC11;
	Mon, 23 Jun 2025 16:24:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ioaTYmX3"
X-Original-To: linux-pm@vger.kernel.org
Received: from mail-oi1-f171.google.com (mail-oi1-f171.google.com [209.85.167.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 88E8023BCE3;
	Mon, 23 Jun 2025 16:24:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750695897; cv=none; b=i4L1lQOnm1jn7NEu4i+o33N/U8WmmHEOaxkNysojfPtg696AQuZegD163py4o78CzKKwcG2rmdMuuogXnwSHgWHs7wABugkJDgpqKZQPoSGUCNTBwdFLoYQOX/e+KIU/QX6sa7IJFiOMwiBYc/C48wqC9yJot4PbkXtP0hwSXzQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750695897; c=relaxed/simple;
	bh=41jbVPsCwj8T5PHJEuSocRy38yFgjqP8BdLlaykU4cs=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=o30fXJowPpFZxZ+wMVu/N2azyLtwHwSAjxAVKm2DS1YW/FMOdaM3+WeR5JYGcK1QjGPNFoqcQM2uJwpXiwvCsMXmqYvj4cVEnp+jvQS/AHjVhMrIVL2ORltMqt1ugXm/TKxuezOVwGocgDs1A8zkR1Oxgv6ptE6B6YpjYJRclQo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=ioaTYmX3; arc=none smtp.client-ip=209.85.167.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-oi1-f171.google.com with SMTP id 5614622812f47-40a6692b75cso3406911b6e.1;
        Mon, 23 Jun 2025 09:24:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1750695894; x=1751300694; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=bDfb6+7enKdNNKI7hWXp6pY/tJHn80dmYFnrZxONTBk=;
        b=ioaTYmX3joPznz8Y8Lp7f5xtU9RHDfQHiqO4++MsoiO7KPTQeE8OtDPAA8uXVpDEQQ
         TQdcczMGeXyBQyFcpFj+BpC568vYU8kan27njjKV0MnJ6jvKPYR+Pp14WVm4uLLknDc7
         CGdG5AjRh5XYEzOnwsEBphnK1KnD8wxZGwdTYoHde53LppvAy5Q7YfJawzjsjbMpstjt
         9+IBv4v6zVI1jAhPaiaGaKrA8NATQ2sdW31uInyDeZqERdNUO27CJOv0+FZ6e0no9MK8
         0IBstkmXoWPapWRQs7Uq2Hg12HtYAcKUm0a1Zb656aP8C8/NE5lE+cybS3o2z/tHeUuG
         4pOw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1750695894; x=1751300694;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=bDfb6+7enKdNNKI7hWXp6pY/tJHn80dmYFnrZxONTBk=;
        b=GSD1wiibAEPtATCFiBswNW6sN3ydmTTHoCU2t9fJy/qI8W1ho6ba/2aFomOM9RuTfw
         W8aOFgahfKbyhu2sUsZscbi0kqNwIpMAUod3/ijY4clBAB7ncOHeoWoS93nqn8xYaN/C
         tjsPyA187pp3xJq5Gzuvc+dyHYRUxKxy6nOhGj+TTniuPK31HkpSp/o7B0WcfWebcONM
         qCqxJi1pXajhc1XuAdwPuAKxcmdc82iZEuc6aUPOUI7PvwIDQSt8EIUSp0xZ27gRtTko
         TinLxt97aGD6Zc+mtJ8y9piU51BKgACzsj8jDsXtJ4RpqayEJ1nVN86D8RBvniRd4yE5
         b7ng==
X-Forwarded-Encrypted: i=1; AJvYcCXb408TOERxzAOTB6NtTGXt+R1LscQvZ97Jj4QzzImwa24BeYgelS6d7j6hoiJ3xroVcf3yY4NYV+W5@vger.kernel.org
X-Gm-Message-State: AOJu0YwLn7nkl3TlyoRhK61OIefFSJl2aiYYSCtuaWvLA0JSg8Vx6qmA
	4fSljbnfS7eZFYDtnSXSLkBQJwsRI8LhunhLEhOxRh68PObawN1MnsyHC811QQ==
X-Gm-Gg: ASbGncuC6KQF421ng/EGnSTb62WjXz0dvT1MbeTOaUCiV1SzavaVDSBcoe7SnwSoyIY
	HPTkumUb4IxdDIc70rEWQs6fyBbOdO8Gi8mQtIoRYCl0le1Udm55B/QYqJkTufE0D4P11b1Ia+1
	0bq5TJiey4ofbq4zs2WubtAlCnvVO2cebYtZwstMqCQJjoGR3lsbZxLW4CRgKhGh6fOTVoUHKz5
	XdpvAKObVPgyJEvCOF8GZk8Eh6FwQxG7mJdvNLmDrww7OlCF4/o8E7/2tb/x68fxWSzVv5T+F76
	Eo+yHVKGO5TiQwhyAZFOpBGTzhHuNIKVHgn2XpBUmQ/eB9D8+uRseXYrYcNhYJhlZkhF4n9UgH/
	dT/rL+QEZAqdnlyOi
X-Google-Smtp-Source: AGHT+IHFwNmuitlNLVWhiK9CQCYv7O4a8CyNPO3l0DMr0R02Wn1Nuepa3ZpqnzlrDdAIDq3Cr+7z2g==
X-Received: by 2002:a05:6808:2f0e:b0:406:71fd:b610 with SMTP id 5614622812f47-40ac70e22f8mr9345582b6e.33.1750695894243;
        Mon, 23 Jun 2025 09:24:54 -0700 (PDT)
Received: from localhost.localdomain ([2600:1700:fb0:1bc0:61a2:e42d:d809:3616])
        by smtp.gmail.com with ESMTPSA id 5614622812f47-40ac6ced44esm1427308b6e.24.2025.06.23.09.24.53
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 23 Jun 2025 09:24:53 -0700 (PDT)
From: Chris Morgan <macroalpha82@gmail.com>
To: linux-pm@vger.kernel.org
Cc: linux-rockchip@lists.infradead.org,
	devicetree@vger.kernel.org,
	broonie@kernel.org,
	lgirdwood@gmail.com,
	sre@kernel.org,
	heiko@sntech.de,
	conor+dt@kernel.org,
	krzk+dt@kernel.org,
	robh@kernel.org,
	lee@kernel.org,
	Chris Morgan <macromorgan@hotmail.com>
Subject: [PATCH V3 0/5] Add Texas Instruments BQ25703A Charger
Date: Mon, 23 Jun 2025 11:22:18 -0500
Message-ID: <20250623162223.184304-1-macroalpha82@gmail.com>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Chris Morgan <macromorgan@hotmail.com>

Add support for the Texas Instruments BQ25703A charger manager. The
device integrates a boost converter with the charger manager. This
series adds the device as an MFD with separate regulator and power
supply drivers. This allows us to manage a circular dependency with
a type-c port manager which depends on the regulator for usb-otg
but supplies power to the BQ25703A charger.

---
Changes since RFC
 - Corrected some minor issues with code and device-tree labels.
 - Replaced most of the manufacturer specific device-tree properties
   with monitored-battery properties.
Changes since V2
 - Added reference to power-supply.yaml and removed note for i2c
   address per recommendation from Sebastian.
 - Corrected documentation error for charger driver found by kernel
   test robot.
 - Corrected duplicate POWER_SUPPLY_USB_TYPE_PD entry and corrected
   ichg logic in power supply changed function.
 - Corrected missing linux/bitfield.h header in regulator driver found
   by kernel test robot.
---

Chris Morgan (5):
  dt-bindings: mfd: ti,bq25703a: Add TI BQ25703A Charger
  mfd: bq257xx: Add support for BQ25703A core driver
  power: supply: bq257xx: Add support for BQ257XX charger
  regulator: bq257xx: Add bq257xx boost regulator driver
  arm64: dts: rockchip: Add USB and charger to Gameforce Ace

 .../devicetree/bindings/mfd/ti,bq25703a.yaml  | 121 +++
 .../dts/rockchip/rk3588s-gameforce-ace.dts    | 122 +++
 drivers/mfd/Kconfig                           |  11 +
 drivers/mfd/Makefile                          |   1 +
 drivers/mfd/bq257xx.c                         | 104 +++
 drivers/power/supply/Kconfig                  |   7 +
 drivers/power/supply/Makefile                 |   1 +
 drivers/power/supply/bq257xx_charger.c        | 754 ++++++++++++++++++
 drivers/regulator/Kconfig                     |   8 +
 drivers/regulator/Makefile                    |   1 +
 drivers/regulator/bq257xx-regulator.c         | 189 +++++
 include/linux/mfd/bq257xx.h                   | 108 +++
 12 files changed, 1427 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/mfd/ti,bq25703a.yaml
 create mode 100644 drivers/mfd/bq257xx.c
 create mode 100644 drivers/power/supply/bq257xx_charger.c
 create mode 100644 drivers/regulator/bq257xx-regulator.c
 create mode 100644 include/linux/mfd/bq257xx.h

-- 
2.43.0


