Return-Path: <linux-pm+bounces-10258-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 9F69491D309
	for <lists+linux-pm@lfdr.de>; Sun, 30 Jun 2024 19:20:19 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 924E11C2083C
	for <lists+linux-pm@lfdr.de>; Sun, 30 Jun 2024 17:20:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5FCBA15534E;
	Sun, 30 Jun 2024 17:20:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmx.net header.i=wahrenst@gmx.net header.b="kHx9bke4"
X-Original-To: linux-pm@vger.kernel.org
Received: from mout.gmx.net (mout.gmx.net [212.227.17.22])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C9D0612D1F1;
	Sun, 30 Jun 2024 17:20:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=212.227.17.22
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719768015; cv=none; b=frHUEG1m9nQj98DEQA1iUS+LcD/h0O116uKv8kG7+7l+zVrCS72VBFkBBSAX93To7ed7Px+S7/wNi7rMoYDzOsjPAsnyoF6sR3S+EoPYwLZ2ARFygFIJXQZlqRZqWIEweIw3I/4mRtKNd3WtapyquxF+EyPzfuBCqpTQrE0GRVc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719768015; c=relaxed/simple;
	bh=TwgxqCRks5hKhBV/6phe1u8rgr3lRsdIwXbXbOF9qug=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=C3LLqhv/e8BrhLuGlkUCjijnkUrM8cs04FYH/3Pousy0L8FQVuzy28VHSQRTI8eFIMwid3sbfTJ7pMTQsba5XWIjp4gFHiPS1gyZhGMqn59F67PkWF8BG3HtwS3NOjn7bP6CSKzglo+UqMKuejlwhnyTbbGocmvN0UsWALDk21c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gmx.net; spf=pass smtp.mailfrom=gmx.net; dkim=pass (2048-bit key) header.d=gmx.net header.i=wahrenst@gmx.net header.b=kHx9bke4; arc=none smtp.client-ip=212.227.17.22
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gmx.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmx.net
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmx.net;
	s=s31663417; t=1719767983; x=1720372783; i=wahrenst@gmx.net;
	bh=TwgxqCRks5hKhBV/6phe1u8rgr3lRsdIwXbXbOF9qug=;
	h=X-UI-Sender-Class:From:To:Cc:Subject:Date:Message-Id:In-Reply-To:
	 References:MIME-Version:Content-Transfer-Encoding:cc:
	 content-transfer-encoding:content-type:date:from:message-id:
	 mime-version:reply-to:subject:to;
	b=kHx9bke4Kg+R+wEbUy+3WT/t5SdDiSohZME11eY+ImacFKQ+fhcBsZskQZMxriTV
	 LZw+i3WwoS14Ry2aOEe+1uS8JMHWz1kuQyTM6PEaTcxwKJyjMUAYz0oAvK+f3nLwh
	 +aTs+KzeCE5wAscsHzVEHcJ3vON4zwOqsaGj5/EhCdAv8P1pnX1neNKEpP1J9DLV5
	 6SRFhf4gsgFnhXNQN5Spdi/RtWGXxLpgUx8DSl23U5GLj6sCi9DNpH0BaSzSTjitY
	 49iCtRaJv/+9IJBGAFs2uHM95/xC85FwzShoO6XkPXYFBk654CpuZAlzgYNgXGW+i
	 XRL+EmT/yoAJ4YFiWw==
X-UI-Sender-Class: 724b4f7f-cbec-4199-ad4e-598c01a50d3a
Received: from stefanw-SCHENKER ([37.4.248.43]) by mail.gmx.net (mrgmx105
 [212.227.17.168]) with ESMTPSA (Nemesis) id 1MV67y-1sq7jd0H8o-00ORUC; Sun, 30
 Jun 2024 19:19:43 +0200
From: Stefan Wahren <wahrenst@gmx.net>
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Florian Fainelli <florian.fainelli@broadcom.com>,
	Ray Jui <rjui@broadcom.com>,
	Scott Branden <sbranden@broadcom.com>,
	Maxime Ripard <mripard@kernel.org>,
	Thomas Gleixner <tglx@linutronix.de>,
	Jassi Brar <jassisinghbrar@gmail.com>,
	Ulf Hansson <ulf.hansson@linaro.org>,
	Jiri Slaby <jirislaby@kernel.org>,
	Minas Harutyunyan <hminas@synopsys.com>
Cc: Dave Stevenson <dave.stevenson@raspberrypi.com>,
	Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
	Thomas Zimmermann <tzimmermann@suse.de>,
	David Airlie <airlied@gmail.com>,
	Daniel Vetter <daniel@ffwll.ch>,
	Lukas Wunner <lukas@wunner.de>,
	Peter Robinson <pbrobinson@gmail.com>,
	dri-devel@lists.freedesktop.org,
	bcm-kernel-feedback-list@broadcom.com,
	linux-pm@vger.kernel.org,
	linux-serial@vger.kernel.org,
	linux-usb@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org,
	kernel-list@raspberrypi.com,
	Stefan Wahren <wahrenst@gmx.net>
Subject: [PATCH 11/11] ARM: bcm2835_defconfig: Enable SUSPEND
Date: Sun, 30 Jun 2024 19:19:26 +0200
Message-Id: <20240630171926.323426-1-wahrenst@gmx.net>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240630153652.318882-1-wahrenst@gmx.net>
References: <20240630153652.318882-1-wahrenst@gmx.net>
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:Zqtyf/Sv3ew+qgoOSE4zRrcg9fRFBv468Pq4gY3jUBz8dUdUgD0
 n2jEfMCDPZevDTgfj7KHz/L97w9v3kXpV3immPkEmlIGA/Hbv8bUG6gWxsy1ltCBzIoPssE
 1hELuNvIbsUJatT3gtokpvJWs3DyyLo5R5hHZfS+nOZPBnKFYbRAyPVnT+Qh/Yrj9kpQHKX
 ItTNfpetMB5/vazmEMebA==
X-Spam-Flag: NO
UI-OutboundReport: notjunk:1;M01:P0:4JoxQbbPUq0=;EcqCyU0NoxnU+tpxe8XWkVyflO7
 hKcYXlwL6ZpFanEiGw4G5OZR6he0TPBkxMT9h4g6QgIzgZ1qfnZeEJMJxIDGZ5WZYmFm1KzRZ
 zmYee1yAouEtibxABNEodMAQLGvt8YNfasmdJDlBOZR64mtxUXWVwI7QFDoyMPmpXBpaDNSp4
 +qSQkuviA1giKrjF+ZbXFM+CztozF7XHTmoKF/ALl/w36IUaFLcnw0DwCZzCU1HpuHxscU17K
 9MOvvKYGxfGZHm5mPn2/6bGHdXB6R269+t4RytybWp3e7tWetTn/UJBmzE2+H1+VoS3KSaiyp
 qWjcqfUduH4voP0cledTq9DoYZPTqOhxdy9IV/QwftjpKfbfKe++p8wlh9IXdG6+E1fqSJYpg
 vu96P4ElFDdjqQ7WQVf0P91UYRVQlzvH9daRI6QSvXOVRaA+XDQLJ4S8HWDcOTrJCZh5ouWQC
 klNyzJSSFZYNHzNHi3WmWFcsx3QJfDv1c7b4PW3wXozttRYeNwkMzLcnbRPljRuy18lNZAnZd
 fTzZLrEy5idQPGmm5JNfzu2ICCFMc62mjc3KOLnclUBzRn9aPpXRcTzJ0Irhqdib/gh3sMjbB
 h6owDQonwhO1TJi2iJasJwPf02uR6UozY6sqnBDaGU7q3/XENuoGzQYIw67YzHI0+G87Nwm/V
 zj+rx3EUqxs0R11MNiJNgX72KpVIeZtm0U8YSZ3X/BSRKpVH6RiEoaGu2vBGqLlOhl/LOzY8m
 zBHt5N3j/utJu/EeXZmdNfARrIxVFRC9LI66S/U4jlb8TpOYjICNhtPrsLcJggDn87vdGXLCC
 4+MSE+zf6Y0GGG9NkyzvaCGI6+AJUqjzZUtseOeXz/Il4=

Since the Raspberry Pi supports Suspend-To-Idle now, this option
should be enabled. This should make power management testing easier.

Signed-off-by: Stefan Wahren <wahrenst@gmx.net>
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


