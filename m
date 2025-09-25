Return-Path: <linux-pm+bounces-35377-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id D8A2EBA0069
	for <lists+linux-pm@lfdr.de>; Thu, 25 Sep 2025 16:32:48 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id AADAE171192
	for <lists+linux-pm@lfdr.de>; Thu, 25 Sep 2025 14:31:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 62DFC2D9EDA;
	Thu, 25 Sep 2025 14:31:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=collabora.com header.i=@collabora.com header.b="XaoyWfbb"
X-Original-To: linux-pm@vger.kernel.org
Received: from bali.collaboradmins.com (bali.collaboradmins.com [148.251.105.195])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4751B2C17B2;
	Thu, 25 Sep 2025 14:31:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.251.105.195
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758810693; cv=none; b=rO3kFrFvIRu0TcNH2AN4ujF+zkRSqIayHVu6iJXSz66yqsZCo40v/dCBYtPr6qt6JL/fT8YIrZn8QOkNynplwt8NB1i38qTcYq7Z2OQbJbdGxLKiLUSGPNzDnm0CImv2cQ85UXCsTGhBPRiN4iumNU5IAe1LAQGtTO9i8UBXauU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758810693; c=relaxed/simple;
	bh=oZpdziF4+X8prnKIEf9KWYpfYHcE/0mFo9ZuSHU8tuE=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=HLhBL7Rem+msvrja1WnNy723yOXMoY1gUm3hPwSSbZmvZWUyuhFvfV+GgHvZBLYp/SK+6AcPNYqr9kYkeKtfv+C+IotFt6THs78iwUFxOHznphqQepx01uhFHUCkzWCicf0wG5NB/t0So550JAtuvdvcf+u0MHZFISRcE4XyuVo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=collabora.com; spf=pass smtp.mailfrom=collabora.com; dkim=pass (2048-bit key) header.d=collabora.com header.i=@collabora.com header.b=XaoyWfbb; arc=none smtp.client-ip=148.251.105.195
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=collabora.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=collabora.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
	s=mail; t=1758810689;
	bh=oZpdziF4+X8prnKIEf9KWYpfYHcE/0mFo9ZuSHU8tuE=;
	h=From:To:Cc:Subject:Date:From;
	b=XaoyWfbb9lkk6pJSR6AcsgrqMftwa8VodFduageFkeZF1KrzKuav19tCrmXFokXnY
	 nx5wBL2nsrERzEdEL5reLJmz1oqwCZqj4e1Mn869sV3TbrbRNCWH2JwetV4nxxVdYG
	 qBH4gF5kL/p/cD5hd9Yjq4+xdHmmhiVS7UIU6xqblbRDZpUnsKkU1ykoXTp6Fs+2Yf
	 SG45njJbOA+rRP8NRRkMjnHsQdbzzDbo+YupKlrcH3PKkpA4BOfDD9ru1YDb/Rw8PY
	 BVHs5mrKddymwCYEcojI1ljTMUgifd4rrQPYE/zle7ET9smEfAc0hxJNieHfJgy0NE
	 fbTuUMpY3yvOQ==
Received: from IcarusMOD.eternityproject.eu (2-237-20-237.ip236.fastwebnet.it [2.237.20.237])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	(Authenticated sender: kholk11)
	by bali.collaboradmins.com (Postfix) with ESMTPSA id B455617E0EB8;
	Thu, 25 Sep 2025 16:31:28 +0200 (CEST)
From: AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>
To: ulf.hansson@linaro.org
Cc: robh@kernel.org,
	krzk+dt@kernel.org,
	conor+dt@kernel.org,
	matthias.bgg@gmail.com,
	angelogioacchino.delregno@collabora.com,
	nfraprado@collabora.com,
	fshao@chromium.org,
	y.oudjana@protonmail.com,
	wenst@chromium.org,
	mandyjh.liu@mediatek.com,
	mbrugger@suse.com,
	devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	linux-pm@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org,
	linux-mediatek@lists.infradead.org,
	kernel@collabora.com
Subject: [PATCH v2 0/5] pmdomain: mediatek: Add HWVoter and MT8196 Support
Date: Thu, 25 Sep 2025 16:31:11 +0200
Message-ID: <20250925143122.39796-1-angelogioacchino.delregno@collabora.com>
X-Mailer: git-send-email 2.51.0
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The initial series [1] was refactoring the bus protection regmap retrieval,
adding modem power sequences and support for the RTFF hardware found in newer
generation MediaTek SoCs - and adding support for Hardware Voter, HWCCF Infra
power on, and MT8196 domains.

That series was doing a bit too much in one shot, and then a discussion about
the whole Hardware Voter started, so I decided to split that in two parts:
one dedicated only to the refactoring, modem and RTFF [2], and one that only
introduces MT8196-specific parts.

Since the refactoring series [2] was merged upstream and the Hardware Voter
discussion came to an agreement on how to proceed (resulting in all of the
MT8196 clock drivers being also merged upstream), it is now time to send
the final piece of the Power Domains (MTCMOS) support for the MediaTek
Kompanio Ultra (MT8196) SoC.

So - this series finally adds support for handling the Hardware Voter type
of power domains in the MT8196 SoC, for secure infracfg power control, and
for all of the power domains found in the MT8196 SoC - using all of the
newly introduced support (HWV, RTFF, etc).

This series was tested on multiple MT8196 Chromebooks now for more than 3
months, and works just great; the last test was performed on the Collabora
MediaTek integration kernel tree based on next-20250909.

P.S.: This is a v2 because the initial series ([1] v1) contained patches
      that I am sending in this series.

[1]: https://lore.kernel.org/all/20250623120154.109429-1-angelogioacchino.delregno@collabora.com/
[2]: https://lore.kernel.org/all/CAPDyKFoe9=4KgOsPUX6FOE+yPxdUqAxRec5yKY2h6uFOeUvvDQ@mail.gmail.com/

AngeloGioacchino Del Regno (5):
  dt-bindings: power: Add support for MT8196 power controllers
  pmdomain: mediatek: Add support for Hardware Voter power domains
  pmdomain: mediatek: Add support for secure HWCCF infra power on
  pmdomain: mediatek: Add support for MT8196 SCPSYS power domains
  pmdomain: mediatek: Add support for MT8196 HFRPSYS power domains

 .../power/mediatek,power-controller.yaml      |   4 +
 drivers/pmdomain/mediatek/mt8196-pm-domains.h | 625 ++++++++++++++++++
 drivers/pmdomain/mediatek/mtk-pm-domains.c    | 305 ++++++++-
 drivers/pmdomain/mediatek/mtk-pm-domains.h    |  49 +-
 .../dt-bindings/power/mediatek,mt8196-power.h |  58 ++
 5 files changed, 1012 insertions(+), 29 deletions(-)
 create mode 100644 drivers/pmdomain/mediatek/mt8196-pm-domains.h
 create mode 100644 include/dt-bindings/power/mediatek,mt8196-power.h

-- 
2.51.0


