Return-Path: <linux-pm+bounces-18784-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 9C3799E85A8
	for <lists+linux-pm@lfdr.de>; Sun,  8 Dec 2024 15:59:44 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 4AD4F164C56
	for <lists+linux-pm@lfdr.de>; Sun,  8 Dec 2024 14:59:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 57A6D1537CB;
	Sun,  8 Dec 2024 14:59:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=weissschuh.net header.i=@weissschuh.net header.b="MRH2GOCI"
X-Original-To: linux-pm@vger.kernel.org
Received: from todd.t-8ch.de (todd.t-8ch.de [159.69.126.157])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A1D1214B075;
	Sun,  8 Dec 2024 14:59:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=159.69.126.157
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733669977; cv=none; b=JYf+87NfWLT7m/CzfkKMgGNllE39tW/UiYPMTYeS7qPjzSAol8YFOZYjkf8t23FcIbjKlepxQ8udWxzwXj8YjXJ24h0HfYmtWZRYnR5S0BUSAXEfToA244qUEpBBSDsdNsNRJAKluM4lCKi5MgiUY79gxYGzGfja4EiAEOLk+AA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733669977; c=relaxed/simple;
	bh=hnZUt8jI6i7KYAdP+J1MYleEfsI9apXEkwri5foNRCA=;
	h=From:Subject:Date:Message-Id:MIME-Version:Content-Type:To:Cc; b=DlG7OwpZzBYh9OFyNk7BTd2cgvq8Hp+/BQ3PwGKV5Nd2ZtAQ3MV1ZLM692Mn2BhwGIiRxArPfOOam8ERbk80EqGxufayt5/GMtH6V3I/yG7cSecPTIqUc8+31Fi5bo7kkkF7n2RdOFGdJ/dJR/T1XrEwkyRmWPwQf/mWaZliVrY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=weissschuh.net; spf=pass smtp.mailfrom=weissschuh.net; dkim=pass (1024-bit key) header.d=weissschuh.net header.i=@weissschuh.net header.b=MRH2GOCI; arc=none smtp.client-ip=159.69.126.157
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=weissschuh.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=weissschuh.net
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=weissschuh.net;
	s=mail; t=1733669973;
	bh=hnZUt8jI6i7KYAdP+J1MYleEfsI9apXEkwri5foNRCA=;
	h=From:Subject:Date:To:Cc:From;
	b=MRH2GOCIsAPRwvjnZ7KaYkHs7EIYB9V4Uv3h7nftbiE++o7f9pkdADnTRo6KMslEV
	 3dmxZKlxMdNinQN3h2oq2nuKVlUcAn2IyYBCeSuEF+ugEA8VgSdSYQQi/lYaLdAZAq
	 PPZON5CIYV3Z2Lz/fYRi4vXf+yooT7ViTOFuv4/8=
From: =?utf-8?q?Thomas_Wei=C3=9Fschuh?= <linux@weissschuh.net>
Subject: [PATCH 0/3] power: supply: cros_charge-control: three fixes
Date: Sun, 08 Dec 2024 15:59:25 +0100
Message-Id: <20241208-cros_charge-control-v2-v1-0-8d168d0f08a3@weissschuh.net>
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
X-B4-Tracking: v=1; b=H4sIAE20VWcC/x2MUQqAIBAFrxL7nZCmH3WViAjdaiE01pBAuntLP
 w+GYV6FjEyYYWwqMBbKlKKAbhvwxxp3VBSEwXTGahnlOeVFFIvyKd6cTlWMCto5PdjN9Z0FiS/
 GjZ7/eJrf9wPN/87LaAAAAA==
X-Change-ID: 20241202-cros_charge-control-v2-d155194f5304
To: =?utf-8?q?Thomas_Wei=C3=9Fschuh?= <thomas@weissschuh.net>, 
 Benson Leung <bleung@chromium.org>, Guenter Roeck <groeck@chromium.org>, 
 Sebastian Reichel <sre@kernel.org>, Tzung-Bi Shih <tzungbi@kernel.org>
Cc: Thomas Koch <linrunner@gmx.net>, 
 Sebastian Reichel <sebastian.reichel@collabora.com>, 
 chrome-platform@lists.linux.dev, linux-pm@vger.kernel.org, 
 linux-kernel@vger.kernel.org, 
 =?utf-8?q?Thomas_Wei=C3=9Fschuh?= <linux@weissschuh.net>, 
 stable@vger.kernel.org
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=ed25519-sha256; t=1733669972; l=860;
 i=linux@weissschuh.net; s=20221212; h=from:subject:message-id;
 bh=hnZUt8jI6i7KYAdP+J1MYleEfsI9apXEkwri5foNRCA=;
 b=J9bsBMBH9PRZYIFWU7n83aOZX2hgtjnfU0ere+oIQJArgusUYF+HGO/POZmaz5nYmmLy3kWUQ
 8cXcJVhB7efCHPC/cTJANl8ooAcUBMnZD/gPv8Falq2YObfgsnrJXTh
X-Developer-Key: i=linux@weissschuh.net; a=ed25519;
 pk=KcycQgFPX2wGR5azS7RhpBqedglOZVgRPfdFSPB1LNw=

Three fixes I'd like to get into stable.
These conflict with my psy extensions series [0],
I'd like to apply the fixes first.

[0] https://lore.kernel.org/lkml/20241205-power-supply-extensions-v5-0-f0f996db4347@weissschuh.net/

Signed-off-by: Thomas Weißschuh <linux@weissschuh.net>
---
Thomas Weißschuh (3):
      power: supply: cros_charge-control: add mutex for driver data
      power: supply: cros_charge-control: allow start_threshold == end_threshold
      power: supply: cros_charge-control: hide start threshold on v2 cmd

 drivers/power/supply/cros_charge-control.c | 36 ++++++++++++++++++++++--------
 1 file changed, 27 insertions(+), 9 deletions(-)
---
base-commit: 7503345ac5f5e82fd9a36d6e6b447c016376403a
change-id: 20241202-cros_charge-control-v2-d155194f5304

Best regards,
-- 
Thomas Weißschuh <linux@weissschuh.net>


