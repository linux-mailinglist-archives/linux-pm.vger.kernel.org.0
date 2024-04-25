Return-Path: <linux-pm+bounces-7052-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 8214F8B1B7F
	for <lists+linux-pm@lfdr.de>; Thu, 25 Apr 2024 09:09:54 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 489801F23F37
	for <lists+linux-pm@lfdr.de>; Thu, 25 Apr 2024 07:09:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3324B6A031;
	Thu, 25 Apr 2024 07:09:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=tuxon.dev header.i=@tuxon.dev header.b="Jp78PMpa"
X-Original-To: linux-pm@vger.kernel.org
Received: from mail-wm1-f44.google.com (mail-wm1-f44.google.com [209.85.128.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CC2F717E
	for <linux-pm@vger.kernel.org>; Thu, 25 Apr 2024 07:09:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714028987; cv=none; b=C2q3WkZ84iZa2zi0Zo1aByMWyhrapdxfdFXkgq4PJ/6tXbdKrzEUHf6BlN6GSTcRzCseUt9IuHymV0/41jAZfNcDSm1MRWJNOTMnJKrY/xIEVZlmhBHjrnVVzuY1sFmdUvRbL2540Z4nNBAPQsTB3ufFAPuJHHk+6Lowa2yi0Y4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714028987; c=relaxed/simple;
	bh=i5csNzvKyzY2KMUo9Pio2GiNuzzW6XfxG41GjBSLsac=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=iY807AyTYih0pS1XqpeQjyV+ZYFfM9Uw0nGC8bfks7pGDc2zpiV7RQDCGfwV+Rn/cpogKAgRnYK+ebNRFy/IHlPu2bRaQhxFjxQF6Weuhj73b0Wfp4ykCvUw0K1wz0NTHWIWWqxLypXMVqFSq5mD5ccUfk7224p3eU2Zh+mukMo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=tuxon.dev; spf=pass smtp.mailfrom=tuxon.dev; dkim=pass (2048-bit key) header.d=tuxon.dev header.i=@tuxon.dev header.b=Jp78PMpa; arc=none smtp.client-ip=209.85.128.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=tuxon.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=tuxon.dev
Received: by mail-wm1-f44.google.com with SMTP id 5b1f17b1804b1-41b5dc5e0d6so343625e9.0
        for <linux-pm@vger.kernel.org>; Thu, 25 Apr 2024 00:09:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=tuxon.dev; s=google; t=1714028983; x=1714633783; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=AQYF0WsVGtCo94Lb/d7hDTJ0GE5m3M9fEwjH6JMfTuk=;
        b=Jp78PMpayEci9dugJllY9Tf2BIvaDqxcYGvOCvkWBJ5OQswdbCTymX4MlHzIW408jC
         z/8IQuoEDlI4r+9/Q0khKbxp+6bXstuuMYkLfYklfkMKlFAXcc2Dgmpt/Ijv9ulofyU5
         JmNhXDkW5giZL6W1hlObz42PO5B7WUvv/uG0J4n4TkgEaZFE3Sw4JxS7zryf420ZiAfZ
         Dy8yd8l7H9cT3n9azbK/Y5rIdoMa8xpFCfNSdk4mWR31BNXazzGJSu0w5AlXoBRQsgaN
         A9J9TD6j31fCBhmzPo1dcqd5xYqokn7NHHKMWcX/wPcWgH5MhSvazhu5CVKSRLLB7JXa
         ttRQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1714028983; x=1714633783;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=AQYF0WsVGtCo94Lb/d7hDTJ0GE5m3M9fEwjH6JMfTuk=;
        b=cSDeE/xbvNP4I8d5j4iNEk3yT4zDpYt+dmkP862RectkTx/K+IyMdB9nA0OTYTFf2J
         wdXEcY1Yy+aDXgIJnYUqLh57lfIbPB0eff3MqFWZb3JJ2Wxt4mcjm2YZJO4umnTpONRj
         sa0J0PN9SJueyZ1C+bfz+clDJLCBh91Pg2nR3YTRwij6iZLPS2Sr+mayEX+i4Z7iLFAB
         MPfUukLrAB0/jLCgGtB7wnG6INkwlkfaRDCOvSNNrBp2gZMSJKADMt0lZc5likcczgxJ
         /1NyaGVrRvrYc8OI6Ssh3MFdFeZ0QNH5xHTZL2hIpFPe7p8F9qeeWkchUHVkbGeN/FQj
         7o/A==
X-Forwarded-Encrypted: i=1; AJvYcCWLVFoeULeKWDiN2xslcLVdjY08RqG4rbpGJ+scqpPR9zPx4uQzYTwD5NWAMEQhmma3biSo5DsiTeMS0N9hNreoO4yodx+AP3k=
X-Gm-Message-State: AOJu0YzjUNQAFhIk0QdZ7Ejb3+Di/Qv7vwyhtZdGv2NaasBP/FKsJED/
	ZmaRa6zc7dywZRCV4u1ZgIRBK7MhitCW2yc98AAxJSqO/oRwzsUk4SqIK8AdgX4=
X-Google-Smtp-Source: AGHT+IHJkzXfp5uKvrRKk7fveyZHLxowyJC99U0qlzXF2CleQH23oiAt0ns4de/tUOZmilj4QuBnRw==
X-Received: by 2002:a05:600c:19ca:b0:41a:141c:e199 with SMTP id u10-20020a05600c19ca00b0041a141ce199mr3737837wmq.8.1714028983029;
        Thu, 25 Apr 2024 00:09:43 -0700 (PDT)
Received: from claudiu-X670E-Pro-RS.. ([82.78.167.53])
        by smtp.gmail.com with ESMTPSA id v11-20020a05600c444b00b00418d5b16f85sm26234186wmn.21.2024.04.25.00.09.41
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 25 Apr 2024 00:09:42 -0700 (PDT)
From: Claudiu <claudiu.beznea@tuxon.dev>
X-Google-Original-From: Claudiu <claudiu.beznea.uj@bp.renesas.com>
To: gregkh@linuxfoundation.org,
	jirislaby@kernel.org,
	tony@atomide.com,
	andriy.shevchenko@linux.intel.com,
	l.sanfilippo@kunbus.com,
	tglx@linutronix.de,
	geert+renesas@glider.be,
	ulf.hansson@linaro.org,
	peng.fan@nxp.com
Cc: linux-kernel@vger.kernel.org,
	linux-serial@vger.kernel.org,
	linux-pm@vger.kernel.org,
	claudiu.beznea@tuxon.dev,
	Claudiu Beznea <claudiu.beznea.uj@bp.renesas.com>,
	Geert Uytterhoeven <geert@linux-m68k.org>
Subject: [RFT PATCH v2] serial: core: Call device_set_awake_path() for console port
Date: Thu, 25 Apr 2024 10:09:36 +0300
Message-Id: <20240425070936.547100-1-claudiu.beznea.uj@bp.renesas.com>
X-Mailer: git-send-email 2.39.2
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Claudiu Beznea <claudiu.beznea.uj@bp.renesas.com>

In case the UART port is used as a console, no_console_suspend is
available in bootargs and UART port is part of a software-controlled power
domain we need to call device_set_awake_path(). This lets the power
domain core code know that this domain should not be powered off
during system suspend. Otherwise, the UART port power domain is turned off,
nothing is printed while suspending and the suspend/resume process is
blocked. This was detected on the Renesas RZ/G3S SoC while adding support
for power domains.

Based on code investigation, this issue is present on other SoCs (e.g.,
Renesas R-Mobile A1 [1], IMX8QXP [2]) and different SoCs have particular
implementation to handle it. Due to this the patch added the call of
device_set_awake_path() in uart_suspend_port() instead of having it in
the platform specific UART driver.

[1] https://elixir.bootlin.com/linux/v6.9-rc5/source/drivers/pmdomain/renesas/rmobile-sysc.c#L116
[2] https://elixir.bootlin.com/linux/v6.9-rc5/source/drivers/pmdomain/imx/scu-pd.c#L357

Suggested-by: Ulf Hansson <ulf.hansson@linaro.org>
Suggested-by: Geert Uytterhoeven <geert@linux-m68k.org>
Signed-off-by: Claudiu Beznea <claudiu.beznea.uj@bp.renesas.com>
---

Changes in v2:
- used device_set_awake_path() instead of device_set_wakeup_path()
- moved the support in uart_suspend_port() to make it generic for
  other drivers
- fixed typos in commit description
- updated the commit description to reflect the new changes and the fact
  that support may be applied to other SoCs
- added Suggested-by tag; this was initially proposed by Ulf to move it
  in the serial driver then Geert propose to have it more generic in
  uart_suspend_port()


 drivers/tty/serial/serial_core.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/tty/serial/serial_core.c b/drivers/tty/serial/serial_core.c
index d8d797a7a1e3..6270baab668c 100644
--- a/drivers/tty/serial/serial_core.c
+++ b/drivers/tty/serial/serial_core.c
@@ -2409,6 +2409,7 @@ int uart_suspend_port(struct uart_driver *drv, struct uart_port *uport)
 			uport->ops->stop_rx(uport);
 			uart_port_unlock_irq(uport);
 		}
+		device_set_awake_path(uport->dev);
 		goto unlock;
 	}
 
-- 
2.39.2


