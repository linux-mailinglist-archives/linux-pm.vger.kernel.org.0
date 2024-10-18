Return-Path: <linux-pm+bounces-15924-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 4677C9A381D
	for <lists+linux-pm@lfdr.de>; Fri, 18 Oct 2024 10:12:10 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 06AED281F39
	for <lists+linux-pm@lfdr.de>; Fri, 18 Oct 2024 08:12:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CE34018C902;
	Fri, 18 Oct 2024 08:11:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Smh3njv6"
X-Original-To: linux-pm@vger.kernel.org
Received: from mail-lf1-f43.google.com (mail-lf1-f43.google.com [209.85.167.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0A22518C34C;
	Fri, 18 Oct 2024 08:11:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729239096; cv=none; b=HO2FqZLvELfEtxOzzi9A3qpgJr6IbmBR50W6Uo+VavQDPyD+xxX9YxQEjcVIyZTX+Qfxd0udpSWKfjieKV2qn6Bh4O3fggxl93gQdeuPo/lZ2XF8tZXljbGO4mx/vQqYCwIYP4eIWWbzGdlax7my1lJ3msgZaAdsS6ws7G19umE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729239096; c=relaxed/simple;
	bh=Vd3k6DXWTHczac19l+ssc6HVY2q5TSnThz/h+s4QmQU=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=GQhPN7ydQaiB8BJWWpDXIEDSrrYdw5fO+bQ7WHn3N4OhO78XszodeYa9FOQ82XWSLfWsvk3uu+2TcBPhsQZ98mnu93bhHZxiRQO0xPqfbSrnK7UsLvLqKiu7xTbXvSIq3QQIyttwGlxZ460gNxeevXr7nm3ceStV2PaP8zX5b3U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Smh3njv6; arc=none smtp.client-ip=209.85.167.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-lf1-f43.google.com with SMTP id 2adb3069b0e04-539f1292a9bso2403336e87.2;
        Fri, 18 Oct 2024 01:11:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1729239093; x=1729843893; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=Gob43/+gAdlsPFue9el9gcoewwrv63+OSZMDYy79pec=;
        b=Smh3njv6d/ldJvlu3B1Rf7t+Q/Ty0JIQyW89vVNYLrzDCR2Tj67trzhvuB22rgB7+F
         zO338ukq3efAyYlUxwP+/DIW050npLk4oLHegcZQXF1uyswucp/qkTER5UjYJFl4YkjH
         Ckn01mGUx5D7ymfNBFjh9YwtGMsp+R31B7NLahVGZYe//J/LRFzoBztEyjRwbsHOp6LR
         VouLc7N6RcvxDSCACQx4gjzYCajCQYxqGWiXFKCyTM1u18yLq6erSTyPHBNJ+xcR0Xzk
         vISdNBkqSy7PKnmLO9UAZgkSk14nr+Tck0zQkrqNxxIyefXhCM6ssfQWDmETzX4Hnry6
         RXVw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1729239093; x=1729843893;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=Gob43/+gAdlsPFue9el9gcoewwrv63+OSZMDYy79pec=;
        b=X2OxnhTrhFsG5w+6P/eDVKVT47Qdlr//0gXeVuB0eqT2tBcb3qGo3P3Nz7JwpqB79O
         TTXof9taCl9mb5AZhN2HDSOVMmWJI+aUG0v9FFghMmTMwh74MjaeEVJzeCICcrpJzMEX
         n7g20rtuFZNudUM++gmGfd9huOU7rvPICG46FmxkC5IpkUxuI95dYYCywcdlST+J8drV
         2Rgm5yrEzaGPnOWlA8uUPeOyftYz+zf33HE9jr5LpD1ThZmwVtHgddpCaEtcVEEYXj13
         sTG9HCuMbiNYTN6i+nwmF68wEwIQlTwUertzFQ+pDrlNcmZf8kPsrHu+UBUt506fHXVn
         0hAw==
X-Forwarded-Encrypted: i=1; AJvYcCUhoYO+EA+8tL8Lc8hemmfpj0yxMv5f3ih77TcNaymF81+XisA3vqyiZeZsV7uOCGnt8p+goOpa76CsCGE=@vger.kernel.org, AJvYcCV27B8B1hVv1ev1dUeGYQAfQNk8jtkWuIg29eu+Kps68Gk09CLkvGBDYskjGkFGYKA5DVQr6+uhsO1j7eP8@vger.kernel.org, AJvYcCVhoJKqHoeLYqH7JrChQg2LhiGADkEMq4C40EqBEy8hFzMD0j8qden21h/uCn01xa138XblCqQmuTjK@vger.kernel.org, AJvYcCWD6GS2Rchg2kcvvuPIyoPtxfTfZxB7NEKGeQVJhz64bRmAZ393LdqM5pw9UNvk62SrqeVuBP3UI1s=@vger.kernel.org
X-Gm-Message-State: AOJu0YwaOramBj1bz4sfzuzTWhgdV8iVuY11dyvxazMzSwvzYuGZvefd
	GofEAs1QvmR3I0FBUmrZEHgj1mC1EfjqFVB5ecxg6f34UxQyqQQJ
X-Google-Smtp-Source: AGHT+IG/FXLUUpVPX3ROT5kd9YPxAoOY00obRdb0wk6QPFIDPBYVog79O1m31Xhkog/xCiQfLs20GQ==
X-Received: by 2002:a05:6512:12d6:b0:539:968a:9196 with SMTP id 2adb3069b0e04-53a154ce943mr1009789e87.48.1729239092911;
        Fri, 18 Oct 2024 01:11:32 -0700 (PDT)
Received: from zenbook.agu.edu.tr ([95.183.227.33])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-a9a68a8e734sm61129666b.24.2024.10.18.01.11.29
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 18 Oct 2024 01:11:31 -0700 (PDT)
From: Yassine Oudjana <yassine.oudjana@gmail.com>
X-Google-Original-From: Yassine Oudjana <y.oudjana@protonmail.com>
To: Dmitry Torokhov <dmitry.torokhov@gmail.com>,
	Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Sen Chu <sen.chu@mediatek.com>,
	Sean Wang <sean.wang@mediatek.com>,
	Macpaul Lin <macpaul.lin@mediatek.com>,
	Lee Jones <lee@kernel.org>,
	Matthias Brugger <matthias.bgg@gmail.com>,
	AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>,
	Liam Girdwood <lgirdwood@gmail.com>,
	Mark Brown <broonie@kernel.org>,
	jason-ch chen <Jason-ch.Chen@mediatek.com>,
	Chen Zhong <chen.zhong@mediatek.com>,
	Flora Fu <flora.fu@mediatek.com>,
	Alexandre Mergnat <amergnat@baylibre.com>
Cc: Yassine Oudjana <y.oudjana@protonmail.com>,
	Yassine Oudjana <yassine.oudjana@gmail.com>,
	linux-input@vger.kernel.org,
	devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	linux-pm@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org,
	linux-mediatek@lists.infradead.org
Subject: [PATCH 0/6] MediaTek MT6735+MT6328 SoC/PMIC pair base support
Date: Fri, 18 Oct 2024 11:10:42 +0300
Message-ID: <20241018081050.23592-1-y.oudjana@protonmail.com>
X-Mailer: git-send-email 2.47.0
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Yassine Oudjana <y.oudjana@protonmail.com>

These patches are part of a larger effort to support the MT6735 SoC family in
mainline Linux. More patches (unsent or sent and pending review or revision)
can be found here[1].

This series adds base support for the MediaTek MT6735 SoC and MT6328 PMIC pair.
This includes PMIC wrapper support on the SoC side and regulators and keys on
the PMIC side. The PMIC has other blocks such as an audio codec and battery
charger which can be supported in the future.

[1] https://gitlab.com/mt6735-mainline/linux/-/commits/mt6735-staging

Yassine Oudjana (6):
  dt-bindings: mediatek: pwrap: Add MT6735 compatible
  dt-bindings: mfd: mediatek: mt6397: Add bindings for MT6328
  soc: mediatek: pwrap: Add support for MT6735 and MT6328 SoC/PMIC pair
  mfd: mt6397: Add initial support for MT6328
  regulator: Add driver for MediaTek MT6328 PMIC regulators
  Input: mtk-pmic-keys - Add support for MT6328

 .../bindings/input/mediatek,pmic-keys.yaml    |   1 +
 .../bindings/mfd/mediatek,mt6397.yaml         |   2 +
 .../bindings/soc/mediatek/mediatek,pwrap.yaml |   1 +
 drivers/input/keyboard/mtk-pmic-keys.c        |  15 +
 drivers/mfd/mt6397-core.c                     |  32 +
 drivers/mfd/mt6397-irq.c                      |  23 +
 drivers/regulator/Kconfig                     |   9 +
 drivers/regulator/Makefile                    |   1 +
 drivers/regulator/mt6328-regulator.c          | 479 ++++++++++
 drivers/soc/mediatek/mtk-pmic-wrap.c          | 251 +++++-
 include/linux/mfd/mt6328/core.h               |  53 ++
 include/linux/mfd/mt6328/registers.h          | 822 ++++++++++++++++++
 include/linux/mfd/mt6397/core.h               |  11 +-
 include/linux/regulator/mt6328-regulator.h    |  49 ++
 14 files changed, 1741 insertions(+), 8 deletions(-)
 create mode 100644 drivers/regulator/mt6328-regulator.c
 create mode 100644 include/linux/mfd/mt6328/core.h
 create mode 100644 include/linux/mfd/mt6328/registers.h
 create mode 100644 include/linux/regulator/mt6328-regulator.h

-- 
2.47.0


