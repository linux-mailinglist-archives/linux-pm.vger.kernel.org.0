Return-Path: <linux-pm+bounces-19777-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 3E34D9FD665
	for <lists+linux-pm@lfdr.de>; Fri, 27 Dec 2024 18:15:30 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id BDDF4163F82
	for <lists+linux-pm@lfdr.de>; Fri, 27 Dec 2024 17:15:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B8C021F7586;
	Fri, 27 Dec 2024 17:15:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="CLo5YY2f"
X-Original-To: linux-pm@vger.kernel.org
Received: from mail-pl1-f170.google.com (mail-pl1-f170.google.com [209.85.214.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2815435974;
	Fri, 27 Dec 2024 17:15:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1735319724; cv=none; b=XrjyY1ydIFu3EdM06QiVPkAWpOE86Pxhb2m2D9OL/J5txQJZoNZsbCQy1ezvTbjB4O+Qeiezh6wbksRTziSRO0Y6em+EJXAsZJOasW0BnPSHCsQ/9ygLPf41pXALZm3lxG48sqTiRpeMT0pql+cmIizjUK4G8ZQiupt7994UHz0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1735319724; c=relaxed/simple;
	bh=kqENJDWRfVkjH1SxZdWluLcN8++438Sm8xVfEuDBBzw=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=tguY/qptBsKey+tb4YQL1VwvaAd4YgbLnlVjBupejMY9GOuutPvvvfT66NnxKGpUvHFEM6ubHuxcFN860o2nRPnMqP+5Pr29dggECXGPHRkMphpC7Q83bpcpIosDhaq5Cv1GkyBGocTNHgjjJ1nSDstxu+qKdFuhKiemwDIPvTg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=CLo5YY2f; arc=none smtp.client-ip=209.85.214.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f170.google.com with SMTP id d9443c01a7336-21634338cfdso129301265ad.2;
        Fri, 27 Dec 2024 09:15:22 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1735319722; x=1735924522; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=2xGH4XIve12sF/Sx0uzEqo2PoNPgglUjahAnQc+lAmU=;
        b=CLo5YY2fVWccWi9xJFR6a/1KrONJJVtt2FgWcCJm6TGDu1LBeoZ3L5Fc5uGAmB+BSs
         OJrHtn9HMtU/NWYE6ynwogWli6ImvKgec1paj0oeJsVdXVbpCl03jq51TIgf2aot6Um9
         KHxaJsWT+5GTXb9tgaO6HAtc5/cQ37BtXw7Z6Vb18KrFEwnIGnttHk94KXw/EcWKdUkG
         gxrXwbyltXHGof52Al5Y+6KIZ8cdi8ujkRj01Nk/1RcwsV+nJ6rp+FPEp5lMpM9vhYIn
         /M6WYJ0mJOFEY6ZVGzbho8V3bUOpK/WSfRHNZDNFls6EvDS0AzMA/NclGe9QuP0FUofO
         mXKg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1735319722; x=1735924522;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=2xGH4XIve12sF/Sx0uzEqo2PoNPgglUjahAnQc+lAmU=;
        b=d+WLlQPRhn97Iw/FC3cYjxqGM66hKL78RbBUJ6FdGmIR9uwZjLojCSae2KkbJAtBXF
         Qm306yU3WOKjFfroE2eKKVM6Z2GM1nSYeWN9JQsSE8J91vxp9Eui2oT5RQ87PTr9V47M
         lMgLHqzLpBw6RQ3FBctxa0L4nORO/xe1JgyW7TpyXICJH4TUCVs7anKyHMOoZaiW/xgK
         OSgKjQQ3ETKhtFTrSo2W8rG/T5xmkZ1jItgJOi1NV6/IljDI5AG/m7GzLujQy8pxKyuU
         NQH6dj4qCv2UGa2ip8mv3b1MNFLp2oecS8GP8O9VYYQYfAa0fclxCDegYuDVRoNmPl+U
         W/Eg==
X-Forwarded-Encrypted: i=1; AJvYcCU+y+dR943nqKKi6/BeAYXcVcsEpD9hI4jMsMEdG+fF7cGPhLVaxJkTnY5IQTE18wc+Xi6dC7QMRpBz@vger.kernel.org, AJvYcCUhmDB5BUKgb1DerRiq1tOjKjGz6DUephPHXk8fGhZ2iEH+jnxCS+r9hhn43rcZ5JYUyG9UTrSyWChj1Kla@vger.kernel.org, AJvYcCVgnFqaPpnPJDZjp2sUL6gQYC12OLiSTl8nbpTq1C//+lirl0YSZ9gTrx1B3vrzIkC8Otn3BxD6f2eOYZLH0ql71kjqdA==@vger.kernel.org, AJvYcCWcIOzQPCZKua9H1PP6+PULABYoycArQMNPJKG3dIKoLUQ1jXWFyoC50EbcEY8qiMtrywOAcSbuQ9Bq3amH@vger.kernel.org, AJvYcCXhTj/bfC3IcTEcbph4IZwIZ4XC2bndw+44ctCF8svbkpbwsGEcw/QjU8CPDMrEDgFfq6FFmIUAJK0=@vger.kernel.org
X-Gm-Message-State: AOJu0Yx9SsmANiqAk8hYZ0Riv0SeQqKcLF+dA5FaaorBLnsfjetm7bsM
	jfOiILp84Ibg6TSx+97QjTwxDZrM3KJssOa4uosPd7HMvZqz6lbRTU58nGSOEM4WJcIq
X-Gm-Gg: ASbGncs9U1s1dit0cToqVNaAzvKEfWwxlXJUAYc3UXQUXGk+KHg2iO4JxWrVi+PppOc
	sy2z2JA95409/bi2/oJ35D7vDnMtNao2duONUAGZuq01R+TiBrU8btQUWYOd9zOcaRG3MLM4qnm
	Y7RTy0f6FC0Ye9cg+1ZYZwZlhRIuelUgq+yNu1Ny3XG4RSOCjPqN7aEFAN7W6+N5r/vtfk0pxjG
	fWEmjrvgcepuOE6USp9TWk5hEU0G+o8Zbm0Sq2ZMOE=
X-Google-Smtp-Source: AGHT+IHTt64/v6O//+g4tudoDgww29789gjWkBCiS4wp+DmomX0svX8WyXKm6m1xzF+2ZGP7sVuR9A==
X-Received: by 2002:a17:903:120e:b0:215:6816:6345 with SMTP id d9443c01a7336-219e6ea278cmr363721505ad.16.1735319722370;
        Fri, 27 Dec 2024 09:15:22 -0800 (PST)
Received: from nuvole.. ([2a09:bac1:76a0:dd10::2e9:62])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-219dc9f5227sm138566925ad.185.2024.12.27.09.15.16
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 27 Dec 2024 09:15:21 -0800 (PST)
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
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	linux-arm-msm@vger.kernel.org,
	platform-driver-x86@vger.kernel.org,
	linux-pm@vger.kernel.org,
	linux-usb@vger.kernel.org,
	Dmitry Baryshkov <dmitry.baryshkov@linaro.org>,
	Nikita Travkin <nikita@trvn.ru>,
	Pengyu Luo <mitltlatltl@gmail.com>
Subject: [PATCH 0/5] platform: arm64: Huawei Matebook E Go embedded controller
Date: Sat, 28 Dec 2024 01:13:48 +0800
Message-ID: <20241227171353.404432-1-mitltlatltl@gmail.com>
X-Mailer: git-send-email 2.47.1
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

This adds binding, drivers and the DT support for the Huawei Matebook E Go
(sc8280xp) Embedded Controller which is also found in Huawei Matebook E Go
LTE (sc8180x), but I don't have the sc8180x one to perferform test, so this
series enable support for sc8280xp variant only, this series provides the
following features:

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
Pengyu Luo (5):
  dt-bindings: platform: Add Huawei Matebook E Go EC
  platform: arm64: add Huawei Matebook E Go (sc8280xp) EC driver
  usb: typec: ucsi: add Huawei Matebook E Go (sc8280xp) ucsi driver
  power: supply: add Huawei Matebook E Go (sc8280xp) psy driver
  arm64: dts: qcom: gaokun3: Add Embedded Controller node

 .../bindings/platform/huawei,gaokun-ec.yaml   | 116 ++++
 .../boot/dts/qcom/sc8280xp-huawei-gaokun3.dts | 139 ++++
 drivers/platform/arm64/Kconfig                |  19 +
 drivers/platform/arm64/Makefile               |   2 +
 drivers/platform/arm64/huawei-gaokun-ec.c     | 598 ++++++++++++++++++
 drivers/platform/arm64/huawei-gaokun-wmi.c    | 283 +++++++++
 drivers/power/supply/Kconfig                  |   9 +
 drivers/power/supply/Makefile                 |   1 +
 drivers/power/supply/huawei-gaokun-battery.c  | 446 +++++++++++++
 drivers/usb/typec/ucsi/Kconfig                |   9 +
 drivers/usb/typec/ucsi/Makefile               |   1 +
 drivers/usb/typec/ucsi/ucsi_huawei_gaokun.c   | 481 ++++++++++++++
 .../linux/platform_data/huawei-gaokun-ec.h    |  90 +++
 13 files changed, 2194 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/platform/huawei,gaokun-ec.yaml
 create mode 100644 drivers/platform/arm64/huawei-gaokun-ec.c
 create mode 100644 drivers/platform/arm64/huawei-gaokun-wmi.c
 create mode 100644 drivers/power/supply/huawei-gaokun-battery.c
 create mode 100644 drivers/usb/typec/ucsi/ucsi_huawei_gaokun.c
 create mode 100644 include/linux/platform_data/huawei-gaokun-ec.h

-- 
2.47.1


