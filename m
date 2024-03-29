Return-Path: <linux-pm+bounces-5623-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 2FCA78914E8
	for <lists+linux-pm@lfdr.de>; Fri, 29 Mar 2024 08:59:07 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id C54AFB2189F
	for <lists+linux-pm@lfdr.de>; Fri, 29 Mar 2024 07:59:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 297F948792;
	Fri, 29 Mar 2024 07:58:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="BBRezgRH"
X-Original-To: linux-pm@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EF8C242061;
	Fri, 29 Mar 2024 07:58:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711699083; cv=none; b=npzLya764qDk1bivT4a2xN7NGIjSd8bYk3KZsxG2NwzXQVv07A2AOInnQ9abznYMujT7yZohtx9peA4yB+9Za5fO223addB70VAdY+Rrva7XgSIBr0JqRq1AlyGB9+RlwluOxI7Ow/wcmJUoET+5tk/dVj/FUeNGuCHja0tHoU8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711699083; c=relaxed/simple;
	bh=7zbqN1PmApdafn8fGnIdSZWQ0JXrI9ad9f7LLt8QxJg=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=djmfLapsz/adkmheP/eAoy8PdLbzmBTZjtqoBEnswvyGKJJ+XBzE5deTlQkD4VodKEX+chebUORiIkDPzz/lojCO/yMHObjieP42Z5voWLir66EUUtG5v6jZXIoA2FJl1jwIufSPJV+cD9MbmU52UapnXoX+ZLHfNjjN0RrstO8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=BBRezgRH; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 153B6C433B1;
	Fri, 29 Mar 2024 07:57:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1711699082;
	bh=7zbqN1PmApdafn8fGnIdSZWQ0JXrI9ad9f7LLt8QxJg=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=BBRezgRHSoHbJ80y8A7pdHtqE1jZ4t19ISuKnDBe/Th1QptvbVvS7KiQNMFI1eLWl
	 RZ3OB5D0dFQpV4YlSIBkwi7Kx5e45xeSy9fCeJ0/X3qLJZO7uRvcBvh5TQEGchyc2J
	 S76F5S3Wid2nT0n+D535PMjutWm7NPlG4U4fuJWzrQE3vYrf2QRix5w73g0UgHtLO6
	 K6mjBZvoH+jPsxZeUbs7DkPRblCtNd88GTK2qrnrALerfdUvluW01KZzK8Io2+/6Qa
	 QvvdP+XB0l9ay/b7rZDRckDYyUfPoYGEqWRtulimk6v6A7hitrCBHlXCIH57O353XR
	 60bzXLb38DQfQ==
From: Tzung-Bi Shih <tzungbi@kernel.org>
To: bleung@chromium.org,
	groeck@chromium.org,
	linus.walleij@linaro.org,
	brgl@bgdev.pl,
	hverkuil-cisco@xs4all.nl,
	mchehab@kernel.org,
	sre@kernel.org,
	alexandre.belloni@bootlin.com
Cc: tzungbi@kernel.org,
	chrome-platform@lists.linux.dev,
	pmalani@chromium.org,
	linux-gpio@vger.kernel.org,
	linux-media@vger.kernel.org,
	linux-pm@vger.kernel.org,
	linux-rtc@vger.kernel.org,
	krzk@kernel.org
Subject: [PATCH 17/18] platform/chrome: wilco_ec: event: remove redundant MODULE_ALIAS
Date: Fri, 29 Mar 2024 15:56:29 +0800
Message-ID: <20240329075630.2069474-18-tzungbi@kernel.org>
X-Mailer: git-send-email 2.44.0.478.gd926399ef9-goog
In-Reply-To: <20240329075630.2069474-1-tzungbi@kernel.org>
References: <20240329075630.2069474-1-tzungbi@kernel.org>
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

There is no platform driver in the file.  Remove the redundant
MODULE_ALIAS().

Signed-off-by: Tzung-Bi Shih <tzungbi@kernel.org>
---
 drivers/platform/chrome/wilco_ec/event.c | 1 -
 1 file changed, 1 deletion(-)

diff --git a/drivers/platform/chrome/wilco_ec/event.c b/drivers/platform/chrome/wilco_ec/event.c
index 13291fb4214e..49043c644572 100644
--- a/drivers/platform/chrome/wilco_ec/event.c
+++ b/drivers/platform/chrome/wilco_ec/event.c
@@ -575,4 +575,3 @@ module_exit(event_module_exit);
 MODULE_AUTHOR("Nick Crews <ncrews@chromium.org>");
 MODULE_DESCRIPTION("Wilco EC ACPI event driver");
 MODULE_LICENSE("GPL");
-MODULE_ALIAS("platform:" DRV_NAME);
-- 
2.44.0.478.gd926399ef9-goog


