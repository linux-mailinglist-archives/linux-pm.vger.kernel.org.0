Return-Path: <linux-pm+bounces-11510-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 20FF493E557
	for <lists+linux-pm@lfdr.de>; Sun, 28 Jul 2024 15:08:44 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 9C423B21D04
	for <lists+linux-pm@lfdr.de>; Sun, 28 Jul 2024 13:08:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 877444AEE0;
	Sun, 28 Jul 2024 13:08:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmx.net header.i=wahrenst@gmx.net header.b="W79Hmsjz"
X-Original-To: linux-pm@vger.kernel.org
Received: from mout.gmx.net (mout.gmx.net [212.227.17.22])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 877A7482D8;
	Sun, 28 Jul 2024 13:08:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=212.227.17.22
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722172117; cv=none; b=DaeI3v+8Y+YWdrExRBZHVhf/XKnTAIsLlD789Xg3QZsvzAAJfk4Yvzp9UI/iyFsETBjAOc+T6+JjjN56sJsx3T0kRhfFpvzC2Qi2K4oK8QethksPDf9JH6Txqx7J0FGpCjmvXAeHRdh5KdZFcuaW15qQlkIxIrsEzoHr5SNWrTw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722172117; c=relaxed/simple;
	bh=EIb/0BVQLAIWTGsSf2exEUrI6S97uVc10LsFQOB7HdM=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=jSyH0kelxLltXBqHvyDAZUEHRPMFPEUM0r9XR4IYy1+2VK7zPUsBmrCYARWjObeEiDs3s/YaWZXXpPD4mmJk5xA1ryFOkJKa6w0Dxyd1vFxi9CB0WNoywKIE+dkijKyDCFqKzdGiiGk1ZShTrvbZhCYT5+fCiaFZTlSeTpI2ZWw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gmx.net; spf=pass smtp.mailfrom=gmx.net; dkim=pass (2048-bit key) header.d=gmx.net header.i=wahrenst@gmx.net header.b=W79Hmsjz; arc=none smtp.client-ip=212.227.17.22
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gmx.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmx.net
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmx.net;
	s=s31663417; t=1722172087; x=1722776887; i=wahrenst@gmx.net;
	bh=EIb/0BVQLAIWTGsSf2exEUrI6S97uVc10LsFQOB7HdM=;
	h=X-UI-Sender-Class:From:To:Cc:Subject:Date:Message-Id:In-Reply-To:
	 References:MIME-Version:Content-Transfer-Encoding:cc:
	 content-transfer-encoding:content-type:date:from:message-id:
	 mime-version:reply-to:subject:to;
	b=W79Hmsjz7U7XYrhfikB5fA/d87YEALxts+rMUgHZC7K6YKogcwefVd73Px1ngb20
	 365JEvCVRYXMhtiEbvA1DyAXJVDqJ1SuUk2mfYuogPsp1OG15PMNTzqM4NP54R0Y4
	 rco/BWhEqtLn21wNUdabqv28AeJfmp1xOChXBhFSbNnmF0yoagC2wqa7A6Bri2ikx
	 aKa0DI1+Ta02ohrOjk7IW6adAKbC28vJZyQp4VxyIIaQq1Rew4IlM1HqpAkCo34B0
	 gS5QEDtNmMJpjkNQB58BsLVzvPBdM0FkqQ996gAfmPFazRgmL3u8pZSMXclP9slo4
	 53BDO4YPwK/5UoFbPw==
X-UI-Sender-Class: 724b4f7f-cbec-4199-ad4e-598c01a50d3a
Received: from stefanw-SCHENKER ([37.4.248.43]) by mail.gmx.net (mrgmx104
 [212.227.17.168]) with ESMTPSA (Nemesis) id 1M89L1-1scCMG0Qdv-009Dte; Sun, 28
 Jul 2024 15:08:07 +0200
From: Stefan Wahren <wahrenst@gmx.net>
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Florian Fainelli <florian.fainelli@broadcom.com>,
	Ray Jui <rjui@broadcom.com>,
	Scott Branden <sbranden@broadcom.com>,
	Maxime Ripard <mripard@kernel.org>,
	Jassi Brar <jassisinghbrar@gmail.com>,
	Ulf Hansson <ulf.hansson@linaro.org>,
	=?UTF-8?q?Ma=C3=ADra=20Canal?= <mcanal@igalia.com>,
	Jiri Slaby <jirislaby@kernel.org>,
	Minas Harutyunyan <hminas@synopsys.com>
Cc: Dave Stevenson <dave.stevenson@raspberrypi.com>,
	Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
	Thomas Zimmermann <tzimmermann@suse.de>,
	David Airlie <airlied@gmail.com>,
	Daniel Vetter <daniel@ffwll.ch>,
	Lukas Wunner <lukas@wunner.de>,
	Artur Petrosyan <Arthur.Petrosyan@synopsys.com>,
	Peter Robinson <pbrobinson@gmail.com>,
	dri-devel@lists.freedesktop.org,
	bcm-kernel-feedback-list@broadcom.com,
	linux-pm@vger.kernel.org,
	linux-serial@vger.kernel.org,
	linux-usb@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org,
	kernel-list@raspberrypi.com,
	Stefan Wahren <wahrenst@gmx.net>
Subject: [PATCH V2 16/16] ARM: bcm2835_defconfig: Enable SUSPEND
Date: Sun, 28 Jul 2024 15:00:29 +0200
Message-Id: <20240728130029.78279-8-wahrenst@gmx.net>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240728130029.78279-1-wahrenst@gmx.net>
References: <20240728114200.75559-1-wahrenst@gmx.net>
 <20240728130029.78279-1-wahrenst@gmx.net>
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:VDKN64YJ6p518cmZoBkZcyEycWgxqBiXzFOn7tj34Md65oD5Z+v
 ZyIH2kWrCo7uD/4rinuinIoegUeMNFemd1ZI3kcdichjEYV+XGxQJ0Le6WmlVnI0Zb96mrp
 CrC/znc5FWPOwF+m8fk6KB/L52BwZlWnZJnB6nouviFVAbfZaCVgOgU439aNUNVMIuISRIf
 DTVt762wNfN8J8Lz42eNA==
X-Spam-Flag: NO
UI-OutboundReport: notjunk:1;M01:P0:dM3fOqR1834=;S1pLtaHrDhNPdNkUIa0I15yIguO
 Z4ExTh1CVbI2XAwJU0xnTJM+/EWJOqr0F1e6NMJwleA6TpewGejD2Qx0Jwf9Jo2g+5wjvPFNU
 Iyl6hMNb43S9FYKt651c+jNhfgCCEqf2UbXvdHos6/m2BArgd1/JGTEssBbObpItkRKxIy2BK
 c3VmdVQJ5ZMc7kvxVKmg0CtynjvYUwbBjVUqJ3hmellCsLI2cCJquD15HPE/JT0wMd/9x0Ixg
 RXoMEFKAQDguz5Sb6cprcJyOrjWmrPVM1iNrWc7uJtQOzWMoQWWsYCJoF+5YfbEUC1jIEcuum
 6H9tKXnjvOpLus+N+pf1BtxuIH+xk2wH/Y4zEb/pnjMKm25yKbeM0gzDHoAQYROdsorX48/46
 DjvLkEWVvMMqEyqr0O6S9OF5/lcVQX7AW4So/EesTHKdesVYYsYn3r7HbRlA8vzZqKtoBpJq6
 g6Z2KYshYwHlqxkbjgDxwz4JHO1CkwUSLMw0BS5ZBHcee23BtjJwVMyFg3Fyl3+zdk2g96vHv
 i5Wzjfe5rghfCDDRRt2IJ7aokGA22Upah8wtrtN90ypv8wm3vgaFbtc8RiTWUUgqfdhb5uH9V
 xyE8xI/b/0EQzz0690FoYI9rzhoyP+raQrW8zO2HbWbu5YLenJsejcfYcaF09DXx3RUWnhexJ
 GwWI75YsJuuZriwPepIFkvx7a14vWdLO5sNtc+/Tq4RL4ibM7hhTCZsbyqka6tdQbHhFA3KdY
 oOuSqF2J01n9R1mjSbzZnD4n5TfSS5gGUs1rIfsMaZzz2a5yf5pKZS4Y4vtIZ3g3xwiCvBWes
 jehdysnWw8gf/IZQgtRodJ4g==

Since the Raspberry Pi supports Suspend-To-Idle now, this option
should be enabled. This should make power management testing easier.

Signed-off-by: Stefan Wahren <wahrenst@gmx.net>
Reviewed-by: Florian Fainelli <florian.fainelli@broadcom.com>
=2D--
 arch/arm/configs/bcm2835_defconfig | 2 --
 1 file changed, 2 deletions(-)

diff --git a/arch/arm/configs/bcm2835_defconfig b/arch/arm/configs/bcm2835=
_defconfig
index b5f0bd8dd536..97632dee1ab3 100644
=2D-- a/arch/arm/configs/bcm2835_defconfig
+++ b/arch/arm/configs/bcm2835_defconfig
@@ -38,8 +38,6 @@ CONFIG_CPU_FREQ_GOV_ONDEMAND=3Dy
 CONFIG_CPUFREQ_DT=3Dy
 CONFIG_ARM_RASPBERRYPI_CPUFREQ=3Dy
 CONFIG_VFP=3Dy
-# CONFIG_SUSPEND is not set
-CONFIG_PM=3Dy
 CONFIG_JUMP_LABEL=3Dy
 CONFIG_MODULES=3Dy
 CONFIG_MODULE_UNLOAD=3Dy
=2D-
2.34.1


