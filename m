Return-Path: <linux-pm+bounces-7333-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 1053A8B6EF4
	for <lists+linux-pm@lfdr.de>; Tue, 30 Apr 2024 12:00:14 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 59E47B22CC7
	for <lists+linux-pm@lfdr.de>; Tue, 30 Apr 2024 10:00:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3E3D1129A7B;
	Tue, 30 Apr 2024 09:59:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=tuxon.dev header.i=@tuxon.dev header.b="H0/CIus4"
X-Original-To: linux-pm@vger.kernel.org
Received: from mail-lj1-f180.google.com (mail-lj1-f180.google.com [209.85.208.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ABB40127B70
	for <linux-pm@vger.kernel.org>; Tue, 30 Apr 2024 09:59:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714471190; cv=none; b=ECKL3cFEVHqIpjtDL5XpuEyUvtESfzReU9q7oQKEStjl/9dQa/ZCnqbNkSMZXqh+oq7x2zxauZ2OzDndOUz0c9B+eIxlgyTFy8SWs427KmN9bIyKsvX9dbrU0Pd6ZuQel+gwa9ZpE6c/U5gUJ5CibPKcscqIkQAvUUlEUytGGEY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714471190; c=relaxed/simple;
	bh=ejhjMJ/H/la8vRxMpwy+QTS9RzsFqN/Ot+U9tVzFz+U=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=Yn8HdQzvu8K9HDcyun2s4/UCNQErdsGIyZ8zp4Eotcl6A955AP8sK3J8Zs9mKzdksQ/DXfM3RhcVYIgzxM8aU9Eme7HfcqpkTEIrS8Kp+5d4A1du0PKgYVEmaZNRnth5WcxAOjA89wCRl6GoFPnyWbWq43dN4gzuWI2Jx5TJ374=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=tuxon.dev; spf=pass smtp.mailfrom=tuxon.dev; dkim=pass (2048-bit key) header.d=tuxon.dev header.i=@tuxon.dev header.b=H0/CIus4; arc=none smtp.client-ip=209.85.208.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=tuxon.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=tuxon.dev
Received: by mail-lj1-f180.google.com with SMTP id 38308e7fff4ca-2dd6c14d000so67410001fa.0
        for <linux-pm@vger.kernel.org>; Tue, 30 Apr 2024 02:59:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=tuxon.dev; s=google; t=1714471186; x=1715075986; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=M/lqUZe7iWGhXp3SSU9OPzFuI5U4ZOXzFyEcRUft5AI=;
        b=H0/CIus4SB+nYZdYRqEpteBz3e6PY5AcLfqX+LjHTNC4llyzU4gLtEloZy8sdUy/of
         HdAKI/6BQqaZm8TQVJPmi5QXtHIkBQs3c6D8CdU3+X7bE2kqCO3VkG+suMiXB9EmXUV3
         McBvpPJWiTcmPMtQIsf5vlhDH+Xi1+SHgD4JmsWkXTSPmvkH8F3D0UOL6kENv49ueWoh
         jnwZV66GwsZ/XLMG4A5tGAOVPPugMq4XI+wpkSEYhb3yiAIfiRR17KdhnANFgtzRDxAX
         omS39iZHQdIFDER/n54RuyplOmu9usq5Fc0yaDCvxTk/yjjrkdlAJ4OQ2e16dh8FBjdT
         2Lfg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1714471186; x=1715075986;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=M/lqUZe7iWGhXp3SSU9OPzFuI5U4ZOXzFyEcRUft5AI=;
        b=myDXCJ2mCmxUWYFsGAG3Q9oyj6RxSn7jTbOmxJY7gltfmxzY0gqAMNoY8a4A+K5ITO
         yOqaTpH9HDk5x6OMJAhHCPpJn+H9oJ+3MTHMPi6IfQLYHDrVw+2JEAF7d2xx2RSAVH4q
         XZGRyETWeOe2UDsgrR33se1m3Dep4AbDcWr5Kgxj+m6W/GUYPv9fDoxIP+tA5vDbuF+X
         NxcDhypocCMhtZ7ZbK1kmZUOHcLvji7VOncBHo6wLGD4wTBXwKx35HIc4ZFvwL0Vjuyh
         7Wvtiul450ES7PCPnecYy2n3+ELW7wJfu2wytyrHMK0kMZ0eCyFwFvYJw3wbSgk4OrJR
         0IXg==
X-Forwarded-Encrypted: i=1; AJvYcCXUlnuCxaadavvPFDOXMsIMj3ReCYKO0x6fCIgJzPN4DnRYh8UoW7TGLxqTXXaGvZoujtHumZKoYgPO3xXicTyXrOBBV4FyIRA=
X-Gm-Message-State: AOJu0Yyec9eDSn7dJz0zuirnZt1adUDhzmlOUIzQSC9QvR3aI9ITCZhh
	k8Qjb/dStXuGIDoQZJHyQafIg8FaJvxGjwNJsk2DQmpNeCzaqHfe+lpkZap2Yds=
X-Google-Smtp-Source: AGHT+IGHzZ1dA5BCORxcKkmsZov6zngxAi94VjevhE7m4ZD65kYUwu+nIIqc4hxd5b22oTtA0hrTZg==
X-Received: by 2002:a05:651c:4ca:b0:2d9:f7f8:3e87 with SMTP id e10-20020a05651c04ca00b002d9f7f83e87mr11114534lji.32.1714471183887;
        Tue, 30 Apr 2024 02:59:43 -0700 (PDT)
Received: from claudiu-X670E-Pro-RS.. ([82.78.167.53])
        by smtp.gmail.com with ESMTPSA id l37-20020a05600c1d2500b004186f979543sm48725235wms.33.2024.04.30.02.59.42
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 30 Apr 2024 02:59:43 -0700 (PDT)
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
	Geert Uytterhoeven <geert@linux-m68k.org>,
	Tony Lindgren <tony.lindgren@linux.intel.com>
Subject: [PATCH v3] serial: core: Call device_set_awake_path() for console port
Date: Tue, 30 Apr 2024 12:59:30 +0300
Message-Id: <20240430095930.2806067-1-claudiu.beznea.uj@bp.renesas.com>
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

Based on code investigation (on v6.9-rc5), this issue is present on other
SoCs (e.g., Renesas R-Mobile A1 [1], IMX8QXP [2]) and different SoCs have
particular implementation to handle it. Due to this the patch added the
call of device_set_awake_path() in uart_suspend_port() instead of having
it in the platform specific UART driver.

[1] drivers/pmdomain/renesas/rmobile-sysc.c:116
[2] drivers/pmdomain/imx/scu-pd.c:357

Suggested-by: Ulf Hansson <ulf.hansson@linaro.org>
Suggested-by: Geert Uytterhoeven <geert@linux-m68k.org>
Reviewed-by: Ulf Hansson <ulf.hansson@linaro.org>
Reviewed-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Reviewed-by: Tony Lindgren <tony.lindgren@linux.intel.com>
Reviewed-by: Geert Uytterhoeven <geert+renesas@glider.be>
Tested-by: Geert Uytterhoeven <geert+renesas@glider.be>
Signed-off-by: Claudiu Beznea <claudiu.beznea.uj@bp.renesas.com>
---

Changes in v3:
- remove https links from commit description
- collected tags
- removed RFT tag

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
index 8a76f378c445..84ae70d52b05 100644
--- a/drivers/tty/serial/serial_core.c
+++ b/drivers/tty/serial/serial_core.c
@@ -2408,6 +2408,7 @@ int uart_suspend_port(struct uart_driver *drv, struct uart_port *uport)
 			uport->ops->stop_rx(uport);
 			uart_port_unlock_irq(uport);
 		}
+		device_set_awake_path(uport->dev);
 		goto unlock;
 	}
 
-- 
2.39.2


