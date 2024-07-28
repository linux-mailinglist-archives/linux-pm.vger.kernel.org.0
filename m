Return-Path: <linux-pm+bounces-11504-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 40AAB93E538
	for <lists+linux-pm@lfdr.de>; Sun, 28 Jul 2024 15:02:26 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id C9222281A87
	for <lists+linux-pm@lfdr.de>; Sun, 28 Jul 2024 13:02:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 544473BBF0;
	Sun, 28 Jul 2024 13:02:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmx.net header.i=wahrenst@gmx.net header.b="LZnHzB/b"
X-Original-To: linux-pm@vger.kernel.org
Received: from mout.gmx.net (mout.gmx.net [212.227.17.21])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 094713BB24;
	Sun, 28 Jul 2024 13:02:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=212.227.17.21
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722171741; cv=none; b=h5c2kld30CGS2GIVGFkgTb5mBClOx/4zd7rv2+6ESc3HRIclVFqYXPGZtJ80m48mueQFuJk0HTb+I5938cyBqmAgsfIv6cMqEzg6OxDl5weOal19ymYKLCnHGvmjJPCyI6/J6LRK4ewgW2tfyTZlVNhYZl8qTkstELppojeLAKo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722171741; c=relaxed/simple;
	bh=87ySgbiiYe8HB9qINfpN7uKwCQeO6bWDjeLE0wDwUCo=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=JG8RQXXo4SUgz3rbgqhbtWiK+r8CBzRR+ZiZAjy8SyzjroHab54dgizwTvrz5RpbwB3hkBcaq6mq/FOHP9gHBP3FRWyXe/MUFYdHD/3lMFzUKdfYUWVZwxA1gDwl9elyjLgNLVj1/+iqFrsJifLLC31qCCqJBPFTmwyt+d0ZuFc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gmx.net; spf=pass smtp.mailfrom=gmx.net; dkim=pass (2048-bit key) header.d=gmx.net header.i=wahrenst@gmx.net header.b=LZnHzB/b; arc=none smtp.client-ip=212.227.17.21
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gmx.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmx.net
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmx.net;
	s=s31663417; t=1722171708; x=1722776508; i=wahrenst@gmx.net;
	bh=ar/kp7yD2mJLJuSys73kvAqBB9MnTy6xyWNEEdcVnRA=;
	h=X-UI-Sender-Class:From:To:Cc:Subject:Date:Message-Id:In-Reply-To:
	 References:MIME-Version:Content-Transfer-Encoding:cc:
	 content-transfer-encoding:content-type:date:from:message-id:
	 mime-version:reply-to:subject:to;
	b=LZnHzB/bDBiYalGk5UPDHQt9PHDy+KZ7w7DSeMZvHGDnHMyMrrCgpIMZ+iPDk0Gv
	 G5HNBmOYG+insjXO6+vTcUcyzck1nyUorJNj3Xg6BACbEgo2OP2L2hZhGwXWSkbTv
	 6TyW1Z3iczgkao0oeHZupuxy+R4DSmzZhi8RnK7wUYq3qmrVUyHuToBZyJcRiYQfp
	 yhvOlS7/PvZcrXGn1myzoK/B5ZdcQCqzoBL/vWeItOUahHCwK72HweqsO7tE2gWSk
	 2Tqq9Ul1sQbYsS6s8+ienD8T2DWX9EUG9HfvSlIOfTFtsppuQbp7xYSzpbEbwrYMB
	 ZSaxbUELZSj41wR8Pw==
X-UI-Sender-Class: 724b4f7f-cbec-4199-ad4e-598c01a50d3a
Received: from stefanw-SCHENKER ([37.4.248.43]) by mail.gmx.net (mrgmx104
 [212.227.17.168]) with ESMTPSA (Nemesis) id 1MzQgC-1sKwYe1EyO-010E9t; Sun, 28
 Jul 2024 15:01:48 +0200
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
Subject: [PATCH V2 10/16] drm/vc4: v3d: add PM suspend/resume support
Date: Sun, 28 Jul 2024 15:00:23 +0200
Message-Id: <20240728130029.78279-2-wahrenst@gmx.net>
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
X-Provags-ID: V03:K1:7IJwLoTzlwttqekflfpKp30OMNgCC3j4tWm9XhRYDocXhUqvFz4
 fVyOSsioY5Adrs1r12juiZMUFnUcFVKLW4xosI+l3QsE+KzidpSCATgSFsIfLWyrpuFH40F
 G5YzwSO6aXeiPPEcUqY0QcOibtdV8YZr8uHCLPId3UC5evWHHpkdKMbX4KMUqcBiEJ5f2lF
 Hf+ImoiVPnqpTtSkP08AA==
X-Spam-Flag: NO
UI-OutboundReport: notjunk:1;M01:P0:i/6mUy9V+lU=;7OqSqn0WBQcyR+A6WrRxHHWZ3z9
 BWxoMASO4FUYKHwltmw+jjL1K021d9WYt57p72CaSTjkLyxfGtsC+mK4UbURJW8yWClJQE7/9
 jBtrfTGKoDbJ7LHf0ENevzJho6XBJFZfeyiU0/4sXUO/9A9qrtcaAslt3tr+8Uke2SqeQjCZb
 jB8ShVJkcM1ulhL9djEQLSNFPSrVydSyMZzDXVyZfAtDSeL2hNb8swVTGBnieaKpB3H2oLQIG
 uul/tbpGtCZ1c4m3OFylGn/lx/5wzvqVhJi1o5MHZ1zhb3AmJiWbJhk9A0J452cFeTei+54bg
 AJBVbmfcaEgKub93NNBEZJb4zMybI1znfIPqhBnYn5zMymqQOlKLhiMzyW4QjiBG3yCqpgfPB
 ZmAhc2y5C7VW8LDLOGWupisWd+cKLWL8ii8sS0g+/0NgbUsCCYf8EmYvXMCnaNb7w+HzMPH46
 dTSaWAIr50aFq21HdkEoPoA+qHJTEyHQcWas9ETSqidOZMZRpIM5+nTqbc3lFxAdgXyAQDdxO
 JtKVrPdOl08XZGARoIr17+bVH1VbwNU/ZvkBdS0ENVBXGLGhKsBJ5hBcBdC889Aba2HWOxtUa
 Lc71shiuBVFKGbC917q9/G1c0ePYpLCNO1O1jj2hx9V7N4m3muh75n5cJwU6aBsEiMgTtnd1X
 x34BLjXC7+ib/ElpoKQ3wJ+mouMdbzvKT8S2FdvNhGl/9mftj8u4bY3lHkk7tek8tehVmOnpR
 BcSRbPPUSiAu/aVkMg6+G/DdNBDG+BYM4qBXUM6/ZYci5XTTis2dlsIqqRrf0OoM1BHiY1Nt9
 w7qnjdQMSCdsTydkIcl8P1Pw==

Add suspend/resume support for the VC4 V3D component in order
to handle suspend to idle properly.

Signed-off-by: Stefan Wahren <wahrenst@gmx.net>
=2D--
 drivers/gpu/drm/vc4/vc4_v3d.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/drivers/gpu/drm/vc4/vc4_v3d.c b/drivers/gpu/drm/vc4/vc4_v3d.c
index 4bf3a8d24770..309c8af08fd0 100644
=2D-- a/drivers/gpu/drm/vc4/vc4_v3d.c
+++ b/drivers/gpu/drm/vc4/vc4_v3d.c
@@ -511,6 +511,8 @@ static void vc4_v3d_unbind(struct device *dev, struct =
device *master,

 static const struct dev_pm_ops vc4_v3d_pm_ops =3D {
 	SET_RUNTIME_PM_OPS(vc4_v3d_runtime_suspend, vc4_v3d_runtime_resume, NULL=
)
+	SET_SYSTEM_SLEEP_PM_OPS(pm_runtime_force_suspend,
+				pm_runtime_force_resume)
 };

 static const struct component_ops vc4_v3d_ops =3D {
=2D-
2.34.1


