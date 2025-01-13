Return-Path: <linux-pm+bounces-20359-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 0F054A0BF37
	for <lists+linux-pm@lfdr.de>; Mon, 13 Jan 2025 18:51:36 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 095FE1888AF1
	for <lists+linux-pm@lfdr.de>; Mon, 13 Jan 2025 17:51:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 397B01BD9C6;
	Mon, 13 Jan 2025 17:51:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="jqcZYIdE"
X-Original-To: linux-pm@vger.kernel.org
Received: from mail-pl1-f171.google.com (mail-pl1-f171.google.com [209.85.214.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 872F424022F;
	Mon, 13 Jan 2025 17:51:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736790690; cv=none; b=UWyfie3hpO5vxXzcZbidQYHuQmmDyFwE7SSfKn4u13syer8sFtIlEi849RT2S0b/IYprjpJdqO1NuDIvYDgp1hY2BYFz8ZTV9IdRuqzyC7kY9ciL4HXwgokOPs/zoIaviFveCPvDVZlz7Z3Jy5ecPD72GSfXzkRCBIorhC4hNAQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736790690; c=relaxed/simple;
	bh=xvP2oas+PRLIaBT2sJfLandQgM2IRgkt3Cwls6mcoqI=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=ID8l6c8WsM73Loqzr6f8hhglDPIUfNrK0opPZzC8KOLdr//lJsCN8FWGrFUxKptK81U/2bvYFTQEIuFF1FKq0BwuQXHCQykFtVf7i5LhrJinvlXd/RcarLrEh6DjyfweUafOtvZPOVFViqTWec5JAPIUS6X1GvzxMK7uWy57aFA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=jqcZYIdE; arc=none smtp.client-ip=209.85.214.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f171.google.com with SMTP id d9443c01a7336-21661be2c2dso77889335ad.1;
        Mon, 13 Jan 2025 09:51:27 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1736790687; x=1737395487; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=qKIcL6LoSOnLSn/JR07z8bmhz8BmbhyMN3yZvvfIdn8=;
        b=jqcZYIdErHxE32Qy1EFn5IMOFMvrS+gi+qCdkQQcep6iLTf/TJ7STEgVSy2YW56yW2
         aaV0fL2nOxdS3iLYUY9DzyYePvuYwETtZKT2Nq5KDeVq4INCt278wsO09uiQ9VPs5e7y
         TDDg+YQQ/8cqKtAy+FPhGZxsgpn/0RAE6i8LlfViZACMng0rOyfoetWrMX86dVr8y1QN
         H3gLQ1RG2mIYJZCAwUYIuDhcoPF7ywz//zd4a0TC8XY7jFhEETx+l8y0ngDAqfAtzlc0
         1RUX5VyInZ1tLSMKJuBnDbQLe7rEPGW2s8bwqKNjQyrCx3UuSQr5lrLXq0aZyZNS0Xst
         sk1A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1736790687; x=1737395487;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=qKIcL6LoSOnLSn/JR07z8bmhz8BmbhyMN3yZvvfIdn8=;
        b=ZcIMgvosYqlcILz3y8NdIVGBEjbSDmkopRPgd6ehqJPLmxvAQ/0KrsVfJ8EBAAVPN6
         9zOZjg/19m+u80fU6rNHe7lkBKmt5LTopCEdi7ZCVxfv0bITPz4gNRJn8oe9jxrLBNO6
         wQsKMgcusRLl3ymg8pjDtVkwYeEXzCfcfA+FTNRoOQHw5yFbd24EQIibrdsi36rxozWS
         JhyVeBGT8LIodvdq0SIMjtNp2clSWVOdKi3UKB2yzid5/lzf0vkfeWEPhpiWKUjdEXRC
         vyPvLcf2+6sq4f9WAJJYWjO4abHBMqoUTN9Hj7mv3a3rysHFfwW+QnQzCcm7NkfGILso
         voVQ==
X-Forwarded-Encrypted: i=1; AJvYcCUX3tSJ5s9numgLVrDIAPBH5hx/O5ryOosUySDkSHpIwvFGZTwPFIut+Oq6tVc9ADpfhDC7CW8b4wos@vger.kernel.org, AJvYcCUx66q7kMgmf4O7fR0rtkmHF/1iuLYLwP7+vJoQdjrbI1qm4WAMgFKTQ5Mpi4exAvbMZGGJLbx7HKo=@vger.kernel.org, AJvYcCVRur4v10CukLmejXTEkaLiogHlcViPGpP2mc8seC/aVFQ5217uODLzkaCYaUOjc+Sl2MCWCa65oTmtYxI=@vger.kernel.org, AJvYcCVzbLQH/RCQcZcfosIGozlMFYDUHRGqD4qgDT+saANDrSo3fP5ODUqgxu13bQpEl9D2JkwxYtXm52R5hJC6@vger.kernel.org, AJvYcCXCVj9KzSPG35r611GkXBu0unAwvg1a+/KPf/2Rl/ekP5423tJf4+WDOz6N/eJY9ciRGmEO/Cy9L/1vT6Mq@vger.kernel.org, AJvYcCXLkbBTjpq20oNx5sDOXr8vkpz1CsmUsYL9V62V1HKPQ7tJEz5pJu4ew+T8tjB0ADChhgJe/71bU2Is6AujxcSRZBdq/w==@vger.kernel.org
X-Gm-Message-State: AOJu0Yxi3CBE4qO+iJd8nX+Zz64XTLGG0JEcXmvNGQeXcuQJ5P0yf3kU
	JvFQe7LHp7tr76/i8aHfb1Idqf6O9RtXjeqrtSUojwWbjti2WyTE
X-Gm-Gg: ASbGnctstOa/xMBrsK9t4OPrpGGE3GTIS6e6cgiHEkvqGhRSaJCywJiNQXUaAnFKbA7
	R/eC2k0cypE60fRANeKzX47Ls/1CX456l+yapsR9+/cn/R4lPKLj//DMEHb+WFuqWv+zFuvbqM5
	XSf/XyDs1J1qKMjsGh83kPcPs6C5sAF6j3h9CkpnjSgVFR3G2i1J6o07sPg93bXk1IxXVjXyth0
	V6Hn4v8OPQiH/DZlESG8XLlr4B3yBQvft92fWm291Ib3PUPRFrCKpA=
X-Google-Smtp-Source: AGHT+IETV0NCUWP6YneaLkhvFR3Lh2s00aDZ8882w0N6P8RzmxA2eHRUCz1gfrlBR4KgYgzTeuAqrg==
X-Received: by 2002:a17:902:ea09:b0:216:2a36:5b2e with SMTP id d9443c01a7336-21a83f76879mr320397085ad.32.1736790686632;
        Mon, 13 Jan 2025 09:51:26 -0800 (PST)
Received: from nuvole.. ([144.202.86.13])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-21a9f25a1cbsm55817985ad.241.2025.01.13.09.51.13
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 13 Jan 2025 09:51:26 -0800 (PST)
From: Pengyu Luo <mitltlatltl@gmail.com>
To: Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Bjorn Andersson <andersson@kernel.org>,
	Konrad Dybcio <konradybcio@kernel.org>,
	Hans de Goede <hdegoede@redhat.com>,
	=?UTF-8?q?Ilpo=20J=C3=A4rvinen?= <ilpo.jarvinen@linux.intel.com>,
	Bryan O'Donoghue <bryan.odonoghue@linaro.org>,
	Sebastian Reichel <sre@kernel.org>,
	Heikki Krogerus <heikki.krogerus@linux.intel.com>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Jean Delvare <jdelvare@suse.com>,
	Guenter Roeck <linux@roeck-us.net>
Cc: devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	linux-arm-msm@vger.kernel.org,
	platform-driver-x86@vger.kernel.org,
	linux-pm@vger.kernel.org,
	linux-usb@vger.kernel.org,
	linux-hwmon@vger.kernel.org,
	Pengyu Luo <mitltlatltl@gmail.com>
Subject: [PATCH v3 0/6] platform: arm64: Huawei Matebook E Go embedded controller
Date: Tue, 14 Jan 2025 01:49:45 +0800
Message-ID: <20250113174945.590344-1-mitltlatltl@gmail.com>
X-Mailer: git-send-email 2.47.1
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

This adds binding, drivers and the DT support for the Huawei Matebook E Go
(sc8280xp-based) Embedded Controller which is also found in Huawei Matebook
E Go LTE (sc8180x-based), but I don't have the sc8180x one to perform tests,
so this series enable support for sc8280xp variant only, this series provides
the following features:

- battery and charger information report
- charging thresholds control
- FN lock (An alternative method)
- LID switch detection
- Temperature sensors
- USB Type-C altmode
- USB Type-C PD(high power)

Thanks to the work of Bjorn and Dmitry([1]), the work of Nikita([2]), writing a
EC driver won't be suffering. This work refers a lot to their work, also, many
other works. I mentioned them in the source file.

Depends: https://lore.kernel.org/linux-arm-msm/20241220160530.444864-1-mitltlatltl@gmail.com

[1] https://lore.kernel.org/all/20240614-yoga-ec-driver-v7-0-9f0b9b40ae76@linaro.org/
[2] https://lore.kernel.org/all/20240315-aspire1-ec-v5-0-f93381deff39@trvn.ru/

base-commit: 37136bf5c3a6f6b686d74f41837a6406bec6b7bc

Signed-off-by: Pengyu Luo <mitltlatltl@gmail.com>
---
Changes in v3:
- Link to v2: https://lore.kernel.org/linux-arm-msm/20250105174159.227831-1-mitltlatltl@gmail.com

dt-binding:
- drop generic compatibles. (Krzysztof)
- remove '+' to use literal block style. (Krzysztof)

ec:
- take struct gaokun_ucsi_reg as parameter (Heikki)
- add almost all kernel doc comments (Krzysztof, Heikki)

ucsi:
- drop unnecessary ucsi quirks (Dmitry)
- add UCSI v1.0 to ucsi.h (Heikki)
- use gaokun_ucsi_read_cci() to read cci directly (Heikki)
- drop unnecessary gaokun_ucsi_get_port_num (Heikki)
- rename member port_num => num_ports (Heikki)
- fix completion, forgot to signal threads in previous version

dt:
- fix indentation (Konrad)
- add a link between role switch and connector

Changes in v2:
- Link to v1: https://lore.kernel.org/linux-arm-msm/20241227171353.404432-1-mitltlatltl@gmail.com

global:
- drop qcom's products(i.e. sc8180x, sx8280xp) everywhere, use 'product'-based instead(Krzysztof, Bryan)
- drop Cc Nikita Travkin, we had discussed the device in PM.
- add myself to MAINTAINERS

dt-binding:
- fix building (Rob Herring (Arm))
- remove unnecessary code (Krzysztof)
- add bugzilla documentation, insights of gaokun(see [1] or patch[1/5]) (Krzysztof, Aiqun(Maria))
- explain the difference between PMIC GLink and gaokun EC (Aiqun(Maria))

ec:
- use Linux style comments (Krzysztof)
- add a comment for mutex lock (Krzysztof)
- add more kerneldoc for exported functions (Krzysztof)
- eliminate unnecessary conditions (Bryan)
- add a macro for check thresholds (Bryan)
- improve English (Bryan)
- use existing sysfs interface(hwmon, psy) whenever possible (Krzysztof)
- use __le16 and related endianess conversion function for temp data (Ilpo)
- drop alias for packet headers (Ilpo)
- avoid hardcoding i2c msgs size (Aiqun(Maria))
- add a comment for the sleep in critial region (Bryan, Aiqun(Maria))
- use macro to construct packet (Bryan, Aiqun(Maria))

wmi:
- dropped

ucsi:
- reorder headers (Bryan)
- a comment for the orientation map macro (Bryan)
- make mux mode map more explicit(minus six is very clear now) (Bryan, Dmitry)
- handle port update exceptions return (Bryan)
- a comment for the UCSI quirks (Dmitry)
- use the inline hint for the short register function (Dmitry)
- use the API with delay to handle register instead of a direct sleep (Bryan)
- handle unfinished initialization early

psy:
- add charging related sysfs to here (Krzysztof, Dmitry)
- document ABI for power_supply sysfs (Krzysztof)
- drop charging threshold, use smart charging instead

dts:
- correct indentation, properties' order. (Konrad)

Pengyu Luo (6):
  dt-bindings: platform: Add Huawei Matebook E Go EC
  platform: arm64: add Huawei Matebook E Go EC driver
  usb: typec: ucsi: Add a macro definition for UCSI v1.0
  usb: typec: ucsi: add Huawei Matebook E Go ucsi driver
  power: supply: add Huawei Matebook E Go psy driver
  arm64: dts: qcom: gaokun3: Add Embedded Controller node

 .../ABI/testing/sysfs-class-power-gaokun      |  47 +
 .../bindings/platform/huawei,gaokun-ec.yaml   | 124 +++
 MAINTAINERS                                   |   9 +
 .../boot/dts/qcom/sc8280xp-huawei-gaokun3.dts | 163 ++++
 drivers/platform/arm64/Kconfig                |  21 +
 drivers/platform/arm64/Makefile               |   1 +
 drivers/platform/arm64/huawei-gaokun-ec.c     | 841 ++++++++++++++++++
 drivers/power/supply/Kconfig                  |  10 +
 drivers/power/supply/Makefile                 |   1 +
 drivers/power/supply/huawei-gaokun-battery.c  | 548 ++++++++++++
 drivers/usb/typec/ucsi/Kconfig                |  11 +
 drivers/usb/typec/ucsi/Makefile               |   1 +
 drivers/usb/typec/ucsi/ucsi.h                 |   1 +
 drivers/usb/typec/ucsi/ucsi_huawei_gaokun.c   | 524 +++++++++++
 .../linux/platform_data/huawei-gaokun-ec.h    |  80 ++
 15 files changed, 2382 insertions(+)
 create mode 100644 Documentation/ABI/testing/sysfs-class-power-gaokun
 create mode 100644 Documentation/devicetree/bindings/platform/huawei,gaokun-ec.yaml
 create mode 100644 drivers/platform/arm64/huawei-gaokun-ec.c
 create mode 100644 drivers/power/supply/huawei-gaokun-battery.c
 create mode 100644 drivers/usb/typec/ucsi/ucsi_huawei_gaokun.c
 create mode 100644 include/linux/platform_data/huawei-gaokun-ec.h

-- 
2.47.1


