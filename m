Return-Path: <linux-pm+bounces-26623-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 31152AA80F6
	for <lists+linux-pm@lfdr.de>; Sat,  3 May 2025 16:04:41 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id A19761683AB
	for <lists+linux-pm@lfdr.de>; Sat,  3 May 2025 14:04:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 906811E0DEB;
	Sat,  3 May 2025 14:04:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="hwb8pb1K"
X-Original-To: linux-pm@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 687EDEEBB;
	Sat,  3 May 2025 14:04:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746281076; cv=none; b=g50MS906ORHwF6beXxOI9ZXyYz3Iey0blWhg9qKYx1XK9Wng/RuxlxKVroGMSl9DQHjv0qV5y8IV3jIqdgtE7Nmi8lm7/v8r0Kza9H7WyXW4PUJ7+VpqEoI0VAp1L21nYl5GWxJN550rdrdF2Q3Wv+XOrFXN7PuoC5ykt3coRb8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746281076; c=relaxed/simple;
	bh=LGpoxawfydihDKyci4BWvfYhj1LwcVx7TSv/wKobEhs=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=hXUxKHah/yb6YlUVNul7fn+tghNmi9NzXTxRZ/lQoeezwZeWWu3/iz8tWFYyKQzTNWlrGokwDdrFMC1xKsusVP7mhc438osuaQ4D1UHQSJMaGOu+5kBUrtHFK8+jQeeVgZAsqrY/7PvrahlGuN/lPgF0RiDIPylfTmv8QrW0qq0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=hwb8pb1K; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B37B3C4CEE3;
	Sat,  3 May 2025 14:04:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1746281075;
	bh=LGpoxawfydihDKyci4BWvfYhj1LwcVx7TSv/wKobEhs=;
	h=From:To:Cc:Subject:Date:From;
	b=hwb8pb1KVcDOgZUiniudSiiFrWa4x2nJN7rF8xnD5soxr7coO/WAig/MI4q/vxG+1
	 CZrWvS+f/pKUZs+oWjyP2Y2TNNhkc0GQzRMkjpBuad0MJxfW9sRMrRCxGoRkNTB7B3
	 DYes0gatEDOmCqcxu6eymaXzJNnI9GC3Fs0nR7eXVKSuYJRiIpcDiJuBldKBw1r+3F
	 0EYPrOsbXiArYGAuRXA/+GM1yYRB6dvKjmXOnPQS73yBS7IrCDaT3KeOlo/sJoXE5n
	 vSO3G+D0aEQ9KP4J4WLzC7Md7CKwwNWUjfGOC4NT+mYc7GetAXeKjnBHZ152YiTHKF
	 trIT4GjHFZ5bQ==
From: Arnd Bergmann <arnd@kernel.org>
To: Sebastian Reichel <sre@kernel.org>,
	Svyatoslav Ryhel <clamor95@gmail.com>
Cc: Arnd Bergmann <arnd@arndb.de>,
	"Dr. David Alan Gilbert" <linux@treblig.org>,
	=?UTF-8?q?Thomas=20Wei=C3=9Fschuh?= <linux@weissschuh.net>,
	Dmitry Baryshkov <lumag@kernel.org>,
	Dimitri Fedrau <dima.fedrau@gmail.com>,
	Andreas Kemnade <andreas@kemnade.info>,
	Pengyu Luo <mitltlatltl@gmail.com>,
	linux-pm@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH] power: supply: add EXTCON dependency
Date: Sat,  3 May 2025 16:04:26 +0200
Message-Id: <20250503140431.438727-1-arnd@kernel.org>
X-Mailer: git-send-email 2.39.5
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Arnd Bergmann <arnd@arndb.de>

max8971 is written to work with or without extcon, but it fails
to link when built-in when the extcon subsystem is in a loadable
module:

x86_64-linux-ld: drivers/power/supply/max8971_charger.o: in function `max8971_probe':
max8971_charger.c:(.text+0x2ab): undefined reference to `extcon_find_edev_by_node'

Add the appropriate dependency that allows the working cases but
prevents the link failure.

Fixes: 60cd40eee4f4 ("power: supply: Add support for Maxim MAX8971 charger")
Signed-off-by: Arnd Bergmann <arnd@arndb.de>
---
 drivers/power/supply/Kconfig | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/power/supply/Kconfig b/drivers/power/supply/Kconfig
index 797c8d1b04aa..daab8214e225 100644
--- a/drivers/power/supply/Kconfig
+++ b/drivers/power/supply/Kconfig
@@ -621,6 +621,7 @@ config CHARGER_MAX77976
 config CHARGER_MAX8971
 	tristate "Maxim MAX8971 battery charger driver"
 	depends on I2C
+	depends on EXTCON || !EXTCON
 	select REGMAP_I2C
 	help
 	  The MAX8971 is a compact, high-frequency, high-efficiency switch-mode
-- 
2.39.5


