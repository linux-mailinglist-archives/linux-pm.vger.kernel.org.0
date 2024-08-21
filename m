Return-Path: <linux-pm+bounces-12662-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 1F24795A6DF
	for <lists+linux-pm@lfdr.de>; Wed, 21 Aug 2024 23:41:49 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 7F1E5B21A86
	for <lists+linux-pm@lfdr.de>; Wed, 21 Aug 2024 21:41:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7A67817A924;
	Wed, 21 Aug 2024 21:41:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmx.net header.i=wahrenst@gmx.net header.b="B0Vj6K11"
X-Original-To: linux-pm@vger.kernel.org
Received: from mout.gmx.net (mout.gmx.net [212.227.15.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8FCD417107F;
	Wed, 21 Aug 2024 21:41:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=212.227.15.19
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724276498; cv=none; b=sA9oaMkTrDXywqlh89CUZMK32McJKb5Kbo4ot6RAYgxY7gWY2Wld6A5BHIFdSEQ2+ETkwolLGPL5iRVj6rgVKVOserojDvM/Z5cKRlcDK+IKYacv2TL6jT6IDll57mKUj0Dmgbr7EgCMqMlwveu9uVQSIZA0fTILQ60pCx9iDEk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724276498; c=relaxed/simple;
	bh=B630JWCN4wj2RFpLdMsLhFZMzSq0chD9iXm8ONpS9Us=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=u57P54pmygkYDJ38KH7ELQRArwpv7JdjwY6TvUlenbv6XpDymZiT+J60V9KBwhaTa0XGqGGNQ2YZ2Cj3Vfof13yfaMDHwf0FPMSoLawuZvagFAVnDRNc0H9LjLpPas2B5TenpN7FKKabaI2FVWzV0OnHGDcicwuzCzHmy6em+H4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gmx.net; spf=pass smtp.mailfrom=gmx.net; dkim=pass (2048-bit key) header.d=gmx.net header.i=wahrenst@gmx.net header.b=B0Vj6K11; arc=none smtp.client-ip=212.227.15.19
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gmx.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmx.net
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmx.net;
	s=s31663417; t=1724276468; x=1724881268; i=wahrenst@gmx.net;
	bh=E5d+ydriTFmIboTE1234GNA41jHZScpZkZpdLaslxGc=;
	h=X-UI-Sender-Class:From:To:Cc:Subject:Date:Message-Id:In-Reply-To:
	 References:MIME-Version:Content-Transfer-Encoding:cc:
	 content-transfer-encoding:content-type:date:from:message-id:
	 mime-version:reply-to:subject:to;
	b=B0Vj6K11yfhCne6cMwHAQjUf2hLopZGDL+8VEGWEn3mmkL8ft1H6uFnmEGhuzKik
	 45tOVqW0XZPIIH8tVXX5S5E3viBdwaTFXLNo+4ovRosUXObBUKew9V8G/uqjZfvqf
	 3xSbJcAxtrZeJWoHC4VhOXKlFLt8yfZYfXkNEVdox7600sTcV/Ej0v1vfKOHNjuy8
	 xYkx1H4MDSapgjyU4Z9jR3pevYP9c2vRh7xFuFQPeH4e7fMoAfaijTsXVivku4ype
	 XGcg9kitVgLCjoENdOyBymjFqh1x7cgUyDEBUm43n1/kX9g3Gn3hV7B226kKY7byw
	 HO2VyB710D490MTd8Q==
X-UI-Sender-Class: 724b4f7f-cbec-4199-ad4e-598c01a50d3a
Received: from stefanw-SCHENKER ([37.4.248.43]) by mail.gmx.net (mrgmx004
 [212.227.17.190]) with ESMTPSA (Nemesis) id 1McpJg-1s7H4o0qmI-00bIZY; Wed, 21
 Aug 2024 23:41:08 +0200
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
Subject: [PATCH V3 4/9] drm/vc4: hdmi: add PM suspend/resume support
Date: Wed, 21 Aug 2024 23:40:47 +0200
Message-Id: <20240821214052.6800-5-wahrenst@gmx.net>
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
X-Provags-ID: V03:K1:54aw2OGuAPBp9ClzrfrERn/WHVRUW+y6EidTMSmxvpGyCNUA3EA
 awuZXqRoGC/yiuv4MMmPW32zs8EWBzL/SLLnKesbTwyP1vvsGnWSC1eGmkDfWzku0Jkjsj0
 iommWdZXPagNDd4DvuLaCWV4VKAl1px6m7FQfhqh32x8vGWeUVkxPbQoDzq+dXRjAry23XU
 GTnzMwn5txDh/jDPWq3wg==
X-Spam-Flag: NO
UI-OutboundReport: notjunk:1;M01:P0:0S+yclBWU4g=;DuKZVZsj9wGu0+m5Lkldz4nsRr3
 DAP5UEYm6d93CCYu70QJjLTshbnkE6FTuiq8fxIM5Tn4DJp+B2EkZExaeFkp0cLQiq/i3kZb1
 AhTnfQhhEVz3Etzu9gBWcFdeqRvH/n5sT/2Sx4t8rgrilqeiytBpy+M3WwiKZ07XX15VkTCwL
 hMw3UQi2hOO9R9pp8hV+58Yq49gfppmuK7sI/kNT+5/Mw8P5Bgvf+oEXiFYFYPH4XPutdirsa
 gog/0hfAn9/fN3R5hXcRl+FDH2d5of/Fh4bZdYD99Rn9sFAFNzK6J14cfOuukxCCFOwFsPbf4
 Qy1zazLfCDqO7sumBnM1dAKhKPcn+bZIcbn0tCjqXgPvqr6AQDeTvf+SX/ahTwszoKjeayqdN
 aOEgMZNqZzJBnNMTbhlEIJn6aR6ZfsV+5Hz0hmcmZvZsnbHNsL8T9rfFyd03jzGZhhOe/qVmT
 I8kkjLVQfnxqsqH+dptmtCx3JEdTJfYKt5VSAAA3212hhUYwOc5ZxeIf3N0yA5oIvrVuDvGv7
 zwGUPp9rfSnFn2e399jC+vtSPDJ70PizRkrF6LYRX1NuS1XjuMW0FjzaS+1CIwCoaOAhfMeCG
 FHt1PRrabJWSSsx0mZtZ23cfBnA1hbIm74OngWg9Gd16KhxfIjz8jRGLdiY841bR/tRnrtJe3
 fTJIUk4o48HIm5l2GP6ImSvIX1xdTTIMQxIBMXLOUwjlXgcGUBn93HEakkN3A+OTYuuZvgvxI
 2+Vi4IiuXeMCuIsn0cZRslAHHVhkT+RsCyppPuEzoAPfVUlmgJU0ouiU3LFsbEUDKqtxc5mmB
 VfGeQlt09aipOZA53ds3R2vg==

Add suspend/resume support for the VC4 HDMI component in order
to handle suspend to idle properly. Since the HDMI power domain
is powered down during suspend, this makes connector status polling
pointless.

Link: https://lore.kernel.org/dri-devel/7003512d-7303-4f41-b0d6-a8af5bf8e4=
97@gmx.net/
Signed-off-by: Stefan Wahren <wahrenst@gmx.net>
Acked-by: Maxime Ripard <mripard@kernel.org>
=2D--
 drivers/gpu/drm/vc4/vc4_hdmi.c | 26 ++++++++++++++++++++++++++
 1 file changed, 26 insertions(+)

diff --git a/drivers/gpu/drm/vc4/vc4_hdmi.c b/drivers/gpu/drm/vc4/vc4_hdmi=
.c
index 6611ab7c26a6..f7a4ed16094e 100644
=2D-- a/drivers/gpu/drm/vc4/vc4_hdmi.c
+++ b/drivers/gpu/drm/vc4/vc4_hdmi.c
@@ -3104,6 +3104,31 @@ static int vc5_hdmi_init_resources(struct drm_devic=
e *drm,
 	return 0;
 }

+static int vc4_hdmi_suspend(struct device *dev)
+{
+	struct vc4_hdmi *vc4_hdmi =3D dev_get_drvdata(dev);
+	struct drm_device *drm =3D vc4_hdmi->connector.dev;
+
+	if (drm && drm->mode_config.poll_enabled)
+		drm_kms_helper_poll_disable(drm);
+
+	return pm_runtime_force_suspend(dev);
+}
+
+static int vc4_hdmi_resume(struct device *dev)
+{
+	struct vc4_hdmi *vc4_hdmi =3D dev_get_drvdata(dev);
+	struct drm_device *drm =3D vc4_hdmi->connector.dev;
+	int ret;
+
+	ret =3D pm_runtime_force_resume(dev);
+
+	if (drm && drm->mode_config.poll_enabled)
+		drm_kms_helper_poll_enable(drm);
+
+	return ret;
+}
+
 static int vc4_hdmi_runtime_suspend(struct device *dev)
 {
 	struct vc4_hdmi *vc4_hdmi =3D dev_get_drvdata(dev);
@@ -3405,6 +3430,7 @@ static const struct dev_pm_ops vc4_hdmi_pm_ops =3D {
 	SET_RUNTIME_PM_OPS(vc4_hdmi_runtime_suspend,
 			   vc4_hdmi_runtime_resume,
 			   NULL)
+	SET_SYSTEM_SLEEP_PM_OPS(vc4_hdmi_suspend, vc4_hdmi_resume)
 };

 struct platform_driver vc4_hdmi_driver =3D {
=2D-
2.34.1


