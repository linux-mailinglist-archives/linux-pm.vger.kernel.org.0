Return-Path: <linux-pm+bounces-6129-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 20C9D89E699
	for <lists+linux-pm@lfdr.de>; Wed, 10 Apr 2024 02:07:43 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 52EE31C2117C
	for <lists+linux-pm@lfdr.de>; Wed, 10 Apr 2024 00:07:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DFCBB39B;
	Wed, 10 Apr 2024 00:07:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="gKMBP5R0"
X-Original-To: linux-pm@vger.kernel.org
Received: from mail-pl1-f173.google.com (mail-pl1-f173.google.com [209.85.214.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6481E7F
	for <linux-pm@vger.kernel.org>; Wed, 10 Apr 2024 00:07:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712707658; cv=none; b=pcVhemHNzr9Dh99BT2RGtPxX4FIhsldy/ZArY1RmNlLG8Csw7PI5Bn0ZJvKUgPaIqKl2iG1cdBIT2l2RdIMC2oXdIsTkMNGin4O7k+MFPREEAYVkmDVbPolkKy3jEJfTB8MQC2AS4HbgkBqEG6yYwp4jkK8VX4+3K+iB0MCnOPs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712707658; c=relaxed/simple;
	bh=44uw6vfVpAG554ds00c5KN20s6e5bH0vd+t3oNPky6k=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version:Content-Type; b=rb5VgRk5vx6LgTlp1C+0wn6MCxtHd+ko0vqNJxM8hY0B0TR+beHzPdqIIhPqJ4qetOqdZir9gCE8pIUqANpCakMlfCMel+rBGB9rK7FKI2NKroQ3dz49/O/OkURljV6HTU3rQVcagRcO6O+1TCbVU6B+s8LDYSW/BewXfI4jaZo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org; spf=pass smtp.mailfrom=chromium.org; dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b=gKMBP5R0; arc=none smtp.client-ip=209.85.214.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=chromium.org
Received: by mail-pl1-f173.google.com with SMTP id d9443c01a7336-1e3c7549078so27915045ad.0
        for <linux-pm@vger.kernel.org>; Tue, 09 Apr 2024 17:07:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1712707657; x=1713312457; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=7ryIE7f8ZtWuzluYZgPcDX89WKZsm70yqAukGanFYfc=;
        b=gKMBP5R0ip9cRqnivqR0jDYl5wyUfS2zeo+3nCXlGR+wO7g4+oZ7WJ+eVWSifB/dG3
         TUlzAK2lO7ZVdhOgh1CxIUPgvLnI3Qg54wcVoD/17kxsbKjdy1od0wMJNF197TJkXkfP
         DXfUpvIGwzqZWR8cb4ReMNH4qLkgOpnAMVZdk=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1712707657; x=1713312457;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=7ryIE7f8ZtWuzluYZgPcDX89WKZsm70yqAukGanFYfc=;
        b=NzbSDL1Fem/y5Ic1K789uKF6sEbaN6XduvVCnde1tQERLTrGIyTOgRnDoFGNQkRdd7
         FmTcB6ZyGXjTbHC1QDjB9DpC+zQy+JxKZ5xYmuXR8xLGwrDdwQ3BtR5kJOvjS5EprCez
         oSh0pbNGGCAwYWIO4vNUHMykKSSXbr6ZE/2qQb5Gx26Weaz3lldoLjIIvjxLPOKWM17V
         NiSpJm0XLp/qE8h15C4sJio8hkuyPdHHItYoCmOVVsZXog4QDDWfXnv5VAU+VKRFZ/k9
         gPi2ELVgJHwHCdB0IU1aCNh24YE17bw93lhvVhjUb56LSAJlu3PGn/XnpvbdMMjcWXb4
         SNwA==
X-Forwarded-Encrypted: i=1; AJvYcCUT1E9mqjzyt3d8ThKWQzWBiBzrfDCp9i0AauKcv0jYtPIURlhLvle+Km8cG2g0cwS9H51lLtxRb2up3J63dbRN1ultCr6rWEI=
X-Gm-Message-State: AOJu0YzvN/nTq7xGDTZ9Ji+kG+ysz4VZ8/j51rt+Aa03Z2Ztgq8bKtQJ
	F0oGUyU/meXZ+D1QtVrGhFHRTY1MfoNJrGLQmDjA64dMbaODDmlIRt38HQU6vg==
X-Google-Smtp-Source: AGHT+IGoDhFHXggG7UV/XM8syPMLRIRAsx+Q3uuIedkhsyiKSu/gHHPrWq5HHr51Yh0dVfPQfUt54g==
X-Received: by 2002:a17:902:a3c5:b0:1e4:39e0:660c with SMTP id q5-20020a170902a3c500b001e439e0660cmr5048130plb.23.1712707656662;
        Tue, 09 Apr 2024 17:07:36 -0700 (PDT)
Received: from treapking.tpe.corp.google.com ([2401:fa00:1:10:1f93:f735:b4fc:3be2])
        by smtp.gmail.com with ESMTPSA id kn12-20020a170903078c00b001e0c91d448fsm9504939plb.112.2024.04.09.17.07.33
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 09 Apr 2024 17:07:36 -0700 (PDT)
From: Pin-yen Lin <treapking@chromium.org>
To: Daniel Lezcano <daniel.lezcano@linaro.org>,
	"Rafael J . Wysocki" <rafael@kernel.org>,
	Zhang Rui <rui.zhang@intel.com>,
	Lukasz Luba <lukasz.luba@arm.com>,
	Matthias Brugger <matthias.bgg@gmail.com>,
	AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>
Cc: linux-arm-kernel@lists.infradead.org,
	Alexandre Mergnat <amergnat@baylibre.com>,
	linux-kernel@vger.kernel.org,
	linux-mediatek@lists.infradead.org,
	=?UTF-8?q?N=C3=ADcolas=20F=20=2E=20R=20=2E=20A=20=2E=20Prado?= <nfraprado@collabora.com>,
	Minjie Du <duminjie@vivo.com>,
	linux-pm@vger.kernel.org,
	Frank Wunderlich <frank-w@public-files.de>,
	Balsam CHIHI <bchihi@baylibre.com>,
	Pin-yen Lin <treapking@chromium.org>
Subject: [PATCH] thermal/drivers/mediatek/lvts_thermal: Remove redundant code in lvts_ctrl_configure
Date: Wed, 10 Apr 2024 08:07:28 +0800
Message-ID: <20240410000730.628043-1-treapking@chromium.org>
X-Mailer: git-send-email 2.44.0.478.gd926399ef9-goog
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

The removed variable assignment is never written to the register, so it
has no effect on the device behavior.  Mediatek has confirmed that it
is not required to initialize this register for current platforms, so
remove this segment to avoid confusion.

Signed-off-by: Pin-yen Lin <treapking@chromium.org>

---

 drivers/thermal/mediatek/lvts_thermal.c | 6 ------
 1 file changed, 6 deletions(-)

diff --git a/drivers/thermal/mediatek/lvts_thermal.c b/drivers/thermal/mediatek/lvts_thermal.c
index fd4bd650c77a..48d2f8ba3f18 100644
--- a/drivers/thermal/mediatek/lvts_thermal.c
+++ b/drivers/thermal/mediatek/lvts_thermal.c
@@ -985,12 +985,6 @@ static int lvts_ctrl_configure(struct device *dev, struct lvts_ctrl *lvts_ctrl)
 	value = LVTS_TSSEL_CONF;
 	writel(value, LVTS_TSSEL(lvts_ctrl->base));
 
-	/*
-	 * LVTS_CALSCALE : ADC voltage round
-	 */
-	value = 0x300;
-	value = LVTS_CALSCALE_CONF;
-
 	/*
 	 * LVTS_MSRCTL0 : Sensor filtering strategy
 	 *
-- 
2.44.0.478.gd926399ef9-goog


