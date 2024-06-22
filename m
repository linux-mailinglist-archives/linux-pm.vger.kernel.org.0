Return-Path: <linux-pm+bounces-9801-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id C517A913275
	for <lists+linux-pm@lfdr.de>; Sat, 22 Jun 2024 09:06:13 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 7BB1F1F223F0
	for <lists+linux-pm@lfdr.de>; Sat, 22 Jun 2024 07:06:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B270414B088;
	Sat, 22 Jun 2024 07:06:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=wanadoo.fr header.i=@wanadoo.fr header.b="XkPfbkA9"
X-Original-To: linux-pm@vger.kernel.org
Received: from smtp.smtpout.orange.fr (smtp-16.smtpout.orange.fr [80.12.242.16])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C0DAE63B9;
	Sat, 22 Jun 2024 07:06:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=80.12.242.16
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719039966; cv=none; b=FYmTBoadoEQ2jeoAgFL4VIbuewsjuWZFCDllSS4+xNNqybxy/Q1G6Y80J8mJBOw9jGklrW6N6W7EZK9JoYMjtI0GMwuhWejxYSkRBya8W8fpTxS9R5PaErj+S3kwrkmJEIDiEJ9koSmxQAlMYJ/qrHBGMMbAC5GKtwQaZ5kQkeo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719039966; c=relaxed/simple;
	bh=rdE3Xv4awGL1VlTda67UdSQaD/vWAZRX4zP4ZOsIxWc=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=hkQiolS7XVGS3vtrQ/uNQkeG/KHALdfvU7Jl0BAqVgG2ay4fa3ZZTfAUwD6rH14Ya+BLmlAFIFqlftgBcnp2mUa90Q0G/Ik8oGNGVbeW5yX+NM0XLFn4cMElqK0vN8xDk/6pTRk1cIezheWHY1hHISw2bCRjRw2jY0NK92VNrjY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=wanadoo.fr; spf=pass smtp.mailfrom=wanadoo.fr; dkim=pass (2048-bit key) header.d=wanadoo.fr header.i=@wanadoo.fr header.b=XkPfbkA9; arc=none smtp.client-ip=80.12.242.16
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=wanadoo.fr
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=wanadoo.fr
Received: from fedora.home ([86.243.222.230])
	by smtp.orange.fr with ESMTPA
	id KuntsjGzHYBZjKuntsnU74; Sat, 22 Jun 2024 09:04:53 +0200
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=wanadoo.fr;
	s=t20230301; t=1719039893;
	bh=9p/NvGXVIGq454IUR23iNKa5i9tD08IILOdEfz3Z4AU=;
	h=From:To:Subject:Date:Message-ID:MIME-Version;
	b=XkPfbkA9aeMYWcYhQlyS9XeZoaldD6fFpSCqfAT12JA4ExRNEQjELwrIqalCO3NBx
	 0pzGE0OhGispf+eM1N62jxwvjw9FXFXe9QvZNg/VesL0fKvfnVFkZfyTDo4JzxulHb
	 /sKEps7UgU6wVdlornsmeKSELNS/Q0s1CcOEB6cb6J7iubfQidZgVBDjGbZTzwmTaE
	 ZOUPbZE+OJ9uyinMzfCF5PvJRoYFGHBdyg7/HC5UF1cV9Zbbt3D7JXda1BCmeIKr9q
	 lCU8E6ilh6UYSd+flBuHvadyUr2HmyG58S3OoEkJua0aYFHOTMA5js/dEpvECTsrK5
	 xmlUVa6V0RaCQ==
X-ME-Helo: fedora.home
X-ME-Auth: Y2hyaXN0b3BoZS5qYWlsbGV0QHdhbmFkb28uZnI=
X-ME-Date: Sat, 22 Jun 2024 09:04:53 +0200
X-ME-IP: 86.243.222.230
From: Christophe JAILLET <christophe.jaillet@wanadoo.fr>
To: linus.walleij@linaro.org,
	sre@kernel.org,
	jic23@kernel.org
Cc: linux-pm@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	kernel-janitors@vger.kernel.org,
	Christophe JAILLET <christophe.jaillet@wanadoo.fr>
Subject: [PATCH 0/3] power: supply: ab8500: Improve code related to iio_read_channel_processed() and fix a bug
Date: Sat, 22 Jun 2024 09:04:23 +0200
Message-ID: <cover.1719037737.git.christophe.jaillet@wanadoo.fr>
X-Mailer: git-send-email 2.45.2
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

This series is inspired by a patch submitted at [1].

While looking if the same pattern was relevant elsewhere, I ended in
ab8500_charger.c.

Patch 1 fixes what looks to me as a regression introduced by
97ab78bac5d0.

Patch 2 is the initial goal of this series. That is to change some
iio_read_channel_processed() + multiplication by a single, cleaner,
iio_read_channel_processed_scale().

Patch 3 is a cosmetic change spotted while at it.


Honestly, I don't have a strong opinion if patch 2 helps in any way
(explanation or confirmation would be appreciated for my own
knowledge), but at least patch 1 deserves a look and seems value to me.

CJ

[1]: https://lore.kernel.org/all/20240620212005.821805-1-sean.anderson@linux.dev/

Christophe JAILLET (3):
  power: supply: ab8500: Fix error handling when calling
    iio_read_channel_processed()
  power: supply: ab8500: Use iio_read_channel_processed_scale()
  power: supply: ab8500: Clean some error messages

 drivers/power/supply/ab8500_charger.c | 52 ++++++++++++++++-----------
 1 file changed, 32 insertions(+), 20 deletions(-)

-- 
2.45.2


