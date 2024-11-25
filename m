Return-Path: <linux-pm+bounces-18092-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 641C89D895E
	for <lists+linux-pm@lfdr.de>; Mon, 25 Nov 2024 16:30:09 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 054A0164E23
	for <lists+linux-pm@lfdr.de>; Mon, 25 Nov 2024 15:30:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0CBC31B3952;
	Mon, 25 Nov 2024 15:30:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="jQxY/GS0"
X-Original-To: linux-pm@vger.kernel.org
Received: from mail-wr1-f43.google.com (mail-wr1-f43.google.com [209.85.221.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 54CEC1B3958;
	Mon, 25 Nov 2024 15:30:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732548605; cv=none; b=kdPWvZE+U4IY0ztk9YkT/2Z/Mz+hth4NpMVZ5vXJ1Id5zFD2sZsxSTgB/IiyET739vybca3War41M15v4TGDp7boeWQZIkaSTYGn6FdlktN4dmgCnmp5q+pHiata3RIfPwYxLTqAtz1Z08GZW/uhLcIb6IXURjCTFQx/F5Tigto=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732548605; c=relaxed/simple;
	bh=ZuOlKDa12lf4PipoKK/WoVow7PE0n9hSDEKjxKpU14k=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=NyfN0B/gmS8u2xN8yZ9JZBDGKncsLmoX3WGzctDNXDCVBYbj2Gj0402xAUB5naWHmBH6/uamlhJQEPYk166MFbafJTpCmz+iAIAognr98vaLMwePReZWOclEGVxNuZ/GFgIUEMLfGQhWExEZHn8MFEuHzeakYk7WdseAsG/d5Js=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=jQxY/GS0; arc=none smtp.client-ip=209.85.221.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wr1-f43.google.com with SMTP id ffacd0b85a97d-3823e45339bso3428435f8f.0;
        Mon, 25 Nov 2024 07:30:04 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1732548603; x=1733153403; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=R0xbIeLjaOcvNQ+T0CeTy2I+8N/GlAJgLra/IyL1M5o=;
        b=jQxY/GS0PnTDMce/5ttdLitViGJdOKFeoOtjgFx+DD+NfEjpE9qYChA4UrEa+ZgpHe
         UgXQ7+vwFTM8bN8j/zVYR0rTBjSli5tduXNH7md3iSm5HWL4BazPC4X+m2VgQqrt9G7N
         8Zg7lK56Ku9ElXRfw+PyA2nVauYqbMmWkcyiHv+Al5rFRG1Ff73hQ6P7acPfIdg5dIwi
         M22SCLEOq0YZwA0AujbxgBdFmEI50EOfI3T5l67aUsezLGXxCijSSgReO6NqEwkUKJ/9
         JDU474U0EcBqtRNoMUj7rVaQ3c8wqZAOPPqK9Int7eNOflumFtVNRAmHcUW3uHPF6lsr
         PR9w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1732548603; x=1733153403;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=R0xbIeLjaOcvNQ+T0CeTy2I+8N/GlAJgLra/IyL1M5o=;
        b=TNP8Hzv/Kuer8Xn63rUKCwB9PY91YGVVvYFAtPfTDEkfubkScMdG8bI6old2BrLWMO
         t7dPGdwwKZuPYuLEIImRKH4vKjB82EydVuVlPVLg9UBhEYnqvjPqAniIvqkQ7bXKxyr/
         OI3HKz0b0f7SyDUf/90ThqOeIURcRm/b2Gy+KLiWGP1IHzpfG/nbIcNvap1pddIBos/3
         gFSJ07iLXr6f7umifagxqYiF6NZnUKFZldfyJ2Z4LUKasV4bsucMI+En6IiPUx2oTfa3
         6gpJgoq1/lC+5Xswhr2xjIcj465k7YyN2JgypXGu+FC+I4Y7jKC6psm4gZ7/gTHxgt94
         ewLg==
X-Forwarded-Encrypted: i=1; AJvYcCUrNemZEdm6dOYvlzADNO2aurJLI3f3toEmp27y4cTN3JqiIeLwYGzvh8P8lCaMDYmmPMdcKMTcToIdin0=@vger.kernel.org
X-Gm-Message-State: AOJu0YzIvQhcWUhAH7nw6Bpp+3bFyXDrefAhTdswoplHuwRHABS0HJOp
	VxAVgI5363T4smDu8ug03vbqe3Ho7QcVteHpPDWflOWIM7ABLCDPRsS5wgqAQXI=
X-Gm-Gg: ASbGncsISQszFWfLoyFRJgit4Af94EoECBtUXPwTYtDRQPcPUonj4Vh+3yMVONnfDQS
	6MdAflIw0zaog2rIoyGLfHLri+bKOCEK4ou+/IpY3fKol2EPrbTXQ8aJD/n5V+f8f+TIxpRHO/N
	woUzqGNTHezPl6MyBd7b76n0b9DPKTLpsv/ValAWIT38O/4CN2y5E77cKuDdQub8hUfk5UdpS4Z
	0Vf7GIRlSkw3fUrlGsuFCE6DPhp+DBlhDs3Cz8YrkoLEJAmfQ==
X-Google-Smtp-Source: AGHT+IFt32g14UZEVcid0Amb4JFft82ihixw77BhJMGM25/YsTHovebIT4JACNL3OiATfH6WP+Ec7g==
X-Received: by 2002:a05:6000:1f8c:b0:382:424b:d0a6 with SMTP id ffacd0b85a97d-38260be2ea2mr10932384f8f.55.1732548602470;
        Mon, 25 Nov 2024 07:30:02 -0800 (PST)
Received: from tpt440p.. ([69.63.64.50])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-3825fb264cdsm10836888f8f.49.2024.11.25.07.29.59
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 25 Nov 2024 07:30:02 -0800 (PST)
From: "Sicelo A. Mhlongo" <absicsz@gmail.com>
To: linux-pm@vger.kernel.org
Cc: pali@kernel.org,
	sre@kernel.org,
	linux-kernel@vger.kernel.org,
	maemo-leste@lists.dyne.org,
	"Sicelo A. Mhlongo" <absicsz@gmail.com>
Subject: [PATCH] power: supply: bq27xxx_battery: do not update cached flags prematurely
Date: Mon, 25 Nov 2024 17:29:30 +0200
Message-ID: <20241125152945.47937-1-absicsz@gmail.com>
X-Mailer: git-send-email 2.45.2
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Commit 243f8ffc883a1 ("power: supply: bq27xxx_battery: Notify also about
status changes") intended to notify userspace when the status changes,
based on the flags register. However, the cached state is updated too
early, before the flags are tested for any changes. Remove the premature
update.

Fixes: 243f8ffc883a1 ("power: supply: bq27xxx_battery: Notify also about status changes")
Signed-off-by: Sicelo A. Mhlongo <absicsz@gmail.com>
---
 drivers/power/supply/bq27xxx_battery.c | 1 -
 1 file changed, 1 deletion(-)

diff --git a/drivers/power/supply/bq27xxx_battery.c b/drivers/power/supply/bq27xxx_battery.c
index 40c5ac7a1118..b2c65fe43d5c 100644
--- a/drivers/power/supply/bq27xxx_battery.c
+++ b/drivers/power/supply/bq27xxx_battery.c
@@ -1913,7 +1913,6 @@ static void bq27xxx_battery_update_unlocked(struct bq27xxx_device_info *di)
 		cache.flags = -1; /* read error */
 	if (cache.flags >= 0) {
 		cache.capacity = bq27xxx_battery_read_soc(di);
-		di->cache.flags = cache.flags;
 
 		/*
 		 * On gauges with signed current reporting the current must be
-- 
2.45.2


