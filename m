Return-Path: <linux-pm+bounces-26433-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 9CC9EAA42A0
	for <lists+linux-pm@lfdr.de>; Wed, 30 Apr 2025 07:52:00 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id A58987A55B7
	for <lists+linux-pm@lfdr.de>; Wed, 30 Apr 2025 05:50:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1BD471E25F8;
	Wed, 30 Apr 2025 05:51:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="GDrZBdyK"
X-Original-To: linux-pm@vger.kernel.org
Received: from mail-ed1-f42.google.com (mail-ed1-f42.google.com [209.85.208.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 539E02F5B;
	Wed, 30 Apr 2025 05:51:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1745992313; cv=none; b=LcZtR+sc4P8cFtwuM/xyxMaGrJKkQwHAyoFyPqpE1xHcomcbS3WSJPi8/CyMeik6IscPzY8eIh7WmjalI8cNWKDC+X48WNO8nZhRBbVkutGb/sQH+kYduCBm21LQ7uJUsaFcsKyLAQLCU/c6v8F9l79ticx/MrY/D0a9RvJeTmY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1745992313; c=relaxed/simple;
	bh=omSCQTCdptCp23vUhrqVKr55U/gZag07HV3WvLK0r2U=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=IEqf42M3hfEgwyBrI0ZqmN/CgWApZfcdN+j2HsTzu9laKU4Bg302jhmjzPMmUoieDpUCb8Xsqxiu4o8xEFwyUmReLBhzs4efAoAAF9rhvpUVW/Nf8xFaBf02Mzm8SUn44mM86JmVD8+aNAF+hZNKCibpXoKTAea+Q9AN4bKcbN0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=GDrZBdyK; arc=none smtp.client-ip=209.85.208.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ed1-f42.google.com with SMTP id 4fb4d7f45d1cf-5efe8d9ebdfso3275364a12.3;
        Tue, 29 Apr 2025 22:51:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1745992309; x=1746597109; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=iyRh4E8pwFKv3Oq5GMrsZnoteH07dnpTctT4hrmHUhE=;
        b=GDrZBdyKGEhBKWlY+NyGODqEHX4ySIF+KcsXpTqt6B3wbpHeXwAimJgG+c3j02Ss5W
         qfRWQAgYdXRarWE8AQj5kYtU6o3c3QWueYU2fTxbCKAP4NsmdXh+T9aIbBs7EfGO/Qmw
         iiEEGEjqqRs3osfVxQU9v+/sCpky+hYnjR5GudzWxFMGCBwVy/NQWVWOTwl1Ep6VuqhA
         PPmhaklDCa15kgJfMxuoEiXGhQF4EwC4adjM6KIfxwDvxQprGwvXEjKoMOfeQvs1JEIo
         dGTVymU807TyExhujpbs2BbuZ/basFN0TxJwH4V5QxAMBRfvXcG8pYT+9l4IUtE4cdsU
         SUTQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1745992309; x=1746597109;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=iyRh4E8pwFKv3Oq5GMrsZnoteH07dnpTctT4hrmHUhE=;
        b=bsU6uLQHMOF9sst4o43E12m3RPUrW9Z0NboK/YxL+P4qonjyfKE8Y9Wc0MlfGxmxVg
         U5X5TX/1xY8kcXhk3PbMUCmesO155CQ5rPS0ejEiZjLRV6jDafmQXcSV1e9NbvbJHtfs
         3SKrGgbTN0qNOSNj0pSeAzijm1hEtZGKdSYLFR00TOLYqNdi3lgYMIBoQ6pbgnSN2shC
         7csnFMkE0zdSwfsHnyIM+m7jJbksuK2WkDTDts/3aICVsG9xSek09H9nxCCIigFjp3sW
         PYcDutEGUPoh8ANV+X8rujK8w4sqd0i5LQ7K1i2iX3XQxuHuw0JH/GYnfTvZ0Ef8L/9p
         ViXw==
X-Forwarded-Encrypted: i=1; AJvYcCUVrzjd6GhKkH05qEF9ic8vi4Fwmst4ag7QWr12WZPu08CsCzG0Ww4wSblI4Veq1oO3Fp/j2cCsa9bSSmIS@vger.kernel.org, AJvYcCUZbxH7fZh/lDmEmiWEKUo9Fg7fPpF2ySrFGgxPl7t6ljElp4Qz/JDZoqP5xrrUSAeze85EkU/QulLs@vger.kernel.org
X-Gm-Message-State: AOJu0YxFI2ezfEWSTF6lRPDyCDjUyYj1ckrje9b7hhMZRbbgpegWkc3/
	uRnFW+pDTQoP5ecMWtTiLDJ3I7f1VGLuwDP2S9RBrQw3wSTwQ/WlzkOvIQ==
X-Gm-Gg: ASbGnculBHL4DyOntOznxvS8ToAXYqBjb9EqPukmi8+N2gPgn5FaxOJ8GUowg8C3OaF
	GKhlGIwYirjkJ/zXPeuaj1lIIoh7mC49lHW/XE5AvG6ZMuvb4VA4RzI+TgQHb8L0scPMTZwGCkr
	WuU75VepolD/LdEY2G5yzQxjfXC7+29NkSQTbfkF8lnXnrlihwuiOvs54oepIBd9L1+XpqnyfW3
	6Hgd516j6Cz+xy5k9laa/6myvxd/WU1TkZOOgZO+JoCetGDukegt0+S7R8UybPtwQmcNT45m5mP
	qImn3lu70O3KOmEZIjNXdVhINxGiJtyE
X-Google-Smtp-Source: AGHT+IE+IGChS8lz4PQe3sirYMpcn8Nw+59hnF8Fm9WrMbDg4BP3Def0MzxodNoeHeoxUTglt4tcsA==
X-Received: by 2002:a17:906:730b:b0:ace:31bf:30f3 with SMTP id a640c23a62f3a-acee25d7a1cmr116790066b.43.1745992309342;
        Tue, 29 Apr 2025 22:51:49 -0700 (PDT)
Received: from xeon.. ([188.163.112.70])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-acebe7a4f1csm299929566b.51.2025.04.29.22.51.48
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 29 Apr 2025 22:51:48 -0700 (PDT)
From: Svyatoslav Ryhel <clamor95@gmail.com>
To: Sebastian Reichel <sre@kernel.org>,
	Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Svyatoslav Ryhel <clamor95@gmail.com>
Cc: linux-pm@vger.kernel.org,
	devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH v6 0/2] power: supply: Add support for Maxim MAX8971 charger
Date: Wed, 30 Apr 2025 08:51:12 +0300
Message-ID: <20250430055114.11469-1-clamor95@gmail.com>
X-Mailer: git-send-email 2.48.1
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The MAX8971 is a compact, high-frequency, high-efficiency
switch-mode charger for a one-cell lithium-ion (Li+) battery.

---
Changes on switching from v5 to v6:
- upgraded ABI properties description
- minor formatting improvements

Changes on switching from v4 to v5:
- revert schema to v3
- removed i2c_client from driver data
- removed max8971_supplied_to
- swapped power_supply_config filling .of_node with .fwnode
- attr group liked to power_supply_config
- added ABI properties description

Changes on switching from v3 to v4:
- swap graph with connector phandle

Changes on switching from v2 to v3:
- fast_charge_timer, top_off_threshold_current and top_off_timer converted to
  device attributes. Other vendor properties removed.
- removed max8971_config
- removed unneded functions and definitions along vendor props removal
- added __maybe_unused for resume function

Changes on switching from v1 to v2:
- swap phandle with graph for extcon
- added power-supply ref
---

Svyatoslav Ryhel (2):
  dt-bindings: power: supply: Document Maxim MAX8971 charger
  power: supply: Add support for Maxim MAX8971 charger

 Documentation/ABI/testing/sysfs-class-power   |  43 +
 .../bindings/power/supply/maxim,max8971.yaml  |  68 ++
 drivers/power/supply/Kconfig                  |  14 +
 drivers/power/supply/Makefile                 |   1 +
 drivers/power/supply/max8971_charger.c        | 752 ++++++++++++++++++
 5 files changed, 878 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/power/supply/maxim,max8971.yaml
 create mode 100644 drivers/power/supply/max8971_charger.c

-- 
2.48.1


