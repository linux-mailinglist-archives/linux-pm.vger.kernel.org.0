Return-Path: <linux-pm+bounces-6793-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id BAAD18ACBAE
	for <lists+linux-pm@lfdr.de>; Mon, 22 Apr 2024 13:11:35 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 4CA50B24077
	for <lists+linux-pm@lfdr.de>; Mon, 22 Apr 2024 11:11:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1CBCD146581;
	Mon, 22 Apr 2024 11:11:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=tuxon.dev header.i=@tuxon.dev header.b="S8+ExHGE"
X-Original-To: linux-pm@vger.kernel.org
Received: from mail-wm1-f42.google.com (mail-wm1-f42.google.com [209.85.128.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 848E9145FFF
	for <linux-pm@vger.kernel.org>; Mon, 22 Apr 2024 11:11:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713784289; cv=none; b=NurmaahGEKQpUMK/oiyp2Rqp75Cb4Pn4fydr3M58IwVAOQL7l21CjYaqL0xwB9Tn3qs8ssbwjD3+7NaXWJ2OwH88y5SwAjv1uYSplNw5DSSC84sumV/zbqzYUSttDJYMo7cqJ2OJepPUFWHFcYrR5zzbkTKDRD0mkR5V23BkwXE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713784289; c=relaxed/simple;
	bh=zOXyQXhCiCAbqSzm1DmnoLf7s16Jjeeh3sXMykWQ4yA=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=BU8vbWuTg8mbCv6JeHbHhxGPqoUWnBDSW5DF+zVwsFbw6Izusc3BcW+4SWJqAlYdO1UHoc3YRwc9/uPD/mW9vaw+O4w1IN3Jqo85NoMVwzWaUCjzNCjHSzmd9PI4IHyV8HsSgfyic7oKQyctsXpsRndAW5l6uD1C+0ikzF2Ytqw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=tuxon.dev; spf=pass smtp.mailfrom=tuxon.dev; dkim=pass (2048-bit key) header.d=tuxon.dev header.i=@tuxon.dev header.b=S8+ExHGE; arc=none smtp.client-ip=209.85.128.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=tuxon.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=tuxon.dev
Received: by mail-wm1-f42.google.com with SMTP id 5b1f17b1804b1-41a70466b77so3871875e9.0
        for <linux-pm@vger.kernel.org>; Mon, 22 Apr 2024 04:11:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=tuxon.dev; s=google; t=1713784286; x=1714389086; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=61hzISvK/wLrrN6ibfTaJ/oIzNgbxFUNfnYIb6kt4q8=;
        b=S8+ExHGE7UZRml9wIgN7GdoCDFGbOMuYgW30fQxMX7T9XTBMF4mHX+QD01Z3ohorUe
         24/J+cQ0ikD27f716BNNq8vRm6UjEMo7eExWWjop0KXE2ITXdGfjI2LhRN3D9u3fhEO1
         biaFZA5xMkPwHgHKnMIgAhNAawvs56RxUmgkU1odYbdMjp7WRWecgP982PFC4nZI857R
         oqtGEDj2/0GCs5AF7Tgk0dFLsAsP/tx6E6WlSVC7jigB0ObK9IM3sDCRFbW98zyZqbVs
         g24C+u0rPRexxxqyNjLqAEbzNQtxyagSm0P3v1zv319lrhtHL0NRhT0jVqomQqjTkSfv
         kcoA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1713784286; x=1714389086;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=61hzISvK/wLrrN6ibfTaJ/oIzNgbxFUNfnYIb6kt4q8=;
        b=lk3NRzTvCH3y/jsE749v7kxlZzmu4jCAo/qnhp/3FlavJ2ryWaxXLLptcaFp5Czdty
         QTduEEo3BHe3j5NQrSIYGBBYFny6btDytZVt9VuzPYuRywjWjRHsmQrR4+uV4PchEZaM
         K1ikYZ5E7vsIMVzwdGnL1PUdN0BQvczURtGP/s0d7NPBUpJVR4rFOcUsfgdLWb4cg6hP
         KfwD6yF9b7u3FiXlWZUIaeZO9kTHeXdoJ4BE3L35OT+NS2ubf1wpPs2oJENc6sMcBBla
         wZa8MTq2spCsj9PIWt4+H97tCqUL5a15dcW6+HgpEpHMWE2zC6YbSE2oPpEeVSqpCGRh
         dw3w==
X-Forwarded-Encrypted: i=1; AJvYcCUJFC/HnU5ss/hr+CKfr4OXqPhgQlXuja5l/LrrxDcfe76mNOz8C7ninTrr7FxJ9oqxjMV5n7rZSmu+PcvM6x0q6Ceq/Hhr+2E=
X-Gm-Message-State: AOJu0YzenQipvEuox4lyUgAvHIvPQJcMO89zAhxmYJUNMJ8g0zDtXwHx
	uUal5/TRuUuy/Xt/UE9IFaZw4u8krPz4V6GqiNnk6GU/kIH0AKOg4oj03TeTTrI=
X-Google-Smtp-Source: AGHT+IGMfRYSdMcLHCdhxlRSB93POiy1y+u9GQT5dTES5qnzs1ds9F6kAbynLwEbX6sbZ/W6e01cVQ==
X-Received: by 2002:a05:600c:46c8:b0:414:d95:cc47 with SMTP id q8-20020a05600c46c800b004140d95cc47mr9334640wmo.30.1713784285915;
        Mon, 22 Apr 2024 04:11:25 -0700 (PDT)
Received: from claudiu-X670E-Pro-RS.. ([82.78.167.53])
        by smtp.gmail.com with ESMTPSA id r18-20020a05600c35d200b00418d434ae4esm16292565wmq.10.2024.04.22.04.11.24
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 22 Apr 2024 04:11:25 -0700 (PDT)
From: Claudiu <claudiu.beznea@tuxon.dev>
X-Google-Original-From: Claudiu <claudiu.beznea.uj@bp.renesas.com>
To: gregkh@linuxfoundation.org,
	jirislaby@kernel.org,
	geert+renesas@glider.be,
	ulf.hansson@linaro.org
Cc: linux-kernel@vger.kernel.org,
	linux-serial@vger.kernel.org,
	linux-pm@vger.kernel.org,
	claudiu.beznea@tuxon.dev
Subject: [PATCH] serial: sh-sci: Call device_set_wakeup_path() for serial console
Date: Mon, 22 Apr 2024 14:11:23 +0300
Message-Id: <20240422111123.1622967-1-claudiu.beznea.uj@bp.renesas.com>
X-Mailer: git-send-email 2.39.2
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Claudiu Beznea <claudiu.beznea.uj@bp.renesas.com>

In case the SCI is used as a UART console, no_console_suspend is
available in bootargs and SCI is part of a software-controlled power
domain we need to call device_set_wakeup_path(). This lets the power
domain core code knows that this domain should not be powered off
durring system suspend. Otherwise, the SCI power domain is turned off,
nothing is printed while suspending and the suspend/resume process is
blocked. This was detected on the RZ/G3S SoC while adding support
for power domains.

Signed-off-by: Claudiu Beznea <claudiu.beznea.uj@bp.renesas.com>
---
 drivers/tty/serial/sh-sci.c | 6 +++++-
 1 file changed, 5 insertions(+), 1 deletion(-)

diff --git a/drivers/tty/serial/sh-sci.c b/drivers/tty/serial/sh-sci.c
index 97031db26ae4..57a7f18e16e4 100644
--- a/drivers/tty/serial/sh-sci.c
+++ b/drivers/tty/serial/sh-sci.c
@@ -3441,8 +3441,12 @@ static __maybe_unused int sci_suspend(struct device *dev)
 {
 	struct sci_port *sport = dev_get_drvdata(dev);
 
-	if (sport)
+	if (sport) {
+		if (uart_console(&sport->port) && !console_suspend_enabled)
+			device_set_wakeup_path(dev);
+
 		uart_suspend_port(&sci_uart_driver, &sport->port);
+	}
 
 	return 0;
 }
-- 
2.39.2


