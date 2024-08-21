Return-Path: <linux-pm+bounces-12688-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id E2BDA95A7DC
	for <lists+linux-pm@lfdr.de>; Thu, 22 Aug 2024 00:37:40 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 7EF4F1F219DD
	for <lists+linux-pm@lfdr.de>; Wed, 21 Aug 2024 22:37:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 94C3617C200;
	Wed, 21 Aug 2024 22:37:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmx.net header.i=wahrenst@gmx.net header.b="JHkqdqGR"
X-Original-To: linux-pm@vger.kernel.org
Received: from mout.gmx.net (mout.gmx.net [212.227.17.21])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 47DBD14B96A;
	Wed, 21 Aug 2024 22:37:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=212.227.17.21
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724279855; cv=none; b=O6JqmfxRA5mMNY+WwGj7bIV/G8mn68FT7XmkvfPvYe2rtN5eAx2GfLxn9PExn3dJgr7P1spIygUNHg1v08k9xHWL3P+ikMiVRPm7yXKFvfbiqJmtzEC1basu71lW7r4FtuPsr2dFxof9MdPgxDWjLzER2gSU7MxiIlzom+P55RU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724279855; c=relaxed/simple;
	bh=EIb/0BVQLAIWTGsSf2exEUrI6S97uVc10LsFQOB7HdM=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=JMaS5bfg/NIEDUFBnhIV4NOEevGK4KXo06sMBOUXzUXbrkGBFTdFmcOVDPMEkqWBsv/tCqenPVPmLu6r1RfiNl8UySB/YTdh+2txFv/KY1so2fPXPna9KFAhd2LVo1lmzfg8PGD7gx8wUXohxAgFZKB1nlu5sxAsbVVVkm0vrZM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gmx.net; spf=pass smtp.mailfrom=gmx.net; dkim=pass (2048-bit key) header.d=gmx.net header.i=wahrenst@gmx.net header.b=JHkqdqGR; arc=none smtp.client-ip=212.227.17.21
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gmx.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmx.net
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmx.net;
	s=s31663417; t=1724279797; x=1724884597; i=wahrenst@gmx.net;
	bh=EIb/0BVQLAIWTGsSf2exEUrI6S97uVc10LsFQOB7HdM=;
	h=X-UI-Sender-Class:From:To:Cc:Subject:Date:Message-Id:In-Reply-To:
	 References:MIME-Version:Content-Transfer-Encoding:cc:
	 content-transfer-encoding:content-type:date:from:message-id:
	 mime-version:reply-to:subject:to;
	b=JHkqdqGRqxXptrhoBHbrJVGrueYDkdRTkXvvvI/0tqRxGBuzKR5I2iP3ur6Z7vR8
	 iFCmwl7Df0pmL3/wU0joN7sbefZk02nRgok7bLuWlCg7Q8sXnty3eVMWIrJqVuY11
	 u2qc9c8Ssl+V/fLMgrk4Q1FtcnkyHJQz4eDETWwom4GGAWXXbN02IUtQ6f85XMnwh
	 x3v1JJi+dgi/mtVTcdCFiK6fo7d7ajKzUE3EK7m+3UOCc8ncwdtEvKfxSTgD6+ZG1
	 B3BiMQq94ZTH4XmZNEv1+8PW8xHfipr5Nh+0jkqABL3Rh3AVbN9lDQwzAn8h5yWXa
	 7Nlhen3VGExLj3wbCQ==
X-UI-Sender-Class: 724b4f7f-cbec-4199-ad4e-598c01a50d3a
Received: from stefanw-SCHENKER ([37.4.248.43]) by mail.gmx.net (mrgmx105
 [212.227.17.168]) with ESMTPSA (Nemesis) id 1Mt757-1rsdbg2LZB-00wVwf; Thu, 22
 Aug 2024 00:36:37 +0200
From: Stefan Wahren <wahrenst@gmx.net>
To: Russell King <linux@armlinux.org.uk>,
	Doug Anderson <dianders@chromium.org>,
	Florian Fainelli <florian.fainelli@broadcom.com>,
	Ray Jui <rjui@broadcom.com>,
	Scott Branden <sbranden@broadcom.com>,
	Maxime Ripard <mripard@kernel.org>,
	Jassi Brar <jassisinghbrar@gmail.com>,
	=?UTF-8?q?Ma=C3=ADra=20Canal?= <mcanal@igalia.com>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
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
	linux-usb@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org,
	kernel-list@raspberrypi.com,
	Stefan Wahren <wahrenst@gmx.net>
Subject: [PATCH V3 9/9] ARM: bcm2835_defconfig: Enable SUSPEND
Date: Thu, 22 Aug 2024 00:36:29 +0200
Message-Id: <20240821223629.10705-1-wahrenst@gmx.net>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240821214052.6800-1-wahrenst@gmx.net>
References: <20240821214052.6800-1-wahrenst@gmx.net>
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:gQN251ySqY5cRStUBE3mudZO0tnWy/NNvjYZYSjAaFKeYHdSO59
 8ddPx7Fzew9NTHP7BngfDEPdSCG+ic1IXU/viHfItdUeFF8+9srqpPxS9xyuy0hs6swPDXp
 Rc0xAbsIhmnPfOHmG3fPjXsDewlYgPtaFSXG1d2kz+eCavIGrLdTIo4nYR9PgajRBisxZ4g
 KHkvqUDcVG2Ku4gckOwWg==
X-Spam-Flag: NO
UI-OutboundReport: notjunk:1;M01:P0:hlhASlEjUh4=;dOqaNRRLVUaN8ZDiJ6dGymnW7X2
 3cw4kKjsrj2JcyUVRiBrPgEcltGWM2C9MG6vYdUgWFZWAjZrdPvovgjnwKDZB6dVmM/IYIysU
 4OJGj6Oo0GSk6iIj8vFqBNShLe/b2FBCtW6vLks6hHW9KtlD7HTuaZJXQDva8opyukUNm9HwF
 lboiCVSKGlPViAIvD45p4z6jvtn42gcRQTfCL/5YUk1x6tl2OWIy/dm/aUT+AwBMjpD6fOmPw
 sngKt0SDvNQewOFrN0WsoB4ZBoGUfzFfPwgL7eqoU4FrmV+czd17SIoJpEVf6QHCquBLS9pUD
 2hdE3iApQOxWlj5WNFFVjK36fnrk6AsOXDQuTBFDgFw3/r02GVWUaWBkdmTgKYs92bm2ThqJs
 l8a0hzqlrvl9+9OTWx+S4qsQoBgYpznZ7vo9UW8zZeYcdyyMSiqAZ4E5Y/fuwTp04p0lQjOqi
 Qb721hWY8pQECRFrF/jmH8HxOC5rE1FH3vGO4l8Lx0v9RbuP0GXr5Jmynw3ne3G3P5NTgzv1m
 X7ZfqC/1p49/x4F6AWwJTOh/Cz3GbLzJGc6TDssV0ZHa2lzx1tJDB7XG5UfmUOAs7LvCdDugx
 XW4jZ/w4fm5ItWtc2ojhTTenJJil27LsehaKlyUYEVwzRZHiNgnNQ/iFcMc6p8/PJGrekbRTY
 B5YY0WyKTa7Wwv5c6v3r1HjYtWyTD7nnxBgBNwOYcguJFpyExsjqQCEICMcihKUIISzsk2SjN
 muJHpFZDy2tEJKZYgxicFHYOwDzNpJmrAZmbx53KkKtR8B1VHvMv8BWxFG2l+c5vSgSgcM2Rd
 uZCWzUOhOHw/Ob+gCv81XUpA==

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


