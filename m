Return-Path: <linux-pm+bounces-11444-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 2B13B93D947
	for <lists+linux-pm@lfdr.de>; Fri, 26 Jul 2024 21:52:28 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 9D41BB220BD
	for <lists+linux-pm@lfdr.de>; Fri, 26 Jul 2024 19:52:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C843650288;
	Fri, 26 Jul 2024 19:52:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="CMX19REm"
X-Original-To: linux-pm@vger.kernel.org
Received: from mail-oo1-f45.google.com (mail-oo1-f45.google.com [209.85.161.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 51F801E4A4;
	Fri, 26 Jul 2024 19:52:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.161.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722023539; cv=none; b=EqMY4ko5xxbOBtefihozf9pKsvF4y0KcX7kmo9RUgPEQz5ReqrhvFeumUDsSjdqrstPhLqiBk25FdfVTWuwTIpEdXvnNtx8FnymBljxaX3u8YZL1ktZzwonbF0kuS/77YsSYs720/dcgGV9Qu2MpOCeg+WudRTAHQJhDA4Ox+cs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722023539; c=relaxed/simple;
	bh=zM4s3tiugQ4XH0asDc4qRuITlFIBr7Pqhg1sstqg5QQ=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=VuXHv54/zi4WG1AQ7sZ6PL4YgJHo5mqONY3ztsTjcpSEqj/xd8SeCuSi9YDIw/gkp3cTjFcY3sRywsibnLxB0l1ORFujCPM3r9z2i07uYjSZ7O1vNE8NP8ha6K3LXLmVsTOeN0c8zZqE+FE5R3GTA7dPsAQq9/lJT1nPGf/fi6c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=CMX19REm; arc=none smtp.client-ip=209.85.161.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-oo1-f45.google.com with SMTP id 006d021491bc7-5d5cbe88f70so403005eaf.0;
        Fri, 26 Jul 2024 12:52:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1722023537; x=1722628337; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=kWiKfDpsEABMzVt5RHgv/hUtn6hfH5Uv0J2xoacck4Q=;
        b=CMX19REmX53AYleY52pZmr8S6Ec84DI55QNL9c9LPfRsuLEg6QEGGw++KreTqIahTC
         X3Z+DtS/QAdDrn1cxXf4XcNaDgBUJr5tZybh2ZtTZ+tSLk0yfHF27E0q8xEYj3cqGezI
         ZEb0qXu253kwg3TxGvUPkEpbv3mObxjD/hh3S0el6tZ8Xb/ZbbLo8pdh9d+AVfQcaTSn
         jYewMhQJDYEi/vHFRi7RCM3Yiw9pTH+Qcdk4Kk0zWl/ImI8cK4H/ZKWd4u3B8grtZAsm
         RsUYL+JtxOBvLQjo6z7GTBV83jUf4dMkq1rO40delV+3/F3zHnJq18s9Hyo3K8hRsski
         E5kA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1722023537; x=1722628337;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=kWiKfDpsEABMzVt5RHgv/hUtn6hfH5Uv0J2xoacck4Q=;
        b=BbXefFncmN9Tbdr5Pp1UKaa/0ucFUZPKqQ9Aw/YBs02ApEfhKK9zmHLVDnBebXdLWw
         D5Il/gcwFbGg/vxTbbI41hT9/A5uEoXsJ6Di9Wj4I30zR0W/lzoV4mMrBRsZlsWByXK2
         iqMNgnwU5naZeeSIHmmofMA5ZRenTndyVgbXQpDrr+2nXozZ0w9CD2/Phbx6akrcobUc
         w6jGcHhEt4BANMFYsZsukQyQeauyM+MfPPFm9mUKPheV8Mh6UQ5rllU4DhLtnDy5aNp6
         hap/TgVVhjHaKzPzf2m0ywZLG9OGucpH29801h9WzVUx68MhQO4xBx80ECPeyY3Yb8dE
         7mAg==
X-Forwarded-Encrypted: i=1; AJvYcCUk5rKtuB7Mmhe/Jx38RR9huSIz43cA6KfE1E5lgIKpMT8/lZbikFsQz8Y6P7UdRFkJCeQO3JEPTP1fBCXvlXBGWc1yY6KQ7KRzww==
X-Gm-Message-State: AOJu0YxJ2eDm8KN7QEmxyhqhWrlS37an2QcYyITeICVQ3BXtRz4q9tK8
	VcS6QQE8snKJXeNS6QWU+0qNY5g4R2OePha3+f3fQ+L1FQY70R3t
X-Google-Smtp-Source: AGHT+IFzGQYFYc+Wq2ICN64+syjNPm+CWB1f4WLsLxrXrXbZo1HnBb5N2Gu1PudJix1u9maC2OxFiw==
X-Received: by 2002:a05:6820:1688:b0:5c6:9320:4f1e with SMTP id 006d021491bc7-5d5d0eb8144mr830440eaf.6.1722023537324;
        Fri, 26 Jul 2024 12:52:17 -0700 (PDT)
Received: from localhost.localdomain ([2600:1700:fb0:1bcf:c1f3:7caa:bc8b:ab10])
        by smtp.gmail.com with ESMTPSA id 46e09a7af769-70930778069sm889972a34.59.2024.07.26.12.52.16
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 26 Jul 2024 12:52:17 -0700 (PDT)
From: Chris Morgan <macroalpha82@gmail.com>
To: linux-rockchip@lists.infradead.org
Cc: linux-pm@vger.kernel.org,
	devicetree@vger.kernel.org,
	jagan@edgeble.ai,
	andyshrk@163.com,
	jonas@kwiboo.se,
	sre@kernel.org,
	t.schramm@manjaro.org,
	heiko@sntech.de,
	conor+dt@kernel.org,
	krzk+dt@kernel.org,
	robh@kernel.org,
	Chris Morgan <macromorgan@hotmail.com>
Subject: [PATCH 0/5] Add GameForce Ace
Date: Fri, 26 Jul 2024 14:49:43 -0500
Message-Id: <20240726194948.109326-1-macroalpha82@gmail.com>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Chris Morgan <macromorgan@hotmail.com>

Add support for the GameForce Ace. The GameForce Ace is an RK3588s
based gaming device with a 1080p display, touchscreen, hall effect
joysticks and triggers, 128GB of eMMC, 8GB or 12GB of RAM, WiFi 5,
and support for a 2242 NVME.

Chris Morgan (5):
  dt-bindings: power: supply: add dual-cell for cw2015
  power: supply: cw2015: Add support for dual-cell configurations
  arm64: dts: rockchip: Pull up sdio pins on RK3588
  dt-bindings: arm: rockchip: Add GameForce Ace
  arm64: dts: rockchip: Add GameForce Ace

 .../devicetree/bindings/arm/rockchip.yaml     |    5 +
 .../bindings/power/supply/cw2015_battery.yaml |    6 +
 arch/arm64/boot/dts/rockchip/Makefile         |    1 +
 .../dts/rockchip/rk3588-base-pinctrl.dtsi     |   10 +-
 .../dts/rockchip/rk3588s-gameforce-ace.dts    | 1315 +++++++++++++++++
 drivers/power/supply/cw2015_battery.c         |    7 +
 6 files changed, 1339 insertions(+), 5 deletions(-)
 create mode 100644 arch/arm64/boot/dts/rockchip/rk3588s-gameforce-ace.dts

-- 
2.34.1


