Return-Path: <linux-pm+bounces-16254-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 14A9E9AB61A
	for <lists+linux-pm@lfdr.de>; Tue, 22 Oct 2024 20:46:35 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 43F711C23C9F
	for <lists+linux-pm@lfdr.de>; Tue, 22 Oct 2024 18:46:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 02E711C1AD0;
	Tue, 22 Oct 2024 18:46:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="GCUkyO7w"
X-Original-To: linux-pm@vger.kernel.org
Received: from mail-wm1-f53.google.com (mail-wm1-f53.google.com [209.85.128.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 517A212B93;
	Tue, 22 Oct 2024 18:46:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729622789; cv=none; b=jK7f8ZhHJ7EPJ/NRBpOUHZ4f2WOUOK1ObY9cm+NkOIj9I5pcDzwqD83k/JLU1DTYxQ+EvktyQ3PkaZf9IQ7+5cwIoAGmREY0Y8ONx4motd1qfYZmQ1dIyaYQCO0clCLsqUu4lFQVOoFxfkA1rOwrDUaKKeHyOi7Vq83oCKBvRG0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729622789; c=relaxed/simple;
	bh=T/vFPOoiPY/UawWJJy0D0WBXjGtVYby2bTN8zCZ6MnY=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version:Content-Type; b=Z3PZddExUShuiumBihAuEEuaEj3BVt0DHnZyGkX7kAHV8HmFch8FO5ByuVTQaMZGUtphPsGfPihGruVEafN+itqWAJ1+7fgCJZQhz+JfjcXv4Y0uazip1Thw6wcRgrRZorQ3MIAFgx0L7qrC7S5lxrDeDX2rj3y9cYCI+fe7noA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=GCUkyO7w; arc=none smtp.client-ip=209.85.128.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f53.google.com with SMTP id 5b1f17b1804b1-431548bd1b4so58603645e9.3;
        Tue, 22 Oct 2024 11:46:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1729622784; x=1730227584; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=LDGG+ZQDHae1HZSzt9Uce9kPw28gcxjgHu8jDN2YlGk=;
        b=GCUkyO7winUcCaq+eXZE3RchOGwUKm7Vej9Rnbq3UKKP3XmvCZPPjwmJyFNpS00EpQ
         9hlGGgawstmMziVZnSf0/LW235vJHND4BuA9josjMhs8moAEQf5afPa/w3Op1bOtINFI
         Bemk8oLtWEf4//BZFK4kZaJmE+4ELgKLlBr6Cug67OlO71NIcmcnU7alSeNjssUPoijj
         Cwz2jL21ZE1csdjSYcgQBsCLukY2pjGtZpRFdc0il3jzJf89R2Cy40Ey5v61u7lomSUO
         gpN6EkC1dTqTv+71juAcpgD5fX+17oRvoJwITqgMkCt4JZLV1abU6/qgrJxKWlK7uamt
         2XQA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1729622784; x=1730227584;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=LDGG+ZQDHae1HZSzt9Uce9kPw28gcxjgHu8jDN2YlGk=;
        b=jGEE9ih/7jpEzUcEwa5h2ih+K8TiBevYn5pUWiHF44jSjTLwl/yWi+Nu3aniFV5+9S
         BIxiY57c/oKXV045Gd/HqUJSgs3Y82xEDLqvQzuoMR/iy2//hxvrx/i6xm701A0Bf47H
         WBScMKrPc9sGzaQ92wnFKc/Ld8tk9gNWDlDIffToB6MUpgVOcj2W4c3FAGo0Iq8ieqad
         hZnbNtB8F0Z/pbMrVi3qGEO0noGjr6Kc08EqyIpDnZDjkgJMudMb53u+EZQq87BB2ITp
         SevAJbEqIewHFfGmo+Y53jwtBtom5+5aYN/PGy4nh8Cv+ZQUxCH5xxrODnq9QVRZRQQc
         uP+Q==
X-Forwarded-Encrypted: i=1; AJvYcCWB3y5nn4g/vnYOMI+Rqv2uS+/4GL1sDzvPVu9dujWykPl1sDuZIG4UitO5RDhxcMjGwNk71p7GQZL2oNc=@vger.kernel.org, AJvYcCXxpzL9vTY9Mtkr6wXa3BFIW9rkuIFzE22/4/kfEwiUoKCcEmGZqgv82C2M11B4AZF0mqMPXmBf8fI=@vger.kernel.org
X-Gm-Message-State: AOJu0YzRONxKwNigqPwqsYIqApyRdy+oyPp76lODELcZ3fM1xw9KPK/L
	rtNZWatvRt1j5cdGm32UiPnwUfO4WJyYhiUD+uBlyVllD6wDr6pz
X-Google-Smtp-Source: AGHT+IEGXgbWX9U0AaFuIJK13HFQXcaZ0nVPPJpIO1kzCYISrLnldzSg9tfWBna4Q2QBXEmg4Tk30A==
X-Received: by 2002:a05:600c:1d22:b0:431:52a3:d9ea with SMTP id 5b1f17b1804b1-4318414298cmr1579635e9.0.1729622784314;
        Tue, 22 Oct 2024 11:46:24 -0700 (PDT)
Received: from localhost ([194.120.133.34])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4316f5c3140sm95635775e9.37.2024.10.22.11.46.23
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 22 Oct 2024 11:46:23 -0700 (PDT)
From: Colin Ian King <colin.i.king@gmail.com>
To: "Rafael J . Wysocki" <rafael@kernel.org>,
	Daniel Lezcano <daniel.lezcano@linaro.org>,
	Zhang Rui <rui.zhang@intel.com>,
	Lukasz Luba <lukasz.luba@arm.com>,
	Matthias Brugger <matthias.bgg@gmail.com>,
	AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>,
	Nicolas Pitre <npitre@baylibre.com>,
	linux-pm@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org
Cc: kernel-janitors@vger.kernel.org,
	linux-mediatek@lists.infradead.org
Subject: [PATCH][next] thermal/drivers/mediatek/lvts_thermal: make read-only arrays static const
Date: Tue, 22 Oct 2024 19:46:22 +0100
Message-Id: <20241022184622.1296044-1-colin.i.king@gmail.com>
X-Mailer: git-send-email 2.39.5
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit

Don't populate the read-only arrays on the stack at run time, instead
make them static const.

Signed-off-by: Colin Ian King <colin.i.king@gmail.com>
---
 drivers/thermal/mediatek/lvts_thermal.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/thermal/mediatek/lvts_thermal.c b/drivers/thermal/mediatek/lvts_thermal.c
index 1997e91bb3be..ce223bab6b55 100644
--- a/drivers/thermal/mediatek/lvts_thermal.c
+++ b/drivers/thermal/mediatek/lvts_thermal.c
@@ -329,7 +329,7 @@ static int lvts_get_temp(struct thermal_zone_device *tz, int *temp)
 
 static void lvts_update_irq_mask(struct lvts_ctrl *lvts_ctrl)
 {
-	u32 masks[] = {
+	static const u32 masks[] = {
 		LVTS_MONINT_OFFSET_SENSOR0,
 		LVTS_MONINT_OFFSET_SENSOR1,
 		LVTS_MONINT_OFFSET_SENSOR2,
@@ -424,7 +424,7 @@ static irqreturn_t lvts_ctrl_irq_handler(struct lvts_ctrl *lvts_ctrl)
 {
 	irqreturn_t iret = IRQ_NONE;
 	u32 value;
-	u32 masks[] = {
+	static const u32 masks[] = {
 		LVTS_INT_SENSOR0,
 		LVTS_INT_SENSOR1,
 		LVTS_INT_SENSOR2,
-- 
2.39.5


