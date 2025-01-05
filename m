Return-Path: <linux-pm+bounces-19967-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id C3CF7A01B07
	for <lists+linux-pm@lfdr.de>; Sun,  5 Jan 2025 18:44:03 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 11FFD1883888
	for <lists+linux-pm@lfdr.de>; Sun,  5 Jan 2025 17:44:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 52B1417278D;
	Sun,  5 Jan 2025 17:43:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="mR1wOEsw"
X-Original-To: linux-pm@vger.kernel.org
Received: from mail-pl1-f181.google.com (mail-pl1-f181.google.com [209.85.214.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9FA935336D;
	Sun,  5 Jan 2025 17:43:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.181
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736099037; cv=none; b=IcpMkiYT3ALCaXOeb6egoeoykU7Cv3ao7+5pmrXzpRQPZK+vHVgmT7Oi0Nuh/pxmrgZ41oCrBABXTSbu3ENZidM6ZIJDnqb+NwZsRAbbYVXiQHbD+1wIY4z0DCuwX+2DC7lDR5H6dZMc7K9VEOumI2WLWaPNB9JTx7Rg1VhBfOw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736099037; c=relaxed/simple;
	bh=q332Fj6F/uI2gskbdG5KgphF6RiCneYdURLVc6gzVH0=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=fMSmo6PGUITwaXSDIImjPy3A2QFaoeElnf7ALYYG3vwUUbn7TrdQvfVhuum+705aKOPGwnRQb29L2aronUWMQKoWKhh1QKpIhEvE1t6oGurg6f+zA4NL57//t5lCC+2J2Ej3m8WrnuAeV6n1VJe972oC3C36JPgiJuRwKr7Td+Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=mR1wOEsw; arc=none smtp.client-ip=209.85.214.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f181.google.com with SMTP id d9443c01a7336-21670dce0a7so7162905ad.1;
        Sun, 05 Jan 2025 09:43:55 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1736099035; x=1736703835; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=36LFfwDYtsfgnNd7joNqjlhSXArKAKlv+UrCSX7GMt4=;
        b=mR1wOEswuAS29UvI1BPhBTcb8XuexdPrf/6RVKtzPH2akMp3wsQpswzrA1yrSCt/bL
         jYBsLxpaVyoKfN7QNlw5UznMNS2Ks+DFwaiOFdJACyvBJHvApF3nQgW0v3NwVZDEG5J1
         Vot8sZy4VVx/aS0KGE/JhZM7NpX7mxiao9cdjCmHsHIduge2deC63PZngANxNd4IEk0Y
         krBQyq18YEavzcNTomFIkBxT44sqrkjYjtIamvF0BEhTc96VFkhtzyQfLyBzjAbGCpX8
         aPAKsPyubPF/M+XXswAm4b07UKeBj0L2xW2vQKCUz0YLKOkhYHo16mSLLmWKxW54uMq8
         O7DQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1736099035; x=1736703835;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=36LFfwDYtsfgnNd7joNqjlhSXArKAKlv+UrCSX7GMt4=;
        b=l7Da1eV+Eo7o67CQv5L/9YNFoALLuRPAW+fjCG4eYntpCXNuutrBl1xyGVOKSx3ghB
         tlv7dwYDemk4mmMdvFDTwOT5f0ipm5rSNHLvyaN0rUJODtQlHkIMeHNWw5bZiC+Aflq9
         EZlGvGcv1CqLJN6Gm4wmT5QMPV/xJTsJu676w19G44ptp5dByUwUHVBSVwoV1G8mcg5F
         rt+NFWJtub0EfpAxGbu8Uqjqv5WdClFi0nrvyN1QaF7d9+x5reRfh1W2eZp9hcHZpZd6
         NTAad193DOL7sXrLtlJknN4PmoFIhNo6dlvP+Bc6l+6BKY83RgQTd1daMq6e87IvQlGS
         o4xQ==
X-Forwarded-Encrypted: i=1; AJvYcCUAxuP7Vd9YAZUHpsC+2kia4BnO+oPecbX5KO9W7aZ8KfgBXnbUOdCcLvzwZs7V6Q1tF7/ZLpQy2Z0=@vger.kernel.org, AJvYcCUduS5Odx256o88wMHN/bWK/8ciRjx43ywopHysU+k6z1fySLk2vgDQDr8jPMSeAfk9N9epqGP9VdJzRvAd@vger.kernel.org, AJvYcCUnTKMLbB3QQ/sU4c+wXacaTPaNUhVCrj2AoIMPnjIzaizzOjuqcHgPBIBVAp3CYSVfW2BSop1ypQ+SfCur+fSRD/ufkA==@vger.kernel.org, AJvYcCVx4YOwNArUtlspQ6IMrIKZyyXEQjH3dDitJ/JcEdeBjj9VKQiWkjL48c2upbBgzgjJzwh27JwqPUFFUWk=@vger.kernel.org, AJvYcCXBq8bHBkhUEX0TMzlqFdD1SkWBxH2UydHzbeTJGvZuvvFQ08T8z++H2MRmAwfK3NJqcI6XRoSCxluz@vger.kernel.org, AJvYcCXtmEsjEglJqmtYqqVhl7+ZJ6I1oaauHU1INiOX8ByvLVK8XY8MCMBAneyAjb+I03U38pUjcCDE4uprYVFF@vger.kernel.org
X-Gm-Message-State: AOJu0YzA9XtKCHnSfIzuecdD1nmUutN+izQcQfDsfjQWpSpUdystLyQe
	4NSE1y4xeddBBP1g/CvfQNfrXU2SKFKEGeSwqb9cFcYNg5XctbdX
X-Gm-Gg: ASbGnctYv4QQ1h8hKbEHexJ6YFAbN9MXfjU3W+7J9pO5HGIroEX5HPUJ69EabNjKG7n
	SSgRhFS0BjLoUVKy0FFQUyWvY84Eta8LJQnkauwWed8IrZ+p5AWPwtWg3k8XPKWjzKd7h1vwGJ0
	1bAwQu10hP/mstkjhBdrdPOW+0Kq4XDLDA5YEHmiSxLZMLalbMtNnPreLazMKz2I/uwZTc195qh
	3ylarQphLqJsRffOVamwIc6SesofEPS+QrdGK/pZymJsJuvYiZJGOo=
X-Google-Smtp-Source: AGHT+IFFIIZvCFbxqtvKBP3spQLi9bhSufpsm15oW78Ou90z34ay3OOR5Oc2VH3/ltiab4y8E7wUkw==
X-Received: by 2002:a05:6a21:9017:b0:1e1:a434:2964 with SMTP id adf61e73a8af0-1e5e0459369mr81799396637.2.1736099034839;
        Sun, 05 Jan 2025 09:43:54 -0800 (PST)
Received: from nuvole.. ([144.202.86.13])
        by smtp.gmail.com with ESMTPSA id 41be03b00d2f7-842abd5927fsm27375046a12.10.2025.01.05.09.43.41
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 05 Jan 2025 09:43:54 -0800 (PST)
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
	Dmitry Baryshkov <dmitry.baryshkov@linaro.org>,
	Pengyu Luo <mitltlatltl@gmail.com>
Subject: [PATCH v2 0/5] platform: arm64: Huawei Matebook E Go embedded controller
Date: Mon,  6 Jan 2025 01:41:54 +0800
Message-ID: <20250105174159.227831-1-mitltlatltl@gmail.com>
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

Signed-off-by: Pengyu Luo <mitltlatltl@gmail.com>
---
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

---
Pengyu Luo (5):
  dt-bindings: platform: Add Huawei Matebook E Go EC
  platform: arm64: add Huawei Matebook E Go EC driver
  usb: typec: ucsi: add Huawei Matebook E Go ucsi driver
  power: supply: add Huawei Matebook E Go psy driver
  arm64: dts: qcom: gaokun3: Add Embedded Controller node

 .../ABI/testing/sysfs-class-power-gaokun      |  47 ++
 .../bindings/platform/huawei,gaokun-ec.yaml   | 127 +++
 MAINTAINERS                                   |   9 +
 .../boot/dts/qcom/sc8280xp-huawei-gaokun3.dts | 139 ++++
 drivers/platform/arm64/Kconfig                |  21 +
 drivers/platform/arm64/Makefile               |   1 +
 drivers/platform/arm64/huawei-gaokun-ec.c     | 767 ++++++++++++++++++
 drivers/power/supply/Kconfig                  |  10 +
 drivers/power/supply/Makefile                 |   1 +
 drivers/power/supply/huawei-gaokun-battery.c  | 548 +++++++++++++
 drivers/usb/typec/ucsi/Kconfig                |  10 +
 drivers/usb/typec/ucsi/Makefile               |   1 +
 drivers/usb/typec/ucsi/ucsi_huawei_gaokun.c   | 524 ++++++++++++
 .../linux/platform_data/huawei-gaokun-ec.h    |  79 ++
 14 files changed, 2284 insertions(+)
 create mode 100644 Documentation/ABI/testing/sysfs-class-power-gaokun
 create mode 100644 Documentation/devicetree/bindings/platform/huawei,gaokun-ec.yaml
 create mode 100644 drivers/platform/arm64/huawei-gaokun-ec.c
 create mode 100644 drivers/power/supply/huawei-gaokun-battery.c
 create mode 100644 drivers/usb/typec/ucsi/ucsi_huawei_gaokun.c
 create mode 100644 include/linux/platform_data/huawei-gaokun-ec.h

-- 
2.47.1


